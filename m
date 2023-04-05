Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E596D7195
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjDEAnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbjDEAnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7249F5
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso22774408wms.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57iumcasqknZOnjXenM7MimJ0hLapVG9R2csE8pbamw=;
        b=ONrh4LSJTrBNUxjC3GV834atMrI4V5CdcsaxhFKKWHNVAV8visvmJmujGs1VyWEgEb
         KUjLooib4nc2NYSQHn2YmIbQ79/NLYzBDWel5ba2nLXXGUO1gvlGnfd37FxHQVgtJG+/
         OrojL3SVx8POuNOCzriGqcBUPYa19rjuPTAGTwDzVLeTCcdMsxBvJkTYIg1fByyy241P
         JV/JrewPwz9IiqlQkh8YnZaHIagPf7vvxQKjsDa6MVbmt4p0BV7nKMgE028I+l+d7TGR
         U9eOiCrtkUJ58pjKkvVcpQ6ARUe7Q/dLY8rNW6XnTCQjqEiKDcBXjFnWIltA+6IRmc2f
         8rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57iumcasqknZOnjXenM7MimJ0hLapVG9R2csE8pbamw=;
        b=3KoPrEU5OTB90+dgkcSVGwn0tGQcgX8/SmV+ZmtsZD/1wLRe37a/VvTUbZ5NKTIuTd
         CrsyYcy2TpCDd98toHoTu1TZNrT7h9Z3P2hpuBhQ10LBXgLYNReveUS6wtbRSDtVzmC9
         OZ3r3YTVhdhjBeEISkxp+fnFc92YXwNeo8TZk+WEb38dpndcclaI+DaOU2qgdlIQzq/+
         wCoANuBwAQCsxnYCY8iMfb93yhLp4Mv0PKLfkOJXg8GG1K5MEbKMjYtn59xzwJg/+VoY
         uHikhVZ0DJfT5MJUJJovi7nZmWrNWyuDbU3I95joUAy6/J6zkZf6ExiUVe6kwsWzXXdZ
         rhlg==
X-Gm-Message-State: AAQBX9ciIDp5PJs1kPDVYY9f2CS4TngO7s0YiyWFQEWhATA/5xP93Sf2
        bdFk3BcPQUrs/VYexd0MOVNDQaGq3QHaDQ==
X-Google-Smtp-Source: AKy350bdOVfHrZ8LqGI5Qs5hBLWTUVqvBqUp99aorK9/qelOKyZraLtH5jJqtouIrW21yaXsueLs6g==
X-Received: by 2002:a1c:f617:0:b0:3ee:672d:caae with SMTP id w23-20020a1cf617000000b003ee672dcaaemr3277684wmc.36.1680655370519;
        Tue, 04 Apr 2023 17:42:50 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003ed1f6878a5sm473434wmb.5.2023.04.04.17.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 6/9] bpf: Add KF_THROW annotation for kfuncs
Date:   Wed,  5 Apr 2023 02:42:36 +0200
Message-Id: <20230405004239.1375399-7-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3408; i=memxor@gmail.com; h=from:subject; bh=BkopB9cnZ0lcE2FeE9hPW8L26C85kzTNg+WjrB34Loo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPwRHycp93QQgjY7UWoeAZzPtGFXrfSHYmFP wL/QgfXu3uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD8AAKCRBM4MiGSL8R ypOwEAC+vqNRgFBs6+kUnWd41XtEnvSKdtUFsM1YrQBD66cgBWH/ILsM8SI3gr43XfCAe9P8O96 8Yz2gW3Sah0Tud84huzNmnlxoAY4ky1CaIrD1HrmElG1dVJxEb7cBrErznmzJyGTDe6KIEZqb/1 ItsvO0haAHzrneTlBSFXcXrC6vMkv/XKbkZ1y68ZTLP7bKVQhB5IaExuQtg1gKIP98eX4VU7qCE Va4qjSkHz0y72vngAaMuZvPBRwYeZtQIZYCf4ubDHpDWWWLjQk+saBzDc1K3MkKDAU36XyH1V1R sP+batOJfdmUOxPUxs8Pt4pVqVu+M/Dl/WtkF15BORAoraeDMYehPobQCju+yQ61nrhBiwMpAJ/ ZslMrNQ87z/RMRuaewnlvnm+NdjdRiBtTda8J+/D5W3W0okNqUi+sWoQI/MVJaQ3/uk6P7R3+0q WhJqxyLM225YYNPd8WmiRaXvzNevCZYUQIVjHguxAXoTqJH8MccWTD8HIdvLBMbUFHWioK6FsOJ QW3C9qdT7m9ztCuNm2tfUKwaPSQXz9EmcqEHJ2xnJ6OjGouAfRmT12u5kSjziDQ8aPh1exGRIZL xvvz2mtYBybul4N4J7xCbL5VZ9chSucF3d7+TTERuKRGl2yn8BiYOyM1Op89i1aDzT0gzPJRng9 DNPaPplb+ghozRg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add KF_THROW annotation to kfuncs to indicate that they may throw. This
is mostly for testing for now, but in the future it could be used by
kfuncs to throw on invalid arguments or invalid conditions based on
their input arguments, causing the program to abort, and simplify the
overall user experience of kfuncs for the happy case, without having to
deal with corner cases that never occur at runtime.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 12 ++++++++++--
 net/bpf/test_run.c    | 12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index d53b10cc55f2..8dfa4113822b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -75,6 +75,7 @@
 #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
+#define KF_THROW	(1 << 11) /* kfunc may throw a BPF exception */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acfcaadca3b6..b9f4b1849647 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9454,6 +9454,11 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
 }
 
+static bool is_kfunc_throwing(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_THROW;
+}
+
 static bool __kfunc_param_match_suffix(const struct btf *btf,
 				       const struct btf_param *arg,
 				       const char *suffix)
@@ -10813,11 +10818,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.btf == btf_vmlinux && meta.func_id == special_kfunc_list[KF_bpf_throw]) {
+	if (is_kfunc_throwing(&meta) ||
+	    (meta.btf == btf_vmlinux && meta.func_id == special_kfunc_list[KF_bpf_throw])) {
 		err = mark_chain_throw(env, insn_idx);
 		if (err < 0)
 			return err;
-		return 1;
+		/* Halt exploration only for bpf_throw */
+		if (!is_kfunc_throwing(&meta))
+			return 1;
 	}
 
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f1652f5fbd2e..31f76ee4218b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -766,6 +766,16 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
+__bpf_kfunc notrace void bpf_kfunc_call_test_always_throws(void)
+{
+	bpf_throw();
+}
+
+__bpf_kfunc notrace void bpf_kfunc_call_test_never_throws(void)
+{
+	return;
+}
+
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -806,6 +816,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_always_throws, KF_THROW)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_never_throws, KF_THROW)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
-- 
2.40.0

