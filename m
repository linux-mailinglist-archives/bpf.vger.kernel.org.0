Return-Path: <bpf+bounces-64838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E6B17744
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEBC5862CA
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE2E256C60;
	Thu, 31 Jul 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PssxvYfD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D021D3F8;
	Thu, 31 Jul 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994413; cv=none; b=o0aYk4Nv8D2eM2ODZ9YgLOuijyLb/ba4GUup76IdqiZhZmpXPeFuSJ2okLenmeP49NXf57AQ6DFVwt/JfAWDcm4N7NBYuXpnsWOqmJzH2eGtAcSaPThjI3tzC94TYfYR34P9ARqhXCevwJxgllsorSlGyaMWsyL4ziwPbO0ygRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994413; c=relaxed/simple;
	bh=inVa1LGB4oH7vDHQdafLXK3uqBgxi40KPmhmoCIdyGk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7NU9MtwPOH9eAhmsqKfchq+e6mj05D/FrfWZSFPC2JzLJ8sgZW9uIwB8YhM5XfPkVrc4FHH3AFI0RDuLy3VzeZ2dBPHLNhKF/MphkaFhtJ40cq3KVTGBauE3/ZX0WOgZ+LSSJQ4PNm5yksX7ezhN/lP5WXH3fwHfb//Ccm4aBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PssxvYfD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af66d49daffso33435166b.1;
        Thu, 31 Jul 2025 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753994410; x=1754599210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AAkvvpbQOhTuAwe9EJHG3ghOkBXusQx1F2hWyP1fLc=;
        b=PssxvYfDdq9l2hRGv9uXkVK/TAfyK+6YPFOKy7GbGpyHsyOH44okqEIsGfxDUQM9Bu
         vVW3n1KXlLu9NWHioDNm2N6yOxrQDCXwoGkmSsHeRzsw55O7luf4gEzM04cpvaCo4zSB
         A/K3pg2jk3GzBXXQXizTe3tIYzLEJDOIg+XSu8amSV7MCzrfX+b9UN9G+aykK1lTDveg
         ap/d80qFOyzlEAPgPHnEsrWOt4vHm2KrOb57nAeDUjRp1Bi9gKNeKyMrpcDTSvL15Ers
         cK3pIN9yDWqdeEc1P2ibpJYTZ7OmhqDku3RhUqk1OL86gOKt0vlfv83u5xxFQCKLf+Po
         wpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753994410; x=1754599210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AAkvvpbQOhTuAwe9EJHG3ghOkBXusQx1F2hWyP1fLc=;
        b=NUzgyHDFqZ+itxQHtvDi6h0Bi8sPFL7ViackubyReOYvpe2w1nq/7roy6rVPhvOFOA
         2vGVRoJbNVhcdRlN4RGs4DTIAZJViTlIDd/cN4mDUgrpzYrmnA/ahtdS4HFvnOXKTqPk
         U/f/D4j0LMUKk/zpy0vltFNXxKOgIxz+Z8/NmGn8N2ktpbAJCn35p33SbBSQ/8Q/0Syl
         8wHlcr0KlPnt8xoEqVtZebAhRvOWw+iFaXfikAo61UniYjBdYhAOAQZJmBq10XvC7SaT
         UrOXYJqim1MlYJkOh5WAdnIT+3MQe3jetG/ee0qfOeATvLONt109Ves8V/nHdbD0sAmF
         tSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBcyTPMT3eseb4UXFcTkSASzCQgd8B2to4hE0IUls8rspJKXEreiHNJD83g4ypwa1EhfM=@vger.kernel.org, AJvYcCVcp5xyn5TpcjKlXj2MdlRchIk1QE8ctx22HeIaln31VHiMrZ2ebvndrBCxwIEIYpNzKjYB0WocPWwXN9vwkhsaHnux@vger.kernel.org, AJvYcCXHUL6pYaSZjPx30ZY+afcILjxC4Q1SQSeMu0dKlMVQGkXW0v0wxyY3h0ftzKtkjnM+EsImojgIYXc3nhAy@vger.kernel.org
X-Gm-Message-State: AOJu0YwxP8iP9XMsMrptuha4FbL5Fs5fyMAHsp1gvNHC4L1r/2raNkjW
	qmkUnnBV1PSjKpa5Fn2Rulf7kiGtTZoDvYF2Bt2+araWCePmQoj7Q++u
X-Gm-Gg: ASbGncuOOvkoSZ394w/JbWs5txQlf088QWefgS+uLu5ftzYi2JRnkBZDi1c3v24UuB2
	VPgwWWWi66Q6biNyBugvAw6xricXejuLT5Q8O2EM0tZ+82pTCm1UP5fmrqLJ6WbbereGZPjRvEv
	0nFNtKcyFt8F0SUzumPtpsqBMfMgxt5qfyxqqWQ+T96EQIyOyFK2W7F3x1W9hO+DDVApOkRIrHG
	E8a+4mm0wTrIOhwzgMqRsNZm6TiLttZyohwLX2gS5GTUYWHhFxErccfOjw2nCAI+ZoWfc7uq2ev
	j4sGt6RdEnoojiQiJxy8kiWeX21pR/+4kzEFoD+YagJVQiw5T6UavmBdIMjrB1A69k7FTee3IcC
	2yEiywR01fA==
X-Google-Smtp-Source: AGHT+IH35GZfVfrFy+4u5JJvJfBMXKVCGrjrhAiwGxS9sqsd6tRiJOQQ6uPYqZ73ZuJ5boDADFvL5w==
X-Received: by 2002:a17:907:3cca:b0:aec:f8bb:abeb with SMTP id a640c23a62f3a-af8fd9a5c45mr987006766b.42.1753994409970;
        Thu, 31 Jul 2025 13:40:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8359sm166233666b.89.2025.07.31.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:40:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Jul 2025 22:40:07 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Message-ID: <aIvUp_88v84Uw-lQ@krava>
References: <20250729102813.1531457-1-jolsa@kernel.org>
 <aIkLlB7Z7V--BeGi@J2N7QTR9R3.cambridge.arm.com>
 <aIn_12KHz7ikF2t1@krava>
 <20250730095641.660800b1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730095641.660800b1@gandalf.local.home>

On Wed, Jul 30, 2025 at 09:56:41AM -0400, Steven Rostedt wrote:
> On Wed, 30 Jul 2025 13:19:51 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > so it's all work on PoC stage, the idea is to be able to attach many
> > (like 20,30,40k) functions to their trampolines quickly, which at the
> > moment is slow because all the involved interfaces work with just single
> > function/tracempoline relation
> 
> Sounds like you are reinventing the ftrace mechanism itself. Which I warned
> against when I first introduced direct trampolines, which were purposely
> designed to do a few functions, not thousands. But, oh well.
> 
> 
> > Steven, please correct me if/when I'm wrong ;-)
> > 
> > IIUC in x86_64, IF there's just single ftrace_ops defined for the function,
> > it will bypass ftrace trampoline and call directly the direct trampoline
> > for the function, like:
> > 
> >    <foo>:
> >      call direct_trampoline
> >      ...
> 
> Yes.
> 
> And it will also do the same for normal ftrace functions. If you have:
> 
> struct ftrace_ops {
> 	.func = myfunc;
> };
> 
> It will create a trampoline that has:
> 
>       <tramp>
> 	...
> 	call myfunc
> 	...
> 	ret
> 
> On x86, I believe the ftrace_ops for myfunc is added to the trampoline,
> where as in arm, it's part of the function header. To modify it, it
> requires converting to the list operation (which ignores the ops
> parameter), then the ops at the function gets changed before it goes to the
> new function.
> 
> And if it is the only ops attached to a function foo, the function foo
> would have:
> 
>       <foo>
> 	call tramp
> 	...
> 
> But what's nice about this is that if you have 12 different ftrace_ops that
> each attach to a 1000 different functions, but no two ftrace_ops attach to
> the same function, they all do the above. No hash needed!
> 
> > 
> > IF there are other ftrace_ops 'users' on the same function, we execute
> > each of them like:
> > 
> >   <foo>:
> >     call ftrace_trampoline
> >       call ftrace_ops_1->func
> >       call ftrace_ops_2->func
> >       ...
> > 
> > with our direct ftrace_ops->func currently using ftrace_ops->direct_call
> > to return direct trampoline for the function:
> > 
> > 	-static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > 	-                             struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > 	-{
> > 	-       unsigned long addr = READ_ONCE(ops->direct_call);
> > 	-
> > 	-       if (!addr)
> > 	-               return;
> > 	-
> > 	-       arch_ftrace_set_direct_caller(fregs, addr);
> > 	-}
> > 
> > in the new changes it will do hash lookup (based on ip) for the direct
> > trampoline we want to execute:
> > 
> > 	+static void call_direct_funcs_hash(unsigned long ip, unsigned long pip,
> > 	+                                  struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > 	+{
> > 	+       unsigned long addr;
> > 	+
> > 	+       addr = ftrace_find_rec_direct(ip);
> > 	+       if (!addr)
> > 	+               return;
> > 	+
> > 	+       arch_ftrace_set_direct_caller(fregs, addr);
> > 	+}
> 
> I think the above will work.
> 
> > 
> > still this is the slow path for the case where multiple ftrace_ops objects use
> > same function.. for the fast path we have the direct attachment as described above
> > 
> > sorry I probably forgot/missed discussion on this, but doing the fast path like in
> > x86_64 is not an option in arm, right?
> 
> That's a question for Mark, right?

yes, thanks for the other details

jirka

