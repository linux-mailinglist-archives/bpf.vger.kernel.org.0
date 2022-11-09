Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64986235B5
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 22:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKIVWe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKIVWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 16:22:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D3317C9
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 13:22:31 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A9KWLRo026066
        for <bpf@vger.kernel.org>; Wed, 9 Nov 2022 13:22:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Nbtmoc9lLSKreYlbRoKrmsrKIDLlzBEi1cQlB9kvHQI=;
 b=SG49O+jmA2/ElS4yLWTobrCQ5YGfdb5UvfwxjnBpu3AxJYEEwyBxMtochdmmIBeM1meV
 GG5L8p239fOA6baiItzCF0T3sF6lJLZTAsXLmcxzRr4J9M34UNC5U0ZQv0eElN9btcX7
 zo3v7jd6xME9q/FZzcdNL0jrYhzKumgcCho= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mxs6j-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 13:22:30 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 13:22:29 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 93D8211E72E6A; Wed,  9 Nov 2022 13:19:49 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v3 1/7] compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
Date:   Wed, 9 Nov 2022 13:19:49 -0800
Message-ID: <20221109211949.3214170-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109211944.3213817-1-yhs@fb.com>
References: <20221109211944.3213817-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QZSh9uhLKsghXWNcPtNtghMPPQbk4Mff
X-Proofpoint-ORIG-GUID: QZSh9uhLKsghXWNcPtNtghMPPQbk4Mff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, without rcu attribute info in BTF, the verifier treats
rcu tagged pointer as a normal pointer. This might be a problem
for sleepable program where rcu_read_lock()/unlock() is not available.
For example, for a sleepable fentry program, if rcu protected memory
access is interleaved with a sleepable helper/kfunc, it is possible
the memory access after the sleepable helper/kfunc might be invalid
since the object might have been freed then. To prevent such cases,
introducing rcu tagging for memory accesses in verifier can help
to reject such programs.

To enable rcu tagging in BTF, during kernel compilation,
define __rcu as attribute btf_type_tag("rcu") so __rcu information can
be preserved in dwarf and btf, and later can be used for bpf prog verific=
ation.

Acked-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
index eb0466236661..7c1afe0f4129 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -49,7 +49,8 @@ static inline void __chk_io_ptr(const volatile void __i=
omem *ptr) { }
 # endif
 # define __iomem
 # define __percpu	BTF_TYPE_TAG(percpu)
-# define __rcu
+# define __rcu		BTF_TYPE_TAG(rcu)
+
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
 /* context/locking */
--=20
2.30.2

