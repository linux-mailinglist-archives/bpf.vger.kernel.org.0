Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6929451D7F
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349305AbhKPAaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhKOTaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 14:30:00 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F19C06120C
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:49 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r5so9514502pgi.6
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7M7FIkw4xCHWvU18lhKXQJCKfukAcHTRUhan1PsbW/Q=;
        b=T1xuQ+uuD5FKrXHy+6Ul5+64EqeZFSXeFrYQOHEDJ0WMFXsPzZw8TA5H3oeZVjcoyx
         SkovVtY10eYK3XQGlPqYMe+Kwi+ljuQ00zpC1zFwMy5nXUcul81mMxg1trfhwaG4zC5F
         vzqFnXfLjc1tlCbEObfjR+dNwxkjsY1smFwMSJ6GbER5CX7PET6/GYLqD1ZPobqo+gmP
         D0sjMltC6argMwI8Z0EIspNqPnKsFal6h9YRcEHT/nScTPpC7gFHSCdIddDFKsUuymGo
         WhLvFTwVOPDJJxhAsZcYPmw1iq8Ew/nBFnQ2PoljgXCdgmmqNcJvuai9Cr4KtR0h9Pt2
         NFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7M7FIkw4xCHWvU18lhKXQJCKfukAcHTRUhan1PsbW/Q=;
        b=ZQ1m7W1lcuJcdTz13+Pj6iRGRZOOkT0IosyPwxKAEmgJDkK5AJnIadqpTkQ5F3Djbc
         Vgy1MdhP73u4LFwSN+M3WHt9mDHDSBFxbGiWNrcYbFN5JMBxjKx/jhrXEFcH/k8Onhco
         zA0vVo/X03gZVCYlZXBszAueqli7forECcC08S9eTuLFvZXnIFpvSeMfVzkGJWFi02po
         9blgg7XpiQlC3DUCDH6iuii+2G69jJR5//xuN7nnhY86KlfY116r73/aUuE54FHtUdvi
         vrpP+sIwfNJW8EJZCwFTJkRHdHMPbzomVL+fORKmfoIyAiDIj9V9iESWq+GL1TvzRPkv
         JW/g==
X-Gm-Message-State: AOAM533dHodxY6yeQvYPmjrjOU0wuKJwzPq6J1IubQPgh4mGx2N7Ohlc
        8emufM+uvTsDyG8EAM1/h3nT7s+ReJ8=
X-Google-Smtp-Source: ABdhPJy8lYj1hAvUg3X0Mw15jRT6C+84K3+8NuXCKD9WCb6ceNbxt12tFJ55/dMeYQDBAHTesEQ+xg==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr34867984pfj.15.1637003929008;
        Mon, 15 Nov 2021 11:18:49 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id d21sm1138672pfu.52.2021.11.15.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:18:48 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
Date:   Tue, 16 Nov 2021 00:48:38 +0530
Message-Id: <20211115191840.496263-2-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115191840.496263-1-memxor@gmail.com>
References: <20211115191840.496263-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223; h=from:subject; bh=f6QOkxkZ7BNFTA6nheRnBYBiocEQj+ELUmnK0PDqBC8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhkrI2NN1ewITG6TVKeciu+xJmSo0qOONLncG7ws21 DwostZmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZKyNgAKCRBM4MiGSL8Rys3sD/ 9CfhRPO3QqdEYNiRl4ZQCOLvdZRaljmeIjdldHYPABEEuxQyB51/bGX30OuraqIiQtpSwPjPEHfpre GfMa+lFqT9Ky9a4GuJ+pU7t9o2FsJOPps0b82g19rslDmfVoes7lJnQE92MFdX1TibVqRb+sJKLtB2 AiGIK1ubMD6CEk+lP3OHOHsddoLrylTLiWpc8+ebbo19XpE8TejL5G89QzvVXEa08QQb/cQ1sExJod xPda/hf+W8T1CTeQaNRK15EzPyhav1Jef3mdKwBAWPk2hVOujEHJtD2Q44m3jgbGb3/Rf4EF0y3vro bUWnDUNEIV6AnbOT0WsV7a6CGfUNwAPB4K+4laCeCdIsjuTQa4yEEa7BBxT6wdumd1AqluFiSw2W10 9OmpjMetBNHiPaU6TCmbWdv4jBnMbaYk40h/O+3IPKnaUZBzMlhYv7B3BGaPw1uguEXyzb/apdxTHo YTcTz5XbATbw9JuKEHvx6y2gxHTEnJgIlUoUUDe6QShk1qDWApY3Xiz+uqIQpwF++3FNnwZV0UKmvf dFnnrbhC3wfw9sqBVs8XdZslX9tY5QBOgllj3EaQWH+NFjYfREqJ7MitXIemLlHOu/ISGYR/5I7a9j u1q0XhirD0ULCrnlb4xTBQwr2w/BLpBvvbGLsZVYdUnRN1bLGax1MQUATHxw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vinicius Costa Gomes reported [0] that build fails when
CONFIG_DEBUG_INFO_BTF is enabled and CONFIG_BPF_SYSCALL is disabled.
This leads to btf.c not being compiled, and then no symbol being present
in vmlinux for the declarations in btf.h. Since BTF is not useful
without enabling BPF subsystem, disallow this combination.

However, theoretically disabling both now could still fail, as the
symbol for kfunc_btf_id_list variables is not available. This isn't a
problem as the compiler usually optimizes the whole register/unregister
call, but at lower optimization levels it can fail the build in linking
stage.

Fix that by adding dummy variables so that modules taking address of
them still work, but the whole thing is a noop.

  [0]: https://lore.kernel.org/bpf/20211110205418.332403-1-vinicius.gomes@intel.com

Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
Reported-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h | 14 ++++++++++----
 kernel/bpf/btf.c    |  9 ++-------
 lib/Kconfig.debug   |  1 +
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 203eef993d76..0e1b6281fd8f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -245,7 +245,10 @@ struct kfunc_btf_id_set {
 	struct module *owner;
 };
 
-struct kfunc_btf_id_list;
+struct kfunc_btf_id_list {
+	struct list_head list;
+	struct mutex mutex;
+};
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
@@ -254,6 +257,9 @@ void unregister_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
 				 struct kfunc_btf_id_set *s);
 bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 			      struct module *owner);
+
+extern struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list;
+extern struct kfunc_btf_id_list prog_test_kfunc_list;
 #else
 static inline void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
 					     struct kfunc_btf_id_set *s)
@@ -268,13 +274,13 @@ static inline bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist,
 {
 	return false;
 }
+
+static struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list __maybe_unused;
+static struct kfunc_btf_id_list prog_test_kfunc_list __maybe_unused;
 #endif
 
 #define DEFINE_KFUNC_BTF_ID_SET(set, name)                                     \
 	struct kfunc_btf_id_set name = { LIST_HEAD_INIT(name.list), (set),     \
 					 THIS_MODULE }
 
-extern struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list;
-extern struct kfunc_btf_id_list prog_test_kfunc_list;
-
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b9d23be1e99..3ace85d496ae 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6361,11 +6361,6 @@ BTF_TRACING_TYPE_xxx
 
 /* BTF ID set registration API for modules */
 
-struct kfunc_btf_id_list {
-	struct list_head list;
-	struct mutex mutex;
-};
-
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
 void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
@@ -6404,8 +6399,6 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 	return false;
 }
 
-#endif
-
 #define DEFINE_KFUNC_BTF_ID_LIST(name)                                         \
 	struct kfunc_btf_id_list name = { LIST_HEAD_INIT(name.list),           \
 					  __MUTEX_INITIALIZER(name.mutex) };   \
@@ -6413,3 +6406,5 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 
 DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
 DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);
+
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6fdbf9613aec..eae860c86e26 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -316,6 +316,7 @@ config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
+	depends on BPF_SYSCALL
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.33.1

