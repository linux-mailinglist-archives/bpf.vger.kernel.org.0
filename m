Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A626A23A5
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBXVTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBXVTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 16:19:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F162525E
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 13:19:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ck15so2748507edb.0
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 13:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9GDlaunD+WPHW0Vp/dpwDcMU7PqNRAtmD+RyJm7jRk=;
        b=gejwYVTvN+gJpBal7w9fD9FomXC64oXdGI8Gn2NuCD7C/QVY1uQHEazg4nEzAA/R3F
         jueF4eJRauSBhuswkz65s6gHMR09eIQqGxgncALF6Sl+ghhPfFZX4EyPbwlNzdnY9BPi
         egV29q5zzw0o+VRM6lBI+/J1oCmhoB6sKC+cUAFbjuzLpLK8PlWYC/PFONIs4mZ1Fc5c
         ZCzMDCeXY7JkuXtn1CYk+iKw6+pu89C0vaqVcwHVVMJpfuH/RabvVXWGCKVsqXXQPk8B
         S7CsoEs20munzzSi9oussVUW5/kZ5H9SvWb4DFgyA7Sg8Dbap6Y7ghe60tA23vk/yD0E
         xOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9GDlaunD+WPHW0Vp/dpwDcMU7PqNRAtmD+RyJm7jRk=;
        b=f2TwqHFRI7M8aGLZaTZjTSmZ59uPAv+hqn2Fiw3kMTajr5UpjkX39O89E3rgrrUC09
         hz32/G0semQM7dRBcBhk+exU9STedjIiczdX7j18VAuzjdVGD0NJQFx9mIqv6veLMjv9
         2ljFXHXbzAJH/jWv+drvDcYF3+vmvlXck8iGq9jqNdR19VZyuVMIhTM3ToGzQIb1kw3y
         sZ74xydb6WpyEbKL/WHUbUceZG7CgZTcXcZa6OM6cUlW1I2Nrbbm4WeY103hSeBEEut6
         dpIMu+6A7UKUnAcal9mcfeMP36992Crz0doeff8oBvmr2zS8GwL5jj1npIk8k9kiCEeb
         MhFg==
X-Gm-Message-State: AO0yUKV343rTgpMYXOhPbw5vkaHWTaX/bxDdSZz7Wtd0zc+O/I+Xpsln
        rwOKfEBPLZZdHz6kpx0sTvh4uYfPpA8YaTiNhRM=
X-Google-Smtp-Source: AK7set/eNne8XyxWc+GRcyN3PhFLbq500ZO7ynzVCW0oeT1ZO6D6q4PNxgTguB3hoHspc8OpTy2L6DcZUCercPIMiCM=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr12447508ejx.15.1677273577363; Fri, 24
 Feb 2023 13:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20230221234500.2653976-1-deso@posteo.net> <20230221234500.2653976-4-deso@posteo.net>
In-Reply-To: <20230221234500.2653976-4-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Feb 2023 13:19:25 -0800
Message-ID: <CAEf4BzbBc_YjED3qyfBdVCDcz_vWpDwMoc3zh-MhoVekx8qXUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: Add support for attaching uprobes
 to shared objects in APKs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 3:45 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change adds support for attaching uprobes to shared objects located
> in APKs, which is relevant for Android systems where various libraries
> may reside in APKs. To make that happen, we extend the syntax for the
> "binary path" argument to attach to with that supported by various
> Android tools:
>   <archive>!/<binary-in-archive>
>
> For example:
>   /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.so
>
> APKs need to be specified via full path, i.e., we do not attempt to
> resolve mere file names by searching system directories.
>
> We cannot currently test this functionality end-to-end in an automated
> fashion, because it relies on an Android system being present, but there
> is no support for that in CI. I have tested the functionality manually,
> by creating a libbpf program containing a uretprobe, attaching it to a
> function inside a shared object inside an APK, and verifying the sanity
> of the returned values.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/lib/bpf/libbpf.c | 87 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4543e9..a41993b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -53,6 +53,7 @@
>  #include "libbpf_internal.h"
>  #include "hashmap.h"
>  #include "bpf_gen_internal.h"
> +#include "zip.h"
>
>  #ifndef BPF_FS_MAGIC
>  #define BPF_FS_MAGIC           0xcafe4a11
> @@ -10702,6 +10703,65 @@ static long elf_find_func_offset_from_file(const=
 char *binary_path, const char *
>         return ret;
>  }
>
> +/* Find offset of function name in archive specified by path. Currently
> + * supported are .zip files that do not compress their contents, as used=
 on
> + * Android in the form of APKs, for example. "file_name" is the name of =
the ELF
> + * file inside the archive. "func_name" matches symbol name or name@@LIB=
 for
> + * library functions.
> + *
> + * An overview of the APK format specifically provided here:
> + * https://en.wikipedia.org/w/index.php?title=3DApk_(file_format)&oldid=
=3D1139099120#Package_contents
> + */
> +static long elf_find_func_offset_from_archive(const char *archive_path, =
const char *file_name,
> +                                             const char *func_name)
> +{
> +       struct zip_archive *archive;
> +       struct zip_entry entry;
> +       long ret =3D -ENOENT;
> +       Elf *elf;
> +
> +       archive =3D zip_archive_open(archive_path);
> +       if (!archive) {
> +               pr_warn("zip: failed to open %s\n", archive_path);
> +               return -LIBBPF_ERRNO__FORMAT;

we don't preserve errno inside zip_archive_open, it might be useful,
though, because there is a difference between "file not found", "file
has invalid format", "we don't have permission", which is where errno
comes in handy

> +       }
> +
> +       if (zip_archive_find_entry(archive, file_name, &entry)) {
> +               pr_warn("zip: could not find archive member %s in %s\n", =
file_name, archive_path);
> +               ret =3D -LIBBPF_ERRNO__FORMAT;

let's preserve error code returned from zip_archive_find_entry and log
it in above pr_warn. It's not always format problem, requested
binary/library might be just missing from APK


> +               goto out;
> +       }
> +       pr_debug("zip: found entry for %s in %s at 0x%lx\n", file_name, a=
rchive_path,
> +                (unsigned long)entry.data_offset);
> +
> +       if (entry.compression) {
> +               pr_warn("zip: entry %s of %s is compressed and cannot be =
handled\n", file_name,
> +                       archive_path);
> +               ret =3D -LIBBPF_ERRNO__FORMAT;
> +               goto out;
> +       }
> +

[...]

> @@ -10806,21 +10867,33 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
>         if (!binary_path)
>                 return libbpf_err_ptr(-EINVAL);
>
> -       if (!strchr(binary_path, '/')) {
> -               err =3D resolve_full_path(binary_path, full_binary_path,
> -                                       sizeof(full_binary_path));
> +       /* Check if "binary_path" refers to an archive. */
> +       archive_sep =3D strstr(binary_path, "!/");
> +       if (archive_sep) {
> +               full_path[0] =3D '\0';
> +               libbpf_strlcpy(full_path, binary_path, archive_sep - bina=
ry_path + 1);

that's probably the bug you mentioned offline, should be
sizeof(full_path) for the third arg, right?

> +               archive_path =3D full_path;
> +               binary_path =3D archive_sep + 2;
> +       } else if (!strchr(binary_path, '/')) {
> +               err =3D resolve_full_path(binary_path, full_path, sizeof(=
full_path));
>                 if (err) {
>                         pr_warn("prog '%s': failed to resolve full path f=
or '%s': %d\n",
>                                 prog->name, binary_path, err);
>                         return libbpf_err_ptr(err);
>                 }

[...]
