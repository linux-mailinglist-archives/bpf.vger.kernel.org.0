Return-Path: <bpf+bounces-60092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C5AD28D1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908DF3AE110
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99185221268;
	Mon,  9 Jun 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr5kjU2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8D78F36;
	Mon,  9 Jun 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504652; cv=none; b=jrldZ5OdCDBiZnvmsRbPb/GRUO+DW0+ym76A+G5JeMZ10IeTC7H6Z2/zBBDQ9DKms/Mq86QJGfR1DJctjkAg5iTiDZLm2BIUqgrOTq2impQE/U3XGh/oeyghkynBh1m0sRSbMKmB6XJrL0EL9q5r6v6w5BHj9s9PVor0o5t5P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504652; c=relaxed/simple;
	bh=6UBDdIdaKnmynnAlRMhTp7pTBkCZ/gZILVaMSvFz+EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP3085QJUJMew8GGn6BtrE8wqoox5M+rVQH7FC6EX6LTcXW+hpzJZKJm7YIeOLc04mZ2HlmulvTJt2G3HLsLQlMzOZevI25qNEp2WnLI76C4FH66YFn/9FRrJRP63nb4zzDPbdxCy7o2tuj7W8EXnQ3Rx32TGPcxVvCYhml3HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr5kjU2N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a463so1016746f8f.1;
        Mon, 09 Jun 2025 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749504645; x=1750109445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZY7V+hZt5gMdEzCXiSSGg6wioL2A0LXqimLY6DtSqM=;
        b=Kr5kjU2N1taPeC30vquPNCBGZ7MLAJinFr2fuktxq90nkbhLUbiWDRgrCw9PDTWIoz
         01kyy7aXaNmIwN0pUUChuW8/Nlf6mBHi4fe4Vt2jIfjlCfPYY+EGrqvW2/r+3WMNt79s
         jjH5XKPntEvxhkdJPZ3tFq6TTQ3t+ri3Gh0mC1ffZVQ5YovL9lPZJUanXlZYjLe40C0m
         YpBCAW5TRqBcKeXxqAeZ+ONaIKPjmmznVAWmpj3hcZpnBwrRvB1pRs6Xds/iWFX13ZdE
         dzu0rHT/TsdrW1MSEZPSoLuzqlGXILw1MOUXYTg2Va70KHhzy1AnIQ6KILha8NUxLYuu
         7wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749504645; x=1750109445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZY7V+hZt5gMdEzCXiSSGg6wioL2A0LXqimLY6DtSqM=;
        b=enRgmQBwP31UYOQRIU8s8CXaiVxMzatFeOzMD0slBL0tj6V99/LqypyABtEKgN0SFD
         x/qGt5IYrr3PGwXSWQJJC85Mp9PZPCNchu3ulFu8ey8ajr2N1DBrkKMYnvzAI6FbMiRU
         M+DJCVu1IRrcmIaQ4Mm4MV/gjL25zPY6I7NRKwgJeSf+1ZS1AHbfgUYFrdPE3qUMPgPq
         aaHALQHIfMBEr2HIQZ5S5ojlSqATCdcFcX+5lQeeglJe4MX7/GC3Q6VsEpwwVjVJfMOU
         jYpL4Tf+FmEUpTDh+TkJ3hi9z4iCm7nPxe+D4Euq5D6kt7Em4C8A71O0X1u84zL6nAuT
         rbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXNZy01R2uydgr5P+BUhvn0Erd+j9AwykNUvjK7eZiXAy/lEZX/FfblAOrH7x3hNbCSXKTXwYZCnuZbN4k9HXPS7qsoLjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTR4QVjYr17MqxciluMOHpDImjImBzJZVY7lyPsAXmUwoZpa7
	NYG94PfZzZ7CRizL9d7Mjr5nHuuV9P0svMKtuPRyV+ovCDAMbh9/OFiWT6fO1Gv+XJhd+BO6Bm9
	F6+aZkFm3rR0UO+0u9FWtntP5HGatfM4=
X-Gm-Gg: ASbGncvpmM5EW7holSN23yKTdhLBzyrCM5t4kZojtbPfXJUisGUUo8omy1K85hwjyRE
	zidFlUVbx0F0e8yp4HMLsa/jTQICddkzzv8drkOOg/ec2SUtW5dhDflgrCK+A8p3OeKEiU+YP7p
	fq0CRR2u1NAm3KipCnAiMsu6hH/JrlUNZpqH3/ZNewNKsDrbMXwt6H9XNC+G+cPO4S7pQw3eAj
X-Google-Smtp-Source: AGHT+IFK18My9cQZM5IIKr+elau4o/IsVw9JKlKPucYoi21VTgFngdGAD84ds7QuXCMmgZXQ3tugOuQohYmddcyF9zk=
X-Received: by 2002:adf:cb13:0:b0:3a3:76d8:67a7 with SMTP id
 ffacd0b85a97d-3a55140272emr679726f8f.20.1749504644748; Mon, 09 Jun 2025
 14:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-8-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-8-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 14:30:32 -0700
X-Gm-Features: AX0GCFtoELspodLOETL-o3GPJNTTUxm8JPpUNmh2adWAr1k5EECQZGJ4jeSGKKc
Message-ID: <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Currently only array maps are supported, but the implementation can be
> extended for other maps and objects. The hash is memoized only for
> exclusive and frozen maps as their content is stable until the exclusive
> program modifies the map.
>
> This is required  for BPF signing, enabling a trusted loader program to
> verify a map's integrity. The loader retrieves
> the map's runtime hash from the kernel and compares it against an
> expected hash computed at build time.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h            |  3 +++
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/arraymap.c          | 13 ++++++++++++
>  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  2 ++
>  5 files changed, 58 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cb1bea99702a..35f1a633d87a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -7,6 +7,7 @@
>  #include <uapi/linux/bpf.h>
>  #include <uapi/linux/filter.h>
>
> +#include <crypto/sha2.h>
>  #include <linux/workqueue.h>
>  #include <linux/file.h>
>  #include <linux/percpu.h>
> @@ -110,6 +111,7 @@ struct bpf_map_ops {
>         long (*map_pop_elem)(struct bpf_map *map, void *value);
>         long (*map_peek_elem)(struct bpf_map *map, void *value);
>         void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u=
32 cpu);
> +       int (*map_get_hash)(struct bpf_map *map, u32 hash_buf_size, void =
*hash_buf);
>
>         /* funcs called by prog_array and perf_event_array map */
>         void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_fil=
e,
> @@ -262,6 +264,7 @@ struct bpf_list_node_kern {
>  } __attribute__((aligned(8)));
>
>  struct bpf_map {
> +       u8 sha[SHA256_DIGEST_SIZE];
>         const struct bpf_map_ops *ops;
>         struct bpf_map *inner_map_meta;
>  #ifdef CONFIG_SECURITY
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6f2f4f3b3822..ffd9e11befc2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6630,6 +6630,8 @@ struct bpf_map_info {
>         __u32 btf_value_type_id;
>         __u32 btf_vmlinux_id;
>         __u64 map_extra;
> +       __aligned_u64 hash;
> +       __u32 hash_size;
>  } __attribute__((aligned(8)));
>
>  struct bpf_btf_info {
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 8719aa821b63..1fb989db03a2 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -12,6 +12,7 @@
>  #include <uapi/linux/btf.h>
>  #include <linux/rcupdate_trace.h>
>  #include <linux/btf_ids.h>
> +#include <crypto/sha256_base.h>
>
>  #include "map_in_map.h"
>
> @@ -174,6 +175,17 @@ static void *array_map_lookup_elem(struct bpf_map *m=
ap, void *key)
>         return array->value + (u64)array->elem_size * (index & array->ind=
ex_mask);
>  }
>
> +static int array_map_get_hash(struct bpf_map *map, u32 hash_buf_size,
> +                              void *hash_buf)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +
> +       bpf_sha256(array->value, (u64)array->elem_size * array->map.max_e=
ntries,
> +              hash_buf);
> +       memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
> +       return 0;
> +}
> +
>  static int array_map_direct_value_addr(const struct bpf_map *map, u64 *i=
mm,
>                                        u32 off)
>  {
> @@ -805,6 +817,7 @@ const struct bpf_map_ops array_map_ops =3D {
>         .map_mem_usage =3D array_map_mem_usage,
>         .map_btf_id =3D &array_map_btf_ids[0],
>         .iter_seq_info =3D &iter_seq_info,
> +       .map_get_hash =3D &array_map_get_hash,
>  };
>
>  const struct bpf_map_ops percpu_array_map_ops =3D {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index bef9edcfdb76..c81be07fa4fa 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
>   */
> +#include <crypto/sha2.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf-cgroup.h>
>  #include <linux/bpf_trace.h>
> @@ -5027,6 +5028,9 @@ static int bpf_map_get_info_by_fd(struct file *file=
,
>         info_len =3D min_t(u32, sizeof(info), info_len);
>
>         memset(&info, 0, sizeof(info));
> +       if (copy_from_user(&info, uinfo, info_len))
> +               return -EFAULT;
> +
>         info.type =3D map->map_type;
>         info.id =3D map->id;
>         info.key_size =3D map->key_size;
> @@ -5051,6 +5055,40 @@ static int bpf_map_get_info_by_fd(struct file *fil=
e,
>                         return err;
>         }
>
> +       if (map->ops->map_get_hash && map->frozen && map->excl_prog_sha) =
{
> +               err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, &=
map->sha);

& in &map->sha looks suspicious. Should be just map->sha ?

> +               if (err !=3D 0)
> +                       return err;
> +       }
> +
> +       if (info.hash) {
> +               char __user *uhash =3D u64_to_user_ptr(info.hash);
> +
> +               if (!map->ops->map_get_hash)
> +                       return -EINVAL;
> +
> +               if (info.hash_size < SHA256_DIGEST_SIZE)

Similar to prog let's =3D=3D here?

> +                       return -EINVAL;
> +
> +               info.hash_size  =3D SHA256_DIGEST_SIZE;
> +
> +               if (map->excl_prog_sha && map->frozen) {
> +                       if (copy_to_user(uhash, map->sha, SHA256_DIGEST_S=
IZE) !=3D
> +                           0)
> +                               return -EFAULT;

I would drop above and keep below part only.

> +               } else {
> +                       u8 sha[SHA256_DIGEST_SIZE];
> +
> +                       err =3D map->ops->map_get_hash(map, SHA256_DIGEST=
_SIZE,
> +                                                    sha);

Here the kernel can write into map->sha and then copy it to uhash.
I think the concern was to disallow 2nd map_get_hash on exclusive
and frozen map, right?
But I think that won't be an issue for signed lskel loader.
Since the map is frozen the user space cannot modify it.
Since the map is exclusive another bpf prog cannot modify it.
If user space calls map_get_hash 2nd time the sha will be
exactly the same until loader prog writes into the map.
So I see no harm generalizing this bit of code.
I don't have a particular use case in mind,
but it seems fine to allow user space to recompute sha
of exclusive and frozen map.
The loader will check the sha of its map as the very first operation,
so if user space did two map_get_hash() it just wasted cpu cycles.
If user space is calling map_get_hash() while loader prog
reads and writes into it the map->sha will change, but
it doesn't matter to the loader program anymore.

Also I wouldn't special case the !info.hash case for exclusive maps.
It seems cleaner to waste few bytes on stack in
skel_obj_get_info_by_fd() later in patch 9.
Let it point to valid u8 sha[] on stack.
The skel won't use it, but this way we can kernel behavior
consistent.
if info.hash !=3D NULL -> compute sha, update map->sha, copy to user space.

