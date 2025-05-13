Return-Path: <bpf+bounces-58121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA4AB571D
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11EA1894D58
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC52BDC38;
	Tue, 13 May 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7rYVlyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46731269D1B
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146498; cv=none; b=sQDPTN6xS3psv6HtEuGZp6rkWzlzn0NnNEuBZg1YbWbWC6Osl0s/A7cFQcrM2PADaoJYqHJJF4rpcLff1Yh3BdJ/RTIuRpPqmulgnOnL28QbmCqocezKDPdzVF/rhHPyimC4JJUp+88wg1J7u/ZkYJK/YsTCjiO4absTyzs44lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146498; c=relaxed/simple;
	bh=Amjm9M4IF3fDIid74guUsuxE12y9bwdjWPVeGMrIvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTow+EHTgHC2g+eD6x7np3V0F4xUzAIUXtUuoNEoEKye4amm5ON7Zx3TKqSIYtHypBHeKcQDA67dsDcSkPwV6OgQSr8VsRAIyvtgrCFzI3t5106yqsDm4c5p5U6WjRgDMSiztOzkqDAj4WKMlvjOLxUhNRbKLurTAePeX4rAq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7rYVlyB; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a0b291093fso4240250f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747146494; x=1747751294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lClPRbgfBZJSlifv5LZkTIca4kkcvS+coc8x3JlfL/Y=;
        b=Y7rYVlyBpK5cVmARWTtICn23cF8loiekQLcYflUmvbpAoCMOPO+TAuC8DTg/nRrDCn
         IFKiMSglB79VZ/emucCJo0Xd7s+zXdAJTaAd7Ly5Wg+yJys6Xf6i9nUpVf5X/9DBh961
         bGO0Dy1BWo5Q79wtIACV04B1dq7gimNzekZSeAULb8qZGQjX7SvgtUME/LeNFuZ4WFiP
         6lPBl/muweG7StP+d8BphUY16NJPypxYZ/CR1xYsJD2ojs3DobTfx5XuDw5XkHZ+/t5M
         zp9mcQOCGa71PcyaDi/IOOZUi6pwKudNVUmoa595EV0AfIyf0JtMVnm4ED9UeVX3pbgD
         /o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747146494; x=1747751294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lClPRbgfBZJSlifv5LZkTIca4kkcvS+coc8x3JlfL/Y=;
        b=NRaMabtaA6xM9fFY8lT0Ha2hg9jxkPbQfUuMUdRKRAYYvH2YaRlLBXF3prXOxp/Rzd
         sE/jgoBPosL2YixIVPGJkCavCLSIJGrrM0tzIi0nTChCom0iLhHVkK2YR/YTLVNmwhFx
         VdKIPhQJ3XLj42fpFvSZHMeQjg32agc2IYBE7aQyKp/3ANOCp8Y9v6GpIS+tM80fEfWJ
         KesIDYBUZBP1U26gmoe4yecaaYKUInJNBFjs4CVGTSmNGjFxZtvDITQlTvZra+1+oa/t
         2qMutOfRCknan8rucMS1ZFH1LlwTuuBlwVSpPKBdA5auL1PA+A5HargAdmumofrAWxFA
         O3Zg==
X-Gm-Message-State: AOJu0YzIVdnkeT9LuJth33vgC8ssiPb+BqDzmx4eVyVEmx1fhXfVsoQ4
	mqdlEBHLNxgjFUDsWhccGWAJ3P5pg+Ym9ILkPzUV1sBjCLljaDVuE+veNYj2d4W9cw==
X-Gm-Gg: ASbGnctNGiFjPGt9tsfeTiBp8e9yvOPqgV7IkD51FgzkgS9PYb05qY5HTwJdg7ICoaF
	bnQkn8MyDbyG/w+atujOa4Xwrcn3jU3fUqo2zF12XXrDkM2b9EYrE2lxsXDgFXSNymXZXUrJ7rm
	A4vHcF2oJxcy0FZn87q16rlTx+Zr1D7xZWPhKEl6u1wrsJnl7VKzS8MNdedCb/tqBFdq2j54DMW
	7GtTkDI4qkhJ8bWRAAvp/HIpo94V5jzxLdaGwD+r3rtPW1rIYrLvnAbiUvwmoPmKfhJUbUaQBJt
	fdGrMu0Luz9U+RPv2udVbx/weW3SYoZ4t9Fg4UQP
X-Google-Smtp-Source: AGHT+IGDxF6JpJgf6bQMyEnn153pINqKxngWTzY7X1cEop7TIC8AtBW6ph+RobHLMFi2Q5M4Tqz+0A==
X-Received: by 2002:a5d:4110:0:b0:3a0:825a:cf8a with SMTP id ffacd0b85a97d-3a340d2879cmr2616226f8f.26.1747146493662;
        Tue, 13 May 2025 07:28:13 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebe4fsm16713646f8f.39.2025.05.13.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:28:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3] bpf: Add __prog tag to pass in prog->aux
Date: Tue, 13 May 2025 07:28:12 -0700
Message-ID: <20250513142812.1021591-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071; h=from:subject; bh=pXNVoWMWueUC0tUxbCDiU5LO/k0FZaDK7r5lqMEKWQ4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoI1Y/rG52NjNYyEkPmCFB8I89ttTkU8HZY2ZHQx6C nqR/n2mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaCNWPwAKCRBM4MiGSL8RymXiD/ 9Nu7IfBO27/+d/jz3JAb55ZAdlx23DpH2jQr+sl2eATXj2W+2v3fK++7a9rPbNnKheXMVn9jiOy0ul dO408XFgUEt811KHgsiv/X5pwouhQlQIErTkRKBanPwFUpgDZ7x099pVk6iIJxkzXw4yUZ3oo0v9oL IcRGrPV17AOo61SlIpw2o05aQAIpzqshvhfI1UMDN4wEOCBX3jUJSglG7HPsFwaz099HmPQBf1ua0W 2qF3hgmXkip6kl08MleR7xTzOEuuSOQ/UaGTaweuJ4cFfuHftRIxajvRmd+sm2QvScGB425ubSao0K OyjQHXX7jpGNqMeMIUcwi77jploBX892HSygU56o7FM/eKJIXTZhqa+pHuM0iwhA/PfdJhCkL6h6Jm QLtuGRX6ClW4+OzZmzv3dxiWQqJfO2pbMM7/PhX/d2dbFW4keFS9OVXjL4QUsD6SSO/oX+XTdlfwyk mBDD5pUI1RFTF+8YDjFPhvU6l0ktAod8tPYhFTz4/b/jSLlm6U+hgEBR7lp67XPWmpbSV4y6zV4kBq 8jOSwaJBq+BhGAPo+1pw2ZAIAS0sTCSfxUP/oJ78yKtewlcAN5PXXurT7KLB1BpatBPgqb3ngqjY5d T5itNK9dz9f5ZZRaJoImNkVmu9y4a/+ekXdk316EWCqt8wgXvdnENHQdk8hQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Instead of hardcoding the list of kfuncs that need prog->aux passed to
them with a combination of fixup_kfunc_call adjustment + __ign suffix,
combine both in __prog suffix, which ignores the argument passed in, and
fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
passed into them without having to touch the verifier.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v2 -> v3
v2: https://lore.kernel.org/bpf/20250513025747.1519365-1-memxor@gmail.com/

 * Move fields in meta and insn_aux to occupy holes. (Eduard)
 * Fix typo in comment. (Eduard)
 * Add documentation. (Eduard)

v1 -> v2
v1: https://lore.kernel.org/bpf/20250512210246.3741193-1-memxor@gmail.com

 * Change __aux tag to __prog. (Alexei)
---
 Documentation/bpf/kfuncs.rst | 17 +++++++++++++++++
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/helpers.c         |  4 ++--
 kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index a8f5782bd833..ae468b781d31 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -160,6 +160,23 @@ Or::
                 ...
         }

+2.2.6 __prog Annotation
+---------------------------
+This annotation is used to indicate that the argument needs to be fixed up to
+the bpf_prog_aux of the caller BPF program. Any value passed into this argument
+is ignored, and rewritten by the verifier.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+                                                 int (callback_fn)(void *map, int *key, void *value),
+                                                 unsigned int flags,
+                                                 void *aux__prog)
+         {
+                struct bpf_prog_aux *aux = aux__prog;
+                ...
+         }
+
 .. _BPF_kfunc_nodef:

 2.3 Using an existing kernel function
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9734544b6957..cedd66867ecf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -591,6 +591,7 @@ struct bpf_insn_aux_data {
 	 * bpf_fastcall pattern.
 	 */
 	u8 fastcall_spills_num:3;
+	u8 arg_prog:4;

 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fed53da75025..43cbf439b9fb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 int (callback_fn)(void *map, int *key, void *value),
 					 unsigned int flags,
-					 void *aux__ign)
+					 void *aux__prog)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__prog;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;

 	if (flags)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..f6d3655b3a7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -322,6 +322,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct btf *arg_btf;
 	u32 arg_btf_id;
 	bool arg_owning_ref;
+	bool arg_prog;

 	struct {
 		struct btf_field *field;
@@ -11897,6 +11898,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }

+static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__prog");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -12938,6 +12944,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;

+		if (is_kfunc_arg_prog(btf, &args[i])) {
+			/* Used to reject repeated use of __prog. */
+			if (meta->arg_prog) {
+				verbose(env, "Only 1 prog->aux argument supported per-kfunc\n");
+				return -EFAULT;
+			}
+			meta->arg_prog = true;
+			cur_aux(env)->arg_prog = regno;
+			continue;
+		}
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "R%d is not a scalar\n", regno);
@@ -21517,13 +21534,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
-	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
+	}

-		insn_buf[0] = ld_addrs[0];
-		insn_buf[1] = ld_addrs[1];
-		insn_buf[2] = *insn;
-		*cnt = 3;
+	if (env->insn_aux_data[insn_idx].arg_prog) {
+		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
+		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
+		int idx = *cnt;
+
+		insn_buf[idx++] = ld_addrs[0];
+		insn_buf[idx++] = ld_addrs[1];
+		insn_buf[idx++] = *insn;
+		*cnt = idx;
 	}
 	return 0;
 }
--
2.47.1


