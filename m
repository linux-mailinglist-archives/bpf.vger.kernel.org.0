Return-Path: <bpf+bounces-30065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE378CA535
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF721F22C8D
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BD4C3D0;
	Mon, 20 May 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GklF0mL2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1241847
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248850; cv=none; b=omnrOWrcwC22tFWiYQk4pIVlJi/XyUI5QTa9YALjzs1Vu7V6gDltGroqWlV9PKfJ9mA4LQEJJLD6mjpBQFp9pZ96RGh8sh4wgKW7AYPrpjFaNKtZrI9aSvsQaxEYh9C8kdr8NsiTizHiThQfJ6Qsh+dFNNmdw1X7iooIqSOLUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248850; c=relaxed/simple;
	bh=gTRR0TNMTh1ERUgceyZvLdW7B2XjhnDlfLfVfHNirOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdhg1KEXarIZhzYb03OuqpjWEDGwnCxcnCxAL/xPsCvTfDUs0gyP5hNgHeJfAY2/lwGrmS8ITsbVVoqRhMSHgYFnyQ3mPWp57bmieNOTqvEW+tJai7VF5FUuxmJrwm8igq5+5E2ArcFOn+5A+g2lfonZRnp8bqiZOaBThETQCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GklF0mL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952C6C2BD10;
	Mon, 20 May 2024 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248849;
	bh=gTRR0TNMTh1ERUgceyZvLdW7B2XjhnDlfLfVfHNirOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GklF0mL2tGmB5ONL6s5uHYObKsqdWkUWy2HpQyt6Iy2iLgdluRwjO/yU2hXSG+pMc
	 nFpNHM63EzwUu7wJw1D49gvKyJ2N/+MDxVx3eN6Kv6T4Rws/LNgQ/VHUtBjbahrhAq
	 4RVssiUBWYb8Fz2i7Svc9Z/4gmkQsrYy/0iyRb4AwqYWU6+s4e07dzdsaO8zbyuOWx
	 Mu3KD2J8WBZBSsZNWMOXDhNY+ddG1VVPkr7k7Im083FmOhwBbw6y7sWRjEaWPAXvMS
	 bsg9ODfPyS7z7dA0UDRdVotW5unr60Zd7jGrvVO2zXQB/Gf1XC75jFzfhVnY+odoSU
	 6svf6+PibBzfQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 2/5] bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic
Date: Mon, 20 May 2024 16:47:17 -0700
Message-ID: <20240520234720.1748918-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520234720.1748918-1-andrii@kernel.org>
References: <20240520234720.1748918-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_pid_task() internally already calls rcu_read_lock() and
rcu_read_unlock(), so there is no point to do this one extra time.

This is a drive-by improvements and has no correctness implications.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1baaeb9ca205..6249dac61701 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3423,9 +3423,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	if (pid) {
-		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
-		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
 			goto error_path_put;
-- 
2.43.0


