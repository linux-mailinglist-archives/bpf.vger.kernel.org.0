Return-Path: <bpf+bounces-77130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2836CCE8E5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B4B93022835
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9182D0C92;
	Fri, 19 Dec 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqyVD2qR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B930218AAB
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122850; cv=none; b=ImR3vBQlMvkKz9AwJB/BtcOfNeCm6/tmRwjXvngiwzB0cqvkbfduLn6hRdYIP6UFo6XibmDgudCBuqb7TghTooXvSbCrw4mb1AeQ582TQez94DEM9lbdtWyQbqSCGXNJ+ZXBRsrwmNRyGxGBBgG56ZjeuOQw3RDiGhwQ4VYkIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122850; c=relaxed/simple;
	bh=9d3QA+c07Yu7Kiy3aBxSBlUgNbE0OjPoO7tGWCN4mz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atFsgMPg+T/NoYUfkP7jfrJGspU9tazKBeWpnxv5zchE8XNbMMgXAdaNa6+njxQy4CvaqmoYOPsCa4yfLXg8d3QqxIqrK4T3Y1xCMwjZBf+QkXubqNp8nknKmcec8MAPymNpvmxoU+LTn0dIFXZGNYsV4bnEYN/gSZbB/Y4s5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqyVD2qR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7a02592efaso198680666b.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122846; x=1766727646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG0doq18WgDNO9PSfdtduvufgbI6UYghC80w4Re3bjo=;
        b=ZqyVD2qRdMkISVkI7EFwVWQq2kRHFMDbepnjwwOe76k/9a2aOQ5SwdI+4Q/Jz8Mfl9
         6jFIfW8WBY2V7mOQXuMRO2V1sw30JNiqjBvs+HUU7Vl4q8GvxQBFc+cxhIb6CDcRzfJh
         ocGg8Dzfqs714uDo+D8AESNlE/rmDeZzPsshTctqzJnJikEawrNrxraPzaQg867IV4oC
         eZGpBJSdtCxpwgAagX2eNPcqkz7bopjh9YlTfJlhBcZywyl3x4LUakSMsxPwtjdnp/I+
         sfKBoNsxcT5vKcPTMUNwsPkuO0q489VZQfY9aWf0T023KdPYm/poA3X58BxHtzQxk+gT
         MVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122846; x=1766727646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bG0doq18WgDNO9PSfdtduvufgbI6UYghC80w4Re3bjo=;
        b=c1G5V9cusoNkShx1yGlCH7yAkpIM0BOIN2U/gyDiMdDiBs/kbazwRnBLwSRn39ckPN
         nbGut4V52n46AKsN0Cd25ZJynMZlPhDrzmuy0cKHlReF9P7MhkVoizNep+5oCHB+8Fd0
         jgY3B075XXtDCShfHfhu2PMNOSRplVMxq/WOT3uYJFBxDb7rth+3ROQ1lwZx4VuPkh8/
         qNkTaKd0TcBHsOJ7kpQE8XlV5RTSjSLwQ+XP1swxUmxG7k3hthsrgvSnetutgMXzxO9T
         Xki9DEcW6sEw+MLAsurFqc5amu8LfztZdE9xWu+Sz3WfmZXDpcmMSHP1XyIK1gJIlSxu
         LzTw==
X-Forwarded-Encrypted: i=1; AJvYcCV3FFEmWqlKqVfjijaVP4YIslyVPR81zj8zmgFAlMFy7UmYrAnDu6kfvM7iAyStdgiSJDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxy7ZpqK6IEfYZkLrmjyD+n62u27lUsO/KTKcLa0Asf9PhL2w
	B7yu3ql7t5VWydeWc1LHdJUwDl0c53MDozqlCzsAKTNoy8QUSK8m9+iiuG8bE5L4uUHXsfOJ4jx
	UbAfuT+dK3Q5oXXSg78mos6xqWxGACJU=
X-Gm-Gg: AY/fxX7ztTcp5vLoMX/P6qOg8FON0+xupPG3tGVZeo+cjvCa4rLeK4xeyGEbpXeifQD
	Zm70eHmCRJBA+7dxgLRoWOx/XP1bokVONFD8gUXq2TZjw0ICPQcAKMtBXbtsJKF8b18ea6NXg4L
	Sk+ipJYaSBhDymhg/uO3C8OhKcfOkyOkPiaSkU5FQYqetH0/aeq+MZxwShYTld+WBltasN1eDOV
	3QNi3/QiAa6w69PcTbw8aSX0ix/iyDzhCnPTSmh0SjAAcYdDfRJslBt7zp69ii6hENqmHMq
X-Google-Smtp-Source: AGHT+IFN57/cfq7fr1Z0HF+p7dnInXKBZB0w6GWCPSAj1rGtSTI33kJUSfKgA69SC9t9OzCgmNrcxEFYMbb9I78L1/Q=
X-Received: by 2002:a17:907:9710:b0:b3f:f207:b748 with SMTP id
 a640c23a62f3a-b8036ecdbd4mr179126266b.10.1766122845699; Thu, 18 Dec 2025
 21:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-9-dolinux.peng@gmail.com> <eede20e39fa1eb459e6e5174b5a8a5e3ba7db312.camel@gmail.com>
 <CAEf4BzY4ANKygJN=aRGHKbooW1Q1ROYgp1A74vgPKOQbW5cghQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY4ANKygJN=aRGHKbooW1Q1ROYgp1A74vgPKOQbW5cghQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:40:34 +0800
X-Gm-Features: AQt7F2rtGejC7CIVj1bRfoNGpiYX8xbWV605tW50BMiXhE1u5-cb-fipK0tv9qY
Message-ID: <CAErzpmvskuQrs=+=TydAsQRe99rqb=539eBOfvd3eJpEgxfwWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 08/13] bpf: Skip anonymous types in type
 lookup for performance
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 2:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Currently, vmlinux and kernel module BTFs are unconditionally
> > > sorted during the build phase, with named types placed at the
> > > end. Thus, anonymous types should be skipped when starting the
> > > search. In my vmlinux BTF, the number of anonymous types is
> > > 61,747, which means the loop count can be reduced by 61,747.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > ---
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > >  include/linux/btf.h   |  1 +
> > >  kernel/bpf/btf.c      | 24 ++++++++++++++++++++----
> > >  kernel/bpf/verifier.c |  7 +------
> > >  3 files changed, 22 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index f06976ffb63f..2d28f2b22ae5 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
> > >  bool btf_is_vmlinux(const struct btf *btf);
> > >  struct module *btf_try_get_module(const struct btf *btf);
> > >  u32 btf_nr_types(const struct btf *btf);
> > > +u32 btf_sorted_start_id(const struct btf *btf);
> > >  struct btf *btf_base_btf(const struct btf *btf);
> > >  bool btf_type_is_i32(const struct btf_type *t);
> > >  bool btf_type_is_i64(const struct btf_type *t);
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index a9e2345558c0..3aeb4f00cbfe 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
> > >       return total;
> > >  }
> > >
> > > +u32 btf_sorted_start_id(const struct btf *btf)
> >
> > Nit: the name is a bit confusing, given that it not always returns the
> >      start id for sorted part. btf_maybe_first_named_id?
> >      Can't figure out a good name :(
>
> yeah, I agree, it is quite confusing overall. I think we should at
> least add comments why we start with something different than 1 in
> those few places where we use this optimization...

Thanks, I will add comments to make it more clear.

>
> let's name it btf_named_start_id() and specify in the comment that for
> non-sorted BTFs we conservatively fallback to the first type.

Thanks, I will do it.

>
> btw, maybe it would be good to have two versions of this (or bool
> flag,but we all hate bool flags) to either return own start id (i.e.,
> ignoring base BTF) or recursively go down to the base BTF.

Thanks, I will implement it.

>
> Having that
>
> while (base_btf->base_btf)
>     base_btf =3D base_btf->base_btf;
>
> logic in a few places looks a bit too low-level and distracting, IMO.

Agreed.

>
> >
> > > +{
> > > +     return btf->sorted_start_id ?: (btf->start_id ?: 1);
> > > +}
> > > +
> > >  /*
> > >   * Assuming that types are sorted by name in ascending order.
> > >   */
> >
> > [...]

