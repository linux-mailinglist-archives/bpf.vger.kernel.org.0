Return-Path: <bpf+bounces-68040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73363B51DC7
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859FD4671E2
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ADB26D4D8;
	Wed, 10 Sep 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1mtmKwu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF42652AC
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521985; cv=none; b=DFbo7ColucmppVNP/aLxTxOw5s5MpPccQd9De3v4RWdhElwkIz8sx1fVx5fFywgipHF/DfC/QERp6h1YygJCwGt8ww+3YrzySS/uN+l22H9GIovgqLsouOXX4PXzsVWqG3e240Al+xy40Mq3KIViJ6GgOXb57JLXJtCncPdPtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521985; c=relaxed/simple;
	bh=6QWP6copzj9cf5FPkW3R7sbrZtIvIyER6xtRBGhVG/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAnNr+i8Yz/qyhc0TnIGB5iNeIM/4QzT9I1gfTwgcCtl4l5cP+Wp6hXaTSWrWkNdGf76aefG8AIlQBeNHChPXe8SHzsPC9Z+SoiWB21rw8nMrNvC/Sx3RnmnMYDOWoQDsPkUmrhA0PAzg0GgIxHwgNn8LeP7Moffrqvq4eJdwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1mtmKwu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b2de2e427so49829605ad.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757521983; x=1758126783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crg9ulSxnVedet7AE0tAYFjDi5iUeW7YmzwRm7NeGuA=;
        b=k1mtmKwuCuo0mPp+5/CDGzpDYM3NEpw6RqSoZ+T7JJt/wSDu9a9KP+hDnR4+f9+JXg
         8x5Zqre59Xp0Qs10YpH7IibsVR/xFMAPqQ9HvE0n149eWgHtqnbE7GFutGmxmHrhOxBO
         uk9K0SytK/hdKxXCP0XN3Wg/dhQqCqxOMPQ0W6crrld/rSA4fcxii0xW+fOwQfe+hNMB
         rpeM+94oXJS3mAdGL395osY09qm7pb7R8nAmOLkfwkO0brcl6fZNu/kWDf+UZVZ6Wi4i
         NbbIKbQ7NncNYG+vP/0VD3MPILLsxYD7JwdqYYLlaog430HBv/QP41VFbF/jzpfCobDH
         wq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521983; x=1758126783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crg9ulSxnVedet7AE0tAYFjDi5iUeW7YmzwRm7NeGuA=;
        b=En4cOuLPzZyYs16szSmjOvLXBqD9xpHg/ZFFiNFwZqJWFkMFbR1LVx3wxQ0tFRNoR9
         PoblHLWmP9M1gNtJKdH+d9++UVy10DUAzg+483SKAQKmiq5Az4k2RPxdnMiNpY09LYHW
         6K+xgQOkoZ3KcQhXwVHZ59pK6VtRvCmljcBCvfgmBd7j5Fyj3Sdos6/DN3dwB5YQFU2H
         0QEHXZ05vRKS5Nfm13XsmuA5A9tvJ/77cmdB1R85Uj15kVKymmYUlhzpZonUn/LeUwQI
         O07EtMO7jTo/m33dZRa+DnHI2TlL/V0noUb+iTpZj+be87W/aa/zGbHtUqljqwaY4TtG
         D+dg==
X-Forwarded-Encrypted: i=1; AJvYcCU0stD7siPUKncczV4UYNvyTnp61J73+/1T1edrZ3xzJOWEP3JtbMehMRVCzGBGY6CzXFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1PCay13HHXo3dbaPGYm7DFJxW0NwzGMTiO/B4fg2RDozSQjc
	Plc3ndwLaH3japOaXoeVKI4n3hjPxQgXEQ0V0lzKTRwLLe+C9HQ6zhXBPbW6dExYig8Ki7rp4lx
	6Q1HiMxGNm9GfbK3LYw9r+tIEzh6f514yUMs8+Ure
X-Gm-Gg: ASbGnctxZUYOKrQLDoQQO3CVtvjxcYfvXGh+Vrgia6Gds0adAEWB7bNXjig+yjSDBBm
	F6bCFNRGt/yNL/5T0Qav7Btye891CI9zFWuvroX/Zmcu/0x8M1oEoR5Kx8LyAXgE74nX5E9K4vM
	t0CakA8cmbCpUGywV6Fb4bhWj0KdOBMkVS/geN68qdN3imgrpePgC6ohGE9eiQ4oCkDAIGxW3fs
	KjTepDFNyNm0TLNBdmK0linnrPg4UAMGFpDLE4NbdQk/SM=
X-Google-Smtp-Source: AGHT+IFygkRcH7mrdQ4Zhgc7n2vieMLoI6r6NoPaSe1OOy5LbAIzXpvm7rozB2gTILsaRSM0LL+d/usqZ1C3z4HoNpo=
X-Received: by 2002:a17:902:f54a:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2516dfcb5c4mr232806255ad.17.1757521982717; Wed, 10 Sep 2025
 09:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909204632.3994767-4-kuniyu@google.com> <202509101912.ROjtP2uL-lkp@intel.com>
In-Reply-To: <202509101912.ROjtP2uL-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 09:32:51 -0700
X-Gm-Features: Ac12FXx6aKnMeDmD-Oqq_oMACp8aNPwM23p9lZayrp8qexUb1gFrzTNdorO62hI
Message-ID: <CAAVpQUAXoxU4r1dgC3wtTxx6oVMpOWjd9q7Ub=SEsnHMpL3RAw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
To: kernel test robot <lkp@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:58=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/net]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250910-044928
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
net
> patch link:    https://lore.kernel.org/r/20250909204632.3994767-4-kuniyu%=
40google.com
> patch subject: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce net.core.=
memcg_exclusive sysctl.
> config: um-randconfig-001-20250910 (https://download.01.org/0day-ci/archi=
ve/20250910/202509101912.ROjtP2uL-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7=
fb1dc08d2f025aad5777bb779dfac1197e9ef87)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250910/202509101912.ROjtP2uL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509101912.ROjtP2uL-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permis=
sions
>    /usr/bin/ld: mm/memcontrol.o: in function `mem_cgroup_sk_set':
> >> memcontrol.c:(.text+0xa1e0): undefined reference to `init_net'
>    clang: error: linker command failed with exit code 1 (use -v to see in=
vocation)

CONFIG_NET=3Dn... will fix it in v8.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d017c8b8a00..b7d405b57e23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5002,8 +5002,10 @@ static void mem_cgroup_sk_set(struct sock *sk,
struct mem_cgroup *memcg)

  sk->sk_memcg =3D memcg;

+#ifdef CONFIG_NET
  if (READ_ONCE(sock_net(sk)->core.sysctl_memcg_exclusive))
    mem_cgroup_sk_set_flags(sk, SK_MEMCG_EXCLUSIVE);
+#endif
 }

 void mem_cgroup_sk_alloc(struct sock *sk)

