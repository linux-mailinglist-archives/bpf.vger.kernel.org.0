Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49054590B75
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 07:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiHLFY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 01:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHLFY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 01:24:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC7A0270
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:28 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLDYWG025607
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4jyGrCLiL1oYn0xKtDJowkLGW00qeepqKGyLw9dyRyg=;
 b=TRp8tTELdz54uoCp/tsfyPwLnnJhWFf8r3hFLcWH8sMoKObisdEbC4Sp98lqHvGFqz43
 9k/jlQ50fsJWQjHHw/MG/+HB+Y8smROgGKSlboLxyV7g2vmdMUmRqHCiNXXJ3FHAsskA
 DwpPoiCZsEeLeM7Oq+CPOYrnRrFiOFxd874= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9gej6dv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:28 -0700
Received: from twshared0646.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 22:24:26 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 81462DF8C3E3; Thu, 11 Aug 2022 22:24:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 1/6] bpf: Add struct argument info in btf_func_model
Date:   Thu, 11 Aug 2022 22:24:24 -0700
Message-ID: <20220812052424.521379-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812052419.520522-1-yhs@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vtvh7teL4jpySf5GCT7B4-obU07YMysc
X-Proofpoint-GUID: Vtvh7teL4jpySf5GCT7B4-obU07YMysc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_03,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add arg_flags for additional information about arguments in btf_func_mode=
l.
Currently, only whether an argument is a structure or not is recorded.
Such information will be used in arch specific function
arch_prepare_bpf_trampoline() to prepare argument access properly
in trampoline.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a627a02cf8ab..2d3099fb5a0a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -726,10 +726,14 @@ enum bpf_cgroup_storage_type {
  */
 #define MAX_BPF_FUNC_REG_ARGS 5
=20
+/* The argument is a structure. */
+#define BTF_FMODEL_STRUCT_ARG		BIT(0)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
+	u8 arg_flags[MAX_BPF_FUNC_ARGS];
 };
=20
 /* Restore arguments before returning from trampoline to let original fu=
nction
--=20
2.30.2

