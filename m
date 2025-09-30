Return-Path: <bpf+bounces-70055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4083BAE4A8
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 20:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BED3AAC2D
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA787238C29;
	Tue, 30 Sep 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="e4D+xKYa"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E02211499;
	Tue, 30 Sep 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256546; cv=none; b=ZE0SHVDxu2/23K8YodSiQt8d3N21eQrAfQH15kQIxkTX/RE1eN2AxvsWU+b5LVsRvz8H7XMKi4KcPxz0ywfA+SLAT5hqWDnsJu9FqGfPIeYwzqPibd+iqHCQoKhYOs6QNugmuL7OG/aTlR9qcgWs0yPqmrSK6uY+qG/9ivYTjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256546; c=relaxed/simple;
	bh=+V+RzqHTVSHWzwZql2VkU320P7hVykf40jxm+lgamc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNBrS+Ybjkm81FeWoEpRGKqcZiIrsmEReMRZMTsw59ryBGa1PM2fNRUE1yTygpGB98WPxIRnTfAyRZGJZndFfQt0maQ353gjt3al0Zv9kbWmUmdW24wtETl0Z4LtXcN/h0XDK1hh89zSWhnw4aSaIIu/siiWDV5taj4AsUDJ10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=e4D+xKYa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cbmcQ3NrYz9ty1;
	Tue, 30 Sep 2025 20:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759256534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsIAQsUWXW/abWKM0AdhZQuMsTYSb9DGGhwXEon9Kys=;
	b=e4D+xKYacgca7yRC4+baMCLEP9JFksX5bINk0w1rZEYr5fJidLlw07CvlF23JgZpNPbPDP
	s90zXK60JWLdHp64ieLgAha4kTvd7sCgDifGGTUiplKwlIUkiBm9fOYCk9AZSAd3SUysbu
	hxQUizEH5uHdUJQiumozsCSkO07w7po1XZm9vdMxJjjAcs/LrhDn0+XJIeZZ2r9j64Se4T
	ZsFHGYxJ50oU/zbGAd9a173mf5//M+enpuxPqGdfxWe8OXlGnh23oArlKiLyL2EiLuqzOG
	06C6+9TtA+4sQQ587Q5onuPRXU5sa4hsYXrZj50t8jTMXogWGB8mwHfld8cdkw==
Date: Tue, 30 Sep 2025 23:51:56 +0530
From: Brahmajit Das <listout@listout.xyz>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Message-ID: <vgtxqzgqxtyfd3pzfngq4l43eeocpputr5syqstbnw2yibl6bv@3yep75dnifgp>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
 <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
 <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>
 <5fjhzkvgvbpcm2vvqlxhgcobbkiwvo36aalj5lbqrfbznbpynf@jzokg4ba2mwp>
 <14a30aa593f8d8c018bf54439261a8f05182aa87.camel@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a30aa593f8d8c018bf54439261a8f05182aa87.camel@linux.dev>

On 26.09.2025 18:36, KaFai Wan wrote:
> On Fri, 2025-09-26 at 06:34 +0530, Brahmajit Das wrote:
> > On 25.09.2025 23:31, KaFai Wan wrote:
> > > On Wed, 2025-09-24 at 23:58 +0530, Brahmajit Das wrote:
> > > > On 25.09.2025 01:38, KaFai Wan wrote:
> > > > > On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > > > > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > > > > On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das
> > > > > > > <listout@listout.xyz>
> > > > > > > wrote:
> > > > > > > > 
> > > > > > > > Syzkaller reported a general protection fault due to a
> > > > > > > > NULL
> > > > > > > > pointer
> > > > > > > > dereference in print_reg_state() when accessing reg-
> > > > > > > > >map_ptr
> > > > > > > > without
> > > > > > > > checking if it is NULL.
> > > > > > > > 
...snip...
> 
> You should add a Fixes label in the commit log and add selftest for it
> in V3. 
> Fixes label is Fixes: aced132599b3 ("bpf: Add range tracking for
> BPF_NEG")
> For selftest you may check the test in verifier_value_illegal_alu.c and
> other files.  
> 
> The code in your next post would change the behavior of BPF_NEG and 
> BPF_END, you can run the selftest to check that.
> 

KaFai, I'm quite new to kernel development. I'm been trying to write a
selftest for this unfortunately been having a hard time. I would really
appreciate some help. For now I tried to create on from the initial test
you used to verify this bug i.e. r0 -= r0.

I have tried testing my changes via sending a pull request on the
kernel-patches/bpf repository, but seems like it's failing.
My pull request: https://github.com/kernel-patches/bpf/pull/9900

-- 
Regards,
listout

