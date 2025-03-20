Return-Path: <bpf+bounces-54487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B0A6AC8E
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BCB98305B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61F226D1B;
	Thu, 20 Mar 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKaMAk9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022D225785;
	Thu, 20 Mar 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493312; cv=none; b=bw0NAOPQJziWnpodxH/QV/XOwvTZpuaCpKSKgbGbxm/lsvvQ72qvKy1Un/NRyGXwdJxRJhZDugHxrXqXLczOYVC4b9qWnzLgM4f0Dij8ubf3uzG1IV7uAfkodgT2X/FiR/uHKiIyHW8KNJsA1mrivXbOTJ3aGeF6p6i46639nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493312; c=relaxed/simple;
	bh=1tHP3yvoRaMfGdgqMIapuAIJ8bRHb8wB2YvVk0UM2a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIBcv1IKHPDHGrqaYQn5vzSonGxphIvsDmH1tp7pKpA4Y3QYW0L3eVkjOwIr1SjWAn7RtJjbas2SpCSeCKfM3pSR5+Gl270cp0yY2Y1pjlwY0s+qdJwf1zpGt7oACeKPtgygcKjw9tPP91enjW57okQxjruwHO5bD30+L+rt8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuKaMAk9; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so9161705ab.3;
        Thu, 20 Mar 2025 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742493310; x=1743098110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8OWNr6NISgDNy1w3Ru5nNUSHta20LVgeQjr5h6nl+k=;
        b=FuKaMAk9SFIDKca2Bh9OWSVDaMeRxMFXwhOVSNsPrtnCMy+UDYjs12oxOTQDugu3XZ
         4I7DMv6cqyFNm/DZreX7nF2n9WQK51OQ7+u3DsgQOmsrh0KgyHgOfL6jLIO5YpNkZ2Ua
         LTVgqkBIvlco2C3ddK2M5tXfgkzsND7nJf8Ng3VQUJDX3B9hfOPS9h2UVeJQ8gEOc3a8
         xZ1jCctFpE0xaUrzIsa7z7Ad+pf+z+sKuUu2KJuEm6IH0DrTelmEzgS2aGCV0RabEHtb
         BjBV3AlQaReWDOu3fHOYw2MFQJrLtFZDjWVuz0MkPwodpl0IatwpNHgoVbDlFzJifc8K
         ylgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493310; x=1743098110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8OWNr6NISgDNy1w3Ru5nNUSHta20LVgeQjr5h6nl+k=;
        b=dBl/mg6mXCglhU5p/CiOLYHUlUW5MQtB26FB/Y8DAYQ6dSIg8WRLAqk+sK8lLbp68u
         hqS150n+fhbB5pP3d6Dc+iNLl038+rHEnJMB7JC0WUEetisy+gAFEP1prxIwrZW/bUV4
         akkKKymFkdNufcRGxLXiEcRWYcRzYVIEfQsGJMlms5Pcff4KYcf0H76gPzYVlzGYzgg4
         zmlG05/qNslzGzRh/Jn1Pa/uHGUwsiuWzV3k+pufdlVUffk91guZTD9txmYqI1E1+GYU
         JtM4yhLR4f6ZAQNIDk+iCoMNl2Q48V6VufoPZknIqIwuDdpuFlVHuvHh/3l9Dn+a3ahz
         NyNw==
X-Forwarded-Encrypted: i=1; AJvYcCUquwcMYGoIdcAv/qypUeDRjW5u3oEzAcP4vPOrMvKzwTEC8OjYhOXJyIH4RxX4uNV+E/q9T1CT@vger.kernel.org, AJvYcCXtvsbJOj2/S9dyRfgPCf4FKPoigoTpbpez1kS3OPNBIxQ5K50qpRlIV4PhAWXvyTXyvTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQG69MYFhf6nvdFni6MWI/RS26E2r+ALD06rHAls9nk/9vR/k
	sfiQPXCvsSPJJp1ctDGECpv4aC4hmzewWKvQgD0n2GU+EPYgG4LsTMfxk+OJ8SB/Zshhza57RVB
	italeSaklISjwuTvrpR/7v8de0R8=
X-Gm-Gg: ASbGncu5JBBBnklAX/J4L0+ECrik2z6Hv6xqUOjHJJqNVp1THxaj/p8T4t3LB5PMltS
	LWayLlvzZt9QbhUFfcceKzNiJsE3B7SwzTc1qNDwEAQbr53aTNQ2wB5TqoLAilpWZJbfPB4er4u
	SkOGFn8NeLWJLaG/VkxaaKYRdF1IVQv24kXZE=
X-Google-Smtp-Source: AGHT+IF+Bf0fuBiZvKXA7lUowNg9xdB13QbYsRfi7HGunQo07YbRtyOOhbWPCimuma0qBGrX41rIS+zwxHz2T3dZUqg=
X-Received: by 2002:a05:6e02:1525:b0:3d3:dfa2:4642 with SMTP id
 e9e14a558f8ab-3d59611b1famr3292405ab.13.1742493309847; Thu, 20 Mar 2025
 10:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313221620.2512684-1-martin.lau@linux.dev>
In-Reply-To: <20250313221620.2512684-1-martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Mar 2025 00:54:33 +0700
X-Gm-Features: AQ5f1JrGW-_G-Xxgwex1RpY5dtZcM6QkfahZCjCJCzt1StCgnxgsZJW0SxZ_w3c
Message-ID: <CAL+tcoDPMrw8yuajgCFmLTVhB65EUvH3WXXo6O70uyEapwFnXQ@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2025-03-13
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 5:16=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> Hi David, hi Jakub, hi Paolo, hi Eric,
>
> The following pull-request contains BPF updates for your *net-next* tree.
>
> We've added 4 non-merge commits during the last 3 day(s) which contain
> a total of 2 files changed, 35 insertions(+), 12 deletions(-).
>
> The main changes are:
>
> 1) bpf_getsockopt support for TCP_BPF_RTO_MIN and TCP_BPF_DELACK_MAX,
>    from Jason Xing
>
> Please consider pulling these changes from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for=
-netdev
>
> Thanks a lot!
>
> ----------------------------------------------------------------
>
> The following changes since commit 6d99faf2541d519ec30a104d6b585484563e2c=
45:
>
>   Merge branch 'net-ti-icssg-prueth-add-native-mode-xdp-support' (2025-03=
-11 11:10:16 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/f=
or-netdev
>
> for you to fetch changes up to c468c8d299341adf348f1d9cfaacca3cb4f91003:
>
>   Merge branch 'tcp-add-some-rto-min-and-delack-max-bpf_getsockopt-suppor=
ts' (2025-03-13 14:43:15 -0700)
>
> ----------------------------------------------------------------
> bpf-next-for-netdev
>
> ----------------------------------------------------------------
> Jason Xing (4):
>       tcp: bpf: Introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
>       tcp: bpf: Support bpf_getsockopt for TCP_BPF_RTO_MIN
>       tcp: bpf: Support bpf_getsockopt for TCP_BPF_DELACK_MAX
>       selftests/bpf: Add bpf_getsockopt() for TCP_BPF_DELACK_MAX and TCP_=
BPF_RTO_MIN
>
> Martin KaFai Lau (1):
>       Merge branch 'tcp-add-some-rto-min-and-delack-max-bpf_getsockopt-su=
pports'
>
>  net/core/filter.c                                  | 45 ++++++++++++++++=
------
>  tools/testing/selftests/bpf/progs/setget_sockopt.c |  2 +
>  2 files changed, 35 insertions(+), 12 deletions(-)
>

Hi maintainers,

No rush actually. I'm just noticing this patchset might be forgotten.
(kindly reminder here.)

Thanks,
Jason

