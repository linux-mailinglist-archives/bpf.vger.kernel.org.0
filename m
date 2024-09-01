Return-Path: <bpf+bounces-38680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9569675BC
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8100281EE0
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5464146A8A;
	Sun,  1 Sep 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCTjo88B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3241C73;
	Sun,  1 Sep 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182670; cv=none; b=tIe6F92t8PwjS4aXW1ACFaidxXHTKX/FAGWLgzVidjx7tlFt1X+sEHMgQUg3ABiPwX3NZRvFjYaA055bzWy0KhD5JANnZYp2mceyW01D7qFl1DL8Ad34q1RMXKgJ5cASUHQ1K8gsJPyGLe0OyFLb/W3wlFxaTj39TWp4aq6fAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182670; c=relaxed/simple;
	bh=Lk9LU3pOMDV48Trmlh6masVpUUQOtostnn/UxblbyKU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOG6vvACuqC/GKQwgyA78ma4Wu4l8oZGuUb2Px7aMK9rHh8XIEtEFNhO/e+ZXH8J6IpRv+PPyufdnvYsbl7ooEYssjWPfDEaVG5gA3FuD1bck9k8et4K4GO7/xRWivxDs2vSxzSnLNkgvV6RRafE8HZa/M3o+nKUcvbj4a1yF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCTjo88B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5353d0b7463so5554613e87.3;
        Sun, 01 Sep 2024 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725182667; x=1725787467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpMbOND7bnnUWOw6bryId5SAxEqCz+beACS9+dckXik=;
        b=LCTjo88Blo8M8+0P3y6bLXxehqJn4tzLhx3saz+5SbFhX4HOTdTyxGDTfwnkPRBUuw
         ad5sXH3FyHow+2lb0z6Hnb9G3HO04IRRVpnCoCnkIQW/5eVBu+3kiWnBEdcizDgnQ6rR
         FbOSxl+MNSMYu6vfLZtEGZ7LxPCdYmsUhhObfnwupmQuchGFvn9UCLxqyYsVsyvLkVG3
         bJBZk6f2B5ykq0jNVk1HUaTjS9WUd20GFPJ48BZyNCq70mFReE1S0Hx/6khfZkwOIctu
         BzUyCb8ZUFeG3/M8QdNAiRyY9+GfLs65PQim9B1Ewo2MLkMLqVjjVU9gSyXn2hTwkhaj
         sNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725182667; x=1725787467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpMbOND7bnnUWOw6bryId5SAxEqCz+beACS9+dckXik=;
        b=ihHd6uljwbcukYgj2hU+0ETyTAf9PcDK5sDjGyPdB3pRuU6OGEzMGB70NDk2k/o2af
         2YILZXBsafh1B25xLWJ1Gk9ALKlb7UeZks5ChfYkX2mGke1eCtkMVH0fOHaeo2Lp/ocY
         P3EtgzKFiwc78C8Ao8Oe4a1xjHs/MnDH5Ma9EOs5FyzKoa7CQHKu6RBVY0Jb/G7M1dLW
         9IF7ZARJI8IVAVaNidAd7fSvUzQGUsdpfTOdO7F0AebMi981G/9D9wgVsGtrIV40Eoys
         7979JyQVFSwB015FY2X5DMHxcpQEUO4sWOrNFWV6DqqFHpeOiW7P/mDzP8wj4rlkq92m
         CrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVxnLDxZzPNZv1zRXKH4cOKQNGmvY6IYAC57b49SzDjDGDvk+l9jkEguv8cFbb3Qlxt0TY=@vger.kernel.org, AJvYcCW/qL2oxqgupDoy5to/4aCFSKiHCtOyv6fEGUOrzk4XE9Fcg9J1Rnor47c87FRzRqKud7657OqYdjh+EFi8@vger.kernel.org, AJvYcCX+oFgSRW9lp88+Gp1SLHo3FSfqT/M67nZp5hK4uIkCpsEsLQnibNdEDT7mDLagSC3Hiq1m0in77s5/YdD01ObtIyTQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fb4OHhJU5/NSgaaXh0AkLTc2MYD6n86B69AqfNOnKgTYqxRT
	jE3op6z2QCA+d7UyNiDYABAUGQ+WVXrMzomlv2+AYEnlHi19xYB+
X-Google-Smtp-Source: AGHT+IENnlyuqzOH83+HQed+QI9kRYRv5ZXCprNMwhivq53TgR7G89sM26T8F3kYwSse0JKmtuHpBg==
X-Received: by 2002:a05:6512:3f06:b0:531:8f2f:8ae7 with SMTP id 2adb3069b0e04-53546b49f69mr6213897e87.25.1725182666067;
        Sun, 01 Sep 2024 02:24:26 -0700 (PDT)
Received: from krava (wifigw.airport-brno.cz. [88.103.205.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196876sm415398166b.110.2024.09.01.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 02:24:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 1 Sep 2024 11:24:22 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <ZtQyxn9ZpxC12eFh@krava>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240831172543.GB9683@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831172543.GB9683@redhat.com>

On Sat, Aug 31, 2024 at 07:25:44PM +0200, Oleg Nesterov wrote:
> On 08/30, Jiri Olsa wrote:
> >
> > with this change the probe will not get removed in the attached test,
> > it'll get 2 hits, without this change just 1 hit
> 
> Thanks again for pointing out the subtle change in behaviour, but could
> you add more details for me? ;)
> 
> I was going to read the test below today, but no. As I said many times
> I know nothing about bpf, I simply can't understand what this test-case
> actually do in kernel-space.
> 
> According to git grep, the only in kernel user of UPROBE_HANDLER_REMOVE
> is uprobe_perf_func(), but if it returns UPROBE_HANDLER_REMOVE then
> consumer->filter == uprobe_perf_filter() should return false?
> 
> So could you explay how/why exactly this changes affects your test-case?
> 
> 
> But perhaps it uses bpf_uprobe_multi_link_attach() and ->handler is
> uprobe_multi_link_handler() ? But uprobe_prog_run() returns zero if
> current->mm != link->task->mm.
> 
> OTOH, otherwise it returns the error code from bpf_prog_run() and this looks
> confusing to me. I have no idea what prog->bpf_func(ctx, insnsi) can return
> in this case, but note the WARN(rc & ~UPROBE_HANDLER_MASK) in handler_chain...
> 
> Hmm... looking at your test-case again,
> 
> > +SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_1")
> > +int uprobe(struct pt_regs *ctx)
> > +{
> > +	test++;
> > +	return 1;
> > +}
> 
> So may be this (compiled to ebpf) is what prog->bpf_func() actually executes?

yep, that's correct, it goes like:

  uprobe_multi_link_handler
    uprobe_prog_run
    {
      err = bpf_prog_run - runs above bpf program and returns its return
                           value (1 - UPROBE_HANDLER_REMOVE)

      return err;
    }       

> If yes, everything is clear. And this "proves" that the patch makes the current
> API less flexible, as I mentioned in my reply to Andrii.
> 
> If I got it right, I'd suggest to add a comment into this code to explain
> that we return UPROBE_HANDLER_REMOVE after the 1st hit, for git-grep.

ok, I'll add comment with that

thanks,
jirka

