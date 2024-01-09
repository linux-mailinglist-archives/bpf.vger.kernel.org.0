Return-Path: <bpf+bounces-19278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F250828CA3
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06DE288E50
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8143A1D7;
	Tue,  9 Jan 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJJuKRSQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498B3D0A0
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso3806041a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704825146; x=1705429946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djxmGs6MlPlacilbRpICOxZCKPHdSO9sSJ3YRYR3y/g=;
        b=OJJuKRSQH5klqm+kTX/XYFst/clJ/jlsvBBvAr/V96v+HWfxgXqnPY3v/PLOuQ6EVR
         lu2jSAOpB4v1DU0E6AEwXV5wKE6s7DfJd9Affj66J94GerMeRzOKI/ZSd+jOMBXefWcL
         0cM/lhH1h4FGRlP3JL2AI6bokolkVy/sb6PHDfuuPjBOTlFBwdbO2HbXqJxomnH4lwJh
         nvsx5l1M6zC4aqeDIt4NYjvq1/Ki1jdnXxxoSdB/4tlxHCup7Lnbrv2cO59CtgIuh/3A
         jng1M5SzD0G3XYJG5gUgEu93PIeRlE63qntU6fbTEeElkAPKg5YrEA3+bBlc344dEixP
         dfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825146; x=1705429946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djxmGs6MlPlacilbRpICOxZCKPHdSO9sSJ3YRYR3y/g=;
        b=IPAv+HP/H0lxWcYWcmdKuFPlJAU21G1BRAJ2PCwCoQQK9ApdvOMrNmc1oZjpDV3GuE
         j4BqdOQcD4KkX5mkRgudhBIb8Y7wDgAnL+ucO94C0HWThxvB2P7SrBWnAcsd7u1B7Lea
         E8uTENSyVlpn7SeZJL7FogVQEsQNzYFBnBLLzPuMnRhSdTedMnvcmXzOqYLhqWljnJID
         ZnuoGYSNLeYUQuO+LskIzqXYhz2RLO3uGjszQPOuOlRe0I0GoZkD3yTzm8320Qjdb7BV
         ZicYkl178SGQGHFHpygP0JJPVIVrMJOGRI0F8WAZ0wY7ILrTnNnYSKZ7aOAIKIVDGY6W
         Hs+A==
X-Gm-Message-State: AOJu0YwDrgLKRdEeLbHasxbG/toUnM5VB7PKcnaRVgWeUyGQQ+OfvjVs
	hboFzKB+b8vlbyQv8quOFUfme+Xo9FFXWzYB9Fk=
X-Google-Smtp-Source: AGHT+IEvEZAgfZcEmEZHKJfeBD6C7geOINVf9HZtvGZOvCQ5O0/uLAkeegq0uiP9wc/C1olIS/zfDyt3Sw5DqYxNTYw=
X-Received: by 2002:aa7:d381:0:b0:556:b290:4277 with SMTP id
 x1-20020aa7d381000000b00556b2904277mr1845591edq.145.1704825146039; Tue, 09
 Jan 2024 10:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-3-eddyz87@gmail.com>
 <CAEf4BzYSPGmMucCwADeKYcivyyvnf0jDvxuRGieMGeW8+Ci89w@mail.gmail.com> <9940a209ef0ab96b817d45a2b8282d1bb796240c.camel@gmail.com>
In-Reply-To: <9940a209ef0ab96b817d45a2b8282d1bb796240c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 10:32:13 -0800
Message-ID: <CAEf4BzZ8Yh2HdJdkSfHC4UmgB6p+681qdZNud2b9tf6T0deC6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, zenczykowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-01-08 at 16:45 -0800, Andrii Nakryiko wrote:
> [...]
> > > @@ -14713,6 +14714,13 @@ static bool try_match_pkt_pointers(const str=
uct bpf_insn *insn,
> > >                 find_good_pkt_pointers(other_branch, dst_reg, dst_reg=
->type, opcode =3D=3D BPF_JLT);
> > >                 mark_pkt_end(this_branch, dst_regno, opcode =3D=3D BP=
F_JLE);
> > >                 break;
> > > +       case BPF_JEQ:
> > > +       case BPF_JNE:
> > > +               /* pkt_data =3D=3D/!=3D pkt_end, pkt_meta =3D=3D/!=3D=
 pkt_data */
> > > +               eq_branch =3D opcode =3D=3D BPF_JEQ ? other_branch : =
this_branch;
> > > +               find_good_pkt_pointers(eq_branch, dst_reg, dst_reg->t=
ype, true);
> > > +               mark_pkt_end(eq_branch, dst_regno, false);
> >
> > hm... if pkt_data !=3D pkt_end in this_branch, can we really infer
> > whether reg->range is BEYOND_PKT_END or AT_PKT_END? What if it's
> > IN_FRONT_OF_PKT_END?
>
> pkt_data !=3D pkt_end in this_branch means that there is an instruction:
>
>   ...
>   if pkt_data =3D=3D pkt_end goto <other_branch>
>   ... <this_branch> ...
>
> the 'eq_branch' would be set to 'other_branch' and AT_PKT_END would be se=
t
> for dst register in 'other_branch'. What's wrong with this?
> Or did you mean something else?

Well, first off, I'm very unfamiliar with all these pkt_xxx registers,
so excuse me for stupid questions. I guess what got me confused was
that find_good_pkt_pointer() and mark_pkt_end() previously (for
GT/GE/LT/LE) were working on opposing branches. But here I see they
work on the same "equal" branch. But now I'm wondering what's the
point of even calling find_good_pkt_pointer()? Is there a scenario
where it can derive new information from JEQ/JNE?

