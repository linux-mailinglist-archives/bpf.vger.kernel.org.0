Return-Path: <bpf+bounces-35312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3D9397B3
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF54B215C8
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839A13211A;
	Tue, 23 Jul 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LblJPpos"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53B14286;
	Tue, 23 Jul 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696451; cv=none; b=MYf1x6iUHF2w09Ykq3XB/qWXKaueNyELQbFCUuY94wYkTBb6r6eCc+RLMzNOMDEsh9nxEZ9ucnpotPY6S+dcAiTgEyIPHAh731fo1cC6Az4EfUmDHtHc8EoVCprX+GXarPgqCcTFibcWdcLwbqFOE4CflrQ850m+sTHkp6LVt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696451; c=relaxed/simple;
	bh=rg/7g2s0Q+rNkmoXv1fLCO87rlKGP+zUItcspUh+LI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAfXf3GDTQshHQBw247J1pRrk6C5k3MO6UOvjzXkdtRvm1sO0aaphfhZBd26J6oKG+eBqRfb8Ekx52qLdInCuce/wVGBRBc9MKLJusFeUjqO8Rf9PK2rAYAdByFymY/Pep0z3ckRJSPeenXRrOWqcpYexZ4f/Zk90U1iYTJoibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LblJPpos; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-52f025bc147so2597008e87.3;
        Mon, 22 Jul 2024 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721696448; x=1722301248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj8LWvLr3PPgz8s6YwkxY2zqcjldqQSWUf/wycNsrRY=;
        b=LblJPpos1tKf8s8vekpbpOZqSdXNJq0puXOxARFS7nlVed3qyCDjNv8DucbE9h0AIM
         +wlgXSu8br1zb2h7o2xDfX1IsJ+RN4hTXFUtw4Nx6LqDizKt+Q/hJok6TvHfNLabx+xU
         QDYFyau329F1JHfM7NowL4dVwNVVTkQihMsL69oc8r7nA3f6+6wgJ9k5PHGBMr7UHljg
         xvSTNSmRW6QrJHxrx6l8IxXIww4oRGAttwS5seXzxvzjUK6OHEfmzCRvrIwmOPEOQ9Pu
         nud6G7msEkEW7DbVKyvgV6/qjX0TmoJyWkijPTdHeBrBqWwVM7EDP2Ap4hEHPa1fAdyy
         Ktxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721696448; x=1722301248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj8LWvLr3PPgz8s6YwkxY2zqcjldqQSWUf/wycNsrRY=;
        b=dtuwocwScVJXP2CrBS/oNniXe17C4IAowwqitXH3Fe0IuRipSdDSWuUKPPghHB4FHa
         RTlhicN21NT+8j9JpEaFCcenUDMsKNEHxObbmCOJSzjfjGdAfxEQYbNRyxu/VD8XPQy/
         +v8VvgngWKnt7sXxk5IXaBPOZtvlOPoG/sALO403AxZCW6wthd3AbuX0Qzej1sDR9LCE
         zlXT9Uq4Ie77LgT519QwS50f7gLzwaU4P7WF9Qhfgh2ahCwSS2UVilq8GPNg4ZTl7/zz
         CQANE4OPRbqEcB6JGVhpd0YAChH+Z+zQevi6+jyjZ9/K3uF/uGlwA8s796/baFTmTQR+
         9skw==
X-Forwarded-Encrypted: i=1; AJvYcCWflKcscppGFzmb7ujRgds/2hpaqmUau2DlXV0VeBptx1KhbsYlLxoDF13NUL+0HgMYZGGD877gU2CPQfUz2LGed7T3O3JvQKDZBPkCgC9fz0UhfPN2Qr0CBPZ0Lt4clYr1nJu920dOmrFg3Dy3LAF5rQquza0YHNdL
X-Gm-Message-State: AOJu0YxKtibkbssbtXcs3Quxt4+IYR2ldMByjU3l0Y2Yu+MtA/bBU9UZ
	2oxHqsW3hIAGO8QUgoljYTo3GtEnmN0HWS41iW2VHj4QwSO1s13Bm0nq0eS1UGc7a2JQy0g+oRQ
	qChz/dn907N5xTv8xc08597VTOLl2DMbpowk=
X-Google-Smtp-Source: AGHT+IFwq14pR29OpleBn7axa0B+ul177eIiIZ6WEmnGRmbdOXLuW4qrtm4dBMXQJX/WvevIm5oQWDmtlm0RnJhHeXc=
X-Received: by 2002:a05:6512:3b82:b0:52e:be49:9d32 with SMTP id
 2adb3069b0e04-52efb7d6ba0mr5484381e87.47.1721696447471; Mon, 22 Jul 2024
 18:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
 <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com> <CAADnVQLsqV2q3Ury+p3_6n4eph+TWAVRFSVWst803k6XV_qf6g@mail.gmail.com>
In-Reply-To: <CAADnVQLsqV2q3Ury+p3_6n4eph+TWAVRFSVWst803k6XV_qf6g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Jul 2024 03:00:10 +0200
Message-ID: <CAP01T74N6091SZJ4Osht8NBNksOdx-D3mbtNRjWAt6w4uJ4y2Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrei Vagin <avagin@gmail.com>, snorcht@gmail.com, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 02:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 22, 2024 at 5:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > >
> > >   > Currently we cannot pass the pointer returned by the iterator nex=
t
> > >   > method as argument to the KF_TRUSTED_ARGS kfuncs, because the poi=
nter
> > >   > returned by the iterator next method is not "valid".
> >
> > I've replied to this particular patch to explain what exact unsafety
> > it might introduce.
>
> What do you mean?
> I think we can make the return value from iter_next() trusted in
> certain cases.
> For example bpf_iter_task_next() returns task_struct and it
> can be safely marked as MEM_RCU, since the whole iterator is
> KF_RCU_PROTECTED.

Yes, iter_next is ok (see reply here:
https://lore.kernel.org/bpf/CAP01T74pq7pozpMi_LJUA8wehjpATMR3oM4vj7HHxohBPb=
0LbA@mail.gmail.com/).
But number 1 doesn't seem ok. Number 2 should now be possible if I'm
not mistaken.

