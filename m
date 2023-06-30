Return-Path: <bpf+bounces-3826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71737442CE
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702CE1C20C52
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B017740;
	Fri, 30 Jun 2023 19:40:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4B1772A;
	Fri, 30 Jun 2023 19:40:18 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FA3C3C;
	Fri, 30 Jun 2023 12:40:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so25684395e9.0;
        Fri, 30 Jun 2023 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688154014; x=1690746014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6pnTwJKxb2Jp5JkpBaLoHKFY7M4ibIn04BA+G59EYg=;
        b=GnYFHnHbHeh67Ewq22wobUeXiEPGvNiZYMQE+/Tt0YO8b55MUWr1L4/Fp2qu6aPW5z
         RJvIIcBdHd5zDsT9WmBNbRVdjk05ObOXl0Ze+uroUPUjHwzaDFOhti87+VyMsHJAJV7O
         YnFtDN/CsVIWam3/lEECcYG0zum+XDJtFvP6L2PZoXQyteRTR0KRrD5jlpBxUeelZKTn
         Vhk6Xw4Gp+bAS/xi1PReVGaOapjkF0yBaHFQqnQP4ImZOI6fabv9QiHtLF5kSvSwTE71
         CmeCNfBGKJkxaBmPvnNg1KNPBdCuXgyMCs0+gNJwupvhdMv6h9NrVXZwNQrfI7uZVDzv
         u+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688154014; x=1690746014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6pnTwJKxb2Jp5JkpBaLoHKFY7M4ibIn04BA+G59EYg=;
        b=ZjvVTnKcewDLPGN7gD5x6JfQDBuZTCQGT7mzZBpADKaq1D6qfQwpzSGaQ4IU7CM/LB
         T3llxxogHg4wsGIO6wmTwh1sPUismqUFXHwnTE5xS9Pit0o88M13Zx5/GLucxXXeEqV8
         ajXz+owV0zlC5u12vOkrxM2kPG7vl1lfeoao4jSb+61Y04VTyh0mj0E11bspE7pmLNGK
         MMR8ollF+mKSbs4/mj05o5eGthAND5F4kDfwALzE9zKhZphVTo+bOhbVYhYjgKoJPoDY
         iqmWRjCOkBd+Ze+TC++PE0S530UlCMERgiDxxku4l6u9OxNc3H0kWAmNltkamXqXNHMh
         VlPQ==
X-Gm-Message-State: AC+VfDyzuqG680A0j18ZLxF5KxSUsLXkhHZE2anlmOFkDmzN+piPlhqX
	wOCPI8zMEH6koolznY5hhponOOZWNNNc/pmUf9vr5sHFOkA=
X-Google-Smtp-Source: ACHHUZ60SjUzyBWIZcv4aguG2YXeIZyv6UTTr1qF4Wyreq4/BL70LFZGDpsjjTRAq1/b9km7vJZ7kIpJmVzoLCPNmc8=
X-Received: by 2002:a05:600c:ac6:b0:3fb:b3aa:1c88 with SMTP id
 c6-20020a05600c0ac600b003fbb3aa1c88mr2666744wmr.26.1688154014182; Fri, 30 Jun
 2023 12:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628152738.22765-1-fw@strlen.de> <20230628152738.22765-2-fw@strlen.de>
In-Reply-To: <20230628152738.22765-2-fw@strlen.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jun 2023 12:40:02 -0700
Message-ID: <CAEf4BzZKPVwGMhJgQgAJBxsiiaSzq5SFYLACTO9fq_w5RPdm7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] tools: libbpf: add netfilter link attach helper
To: Florian Westphal <fw@strlen.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 8:27=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Add new api function: bpf_program__attach_netfilter.
>
> It takes a bpf program (netfilter type), and a pointer to a option struct
> that contains the desired attachment (protocol family, priority, hook
> location, ...).
>
> It returns a pointer to a 'bpf_link' structure or NULL on error.
>
> Next patch adds new netfilter_basic test that uses this function to
> attach a program to a few pf/hook/priority combinations.
>
> v2: change name and use bpf_link_create.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Link: https://lore.kernel.org/bpf/CAEf4BzZrmUv27AJp0dDxBDMY_B8e55-wLs8DUK=
K69vCWsCG_pQ@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CAEf4BzZ69YgrQW7DHCJUT_X+GqMq_ZQQPBwopa=
JJVGFD5=3Dd5Vg@mail.gmail.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  tools/lib/bpf/bpf.c      |  6 ++++++
>  tools/lib/bpf/bpf.h      |  6 ++++++
>  tools/lib/bpf/libbpf.c   | 42 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 15 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 70 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index ed86b37d8024..1b4f85f3c5b1 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -741,6 +741,12 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, tracing))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_NETFILTER:
> +               attr.link_create.netfilter.pf =3D OPTS_GET(opts, netfilte=
r.pf, 0);
> +               attr.link_create.netfilter.hooknum =3D OPTS_GET(opts, net=
filter.hooknum, 0);
> +               attr.link_create.netfilter.priority =3D OPTS_GET(opts, ne=
tfilter.priority, 0);
> +               attr.link_create.netfilter.flags =3D OPTS_GET(opts, netfi=
lter.flags, 0);

there should have also done this check:

if (!OPTS_ZEROED(opts, netfilter))
    return libbpf_err(-EINVAL);

 just like in other cases. I added it while applying to bpf-next, thanks.


> +               break;
>         default:
>                 if (!OPTS_ZEROED(opts, flags))
>                         return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 9aa0ee473754..c676295ab9bf 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -349,6 +349,12 @@ struct bpf_link_create_opts {
>                 struct {
>                         __u64 cookie;
>                 } tracing;
> +               struct {
> +                       __u32 pf;
> +                       __u32 hooknum;
> +                       __s32 priority;
> +                       __u32 flags;
> +               } netfilter;
>         };
>         size_t :0;
>  };
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..f193eca16382 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11811,6 +11811,48 @@ static int attach_iter(const struct bpf_program =
*prog, long cookie, struct bpf_l
>         return libbpf_get_error(*link);
>  }
>
> +struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program =
*prog,
> +                                              const struct bpf_netfilter=
_opts *opts)
> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +       struct bpf_link *link;
> +       int prog_fd, link_fd;
> +
> +       if (!OPTS_VALID(opts, bpf_netfilter_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't attach before loaded\n", prog->=
name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
> +       link =3D calloc(1, sizeof(*link));
> +       if (!link)
> +               return libbpf_err_ptr(-ENOMEM);
> +
> +       link->detach =3D &bpf_link__detach_fd;
> +
> +       lopts.netfilter.pf =3D OPTS_GET(opts, pf, 0);
> +       lopts.netfilter.hooknum =3D OPTS_GET(opts, hooknum, 0);
> +       lopts.netfilter.priority =3D OPTS_GET(opts, priority, 0);
> +       lopts.netfilter.flags =3D OPTS_GET(opts, flags, 0);
> +
> +       link_fd =3D bpf_link_create(prog_fd, 0, BPF_NETFILTER, &lopts);
> +       if (link_fd < 0) {
> +               char errmsg[STRERR_BUFSIZE];
> +
> +               link_fd =3D -errno;
> +               free(link);
> +               pr_warn("prog '%s': failed to attach to netfilter: %s\n",
> +                       prog->name, libbpf_strerror_r(link_fd, errmsg, si=
zeof(errmsg)));
> +               return libbpf_err_ptr(link_fd);
> +       }
> +       link->fd =3D link_fd;
> +
> +       return link;
> +}
> +
>  struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>  {
>         struct bpf_link *link =3D NULL;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 754da73c643b..10642ad69d76 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -718,6 +718,21 @@ LIBBPF_API struct bpf_link *
>  bpf_program__attach_freplace(const struct bpf_program *prog,
>                              int target_fd, const char *attach_func_name)=
;
>
> +struct bpf_netfilter_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +
> +       __u32 pf;
> +       __u32 hooknum;
> +       __s32 priority;
> +       __u32 flags;
> +};
> +#define bpf_netfilter_opts__last_field flags
> +
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_netfilter(const struct bpf_program *prog,
> +                             const struct bpf_netfilter_opts *opts);
> +
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2fb7626..d9ec4407befa 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
>  LIBBPF_1.3.0 {
>         global:
>                 bpf_obj_pin_opts;
> +               bpf_program__attach_netfilter;
>  } LIBBPF_1.2.0;
> --
> 2.39.3
>

