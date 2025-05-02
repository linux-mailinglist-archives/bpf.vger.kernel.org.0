Return-Path: <bpf+bounces-57196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B240AA6CDE
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC771BA1B90
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AB22C325;
	Fri,  2 May 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSF7K3Gf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50E22A819;
	Fri,  2 May 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175680; cv=none; b=uB9y/7d47/SF/o3MNEoErOWe/qjnpAdQnFKtuL9cL2sa4pfQlaygkkR7k0yf+PKLdMIFDAIDvp721WPiUEG5PsNfjMjTAgzCLzRVnq9wnSgQSFojRx+Am03/QZ2LP0Sdgt9lCLix0vU8yCb2i0shux16lc9h+NHE42N+rdFTCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175680; c=relaxed/simple;
	bh=fpk/kMJFJOYpZ6RZKJXvQwwCwcQhzbrqgWEEwEcexaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPEURs7XGuDwx87Kx8j53zTt+LhvWFlxnQH+zW1yHedSMbYXdciXmM51VGgT0DV1kjOuTB1d1mICY+KZsOn0poOgHFNCyD58bbyCSdsku68qWJG9NX9N57tliqNSFBYbCbTzZTmQco/41vpGUvqQgPq3B0ORAQU2aCFZpTy3FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSF7K3Gf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f728aeedacso2659361a12.2;
        Fri, 02 May 2025 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746175677; x=1746780477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bh0Rl1k2uOksfrDAOIuz8rd+aIGZh9M8Pf/lIkHtO8I=;
        b=OSF7K3Gfqc/YTeKBtrGVHpngZd23AosjYjNA2WLDk4MZ9ia4ho8f+ASfbVwHWaN1YB
         gEcOwLZ+USo6YWuKuB9xq7CRQZQzySl9ViMfTMpsWDYMYIM70jwmSJOSFj+Puc7GzTnx
         dYKYk14j9L0rfkPGq99aOssVUHz67X2UFHQsmOkvOdtSDUKyZvJ+me8ijkglH4C0ItuP
         GFfAVS6Lp5xwZdjLxj6PsZC2CC+MBppjxGbAVAICx70sFW51pEs7yG4O/MiAAudhrjQV
         TIc778xpaYSSSkJ2mtujks1LV3HAJSOk1AqnSzHmLL3MVzwjEfNmw3d1kuRbDMO2zu48
         zN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746175677; x=1746780477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh0Rl1k2uOksfrDAOIuz8rd+aIGZh9M8Pf/lIkHtO8I=;
        b=mNOvWV5TNoe7Z/J4XnzbJgMKidRG1tQdPfNMrcc9aICFpNLxiKHAPp8n5v78E8dnci
         slhoibEKv2Bx3vFin2UHHs3nRQpnD8EvqSZyW6T4JjucmqSunD3I4B+Hb98+HPDDGsN2
         tmab869ojwEmNZoSr3gdDXY7oIxlbgyxRUQsPFB7PyQkIUaRjj4F8DMbCO+NNvLb8vBr
         2rIP9J2kpRsdOMxpxPuY0EQ4aA1+rXrNSWMtrrb6FgM2WtCIIunIfmHYNDYT6MiQPShc
         zfpBQhJ2NbLbhnrB+IXqO4731F3uF93PpPVJb6OXvp1N/S7h+Sru0/FB7hh0/951izMC
         TgdA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6Kn1sWK2I/5kMsewAD7YaXi08F/kDxmZfG7IFHA8DGvWmWgtq4l8bmmhcCbl9yKFWIo=@vger.kernel.org, AJvYcCW7MNO9CRRiEqKBD63hJYHSoeThl5TYW1X02tTnDBJpS3A911uQiBNlok4bPaRVptT8sqQblwlmJizTEj14@vger.kernel.org, AJvYcCWqUJyh27FN/Cyi5lOuhAPNnbsocbWfEiKojqwwYhCCG2KIsTm1JRCarupwh1m8MHivwhPxN4Oyahk/2UK21zW2/wB9@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJbUOHW6PYtcHV+c8sFtrVeG6IjPHeZftecAU5M6B3SPWA6y9
	dtDiwWh5WODsmJjPME8wEy6bMmKSxhMm6IlLPmua0vxejS9ebSFW
X-Gm-Gg: ASbGnctt/dliQwLvG+I+av1QnH0MWLNuhvcqVM7dhpLlxI07rB5+tjse/oVCpw57GbS
	eLl69UYqh10WO4Gaq+K8YIj9IwWAFZjLDy7P7PGh81pnmX8pQCQsbdwJFbtLA3/HdeSWv80sren
	cl8Tm0jOsB3kbqroMkbTnCp5buDdQTC72C2OJDeXxRlCSgQMoJpEFk5m7gxvuZDqUHshygIiyaw
	xCtncn6iGH2xjOrC3Hd0vlB5Er7OARXrYU0oETI1fGxspHCMVe7IJUX8eUqqCgwryqXzkLyTTUE
	y5ZVkZmxs5ZKa70CJRlzt+4P6s0=
X-Google-Smtp-Source: AGHT+IGLo5LwCnRs/f36Ec6GHgEp3262fW7h0ITzF1LNYmVO5/4odC3rPODA7HJ2f7d15r/5GhhTrQ==
X-Received: by 2002:a05:6402:1e89:b0:5f4:d5d2:dd47 with SMTP id 4fb4d7f45d1cf-5fa789182c1mr1445887a12.25.1746175676569;
        Fri, 02 May 2025 01:47:56 -0700 (PDT)
Received: from krava ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b8ffcfsm894913a12.64.2025.05.02.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 01:47:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 May 2025 10:47:53 +0200
To: Alejandro Colomar <alx@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
Message-ID: <aBSGuZUzSZAzG8O-@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
 <aAehVOlj-W5kVyW3@krava>
 <6rauz4mwgjpcmdbpny3pnh632t3wbequxni2iqdvs3bmjbzqzt@7cykilsvoggn>
 <cqih4qscx5jslfaq46bjcldt3dqoiyqg2dgbnif5eqa7ioygem@lorictjx3jrb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cqih4qscx5jslfaq46bjcldt3dqoiyqg2dgbnif5eqa7ioygem@lorictjx3jrb>

On Thu, May 01, 2025 at 11:26:46PM +0200, Alejandro Colomar wrote:
> Hi Jiri,
> 
> On Tue, Apr 22, 2025 at 10:45:41PM +0200, Alejandro Colomar wrote:
> > On Tue, Apr 22, 2025 at 04:01:56PM +0200, Jiri Olsa wrote:
> > > > > +is an alternative to breakpoint instructions
> > > > > +for triggering entry uprobe consumers.
> > > > 
> > > > What are breakpoint instructions?
> > > 
> > > it's int3 instruction to trigger breakpoint (on x86_64)
> > 
> > I guess it's something that people who do that stuff understand.
> > I don't, but I guess your intended audience will be okay with it.  :)
> > 
> > > > The pages are almost identical.  Should we document both pages in the
> > > > same page?
> > > 
> > > great, I was wondering this was an option, looks much better
> > > should we also add uprobe link, like below?
> > 
> > Yep, sure.  Thanks for the reminder!
> 
> From what I see, I should not yet merge the patch, right?  The kernel
> code is under review, right?

right, we need to figure out other stuff first

thanks,
jirka

> 
> 
> Have a lovely night!
> Alex
> 
> > 
> > 
> > Have a lovely night!
> > Alex
> > 
> > -- 
> > <https://www.alejandro-colomar.es/>
> 
> 
> 
> -- 
> <https://www.alejandro-colomar.es/>



