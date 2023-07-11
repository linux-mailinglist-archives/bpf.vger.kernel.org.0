Return-Path: <bpf+bounces-4721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C885674E5A2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D691C20CA6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256004698;
	Tue, 11 Jul 2023 04:00:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1934410;
	Tue, 11 Jul 2023 04:00:49 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D769E55;
	Mon, 10 Jul 2023 21:00:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so8299661e87.1;
        Mon, 10 Jul 2023 21:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689048044; x=1691640044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8525MQlCEJwenXrCKQZ9N/GqdVbsEYF01fFBpjmnsA=;
        b=KrA3FoaV7f6M8n95Ytko9hmzbqAZ5DlKEiNtc9GTlrnizIgKi44Gie5qKlkRKZhxNf
         9fuyi6NOL1mJgeUc0kdm5UP//p237dUV5WL8GAxlaGvHTroa67dqUIh8tSpDQs5P8D43
         El03+/sZaToduBmaJ8xeHbET9mvhH5WjOozrQ12+KiEmiG+khH6JcVfhU67B/AHVxd44
         ODjyjJkZUvKP/3EbOvrjrKljVE9SXdCMv6Rc1Za1v54Jz3H6/VshNFbecvHt/CeGZ4VJ
         Cw4Y7skqBHyAtsudbroHK2C0LyqBvAr3/pRhbOCO/PRjZhVD2AunXNrs6RgjQD/EjhIN
         jLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048044; x=1691640044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8525MQlCEJwenXrCKQZ9N/GqdVbsEYF01fFBpjmnsA=;
        b=Lr500riFK18sWk0Zd0jZ1fYChEsh9aQ19xzfEbQV5em3Zz5d3Ya8S5VWFCn3ttbapc
         KuCkqgffVNppK37jnewahaSpqig0OvM3LzZ4a6p0um4+hXybKsI6nUppa9nwSPJ06BVL
         YnDFIRrVR0pVozQsQHaLONNeu5e3pV2ekyUCv21q2kDoPjJqNj0t5whRKFVD6c32xR5S
         uV+tE360KYzWYFDFgMptgtiSrDPKECP4k0mkJ2SIBUz+acy0NcLfDsD5jKR/NGte5dmf
         DUdEAr43YITK6LsaFnbLK13X9WHy+Uo2UPL8H8/6+55FGqhbiNju6Iqxo406W/gQE2a0
         +Z/g==
X-Gm-Message-State: ABy/qLa2WL2WpGjMigy0llgYZyzpbTPxh/iR2+kAaab+F1fXxgXLkjMA
	SY7buhc+Z/k3o9ZeLH4jHX55m1ZhcPfgf96Vdek=
X-Google-Smtp-Source: APBJJlHdxAvBFl2cM6IBEAFkCLnnj6UIsFuY5RUrwfeRY1EC2T0oCD4WtnkL5f0SRDZQyfNlonrtpPReuVHFVs4bwsc=
X-Received: by 2002:a05:6512:6d3:b0:4f8:5ade:44b5 with SMTP id
 u19-20020a05651206d300b004f85ade44b5mr13405879lff.53.1689048043714; Mon, 10
 Jul 2023 21:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710201218.19460-1-daniel@iogearbox.net> <20230710201218.19460-5-daniel@iogearbox.net>
In-Reply-To: <20230710201218.19460-5-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 21:00:31 -0700
Message-ID: <CAEf4Bzb_qyd9KbNU6=vs=H3Nbqt6QNNo++JVRCUrQ9aFW4psMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Add link-based API for tcx
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 1:12=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Implement tcx BPF link support for libbpf.
>
> The bpf_program__attach_fd() API has been refactored slightly in order to=
 pass
> bpf_link_create_opts pointer as input.
>
> A new bpf_program__attach_tcx() has been added on top of this which allow=
s for
> passing all relevant data via extensible struct bpf_tcx_opts.
>
> The program sections tcx/ingress and tcx/egress correspond to the hook lo=
cations
> for tc ingress and egress, respectively.
>
> For concrete usage examples, see the extensive selftests that have been
> developed as part of this series.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/bpf.c      | 19 ++++++++++--
>  tools/lib/bpf/bpf.h      |  5 ++++
>  tools/lib/bpf/libbpf.c   | 62 ++++++++++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h   | 16 +++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 92 insertions(+), 11 deletions(-)
>

Pretty minor nits, I think ifindex move to be mandatory argument is
the most consequential, as it's an API. With that addressed, please
add my ack for next rev

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 3dfc43b477c3..d513c226b9aa 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -717,9 +717,9 @@ int bpf_link_create(int prog_fd, int target_fd,
>                     const struct bpf_link_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_create)=
;
> -       __u32 target_btf_id, iter_info_len;
> +       __u32 target_btf_id, iter_info_len, relative_id;
> +       int fd, err, relative;

nit: maybe make these new vars local to the TCX cases branch below?

>         union bpf_attr attr;
> -       int fd, err;
>
>         if (!OPTS_VALID(opts, bpf_link_create_opts))
>                 return libbpf_err(-EINVAL);
> @@ -781,6 +781,21 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, netfilter))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_TCX_INGRESS:
> +       case BPF_TCX_EGRESS:
> +               relative =3D OPTS_GET(opts, tcx.relative_fd, 0);
> +               relative_id =3D OPTS_GET(opts, tcx.relative_id, 0);
> +               if (relative > 0 && relative_id)
> +                       return libbpf_err(-EINVAL);
> +               if (relative_id) {
> +                       relative =3D relative_id;
> +                       attr.link_create.flags |=3D BPF_F_ID;
> +               }

Well, I have the same nit as in the previous patch, this "relative =3D
relative_id" is both confusing because of naming asymmetry (no
relative_fd throws me off), and also unnecessary updating of the
state. link_create.flags |=3D BPF_F_ID is inevitable, but the rest can
be more straightforward, IMO

> +               attr.link_create.tcx.relative_fd =3D relative;
> +               attr.link_create.tcx.expected_revision =3D OPTS_GET(opts,=
 tcx.expected_revision, 0);
> +               if (!OPTS_ZEROED(opts, tcx))
> +                       return libbpf_err(-EINVAL);
> +               break;
>         default:
>                 if (!OPTS_ZEROED(opts, flags))
>                         return libbpf_err(-EINVAL);

[...]

> +struct bpf_link *
> +bpf_program__attach_tcx(const struct bpf_program *prog,
> +                       const struct bpf_tcx_opts *opts)
> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
> +       __u32 relative_id, flags;
> +       int ifindex, relative_fd;
> +
> +       if (!OPTS_VALID(opts, bpf_tcx_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       relative_id =3D OPTS_GET(opts, relative_id, 0);
> +       relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> +       flags =3D OPTS_GET(opts, flags, 0);
> +       ifindex =3D OPTS_GET(opts, ifindex, 0);
> +
> +       /* validate we don't have unexpected combinations of non-zero fie=
lds */
> +       if (!ifindex) {
> +               pr_warn("prog '%s': target netdevice ifindex cannot be ze=
ro\n",
> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }

given ifindex is non-optional, then it makes more sense to have it as
a mandatory argument between prog and opts in
bpf_program__attach_tcx(), instead of as a field of an opts struct

> +       if (relative_fd > 0 && relative_id) {

this asymmetrical check is a bit distracting. And also, if someone
specifies negative FD and positive ID, that's also a bad combo and we
shouldn't just ignore invalid FD, right? So I'd have a nice and clean

if (relative_fd && relative_id) { /* bad */ }

> +               pr_warn("prog '%s': relative_fd and relative_id cannot be=
 set at the same time\n",
> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +       if (relative_id)
> +               flags |=3D BPF_F_ID;

I think bpf_link_create() will add this flag anyways, so can drop this
adjustment logic here?

> +
> +       link_create_opts.tcx.expected_revision =3D OPTS_GET(opts, expecte=
d_revision, 0);
> +       link_create_opts.tcx.relative_fd =3D relative_fd;
> +       link_create_opts.tcx.relative_id =3D relative_id;
> +       link_create_opts.flags =3D flags;
> +
> +       /* target_fd/target_ifindex use the same field in LINK_CREATE */
> +       return bpf_program_attach_fd(prog, ifindex, "tc", &link_create_op=
ts);

s/tc/tcx/ ?

>  }
>
>  struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *=
prog,
> @@ -11917,11 +11956,16 @@ struct bpf_link *bpf_program__attach_freplace(c=
onst struct bpf_program *prog,
>         }
>
>         if (target_fd) {
> +               LIBBPF_OPTS(bpf_link_create_opts, target_opts);
> +
>                 btf_id =3D libbpf_find_prog_btf_id(attach_func_name, targ=
et_fd);
>                 if (btf_id < 0)
>                         return libbpf_err_ptr(btf_id);
>
> -               return bpf_program__attach_fd(prog, target_fd, btf_id, "f=
replace");
> +               target_opts.target_btf_id =3D btf_id;
> +
> +               return bpf_program_attach_fd(prog, target_fd, "freplace",
> +                                            &target_opts);
>         } else {
>                 /* no target, so use raw_tracepoint_open for compatibilit=
y
>                  * with old kernels
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 10642ad69d76..33f60a318e81 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -733,6 +733,22 @@ LIBBPF_API struct bpf_link *
>  bpf_program__attach_netfilter(const struct bpf_program *prog,
>                               const struct bpf_netfilter_opts *opts);
>
> +struct bpf_tcx_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +       int ifindex;

is ifindex optional or it's expected to always be specified? If the
latter, then I'd move ifindex out of opts and make it second arg of
bpf_program__attach_tcx, between prog and opts

> +       __u32 flags;
> +       __u32 relative_fd;
> +       __u32 relative_id;
> +       __u64 expected_revision;
> +       size_t :0;
> +};
> +#define bpf_tcx_opts__last_field expected_revision
> +
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_tcx(const struct bpf_program *prog,
> +                       const struct bpf_tcx_opts *opts);
> +
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a95d39bbef90..2a2db5c78048 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -397,4 +397,5 @@ LIBBPF_1.3.0 {
>                 bpf_obj_pin_opts;
>                 bpf_program__attach_netfilter;
>                 bpf_prog_detach_opts;
> +               bpf_program__attach_tcx;

heh, now we definitely screwed up sorting ;)

>  } LIBBPF_1.2.0;

> --
> 2.34.1
>

