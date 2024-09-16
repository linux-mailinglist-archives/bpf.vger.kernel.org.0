Return-Path: <bpf+bounces-40000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B73979F22
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901441F21726
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D831534EC;
	Mon, 16 Sep 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OsXs00T4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18QLzLTo"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85314A60C;
	Mon, 16 Sep 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481987; cv=none; b=Iq8zJGaxtMyfwqXf1rBAtFTx2tImUTIZupjdhYDYK7adzJ+sUlUPjU4HKTm84SddmQM6Up+7rJBs972ph5p80Nx0axhFrX+Ttj8J5BoK/2qMb/VHJTuKwhCkKTjOmMJUxXzvgmUf9lJOcZBpId+5JM815ynYJXGYNIvasV2UXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481987; c=relaxed/simple;
	bh=xEY4iXHQyxQ5TEy5yUB0lFoOwfozOkxuoIir1tq/NwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9yvXHnO1zmD048NP71mQAgzHnrER6FoIiTHl6ggTXpAafmLr9GGKYBLKPkh8BeqDRXsi+2skfA0zgFPusP15URm/C+iXNHj9ymG/3OqjRtE7aGqJYTLlhdyB5ZX32X47T2IM1uVK+/7o70FVKBvnCKd/Xs1x9Pf0UTbNDMxv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OsXs00T4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18QLzLTo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Sep 2024 12:19:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726481984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pZy5VfM0VgVYUQhNzkZHTWn2e+O6Pz/2EXmQN0vnal4=;
	b=OsXs00T4j6uZTwh5uE8gFL9b8Tfkw1tWURw07F5Mzgy9887Pxa003jXbzAGuPMsIzWr9iC
	CHfUNC46T+kqEDHyTt0QOGzpYa3di7AsWxqHZ5ML/AEzDsiepBiZdczFTVjhWqI2YqHjQu
	708JyyZGT5HQGTggLQalBxjPpZ/vOjZFV6yP2rPpMv4IiotDsg70liisgAxxIWQbnBrBg3
	k+WviKqiP4w71YIWlscmT/uUxWiiVpCfcffvwrJs6rJAaWXgHdsS3iDGOuA3uqXSkD/seb
	K52AZlaK4EW/oBcu969XHh0mEwBRhA6+1YPouwy5W4S+DK4qM81NcgqPOXgnOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726481984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pZy5VfM0VgVYUQhNzkZHTWn2e+O6Pz/2EXmQN0vnal4=;
	b=18QLzLTofgaZcyR16Y2UDAgkAFAHIFnQS+p09RQVOmSqhFHLDbMGe95vJN6PKD9MiWLciy
	jGZM8bfK+d9KpDBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	razor@blackwall.org, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, davem@davemloft.net, eddyz87@gmail.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240916101942.ZJP2h0NM@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
 <ccd708bf-580a-3d24-e5be-4e7dc12e7b39@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccd708bf-580a-3d24-e5be-4e7dc12e7b39@iogearbox.net>

On 2024-09-12 17:03:15 [+0200], Daniel Borkmann wrote:
> 
> Oh well, quite annoying that we need this context now everywhere also outside of XDP :(
> Sebastian, do you see any way where this could be noop for !PREEMPT_RT?

This isn't related to XDP but to the redirect part of BPF which is (or
was) using per-CPU variables.
I don't know how much pain it causes here for you and how much of this
is actually helping and not making anything worse:
- If netkit::active is likely to be NULL you could limit assigning the
  context only if it != NULL

- If you can ensure (via verifier) that netkit_run() won't access the
  redirect helper (such as bpf_redirect()) and won't return
  NETKIT_REDIRECT (as a consequence) then the assignment could be
  avoided in this case.

Sebastian

