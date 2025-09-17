Return-Path: <bpf+bounces-68634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55CB802AB
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF3C2A4B23
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723A2C21C2;
	Wed, 17 Sep 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KD8gUSuL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CD27F75F
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092622; cv=none; b=HqOJFesKuKoB90QMsh99h/9cxzcyeEgizCkvqhIm+fs7g2GUDnrnNp7j8BPhnCAEsxlwBiKkWVbvWqKyl7cf9ZF1LpY3ejBoGHvGowb6X+RLZ6Eh6reaomFTIUuk/ILfUevujOCSgTl0D8xWJJKBHCakxTzF23m4DctIq/z9hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092622; c=relaxed/simple;
	bh=ZtJdwHsCQacx7vT+1PGPgg7gCIp7k++eP+19pc8gOjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpdJoU2aDP5w6bFN1JAhvNYpKgxb9p0Nbemx3ikNBiKGJzsIUBoG8ZHYv32W7sXbGBzTP6qx+2ZIuEQt2CAGiqtmobdmIvdmQAl3w5EpvCtFABJp84Szysp1JudleaI1gJdFiJjVb9s1ncGdFTctsoPOuOaZekF3YKyMVbnkQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KD8gUSuL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244582738b5so53090825ad.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758092620; x=1758697420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
        b=KD8gUSuLGPKG+5n+5D2HmmxLUtFVSP9gGkup4+V4M7+X12wp+ZmZHfWTjWJdSmXwn/
         qLH1degeEoxNghZKQ3lTdfBkLkvPUILGbzggbMV2FJ0GFJqbvRUd3jVTDWDIb82hQdTu
         XFKMSRz3A5kxWxTZ9eiuDNkt6D8W1qlfCLVftfrN1d283mYDDTTpj6PPE49KtwZN3aVa
         J7Z0ba/BiTrp5zrj4Jo6/lVFx8INKePcZzSFHNP9CFNKUEzszyArUa2p0FbT5DrQ7TPI
         I0bYVlEmkLC7PSnVEZM9udm9JC8roNnvjrfOwoeJu5HSgjeBuG5/WkN9tvZnfluLEXvI
         pOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092620; x=1758697420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
        b=Rq4R3jYT/rxwKvhC+Xyw82Evo1yVonZiCg1KvChTLZXE/wkiUJb+OwDV42UIAkqXRd
         1Cw13QCDqII5QkTOhF+tPxI715GZLgsc8ozDs5kuMn7Go8l4F6+FB1s2cBkFt/DemW9N
         nHV8ZXp6LWDX3g3qhyMbJynaUtyXfF/ioV6xemoXD7mycabWJDL6yTfi2bn+nS2Gcgn6
         BZDhzNjh3tkhS0DMKXh+wxZvN75iJqeyAyAjmbsc7h7JfJ7RVWz+R8xEe+w2tNf3bFwg
         riOxV0+KOscnT6gDEAVTe26AWLeqpCzrIJMK5XaFjyEYRK54817xNivfCZUuByIqxNwX
         Oe4g==
X-Forwarded-Encrypted: i=1; AJvYcCW1I1N0EeQnN/nmNjvFj+F0FIIUhuDPuHP/QVCzffjXCGnGg997DmxNg+qMJMWVOEqW9yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICWaM1e55FGmfDp5mYtfV7NKzs2IHy8asFro5CYSYpKNd6CvN
	QLpIj7gfTkuNOQ7OCL0jvE+1E9OKyjP7wOVL+8VNs1f0mv1vmCAGH26a1ET1Mk2Cx2cBjs3hgDN
	F8jZX/tpAixiUUDMchVgkI8wflPW5+LkBSZFDfGPl
X-Gm-Gg: ASbGncueHA/ej3FQPWop7C9zpKcw3wUKpvwgS+55H3F4YoeZe/ff93N70pK4ln/yIye
	89V9RWUjPqbtyes9TMDREDYlIe2en4O+BfPXuGFf8ESIq1FHzvU3LVpw100umTnsFtOroL8TsSI
	kt9U6HF573mNj/49Q/eeMdwah1yTkkhSHUJJJLUwM3Yge6CO5TKcjJjiX6DyVNP0s+cAXdKqD8E
	5vh5KMuflj1V1l7/dGw8LECbQBZeLnOxtxACGp3O3LdGqUTdj5VKLabi6iwkp3Enyg=
X-Google-Smtp-Source: AGHT+IFHqqSb0iZeLJZY85eRucnrDK2myNCsnrye3aGyc3jn1Chr0LEkdru+rbzxnAqB29LvtQoRAz7rfDOuHcs9NJY=
X-Received: by 2002:a17:902:dac4:b0:248:f84f:fd3c with SMTP id
 d9443c01a7336-26812166d0cmr13573895ad.13.1758092619855; Wed, 17 Sep 2025
 00:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910192057.1045711-2-kuniyu@google.com> <202509171359.658ddb38-lkp@intel.com>
In-Reply-To: <202509171359.658ddb38-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 00:03:28 -0700
X-Gm-Features: AS18NWCDLFhRi5V-YAZb1sP659_dYtJBp3pw_GvlN50RKdZinoKi4N8ZdQCAG4E
Message-ID: <CAAVpQUBZT4dX9hU8h6s8ew5BYX9C6yBPaRODP4zM3F-=BB4Dtw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, ltp@lists.linux.it, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:37=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
> Hello,
>
> kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in__inet_accept" =
on:
>
> commit: d465aa09942825d93a377c3715c464e8f6827f13 ("[PATCH v8 bpf-next/net=
 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().")
> url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp=
-Save-lock_sock-for-memcg-in-inet_csk_accept/20250911-032312
> base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git net
> patch link: https://lore.kernel.org/all/20250910192057.1045711-2-kuniyu@g=
oogle.com/
> patch subject: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memc=
g in inet_csk_accept().
>
> in testcase: ltp
> version: ltp-x86_64-c6660a3e0-1_20250913
> with following parameters:
>
>         test: net.features
>
>
>
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GH=
z (Haswell) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509171359.658ddb38-lkp@intel.=
com
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250917/202509171359.658ddb38-lk=
p@intel.com
>
>
> we saw a lot of "BUG:KASAN:slab-out-of-bounds_in__inet_accept" issue in d=
mesg
> uploaded to above link, below is just one example:
>
>
> [  468.984291][T30180] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  468.992753][T30180] BUG: KASAN: slab-out-of-bounds in __inet_accept+0x=
5c6/0x640

Oh I misused sk_is_mptcp() which assumes that sk_is_tcp()
is always true and should not be used if sk_is_tcp() is false for
SCTP, so sk_is_mptcp() test was unnecessary

I'll remove it, thanks!

