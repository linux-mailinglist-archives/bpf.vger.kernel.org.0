Return-Path: <bpf+bounces-55190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDBAA7988B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8754D1895BF6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981B1F585B;
	Wed,  2 Apr 2025 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ppAEBHcw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7A1F4C8F
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635426; cv=none; b=apJsBZSlgsaQmr1t0tp22LQGWTJ/20p/KEGsxKAEH//ExYZIFnr7GRRa73EPQjmjRO69CfLbxrGevTc5QjuXW+0E4GgDhvh1pjaDQ5s83JhRKv8VD8c65SKfxU+mSyIOBtIUudR1XHxJHD/bWe8IyVdgPH6r3KPybTmvQ6wBXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635426; c=relaxed/simple;
	bh=50Z2yDR6KF+f2MTKC+x7xCZQh/1SfIY3Au1Mpel5v8I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTsdLl+lU1xWr15jUKx3eADxRw/Jr2/CILlbp+p250WoRu/uvsnGpFUKcu2GxZ/0oektSt3uh5UwLEtNDHqA4KOJyI8LALYld26RDQkbPKHDistzID6JYf5hLZTj99La8CYzrH/0yFIM6Lmj+PDARR1W6bfsTp7s7Ct+TsrCP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ppAEBHcw reason="signature verification failed"; arc=none smtp.client-ip=95.215.58.178; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c277331eso577805b3a.1
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 16:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743635424; x=1744240224;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:dkim-signature:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTvf69xZVqywcDHwAK1eBb6GZKnmWx3ondXneizH4aM=;
        b=PZE8fuI/CcUYj/gQcNi6T2WCLINK8v9C3eek4WKHa0b8e88c+wCLfqDtgJKKbZo8rX
         o7bTKtBdhUD5nVl30zCMy1maemUhbEHKWK1dyQXYuh6GGKE0fUephvtIzextuYFD9Gar
         TL0UxRtOJYrlCt3uoYfp/GRws9yGYEey0uhOXU+o+O/bwV+PtmSM42Yw4Jc52ak3n6WO
         xmXHmJnrlm9sdjwY954wMCjHGKwzcwciqZPwLcsrt0tsFdSunqucmEPvl89PtL/66M+I
         bDAf2GrlRAlbVpeUlyAj6zM8tVJI33pnyWgQcePHWY8i1HSizlRjn3BKp7J69jYfwaaQ
         ljHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+MJbznJBmJ3UdWTKl9KB3JXRlVoaE9yJIRMh8Pyt4kWQ0h6kox10A5W13eNB2GxguKlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3TgYgNKuVS3NlJxNlSlNbXzPchgoq9Fm8G4GirCbHRjBG7UA
	VHLEF8rElRhGZrK1e2yPTKob2v9J7rYGJ5OoPlGUmu8bzwh/lIBmtx39+w==
X-Gm-Gg: ASbGncuqnxzGwHOWTfPQ1q2rK1DfyFA3SeB9RhGYx9LNpK0gGobWXY+f9Q81K18u93S
	l1+/QcDaLyCVkRepLebouDNMl3CY4jSGQu4fYY1DFo3D9SRlbJciF9sUoLwsz/Rtg4ApHqF1qhV
	TjLn7eX/+6V2AkPNF1Gh279AGojQhd1Carkuw3/dt3MAl58CxVKcFMPpv2bqpqeLHi8uwaOZ188
	BOAYlVy/I2I2wcdj2f1VE5McRxTPoPHI2pzP2tcx/QYcFuvSMPu6YkH6fKbA25iyWnchwoz7sPl
	08jFCldsT3z27PE61qcb2m3AN0MMqN6d09A+KvDtklHUob9WUL5fMBQ=
X-Google-Smtp-Source: AGHT+IHicb4AR5zm1VWkUmqUG4Sz3aOyJ5ko6ycZJClIhLWoM5uyh754p0PxQVcbPCcdeIbb3Qi9Cw==
X-Received: by 2002:a05:6a20:6008:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-200f507f11amr1239360637.0.1743635423588;
        Wed, 02 Apr 2025 16:10:23 -0700 (PDT)
Received: from john-l-PF4NN7FK.. ([98.97.40.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41a84bsm1721a12.63.2025.04.02.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:10:22 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: fix ktls panic with sockmap
Date: Wed,  2 Apr 2025 16:10:21 -0700
Message-Id: <20250219052015.274405-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219052015.274405-1-jiayuan.chen@linux.dev>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2F14A85 for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1; t=1739942469; h=from:from:reply-to:subject:subject:date:date:message-id:message-id: to:to:cc:cc:mime-version:mime-version: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=Ng683JyK1h4LyOkLDNWozrztNxPIVIkoqqjCDrkgTXU=; b=ppAEBHcwJaxwkdYAlQZcN15UbSCuCebLNl/nOqkifuaQ+FPzp0Jd5H3+5Mos9CWY8pCqr4 X5gZSVr1rKcMMWnlWVxWkphEQreM6Kb458+dbi9PwbAjxrxNE7+rl4cAFFumEcEhYCbQ6j iSVGSm2j1bZZJV1WdRAWYC0bfm60ZHM=
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ 2172.936997] ------------[ cut here ]------------
[ 2172.936999] kernel BUG at lib/iov_iter.c:629!
......
[ 2172.944996] PKRU: 55555554
[ 2172.945155] Call Trace:
[ 2172.945299]  <TASK>
[ 2172.945428]  ? die+0x36/0x90
[ 2172.945601]  ? do_trap+0xdd/0x100
[ 2172.945795]  ? iov_iter_revert+0x178/0x180
[ 2172.946031]  ? iov_iter_revert+0x178/0x180
[ 2172.946267]  ? do_error_trap+0x7d/0x110
[ 2172.946499]  ? iov_iter_revert+0x178/0x180
[ 2172.946736]  ? exc_invalid_op+0x50/0x70
[ 2172.946961]  ? iov_iter_revert+0x178/0x180
[ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
[ 2172.947446]  ? iov_iter_revert+0x178/0x180
[ 2172.947683]  ? iov_iter_revert+0x5c/0x180
[ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
[ 2172.948206]  tls_sw_sendmsg+0x52/0x80
[ 2172.948420]  ? inet_sendmsg+0x1f/0x70
[ 2172.948634]  __sys_sendto+0x1cd/0x200
[ 2172.948848]  ? find_held_lock+0x2b/0x80
[ 2172.949072]  ? syscall_trace_enter+0x140/0x270
[ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
[ 2172.949595]  ? find_held_lock+0x2b/0x80
[ 2172.949817]  ? syscall_trace_enter+0x140/0x270
[ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
[ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
[ 2172.951036]  __x64_sys_sendto+0x24/0x30
[ 2172.951382]  do_syscall_64+0x90/0x170
......

After calling bpf_exec_tx_verdict(), the size of msg_pl->sg may increase,
e.g., when the BPF program executes bpf_msg_push_data().

If the BPF program sets cork_bytes and sg.size is smaller than cork_bytes,
it will return -ENOSPC and attempt to roll back to the non-zero copy
logic. However, during rollback, msg->msg_iter is reset, but since
msg_pl->sg.size has been increased, subsequent executions will exceed the
actual size of msg_iter.
'''
iov_iter_revert(&msg->msg_iter, msg_pl->sg.size - orig_size);
'''

The changes in this commit are based on the following considerations:

1. When cork_bytes is set, rolling back to non-zero copy logic is
pointless and can directly go to zero-copy logic.

2. We can not calculate the correct number of bytes to revert msg_iter.

Assume the original data is "abcdefgh" (8 bytes), and after 3 pushes
by the BPF program, it becomes 11-byte data: "abc?de?fgh?".
Then, we set cork_bytes to 6, which means the first 6 bytes have been
processed, and the remaining 5 bytes "?fgh?" will be cached until the
length meets the cork_bytes requirement.

However, some data in "?fgh?" is not within 'sg->msg_iter'
(but in msg_pl instead), especially the data "?" we pushed.

So it doesn't seem as simple as just reverting through an offset of
msg_iter.

3. For non-TLS sockets in tcp_bpf_sendmsg, when a "cork" situation occurs,
the user-space send() doesn't return an error, and the returned length is
the same as the input length parameter, even if some data is cached.

Additionally, I saw that the current non-zero-copy logic for handling
corking is written as:
'''
line 1177
else if (ret != -EAGAIN) {
	if (ret == -ENOSPC)
		ret = 0;
	goto send_end;
'''

So it's ok to just return 'copied' without error when a "cork" situation
occurs.

Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 914d4e1516a3..f3d7d19482da 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC)
+				else if (ctx->open_rec && ret == -ENOSPC) {
+					if (msg_pl->cork_bytes) {
+						ret = 0;
+						goto send_end;
+					}
 					goto rollback_iter;
-				else if (ret != -EAGAIN)
+				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
 			continue;
-- 
2.47.1



