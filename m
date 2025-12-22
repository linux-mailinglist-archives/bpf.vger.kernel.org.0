Return-Path: <bpf+bounces-77274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49531CD47E6
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E49CE3004F23
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF821B192;
	Mon, 22 Dec 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWanKzju"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66F20C463
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364602; cv=none; b=FnksiN4buyWBfIiWS1HG69p4gizYKIxHLkQ9KthxX03rS2qzDePJgcbs1Bkw5h+bs0tstO9os3gpEnipqEPu6AiQKXGMGjmH6pvNfumbPCuuJEdmw8S14opSdNG6IIcT6nqyAiPHTKPcONO5K+UxwgWqNqbdKJPaj4hJyVBO90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364602; c=relaxed/simple;
	bh=lq5RLkXRQIizzY91VZHAMVodSjXZ/IlLCgaKaPHgi9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiLQ6A0zKMhMYaCpSirv8y40Q9RBa39qNfNT6ul3EnM9ut49VWXFzyFYb3IRcRSOj9qJr7cRe/vgFssRCN37IT9u4ysNAN4M6E+e33lc9LLI9pqhLAfXEeWRu/yOJju6RijNl2lhZMMDiQXjQhkip+JPBM7OlySDHorRhN8yR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWanKzju; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so1742130f8f.1
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364598; x=1766969398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvznF6HkFTNiIhI7+tVTU2N5AFcUAe/pj6zJRL8S6bo=;
        b=QWanKzju48le8fj5Kl8VTRQ1BqphOqt/oRCDPQPCRdTaLOc2EPGu2ya1u0yJrk100z
         h0rv1BvtzqkvT6ezKu5sM1wZFibbpCe61102ydFi1gpLk7xNxi0GInTfjjDZlDW/W4Ch
         0XGAHXEe/pOE2ClfsHowjoDjBC+4tF/gcjKHbWVYOrwrtOgvGY1ti9iEw6uBVWZCCcAi
         tTvqEu4QhC9JBMuxu4MMpduKFJxF/1j7tJhGVTf/OLos+jrcdhxG2wdLjcYnYvA3+5/W
         aCQzal5V9BBH76kq9+fkBDeqb5/M+YFJgSLzaNHOG/L/ZYBYASj0O9XnBRJhg2bGeGap
         gOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364598; x=1766969398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TvznF6HkFTNiIhI7+tVTU2N5AFcUAe/pj6zJRL8S6bo=;
        b=hSVavXpcZeMPNVzfn/TbzPDcLBBs0FEZmebEbyENLqMeVoQ9iVvTKVqbcbsdvtxBi9
         sxMFbEzwzE0NMf/N148iHcPDWwUk0UOj/L1VI+pNKsr3s117fhXntdMr9gpdJPOtdx5c
         d1nN/VH8MVJ0sjkYjcs/lawMTteLGLn/enAHhK79Mm9EkeUThqu9l3R4L48FvoYOMXA1
         +STheeJJcRNkKneJIxg6cZtCuZYYYz9tp4baWEoNhArpaXC80mgcDcxJfc1Nxm5hDAZz
         UHOMXCrJJuCwYS+ovKHjhNnxyii050t5p1HRmasmTkwZkZBBpw5sei2bnxxCs/e6VXu+
         WsfA==
X-Gm-Message-State: AOJu0YwoFQeeYJAblu5P5IPQjPVsm0JvT10SDf/moqv7U2iU3a/Z2svP
	i6xScsBAJVu0StMWirIuRiSBGegmGUG6WbvkyLORtkrIbkAMKCmIpJpeae3mPhtauq/wpSxprJI
	wlWlAw96Fa2IJ0A0zYyN02Yfm3lHueOM=
X-Gm-Gg: AY/fxX5uU8JIavjAHmOIcugLBk2pV3bqS5c4PQ61baOsNfg9uBPJsw6vOpEKvt3vp/L
	qiEB1HY8lJBrK2LDvcqdsfCp0MkDkNMJJn/YGBhMzKVlqSctIqPgg1ToX9Nvlhqt4/GUChyrPkY
	u7cDRJEXUKVGc8+fyXhrc1UKEEPKBUJkcNV1fkrtDohANPYUUGDF4WzahbWxg0mUZ/n3cn+FoML
	/1+leYLdhK5ehoRmViR25jSADuEyVa/2y6PHgTN76OEYPmuxQ4M9nXGbK8QGt+RlDo5LiHW
X-Google-Smtp-Source: AGHT+IFLLpsgIg3SMML8wyV0yyIqH9wAeaX6ob4SNQKIJd/JePJVNtDM+7GlyvTtPFOIiSc8UyCFSuUqjpROnExh3eE=
X-Received: by 2002:a05:6000:2305:b0:431:316:920a with SMTP id
 ffacd0b85a97d-4324e4c1519mr9448273f8f.8.1766364597604; Sun, 21 Dec 2025
 16:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220041250.372179-1-roman.gushchin@linux.dev> <20251220041250.372179-6-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-6-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:49:46 -0800
X-Gm-Features: AQt7F2pVDUwMoKC5RqsFan_45pu3L1tkLo-R88ZJb38eQ6Ir4uJa8xcwJuj8ZPc
Message-ID: <CAADnVQJo3HspB9-_R5yWKWLdExDmFayDpNZ4JnoBpCw6aRNTrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access memory events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:13=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> From: JP Kobryn <inwardvessel@gmail.com>
>
> Introduce BPF kfunc to access memory events, e.g.:
> MEMCG_LOW, MEMCG_MAX, MEMCG_OOM, MEMCG_OOM_KILL etc.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/bpf_memcontrol.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index d84fe6f3ed43..858eb43766ce 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struc=
t mem_cgroup *memcg)
>         return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>  }
>
> +/**
> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event valu=
e
> + * @memcg: memory cgroup
> + * @event: memory event id
> + *
> + * Returns current memory event count.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup=
 *memcg,
> +                                               enum memcg_memory_event e=
vent)
> +{
> +       if (event >=3D MEMCG_NR_MEMORY_EVENTS)
> +               return (unsigned long)-1;
> +
> +       return atomic_long_read(&memcg->memory_events[event]);
> +}

Why is patch 5 not squashed with patch 4?
I'd think placing bpf_mem_cgroup_memory_events()
right next to bpf_mem_cgroup_vm_events() in the same patch
will make the difference more clear.
For non-mm people the names are very close and on the first glance
it looks like a duplicate.

