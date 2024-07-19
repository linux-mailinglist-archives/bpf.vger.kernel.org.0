Return-Path: <bpf+bounces-35127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F4937E0B
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B401C211A3
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E01487F4;
	Fri, 19 Jul 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th0EcTkS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97493A35
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432456; cv=none; b=DMQGpB78ReCeqN5HRM3j7dcBGEinFidnGXB4U1KhHNfBbJqtPtFnkD+xOQXoFuoVAlBHsp0KzMSdMMGzBG9afC+uGNJRagtFaNddTDkqU4Zs3Ha3kNbK09Trjvmii0AS2IJ+BdOSFiQNBMaTdhPWKhuYR6lfZVm9WlMfTrsjaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432456; c=relaxed/simple;
	bh=PmHzgJlE8nPzCWbmJgUcyxSLOlh0CYiTeIxD7f7VH1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4FXcTCL0miDXuGGyXEsP2CL6N691ivILTcad6yyNWqq/9CTp45iNWW9ZpCPxBKl6sDzJHOzcJn70jFTUHaVRYAw3X2ryZIk82dqklgpqMGwlBfUIVOR4XvQSEpkQJy3DEEiSU/CkSoRcXxvimogjSmo84fMJu3/wCugZIN1nKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th0EcTkS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so976302b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721432455; x=1722037255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HAHmzs9ubZUZYXApR2F6Ml1S9gT1jwAeiQnAbIVjexo=;
        b=Th0EcTkSQMHmuLf0oyKAlxwYjdhZJE5l6MkPUao5lGXivmY9OITzagjMHCzOHMI9rd
         IffoAnhfhuVdjGOpVjnE4Sew96Fr80NBaNsh0BHiV0l6v1fxc68GRfz4jb8pkRTjj370
         pmFb3Uolxzi+lpokwPKyIPAIgWTJxhtgPYfcM1XUHE06Qk5PQHEvEyIOmxixsFjaYUFF
         TnqWeLKDB7dqNBsmgTZTQ4DATCe4uj82ofzyU0krduKRGGwRUkSyVDgKdKFqRmr+Lu1H
         XZsP9MRNGFle0EAIbtmQFOmcfLBZme9Y4Ad/v/n992uWIVs5mcKJOMIrbn9Uw16Q3PLu
         Tg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432455; x=1722037255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAHmzs9ubZUZYXApR2F6Ml1S9gT1jwAeiQnAbIVjexo=;
        b=vZ2Zh7S890HYzfzpeoBXaLq7kdgaiyx097l0HTjJimXrqwPJwkTX3u5hPjOhq5vfii
         WTSJBGnTxaqzSLH/lUHnCtMr0fCMR9675NaS+ir0R9GIV12SRV07wFKeT9KvN8M3hQWr
         JKU/DdjKQ3RmYEZrbRB7HIu+y2O4DhR+rbwGWfRgCOeW6xjbAUPpjmdzvLKgOJQNZc5V
         EkG79/5fTdDYSTj1P98gbwadfUjLFqlCl1paSzT7/zxcNiJjkOPYQ3liuHC4LRxchnzJ
         yYHYwIBheFJWkYec9MWRF7BRceieLjCi+Lb+FS4Hu00TI0m15nMtNxWyRtiZBSJPEG98
         nFRw==
X-Gm-Message-State: AOJu0YxkS37N51AbJ06xABtmOkEQl06mvWIcAlR1alAQC2OQRF0ZbFdx
	d10ST6ULfoBKKoi3JeKAUQzQ+Xh3Yel6iod8AiNqmtP+CiCI4sd2
X-Google-Smtp-Source: AGHT+IGHMhb9jyXGWP4/qsF850KHznUI4Is5NFMlWN/t2+ZcdVbIzb9u5YHe5Fk21st+2g20nKOU5g==
X-Received: by 2002:a05:6a00:2d07:b0:706:671f:d252 with SMTP id d2e1a72fcca58-70d0862f99dmr1875666b3a.26.1721432454724;
        Fri, 19 Jul 2024 16:40:54 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff59cb7dsm1778232b3a.144.2024.07.19.16.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:40:54 -0700 (PDT)
Message-ID: <e10d476b192b32acecafa73392f2dad97419536b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Get better reg range with ldsx and
 32bit compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Fri, 19 Jul 2024 16:40:49 -0700
In-Reply-To: <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com>
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
	 <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 15:46 -0700, Andrii Nakryiko wrote:

[...]

> > +       /* Here we would like to handle a special case after sign exten=
ding load,
> > +        * when upper bits for a 64-bit range are all 1s or all 0s.
> > +        *
> > +        * Upper bits are all 1s when register is in a range:
> > +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> > +        * Upper bits are all 0s when register is in a range:
> > +        *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> > +        * Together this forms are continuous range:
> > +        *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> > +        *
> > +        * Now, suppose that register range is in fact tighter:
> > +        *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> > +        * Also suppose that it's 32-bit range is positive,
> > +        * meaning that lower 32-bits of the full 64-bit register
> > +        * are in the range:
> > +        *   [0x0000_0000, 0x7fff_ffff] (W)
> > +        *
> > +        * If this happens, then any value in a range:
> > +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
> > +        * is smaller than a lowest bound of the range (R):
> > +        *   0xffff_ffff_8000_0000
> > +        * which means that upper bits of the full 64-bit register
> > +        * can't be all 1s, when lower bits are in range (W).
> > +        *
> > +        * Note that:
> > +        *  - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
> > +        *  - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX
>=20
> ?? S32_MAX =3D 0x7fffffff, so should the right part be U32_MAX or the
> left part should be 0x0000_0000_7fff_ffff ?

Oops, that's on me, yes it should be 0x0000_0000_7fff_ffff here.

[...]

