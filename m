Return-Path: <bpf+bounces-42952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C557B9AD54B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49803B2209F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E514EC62;
	Wed, 23 Oct 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRX3uBEg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3F155C83;
	Wed, 23 Oct 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713843; cv=none; b=NfzPNaySbu3Zp1CQlkVtTqw2G9TEomZNpnuDMQRCcFrd1fWbqf/PRyI98g8V+VntH0LBc7PJ8O12rR2ves7eXI9/lOuKCHcXt4lR1fzahamZ6ZY9wGoxLveAiFPb3XWCTQKqPebQhg09KpyIFFLyDwJM6IF1mR/+BW4n9jBhPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713843; c=relaxed/simple;
	bh=3qIlraoxaCv9+Pq0JTH2dhEZcmPvyhmxrgdBLEwEqII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FoPjGkmWV11OwQQH4b992mAg2QQgmyclZUnhXHyKS5g+IrHpUD+5CTDj/llIB5GGu4w6xPZT4P964XnInqFKcXy/4UxbnBJecxzwFoJqFJKmwcLHrFl7ySNLhumfSw3wbAkrRD0smLVD2TMl9J4Xv6D0t/6/2WBKQWR0MX4mfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRX3uBEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D110CC4CEC6;
	Wed, 23 Oct 2024 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729713843;
	bh=3qIlraoxaCv9+Pq0JTH2dhEZcmPvyhmxrgdBLEwEqII=;
	h=From:To:Cc:Subject:Date:From;
	b=tRX3uBEgTx6Z+odahfHLASpSjWydva/dpdv6C6ZtGSoQ4VZVjh4yejMrg+7ddkVbf
	 gbvhjFgOxKz+UXYJbqN6uI7/LYSAvxKL5wna1D5DKCOuvGQO53sDwNgIujCx5vEfcn
	 EZBWBFIbcuWlYVRzibLc7wXY6teMnBocA+j2Puaee/yGb852k1U+BQF8EmJlKWgCzL
	 2fdo32iiuwVYqKzU5RlTrlUOkfWwOilbiOJwRg385JROXAk4kYrYMQJCaJ6B+8ZZTR
	 Nr+bzC8DeuPZcDQWbNxCBMeBOyQKLhxexGHvaKzKBnXjLoI+qcJQkxnl7bc5YqZwKP
	 EK44nvVXaMvjA==
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
Subject: [PATCHv2 bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
Date: Wed, 23 Oct 2024 22:03:52 +0200
Message-ID: <20241023200352.3488610-1-jolsa@kernel.org>
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

Let's drop the -ENOENT check and make sure the bpf program is released
in any case.

Cc: Sean Young <sean@mess.org>
Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- drop the WARN_ON_ONCE check (Andrii, Sean)

 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 95b6b3b16bac..630b763e5240 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2216,8 +2216,6 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
-	if (ret == -ENOENT)
-		goto unlock;
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
-- 
2.46.2


