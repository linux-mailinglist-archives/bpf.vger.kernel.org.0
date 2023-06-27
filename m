Return-Path: <bpf+bounces-3519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CD673EF98
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484701C20A11
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA67E2;
	Tue, 27 Jun 2023 00:12:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01597161
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 00:12:07 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0E0E3;
	Mon, 26 Jun 2023 17:12:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa96fd79f0so22214705e9.3;
        Mon, 26 Jun 2023 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687824724; x=1690416724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNboCHedRLLXfh28XbOHjXWJ1PFfJzftlv/4qzy3emY=;
        b=Ac2dKWLvqT90BLdek41KI+7ybjXLn4H00EY8HNxT2dPqrMG0d8uJX7HD0aRI2hq5wu
         7nclcOiUk1M5uSyp+UrlFqvOYc68HSOk+YvegHyF/mPxEF+34q8viEVgoR626QfYqumN
         Wg6K6CRwUyKRWjvMFDjb6odvizOnY6vSYWT2bhPzpJxS7pCFcvtjdsoe8HmWKwdRoi4m
         hIyssDIz65Ej/vAztf47TYVq/eK/25YDOM5S4Hafojl23uAY6T42SEuKsWb9VTjQx8PV
         kO8QnmQvk7k4J3hU5JANaBdxLHHDJ2WaVogJQFqJuNp2VK+OZjJfmjSLWRaxq5Ie3aEz
         f/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687824724; x=1690416724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNboCHedRLLXfh28XbOHjXWJ1PFfJzftlv/4qzy3emY=;
        b=hDMUlck2lH0rtNgV71eNHqoHVmiWubvmuMnKq0Us6wSzRlR6QAoE+cxrHwT1JUIhH+
         5wAkEuSMp9xCjclqi5dnF24BuofXQ6FXs2v1zjg9LRygzxwSyCZ88clLVOZ3JQK6UYYq
         PSPzGIP4ou7zMAtP1XFZRA6rmpPfoh/As9BUmjQgy25rwpwbIyGw6Tipmmv0yfV4FcdY
         nL6RYlE3RuSpooxBihOPnWrGWtSHq3t3OSnf0othZCccXL3ps/tjAqblKIEwrnFa1JjS
         6o/dB6+CsHC3yJ03e8wzLIyC3Hp7tApTL4BfyTDU4PQ1xMqtAM142aAEi8+kYIAVwjqz
         aZFQ==
X-Gm-Message-State: AC+VfDxbJepNSh/OCm3dm6c/RS08GnUbxQVYKPK0UAdaoNToL+RmHuR2
	bpnISMLJN0yPOHiZR0vLKY8NzkTi1sANCIney2Y=
X-Google-Smtp-Source: ACHHUZ5SZSV1kLiIvOHnAr6ypRBQ9/JysLeblGPbXmFMY+rdoQWO2hFBDk9gK3Z/GiKzsmRbrT7dSB8nXf+wAXgpvQg=
X-Received: by 2002:a1c:f70f:0:b0:3f7:e58b:5898 with SMTP id
 v15-20020a1cf70f000000b003f7e58b5898mr34070714wmh.33.1687824724272; Mon, 26
 Jun 2023 17:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1687819413.git.dxu@dxuuu.xyz> <d98692cd1451b35b0939718f5d4676444aa40069.1687819413.git.dxu@dxuuu.xyz>
In-Reply-To: <d98692cd1451b35b0939718f5d4676444aa40069.1687819413.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 17:11:52 -0700
Message-ID: <CAEf4Bza-b8WhMofDrOZcUr59inZcX8GWXMJxuHmPxj7eChzr=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] tools: libbpf: add netfilter link attach helper
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, fw@strlen.de, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 4:02=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> Co-developed-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/bpf.c      |  8 +++++++
>  tools/lib/bpf/bpf.h      |  6 +++++
>  tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 15 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 77 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index ed86b37d8024..3b0da19715e1 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -741,6 +741,14 @@ int bpf_link_create(int prog_fd, int target_fd,
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
> +               if (!OPTS_ZEROED(opts, netfilter))
> +                       return libbpf_err(-EINVAL);
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
> index 214f828ece6b..a8b9d5abb55f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11811,6 +11811,53 @@ static int attach_iter(const struct bpf_program =
*prog, long cookie, struct bpf_l
>         return libbpf_get_error(*link);
>  }
>
> +struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program =
*prog,
> +                                              const struct bpf_netfilter=
_opts *opts)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);

nit: let's use shorter LIBBPF_OPTS() macro

> +       struct bpf_link *link;
> +       int prog_fd, link_fd;
> +
> +       if (!OPTS_VALID(opts, bpf_netfilter_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       link_create_opts.netfilter.pf =3D OPTS_GET(opts, pf, 0);
> +       link_create_opts.netfilter.hooknum =3D OPTS_GET(opts, hooknum, 0)=
;
> +       link_create_opts.netfilter.priority =3D OPTS_GET(opts, priority, =
0);
> +       link_create_opts.netfilter.flags =3D OPTS_GET(opts, flags, 0);
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
> +       link->detach =3D &bpf_link__detach_fd;
> +
> +       link_fd =3D bpf_link_create(prog_fd, 0, BPF_NETFILTER, &link_crea=
te_opts);
> +
> +       link->fd =3D ensure_good_fd(link_fd);

bpf_link_create() does ensure_good_fd() already, no need to do it
here, just assign result directly


> +
> +       if (link->fd < 0) {
> +               char errmsg[STRERR_BUFSIZE];
> +
> +               link_fd =3D -errno;
> +               free(link);
> +               pr_warn("prog '%s': failed to attach to pf:%d,hooknum:%d:=
prio:%d: %s\n",

comma before prio? but also how necessary is to emit all these? what
if we add another argument to opts, would we add them here as well?

I'd just go with just "failed to attach netfilter" and keep it simple

> +                       prog->name,
> +                       OPTS_GET(opts, pf, 0),
> +                       OPTS_GET(opts, hooknum, 0),
> +                       OPTS_GET(opts, priority, 0),
> +                       libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)=
));
> +               return libbpf_err_ptr(link_fd);
> +       }
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
> 2.40.1
>

