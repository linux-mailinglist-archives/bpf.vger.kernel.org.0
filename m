Return-Path: <bpf+bounces-46366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D2B9E859C
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6741B1884CE0
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D014B955;
	Sun,  8 Dec 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf388TiC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D913D504;
	Sun,  8 Dec 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733667915; cv=none; b=dlRwKiAo38RT5zEW/ATmrYl3FDVAcYXf6PDmVifRWbmrkqYejxphT7ZUQqbGos9x95Vmz+RjOayxsKjU/K0C8a1TN+64PQPhaM4Zi8B7xo4nAhqIofwDjahb51BPwtEvujaF/xxap+qS0vdho0C5sR/6yhcnqmtSAijTBxxJCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733667915; c=relaxed/simple;
	bh=VOxR70wT2utwI1MwcNRvAydJDpbuxxyWDz5BNP+8548=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AodjvVj492jldpLXpdDcqGFbH2SvcFLhEFyVvyMfr9TcVWcKczgUCJc6VuoM1b1Y4mFihxI2i7F/m2hHVtdPFzekIRVmp1VH+/4qoBrLgnGtkkRVprTzrbXcKGepYcP+XM9XIB2kWXje65OFb2HvjO8FxnXTcDPQw9gqLXaA6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf388TiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC34AC4CED2;
	Sun,  8 Dec 2024 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733667913;
	bh=VOxR70wT2utwI1MwcNRvAydJDpbuxxyWDz5BNP+8548=;
	h=From:To:Cc:Subject:Date:From;
	b=lf388TiCc2m6Iaq8a1jHG4I7S4SA1Nw9ssrkVvlkl0Q1WHc/LQCkdalb7NwhsnQW3
	 l6cEau4nm+FyBJUHeoMW4b6jZlE0aMyh7p+2T/Ek8j8qvfa7Pv9GopGKJTVmCUPAj9
	 xQkbeuMIJDvsOmnG6Ng6s4q7+W5JUxel7enSe6jabILGFKVVsfH5b3voT2tIjUEjZO
	 n6GtwjoNZlVkqcaBiqGQI9XK6uH36/UessfwOXmvs91Fy6QGG0YfD1PGeqHRi9nCcN
	 bMGfXwuhlPv55ImPmJ2mUHEZy7p1DNzdudhNWeYEhBnc9wutuSKRTXidOVpOPP6KTV
	 7Q+crXefQKKgA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Sean Young <sean@mess.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf] bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog
Date: Sun,  8 Dec 2024 15:25:07 +0100
Message-ID: <20241208142507.1207698-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported [1] crash that happens for following tracing scenario:

  - create tracepoint perf event with attr.inherit=1, attach it to the
    process and set bpf program to it
  - attached process forks -> chid creates inherited event

    the new child event shares the parent's bpf program and tp_event
    (hence prog_array) which is global for tracepoint

  - exit both process and its child -> release both events
  - first perf_event_detach_bpf_prog call will release tp_event->prog_array
    and second perf_event_detach_bpf_prog will crash, because
    tp_event->prog_array is NULL

The fix makes sure the perf_event_detach_bpf_prog checks prog_array
is valid before it tries to remove the bpf program from it.

[1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad

Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 949a3870946c..745cd72377d4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2250,6 +2250,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
+	if (!old_array)
+		goto put;
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
@@ -2258,6 +2260,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+put:
 	bpf_prog_put(event->prog);
 	event->prog = NULL;
 
-- 
2.47.0


