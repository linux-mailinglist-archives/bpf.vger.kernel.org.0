Return-Path: <bpf+bounces-77187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA52CD155A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 074D130198EB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3E387B0E;
	Fri, 19 Dec 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTqzkg2A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C4382D41
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168378; cv=none; b=DgVSn0hHq/FjDlLfCLYP2DfpuYVV9pqXctgWX88HiWo9Plm3vMjHRAQvAr29g7zwOKKkmKlFvOuKBTEfC4stcqlDWl6kqlCpkswPNlDsFarY95msSkzBHsDiSFDT1o4k2oyS4fRkntfrSvHVac09w8W/7Pm7DACHPJ2sM1gWNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168378; c=relaxed/simple;
	bh=kPSnauOh35T2uRJQwpLp11gDnNuUjO8JFiMbZ0DTF+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je46T2+Dm2+SqG/J6LnXh3iHGmE3rDwK9KSS4oLRX94w+KbzQ7ubPbrCzBKcvGgVFArHZChtB+uOR0RJfvv+LzQ8Yix9o9goGNlzjZUd+yvgGd8gWsxYyqjnj2ulWin2jGjdmTQmeag+6yI0LTAtoO4i9VvbRlj8rbecw8cwCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTqzkg2A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c213f7690so1712895a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168375; x=1766773175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haS2Jgk2geqqgqgUJ+qGj/5ue2os4ZAQulE1vWMJOOQ=;
        b=iTqzkg2A03lfkT3lQH/eHT4r9kG/F459sawPm1tx7jeXFKyjIVAWmR17VtPcou7hU3
         5UGCyOhuutVpOcCLf8Ql+RWoFcq9Ft8StBNV8Gbj1l3NeaowTcpZ+ZW7VukgTEiIhrBs
         wFR/P72GceoSuSaL6YNl82a9CdISh+NOi/0h1z+6NZ30x3VFNyUid3NDHDSXYvIwsU+J
         3UzoSdKpYAwoDwutOg0R2sibBU2AVBHrYgMVBIS/7VeQvvrEkGrp+vXa5dy/TLK4Q2PY
         XZYBcRdnpo+AEpCdPRRt5dgLJX/AJkcn2eold+Ohprw3q+Bbv0Db073jiXCn//LCIU7i
         2q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168375; x=1766773175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haS2Jgk2geqqgqgUJ+qGj/5ue2os4ZAQulE1vWMJOOQ=;
        b=IdGVs8hKEZlC2aJelh8ggKn64RIwxVBlCSYxZHM7/ehlOTdIVcZwl3H+qVhkeEHXwR
         ZAhYBRAkn3Ty/968NH+xVy2TbTY2YiE35WjPoiU3RFVlfee2LM+PxjjmV0hTBBklAbVt
         wPAGEIIR4j9OKdvPz3NgcS3dU7b14dK7GKlyrPQmu8KVRVR98nQvcMWEeNmQ7fPbTzPb
         UPZvT2chRixTJC7+dkOrxgVmvj50tiqYymDB4xzjvTl/fiZnSc5+DsVyWYm8Dr/nQQ82
         VGbL35LiNkfs2l0TYII/VaaPusx0uLJRYKFv9EuSP6zmYx+FsHBn9y92UW7OxHEKmTXo
         nYgw==
X-Forwarded-Encrypted: i=1; AJvYcCWM+X2zl8TiB7mPshIq6HRtRnC9uYLd1U1L7rE1ef9YoCKJOpt48jF82QUwNRj4lCtQAdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOPJzzaUph54vr8o8v8LZq08+I+6AV5pXrQ9kjI/xHaxyZVYb
	m3efZquIGc8BK2sMN08nwJHijEVzlRVNbOnohlzNN7ixJWHbpF2IU37Egb1Jv4vLyaXdHFQ0qJ0
	mJmOG6JMbYE5TTN78rCTVI4139TInoqc=
X-Gm-Gg: AY/fxX4mCIMNIbbmblIVhEH/dhiG2EGZmeRCDz9bM6c3zBokZvTKNIkD/ylf3m0h8ak
	lIzkeCR0Nx+Xuf7iX+IbeImT+FiAnXBTVSoRGNqKQVM8B+QnnF4pGLe4gHo8kinuAeyOkBzzj9l
	mv70BqjWZjwLGcH0+qhxNcBRBhGT/cQLeAabL9j6R1y2lww3vJ04UtkjVRL9zUneXgusjUOnA6Q
	HibGsVjEWoFX52RDtuevTJACipCBaOsxnpIQ7TbXY3zti1tG/ZlkRK5Y73tXPkc4/Q/eyY=
X-Google-Smtp-Source: AGHT+IFx4a+AppuzX/FbCeu+FDxPaNaADYjmHwAXphHwzxvS8HmDb5QOcWNm4ESLI/qdzoOlorG1Nsl+y/fnNlHVALQ=
X-Received: by 2002:a17:90b:37c3:b0:330:7ff5:2c58 with SMTP id
 98e67ed59e1d1-34e9211d448mr3629714a91.7.1766168374459; Fri, 19 Dec 2025
 10:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
In-Reply-To: <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:19:22 -0800
X-Gm-Features: AQt7F2pIYGA_Eyj6afGComfhAYielY0COjLNBQf_Ir5m5cR1AqbCibmOxfw_V6c
Message-ID: <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:14=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 19/12/2025 17:53, Andrii Nakryiko wrote:
> > On Fri, Dec 19, 2025 at 5:15=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 16/12/2025 19:23, Andrii Nakryiko wrote:
> >>> On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> >>>>
> >>>> BTF kind layouts provide information to parse BTF kinds. By separati=
ng
> >>>> parsing BTF from using all the information it provides, we allow BTF
> >>>> to encode new features even if they cannot be used by readers. This
> >>>> will be helpful in particular for cases where older tools are used
> >>>> to parse newer BTF with kinds the older tools do not recognize;
> >>>> the BTF can still be parsed in such cases using kind layout.
> >>>>
> >>>> The intent is to support encoding of kind layouts optionally so that
> >>>> tools like pahole can add this information. For each kind, we record
> >>>>
> >>>> - length of singular element following struct btf_type
> >>>> - length of each of the btf_vlen() elements following
> >>>>
> >>>> The ideas here were discussed at [1], [2]; hence
> >>>>
> >>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>
> >>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4=
bn=3DNuc1g8JPFC34MA@mail.gmail.com/
> >>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguir=
e@oracle.com/
> >>>> ---
> >>>>  include/uapi/linux/btf.h       | 11 +++++++++++
> >>>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
> >>>>  2 files changed, 22 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> >>>> index 266d4ffa6c07..c1854a1c7b38 100644
> >>>> --- a/include/uapi/linux/btf.h
> >>>> +++ b/include/uapi/linux/btf.h
> >>>> @@ -8,6 +8,15 @@
> >>>>  #define BTF_MAGIC      0xeB9F
> >>>>  #define BTF_VERSION    1
> >>>>
> >>>> +/*
> >>>> + * kind layout section consists of a struct btf_kind_layout for eac=
h known
> >>>> + * kind at BTF encoding time.
> >>>> + */
> >>>> +struct btf_kind_layout {
> >>>> +       __u8 info_sz;           /* size of singular element after bt=
f_type */
> >>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) eleme=
nts */
> >>>
> >>> So Eduard pointed out that at some point we discussed having a name o=
f
> >>> a kind (i.e., "struct", "typedef", etc). By now I have no recollectio=
n
> >>> what were the arguments, do you remember? I'm not sure how I feel now
> >>> about having extra 4 bytes per kind, but that's not really a lot of
> >>> data (20*4 =3D 80 bytes added), so might as well add it, I suppose?
> >>>
> >>
> >> Yeah we went back and forth on that; I think it's on balance worthwhil=
e
> >> to be honest; tools can be a bit more expressive about what's missing.
> >>
> >>> I think we were also discussing having flags per kind to designate
> >>> some extra semantics, where applicable. Again, don't remember
> >>> arguments for or against, but one case where I think this would be
> >>> very beneficial is when we add something like type_tag, which is
> >>> inevitably used from "normal" struct and will be almost inevitable in
> >>> normal vmlinux BTF. Think about it, we have some field which will be
> >>> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
> >>> totally break (old) bpftool's dump, as it really can be easily ignore=
d
> >>> **if we know TYPE_TAG can be ignored and it is just a reference
> >>> type**. That reference type means that there is another type pointed
> >>> to using struct btf_type::type field (instead of that field being a
> >>> size).
> >>>
> >>> So I think it would be nice to encode this as a flag that says a) kin=
d
> >>> can be ignored without compromising type integrity (i.e., memory
> >>> layout is preserved) which will be true for all kinds of modifier
> >>> kinds (const/volatile/restrict/type_tag, even for typedef that should
> >>> be true) and b) kind is reference type, so struct btf_type::type is a
> >>> "pointer" to a valid other underlying type.
> >>>
> >>> Thoughts?
> >>>
> >>
> >> Again we did go back and forth here but to me there's much more value =
in
> >> being both able to parse _and_ sanitize BTF, at least for the simple c=
ases.
> >> What we can include are as you say types in the type graph that are op=
tional
> >> reference kinds (like type tag), and kinds that are not implicated in =
the
> >> known type graph like the location stuff (it only points _to_ known ki=
nds,
> >> no known kinds will point to location data). So any case where known
> >> types + optional ref types constitute the type graph we are good.
> >> Anything more complex than these would involve having to represent the
> >> layout of type references within unknown kinds (kind of like what we d=
o for
> >> field iteration) which seems a bit much.
> >>
> >> Now one thing that we might want to introduce here is a sanitization-f=
riendly
> >> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting ki=
nd
> >> which can be used to overwrite kinds we don't want in the sanitized ou=
tput.
> >> We need this to preserve the type ids for the kernel BTF we sanitize.
> >> I get that it seems weird to add a new incompatibility to handle incom=
patibility,
> >> but the sooner we do it the better I guess. The reason I suggest it no=
w is we'd
> >> potentially need some more complex sanitization for the location stuff=
 for
> >> cases like large location sections, and it might be cleaner to have a =
special
> >> "ignore this it's just sanitization info" kind, especially for cases l=
ike
> >> BTF C dump.
> >
> > So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
> > we can "overwrite" any possible unknown BTF kind?.. As you said,
> > though, this would only work for new kernels, so that's sad... I don't
> > know, I don't hate the idea, but curious what others think.
> >
> > Alternatively, we can just try to never add kinds where the vlen
> > element is not a multiple of 8 or 12. We can then use ENUM
> > (8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknown
> > types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
> > are other options. We just don't have 4-bytes-per-vlen for the most
> > universal "filler", unfortunately.
> >
> > The advantage of the latter is full backwards compatibility with old ke=
rnels.
> >
>
> True. And I guess during sanitization we can just handle intermediate
> types in a type graph by adjusting type ids to skip over them, so we
> likely have everything we need already. Funnily enough the BTF location
> stuff will give us a vlen-specified 4 byte object (specifying the
> location parameters associated with an inline), so that will help in
> the future for cases where it is recognized but other kinds are not.

So coming back to flags? Let's do two flags: "safe modifier-like
reference kind" (for type_tag-like things where they can be dropped
from the chain of types) and "safe to ignore non-structural type" that
can't be part of any struct/union and are more like decl_tag where
they only reference other types, but can be dropped/replaced with
something? And if kind doesn't have either of those, we won't attempt
to sanitize (and hopefully we won't even have kinds like that, but if
necessary we can add more flags with some other "safe" semantics, if
necessary?)

>
> Alan

