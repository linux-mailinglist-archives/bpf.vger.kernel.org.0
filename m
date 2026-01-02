Return-Path: <bpf+bounces-77710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B14CEF3DF
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 20:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 172B83001615
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6027FD76;
	Fri,  2 Jan 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjyOyC7j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729723C4FA
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382800; cv=none; b=adAv1+KqMHShj/GwCUiqxfhlC7ZaEJPnWp2NzBuxtk1f08Ng+HaOn0WqcML7gGnFKXI01W+y9qKE3CNXg/2uUs/INQBJs/i8fPa4hDsCL+cemMKWQ8R3JpVSLQBsbT20M68IuAlJ6kfjTUFs+BFTpx1VajpmjWP8iejeAegBRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382800; c=relaxed/simple;
	bh=6BIs6+3JFU4smJ/lWPQo4s2yERqPoICauhp20Oit7ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe5L0NLkUyPW3HM4XvLvLuqcKPH4nRz/dIc+JIDhbkuSrSRujmPMRQaQo93bcEjrzOA5n3gCgYgoaX8dApJqbWs09d3zT93dMEiD1qZMVpAvbKtTB6gIMhGKtLdtpvL8ocg7rwIP7+N2wIUnaWdcVjVBlI882ojuuCcmQtzv7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjyOyC7j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso57190575e9.1
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382796; x=1767987596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CfC9CVrZi76tTwtJs0RUcsrQxaGmj5vmJMN+tDEPkI=;
        b=NjyOyC7jMHU94OC6wvhn+0QvcrW2xe11Pe58BewtvZm5VlUILdllUmDBWFdaxcTlwI
         vWylVeOErr0mrOHQBUjjFxCML4HSxZ2O19A0rzABEDsBNBLu9SV6K3MJkhWDfCrwv23Q
         OpfLT13k30m2E+UxiMbB6FvCrbRFgyW6aJER1FM1OYzkZci3BpNhoFLUFQijQyhaygtY
         ld7Md3+yxejuCxLLO4AS7LKMF5PTMi0M+N4vtHQZgqdY0ZO0TZLoHJ8rJ8aE5pv+z9kP
         SNRTOMVnRN09CjK8keERG9Rfj2aQzX1NefvxINIjpBwqw5nt7EGASmCVTswhUal/vM2l
         VCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382796; x=1767987596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5CfC9CVrZi76tTwtJs0RUcsrQxaGmj5vmJMN+tDEPkI=;
        b=ui6k6CX6lzHc1EaAfdB0NM58A1ypfscAwxKwV3MSmtrB1ndJZJFFw9V7vuTaxq9Ktu
         mxPCVaKNSLMVRRyPGjKjTjqJei78DDzM36/1fojKK21S46jLCRdT3qlmMmWNYk8lf/ck
         5q1mGVIlhX8L+HiGv/dQZpElst0GA+NeJQOrrU17JG+oKvf4V3xELRqUf21K3PyqqguH
         iOIMZDFmcE6YL5/nQJah5fzO74BTm+cS9xjxorh6FAnb7KWYAOuFFZQSRKxqA47fBeNK
         Zk/sW6NtTa0JBjFVd8oRFfGADsWn5TnzoetmmwSPGyUihOXpmMCGM/liLQKMMDnCKayJ
         7EEA==
X-Gm-Message-State: AOJu0YwLAf4DAqVeY+DUm4ENX/e9CUlxLGo6S1B5gZdvOwwPDnsHWsHv
	quNA/t8Q18m1qgornzyUoRkVtVcGB00EHDKPwY7V93OutaiUv2ogotIGNybMehNJ7PZ8xhA3s8z
	LNkf0k7GkatpthnmKah8KyDL/jXfa4lY=
X-Gm-Gg: AY/fxX4vM5UzhQ1/sdqwnzY/xxDq0tNEtKjBFv9m+C5Y+FO/VnbSSsXlJBzb1wpEf5w
	p34kKrzw6LuzyuS2LFUg55he9Sgm4d6uy0zWg901Wg1gcJdEo9psF4w7uIMwoEVDqAiQOoSSVTM
	BwmBa/VuXmvyPaJbecdoTVN0aIkcp1khaMDGi9WBlSQjNPlhV47BQArmbD/2TLnWc/QhtEH+9xz
	iX6ymvPb6s8xK6pZXd1X68yGru8MgTeMaRPmA3gZMQ5kKV6lEkR8CURHWsbhZ/NNBiH6gy4Rret
	+BG4MlyQbpZHzHjDDyfXTImLCnWM
X-Google-Smtp-Source: AGHT+IEYHZEQPBMmElgdIuMgg+VdZetEZxpDyeIDwM3wTCNSqh+iYvMNuLPFIemyqlnRim35nSq61XHPzq9wZWFXK/g=
X-Received: by 2002:a05:6000:1843:b0:431:342:ad44 with SMTP id
 ffacd0b85a97d-4324e50dc75mr57169370f8f.45.1767382796441; Fri, 02 Jan 2026
 11:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102181333.3033679-1-puranjay@kernel.org> <20260102181333.3033679-3-puranjay@kernel.org>
In-Reply-To: <20260102181333.3033679-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 11:39:45 -0800
X-Gm-Features: AQt7F2o7LMsMUACLmyS89IBHBa6K098vXbDPyH8ZyEEmZQi5A8n9IzMqZkYjGP8
Message-ID: <CAADnVQLzApPhFaLR-B-WpNvSz+_YBJTAYAaCs1o53yKHHA6PMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: arena: Reintroduce memcg accounting
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>                 left->rn_start =3D start;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c77ab2e32659..12e44f433d72 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -618,7 +618,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, in=
t nid,
>         int ret =3D 0;
>         struct mem_cgroup *memcg, *old_memcg;
>
> -       bpf_map_memcg_enter(map, &old_memcg, &memcg);
>         for (i =3D 0; i < nr_pages; i++) {
>                 pg =3D __bpf_alloc_page(nid);
>
> @@ -632,7 +631,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, in=
t nid,
>                 break;
>         }
>
> -       bpf_map_memcg_exit(old_memcg, memcg);
>         return ret;

Sigh. See CI complains:

../kernel/bpf/syscall.c:619:21: warning: unused variable 'memcg'
[-Wunused-variable]
  619 |         struct mem_cgroup *memcg, *old_memcg;
      |                            ^~~~~
../kernel/bpf/syscall.c:619:29: warning: unused variable 'old_memcg'
[-Wunused-variable]
  619 |         struct mem_cgroup *memcg, *old_memcg;
      |                                    ^~~~~~~~~
2 warnings generated.
New errors added

pw-bot: cr

