Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6466A7451
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCATbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCATbZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:31:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CB72B4
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 11:31:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o15so55858881edr.13
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677699082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAEGOKX2nfRTk3VLZ6FFTaBh6hva3oQbGj5l8HS6YOY=;
        b=psMAHsFcaFPvnvaosVguehVB44XPZO8nb7tn6MZ6l4bQ2r3HE34NsxQ3OF+R/2ZGQ6
         zDNpyELdNRXV0cqKS+cs0cz+FckcPR9usyubE+nv/dYCP3lR5gnW05lE+KluDCq9N5Vc
         pjNSuxVprTpSWy3q+PwtIX8y51KklXE+5m5/HR12nxjqtXjMGAeg8jzV5LoHTMquMGhn
         kGuem+obp94m4VL0idIShIWkRWL+UEh1P6rtjBa5JFZ6RKZDQz23oiEW8bS+4eMeEzKA
         kIGCXUqcyO981TtKLxNERJoK7RoVcBcfnS8ZodsSxAMicojrJo0L0u0MFuLAbsLzuH/i
         fpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAEGOKX2nfRTk3VLZ6FFTaBh6hva3oQbGj5l8HS6YOY=;
        b=qM1TvxjAzLzRzpnB5AbL3bQnN7oKL5sdCCf/VR45/4X/vB2UUwdtqYW84DYHNi+ete
         FmfuK/TXPyvnt/ihX111mJnyH5BpHN/yqs10F+BG/XBOIm+40ybdnICn0n0Jm0qFevwU
         CGyoaHVV61kDi0uwvkT60jtYHx/S8PED1jsbv9fSef+2BjGJynI9GSbTO/7w6DYt4CkF
         d14JglluUkFZnWXZrB2E8FVkKtqj4fUDuPiGcviFTUlj6Ul25Yd6YkTZyUol7zUN7xUk
         NYBlEivMz2++2Aap7atONpOpz5TSIGU6x75GwS3gdrU36L8eseINShWesyKJNWYhXAgE
         vKHQ==
X-Gm-Message-State: AO0yUKXwb8Nq///GtSSszGRaew9qqBMz38mtAX3ZD6O3HRXoDliiYESD
        05kMIjfHtIgFFSqrAgEKr9POFVe8tcq1CUDhEG7faO5dd7M=
X-Google-Smtp-Source: AK7set8+lEhGmqStipEziXRBkvR7cbq3u4ion5lQPjWpVc7Da2Nf36YahFJd17olXPWUOfTLa6dDYV5H5MFBzqIFxz0=
X-Received: by 2002:a17:906:5f97:b0:8b0:7e1d:f6fa with SMTP id
 a23-20020a1709065f9700b008b07e1df6famr3644870eju.15.1677699082420; Wed, 01
 Mar 2023 11:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20230301184026.800691-1-deso@posteo.net> <20230301184026.800691-4-deso@posteo.net>
In-Reply-To: <20230301184026.800691-4-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 11:31:09 -0800
Message-ID: <CAEf4BzYcRjvXhBnsJEWP0YDoDpaVyeBUeyz+LbNWmi-5VL7hoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] libbpf: Add support for attaching uprobes
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

On Wed, Mar 1, 2023 at 10:40=E2=80=AFAM Daniel M=C3=BCller <deso@posteo.net=
> wrote:
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
>  tools/lib/bpf/libbpf.c | 92 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 85 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4543e9..e6b99a 100644
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
> @@ -10702,6 +10703,69 @@ static long elf_find_func_offset_from_file(const=
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
> +       int err;
> +       Elf *elf;
> +
> +       archive =3D zip_archive_open(archive_path);
> +       if (IS_ERR(archive)) {

Unfortunately, this won't work with the libbpf_err_ptr() approach that
you used inside zip_archive_open(). Since libbpf v1.0 libbpf_err_ptr()
will return NULL on error (and so this IS_ERR() check will always be
false, and subsequent PTR_ERR() would be returning 0) and only set
errno to actual error. This was meant to be used mostly for
user-facing APIs.

Given zip_archive_open() is internal, explicit PTR_ERR() use as you do
below makes most sense. Please update and respin.

> +               pr_warn("zip: failed to open %s: %ld\n", archive_path, PT=
R_ERR(archive));
> +               return PTR_ERR(archive);

err =3D PTR_ERR(archive); and use err in pr_warn() and return?

and it's not clear why you need both ret and err, it should be fine to
just use ret (long vs int doesn't hurt error propagation)

> +       }
> +
> +       err =3D zip_archive_find_entry(archive, file_name, &entry);
> +       if (err) {
> +               pr_warn("zip: could not find archive member %s in %s: %d\=
n", file_name,
> +                       archive_path, err);
> +               ret =3D err;
> +               goto out;
> +       }
> +       pr_debug("zip: found entry for %s in %s at 0x%lx\n", file_name, a=
rchive_path,
> +                (unsigned long)entry.data_offset);
> +

[...]
