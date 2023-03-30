Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591036CFB06
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC3F4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC3F4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329A61A5
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U1ltuq025767
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5lYCwV2HeEcuWkgqKBFe0EDmhCydmPjC6EZMoUgNdOs=;
 b=OU3o7Ak3QyIA3vRcfnDZgbC1LBBM0d6VyhlUhz1bU4KA8Jki490oxlXUDwKSES1HC31X
 Ynay59nY3OcE+VYDCyr9KtqU5+UD9kfGVdcP5ejEn0lNq/+D+qdLwlbFImnLDGNuO+FT
 C2tS2NkhxB03TIT8oSumpoZc2dgJyD0hfbw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pn11ss3hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:38 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:37 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 0AC471BA2D987; Wed, 29 Mar 2023 22:56:31 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: [PATCH bpf-next 6/7] selftests/bpf: Remove previous workaround for test verif_scale_loop6
Date:   Wed, 29 Mar 2023 22:56:31 -0700
Message-ID: <20230330055631.92620-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z3dcgH3T8vCFUg9AnBclyQoR3eCqNbrN
X-Proofpoint-GUID: Z3dcgH3T8vCFUg9AnBclyQoR3eCqNbrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 3c2611bac08a("selftests/bpf: Fix trace_virtqueue_add_sgs test issu=
e with LLVM 17")
workarounds the verification failure by using asm code with '__sink' macr=
o to
prevent certain llvm optimization.

This patch added proper support in verifier so workaround is not
necessary any more. So remove these workarounds.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/loop6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/se=
lftests/bpf/progs/loop6.c
index e4ff97fbcce1..a13bee928b27 100644
--- a/tools/testing/selftests/bpf/progs/loop6.c
+++ b/tools/testing/selftests/bpf/progs/loop6.c
@@ -77,7 +77,6 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, s=
truct scatterlist **sgs,
 		return 0;
=20
 	for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
-		__sink(out_sgs);
 		for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp =3D __sg_next(sgp)) {
 			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
@@ -87,7 +86,6 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, s=
truct scatterlist **sgs,
 	}
=20
 	for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < in_sgs); i++) {
-		__sink(in_sgs);
 		for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp =3D __sg_next(sgp)) {
 			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
--=20
2.34.1

