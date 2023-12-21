Return-Path: <bpf+bounces-18557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B9681BF89
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 21:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362DF287B63
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A974E21;
	Thu, 21 Dec 2023 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1jn/y0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF19745DA
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2371eae8f1so141048166b.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703190281; x=1703795081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1B3g4NuM/DD/0sh57Q9pzfA05yOxsrn/35RGBOjORw=;
        b=H1jn/y0GHLX1YwK+7ZBMsl0Mjah+oqDSk5VrX4m2WK+w4drTpfMEC5epozvW41FNDS
         nvN4+PV+DO9rAeIa0KNScfohufUO7cqvZz+BzJ8NpoSgGrS1e7mkVX0WUIixS+5M8ENW
         tFFeB7ghZ6et/laKX0q+cQ2XexyOHMkJ0AVOefbCgQPKU9n5wR4bal0KAZke5F6CjhSD
         OjIkmTXA+ivRP+fI0ySrY61okbEuvm0vYGapOsGb47U5cUi/VTa53wFyyahZwjfak0HC
         067BHEgcKpFy1BiCB6HQqRHH+NPPX4KS4mXHP2Ba3TZuvm6Sc5Ak2/ewEquS7sLRE8CX
         m7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190281; x=1703795081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1B3g4NuM/DD/0sh57Q9pzfA05yOxsrn/35RGBOjORw=;
        b=loz7U0NrgTTheWom9KUMhqiPG6Ti7+wQ2vQW+tZ3l0cn5dafxgLcELDE4AF5kizcDg
         K04PZNdk1YEG7rCTV0oOko4xAnzXnY0PmT5nzo7KAvP+vtvKY1X6U2k0w+mTH6KQgEtF
         bVNGe8mIDlrhNUAXugqN9/6ibMg2WiijolqA7QBAMl3VbGSgI3vBH2W5gcdAB58dNNU5
         W1iTa4eLB8VKvcSBaJeZXJtrwMI4LobzFzr2yKI4BsVgTsvgt+1GY9PH9CxT4JpCiqX5
         vlZ3UCp5Po8VinT7sKp9+dRfsvLljIntON1dKs7zQ2QEGcryvUXsmN9lbU+I39EtfEzF
         dUIA==
X-Gm-Message-State: AOJu0YxNoRfWO0xmaUFPSKerbf1wjkroAmoAUKX5WiE+PxyRW8pBqV76
	/n7ns7/66x9WTN3mbZyFqjA=
X-Google-Smtp-Source: AGHT+IGtw3sHSceiFjmaqBMlyid6fYci3Dv3MJNM+zYnodnC9qj06uvi2V4dGciuuflC/5DuDAnROw==
X-Received: by 2002:a17:906:c351:b0:a25:5026:4469 with SMTP id ci17-20020a170906c35100b00a2550264469mr231575ejb.70.1703190280613;
        Thu, 21 Dec 2023 12:24:40 -0800 (PST)
Received: from erthalion ([2a00:20:6082:2d2f:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090624d700b00a2371908713sm1309425ejb.181.2023.12.21.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 12:24:39 -0800 (PST)
Date: Thu, 21 Dec 2023 21:24:37 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v10 1/4] bpf: Relax tracing prog recursive
 attach rules
Message-ID: <20231221202437.gwpktfli43kdrcbg@erthalion>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
 <20231220180422.8375-2-9erthalion6@gmail.com>
 <ZYR9mrvFargzFlQp@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYR9mrvFargzFlQp@krava>

> On Thu, Dec 21, 2023 at 07:02:02PM +0100, Jiri Olsa wrote:
> > +	/*
> > +	 * Bookkeeping for managing the program attachment chain.
> > +	 *
> > +	 * It might be tempting to set attach_tracing_prog flag at the attachment
> > +	 * time, but this will not prevent from loading bunch of tracing prog
> > +	 * first, then attach them one to another.
>
> hi,
> sorry for delayed response..  this part gets trickier with every change :-)

Yeah, I'm impressed how many scenarios this one-liner can affect.

> > +	 *
> > +	 * The flag attach_tracing_prog is set for the whole program lifecycle, and
> > +	 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
> > +	 * programs cannot change attachment target.
>
> I'm not sure that's the case.. AFAICS the bpf_tracing_prog_attach can
> be called on already loaded program with different target program it
> was loaded for, like:
>
>   load fentry1   -> bpf_test_fentry1
>
>   load fentry2   -> fentry1
>     fentry2->attach_tracing_prog = true
>
>   load ext1      -> prog
>
>   attach fentry2 -> ext1
>
> in which case we drop the tgt_prog from loading time
> and attach fentry2 to ext1
>
> but I think we could just fix with resseting the attach_tracing_prog
> in bpf_tracing_prog_attach when the tgt_prog switch happens
>
> it'd be great to have test for that.. also to find out it's real case,
> I'm not sure I haven't overlooked anything

Before preparing this patch version I was confident it's possible, but
turned out bpf_tracing_prog_attach has this condition:

	if (tgt_prog_fd) {
		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
		if (prog->type != BPF_PROG_TYPE_EXT) {
			err = -EINVAL;
			goto out_put_prog;
		}

Here is where all such cases I've tried are failing. Just tried what
you've described with an ext prog (reattaching fentry2 via
bpf_link_create with target_fd and link opts containing btf_id) -- the
same result, as well as with trying to change the fentry2 to some
fentry3. Does it make sense to you, or do I miss anything?

As as side note, I find it's generally a good idea to reset
attach_tracing_prog in bpf_tracing_prog_attach when the tgt_prog switch
happens. It has to do both setting it on and off, if the new target is a
tracing/not tracing prog. The flag still will be kept during the whole
lifetime, unless switched in bpf_tracing_prog_attach -- meaning no
changes in bpf_tracing_link_release. If changing the attachment target
would be possible, that would be the way to go.

