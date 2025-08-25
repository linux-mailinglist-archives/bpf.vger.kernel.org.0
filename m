Return-Path: <bpf+bounces-66459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D1B34D9B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AC61B25DAA
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DA299AA9;
	Mon, 25 Aug 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMWsAYs7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DB1632C8
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156074; cv=none; b=CuEUHF5u9lFujhVE/otuSli2+h5BdYNE7kL3iNlH62guxDxnR2dbgJZ+G55c38CzWuix87dCANxrhnQZuKf8QDEiYl6FEFJGq6zflt9kCOK7+3gQAHmbGBk1mVvd1Ur7DJuV/npKBgYSUbUYXWNmSJgYE5udeZQHx2CJD/3hQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156074; c=relaxed/simple;
	bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv9smeXqyjWhjWYaEzxxgF4MXd4o+SqQvH9mEk93VflQAreQFkKLumyw9cyv/mgxW3BxkV6MAkhC8F8a59g7R5F3WpqOD9pcKrgvm+4DBPTcaJ+GRmhbm7yu4Fsy/kt6P/d7Mwkuecn9UzozA444nWfIl4/Pi7a6l7RGmtWQ4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMWsAYs7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2461864f7f8so39569475ad.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156072; x=1756760872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
        b=BMWsAYs7JLJw+2eVfaxp1YRFEQb2JUWOmhzQhuMbM/wS6rTkF4QM6Vb1djkCpeLSD/
         E1aq7w47bDstEuTGP3YEGkuIfIoJXwZJ2tJlU57MZaR83wX797SCCvNRbepXohmCbbYJ
         LfJY6I37vlTSDbtJVyPFPcqNe1+uHREyg1tzeJhefOInOH0M5jdbJnwUloky77D6mrB9
         TXyUERKbXvOzo6cQFhOZ/WsWuGVBhwyEQE++bZwMKcEyTYrikSetPIniLD4KxdWr7gjB
         48hwmqfy1oQS+tnC9/YkEu3X6BHZsOlNjOPeYVPbrTJ/GA5bF3Ll2l8cnJF/1MMYdfj9
         kXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156072; x=1756760872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsgQsADbJK9QUmMKxUDa/Fk0IhymXtnj4qX8ecK2uC8=;
        b=hykuC/oI4KqIWIq3dNgkBzrXVo3JCRDuTrpfmpsvYCuuZBZx5UPMAWGg6NlwboBW7r
         UTRtOQrEsK0mdliJMZCDA18hzFPeBfLTE6N5Nm/j3NXlrwfNVM7ABlwywNUNs3nx/5ak
         2wcs2M+fKmxUJ98iOEzUgYlEcC7gxbvWWzEuBc0XwT5lDhz501FwF9nYrPDEJZIPDQXY
         fzXH6yuFGjt/mlxGAvpVRe9nOzC6vozR4/kXqLC9FInlINb2J3DE3uCtpK+RmtXuHx0D
         X5ao1sfYFByMrY36ITY3+XChGejsaiz6vNjCTC9Ate4P/CHfK66YJyyZhgFZoiDfQgff
         4/eA==
X-Forwarded-Encrypted: i=1; AJvYcCU32lv5SbLQtQMc5oLw70s1dE59M/uHErP806i83mvE2kzdEvXtNtWN3ZppI2EHvKxkYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKDLMmkq+XvkLlrdVdJPI9Z7LikhAZjohEDS1e0FxQcdzIW/9
	0evnfnqspqLFEDh4rpI8jB91A0MWJ3mhxYyvXstfZBUNkrEM6scY7vN62SGPLgw15QpInZyYJS4
	JmSqIg8QkHuZQlzSaWdAdRNiQOAlbrQcQBgtI9bWU
X-Gm-Gg: ASbGncuRKeCp62K3o1NWMO2P1Uohs5rihKtnQ3uLkfAueWuiud+PgrJvRnIZWBW/ZHG
	LGl7Ax4o7e5i9nZuqZspHG1HGaqTtPZVMXWSz4j1+JksfXOFqyXD6gtaoJk8wV610GuQJdJPxki
	GkVJYuPcnkAVGdw7d2AyC4ahZMg7x9uZtUnG63fAZyETU6hC+afRd6t+M5YV4X5Fju45pG2KSR0
	0QRci2hgH/TuGxSA75MxMoZ7LYHhvFRVLu3SKpSx3CAgEDu46XMy4oqXwJhPJfN1pD/FZ9jsLiw
	dCgOJ8g0iA==
X-Google-Smtp-Source: AGHT+IFG5RTfX6ud7JlnRAPMerHJf0Gbw2YzpqBK05FqAlo9zIJQqUl848H3iGoxvhe6mgAQlaJdiUZU7L2rrRtCD00=
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id
 d9443c01a7336-246b3513841mr70712685ad.48.1756156072000; Mon, 25 Aug 2025
 14:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com> <20250825204158.2414402-3-kuniyu@google.com>
 <aKzMxKViOGjxFhiW@mini-arch>
In-Reply-To: <aKzMxKViOGjxFhiW@mini-arch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 14:07:39 -0700
X-Gm-Features: Ac12FXw0Dtr1s8EQjHWjs5pMcjrpJOHq1fQzaS4zTIwkTNJhoX312mfmLMXMCzs
Message-ID: <CAAVpQUBzWzVgvohLKOTS0U4ay9D29otB619T6O786m9W0YSWtg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:51=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/25, Kuniyuki Iwashima wrote:
> > We will store a flag in sk->sk_memcg by bpf_setsockopt().
> >
> > For a new child socket, memcg is not allocated until accept(),
> > and the child's sk_memcg is not always the parent's one.
> >
> > For details, see commit e876ecc67db8 ("cgroup: memcg: net: do not
> > associate sock with unrelated cgroup") and commit d752a4986532
> > ("net: memcg: late association of sock to memcg").
> >
> > Let's add a new hook for BPF_PROG_TYPE_CGROUP_SOCK in
> > __inet_accept().
> >
> > This hook does not fail by not supporting bpf_set_retval().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> And similarly to [0], doing it in sock_ops's BPF_SOCK_OPS_PASSIVE_ESTABLI=
SHED_CB
> is not an option because you want to run in the process context instead
> of softirq?

Yes, I considered the hook but ended up adding a new one
in accept(), only when we know sk_memcg is the intended one.


>
> 0: https://lore.kernel.org/netdev/daa73a77-3366-45b4-a770-fde87d4f50d8@li=
nux.dev/

