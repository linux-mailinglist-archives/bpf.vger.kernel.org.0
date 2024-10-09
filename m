Return-Path: <bpf+bounces-41490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA59976AC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D97282916
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB84C1E47D2;
	Wed,  9 Oct 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hukEGIaA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824621E22F5;
	Wed,  9 Oct 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506509; cv=none; b=DlqLtXYtC5I4YMt9T8VsWEUuaUEd4iYfpk3TAMmUL5T80qxp5bM8+70RCyFIStZRb8b7/jzV/X9iQmu9WTlik41UmpdVSPMY99YFf5yGwDkNO9xIBVTWh1C7zoZkYMMb/wrna46Ryo2NO4pP50CpJBvNX0vy+xQEHFG5YyIchZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506509; c=relaxed/simple;
	bh=w9pCLkNbrQoLg1k3mahFOF/NkFKpOA1SibfIdCm3zLI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJZh0ShCb2S+rd5zOY7v+y2Q1zB62oYr1DUq0VjYDH5plSdRb9wq22PHm/v7C7JWHgWlOEY30W1Et6SRmNqobGP624ihGmwicmJfM7S6r71geLWnkq2bSWKJiq7O9y5h4qtftOcT6yAshdrYIiro0Tt25J3wyKRrKjhnTzNh/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hukEGIaA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so168967a12.0;
        Wed, 09 Oct 2024 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728506506; x=1729111306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQF2rqqlC2ZA1LKXQ0ck6TwzR+w+uVrwQifk5iiRn24=;
        b=hukEGIaAAnjW8b4F9SAnK5MgA+UTgQf9Kj1Q3TpgLBEOrqqKLf8POZFKRdxaD5rLDt
         oLb/H4umEYUx+qGRcQXTe48nfd8EXvBnbzL+NrXKWBbygda3BF6hf0+LNwNS5f+8t9bu
         i6Hf49+yER9I+CuWnrQSCiF2tLHCOQMleqxQ9jSPg7hLhePkXvWQiRcPQfI8INs/oiJw
         VREehCUeOiTQVN+3e/0reBDmfNedogptvYwPieRwlTwfi4h4AwCK4wCARLnoH+8GokC6
         lf4y/1Jjx7pNqrZh7+SqKzXSKJBLzRSiy+aqu80TJLtlcX6RwYipEf4fEv24V0hxUfDD
         DmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506506; x=1729111306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQF2rqqlC2ZA1LKXQ0ck6TwzR+w+uVrwQifk5iiRn24=;
        b=vpiABfDtdubOtoyJuu1GJ5E8Lxrumhg9Q0RP1y+m8AnsUK79/TtGeyeyDpWiqR02p2
         vZZ+2knJrPiIqTGri9i8aINF1279OwCnvw6LE4192k5MD2PihtMgcu3VryHPdUamcGxD
         IPaUvLB7FqVJdZqPAWVAWikw2sUXszwwduLn5yowbmQrCP/ZPbBHpQNB1uFaJNMVnDCz
         VztHLIku4sJITJwirbFE+gkZCI2YZ7sFUlmdNKW61YSALt+0kFmBPxd3Gjca3QS1TuL6
         QfMbuzfVAZHBN06Yl1AM8lopdlFyG1oHMmNo1o87Qs0rR1LYgX/pBiIamHS96EXn3lgJ
         OLQg==
X-Forwarded-Encrypted: i=1; AJvYcCUwvlEl9Pkg8lOEBaZPaNdfRcYEZj7dLqaDblpDvFjPNulROG0pCK+EQInO3SK29NUzCsI=@vger.kernel.org, AJvYcCWtMAjhQaKktTj0nha4J/U1bjz96/MnztgzIS9orUnRe5zmSVMM2tYdmUhNRd16IYOztLxhewjk/SYGjuay@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GTdI/Qo79rPcVoOL/DFa2vyj8w2vvLccCkFAKmUV2XlyEA/k
	2LtX05nYiL1A6DE14wM25j2WIhBge/clvkIKkYMxZi8A9kTXZ/yi
X-Google-Smtp-Source: AGHT+IH1q9gzkNj3dyPFi/3lejnYdf8z4IfmMdtH0FmDLemybkwb7IfxVLNH3OIw80UiUO6jzzUr2w==
X-Received: by 2002:a17:907:d20:b0:a99:4ba9:c965 with SMTP id a640c23a62f3a-a998d327a84mr314305066b.44.1728506505580;
        Wed, 09 Oct 2024 13:41:45 -0700 (PDT)
Received: from krava (85-193-35-211.rib.o2.cz. [85.193.35.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99414b675esm635493966b.10.2024.10.09.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:41:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Oct 2024 22:41:42 +0200
To: Jiri Olsa <olsajiri@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <Zwbqhkd2Hneftw5F@krava>
References: <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
 <ZsRtOzhicxAhkmoN@krava>
 <20240820110507.2ba3d541@gandalf.local.home>
 <Zv11JnaQIlV8BCnB@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv11JnaQIlV8BCnB@krava>

On Wed, Oct 02, 2024 at 06:30:30PM +0200, Jiri Olsa wrote:
> On Tue, Aug 20, 2024 at 11:05:07AM -0400, Steven Rostedt wrote:
> > On Tue, 20 Aug 2024 12:17:31 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > > Could it be possible that the verifier could add to the exception table for
> > > > all accesses to tracepoint arguments? Then if there's a NULL pointer
> > > > dereference, the kernel will not crash but the exception can be sent to the
> > > > user space process instead? That is, it sends SIGSEV to the task accessing
> > > > NULL when it shouldn't.  
> > > 
> > > hm, but that would mean random process that would happened to trigger
> > > the tracepoint would segfault, right? I don't think we can do that
> > 
> > Better than a kernel crash, isn't it?  I thought the guarantee of BPF was
> > not to ever crash the kernel. Crashing user space may be bad, but not
> > always fatal, and something that can be fixed by fixng the BPF program that
> > was loaded.
> > 
> > > 
> > > it seems better to teach verifier which tracepoint arguments can be NULL
> > > and deny load of the bpf program that would not check such argument properly
> > 
> > These are not mutually exclusive. I think you want both. Adding annotation
> > is going to be a whack-a-mole game as new tracepoints will always be
> > created with new possibly NULL parameters and even old tracepoints can add
> > that too. There's nothing to stop that.
> > 
> > The exception table logic will prevent any missed checks from causing a
> > kernel crash, and your annotations will keep user space from crashing.
> > 
> > -- Steve
> 
> sorry for delay.. reviving this after plumbers and other stuff that got in a way
> 
> Steven,
> we were discussing this in plumbers and you had an idea on doing this
> automatically through objtool.. IIRC you meant tracking instructions
> that carry argument pointers for NULL checks
> 
> AFAICS we'd need to do roughly:
>   - for each tracepoint we'd need to interpret one of the functions
>     where TP_fast_assign macro gets unwinded:
>       perf_trace_##call
>       trace_custom_event_raw_event_##call
>       trace_event_raw_event_##call
>   - we can't tell at this point which argument is kernel object,
>     so we'd need to check all arguments (assuming we can get their count)
>   - store argument info (if it has null check) into some elf tables and
>     use those later in bpf verifier
>   - it's all arch specific 
> 
> on first look it seems hard and fragile (given it's arch specific)
> but I might be easily wrong with above.. do you have an idea on how
> this could work?

Hi Josh,
we'd like to have information on which of tracepoint's arguments can be NULL

Steven had an idea that objtool could help with that by doing something like
what's described above.. would you have any thoughts on that?

thanks,
jirka

