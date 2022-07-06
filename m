Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE2569109
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiGFRtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiGFRtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:49:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD746459
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:49:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so112123447b3.12
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+0ywNl+UzKy+Oirvqy2rLPX36d1n4NMn4QqX2Zbrjs8=;
        b=F3XwHp7oJOd48fqRCn+oPcHHvBbBujhLtK74QTzBq9Gs6HW1BLa19pP0P2v0AJB2Es
         BrmZyMCMwufOgbEcxXHZrg5p8TfFtRjbuTvPWCpAIDoC4GBl5lpTPkmHFZstvHgt0WlR
         6iGyMlC2jYPfZEP4587rTSIAOOCjfhNhHpfaOTKbyrCCjXnPyswoIzL8dZrDuQGrxWm/
         yNkhC6dQ3UDS5x5g9tePbsZCAWV0v+oOnhtlZn029CIw6JhVbQwECtWdlMU70VtGiBBJ
         5Gkj7Zp+uIntDe8uBHZJ3QjYMb770Hft/dPEXLhgTyJx9RQ1dRTZNE9zJZfS2BNL9nLf
         shlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+0ywNl+UzKy+Oirvqy2rLPX36d1n4NMn4QqX2Zbrjs8=;
        b=m+npp54tUPIf6QFq230kyucyYFxe0igdIRK9BSIJyfRIODOF2vFfA4zb3FcDFA77De
         a/lXpKFtE/af5qTaDhDSx8YR2TuV7UrAk4PMWbcIEcd2CEQn7/+D3EArjjamtVYkRa9P
         5IdvPPJeEOGvsnXjizjEXnsKVoZc1N8If/p1AtcrA84g+/aPocykBamI40BXzrW1zoBv
         QGizUEq217rIN6Mzmm41dgiS6zUbTq8KZ+GL+wWCoJ2IV7Tq4YbYYVztaMgvx49ZNjeA
         OJSlH6Tyi37+OXnX6MgsBAnxfGC7cIgS7ofe7DxzcnpAL1LG54Y2dcg/HQpv1BOseGfA
         GAAA==
X-Gm-Message-State: AJIora831VuuESQ+dUC+X+0SvVveQrDGHLr5sR62FQy4U8MMy5uYDqyD
        hKL/pMg+3PtpnLPG4453fn201bGhDeM4HHf+dBc9oMYaIA3kEDg18nlc5WZk8SH+eagpUaOveBf
        5qQmvSJuxMe5mInbnrR/ZpFnd2X3Ye7YqW0uvZ7SrYVpk6+J41A==
X-Google-Smtp-Source: AGRyM1szy3FZAyth2Pe+ilwe9iDGXIL6RRYHhxg8omS276PdZa6Z5loc3ugKynbfZze2n8spRoRh5eU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:9147:0:b0:31c:7a11:bcf3 with SMTP id
 i68-20020a819147000000b0031c7a11bcf3mr27851203ywg.310.1657129739293; Wed, 06
 Jul 2022 10:48:59 -0700 (PDT)
Date:   Wed,  6 Jul 2022 10:48:57 -0700
Message-Id: <20220706174857.3799351-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next] bpf: check attach_func_proto return type more carefully
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller reports the following crash:
RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610

With the following reproducer:
bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)

Because we don't enforce expected_attach_type for XDP programs,
we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
part in check_return_code and follow up with testing
`prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
is NULL.

Let's add a new btf_func_returns_void() wrapper which is more defensive
and use it in the places where we currently do '!->type' check.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/btf.h     | 5 +++++
 kernel/bpf/trampoline.c | 2 +-
 kernel/bpf/verifier.c   | 8 ++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa0428..17ba7d27a8ad 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -302,6 +302,11 @@ static inline u16 btf_func_linkage(const struct btf_type *t)
 	return BTF_INFO_VLEN(t->info);
 }
 
+static inline bool btf_func_returns_void(const struct btf_type *t)
+{
+	return t && !t->type;
+}
+
 static inline bool btf_type_kflag(const struct btf_type *t)
 {
 	return BTF_INFO_KFLAG(t->info);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6cd226584c33..9c4cb4c8a5fa 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -400,7 +400,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
 	case BPF_LSM_MAC:
-		if (!prog->aux->attach_func_proto->type)
+		if (btf_func_returns_void(prog->aux->attach_func_proto))
 			/* The function returns void, we cannot modify its
 			 * return value.
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3ec6b05f05..e3ee6f70939b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7325,7 +7325,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	case BPF_FUNC_set_retval:
 		if (env->prog->expected_attach_type == BPF_LSM_CGROUP) {
-			if (!env->prog->aux->attach_func_proto->type) {
+			if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
 				/* Make sure programs that attach to void
 				 * hooks don't try to modify return value.
 				 */
@@ -10447,7 +10447,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	if (!is_subprog &&
 	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
 	     prog_type == BPF_PROG_TYPE_LSM) &&
-	    !prog->aux->attach_func_proto->type)
+	    btf_func_returns_void(prog->aux->attach_func_proto))
 		return 0;
 
 	/* eBPF calling convention is such that R0 is used
@@ -10547,7 +10547,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 			 */
 			return 0;
 		}
-		if (!env->prog->aux->attach_func_proto->type) {
+		if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
 			 */
@@ -10572,7 +10572,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	if (!tnum_in(range, reg->var_off)) {
 		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
 		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
-		    !prog->aux->attach_func_proto->type)
+		    btf_func_returns_void(prog->aux->attach_func_proto))
 			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 		return -EINVAL;
 	}
-- 
2.37.0.rc0.161.g10f37bed90-goog

