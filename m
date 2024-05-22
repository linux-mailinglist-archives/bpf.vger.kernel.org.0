Return-Path: <bpf+bounces-30313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65A8CC537
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4416C1F21D03
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F91420BE;
	Wed, 22 May 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arIpQ77D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BD141987
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397072; cv=none; b=XY41K1tROp+pba3tMAX0kf5f/Cs6ro1/2814W+QliXG3lrochKrW4oEvVSortP0GtBJ2/snV9UXvD63EgffBApU4PzTSLX9P36zkRn5oXqKicA0Lzm9s6EG0H64Mfbtz9PMo3g1uNAUXaEGf9SQzj1HLj0PBRAnOyHk5fnHIXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397072; c=relaxed/simple;
	bh=qlAjixKx6yNZIxcAT+DLn8bjY+GpQImfsVVnpTEc6Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYanlC+tbEaNKRrvxMx7URnZ3d5D6eOvuayR0qm9C2GYANBVTdiK3qc9m82yaN6mes7v1p6w1TKtiO7WZSBa6/nc0WHZPKEZHcNOHdgT/JvSOBnWXSmjuTV2/OUbs09j0eWHdFCT6HJbZ2WFpzatAcPziUiLIF2FlbLVnpSdC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arIpQ77D; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bd92b3939fso1177683a91.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716397070; x=1717001870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGTCejr0IMwjrwkmd5iwPFn+Y5HIj8EywTWMHSYqxXY=;
        b=arIpQ77DVqfQ/dF7070AqwjyRM/l3W1C+s9rK3CoG6/4NRcga9oa9lIfTUv1CFtyqi
         Y6XnSpXvF+jKXBeh/yKHYc/9kO/7J/nSxcMQbJO0Q5oHrcI0B/S+CT6lNvmnqR/9ow3L
         W2xuLQSe0SRGUPDZuQSd4UnF2a8n1GA32xUQvISHViEeGF7OSoWWqS5XwMqa/2HHTOxJ
         HTECkzFomP4N0eLotviC8e8rpSZGngOsFz6qK9dh8Srix7kv0XohMxwmccfrHXFvlXpD
         1+T7g6ajwcJtSL1JV/QG7gZrWoFedO8g9qysO07ZMfyUn6w3NxukPKIa4iddtVxH14Qb
         6Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716397070; x=1717001870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGTCejr0IMwjrwkmd5iwPFn+Y5HIj8EywTWMHSYqxXY=;
        b=pPKt7oYKFWSLNoL2Kg1EEVR62sNlTqJRTfpFLuJ3YMEuM8FYyqeSuGSfxXILBK+O9y
         /ODDvnowstOQTASKsZZpZ7BSCiJLpdb1IwMxg4twjz3zcBhqHNqWyxA1c5J9DP6Y20oT
         R1cjNI6rcKsiB6ewt3tUp+OAGjJB7FkxzyZKg/jdFEcZc2jpz8pG341XixPeE/aTgZNi
         +kZF/Bpi8yUS3Jn+0i28xg0lhqTo7grvvX37JTjI2tvSLcCcXQn5h/gsSqVMrIITNBmY
         pyGvqUMeZfeSTlCfDa9M0mFDrhrF6LlmB4OveUw9IKsK1elVl4GHrkivml1dMGa8Fave
         jBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWanm2xS2n2Xc+LO+MkXp9Bz71oRc/t/Jgh6y3LUpJbdOlXJovaPtO3B0HWI/hdcTfo58XI2cj6YXW5Acviv6FBD+qK
X-Gm-Message-State: AOJu0Yz67kOl/YYz6uCigPDt44hk+Z85Vnx91zJmMtkT7BN6n6bZ/VQq
	FFjIGZ+Rsu5u2Hk01S/NNM5eBuYxZmdJApEzY2mBFho1vHtQNtrKDUKzX92pIDdvWylPAeygfrF
	3xxmlsFbaRPjuRM4wpMDu+h3nATRVCg==
X-Google-Smtp-Source: AGHT+IG3FhgI5RNFC8GEhytEoMCUS8YRdyz/6GoO5sMGeEgQGJOnQcjsoh0A4VcbZ86lYl87l3FdbRRMBCOli1v+luI=
X-Received: by 2002:a17:90a:ba98:b0:2b5:4ee8:e5e8 with SMTP id
 98e67ed59e1d1-2bd9f463b10mr2597563a91.16.1716397070408; Wed, 22 May 2024
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <20240517102246.4070184-2-alan.maguire@oracle.com> <CAEf4Bzao+YSk9LfyDFVbWY-BKzExrvoAHn_5D37J7Mi2Rna06w@mail.gmail.com>
 <8d1c6821-4918-42f1-b17e-cc56014cb552@oracle.com>
In-Reply-To: <8d1c6821-4918-42f1-b17e-cc56014cb552@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 May 2024 09:57:38 -0700
Message-ID: <CAEf4BzZf9QGV98MfUdwW5x+241LWw-jxC29i6dYM4mY_s4oghA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 9:42=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 21/05/2024 22:48, Andrii Nakryiko wrote:
> > On Fri, May 17, 2024 at 3:23=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> To support more robust split BTF, adding supplemental context for the
> >> base BTF type ids that split BTF refers to is required.  Without such
> >> references, a simple shuffling of base BTF type ids (without any other
> >> significant change) invalidates the split BTF.  Here the attempt is ma=
de
> >> to store additional context to make split BTF more robust.
> >>
> >> This context comes in the form of distilled base BTF providing minimal
> >> information (name and - in some cases - size) for base INTs, FLOATs,
> >> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
> >> points at that base and contains any additional types needed (such as
> >> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
> >> information constitutes the minimal BTF representation needed to
> >> disambiguate or remove split BTF references to base BTF.  The rules
> >> are as follows:
> >>
> >> - INT, FLOAT are recorded in full.
> >> - if a named base BTF STRUCT or UNION is referred to from split BTF, i=
t
> >>   will be encoded either as a zero-member sized STRUCT/UNION (preservi=
ng
> >>   size for later relocation checks) or as a named FWD.  Only base BTF
> >>   STRUCT/UNIONs that are either embedded in split BTF STRUCT/UNIONs or
> >>   that have multiple STRUCT/UNION instances of the same name need to
> >>   preserve size information, so a FWD representation will be used in
> >>   most cases.
> >> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
> >>   with no values) is used.
> >> - in all other cases, the type is added to the new split BTF.
> >>
> >> Avoiding struct/union/enum/enum64 expansion is important to keep the
> >> distilled base BTF representation to a minimum size.
> >>
> >> When successful, new representations of the distilled base BTF and new
> >> split BTF that refers to it are returned.  Both need to be freed by th=
e
> >> caller.
> >>
> >> So to take a simple example, with split BTF with a type referring
> >> to "struct sk_buff", we will generate distilled base BTF with a
> >> FWD struct sk_buff, and the split BTF will refer to it instead.
> >>
> >> Tools like pahole can utilize such split BTF to populate the .BTF
> >> section (split BTF) and an additional .BTF.base section.  Then
> >> when the split BTF is loaded, the distilled base BTF can be used
> >> to relocate split BTF to reference the current (and possibly changed)
> >> base BTF.
> >>
> >> So for example if "struct sk_buff" was id 502 when the split BTF was
> >> originally generated,  we can use the distilled base BTF to see that
> >> id 502 refers to a "struct sk_buff" and replace instances of id 502
> >> with the current (relocated) base BTF sk_buff type id.
> >>
> >> Distilled base BTF is small; when building a kernel with all modules
> >> using distilled base BTF as a test, ovreall module size grew by only
> >
> > typo: overall
> >
> >> 5.3Mb total across ~2700 modules.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c      | 409 ++++++++++++++++++++++++++++++++++++++=
-
> >>  tools/lib/bpf/btf.h      |  20 ++
> >>  tools/lib/bpf/libbpf.map |   1 +
> >>  3 files changed, 424 insertions(+), 6 deletions(-)
> >>

[...]

> >> +#define BTF_ID(id)             (id & ~BTF_NEEDS_SIZE)
> >> +
> >> +struct btf_distill {
> >> +       struct btf_pipe pipe;
> >> +       int *ids;
> >
> > reading the rest of the code, this BTF_NEEDS_SIZE and BTF_ID() macro
> > use was quite distracting. I'm wondering if it would be better to use
> > a simple struct with bitfields here, e.g.,
> >
> > struct type_state {
> >     int id: 31;
> >     bool needs_size;
> > };
> >
> > struct dist_state *states;
> >
> > Same memory usage, same efficiency, but more readable code. WDYT?
> >
>
> Yeah, I saw Eduard used that approach elsewhere, it's much neater.
> However in other discussion with Eduard we talked about moving the
> embedded/duplicate validation to relocation time. The motivation for
> that is that if we record sizes for all STRUCTs and UNIONs, we can then
> be selective about size checks at relocation time.  This is particularly
> relevant for the duplicate name case since it's possible a name either
> is no longer duplicate in the new vmlinux, or in the new vmlinux has a
> duplicate where the original vmlinux did not. In other words it's the
> "new world" of the vmlinux we're trying to relocate with that we're
> really concerned with, so preserving all size information until we see
> that new vmlinux and can spot duplicates and embedded types where the
> size checks need to be enforced makes sense I think.

Sure, I think it makes sense (though let's see how much more
complexity we add to relocation code).

>
> In that context, we mark embedded types prior to assigning mappings, and
> don't mark duplicate names at all in the map since it is duplicates in
> the new vmlinux we're interested in. So the way I'd approached it is to
> have a BTF_IS_EMBEDDED (casting -1) value that the map values would set
> when they found a split BTF struct/union with an embedded base BTF type.
> That later gets overwritten when we do the map assignments so it never
> gets exposed to the user and we can still return a __u32 array of BTF
> ids to the caller.

My only question/concern is duplicate named entries in distilled base.
How will that work with binary search (at least the exact variant you
are using). But I'm not sure I understand all the nuances of what you
agreed on.

[...]

> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/* Check if composite type has a duplicate-named type; if it does, re=
tain
> >
> > see above about check vs mark, here at least the function name uses "ma=
rk" :)
> >
> >> + * size information to help guide later relocation towards the correc=
t type.
> >> + * For example there are duplicate 'dma_chan' structs in vmlinux BTF;
> >> + * one is size 112, the other 16.  Having size information allows rel=
ocation
> >> + * to choose the right one.
> >
> > re: this dma_chan and similar cases. Is it ever a problem where a
> > module actually needs two dma_chan in distilled base BTF? Name
> > conflicts do happen, but intuitively I'd expect this to happen between
> > some vmlinux-internal (so to speak, i.e., not the type used in
> > exported functions/types) and kernel module-specific types. It would
> > be awkward for the same module to use two different types that are
> > named the same.
> >
> > Have you seen this as a problem in practice? What if for now we just
> > error out if there are two conflicting types required in distilled
> > BTF?
>
> Funnily enough I ran into it with "dma_chan" itself when trying to load
> an in-tree module which I'd forced (along with the rest of the tree) to
> be built with distilled base BTF.  And it was also an embedded struct
> too, so we got 2 for 1 there ;-)
>
> But it does seem like it's a legitimate problem, so if we can address it
> I think it'd be worth trying. Even the size checks (applied at
> relocation time) would be better than nothing I think.
>
> The only other way I could think that we could disambiguate things would
> be to add the duplicate-named type to the split BTF (as we do with the
> anonymous structs).  That would remove the ambiguity, but expose us to
> the risk of having to pull in a lot more types. I can't imagine a
> duplicate-named type would ever figure in a kfunc signature, so it
> should be safe to do. But I think either way we probably have to have
> some sort of answer for this problem.
>

Ok, just keep in mind that duplicated names in distilled base BTF do
cause issues when "joining" actual vmlinux BTF and distilled base BTF.

[...]

> >> +
> >> +       /* struct/union members not needed, except for anonymous struc=
ts
> >> +        * and unions, which we need since name won't help us determin=
e
> >> +        * matches; so if a named struct/union, no need to recurse
> >> +        * into members.
> >> +        */
> >
> > is this an outdated comment? we shouldn't have anonymous types in the
> > distilled base, right?
>
> Yep, they go into split BTF. However, we might need to add their members
> to our distilled base; for example if we hadn't yet added an int and had
>
>         struct {
>                 int field;
>         };
>
> ...we'd want to make sure we added an INT to our distilled base. I'll
> try and clarify the comment a bit more.

I see, it makes sense. Yes, let's add a comment, it's a bit subtle.

>
> >
> >> +       if (btf_is_eligible_named_fwd(t))
> >> +               return 0;
> >> +

[...]

> >> +                               err =3D btf__add_enum(dist->pipe.dst, =
name, t->size);
> >> +                               break;
> >> +                       default:
> >> +                               pr_warn("unexpected kind [%u] when cre=
ating distilled base BTF.\n",
> >> +                                       btf_kind(t));
> >> +                               return -EINVAL;
> >> +                       }
> >> +               } else {
> >> +                       err =3D btf_add_type(&dist->pipe, t);
> >
> > So this should never happen if adding_to_base =3D=3D true, is that righ=
t?
> > Can we check this? Or am I missing something as usual?
> >
>
> We're currently adding INTs and FLOATs to the base also, so they are two
> cases where we end up here I think.

let's have them as another explicit case and then warn for everything
we don't expect to be added? I'm trying to prevent silent problems we
haven't thought about or that will appear in the future due to BTF
extension, so let's be conservative everywhere.

>
> >> +               }
> >> +               if (err < 0)
> >> +                       break;
> >> +               dist->ids[i] =3D id++;
> >> +       }
> >> +       return err;
> >> +}
> >> +
> >

[...]

