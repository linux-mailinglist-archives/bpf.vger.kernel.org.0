Return-Path: <bpf+bounces-62041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A29AF091E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37C0423164
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22B1DB34C;
	Wed,  2 Jul 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Popehyhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773EAD51
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426274; cv=none; b=gMHfYfieq6X62Hlj1Q7CfRjFEge4URxlxIdeZo13Yu6Vn3wDE8x+exZDCJe5ifd95wsHB88didLKC5CR4H2ufCrMXNum5SrRumscr6oQRvWUUnsIgLrPTqfjdivvscRrMjLrK4olyaXb4zphFBmd4oauIt/2fl5E0a2vZxdeWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426274; c=relaxed/simple;
	bh=Uj1KcIcCXBIrooFXLrO/d+UGv7pxDoR8Iq0kfschCyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0o7WsmA189WOpi6OCmazHJY7UjOyJnfko1JxbGw4Ql2vlg2g1wCo1i4i7pg2kby71syXwCHG5AtxRKNQ+xuYYtiRkmkMZcvGbMIhJHhqA82yRuplcX8847N4lQrI8+8W+IxkUHLAV1MCcwwT87NnrtbD/kqLaZIXkqAhnsSFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Popehyhe; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so10698500a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426270; x=1752031070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNrm7aQjBTn5N2R0Bm6YQOm59mWuaR96yAUeb26A5og=;
        b=PopehyhexvW9W7DwllZy7/0p0t6c7Dufn5F0gLMGe5xEixbQPE6pV3KMvlinTkQGdl
         JiHjotYy1y8grSBRrvbSgWKqMx9SIrAzJynuW2R8JWbGc7dFu6+jwoZwRmdflU5CVUR4
         tds1YgIXRNuVRyGtQwJI+aFYW5iQTaEVWbzHmMSUxE6PNyhmyvOg98s4Gx0rQ9xiCzAR
         almqTUFRaT8pVhQXppRlzmshQgRJP/VcfWaYJ0g7Z0XiaK6HfaEPgiRhKzNVthatu5yJ
         nLuq2gBrauwUkWWdthxBMnMlGI+fGRwOChc2Eucnr+tmcF/ymyHL5fBTDviPzfNhkrUW
         ENTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426270; x=1752031070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNrm7aQjBTn5N2R0Bm6YQOm59mWuaR96yAUeb26A5og=;
        b=DHd6z8JwhMxZVHK7N4NI2UNS5gkD/31tV/qBv5xSe4t3twko0SuYg8jUWOw/+665Wp
         YOM4ZVvGXqwPx3Gp9ZSSf5zC68vBtRK2W8DpqZbNTou6d6ncH8/0+SZUenQOsAhxb3vt
         6fAzX3CmdOA/XJegI7cdA3WurD086UexlPKyCiVrBAZDI4aG4vpjoWja1cZqWlitm1RG
         lIdv/JPHYl9vYw0S7NbnFSKrdGnCErz2Kt0rlOSvWQgOyZc29Prpf4Lno44m44HRoZrq
         vh58yjedlVpqgdw+fRyyg2AXKSnQ2S8Rus8n5q8czl3nMy7xsEGRc+JHrzvEp1pee5K9
         jpSQ==
X-Gm-Message-State: AOJu0Yzerf8dzO+MLiCgU/DV1XMxnWxChnilB7c/UZ8gjLG3KBu3s51N
	PAuOitQd4GPmQQQB02tt7ed9hDlcRRqvzco88rdCasvvEd//jq0ZVRV9lhsn39UWd84=
X-Gm-Gg: ASbGncvMsS6ZPp61fwh9J/RZ5l49D21NBx4Gj/QU+/uFvkb/HrwZ3cimiwn2PPt/Ui/
	U+CD1DdRUd+DX/jQrr8URDG5HZxLfEkQI/FZxwnEH1sa8QKrAOXF3hJ5ZU8MQ83UHcs4ou1kbIw
	hfIqTw8gNS4SKfpIMHjJqnlar/hlNYYkyDycYqFoS4OMWM2nq/Bp7w9LlYcnSQi+/3CnxoUbhPG
	PlOdX5gXrcNkXQou1KQgbQItBSz25H2/LQII6t/dENGEgqDu6H+OXPSkVFbFMoVNmN/7+bpmmV8
	1hgHe511Zc9zNhA86WU/jJDQb+1JVSXZ+mTqIfjDpw9F3Ylv54qP
X-Google-Smtp-Source: AGHT+IEH3ncdGFKEDegRdc1OBj8P3tO0gCQHOWsBQjH589nmQtg6lEUPp3YgXp/GS1/ElAh7YSApBw==
X-Received: by 2002:a17:907:2d2a:b0:ad5:5b2e:655b with SMTP id a640c23a62f3a-ae3c2b4d9d0mr110234166b.25.1751426270097;
        Tue, 01 Jul 2025 20:17:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bd4bsm988847766b.134.2025.07.01.20.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 05/12] bpf: Add function to find program from stack trace
Date: Tue,  1 Jul 2025 20:17:30 -0700
Message-ID: <20250702031737.407548-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; h=from:subject; bh=Uj1KcIcCXBIrooFXLrO/d+UGv7pxDoR8Iq0kfschCyo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQ8QLRR2qhoHnBXWQ+vgYxm94KAdw2PQYlJfWe k9ThhzeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8Rymg7D/ 4+e8MnOc3hVHzKmM+RckRfF1oDUIQC6gr96mOIBGAWjMKOfiVBFjT2DIMGCt7tqir6nvmWhmPkjKt8 x+appI0b5AWsnAeJtd41o3LT2qV8UDoKDbo90ABeLZy2bR+izMpY0EHwaG4C3E1F/2WrYeF39AK5ke QkZuRVaKDcrUrSjI8ORA9UZMQje+ir850i3RWLZDsGbQ1w8AUeqGgaoJ2cUmK/1OuKNC4ZEvYxUXSj 83IGnCCGzR6b/3Fs54x+hnh8QCr1qnABE8XivKbW08ICF8GT9wxwQQCp+cQFt/qQ2j6+RODdMbnplu vUTZ5O9bulzRIYNQULipwfvF3SuTcu71iXTES5EU4oP+hAdRv9cXuPXK6AnsU6gcqSuvcK+0FQD4os N+yoarbojL1gonM1ir9vhGt6IjztiRjHutzRLsutN661BJz0U47iepeIIyTXYmc9oUrfdgwiO/ZMVf BQiVQ6oOYly7WPz0ErTXpf7u0gj2o+3iFaa6bbovJ3VLAqWWVQnElphAZPURSPadeFH8YAMRm4XWMC 7cVfARQlBdJYRRO/rwWlr0cZFZMcTgnxvmTrN/WKqZrmZW8+ueMMBqG2gWCt0FtW5SWPaaZSnbSJcJ uu7V3Ny3G9Obq3hzhwNj2RE2ZjO/9KgM8hw62UbvkrAmZawtfdKRepOOrg+A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation of figuring out the closest program that led to the
current point in the kernel, implement a function that scans through the
stack trace and finds out the closest BPF program when walking down the
stack trace.

Special care needs to be taken to skip over kernel and BPF subprog
frames. We basically scan until we find a BPF main prog frame. The
assumption is that if a program calls into us transitively, we'll
hit it along the way. If not, we end up returning NULL.

Contextually the function will be used in places where we know the
program may have called into us.

Due to reliance on arch_bpf_stack_walk(), this function only works on
x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
arch_bpf_stack_walk as well since we call it outside bpf_throw()
context.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 -
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..40e1b3b9634f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3845,7 +3845,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	}
 	return;
 #endif
-	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09f06b1ea62e..4d577352f3e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3662,5 +3662,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
+struct bpf_prog *bpf_prog_find_from_stack(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b4203f68cf33..ab8b3446570c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3262,4 +3262,37 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	return 0;
 }
 
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return true;
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
+
 #endif
-- 
2.47.1


