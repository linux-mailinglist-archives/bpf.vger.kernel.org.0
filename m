Return-Path: <bpf+bounces-75990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52ECA18BC
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 21:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9CD13009C11
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE828DB54;
	Wed,  3 Dec 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAecPv5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20629305055
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793434; cv=none; b=UWLjMOstJzCrVqLmWvl5X5rDXBM33zfDRDZ6nah1UydPURisb0w4AB/qRtwuk3tjxCape/kylkc+OFO8TvG4w9uRdQQEEh2b5GlWYk78Y0z5FucAymUnZ62zADiU4KLfFuQ1i2kQwht+7IZjIooxtVhV0PYd5dmFEKz7MoV4bMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793434; c=relaxed/simple;
	bh=H3qq8NXAbCoDl1lI9pvTZNbJD7FkSGRSasmvrrHI8nw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8L2PnaN+T2qSgh6UUEMEtDjzzqRGsFa8pTnqeZAp108DGj2XMBmlL16ykIv8Ku6SD+g77x07RTy8KCZylHVcgp/kPwfXPjPbXNSGxkt4kTUeURUuij29fymDXNye3n+HbcJf5rUmY7g7TVG5qnWY+kE7ro0jalRvVc9PK0nsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAecPv5Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a1c28778so2157965e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 12:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764793430; x=1765398230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zi2Tym97Iw47XsW0KDcn1kY+fahoY4a+WRZ6zbXd8IA=;
        b=dAecPv5QWr1qwfgxSNEAoxGWtuV7+93+QdDtLpVgzPQsow/jkn8r0v6gA4nMB3WAQd
         yUqLIpD9qHcTSBPKecqpL0lCurp1rs4XvZTvtqW16yF20Dz+/5SPFjtEdrxXM+UyUl/a
         6poF8y0U5bKA5DfMcbEFaTTHNpjhtDfUV3G0xfKckvlfjZDcNJQAJrna2uBldc8H8rh1
         NOQaHEExkPrjh8Qx1O5x9JXxPbkncTuE+FC1Br3V7viWLzNS2HiV8txxTrETIZqqawFQ
         VeMK1I0CJTShm1LXIYT0K9KM6ACvHSJMLeboDNiJlpMTPowM53F8SG2jsJ/kfRrmra5t
         RXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764793430; x=1765398230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi2Tym97Iw47XsW0KDcn1kY+fahoY4a+WRZ6zbXd8IA=;
        b=FxRWQ0kk2QdCer6SKQuuY1ilwwQSpnf4O3Rfw1iXxpOwr/mDOL7w0XxftquQVkXui7
         dMMFcLSbFVuJbhNqTO3fqHKagQ9N4o0fR9zi0A+xWKDUyqpBwvkh456rM+XLugZ3DYy/
         FwwtKGdXc5GpHCuefq3An2GqFhtN4PkSNYLzr6fUbFoKaD3bnaZPdmTTi+IlhjoL1FsX
         vY49fE9gD57PHVsxkMXXTuwxXKJlqZtqUV6dFbp3SnLeV9q7VPzL5tB9kqSygWP3bUUm
         l/atvaUk6Q5dS89U7xM9vyVXVZb15WQJD3+jm/vZEUuR0A8M/b54yUMXakhMcsGhbReb
         jA3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9mHVu+Q/gMP7GSae8sxE3q1Ngsm/8UrJyAJJcvXha3lJQ21ByhD+d0z7FwB1q8cU0fjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmS05mmFaKl5Ii5byLfxcwdSGo6+ndVEecxUyqjs4iXWHjW6zY
	NqeuZhHyHlud7kBmar/DikuHq13/gBB610p7hbkzeSdDWtb7VryDRZmd
X-Gm-Gg: ASbGncvj9u/5E3ivPBZ+71YJ399N4IdPR2Ej1+Wu+YZddH76EHGkgsIcwnWbFcFpcTE
	FunzeX5tkch9m4xsrdLjj1GFQSjSa/bRidQbYbXmZVgaQjkdydQ15rgLIBmFMZs1eTGH1kJrDCI
	6EUBNTB9BQXQn0yQzEMRqFPfko0n5UjyKj3dVgD4Ev6dCFLqFrmKFwER59F3Jhu1kmOQuMsPdhK
	OmN9Wpz4iO54aMSFDq3cETp5bBytNDVKK9dYeJ+fihKxnzeseXQi3OVNOhFqbZKjCiXJr/XTeB4
	H6x9/Kz3wMfoL4B8oEzSkmOQyW71qYcbGH5RIoVAQjKyj3fjFauZB2gw6FH/h8nfk+x7xXR5K2R
	VZ7WlJ8nXQpoNEkZbSfYh5fJ87TJmBBqpWxu0/8PjRRv5hywzj/WpzdRXIFpO2qpg0M/mAFHChe
	8=
X-Google-Smtp-Source: AGHT+IHAWH1Cpvq5B81/xkivbTXgTXuutxLETKY/29bdgzeJHM6sjIXHH155EYl31r8m6eHuaFG7fg==
X-Received: by 2002:a05:6000:22c2:b0:428:4004:8241 with SMTP id ffacd0b85a97d-42f79851c93mr237747f8f.40.1764793429799;
        Wed, 03 Dec 2025 12:23:49 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm40900203f8f.12.2025.12.03.12.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:23:49 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Dec 2025 21:23:47 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCHv4 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
Message-ID: <aTCcU509ajY9-Dgj@krava>
References: <20251203082402.78816-1-jolsa@kernel.org>
 <20251203082402.78816-2-jolsa@kernel.org>
 <CADxym3awpEbMiSKE5aDcyd2Cg1Cdo7++SLAMSuZmaggt3BSbUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3awpEbMiSKE5aDcyd2Cg1Cdo7++SLAMSuZmaggt3BSbUA@mail.gmail.com>

On Wed, Dec 03, 2025 at 05:15:52PM +0800, Menglong Dong wrote:
> On Wed, Dec 3, 2025 at 4:24 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > At the moment the we allow the jmp attach only for ftrace_ops that
> > has FTRACE_OPS_FL_JMP set. This conflicts with following changes
> > where we use single ftrace_ops object for all direct call sites,
> > so all could be be attached via just call or jmp.
> >
> > We already limit the jmp attach support with config option and bit
> > (LSB) set on the trampoline address. It turns out that's actually
> > enough to limit the jmp attach for architecture and only for chosen
> > addresses (with LSB bit set).
> >
> > Each user of register_ftrace_direct or modify_ftrace_direct can set
> > the trampoline bit (LSB) to indicate it has to be attached by jmp.
> >
> > The bpf trampoline generation code uses trampoline flags to generate
> > jmp-attach specific code and ftrace inner code uses the trampoline
> > bit (LSB) to handle return from jmp attachment, so there's no harm
> > to remove the FTRACE_OPS_FL_JMP bit.
> >
> > The fexit/fmodret performance stays the same (did not drop),
> > current code:
> >
> >   fentry         :   77.904 ± 0.546M/s
> >   fexit          :   62.430 ± 0.554M/s
> >   fmodret        :   66.503 ± 0.902M/s
> >
> > with this change:
> >
> >   fentry         :   80.472 ± 0.061M/s
> >   fexit          :   63.995 ± 0.127M/s
> >   fmodret        :   67.362 ± 0.175M/s
> >
> > Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/ftrace.h  |  1 -
> >  kernel/bpf/trampoline.c | 32 ++++++++++++++------------------
> >  kernel/trace/ftrace.c   | 14 --------------
> >  3 files changed, 14 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 015dd1049bea..505b7d3f5641 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -359,7 +359,6 @@ enum {
> >         FTRACE_OPS_FL_DIRECT                    = BIT(17),
> >         FTRACE_OPS_FL_SUBOP                     = BIT(18),
> >         FTRACE_OPS_FL_GRAPH                     = BIT(19),
> > -       FTRACE_OPS_FL_JMP                       = BIT(20),
> 
> Yeah, the FTRACE_OPS_FL_JMP is not necessary. I added
> it in case that we maybe want to implement such "jmp" for
> ftrace trampoline in the feature. But it's OK to remove it now.
> 
> >  };
> >
> >  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 976d89011b15..b9a358d7a78f 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> >         int ret;
> >
> >         if (tr->func.ftrace_managed) {
> > +               unsigned long addr = (unsigned long) new_addr;
> > +
> > +               if (bpf_trampoline_use_jmp(tr->flags))
> > +                       addr = ftrace_jmp_set(addr);

I wanted to get rid of the  void * -> unsigned long casting in all the
places.. this way it has to be just on one place above, but maybe we
could have already direct_ops_add with unsigned long addr, will check

jirka

> 
> nit: It seems that we can remove the variable "addr" can use
> the "new_addr" directly?
> 
> > +
> >                 if (lock_direct_mutex)
> > -                       ret = modify_ftrace_direct(tr->fops, (long)new_addr);
> > +                       ret = modify_ftrace_direct(tr->fops, addr);
> >                 else
> > -                       ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
> > +                       ret = modify_ftrace_direct_nolock(tr->fops, addr);
> >         } else {
> >                 ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
> >                                                    new_addr);
> > @@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >         }
> >
> >         if (tr->func.ftrace_managed) {
> > +               unsigned long addr = (unsigned long) new_addr;
> > +
> > +               if (bpf_trampoline_use_jmp(tr->flags))
> > +                       addr = ftrace_jmp_set(addr);
> 
> And here.
> 
> Thanks!
> Menglong Dong
> 
> > +
> [...]
> >

