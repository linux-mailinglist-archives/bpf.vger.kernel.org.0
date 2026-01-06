Return-Path: <bpf+bounces-77903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC1CF63B7
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACC2D301F3CB
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57768329E7B;
	Tue,  6 Jan 2026 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAVIEx8G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59096329E7A
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662391; cv=none; b=lQ4Ob+bVsU6sfFwaL7z52c1wdHuDiLpNL3rcuv8rM4FoiIjpcEU8MeFG0+7OQAHoZVk3dZfinGRPneE1QEe/1la6oB963oewarcQAe2eB4W6nhgoG5ScHvTR+Kr5k1jbY1cg0nZX2I5ChUZ79UCgbDjSeCJRXwQdbvZwncjdZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662391; c=relaxed/simple;
	bh=Lw+WUkHAnt7Yk9QGoWEP7lHFIOoDXXnkegUifZDeZ7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZGzsdvwKmzPFmS8oG83rwYAOmaj5pxTrhN6IByrVzILFiRgUaXBnU10BNkSLdst7CNrnG9g3vYVCF0zfTrEfFqtWGha2yTtXjTeps8zvqcxKKTOW1D90u9v6op96vHep0zb4LLzAsLLKsFTy8Euw1RAE9HYCmYtrXQNl9X5rk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAVIEx8G; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so496995a91.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767662390; x=1768267190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sXr0qzW/IPoJWgMaNDnsLaUUbJyxXu9pwTAJUvCB88=;
        b=VAVIEx8GQYYbdhq8voNYdzjCFGIuiVjFZr5aLS7icUlHI0dcicAzISl9SZe6LK8r5z
         Lmd0tfZ47AYq0rfLFE8FVv3T+/jo6f6PC9BDGxIKseGuKzHFwvR/AADwLSgm/3fcQ9T0
         4maApwddPycuvKdtq1FJ5ZiceQ+Ja2U13T0Jd8KYVpJLttYieiW8yr/mlYJzQiRt/m0Z
         EK79xkoF3mzYw3lO2ScCqsw5dtCNAIZqhhV1OXJ0eWxiqXJfjDSngo5pztDjpm/VWv8R
         ytSBHkE751iXI8rqSX+bwhSm84jqbEnS3N18r4s8yVbwyH91UFQVvxP1Ioc7IDylMDRc
         RaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767662390; x=1768267190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sXr0qzW/IPoJWgMaNDnsLaUUbJyxXu9pwTAJUvCB88=;
        b=FDZnXMBOYu0fV0K/UstFQytAdpVf6SAARmV6Nn7HUD82S5yF77kgOy52fx3D41VsoR
         ShD8FCqams0g3IufVYer3uW8B831adGaPjt7qowwf/ndS5Q2tGSGfVzvD7tERLHS9jVx
         zNW/n238qIHhMbNdEpSlhCa81mviuOGWXbLZiJkJ7KOsc669Qnho4zcREhyApvlojWMl
         dr6Kook9NSxjiB+AmOsYh5HzaI7s9jitLLHuE393Vjh7Yoke0a8zG1ocSqiqXYTWK+o6
         Tze/6eZI86UOvgJZ6FjRlgfdEpAiQgDZ72RV4QgD956koQXPiw0yPY9DVlr1Lq4TrqxY
         pBZw==
X-Forwarded-Encrypted: i=1; AJvYcCXO3lpRVY0l20tNvsJjUnK+dCVeNNRgyU9MewE8jhcmGkggMC6F4SOWUG67hij0fm1NeAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/svhPaznOQz4s+drIb7fFakAyxozA7hZseSvsx/K3cMaaaUtp
	eNbNiYxL73EkoPJdzmhCn+EXFcpHJVkvf6gVHZA7agQzOQ8NJgOJdghCUvlQG8wnZ9iKCUYNlai
	cSjg3kmJIrFvYSz+EhZR6IgB8rxkRmmw=
X-Gm-Gg: AY/fxX5djOAl+qwhYrCyye3FhG78OhGEEHsxuiTVLQbcVOPcfC61+3Or34ClO2FeM/G
	1vzE11tFRwZjrcxKaCN4A4ikBRUuI91X2+RkquerlW093mo0F9utfqZPYkz2/wSxZucXRyi5pSb
	5V7QptpbOKH2yYwb0fXnHBojbjaj5es/63LwvwpEEDYdZhwiX/c6dJBNJya86/iWbO5N7a5y1zU
	6luwPPJAyjoV3cPpIDvdMTYq2jLALaMvT7vTDvvBfEqCWa93LUZwlAgG+0tbAscush4lOGqKo/L
	BCFYtTu9oGs=
X-Google-Smtp-Source: AGHT+IGsRYa3i86/AOhfKIG44a6+dPFfkcN9Yo45nJhrrW+I7bVbNxtD29bDj16FhUltixRQlUynO952vkFKIP+oqa0=
X-Received: by 2002:a17:90b:4d0b:b0:34c:6108:bf32 with SMTP id
 98e67ed59e1d1-34f5f34391bmr806921a91.34.1767662389588; Mon, 05 Jan 2026
 17:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com> <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com> <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
In-Reply-To: <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 17:19:36 -0800
X-Gm-Features: AQt7F2pZAV7IfRbL6vMBPZ6Ket-bsN85Nj8JjHlliDzsn9YmzXeC5qneEBG3rgQ
Message-ID: <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 4:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 5, 2026 at 4:11=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 22/12/2025 19:03, Alexei Starovoitov wrote:
> > > > On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> > > >>
> > > >>>
> > > >>> Hold on. I'm missing how libbpf will sanitize things for older ke=
rnels?
> > > >>
> > > >> The sanitization we can get from layout info is for handling a ker=
nel built with
> > > >> newer kernel/module BTF. The userspace tooling (libbpf and others)=
 does not fully
> > > >> understand it due to the presence of new kinds. In such a case lay=
out data gives us
> > > >> info to parse it by providing info on kind layout, and libbpf can =
sanitize it
> > > >> to be usable for some cases (where the type graph is not fatally c=
ompromised
> > > >> by the lack of a kind). This will always be somewhat limited, but =
it
> > > >> does provide more usability than we have today.
> > > >
> > > > I'm even more confused now. libbpf will sanitize BTF for the sake o=
f
> > > > user space? That's not something it ever did. libbpf sanitizes BTF
> > > > only to
> > >
> > > Right; it's an extension of the sanitization concept from what it doe=
s today.
> > > Today we sanitize newer _program_ BTF to ensure it is acceptable to a=
 kernel which
> > > lacks specific aspects of that BTF; the goal here is to support some =
simple sanitization
> > > of the newer _kernel_ BTF by libbpf to help tools (that know about ki=
nd layout but may lack
> > > latest kind info kernel has) to make that kernel BTF usable.
> >
> > Wait, is that really a goal? I get why Alexei is confused now :)
> >
> > I think we should stick to libbpf sanitizing only BPF program's BTFs
> > for the sake of loading it into the kernel. If some user space tool is
> > trying to work with kernel BTF that has BTF features that tool doesn't
> > support, then we only have two reasonable options: a) tool just fails
> > to process that BTF altogether or b) the tool is smart enough to
> > utilize BTF layout information to know which BTF types it can safely
> > skip (that's where those flags I argue for would be useful). In both
> > cases libbpf's btf__parse() will succeed because libbpf can utilize
> > layout info to construct a lookup table for btf__type_by_id(). And
> > libbpf doesn't need to do anything beyond that, IMO.
> >
> > We'll teach bpftool to dump as much of BTF as possible (I mean
> > `bpftool btf dump file`), so it's possible to get an idea of what part
> > of BTF is not supported and show those that we know about. We could
> > teach btf_dump to ignore those types that are "safe modifier-like
> > reference kind" (as marked with that flag I proposed earlier), so that
> > `format c` works as well (though I wouldn't recommend using such
> > output as a proper vmlinux.h, users should update bpftool ASAP for
> > such use cases).
> >
> > As far as the kernel is concerned, BTF layout is not used and should
> > not be used or trusted (it can be "spoofed" by the user). It can
> > validate it for sanity, but that's pretty much it. Other than that, if
> > the kernel doesn't *completely* understand every single piece of BTF,
> > it should reject it (and that's also why libbpf should sanitize BPF
> > object's BTF, of course).
>
> +1 to all of the above, except ok-to-skip flag, since I feel
> it will cause more bike sheding and arguing whether a particular
> new addition to BTF is skippable or not. Like upcoming location info.

I was thinking about something like TYPE_TAG, where it's in the chain
of types and is unavoidable when processing STRUCT and its field.
Having a flag specifying that it's ref-like (so btf_type::type field
points to a valid type ID) would allow it to still make sense of the
entire struct and its fields, though you might be missing some
(presumably) optional and highly-specialized extra annotation.

But it's fine not to add it, just some type graphs will be completely
unprocessable using old tools. Perhaps not such a big deal.

I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
whether they are more like DECL_TAG (roots pointing to other types) or
TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
fields, PROTO args, etc).

> Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
> Skippable? One might argue that they are while they are mandatory
> for some other use case.
> Looking at it differently, if the kernel is old and cannot understand tha=
t
> BTF feature the libbpf has to sanitize it no matter skippable or not.
> While from btf__parse() pov it also doesn't matter.
> btf_new()->btf_parse_hdr() will remember kind layout,
> and btf_parse_type_sec() can construct the index for the whole thing
> with layout info,
> while btf_validate_type() has to warn about unknown kind regardless
> of skippable flag. The tool (bpftool or else) needs to yell when
> final vmlinux.h is incomplete. Skipping printing modifier-like decl_tag
> is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
> though one might argue that they are.

Yeah, I agree about vmlinux.h. One way to enforce this would be to
have btf_dump emit something uncompilable as
"HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
modified.

But yeah, we don't want bikeshedding. It's fine.

>
> Also let's not call btf__parse() process with layout info
> as a sanitization. Sanitization is the word to describe actual replacemen=
t
> of unrecognized kind with a known kind. Here btf__parse() won't be
> mangling it. Who knows, maybe btf_dumper (in bpftool or else)
> understands the kind, though libbpf's btf__parse() does not.

