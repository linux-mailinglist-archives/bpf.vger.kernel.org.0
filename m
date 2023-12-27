Return-Path: <bpf+bounces-18693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5681EF38
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F7C282736
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9C44C94;
	Wed, 27 Dec 2023 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz53ItIn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2744C83
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-427e7aa0207so5565191cf.2
        for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 05:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703684516; x=1704289316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGYkgO+v5dM4VLhHEOXOcJg+nv/40e6lm1iAJuP4cT4=;
        b=Nz53ItIny6nS8pqS8yFNakrGiZaTtcVG5YWSzx/vk9EGA//L6hn2ZwD5Ncc61EVKlJ
         V9tH9WpWhArMo3DZgFUt2pqFwB4dpq5WX9DPMzZ6PfU/bC4KmiU9KaclOAPrnxWOdfOg
         osxHSmGFkAJGef1OulNJfOGtTcz/vOXw6/4yRfSXYtC1JVDshGn3bYFp7zC4LDZmFqSE
         gmuicDY5Dex5m0FNAE8hIK/VyE/AHXxRLt8g0jiyFzXuyaFjq5Q0gWGkzZHRSVcIQAq+
         AjDL/LFKTXidrAUftSmoiMUviBKUyGTfjpjH9Yty2TaFnlluzWgz8Ja5ZKQpvdx0G7pa
         xe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703684516; x=1704289316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGYkgO+v5dM4VLhHEOXOcJg+nv/40e6lm1iAJuP4cT4=;
        b=C304g63zYVSOVaLhDOV/c7GJOidZGgnr7o56iTVBq3qZ8FzSMhj1fdoKAnEfzIqyNO
         Qg68kS48RF2xvhN1jjavV6U+BMfO2+nO+ZHg4WlAjflyW+8JCdoFzkPciIEjKUJTx4h4
         HBdohpSqADNEIHrmCpIesZmexGjr3oMQJSt3K16DUlbeOtItsnCHcqwWyzQux8iEyH2u
         /c92Xjkrdl0+NHVnr3lwdt8kSetPSfcYDfOENySa3ptvbmibMVouNYAq9X2wxyG8ia9/
         UUM4zgcJ5KkGkEfeOL3xAQfWFenB16Txqcpwgq6D74Q0IL2PpfYMz5tnxPUV1AgAXxDd
         bBGw==
X-Gm-Message-State: AOJu0YxYCwULAOVgo4PfDk7hqr8dPFfYQpeUnPHVaKkpMbXhUZbXBv2o
	eWuagSVo0EF3TBBAd+BSQQhW16y9BEAbsyR9zbc=
X-Google-Smtp-Source: AGHT+IHGf9I/zb8m9acOZ0iBcevkWCkj9WuY2fOazZahOGnEMUqAuUpqoj9T3gCqlLWRkb5leMi/vkMRg+BiwmcWR74=
X-Received: by 2002:a0c:dd10:0:b0:67f:bb8c:880b with SMTP id
 u16-20020a0cdd10000000b0067fbb8c880bmr7906956qvk.56.1703684515984; Wed, 27
 Dec 2023 05:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227100130.84501-1-lulie@linux.alibaba.com> <20231227100130.84501-2-lulie@linux.alibaba.com>
In-Reply-To: <20231227100130.84501-2-lulie@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 27 Dec 2023 21:41:19 +0800
Message-ID: <CALOAHbCocE7r4o4oGgQ+BeuSxf+-op9hnEYnq_7zdHf_VEf-LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: implement relay map basis
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	joannelkoong@gmail.com, kuifeng@meta.com, houtao@huaweicloud.com, 
	shung-hsi.yu@suse.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 6:01=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
> creates per-cpu buffer to transfer data. Each buffer is essentially a
> list of fix-sized sub-buffers, and is exposed to user space as files in
> debugfs. All of these compose a "relay chanel", which is the kernel of a
> relay map.
>
> Currently, attr->max_entries is used as subbuf size and attr->map_extra
> is used as subbuf num, and the default value of subbuf num is 8. A new
> map flag named BPF_F_OVERWRITE is also introduced to set overwrite mode
> of relay map.
>
> A relay map is represented as a directory in debugfs, and the per-cpu
> buffers are files in this directory. Users can get the data through read
> or mmap.
>
> To avoid directory name conflicting, relay_map_update_elem is provided
> to set the name. In fact, we create the relay channel and buffers with
> BPF_MAP_CREATE, and create relay files and bind them with the channel
> using BPF_MAP_UPDATE_ELEM. Generally, map_update_elem should be called
> once and only once.
>
> Here is an example:
> ```
> struct {
> __uint(type, BPF_MAP_TYPE_RELAY);
> __uint(max_entries, 4096);
> } my_relay SEC(".maps");
> ...
> char dir_name[] =3D "relay_test";
> bpf_map_update_elem(map_fd, NULL, dir_name, 0);
> ```
>
> Assume there are 2 cpus, we will have 2 files:
> ```
> /sys/kerenl/debug/relay_test/my_relay0
> /sys/kerenl/debug/relay_test/my_relay1
> ```

Is there a specific reason why relayfs necessitates creating an
individual file for each CPU? Alternatively, are there any approaches
available to collectively expose all CPUs using a single file?

When dealing with a large number of available CPUs, such as 236,
reading the buffer using the command `cat
/sys/kernel/debug/relay_test/my_relay{0...236} | awk '{}' ` can become
a bit cumbersome and tedious.

> Each represents a per-cpu buffer with size 8 * 4096 B (there are 8
> subbufs by default, each with size 4096B).
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  include/linux/bpf_types.h |   3 +
>  include/uapi/linux/bpf.h  |   7 ++
>  kernel/bpf/Makefile       |   3 +
>  kernel/bpf/relaymap.c     | 199 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c      |   2 +
>  5 files changed, 214 insertions(+)
>  create mode 100644 kernel/bpf/relaymap.c
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fc0d6f32c687..c122d7b494c5 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -132,6 +132,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_=
map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
> +#ifdef CONFIG_RELAY
> +BPF_MAP_TYPE(BPF_MAP_TYPE_RELAY, relay_map_ops)
> +#endif
>
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 754e68ca8744..143b75676bd3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -951,6 +951,7 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_BLOOM_FILTER,
>         BPF_MAP_TYPE_USER_RINGBUF,
>         BPF_MAP_TYPE_CGRP_STORAGE,
> +       BPF_MAP_TYPE_RELAY,
>  };
>
>  /* Note that tracing related programs such as
> @@ -1330,6 +1331,9 @@ enum {
>
>  /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
>         BPF_F_PATH_FD           =3D (1U << 14),
> +
> +/* Enable overwrite for relay map */
> +       BPF_F_OVERWRITE         =3D (1U << 15),
>  };
>
>  /* Flags for BPF_PROG_QUERY. */
> @@ -1401,6 +1405,9 @@ union bpf_attr {
>                  * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate=
 the
>                  * number of hash functions (if 0, the bloom filter will =
default
>                  * to using 5 hash functions).
> +                *
> +                * BPF_MAP_TYPE_RELAY - the lowest 32 bits indicate the n=
umber of
> +                * relay subbufs (if 0, the number will be set to 8 by de=
fault).
>                  */
>                 __u64   map_extra;
>         };
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index f526b7573e97..45b35bb0e572 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -10,6 +10,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o ino=
de.o helpers.o tnum.o log.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
> +ifeq ($(CONFIG_RELAY),y)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D relaymap.o
> +endif
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}    +=3D bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o mprog.o
> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
> new file mode 100644
> index 000000000000..02b33a8e6b6c
> --- /dev/null
> +++ b/kernel/bpf/relaymap.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/cpumask.h>
> +#include <linux/debugfs.h>
> +#include <linux/filter.h>
> +#include <linux/relay.h>
> +#include <linux/slab.h>
> +#include <linux/bpf.h>
> +#include <linux/err.h>
> +
> +#define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
> +
> +struct bpf_relay_map {
> +       struct bpf_map map;
> +       struct rchan *relay_chan;
> +       struct rchan_callbacks relay_cb;
> +};
> +
> +static struct dentry *create_buf_file_handler(const char *filename,
> +                                      struct dentry *parent, umode_t mod=
e,
> +                                      struct rchan_buf *buf, int *is_glo=
bal)
> +{
> +       /* Because we do relay_late_setup_files(), create_buf_file(NULL, =
NULL, ...)
> +        * will be called by relay_open.
> +        */
> +       if (!filename)
> +               return NULL;
> +
> +       return debugfs_create_file(filename, mode, parent, buf,
> +                                  &relay_file_operations);
> +}
> +
> +static int remove_buf_file_handler(struct dentry *dentry)
> +{
> +       debugfs_remove(dentry);
> +       return 0;
> +}
> +
> +/* For non-overwrite, use default subbuf_start cb */
> +static int subbuf_start_overwrite(struct rchan_buf *buf, void *subbuf,
> +                                      void *prev_subbuf, size_t prev_pad=
ding)
> +{
> +       return 1;
> +}
> +
> +/* bpf_attr is used as follows:
> + * - key size: must be 0
> + * - value size: value will be used as directory name by map_update_elem
> + *   (to create relay files). If passed as 0, it will be set to NAME_MAX=
 as
> + *   default
> + *
> + * - max_entries: subbuf size
> + * - map_extra: subbuf num, default as 8
> + *
> + * When alloc, we do not set up relay files considering dir_name conflic=
ts.
> + * Instead we use relay_late_setup_files() in map_update_elem(), and thu=
s the
> + * value is used as dir_name, and map->name is used as base_filename.
> + */
> +static struct bpf_map *relay_map_alloc(union bpf_attr *attr)
> +{
> +       struct bpf_relay_map *rmap;
> +
> +       if (unlikely(attr->map_flags & ~RELAY_CREATE_FLAG_MASK))
> +               return ERR_PTR(-EINVAL);
> +
> +       /* key size must be 0 in relay map */
> +       if (unlikely(attr->key_size))
> +               return ERR_PTR(-EINVAL);
> +
> +       /* value size is used as directory name length */
> +       if (unlikely(attr->value_size > NAME_MAX)) {
> +               pr_warn("value_size should be no more than %d\n", NAME_MA=
X);
> +               return ERR_PTR(-EINVAL);
> +       } else if (attr->value_size =3D=3D 0)
> +               attr->value_size =3D NAME_MAX;
> +
> +       /* set default subbuf num */
> +       if (unlikely(attr->map_extra & ~UINT_MAX))
> +               return ERR_PTR(-EINVAL);
> +       attr->map_extra =3D attr->map_extra & UINT_MAX;
> +       if (!attr->map_extra)
> +               attr->map_extra =3D 8;
> +
> +       if (strlen(attr->map_name) =3D=3D 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       rmap =3D bpf_map_area_alloc(sizeof(*rmap), NUMA_NO_NODE);
> +       if (!rmap)
> +               return ERR_PTR(-ENOMEM);
> +
> +       bpf_map_init_from_attr(&rmap->map, attr);
> +
> +       rmap->relay_cb.create_buf_file =3D create_buf_file_handler;
> +       rmap->relay_cb.remove_buf_file =3D remove_buf_file_handler;
> +       if (attr->map_flags & BPF_F_OVERWRITE)
> +               rmap->relay_cb.subbuf_start =3D subbuf_start_overwrite;
> +
> +       rmap->relay_chan =3D relay_open(NULL, NULL,
> +                               attr->max_entries, attr->map_extra,
> +                               &rmap->relay_cb, NULL);
> +       if (!rmap->relay_chan) {
> +               bpf_map_area_free(rmap);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return &rmap->map;
> +}
> +
> +static void relay_map_free(struct bpf_map *map)
> +{
> +       struct bpf_relay_map *rmap;
> +       struct dentry *parent;
> +
> +       rmap =3D container_of(map, struct bpf_relay_map, map);
> +
> +       parent =3D rmap->relay_chan->parent;
> +       relay_close(rmap->relay_chan);
> +       /* relay_chan->parent should be removed mannually if exists. */
> +       debugfs_remove_recursive(parent);
> +       bpf_map_area_free(rmap);
> +}
> +
> +static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static long relay_map_update_elem(struct bpf_map *map, void *key, void *=
value,
> +                                  u64 flags)
> +{
> +       struct bpf_relay_map *rmap;
> +       struct dentry *parent;
> +       int err;
> +
> +       if (unlikely(flags))
> +               return -EINVAL;
> +
> +       if (unlikely(key))
> +               return -EINVAL;
> +
> +       /* If the directory already exists, debugfs_create_dir will fail.=
 It could
> +        * have been created by map_update_elem before, or another system=
 that uses
> +        * debugfs.
> +        *
> +        * Note that the directory name passed as value should not be lon=
ger than
> +        * map->value_size, including the '\0' at the end.
> +        */
> +       ((char *)value)[map->value_size - 1] =3D '\0';
> +       parent =3D debugfs_create_dir(value, NULL);
> +       if (IS_ERR_OR_NULL(parent))
> +               return PTR_ERR(parent);
> +
> +       /* We don't need a lock here, because the relay channel is protec=
ted in
> +        * relay_late_setup_files() with a mutex.
> +        */
> +       rmap =3D container_of(map, struct bpf_relay_map, map);
> +       err =3D relay_late_setup_files(rmap->relay_chan, map->name, paren=
t);
> +       if (err) {
> +               debugfs_remove_recursive(parent);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static long relay_map_delete_elem(struct bpf_map *map, void *key)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int relay_map_get_next_key(struct bpf_map *map, void *key,
> +                                   void *next_key)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static u64 relay_map_mem_usage(const struct bpf_map *map)
> +{
> +       struct bpf_relay_map *rmap;
> +       u64 usage =3D sizeof(struct bpf_relay_map);
> +
> +       rmap =3D container_of(map, struct bpf_relay_map, map);
> +       usage +=3D sizeof(struct rchan);
> +       usage +=3D (sizeof(struct rchan_buf) + rmap->relay_chan->alloc_si=
ze)
> +                        * num_online_cpus();
> +       return usage;
> +}
> +
> +BTF_ID_LIST_SINGLE(relay_map_btf_ids, struct, bpf_relay_map)
> +const struct bpf_map_ops relay_map_ops =3D {
> +       .map_meta_equal =3D bpf_map_meta_equal,
> +       .map_alloc =3D relay_map_alloc,
> +       .map_free =3D relay_map_free,
> +       .map_lookup_elem =3D relay_map_lookup_elem,
> +       .map_update_elem =3D relay_map_update_elem,
> +       .map_delete_elem =3D relay_map_delete_elem,
> +       .map_get_next_key =3D relay_map_get_next_key,
> +       .map_mem_usage =3D relay_map_mem_usage,
> +       .map_btf_id =3D &relay_map_btf_ids[0],
> +};
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1bf9805ee185..d6b7949e29c7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1147,6 +1147,7 @@ static int map_create(union bpf_attr *attr)
>         }
>
>         if (attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER &&
> +           attr->map_type !=3D BPF_MAP_TYPE_RELAY &&
>             attr->map_extra !=3D 0)
>                 return -EINVAL;
>
> @@ -1202,6 +1203,7 @@ static int map_create(union bpf_attr *attr)
>         case BPF_MAP_TYPE_USER_RINGBUF:
>         case BPF_MAP_TYPE_CGROUP_STORAGE:
>         case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> +       case BPF_MAP_TYPE_RELAY:
>                 /* unprivileged */
>                 break;
>         case BPF_MAP_TYPE_SK_STORAGE:
> --
> 2.32.0.3.g01195cf9f
>


--=20
Regards
Yafang

