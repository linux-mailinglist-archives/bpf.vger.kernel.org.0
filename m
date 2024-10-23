Return-Path: <bpf+bounces-42885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6549AC741
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BDDB24DD1
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C319AD97;
	Wed, 23 Oct 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MES1Hn9G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC16158A33;
	Wed, 23 Oct 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677699; cv=none; b=Kvr2DOYKoz4Z1nUY/L72t4lMue1UddZ29V1kTjMhkDoE4I28eVwakfo6HPYN60XfsMInbWQiZOZp2+pt03t2KaBcmzdcQBcHmsCgJfXvse+0Jv2GT8tHsG/w5XfcnRLv/GieCLELHNDp21w3Ft8PbPsCIoJ5vxhW7GktQctNoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677699; c=relaxed/simple;
	bh=h/oyxIDvVzPzjLipe711o5wG2T0uCbbxdKu5d6vkWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAmHwSP2bQRHyZXIrH8k+WvWylY55G7aGxtkkPwpR+zfZdCaQ4rL7fD8ooFeptmGomboCoJZa+Cy7qVBea5tEkPA8/02ku9hxMi7n20qbssE+ezne2xuAyO4t/+d+jB5oUYMaRUp6zg0x6fpyLuQ711i1OxRR0xnf6ZPIdZ70AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MES1Hn9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF4C4CEC6;
	Wed, 23 Oct 2024 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729677698;
	bh=h/oyxIDvVzPzjLipe711o5wG2T0uCbbxdKu5d6vkWxM=;
	h=From:To:Cc:Subject:Date:From;
	b=MES1Hn9G5ikIFgZ8V6H5a5yxzsAhxdNemqfy67ozsIeQd8vBFI+SU8A385UFkAyGJ
	 rfojsUp6XyXm5rSk2rW0XHD3CV3gdCaZbu0+wtSnlVXl3ssJ1y4ksSQcnVcwqj7s+Q
	 3cDudo/PZV+Q99GttTChfcbuIlH5Zy6QEmerd+zLi6/jeD3R/sHpvkb/WPUjdDFcCZ
	 I/Kb5pIuuXLdM4/QXo/1mzf/MX5p3cd4lsf+Ao6brBt1tPsbPJ9RADmChWdNxn4V6n
	 H7CkgtnmMd8YOp++887kKK1JH+1deEb9xBgPXMOX7GaQvSimKv2J7n76Lp1wSAuJzz
	 Nyuyl3B1QyBDw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sean Young <sean@mess.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
Date: Wed, 23 Oct 2024 12:01:31 +0200
Message-ID: <20241023100131.3400274-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peter reported that perf_event_detach_bpf_prog might skip to release
the bpf program for -ENOENT error from bpf_prog_array_copy.

This can't happen because bpf program is stored in perf event and is
detached and released only when perf event is freed.

Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
make sure the bpf program is released in any case.

Cc: Sean Young <sean@mess.org>
Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 95b6b3b16bac..2c064ba7b0bd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
-	if (ret == -ENOENT)
-		goto unlock;
+	if (WARN_ON_ONCE(ret == -ENOENT))
+		goto put;
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
@@ -2225,6 +2225,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+put:
 	bpf_prog_put(event->prog);
 	event->prog = NULL;
 
-- 
2.46.2


