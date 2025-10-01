Return-Path: <bpf+bounces-70165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE00BB1FCE
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EE11C0E44
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB673126B0;
	Wed,  1 Oct 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT637a1H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EA296BCD
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357540; cv=none; b=otlNifWJX7AbWYHfBVhz3HEmnyxGM142jDbQDYbhAw//XHnvF6TJasoqm88wedu60YYHH2nF5cBBSMKJMfkPA4C+iHynLvYMqwuChW5Ls/Au/eRpXseXB5eOTgprb2IsWV/lAFYfVFF3xavgnEMvHeqa6+NbuiCH3RPoTN1ZbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357540; c=relaxed/simple;
	bh=gurYv7OmG7JPJ89tnLTtMxBysLOPv42xZbrgsgp8n3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9AuI7n3ARFO4LGNX19LUabNGm0H/w/O3TGMAeRSYSJvuSYPXnarSYM2A1MkWoUaZTwih3VEPl4N3HSrha7MW2qqml1fODwOQb4OIIa1ZenVW2hYelVIRyafGUm+WzfxsxKQA3xqLnvTIK0eChHOy2BBeXtBNScNwvTixVBdhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT637a1H; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so212278f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759357535; x=1759962335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzvrs1VV2WDiIUvA5i+R/HiHvohIXfIQ0AqUBNp0VuQ=;
        b=cT637a1H83BMjkUbEWsbSYymtE9rGewSjK86pSQbapKcrVKNtEK9WOVDhhRhvOkz6U
         Ct2JBMHyvORK5srmMI/5i4br85DbA0IZjKM1rgNKOlrxllG6avk5NZs+E+wN/uZ1sZEb
         1YsuKiF2aUxw65YedpVoDJDn5u/9R/aBTdX4zCAhJNCBEesP2/BQWNhfj3XzkH7w1qB+
         LM85Drq+EO74cjbApFx/87Nljompm15Ke6NYiVTUWfLt7J14atUEUpzrn4LB1yKCZBGd
         wnEi7OXAf8z1cPxxDdkdacePuV7MDoRLZX27RdUW0szqTgZLKomhsDABbnSiWlnAFBda
         ieXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759357535; x=1759962335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzvrs1VV2WDiIUvA5i+R/HiHvohIXfIQ0AqUBNp0VuQ=;
        b=GKiwMzAtfNM0wXk1ichBi5ikVZQNED9Tg/poLDYEPmvmvh9LftGTRxZfyZ14HVnw9j
         vaLaddCZkG7wRzgz5E21vyeG+UBJxIeAigAwUEQzKvD3mkJ4hKzmmvK/9EdSSP5Rlbxn
         0mcnUsQXSzVbnzFZw7ljGr9wSws3AIPlXBZQtfc2WsesbKWUSB2WJoNNfrmsBYHxzZAk
         l6nv2pntTflAl9XecAq6Jw+QOE/5YmcvNaZLifOGSNUwlhiCCLqcYE2w5xhEnq454tIK
         HJ5QcvxTyK7ZCfCsZkkpbqnf+oAKpH1VrBICdj/bc1jR+yFPIqBzin1q1aAHpZicLe4r
         cmpA==
X-Forwarded-Encrypted: i=1; AJvYcCXqVQtSmdvx13cCxofFJVBYi+tX6OUmTFROR3vUv1eKeXYKXUlrila8dnUpl8YM5y6l+iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliqRpdYf/1ZDa/F+xBtxS64GvD2rW2I/EcJ3aZy2yxZmJeYB8
	TgcG4v1nSDa7L1sWo9HeOFYIn4L4w2doQuiUiwNyabr+cCYZJ75dZ1oLaVAffI/TbUMOeMrVSko
	KyX+f/RKUEKS2vz5a5+QBprjWHCTBa5qDix3k
X-Gm-Gg: ASbGncsmpfSOOY7GRgW3BCN+h7A9FbVwwI9PBXw+iCA90si/wU+GosADq0M4H81DalB
	SGGk4WsvbIQwtw3TyhVs0h+9gXKvUeFQ6M80ke0WBtIkX15LIrf83uA7FFceIoTr2pHi4nfXdqe
	3kzgKXeZnx/HpFa3+M0lQEAzZ0cAXLxKJSbnfoKzww8/sdZdg/Qqpq/AyQZO27mvAr+Gf7vj6bw
	WnPdibIQFme2c3cy2Tcgdp+CveI73L6YIkKSN5GossRp7eg58Xzt6jfEOpb
X-Google-Smtp-Source: AGHT+IHUnBKdFqH+zdDC55FLmxcJJANqI9YCx7pP1qHkYZGc1Je9nusm+GcGOviIHqQ5EYWixbHaoj2wSMOND3KK2p4=
X-Received: by 2002:a5d:64c8:0:b0:40f:5eb7:f23e with SMTP id
 ffacd0b85a97d-425577ecbedmr3263574f8f.1.1759357535110; Wed, 01 Oct 2025
 15:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001045456.313750-1-inwardvessel@gmail.com>
In-Reply-To: <20251001045456.313750-1-inwardvessel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 15:25:22 -0700
X-Gm-Features: AS18NWDFsjjNNsPBytmySk7rKJfVZ4JmUJORMaJDq5DI1Bp20yXRuNwLH5i4BL4
Message-ID: <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce kfuncs for fetching memcg stats
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:57=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> When reading cgroup memory.stat files there is significant work the kerne=
l
> has to perform in string formatting the numeric data to text. Once a user
> mode program gets this text further work has to be done, converting the
> text back to numeric data. This work can be expensive for programs that
> periodically sample this data over a large enough fleet.
>
> As an alternative to reading memory.stat, introduce new kfuncs to allow
> fetching specific memcg stats from within bpf cgroup iterator programs.
> This approach eliminates the conversion work done by both the kernel and
> user mode programs. Previously a program could open memory.stat and
> repeatedly read from the associated file descriptor (while seeking back t=
o
> zero before each subsequent read). That action can now be replaced by
> setting up a link to the bpf program once in advance and then reusing it =
to
> invoke the cgroup iterator program each time a read is desired. An exampl=
e
> program can be found here [0].
>
> There is a significant perf benefit when using this approach. In terms of
> elapsed time, the kfuncs allow a bpf cgroup iterator program to outperfor=
m
> the traditional file reading method, saving almost 80% of the time spent =
in
> kernel.
>
> control: elapsed time
> real    0m14.421s
> user    0m0.183s
> sys     0m14.184s
>
> experiment: elapsed time
> real    0m3.250s
> user    0m0.225s
> sys     0m2.916s

Nice, but github repo somewhere doesn't guarantee that
the work is equivalent.
Please add it as a selftest/bpf instead.
Like was done in commit
https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
to demonstrate equivalence of 'cat /proc' vs iterator approach.

>
> control: perf data
> 22.24% a.out [kernel.kallsyms] [k] vsnprintf
> 17.35% a.out [kernel.kallsyms] [k] format_decode
> 12.60% a.out [kernel.kallsyms] [k] string
> 12.12% a.out [kernel.kallsyms] [k] number
>  8.06% a.out [kernel.kallsyms] [k] strlen
>  5.21% a.out [kernel.kallsyms] [k] memcpy_orig
>  4.26% a.out [kernel.kallsyms] [k] seq_buf_printf
>  4.19% a.out [kernel.kallsyms] [k] memory_stat_format
>  2.53% a.out [kernel.kallsyms] [k] widen_string
>  1.62% a.out [kernel.kallsyms] [k] put_dec_trunc8
>  0.99% a.out [kernel.kallsyms] [k] put_dec_full8
>  0.72% a.out [kernel.kallsyms] [k] put_dec
>  0.70% a.out [kernel.kallsyms] [k] memcpy
>  0.60% a.out [kernel.kallsyms] [k] mutex_lock
>  0.59% a.out [kernel.kallsyms] [k] entry_SYSCALL_64
>
> experiment: perf data
> 8.17% memcgstat bpf_prog_c6d320d8e5cfb560_query [k] bpf_prog_c6d320d8e5cf=
b560_query
> 8.03% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
> 5.21% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
> 3.87% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
> 3.01% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
> 2.49% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
> 2.47% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
> 2.34% memcgstat [kernel.kallsyms] [k] kmem_cache_free
> 2.32% memcgstat [kernel.kallsyms] [k] entry_SYSCALL_64
> 1.92% memcgstat [kernel.kallsyms] [k] mutex_lock
>
> The overhead of string formatting and text conversion on the control side
> is eliminated on the experimental side since the values are read directly
> through shared memory with the bpf program. The kfunc/bpf approach also
> provides flexibility in how this numeric data could be delivered to a use=
r
> mode program. It is possible to use a struct for example, with select
> memory stat fields instead of an array. This opens up opportunities for
> custom serialization as well since it is totally up to the bpf programmer
> on how to lay out the data.
>
> The patch also includes a kfunc for flushing stats. This is not required
> for fetching stats, since the kernel periodically flushes memcg stats eve=
ry
> 2s. It is up to the programmer if they want the very latest stats or not.
>
> [0] https://gist.github.com/inwardvessel/416d629d6930e22954edb094b4e23347
>     https://gist.github.com/inwardvessel/28e0a9c8bf51ba07fa8516bceeb25669
>     https://gist.github.com/inwardvessel/b05e1b9ea0f766f4ad78dad178c49703
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dd7fbed5a94..aa8cbf883d71 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *=
memcg, int event)
>  }
>  #endif
>
> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
> +{
> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) :=
 NULL;
> +}
> +
> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return;
> +
> +       mem_cgroup_flush_stats(memcg);
> +}

css_rstat_flush() is sleepable, so this kfunc must be sleepable too.
Not sure about the rest.

> +
> +__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cg=
rp,
> +               enum node_stat_item item)
> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return 0;
> +
> +       return memcg_page_state_output(memcg, item);
> +}
> +
> +__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
> +               enum memcg_stat_item item)
> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return 0;
> +
> +       return memcg_page_state_output(memcg, item);
> +}
> +
> +__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgr=
p,
> +               enum vm_event_item item)
> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return 0;
> +
> +       return memcg_events(memcg, item);
> +}
> +
> +BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
> +BTF_ID_FLAGS(func, memcg_flush_stats)
> +BTF_ID_FLAGS(func, memcg_node_stat_fetch)
> +BTF_ID_FLAGS(func, memcg_stat_fetch)
> +BTF_ID_FLAGS(func, memcg_vm_event_fetch)
> +BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)

At least one of them must be sleepable and the rest probably too?
All of them must be KF_TRUSTED_ARGS too.

> +
> +static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set =3D {
> +       .owner          =3D THIS_MODULE,
> +       .set            =3D &bpf_memcontrol_kfunc_ids,
> +};
> +
> +static int __init bpf_memcontrol_kfunc_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                        &bpf_memcontrol_kfunc_set);
> +}

Why tracing only?

