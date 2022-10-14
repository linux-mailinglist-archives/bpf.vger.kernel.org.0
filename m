Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFF5FE840
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJNE4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJNE4d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:56:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858A2E9D2
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E4iPMm026214
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NUCMZhBtdEFob4Yy2+IoIDADd3grxFGmLtCe9yP2X0I=;
 b=WkVNLcNjUsxmnKE03nXMGaxUOyM5UF7MrarHYVRB/qfxNt1xHydfm/xUMus47LpY04CG
 fBetLlJa0b5l2d7eXxg7jVH0C5UN0cMVdX/4Cif0ggNkBM1HHHTPfJ4ChAimxu1fiGk1
 mpJPdBA1rScJKvl8pV3cZfrVgQr2/vpacm4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k710gr27a-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:32 -0700
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:56:28 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 04ECA10A7A53C; Thu, 13 Oct 2022 21:56:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 1/5] bpf: Make struct cgroup btf id global
Date:   Thu, 13 Oct 2022 21:56:24 -0700
Message-ID: <20221014045624.3311062-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221014045619.3309899-1-yhs@fb.com>
References: <20221014045619.3309899-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9_chA5fHozqowQ2C03ndtJHAKnALK1qr
X-Proofpoint-ORIG-GUID: 9_chA5fHozqowQ2C03ndtJHAKnALK1qr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make struct cgroup btf id global so later patch can reuse
the same btf id.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf_ids.h  | 1 +
 kernel/bpf/cgroup_iter.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 2aea877d644f..c9744efd202f 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -265,5 +265,6 @@ MAX_BTF_TRACING_TYPE,
 };
=20
 extern u32 btf_tracing_ids[];
+extern u32 bpf_cgroup_btf_id[];
=20
 #endif
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 0d200a993489..c6ffc706d583 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -157,7 +157,7 @@ static const struct seq_operations cgroup_iter_seq_op=
s =3D {
 	.show   =3D cgroup_iter_seq_show,
 };
=20
-BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
=20
 static int cgroup_iter_seq_init(void *priv, struct bpf_iter_aux_info *au=
x)
 {
--=20
2.30.2

