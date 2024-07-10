Return-Path: <bpf+bounces-34401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F106C92D4CA
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17322864E3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68299192B87;
	Wed, 10 Jul 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="e0b2D8a1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57F19247B;
	Wed, 10 Jul 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624577; cv=none; b=rGxBZS8bMuGhwYdqVeDhK0zEcGjVlyz8AyT20HqL4g2bFr0yhsScjztEhAIxtBGOibv7pEl0LqHJ/BaTkp1KtUQPOxRY68YJ+gbpEts57LPLHOhOdD4yfyyhjB2I69IA28T4E0egTLQoztFJZvHF48MgAU4FcY/MLSJ0VdUXkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624577; c=relaxed/simple;
	bh=orYW0Rx/mRR7mRC86YbmqQ/XEF+I1e/zQ66SthK/9Mw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BeC3lF4Y4I/vfd/AD0MLDQMYEtIDnLKAYxzECmlUSDEIV8Gajnho428ZuNmNQAFP3I/nCZZeB3sDUbqyNn0O+k15cXx6LIZ+rMIcqvNP+qBkY1e6e5+aPC/slVniDoPhoCnLyBqrTBNgqVJ+FpBJtBudOlMG3YRiGBX+wDQzHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=e0b2D8a1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aEkO7cacsxq7W9bkSWPya+FIrxQc5cVsrMRiMFr+KPk=; b=e0b2D8a1qhHPLaqzZFy4hYS5jj
	mfOONLgg0rTQ2MlZbl9V+Ssazk/9avpT9EG5YdM6me80cdkQ9fkDGN84c5Z1Gp0ys0C5JeWBVGam7
	CuduL2ExpKyot9TdBjGW0l/lTArYFq0kHmlY0P+B5EH3sRzPiCMFHljgjCsjYgqZIlYj7pBmwbDeb
	xlL0GTzImqCp8PjwtKA9zSxPUDd6TnnoPTmx3GRpky4oFA/dWNW9VLXnkfVPLQBKmlPjaD8tKTMFC
	J85nhjbYWKaRPdQw/SWx7knTDqYZHYDCbjcdFxDgg/SbXq/ayX60bQPCzK2MQ+GXelK7jiT3uAK6Q
	XK+seVrg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRZ34-0003PM-KS; Wed, 10 Jul 2024 17:16:02 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRZ32-000A3w-2d;
	Wed, 10 Jul 2024 17:16:01 +0200
Subject: Re: [PATCH bpf-next] bpf: Remove tst_run from lwt_seg6local_prog_ops.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Mathieu Xhonneux
 <m.xhonneux@gmail.com>, David Lebrun <dlebrun@google.com>
References: <20240710141631.FbmHcQaX@linutronix.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cb5d07ac-2224-6ac7-d2b2-cdc5db918106@iogearbox.net>
Date: Wed, 10 Jul 2024 17:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240710141631.FbmHcQaX@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27332/Wed Jul 10 10:36:46 2024)

On 7/10/24 4:16 PM, Sebastian Andrzej Siewior wrote:
> The syzbot reported that the lwt_seg6 related BPF ops can be invoked
> via bpf_test_run() without without entering input_action_end_bpf()
> first.
> 
> Martin KaFai Lau said that self test for BPF_PROG_TYPE_LWT_SEG6LOCAL
> probably didn't work since it was introduced in commit 04d4b274e2a
> ("ipv6: sr: Add seg6local action End.BPF"). The reason is that the
> per-CPU variable seg6_bpf_srh_states::srh is never assigned in the self
> test case but each BPF function expects it.
> 
> Remove test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
> Fixes: d1542d4ae4df ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")

We can also add in addition for reference:

Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

