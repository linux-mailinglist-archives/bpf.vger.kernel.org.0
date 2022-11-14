Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF0628B97
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiKNVvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:51:36 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6012D34
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:51:35 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d7so5980889qkk.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6Q5/JPSBBWvo6+Gkj/fxw/rW/J7gv/Pi9m6mf17+TI=;
        b=yuyICg4HW2R9mBv3EkSy/ycA6vAFj+4D8vIrkBaJ7+WXRT/Wk2rNvT0NjonQACTRgL
         zfl8u4BRVyedjJC8fwOjOscXHOYHNSBCcM8Og7iV+BVMlL8L8oTsYMPYiAvTFKpkHkII
         7hSW6vxKM/ETVq/EIOR5FdnfONoRwUZvhis/cRMCWUYhZsihmCra/JyFPI6/Ob8xTg/4
         3bDg4+hgG/sAQK4E7f4lIGGPquc/HvhXDA2RjFgG0c86xe4aw5tLu82WezVQTTlXoq1n
         CSUUtaJbw+ql9iPrVLEsY/3QQfbVQ6tfwJFOWcqUoNDW99QfUTZVMpZcZcc+1Tz1XpJ7
         DewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6Q5/JPSBBWvo6+Gkj/fxw/rW/J7gv/Pi9m6mf17+TI=;
        b=QZQeW/wFaE9IUHD8YCsCH6zuu6me5MgrqvepTLtwq6D6vPv5ZuP2T5TsEb5tesH94w
         4Df1np4ANnzX4Ut7rvgN340PZ7+DoH3byLpnN8GUIXZHlQWlyVYvg12i5Z6AOqqNJ8U/
         6RIJg4o+l6mXJZaoAtTSVWSRZYkNkHY8n02ZJsrjnHZOlhJrw4aqB3IORvIjb87knFf1
         3ZDRAykLxncMEfut9YtXYfV9SjFjIf5eL6EdTUtDXCS1yTjAxe+lSwxUrS8Ujb650FCP
         ReY0NO2TspoIQpm2bVcs3DUyUV55dmBC7Xd1oBddQnp1QU5wyzAYUxXrJzY8NUT/kMyc
         mOVA==
X-Gm-Message-State: ANoB5pl7yBpCaq/Jzd0JadMHZK1KXYA9KHFX6Ru2fZPvVXjvRnJwBXIq
        HDrE5dynQ70L9tPkgeeYHrO9lAarLtqSbKYUKtUvXw==
X-Google-Smtp-Source: AA0mqf7a8kG1ofpy1vkuR9aCipr49/KJCDobO3xklR8h9TbNYGO7Nbw0NymJ+gOsLg2KQ66gM9JoEa86jSLGHi+Osj4=
X-Received: by 2002:a05:620a:4895:b0:6ce:2d77:92d0 with SMTP id
 ea21-20020a05620a489500b006ce2d7792d0mr13022192qkb.713.1668462694264; Mon, 14
 Nov 2022 13:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20221113101438.30910-5-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-5-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 21:51:23 +0000
Message-ID: <CACdoK4+7DUg+H0p-sPeM-FtpTbazk2JrGG+Cbu=BoPL9HfnuKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: clean-up usage of libbpf_get_error()
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 at 10:15, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> bpftool is now totally compliant with libbpf 1.0 mode and is not
> expected to be compiled with pre-1.0, let's clean-up the usage of
> libbpf_get_error().
>
> The changes stay aligned with returned errors always negative.
>
> - In tools/bpf/bpftool/btf.c This fixes an unintialized local variable
> `err` in function do_dump() because it may now be returned without
> having been set.
> - This also removes the checks on NULL pointers before calling
> btf__free() because that function already does the check.
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> ---
>  tools/bpf/bpftool/btf.c        | 19 ++++++++-----------
>  tools/bpf/bpftool/btf_dumper.c |  2 +-
>  tools/bpf/bpftool/gen.c        | 11 ++++-------
>  tools/bpf/bpftool/iter.c       |  6 ++----
>  tools/bpf/bpftool/main.c       |  7 +++----
>  tools/bpf/bpftool/map.c        | 15 +++++++--------
>  tools/bpf/bpftool/prog.c       | 10 +++++-----
>  tools/bpf/bpftool/struct_ops.c | 12 ++++++------
>  8 files changed, 36 insertions(+), 46 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index b87e4a7fd689..352290ba7b29 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -467,9 +467,8 @@ static int dump_btf_c(const struct btf *btf,
>         int err = 0, i;
>
>         d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> -       err = libbpf_get_error(d);
> -       if (err)
> -               return err;
> +       if (!d)
> +               return -errno;
>
>         printf("#ifndef __VMLINUX_H__\n");
>         printf("#define __VMLINUX_H__\n");
> @@ -512,11 +511,9 @@ static struct btf *get_vmlinux_btf_from_sysfs(void)
>         struct btf *base;
>
>         base = btf__parse(sysfs_vmlinux, NULL);
> -       if (libbpf_get_error(base)) {
> -               p_err("failed to parse vmlinux BTF at '%s': %ld\n",
> -                     sysfs_vmlinux, libbpf_get_error(base));
> -               base = NULL;
> -       }
> +       if (!base)
> +               p_err("failed to parse vmlinux BTF at '%s': %d\n",
> +                     sysfs_vmlinux, -errno);
>
>         return base;
>  }
> @@ -559,7 +556,7 @@ static int do_dump(int argc, char **argv)
>         __u32 btf_id = -1;
>         const char *src;
>         int fd = -1;
> -       int err;
> +       int err = 0;
>
>         if (!REQ_ARGS(2)) {
>                 usage();
> @@ -634,8 +631,8 @@ static int do_dump(int argc, char **argv)
>                         base = get_vmlinux_btf_from_sysfs();
>
>                 btf = btf__parse_split(*argv, base ?: base_btf);
> -               err = libbpf_get_error(btf);
>                 if (!btf) {
> +                       err = -errno;
>                         p_err("failed to load BTF from %s: %s",
>                               *argv, strerror(errno));
>                         goto done;
> @@ -681,8 +678,8 @@ static int do_dump(int argc, char **argv)
>                 }
>
>                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
> -               err = libbpf_get_error(btf);
>                 if (!btf) {
> +                       err = -errno;
>                         p_err("get btf by id (%u): %s", btf_id, strerror(errno));
>                         goto done;
>                 }
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 19924b6ce796..eda71fdfe95a 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -75,7 +75,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
>                 goto print;
>
>         prog_btf = btf__load_from_kernel_by_id(info.btf_id);
> -       if (libbpf_get_error(prog_btf))
> +       if (!prog_btf)
>                 goto print;
>         func_type = btf__type_by_id(prog_btf, finfo.type_id);
>         if (!func_type || !btf_is_func(func_type))
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 01bb8d8f5568..5c68b0983491 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -252,9 +252,8 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>         int err = 0;
>
>         d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
> -       err = libbpf_get_error(d);
> -       if (err)
> -               return err;
> +       if (!d)
> +               return -errno;
>
>         bpf_object__for_each_map(map, obj) {
>                 /* only generate definitions for memory-mapped internal maps */
> @@ -976,13 +975,11 @@ static int do_skeleton(int argc, char **argv)
>                 /* log_level1 + log_level2 + stats, but not stable UAPI */
>                 opts.kernel_log_level = 1 + 2 + 4;
>         obj = bpf_object__open_mem(obj_data, file_sz, &opts);
> -       err = libbpf_get_error(obj);
> -       if (err) {
> +       if (!obj) {
>                 char err_buf[256];
>
> -               libbpf_strerror(err, err_buf, sizeof(err_buf));
> +               libbpf_strerror(errno, err_buf, sizeof(err_buf));
>                 p_err("failed to open BPF object file: %s", err_buf);
> -               obj = NULL;
>                 goto out;
>         }
>
> diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
> index a3e6b167153d..ab6f1b2befe7 100644
> --- a/tools/bpf/bpftool/iter.c
> +++ b/tools/bpf/bpftool/iter.c
> @@ -48,8 +48,7 @@ static int do_pin(int argc, char **argv)
>         }
>
>         obj = bpf_object__open(objfile);
> -       err = libbpf_get_error(obj);
> -       if (err) {
> +       if (!obj) {

We could maybe set err to -errno here, so the function returns it
instead of the default -1 on error. Doesn't matter too much because
the return value is not used by the caller (other than to compare it
to 0), but it would be more consistent with the surrounding checks in
my opinion.

>                 p_err("can't open objfile %s", objfile);
>                 goto close_map_fd;
>         }
> @@ -67,8 +66,7 @@ static int do_pin(int argc, char **argv)
>         }
>
>         link = bpf_program__attach_iter(prog, &iter_opts);
> -       err = libbpf_get_error(link);
> -       if (err) {
> +       if (!link) {

Same

>                 p_err("attach_iter failed for program %s",
>                       bpf_program__name(prog));
>                 goto close_obj;
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 87ceafa4b9b8..da43ba596610 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -510,10 +510,9 @@ int main(int argc, char **argv)
>                         break;
>                 case 'B':
>                         base_btf = btf__parse(optarg, NULL);
> -                       if (libbpf_get_error(base_btf)) {
> -                               p_err("failed to parse base BTF at '%s': %ld\n",
> -                                     optarg, libbpf_get_error(base_btf));
> -                               base_btf = NULL;
> +                       if (!base_btf) {
> +                               p_err("failed to parse base BTF at '%s': %d\n",
> +                                     optarg, errno);

You fixed the errno -> -errno occurrences reported by Andrii, but you
have a few remaining: here...

>                                 return -1;
>                         }
>                         break;
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index d884070a2314..26d4022ec374 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -786,18 +786,18 @@ static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
>         if (info->btf_vmlinux_value_type_id) {
>                 if (!btf_vmlinux) {
>                         btf_vmlinux = libbpf_find_kernel_btf();
> -                       err = libbpf_get_error(btf_vmlinux);
> -                       if (err) {
> +                       if (!btf_vmlinux) {
>                                 p_err("failed to get kernel btf");
> -                               return err;
> +                               return errno;

... and here...

>                         }
>                 }
>                 *btf = btf_vmlinux;
>         } else if (info->btf_value_type_id) {
>                 *btf = btf__load_from_kernel_by_id(info->btf_id);
> -               err = libbpf_get_error(*btf);
> -               if (err)
> +               if (!*btf) {
> +                       err = errno;

... and here. Please double-check in case I missed some too.

>                         p_err("failed to get btf");
> +               }
>         } else {
>                 *btf = NULL;
>         }
> @@ -807,14 +807,13 @@ static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
>
>  static void free_map_kv_btf(struct btf *btf)
>  {
> -       if (!libbpf_get_error(btf) && btf != btf_vmlinux)
> +       if (btf != btf_vmlinux)
>                 btf__free(btf);
>  }
>
>  static void free_btf_vmlinux(void)
>  {
> -       if (!libbpf_get_error(btf_vmlinux))
> -               btf__free(btf_vmlinux);
> +       btf__free(btf_vmlinux);
>  }
>
>  static int
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 2266958f203f..cfc9fdc1e863 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -322,7 +322,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
>                 return;
>
>         btf = btf__load_from_kernel_by_id(map_info.btf_id);
> -       if (libbpf_get_error(btf))
> +       if (!btf)
>                 goto out_free;
>
>         t_datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
> @@ -726,7 +726,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>
>         if (info->btf_id) {
>                 btf = btf__load_from_kernel_by_id(info->btf_id);
> -               if (libbpf_get_error(btf)) {
> +               if (!btf) {
>                         p_err("failed to get btf");
>                         return -1;
>                 }
> @@ -1663,7 +1663,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>                 open_opts.kernel_log_level = 1 + 2 + 4;
>
>         obj = bpf_object__open_file(file, &open_opts);
> -       if (libbpf_get_error(obj)) {
> +       if (!obj) {
>                 p_err("failed to open object file");
>                 goto err_free_reuse_maps;
>         }
> @@ -1882,7 +1882,7 @@ static int do_loader(int argc, char **argv)
>                 open_opts.kernel_log_level = 1 + 2 + 4;
>
>         obj = bpf_object__open_file(file, &open_opts);
> -       if (libbpf_get_error(obj)) {
> +       if (!obj) {
>                 p_err("failed to open object file");
>                 goto err_close_obj;
>         }
> @@ -2199,7 +2199,7 @@ static char *profile_target_name(int tgt_fd)
>         }
>
>         btf = btf__load_from_kernel_by_id(info.btf_id);
> -       if (libbpf_get_error(btf)) {
> +       if (!btf) {
>                 p_err("failed to load btf for prog FD %d", tgt_fd);
>                 goto out;
>         }
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index a6c6d5b9551e..903b80ff4e9a 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -32,7 +32,7 @@ static const struct btf *get_btf_vmlinux(void)
>                 return btf_vmlinux;
>
>         btf_vmlinux = libbpf_find_kernel_btf();
> -       if (libbpf_get_error(btf_vmlinux))
> +       if (!btf_vmlinux)
>                 p_err("struct_ops requires kernel CONFIG_DEBUG_INFO_BTF=y");
>
>         return btf_vmlinux;
> @@ -45,7 +45,7 @@ static const char *get_kern_struct_ops_name(const struct bpf_map_info *info)
>         const char *st_ops_name;
>
>         kern_btf = get_btf_vmlinux();
> -       if (libbpf_get_error(kern_btf))
> +       if (!kern_btf)
>                 return "<btf_vmlinux_not_found>";
>
>         t = btf__type_by_id(kern_btf, info->btf_vmlinux_value_type_id);
> @@ -62,6 +62,7 @@ static __s32 get_map_info_type_id(void)
>         if (map_info_type_id)
>                 return map_info_type_id;
>
> +       kern_btf = get_btf_vmlinux();

Looks like that line you removed by mistake in a previous patch?

>         if (!kern_btf)
>                 return 0;
>
> @@ -412,7 +413,7 @@ static int do_dump(int argc, char **argv)
>         }
>
>         kern_btf = get_btf_vmlinux();
> -       if (libbpf_get_error(kern_btf))
> +       if (!kern_btf)
>                 return -1;
>
>         if (!json_output) {
> @@ -495,7 +496,7 @@ static int do_register(int argc, char **argv)
>                 open_opts.kernel_log_level = 1 + 2 + 4;
>
>         obj = bpf_object__open_file(file, &open_opts);
> -       if (libbpf_get_error(obj))
> +       if (!obj)
>                 return -1;
>
>         set_max_rlimit();
> @@ -589,8 +590,7 @@ int do_struct_ops(int argc, char **argv)
>
>         err = cmd_select(cmds, argc, argv, do_help);
>
> -       if (!libbpf_get_error(btf_vmlinux))
> -               btf__free(btf_vmlinux);
> +       btf__free(btf_vmlinux);
>
>         return err;
>  }
> --
> 2.34.1
>
>
