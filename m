Return-Path: <bpf+bounces-56694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C8AA9CA0B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8317D4A612A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF524C06A;
	Fri, 25 Apr 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvs1NKtz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153E2557A;
	Fri, 25 Apr 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587220; cv=none; b=KeOsMG1oLC8Ov/oRilh1/Clg4/FDEwQWq5YQ7fLbbOpk4H70DhjlPDPclU9aNrtR8iB1jrJs3Otoixc3pjmJ3pLUsTWKYY23P73wN0lUSsHDbceNKpp8HqMzdxL3CanRfC3MlehucJzVyMG97YnLO+OzynIrbjxs5icPC8qpSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587220; c=relaxed/simple;
	bh=SPyeJFPnbHfdtjXp/gNM2HM2zqqL14sTVD1IE9G44cw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcQHXXnDbZ/bO3lwYlGVU6JQiJQHHlgrhBvZWUR73GzFS25JZeTveRDSO0Yumby/EL0EfYG1/qU4ZCQysqpeZviazFRSl970SxcpUBWjVppE5C7ftlgMA8jNFjWO9/+I0QxgF72Xy0kLHDGLePdZVW4ieIg2UeLH1cJaGz8kV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvs1NKtz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so341838666b.0;
        Fri, 25 Apr 2025 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587214; x=1746192014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tiDbQOOhMKzPk9TaDla//wQdnnmLWU+xDiPyN3yrQNE=;
        b=lvs1NKtzqcqElldMA168UMLN8kjU4zRZrC036CXzbMKYlkopxS7UNLfW70mnZ4IkRo
         8BPpyUxgBQqdeSpJ0ajO+gvCmG/amKl+AS6uGWTLTqMgRLyrVV2Xuf9jS9ok8bvTS3Sw
         mFkev6qJkAbl1wToVDeM1GnkbBsR20hxeYgukyVZNxBkdx6kLrhHzbO33muTrc7FymPK
         neVrn1jFwacoDSALxK9E+944qpZImUyk2c3Yqe0IA4dfxu6mmbuvBUQC35eubU/JSkbc
         DLMQK0rDZtNXk3IyULk/wpeo6xkyL3KQmGDHGHhjSF1dpP+UsI8qiXEmns8YtuoTv8Wu
         Ijzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587214; x=1746192014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiDbQOOhMKzPk9TaDla//wQdnnmLWU+xDiPyN3yrQNE=;
        b=Qcjh0JCIKwgqTQ1oMgFtLWCUZmrrXTuosUywKvCECVpT8nmWSSj953MgWuvp7efAnN
         n2DzGRg7cmyupcMo0LmSISccQSN/Nm252Kg0zDDsHqnSzx2Q5Ev2X0G8FPSKYqauA9o/
         YaIlk4eYF+YoRMN4uk8Q4l/LJhz/uJpgL9uGetc/AUweZHlp3Mh+jluNAQibh/udQ/M4
         wUxYhlgei542mNvrXipYg+VfeIvwLzdRZMsON9H4Ri5qpmRGSnysRbvqwm4jQxTmUbJv
         78c8oL0Om99WDfv8iZ56z7cdv381DY1cYuQYVEeCtv2I9S4q1IPvmZ+PGa92T4Ld3X3W
         yTww==
X-Forwarded-Encrypted: i=1; AJvYcCXWpsRKaBlD/bABvgJh5LDgKAMpStIlGcr9tdNUgXXdm0yaTcNVmtpsRIwcimophB9tYwY=@vger.kernel.org, AJvYcCXcxQA33VPcA74itxDkSD4sGNlwHE8pZsn9UkZDj0aaMzlZjoZYjWGExWDadp9MLhMFMRwlMf/sY2UtgWpy@vger.kernel.org, AJvYcCXyghieXVwQFo0l0X3BlhatgboyrQlfJW9df30rf7csgZQRlS1qy4xt4l48hG2swyfrLVR7xzuxmpmlRDa2ATJAQZ20@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMgvtzgRsjNvodjCTVUF2Wk6p6CqGRBA3wJjK/UfDsrxDl2Qe
	EvooMrRL/Lt08C6k4ZECSoGNcpPMq6kl3dJmYHgsBCxGA//JcmR2
X-Gm-Gg: ASbGncvKKEI9jxrU3BUTN3IXQ7CIKdjskv5ppIAOcg3bxPHYA8Ti0ZNtMAR5JNZu15r
	tn1RlTHCki/jiLIk+H+zOnfzHkbPeWLqClql2oOfeCQvpiXNUMlKUKaXc4X5jwLtACz+M0EXqXq
	/h79dRk/0q4gjpYLQ0dg6jC1D28NqlZyewBTqdNsQecVxKO7J5Mh6Etm1PXS74l19d6n8Lwab/5
	ZGfXhcPIM52PNVyIEsDmiSnfAzf0VLKeGMkReYIquPvUX60WTDtlP5QDEkL5p+qUSGuiDrB25Gp
	rG1FNzVVBi19v7fVrUtXhVE6vus=
X-Google-Smtp-Source: AGHT+IEGzf+3TOrg5dTtOxaINCOqHwTMbgLBeYUbqcdGafNXT/aTs0JPn43Dy04GGn7+CgBVyLmJhg==
X-Received: by 2002:a17:907:3f0b:b0:ac3:3e40:e182 with SMTP id a640c23a62f3a-ace7109ff27mr224360066b.19.1745587214242;
        Fri, 25 Apr 2025 06:20:14 -0700 (PDT)
Received: from krava ([173.38.220.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf9a17sm135823266b.99.2025.04.25.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:20:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 25 Apr 2025 15:20:12 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH perf/core 11/22] selftests/bpf: Use 5-byte nop for x86
 usdt probes
Message-ID: <aAuMDEyiahZi6zIa@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-12-jolsa@kernel.org>
 <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com>
 <aAozU3alQYU0vNkw@krava>
 <CAEf4BzagXsyr-iKB=ZpRZ3kS2FE69jpbWa8EVyFJknUOCGtEEQ@mail.gmail.com>
 <CAEf4BzZvwH2GR6cr8EN8Up02tHBkGij_1v6UNPcKaVFATmKvUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZvwH2GR6cr8EN8Up02tHBkGij_1v6UNPcKaVFATmKvUQ@mail.gmail.com>

On Thu, Apr 24, 2025 at 11:20:11AM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 24, 2025 at 9:29 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 24, 2025 at 5:49 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Apr 23, 2025 at 10:33:18AM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Apr 21, 2025 at 2:46 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Using 5-byte nop for x86 usdt probes so we can switch
> > > > > to optimized uprobe them.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > >
> > > > So sdt.h is an exact copy/paste from systemtap-sdt sources. I'd prefer
> > > > to not modify it unnecessarily.
> > > >
> > > > How about we copy/paste usdt.h ([0]) and use *that* for your
> > > > benchmarks? I've already anticipated the need to change nop
> > > > instruction, so you won't even need to modify the usdt.h file itself,
> > > > just
> > > >
> > > > #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
> > > >
> > > > before #include "usdt.h"
> > >
> > >
> > > sounds good, but it seems we need bit more changes for that,
> > > so far I ended up with:
> > >
> > > -       __usdt_asm1(990:        USDT_NOP)                                                       \
> > > +       __usdt_asm5(990:        USDT_NOP)                                                       \
> > >
> > > but it still won't compile, will need to spend more time on that,
> > > unless you have better solution
> > >
> >
> > Use
> >
> > #define USDT_NOP .ascii "\x0F\x1F\x44\x00\x00"
> >
> > for now, I'll need to improve macro magic to handle instructions with
> > commas in them...
> 
> Ok, fixed in [0]. If you get the latest version, the .byte approach
> will work (I have tests in CI now to validate this).
> 
>   [0] https://github.com/libbpf/usdt/pull/12

yep, works nicely, thanks

jirka

