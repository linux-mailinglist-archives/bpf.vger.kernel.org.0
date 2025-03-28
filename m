Return-Path: <bpf+bounces-54879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF041A7524C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9861891B59
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F01EB5EC;
	Fri, 28 Mar 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+XvqYp0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F31D8E12
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199571; cv=none; b=t5bby1HCw+cKRUWiGeFMj3YVR8pF7/e4veGrd+uuruvIibQqasoxUbtMDtA+pyZOtRVic0hQVhSHG8EWlLEiw8nwkJlua7r2VU3IteYXXmdsQ1gsdqcRm+oP05t6Xs9YPDq/tL/qjfcWQm1EZb/od3/fVJ29xUMFui+mWv06xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199571; c=relaxed/simple;
	bh=JTDPAMa/n/6Pq8WisKvS/Rj2Q/oXRf6wRojehHHbBAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrP96UENqD7mFFZxjtBNlaVKYIYYnTNd7lpMt4XhhkoSScSw4TbBrgKIg1onxH7Om9KOISnPC6jNqVnmh9tq7S/BxaPWaXylbVNa43J+DZXOSg4iN+BPcTVI6VLvC8Ew7yZYkPPJgkvFsJ8BiK5qLwFydmub69byBZeRW7tHVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+XvqYp0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso3410103a91.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743199569; x=1743804369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul0DxUffmtso2ismvGdjXQ8lfC0M3SzA47VzBxp4OSM=;
        b=Q+XvqYp0EaS/4rhJBdIRRhoB+ujQP5Ck63vRx4lOfarTKULoPsS1XvokfnPxhij9hQ
         1H5njICZ+u9avxM+9yXJZoUHV+oE1nXv4NFESAZuE0OfivIIY6MJwLFmo7uGurpketKg
         IWGhPvdXW6fLKqZQ+04WLMDVCUITzBh88ejrMfb+DKjt48hWXkSZKSUflckXwAqjvUAs
         jPOa4fMrEfE+r/3VaRvuCZWFIJKGP6/GbEmXIr0wCJqwgHIsCtDDdHnSh+GQMPfZbNRV
         ImX2Y5eJ7AZojl43XQWj8kZi70DJVv4uRV07OK8B7oDjs7ZqElkuralKJ+YdF1RsJHun
         KEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743199569; x=1743804369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul0DxUffmtso2ismvGdjXQ8lfC0M3SzA47VzBxp4OSM=;
        b=kksSp6WsSHp26sIltFMOa+/USzstyqWXF878o2D/N8FjZIiPBkDFIPUr0q0FHUkblQ
         oOKGoxEF/ftBPtARehdTOTnd/B4BZ2Doeh5n1u46fkfSuCt/4sEsan/EyYmxVpyaxWoB
         NBGZTuUdUiHlAj4J5RlKsdVbuCRJ8wyYVXdK6hs3HJg9I0e/swsO7CWsZj1eRGlw/2N8
         hLJpB9RJ2ovKLHI/jpY9qean9pBIAwZA1+F1SdXyUjRibTReXS07uSmnfsjoj+xO6LnM
         32Wly7w8ukA/Lbj452Vv0w5vIlyS+nnPuIx47cZ/wV51LP7KHJ7XkIDCVUpAojT7/t+7
         Ahag==
X-Forwarded-Encrypted: i=1; AJvYcCUC5NdwgyVIIE8Toz4BLTTXqdwAJWLkUfOz1IsjK1oJG33QwfuyU1r6Z35/kQdLY8FDpRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVt4lOHnZmgHnPnH9/WoBJrbuLV5+GZElAXXZElrQF/vt5fSY+
	X5lGdAaaR4mS1QMLhU891TkTGzMgSjXeIm2iu1hHKZ0e9Tk+toWDDwhLAb2ppLNoMQU/YRd9c4k
	dwdEKHOQ0njtpooK7rQ2oVl0e35w=
X-Gm-Gg: ASbGncs2qX/3BFXXierxpTiaNH8n/SxtApXTiFk5AD/fnIJJBbIr9P56MPZbUaaX9ck
	lORaivdnVmyfw460CHlB73HlXCuREitIQVSdzB3pvQycWUVgMZqLJasFEQy2xthKxCeAYHkMaIt
	Uk3DRHzfIiOXzM306QGLrOSZz+VDI/62yf/dhemjELNA==
X-Google-Smtp-Source: AGHT+IHfP/mQhNHsWw3jZgUC3cdKLSQaE6ZcQx/DQDLGvR8aajCcacd+CLsas4XyehxEy7aiWBzwUUxrCgkBN1K8YNk=
X-Received: by 2002:a17:90b:3a81:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-3053214bcdcmr1189789a91.27.1743199569036; Fri, 28 Mar 2025
 15:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308135110.953269-1-houtao@huaweicloud.com>
 <04a2b00d-970f-7357-81e3-509a543550e9@huaweicloud.com> <CAADnVQJeFmNjjshdXUAm0jnOofWSA-O3YJCfvtP82ZbYO40rBQ@mail.gmail.com>
In-Reply-To: <CAADnVQJeFmNjjshdXUAm0jnOofWSA-O3YJCfvtP82ZbYO40rBQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 15:05:57 -0700
X-Gm-Features: AQ5f1Jqrx9MwVuVXX-R0d_jz3m-OQGEnaez_0mSOul8bR00J-OLs4p1ZrZbmll4
Message-ID: <CAEf4BzY91syLTet6S=NWH=hnuV3Ye0dSWy_nYbqND3g1FNrcoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf: Support atomic update for htab of maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Zvi Effron <zeffron@riotgames.com>, Cody Haas <chaas@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 7:36=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > ping ?
>
> Sorry for the delay. Still thinking about it.
> The mix of cleanups and features make it difficult to evaluate.
> Most bpf folks attend lsfmmbpf this week, so expect more delays.

I looked at the patches and didn't find anything obviously wrong with them.

I'm a bit worried how we implicitly assume that if it's not per-cpu,
then htab_map_update_elem_in_place() will be working with FD hashtable
and map->ops->map_fd_put_ptr() will be defined. Seems a bit error
prone. But overall everything looks correct, and some of the
refactorings (e.g. patch #1) are a nice clean up.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

BTW, while I was reading all that code, I got a question. Why is it
specifically per-CPU maps that allow in-place updates for arbitrary
values? What makes it special? The assumption that we only have one
BPF program using value on the current CPU or something?

If yes, what do we say about bpf_map_lookup_percpu_elem() executed
from another CPU? Weird. Hopefully I'm missing something and it's not
really just broken.


>
> > On 3/8/2025 9:51 PM, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> > >
> > > Hi,
> > >
> > > The motivation for the patch set comes from the question raised by Co=
dy
> > > Haas [1]. When trying to concurrently lookup and update an existing
> > > element in a htab of maps, the lookup procedure may return -ENOENT
> > > unexpectedly. The first revision of the patch set tried to resolve th=
e
> > > problem by making the insertion of the new element and the deletion o=
f
> > > the old element being atomic from the perspective of the lookup proce=
ss.
> > > While the solution would benefit all hash maps, it does not fully
> > > resolved the problem due to the immediate reuse issue. Therefore, in =
v2
> > > of the patch set, it only fixes the problem for fd htab.
> > >
> > > Please see individual patches for details. Comments are always welcom=
e.
> > >
> > > v2:
> > >   * only support atomic update for fd htab
> > >
> > > v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmai=
l.com
> > >
> > > [1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYL=
Eg-14d1fBYWH2eekudsnTRg@mail.gmail.com/
> > >
> > > Hou Tao (6):
> > >   bpf: Factor out htab_elem_value helper()
> > >   bpf: Rename __htab_percpu_map_update_elem to
> > >     htab_map_update_elem_in_place
> > >   bpf: Support atomic update for htab of maps
> > >   bpf: Add is_fd_htab() helper
> > >   bpf: Don't allocate per-cpu extra_elems for fd htab
> > >   selftests/bpf: Add test case for atomic update of fd htab
> > >
> > >  kernel/bpf/hashtab.c                          | 148 +++++++-------
> > >  .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
> > >  3 files changed, 289 insertions(+), 76 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lo=
okup.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.=
c
> > >
> >

