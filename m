Return-Path: <bpf+bounces-21471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8A84D7B2
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561FE1F22F9B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EC1947E;
	Thu,  8 Feb 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fegrhy3H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234A1E4B0
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357544; cv=none; b=mdW8ur3pcz3sdQtFbV0A2KxX3wX1M/M9duIXVZH0quO7CxTHeCrBkqYdthPuJQCTq/QjQD+7AcQqKmxYf2+FzSkAwpOyK8NN5Nj5sHQw3GcNvJahDue4SJFoeARCNh6wan9U7Zfxww1Nxnik22A7jSlsYFdwKUsEUvJDp9WFt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357544; c=relaxed/simple;
	bh=bSP5g+Iw15RipRDMA3Xnt991S4dNeFJgmD5zU5GlI/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHROa4orUDHwk0fgwcDHY/Q+EH2CiFevaJEuEoyStfcevlWbNfSl5agIkESyzElPpd0DJBLUoMBpxpv+JLfA4dgCma3s7ZOI83SO9tEUoHJ8hwWGTydSrYpY5S6Y2jSODd1YifaV/Gm/FQvsP9L5Hj9Tpy4xoc0YUFbU8930UN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fegrhy3H; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3394bec856fso240631f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707357541; x=1707962341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw2DG9D22iPvPnBNWQtqEQ8bb/c7ENmGt4tgaUKDf+Q=;
        b=Fegrhy3HMM8IfLLL5A0+PChVGMHHG6qpgZmTj8ywKuvvpCekuQjGmqPZExQRXd6qJ1
         T6H/VoI1yWtFDGRKbYWxYhE8Xhu3vkLEONuQJuB2kroMdScSPNuZdxiVzgH49vfJu4Gi
         ZJl/bmR0CUn7lT3o/EvnIONYDe0UR3pCTf7rBjyB5bfzIqdlcdxaorWX/+JDjvOYgCdD
         V7+H6Wps6Wjsvj1aHWSSrAjtx7RkOZ+SAZIYZFxfmGnU3VAgsgk+dDvBI0eokBoOO1Or
         eL+i2ETnRDRffN4D5ko2vPHxEkrSHYs6p+aMlnUTMargsywCQoejU4WWBORUz3qlcbUS
         4phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707357541; x=1707962341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw2DG9D22iPvPnBNWQtqEQ8bb/c7ENmGt4tgaUKDf+Q=;
        b=ShA3XbL0vjfsvroKsfIEoUCQAErd2TpV2LMim1nY9e8GvNPde1PnPkDI035UIqUcCv
         GGjHiysiuNO61ovzP2lFfvCEpGqTIE0K9aNJJ8y3yvJd7sdpwK2K0zUTkJNLa4XFvCh4
         yBZOX3zP4Sgs2FKmLC3n0TCndl8XWBneFrZd67x/hTVZz3FXyZ7vKtqRhadCc3gikFPL
         xp7yMqWIT+Gy2soa8fsGGYX9k5hAYnrRodRxW29RF0KHJWSFrvhvodYVCMe9dHQm/s+f
         z2lvxz78B0uB5Sd8H3mzhBtquwvgo+sRzgEEH6PluE2eu/UcmFUqyEg2199nIcZdzEbD
         W/LQ==
X-Gm-Message-State: AOJu0YyQPkng3HWAao6LwPhwGUFxbrh90udGEe1tkXJC9JuKCfl0o9Va
	7gKn5GLUmsppB6L44h9I1ER0/EDZhRUDKYDMC+X3XlLqP1pJ55xI0/Pu86slKnLkMYZfJqrLDrc
	387g43VYBbTjBRG0uWnR1A7VjWSk=
X-Google-Smtp-Source: AGHT+IEhUIADTS41xKPaZ38J9Vvk8cZXp1t+WvDYRjY+jJ+5HqZDRA4h74rLcPVpC7ofzBNLTQhRnPsNXGw5ZQyyjG4=
X-Received: by 2002:adf:ab1c:0:b0:33b:5815:d51d with SMTP id
 q28-20020adfab1c000000b0033b5815d51dmr363632wrc.18.1707357541040; Wed, 07 Feb
 2024 17:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-13-alexei.starovoitov@gmail.com> <CAEf4BzbAj=zU+iAc6KFsCscKKYZBKmCtNvtW1e9u=TJ+LpUG7A@mail.gmail.com>
In-Reply-To: <CAEf4BzbAj=zU+iAc6KFsCscKKYZBKmCtNvtW1e9u=TJ+LpUG7A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 17:58:49 -0800
Message-ID: <CAADnVQL9ctDPTOLMHp=4EURUODrReCk5KuRVZN1stwhuwP1t_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] libbpf: Allow specifying 64-bit integers
 in map BTF.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:17=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > __uint() macro that is used to specify map attributes like:
> >   __uint(type, BPF_MAP_TYPE_ARRAY);
> >   __uint(map_flags, BPF_F_MMAPABLE);
> > is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements"=
 field.
> >
> > Introduce __ulong() macro that allows specifying values bigger than 32-=
bit.
> > In map definition "map_extra" is the only u64 field.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_helpers.h |  1 +
> >  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 9c777c21da28..fb909fc6866d 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -13,6 +13,7 @@
> >  #define __uint(name, val) int (*name)[val]
> >  #define __type(name, val) typeof(val) *name
> >  #define __array(name, val) typeof(val) *name[]
> > +#define __ulong(name, val) enum name##__enum { name##__value =3D val }=
 name
>
> Can you try using __ulong() twice in the same file? enum type and
> value names have global visibility, so I suspect second use with the
> same field name would cause compilation error

Good point will change it to:

#define __ulong(name, val) enum { __PASTE(__unique_value,__COUNTER__)
=3D val } name

