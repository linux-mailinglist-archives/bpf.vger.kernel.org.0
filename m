Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471D642BBB
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 16:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiLEP2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 10:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiLEP2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 10:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F836147
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670253984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEKiaerBTgxeA+iQRDpxjwc3UIUz5FP4iUyhE5eUv28=;
        b=ZpUHkmHgyrERIIIDDabAzLH9Qp9WuMeN/hDZwhYotIel3uYLXLlLShPCRQtzaJZS4xnEcd
        0igF85ezWRmLIoQJ4u7fOyoNWM1F/G6J5Ud8ruVIdRebXe1vCo0fzDRqPi767t4cfnfC2r
        gsXIEbJJOYfGLdiJVFMr/7PhwfmvhmI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-8uT96WGBMOqEa9FGmoZw5g-1; Mon, 05 Dec 2022 10:26:22 -0500
X-MC-Unique: 8uT96WGBMOqEa9FGmoZw5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC637383328E;
        Mon,  5 Dec 2022 15:26:21 +0000 (UTC)
Received: from ovpn-193-115.brq.redhat.com (ovpn-193-115.brq.redhat.com [10.40.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9555540C6EC3;
        Mon,  5 Dec 2022 15:26:18 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 1/3] kallsyms: add space-efficient lookup in one module
Date:   Mon,  5 Dec 2022 16:26:04 +0100
Message-Id: <8831f08b909c7c670e547240368276af73e552d2.1670249590.git.vmalik@redhat.com>
In-Reply-To: <cover.1670249590.git.vmalik@redhat.com>
References: <cover.1670249590.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Until now, the only way to look up a symbol in kallsyms of a particular
module was using the "module_kallsyms_lookup_name" function with the
"module:symbol" string passed as a parameter. This syntax often requires
to build the parameter string on stack, needlessly wasting space.

This commit introduces function "kallsyms_lookup_name_in_module" which
takes the module and the symbol names as separate parameters and
therefore allows more space-efficient lookup.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/module.h   |  7 +++++++
 kernel/module/kallsyms.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 35876e89eb93..a06fbcc4013c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -605,6 +605,7 @@ struct module *find_module(const char *name);
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			char *name, char *module_name, int *exported);
 
+unsigned long kallsyms_lookup_name_in_module(const char *module_name, const char *name);
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
 
@@ -783,6 +784,12 @@ static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
 }
 
+static inline unsigned long kallsyms_lookup_name_in_module(const char *module_name,
+							   const char *name)
+{
+	return 0;
+}
+
 static inline unsigned long module_kallsyms_lookup_name(const char *name)
 {
 	return 0;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 4523f99b0358..c6c8227c7a45 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -482,6 +482,22 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 	return 0;
 }
 
+unsigned long kallsyms_lookup_name_in_module(const char *module_name, const char *name)
+{
+	unsigned long ret;
+	struct module *mod;
+
+	preempt_disable();
+	mod = find_module_all(module_name, strlen(module_name), false);
+	if (mod)
+		ret = find_kallsyms_symbol_value(mod, name);
+	else
+		ret = 0;
+	preempt_enable();
+	return ret;
+
+}
+
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name)
 {
-- 
2.38.1

