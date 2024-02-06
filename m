Return-Path: <bpf+bounces-21298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258984B1F6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 11:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F88B21694
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6D12D765;
	Tue,  6 Feb 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DyKJp3ab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E612D157
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214102; cv=none; b=jjmMoWaRs6QX43hRh400CHVtL2r2u4kodFHl3yL2xufZw1+TSG6/5/ncm1H0pnpaisQfyQWpucPtSFDcZhrDdzg44NJAHWfJcdjWaH/KM/QnhXL10xTYlqcoc9Q1WD9appc/iNmeXiPwad91iS9d0n/NioxxKMUc1pZGKcJRCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214102; c=relaxed/simple;
	bh=tGQ37uTY1Lgy3kGD13UiKdGI6UujpLH4vh3+Rklvt9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy1Fa/x0S+5Jr0EXgsjdyvwmiwVc7d7vfNOFmM0/7ZbnifKJx1XI/mYEr9bjcRY3nbu0c77CF8uteRuHUHJOIeI60907swNAdAeoj49EBSx9PspO1QjyDu7BBEv5Y0zAz0FRZtE6KjrTvCmJaD9srAmJniQAuCmjyVoWfyCR+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DyKJp3ab; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe3141e1cso3321615e9.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1707214099; x=1707818899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xe5/cZ6Aod/98ds/+MrcL5uP7C5QI2K9vnunlSg6ll0=;
        b=DyKJp3abY1vSBqoWB/gJrcfobgwnE+ykg6F7sya2FgCd4O6FFj9E58/eH0oVusCLjH
         SZHQz+mnZNuH2pgOcnv9bf9O0j1i5PFAH3sLvUPBs7SpqnbBtzWqLWn6jDIVx1FL3CGB
         8yrY1AitoUtiahwGCozWxrutnpzLYdZrvJfdmumEVAK+n3c8SzppNa2Mp22FsZB52os4
         76IKFWvOFlFac0ueHdLMY/AMF2DUjeHi4PoJCCE5Lg2b3FBEXemZs7aMuIOajW/Ehowo
         SHsE+c7p2C0DpRLPU3LlPX9s/A5ObCC6hJK0gvwj8Cj40J7c7UYuRGfjMipIcKbgB60n
         XfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214099; x=1707818899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe5/cZ6Aod/98ds/+MrcL5uP7C5QI2K9vnunlSg6ll0=;
        b=dLnt2BkJZZeo63TiWTyehHxxP2b9cWnTkcJwU4OTTV9c9FRjm6PH+4H46M5aiJXAKS
         07yaRG7eyJaa9MS4OvAOrR4UvNi7bABHDr53CIb3CpnQ7vTKMEzUy7/IBTsZdqNFQ/Q9
         3F07qf6LH3vhIWGM5cO8WDZ56i/rPahOPULnQ1ZdnXz7WFY4BWIPHTPqEmXi/Y6jY8X7
         vV2yPKsqfbkQpRszYUDbgGT3J5Cz8CQZYh28mZQd6asMmYlIGZrcHNAuea17nz6QYeay
         ql7Dc1PF0YO3szj7GaumI7PzmXyNCmACuhwrUTvdHPqOdDelJVebxJvfFpDZ+O60cvxE
         9b1w==
X-Gm-Message-State: AOJu0YwedoZUZDTsrwMYPjr458jEupOkG3OasJVnIJ88VjNre/q2AIqA
	psYyuxQlIyt/ZO5l3Gfyd8aJVuRPcbIf97phXU/pi2tonNm8420ZGcsPfI/ggHI=
X-Google-Smtp-Source: AGHT+IGuXTyALI6Fe9Af4M+1Lkar0uek0WSyDAl9tSS+HPRw86QdA4/7H17D0Rl4eV/b0snwzjkSxQ==
X-Received: by 2002:a05:600c:4688:b0:40f:d1e4:6074 with SMTP id p8-20020a05600c468800b0040fd1e46074mr1242518wmo.8.1707214099090;
        Tue, 06 Feb 2024 02:08:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWm5HtxcFG6M/BJuCf/bBCN2b9ZReLoDkQNuR7UUdTjQfwIy4uZ4u/Tu619NUzg18bf2wc6tqajd1KQjfJUwtJ0KcTJsWNAFzK7ZYPiTfXYBtUl/ZzIpoGtSt4GIdxZ9uhJQfi7DuVoSkRaA+wSEmDxLci4NLGFY4Mz/x7BRT73pIjEe9WS47QJLwKRfGfQblDyGabDMRbF9VJv5MRbFendv3z4SWX78v5aT1oRf9EzBm1LmcxeQQMt6MSWF5ckT4ATY93MnXhX5a7azC6DpSV6ovCVZ350SGmCVGjInlZIt0O/FDJcdJw=
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0040e9f7308f4sm1488599wmo.10.2024.02.06.02.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:08:18 -0800 (PST)
Date: Tue, 6 Feb 2024 10:02:18 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
Message-ID: <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
 <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>

On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4def3dde35f6..bdd6be718e82 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> >         };
> >         /* an array of original indexes for all xlated instructions */
> >         u32 *orig_idx;
> > +       /* for every xlated instruction point to all generated jited
> > +        * instructions, if allocated
> > +        */
> > +       struct {
> > +               u32 off;        /* local offset in the jitted code */
> > +               u32 len;        /* the total len of generated jit code */
> > +       } *xlated_to_jit;
> 
> Simply put Nack to this approach.
> 
> Patches 2 and 3 add an extreme amount of memory overhead.
> 
> As we discussed during office hours we need a "pointer to insn" concept
> aka "index on insn".
> The verifier would need to track that such things exist and adjust
> indices of insns when patching affects those indices.
> 
> For every static branch there will be one such "pointer to insn".
> Different algorithms can be used to keep them correct.
> The simplest 'lets iterate over all such pointers and update them'
> during patch_insn() may even be ok to start.
>
> Such "pointer to insn" won't add any memory overhead.
> When patch+jit is done all such "pointer to insn" are fixed value.

Ok, thanks for looking, this makes sense.

