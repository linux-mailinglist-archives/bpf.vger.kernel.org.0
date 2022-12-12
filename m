Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177E649F55
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 14:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiLLNCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 08:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiLLNB0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 08:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C01274F
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670849984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=em38rrGPDE/23xOPclO2Yg66D3ChAbtZDdaX/ywg2mM=;
        b=G5uwTlO91ObA68noAx6SFvZ7kOFDxOIcqzpbfQP52Be9KgOiQme+SW+cHvjc9jhONQL+RD
        2rr+HmChYOeIuf6hNFIGDNHIfHxg7opJOJ/245vbXfzmE8gpoeDod10seMRAaZP9ToUBEa
        apyxaC30lO/3NKttdzynN2eNrsvtUos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45--d_1hGUFOB6HWnQiYSLmBg-1; Mon, 12 Dec 2022 07:59:28 -0500
X-MC-Unique: -d_1hGUFOB6HWnQiYSLmBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09F61101A52A;
        Mon, 12 Dec 2022 12:59:28 +0000 (UTC)
Received: from ovpn-195-46.brq.redhat.com (ovpn-195-46.brq.redhat.com [10.40.195.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD02E2026D4B;
        Mon, 12 Dec 2022 12:59:24 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 12 Dec 2022 13:59:15 +0100
Message-Id: <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
In-Reply-To: <cover.1670847888.git.vmalik@redhat.com>
References: <cover.1670847888.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When attaching fentry/fexit/fmod_ret/lsm to a function located in a
module without specifying the target program, the verifier tries to find
the address to attach to in kallsyms. This is always done by searching
the entire kallsyms, not respecting the module in which the function is
located.

This approach causes an incorrect attachment address to be computed if
the function to attach to is shadowed by a function of the same name
located earlier in kallsyms.

Since the attachment must contain the BTF of the program to attach to,
we may extract the module from it and search for the function address in
the module.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/verifier.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..d646c5263bc5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
+#include "../module/internal.h"
 
 #include "disasm.h"
 
@@ -16478,6 +16479,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const char *tname;
 	struct btf *btf;
 	long addr = 0;
+	struct module *mod;
 
 	if (!btf_id) {
 		bpf_log(log, "Tracing programs must provide btf_id\n");
@@ -16645,7 +16647,19 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			else
 				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
-			addr = kallsyms_lookup_name(tname);
+			if (btf_is_module(btf)) {
+				preempt_disable();
+				mod = btf_try_get_module(btf);
+				if (mod) {
+					addr = find_kallsyms_symbol_value(mod, tname);
+					module_put(mod);
+				} else {
+					addr = 0;
+				}
+				preempt_enable();
+			} else {
+				addr = kallsyms_lookup_name(tname);
+			}
 			if (!addr) {
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
-- 
2.38.1

