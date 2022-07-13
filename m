Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB134574025
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiGMXpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGMXpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 19:45:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E537F419BF
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:45:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26DICdej029939
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jEcv5LftNfrzApFiAGL9MVC+3Z/fAF61gGvH242t+dE=;
 b=I1DH/HIgCIXyopE4cHb16XBETovvEQjJ+cJ0ON7b4x1grFgopoYaB9Edw58z6ISFqNR9
 hn4hmjYkNq/VHLes4o3gb4iWokD0cCV67deJ6MqqmY41LGXiupKoH91tchtW/M5i5KN8
 tuXmO/ajZ3TIH/kMLwKd4W3OoDtqfeg9yi8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h9h5eys2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:45:41 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 16:45:40 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id E2E24A4170C3; Wed, 13 Jul 2022 16:45:30 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
Date:   Wed, 13 Jul 2022 16:45:29 -0700
Message-ID: <20220713234529.4154673-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CE0LHY3Ke-mR2HPPeOCxXxdmOrOjdnR9
X-Proofpoint-GUID: CE0LHY3Ke-mR2HPPeOCxXxdmOrOjdnR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_12,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The may_be_acquire_function check is a weaker version of
is_acquire_function that only uses bpf_func_id to determine whether a
func may be acquiring a reference. Most funcs which acquire a reference
do so regardless of their input, so bpf_func_id is all that's necessary
to make an accurate determination. However, map_lookup_elem only
acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added the
may_be check.

Any helper which always acquires a reference should pass both
may_be_acquire_function and is_acquire_function checks. Recently-added
kptr_xchg passes the latter but not the former. This patch resolves this
discrepancy and does some refactoring such that the list of functions
which always acquire is in one place so future updates are in sync.

Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---

Sent to bpf-next instead of bpf as kptr_xchg not passing
may_be_acquire_function isn't currently breaking anything, just
logically inconsistent.

 kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26e7e787c20a..df4b923e77de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
=20
+/* These functions acquire a resource that must be later released
+ * regardless of their input
+ */
+static bool __check_function_always_acquires(enum bpf_func_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_sk_lookup_tcp:
+	case BPF_FUNC_sk_lookup_udp:
+	case BPF_FUNC_skc_lookup_tcp:
+	case BPF_FUNC_ringbuf_reserve:
+	case BPF_FUNC_kptr_xchg:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool may_be_acquire_function(enum bpf_func_id func_id)
 {
-	return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
-		func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
-		func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
-		func_id =3D=3D BPF_FUNC_map_lookup_elem ||
-	        func_id =3D=3D BPF_FUNC_ringbuf_reserve;
+	/* See is_acquire_function for the conditions under which funcs
+	 * not in __check_function_always_acquires acquire a resource
+	 */
+	return __check_function_always_acquires(func_id) ||
+		func_id =3D=3D BPF_FUNC_map_lookup_elem;
 }
=20
 static bool is_acquire_function(enum bpf_func_id func_id,
@@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_id fun=
c_id,
 {
 	enum bpf_map_type map_type =3D map ? map->map_type : BPF_MAP_TYPE_UNSPE=
C;
=20
-	if (func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
-	    func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
-	    func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
-	    func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
-	    func_id =3D=3D BPF_FUNC_kptr_xchg)
+	if (__check_function_always_acquires(func_id))
 		return true;
=20
 	if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
--=20
2.30.2

