Return-Path: <bpf+bounces-33681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C09249E5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E7728521C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D137201272;
	Tue,  2 Jul 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdxzmyZ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A617201279
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955370; cv=none; b=JrCCXDd+aBVrRcegjAFVnOcw727M807Xlh5EHdUZAUCFP23GiQDSjOJA2+6PA9GLTKXSAae8njr9TBg0NTLzE8zbz6+HPhaF6dzfqbg8XF+LEC/sSaHC0X0a3N5U82rwEgGn7IpKG0ORBD1Y3n6Z1PjLlRNIW2bka336qZ7905w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955370; c=relaxed/simple;
	bh=VDheldbkPWxAkGsFkNd6jaCFwX1YLwiRGou8baFwB50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATQxWqEFknJIs9J7KX6JgZ4iOnMw5+pCipicSBnBDpDDSpHoXiZ/4EzBDx+JXdPi7vLDLu7+ctZpgjCh1F0x03cYuwKurfeC7pY88HgmtN8G668JHKJ+AxhqUv3wWng1bl9w2YwFLTcDTB0XMFDR/XQ0L0tUXhTUYxfQ6GVyG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdxzmyZ+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066a3229f4so3094807b3a.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955369; x=1720560169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDheldbkPWxAkGsFkNd6jaCFwX1YLwiRGou8baFwB50=;
        b=OdxzmyZ+z/pfm6IlX2mvknZqVkkqNuMRa+TemB2tIQEA48IAkOOUqcqeVO75VCN4JA
         Q8KZHwRi3n+0o8Om0hiKkMurcewIb6Oj+LnAfCgQ27uOYGUcb2aCzOIC7QyycX2dACJG
         asgcsNNyTBZYPFtDVgwbC5rwwfBxRCK5rSn4EKVOQszEhY+apqrQ49jyLMFelCqgJXq9
         XxDFSNSKQsxgMwlS8PNYFFzo3G6XiblGFmUnfSS5WwhLAmi7O+lpObG7WWXSV0FxF7JT
         Yx7pcDX/SQaXKZ7jIT0hcJuqacoy9H/pSLU6x4lCPO0mfbLL5BkAS/pC3Ma8Fc66zLFM
         WXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955369; x=1720560169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDheldbkPWxAkGsFkNd6jaCFwX1YLwiRGou8baFwB50=;
        b=kse1oZiNCIpAKYz/UbLBlMIYgbBmk3VW2fQOsytZ6K46+gA1Ei3vKlkv+ohhnKbYCO
         BaBUxF0osiMAVy40VJOhFH5hURyUV1OWPtmVUfyPLPvLmPvEbAg27PGyuzSktRBaWua7
         wIYSdZDYAfGGXGQrj16L7w3R/9LLPKLJeoLugNzVLfQ71DLEoKGp2YPsQTdXyPoAGSyJ
         spS6CP0e828fro7rP5yASz86kxwdJJyGCUylc9df3z6RdUz7r/4eRl6HVuOQH/Fpq/To
         ZlrCIwZQdNIR25S31hAk9Cuf6DjDtoNvB5KzDkxfIOLFg4jC3syXMVksqTjZJCG4r/No
         882Q==
X-Gm-Message-State: AOJu0YyWPJ3MWUjacNZY0ccZp3uJGxvDQwVFGsFSQ5QpR31HTRYD7hRI
	LvXrmJ1qZl0wL3tnYsKpik5vPrjPa32ko+bn5Shd8jywCP5lhGWSsdI8ECBh0+9NmeHjNojh8DL
	tUNwe4F+FTpD0SMjGcRq1OHzwkK0=
X-Google-Smtp-Source: AGHT+IHw/gfhMmwiQe4lSEL4djVOA/yAghS7HT4Sr9kaF1j86dCo+nRmdKuAEPIY+XjS2Oa4M3qn8BaZqHJHOv/75GE=
X-Received: by 2002:a05:6a00:3c8d:b0:706:67c9:16d0 with SMTP id
 d2e1a72fcca58-70aaaee4715mr9962818b3a.26.1719955368693; Tue, 02 Jul 2024
 14:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-3-eddyz87@gmail.com>
 <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com>
 <806fe5b0940a8b3e60a9c5448ec213b23107e3f0.camel@gmail.com>
 <CAEf4BzZPyZ=HWDeYXwjS1q5C0pcKmtQ5_pt=hQN9P0W+Tb+L3A@mail.gmail.com> <f9577edf4ebf9c730a93d756553c4d9eb92b9fb3.camel@gmail.com>
In-Reply-To: <f9577edf4ebf9c730a93d756553c4d9eb92b9fb3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:22:36 -0700
Message-ID: <CAEf4Bzaj86gD1QCbDijmz9VoA0jWTp1is6bcUJtT2O9fQQzpoQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-07-02 at 14:09 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > you are defining a general framework with these changes, though, so
> > let's introduce a standard and simple way to do this. Say, in addition
> > to having arch-specific bpf_jit_inlines_helper_call() we can have
> > bpf_jit_supports_helper_nocsr() or something. And they should be
> > defined next to each other, so whenever one changes it's easier to
> > remember to change the other one.
> >
> > I don't think requiring arm64 contributors to change the code of
> > call_csr_mask() is the right approach.
>
> I'd change the return value for bpf_jit_inlines_helper_call() to enum,
> to avoid naming functions several times.

Hm... I don't know, feels ugly. nocsr is sort of a dependent but
orthogonal axis, so I'd keep it separate. Imagine we add yet another
property that relies on inlining, but is independent of nocsr. I guess
we can have enum be a bit set, but I'd start simple with two
functions.

>
> [...]
>
> > > > strictly speaking, does nocsr have anything to do with inlining,
> > > > though? E.g., if we know for sure (however, that's a separate issue=
)
> > > > that helper implementation doesn't touch extra registers, why do we
> > > > need inlining to make use of nocsr?
> > >
> > > Technically, alternative for nocsr is for C version of the
> > > helper/kfunc itself has no_caller_saved_registers attribute.
> > > Grep shows a single function annotated as such in kernel tree:
> > > stackleak_track_stack().
> > > Or, maybe, for helpers/kfuncs implemented in assembly.
> >
> > Yes, I suppose it's too dangerous to rely on the compiler to not use
> > some extra register. I guess worst case we can "inline" helper by
> > keeping call to it intact :)
>
> Something like that.
>
> [...]

