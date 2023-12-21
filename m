Return-Path: <bpf+bounces-18562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCC81C0D6
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034D52875A9
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520477F18;
	Thu, 21 Dec 2023 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H19W5rQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE677635
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d3dfcc240so11369065e9.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703196819; x=1703801619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YgaZFEhg9tiLksHfa2J5nIlKlUtskmmVGSXvOgdrWnU=;
        b=H19W5rQ7f0D2kT4MZfRS59CtYN4H+XcceZX2kewWx+BH21LyZzMlx9B++TQKUBFp38
         Wvtr6Vj0phbS3LUTeYV3Qee7M5Fo+zW9xUgl4p2bpLVStbwFICpalyxDSX34jdzBUrA6
         a0P6aiupzU1y975LMWlZp7nioIfer9SsfTNeR0IJ4dzMcAgONVdVmadVm4GlNk0GhW+P
         LMgC5LEuC/OofqOouD/skESWv/CG5OZuG3sN19bl3NPh3WilbBxd7pHgGlIw9JC+63UD
         +DGZsndHj10lQ3ZrOe3U87WZuLd1NWvdwzbIBhtncJoHZE1ht1HbshsOMtWknvJelm5m
         YxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196819; x=1703801619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgaZFEhg9tiLksHfa2J5nIlKlUtskmmVGSXvOgdrWnU=;
        b=CNztSD9afiGQTSqCyn3l7NHCQanyLs52Xz41rMfhaezzjQa6nA2kw+zIIn1QhbcD9l
         5SANYyFCcuy++kT147LNHXgrZiBVG1aw0YmSXe3dLoTkAWpMeaFkF1IBHJQuKxoEBciR
         HvoyEomEmGsiCB0/uEE/gdCzAn6JoVyaDPMbHVfQWT2QEFJNkv7eNhB4Bx7t53Fg1NnX
         ZbzyGysUtaImx4XSyh89oY7Zp/6IK3UmFXj8Xw8Wf2Pgmz4iHhuHC140OSzpzG4MGenB
         C0MONRT7/9h6WvjCZM5LfhWD5hV+rsSMnlM6FDMEGWntlDpwCsJ8P8t9yKybTdshtqs2
         33xA==
X-Gm-Message-State: AOJu0Yw/B8TGxQ0c1bsV1zrpEeJcXGngH3nJEEbgbdiKi1nntEX1Vs0c
	IK4TlZPu9Bsc7BPGInjNQyI=
X-Google-Smtp-Source: AGHT+IEYp+Zm8A8q/XEbDk4MVSB9Plo8V6RvwItqD+0cZQy3gVg6ozM4u4ZCdxZAOSIR65VslMyLXw==
X-Received: by 2002:a05:600c:3550:b0:40c:3e3e:4724 with SMTP id i16-20020a05600c355000b0040c3e3e4724mr143798wmq.91.1703196818498;
        Thu, 21 Dec 2023 14:13:38 -0800 (PST)
Received: from krava (host-87-27-10-76.business.telecomitalia.it. [87.27.10.76])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709066c8400b00a1fa6a70b8dsm1380659ejr.133.2023.12.21.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:13:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 23:13:34 +0100
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v10 1/4] bpf: Relax tracing prog recursive
 attach rules
Message-ID: <ZYS4jlTJ0k8z9TMY@krava>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
 <20231220180422.8375-2-9erthalion6@gmail.com>
 <ZYR9mrvFargzFlQp@krava>
 <20231221202437.gwpktfli43kdrcbg@erthalion>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221202437.gwpktfli43kdrcbg@erthalion>

On Thu, Dec 21, 2023 at 09:24:37PM +0100, Dmitry Dolgov wrote:
> > On Thu, Dec 21, 2023 at 07:02:02PM +0100, Jiri Olsa wrote:
> > > +	/*
> > > +	 * Bookkeeping for managing the program attachment chain.
> > > +	 *
> > > +	 * It might be tempting to set attach_tracing_prog flag at the attachment
> > > +	 * time, but this will not prevent from loading bunch of tracing prog
> > > +	 * first, then attach them one to another.
> >
> > hi,
> > sorry for delayed response..  this part gets trickier with every change :-)
> 
> Yeah, I'm impressed how many scenarios this one-liner can affect.
> 
> > > +	 *
> > > +	 * The flag attach_tracing_prog is set for the whole program lifecycle, and
> > > +	 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
> > > +	 * programs cannot change attachment target.
> >
> > I'm not sure that's the case.. AFAICS the bpf_tracing_prog_attach can
> > be called on already loaded program with different target program it
> > was loaded for, like:
> >
> >   load fentry1   -> bpf_test_fentry1
> >
> >   load fentry2   -> fentry1
> >     fentry2->attach_tracing_prog = true
> >
> >   load ext1      -> prog
> >
> >   attach fentry2 -> ext1
> >
> > in which case we drop the tgt_prog from loading time
> > and attach fentry2 to ext1
> >
> > but I think we could just fix with resseting the attach_tracing_prog
> > in bpf_tracing_prog_attach when the tgt_prog switch happens
> >
> > it'd be great to have test for that.. also to find out it's real case,
> > I'm not sure I haven't overlooked anything
> 
> Before preparing this patch version I was confident it's possible, but
> turned out bpf_tracing_prog_attach has this condition:
> 
> 	if (tgt_prog_fd) {
> 		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
> 		if (prog->type != BPF_PROG_TYPE_EXT) {
> 			err = -EINVAL;
> 			goto out_put_prog;
> 		}
> 
> Here is where all such cases I've tried are failing. Just tried what
> you've described with an ext prog (reattaching fentry2 via
> bpf_link_create with target_fd and link opts containing btf_id) -- the
> same result, as well as with trying to change the fentry2 to some
> fentry3. Does it make sense to you, or do I miss anything?

ok, I was wondering what I missed ;-) looks good

> 
> As as side note, I find it's generally a good idea to reset
> attach_tracing_prog in bpf_tracing_prog_attach when the tgt_prog switch
> happens. It has to do both setting it on and off, if the new target is a
> tracing/not tracing prog. The flag still will be kept during the whole
> lifetime, unless switched in bpf_tracing_prog_attach -- meaning no
> changes in bpf_tracing_link_release. If changing the attachment target
> would be possible, that would be the way to go.

agreed, you can add my ack to the next version with test fix

thanks,
jirka

