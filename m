Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1304DD407
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 05:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCRE6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 00:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiCRE6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 00:58:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A126D113
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:57:21 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22I0xJjq020272
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:57:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+Z4ptDeZoh7ulhNjp2+RoI7k6AN3UNexgvyGreqEV0U=;
 b=Lk4zP2FdyM69QBMlUfqaweSRVA+NKr8MmSlo81Lpzmcy99AyZEvaJC8DpNPJulyYrsoM
 7Hvuv8TKSyOxrGLZwZVsppYsjO6RMj36wG+e75l1+7QgosGi2EB4IGuaOBWRy8jGyTMV
 BRf79josGYai2rXDJ9emV1YqUplz8Nl5xnE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3evg10rues-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:57:21 -0700
Received: from twshared37304.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:57:19 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 94F8E9C8E690; Thu, 17 Mar 2022 21:57:10 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kafai@fb.com>, <kpsingh@kernel.org>, <memxor@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <tj@kernel.org>, <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test for associating multiple elements with the local storage
Date:   Thu, 17 Mar 2022 21:55:53 -0700
Message-ID: <20220318045553.3091807-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318045553.3091807-1-joannekoong@fb.com>
References: <20220318045553.3091807-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TyCN6b8D7cptKkRHL3pFD95A1hh_Gwfu
X-Proofpoint-ORIG-GUID: TyCN6b8D7cptKkRHL3pFD95A1hh_Gwfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_05,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This patch adds a few calls to the existing local storage selftest to
test that we can associate multiple elements with the local storage.

The sleepable program's call to bpf_sk_storage_get with sk_storage_map2
will lead to an allocation of a new selem under the GFP_KERNEL flag.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../selftests/bpf/progs/local_storage.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/te=
sting/selftests/bpf/progs/local_storage.c
index 9b1f9b75d5c2..19423ed862e3 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -36,6 +36,13 @@ struct {
 	__type(value, struct local_storage);
 } sk_storage_map SEC(".maps");
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
+	__type(key, int);
+	__type(value, struct local_storage);
+} sk_storage_map2 SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -115,7 +122,19 @@ int BPF_PROG(socket_bind, struct socket *sock, struc=
t sockaddr *address,
 	if (storage->value !=3D DUMMY_STORAGE_VALUE)
 		sk_storage_result =3D -1;
=20
+	/* This tests that we can associate multiple elements
+	 * with the local storage.
+	 */
+	storage =3D bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
 	err =3D bpf_sk_storage_delete(&sk_storage_map, sock->sk);
+	if (err)
+		return 0;
+
+	err =3D bpf_sk_storage_delete(&sk_storage_map2, sock->sk);
 	if (!err)
 		sk_storage_result =3D err;
=20
--=20
2.30.2

