Return-Path: <bpf+bounces-58053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E8AB45E9
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125087A7C9B
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B9257AF9;
	Mon, 12 May 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNrHlj+P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A964171CD
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083776; cv=none; b=ielKKDeSwDVr3K9YoQtcB3lAjcC9sFWTpgortn84DphEz+SJ3X8K6rvJZ/sur4MTvnvwFiwC1A+bdeLAeHc8IGk3twY1oJ++iOiy7nxz6Cvy5QnzAl4bxEdxwn1ctX+BXNwoJVUPG8Sk85Ve7E+0Pgo5TvRoF/wIjTrW82H+Mto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083776; c=relaxed/simple;
	bh=fL/wUhI5itB7skT6UN9HZoGSxvXq6OwGAvU8bK0KZXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTlb+hTIjA50DF6oufLkLmuFEDRwY6RjFhiaBQuIzLCFeDUcCS0cMBzVRfY0fRjmX2lZnKOPd0joC7Qbkr11dF66nSUp07ZaigmH1jWxJ6nRTfDCEhHK0ht4QI6fdSZFE9zwrLSL9F9BeLHDhiVRLHDOOAZSZmjr1r24mbvmZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNrHlj+P; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43edb40f357so33765055e9.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083771; x=1747688571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZIUBidB/FGuTFtLNlYj6FDVDNjgBOxdp+z2lKaxFfc=;
        b=cNrHlj+PNwPJiXFw+sappZhg0OkWpGM8LStZGIjepBO/gEIxmZ+GiDq9ENYXOUtw3l
         c0JfWUsFFnw3opxIdHZMo0Loar84arT8AZuCicdkkPFX2buTpytOfuwKf+JXqv1lKZmP
         GcPdbINAbcNSYzVqr1y+bL8cT36q+enMXus/kj8+w1qQpVeL8oAE5m5HOGH+qESm7IRL
         piUGFKMxZAwo2onb2/REY72W8EPYlNzDv+4e/DIUri/k03W7h7IQXjaoI2yHOoebqEUt
         o8LvKKlWkO9dI6MFMEYIk030XuISSo44SmZ36wZDQOIWaj6At6CUPWuYbDgF+0f35BiN
         wmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083771; x=1747688571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZIUBidB/FGuTFtLNlYj6FDVDNjgBOxdp+z2lKaxFfc=;
        b=SX1V66dlMLVZyyEEwJUFZVIxgXIXGRwTeHuVRX5OUbSNTtzbuthxdJUxyWV4urL6lh
         L5xnn5SI7dHguPn2zIi1ZOiHZ7EHFVxp/fChnrYjkQABuekvh9RLFACvVRz8SnG6rmpY
         kP24YVvkUQzY1UASSs246AxnvPLi2EYC2GM31JlA4Nz43rmFdW8cpg7hHhW+kjb/UTRM
         x+g1jsEjOWnFyXC5PEEHq4wxk8GiamIqRBNIv83aQfaZx/S2SLX166Ds/k2MWXWCFVoV
         aSoEjhmletD2uLbZ5DsSCZrgH2jBU7ZxUSDmFE1UhS3H7xUsPN1euy9kdtHJKJrufqSU
         bpBA==
X-Gm-Message-State: AOJu0YwRaHQpf9QCuBJtt1IFeX/L6tHzd677it8eOjU5miHA3vasset4
	YFdCR2UOuUnhz5G+0lf9rZ1n1HcM6c2tWafVmuuU35SVJe5bugrzTN3rQ8q/FFF3/w==
X-Gm-Gg: ASbGnctEpB89jdrANr9dKjSS03M9AfWw21qOLDWjHVliTEbLyTrZVpQxnTV1y2U8g/X
	AwGr9M6KmlrJqjiUq5VSrwY3hTMCdu+er00Rr8et06GUrKb5UJgIYggL6UGQ3AGwUhb0PRIC8wr
	ntYwk6F0dmY3k6MPieJORztjzRCfCISE6pqOJA2Rx1e7P1l2LQvBsilauLgnROhdsbYOhP3a6qk
	t1eEw4EDiG42NlGcC3giTn/gTSS0E/v1DmreFh3smS3auX9x3tCEy1f0j251WMXZ+WRDRInR+TY
	O7aU465no9b5nwlPKk0zsBFof0UtIpZqHBdoFEf2
X-Google-Smtp-Source: AGHT+IGu5UGKv8Qa2KMCW61eWBhrqb1yb9B6g03vjGOVIYFPK+IoTqGKnQW8Q8ab9ApVMoSYAARQpw==
X-Received: by 2002:a05:6000:401e:b0:3a0:aee0:c647 with SMTP id ffacd0b85a97d-3a1f64374e1mr11497080f8f.17.1747083770881;
        Mon, 12 May 2025 14:02:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm13767676f8f.91.2025.05.12.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 14:02:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
Date: Mon, 12 May 2025 14:02:46 -0700
Message-ID: <20250512210246.3741193-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; h=from:subject; bh=bT6H+hKp8xVhHlYDfUuvL8nBz4kCNkUKS8EgoQJHhWw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoIlvIfOeNvLQ3RtmvTvlyKlXE2RF85ZtX9C2fJCp3 of7lDiSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaCJbyAAKCRBM4MiGSL8RysNZEA Cwi/YMkUgXK6n6+KtG7LzSU3Ocqi6J/m31EylD0+bo05JIeGViRAURap0fer5e6eVDkQeIo8TFyKio GLcDY30Ua1Ba3LhJCD9bl/RxLbKkyNcXugfJ/35Npcl/TMkLUH0a43/4g2ktCUZm+j2blquejk24Z3 V3hwroFvu3fz3iU9lsY5cIyhbSZw36mMa1/UwlsA6aARxn5ho0JhUVE+LI18JYssu7bBCeL2Nn1XvU lBfm0fF5jO4chxd9ARMMYCGiMEkBp+s0mhr0+Cqx03jihfDnb8gO9Wury1HnJ5METodvsuuHQc8k55 IVctsj1TzaIABca64W59vtqnXKqf2KrtGCvuFz3jvCw/S5LvYbWmUlUjhgm01/D9Qkimc2FE0JGQCd P8Zlt2hwPFuFPwjW1iM6/ZYISM/6YQid06jzjZgkWERJ6PJ3v7RVXwjm6LHMqa8WsjB4nTEpJs4HIg w7e8k4ba1MBFxR0AiyslGosyDRdYFX86aGrOpj8nc7Ou+5z0LFJ7FAmQoWNPMxRvX6YKmrqBcZfTSH OkZ+BPbGT1cS2VR+P1gQBOE7sdGyHQMrXlECavfem+8LkW7SH1oPZYey2ztaRpkneLhoOfSwD3kXOb 5q0481vu1vYK7lRw0O7uQx/Ykkdk0+5pH5djQ+EwRuSemFjeLvjPPXnR1aVg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Instead of hardcoding the list of kfuncs that need prog->aux passed to
them with a combination of fixup_kfunc_call adjustment + __ign suffix,
combine both in __aux suffix, which ignores the argument passed in, and
fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
passed into them without having to touch the verifier.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/helpers.c         |  4 ++--
 kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9734544b6957..1d90e44a1d04 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
 	bool calls_callback;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
+	u16 arg_prog_aux;
 };

 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fed53da75025..2b6bac4bf6e3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 int (callback_fn)(void *map, int *key, void *value),
 					 unsigned int flags,
-					 void *aux__ign)
+					 void *aux__aux)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__aux;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;

 	if (flags)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..151bd18c086a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -343,6 +343,7 @@ struct bpf_kfunc_call_arg_meta {
 		int uid;
 	} map;
 	u64 mem_size;
+	u32 arg_prog_aux;
 };

 struct btf *btf_vmlinux;
@@ -11897,6 +11898,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }

+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__aux");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -12938,6 +12944,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;

+		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
+			/* Used to reject repeated use of __aux. */
+			if (meta->arg_prog_aux) {
+				verbose(env, "Only 1 prog->aux argument supported per-kfunc\n");
+				return -EFAULT;
+			}
+			meta->arg_prog_aux = regno;
+			cur_aux(env)->arg_prog_aux = regno;
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
+	if (env->insn_aux_data[insn_idx].arg_prog_aux) {
+		u32 regno = env->insn_aux_data[insn_idx].arg_prog_aux;
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


