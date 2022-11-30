Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861463CF61
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 07:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiK3GzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 01:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiK3GzV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 01:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F14B77D
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 22:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669791261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GgiL2uUehFeSY01/5xS/jsuIOB0GqA8H4qC4ZB37mA=;
        b=YJ53k7FCf95NLCf3WNF6nT6HcEYmo+PZcM+MlDFl+MzwfwD9v7FfpAUPiqs614riaDDRRS
        dKn/610nDzGiXzrTQohs9rPEmTDXLBrhA7YbNFnWvRNxlQmVu3Wx1CboTr9yPSG2o91f8U
        EtjDy5cb7Ng6xieyeYq5tf+dOjzOSME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-IjyMXwJVO4ecXW6Emge_iw-1; Wed, 30 Nov 2022 01:54:16 -0500
X-MC-Unique: IjyMXwJVO4ecXW6Emge_iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72F0E1C008A5;
        Wed, 30 Nov 2022 06:54:15 +0000 (UTC)
Received: from ovpn-192-146.brq.redhat.com (ovpn-192-146.brq.redhat.com [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F8D5C15BA4;
        Wed, 30 Nov 2022 06:54:12 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 1/3] kallsyms: add space-efficient lookup in one module
Date:   Wed, 30 Nov 2022 07:54:02 +0100
Message-Id: <2036e115623b527dd78b22f487a35ddceb512006.1669787912.git.vmalik@redhat.com>
In-Reply-To: <cover.1669787912.git.vmalik@redhat.com>
References: <cover.1669787912.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
 include/linux/module.h   |  1 +
 kernel/module/kallsyms.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 35876e89eb93..fe5dfb6bd288 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -605,6 +605,7 @@ struct module *find_module(const char *name);
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			char *name, char *module_name, int *exported);
 
+unsigned long kallsyms_lookup_name_in_module(const char *module_name, const char *name);
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
 
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

