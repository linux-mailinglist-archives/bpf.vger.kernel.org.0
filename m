Return-Path: <bpf+bounces-54242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A3A660EC
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D823B1B7C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194D1FFC44;
	Mon, 17 Mar 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFMypfhq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B681E1E08
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248022; cv=none; b=j7bEAyvEHPSe4cz9f06myyCLsvfWON81vwkaykEMLY3pvKCwu34enLC5srp9fuavxDvlAraavx3Gf79uAh/lM6Be05nlxRIGFfmqR1f2VLztghm7IX9qmIf+eOpzlAUNhKLVC1ZaJ2P5+5DhgRTLhBje36sxkfJPPpVYnPWoEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248022; c=relaxed/simple;
	bh=gEpQKMfdGp0LZ29keggzYvL/E6EYZYixw/P6b2eYWKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5v5KeJ7LrOBKIfwKBbgVxP6ox4uGkUNz3kpXweSgN/jkZh564crwxrE6jMB1ITjuyMalfAgoH52g717ejInZaAl4/2Y9Bcsj+gp5HJgX9Hwx00XdV0eEcU0ZlmAcZMi7macy3xekN4FhyY3kqtMKHgBM9zMUBj3sr1aM42ZQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFMypfhq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2703286f8f.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742248018; x=1742852818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co9WR04AnR/fgO24BlOgTXR9OIiz/T2w9bN6++6N7n8=;
        b=bFMypfhqd86Ir/Tkz9ZoeUhCWUXkKXhP+o3lwCz/cWIkWN26Q6tvvTgxtNcZWr+fNm
         UsZoLRjU1mpmoPsgj8AAiq5VJcXZVy6gslUnti6Vni+9VIJO1xUuZWXJV+v38XC78lY8
         GJapmnZwrJt0J1rSQj0EHevKl2u4QGvvHEzoR0F/i47Rf1fBDeY46KBsKa1DFJNda3JG
         +/j3xsFC03EUH/A3x7mB2d0z4IjJSK4a15LUv1wEXkTyMLEVAXKoERiVa2oS3qp4E53u
         nOjbsWexdtGyfcwUoto4qPg5WgUWqm9Ucw5GuZAXTz+U5nrD9T7+J4K4l1HAqyrpAqhG
         G/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742248018; x=1742852818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=co9WR04AnR/fgO24BlOgTXR9OIiz/T2w9bN6++6N7n8=;
        b=FurJydsnbdz6yz9wcmB+ia0e57afMLnpkQvrXRryxD77bLGLP8XezGQ4MTn5jwFRun
         CNPMWIHpkbv6eF6O3+k/u0mCaOkDOChwylR8sTU+BHleChHO44+J2C2zrBz8D+ELLL54
         Zq1Rf1dM0peqwjC96Rhww27gtnMpTjdH6c26omCGEEb7g9mBBc5rbqqUPy5QleYKiym3
         STAiWBQ/JsWtbDrr0ay0Iy/04oziUAv8dM04oeAfcjKrMofTGU8liSow+QRYbmgWgjk4
         +Ql4xoKkLApaPu1IbuU9QsaU5/l+FSf6AXlCY4AfhGwc2/gbbblX/vtjUjrpmvNKNDeG
         CBww==
X-Gm-Message-State: AOJu0YwxBGtxeVVDZJA/psL8pQ3l42HqEWqUS6lp1qeRhiA+6wcDKQUf
	NwGmhS69RZj2qJyCSFILOAUA6zhvJhWe/eIck6juEbrQ2ef3ZRjmu3eF/wYkptW69F8bKPeOeuL
	V66v1QJUiAT9CePZuXkXjojocNQE=
X-Gm-Gg: ASbGncu9Ha63hD2Fv2NOhfmfXIWxH4xepyBbetOL1KsgnGO3sWrBJW20Y1YWaZ/IPRv
	cOGWGpIBwUFhz6cBUYjBrf58vzdJIn8ZTmfyfzZ5pVKnur8KYJbBYDm4iCgn7LbmKzF5NRQRPuH
	JVRIW8wwe2ZrCGWSJm5bnDBmu2um4W+vh16vqCAkF1gQ==
X-Google-Smtp-Source: AGHT+IGisgqHpGv6A1wquzy6sOHxpZNcJbdyWUlOlhXE47nDqIeMQ+sttAddqPfqmt+gUZ7fkR5GXid263yCU50d8Rs=
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id
 ffacd0b85a97d-3971e96b183mr11661525f8f.18.1742248018387; Mon, 17 Mar 2025
 14:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312031344.3735498-1-eddyz87@gmail.com> <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
 <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
 <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com> <1b1913448e28d0d6beef5c2f47a033aa44e2f336.camel@gmail.com>
In-Reply-To: <1b1913448e28d0d6beef5c2f47a033aa44e2f336.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Mar 2025 14:46:47 -0700
X-Gm-Features: AQ5f1JqUXMi1TiJyKwRwacg90v5SiTov0wedGfmripZlTmAo4L80cJkJbiaKqyc
Message-ID: <CAADnVQJabnCzo6=3uATv3nN2hz7Av=BAORVS=hgnyNHt+5dBCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-03-14 at 19:51 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > Looks like the whole concept of old-style liveness and precision
> > is broken with loops.
> > propagate_liveness() will take marks from old state,
> > but old is incomplete, so propagating them into cur doesn't
> > make cur complete either.
> >
> > > Another possibility is to forgo loop entries altogether and upon
> > > states_equal(cached, cur, RANGE_WITHIN) mark all registers in the
> > > `cached` state as read and precise, propagating this info in `cur`.
> > > I'll try this as well.
> >
> > Have a gut feel that it won't work.
> > Currently we have loop_entry->branches is a flag of "completeness".
> > which doesn't work for loops,
> > so maybe we need a bool flag for looping states and instead of:
> > force_exact =3D loop_entry && complete
> > use
> > force_exact =3D loop_entry || incomplete
> >
> > looping state will have "incomplete" flag cleared only when branches =
=3D=3D 0 ?
> > or maybe never.
> >
> > The further we get into this the more I think we need to get rid of
> > existing liveness, precision, and everything path sensitive and
> > convert it all to data flow analysis.
>
> In [1] I tried conservatively marking cached state registers as both
> read and precise when states_equal(cached, cur, RANGE_WITHIN) =3D=3D true=
.
> It works for the example at hand, but indeed falls apart because it
> interferes with widening logic.

hindsight 20/20 :)

> So, anything like below can't be
> verified anymore (what was I thinking?):
>
>     SEC("raw_tp")
>     __success
>     int iter_nested_deeply_iters(const void *ctx)
>     {
>         int sum =3D 0;
>
>         MY_PID_GUARD();
>
>         bpf_repeat(10) {
>                 ...
>                 sum +=3D 1;
>                 ...
>         }
>
>         return sum;
>     }
>
> Looks like there are only two options left:
> a. propagate read/precision marks in state graph until fixed point is
>    reached;
> b. switch to CFG based DFA analysis (will need slot/register type
>    propagation to identify which scalars can be precise).
>
> (a) is more in line with what we do currently and probably less code.
> But I expect that it would be harder to think about in case if
> something goes wrong (e.g. we don't print/draw states graph at the
> moment, I have a debug patch for this that I just cherry-pick).

if (a) is not a ton of code it's worth giving it a shot,
but while(!converged) propagate_precision()
will look scary.
We definitely need to do (b) at the end.

