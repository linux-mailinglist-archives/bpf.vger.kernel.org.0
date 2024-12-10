Return-Path: <bpf+bounces-46441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDC9EA3E6
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3445E2866CB
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979522758B;
	Tue, 10 Dec 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJM5mZRH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6B13635E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791734; cv=none; b=DcHPc1iMBNKgGz2zVcni9UA/nP1vKI1s98cSp1e7BnqOxr6/UKPq7gunAa32uAHEuVdUUMKatQZcAGEWk6Y7xowx7qHPMnRLmUvggq6ICeUW/GAQb2+0eE/Ecgm7svC+gBe/sZdOWgHgND1jjW/fYmUuIGHeZ425NeEi/adUCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791734; c=relaxed/simple;
	bh=MJatw+wLEMYmFIvUmqJZcLTOu7lwG2n9Xw/Odtu8uPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i86Bp8cWTGf8KaJtgwhCfeQE0kbAHpMqF4jJc70N5y6GaY+Dv08WKalEDYSyKFoI2WLGdVKVL8fZ+vJGQ/XieAM2L9X7XcrQz5aDlSs6uHvLvuMqpHfRJbWUVjRjyYbi8D22sZQXFiIFw7NJCZ8hXgal7DH6NFi0Pii3CoBdK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJM5mZRH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso48236555e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733791730; x=1734396530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orob2Y9clHpLU4sE+RO9Ed41nFdSbsV5unFc7KxsH34=;
        b=MJM5mZRH0/qS13imLTM6/mNJkBL5h6L85TECai4LV/OmlGnwJOx4gAaJ/b+PqkauZF
         reN1KZot6sg3vaovMUvExVcZamKXGZsPS8W6ijUKvHyK8BTH+k6N2d7PxV/X96xdBxE3
         OpJOSxrcrvACU+vPI0qQbvoyDj3ZuCV09EX/9lOM4ZhoGUDKqyeIpK2e0eT7ZDNTbC4V
         TnXz83k+MWdYvD418qcYhQwsFf7uC5oWJc3+3vlb8O4Txh/K5aMDEfwK7pqUHSqGhPn0
         dhhCRbb9It9DyzHocLIeA2qoZBn2x11USrDEri+wkZ8kzdFEnho9e8p6Mfj5RzB1puW0
         vG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791730; x=1734396530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orob2Y9clHpLU4sE+RO9Ed41nFdSbsV5unFc7KxsH34=;
        b=InwHUVSnfbgBHVQ0/fgSRUIgnMpf8XaB6fqv/62J8ivz669Pxf0aYGTGeDJZ9CiHKC
         WjPhBNr2r/KC+VQC8HHYcOz4fQwW+yEwOcdJB33FvQqMgGarN9TyvunsS/NbLctsXER+
         4BXV+UqhtcuHUI2/+6/u49rzkTBj7KIcAGYsdB5PWEOyI1TbxQ0zUcnObUnpahdYHXUh
         OvbTupCaYfCIpSY02vRbVMOBEy2v7cRrVO2QktR8N1iD0/1klo/BGxwIzcPtM06m/kyy
         GJOd9KOogP42GQxjZ9QcSzGHvSBHlcUjIGuP3PLYaDy29DrErxh6VPcfQufP/40GDcFi
         l2Aw==
X-Gm-Message-State: AOJu0YybcGy+y4WPIwCJwBeWJSU8/jo6E880egM94zZJKGebLT2XArts
	DzCJQ3IVx2v+A83Q23KAc7qXTrxdUY5YppqTgGwqaW2EcJSGZPtDX8k7DSioSeCfA0Rxx0nYudi
	OtCFHvRELNbnityS8+8j+bdXbrjqer3iJ
X-Gm-Gg: ASbGncuRDYS8GRD4rdNEV74AMd94CcRLNjsj2kHpvZv2ThGKI/JJ2MgFH8Bv+QSTGlp
	2xnmoX7NrG6gvg9jNU3XndbIRcCr9tUO2fhpkU3vsSrVbfZYcn9Q=
X-Google-Smtp-Source: AGHT+IGA/V7d6hY0iecYJyuec4wEIx0PYpENnWRRL/TYPRq9hWDcrWoLZzIjPPhF/jKgohIdvJgC/gVESY5FJTHd8EY=
X-Received: by 2002:a5d:5889:0:b0:385:f3fb:46a5 with SMTP id
 ffacd0b85a97d-386453fffcemr1530043f8f.52.1733791730283; Mon, 09 Dec 2024
 16:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206040307.568065-1-eddyz87@gmail.com> <20241206040307.568065-4-eddyz87@gmail.com>
 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
 <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
 <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com> <58dbb0671ad59507e45c3f5ff50da66b0f8bd36e.camel@gmail.com>
In-Reply-To: <58dbb0671ad59507e45c3f5ff50da66b0f8bd36e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Dec 2024 16:48:39 -0800
Message-ID: <CAADnVQ+RNBq+nHO2J8m-eaZ_5K=dHk7BBOAwk399e+6qwoybUA@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global functions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-12-09 at 08:53 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > >
> > >     // tc_bpf2bpf.c
> > >     __noinline                             freplace
> > >     int subprog_tc(struct __sk_buff *skb) <--------.
> > >     {                                              |
> > >         int ret =3D 1;                               |
> > >                                                    |
> > >         __sink(skb);                               |
> > >         __sink(ret);                               |
> > >         return ret;                                |
> > >     }                                              |
> > >                                                    |
> > >     SEC("tc")                                      |
> > >     int entry_tc(struct __sk_buff *skb)            |
> > >     {                                              |
> > >         return subprog_tc(skb);                    |
> > >     }                                              |
> > >                                                    |
> > >     // tailcall_freplace.c                         |
> > >     struct {                                       |
> > >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);     |
> > >         __uint(max_entries, 1);                    |
> > >         __uint(key_size, sizeof(__u32));           |
> > >         __uint(value_size, sizeof(__u32));         |
> > >     } jmp_table SEC(".maps");                      |
> > >                                                    |
> > >     int count =3D 0;                                 |
> > >                                                    |
> > >     SEC("freplace")                                |
> > >     int entry_freplace(struct __sk_buff *skb) -----'
> > >     {
> > >         count++;
> > >         bpf_tail_call_static(skb, &jmp_table, 0);
> > >         return count;
> > >     }
> >
> > hmm. none of the above changes pkt_data, so it should be allowed.
> > The prog doesn't read skb->data either.
> > So I don't quite see the problem.
>
> The problem is when I use simplified rule: "every tail call changes packe=
t data",
> as a substitute for proper map content effects tracking.
>
> If map content effects are tracked, there should be no problems
> verifying this program. However, that can't be done in check_cfg(),
> as it does not track register values, and register value is needed to
> identify the map.

We don't need data flow analysis and R1 tracking.

We could do the following rule:
if prog has a tail call and any prog array map in prog->aux->used_maps
calls into prog with adjust_pkt_data assume that this prog
also adjusts pkt_data.

> Hence, mechanics with "in-line" global sub-program
> traversal is needed (as described by Andrii):
> - during a regular verification pass get to a global sub-program call:
>   - if sub-program had not been visited yet, verify it completely
>     and compute changes_pkt_data effect;
>   - continue from the call-site using the computed effect;
> - during a regular verification pass get to a tail call:
>   - check the map pointed to by R1 to see whether it has
>     changes_pkt_data effect.

I don't think we should be adding all that logic when a much simpler
rule (as described above) is good enough.

Also either inline global sub-prog traversal or the simple rule above
both suffer from the following issue:
in case prog_array is empty map->changes_pkt_data will be false.
It will be set to true only when the first
prog_fd_array_get_ptr()->bpf_prog_map_compatible()
will record changes_pkt_data from the first prog inserted in prog_array.

So main prog reading skb->data after calling subprog that tail_calls
somewhere should assume that skb->data is invalidated.

That's pretty much your rule "every tail call changes packet data".

I think we can go with this simplest approach as well.
The test you mentioned have to be adjusted. Not a big deal.

Or we can do:
"if prog_array empty assume adjusts_pkt_data =3D=3D true,
otherwise adj_pkt_data | =3D for each map in used_maps {
map->owner.adj_pkt_data }"

The fancy inline global subprog traversal would have to have the same
"simple" (or call it dumb) rule.
So at the end both inline or check_cfg are not accurate at all,
but check_cfg approach is so much simpler.

