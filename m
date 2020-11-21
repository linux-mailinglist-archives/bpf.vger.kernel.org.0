Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C182BBDBE
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgKUHIo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 21 Nov 2020 02:08:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgKUHIo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Nov 2020 02:08:44 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AL77jbY019454
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 23:08:42 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34whfkye6x-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 23:08:42 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 23:08:40 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 64F362EC9D02; Fri, 20 Nov 2020 23:08:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH RESEND bpf-next 2/2] bpf: sanitize BTF data pointer after module is loaded
Date:   Fri, 20 Nov 2020 23:08:29 -0800
Message-ID: <20201121070829.2612884-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201121070829.2612884-1-andrii@kernel.org>
References: <20201121070829.2612884-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-21_03:2020-11-20,2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=38 priorityscore=1501
 impostorscore=0 mlxlogscore=643 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given .BTF section is not allocatable, it will get trimmed after module is
loaded. BPF system handles that properly by creating an independent copy of
data. But prevent any accidental misused by resetting the pointer to BTF data.

Suggested-by: Jessica Yu <jeyu@kernel.org>
Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index f2996b02ab2e..18f259d61d14 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3709,6 +3709,11 @@ static noinline int do_init_module(struct module *mod)
 	mod->init_layout.ro_size = 0;
 	mod->init_layout.ro_after_init_size = 0;
 	mod->init_layout.text_size = 0;
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
+	mod->btf_data = NULL;
+	mod->btf_data_size = 0;
+#endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
 	 * walking this with preempt disabled.  In all the failure paths, we
-- 
2.24.1

