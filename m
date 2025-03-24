Return-Path: <bpf+bounces-54613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1440A6DB72
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 14:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A4C3B38BC
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012725EFAB;
	Mon, 24 Mar 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmOT5fGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9525DB03
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822953; cv=none; b=CJ/Q2l4KN5HK4zyVM6EOE7bJnSJWQg4lxe8uKttZeDnKD7SzvUwSEI5E3GfRGtPwqM/W/k4CRFub/6uXNV/ljm9gP5UQvUGWC+4f382Pjn2rRRN8KDsp9+zbkEH/7FU7bO6+/W5LFZFi1IqPAZoC7Ww4EbyW2E+jIVSGCpK0aZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822953; c=relaxed/simple;
	bh=qjCg5petmdcSx4lErJi0RPWGgPVzBZKg17/cgmktZus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLa5LlUcNlUeHLAqN/1s5Ybno5xZ8G3dcFuXL5vg1r7xuPVLZdoprJsneCZXHG/wX6xzNNvO4e+6nADSkBENiIf+S3VN2MERk40cWOx7yZgsFHrkwFYEhYZ37ivDHUYjic1s/C0dXhlCMJFmP11ovO74XRwp0ktTdS8eHp2fQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmOT5fGx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so46866725e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742822950; x=1743427750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu+dRo1yqMd7ELOBTsX/l9v9sTggSVCtRwfpvGq3hzc=;
        b=ZmOT5fGxJzHi/IIE34rd7dqz7kIYmRwx6nZJe8nn/b9CzLQ9uBSXlxo6wnPrWMQpod
         WzdGTemC5G927fdq58I8Y3c43lI69H0Bvd1J3RGPws5nRYLRMakdz/eeFdiYoFK9RIur
         SY6pDTNFV3+Vr0lhtAhlRiEWOuCU6E8cNkEB0uHjgMGnjKX6BoYwfd3AmdWBEQkj7igy
         uBZ7tcl5mqVytZhn6e+SJkMSiGO+yumylF8xkpfrTaefMHaaCbYTGEGV8kBm4heUtZIL
         1IqVWY8zrNF3UA+ks7Ni5vG9PVqg1cWGKnkM1MFXewV6v3qIdsaKVyMB/yUGpUqcKLOw
         1JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822950; x=1743427750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu+dRo1yqMd7ELOBTsX/l9v9sTggSVCtRwfpvGq3hzc=;
        b=j0JJ/d+F1lrNHfr963DOPNsYlEcEbu8K+N7sjDxWPzQX4JGTYxV/fXk3kz4CX57oY2
         YRcNNrgFw6l4MIH3smmXzktL7uKnWHDSJXbX4EJqzTsFfrFEz0skwNKe6wfp1td9+shv
         CdXBOEVkqij5b/UROHaxCT7Bjq/iibkS2bKfTmwRkQ5hDeJH4WAmU5so5ZkNuHsYJzA+
         zt8l2GH1THBqbIQBHx7khxmXDoHCLChNvlAGL/6CDemJOXKoSQGqpm7MT+vy0R0yAd63
         tfqmtKddiSNtTaMTnh+QhPeiF2f45lRPq/vR2fgM/u4U1+9eZOTm7H+r9tT0SexzDnMK
         t1dg==
X-Gm-Message-State: AOJu0YzEsF8u8KBA5OxkO5t+e4nVr09L8OA7Ox0MfbWe/3nYaEXLYB3I
	o7Smscvt6sV/mwLiLYOYdJ09BRRubm8QxFgaGhcmUVNfUpWklqpgVdmuSP8qvclqKgnLH/gANpR
	U1XqCT5MAqSFYTaYVXso7oZrTldg=
X-Gm-Gg: ASbGncvH9aZVJXG5niJlS0Q4tlxhBko2c5nQboElrEwHgOtsXCHMbs1qUsEM+nejw59
	4+f2jfLk+BvagXUMOo2kEDjE0VW3ygn8YlYALdK4KSTNn3abyFXoraJLAqc9XSrtLqKYhp0ZopX
	C7w2FfFwbnwc88d3CXJFhrQLFA
X-Google-Smtp-Source: AGHT+IGZa80ZcbMSbpFX7rvjfax4RDjuDBg7c6VcP7I1ydb/vNEfI3Dhx2v2u1ZHDNtg3yReQRrR5zJ/rNK5iaqtSrk=
X-Received: by 2002:a05:6000:2b0a:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-3997f941223mr9003342f8f.53.1742822949415; Mon, 24 Mar 2025
 06:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308135110.953269-1-houtao@huaweicloud.com> <04a2b00d-970f-7357-81e3-509a543550e9@huaweicloud.com>
In-Reply-To: <04a2b00d-970f-7357-81e3-509a543550e9@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Mar 2025 09:28:58 -0400
X-Gm-Features: AQ5f1Jomi1OoCzFXS0Ip5zGPKw9JIaXUsueWLAEZuLFOdfe_O_f1WY0Lu2Z1YBE
Message-ID: <CAADnVQJeFmNjjshdXUAm0jnOofWSA-O3YJCfvtP82ZbYO40rBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf: Support atomic update for htab of maps
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Zvi Effron <zeffron@riotgames.com>, Cody Haas <chaas@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:36=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> ping ?

Sorry for the delay. Still thinking about it.
The mix of cleanups and features make it difficult to evaluate.
Most bpf folks attend lsfmmbpf this week, so expect more delays.

> On 3/8/2025 9:51 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Hi,
> >
> > The motivation for the patch set comes from the question raised by Cody
> > Haas [1]. When trying to concurrently lookup and update an existing
> > element in a htab of maps, the lookup procedure may return -ENOENT
> > unexpectedly. The first revision of the patch set tried to resolve the
> > problem by making the insertion of the new element and the deletion of
> > the old element being atomic from the perspective of the lookup process=
.
> > While the solution would benefit all hash maps, it does not fully
> > resolved the problem due to the immediate reuse issue. Therefore, in v2
> > of the patch set, it only fixes the problem for fd htab.
> >
> > Please see individual patches for details. Comments are always welcome.
> >
> > v2:
> >   * only support atomic update for fd htab
> >
> > v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmail.=
com
> >
> > [1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg=
-14d1fBYWH2eekudsnTRg@mail.gmail.com/
> >
> > Hou Tao (6):
> >   bpf: Factor out htab_elem_value helper()
> >   bpf: Rename __htab_percpu_map_update_elem to
> >     htab_map_update_elem_in_place
> >   bpf: Support atomic update for htab of maps
> >   bpf: Add is_fd_htab() helper
> >   bpf: Don't allocate per-cpu extra_elems for fd htab
> >   selftests/bpf: Add test case for atomic update of fd htab
> >
> >  kernel/bpf/hashtab.c                          | 148 +++++++-------
> >  .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
> >  .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
> >  3 files changed, 289 insertions(+), 76 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_look=
up.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c
> >
>

