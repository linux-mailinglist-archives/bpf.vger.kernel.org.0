Return-Path: <bpf+bounces-3222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6A73ADD3
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB1D1C20BD4
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF580376;
	Fri, 23 Jun 2023 00:33:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E019D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 00:33:49 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEE2684
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:33:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa71db41b6so1535725e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687480425; x=1690072425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdKQMJAYupZh/41fMc60omiGqjzsigvClahE4FE5K50=;
        b=PDJkgu+FjQ5FvJ5A2GS8FBzOMtTywQcjgavSadqzt0NwMg2BnYdp+SVPRav+obkUeJ
         coxswfSF1mWOvm2lORBzlnky7KcE3Voa1ja7tzkPUafEiLKiUoVRK00W82bMDtRKStpB
         0u9fxP8DoWJucXYyoWVSrZ4ASs2nZzc7qKye0FoNmAciJKDlosVxtJgIKtA8gxkdOQaP
         wH4U84lR256mfj0vc6DqekmzGYgFsMqPFWhTcTaTbk9wyt2tQFBwJxmfj3KWyu5zEn+Z
         IvPypkgA+ZSMST5CzCNLCmzwqVfXLQ+BfSKtqyJyBEWsgpOPB1Lqpo6QCARciSkcO6Rm
         6rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480425; x=1690072425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdKQMJAYupZh/41fMc60omiGqjzsigvClahE4FE5K50=;
        b=LwqIEAyrjwHxZk6tWZtaKrPlXsufGykx1dJyZdZKdrdwaivyY7eault4y0t9a7Q8cC
         Ih8YTNJftyH569zui0ibYDyHd/vgX+rvyOxXOm4nWKCb9r2HcqOVdEnxHK+oXngTLNSr
         X8oNCrbO8WNz3Y2WrIrIit/K34/1FfyvGuUkD0CKYHjSKOVSo/pCw1Hy051XMEwvz1P+
         QLai5ILs1wQheKfH3wtDPCV3kMErO9SGmCNgHIjskcvoSyacgl94Wo23gTt9eVuN8TVX
         0WHhi2olHEJAf/PJ5yRDiXLV40O7iUskVQlKOPtrjsA5CYnw8g4RQwnPaSEmq6KGLE08
         92pw==
X-Gm-Message-State: AC+VfDyK9AUg+YKQayJYPBFL7N4rC7be5++xSGZZRCGJiByby91wGEo1
	UEEDF3eKY1nKoERV1O00KwDM3htL11FRPhAbvVU=
X-Google-Smtp-Source: ACHHUZ7zExAe3m7gpLmDknS10yAzfNG0MnOui9GEWwibDFx/uhV0kDQb7Nar47GX+8mY0ATCttcP3x4FPuCOaHkuZrI=
X-Received: by 2002:a05:600c:ad4:b0:3f9:b8b8:20df with SMTP id
 c20-20020a05600c0ad400b003f9b8b820dfmr6607314wmr.33.1687480425538; Thu, 22
 Jun 2023 17:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-8-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 17:33:33 -0700
Message-ID: <CAEf4BzZAVUycbMeCMjGN8Sh+sR3Fe84neU1fkt_xp0EVMQe3CA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 07/24] libbpf: Add open_elf/close_elf functions
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding open_elf/close_elf functions and using it in
> elf_find_func_offset_from_file function. It will be
> used in following changes to save some code.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 18 deletions(-)
>

we should definitely move all this into separate elf.c file

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cdac368c7ce1..30d9e3b69114 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10927,6 +10927,45 @@ static struct elf_symbol *elf_symbol_iter_next(s=
truct elf_symbol_iter *iter)
>         return ret;
>  }
>
> +struct elf_fd {
> +       Elf *elf;
> +       int fd;
> +};
> +
> +static int open_elf(const char *binary_path, struct elf_fd *elf_fd)
> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       int fd, ret;
> +       Elf *elf;
> +
> +       if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
> +               pr_warn("failed to init libelf for %s\n", binary_path);
> +               return -LIBBPF_ERRNO__LIBELF;
> +       }
> +       fd =3D open(binary_path, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               ret =3D -errno;
> +               pr_warn("failed to open %s: %s\n", binary_path,
> +                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));

let's add "elf: " prefix for consistency?

> +               return ret;
> +       }
> +       elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> +       if (!elf) {
> +               pr_warn("elf: could not read elf from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> +               close(fd);
> +               return -LIBBPF_ERRNO__FORMAT;
> +       }
> +       elf_fd->fd =3D fd;
> +       elf_fd->elf =3D elf;
> +       return 0;
> +}
> +
> +static void close_elf(struct elf_fd *elf_fd)
> +{
> +       elf_end(elf_fd->elf);
> +       close(elf_fd->fd);
> +}
> +
>  /* Find offset of function name in the provided ELF object. "binary_path=
" is
>   * the path to the ELF binary represented by "elf", and only used for er=
ror
>   * reporting matters. "name" matches symbol name or name@@LIB for librar=
y
> @@ -11019,28 +11058,15 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>   */
>  static long elf_find_func_offset_from_file(const char *binary_path, cons=
t char *name)
>  {
> -       char errmsg[STRERR_BUFSIZE];
> +       struct elf_fd elf_fd =3D {};
>         long ret =3D -ENOENT;
> -       Elf *elf;
> -       int fd;
>
> -       fd =3D open(binary_path, O_RDONLY | O_CLOEXEC);
> -       if (fd < 0) {
> -               ret =3D -errno;
> -               pr_warn("failed to open %s: %s\n", binary_path,
> -                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> +       ret =3D open_elf(binary_path, &elf_fd);
> +       if (ret)
>                 return ret;
> -       }
> -       elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> -       if (!elf) {
> -               pr_warn("elf: could not read elf from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> -               close(fd);
> -               return -LIBBPF_ERRNO__FORMAT;
> -       }
>
> -       ret =3D elf_find_func_offset(elf, binary_path, name);
> -       elf_end(elf);
> -       close(fd);
> +       ret =3D elf_find_func_offset(elf_fd.elf, binary_path, name);
> +       close_elf(&elf_fd);
>         return ret;
>  }
>
> --
> 2.41.0
>

