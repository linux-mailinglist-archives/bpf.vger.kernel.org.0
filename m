Return-Path: <bpf+bounces-67339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4DB42A57
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B22680301
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61E238D22;
	Wed,  3 Sep 2025 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/GkbZwz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED829D0E;
	Wed,  3 Sep 2025 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929317; cv=none; b=auiv5Ba7Nr/3TuQE6Ji03APnkDhVpSHuydgJbUlXNRCotxJ9Vp2YF5+cfUHKl8Bi1JiGOk5mJj3NXijsfg/0ZHndZ4NMDSEqF1iwnbmtWrwsoooMjGZbT1B/6BJr+u7BW2lylH2gTBEf+EeSki+oiP/uWMG1QIUQleHd1XoaLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929317; c=relaxed/simple;
	bh=zezUoFN2iNFV98R9sm4aw8j0++6jTrSoQr9j1YUqGro=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn0HA1oDckYO+EhSYFf2oFuXo6DDZKhrOiIjy5/67aCyyQMeQ1SbG/7y+k+gqhQu2U5f6ha8DGFpWT2bUDFn7yNWC1N7LQbo9Q8j85mo4g0dTbVvwjAO6JZrx6oS+0PmDgR5cUDGtEtfdsY7UCeprSQ3Qy92dRNvz323hA6tDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/GkbZwz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00a9989633so50070466b.0;
        Wed, 03 Sep 2025 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756929312; x=1757534112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BkGfMi6CkMSbFPzftImbxarPsyJN6UbbO89dlurGrPU=;
        b=R/GkbZwzxXmqBJclNi1mCyUQgUu17EAp0prDNDTh7wPKXK/lYqQpQMxV+PqHU1i4e/
         5e64/RKd1o5OPsxMx5SvQs6jDuMHEAZlwbbvnw2BmDzDqUX/d4HVpmKZAAnKwQAw5J8E
         hx6liWBdVY4x4W+EvI8zuzihXJSVQJJOivrfq1FUnnNYtdkTvh320ZU0U7RbNd3bsEis
         MwrH/Ky8j/499c9kPnKnLNJ09+CSIorOM3OW8HhNN1Beuk+v3H+Km7PwdjXileD7Pplw
         opxYpdrxyF7OLMQZgnqdFkQJiPt83+tMgvgJx1XWAw/6qjCh3BbTUrhZOkMl/uoWuxLh
         A5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929312; x=1757534112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkGfMi6CkMSbFPzftImbxarPsyJN6UbbO89dlurGrPU=;
        b=m8aYYO+2D8ppaJf8u6i/tm/YHJIGkhyc+kwyaXWxPJoJL4vcocRSLd/IZ8iGbwWFYB
         BjUnjtY7VgwRAmSr4fYFyCnKnVqaG8Czza+ozPbLflZfoD/FmHM7tJx1UOWauXoOqwPA
         LGKUhLVftmmM4lR2w/J4lhEs9aavB6eH/zEBGD7lcdGJWnkIZ2kBR5ixdztYZQOkwlzV
         VME1O2X7KT76StcSWj4eX7+Z26BAVvGNPVT0edCzkgzP7bGbRSMhm29lteF+unxQjwZq
         YZPznf2qWEWWGKIwxYkvnFKtbqQuVlkiVdH5eoHn/dhQ4Ro2uav5ji0yVbmpthvV6twl
         4ZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSALZNAWvEfMFTW5B74fqUjvzuYMQ0imvjy6Q2r08NeSwMv9cGroiAmIabsd9FrazJ0cNfwJ+Ro9xFvwFBJUKf9HB7@vger.kernel.org, AJvYcCVSSyvunn0hhxSTy1kmf39f9Uhn1WV0xrGPC5ojzEce9P4k/Vy1LBgIqgnyB8RS5MzGyQ3prVFEZPv7U2uq@vger.kernel.org, AJvYcCX7jlAS7BAddAO4Yuw9EtKQ2m7y3lk1pbKMyv1nMdJguPrsok7sKvsFQ+cZSWp2m3nNch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjAl0/wMDB8ZdSGcJpbQ5sXACKFVzkrpVJtTCIaVncGjaPIM8
	4JrgHWybyQeoW9IUXrpqoLa1XNLJfnIgKG20cL7gH59e+PCyzPQ4W4HT
X-Gm-Gg: ASbGnctaKUNdiYCZHqzZWIzc8/PnqLlI75MuyR/wrhRG7nOX90tO/QyzfPo5H+H51HY
	3EMJzaoNW6ZLTLgz4riRHNymUk/Wxkl1BjPZxjsGtxtU5OaaiVyMdEvKuPupqBMtdVeKXAaG4WZ
	b8s/OwW2h48YaGsrG/TFdgXA1GslYH+slUVJd+l8O7X3TG8KdGUGOi5/B8oNj1og0jv65BcwQKv
	mOhagNfzfNZKVzdRV0EYia2nGiazYgu7E+PnXz1K7JHIXQQ4G8waf85WpPGUAuVgjKYD+glv0Bk
	aaGqUUW+bILV4Nf0l/9gQ5LFx5RAgtEZX9kKrvyazLwBVfxBjNj0KEvvO2hWIoEGxexK5MRBpXB
	4AcI+do3LnkQBS8J3Xs4Qwj9vrGd1iOr9
X-Google-Smtp-Source: AGHT+IEJfQ6bXwCoPaw7VfRqN0ajR8l1s2d0xZIJViqxAY/WD3gIXmO0hhSQ8zJ5cG73NJqFAOu6mA==
X-Received: by 2002:a17:907:849:b0:afe:86d3:1296 with SMTP id a640c23a62f3a-b01d8c74b6emr1979874766b.11.1756929311676;
        Wed, 03 Sep 2025 12:55:11 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b009ae4f2ddsm1210211066b.82.2025.09.03.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:55:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 21:55:09 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 04/11] bpf: Add support to attach uprobe_multi
 unique uprobe
Message-ID: <aLidHRkM2jpUdvwE@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-5-jolsa@kernel.org>
 <CAADnVQ+MntzHdwSe_Oqe7CU=E3yjko=7+9GTnapsPWwe4oqpsw@mail.gmail.com>
 <aLfhwmf7lkIYQvBt@krava>
 <CAADnVQLLcH1weL24BJv=K5cSijNzjgWq5LM2=GCyM6bid2m0ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLLcH1weL24BJv=K5cSijNzjgWq5LM2=GCyM6bid2m0ag@mail.gmail.com>

On Wed, Sep 03, 2025 at 08:32:14AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 2, 2025 at 11:35 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Sep 02, 2025 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> > > On Tue, Sep 2, 2025 at 7:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding support to attach unique uprobe through uprobe multi link
> > > > interface.
> > > >
> > > > Adding new BPF_F_UPROBE_MULTI_UNIQUE flag that denotes the unique
> > > > uprobe creation.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 3 ++-
> > > >  kernel/trace/bpf_trace.c       | 4 +++-
> > > >  tools/include/uapi/linux/bpf.h | 3 ++-
> > > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 233de8677382..3de9eb469fe2 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -1300,7 +1300,8 @@ enum {
> > > >   * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> > > >   */
> > > >  enum {
> > > > -       BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
> > > > +       BPF_F_UPROBE_MULTI_RETURN = (1U << 0),
> > > > +       BPF_F_UPROBE_MULTI_UNIQUE = (1U << 1),
> > >
> > > I second Masami's point. "exclusive" name fits better.
> > > And once you use that name the "multi_exclusive"
> > > part will not make sense.
> > > How can an exclusive user of the uprobe be "multi" at the same time?
> > > Like attaching to multiple uprobes and modifying regsiters
> > > in all of them? Is it practical ?
> >
> > we can still attach single uprobe with uprobe_multi,
> > but for more uprobes it's probably not practical
> >
> > > It till attach single uprobe with eels to me BPF_F_UPROBE_EXCLUSIVE should be targeting
> > > one specific uprobe.
> >
> > do you mean to force single uprobe with this flag?
> >
> > I understood 'BPF_F_UPROBE_MULTI_' flag prefix more as indication what link
> > it belongs to, but I'm ok with BPF_F_UPROBE_EXCLUSIVE
> 
> What is the use case for attaching the same bpf prog to multiple
> uprobes and modifying their registers?

I dont have one.. but I guess you could have just one bpf program
doing the whatever override based on uprobe cookie?

I added the unique flag support in here because you can also
create just single uprobe with uprobe_multi interface

jirka

