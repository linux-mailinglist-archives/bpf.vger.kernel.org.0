Return-Path: <bpf+bounces-68420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3083B58546
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D764C1FF6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2927FB34;
	Mon, 15 Sep 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpKeiY7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EE27E7FC
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964542; cv=none; b=Nwyh3PKgnrU7Gz+q3X0cppKxAAjTsGFMoBLpFP61fmpjv3qbt+owz0/guSmJ08Q2qjRvNHxTBnEQvp2+y+6umHtTufvoHxpEOLofN6mhwKu4vQ87ReRxO12DckAlELTf5OrZZxpkPEkDckfjVtgEK8YafsIhzU7iOZ2AmI/9khI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964542; c=relaxed/simple;
	bh=3+LSnB0hm77WzzZOWxYhRFi0LkYXmP1scLAe0mnF6WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsXE5lp1gJTzJolkfoVHsW3mNU44JQBt6EfOs7k6h9/XZgDmuFQxImltOis0ljst2ovEHXJZlxUNTGbKmdnsIgNb9X9y2nVh0QgYT7yeWd1yPn4CW+wTIMNFEs6mgpUuqJ8NcyphBsKOSzeHREcRwH6mQYe7SoAFXbwkZKAygXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpKeiY7L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dae49b1293so2604019f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757964539; x=1758569339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2xMlKKm6nf8tRVENFk2G2ikqGpzESVbYPn0Gjm50Mw=;
        b=TpKeiY7LkvG+K3u/7LMpTZc/KBxGPEqrgi6h2WDFBYKEttGiLkbDVuIPn44ZCV8nGN
         HlGsn9r32phvvT/deJcm87Y1Burqmd+2HwEDV6CltsF0UIoumDJAlj8yH1pwk9qFLbkL
         eshMlyZ2ZDvxeFgjpONXNzXM5hsimpbDOiNqNlcQ4yYt66y2bIQ5rN4nox4x4ZCEhQnR
         VNd9W/kYzze7wNiylFPbho6Xzfh0DBClfHSKPpxcLUkKtCaGRnFHjHOa/WxkzVPn9+DR
         bI1pl2tJ3mvXoE+y+vsOdPN/X3+VCwEySE1+FMQtoBqY1cbiz4fXd9kR/p87lCxgPLpg
         3zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964539; x=1758569339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2xMlKKm6nf8tRVENFk2G2ikqGpzESVbYPn0Gjm50Mw=;
        b=K1va9Lor6F55mIwnlKKkwrtg9CC46LZd4xMG+i7CKVKGCfk7rgSwibkdThs5vuwJJn
         OncKcCR+SZzH8p24pJpZMW0mQ0JvU2A9axl+p3XyUhKZipkIJ6IfH1Ul0Wf6mot9YY5L
         KJwV/F3DJeOKNSmpjWDOzJCk/HjcVW4BmXabNo8fhTczPyewzjU1xT2CT6K/ZfWgCXvY
         JU0IbV4Q3nEMOAvA4wRSjdo1W63cB8gWX1jEST6apZh/za0LAhpQxfvVWXMxZvHB/sYm
         mKFaSD+wU0h5z1DCtPxX+Q1KZm8XjJFT2XYBxwPfXVJfoO7IiexjlxkVuLOizWlMIKMq
         puWg==
X-Forwarded-Encrypted: i=1; AJvYcCWTsNIENKjEVRUuWIDiANWTjLgNGW8L2ZNpf73ZddmGq7yPH2fVJny1pOorOYCSsP4KXDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIeKABy0MwgNcnjl75m39WN3B8wn7fLb9zob7Chxd43LmgDcT
	EknqAUNho2GiO1AjIx8SrLc1PLLVYr4V/bS3HsTihRO0iL3U+PdrdEOkBZubVx9LUG+djl1nHkg
	x6/6oiiGieaiqcdbx6OTK6mz+gDLDBqc=
X-Gm-Gg: ASbGncszQqIXJaIIzTeHhixCIrPqi126wqOgz1pEpiICC6XgyB5lQYxexkDxIwZTs8C
	f1heRm4KLXpRE3J7CNkFSxIFZSvkfFWC1MCxtVim48EOLCfbjFf0oRrwuEor9sS4LlhfRbALjIM
	njj3b/v1BdoXMHzIYkbRhPBJ13dEzbbhySXx5+nlOxuoUN08NXRmqOLFelAm/eGWKfewOc/j8gB
	C7nC0pcX4deku9URsGttOEQV54sejRJMQ==
X-Google-Smtp-Source: AGHT+IEcmBIdCHPVUTeRbmBWBEydiOQEd4gmT8QR2t0o1lIJhv4unjkClYcHgiiTNR77Rdx3KRAOKCKWxA3Q89LsazE=
X-Received: by 2002:a05:6000:609:b0:3eb:c276:a340 with SMTP id
 ffacd0b85a97d-3ebc276a59amr2864751f8f.5.1757964538384; Mon, 15 Sep 2025
 12:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-patch-insn-data-double-free-v1-1-af05bd85a21a@gmail.com>
 <fdc291d2-ec13-4a54-9fad-bc905edf4ff8@iogearbox.net> <f8337cf1b17b9bf2ee31ebbb5f79ab7290ca4263.camel@gmail.com>
In-Reply-To: <f8337cf1b17b9bf2ee31ebbb5f79ab7290ca4263.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 12:28:45 -0700
X-Gm-Features: AS18NWDdJ4UVYcL4qk414ZiFdyO36URvs1dQac0SdDT_9RScJm_ncYdwFRsdz_M
Message-ID: <CAADnVQK5hiTLOjh9RUk3FxRJ+p2Rf4zkj0+OO6QBtAZS28dEhA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: potential double-free of env->insn_aux_data
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-09-15 at 13:42 +0200, Daniel Borkmann wrote:
>
> [...]
>
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9fb1f957a09374e4d148402572b872bec930f34c..92eb0f4e87a4ec3a7e303=
c6949cb415e3fd0b4ac 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -20781,7 +20781,6 @@ static struct bpf_prog *bpf_patch_insn_data(s=
truct bpf_verifier_env *env, u32 of
> > >                     verbose(env,
> > >                             "insn %d cannot be patched due to 16-bit =
range\n",
> > >                             env->insn_aux_data[off].orig_idx);
> > > -           vfree(new_data);
> >
> > I presume you mean bpf-next tree, otherwise we'd be adding a memory lea=
k into bpf tree?
>
> Hi Daniel,
>
> Yes, the tag should be bpf-next.
> Will resend with the correct tag.

No need to resend.

