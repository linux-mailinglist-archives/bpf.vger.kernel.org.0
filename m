Return-Path: <bpf+bounces-20868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF087844851
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F87B27851
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E53EA93;
	Wed, 31 Jan 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="I45K354d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310453E499
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730801; cv=none; b=EIz4j6m5qSTtzY1jcJXQ2dQ7QBpE3XOv5LqNDIGlzkUff2/QZSeh/TsMy2d7+LZ3vGxYZfu4aNY2Untm4nEk45FU73ruQd991mnc2iA/DJCIcUmv5cvl0UZt1lpo+sDUdmLIlXnmQBrgRq3WmjASqFQAN7b0YQMVwjWU2IxPjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730801; c=relaxed/simple;
	bh=NRMb+2PV8Q9vzRLAYkrArcII/ZX3rb+7RnMXgd8uMWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6iDnhBjnsJpL0d5PkZdHD3rk3cddT8x3tIP0cN1P45S9ujKZdQevjycyTV50pNKDFdg+pru6qzk2Wzi0di+IWoxRHhpJY1ytF6dlXJ1bLTlfwxUhXLbiLvkmHIIobpKAqOFQg+iLEJ8mtfzjy1aHJODKe8zSEKWZW0NNkSgX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=I45K354d; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc68150f46fso94808276.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706730798; x=1707335598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbXeis8CtFXgU6snPwnEN2qvedAhzb+8Us4+2fBZDN8=;
        b=I45K354dg9A2HvV5hVWN9wZqZgJB42UKPhrLONPfEsdEM0NhKiQc8wsi+RZwOZmzUA
         +nnrEC9UR7cTASrk2JaNbIs1NYJ01DAXq/d1rgZWyh+Lkx6eWkBVMNyU5xS3RZlLL6EB
         QZXTnYrtXc1j5q8pSjIZ/xkReSYPGNpa4cW6UWKBt9erEHZWgXQ8LJxJZTZaYp7vNAj0
         79tGshvh5BQSA6P16FhxG6/s/F2k18Hv0J4haV2UVH3ADOzqWtszvKK70j3CTNZnDEzV
         u9WBs82UZwYmN+A8tLnmrZt9B6bspsUW6gG2vnmbOfzIpZOA5b9Q5EYgzCsbOQOTIw++
         OiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730798; x=1707335598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbXeis8CtFXgU6snPwnEN2qvedAhzb+8Us4+2fBZDN8=;
        b=SMdm0jrjE6HIgn2hc1tDqXyortrwuaSCS+7WqWh9GYZaEWqkWynQev9vDEhRczrv/K
         qPPG/RaEUd3ca4dfFgkJPlJUOmFMX357CXj0GSK5t2wuum8TVN/DGY2ydYxGUvzjoWPP
         ntBQezLSSmV+ibfcBGIee5Y9OnDOS9z6UnxgvvVIevak+DPWzkR4RHNSUBN4yl3iOVSZ
         e40cBHph3TmIJZxojdS6Zd2I5Gn/R8WyzAo43h3nPiyJLtbaoIYdl6qppRX+Rj0HqoMH
         u3pLk7GLlRLI7TDqvcx7PnJUTA61UBwPXOiEMY/yEdHuXx31G5q78PIGeKvKHIkf5g0m
         lOLg==
X-Gm-Message-State: AOJu0Yx/cHGgPSAQBRVgxHbSvh3Z6qV4XYZz57E7g1nor0QE6vlti7Nf
	fwjSm+1km+cnhO6ZuYqmmh3LBeJnMUqWQvJ4MQOJCKg3KhJV5qjDuWfQ8Hqyw+IwupP01xV8G4K
	kKvtcUjPecGspEHnbLVMjIn1bu7COmAT8VX4U
X-Google-Smtp-Source: AGHT+IHRLyKoCUP7cEiF8nqSwcburomLqObss/hLppMvI7cdN44kACofbcxjst6R3mZVZHM2AHyL3pce6B1hcAiECFo=
X-Received: by 2002:a25:c702:0:b0:dc2:554f:ef44 with SMTP id
 w2-20020a25c702000000b00dc2554fef44mr2858524ybe.18.1706730797932; Wed, 31 Jan
 2024 11:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131170019.106122-1-stephen@networkplumber.org>
In-Reply-To: <20240131170019.106122-1-stephen@networkplumber.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 31 Jan 2024 14:53:06 -0500
Message-ID: <CAM0EoMnrs7h8SZbex27OosxkcrgyhZC1KQK0F=+XfA-ewOGy8g@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: report errors with extack
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:00=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> While working a BPF action, found that the error handling was
> limited. The support of external ack was only added to some
> but not all actions.
>
> When an action detects invalid parameters, it should
> be adding an external ack to netlink so that the user is
> able to diagnose the issue.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/act_bpf.c      | 31 ++++++++++++++++++++++---------
>  net/sched/act_connmark.c |  8 ++++++--
>  net/sched/act_csum.c     |  8 ++++++--
>  net/sched/act_gact.c     | 14 +++++++++++---
>  net/sched/act_gate.c     | 15 +++++++++++----
>  net/sched/act_ife.c      |  8 ++++++--
>  net/sched/act_nat.c      |  9 +++++++--
>  net/sched/act_police.c   | 13 ++++++++++---
>  net/sched/act_sample.c   |  8 ++++++--
>  net/sched/act_simple.c   |  9 +++++++--
>  net/sched/act_skbedit.c  | 13 ++++++++++---
>  net/sched/act_skbmod.c   |  9 +++++++--
>  net/sched/act_vlan.c     |  8 ++++++--
>  13 files changed, 115 insertions(+), 38 deletions(-)
>
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 6cfee6658103..f8a03d3bbf20 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -184,7 +184,8 @@ static const struct nla_policy act_bpf_policy[TCA_ACT=
_BPF_MAX + 1] =3D {
>                                     .len =3D sizeof(struct sock_filter) *=
 BPF_MAXINSNS },
>  };
>
> -static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg =
*cfg)
> +static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg =
*cfg,
> +                                struct netlink_ext_ack *extack)
>  {
>         struct sock_filter *bpf_ops;
>         struct sock_fprog_kern fprog_tmp;
> @@ -193,12 +194,16 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb=
, struct tcf_bpf_cfg *cfg)
>         int ret;
>
>         bpf_num_ops =3D nla_get_u16(tb[TCA_ACT_BPF_OPS_LEN]);
> -       if (bpf_num_ops > BPF_MAXINSNS || bpf_num_ops =3D=3D 0)
> +       if (bpf_num_ops > BPF_MAXINSNS || bpf_num_ops =3D=3D 0) {
> +               NL_SET_ERR_MSG_MOD(extack, "Invalid number of BPF instruc=
tions");
>                 return -EINVAL;
> +       }
>
>         bpf_size =3D bpf_num_ops * sizeof(*bpf_ops);
> -       if (bpf_size !=3D nla_len(tb[TCA_ACT_BPF_OPS]))
> +       if (bpf_size !=3D nla_len(tb[TCA_ACT_BPF_OPS])) {
> +               NL_SET_ERR_MSG_MOD(extack, "BPF instruction size");
>                 return -EINVAL;
> +       }
>
>         bpf_ops =3D kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_=
KERNEL);
>         if (bpf_ops =3D=3D NULL)
> @@ -221,7 +226,8 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, =
struct tcf_bpf_cfg *cfg)
>         return 0;
>  }
>
> -static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg =
*cfg)
> +static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg =
*cfg,
> +                                struct netlink_ext_ack *extack)
>  {
>         struct bpf_prog *fp;
>         char *name =3D NULL;
> @@ -230,8 +236,10 @@ static int tcf_bpf_init_from_efd(struct nlattr **tb,=
 struct tcf_bpf_cfg *cfg)
>         bpf_fd =3D nla_get_u32(tb[TCA_ACT_BPF_FD]);
>
>         fp =3D bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_SCHED_ACT);
> -       if (IS_ERR(fp))
> +       if (IS_ERR(fp)) {
> +               NL_SET_ERR_MSG_MOD(extack, "BPF program type mismatch");
>                 return PTR_ERR(fp);
> +       }
>
>         if (tb[TCA_ACT_BPF_NAME]) {
>                 name =3D nla_memdup(tb[TCA_ACT_BPF_NAME], GFP_KERNEL);
> @@ -292,16 +300,20 @@ static int tcf_bpf_init(struct net *net, struct nla=
ttr *nla,
>         int ret, res =3D 0;
>         u32 index;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Bpf requires attributes to be=
 passed");
>                 return -EINVAL;
> +       }
>
>         ret =3D nla_parse_nested_deprecated(tb, TCA_ACT_BPF_MAX, nla,
>                                           act_bpf_policy, NULL);
>         if (ret < 0)
>                 return ret;
>
> -       if (!tb[TCA_ACT_BPF_PARMS])
> +       if (!tb[TCA_ACT_BPF_PARMS]) {

if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_ACT_BPF_PARMS)  to set the
other extack fields


> +               NL_SET_ERR_MSG_MOD(extack, "Missing required bpf paramete=
rs");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_ACT_BPF_PARMS]);
>         index =3D parm->index;
> @@ -336,14 +348,15 @@ static int tcf_bpf_init(struct net *net, struct nla=
ttr *nla,
>         is_ebpf =3D tb[TCA_ACT_BPF_FD];
>
>         if (is_bpf =3D=3D is_ebpf) {
> +               NL_SET_ERR_MSG_MOD(extack, "Can not specify both BPF fd a=
nd ops");
>                 ret =3D -EINVAL;
>                 goto put_chain;
>         }
>
>         memset(&cfg, 0, sizeof(cfg));
>
> -       ret =3D is_bpf ? tcf_bpf_init_from_ops(tb, &cfg) :
> -                      tcf_bpf_init_from_efd(tb, &cfg);
> +       ret =3D is_bpf ? tcf_bpf_init_from_ops(tb, &cfg, extack) :
> +                      tcf_bpf_init_from_efd(tb, &cfg, extack);
>         if (ret < 0)
>                 goto put_chain;
>
> diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> index f8762756657d..0964d10dfc04 100644
> --- a/net/sched/act_connmark.c
> +++ b/net/sched/act_connmark.c
> @@ -110,16 +110,20 @@ static int tcf_connmark_init(struct net *net, struc=
t nlattr *nla,
>         int ret =3D 0, err;
>         u32 index;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Connmark requires attributes =
to be passed");
>                 return -EINVAL;
> +       }
>
>         ret =3D nla_parse_nested_deprecated(tb, TCA_CONNMARK_MAX, nla,
>                                           connmark_policy, NULL);
>         if (ret < 0)
>                 return ret;
>
> -       if (!tb[TCA_CONNMARK_PARMS])
> +       if (!tb[TCA_CONNMARK_PARMS]) {

Same thing..

> +               NL_SET_ERR_MSG(extack, "Missing required connmark paramet=
ers");
>                 return -EINVAL;
> +       }
>
>         nparms =3D kzalloc(sizeof(*nparms), GFP_KERNEL);
>         if (!nparms)
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 7f8b1f2f2ed9..7c7f74e37528 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -55,16 +55,20 @@ static int tcf_csum_init(struct net *net, struct nlat=
tr *nla,
>         int ret =3D 0, err;
>         u32 index;
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Checksum requires attributes =
to be passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_CSUM_MAX, nla, csum_p=
olicy,
>                                           NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_CSUM_PARMS] =3D=3D NULL)
> +       if (!tb[TCA_CSUM_PARMS]) {

Same thing...

> +               NL_SET_ERR_MSG(extack, "Missing required checksum paramet=
ers");
>                 return -EINVAL;
> +       }
>         parm =3D nla_data(tb[TCA_CSUM_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index 4af3b7ec249f..5d04bcd5115e 100644
> --- a/net/sched/act_gact.c
> +++ b/net/sched/act_gact.c
> @@ -68,16 +68,21 @@ static int tcf_gact_init(struct net *net, struct nlat=
tr *nla,
>         struct tc_gact_p *p_parm =3D NULL;
>  #endif
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG(extack, "Gact requires attributes to be pa=
ssed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_GACT_MAX, nla, gact_p=
olicy,
>                                           NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_GACT_PARMS] =3D=3D NULL)
> +       if (!tb[TCA_GACT_PARMS]) {

Same..


> +               NL_SET_ERR_MSG_MOD(extack, "Missing required gact paramet=
ers");
>                 return -EINVAL;
> +       }
> +
>         parm =3D nla_data(tb[TCA_GACT_PARMS]);
>         index =3D parm->index;
>
> @@ -87,8 +92,11 @@ static int tcf_gact_init(struct net *net, struct nlatt=
r *nla,
>  #else
>         if (tb[TCA_GACT_PROB]) {
>                 p_parm =3D nla_data(tb[TCA_GACT_PROB]);
> -               if (p_parm->ptype >=3D MAX_RAND)
> +               if (p_parm->ptype >=3D MAX_RAND) {
> +                       NL_SET_ERR_MSG(extack, "Invalid ptype in gact pro=
b");
>                         return -EINVAL;
> +               }
> +
>                 if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
>                         NL_SET_ERR_MSG(extack,
>                                        "goto chain not allowed on fallbac=
k");
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c681cd011afd..c9e32822938c 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -239,8 +239,10 @@ static int parse_gate_list(struct nlattr *list_attr,
>         int err, rem;
>         int i =3D 0;
>
> -       if (!list_attr)
> +       if (!list_attr) {
> +               NL_SET_ERR_MSG(extack, "Gate missing attributes");
>                 return -EINVAL;
> +       }
>
>         nla_for_each_nested(n, list_attr, rem) {
>                 if (nla_type(n) !=3D TCA_GATE_ONE_ENTRY) {
> @@ -317,15 +319,19 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
>         ktime_t start;
>         u32 index;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Gate requires attributes to b=
e passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested(tb, TCA_GATE_MAX, nla, gate_policy, exta=
ck);
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_GATE_PARMS])
> +       if (!tb[TCA_GATE_PARMS]) {

Here...

> +               NL_SET_ERR_MSG_MOD(extack, "Missing required gate paramet=
ers");
>                 return -EINVAL;
> +       }
>
>         if (tb[TCA_GATE_CLOCKID]) {
>                 clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
> @@ -343,7 +349,7 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
>                         tk_offset =3D TK_OFFS_TAI;
>                         break;
>                 default:
> -                       NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
> +                       NL_SET_ERR_MSG_MOD(extack, "Invalid 'clockid'");
>                         return -EINVAL;
>                 }
>         }
> @@ -409,6 +415,7 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
>                         cycle =3D ktime_add_ns(cycle, entry->interval);
>                 cycletime =3D cycle;
>                 if (!cycletime) {
> +                       NL_SET_ERR_MSG_MOD(extack, "cycle time is zero");
>                         err =3D -EINVAL;
>                         goto chain_put;
>                 }
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 0e867d13beb5..85a58cfb23f3 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -508,8 +508,10 @@ static int tcf_ife_init(struct net *net, struct nlat=
tr *nla,
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_IFE_PARMS])
> +       if (!tb[TCA_IFE_PARMS]) {

Here...
Going to stop here - there are more further down. You get the gist..

cheers,
jamal

> +               NL_SET_ERR_MSG_MOD(extack, "Missing required ife paramete=
rs");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_IFE_PARMS]);
>
> @@ -517,8 +519,10 @@ static int tcf_ife_init(struct net *net, struct nlat=
tr *nla,
>          * they cannot run as the same time. Check on all other values wh=
ich
>          * are not supported right now.
>          */
> -       if (parm->flags & ~IFE_ENCODE)
> +       if (parm->flags & ~IFE_ENCODE) {
> +               NL_SET_ERR_MSG_MOD(extack, "Invalid ife flag parameter");
>                 return -EINVAL;
> +       }
>
>         p =3D kzalloc(sizeof(*p), GFP_KERNEL);
>         if (!p)
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index a180e724634e..a990d0c626cd 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -46,16 +46,21 @@ static int tcf_nat_init(struct net *net, struct nlatt=
r *nla, struct nlattr *est,
>         struct tcf_nat *p;
>         u32 index;
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Nat action requires attribute=
s");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_NAT_MAX, nla, nat_pol=
icy,
>                                           NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_NAT_PARMS] =3D=3D NULL)
> +       if (!tb[TCA_NAT_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Nat action parameters missing=
");
>                 return -EINVAL;
> +       }
> +
>         parm =3D nla_data(tb[TCA_NAT_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index e119b4a3db9f..3eb41233257b 100644
> --- a/net/sched/act_police.c
> +++ b/net/sched/act_police.c
> @@ -56,19 +56,26 @@ static int tcf_police_init(struct net *net, struct nl=
attr *nla,
>         u64 rate64, prate64;
>         u64 pps, ppsburst;
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Police requires attributes");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_POLICE_MAX, nla,
>                                           police_policy, NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_POLICE_TBF] =3D=3D NULL)
> +       if (!tb[TCA_POLICE_TBF]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required police actio=
n parameters");
>                 return -EINVAL;
> +       }
> +
>         size =3D nla_len(tb[TCA_POLICE_TBF]);
> -       if (size !=3D sizeof(*parm) && size !=3D sizeof(struct tc_police_=
compat))
> +       if (size !=3D sizeof(*parm) && size !=3D sizeof(struct tc_police_=
compat)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Invalid size for police actio=
n parameters");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_POLICE_TBF]);
>         index =3D parm->index;
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index c5c61efe6db4..2442e001d92e 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -49,15 +49,19 @@ static int tcf_sample_init(struct net *net, struct nl=
attr *nla,
>         bool exists =3D false;
>         int ret, err;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Sample requires attributes to=
 be passed");
>                 return -EINVAL;
> +       }
>         ret =3D nla_parse_nested_deprecated(tb, TCA_SAMPLE_MAX, nla,
>                                           sample_policy, NULL);
>         if (ret < 0)
>                 return ret;
>
> -       if (!tb[TCA_SAMPLE_PARMS])
> +       if (!tb[TCA_SAMPLE_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required sample actio=
n parameters");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_SAMPLE_PARMS]);
>         index =3D parm->index;
> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index 0a3e92888295..02b8e42c1bdd 100644
> --- a/net/sched/act_simple.c
> +++ b/net/sched/act_simple.c
> @@ -100,16 +100,20 @@ static int tcf_simp_init(struct net *net, struct nl=
attr *nla,
>         int ret =3D 0, err;
>         u32 index;
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Sample requires attributes to=
 be passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_DEF_MAX, nla, simple_=
policy,
>                                           NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_DEF_PARMS] =3D=3D NULL)
> +       if (!tb[TCA_DEF_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required sample actio=
n parameters");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_DEF_PARMS]);
>         index =3D parm->index;
> @@ -121,6 +125,7 @@ static int tcf_simp_init(struct net *net, struct nlat=
tr *nla,
>                 return ACT_P_BOUND;
>
>         if (tb[TCA_DEF_DATA] =3D=3D NULL) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing simple action default=
 data");
>                 if (exists)
>                         tcf_idr_release(*a, bind);
>                 else
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index 754f78b35bb8..671ca64a2c33 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -133,16 +133,20 @@ static int tcf_skbedit_init(struct net *net, struct=
 nlattr *nla,
>         int ret =3D 0, err;
>         u32 index;
>
> -       if (nla =3D=3D NULL)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Skbedit requires attributes t=
o be passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_SKBEDIT_MAX, nla,
>                                           skbedit_policy, NULL);
>         if (err < 0)
>                 return err;
>
> -       if (tb[TCA_SKBEDIT_PARMS] =3D=3D NULL)
> +       if (!tb[TCA_SKBEDIT_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required skbedit para=
meters");
>                 return -EINVAL;
> +       }
>
>         if (tb[TCA_SKBEDIT_PRIORITY] !=3D NULL) {
>                 flags |=3D SKBEDIT_F_PRIORITY;
> @@ -161,8 +165,10 @@ static int tcf_skbedit_init(struct net *net, struct =
nlattr *nla,
>
>         if (tb[TCA_SKBEDIT_PTYPE] !=3D NULL) {
>                 ptype =3D nla_data(tb[TCA_SKBEDIT_PTYPE]);
> -               if (!skb_pkt_type_ok(*ptype))
> +               if (!skb_pkt_type_ok(*ptype)) {
> +                       NL_SET_ERR_MSG_MOD(extack, "ptype is not a valid"=
);
>                         return -EINVAL;
> +               }
>                 flags |=3D SKBEDIT_F_PTYPE;
>         }
>
> @@ -212,6 +218,7 @@ static int tcf_skbedit_init(struct net *net, struct n=
lattr *nla,
>                 return ACT_P_BOUND;
>
>         if (!flags) {
> +               NL_SET_ERR_MSG_MOD(extack, "No skbedit action flag");
>                 if (exists)
>                         tcf_idr_release(*a, bind);
>                 else
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index bcb673ab0008..c80828cdeb69 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -119,16 +119,20 @@ static int tcf_skbmod_init(struct net *net, struct =
nlattr *nla,
>         u16 eth_type =3D 0;
>         int ret =3D 0, err;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Skbmod requires attributes to=
 be passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_SKBMOD_MAX, nla,
>                                           skbmod_policy, NULL);
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_SKBMOD_PARMS])
> +       if (!tb[TCA_SKBMOD_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required skbmod param=
eters");
>                 return -EINVAL;
> +       }
>
>         if (tb[TCA_SKBMOD_DMAC]) {
>                 daddr =3D nla_data(tb[TCA_SKBMOD_DMAC]);
> @@ -160,6 +164,7 @@ static int tcf_skbmod_init(struct net *net, struct nl=
attr *nla,
>                 return ACT_P_BOUND;
>
>         if (!lflags) {
> +               NL_SET_ERR_MSG_MOD(extack, "No skbmod action flag");
>                 if (exists)
>                         tcf_idr_release(*a, bind);
>                 else
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index 836183011a7c..b468a4c8a904 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -134,16 +134,20 @@ static int tcf_vlan_init(struct net *net, struct nl=
attr *nla,
>         int ret =3D 0, err;
>         u32 index;
>
> -       if (!nla)
> +       if (!nla) {
> +               NL_SET_ERR_MSG_MOD(extack, "Vlan requires attributes to b=
e passed");
>                 return -EINVAL;
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_VLAN_MAX, nla, vlan_p=
olicy,
>                                           NULL);
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_VLAN_PARMS])
> +       if (!tb[TCA_VLAN_PARMS]) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required vlan action =
parameters");
>                 return -EINVAL;
> +       }
>         parm =3D nla_data(tb[TCA_VLAN_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> --
> 2.43.0
>

