Return-Path: <bpf+bounces-22748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39853868503
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D61281E2D
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA5139E;
	Tue, 27 Feb 2024 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy/51QBe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE037E
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994076; cv=none; b=ilFztLZ6sCXgHcHGdJnYL5WAbz/114QGdWx0HcRj6izDjlz3Pr6VexIa4oiNHrrXJa2y84RRjRtOIAQukFaeO35s5nUvppQZXSsBecC+3tBXwbEgPJzwCMk4UkQNQ2M++VB6CcXMnezrwd9HOJMf8hqHT7MfLEBf8n5whfsmOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994076; c=relaxed/simple;
	bh=EuojHvTDKSjdHkXEJM7Zl1Q+dQ6f3/JjVZ936St8XZE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SeBF+6mI7HvM7tslISKttl1q/oPRA15ro6qZu1h8sQi+Vd0m0sz7uqdTNsoq/jLFN1a1u9sjIUFj6swZ1JnR5M5vmhGOqyKStddzSlXLhu58JQnMxQ2rLq88yWCzT6FaK+rwlJVEoyb2w2LMwIXH5nlA6k6lVPL8M1TsDX+6Eg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy/51QBe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2907714a12.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708994074; x=1709598874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Ms1lmOyzW3YQYRqz1O4YEbS8qfJ+rYCUvZCfwKmoo=;
        b=Sy/51QBeE/miR42kffSult6wW+I6y6rxmkJW+5sh4sMbpYzXcbUa/BLjXmRbkP/aDM
         DoAh6HJCGWS/B1CdIOIfkXzO8MkM3Fzmi5pxMd4nNIxjV1mZi+XtbQ+Afra+IBMUYIlo
         1bi0jzVY0ty8giHIy6QxtyYeqW86MnT5O1vArRu6CYu9Qs7y2cURb7OHBlq4uP40+YeH
         OpjqFXGcVl2LJzpXqckcEtT+w2PaE0/ICJX+4cN6gt1mPeKt3B8aC/B2CJ1Y2GzR6xIy
         kP6634kvElHzZo4rHBVkGb7iIwApG6JpkHMcLICXDtTJrdZuyQVI8aqS+Iy2gxT/JHqK
         znIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994074; x=1709598874;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+Ms1lmOyzW3YQYRqz1O4YEbS8qfJ+rYCUvZCfwKmoo=;
        b=NgORK458c2YaZhzqpQh2jVOrjvQhPAuToFhJg8oo+BgqL2V6CG5wKemIIqWS6ts0A9
         8LT7z0QQNMxAVe8Rnkf7pctl8ZU6lA1ci+gkvVSk7XyPvsdoX+Y9S+flgMrGuMtYE6eQ
         vaQsB7uSb2yI05eF9twVT1sBoRiEWjwv12fGFrWkiMk886NOBe0yfFpx6Mb7+j68F2q4
         Jk4j8HFqI8a4qgwtwXy9q+ZmQiShD3pcu9mJIbasm26PQIP4feQhwMRtcvhATQASpKKv
         /T1ILJlhaXIF1SH4EPKwH/s0SANU6LvaOEmOedQonIrouAxiAVXLiAS8hpXp3Q7IreI6
         0W/A==
X-Forwarded-Encrypted: i=1; AJvYcCWE6TABjJuqLY+U6iLQgn4KBKOea65gT1nbY46R9+3mpOdDKW6w2/fNppXs1bh0Tfub04FZHtYhNifDFjS/UtQzuGB9
X-Gm-Message-State: AOJu0YwQdt++Yg1kvLUicy3pzSzIpJH6MneFiBdVnaskA6oS6IHhNWRM
	HkaXOF55CkyoH6ER12HNdmdoLjV0s25kBQpzXxRLAb81f0+q1g7L
X-Google-Smtp-Source: AGHT+IFJlDKEmqw7lyHOk9FhSzxAlqd3g+7/a9SPKr/J4n49D0Ds/4Hv2Yrph8zVZ9Qikw/0KfpiAA==
X-Received: by 2002:a17:90a:d597:b0:29a:b4c5:eba7 with SMTP id v23-20020a17090ad59700b0029ab4c5eba7mr6704979pju.0.1708994074056;
        Mon, 26 Feb 2024 16:34:34 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id gq15-20020a17090b104f00b0029ab73a80a2sm3326380pjb.22.2024.02.26.16.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:34:33 -0800 (PST)
Date: Mon, 26 Feb 2024 16:34:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eddy Z <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 bpf <bpf@vger.kernel.org>
Message-ID: <65dd2e181f8a1_24aa9208c8@john.notmuch>
In-Reply-To: <CAADnVQKtL0mo2pqcKtOJ+nzG0K72dhH47KZP_-O06U6pfvzb1w@mail.gmail.com>
References: <20240218114818.13585-1-laoar.shao@gmail.com>
 <20240218114818.13585-2-laoar.shao@gmail.com>
 <65dd1d0d6e41b_20e0a208a9@john.notmuch>
 <CAADnVQKtL0mo2pqcKtOJ+nzG0K72dhH47KZP_-O06U6pfvzb1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bits iterator
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov wrote:
> On Mon, Feb 26, 2024 at 3:21=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> > > +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> > > +{
> > > +     struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > +     const unsigned long *bits =3D kit->bits;
> > > +     int bit;
> > > +
> > > +     if (!bits)
> > > +             return NULL;
> > > +
> > > +     bit =3D find_next_bit(bits, kit->nr_bits, kit->bit + 1);
> >
> > Seems like this should be ok over unsafe memory as long as find_next_=
bit
> > is bounded?
> =

> Are you proposing to add find_next_bit() as a kfunc instead?

I was suggesting you could likely implement find_next_bit() in
BPF directly no need for a kfunc.

> =

> With the bpf_can_loop() proposal these two can be combined and
> it will probably achieve the same result.
> But imo this iterator is small enough to get in now and
> delete later when there is a better way.

Agree its fine to go in as is IMO. Mostly just curious if anyone
tried to implement it in BPF.

> Ideally we'd need to add new instructions to operate with bits efficien=
tly.

+1.=

