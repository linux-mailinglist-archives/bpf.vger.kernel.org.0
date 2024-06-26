Return-Path: <bpf+bounces-33142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED9917B43
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3973F1C21F49
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDD1684B4;
	Wed, 26 Jun 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aHugTBZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34851662F7
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391574; cv=none; b=qW27u+L2SQV3FxOnQjOzgtX+qJ5yXXSUFGZUgdjjeLjt5+ExdcQnAkLAfme8Y3FkNpWtNnXpOcOjYImvfa0sVBdzimH6ushL4CHlz5xE07pjyjTOq/ckOgjDQSekUXF8kPEULJL61kJ0O2a3QwN4UVwP3HLb2kOuVBpcvhb81L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391574; c=relaxed/simple;
	bh=a4k0vpYgW5Q44Zgxxl4VntJc5r2rzGgeLjih3avWkW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMohuy29ZjbPGY4fOjiPDDSVrOCcRh7EsmXQ+ZmQbzlIQj+Gnc2QO97AP/D1roAgMW3aTQIbUoes3bQdupTltkJQlX9PBX8m5898RAcIUzGkZY0Ik0cvbtGg1cmAFp1XNjkN7QCw2jQ8BJ2P7b0MZ+b01rruDbAYy0uMlvzqWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aHugTBZI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so78311511fa.1
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 01:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719391571; x=1719996371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDRFjTdMNUzEUOE9x05fu2SY9ut8HJs3+qpIaAb+KZo=;
        b=aHugTBZIVL9GF+ymdhJbq13kCQeT3TeE+IEDMSOAYxRLB7sPqAQoisz0pC8P3bHhN1
         rVG+a1Im4PBoR6wDvOHwRgFkQy8eDwD4jFnwsnTfCdz2ysfZp9EZChi1WeZGeF3Tf7qj
         n/wE/zUERf7KtPFXD3PbWU5Q24XrgV69xKI4xHquCgOnlkAWLpcsyxCXJcy+B5FRLOdx
         gzIDrxI/mketvJmQoNoqNzeFolTiX2frytpzrUihLyY1waTR5i5tCUavxSVrH/kXOXgI
         zHbcjgtTxVv9rT0YHJMWWhM+PTIqqW7n5SnBD4nBx4GZEY/vv5dOHxYhoS3sziF0Lxjf
         7bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391571; x=1719996371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDRFjTdMNUzEUOE9x05fu2SY9ut8HJs3+qpIaAb+KZo=;
        b=sLa1OhVtfRMtzp2IK50n30L8W1+Ja0EE7r8I68A+V54lKdLmsX9DcxSZGtzhpf9lwK
         akMAzCE7NzXRkPjPZsvcoMnqF+Rkeadl4TzuX/rNZNcTx59bbkOIONHv0EAkHGi9d0ID
         4YJStFFhgSk3GfNF9a15d+hrAmM3+zyknSX+yqTdwc9UKcvEiZC85dp6xEO1iEsp0gJu
         THWmDgI2uhYX697uVXEc2BSpVTUlufj/wC8LC/1dWdLbnmXEoAN+BHT/yu+VoV7dltsn
         V1e/DyKWPDghCZtJbfryyIe4AEX8aXh5VBFrUVtXzIAr/Pk3OjQz0GUQQ5+WkY86XXPY
         sALA==
X-Forwarded-Encrypted: i=1; AJvYcCVKvPrxBn3LSgbrBoPi9j6D5XzCHl8Mb5aLkBVgLNkhKE7Esu5ZlGksJboAyo1x4qbSdu/W7Tsd9cw7DfYv8BFvFqm8
X-Gm-Message-State: AOJu0YxXBkdK1u7E4TR0heBk04kQSTaY6ImBgLcWUqEMABhwp3m1Dich
	iv9WSAldYSoWmq9llX1b46ell5TkJ/6LnP5jw0LoiuFgY8yUA26qfC4SWi5sdao=
X-Google-Smtp-Source: AGHT+IHloQsSwgyR/8V2BcW+2VgGBMcenO+xh/ZmE7Aj/s5neytXluSwzLViJkSqVnLOOauGHTYTdw==
X-Received: by 2002:a2e:9b0c:0:b0:2ec:54f3:7b65 with SMTP id 38308e7fff4ca-2ec5b2f034fmr61845241fa.36.1719391570779;
        Wed, 26 Jun 2024 01:46:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7d245asm94901975ad.232.2024.06.26.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:46:10 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:45:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
Message-ID: <ZnvVQ5cs9F0b7paI@pathway.suse.cz>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
 <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
 <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>

On Wed 2024-06-26 08:52:44, Tetsuo Handa wrote:
> On 2024/06/26 4:32, Alexei Starovoitov wrote:
> >>>>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >>>>>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
> >>>>>> for fault injection calls printk() despite rq lock is already held.
> > 
> > If you want to add printk_deferred_enter() it
> > probably should be in should_fail_ex(). Not here.
> > We will not be wrapping all bpf progs this way.
> 
> should_fail_ex() is just an instance.
> Three months ago you said "bpf never calls printk()" at
> https://lkml.kernel.org/r/CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com ,
> but bpf does indirectly call printk() due to debug functionality.
> 
> We will be able to stop wrapping with printk_deferred_enter() after the printk
> rework completes ( https://lkml.kernel.org/r/ZXBCB2Gv1O-1-T6f@alley ). But we
> can't predict how long we need to wait for all console drivers to get converted.
> 
> Until the printk rework completes, it is responsibility of the caller to guard
> whatever possible printk() with rq lock already held.

Honestly, even the current printk rework does not solve the deadlock
with rq lock completely. The console_lock/console_sem will still be needed for
serialization with early consoles. It might need to be used when
printing emergency messages while there is still a boot console.

I am sure that it might be solved but I am not aware of any plan at
the moment.

I have just got a crazy idea. printk() needs to take the rq lock in
console_unlock() only when there is a waiter for the lock. The problem
might be gone if we offloaded the wakeup into an irq_work.

It is just an idea. I haven't thought much of all consequences and
scenarios. It might violate some basic locking rule and might not work.
Anyway, it would require special variant for unlocking semaphore which would
be used in console_unlock().

> If you think that only
> individual function that may call printk() (e.g. should_fail_ex()) should be
> wrapped, just saying "We will not be wrapping all bpf progs this way" does not
> help, for we need to scatter migrate_{disable,enable}() overhead as well as
> printk_deferred_{enter,exit}() to individual function despite majority of callers
> do not call e.g. should_fail_ex() with rq lock already held. Only who needs to
> call e.g. should_fail_ex() with rq lock already held should pay the cost. In this
> case, the one who should pay the cost is tracing hooks that are called with rq
> lock already held. I don't think that it is reasonable to add overhead to all
> users because tracing hooks might not be enabled or bpf program might not call
> e.g. should_fail_ex().
> 
> If you have a method that we can predict whether e.g. should_fail_ex() is called,
> you can wrap only bpf progs that call e.g. should_fail_ex(). But it is your role
> to maintain list of functions that might trigger printk(). I think that you don't
> want such burden (as well as all users don't want burden/overhead of adding
> migrate_{disable,enable}() only for the sake of bpf subsystem).

Yeah, converting printk() into printk_deferred() or using
printk_deferred_enter() around particular code paths is a whac-a-mole
game.

Best Regards,
Petr

