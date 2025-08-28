Return-Path: <bpf+bounces-66754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18409B38FB3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C1E1B23892
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8791519B4;
	Thu, 28 Aug 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMzBXb7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD114C97
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340385; cv=none; b=Sx9YmiI3aWh2cUc6JYOUZEWSr+dMS/86yRLG/UCTga3vtaFFAukG5lNCPgv8kWev8REteDaKdzLxr80NLWaCpsN6WjHBbMcs2QiqWLloJ0kykRZbKEaPpws/kms7j72u3j9uFAQscaA0pAQHaK0lhRpKGxfBBLWXG+Ontjs2Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340385; c=relaxed/simple;
	bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prqt4tev2ff5PllRWKAEjQ8+m7Q0XclAmWCir5h2Gvm3jXnzLHZzTq29AQ/NfMEXA30Vi675Mhyao4ElRYwjNvzMlrhywO1h9eK9hDfVZA5bstJssYPFBSM+FoBXvYXRmPg5aWCTtWGQ8Q2DWJBlzSIldLqOgf7Hdcx/fBf6y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMzBXb7R; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-248cb0b37dfso3564525ad.3
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340384; x=1756945184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
        b=pMzBXb7RUvTx3WrajDjQ3DjUVUvFVZki/N83dhH2CKhwhD8MngObtNd0qhP3dXCCwy
         8ta/wFq/WjcFEAt73w0gD/RKNW8jX5l9fNMe+ppqY9YvYVdr0bMcS4pczU7lTUH+ah2v
         2n4ex6VJaAPFQgySMtULRkx40kdOnl3FDh3ZODUZluDkGQLbH7uUD8poiWknW2Y90P/1
         06JGn1AP3kYZK/WCuhWO7TJrUiGzXLTr9dQCjx5D9kozlT9LG7iln986fkPryL9sHRJo
         p08IEDpZ+b43M94PdujPqNHlfn4dB2fQrHFBDwGx2BhsHaj2EWNA4stv0NQP8XtstWuS
         q0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340384; x=1756945184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
        b=D+ThTgtLV3cQJq31XAbf/VsxNTZ6BS5lXviDIb+2sIH2NadRDV6ZAfAAPnmtJVIK15
         cMQwxHKKPlmind2dkQ+f1dTwDXaIueheZBItDW9wFyRyCvrIFCP6CjdKMBhR2b/4Bdp0
         lq8+IEeFkmDbzio1c5V0mNuxqHlGxKik8KiRhnBzLW59hD4wR6VR+NtlzlPwLSpEvjWT
         fb/KPdA3ceJphn8EalleLSZ/94GORvZBpIygS2/Qdd3/ZJt6HPlzHIyL27xEU7O8vQKq
         ak426NUEvDLv7AT5OTxRDkqGzcH41iGeto7K+wpDQonCMGiJw3tAQ0THPL1sS0BljcRs
         ItYg==
X-Forwarded-Encrypted: i=1; AJvYcCVzOxaChYrsA0L/xOycSM11FQNoatODRdWTMNUWLxGC7Z4s4c8cAdeb4uMj9RUjlmnaErk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBc7aVP4CyE9Mo6gPQWyjnJhSAEEIcktoqThdSw2R4n8b6cgg
	ldWHfT3aMvHh52rbjgKCP4rvXi8Jhp7/4U/ArxuRpm0eCfoFf45pRv0nhWymLkPYNNoE52GqAx7
	2tC/yZz3ZN2IlkZz4Aae3IVWJmqEwCzPMlafp3wg6
X-Gm-Gg: ASbGncvnzeKiPYCHUx01LdhaDJl7qlH0HOrvj/w1IoVVpyJhRIQzu3tcyg0xjiMAiO4
	8sNA9vepG54gD+jjD9WEXIJMVpMhaERi1t9dWAu5Be8tgK2QQBoxIBxEr0j+fpjSbuTQg7aR0Lr
	5qYAB7LS+Fs6FOQh70lANg/k4t0URQU5yVOMBJnqCZuqHKgb7Qa6qTenWxHrAc1XwKRscWtKyXI
	Bq9aOgJpglYbDUvTbx9FGZblcIJC/pqgC96IEWvA2F3GAZHeLPolqbwKJVCm5CVa8aQPfte03cn
	0dc=
X-Google-Smtp-Source: AGHT+IEcMiaI8p4nu0+Oo9FmX3c8dSh5JHEOBpRgx1fzXDPwmG+cFna0yv+B82bWgwHATb9RvvUHalC2nnsdSOA2KIo=
X-Received: by 2002:a17:902:ecce:b0:248:ae62:dd with SMTP id
 d9443c01a7336-248ae6203eamr41169345ad.42.1756340383569; Wed, 27 Aug 2025
 17:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-3-kuniyu@google.com>
 <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev> <CAAVpQUCpoN4mA52g_DushJT--Fpi5b8GaB0EVgt1Eu3O+6GUrw@mail.gmail.com>
 <e1ec7d14-ec50-45a1-b67b-f63ba75699a6@linux.dev>
In-Reply-To: <e1ec7d14-ec50-45a1-b67b-f63ba75699a6@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 17:19:31 -0700
X-Gm-Features: Ac12FXyhl0cHjLniHgsnjLB1YunJzhJbR-hzj2gsufADHNTLK3kQXg1nZBBUI8c
Message-ID: <CAAVpQUCnNbV+CcPK48qxTF812xbCeq+g7+avKRSKu2sS+oKw=g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:06=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/27/25 3:49 PM, Kuniyuki Iwashima wrote:
> > BTW, I'm thinking I should inherit flags from the listener
> > in sk_clone_lock() and disallow other bpf hooks.
>
> Agree and I think in general this flag should be inherited to the child. =
It is
> less surprising to the user.
>
> >
> > Given the listener's flag and bpf hooks come from the
> > same cgroup, there is no point having other hooks.
> iiuc, this will narrow down the use case to the create hook only? Sure, i=
t can
> start with the create hook if there is no use case for sock_ops. sock_ops=
 can do
> setsockopt differently based on the ip/port but I don't have a use case f=
or now.

Yes, we can support another hook later when needed.

