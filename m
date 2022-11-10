Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD06237E3
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 01:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKJADg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 19:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKJADg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 19:03:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC979FD2
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 16:03:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t25so997935ejb.8
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 16:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2MjMKhpXmde3pSyCTt8N2NXcrFWrA4nuYJU1lAuU8o=;
        b=giCsbZlvZJK091W8/m3awWT0h9FX/57LZ3huOEkZXOAgz/xrPP+38/tebcQR8BT/YJ
         UvxJLzn+nt3xdylXOAt0OAh0+OwbdzPv3fL4bjqZHVowteQnBJvbP9jpScG1nIBpjP4b
         CXZpduFUWunLLP2vdxJ55ev/rz122g3meOmTBqWDfcOIyORMwdnQeY03jyjPHLbZ8mjj
         PQy6YgWjuhdHLZjoC69zw5pPCW7BEevETZ3XDdkKYsUjtTqNwxGmXz4z/esb+Klczufk
         ToUEs0kzVmXrkawd8nSzoA2YaQPMs+v+w8U5uf90Zf9YYHeoA5xTins5qiKtlKdyvPtw
         BTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2MjMKhpXmde3pSyCTt8N2NXcrFWrA4nuYJU1lAuU8o=;
        b=SHX9TakZPKWqiegPK9aQu4tyFoHWDoTKHvTYzVrYx8afGQ5nioTC/m290ixlvVTetU
         BZagQ92BQyPqnNn6/ggBJAVeoAlbtRNQw0PmmfCc1BFsksQStvS4NWbXc7LNcX46Q5Ut
         YsUCWuipnwSx0kbRBPzW/JoYWuy3JxbX42PiFXUWxPirJTw0zDOkv8VV7812LRGY4Ofi
         Oos2sHF1JNMAtnFj9FZibRvEshPonZ512hKHsijd7U42Xb6uEYyHGmvWvS7RiONJHk5Z
         7LrvB55ctoDXpFAHUNMOsvzGvNubLtUFbgae2DU4CuWZMn7JatBT4dFUeivetqlYRaQA
         cQwQ==
X-Gm-Message-State: ACrzQf2+p6ZFnmeXgIExKGVJSny7Zu4ztnE1vWy/d86pNvfNE6oSeHZu
        A6Ofg/+hiU+tD3+Mk5xMx46C05+Plj4InUq4fto=
X-Google-Smtp-Source: AMsMyM6Pme1C4H2byCkt1kJg7wudhQ+YAOfHicsvzndqQGSFtH9IbYYjRWjWwfeAvs3c9h92QhM2o9bgzB2pTFCLzdQ=
X-Received: by 2002:a17:906:af6b:b0:7a9:ecc1:2bd2 with SMTP id
 os11-20020a170906af6b00b007a9ecc12bd2mr1977170ejb.545.1668038613605; Wed, 09
 Nov 2022 16:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20221109074427.141751-5-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221109074427.141751-5-sahid.ferdjaoui@industrialdiscipline.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 16:03:21 -0800
Message-ID: <CAEf4BzavzS5XNMiX8TTR63MPsVx=D5B4nbg=sYn7V8r-L8iszQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: clean-up usage of libbpf_get_error()
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 11:46 PM Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> bpftool is now totally compliant with libbpf 1.0 mode and is not
> expected to be compiled with pre-1.0, let's clean-up the usage of
> libbpf_get_error().
>
> In some places functions that are returning result of
> libbpf_get_error() will now return errno. This won't impact the
> functionality as the caller checks for 0/non-0 for success/failure.
>
> sidenode: We can remove the checks on NULL pointers before calling
> btf__free() because that function already does the check.
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> ---
>  tools/bpf/bpftool/btf.c        | 17 +++++++----------
>  tools/bpf/bpftool/btf_dumper.c |  2 +-
>  tools/bpf/bpftool/gen.c        | 11 ++++-------
>  tools/bpf/bpftool/iter.c       |  6 ++----
>  tools/bpf/bpftool/main.c       |  7 +++----
>  tools/bpf/bpftool/map.c        | 15 +++++++--------
>  tools/bpf/bpftool/prog.c       | 10 +++++-----
>  tools/bpf/bpftool/struct_ops.c | 15 +++++++--------
>  8 files changed, 36 insertions(+), 47 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 68a70ac03c80..ed39b24e39d2 100644
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
> +               return errno;

-errno

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
> +                     sysfs_vmlinux, errno);

to be exactly the same: -errno (errno is always positive, while
returned error is always negative)

>
>         return base;
>  }
> @@ -634,8 +631,8 @@ static int do_dump(int argc, char **argv)
>                         base = get_vmlinux_btf_from_sysfs();
>
>                 btf = btf__parse_split(*argv, base ?: base_btf);
> -               err = libbpf_get_error(btf);

you are removing setting err to actual value returned by libbpf. I
don't know if that matters, but it's certainly a change. Now on error
you'll always return -1. Please check if that has any unexpected
effect on calling code.

>                 if (!btf) {
> +                       err = errno;

-errno

>                         p_err("failed to load BTF from %s: %s",
>                               *argv, strerror(errno));
>                         goto done;
> @@ -681,8 +678,8 @@ static int do_dump(int argc, char **argv)
>                 }
>
>                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
> -               err = libbpf_get_error(btf);
>                 if (!btf) {
> +                       err = errno;

same

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
> index cf8b4e525c88..d00b4e1b99ba 100644
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
> +               return errno;

-errno

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

in this case doesn't matter, as libbpf_strerror drops the sign anyway

>                 p_err("failed to open BPF object file: %s", err_buf);
> -               obj = NULL;
>                 goto out;
>         }
>

[...]
