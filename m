Return-Path: <bpf+bounces-74412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91CC57CE0
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B64E535744B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849F2367B8;
	Thu, 13 Nov 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="LhR575J6"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1311218AAD;
	Thu, 13 Nov 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041778; cv=none; b=B+X16j4wrpo4CMCZ/ZDizDbTQE7cwjBwiDXx/Qz7DYWdV58LvXWPHwxvMzXaA1lzpdanqk5kEG0UTPiVbIcKJKcLQNy/WgAdwdHiZf6e/pTaL/zAVOo5HYUZLCE9ngnPh2NzAuBXjT2lMSgeesQJjHwhBm/785po3EJ60VpAAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041778; c=relaxed/simple;
	bh=Hk/nrPG9g247m1esdk0TNhUIdkf8CjIcgRtT6PiHSMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+PxryUsihmFygGs2pATl7oV9UXalX+07Y1Oq++3mJPL4DTbIlf51CM23CypfHG3K81xdpNtMpEO1UEkB2jVwbaVXU3ZHvzzsFcBO1Swhidlot/KKO274LxsWLD0a2wj1hUR7nv77XEAz83Md/L7U0dB9JUoVN4KqZVq0ga9osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=LhR575J6; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6hTQ12bTz9tjW;
	Thu, 13 Nov 2025 14:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1763041770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZaGC6alm5aGf5z0pYZqJYHl8zmBaT4Tdqot/zKeVAI=;
	b=LhR575J6K8bVKgVxGov/j7pRJRj6XkHWpsbEc/sibmcRmZIKZNzgf4S6E0J4aI70/44MaW
	Eu4usgSU9Ia889Xg5bawh3gOiLKXGWcqdIyQ4SyN4S0yVSQU4WaQ0EHSR8ztVvQKs6sNyA
	wYAe1FC6vNznka/DrCwkp2GQcRFMGTVAQmPrn6sP9ntiNksPbQ1m8aTyFxP/iRugctEeWd
	lJzY2bKIVgsCfeTW7FzyZOWoFrV+fQC7dhKfcNBM24p8TjeuvGrjoxUh+wcd/IqJot8+0U
	FQq3i/d+iM7g2HB7BoMICoGachG/1UPXFCm12J2h4pSsrjStrDiD2fo0v56cTQ==
Date: Thu, 13 Nov 2025 19:19:22 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <4ym76vsa2ey6ktrwmidmiawsymtlunoy4dtnjj4lwzgal6nue3@u3wpynwgmxya>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
 <kjjn3mvfp2gf5iyeyukthgluayrkefonfmqbugrsreeeqfwde5@rxrzxrsobt54>
 <43aa4ed3-d9c0-4f60-b850-d345cb85fe41@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43aa4ed3-d9c0-4f60-b850-d345cb85fe41@arnaud-lcm.com>

On 13.11.2025 13:26, Lecomte, Arnaud wrote:
> 
> On 13/11/2025 12:49, Brahmajit Das wrote:
> > On 12.11.2025 08:40, 'Lecomte, Arnaud' via syzkaller-bugs wrote:
> > > I am a not sure this is the right solution and I am scared that by
> > > forcing this clamping, we are hiding something else.
> > > If we have a look at the code below:
...snip...
> > > might hide something else. I would like to have a look at the return for
> > > each if case through gdb. |
> > Hi Arnaud,
> > So I've been debugging this the reproducer always takes the else branch
> > so trace holds whatever get_perf_callchain returns; in this situation.
> > 
> > I mostly found it to be a value around 4.
> > 
> > In some case the value would exceed to something 27 or 44, just after
> > the code block
> > 
> > 	if (unlikely(!trace) || trace->nr < skip) {
> > 		if (may_fault)
> > 			rcu_read_unlock();
> > 		goto err_fault;
> > 	}
> > 
> > So I'm assuming there's some race condition that might be going on
> > somewhere.
> Which value ? trace->nr ?

Yep, trace->nr

> > I'm still debugging bug I'm open to ideas and definitely I could be
> > wrong here, please feel free to correct/point out.
> 
> I should be able to have a look tomorrow evening as I am currently a bit
> overloaded
> with my work.

Awesome, thank you. I'll try to dig around a bit more meanwhile.

-- 
Regards,
listout

