Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE669B6FD
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBRAlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBRAle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:41:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88186D25A
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:40:52 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y14so2655715ljq.10
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Z1W0wEvuLo9yl4c/axSNeczppuJsAbTfAQ5W0V+7s=;
        b=N00ka4wUzf+PRKX6zYwkpB6cHSu40vJ8MRD7qaqTqw5/b1mpergWasK6pLiaZ4i8ns
         VbdCeIzze8cipxDcLXUvGuI/mo+c+j2/vCXb5WT+sA34QQIv4rKmamf1u4c4lOGviGIM
         eLTcWz8tya/s4kurL8g28pn7xiEx86LMqPuLlRu+kqLGGIIyILNgvKBbUik/o3h6hzp3
         h7j5kBPjbBkyblKQQBP8hh2v5VJ15tixbTAhp62jihFJKMFSpFhfsN9DJ6FpQmOav9NC
         lsUJOoCs4lqE74BUEVik9BOKad4A2YsrPHcG1JLSUNnysUnjhdizZtucmzoV3vLt1RCA
         TJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/Z1W0wEvuLo9yl4c/axSNeczppuJsAbTfAQ5W0V+7s=;
        b=YxcQD6AXo7ePJx1Zw33OsTH22dhKFWVFkiSjLDofQZN730blQcYsFUv8CgvARVdsj9
         D1cib04BeTMAsivOaMebGriNFt1hh1sIucGT93ZedHxBm1Rob01TISCu42yILjK9tMb9
         S3nO6LkYlrHrn1JY+J33fooqiencB8Jw0ozrkQYNxnjKB8fxaTxmcd2Ru7Yk3HIZu9j6
         yiXHzMUJ9Ioq7mF6V6SoapFc330xD4rVzC+ly9NWLdVvLmYZSC6q/LXuVX/TM/cvYigP
         olQSqbeiFpjUvXC5tqrq4+rm+R19X6+PZxzrK9N10WMMzDOhiRi5QTGZsTjKHt1amikF
         3aXQ==
X-Gm-Message-State: AO0yUKVLMjj4Jj8idrzZtxTEf5RtuChhhBEb5QV4e1p6BWqfsX3Ig6Ah
        myIDLrMXdDsF7X8rnE5kpMHOy2//U++gKk7nmgg+VrlonyU=
X-Google-Smtp-Source: AK7set9kNpSTb7rS+JyknwjBM4CL01+6yyG8NhhNMSnKCm8eU0I9ErVk4hSZWvVP1Xj/0dhu5fLI4sxA/Q7ajrpazJA=
X-Received: by 2002:a05:6402:3890:b0:4ab:1f1b:95a1 with SMTP id
 fd16-20020a056402389000b004ab1f1b95a1mr5406889edb.0.1676680338051; Fri, 17
 Feb 2023 16:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <20230217191908.1000004-4-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-4-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 16:32:05 -0800
Message-ID: <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes to
 shared objects in APKs
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

On Fri, Feb 17, 2023 at 11:19 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This change adds support for attaching uprobes to shared objects located
> in APKs, which is relevant for Android systems where various libraries

Is there a good link with description of APK that we can record
somewhere in the comments for future us?

Also, does .apk contains only shared libraries, or it could be also
just a binary?

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

mere?

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
>  tools/lib/bpf/libbpf.c | 84 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a474f49..79ab85f 100644
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
> @@ -10702,6 +10703,60 @@ static long elf_find_func_offset_from_elf_file(c=
onst char *binary_path, const ch
>         return ret;
>  }
>
> +/* Find offset of function name in archive specified by path. Currently
> + * supported are .zip files that do not compress their contents (as used=
 on
> + * Android in the form of APKs, for example).  "file_name" is the name o=
f the
> + * ELF file inside the archive.  "func_name" matches symbol name or name=
@@LIB
> + * for library functions.

These double spaces after dot were not intended, let's not add more.

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
> +               pr_warn("failed to open %s\n", archive_path);

add "zip: " prefix?

> +               return -LIBBPF_ERRNO__FORMAT;
> +       }
> +
> +       if (zip_archive_find_entry(archive, file_name, &entry)) {
> +               pr_warn("zip: could not find archive member %s in %s\n", =
file_name, archive_path);
> +               ret =3D -LIBBPF_ERRNO__FORMAT;
> +               goto out;
> +       }
> +
> +       if (entry.compression) {
> +               pr_warn("zip: entry %s of %s is compressed and cannot be =
handled\n", file_name,
> +                       archive_path);
> +               ret =3D -LIBBPF_ERRNO__FORMAT;
> +               goto out;
> +       }
> +
> +       elf =3D elf_memory((void *)entry.data, entry.data_length);
> +       if (!elf) {
> +               pr_warn("elf: could not read elf file %s from %s: %s\n", =
file_name, archive_path,

I kind of like preserving the "archive/path!/file/path" consistently
through error messages when referring to file within APK, WDYT?

> +                       elf_errmsg(-1));
> +               ret =3D -LIBBPF_ERRNO__FORMAT;
> +               goto out;
> +       }
> +
> +       ret =3D elf_find_func_offset(elf, file_name, func_name);
> +       if (ret > 0) {
> +               ret +=3D entry.data_offset;
> +               pr_debug("elf: symbol address match for '%s' in '%s': 0x%=
lx\n", func_name,
> +                        archive_path, ret);

so for debugging I feel like we'll want to know both entry.data_offset
and original ELF offset, let's report all three offset (including the
final calculated one)?

> +       }
> +       elf_end(elf);
> +
> +out:
> +       zip_archive_close(archive);
> +       return ret;
> +}
> +
>  static const char *arch_specific_lib_paths(void)
>  {
>         /*
> @@ -10789,6 +10844,9 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>  {
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
>         char errmsg[STRERR_BUFSIZE], *legacy_probe =3D NULL;
> +       const char *archive_path =3D NULL;
> +       const char *archive_sep =3D NULL;

nit: combine on a single line?

> +       char full_archive_path[PATH_MAX];
>         char full_binary_path[PATH_MAX];
>         struct bpf_link *link;
>         size_t ref_ctr_off;
> @@ -10806,9 +10864,21 @@ bpf_program__attach_uprobe_opts(const struct bpf=
_program *prog, pid_t pid,
>         if (!binary_path)
>                 return libbpf_err_ptr(-EINVAL);
>
> -       if (!strchr(binary_path, '/')) {
> -               err =3D resolve_full_path(binary_path, full_binary_path,
> -                                       sizeof(full_binary_path));
> +       /* Check if "binary_path" refers to an archive. */
> +       archive_sep =3D strstr(binary_path, "!/");
> +       if (archive_sep) {
> +               if (archive_sep - binary_path >=3D sizeof(full_archive_pa=
th)) {

very unlikely to happen, I wouldn't bother checking, especially that
strncpy will just truncate and make us fail anyways

> +                       return libbpf_err_ptr(-EINVAL);
> +               }
> +
> +               strncpy(full_archive_path, binary_path, archive_sep - bin=
ary_path);

let's use saner libbpf_strlcpy() instead of strncpy, we stopped using
strncpy relatively recently

> +               full_archive_path[archive_sep - binary_path] =3D 0;

strlcpy makes sure the resulting string is zero-terminated.

But note that full_archive_path[0] is not guaranteed to be zero, so
strncpy/strlcpy might preserve some garbage in front. Let's make sure
full_archive_path[0] =3D '\0'; before manipulating that buffer

> +               archive_path =3D full_archive_path;
> +
> +               strcpy(full_binary_path, archive_sep + 2);
> +               binary_path =3D full_binary_path;

no need to copy, just `binary_path =3D archive_sep + 2;`? And thus we
can reuse full_binary_path buffer for archive path (we can rename it
to be more generic "full_path" name or something)

> +       } else if (!strchr(binary_path, '/')) {
> +               err =3D resolve_full_path(binary_path, full_binary_path, =
sizeof(full_binary_path));
>                 if (err) {
>                         pr_warn("prog '%s': failed to resolve full path f=
or '%s': %d\n",
>                                 prog->name, binary_path, err);
> @@ -10820,7 +10890,13 @@ bpf_program__attach_uprobe_opts(const struct bpf=
_program *prog, pid_t pid,
>         if (func_name) {
>                 long sym_off;
>
> -               sym_off =3D elf_find_func_offset_from_elf_file(binary_pat=
h, func_name);
> +               if (archive_path) {
> +                       sym_off =3D elf_find_func_offset_from_archive(arc=
hive_path, binary_path,
> +                                                                   func_=
name);
> +                       binary_path =3D archive_path;
> +               } else {
> +                       sym_off =3D elf_find_func_offset_from_elf_file(bi=
nary_path, func_name);
> +               }
>                 if (sym_off < 0)
>                         return libbpf_err_ptr(sym_off);
>                 func_offset +=3D sym_off;
> --
> 2.30.2
>
