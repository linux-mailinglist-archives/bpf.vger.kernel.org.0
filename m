Return-Path: <bpf+bounces-11012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8B7B0FCB
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 02:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C2C522821BE
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA6136D;
	Thu, 28 Sep 2023 00:12:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C3110B;
	Thu, 28 Sep 2023 00:12:30 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D4A1;
	Wed, 27 Sep 2023 17:12:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-534659061afso5802024a12.3;
        Wed, 27 Sep 2023 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695859946; x=1696464746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WReGbAcbMlIjoLeWp3XBRLnKQ2ZamO7erRTXM1W4SO8=;
        b=ItWmX53iBihN12Sh5lKW4UXeV/zx09m6S7u8mXs7tC2d63W9yX+foSGDJt1ZBI6lso
         sJewqKhpmrVpIUlox9bRIcrDOZypImwNiWFrDOlJBhsvRcULe5E0EqakxQ6OrTzjmhnA
         D8NIvL50mOG1qRT8zlrWbYFjRQ/f+j813TTivqbyPcdWte9B3vciQOWh9v2ZqKKTV0JX
         FTeNSS31nVeyJMNg8gIj5qgL6ZFTqijrdqvyIEeqfJ2Noec462e43+AcTBik8hWjDa4T
         0wEvLyYQzl0s564gCm8sflTe2AjTPJkYoTXLFvaw7KrWcrd/Jpnym5LFpCbA6MOvryyV
         AAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695859946; x=1696464746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WReGbAcbMlIjoLeWp3XBRLnKQ2ZamO7erRTXM1W4SO8=;
        b=Ft5giZzwOkeiIAveKBb8GAatvDKO7pGDli+vahR1kPlMBas+H3oue5rrwvhqilj5wo
         RE7tJb20sS5cpYaTiGNOKgvR56c7wcwGspaSPjRKP43Bi8sCovBfXT98MCsPoSNDmtMl
         2IOaxH5ijzP8wy9jUbaT7xXUuh75H1AcdYK4uvRsyxjZS2I6J3FOWP8GwmffjBvlesZK
         BdF1j+Z+T8Urf8N6g27a8iCb4nW5KoIPXp91Y08amzM6jAyLYYUk5iy3PO38s4w5/wXl
         L7K50V+k3DX1GCQDQqyBiVE/G9PesJboB4HvhLhcvO+6lgTwW085eE+XrI9C1RbsSPsB
         OhTw==
X-Gm-Message-State: AOJu0YxMDyjDOkE/KcJmy61eQuE3q0qjbUqOhBwCgW1c5UxpYxhlaqS7
	LUtWXVeJ0LS/VpkYJ0oS+1RtpRTZQeaRGUJHy7A=
X-Google-Smtp-Source: AGHT+IEIqo/cp2gILHabcShj+gFrAY9wAWb52b+II8Cp4SIS+e/Ou5FTdd6hNuoe4UYar4OyM7VZxKOS9ATKiCoeihA=
X-Received: by 2002:a17:906:6a0d:b0:9a1:db2e:9dc0 with SMTP id
 qw13-20020a1709066a0d00b009a1db2e9dc0mr4116731ejc.44.1695859946034; Wed, 27
 Sep 2023 17:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-5-daniel@iogearbox.net>
In-Reply-To: <20230926055913.9859-5-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 17:12:14 -0700
Message-ID: <CAEf4BzbOD0CWrV39jOAR-DLUC8ntFVQKC9R92fp0o49VMJT0QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] libbpf: Add link-based API for meta
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 10:59=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> This adds bpf_program__attach_meta() API to libbpf. Overall it is very
> similar to tcx. The API looks as following:
>
>   LIBBPF_API struct bpf_link *
>   bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
>                            bool peer_device, const struct bpf_meta_opts *=
opts);
>
> The struct bpf_meta_opts is done in similar way as struct bpf_tcx_opts.
> bpf_program__attach_meta() compared to bpf_program__attach_tcx() has one
> additional argument, that is peer_device. The latter denotes whether the
> program should be attached to the relative peer of ifindex or whether it
> should be attached to ifindex itself.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/bpf.c      | 16 +++++++++++
>  tools/lib/bpf/bpf.h      |  5 ++++
>  tools/lib/bpf/libbpf.c   | 61 ++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h   | 15 ++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 92 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b0f1913763a3..f1335333b63c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -810,6 +810,22 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, tcx))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_META_PRIMARY:
> +       case BPF_META_PEER:

thinking out loud: should this be expected_attach_type during program
load? Or is it going to be common for primary and peer to be exactly
the same instance of a BPF program? If BPF_META_PRIMARY or
BPF_META_PEER is expected_attach_type, it seems to be a more natural
API where you'll be just saying "bpf_program__attach_meta(prog,
ifindex)" and whether it's primary or peer will be determined by SEC()
definition (SEC("meta/primary") vs SEC("meta/peer"))?

> +               relative_fd =3D OPTS_GET(opts, meta.relative_fd, 0);
> +               relative_id =3D OPTS_GET(opts, meta.relative_id, 0);
> +               if (relative_fd && relative_id)
> +                       return libbpf_err(-EINVAL);
> +               if (relative_id) {
> +                       attr.link_create.meta.relative_id =3D relative_id=
;
> +                       attr.link_create.flags |=3D BPF_F_ID;
> +               } else {
> +                       attr.link_create.meta.relative_fd =3D relative_fd=
;
> +               }
> +               attr.link_create.meta.expected_revision =3D OPTS_GET(opts=
, meta.expected_revision, 0);
> +               if (!OPTS_ZEROED(opts, meta))
> +                       return libbpf_err(-EINVAL);
> +               break;
>         default:
>                 if (!OPTS_ZEROED(opts, flags))
>                         return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 74c2887cfd24..175cfb95a175 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -415,6 +415,11 @@ struct bpf_link_create_opts {
>                         __u32 relative_id;
>                         __u64 expected_revision;
>                 } tcx;
> +               struct {
> +                       __u32 relative_fd;
> +                       __u32 relative_id;
> +                       __u64 expected_revision;
> +               } meta;
>         };
>         size_t :0;
>  };
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b4758e54a815..4d4da8ba2179 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -121,6 +121,8 @@ static const char * const attach_type_name[] =3D {
>         [BPF_TCX_INGRESS]               =3D "tcx_ingress",
>         [BPF_TCX_EGRESS]                =3D "tcx_egress",
>         [BPF_TRACE_UPROBE_MULTI]        =3D "trace_uprobe_multi",
> +       [BPF_META_PRIMARY]              =3D "meta",
> +       [BPF_META_PEER]                 =3D "meta",
>  };
>
>  static const char * const link_type_name[] =3D {
> @@ -137,6 +139,7 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_NETFILTER]               =3D "netfilter",
>         [BPF_LINK_TYPE_TCX]                     =3D "tcx",
>         [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
> +       [BPF_LINK_TYPE_META]                    =3D "meta",
>  };
>
>  static const char * const map_type_name[] =3D {
> @@ -8910,6 +8913,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE), /* depre=
cated / legacy, use tcx */
>         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE), /* depre=
cated / legacy, use tcx */
>         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE), /* depre=
cated / legacy, use tcx */
> +       SEC_DEF("meta",                 SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_t=
p),
>         SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_t=
p),
>         SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, atta=
ch_raw_tp),
> @@ -12019,11 +12023,11 @@ static int attach_lsm(const struct bpf_program =
*prog, long cookie, struct bpf_li
>  }
>
>  static struct bpf_link *
> -bpf_program_attach_fd(const struct bpf_program *prog,
> -                     int target_fd, const char *target_name,
> -                     const struct bpf_link_create_opts *opts)
> +bpf_program_attach_fd_type(const struct bpf_program *prog,
> +                          int target_fd, const char *target_name,
> +                          enum bpf_attach_type attach_type,
> +                          const struct bpf_link_create_opts *opts)
>  {
> -       enum bpf_attach_type attach_type;
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link *link;
>         int prog_fd, link_fd;
> @@ -12038,8 +12042,6 @@ bpf_program_attach_fd(const struct bpf_program *p=
rog,
>         if (!link)
>                 return libbpf_err_ptr(-ENOMEM);
>         link->detach =3D &bpf_link__detach_fd;
> -
> -       attach_type =3D bpf_program__expected_attach_type(prog);
>         link_fd =3D bpf_link_create(prog_fd, target_fd, attach_type, opts=
);
>         if (link_fd < 0) {
>                 link_fd =3D -errno;
> @@ -12053,6 +12055,16 @@ bpf_program_attach_fd(const struct bpf_program *=
prog,
>         return link;
>  }
>
> +static struct bpf_link *
> +bpf_program_attach_fd(const struct bpf_program *prog,
> +                     int target_fd, const char *target_name,
> +                     const struct bpf_link_create_opts *opts)
> +{
> +       return bpf_program_attach_fd_type(prog, target_fd, target_name,
> +                                         bpf_program__expected_attach_ty=
pe(prog),
> +                                         opts);
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd=
)
>  {
> @@ -12106,6 +12118,43 @@ bpf_program__attach_tcx(const struct bpf_program=
 *prog, int ifindex,
>         return bpf_program_attach_fd(prog, ifindex, "tcx", &link_create_o=
pts);
>  }
>
> +struct bpf_link *
> +bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
> +                        bool peer_device, const struct bpf_meta_opts *op=
ts)

you mentioned that there are plans to also support cases where there
is no primary-peer. Is that going to be a primary-only setup or will
it be some third option? If the latter, should this `bool peer_device`
be an enum then?

> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
> +       enum bpf_attach_type attach_type;
> +       __u32 relative_id;
> +       int relative_fd;
> +
> +       if (!OPTS_VALID(opts, bpf_meta_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       relative_id =3D OPTS_GET(opts, relative_id, 0);
> +       relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> +       attach_type =3D peer_device ? BPF_META_PEER : BPF_META_PRIMARY;
> +
> +       /* validate we don't have unexpected combinations of non-zero fie=
lds */
> +       if (!ifindex) {
> +               pr_warn("prog '%s': target netdevice ifindex cannot be ze=
ro\n",
> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +       if (relative_fd && relative_id) {
> +               pr_warn("prog '%s': relative_fd and relative_id cannot be=
 set at the same time\n",
> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
> +       link_create_opts.meta.expected_revision =3D OPTS_GET(opts, expect=
ed_revision, 0);
> +       link_create_opts.meta.relative_fd =3D relative_fd;
> +       link_create_opts.meta.relative_id =3D relative_id;
> +       link_create_opts.flags =3D OPTS_GET(opts, flags, 0);
> +
> +       return bpf_program_attach_fd_type(prog, ifindex, "meta", attach_t=
ype,
> +                                         &link_create_opts);
> +}
> +
>  struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *=
prog,
>                                               int target_fd,
>                                               const char *attach_func_nam=
e)
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0e52621cba43..827d29cf9a06 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -800,6 +800,21 @@ LIBBPF_API struct bpf_link *
>  bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
>                         const struct bpf_tcx_opts *opts);
>
> +struct bpf_meta_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +       __u32 flags;
> +       __u32 relative_fd;
> +       __u32 relative_id;
> +       __u64 expected_revision;

nit: move flags to be the last, so we don't have that padding before
expected_revision?


> +       size_t :0;
> +};
> +#define bpf_meta_opts__last_field expected_revision
> +
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
> +                        bool peer_device, const struct bpf_meta_opts *op=
ts);
> +
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 57712321490f..2dd4fe2cba3d 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -397,6 +397,7 @@ LIBBPF_1.3.0 {
>                 bpf_obj_pin_opts;
>                 bpf_object__unpin;
>                 bpf_prog_detach_opts;
> +               bpf_program__attach_meta;
>                 bpf_program__attach_netfilter;
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
> --
> 2.34.1
>

