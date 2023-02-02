Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC7688471
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBBQbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjBBQbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 11:31:10 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1164698;
        Thu,  2 Feb 2023 08:31:07 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id l129so1153178vkh.6;
        Thu, 02 Feb 2023 08:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anXQZojTFkdmfLnwafQXN0T5XgJCU3AiiRxtzHW7UPA=;
        b=p3N/foHYUlUmsH8ODPaCKJizAFJH320foFwlGY+eGU1UwoNRugrqUW5tbuer6xu9/Q
         R4K8O8G2xT+yjBiamG9PPv9Npb5R8bRkR2reUTIH9tSF9rYSKDD+5XfXsNcKTrgu+R2g
         Tn54fIfcgqhdNnbgAXzXR6ihwk4MIGBludXGnNow57ZKvah/LZH+O1xprT2ks4xw5RVm
         454LDE0XSQLS8eSDxR8UYb9XBaMNi8w5vTQGDOX75iE+tK5oYtwS0BSMYoYUaB9CoGbM
         2QOfePuJy3MJ44aEHQbXlnFNFKq0wZcFhsC+T3YS0eKBXNpQy0Zh4vtj2nZBL2yq5Rz4
         sMzg==
X-Gm-Message-State: AO0yUKXBG5M6tvEctpdDgvJUX/E6nTQ1SrFUTtpj12+3ZZ4x5nkuOG+d
        UnBWUPg7NTnHRgnguQwlg0p5n/OEGRAmYv30
X-Google-Smtp-Source: AK7set+VUsZMdfoZD6C4KYyS4uTpJw+OUDCHLDkRqwi21bPaaaCGxAudNJx1xHTQdMEYtBhqIGLDSA==
X-Received: by 2002:a05:6122:731:b0:3e5:cfa3:124e with SMTP id 49-20020a056122073100b003e5cfa3124emr3646782vki.12.1675355466323;
        Thu, 02 Feb 2023 08:31:06 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c30-20020a05620a201e00b006e07228ed53sm36466qka.18.2023.02.02.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:31:05 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, brouer@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
Date:   Thu,  2 Feb 2023 10:30:55 -0600
Message-Id: <20230202163056.658641-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202163056.658641-1-void@manifault.com>
References: <20230202163056.658641-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have our kfunc lifecycle expectations clearly documented,
and that KF_DEPRECATED is documented as an optional method for kfunc
developers and maintainers to provide a deprecation story to BPF users,
we need to actually implement the flag.

This patch adds KF_DEPRECATED, and updates the verifier to issue a
verifier log message if a deprecated kfunc is called. Currently, a BPF
program either has to fail to verify, or be loaded with log level 2 in
order to see the message. We could eventually enhance this to always
be logged regardless of log level or verification status, or we could
instead emit a warning to dmesg. This seems like the least controversial
option for now.

A subsequent patch will add a selftest that verifies this behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/verifier.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 49e0fe6d8274..a0ea788ee9b0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -71,6 +71,7 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
+#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cc0e70ee71e..22adcf24f9e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU;
 }
 
+static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_DEPRECATED;
+}
+
 static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 {
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
@@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
+	if (is_kfunc_deprecated(&meta))
+		verbose(env, "calling deprecated kfunc %s\n", func_name);
+
 	return 0;
 }
 
-- 
2.39.0

