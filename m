Return-Path: <bpf+bounces-32548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FB90F995
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AA1C2150C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3B15A84D;
	Wed, 19 Jun 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Eq4sBvQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF481763EE
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837789; cv=none; b=VBY92B9NES2CtRz8YlSUXLfvyQbAFGu8bAZhzxQc2Ff1cP1DI0YtopMI/j+wDJQTibEX4pP5n+oUkgMda/Axc4cxTqvNYqXA/H8cSSUt1C8x/Jlt03wDQAnVZERR0RHEqgqnXwHLfMj4MDwsogadoI1cjuOnaRkkMHbsKJTleWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837789; c=relaxed/simple;
	bh=oA+sj7Djqxbrarm7I2zjgfnb3L6txQDz+HbmFlGzGUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKNGtInzTpTg1Jivb9lU+5282mMjJ/8BIpXvrZd9qKu+C1bZeIDRxY/vRUWkXhUO9h+TFobc1MR82ptDONGiF4ZuEBJ8TirD0mm3bvLXkqZqcG31F3D2vYgpzBO21nJIVJc5w2PNsFKIcoEJFX7T97UoCNY2OHW/DyEcnjdFHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Eq4sBvQh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-363826fbcdeso236275f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718837786; x=1719442586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4ArltmimkgOuzhs9/gakjvhfS3EBeG4nlT8epF65b4=;
        b=Eq4sBvQhkKxdGuVqN58QiMUHPrwF9M5TQ87OMUPXahvrdLOSEP3iYk2jJmRykyhckH
         dNL+tb621+XZGw9MbB7gqoKm7VLNnuo/yuzWY4MsN8lFVV2IG+76dWecdbEDltuHQZcO
         klYVDPRDaGic1rDlBLOS8BP7yk3V21P3vh0vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718837786; x=1719442586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4ArltmimkgOuzhs9/gakjvhfS3EBeG4nlT8epF65b4=;
        b=WU35AZF08LG4Ft5ja+uItr2BwkZE+dY1OvXq3e6iPUT1Ps2cbD8ZZCwiC4Rz8SQa7h
         2a/IlsVex0oI3pM5ulcJLwSiHauQ8OtK3k8mxDTFF5UU4q31dgjE197Cj6iUXpW0UH2G
         fCQ2FTfBdeWsSa/QNXsNeD1YRS5oEB60VhOAgSdFORIi2pRkAzlWZbIbyzumJKRQJEu1
         UUAT/W46rSPcSmh2YDLb67NnF7NeSb2XXkATltPyERA+S3Bk69JgOw2KKZl9ONQD38tH
         txXPYggwbCLQ00s8YM0YJNVx4DWWvB9NwhX2VpBaMhE8cWsxIsIiTUjImzI1X9NBLmcT
         ClgA==
X-Forwarded-Encrypted: i=1; AJvYcCVrFb8CHxarOKE8fYg6/hMbrCAvsNMJKn8UcmiIRjYcRVFLgI24l7TWJkatvvAdammtFHh4CKjhwSjUMnz0hDYW6c3e
X-Gm-Message-State: AOJu0Yz9TViBTeXZcVaJiBvZMONwtly3yHg2ldfa9uEfAmLAle3JraPD
	S/VXdcEJPIXpF4swWmfP18OSnFx9Bc3B6J6uwsvhbmlPP+SLQn/Ug5Y5KYrr7HcENlN5EBLCtFA
	A3bS9Dg==
X-Google-Smtp-Source: AGHT+IFmkEdJVBTa74R8REbEIq8xBc9q0MZUed9YLUK0Ec/jPAHzYpmqw8mK5Tv3SUpwDynUOeDRrA==
X-Received: by 2002:a05:6000:1e81:b0:364:aafb:6019 with SMTP id ffacd0b85a97d-364aafb6085mr289706f8f.4.1718837785942;
        Wed, 19 Jun 2024 15:56:25 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd79sm711486866b.132.2024.06.19.15.56.25
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:56:25 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424720e73e0so3528325e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 15:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfKCXHPwCjuXILRXLiPwueSUHDiIy6iNy15aNfoQBHJmJOxgy6LIWa3+pNPvlZy1uUHm0Uh2O+wJnyCg0ASEXMG2b3
X-Received: by 2002:a17:906:2519:b0:a6f:5a48:7b90 with SMTP id
 a640c23a62f3a-a6fab641667mr177288966b.38.1718837763732; Wed, 19 Jun 2024
 15:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
In-Reply-To: <87bk3wpnzv.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:55:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
Message-ID: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 15:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Jun 19 2024 at 15:10, Linus Torvalds wrote:
> >
> > The thing is, I have seen absolutely _nothing_ in the last 9 months or
> > so.
>
> Right, but that applies to both sides, no?

But Thomas, this isn't a "both sides" issue.

This is a "people want to do new code and features, and the scheduler
people ARE ACTIVELY HOLDING IT UP" issue.

Yes, part of that "actively holding it up" is trying to make rules for
"you need to do this other XYZ thing to make us happy".

But no, then "not doing XYZ" does *NOT* make it some "but but other side" issue.

This, btw, is not some new thing. It's something that has been
discussed multiple times over the years at the maintainer summit for
different maintainers. When people come in and propose feature X, it's
not kosher to then say "you have to do Y first".

And yes, maybe everybody even agrees that Y would be a good thing, and
yes, wouldn't it be lovely if somebody did it. But the people who
wanted X didn't care about Y, and trying to get Y done by then gating
X is simply not ok.

Now, if there was some technical argument against X itself, that would
be one thing. But the arguments I've heard have basically fallen into
two camps: the political one ("We don't want to do X because we simply
don't want an extensible scheduler, because we want people to work on
_our_ scheduler") and the tying one ("X is ok but we want Y solved
first").

I was hoping the tying argument would get solved. I saw a couple of
half-hearted emails to that effect, and Rik at some point saying
"maybe the problems are solvable", referring to his work from a couple
of years ago, but again, nothing actually happened.

And I don't see the argument that the way to make something happen is
to continue to do nothing.

    https://www.youtube.com/watch?v=lOTyUfOHgas

Because if you are serious about making forward progress *with* the
BPF extensions, why not merge them and actually work with that as the
base?

IOW, what is the argument for _not_ merging it?

                        Linus

