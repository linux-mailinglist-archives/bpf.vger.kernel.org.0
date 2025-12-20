Return-Path: <bpf+bounces-77211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73BCD2390
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 01:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861483035262
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245291C6B4;
	Sat, 20 Dec 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHhn+rQ5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AA17555
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189134; cv=none; b=YXg1BmDi32/TAPFNKi1TI3a9dYuBdWZLiyvDQUPo73la2rJh8OAW/nxD5sRiAJlQr+vqW+FIy/tL4F4KGxuc4DqdzQL6/7T7FcZZHyVQB5HTXfyw3v/QbeTD5T6eqYS/q2sj8jU2WhKVb0Qx0paDe2Y4EqldvtIv/PK6/A2wqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189134; c=relaxed/simple;
	bh=zVPSnrEhLaeudmeBYZyBjQo0KsMYyErrXfnPab64pvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfR6GzzbADDcTGlJXQpWqlC/h+wM2xz9AHIksOQqkT+2YtOu0rssIif1/toCCEuGsFfj9OdwO/O0OyEf+aH9Tbb8MSmpMxVBvBz4iiQ5rWVZd5lgefGxJDCbV2dqPm8t+fxNqSIp59uWhz7QWeGZJ1KGcyOVlJwJo+O/4yyFV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHhn+rQ5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47a8195e515so17555785e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766189130; x=1766793930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+u3PBPK4A459u8PEf6VM+eC5vaoAUWFFT1W6cnhYsA=;
        b=gHhn+rQ5+sEnwTX7l4OUZAyyfZBHLUy9IVMzaR9vNkO8C1KaQvdPzpn1Fr7D36e8NI
         2fftsH1k7XDR6Y2uT6WwJo9thzVBMNnvi3svDnipf2u/n2Zm40nLvwFKxiSM/2Q9+uMZ
         iNlhA+sF4rzbUqUhsDHIDTWM8nLBCV4hRurEQ0gFMFnnebunVE4WK8BpaF28YiVHQ7VR
         PmpB1HjmB5M+a+fpp1FPZlv287xAUQTUeiDMnsvA1CwiUiTr0aYABl5+hloWJx3NI5Ou
         Yrnf2ZMb5ckOVcjeR9MB+iSDn7nvkaNWfhqSmifBLWn7jPtRsRHCDbt2WYh0C0JCO/AJ
         c7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766189130; x=1766793930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+u3PBPK4A459u8PEf6VM+eC5vaoAUWFFT1W6cnhYsA=;
        b=p51T+YxwL/culW/tYYrJDeGMGq2CA8P/J7yvK19XcVEsDwkJ/C6+kAlMrWmSI+maw6
         fordssIidysVqlfA52RTrsFqU6vi7kdOVk1DurnjQzWA47KTCvAXipI6idxyXWmcVoSB
         54yIf3vix7bE13GLxv7rEdskhEhytmnF3OjONwOHUa4k/0D9reOKRkAjylR9BzB2F+52
         9ujMYpket39sw5Y9sP1yN+lYzmUdrB+v6QBnIomqUH2X8dsNOfhn5OlO8eCe4LTw8iYd
         ldEPM7pSDsZCypfOsyx0+8s75IDXd3CTCxVvspyaSfh15iwLcyCoFdelHpNb0Zki11nn
         +lzg==
X-Forwarded-Encrypted: i=1; AJvYcCUP7TCwk6J4aPj1hvuj3HV9Li/6wBZQCTmoz4PyKqaGxiM7pEb38HxyWy2UxBEZQC83TjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytDJGjfrg0ugjlkqWRpXsVHkQTekQ+zs3B3Hiuf8z/C5e/AWad
	bnH7h2tIEkm7p6XTlypx3TOtpbeaWF27chm2IgQUBW/1jqikXN3W8izhlB+CwAMJoJ0CQ8egsW6
	w67MQTA8+ufW/TplRIe773Mn84+E701k=
X-Gm-Gg: AY/fxX5j1N0aXEWGrz6yU35KTYZSfrIKQ7wlnI/KmHXXO87K4kJZqX8nwjagZXnRRdf
	CragXuCchzvpUGzZqivqvvaMODLvPQbJ0asGcmqaJOHN+Vd4OkK3Pcbo1wKuxBrISlVJ4Ajngk7
	DZ6mgjG1qJVECYLpuYGaVwXUT2qAFvlsb6MZOjpsoY4dEnmOKs82tegFWwqZ/j5lOyhjeKY+wWY
	ZLGPCX6H0vovlOdGVK+bRVnhP3HUETPIlYCw+lykWOW8xWF5kTemptDXTRvXbaOTQBnQXk/
X-Google-Smtp-Source: AGHT+IGvSZD2XQwBZ/uMJoJ+z3WUZV9iuqBkrWsZMEDLORDkX4dx9v4Gu0P3o9LKKab5rsIg5ittbAZQs2wt+pUlTVg=
X-Received: by 2002:a05:6000:2dc7:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-4324e50d03dmr5051910f8f.52.1766189129600; Fri, 19 Dec 2025
 16:05:29 -0800 (PST)
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
In-Reply-To: <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Dec 2025 16:05:18 -0800
X-Gm-Features: AQt7F2oyYyK1fJoVhsyG-5BE-48Nm4xX7WRGnUoZE_HkRf22OHYW3cJKtummAks
Message-ID: <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, Dec 19, 2025 at 8:19=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 19, 2025 at 10:14=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >
> > On 19/12/2025 17:53, Andrii Nakryiko wrote:
> > > On Fri, Dec 19, 2025 at 5:15=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> > >>
> > >> On 16/12/2025 19:23, Andrii Nakryiko wrote:
> > >>> On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@=
oracle.com> wrote:
> > >>>>
> > >>>> BTF kind layouts provide information to parse BTF kinds. By separa=
ting
> > >>>> parsing BTF from using all the information it provides, we allow B=
TF
> > >>>> to encode new features even if they cannot be used by readers. Thi=
s
> > >>>> will be helpful in particular for cases where older tools are used
> > >>>> to parse newer BTF with kinds the older tools do not recognize;
> > >>>> the BTF can still be parsed in such cases using kind layout.
> > >>>>
> > >>>> The intent is to support encoding of kind layouts optionally so th=
at
> > >>>> tools like pahole can add this information. For each kind, we reco=
rd
> > >>>>
> > >>>> - length of singular element following struct btf_type
> > >>>> - length of each of the btf_vlen() elements following
> > >>>>
> > >>>> The ideas here were discussed at [1], [2]; hence
> > >>>>
> > >>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >>>>
> > >>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrg=
X4bn=3DNuc1g8JPFC34MA@mail.gmail.com/
> > >>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.magu=
ire@oracle.com/
> > >>>> ---
> > >>>>  include/uapi/linux/btf.h       | 11 +++++++++++
> > >>>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
> > >>>>  2 files changed, 22 insertions(+)
> > >>>>
> > >>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > >>>> index 266d4ffa6c07..c1854a1c7b38 100644
> > >>>> --- a/include/uapi/linux/btf.h
> > >>>> +++ b/include/uapi/linux/btf.h
> > >>>> @@ -8,6 +8,15 @@
> > >>>>  #define BTF_MAGIC      0xeB9F
> > >>>>  #define BTF_VERSION    1
> > >>>>
> > >>>> +/*
> > >>>> + * kind layout section consists of a struct btf_kind_layout for e=
ach known
> > >>>> + * kind at BTF encoding time.
> > >>>> + */
> > >>>> +struct btf_kind_layout {
> > >>>> +       __u8 info_sz;           /* size of singular element after =
btf_type */
> > >>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) ele=
ments */
> > >>>
> > >>> So Eduard pointed out that at some point we discussed having a name=
 of
> > >>> a kind (i.e., "struct", "typedef", etc). By now I have no recollect=
ion
> > >>> what were the arguments, do you remember? I'm not sure how I feel n=
ow
> > >>> about having extra 4 bytes per kind, but that's not really a lot of
> > >>> data (20*4 =3D 80 bytes added), so might as well add it, I suppose?
> > >>>
> > >>
> > >> Yeah we went back and forth on that; I think it's on balance worthwh=
ile
> > >> to be honest; tools can be a bit more expressive about what's missin=
g.
> > >>
> > >>> I think we were also discussing having flags per kind to designate
> > >>> some extra semantics, where applicable. Again, don't remember
> > >>> arguments for or against, but one case where I think this would be
> > >>> very beneficial is when we add something like type_tag, which is
> > >>> inevitably used from "normal" struct and will be almost inevitable =
in
> > >>> normal vmlinux BTF. Think about it, we have some field which will b=
e
> > >>> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
> > >>> totally break (old) bpftool's dump, as it really can be easily igno=
red
> > >>> **if we know TYPE_TAG can be ignored and it is just a reference
> > >>> type**. That reference type means that there is another type pointe=
d
> > >>> to using struct btf_type::type field (instead of that field being a
> > >>> size).
> > >>>
> > >>> So I think it would be nice to encode this as a flag that says a) k=
ind
> > >>> can be ignored without compromising type integrity (i.e., memory
> > >>> layout is preserved) which will be true for all kinds of modifier
> > >>> kinds (const/volatile/restrict/type_tag, even for typedef that shou=
ld
> > >>> be true) and b) kind is reference type, so struct btf_type::type is=
 a
> > >>> "pointer" to a valid other underlying type.
> > >>>
> > >>> Thoughts?
> > >>>
> > >>
> > >> Again we did go back and forth here but to me there's much more valu=
e in
> > >> being both able to parse _and_ sanitize BTF, at least for the simple=
 cases.
> > >> What we can include are as you say types in the type graph that are =
optional
> > >> reference kinds (like type tag), and kinds that are not implicated i=
n the
> > >> known type graph like the location stuff (it only points _to_ known =
kinds,
> > >> no known kinds will point to location data). So any case where known
> > >> types + optional ref types constitute the type graph we are good.
> > >> Anything more complex than these would involve having to represent t=
he
> > >> layout of type references within unknown kinds (kind of like what we=
 do for
> > >> field iteration) which seems a bit much.
> > >>
> > >> Now one thing that we might want to introduce here is a sanitization=
-friendly
> > >> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting =
kind
> > >> which can be used to overwrite kinds we don't want in the sanitized =
output.
> > >> We need this to preserve the type ids for the kernel BTF we sanitize=
.
> > >> I get that it seems weird to add a new incompatibility to handle inc=
ompatibility,
> > >> but the sooner we do it the better I guess. The reason I suggest it =
now is we'd
> > >> potentially need some more complex sanitization for the location stu=
ff for
> > >> cases like large location sections, and it might be cleaner to have =
a special
> > >> "ignore this it's just sanitization info" kind, especially for cases=
 like
> > >> BTF C dump.
> > >
> > > So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
> > > we can "overwrite" any possible unknown BTF kind?.. As you said,
> > > though, this would only work for new kernels, so that's sad... I don'=
t
> > > know, I don't hate the idea, but curious what others think.
> > >
> > > Alternatively, we can just try to never add kinds where the vlen
> > > element is not a multiple of 8 or 12. We can then use ENUM
> > > (8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknow=
n
> > > types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
> > > are other options. We just don't have 4-bytes-per-vlen for the most
> > > universal "filler", unfortunately.
> > >
> > > The advantage of the latter is full backwards compatibility with old =
kernels.
> > >
> >
> > True. And I guess during sanitization we can just handle intermediate
> > types in a type graph by adjusting type ids to skip over them, so we
> > likely have everything we need already. Funnily enough the BTF location
> > stuff will give us a vlen-specified 4 byte object (specifying the
> > location parameters associated with an inline), so that will help in
> > the future for cases where it is recognized but other kinds are not.
>
> So coming back to flags? Let's do two flags: "safe modifier-like
> reference kind" (for type_tag-like things where they can be dropped
> from the chain of types) and "safe to ignore non-structural type" that
> can't be part of any struct/union and are more like decl_tag where
> they only reference other types, but can be dropped/replaced with
> something? And if kind doesn't have either of those, we won't attempt
> to sanitize (and hopefully we won't even have kinds like that, but if
> necessary we can add more flags with some other "safe" semantics, if
> necessary?)

Hold on. I'm missing how libbpf will sanitize things for older kernels?
I think new kind just to be ignored is not great.
libbpf can use any existing kind to sanitize and give it some
convention defined name to separate from normal types of the same kind.
We do this for bpf insn with call #magic_helper_number.

Flags sound nice, but libbpf would still need to sanitize for old
kernels. If it needs to sanitize for very old vs recently old things
get more complex.

