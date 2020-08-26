Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC72525F8
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 06:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgHZECs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 00:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHZECq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 00:02:46 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D0C061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 21:02:45 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 189so3290ybw.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZpnU1z9qESVHzXkRVcKdL5J3m9eil3Drh9ILsoAI+w=;
        b=c6BNLsl6ZwVL6gis8yVz+vlJqvQwXnxdxu/MZTnRQm5VMretEQm4LpE42ohknwgFGy
         sErOdP+p/elzBn5H/kldkdDAZUKdgrwN2jRQ4u6hWo3/XgGi1fxDkHzLYVFftK9qYpG4
         6bH/MGcqoEAj9gCnZwJmk2py6T97sfDbKnWpSMhBOwVpund5TiM3tFFudYWYMD/XTLVR
         T/6YvKi1XpOgAA7d3xopCapXAyJ9MQCNug8y+rVFzuNV4U8l6WvKVwGFaeOUuyjIHl4I
         2J9z1oyUzdBHsM8Lph4rjRZsHyGXwkvmyiZc1/oQ0qo6v3OYzvEU+qSr6R+wdPvt8hAT
         G3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZpnU1z9qESVHzXkRVcKdL5J3m9eil3Drh9ILsoAI+w=;
        b=r54C0uSFdLYL/LdDHlhNqB+yTn2fr6Ay0pxHlFSuAtGtDBgEV15vmDOgIJm+eq20O6
         qPrKQx102h1lYNtZLz1mmjgHLvlkiSVEYn5guzWA5q66+Iy7SoiZESPdikAbqr7bh4yo
         mSaf0cDCJMG8lI0xKTvLPKzXPh1B/z5h9B1M0Ro7f6+3b1yf9bVzffo2TYObWHnvaOM9
         sIhl9SZNTTRY+CRXhavW3atRadE94qQ79prxwTAQNyFZ/sSfn0HgCfn7P+h2ba74uq6C
         07mx2OG1mbX1WbbMUGqYeN6T25UEvU7INum1QR40+wveq2lFGwTejhNRszNjcoeiCwlI
         Q22A==
X-Gm-Message-State: AOAM532bb7anA4HeAQFDCH0YRcN6JIxSP07JnDiWop3/Fx7uNq7W7xgO
        JR/1uDYdPfFJKuKSHsyW7xX4dXiNwOwg6eJA5xg=
X-Google-Smtp-Source: ABdhPJzWKxb/PhuQN/eVuYWPtTBF0MZ1nsfr5MzeJyk+h4leQOPhyAyOOsbhlXRusvOL49C4QeI6IkPx43V4YSuGvUE=
X-Received: by 2002:a5b:44d:: with SMTP id s13mr19295343ybp.403.1598414564749;
 Tue, 25 Aug 2020 21:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
In-Reply-To: <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Aug 2020 21:02:33 -0700
Message-ID: <CAEf4BzYkCsuB1nB9A69EREkuY66+s9C1jvLtnO01C+PVBYAiLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and
 use it on .metadata section
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 2:43 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> The patch adds a simple wrapper bpf_prog_bind_map around the syscall.
> And when using libbpf to load a program, it will probe the kernel for
> the support of this syscall, and scan for the .metadata ELF section
> and load it as an internal map like a .data section.
>
> In the case that kernel supports the BPF_PROG_BIND_MAP syscall and
> a .metadata section exists, the map will be explicitly bound to
> the program via the syscall immediately after program is loaded.
> -EEXIST is ignored for this syscall.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  tools/lib/bpf/bpf.c      |  11 +++++
>  tools/lib/bpf/bpf.h      |   1 +
>  tools/lib/bpf/libbpf.c   | 100 ++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.map |   1 +
>  4 files changed, 112 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 82b983ff6569..383b29ecb1fd 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -872,3 +872,14 @@ int bpf_enable_stats(enum bpf_stats_type type)
>
>         return sys_bpf(BPF_ENABLE_STATS, &attr, sizeof(attr));
>  }
> +
> +int bpf_prog_bind_map(int prog_fd, int map_fd, int flags)
> +{
> +       union bpf_attr attr = {};


use explicit memset() to avoid potential issues with uninitialized paddings

> +
> +       attr.prog_bind_map.prog_fd = prog_fd;
> +       attr.prog_bind_map.map_fd = map_fd;
> +       attr.prog_bind_map.flags = flags;
> +
> +       return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 015d13f25fcc..32994a4e0bf6 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -243,6 +243,7 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
>  enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
>  LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
>
> +LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd, int flags);
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 77d420c02094..4725859099c5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -174,6 +174,8 @@ enum kern_feature_id {
>         FEAT_EXP_ATTACH_TYPE,
>         /* bpf_probe_read_{kernel,user}[_str] helpers */
>         FEAT_PROBE_READ_KERN,
> +       /* bpf_prog_bind_map helper */

not helper, see below

> +       FEAT_PROG_BIND_MAP,
>         __FEAT_CNT,
>  };
>
> @@ -283,6 +285,7 @@ struct bpf_struct_ops {
>  #define KCONFIG_SEC ".kconfig"
>  #define KSYMS_SEC ".ksyms"
>  #define STRUCT_OPS_SEC ".struct_ops"
> +#define METADATA_SEC ".metadata"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -290,6 +293,7 @@ enum libbpf_map_type {
>         LIBBPF_MAP_BSS,
>         LIBBPF_MAP_RODATA,
>         LIBBPF_MAP_KCONFIG,
> +       LIBBPF_MAP_METADATA,
>  };
>
>  static const char * const libbpf_type_to_btf_name[] = {
> @@ -297,6 +301,7 @@ static const char * const libbpf_type_to_btf_name[] = {
>         [LIBBPF_MAP_BSS]        = BSS_SEC,
>         [LIBBPF_MAP_RODATA]     = RODATA_SEC,
>         [LIBBPF_MAP_KCONFIG]    = KCONFIG_SEC,
> +       [LIBBPF_MAP_METADATA]   = METADATA_SEC,
>  };
>
>  struct bpf_map {
> @@ -375,6 +380,8 @@ struct bpf_object {
>         size_t nr_maps;
>         size_t maps_cap;
>
> +       struct bpf_map *metadata_map;
> +
>         char *kconfig;
>         struct extern_desc *externs;
>         int nr_extern;
> @@ -398,6 +405,7 @@ struct bpf_object {
>                 Elf_Data *rodata;
>                 Elf_Data *bss;
>                 Elf_Data *st_ops_data;
> +               Elf_Data *metadata;
>                 size_t strtabidx;
>                 struct {
>                         GElf_Shdr shdr;
> @@ -413,6 +421,7 @@ struct bpf_object {
>                 int rodata_shndx;
>                 int bss_shndx;
>                 int st_ops_shndx;
> +               int metadata_shndx;
>         } efile;
>         /*
>          * All loaded bpf_object is linked in a list, which is
> @@ -1022,6 +1031,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>         obj->efile.obj_buf_sz = obj_buf_sz;
>         obj->efile.maps_shndx = -1;
>         obj->efile.btf_maps_shndx = -1;
> +       obj->efile.metadata_shndx = -1;
>         obj->efile.data_shndx = -1;
>         obj->efile.rodata_shndx = -1;
>         obj->efile.bss_shndx = -1;
> @@ -1387,6 +1397,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>         if (data)
>                 memcpy(map->mmaped, data, data_sz);
>
> +       if (type == LIBBPF_MAP_METADATA)
> +               obj->metadata_map = map;

Let's keep the approach consistent with other special maps. See how
it's done for Kconfig with kconfig_map_idx.

> +
>         pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>         return 0;
>  }
> @@ -1422,6 +1435,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>                 if (err)
>                         return err;
>         }
> +       if (obj->efile.metadata_shndx >= 0) {
> +               err = bpf_object__init_internal_map(obj, LIBBPF_MAP_METADATA,
> +                                                   obj->efile.metadata_shndx,
> +                                                   obj->efile.metadata->d_buf,
> +                                                   obj->efile.metadata->d_size);
> +               if (err)
> +                       return err;
> +       }
>         return 0;
>  }
>
> @@ -2698,6 +2719,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>                         } else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
>                                 obj->efile.st_ops_data = data;
>                                 obj->efile.st_ops_shndx = idx;
> +                       } else if (strcmp(name, METADATA_SEC) == 0) {
> +                               obj->efile.metadata = data;
> +                               obj->efile.metadata_shndx = idx;
>                         } else {
>                                 pr_debug("skip section(%d) %s\n", idx, name);
>                         }
> @@ -3111,7 +3135,8 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
>  {
>         return shndx == obj->efile.data_shndx ||
>                shndx == obj->efile.bss_shndx ||
> -              shndx == obj->efile.rodata_shndx;
> +              shndx == obj->efile.rodata_shndx ||
> +              shndx == obj->efile.metadata_shndx;
>  }
>
>  static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
> @@ -3132,6 +3157,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
>                 return LIBBPF_MAP_RODATA;
>         else if (shndx == obj->efile.symbols_shndx)
>                 return LIBBPF_MAP_KCONFIG;
> +       else if (shndx == obj->efile.metadata_shndx)
> +               return LIBBPF_MAP_METADATA;
>         else
>                 return LIBBPF_MAP_UNSPEC;
>  }
> @@ -3655,6 +3682,60 @@ static int probe_kern_probe_read_kernel(void)
>         return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
>  }
>
> +static int probe_prog_bind_map(void)
> +{
> +       struct bpf_load_program_attr prog_attr;
> +       struct bpf_create_map_attr map_attr;
> +       char *cp, errmsg[STRERR_BUFSIZE];
> +       struct bpf_insn insns[] = {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       int ret = 0, prog, map;
> +
> +       if (!kernel_supports(FEAT_GLOBAL_DATA))
> +               return 0;
> +
> +       memset(&map_attr, 0, sizeof(map_attr));
> +       map_attr.map_type = BPF_MAP_TYPE_ARRAY;
> +       map_attr.key_size = sizeof(int);
> +       map_attr.value_size = 32;
> +       map_attr.max_entries = 1;
> +
> +       map = bpf_create_map_xattr(&map_attr);
> +       if (map < 0) {
> +               ret = -errno;
> +               cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> +               pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
> +                       __func__, cp, -ret);

don't log here, it's already logged by few more basic feature checks

> +               return ret;
> +       }
> +
> +       memset(&prog_attr, 0, sizeof(prog_attr));
> +       prog_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> +       prog_attr.insns = insns;
> +       prog_attr.insns_cnt = ARRAY_SIZE(insns);
> +       prog_attr.license = "GPL";
> +
> +       prog = bpf_load_program_xattr(&prog_attr, NULL, 0);
> +       if (prog < 0) {
> +               ret = -errno;
> +               cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> +               pr_warn("Error in %s():%s(%d). Couldn't create simple program.\n",
> +                       __func__, cp, -ret);
> +

same, no need for logging

> +               close(map);
> +               return ret;
> +       }
> +
> +       if (!bpf_prog_bind_map(prog, map, 0))
> +               ret = 1;
> +
> +       close(map);
> +       close(prog);
> +       return ret;
> +}
> +
>  enum kern_feature_result {
>         FEAT_UNKNOWN = 0,
>         FEAT_SUPPORTED = 1,
> @@ -3695,6 +3776,9 @@ static struct kern_feature_desc {
>         },
>         [FEAT_PROBE_READ_KERN] = {
>                 "bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
> +       },
> +       [FEAT_PROG_BIND_MAP] = {
> +               "bpf_prog_bind_map() helper", probe_prog_bind_map,

it's not a helper, it's bpf() syscall command (BPF_PROG_BIND_MAP,
right?), so "BPF_PROG_BIND_MAP support" would probably be an ok short
description.

>         }
>  };
>
> @@ -5954,6 +6038,20 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
>         if (ret >= 0) {
>                 if (log_buf && load_attr.log_level)
>                         pr_debug("verifier log:\n%s", log_buf);
> +
> +               if (prog->obj->metadata_map && kernel_supports(FEAT_PROG_BIND_MAP)) {
> +                       if (bpf_prog_bind_map(ret, bpf_map__fd(prog->obj->metadata_map), 0) &&
> +                           errno != EEXIST) {
> +                               int fd = ret;
> +
> +                               ret = -errno;
> +                               cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> +                               pr_warn("add metadata map failed: %s\n", cp);

please use error message consistent with most libbpf code, something
like this should be enough:

pr_warn("prog '%s': failed to bind .metadata map: %d\n", prog->name, ret);

> +                               close(fd);

Do we really want to fail loading the program because we failed to
attach .metadata? Surely feature detection should ensure that this
doesn't fail, but stil...


> +                               goto out;
> +                       }
> +               }
> +
>                 *pfd = ret;
>                 ret = 0;
>                 goto out;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index e35bd6cdbdbf..4baf18a6df69 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -288,6 +288,7 @@ LIBBPF_0.1.0 {
>                 bpf_map__set_value_size;
>                 bpf_map__type;
>                 bpf_map__value_size;
> +               bpf_prog_bind_map;
>                 bpf_program__attach_xdp;
>                 bpf_program__autoload;
>                 bpf_program__is_sk_lookup;
> --
> 2.28.0
>
