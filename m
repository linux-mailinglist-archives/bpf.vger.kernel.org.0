Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44E581827
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiGZRLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGZRLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:11:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E013F20
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEJk3P001485
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BSwR6/Uk04srRygQ1XKEkf5MhLKULDEnCP2Tj6nIL1U=;
 b=WCTP/fAauolMDfZNQZkGUAsw6VWpyI6pVLe95Rq84PTGeRnZe/Bdf7LjzaX6yBIganSu
 x6FWZ/1yf684DuTj52tb/9WEBZ0x7eyk4E1wpzHApmutwJkLQaDy26f7lI712nu3O/c/
 Ro9dbnDfg3169o0qd8VjiAI7Cd2T3GmJFGs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hjhxasasu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:50 -0700
Received: from twshared7556.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:11:49 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 17D64D40E8EF; Tue, 26 Jul 2022 10:11:40 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 2/7] bpf: Add struct argument info in btf_func_model
Date:   Tue, 26 Jul 2022 10:11:40 -0700
Message-ID: <20220726171140.710070-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7L1N4RvLf4K_WYOk3617AvncazErLGXU
X-Proofpoint-GUID: 7L1N4RvLf4K_WYOk3617AvncazErLGXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add struct argument information in btf_func_model and such information
will be used in arch specific function arch_prepare_bpf_trampoline()
to prepare argument access properly in trampoline.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..173b42cf3940 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -726,10 +726,19 @@ enum bpf_cgroup_storage_type {
  */
 #define MAX_BPF_FUNC_REG_ARGS 5
=20
+/* The maximum number of struct arguments a single function may have. */
+#define MAX_BPF_FUNC_STRUCT_ARGS 2
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
+	/* The struct_arg_idx should be in increasing order like (0, 2, ...).
+	 * The struct_arg_bsize encodes the struct field byte size
+	 * for the corresponding struct argument index.
+	 */
+	u8 struct_arg_idx[MAX_BPF_FUNC_STRUCT_ARGS];
+	u8 struct_arg_bsize[MAX_BPF_FUNC_STRUCT_ARGS];
 };
=20
 /* Restore arguments before returning from trampoline to let original fu=
nction
--=20
2.30.2

