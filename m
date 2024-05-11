Return-Path: <bpf+bounces-29597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3E8C33CE
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A313D1F21694
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94352224F6;
	Sat, 11 May 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwgJIpsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69F1BC44;
	Sat, 11 May 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715461794; cv=none; b=YGbuCIs8JyLj/wEm1kRYCQWqFeQ1V0VHmaMJ/tldh3pcYB2MUdQNRS4lGtcvJIngmU5aoqQONwBoAkXHD2s4sMGvGuUPEw/gpv9e8n27mXX3KfXAFxt1GKGglX+NwaygnvqIeThkez99+CMBg35xHIMNpwp2u0YRk56LQ8C2HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715461794; c=relaxed/simple;
	bh=awyMliQSjbUNmHImBj3im/6MAmRLZaXBovw6qI33SIk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1Bjh10QIkfp+b1jG7kKHmTh1bTqedkKosxEOdP89vtuxhjAH4NIqKGoWPIiTemLpIR3NFefKZALwHyMspYKWZTB13q4HpkBzxl8+xSKdUvKBM2hqP6WAnPuWKkJm5aIEygqHhK2cGXNzgb5UxZZs3sLcjAN/nRy+HSb2SyN18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwgJIpsT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ed835f3c3cso28434355ad.3;
        Sat, 11 May 2024 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715461792; x=1716066592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhGglJZ+b8g6GXzg1Ll6IIdz99ZTq4GAj4YEaMs8Mvw=;
        b=EwgJIpsTzH4OkgLZBVo4ouzRadD8+NqZY4U4PWYqdHpx2X23MXCuQ05TBfBwF6U8gW
         LQH7Wp0GjXY4Ka28s3/nSyaNd4P8QyQannKor0vPmml+NeXNO0nY0mx60MYqMIi8eA0Z
         YSCPc2hyI+GIqSPPXSCWOcsIApyjgHw1WHgpegd6rZ1cA6aROkxBKmMTmG3NK3GUP4yh
         Y+MXxvTTeC+WTREBoi7RdCwZnxTvtjkAdtrmvZP+ZEszJq8OTjUc0AKHdA8tQhlpHa4N
         dFPTKpwo5sVqBqp4qBZdoOfv/KMyiJ8V1jXrTP20mOm6PpWGFxgYmepgLdq0XU7552+3
         XQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715461792; x=1716066592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhGglJZ+b8g6GXzg1Ll6IIdz99ZTq4GAj4YEaMs8Mvw=;
        b=BMFTKLvxEZnVlDb152oocQtcALWqGYBaVp4tluPrK4SOd+MR11S2E/t56t4cqHegA7
         4MI2c634enpvFwm8mZKJ23T59madS05IHA9RD0n7bCIbIcqpo8Oalq+u4rLEz7gNrn/H
         0F1oLpVEj/8KZ8hxFiLZOgy6RE3Q3hwYRwM0l1nAWPde8E4pbW+OUyXIVxa2+GcFCXTw
         L4Av4F1KdGRfx2NwJXkEat/PcgapRxKo+pQ3sC3GbgE3qhw9Q2lETU6A8oSq9kUyvCbx
         hqQz36bdv6h4jsgE4/9vFveiaHM57s2lOVJsVpAjUfZ857U5iJWp4duWqOanHAgurciq
         GmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7be1Hzc+FAQBcBrQzPngzwbWsPoSIhQlVxYLx6M+WqLqN+hxabNjy1C6G3k2VbfMpYoHG3tzppAaHsFI/DgwYuR0ibUUZRDVZNo5h6IRedwH0+7yW4L4P0W84ArF3qj6rebW2c6PFUOfNQIRMmhAurUsnI1IZcT49jBP4n/tAqjuj02EpKN/+AZByGSKMQygYRgG0jClIocKoHjE9oLjhoeSMVzYScv7mx48lx8nbPulk1nQWszwJ1pRM
X-Gm-Message-State: AOJu0Yya3bLLR9QbdMt1BaCejySBhYPzNQXjiNKdn+bbDbByek+g3QqY
	TejS8kRzTLYEHRFL1BaphqgGgSqKYyQwcoJlSf8MhkBIHie88lPU
X-Google-Smtp-Source: AGHT+IFjDvMTXnhobln5jKNDQ2P6dQWSaGgkS/7twQcL+UsiDkVCy53zVtZ0UlohXhd71LvKm8ZPcA==
X-Received: by 2002:a17:902:82ca:b0:1e6:116b:b0d3 with SMTP id d9443c01a7336-1ef43d2ec00mr73548335ad.28.1715461791943;
        Sat, 11 May 2024 14:09:51 -0700 (PDT)
Received: from krava ([204.113.88.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c7asm52841025ad.171.2024.05.11.14.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:09:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 11 May 2024 15:09:48 -0600
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <Zj_enIB_J6pGJ6Nu@krava>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>

On Thu, May 09, 2024 at 04:24:37PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-05-09 at 10:30 +0200, Jiri Olsa wrote:
> > > Per the earlier discussion, this cannot be reached unless uretprobes are in
> > > use,
> > > which cannot happen without something with privileges taking an action. But
> > > are
> > > uretprobes ever used for monitoring applications where security is
> > > important? Or
> > > is it strictly a debug-time thing?
> > 
> > sorry, I don't have that level of detail, but we do have customers
> > that use uprobes in general or want to use it and complain about
> > the speed
> > 
> > there are several tools in bcc [1] that use uretprobes in scripts,
> > like:
> >   memleak, sslsniff, trace, bashreadline, gethostlatency, argdist,
> >   funclatency
> 
> Is it possible to have shadow stack only use the non-syscall solution? It seems
> it exposes a more limited compatibility in that it only allows writing the
> specific trampoline address. (IIRC) Then shadow stack users could still use
> uretprobes, but just not the new optimized solution. There are already
> operations that are slower with shadow stack, like longjmp(), so this could be
> ok maybe.

I guess it's doable, we'd need to keep both trampolines around, because
shadow stack is enabled by app dynamically and use one based on the
state of shadow stack when uretprobe is installed

so you're worried the optimized syscall path could be somehow exploited
to add data on shadow stack?

jirka

