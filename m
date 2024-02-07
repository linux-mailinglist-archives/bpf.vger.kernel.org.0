Return-Path: <bpf+bounces-21385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6058D84C1F0
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 02:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CC1287C8C
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A001DDC7;
	Wed,  7 Feb 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bR5Q7BKB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E6DDA9
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269815; cv=none; b=BQ6J38GLfUxY2R+DGClsJA3HQyTh8YmCKAFnZT98tko4A5jVCqcsruMr/IWC+vK7ApSTtn/vH2WZIyFEwDR+xPgoZgg9/5E2JhPkhbnyLCfXGsZ/y7wLjNRiqJmbIPwtund4JIdTKO92Pk2qNO3DnqcCFIk8Nr0jADHko4H+L5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269815; c=relaxed/simple;
	bh=8/IXU+3A+BigWLFJTjjnh7adLXY58gs2T4x67o9TK6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBqe1GZyl7OFsRi14qolaZPF7T9bgcKQzAOPQH79o2Im8py6ev06GkAlKwzzDuQkN+JrztOBX2a+X/WOizOXEHv0casXqfZMQnpUXkmNF8bJ7Un1O5lNH0hEbE3BgQx0V24sG0A2nQxgSbEucr7Fhh3ZSPJHrGEvj7jdmkqM8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bR5Q7BKB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so91603276.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 17:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707269811; x=1707874611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4UVXt0fxIgi47UM0Lcd+kHeDNX9b2q5xQI04Cos9NU=;
        b=bR5Q7BKBzUPH9TRrhY0Ts+AanYwmXGPiB3n/Y87LU4ml8E9F60X3/Str2En+ZB7Cyx
         uwhVJztNMpEcteWAQB55Ut6o4har2eHNKZblu5zlZX7JgrgDhjRF3MuVvIZdNNHYgj4E
         ax5GNr3rOb+iHD0WYWQ/DmhN/1yKJUKGaUy7TyJRKT3Z9jEINj84X57cxiGHLuIyFN4o
         bLbo0xNG3GVqgf4pxWpKsnEZiAk8BGof5EB6xdZgjs7J3aZh+iNHazVenvziLuzyEwcC
         rCRrpt6B+IzsGRM5I7IbL2hUvOfCShOAt374uXrqJ4k51eDrh9Q49ZeeFGwm3dCG7S9a
         xjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269811; x=1707874611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4UVXt0fxIgi47UM0Lcd+kHeDNX9b2q5xQI04Cos9NU=;
        b=ss4S5fl330q9YYAEZTgqziJVMcmIsvBrcRGIdqv1zQ0TqumRqoaFE3R3rYAV/3EH4o
         Jo6u437i3ViPjBYzBM7z15Zhnrh8Z6umC9Ickr6F9UNNg3X7IS88xI/H6BVWpXNCHuUk
         xDfITlDkxzkz5X/vCFcNOvQ+Wt5HyTjRKYcmvMYsMLUddBdr8uQ8g7CCsus628mkeDV3
         TMkJUpshYT67k17YWJKTnLMCxDejBoThRlzo2pt4A1mJKAo8tViiiNfe8nCQ+sH9SPod
         EAZ3FLIDTdPGygZgt/3HYiBOPHIcc81C7puvjCPzRDsjyUv9WYlvG5G1qbuuAr/eIf0t
         qaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBvMP/VOXyX+YGtI8I2mwCAWfN51EVIV1J3N9vK3g6eDYYw/ZJCRJO25HYT7XULqUf/FUxATXsblSAnkAqkozN3Aay
X-Gm-Message-State: AOJu0Yy6R0/1J/T544caDJI92CfV4NNj6rb4WkIt6WcFgQljx2GrDHYk
	ewG+xFnqZhfZCa4P/w5pfdZFFlrDiGkLnIMXLskKCkMLHbFaoTDyMYYEofIser2ghLimB1Eswlg
	TO4OgkyS5rACU0WTz1jdKJY5D17rrqM2hf/In5XfIN40441I=
X-Google-Smtp-Source: AGHT+IHbdMjBFE9gkcG2DKXZMOZiL36BSA5BN+4JT8Qstkewyemi4FKBoYvBYFum6TvDvPsoKico4ITsjLy2IelT1nE=
X-Received: by 2002:a25:ac94:0:b0:dc6:4ad3:1671 with SMTP id
 x20-20020a25ac94000000b00dc64ad31671mr3366444ybi.15.1707269811453; Tue, 06
 Feb 2024 17:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205185537.216873-1-stephen@networkplumber.org>
In-Reply-To: <20240205185537.216873-1-stephen@networkplumber.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 6 Feb 2024 20:36:40 -0500
Message-ID: <CAM0EoMnZ=WcSy7me3Tf=_znWqp_ep8UTpyHuX3iUNFtVvzUufQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with extack
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:55=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> When an action detects invalid parameters, it should
> be adding an external ack to netlink so that the user is
> able to diagnose the issue.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v2 - use NL_REQ_ATTR_CHECK()
>
>  net/sched/act_bpf.c      | 32 +++++++++++++++++++++++---------
>  net/sched/act_connmark.c |  8 ++++++--
>  net/sched/act_csum.c     |  9 +++++++--
>  net/sched/act_ct.c       |  5 +++--
>  net/sched/act_ctinfo.c   |  6 +++---
>  net/sched/act_gact.c     | 14 +++++++++++---
>  net/sched/act_gate.c     | 15 +++++++++++----
>  net/sched/act_ife.c      |  8 ++++++--
>  net/sched/act_mirred.c   |  6 ++++--
>  net/sched/act_nat.c      |  9 +++++++--
>  net/sched/act_police.c   | 13 ++++++++++---
>  net/sched/act_sample.c   |  8 ++++++--
>  net/sched/act_simple.c   | 11 ++++++++---
>  net/sched/act_skbedit.c  | 17 ++++++++++++-----
>  net/sched/act_skbmod.c   |  9 +++++++--
>  net/sched/act_vlan.c     |  8 ++++++--
>  16 files changed, 130 insertions(+), 48 deletions(-)
>
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 0e3cf11ae5fc..4dc6f27a4809 100644
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
> @@ -193,12 +194,17 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb=
, struct tcf_bpf_cfg *cfg)
>         int ret;
>
>         bpf_num_ops =3D nla_get_u16(tb[TCA_ACT_BPF_OPS_LEN]);
> -       if (bpf_num_ops > BPF_MAXINSNS || bpf_num_ops =3D=3D 0)
> +       if (bpf_num_ops > BPF_MAXINSNS || bpf_num_ops =3D=3D 0) {
> +               NL_SET_ERR_MSG_FMT_MOD(extack,
> +                                      "Invalid number of BPF instruction=
s %u", bpf_num_ops);
>                 return -EINVAL;
> +       }
>
>         bpf_size =3D bpf_num_ops * sizeof(*bpf_ops);
> -       if (bpf_size !=3D nla_len(tb[TCA_ACT_BPF_OPS]))
> +       if (bpf_size !=3D nla_len(tb[TCA_ACT_BPF_OPS])) {
> +               NL_SET_ERR_MSG_FMT_MOD(extack, "BPF instruction size %u",=
 bpf_size);
>                 return -EINVAL;
> +       }
>
>         bpf_ops =3D kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_=
KERNEL);
>         if (bpf_ops =3D=3D NULL)
> @@ -221,7 +227,8 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, =
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
> @@ -230,8 +237,10 @@ static int tcf_bpf_init_from_efd(struct nlattr **tb,=
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
> @@ -292,16 +301,20 @@ static int tcf_bpf_init(struct net *net, struct nla=
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_ACT_BPF_PARMS]);
>         index =3D parm->index;
> @@ -336,14 +349,15 @@ static int tcf_bpf_init(struct net *net, struct nla=
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
> index 0fce631e7c91..00c7e52d91ca 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CONNMARK_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
> +       }
>
>         nparms =3D kzalloc(sizeof(*nparms), GFP_KERNEL);
>         if (!nparms)
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 5cc8e407e791..b83e6d5f10ee 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -55,16 +55,21 @@ static int tcf_csum_init(struct net *net, struct nlat=
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CSUM_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
> +       }
> +
>         parm =3D nla_data(tb[TCA_CSUM_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index baac083fd8f1..7984f9f6ea2c 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1329,10 +1329,11 @@ static int tcf_ct_init(struct net *net, struct nl=
attr *nla,
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_CT_PARMS]) {
> -               NL_SET_ERR_MSG_MOD(extack, "Missing required ct parameter=
s");
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CT_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
>         }
> +
>         parm =3D nla_data(tb[TCA_CT_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> index 5dd41a012110..dde047b6b839 100644
> --- a/net/sched/act_ctinfo.c
> +++ b/net/sched/act_ctinfo.c
> @@ -178,11 +178,11 @@ static int tcf_ctinfo_init(struct net *net, struct =
nlattr *nla,
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_CTINFO_ACT]) {
> -               NL_SET_ERR_MSG_MOD(extack,
> -                                  "Missing required TCA_CTINFO_ACT attri=
bute");
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CTINFO_ACT)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
>         }
> +
>         actparm =3D nla_data(tb[TCA_CTINFO_ACT]);
>
>         /* do some basic validation here before dynamically allocating th=
ings */
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index e949280eb800..42c6b8d9002d 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_GACT_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
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
> index 1dd74125398a..3e8056a2c304 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_GATE_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
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
> index 107c6d83dc5c..b22881363029 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -508,8 +508,10 @@ static int tcf_ife_init(struct net *net, struct nlat=
tr *nla,
>         if (err < 0)
>                 return err;
>
> -       if (!tb[TCA_IFE_PARMS])
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_IFE_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
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
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 93a96e9d8d90..f1bdd19e0bbb 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -124,10 +124,12 @@ static int tcf_mirred_init(struct net *net, struct =
nlattr *nla,
>                                           mirred_policy, extack);
>         if (ret < 0)
>                 return ret;
> -       if (!tb[TCA_MIRRED_PARMS]) {
> -               NL_SET_ERR_MSG_MOD(extack, "Missing required mirred param=
eters");
> +
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_MIRRED_PARMS)) {
> +               NL_SET_ERR_MSG(extack, "Missing required attribute");
>                 return -EINVAL;
>         }
> +
>         parm =3D nla_data(tb[TCA_MIRRED_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index d541f553805f..42019977514e 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_NAT_PARMS)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required NAT paramete=
rs");
>                 return -EINVAL;
> +       }
> +
>         parm =3D nla_data(tb[TCA_NAT_PARMS]);
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index 8555125ed34d..17708fe32ad1 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_POLICE_TBF)) {
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
> index a69b53d54039..0492df144b39 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SAMPLE_PARMS)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required sample actio=
n parameters");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_SAMPLE_PARMS]);
>         index =3D parm->index;
> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index f3abe0545989..0c56c8c9ef44 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_DEF_PARMS)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing required sample actio=
n parameters");
>                 return -EINVAL;
> +       }
>
>         parm =3D nla_data(tb[TCA_DEF_PARMS]);
>         index =3D parm->index;
> @@ -120,7 +124,8 @@ static int tcf_simp_init(struct net *net, struct nlat=
tr *nla,
>         if (exists && bind)
>                 return ACT_P_BOUND;
>
> -       if (tb[TCA_DEF_DATA] =3D=3D NULL) {
> +       if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_DEF_DATA)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Missing simple action default=
 data");
>                 if (exists)
>                         tcf_idr_release(*a, bind);
>                 else
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index 1f1d9ce3e968..e9c4f2befb8b 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SKBEDIT_PARMS)) {
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
> @@ -182,8 +188,8 @@ static int tcf_skbedit_init(struct net *net, struct n=
lattr *nla,
>                 if (*pure_flags & SKBEDIT_F_TXQ_SKBHASH) {
>                         u16 *queue_mapping_max;
>
> -                       if (!tb[TCA_SKBEDIT_QUEUE_MAPPING] ||
> -                           !tb[TCA_SKBEDIT_QUEUE_MAPPING_MAX]) {
> +                       if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_SKBED=
IT_QUEUE_MAPPING) ||
> +                           NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_SKBED=
IT_QUEUE_MAPPING_MAX)) {
>                                 NL_SET_ERR_MSG_MOD(extack, "Missing requi=
red range of queue_mapping.");
>                                 return -EINVAL;
>                         }
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
> index 39945b139c48..19b35666f357 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SKBMOD_PARMS)) {
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
> index 22f4b1e8ade9..414129539c4a 100644
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
> +       if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_VLAN_PARMS)) {
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

