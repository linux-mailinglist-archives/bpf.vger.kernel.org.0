Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA39637955E
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhEJRYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEJRYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:06 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0ADC06175F;
        Mon, 10 May 2021 10:23:01 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id jm10so8749535qvb.5;
        Mon, 10 May 2021 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKWNKjvr3PIJMbAHVnciIVF869iR5Tf3Vcd3i8yjR7k=;
        b=HPSFDpKwtpmI97BZ7OnEnwlJ7OuP8yE/VAmnjLJjS/naYUPkqSuhZgmTx/MyS2dJRa
         lTtgjMdq+j883FGfyq5Ddx/EzmsZX28SURajAkG7zoBAffmgLcLiiZVI4ZmqTjStSXPe
         c5auVjYHCI6/Zqk0WI6uyEHrglF2tMX5qfckEWKUtfESCHpkGA8Fmpt4fXiQwVFnQkcU
         vE9oVeoAjDcNT1GQXtRDa7aQfDBGD0GICi9rLDLMeUJl3CLnoyG3MI+tmYe613gAmgWU
         tJ6DGKEmlbW1JghfZciGQxHlFrIMJuxQ4N6d4DLi9kg9xFmMciPx/ZPo+vnnfC/e1PI2
         ZYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKWNKjvr3PIJMbAHVnciIVF869iR5Tf3Vcd3i8yjR7k=;
        b=Dw6R9/J7rB73AF3JJv+jiCIgwEudi9q5zWu8njwDkZvok4rHTSXZmO+YmFO0PEcuML
         f8pofZnXazb3wQCjoB4rSerncwVeuqZ8598Hm6loHU5jBg1lg89EW3yqZ+51hI9Zp5Qs
         Dfj+k9qZQn4vNiXJMUc7muc2qzzJXG/yfyy6yBZWxELo7knWHP+HsPdT2wrkoIO1sExY
         xPAcVfhPpQCd88wPEhxvTZabyTdoO+CgcZX31/r9sE9TOfTJau6XZeydUTcK0l4CXahd
         FCzq8sV31JyQj/2RFeab7SnI5211lwXMYcrkpi8OSCEnoHytZI72xj3rsR71pxTT59qZ
         YKsQ==
X-Gm-Message-State: AOAM532iXWJXU0dlsGjiXH97i/88Z0fpqRmLS4OmpgryWpXKUxyqKVr4
        joNnxEZEkPATP9wYsIAOfEmQK35uwyApz498
X-Google-Smtp-Source: ABdhPJxHKiUOuiZgZMAXiPdZZ8hqDpsF0UZO35YHyOMtFSuBp7jsqZ6dvzUky2eQee+s+Ub8pszoBA==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr24460456qvw.35.1620667380808;
        Mon, 10 May 2021 10:23:00 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:23:00 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 06/12] lsm: New hook seccomp_extended
Date:   Mon, 10 May 2021 12:22:43 -0500
Message-Id: <f7ebfa197042ec56628cecd29b5eedd8f0cfb9c3.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

This hooks takes no argument, and returns 0 if the current task is
permitted to use extended seccomp-eBPF features, or -errno if it is
not permitted.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 13 +++++++++++++
 security/security.c           |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 61f04f7dc1a4..94e18d95e1cc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -391,6 +391,10 @@ LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
+
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+LSM_HOOK(int, 0, seccomp_extended, void)
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 9aeda3f9e838..8e98dd98ac90 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1960,6 +1960,11 @@ extern int security_bpf_map_alloc(struct bpf_map *map);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
 extern void security_bpf_prog_free(struct bpf_prog_aux *aux);
+
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+extern int security_seccomp_extended(void);
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
+
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -1992,6 +1997,14 @@ static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 
 static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 { }
+
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+static inline int security_seccomp_extended(void)
+{
+	return 0;
+}
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
+
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/security/security.c b/security/security.c
index 94383f83ba42..301afe76ffb2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2553,6 +2553,14 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 {
 	call_void_hook(bpf_prog_free_security, aux);
 }
+
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+int security_seccomp_extended(void)
+{
+	return call_int_hook(seccomp_extended, 0);
+}
+#endif
+
 #endif /* CONFIG_BPF_SYSCALL */
 
 int security_locked_down(enum lockdown_reason what)
-- 
2.31.1

