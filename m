Return-Path: <bpf+bounces-15602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1A7F3948
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 23:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BB5282A31
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384EA58129;
	Tue, 21 Nov 2023 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G3pUW2bX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E740D1AA
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:37:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db029574f13so6020044276.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700606269; x=1701211069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PhJ58DzGJEIVblaXAuceHul3/IImKCshOtqF3D3RDY=;
        b=G3pUW2bX8byqs35VWE2lNPVsBNcPlbaF5SlaScwyUrgiZSZs00xuRH+KAE+IEGFSEO
         iaMKubjto92VurzGn40vzoGHqbMnAyi1IEwwVT+TliIjIy9E+xnQhspWx1eYKR/PeMAX
         TDxIZpd6DUjkgW9Qgw/6ArBgbb7TlH7qK1AJoCjPXtW8BPEC4kXgSdVYK9KNSkJ/pPcQ
         4qixQneYFUV3fi5ukpH67Z0q/RN//VSyXW3MEgEz1xm8cgclFNDGHfccsjodCS8N9prM
         HWggSM4a45AxHT1/SM71jHFD2ku1cx41ruYKSRey7XXkvqxADsYeb7lOtMCs+VK9dQDy
         AfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606269; x=1701211069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PhJ58DzGJEIVblaXAuceHul3/IImKCshOtqF3D3RDY=;
        b=sEL1JeoDRcSRH66GtpG7ZpFQ0azNhBlxZtqjTsHIP4bc77olOSZK94bByiWv5gCOON
         1NSaUBDMILiD2CopCNMor+jmLenW3xDB8TKuHdJFhJmhjaYoKZkOt6PnbwAxst2ortWM
         AsGMdebFtUOHA3M0GEA+8cbaIZIYvsHzjUZZfKLoItid1DBACFfQJx/GOauUZWnvKm+E
         yQ2KEovmxs7uSiWB5hUOOzWQ4Qcb05BJU550+/AdgvXFWX7TvIENMnBaaBeUZgytZbGH
         ZwGGHBOmkNP4Xbp4Zb17npNTtF+zQE+up3bdyH1TwGmzDPMWhqikLsIHTKevf3K8YxQh
         SbYw==
X-Gm-Message-State: AOJu0Yx9TN9/eKnv615Us9d5VLWBhKYjD8MS/N45UGobZ6DPcaKr9dV2
	wqe3O9RklxS1iG93U9OliW0Bj3581WDC8yobR+khtQ==
X-Google-Smtp-Source: AGHT+IFagDuyax0DNgWQWewr4Jl8bk+ehoQOtcabRwSIbmpcVEP0szwxg8PkrH2pRvlyeDOVm1B6JRdrl1GS+tzgroM=
X-Received: by 2002:a81:5b06:0:b0:5bf:f907:e07c with SMTP id
 p6-20020a815b06000000b005bff907e07cmr437425ywb.33.1700606269085; Tue, 21 Nov
 2023 14:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com>
In-Reply-To: <20231121175640.9981-1-mkoutny@suse.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 21 Nov 2023 17:37:37 -0500
Message-ID: <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 12:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> The classifier modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism works also for
> classifier modules. (The same pattern exists e.g. for filesystem
> modules.)
>

Hi Michal,
Dumb question: What's speacial about the "tcf- '' that makes it work
better for filtering than existing "cls_" prefix? What about actions
(prefix "act_") etc?

cheers,
jamal

> Original module names remain unchanged.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  include/net/pkt_cls.h    | 1 +
>  net/sched/cls_api.c      | 2 +-
>  net/sched/cls_basic.c    | 1 +
>  net/sched/cls_bpf.c      | 1 +
>  net/sched/cls_cgroup.c   | 1 +
>  net/sched/cls_flow.c     | 1 +
>  net/sched/cls_flower.c   | 1 +
>  net/sched/cls_fw.c       | 1 +
>  net/sched/cls_matchall.c | 1 +
>  net/sched/cls_route.c    | 1 +
>  net/sched/cls_u32.c      | 1 +
>  11 files changed, 11 insertions(+), 1 deletion(-)
>
> This is primarily for TC subsystem maintainers where the
> request_module() resides but Cc list is large because of touches in
> various classifier modules.
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..424b4f889feb 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -24,6 +24,7 @@ struct tcf_walker {
>
>  int register_tcf_proto_ops(struct tcf_proto_ops *ops);
>  void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
> +#define MODULE_ALIAS_TCF(kind) MODULE_ALIAS("tcf-" __stringify(kind))
>
>  struct tcf_block_ext_info {
>         enum flow_block_binder_type binder_type;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..02fdcceee083 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held=
,
>  #ifdef CONFIG_MODULES
>         if (rtnl_held)
>                 rtnl_unlock();
> -       request_module("cls_%s", kind);
> +       request_module("tcf-%s", kind);
>         if (rtnl_held)
>                 rtnl_lock();
>         ops =3D __tcf_proto_lookup_ops(kind);
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index a1f56931330c..a3500ac7fc1a 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -328,6 +328,7 @@ static struct tcf_proto_ops cls_basic_ops __read_most=
ly =3D {
>         .bind_class     =3D       basic_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("basic");
>
>  static int __init init_basic(void)
>  {
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 382c7a71f81f..8d57ac155c0c 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -693,6 +693,7 @@ static struct tcf_proto_ops cls_bpf_ops __read_mostly=
 =3D {
>         .dump           =3D       cls_bpf_dump,
>         .bind_class     =3D       cls_bpf_bind_class,
>  };
> +MODULE_ALIAS_TCF("bpf");
>
>  static int __init cls_bpf_init_mod(void)
>  {
> diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
> index 7ee8dbf49ed0..0ded7d79894c 100644
> --- a/net/sched/cls_cgroup.c
> +++ b/net/sched/cls_cgroup.c
> @@ -209,6 +209,7 @@ static struct tcf_proto_ops cls_cgroup_ops __read_mos=
tly =3D {
>         .dump           =3D       cls_cgroup_dump,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("cgroup");
>
>  static int __init init_cgroup_cls(void)
>  {
> diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
> index 6ab317b48d6c..2806aa1254e1 100644
> --- a/net/sched/cls_flow.c
> +++ b/net/sched/cls_flow.c
> @@ -702,6 +702,7 @@ static struct tcf_proto_ops cls_flow_ops __read_mostl=
y =3D {
>         .walk           =3D flow_walk,
>         .owner          =3D THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("flow");
>
>  static int __init cls_flow_init(void)
>  {
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e5314a31f75a..739e09e0fa57 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -3633,6 +3633,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostl=
y =3D {
>         .owner          =3D THIS_MODULE,
>         .flags          =3D TCF_PROTO_OPS_DOIT_UNLOCKED,
>  };
> +MODULE_ALIAS_TCF("flower");
>
>  static int __init cls_fl_init(void)
>  {
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index afc534ee0a18..86c833885a2d 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -433,6 +433,7 @@ static struct tcf_proto_ops cls_fw_ops __read_mostly =
=3D {
>         .bind_class     =3D       fw_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("fw");
>
>  static int __init init_fw(void)
>  {
> diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
> index c4ed11df6254..21ba73978c6a 100644
> --- a/net/sched/cls_matchall.c
> +++ b/net/sched/cls_matchall.c
> @@ -398,6 +398,7 @@ static struct tcf_proto_ops cls_mall_ops __read_mostl=
y =3D {
>         .bind_class     =3D mall_bind_class,
>         .owner          =3D THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("matchall");
>
>  static int __init cls_mall_init(void)
>  {
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 12a505db4183..a4701c0752df 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -671,6 +671,7 @@ static struct tcf_proto_ops cls_route4_ops __read_mos=
tly =3D {
>         .bind_class     =3D       route4_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("route");
>
>  static int __init init_route4(void)
>  {
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index d5bdfd4a7655..a969adbd7423 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1453,6 +1453,7 @@ static struct tcf_proto_ops cls_u32_ops __read_most=
ly =3D {
>         .bind_class     =3D       u32_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("u32");
>
>  static int __init init_u32(void)
>  {
> --
> 2.42.1
>

