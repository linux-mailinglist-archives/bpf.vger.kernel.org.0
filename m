Return-Path: <bpf+bounces-4349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09A74A770
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304FD1C20ED5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775A1642E;
	Thu,  6 Jul 2023 23:09:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E463BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:09:45 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169219AE
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:09:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313e09a5b19so2179328f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688684981; x=1691276981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wucP8/WqjQ/GrBKUoUV49TSxwzSiQE1NSjPkXHupFSM=;
        b=W0r5efcROuoPGZ5JFJ0nSLIuuWVTnywrMkvZSdg4WRMgiOxRTVBKXFQF3WFIDKG9Cp
         PnY6LXtjgMCkzqgoOvK4GlzI0EPnvYRnV3TRuC47WYc2ixGfU80uG3KRpqI8FPkOfNl1
         o2vKOozZnjqiQ50RSRsvMuT6CjneeJKjQssR/6IZABLNfvSXlCcPNqY8i9dLnl9QWfcu
         Q/61RQyCqlJuSGcrLGRjtnUWpCzdgQ4LVCamZaNULOIAk+6+gLFnpCHjKDAXOnMRCbKL
         MGUNSjswyBd+f+ryFkPXbzpDIYF/NIMfG7gSvBUiHYBOVGtfT2+wnNzyBbyPW08F8+xd
         Bqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688684981; x=1691276981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wucP8/WqjQ/GrBKUoUV49TSxwzSiQE1NSjPkXHupFSM=;
        b=eTf2ZMrRAaRc+N59OSLliSTrJDj8VKK0MQeRSVj7xXHU9xjkP8Lk+D6ohtv+8McB5i
         XxVeZOtyrVJ2hGW7WRR0/QCgmpvihPnisiSdKizJbhVsiXgLMGZAONggiN+b4IKIDbpI
         9d/B92IUdE9ukbdNSikZTKPVXVcAP9/CI4V9Dzf5K/SQpmiQVfol3+TsoEkb0ue2v9eR
         6LGE/R10Cm1RTScqIAfpCdUGDHHDr/yMfy/hXQnBBTvW+aarP9ZKPJBp4B65trB+fFth
         Jg/s1v+S3NpoWF5vSGJz4zm7pGpa0IsxYurESGTlds29HEHVWX5zthcBW8Jf+p5SeCiP
         xt/Q==
X-Gm-Message-State: ABy/qLavNfmrKvyrkNZKpA0+VYJEujSsW7HAMVjm/Y5epU5+f1X2bTd7
	QV7PlS36VLKuYNck258NDFC3kjn3ro+77LUUDjCQ8+njpKXUlw==
X-Google-Smtp-Source: APBJJlGyl//Hjp+AzsK6+y6X/GH0pHfaH+If0Am9QWq+B9OTcAs0u7V8Xtv/UNJxhHRcqrGyeK5uvNp6Xh6EeuOffdg=
X-Received: by 2002:a05:600c:1d04:b0:3fb:b075:8239 with SMTP id
 l4-20020a05600c1d0400b003fbb0758239mr6091155wms.4.1688684980881; Thu, 06 Jul
 2023 16:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-9-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 16:09:29 -0700
Message-ID: <CAEf4BzaT8-81ooHjgwmR8F+e9++ZewdXJMGqVfFi+y-g4BFYww@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 08/26] libbpf: Add elf_open/elf_close functions
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

On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf_open/elf_close functions and using it in
> elf_find_func_offset_from_file function. It will be
> used in following changes to save some common code.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/elf.c        | 59 +++++++++++++++++++++++++-------------
>  tools/lib/bpf/libbpf_elf.h |  8 ++++++
>  tools/lib/bpf/usdt.c       | 31 ++++++--------------
>  3 files changed, 56 insertions(+), 42 deletions(-)
>

one nit below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 2b62b4af28ce..74e35071d22e 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -11,6 +11,40 @@
>
>  #define STRERR_BUFSIZE  128
>
> +int elf_open(const char *binary_path, struct elf_fd *elf_fd)
> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       int fd, ret;
> +       Elf *elf;
> +
> +       if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
> +               pr_warn("elf: failed to init libelf for %s\n", binary_pat=
h);
> +               return -LIBBPF_ERRNO__LIBELF;
> +       }
> +       fd =3D open(binary_path, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               ret =3D -errno;
> +               pr_warn("elf: failed to open %s: %s\n", binary_path,
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
> +       elf_fd->fd =3D fd;
> +       elf_fd->elf =3D elf;
> +       return 0;
> +}
> +
> +void elf_close(struct elf_fd *elf_fd)
> +{
> +       elf_end(elf_fd->elf);
> +       close(elf_fd->fd);

nit: I'd make elf_close() work correctly with a) NULL elf_fd and b)
NULL elf_fd->elf, just to never have to think about this

> +}
> +
>  /* Return next ELF section of sh_type after scn, or first of that type i=
f scn is NULL. */
>  static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn=
 *scn)
>  {

[...]

