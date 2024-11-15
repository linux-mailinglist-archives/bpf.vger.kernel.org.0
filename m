Return-Path: <bpf+bounces-44928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD39CD66F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 06:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167612836B2
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3516C684;
	Fri, 15 Nov 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxzS2Jcy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3902F26
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647328; cv=none; b=hn8VAxl5z6TzH1leYRzBRRWDZTyczlEoN65qVggzRM86IaXNnvgGWHnGaSo5DBMQ0/Oi0oNftDPT/mxTSouV8aRuq9Q3HjoGsh77rdcn9K51rCqRQbIThqEYYQ47Dp+UrnpDqaTMnTB8eWHed3v6Z/LjpymXNWrpyy0d2tLLy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647328; c=relaxed/simple;
	bh=g9cyJ3gA4e8nGAnMq4nREAIZuzEqRqGgcXyRHcTj+aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctlNtOZ0x2dSXi+EL7Wy/62J5nrvWyEUw1LGlojRBoq5vbkFFck7ixXl7FKSwTvu88qBjOcKnkyiHjuiv+cMLCH/K7EK8R6SXLcGe/9gGUQd/Lv7Y4N4/uPucsw4DWy41DEqMXDi40MjorDWC98zWmfvMbVYAwgYA1iciYwYc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxzS2Jcy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3821df9779eso772691f8f.2
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731647325; x=1732252125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE9N4EdnoCMh60r/bpC7RIGmUtJcBIXogzoW62O1H+4=;
        b=TxzS2JcyTu09dmboDBO70NuV0naQTX7+Ah6ijPTGuVMJEN+n3+0DNjQgFJ/WiMcTou
         KNgOPmLo2WRs1Akkze7c22PAShES28UhlXfplYZmgcS0Pwl2cnfqbsrs6sz3/aophirW
         4u4KJDw5jwrvyH9V6ledUamh3Rgh7cGDPihqBqnjaXaFvACcFHLNMx6PtDAMVpHdrgVE
         FC1MomgKQTL75WfrL3pXrHqCGyFVtK9u4ZB5xCUcYEe1BrjQ1ARwRR7hVts8h6eqFkjz
         IQbQt6zhyB+kbPwtX1Ap90Dt7xjESj0NTTQKhqAPW0uW4oNn9lF9FUeSiL7YwSbg5NGG
         Be0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731647325; x=1732252125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE9N4EdnoCMh60r/bpC7RIGmUtJcBIXogzoW62O1H+4=;
        b=IjlKiUVURg2eDnroEw9SclAtWND94/PBJDKWlKBifq39xqFLfp0jIAuhT01ohT6v1f
         AkjecBlh9XA150nxdcrBNRc8Wz6EaMwMDc11lA3wBcnmzl8efWKQ9Z+zScjCgnsU8q9L
         rMZgcL3ytF+R8sPbnz8N+NJ3dNjw6YIOKACE+dmjDfhNjVTzgAUo8w/sbo37v0ZTtcp6
         rny6UPPlKUzbvprazWrns/+L9hhoWM6w9tjUsffLZiZJssnXscOnsRVh4TZuqWFKt+Xi
         lA3Sx8Az33CLCzvgSUlFtGl/YuNc1L+/TJDTS9PrZwZ3lIkdZvi76Q1KkYzxMRU6S6zt
         t7gg==
X-Gm-Message-State: AOJu0YwFlmnrfyrvaQTBiAVgL1VI71xws8lwdq8oJFY0PUpNFO+L4Dnz
	Q7orLrgnSHWn9HYSZkCG2iGSwjmpVIjGPPAPGSQ0O++Z1VRrZD76Re0mjYVy8YTg4QjGy1eP+Nv
	BkmMKg3k3E4lWy2Wo/KWHj3hWsBs=
X-Google-Smtp-Source: AGHT+IHUr1BKEoB2Zui2943b7yu7dOjLxuNaYD40mwcuhS+0ZWciI5n6QSJtBN019V1IyUTggoTjVxv9LFlDpbYzdmI=
X-Received: by 2002:a05:6000:3c6:b0:374:af19:7992 with SMTP id
 ffacd0b85a97d-38225a42f6dmr992310f8f.7.1731647324788; Thu, 14 Nov 2024
 21:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115035257.2181074-1-yonghong.song@linux.dev>
In-Reply-To: <20241115035257.2181074-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 21:08:33 -0800
Message-ID: <CAADnVQJpvMjD3B4BvDZZybPvhakMOxjOAo_HmVOnmvkgTKPOiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add necessary migrate_{disable,enable} in
 bpf arena
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 7:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> When running bpf selftest (./test_progs -j), the following warnings
> showed up:
>
>   $ ./test_progs -t arena_atomics
>   ...
>   BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u=
19:0/12501
>   caller is bpf_mem_free+0x128/0x330
>   ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl
>    check_preemption_disabled
>    bpf_mem_free
>    range_tree_destroy
>    arena_map_free
>    bpf_map_free_deferred
>    process_scheduled_works
>    ...
>
> For selftests arena_htab and arena_list, similar smp_process_id() BUGs ar=
e
> dumped, and the following are two stack trace:
>
>    <TASK>
>    dump_stack_lvl
>    check_preemption_disabled
>    bpf_mem_alloc
>    range_tree_set
>    arena_map_alloc
>    map_create
>    ...
>
>    <TASK>
>    dump_stack_lvl
>    check_preemption_disabled
>    bpf_mem_alloc
>    range_tree_clear
>    arena_vm_fault
>    do_pte_missing
>    handle_mm_fault
>    do_user_addr_fault
>    ...
>
> Adding migrate_{disable,enable}() around related arena_*() calls can fix =
the issue.
>
> Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it=
 in bpf arena")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/arena.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 3e1dfe349ced..9a55d18032a4 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -134,7 +134,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
>         INIT_LIST_HEAD(&arena->vma_list);
>         bpf_map_init_from_attr(&arena->map, attr);
>         range_tree_init(&arena->rt);
> +       migrate_disable();
>         range_tree_set(&arena->rt, 0, attr->max_entries);
> +       migrate_enable();
>         mutex_init(&arena->lock);
>
>         return &arena->map;
> @@ -185,7 +187,9 @@ static void arena_map_free(struct bpf_map *map)
>         apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_star=
t(arena),
>                                      KERN_VM_SZ - GUARD_SZ, existing_page=
_cb, NULL);
>         free_vm_area(arena->kern_vm);
> +       migrate_disable();
>         range_tree_destroy(&arena->rt);
> +       migrate_enable();
>         bpf_map_area_free(arena);
>  }
>
> @@ -276,7 +280,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>                 /* User space requested to segfault when page is not allo=
cated by bpf prog */
>                 return VM_FAULT_SIGSEGV;
>
> +       migrate_disable();
>         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> +       migrate_enable();

Thanks for the fix.
I thought I had all debug configs enabled :(

Could you please add migrate_disable/enable into range_tree.c
around bpf_mem_alloc/free calls instead ?
range_tree user shouldn't need to worry about this internal details.

pw-bot: cr

