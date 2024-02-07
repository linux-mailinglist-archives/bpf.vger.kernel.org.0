Return-Path: <bpf+bounces-21388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4319884C27D
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 03:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0021328CA75
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83210788;
	Wed,  7 Feb 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho6bs2JU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39C101D5
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272787; cv=none; b=WzK9Huo2r2GBIUREXhAaraDM314CGFx/Ne3EzhMiUje0R7MGgURruoaZtc+UHJPt9+BoJCBRZGP+8ug+3dODVNmvvwXL9xYmMP/pQ0UXuCVqPpaPwTahmjlXvdeNXB/J+q41dQvnmgnniewZ//uE2wAH51yg61UaP7/SMT2EMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272787; c=relaxed/simple;
	bh=9JMkxxzpV5yZUcpiWNnGU1g/C3PRn2dnoYV5kslRxrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtfJ40F/U+ufwFkSQNW+z/+IjHjk7ePH3RmhP7Q7QKkh2by5GrUgmJYNOyBh8W3LaF5qKkLyhMldaouiUh88jG7iJtetWbhK2uE7+5S5TUIyzdgivGX9zYfcQiVYLI2Jnjk09VUuniFEpFQA8f7Igi6hJW9hzTcmJBI+4NfiO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho6bs2JU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fe32fcbdaso823305e9.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 18:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707272783; x=1707877583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=encXDrJ6aTHoLNQ4j7L7ePtT+7SKopVCK8nOpOh6RQg=;
        b=ho6bs2JUxJe6BTCbMtTsXYdqrsSU1NzRXj0q+4sNVCIKyuQT8NR4zqPuamNdatEKIQ
         Pgzze93tcA7hn7TU6y5/o5ONkXE8WV3xDVGenbVEBasjvJ3E5U8Rou4Z82cYQauNJfxy
         RbGZe04L+E6DVN/GM3V995XW44EcskMZlpOwfL7KZYEK1YpofzTVDxPLBCcLVa41V3PJ
         x9SZLY3Q1vplScwz7xRcv2zIyvGeaqlnZxF6fxqRO10gLB77WnfNmHeNLNoLBc1Ft12H
         E7T2/q7lHcCmyeKc6eEPxlBeAQYG2YJv8xLM4BhdK9HgBqSVymeWVk8rtBC38bQE+gXW
         cf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707272783; x=1707877583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=encXDrJ6aTHoLNQ4j7L7ePtT+7SKopVCK8nOpOh6RQg=;
        b=VEHX6gq94eKc4FiIfcZfecysgHb067t9LI+AOKLNA16nbhbwrn55KfSra55q4/5T5E
         bhenZDLHiDjZu5tGd2eTGyfVMzvai4f+hr7ubX7xF5WwpgfYGaqQ+Dwes1V/w+G1cPJj
         5zuDTM59SV7dcSNH3xXHl1OH7PZiDNPJf1oVM2B5PHUqeH/8Zr5LrtQGZE3ZuId7sHiM
         yfiUs3yXHCxtRdsY7qEm657mP1YyIOiW7i1RDGK02s5LtCwBM6+bDCJHXt1c935P/tO3
         bGPNuMoxr5U/CWEQWkv2q4nLcjIrmDFmoAFEpvJIfQ6hu6wnjeUnA7sCw3ccdAA2AHbx
         3R7w==
X-Forwarded-Encrypted: i=1; AJvYcCWXeWw/cSipIL6x2OU1R3CfueYiYZ9LDdmndPrF9QcyM5tyVLXr/9gypzI4o5Ajx0t/wgQrZvXPoKSMveUiJIXE5shY
X-Gm-Message-State: AOJu0YwdK7cWBdwhDMXkmz9O4LkSMy8vP1I5DVSsksDeISUwgHmKIRXp
	xK8xCBfc27KGiqPvCWRYsznCAAWLE0yqz+kLivlcgzvVr4gIFcrUzTjn+mqg6HL0cl+bN27l/qi
	Y+LI+0yDvxy1vF4TkESWlSTFAPQ/GTDPB4Nw=
X-Google-Smtp-Source: AGHT+IGrL2AIqK6YcV2D2ZqcCRxv1ltK8FCwEsmbrNERG+9fsJkvKaczmQbTS60F5BNJjNpa0KHCuBvS6kwoCkq84Vw=
X-Received: by 2002:a5d:4578:0:b0:33b:2bda:c00b with SMTP id
 a24-20020a5d4578000000b0033b2bdac00bmr2283441wrc.0.1707272783285; Tue, 06 Feb
 2024 18:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com> <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com> <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
In-Reply-To: <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Feb 2024 18:26:12 -0800
Message-ID: <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 4def3dde35f6..bdd6be718e82 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > >         };
> > >         /* an array of original indexes for all xlated instructions *=
/
> > >         u32 *orig_idx;
> > > +       /* for every xlated instruction point to all generated jited
> > > +        * instructions, if allocated
> > > +        */
> > > +       struct {
> > > +               u32 off;        /* local offset in the jitted code */
> > > +               u32 len;        /* the total len of generated jit cod=
e */
> > > +       } *xlated_to_jit;
> >
> > Simply put Nack to this approach.
> >
> > Patches 2 and 3 add an extreme amount of memory overhead.
> >
> > As we discussed during office hours we need a "pointer to insn" concept
> > aka "index on insn".
> > The verifier would need to track that such things exist and adjust
> > indices of insns when patching affects those indices.
> >
> > For every static branch there will be one such "pointer to insn".
> > Different algorithms can be used to keep them correct.
> > The simplest 'lets iterate over all such pointers and update them'
> > during patch_insn() may even be ok to start.
> >
> > Such "pointer to insn" won't add any memory overhead.
> > When patch+jit is done all such "pointer to insn" are fixed value.
>
> Ok, thanks for looking, this makes sense.

Before jumping into coding I think it would be good to discuss
the design first.
I'm thinking such "address of insn" will be similar to
existing "address of subprog",
which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
"address of insn" would be a bit more involved to track
during JIT and likely trivial during insn patching,
since we're already doing imm adjustment for pseudo_func.
So that part of design is straightforward.
Implementation in the kernel and libbpf can copy paste from pseudo_func too=
.

The question is whether such "address of insn" should be allowed
in the data section. If so, we need to brainstorm how to
do it cleanly.
We had various hacks for similar things in the past. Like prog_array.
Let's not repeat such mistakes.

