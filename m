Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E406459085
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhKVOuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 09:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhKVOuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 09:50:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86488C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:48 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id r130so16317419pfc.1
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFMzP91ueGJnO+YSOyIFIq9+XtvxdcxcczCdYUBEypo=;
        b=ksFAg+56IkNo+f0mV3FuNWzOSB6WJxprwKYv6bSxrTNTwr6c1y4Xb9rL5IKEhEouwb
         0oW+ItwY35992/figQWzQboZI+FNoKRRgrYd1Gz7TTBjscPVqly0DXaqMiw7smzIp+gB
         L4lVAry4A2VbPyF2XIbhyhneQ8wA1TCiNZLO7H+t2e7Pm8fMBWI77aX0RGMozpg2DaZQ
         gLqeVqKGrNW94u0ib7G1R/4I60XsvFLRs9rnQCqGY+hIMuwX8wfP6oTZiHf7e1TZ5oPJ
         db3fyhSmCAg27T95a0k+LNnKs61D9DH9iVrBzvouccryHWF8l8q9leM+0LH9EZoNtzIl
         C+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFMzP91ueGJnO+YSOyIFIq9+XtvxdcxcczCdYUBEypo=;
        b=TXZawKzKh1idvcUxZQHwnGozyE0wmtBLT2pH1g62OAiaKPRdI+0fqAheT2RTV18KX1
         ko+pOGaFqJPVNm01JeUmTKpzrXFbksTpiVtznwSj4M/myU6CBHTgNLBedcGUzcFYpEoh
         crATI/stlZj4X1SNmfQexoQGRVd6SZIbNaVkwrNWqUWztmuUnR5dNbWbQXnIhoOILsgi
         DI9i/qZWseUaXotci4OUZ2OqB5bFk+PO/yPTzlT2j9FSylfQ3pto+UEjO2VFOjQFriKf
         jVn6AskPibaeHrBawLcOayVEVz6YhXa0f1nfzeI98flyxOROq4EZbXRRx1NwAwf7xMKD
         5SlQ==
X-Gm-Message-State: AOAM5325/wR27NsOQoA6Gez5Ynt9d2j44RC03+EOoLoITFFPo0patZbP
        64r795XEqNSBzIq4kuyC2S6+4a5g6ko=
X-Google-Smtp-Source: ABdhPJz34rxPUEbi962IDephaNaDJ9Pjn/BAHF7+J3W2I91LYScPGkmafiPRLwmrhn1VGmJrAeP7ag==
X-Received: by 2002:a05:6a00:1693:b0:44c:64a3:d318 with SMTP id k19-20020a056a00169300b0044c64a3d318mr85469881pfc.81.1637592467929;
        Mon, 22 Nov 2021 06:47:47 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id na15sm21106123pjb.31.2021.11.22.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:47:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
Date:   Mon, 22 Nov 2021 20:17:40 +0530
Message-Id: <20211122144742.477787-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122144742.477787-1-memxor@gmail.com>
References: <20211122144742.477787-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; h=from:subject; bh=+GXisLs7ZQBt/pkFUiXWFHc+Wx/Sj9NAE9KbszUJ3Ws=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhm619F3HgNrcaNZS5cDaMlo8W3rAkEiodd+2RZwTP ujRtyjuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZutfQAKCRBM4MiGSL8RymwVD/ 9LL8tKFo/aifZPWfZccCt7lKh8yAxMApxlyYgrFJqkN4heErG03PTWQ6pe3XjnKPimTBl0Q+5fpnvJ q3lB4Enjem/Eh1Qfb3qEQbT84DNteoczG9EDTQDDffH0Q5WhnzBGSg9ZW9PfZ/f855e630V5XKNHLg 96wt5YuHR02q4Vjg8ru385HV0QFxtcLrlzQZbr3U2VfTILLeOiZNaVbPwE8M3jPo4ZzyhjdzNWeGUd TmPQEt+e2MddE+XWaIz1GnE9ARxoJ5DpjlomgJ22HcZLqUkyvYI6T+/iRUdBGAYPcpcmpyX2ciN/kT Ia/VdFpYl29CyfL4rcniqkX7vO9VQ1DyRIUmkqw7kn5i4xPnD14q9odFcEp6nho3FdilnDGHVWAkTK /mkyKdw+gHAygy6dhlQjyEYPmWC9sTa0lGxvtaYcren+hRNOtRjuM6NOCmwh+sWBayIaX/wXtOykHT avkM38A51bPMI/oRsjQev4XTammHS7vUmZxnghTOLJq/WX7T2bkKRwrDs7xGGrca/Ebhl/K0VZhRaH lUpbea4cwrcO34IxH9nu47myHCCUuV510ejC83VDkMEKSxDbZg5xE6Ey/44XqwUKqwKz24B+KabJE/ JlStbs2oX7Ujttt6W7442Ly9Khlh7MKvVnl4bS1/sw4aAxFRZLttd9/Wk+oA==
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
index dbc3ad07e21b..ea3df9867cec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6346,11 +6346,6 @@ BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
 
 /* BTF ID set registration API for modules */
 
-struct kfunc_btf_id_list {
-	struct list_head list;
-	struct mutex mutex;
-};
-
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
 void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
@@ -6389,8 +6384,6 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 	return false;
 }
 
-#endif
-
 #define DEFINE_KFUNC_BTF_ID_LIST(name)                                         \
 	struct kfunc_btf_id_list name = { LIST_HEAD_INIT(name.list),           \
 					  __MUTEX_INITIALIZER(name.mutex) };   \
@@ -6398,3 +6391,5 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 
 DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
 DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);
+
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ef7ce18b4f5..596bb5e4790c 100644
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
2.34.0

