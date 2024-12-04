Return-Path: <bpf+bounces-46066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A319E37F7
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E13CB268BB
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072341AB507;
	Wed,  4 Dec 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="FzeEJGNr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CB63D
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309263; cv=none; b=NnP60x7KMCs1GsYu+oj1Gk8gO7gd9LOPGHnewD/ehXjdsWFDEx7BSaXlQxH1FEj2Y/kZ2JqMDgf9oluWFOvTr+tq5prxtOJnjYh3wsNxgxrEWVZvr75lANUduxOFGV3E5FR8WAqhMIh/YinGtIrv3AqX+CcEskC+xoUWhvFIuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309263; c=relaxed/simple;
	bh=rMSvgsSUsz8czV6T6l8LpiBwRyphmI6ZNZt5Kgxx0N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrjo2uVLQj/h7sqSDZHy97mszReceyGPE7+M+3up5qDE5A8cVHT1sjdPHviKW0ZkiztgPOf1cBjqC7GXVtIjzrhRA8+XMl1VDxOyX2wZAdQMvpZSCWtxS/Crj/cM+p4hH3jqgHSCFfWrzB+kJwjjE5HwU477AB3XhfgalEGV1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=FzeEJGNr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so59872865e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 02:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733309260; x=1733914060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=diZPYTprocSq4BVat0JzeqSWsTejuM3edUNZvLixG94=;
        b=FzeEJGNrY3b7DZ6Sf+uGgs53qPtTko3zR1yvylGK4blEXCh7Kw+0AjenzckCi37JV+
         x1HMo1+Y7JBxcW745LWkfv49Mg85aoc8gVYCyDIUwcpqrU1vkM+QZYcsBNxcqaRWB+V2
         cXBmE0LmCo50RjgjqGbr1D0B/kRY4Zla93XyCJSYmrcj3wMKmoZ66SFNBgz+U0kyrbmc
         N5cKNO7pZAG0P+/RYx2ELhPLNCPz+1tMr9KlIoHBOXmrba8CFb8W7vzHHfRgNltTSDck
         SGwvq2ZMqRHXOx8NpViWNYpiBRCwBVX89iMv2ERppQ2vM5qUwEFqu+fPpq4buoPPo1yZ
         T6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309260; x=1733914060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diZPYTprocSq4BVat0JzeqSWsTejuM3edUNZvLixG94=;
        b=quFNq4KZKpeB8BjU/i1keUis1ZB4Ib1couT+EtIomsJvvK1AJ7z1o+Nc6r+JZ7ibrv
         rfAI/g9ZdQxVMJoGpq+m6Y2rlAT5A7D6wPFtk3Kfe2DzpOj6pkmAS/L3RuWFI3Nchqm2
         OugeFwFpealN/VwZstfUoEv4/72C+O3t4zA4kRz0lP3Y1akI8ExMtw06gjECxoAhI6y4
         JZLelCTqQkkHARpznS5uC4rQHwPcFMxMQpSaa+tGGY9Ti3i/qxG1oQpEjb+O/auJbAGc
         AGz1AQCVlROk1vk6AR3n8/7ZCZTaLlQutU6XymJ59mpqRMDwlmrfNGDNHjRPOVVRxOMJ
         aA/g==
X-Gm-Message-State: AOJu0Yzy/DenUL3/Iyl4cfs+uvC9vfV0htSoR5p9nxfHPF1cMiP0WYyN
	RTHnWnWJtXvrrVHn+xCR5G5KhSzx+u/k4qNcFSTWA65U8PvcJJjKr5Kp7Dk98mK06L+1OC+l2ET
	Q
X-Gm-Gg: ASbGnctTi+37sf/m2yMxYEtRBjjrA3mGXaunUj+icqbH2d/2t9KlcSwnAX+K4IiOHG7
	F36aNR8lYiydrJVA2RBJiWekjlG/6yQgvj/ye2oPqvZmGqsca5dGfawvnbXaVIZaQepCsHluVtP
	H4L/QXbB3DK1DzGB68zLQ+R06fyP3TpyRDIxV6j1G8FeXU51QDZZ8h6Y4yYI3w9AMZpviT16/RI
	2u2829jRBmVTvhtBga8Ot7TCnSkglCy/nh04GM=
X-Google-Smtp-Source: AGHT+IHflaJ1KNNcIwGv1Swm818E6HOBJzZQDWq9Iz4BP+bx90+sixju7urFNbsQEjIaMCXlMephtg==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr59474215e9.30.1733309259979;
        Wed, 04 Dec 2024 02:47:39 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5288264sm19818605e9.19.2024.12.04.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:47:39 -0800 (PST)
Date: Wed, 4 Dec 2024 10:49:53 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/7] bpf: fix potential error return
Message-ID: <Z1Az0SDbjnGDO+mB@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-7-aspsk@isovalent.com>
 <CAEf4BzZmNK6FXj9aUnqUj3fVYyp=ne2X3uodZHnarrP_CbJMKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZmNK6FXj9aUnqUj3fVYyp=ne2X3uodZHnarrP_CbJMKw@mail.gmail.com>

On 24/12/03 01:26PM, Andrii Nakryiko wrote:
> On Tue, Dec 3, 2024 at 5:49 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> > error is a result of bpf_adj_branches(), and thus should be always 0
> > However, if for any reason it is not 0, then it will be converted to
> > boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> > error value. Fix this by returning the original err after the WARN check.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> 
> Looks irrelevant to the patch set and probably should go through the
> bpf tree? I'll leave it up to Alexei to decide, though.

Sure, I can send it separately, if needed.

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index a2327c4fdc8b..8b9711e6da6c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
> >
> >  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >  {
> > +       int err;
> > +
> >         /* Branch offsets can't overflow when program is shrinking, no need
> >          * to call bpf_adj_branches(..., true) here
> >          */
> > @@ -546,7 +548,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >                 sizeof(struct bpf_insn) * (prog->len - off - cnt));
> >         prog->len -= cnt;
> >
> > -       return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
> > +       err = bpf_adj_branches(prog, off, off + cnt, off, false);
> > +       WARN_ON_ONCE(err);
> > +       return err;
> >  }
> >
> >  static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
> > --
> > 2.34.1
> >
> >

