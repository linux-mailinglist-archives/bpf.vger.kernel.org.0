Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EFF5A3B1F
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiH1CzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1CzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:55:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871722B29
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S2PEle005620
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=McXEiJptNjPYOdgh7RLsNyGLsvK5M/BUrqqZzx6Ikeo=;
 b=qYuivN60wbFcqDWRFEm2TtU5yfXIriY2FRdDSPZtNJnjeTJgSFSDiQ7Evhce3S7CKayW
 2rU3vc/Pxr1/nmWAFTCT9qov90O0rA7SwkaZV8degbMA1GhQ7Gl9aP5B7twUxaAU2h+v
 vXn/r8pfOvbmTwYJ5pBdZMBFNYAI4vJ9oxM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7gsytu4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:02 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:55:01 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2A85EEA747FE; Sat, 27 Aug 2022 19:54:54 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 3/7] bpf: Update descriptions for helpers bpf_get_func_arg[_cnt]()
Date:   Sat, 27 Aug 2022 19:54:54 -0700
Message-ID: <20220828025454.144201-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ecLvg4hYszaD5HzV3WPcfBHyHeFBSrI
X-Proofpoint-GUID: 1ecLvg4hYszaD5HzV3WPcfBHyHeFBSrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now instead of the number of arguments, the number of registers
holding argument values are stored in trampoline. Update
the description of bpf_get_func_arg[_cnt]() helpers. Previous
programs without struct arguments should continue to work
as usual.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h       | 9 +++++----
 tools/include/uapi/linux/bpf.h | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 962960a98835..f9f43343ef93 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5079,12 +5079,12 @@ union bpf_attr {
  *
  * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
  *	Description
- *		Get **n**-th argument (zero based) of the traced function (for traci=
ng programs)
+ *		Get **n**-th argument register (zero based) of the traced function (=
for tracing programs)
  *		returned in **value**.
  *
  *	Return
  *		0 on success.
- *		**-EINVAL** if n >=3D arguments count of traced function.
+ *		**-EINVAL** if n >=3D argument register count of traced function.
  *
  * long bpf_get_func_ret(void *ctx, u64 *value)
  *	Description
@@ -5097,10 +5097,11 @@ union bpf_attr {
  *
  * long bpf_get_func_arg_cnt(void *ctx)
  *	Description
- *		Get number of arguments of the traced function (for tracing programs=
).
+ *		Get number of registers of the traced function (for tracing programs=
) where
+ *		function arguments are stored in these registers.
  *
  *	Return
- *		The number of arguments of the traced function.
+ *		The number of argument registers of the traced function.
  *
  * int bpf_get_retval(void)
  *	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index f4ba82a1eace..f13fa71822f4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5079,12 +5079,12 @@ union bpf_attr {
  *
  * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
  *	Description
- *		Get **n**-th argument (zero based) of the traced function (for traci=
ng programs)
+ *		Get **n**-th argument register (zero based) of the traced function (=
for tracing programs)
  *		returned in **value**.
  *
  *	Return
  *		0 on success.
- *		**-EINVAL** if n >=3D arguments count of traced function.
+ *		**-EINVAL** if n >=3D argument register count of traced function.
  *
  * long bpf_get_func_ret(void *ctx, u64 *value)
  *	Description
@@ -5097,10 +5097,11 @@ union bpf_attr {
  *
  * long bpf_get_func_arg_cnt(void *ctx)
  *	Description
- *		Get number of arguments of the traced function (for tracing programs=
).
+ *		Get number of registers of the traced function (for tracing programs=
) where
+ *		function arguments are stored in these registers.
  *
  *	Return
- *		The number of arguments of the traced function.
+ *		The number of argument registers of the traced function.
  *
  * int bpf_get_retval(void)
  *	Description
--=20
2.30.2

