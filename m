Return-Path: <bpf+bounces-30803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073688D28C6
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D81C2439B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7A13F437;
	Tue, 28 May 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KumCt2Tl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5C22089
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939601; cv=none; b=Pd2EZYCmfpTqzzU8pB6tSJ+WPnhIq59jk7O1+9fTaLl55kJidVLzEqlOZFQE8cv4FtMyTzRYnfsuGoZxgIVJVX1uOzum91HFFP9RD6vSH/X2AEJauMhTS0dVLkTMLHYq8AtoQDMvJbsi8k+p9hp0MtJIr1Dak5a+n1La80X+UjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939601; c=relaxed/simple;
	bh=kB5tuUqjLRUqqDj1Rg5dqu31D/dBHOb60GCOBZ/z+jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozPi9lJojvFGkilQVjAPXDo8aQ41U8eEAxCAQnDZSJBlNEBBcMZzPvXLYoSpnbiNyioeRs8+oLMsP0xplOAnUqQQZr+NAd6Dp2GFL1NH/pf9+Ha+zvAQASOwfYOnweqv+SU5cj8gEyFsTqkcsJ0bFJCcLsG7xf9bG1GWeTGR4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KumCt2Tl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bdd8968dabso1100539a91.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716939599; x=1717544399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMly0QYFkblCvCneRrdC4u2AsHXzoJ4vYH/L77APNAE=;
        b=KumCt2TlfXlZ/fH7fFvlTu57Eo26AJx/DX9AAGIlG7Wqfet34CCkSOcRTjnKuOi2v+
         SUXd/G+duR6CP1NJYxxuHDDAYL5hd3k7ZvXmowNY0OqNqZka/lChU1gbZgrtakd8zCIO
         X9LgdZ3BwINudyAuTDoDmNfe4dUWhQbUBtHs7TgXywpq1OB9XTIhQJg0/3rJXpokJyrz
         Z8EQ3RZawxJnmojO3VcLXfOfScvb6vQwBm6X1s8N/PTJkOxXH5ZyP3c8+rtjDoQpKrTM
         0SiADZJxc1Np208kjnh6wqnMf2LFDXlDjLl8quPf1ElWeB1OeSrDZ8S+kvwghB3TNhaT
         1Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716939599; x=1717544399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMly0QYFkblCvCneRrdC4u2AsHXzoJ4vYH/L77APNAE=;
        b=waNNjTT2sQ+aR8+uS1npKALstDf09eTJR6k+cRcwuBMusS++bL+bsyy3uEo/YoJvgX
         EK/NWvFGGj96nQQx+0eE6y+7l7aAg++jl/w/BSknA7Wt4OBWBMOLBeBTCFx0fw15hTAN
         FnT9Fnrv8baB48YRgYzFTVJPvz3E2URsTGaOrwE9CJVXdRjMuNtd5IMrk5glJVOy71AB
         WDVo4SZriBwAb6qthNnEj216ZgYb2Z/3CC3+fXYkFAHlU7MbhoLU3Eh4ifeFTOBSP84x
         pTFHhoyFPKcAPMNsntl73ZhXrGdOrOEBxStTU700adVvjjnSAe51bLLT1m2dS3QwsMiZ
         xZHg==
X-Gm-Message-State: AOJu0Yx2s7BkZrjxWE6WAUS8J3R80P/wVinMvNVdMfAcyOIriX62dOY5
	oV/dPJ+/2FBwEf1gzbLUObcNbnDwpuNqvnpPFg/HqcmbTkYz9Z/rpPM1Pg==
X-Google-Smtp-Source: AGHT+IE6S2eVjoSPtrE61ZgUKUWN1SdTRRpLwXUIqIlKdIXmtlBghKMCHHTIL74m3tnSgePIMnMdPA==
X-Received: by 2002:a17:90a:d713:b0:2b0:e883:270e with SMTP id 98e67ed59e1d1-2bf5e66023dmr11332841a91.28.1716939599022;
        Tue, 28 May 2024 16:39:59 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f0649asm10251177a91.25.2024.05.28.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:39:58 -0700 (PDT)
Message-ID: <75b4d63073a29c9f3bfaa788931764f9085663ce.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit
 queue and print single type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, alan.maguire@oracle.com
Date: Tue, 28 May 2024 16:39:57 -0700
In-Reply-To: <CAEf4BzY=uJiZGp=05qd6hOh8QQw+SgYCYH2V9KEt90xEckeo3g@mail.gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
	 <20240517190555.4032078-3-eddyz87@gmail.com>
	 <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
	 <dbb51b28cfcecc8461f9fe002869ff3206eaea14.camel@gmail.com>
	 <CAEf4BzY=uJiZGp=05qd6hOh8QQw+SgYCYH2V9KEt90xEckeo3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 16:19 -0700, Andrii Nakryiko wrote:

[...]

> > > > +LIBBPF_API int btf_dump__dump_one_type(struct btf_dump *d, __u32 i=
d, bool fwd);
> > >=20
> > > not a fan of a name, how about we do `btf_dump__emit_type(struct
> > > btf_dump *d, __u32 id, struct btf_dump_emit_type_opts *opts)` and hav=
e
> > > forward declaration flag as options? We have
> > > btf_dump__emit_type_decl(), this one could be called
> > > btf_dump__emit_type_def() as well. WDYT?
> >=20
> > `btf_dump__emit_type_def` seems good and I can make it accept options
> > with forward as a flag.
> >=20
> > However, in such a case the following is also a contender:
> >=20
> > struct btf_dump_type_opts {
> >         __u32 sz;
> >         bool skip_deps;         /* flags picked so that by default     =
  */
> >         bool forward_only;      /* the behavior matches non-opts varian=
t */
> > };
> >=20
> > LIBBPF_API int btf_dump__dump_type_opts(struct btf_dump *d, __u32 id,
> >                                         struct btf_dump_type_opts *opts=
);
> >=20
> >=20
> > I find this contender more ugly but a bit more consistent.
> > Wdyt?
>=20
> You'll also need "skip_semicolon" which makes this even uglier. Which
> is why I'd not do it as an extension to btf_dump__dump_type() API.

Right, forgot about this one.
Ok, let's make it `btf_dump__emit_type_def`, thank you.

