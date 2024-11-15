Return-Path: <bpf+bounces-44897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CE9C96E9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE40283ED4
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257B524C;
	Fri, 15 Nov 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1pMcVOO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D21FC8
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629889; cv=none; b=Tn5+rx87cz4fjUr2fDaI5Nj5YCeTqZJqBKZwNWNFkwlBO9DMqRCtlcAJh7P+uB78Ojde7PamLVOkSV1l7Gqus505cnHBBQCsSJ3v/T8Zo3V2+yYm9lJdWO/Yojy24S6/A3Ya4JEKTYqZWrukVycMVWcltS5Vf4IaBQ7YPN0+lH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629889; c=relaxed/simple;
	bh=L4pfbhIqD3SPsPl32iwX9+XSdZPK6DQfkYsdQ5LfgAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNjCTAPSiy+4R5JhyCXb6E0e2Ak+WtCg0mPm5xKVnJdibzLfYjEHpvlQoQa8XxSwWCfNF7n3lkevHu47h2Xly1W/p5UIAtDFx8olPSV2BxgmkqYdPDmR15FDOMpBlk/YXHK4AtvpQuc0cA1d5y9liRLzG0WbO9mQCFxYp0nY/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1pMcVOO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71ec997ad06so941157b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731629887; x=1732234687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsEwpVok/zQrhr4Uak3VUPbA6Ph3JsYsG5cJRWzLRnE=;
        b=j1pMcVOO3jJ+MqmNr6O+VoGULJdiZ5pIeb2isRMLsl+iRdsfyebQBEfXOyZAqgu1zf
         E809WFz0iYqOvWxD8P3lp1c2WYdEIRVVqtNTlIynC1132RZdqce+fOe7uzcWoWPZHkqz
         ZWqjoo40EUVEj3I0Pzn0+r37Z3hi74vBc+PEMflrPdlQRU/G6R/p9FldpkGi3+9iy72E
         q40BYRVGxvN02AFBBAQqIe3lPx/7cNVQxx4YdUn6WXzVYx1cOFE2z1XkKYcWHvvT2jEJ
         xrOZHlVacYDXqBUVCHp6/hRk7crm8LOfh3JX2kpaExQPUWH1/k9AyUtbB6pokYrKj7Ph
         HKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731629887; x=1732234687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsEwpVok/zQrhr4Uak3VUPbA6Ph3JsYsG5cJRWzLRnE=;
        b=anU5zdpgF/Ln0FODB3PK/10Jat6WTk0xhlPYiHkglrhTq7Bl6gtXI/qcfF8Tso/fbX
         RCQalkItywTroIRZWl2qjXJIhh5u2pvlSojKVw4AJ5q3k22imvNzSewhRcVnrOhLRr1t
         7iq1+L5bwSMajzNwi7ejDljxXn+0V2uXC2nujdy9EbWJx9USCb2yC8qPwCl1YQkojXuA
         rky2ojo/xGqaWQIz6SwJ6XkJG/ro8GRy+98tDgUi1U70+c4YSzaiO9fTAqSW3tZusBp/
         D+wbb4IskAd9F8L7weR8PbLfqYWePwCeYrlzyRY1Z5ajHEw649cDD+a4D6p3XtpObt9S
         Jq/Q==
X-Gm-Message-State: AOJu0Ywqs8w0k9wtdOyubp6Nt0iIpj6Fg/voc+MVru7ltncDwZowoYLT
	dfcSGtkmoYuJVA5rMT9kmgWqxESq1Y4BYDa+VfDI9/ksTJmBvJSwEHGqnVApiChygjNjXmM1Km6
	Ej7ydsFgraYVZGFJ0tknVnxPq3US2Lw==
X-Google-Smtp-Source: AGHT+IHrdxPRD3+gtQ5L7rNaHrSu0FvJwjYS5SpGzBG5kuNtNmNx2UOSdSxfr+vmwQ7NWyK15HDSywH6tiecPj1/hws=
X-Received: by 2002:a17:90b:1b4b:b0:2e8:f58e:27bb with SMTP id
 98e67ed59e1d1-2ea154dad9cmr1192543a91.8.1731629887313; Thu, 14 Nov 2024
 16:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
In-Reply-To: <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 16:17:55 -0800
Message-ID: <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-11-07 at 09:50 -0800, Eduard Zingerman wrote:
> > Consider dead code elimination problem for program like below:
> >
> >     main:
> >       1: r1 =3D 42
> >       2: call <subprogram>;
> >       3: exit
> >
> >     subprogram:
> >       4: r0 =3D 1
> >       5: if r1 !=3D 42 goto +1
> >       6: r0 =3D 2
> >       7: exit;
> >
> > Here verifier would visit every instruction and thus
> > bpf_insn_aux_data->seen flag would be set for both true (7)
> > and falltrhough (6) branches of conditional (5).
> > Hence opt_hard_wire_dead_code_branches() will not replace
> > conditional (5) with unconditional jump.
>
> [...]
>
> Had an off-list discussion with Alexei yesterday,
> here are some answers to questions raised:
> - The patches #1,2 with opt_hard_wire_dead_code_branches() changes are
>   not necessary for dynptr_slice kfunc inlining / branch removal.
>   I will drop these patches and adjust test cases.
> - Did some measurements for dynptr_slice call using simple benchmark
>   from patch #11:
>   - baseline:
>     76.167 =C2=B1 0.030M/s million calls per second;
>   - with call inlining, but without branch pruning (only patch #3):
>     101.198 =C2=B1 0.101M/s million calls per second;
>   - with call inlining and with branch pruning (full patch-set):
>     116.935 =C2=B1 0.142M/s million calls per second.
>

This true/false logic seems generally useful not just for this use
case, is there anything wrong with landing it? Seems pretty
straightforward. I'd split it from the kfunc inlining and land
independently.

