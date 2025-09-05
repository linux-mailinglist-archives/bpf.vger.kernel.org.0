Return-Path: <bpf+bounces-67578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E400B45E42
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F011C237B2
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D627306B3E;
	Fri,  5 Sep 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Rq4lP9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DF306B32
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090107; cv=none; b=vBzjgxcYGMuCEWCUFJmnLdK2qqZfVe/yFZwSG+xJGgu3U9gJHH9PVLtNtRhm6xwITNBMhOrvuMwrR0/5V0qLq0Hg/ztDDm4X1O5wJjvUd0h70syeY6Kgqx7EnZhTwJ8erW34zwgEBshTX4k1RZe+hq1BcjpCHqQEsMgyrFxTizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090107; c=relaxed/simple;
	bh=MwWu93i0P1q+IaKSg4DeuJ0+YvzQ/MbC80Tz/UpuXk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THVXC7oJCuk91AfTaTvjzFduwRW2XgZdVA62Y56XbELcCu8nYQ3tsY0VibovdZabFr9XAnJia9hzPsSjTuKShgM8LOjqUZuCWJ/Fx9lh5jFLOtk85zI4Ks0hBqFhG9QwAh4FYeP23jLcI5WVOtDuaX/E6FZHsU8/Dv1RmixXmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6Rq4lP9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60157747so22553837b3.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090105; x=1757694905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcGBnjP40ZKjYIRtc8b4iej7hCs3vRB58DfPDtngo1w=;
        b=I6Rq4lP9rZZw/n325TFv0AhdRXPZzJfMLQG2NG5RZXuejVOCYgMTZU36/gSO1eo4Eu
         I8dpWqbvMJ4kqUXJ2lltJ2Xoknth03cPtr2XxI+tsf2kkL4583flUc1yJNOTgkLLJiZo
         TmZCL8dNm4ZJdb/i0ILUqpKb5eWi4OxbNnb2nSjRaC3xC25vsV3nTDpcRfb3RH2PNNyc
         7KNugirro1h94cEWyisULe6q8JdQu5PDSG1IVwUW0ggbCDu8W5FX0SbWgrs/aTjGhoSh
         zJ7cCdRvvx0hKAvJMTM/6O9wwtI3hjdafWOTLQxU8jpCnOAE7fNpUeYnA9eXEIadmI9i
         Qmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090105; x=1757694905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcGBnjP40ZKjYIRtc8b4iej7hCs3vRB58DfPDtngo1w=;
        b=uO5K8H/3Q7sZVgevT161pkp54rYnX5rKT26CDXO1pUrcMur6DIip2TD45cn7Nl6KfV
         7X9QYStenjxTG/2/yzwQSDp2553MSULsMu9f4Bwefu3uv0tvmhyiQREa6CZWGMockLqH
         U58bsKuciOrw8VpLS2ymmUJRpHu2LtAcP8VW/DnOpPY7bREYZr44brLjI3J2NTgoIWpl
         xNw5nXKKAr2CUBCvOBH8GehIrV3xwasJ07VWqr6OJkdD4Jhpg51EzWns4HUNssLb5eLn
         KCL+n5Rocfgyz1v9P3yfHuKLg40HRZnYQK2C/2Fn18pY6NXG8P6goczuTaE01hH9KTeu
         64dw==
X-Forwarded-Encrypted: i=1; AJvYcCW1MJHcLRG/y1QMFZbwUdPHNIB1WkRoSzhA5UxQl4xNTJedBfvNX7OforNTl7wVpjDjM+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoWewTS3QbwfsQzYkN1P3zx72nrsKOp0k/Q7qrXim1+aFgHWO
	fsbLOfZxpoKJwj+CnwAmCcJEj/XaT3KRi4i9ToX86g5LuBz+HP8emxWjYu8HUsx4WynOiS1AWkS
	51RMcju+IF1eLAs9IhyotgMVRtoypKkkGtg==
X-Gm-Gg: ASbGncvb/aasLEtx/hp8v+LZidFryPyZXrfiFqQya0t7ODtr0GY9Dgvmu8bNtxBdDVZ
	9TOdTQRKnFDtia/FVWHhPrq+dyAUTZQfAZ+P0s7PHAow2lb0nFr2kB1xbm5zs6nHVNj8dpDa2Xr
	o2manUWuCnkkhjlIeqWlcRov7z8sfly2zL8rt1Es2PiRgsvY8jUZm8DuMLWhcYCRXIHevNdSoS2
	Q/1hlkEUb6j3hjL5Q==
X-Google-Smtp-Source: AGHT+IGrB3n1eosfdkLinI3t/jBXSZUGU7ejy65/9FOii9l/ere5s/qtkSInloQfve/mKRjAkme5RXOHMX7nXEaiFmk=
X-Received: by 2002:a05:690c:9a87:b0:723:b572:c895 with SMTP id
 00721157ae682-723b572c9f4mr136205267b3.42.1757090105135; Fri, 05 Sep 2025
 09:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756983951.git.paul.chaignon@gmail.com> <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net> <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
 <aLrkb-6ZFMLfMd-o@mail.gmail.com>
In-Reply-To: <aLrkb-6ZFMLfMd-o@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Sep 2025 09:34:54 -0700
X-Gm-Features: Ac12FXzvz1JHB5GzVUYQHdS3VuimbGkp-oKt9YBOUmgsv5kJK3gdwMcaknRtJiE
Message-ID: <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:24=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> On Thu, Sep 04, 2025 at 09:27:58AM -0700, Amery Hung wrote:
> >
> >
> > On 9/4/25 9:02 AM, Daniel Borkmann wrote:
> > > On 9/4/25 5:56 PM, Alexei Starovoitov wrote:
> > > > On Thu, Sep 4, 2025 at 5:11=E2=80=AFAM Paul Chaignon
> > > > <paul.chaignon@gmail.com> wrote:
> > > > >
> > > > > This patch adds support for crafting non-linear skbs in BPF test =
runs
> > > > > for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When t=
his
> > > > > flag is set, only the L2 header is pulled in the linear area.
> > > >
> > > > ...
> > > >
> > > > > +               /* eth_type_trans expects the Ethernet header in
> > > > > the linear area. */
> > > > > +               __pskb_pull_tail(skb, ETH_HLEN);
> > > >
> > > > Looks useful, but only L2 ? Is it realistic ?
> > > > I don't recall any driver that would do L2 only.
> > > > Is L2 only enough to cover all corner cases in your progs ?
> > > > Should the linear size be a configurable parameter for prog_run() ?
>
> I think it's enough for Cilium. It's a bit of a worst case for us AFAIU.
> In any case, I'm definitely not against making it configurable.
>
> > >
> > > Yeah perhaps we could make this configurable. The ETH_HLEN is a commo=
n
> > > case
> > > we've seen and also what virtual drivers pull in at min, but with NIC=
s
> > > doing
> > > header/data split its probably better to let the user define this as =
part
> > > of the testing. Then we're more flexible.
> > >
> >
> > How about letting users specify the linear size through ctx->data_end? =
I am
> > working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part o=
f is
> > to support non-linear xdp_buff in test_run_xdp, and I am doing it throu=
gh
> > ctx->data_end. Is it something reasonable for test_run_skb?
>
> Oh, nice! That was next on my list :)
>
> Why use data_end though? I guess it'd work for skb, but can't we just
> add a new field to the anonymous struct for BPF_PROG_TEST_RUN?
>

I choose to use ctx_in because it doesn't change the interface and
feels natural. kattr->test.ctx_in is already copied from users and
shows users' expectation about the input ctx. I think we should honor
that (as long as the value makes sense). WDYT?

Thanks for working on this. It would be great if there is some
consistency between test_run_skb and test_run_xdp.

> >
> > > Cheers,
> > > Daniel
> >

