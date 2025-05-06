Return-Path: <bpf+bounces-57568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81449AAD065
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A6F986BB3
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689121D591;
	Tue,  6 May 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMcHW0du"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A121D018
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567808; cv=none; b=Mm/tWprpRhpHQIiSg3qITQWBTBIayNJVELqgeXAMlhlAuvPL4ssVyobpWPLQLkNH4Hay9DxIxXWjIW4RXwzVu2eTYrZBqtV6sOo89EvzeG3Ig5LDS2jNjo2DxAcfRihES9xgILWWO/G51SWSfKtgnBNu+1NUHlSLicsxf5j8ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567808; c=relaxed/simple;
	bh=C+IzuzqxA9/CxMX37DsPTmXJsupGHjEEmX9bz8YcPmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN801OpnO3XOdUPeriNbtuNFtHi6AN6C54wa7fqhTS5C0YFbmVXGhJydMKHil+3Y/AXcoyb/dJvaI80C2eD+pBguhRhpD3UHKxracjq49pbZTgfnJKFmYkEGnSbvvzCkJR1Wa0IZyfjUGBsc4IC7ALK4BtBiFi4a4pFVP4Xl8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMcHW0du; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c277331eso293397b3a.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567806; x=1747172606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3Yx+ATiIpwZP5uEBViF+60tzvvBieVhJfJ/9yAy/NQ=;
        b=nMcHW0duXHjT6o3D031Yh4mYDw5qyDOR+aM/SrCc9AjeOnFLqf4yu8cNeJ+sVSCwOh
         E7ZQ5SWYN0lOQ/lmYwlRkbIrxg4uvysq+NnSGAtR3gVIW0fcHbeOlyzH53oTTbbmuWn/
         fDeke7NehB6OzQHsV02Ad1z0C1s+MTd6vVearcZdxYAHlweipBqN8p53qRWphCN/gbM5
         Xsh4nqXCEM83mIWq6mX2Q+YYs96K9y1yBQBCet2aUO4QjYRS3NTGi1M6etawz3wyNdju
         7+cD7EiPuBs8yTqZYabRVm8DS65h4QXtz9E2RQjGQtCmveqnDOt2iM5xkWAkAMJOXsvh
         UHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567806; x=1747172606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3Yx+ATiIpwZP5uEBViF+60tzvvBieVhJfJ/9yAy/NQ=;
        b=lwfcJ5EJgVu6pCaStCUTng+WTT5yuJAgitOgW2DBP9EOITaTEBLqa9eocqJfAzf4TU
         lwo3AuBIWQmAqEqdk3TBWlYFfC4eXFyqBpPeYP6wN1ka6kyD8KXThvQ/RFTHH4WlIHc5
         gw73p+KEsNCY0kt868TtrdKFmwNvSS292Xkr9jpkO8kcWg6FWXVALkXu+5FCcVCXj6SQ
         y/979h0mjqWuFMVpVyDhhk5PJv2DBGMtXj+udPsGBUL4UR3fcoZziQMhhYilCIlvtD/v
         mNAyNa9JGl7uuw18zrZ8UuL+0DL3u7wEqL6H4Sj7uJlWatu2dDfODY0CFjRp8JTauWWO
         LZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUfclpJT67ch3ZbgwfaD2S0bSAcYV4umKXtmJXJ4NFouRRTKyuTKA/BrgafQ4GgqNGqwFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dFiRx5OmbyfSc4wIQDtlXrGOw1oF7KHUwAkL4MNBT8ynQZYt
	E1V/ZghhyilR1YNKu8yKSJ4cdAcJboXYaHradyZ7c90HElijbWeAQ+44Qd2hiahIB1LYHfyqp4U
	RPuVXdydwP4SPjaIiDCrq4x9NZaU=
X-Gm-Gg: ASbGncv+AsnAR4j1PfGE7NhohmE+uFRsUhTb9YYyDaaUIs95Q/wP/1Fiy8hFWp4mlpF
	qy7WWfblwZjPVOmAhy/kwDbdB3T21X6Wh9ECDNQ6xn9XlFeaXDm9TjmcQZ2ZEVpVLzB5UyXwc/5
	Zo9v1m1HbL9tMghgF1LvRE9KZvLSPUcUfk7zdlLw==
X-Google-Smtp-Source: AGHT+IGkP53PDaq7JFXWSPCrZiRglZvFGbI8VAXhTQClIQDIW2xfNNrRaw+0eUW3qrjIDMdieFbyjfEZ8cIZblE9C+s=
X-Received: by 2002:a05:6a00:ac86:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-7409cfb10cemr963323b3a.3.1746567806238; Tue, 06 May 2025
 14:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501235231.1339822-1-andrii@kernel.org> <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
 <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com>
 <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com> <b8d256a2-66d4-4342-be55-6ec54d79ef96@oracle.com>
In-Reply-To: <b8d256a2-66d4-4342-be55-6ec54d79ef96@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:43:14 -0700
X-Gm-Features: ATxdqUHQaYSsdiYzUVyFFg-n8hWyj1GfTpaO6Go_aXvnDVjeHzBFl39Z2g1mkbg
Message-ID: <CAEf4BzaT0uqwDtauHvC9MOfkUr1U=1=vR8JBGrt0tc34=dYJLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 05/05/2025 22:10, Andrii Nakryiko wrote:
> > On Fri, May 2, 2025 at 11:09=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Fri, May 2, 2025 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>>
> >>>>
> >>>> On the other hand, this seems to help to reduce duplication across m=
any
> >>>> kernel modules. In my local test, I had 639 kernel module built. Ove=
rall
> >>>> .BTF sections size goes down from 41MB bytes down to 5MB (!), which =
is
> >>>> pretty impressive for such a straightforward piece of logic added. B=
ut
> >>>> it would be nice to validate independently just in case my bash and
> >>>> Python-fu is broken.
> >>>>
> >>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>>
> >>> Looks great!
> >>>
> >>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >>>
> >>> Should have some numbers on the module size differences with this cha=
nge
> >>> by Monday, had to dash before my build completed.
> >>
> >> I'm curious what BTF sizes you'll see.
> >>
> >> Sounds like dwarf has more cases of "same type but different id"
> >> than we expected.
> >> So existing workarounds are working only because we have very
> >> few modules that rely on proper dedup of kernel types.
> >> Beyond array/struct/ptrs, I wonder, what else is there.
> >
> > Well, turns out I screwed up the measurements. I thought that I used
> > libbpf version with Alan's patch applied as a baseline, but it turned
> > out it was libbpf without his patch. So all the measurements (41MB ->
> > 5MB) are actually due to Alan's identical pointers fix. My patches
> > have no effect on module BTF sizes (which is good and a bit more
> > sensible, I should have double checked before submitting). So, if we
> > are going to apply the patch, it's probably better to just drop that
> > paragraph. Or I can send v2 with an adjusted commit message, whatever
> > is better.
> >
>
> I did see some small changes, so the fact that you've added additional
> cases here definitely helps; with ~3000 modules built I got ~50Mb of
> module BTF in total both before and after the change, but comparing the
> results using latest pahole (with the pointer-specific fix) and your
> change (the more general fix) we do see some size reductions:
>
> $ find . -name '*.ko' -print |sort|xargs objdump -h --section=3D".BTF" >
> /tmp/modout.base
> $ awk '/file format/ { printf $1" " } / .BTF/ { print strtonum("0x" $3)
> }'  /tmp/modout.base > /tmp/modout.base.sizes
> # rebuild pahole with Andrii's change
> $ rm vmlinux
> $ make -j$(nproc)
> $ find . -name '*.ko' -print |sort|xargs objdump -h --section=3D".BTF" >
> /tmp/modout.test
> $ awk '/file format/ { printf $1" " } /tmp/modout.test / .BTF/ { print
> strtonum("0x" $3) }' > /tmp/modout.test.sizes
>
> $ diff /tmp/modout.base.sizes /tmp/modout.test.sizes
> 198c198
> < ./drivers/char/ipmi/ipmi_si.ko: 11575
> ---
> > ./drivers/char/ipmi/ipmi_si.ko: 11539
> 1810c1810
> < ./drivers/platform/x86/ideapad-laptop.ko: 7122
> ---
> > ./drivers/platform/x86/ideapad-laptop.ko: 7086
> 1952c1952
> < ./drivers/scsi/mpi3mr/mpi3mr.ko: 52625
> ---
> > ./drivers/scsi/mpi3mr/mpi3mr.ko: 52589
>
> So while numerically it isn't huge, it definitely validates the
> principle of making the identical type handling less specific to the
> cases we had encountered. If you want to resync libbpf github again I
> can update the submodule commit in pahole. Thanks!

given how small the change in size is, it's probably const/volatile
PTR cases or something similar. Well, good to know it does make a bit
of a difference in some situations, thanks for confirming!

>
> Alan

