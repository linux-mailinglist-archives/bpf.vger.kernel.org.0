Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7463651C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiKWP7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiKWP63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 10:58:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400062381
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 07:58:08 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANB6PZG030008
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 07:58:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=rKxnnlsQQsSac0UsX1uKjuvJ2RjhSPAaDfvKr5XrpRs=;
 b=oi2pqGA5cUghCXHSdedxQUCmsNYFUHcwbOyNcsHU1srb9iHG2ToPDwW7r1O8JJZ3hdUc
 +wL0zpKpfC1x86wm3tyS4jr5bN14CRH1B9F15r4XSjz8HYLxiZIg6+wXUVqf57jD/T+z
 t+x/8qRTsN5Up/h5Ft9fhpCaT3v1AoAaJZY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0y4usmaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 07:58:07 -0800
Received: from twshared0705.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 07:58:06 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CFA15129C5151; Wed, 23 Nov 2022 07:57:59 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH bpf-next] bpf: Fix a BTF_ID_LIST bug with CONFIG_DEBUG_INFO_BTF not set
Date:   Wed, 23 Nov 2022 07:57:59 -0800
Message-ID: <20221123155759.2669749-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4RhUx7IAjrK_8n1joq-sSY1-mJpUMcAy
X-Proofpoint-ORIG-GUID: 4RhUx7IAjrK_8n1joq-sSY1-mJpUMcAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_DEBUG_INFO_BTF not set, we hit the following compilation erro=
r,
  /.../kernel/bpf/verifier.c:8196:23: error: array index 6 is past the en=
d of the array
  (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bound=
s]
        if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_c=
tx])
                             ^                  ~~~~~~~~~~~~~~~~~~~~~~~
  /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' dec=
lared here
  BTF_ID_LIST(special_kfunc_list)
  ^
  /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_=
LIST'
  #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                            ^
  /.../kernel/bpf/verifier.c:8443:19: error: array index 5 is past the en=
d of the array
  (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bound=
s]
                 btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back];
                           ^                  ~~~~~~~~~~~~~~~~~~~~
  /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' dec=
lared here
  BTF_ID_LIST(special_kfunc_list)
  ^
  /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_=
LIST'
  #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
  ...

Fix the problem by increase the size of BTF_ID_LIST to 8 to avoid compila=
tion error
and also prevent potentially unintended issue due to out-of-bound access.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index c9744efd202f..71d0ce707744 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
=20
 #else
=20
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[8];
 #define BTF_ID(prefix, name)
 #define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
--=20
2.30.2

