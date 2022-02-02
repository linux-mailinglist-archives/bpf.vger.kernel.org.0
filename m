Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945054A775E
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiBBR6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiBBR63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 12:58:29 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A246C061714;
        Wed,  2 Feb 2022 09:58:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r144so25595iod.9;
        Wed, 02 Feb 2022 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r+th5RSgiUIlE9+fwUEbrkoI+KpY8Qdz15Bn4My9lRg=;
        b=ndHDmoxwAS4DqB2GZ1So2rcrZoA6xNdlR3TIk/L+5++SrAScUgWJ+ODeQfR82EwfxJ
         neaBEYabFMQsSYuN/XLCX/xP16MUMUP2bKv+pX3qc3heI7m+fU6MAQ//KDDTT3dGlKZZ
         B+N2jqeJX1mFt+cLlbJyCdm9yAmVjEnxjBVxHhYs1Q1M66Ul7UopbyQDno0p8fGLXKn2
         lPBZH52//G3emv0OUrfZL07xVTMRupHKHiNgtgqakrq2OEFvaEU5aNpZS5Wg/HmasK+c
         AFPWgwueNWzRVWCk4LqDgcLKHqrTyFNY2pBfz/Mt59EAVfQ6k5HbS4ECdmqs8gs9v2Wf
         XBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r+th5RSgiUIlE9+fwUEbrkoI+KpY8Qdz15Bn4My9lRg=;
        b=38AmOLNTOo5XMTJYvF2WZvGEGVeBWhpqSMxDWHKGWSdJULO5fQJ25Sjm32eXuAAJjH
         mo5Z2hxafGm92oa4yQzhTCmSj3MrTh9wBa5/YVtE8DRtziTUwVkcepOyA1o32fBi879X
         JNzR5YzkYLHm+wpcZUDIFkcFBDMz1OLDmT5RaGB/C9UyNpdR5bgyGfu5B/kxmwClINXz
         IJDpeeUezppWCeiH7fOP3N78j+I//O7avFllo6HvnFxAyjsYtnO28bI1PgA/F8GTKvNT
         l2mMput457piGqkyRXgOoyysfTZzMX/nmZQgF7UvslYhWC3cbqcWxDDXLZejLbXuqVZ/
         uOAw==
X-Gm-Message-State: AOAM532UehDUBMEUy+hW+9Z+WpNNgLUE0Cz6GJ+UzslNDC4ENsNuiZn0
        FDqP6MCk02w68JY8PqaJ5APe0Ygdt4uRo5+xM53PEMw4
X-Google-Smtp-Source: ABdhPJx9yeuDUU46BBDC0oJyLFzosAmrLKNm8M/ssDs//SDRz6+ifk2i2KrsEBrKkKY2u/P/dQCVawd6VzAeNfxEx5s=
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr14314317jak.103.1643824707710;
 Wed, 02 Feb 2022 09:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20220128223312.1253169-1-mauricio@kinvolk.io> <20220128223312.1253169-3-mauricio@kinvolk.io>
In-Reply-To: <20220128223312.1253169-3-mauricio@kinvolk.io>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Feb 2022 09:58:16 -0800
Message-ID: <CAEf4BzY3_GZD8C754nb5P_+btFEsmK5QHC-qoHqJqAdSMNKcsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] bpftool: Add gen min_core_btf command
To:     =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 2:33 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io>=
 wrote:
>
> This command is implemented under the "gen" command in bpftool and the
> syntax is the following:
>
> $ bpftool gen min_core_btf INPUT OUTPUT OBJECT(S)
>
> INPUT can be either a single BTF file or a folder containing BTF files,
> when it's a folder, a BTF file is generated for each BTF file contained
> in this folder. OUTPUT is the file (or folder) where generated files are
> stored and OBJECT(S) is the list of bpf objects we want to generate the
> BTF file(s) for (each generated BTF file contains all the types needed
> by all the objects).
>
> Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |   6 +-
>  tools/bpf/bpftool/gen.c                   | 112 +++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index 493753a4962e..958e1fd71b5c 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1003,9 +1003,13 @@ _bpftool()
>                              ;;
>                      esac
>                      ;;
> +                min_core_btf)
> +                    _filedir
> +                    return 0
> +                    ;;
>                  *)
>                      [[ $prev =3D=3D $object ]] && \
> -                        COMPREPLY=3D( $( compgen -W 'object skeleton hel=
p' -- "$cur" ) )
> +                        COMPREPLY=3D( $( compgen -W 'object skeleton hel=
p min_core_btf' -- "$cur" ) )
>                      ;;
>              esac
>              ;;
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 8f78c27d41f0..7db31b0f265f 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -5,6 +5,7 @@
>  #define _GNU_SOURCE
>  #endif
>  #include <ctype.h>
> +#include <dirent.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/err.h>
> @@ -1084,6 +1085,7 @@ static int do_help(int argc, char **argv)
>         fprintf(stderr,
>                 "Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FI=
LE...]\n"
>                 "       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
> +               "       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT(S)\n"

OBJECTS(S) should be OBJECT... for this "CLI notation", no?

>                 "       %1$s %2$s help\n"
>                 "\n"
>                 "       " HELP_SPEC_OPTIONS " |\n"
> @@ -1094,10 +1096,114 @@ static int do_help(int argc, char **argv)
>         return 0;
>  }
>
> +/* Create BTF file for a set of BPF objects */
> +static int btfgen(const char *src_btf, const char *dst_btf, const char *=
objspaths[])
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int do_min_core_btf(int argc, char **argv)
> +{
> +       char src_btf_path[PATH_MAX], dst_btf_path[PATH_MAX];
> +       bool input_is_file, output_is_file =3D true;
> +       const char *input, *output;
> +       const char **objs =3D NULL;
> +       struct dirent *dir;
> +       struct stat st;
> +       DIR *d =3D NULL;
> +       int i, err;
> +
> +       if (!REQ_ARGS(3)) {
> +               usage();
> +               return -1;
> +       }
> +
> +       input =3D GET_ARG();
> +       if (stat(input, &st) < 0) {
> +               p_err("failed to stat %s: %s", input, strerror(errno));
> +               return -errno;
> +       }
> +
> +       if ((st.st_mode & S_IFMT) !=3D S_IFDIR && (st.st_mode & S_IFMT) !=
=3D S_IFREG) {
> +               p_err("file type not valid: %s", input);
> +               return -EINVAL;
> +       }
> +
> +       input_is_file =3D (st.st_mode & S_IFMT) =3D=3D S_IFREG;

move before if and use input_is_file in the if itself instead of
duplicating all the S_IFREG flags?

> +
> +       output =3D GET_ARG();
> +       if (stat(output, &st) =3D=3D 0 && (st.st_mode & S_IFMT) =3D=3D S_=
IFDIR)
> +               output_is_file =3D false;

if stat() succeeds but it's neither directory or file, should be an
error, right?

> +
> +       objs =3D (const char **) malloc((argc + 1) * sizeof(*objs));

calloc() seems to be better suited for this (and zero-intialization is
nice for safety and to avoid objs[argc] =3D NULL after the loop below)

> +       if (!objs) {
> +               p_err("failed to allocate array for object names");
> +               return -ENOMEM;
> +       }
> +
> +       i =3D 0;
> +       while (argc > 0)
> +               objs[i++] =3D GET_ARG();

for (i =3D 0; i < argc; i++) ?

> +
> +       objs[i] =3D NULL;
> +
> +       /* single BTF file */
> +       if (input_is_file) {
> +               p_info("Processing source BTF file: %s", input);
> +
> +               if (output_is_file) {
> +                       err =3D btfgen(input, output, objs);
> +                       goto out;
> +               }
> +               snprintf(dst_btf_path, sizeof(dst_btf_path), "%s/%s", out=
put,
> +                        basename(input));
> +               err =3D btfgen(input, dst_btf_path, objs);
> +               goto out;
> +       }
> +
> +       if (output_is_file) {
> +               p_err("can't have just one file as output");
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* directory with BTF files */
> +       d =3D opendir(input);
> +       if (!d) {
> +               p_err("error opening input dir: %s", strerror(errno));
> +               err =3D -errno;
> +               goto out;
> +       }
> +
> +       while ((dir =3D readdir(d)) !=3D NULL) {
> +               if (dir->d_type !=3D DT_REG)
> +                       continue;
> +
> +               if (strncmp(dir->d_name + strlen(dir->d_name) - 4, ".btf"=
, 4))
> +                       continue;

this whole handling of input directory feels a bit icky, tbh... maybe
we should require explicit listing of input files always. In CLI
invocation those could be separated by "keywords", something like
this:

bpftool gen min_core_btf <output> inputs <file1> <file2> .... objects
<obj1> <obj2> ...

a bit of a downside is that you can't have a file named "inputs" or
"objects", but that seems extremely unlikely? Quentin, any opinion as
well?

I'm mainly off put by a bit random ".btf" naming convention, the
DT_REG skipping, etc.

Another cleaner alternative from POV of bpftool (but might be less
convenient for users) is to use @file convention to specify a file
that contains a list of files. So

bpftool gen min_core_btf <output> @btf_filelist.txt @obj_filelist.txt

would take lists of inputs and outputs from respective files?


But actually, let's take a step back again. Why should there be
multiple inputs and outputs? I can see why multiple objects are
mandatory (you have an application that has multiple BPF objects used
internally). But processing single vmlinux BTF at a time seems
absolutely fine. I don't buy that CO-RE relo processing is that slow
to require optimized batch processing.

I might have asked this before, sorry, but the duration between each
iteration of btfgen is pretty long and I'm losing the context.

> +
> +               snprintf(src_btf_path, sizeof(src_btf_path), "%s%s", inpu=
t, dir->d_name);
> +               snprintf(dst_btf_path, sizeof(dst_btf_path), "%s%s", outp=
ut, dir->d_name);
> +
> +               p_info("Processing source BTF file: %s", src_btf_path);
> +
> +               err =3D btfgen(src_btf_path, dst_btf_path, objs);
> +               if (err)
> +                       goto out;
> +       }
> +
> +out:
> +       free(objs);
> +       if (d)
> +               closedir(d);
> +       return err;
> +}
> +
>  static const struct cmd cmds[] =3D {
> -       { "object",     do_object },
> -       { "skeleton",   do_skeleton },
> -       { "help",       do_help },
> +       { "object",             do_object },
> +       { "skeleton",           do_skeleton },
> +       { "min_core_btf",       do_min_core_btf},
> +       { "help",               do_help },
>         { 0 }
>  };
>
> --
> 2.25.1
>
