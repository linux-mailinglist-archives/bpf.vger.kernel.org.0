Return-Path: <bpf+bounces-31070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF938D6A0B
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC9D1C252F4
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1517C23B;
	Fri, 31 May 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHDMZfrS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E10745E4
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184706; cv=none; b=XjJQBDRLCfkhDfeH50016VEzvIx1uXUhYYoADcPpLBZ5jUQW44M4nWRWCtb1AIIy7LKYmx1teRJ7opC3+czT3GtZRsnPE26XnzDvH9TirwxM1q/6KuC8WAUCbSce+UvQVrhDL3F2GAG2Xhxw+mNBKqWMeUSkNrslN4yU0RFm4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184706; c=relaxed/simple;
	bh=eT0bPR01XmZQ6YhuCbW1FEmI76aTs9jEG57lNIeKwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOHQGY/GWZRlzUB44y+Dtw99xfx+JaKxWrfnr+Nyi61w9SaxNKTiT3gfRq4bwfT9gOD6M1t58m7lHl5ZOOPHgLKcPYtKZeRffHQZgih865WFbAmbflPY1cd6SGs40ImkbPMirckZlBG3Ff4N6P9zR47SELc5Rlk2Wx5/F6vKKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHDMZfrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A0C116B1;
	Fri, 31 May 2024 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184706;
	bh=eT0bPR01XmZQ6YhuCbW1FEmI76aTs9jEG57lNIeKwu8=;
	h=From:To:Cc:Subject:Date:From;
	b=XHDMZfrSmfJrjfX0SS6G/JPS9WDQBbhaCuoCaZ7y3fFiLlN+vut5pv1SUAw2sJEkc
	 bI3g0muQ/VOwHtGqWpRPf47FZlbTTF9zG3kxCF1E5tUS/zI0HlB+SdaKk9yXic1oiq
	 Ebl7/HcD2tYedFJY06LQutVtVxiSxp1RCbA3FeAVeJeQrMEKe7QlN09kw3j6oW0Xbo
	 dMyi2wgrukLUULGhCscE1cu241dSXFGSV+BZZyzQ68aoPD5+2An7bQoiD5lNLI6ST9
	 UkZ8rLmoFWjNJ3LgNdEt/HS+tjMqLRrc77vvQdY0uNbpxE80TuvHW6UsrtEeh3ejhV
	 S2ksKWEaozRmA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set list
Date: Fri, 31 May 2024 21:45:00 +0200
Message-ID: <20240531194500.2967187-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
by Sebastian [1].

To fix that we remove CONFIG_FPROBE ifdef for session kfuncs, which
is fine, because there's filter for session programs.

Then based on bpf_trace.o dependency:
  obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o

we add bpf_session_cookie BTF_ID in special_kfunc_set list dependency
on CONFIG_BPF_EVENTS.

[1] https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#m71c6d5ec71db2967288cb79acedc15cc5dbfeec5
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 5c919acef8514 ("bpf: Add support for kprobe session cookie")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c    | 4 ++++
 kernel/trace/bpf_trace.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48f3a9acdef3..36ef8e96787e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11128,7 +11128,11 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+#ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_cookie)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6249dac61701..d1daeab1bbc1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3517,7 +3517,6 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 }
 #endif /* CONFIG_UPROBES */
 
-#ifdef CONFIG_FPROBE
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void)
@@ -3566,4 +3565,3 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
-#endif
-- 
2.45.1


