Return-Path: <bpf+bounces-21697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C101850344
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197901F20EEB
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACE2FC29;
	Sat, 10 Feb 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyyBEgYs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEF2E632
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549420; cv=none; b=RJAjD/wOLIgw0TAqbRLdOwMvxs4OpXNntuvpmNFzOHMUU1eDHt0DGP4/Ez7QtPzYN6jDU3ESuW9yEvbji2qn1xzZy7Y5BTPUUKFBqLHYXP3SLc7Rfg6+GYuYTJvrZ50zpHZizuWMLmg/RElOxDxSkMoue8v2laZk8hDwbU/MMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549420; c=relaxed/simple;
	bh=luv/nozxQiaR+dTBlsUTbS7gmBhprrhBjeFkNiOxAIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KV7MmvqpYp5/osQEsSmp/mzNoxfhpQarDmJsIQymDLK3iJpB1YhITy60rl86tciQbven/+9WEqnVMpQ+AXxxM8WWPk9BotG6cGC4E7jtZOBPxAkz55fSQAajFAVxURqTm9+sShELSslLu8IpjMuQUC0J/wgEPmGjodcMFgpcApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyyBEgYs; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a28a6cef709so223140366b.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707549417; x=1708154217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y97i1bM3fowwtIiLcqiCPU79flprtC3sB1VR0OaMOMQ=;
        b=AyyBEgYs7WPaaRB6bEWIwn/LZtviUgMkRffnQITDG65Hml8RTPGdJIO21nm5azP/1P
         zletx3TAFY5HpDL/TupBTNPOq4vSqWer58nokM15gWdEkX4BdftF/rSm2UWpwtYbYnMm
         5Wr2UB1Kgbm3XkJWfZGxVpTUuKSgXS+UcK6WXoGXICoZOSulPYk8u/Beu3xN/pO5T0pL
         r4YO8u2f9731PCuMGJydC9ambZkVnZqcMZB7q1ebrCFqJBIOSu49s0WtZUr51Pf7p5mj
         EfpIqVSSHxI2fr5QZb9l3Dc6IXWnOH/XXpbJNkV3HYqoaS2rQ0aa2LwsesWCx4Z6/FT0
         8qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549417; x=1708154217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y97i1bM3fowwtIiLcqiCPU79flprtC3sB1VR0OaMOMQ=;
        b=uMl1kO3XzMJyKeVGxns6IFH3ePoieagHdE71BL2TAfbsOGPeXLpmpZ8l2NhcIJA0Z+
         krsRUzSw9FF7UCP6xe+trjyh+ucvJwAlUxNxs4ff+orzuxZDC1sBeGTYKWHt87LKSoiS
         +L26XGqh3KYv2vUCOeH+YvjzIkyFuUxTUYj6rFSMO9Z+VHjddXWsx+XX/zg8e6MG1frX
         uFrcl/Ci+dRdeWqsCbgdhi7m3Kqoph9sXU0dzhluJxRRAK03eR2X0Wfbp3M0bg0A2nvg
         HUFokKCiy3aILHbIhj26xdPUF2lDhsrSYx1u14hKxoqmNN8NoJHYXrxa2hNNTNHmTrIx
         MVGw==
X-Gm-Message-State: AOJu0YyjVS8cicyLvop+Ck+1kgTLKWaxsK8vQEGR1hO5O8NL6QH9eVOl
	lDYlKMrcwkI27/s1vXWSCJnoiFHz/Ygt1Zvf02p59LqT273Y2wRU3rb21gyjTFj75DiSyx39thM
	0WC8ki9ZdfTcw6FkPDtrLflndIfk=
X-Google-Smtp-Source: AGHT+IEWobhmE1/WwMHn6oX5ZN80IWRQNYjBDrldUZX4i4anOyMX2ZlYR3J04Gg+rJ599TivW5b2bCmN+cUc4fiu+Uk=
X-Received: by 2002:a17:906:35d9:b0:a38:a6a0:3c43 with SMTP id
 p25-20020a17090635d900b00a38a6a03c43mr886180ejb.50.1707549417181; Fri, 09 Feb
 2024 23:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-13-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:16:21 +0100
Message-ID: <CAP01T761B1+paMwrQesjX+zqFwQp8iUzLORueTjTLSHPbJ+0fQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> mmap() bpf_arena right after creation, since the kernel needs to
> remember the address returned from mmap. This is user_vm_start.
> LLVM will generate bpf_arena_cast_user() instructions where
> necessary and JIT will add upper 32-bit of user_vm_start
> to such pointers.
>
> Fix up bpf_map_mmap_sz() to compute mmap size as
> map->value_size * map->max_entries for arrays and
> PAGE_SIZE * map->max_entries for arena.
>
> Don't set BTF at arena creation time, since it doesn't support it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf_probes.c |  7 ++++++
>  2 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..4880d623098d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -185,6 +185,7 @@ static const char * const map_type_name[] = {
>         [BPF_MAP_TYPE_BLOOM_FILTER]             = "bloom_filter",
>         [BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
>         [BPF_MAP_TYPE_CGRP_STORAGE]             = "cgrp_storage",
> +       [BPF_MAP_TYPE_ARENA]                    = "arena",
>  };
>
>  static const char * const prog_type_name[] = {
> @@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
>         return map;
>  }
>
> -static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
> +static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
>  {
>         const long page_sz = sysconf(_SC_PAGE_SIZE);
>         size_t map_sz;
> @@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
>         return map_sz;
>  }
>
> +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> +{
> +       const long page_sz = sysconf(_SC_PAGE_SIZE);
> +
> +       switch (map->def.type) {
> +       case BPF_MAP_TYPE_ARRAY:
> +               return __bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
> +       case BPF_MAP_TYPE_ARENA:
> +               return page_sz * map->def.max_entries;
> +       default:
> +               return 0; /* not supported */
> +       }
> +}
> +
>  static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz)
>  {
>         void *mmaped;
> @@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>         pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
>                  map->name, map->sec_idx, map->sec_offset, def->map_flags);
>
> -       mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
> +       mmap_sz = bpf_map_mmap_sz(map);
>         map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         if (map->mmaped == MAP_FAILED) {
> @@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         case BPF_MAP_TYPE_SOCKHASH:
>         case BPF_MAP_TYPE_QUEUE:
>         case BPF_MAP_TYPE_STACK:
> +       case BPF_MAP_TYPE_ARENA:
>                 create_attr.btf_fd = 0;
>                 create_attr.btf_key_type_id = 0;
>                 create_attr.btf_value_type_id = 0;
> @@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         if (map->fd == map_fd)
>                 return 0;
>
> +       if (def->type == BPF_MAP_TYPE_ARENA) {
> +               map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
> +                                  PROT_READ | PROT_WRITE,
> +                                  map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
> +                                  map_fd, 0);
> +               if (map->mmaped == MAP_FAILED) {
> +                       err = -errno;
> +                       map->mmaped = NULL;
> +                       close(map_fd);
> +                       pr_warn("map '%s': failed to mmap bpf_arena: %d\n",
> +                               bpf_map__name(map), err);
> +                       return err;
> +               }
> +       }
> +

Would it be possible to introduce a public API accessor for getting
the value of map->mmaped?
Otherwise one would have to parse through /proc/self/maps in case
map_extra is 0.

The use case is to be able to use the arena as a backing store for
userspace malloc arenas, so that
we can pass through malloc/mallocx calls (or class specific operator
new) directly to malloc arena using the BPF arena.
In such a case a lot of the burden of converting existing data
structures or code can be avoided by making much of the process
transparent.
Userspace malloced objects can also be easily shared to BPF progs as a
pool through bpf_ma style per-CPU allocator.

> [...]

