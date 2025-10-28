Return-Path: <bpf+bounces-72501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA3C13628
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 08:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E193400967
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888D2C08BA;
	Tue, 28 Oct 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kiu7UYNS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TS/rXFHh"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7BF29A9C9;
	Tue, 28 Oct 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637944; cv=none; b=s2vaxRTgsMRpi18BO6DvDfu7Fkh4OFyk6oR3Zedkiecw9bMQFtI6CmfeR0z0E6QpQ/diBEMGNoeJDQQ9SG8ySsSPZcBk56ODbCjvrnNe5z7Wqec6BHGRQQBh8xH99noPwtk87kk3FTquWNpntPs9mZ1OQhPg9cfx3H0kCoHE+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637944; c=relaxed/simple;
	bh=BlH1k/7FQlfjC1lJDoXjs5d1U9toPAOhi2tez2K7Kzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9FWL0fncMj852YnkqlCVnFGCfiX9PwCt6NgJiNars2LSai1Npo/1fb4rtJ/UHsPVYR5gSuWWhIGFNFmYdan5I5/PAT+RyOca/LxL4N8SHAg6aPL0rVvQtnzWhzRVssAW0Rfa55mtifvt/HPk+IBlJZAFCtMrgJ0QzOIJnnp93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kiu7UYNS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TS/rXFHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 08:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761637940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHWV/31bypuym5GRXjxOlk2qZBuAxqMswHw50rJip1Q=;
	b=Kiu7UYNSsTpAQpdqw2sVW2UvD1GqQshrx6wqHmt3innhVdRFyZU1pVblsbB4m5qBBfDp0W
	lN8MnHStEMXA3UD13GEfJx76HHjOAb1UxoalqdxptlZOEEQzkJ5rztbNUHBIObrX9VIJiD
	mjCm4hWNWv7+NoZ92y3/aI9bgATAD3PtkwRH7kWeYeZc4hBZbh014CPC3EyeWT09bmTh5+
	+M/HUd5pqe+i5ckJVS6ZdIOMSgB0dhL7pP9Wle1TMXnBpnQ6zJBRRTwF+m0IAW9aedIu2q
	TwxjO6v9tS3EsRCk4jo73UAvCJojwIHplVF37X+5LJq4MFHFWIQ3FZDk4iZmiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761637940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHWV/31bypuym5GRXjxOlk2qZBuAxqMswHw50rJip1Q=;
	b=TS/rXFHhiwPMG/jXJvataZ1SJRJMP44uwocqxI6+TbbESv3cus8zaGjEMZdGKn/eRKY4dj
	z7oADzXFJeZWgpDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, listout@listout.xyz,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Message-ID: <20251028075218.aw9YABrW@linutronix.de>
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
 <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
 <aP5_JbddrpnDs-WN@chandna.localdomain>
 <95e1fd95-896f-4d33-956f-a0ef0e0f152c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95e1fd95-896f-4d33-956f-a0ef0e0f152c@linux.dev>

On 2025-10-27 20:45:25 [-0700], Yonghong Song wrote:
> This should work, but local lock disable interrupts which could have
> negative side effects on the system. We don't want this.
> That is the reason we have 3 nested level for bpf_bprintf_buffers.
> 
> Please try my above preempt_disalbe/enable() solution.

I meant to look into this yesterday but got distracted with other
things. I try to take a look.

Sebastian

