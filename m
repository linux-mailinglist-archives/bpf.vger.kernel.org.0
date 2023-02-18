Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6E69B6A0
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBRAO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:14:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C566CF3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:14:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cn2so10374879edb.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45oLKlMBC6Fz1fv549yYeAWI2jYW/lEYLWAGavWr1dQ=;
        b=RkIHOoIsn5TtP9VYcyga4jMjBpV/av/x3o8xvMFnEj5cQYOfidZN4MRYXZMn+Qg/IW
         8vVaj/Kl98OQQBBCqb4CpRRJu7U18md4qQke18x3i1JWYeioF1tJ9/F/82wnFqb0tYHT
         hpG9p7+CM5x2Dkplp23KLqrWNTtcQYQf0sYZAZ3pldtmCFU3u3Sc5hvUxPEu4iNpeUKw
         2XUX52yqSUa/ASb/gUrm/T1T8SyyThD9QaGnMnQjG4Gvl6BgjTo8t+59DmqLu/LLqXo3
         /upJkMGNEb7Yf7GmMdnQGie/8kMrPxICeNENU9/xLoflgP0E8DkvcZ+M35P3wp96EfPl
         Dd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45oLKlMBC6Fz1fv549yYeAWI2jYW/lEYLWAGavWr1dQ=;
        b=3DnevLpHH0Z6x656wGFWRAyPMlcJzfXU4l1THa98xVv1HI3VhB8gm6RtGmJ15vCADC
         ykFP23CRgn0TKK3m7bUw22UxdjeKJpYNxDrvcwy2N6yzrlRxCM4IC/dcamFz6HnCudp1
         4O0LQecG7dHFVB9sonFyKsGNT20yHGzyJvzwMc0w4Vt9C/uEVWPNsCAR8BH6TKKRIXS/
         vQbbJAC1/8j01NA6gIHz+On8I1NKYy//nbUh+k1zf55I4lfbZfUo/77WXDCQ8X4Sw4iD
         gJ6xt7OYSO0tgHEiNNKbYRltdtr096VWM13SB4b9BXuDM/ZSBKXeRDCzIaL4srCa/czu
         rbHw==
X-Gm-Message-State: AO0yUKWmNZPvG3cTCPfCJ5c1ZDXDa6hrHHFLoMa2nlV+bn7W57yEltVR
        +pOAW0dbwjHha3gXWYD1CWlEq2B2jjvz6KhxefE=
X-Google-Smtp-Source: AK7set8MFTrsom3nZE+kzjG5bmGLQc3Jni3RqlASObWaSBbRCcIGZ4UJipc/Ng6WVrHyJl0MBqt9Qhb2xqtZzx1BA0Y=
X-Received: by 2002:a17:906:4a93:b0:88a:b103:212d with SMTP id
 x19-20020a1709064a9300b0088ab103212dmr1409278eju.15.1676679264699; Fri, 17
 Feb 2023 16:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <20230217191908.1000004-3-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-3-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 16:14:12 -0800
Message-ID: <CAEf4BzaAeBi4MWu7gbQfTPVGq76nS1EEAtB8uRc8J87uVD8gTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: Introduce elf_find_func_offset_from_elf_file()
 function
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
> This change splits the elf_find_func_offset() function in two:
> elf_find_func_offset(), which now accepts an already opened Elf object
> instead of a path to a file that is to be opened, as well as
> elf_find_func_offset_from_elf_file(), which opens a binary based on a
> path and then invokes elf_find_func_offset() on the Elf object. Having
> this split in responsibilities will allow us to call
> elf_find_func_offset() from other code paths on Elf objects that did not
> necessarily come from a file on disk.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/lib/bpf/libbpf.c | 55 +++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>

Looks good, just few pedantic nits


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 05c4db3..a474f49 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10531,32 +10531,19 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *=
elf, int sh_type, Elf_Scn *scn)
>         return NULL;
>  }
>
> -/* Find offset of function name in object specified by path.  "name" mat=
ches
> - * symbol name or name@@LIB for library functions.
> +/* Find offset of function name in the provided ELF object.  "binary_pat=
h" is
> + * the path to the ELF binary represented by "elf", and only used for er=
ror
> + * reporting matters.  "name" matches symbol name or name@@LIB for libra=
ry
> + * functions.
>   */
> -static long elf_find_func_offset(const char *binary_path, const char *na=
me)
> +static long elf_find_func_offset(Elf *elf, const char *binary_path, cons=
t char *name)
>  {
> -       int fd, i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> +       int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
>         bool is_shared_lib, is_name_qualified;
> -       char errmsg[STRERR_BUFSIZE];
>         long ret =3D -ENOENT;
>         size_t name_len;
>         GElf_Ehdr ehdr;
> -       Elf *elf;
>
> -       fd =3D open(binary_path, O_RDONLY | O_CLOEXEC);
> -       if (fd < 0) {
> -               ret =3D -errno;
> -               pr_warn("failed to open %s: %s\n", binary_path,
> -                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> -               return ret;
> -       }
> -       elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> -       if (!elf) {
> -               pr_warn("elf: could not read elf from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> -               close(fd);
> -               return -LIBBPF_ERRNO__FORMAT;
> -       }
>         if (!gelf_getehdr(elf, &ehdr)) {
>                 pr_warn("elf: failed to get ehdr from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
>                 ret =3D -LIBBPF_ERRNO__FORMAT;
> @@ -10682,6 +10669,34 @@ static long elf_find_func_offset(const char *bin=
ary_path, const char *name)
>                 }
>         }
>  out:
> +       return ret;
> +}
> +
> +/* Find offset of function name in ELF object specified by path.  "name"=
 matches

nit: seems like it's original spelling, but let's remove these double
spaces (same above in elf_find_func_offset comment)

> + * symbol name or name@@LIB for library functions.
> + */
> +static long elf_find_func_offset_from_elf_file(const char *binary_path, =
const char *name)

"from_file" would be enough, reads a bit tautological otherwise

> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       long ret =3D -ENOENT;
> +       Elf *elf;
> +       int fd;
> +
> +       fd =3D open(binary_path, O_RDONLY | O_CLOEXEC);

btw, this reminded me that in patch #1 we probably want to pass
O_CLOEXEC as well?

> +       if (fd < 0) {
> +               ret =3D -errno;
> +               pr_warn("failed to open %s: %s\n", binary_path,
> +                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> +               return ret;
> +       }
> +       elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> +       if (!elf) {
> +               pr_warn("elf: could not read elf from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> +               close(fd);
> +               return -LIBBPF_ERRNO__FORMAT;
> +       }
> +
> +       ret =3D elf_find_func_offset(elf, binary_path, name);
>         elf_end(elf);
>         close(fd);
>         return ret;
> @@ -10805,7 +10820,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>         if (func_name) {
>                 long sym_off;
>
> -               sym_off =3D elf_find_func_offset(binary_path, func_name);
> +               sym_off =3D elf_find_func_offset_from_elf_file(binary_pat=
h, func_name);
>                 if (sym_off < 0)
>                         return libbpf_err_ptr(sym_off);
>                 func_offset +=3D sym_off;
> --
> 2.30.2
>
