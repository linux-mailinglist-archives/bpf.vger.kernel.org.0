Return-Path: <bpf+bounces-34271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AA92C326
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1F1F23BA5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB417B053;
	Tue,  9 Jul 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDd8v9c7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60417B04B;
	Tue,  9 Jul 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548734; cv=none; b=iAeYQZJ2d68IBmnpd2m07V6opB2cKCgIItIhiiX73S7jfzhRiy3F3r1+RWwRoTIhqW4y8N++Pr1miR6jh2lNzbWc+rP3Y+DtSVqpfaLAcIhkhvROrG3PjI8hqKz3/oDXMsJhYqHvwGENGdtObmu8zc6rpih/CM/6aM40q1yb+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548734; c=relaxed/simple;
	bh=158cZUlmlIr5dPwD52dAc3U5dHPzagtOg3XpKlSlH+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVoQXytFu45eYRXPYWnvLGOxbK/TpIMBQopN1GLgusfHqj0XYOUSJ8e/PJbjf4OVonOR988hvSLP564IxECGZUOXtVQeTmTwvBiEfYuHdmo4Ik/RkZdUFhGeopemflkanFSt590I2IDfm8HuGTUvnXurGvL73ac+94xsNdGUxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDd8v9c7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3678aa359b7so7505f8f.1;
        Tue, 09 Jul 2024 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548730; x=1721153530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=158cZUlmlIr5dPwD52dAc3U5dHPzagtOg3XpKlSlH+E=;
        b=EDd8v9c7iYOYWW2o3atSssoL7UPxdE9qYxEWZojhN5P8WLAYpmUPuS9BxbsWAeU9Fo
         wy9EDrDk8WiE9WpyG9B2FKyuDnn1Mn8zjsQzSpsbPoHokaxrMn5bGWMffI48spQ+7WDQ
         0xMwSyDDlNkHsRnz2YFvIEBZnywsjmHMb4W7XQRev73CFNuq1O+07ucXqzO5acgaIdLy
         6p03vhU/6AxrXatN2hqJgrz7uNCzMdb3yrZ1PxN71UJeZcp48aQc0FuouJ2IGBd52kG8
         R06AaQY03LjZarsIAQceYl2Lt5SIDpL3NQeVBXJB+tPjuoY07t5Ia/5dkl48hRYwgfAz
         0fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548730; x=1721153530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=158cZUlmlIr5dPwD52dAc3U5dHPzagtOg3XpKlSlH+E=;
        b=KaTPSCo6SdaUTWn5h+IX019XLlx+pMg8L2pu9OtLQ7VphdWW+0KpyP7x0Em4+RKZMR
         eiSqXFX/ecwWQPoI1yieDY2IpCTdUOGVgamSssx8cXZm7yVvfgQR91ZNiifq74mxmjtq
         LE/42Hvrqzx1EPIXiJOcOn4LgrltPnST1wRD5e1wwWEeIC/m2e3DqtWcUndfUvElCd+3
         0QqMQZ2EZthpl4dbj+Z7plTEkBZ8dw0j9psiZdwUKl8lDQagi1Ei9u+EjzbeMzJDfeNX
         6rBAsAqCd80yx6J443K7q9mOv864wLdkpmtJ/hbJxkumZrbF9rf93fFCjoqN9gfq3qNx
         exlw==
X-Forwarded-Encrypted: i=1; AJvYcCWTFy28xphfYBGJpAuApnpY7KBRG628PsjDQhohplYAstR9nO7T8qxfUEOvRY8fz3vbkVuVGUARfgB/hcYvhYvteujurjhxE02Wq7p9sL8lNtXZj+vfv2/uhJzdGnp6kLtd
X-Gm-Message-State: AOJu0YzsDfR8hpBs78dixTMPaCE4bgWwHm65RSuQdDwrhwxcvRaJ5Wdu
	9vGV0e/1SIhe5YVB1S+aAu2wiCf8ihYB7ZnAfpNMntgWZI1TTxxeqGPKRtDFXiGuu3mzKgePp3+
	ICpyTy4PXQarzL/TbcDVzItig4uM=
X-Google-Smtp-Source: AGHT+IGLVg2FRz2+w0XtmmxlRun9h4Ybp36gLJSCBUdlGaA1HiqJFnHDxXBSojzDhlUcoRgkZOmBeHW91MU0DR6KcDU=
X-Received: by 2002:a5d:4490:0:b0:366:e308:f9a1 with SMTP id
 ffacd0b85a97d-367d2d51899mr3022882f8f.23.1720548730208; Tue, 09 Jul 2024
 11:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-master-v1-1-a95f24339dab@gmail.com> <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
 <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info> <2c9089c9-4314-4e4a-a7e2-2dd09716962f@suse.cz>
 <CAJuCfpFsKsA3vTZCPTCKL9-Xs9G+07b8vgr0PunqZzVSN1Lmmg@mail.gmail.com>
In-Reply-To: <CAJuCfpFsKsA3vTZCPTCKL9-Xs9G+07b8vgr0PunqZzVSN1Lmmg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 11:11:59 -0700
Message-ID: <CAADnVQK_ftwe5Dxtc0bopeDg2ku=GrFYrMOUWHLnXaK1bqoXXA@mail.gmail.com>
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Christian Kujau <lists@nerdbynature.de>, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:39=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jul 9, 2024 at 8:14=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 7/8/24 10:20 AM, Linux regression tracking (Thorsten Leemhuis) wrote=
:
> > > [CCing the regressions list and people mentioned below]
> > >
> > > On 12.06.24 16:53, Alexei Starovoitov wrote:
> > >> On Wed, Jun 12, 2024 at 2:51=E2=80=AFAM Mohammad Shehar Yaar Tausif
> > >> <sheharyaar48@gmail.com> wrote:
> > >>>
> > >>> The original function call passed size of smap->bucket before the n=
umber of
> > >>> buckets which raises the error 'calloc-transposed-args' on compilat=
ion.
> > >>>
> > >>> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
> > >>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> > >>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> > >>> ---
> > >>> - already merged in linux-next
> > >>> - [1] suggested sending as a fix for 6.10 cycle
> > >>
> > >> No. It's not a fix.
> > >
> > > If you have a minute, could you please explain why that is? From what=
 I
> > > can see a quite a few people run into build problems with 6.10-rc
> > > recently that are fixed by the patch:
> > >
> > > * P=C3=A9ter Ujfalusi
> > > https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@inte=
l.com/
> > >
> > > * Christian Kujau
> > > https://lore.kernel.org/bpf/48360912-b239-51f2-8f25-07a46516dc76@nerd=
bynature.de/
> > > https://lore.kernel.org/lkml/d0dd2457-ab58-1b08-caa4-93eaa2de221e@ner=
dbynature.de/
> > >
> > > * Lorenzo Stoakes
> > > https://fosstodon.org/@ljs@social.kernel.org/112734050799590482
> > >
> > > At the same time I see that the culprit mentioned above is from 6.4-r=
c1,
> >
> > IIUC the order was wrong even before, but see below.
> >
> > > so I guess it there must be some other reason why a few people seem t=
o
> > > tun into this now. Did some other change expose this problem? Or are
> > > updated compilers causing this?
> >
> > I think it's because of 2c321f3f70bc ("mm: change inlined allocation he=
lpers
> > to account at the call site"), which was added in 6.10-rc1 and thus mak=
es
> > this technically a 6.10 regression after all.
>
> IIUC the above mentioned change reveals a problem that was there
> before the change. So, it's a build regression in 6.10 because the bug
> got exposed but the bug was introduced much earlier. The fix should be
> marked as:
>
> Fixes: ddef81b5fd1d ("bpf: use bpf_map_kvcalloc in bpf_local_storage")

Not really. The order was flipped before that patch.

> > So what triggers the bug is
> > AFAICS the following together:
> >
> > - gcc-14 (didn't see it with gcc-13)
> > - commit 2c321f3f70bc that makes bpf_map_kvcalloc a macro that does
> > kvcalloc() directly instead of static inline function wrapping it for
> > !CONFIG_MEMCG
> > - CONFIG_MEMCG=3Dn in .config

Can somebody respin the patch with above details?

tbh I don't think it qualifies as a "bug".
Plenty of code places mix up size/n arguments to calloc.
Erroring the build in such cases is imo wrong.
Not sure what makes gcc-14 produce such warn/error.

But since the patch is trivial we can get that in quickly.
Pls respin with all details.

