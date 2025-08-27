Return-Path: <bpf+bounces-66702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB933B38A37
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7C524E15AD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458B2EBB9E;
	Wed, 27 Aug 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5dCtIWW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F01FFC49;
	Wed, 27 Aug 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323193; cv=none; b=XIQJBf4fKQbjq2H3iagEyLGbkzzp83kRwXpc3ehK39WIHVAMIhs9dgWNTIDOM8ZFf2W7pWbwUsvppKrEmySNe1TjWfeDiJ2OvBNO+I6ETiFdQWW0RvUpmSWTwHaTHxZXouwnXrfiQ304E5UsAu4RUBL1lKKwJ3oub+UhW90V4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323193; c=relaxed/simple;
	bh=6DsncMSZiTkWh+WqTScsQ/jva3tXctOU6zWlU2hsJT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiATRxvrRcEBCKdK+4XmeU+g5XrmVuCBingc3k3H1dOHw3zn9TETqpVeYKgFnPDTpAFaCkrjiwfw2WtW8ixhSjGFJLwNdOhlbURzkYwLm2nPVhXKvR+xejbcM70WzM0XrAfWG8PmJuNpmbWd5n6D/DAFEN6YRxDJOYyB6ohtgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5dCtIWW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso113087f8f.0;
        Wed, 27 Aug 2025 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756323190; x=1756927990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdOgLzLVEVxOyIO4zHuw9whMYOKbeYIspVzB3OvBoVY=;
        b=G5dCtIWWj7Fcmz3wq3pQ7+5fIeR4keyULCVPqNGATzDjHCgkRGMMxsu8uRaNsrUhtk
         6aIiMBdgp5po96m4XPR5KDBmhJEz95rH1iU8PqxNUuL4Dy3Fo4XdNvjDePWFD5y6jORa
         HiQiJvFMcrDT6kKSyRRMqfB4bDGXYuXcliiiYabH9pt1WeOqIupu70pWkjXVC59/Z7/H
         LupqRdZdrgQJmFm53ZHkH9AvcZfKoPvWSPfsnr/FJvAJKK9Klz6tVW/aG3tbqq1f21EU
         bELAAOfRxcTNp0KQJ85J2s7UusxxDZcdey/WB4TiG0MZ4ULH5Mnv2ULQUuRl3oIcfvQY
         nElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323190; x=1756927990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdOgLzLVEVxOyIO4zHuw9whMYOKbeYIspVzB3OvBoVY=;
        b=XOnF3zNZfkXaqHmbZgCfmDCozhjSc0T867sZW1pqOGvRv+YRFtH/7heJHPyy8ycDy2
         nPNrXOpeBgDNHeAdS1cFUKXaOLa3INHhLxZzdw23Gc98B0QhU5S972YsNxndvz6VPsUd
         Hlp3XkCOPe/T0qXwkr5VqEmwpy9vpmR8qzPBFnO9vPD3AXDNbL28hRf/BM6Q52aRIJr9
         vub7NSIqPTLLliRSkSXSWzLXvWUkbXlLYsOqbn+z2lbDnQHt+ctOsjwj7sHT7w+6SnQ9
         6pfly8qQHCcf6oUhm8GcJ93rcKHZYyd0mRlp22XjNGFqAvJPbB/f5mOhl7mlfoIKm6Qd
         uoIA==
X-Forwarded-Encrypted: i=1; AJvYcCUTz5+wGywIRLcnoBY87xg0ds7SHWUF/55N7SrqsHB3+LuBZyecwyRVFwJ5CHf2j3dYz4Dtr1KkWmjn23yy@vger.kernel.org, AJvYcCUes4twjADf2SZwbTEW4mUljHfNKjAt1OCsYOQsXy727wfWphFE44KPoO6wLkXupZJ9uHME1Mmst4Q8e/aicjFJz3cB@vger.kernel.org, AJvYcCWy1LFUILa2XCh8zcSt08lV/0V4qxGAoxhFroW3cqyDE3tHn9E5D8IOB6NNaQjaOfejmdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89NzPy5xvvM9IVBDjKFsQXH43S/fLuyqSeEIjwpRViEEassZl
	RqiJwkdzJcKw3EAyGEQj9mT3CrPs6NU4q6G55uX4gbW8NLvuFQXI5AjU
X-Gm-Gg: ASbGncu9TL780FbSs959Pc+Boue3Ee5mEXvx8G6S9QQIOYI+jTCBxzOm1Ok1R3N+aZP
	ePirDGdWTNmmTQk9Rv3KbB2W04p41iCmdMcS1NZDxjl1kyd0A6HuRu9WXH45SmXl0cgNPgZ0A6m
	03T/n1EKE28Lnz+jVJl8hiU9AWpArpQRTV2hozZKCZ08ulIWKbw5CifKzjjszMOAM28HS82ZzNs
	zqwQfF4e2zTo2bK3IBe3EXb8aHXwoLnQJkKqwt/MxGYSJBGVAQuq7tlGWjXClOt+3LhOpq17yEQ
	njudwRbj/h+3EQtRQuVVc+wW11Pd8CZinEEwJCkLIJ6jRKcboNWR52X9zmAyAYGJLJZ2WeYwZnF
	H/NyEdfgKpzeUA+xh95iscrLTSA2BDLB0DC4751IJdOTLZhw4ZRzGACdLMMmoGFZB
X-Google-Smtp-Source: AGHT+IEK5LWBaRos0+vMfAdVULQES0PvVLHuzOtINzlrIxc6TjYzZirBRoCKNDPkDAGR5+jNWYX5jg==
X-Received: by 2002:a5d:4d0a:0:b0:3cc:32f0:daf8 with SMTP id ffacd0b85a97d-3cc32f0db80mr3198374f8f.36.1756323189965;
        Wed, 27 Aug 2025 12:33:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm23595649f8f.9.2025.08.27.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:33:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 20:32:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, oleg@redhat.com, andrii@kernel.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org,
 eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com,
 rostedt@goodmis.org, alan.maguire@oracle.com, David.Laight@aculab.com,
 thomas@t-8ch.de, mingo@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
Message-ID: <20250827203240.664a030c@pumpkin>
In-Reply-To: <20250826081840.GD3245006@noisy.programming.kicks-ass.net>
References: <20250821122822.671515652@infradead.org>
	<20250821123656.823296198@infradead.org>
	<20250826065158.1b7ad5fc@pumpkin>
	<20250826081840.GD3245006@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 10:18:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 26, 2025 at 06:51:58AM +0100, David Laight wrote:
> 
> > > @@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
> > >  	     unsigned long vaddr)
> > >  {
> > >  	if (should_optimize(auprobe)) {
> > > -		bool optimized = false;
> > > -		int err;
> > > -
> > >  		/*
> > >  		 * We could race with another thread that already optimized the probe,
> > >  		 * so let's not overwrite it with int3 again in this case.
> > >  		 */
> > > -		err = is_optimized(vma->vm_mm, vaddr, &optimized);
> > > -		if (err)
> > > -			return err;
> > > -		if (optimized)
> > > +		int ret = is_optimized(vma->vm_mm, vaddr);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		if (ret)
> > >  			return 0;  
> > 
> > Looks like you should swap over 0 and 1.
> > That would then be: if (ret <= 0) return ret;  
> 
> I considered that, but that was actually more confusing. Yes the return
> check is neat, but urgh.
> 
> The tri-state return is: 
> 
> <0 -- error
>  0 -- false
>  1 -- true
> 
> and that is converted to the 'normal' convention:
> 
> <0 -- error
>  0 -- success
> 
> 
> Making that intermediate:
> 
> <0 -- error
>  0 -- true
>  1 -- false
> 
> is just asking for trouble later.

I'm sure the function name could be changed to make it all work :-)

	David



