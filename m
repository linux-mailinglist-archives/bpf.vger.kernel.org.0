Return-Path: <bpf+bounces-51255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5CA327A0
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805157A266C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1B20E6E0;
	Wed, 12 Feb 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EUArzt0O"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72420E315
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368452; cv=none; b=lvD+GlCsq0yx91aAPj+eg8vpd4H0SYefP7V3Nb5DHk6+n43dBFjbFcAqO1PQ1eg+1h7OU7xlEVaTldGkTKnkoJB08djHEzWTGBgphLfee1BUhOslIPu9mAQtY3cQhCTweUyn/VooQ6sY37c7z3NU11XPoWajg8DsZyxTwZmFucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368452; c=relaxed/simple;
	bh=yoI4lnbUvT2scfVznNw2j2mfZVzvokIi22NaJYFos2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vzz41I3QPpIMt7jSgMdqbIIm0VqMsUj/6Lqyp4MuQgwPp0ZbNaFFdb1DC4GAsIPAorJpvaSxvMP1kxZLT47JUMjD+zyHQsnZsOfXx0/9cTKW44ZyqqvwPTh0Q1HgWm98Lk5v4uqyAolwQ4C9580jadaO71LqHz0ZdD9Pg1E8Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EUArzt0O; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=fNV2N
	aKoOogORF4F4HYt0ZgMtd3JMYtXUzpDn3B/McI=; b=EUArzt0ODqEd1x+25sS6e
	fFTmeJGY4SHouYWzoBTcRVyppCrbDDuZVBEUEZGQEni23tnOEOkgGJf7aUS+pcnC
	w8cpZlfxpJjWy0JqZYR5k7M3o9CFrnlWfEShyDYAPx93EZEXStjCCvD/m/jpLBJw
	hu2Wn5ABC4aEV4FwSjWVIw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD37x+9p6xn5UW6Lg--.513S2;
	Wed, 12 Feb 2025 21:53:03 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v1 0/2] bpf: Fix array bounds error with may_goto and add selftest
Date: Wed, 12 Feb 2025 21:52:49 +0800
Message-ID: <20250212135251.85487-1-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD37x+9p6xn5UW6Lg--.513S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw47Xr43WFykAr4rJF4DCFg_yoW8Xr13pa
	95XrsIkr1kJr4Syr93Ca4UW3yFqrs5ta43Gw4agw1UAw15XryUAa1xta4UXFy7ZrykXa1F
	qFW7Z3sxGFyjva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwSdgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxDxp2espdUZOQAAsS

Syzbot caught an array out-of-bounds bug [1]. It turns out that when the
BPF program runs through do_misc_fixups(), it allocates an extra 8 bytes
on the call stack, which eventually causes stack_depth to exceed 512.

I was able to reproduce this issue probabilistically by enabling
CONFIG_UBSAN=y and disabling CONFIG_BPF_JIT_ALWAYS_ON with the selfttest
I provide in second patch(although it doesn't happen every time - I didn't
dig deeper into why UBSAN behaves this way).

To fix this, I came up with three possible solutions:
1. Run check_max_stack_depth() again after do_misc_fixups(), but I don't
think it's fair to make users pay for the extra stack overhead caused by
our optimization. Especially when users write assembly code that directly
allocates 512 bytes (like my selftest), it's gonna fail and leave them
confused.

2. Force JIT when using may_goto, but that's not ideal if we want may_goto
to work with both interpreters and JIT.

3. Simply extend interpreters, which seems like the most reasonable
approach to me. And if I had to choose a second best, it would be option 1.


[1] https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
---
Jiayuan Chen (2):
  bpf: Fix array bounds error with may_goto
  bpf/selftest: add selftest for may_goto

 kernel/bpf/core.c                             | 11 +++++--
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 33 +++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.47.1


