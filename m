Return-Path: <bpf+bounces-75547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A59C88A3D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97F9B4E135D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE143176F4;
	Wed, 26 Nov 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhQt49OW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB73164C2
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145797; cv=none; b=LGaFdaAfMnKx/+Um9gr8iqb4pg6c5yJNQpYXyp13vqYLvLIx2/nDObJAXG6upKIVmYiVBmVGmBJAvaJgFFYBwitQtdoGytYpF0Tgxpp36y4qn0fnmBdPEtO/+Oj3AX7wYpcUCmea6enHqNK/ryvLRRGqxLxP4oYBwCi7smEBZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145797; c=relaxed/simple;
	bh=3HvIvlYUi71+Avx2+menTUOV2j1SqCyVDLtcPRSRYTY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOZ+L+n2bpN58rPDaPU4l5xdlPaMjJMR27aSRSiAFEfvv4N+BfvHIsX1Rnv0yIsiWTiYOCzdYwEfb9xOZnIsjS11DfNb42Y8umaXdsgpFTNBL8IlLn3SrhKzdO3vxehJJlXByL2BGbOhqJqVT3AcQ1hkV4FoTSAiUfINWm3YtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhQt49OW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso5247082f8f.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764145794; x=1764750594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3D96AlIhIrSwiYG1ld9eeOW54Z4lDfMvK6VDkdFkU4=;
        b=PhQt49OWJ1ZZdQDrGD4hfDu8AsORL0xgFAeywiQzKHgdVH4VkG249hxDOl+olzK76p
         Xm5Z49Q/NCRuI4Gz9B1DFvXwn/CsxbIEr6+jc1hskasqeU8XQz9Z+B09UywCTyDBm4fj
         iexlPGicw/nA4mJE/D+Zj0b7ciz+odtcMZud3nmSfnfxrcl0A0kevyQobU58CAcqjUC4
         fUbUcPjRB6PBaCrd2rjVQC+NRoDiGRxMzObOTEQvGdeJNV280Za1LqGhSR6Y0GALomGB
         TA4CI22XyBoBeG/Vdsk0pRtHjCZQthgBWBdsJEOwlp3Eikmhvmzd5vJD7uzik+yhXinW
         CMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764145794; x=1764750594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3D96AlIhIrSwiYG1ld9eeOW54Z4lDfMvK6VDkdFkU4=;
        b=UHfbLsTS1RGdyYA3B3cc4OzlY20t3PE5er7sBdivtUva+iott4ZbzUf5S+pP1h8fIO
         2z5ls29hI818fnKxslqoDz4DunPeK/2CZpsaPIQU83pG3tQh5tPwxUllCzYL5n9zlMFs
         IYMn+9o8jvSLMbGvWz4decNIDGSSOJ3rdjqd6zH/BVZvkWLbKvj+9wHIdCqn3Pr+/C7c
         Bl/KN3TMe+PDMmbP8s+49rzpNdjdT5Xm9iZW3mWb2k+/Dvh9OPsI8zErDc+lO9chV83z
         yRDt4sQfNYTCexIKWReNZKMbG1XVWwoGvW6uLIZnGo2PkzHm6goyuyasHkmYe4tFxxi/
         DMYw==
X-Forwarded-Encrypted: i=1; AJvYcCUIqVzpoJK+LKiHJSbEoYGjAvHS5er9Nyu8Iqit46A++gxxO2PIApBPYTA5e/yr7jdlz9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRRwwg6aww0ubOdyTrjQdlht9CyxIxg7vIhqms7Ue1v0xQZQY
	fSlcszZKw5oxZz5hRUg8hvxQxXnVC4DlFONSlKi2bBU6NS7FyRwn+ogw
X-Gm-Gg: ASbGnctNpiUEQwJRnX9/uFXbljPnkarbNjFW9GcBN56TpxK0S61eymItYdgfFihoCmd
	Le4lFLd2isvLyC+PaXf36Eg4+iklTGtWnSXJ5Kx2BQ7nkA9ZyFm2ncaWAYc0Y6sb1lgZkk4Juh+
	bAYm20glYhBLEqQ1DsrqusB2VMhEFu4RNuse0HlXNJggc8r2t7t9HcnlCEoDFLpwCM99pYsRJCD
	JcEWuKCIx2KFlUytY3oonAL/JfawHU/IOhplhIQoXv98bzvmNznTYFJJdpKHg/gVz+fvEw961HC
	8OninZgo4mCQ8YMX2ep2kF4QidiqYVoT05mJcRgrdPAnxqScY9PxcM/obJzF/HbTFUDrKLug7KH
	d+O8KZx7ktqciskdrQg44C18dJKlaQg1X3d12Y1rp9c5FjqucbKHDpposx50N
X-Google-Smtp-Source: AGHT+IFgkVAxa/Y1EduG5D/Ky2jhY4sff92iY9C/L79kHLkTX/OwKx7uPVDzuMdk34ogFLnGxD5vwQ==
X-Received: by 2002:a5d:64c3:0:b0:42b:3825:2ac8 with SMTP id ffacd0b85a97d-42cc1d23eb5mr20670199f8f.59.1764145794310;
        Wed, 26 Nov 2025 00:29:54 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm38668420f8f.5.2025.11.26.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:29:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Nov 2025 09:29:52 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Add uprobe syscall feature detection
Message-ID: <aSa6gA2o-2-0YMQW@krava>
References: <20251117083551.517393-1-jolsa@kernel.org>
 <20251117083551.517393-3-jolsa@kernel.org>
 <CAEf4BzaXac7JyAOXA8+cFj7ZgORHdVxCHceFv417t1xqAe94HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaXac7JyAOXA8+cFj7ZgORHdVxCHceFv417t1xqAe94HA@mail.gmail.com>

On Mon, Nov 24, 2025 at 09:29:05AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 17, 2025 at 12:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe syscall feature detection that will be used
> > in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index b842b83e2480..587571c21d2d 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -506,6 +506,25 @@ static int probe_kern_arg_ctx_tag(int token_fd)
> >         return probe_fd(prog_fd);
> >  }
> >
> > +#ifdef __x86_64__
> 
> nit: <empty line here>, give the code a bit of breathing room :)

ok :)

> > +#ifndef __NR_uprobe
> > +#define __NR_uprobe 336
> > +#endif
> 
> <empty line>
> 
> > +static int probe_uprobe_syscall(int token_fd)
> > +{
> > +       /*
> > +        * When not executed from executed kernel provided trampoline,
> 
> "executed from executed kernel"? Maybe: "If kernel supports uprobe()
> syscall, it will return -ENXIO when called from the outside of a
> kernel-generated uprobe trampoline."? Otherwise it will be -ENOSYS or
> something like this, right?

ugh, yep

> 
> > +        * the uprobe syscall returns ENXIO error.
> > +        */
> > +       return syscall(__NR_uprobe) == -1 && errno == ENXIO;
> 
> nit: please use < 0 check for consistency with other error checking
> logic everywhere else

ok

thanks,
jirka


> 
> 
> > +}
> > +#else
> > +static int probe_uprobe_syscall(int token_fd)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  typedef int (*feature_probe_fn)(int /* token_fd */);
> >
> >  static struct kern_feature_cache feature_cache;
> > @@ -581,6 +600,9 @@ static struct kern_feature_desc {
> >         [FEAT_BTF_QMARK_DATASEC] = {
> >                 "BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
> >         },
> > +       [FEAT_UPROBE_SYSCALL] = {
> > +               "Kernel supports uprobe syscall", probe_uprobe_syscall,
> > +       },
> >  };
> >
> >  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index fc59b21b51b5..69aa61c038a9 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -392,6 +392,8 @@ enum kern_feature_id {
> >         FEAT_ARG_CTX_TAG,
> >         /* Kernel supports '?' at the front of datasec names */
> >         FEAT_BTF_QMARK_DATASEC,
> > +       /* Kernel supports uprobe syscall */
> > +       FEAT_UPROBE_SYSCALL,
> >         __FEAT_CNT,
> >  };
> >
> > --
> > 2.51.1
> >

