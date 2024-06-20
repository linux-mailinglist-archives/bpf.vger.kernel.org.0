Return-Path: <bpf+bounces-32633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6784C911238
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B711F22757
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3271B9ACD;
	Thu, 20 Jun 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDbWaC9T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F21B9AC3;
	Thu, 20 Jun 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912123; cv=none; b=Q0yC1dvZ/M9tlGk47exczIG9kZfFxppjaB32RCqXj5YTkyg3ebYHfkDwXpyX2EUaZtocs98xAlT/gTOmQCpEcqZZZmgWFQwa14LebfdfKy2kF9wCTLnP2K4pocTGCHuFiCNojp/dl1yrcVwfTKw8RUl9hmINvQhknA3d98hP79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912123; c=relaxed/simple;
	bh=CZ4vCQRbC/D+Q0spOdedGC9PVT62zn4ZFwpwrw3zfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwCDOWCNdF/oUckR0D0MgGfsXh6ID+X03k2xgTxiFax2JoTkoCB7LvPJ+zRMxvVWy8PFSo5SVynB9psrCRjfhDFb75vXE05GAYfhDrgBf5pUAcmidOGvNUMCb4/FvBlfb8PPTA9Zfd/Xso1NSTHOz7vS3CtVV5W33Mz2ZCvfqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDbWaC9T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9e5fb4845so735315ad.0;
        Thu, 20 Jun 2024 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718912122; x=1719516922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stT07F0FmaEAp0pjqZJjlb0QXpimaL67vkyOhVBAm6s=;
        b=BDbWaC9TWYFptbk77KixoDtG0nfuVSV2wC5SM46xf8yCa1SsC8zkLaDuhVTumaeezc
         eIi+IXpHKuo5oR9i8d9OXeyJYAhK5oEKCuFZHp2mfb8+nbubyIQ6eYB+D+RIcJeZR+yg
         zb+q3NLtLtFTiq97WIiUyYzZ8abusKZ987OF0sUybBeBsn27+PAfUCDP3PSxNJ32Io23
         Gn+U4ZeD/PPxQwHGrKmO3vbgYXHxwGVY6pUpoR83d2mcQ/lnP4YXoreGpG5cHVpHEpwW
         IGvGNn+QEHcXfA0hQmJlMQedazG7l+4n+CobEW8ulahXsvPUasmEJbSC7Rgw2y0U0kS0
         MWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912122; x=1719516922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stT07F0FmaEAp0pjqZJjlb0QXpimaL67vkyOhVBAm6s=;
        b=Hj5NXOQGW/bSJgeM2865fgXFERYCAz1vYcCZX6IuZZ3S3xnkLp3TLQtDTu2aSVCZB5
         T6PRHkqSATZrRQjOEKM/YpFj67UdjTKLzmH2qFbqwsk1RoPen1MaUNNTvXoAqOkpvtIL
         Qeb/3TbiLbvOf66Wjc1xKI9tUjcok+vTDP+EaL0sU8fZ4SSnwyC/VenJ/spxlrW2f7FI
         WmbKgkpXJbTQvfoE8+D/JkcYF9uznuzWuWtVuPHzMLGD80/mVa7U2F9SvPPMMO9TOPiM
         CDtklvSFHiQ7RRs4Hh/NYuZEE4/PJ44cDMz0BgKTnVxfqeR7MJKumCjaZ9kfgzgShf0n
         sBdw==
X-Forwarded-Encrypted: i=1; AJvYcCVvEFipfZ5XANCokd7Jp4S5xSIWhcxzYYvvTQtfY/NyrfUqIZZKEqUg4001D+sVQDM6yoR0FwbhnVIHIgDW4Vmphn6z+TJcZwnyKw77pTopO40XFv6bfwl/LTfKcdZjEgtX
X-Gm-Message-State: AOJu0YzmjO0StlyXojMz5ir0XOk4udjsWSFlYr6UEbJayRvyzR5lwbg/
	JERYd0NkmJK+P1hw519Y7OeWCd974dXeNWA70t2fUkK8EZxKioD+
X-Google-Smtp-Source: AGHT+IFBaYin5Emvgr9AeDeq8MOwKNyD8wDNCHiYpFiFIsr7nV88kb7csWBIoxk9T2BoPR3Jj7VwdQ==
X-Received: by 2002:a17:902:ea12:b0:1f6:8c90:3521 with SMTP id d9443c01a7336-1f9a8d419a0mr90405615ad.8.1718912121572;
        Thu, 20 Jun 2024 12:35:21 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c2560b9csm24795615ad.224.2024.06.20.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:35:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Jun 2024 09:35:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qz0pcir.ffs@tglx>

Hello, Thomas.

On Thu, Jun 20, 2024 at 04:35:08AM +0200, Thomas Gleixner wrote:
...
> There have been voiced a lot of technical arguments, which never got
> addressed and at some point people gave up due to being ignored.

More on the in-person discussion later, but can you please point to the many
technical arguments that have been ignored? I addressed all the review
points that PeterZ raised on the first RFC patchset and responded to most of
the arguments that were raised. There haven’t been any technical feedbacks
since then. If there are things that I missed, please point them out, I'd be
happy to respond.

> When I sat there in Richmond with the sched_ext people I gave them very
> deep technical feedback especially on the way how they integrate it:
> 
>   Sprinkle hooks and callbacks all over the place until it works by some
>   definition of works.

I would characterize that part of the discussion more nebulous than deep.
You cited a really high number for where SCX is hooking into the scheduler
core and then made wide-ranging suggestions including refactoring all the
schedulers, which seemed vague and out of scope. I tried to probe and we
didn't get anywhere concrete, which is fine. It's difficult to hash out
details in such settings.

> That's perfectly fine for a PoC, but not for something which gets merged
> into the core of an OS. I clearly asked them to refactor the existing
> code so that these warts go away and everything is contained into the
> scheduler classes and at the very end sched_ext falls into place. That's
> a basic engineering principle as far as I know.
> 
> They nodded, ignored my feedback and just continued to pursue their way.

However, this is not true. During the discussion, I asked you multiple times
to review the patches and point out the parts that are problematic so that
they can be addressed and the discussion can become more concrete. You
promised you would but didn't.

This patch series has been up in one form or another for almost two years.
It took forcing the discussion in Richmond to get any responses from you and
Peter, and what we got wasn't feedback on the patches, but verbal
suggestions about SCX itself, and suggestions that X for Y would help us.
When we attempted to follow up with you afterwards, we got no responses.

Now that Linus said he would pull it, there all of a sudden are discussions
about the code. It seems likely that we wouldn't have that without Linus'
email last week. The raised issues seem resolvable and mostly stem from
trying to minimize changes to sched core. I don’t see a reason why this
would warrant yet another delay. Why can’t we work it out in tree like any
other problem?

Thanks.

-- 
tejun

