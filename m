Return-Path: <bpf+bounces-46447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66A9EA46F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC91642E9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE07081E;
	Tue, 10 Dec 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Hrcwoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFD4A04
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794700; cv=none; b=GcXid4myy8TiYkNllp99NA9fLNWBoC/5BsutFQ+5LaOiA92WQ6gerbQeu3QhT//V7ukZdne4oF99+TWidqPpTfUL1AI+A9HMCVeD7pCk/8IcbIXYmNBzQEW+O5C1oipfA0cQbDbk1+5tazCpa1TCO+ATDNm3bx1UtN+P0HDZiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794700; c=relaxed/simple;
	bh=HEsCgFqa4MSpmw9hVKR9aA1majIl82XOK4jDFFfE5aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvmv1s9Tthtps8Ag27trfMJ5gA2AExtT/cKVkff5zEnDtF7BSi3416uTM8ELfAkvNVpOfnI38SByzrGcnWdxELuyarxl5mGjipBsGAHU9F/ilvJY8Elf9CJIbfITIenPWEEJ/qqRhIEK2UsyzhwLM9h4kXd+FZ/SoGzvhMIlwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Hrcwoh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso48474455e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 17:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794696; x=1734399496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEsCgFqa4MSpmw9hVKR9aA1majIl82XOK4jDFFfE5aI=;
        b=Y4HrcwohqYjdPO2VN0JcnCgtnRy/HqhQ/Crm633U97ngplqAYzDBZVOJ020mgGJNce
         FNyYgJfkJZa0F3UyDAP88J+evNyH8Rr/LarECpbpjy0SLJ8xsT1T+SoKzjbZFDs9Xdq6
         fQQSUhmMm0Ibq7eljBIcQnEjUnh1qaIxwZfe9vlcJvEnpZIHVltgqq1Apd8rVIncJ8Gg
         3sCZ5bEP/F0SF/WxekAmJ3rf7epvdrjvndPrU+iWzYgmRwmtOd54cRG1bR860OZFifPn
         ySZjCHblpqUVKdIs5hYL3r6BzjV5m9nwnc8NuYfwUtY7j581AZVeUIcDhNmNgGCrG6lw
         8XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794696; x=1734399496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEsCgFqa4MSpmw9hVKR9aA1majIl82XOK4jDFFfE5aI=;
        b=myl0N83Ksmsl8zix0B6j2z27KMrET8G7Txt/V8QjjH/d5Ja1SmMD6H6RYsSduRVxKi
         zocl9cz32xrCz5MhiexmZQO6t5igtOyttOSyNJ8NlbgAZVSMZ0bftCGhPTHhDYWz4zGM
         /QvaYUyrxOBmFkbehPhSqhE0BMvhHQke79mGuRvUv7yV5Fl2mPYlbbKvTHoX+mGb8NdC
         5KyR8MyOqMulO5HZM3Wn2LvnrlznMc4MYztmlHn+ba2EoHS8PUL70l3f2uoIlG3/aG7a
         Vkan62bZzXpYLiHksvkTInjMhB7LPVkxThuiZNoj7uHJLcY7EHF+fVV1g3/VpLQNWKYc
         ApRA==
X-Gm-Message-State: AOJu0Yz6o515YMMEo6J2Ad5yrzBYM4JNdyUK8TXudU5+SbZCsx4MJqd7
	nv0DX+VY+R4m/Fn7cmFkY1JsOxcvcQZEgkCORjAb66pg30HcQDP9qmJNwUzAh/6AmB4gElLM5a2
	u82hG8ABuDzQ1RhoCPokfwAJ48mc=
X-Gm-Gg: ASbGncsZSk7KKkmESU5IekJ4/2SfZR/H9ni9sxLzNZ9KsHgEpi8FQCpk8LN9rXt0ABZ
	8eDUzcPxUPvALFPZSRmI0ffp7++cjPTRJP33W91rfLK1hd72lXr4=
X-Google-Smtp-Source: AGHT+IFoJaB3l27kDLMtO8IvsqvRfWCpR1sHABpM5y+Cnvz28KnuoExctysWSWmCq2W7z+LprtGfVIA86QW99rTvVZ0=
X-Received: by 2002:a05:6000:4112:b0:382:47d0:64be with SMTP id
 ffacd0b85a97d-386453dff87mr1617745f8f.29.1733794696113; Mon, 09 Dec 2024
 17:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206040307.568065-1-eddyz87@gmail.com> <20241206040307.568065-4-eddyz87@gmail.com>
 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
 <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
 <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com>
 <58dbb0671ad59507e45c3f5ff50da66b0f8bd36e.camel@gmail.com>
 <CAADnVQ+RNBq+nHO2J8m-eaZ_5K=dHk7BBOAwk399e+6qwoybUA@mail.gmail.com> <8f620e10edd75367fbb9e2cd47eb40872350eefb.camel@gmail.com>
In-Reply-To: <8f620e10edd75367fbb9e2cd47eb40872350eefb.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Dec 2024 17:38:04 -0800
Message-ID: <CAADnVQKGmBd_+s+2HjSu=hJD+bYVu+OuRRU=F00YR3wEUL84Vg@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global functions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 5:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-12-09 at 16:48 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > Also either inline global sub-prog traversal or the simple rule above
> > both suffer from the following issue:
> > in case prog_array is empty map->changes_pkt_data will be false.
> > It will be set to true only when the first
> > prog_fd_array_get_ptr()->bpf_prog_map_compatible()
> > will record changes_pkt_data from the first prog inserted in prog_array=
.
> >
> > So main prog reading skb->data after calling subprog that tail_calls
> > somewhere should assume that skb->data is invalidated.
>
> Yes, that's what I was planning to do.
>
> > That's pretty much your rule "every tail call changes packet data".
> >
> > I think we can go with this simplest approach as well.
> > The test you mentioned have to be adjusted. Not a big deal.
> >
> > Or we can do:
> > "if prog_array empty assume adjusts_pkt_data =3D=3D true,
> > otherwise adj_pkt_data | =3D for each map in used_maps {
> > map->owner.adj_pkt_data }"
> >
> > The fancy inline global subprog traversal would have to have the same
> > "simple" (or call it dumb) rule.
> > So at the end both inline or check_cfg are not accurate at all,
> > but check_cfg approach is so much simpler.
>
> I don't like the '|=3D map->owner.adj_pkt_data' thing, tbh.
> I think "any tail call changes packet data" is simpler to reason about.
> But then, the question is, how to modify the test?
> You suggested bpf_xdp_adjust_meta(xdp, 0) for 'xdp', and it is a good fit=
,
> as it does not do much.
> For 'skb' I don't see anything better than 'bpf_skb_pull_data(sk, 0)',
> it does skb_ensure_writable(), but everything else does more.

bpf_skb_change_proto(skb, skb->protocol, 0)
is a guaranteed success and as close to nop as possible.
Or the same with invalid flags or invalid proto.
bpf_skb_change_proto(skb, 0, 0)
Guaranteed -EINVAL.

> Dedicated kfunc would be cleaner, though.

Sorry I disagree.

