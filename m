Return-Path: <bpf+bounces-47132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6169F565B
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649E216EBA3
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468991F8AD9;
	Tue, 17 Dec 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0qwGjT3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DE1F8ACD;
	Tue, 17 Dec 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460357; cv=none; b=dPL7iPDOnhecilvYT8VpvLzhdrRDvDFyD1eOJoHO3bN1Y/+MYzGhCbFwRyP8uIZilxgjtaLCj7MfSR4j2RMDLED24Ow5mPg38EIBg9FRijfJM55WG4adUZQ7H7uGJDrcOlrCFixM83hqKwwFZxKP+Vvaymk7oODR67FANNPdPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460357; c=relaxed/simple;
	bh=5nb+i4GUEBvuEtR/XlIKTCQSOtKx3rOfpIbIfnEuQds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlooTPYe1K7yniYKlc2bKIkK2G2SKv5eSqKebd02Q9BdTyWh1NTLJhsYcK24pE7vSTm4OTuNhA/sPJRtmC8ZwyVG6HJxOgvTaUPIVFQ9FEpPAedjU6u90jI0J5Nqtnc77Npe1fQqcCM/x12spe0vz7Bokclx3XHj7DXK12sEz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0qwGjT3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f4623df7so5022894b3a.2;
        Tue, 17 Dec 2024 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734460355; x=1735065155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5FXtkjb0FK4e0OHg+/7n+qyAizRnGYdC1ZI9qRZxxw=;
        b=W0qwGjT3kwAT921j0AvtUMMRhORXK+qCJfWfoR0BfEATmQlTMfherus6bdBEXBBhu4
         MKVYXEptyE1Xe0Ff7EChiVSrMRRjKkunv/oSZ+zEGRgq9aiLSB3/NzAr/GYilG/7gE37
         9kr180zMkp+IrF+MX0uq/BARAjnb7R9C/7ehDBVcwTW7YHxM9dx8LCJR7Y21vR7wO8ju
         2ohTeiDB0FGsPtMQz+2K/B2Wry12eebkXKG/4uHEaFeGdy+a7TdVBtp1jBy6o6gqL7An
         VIF11DnJobzLRIyaMo5Q5ewiow4S7Visa7L2fRiEK61jVBS/TmkbepvNQ9vCwMC5PS0i
         P5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460355; x=1735065155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5FXtkjb0FK4e0OHg+/7n+qyAizRnGYdC1ZI9qRZxxw=;
        b=Q7+ZshMMmtCK/EG6SWr/2GfNRPrbZCiFOrZKC50vMrvyO5tJBpQ3uTB8SfsvUQSG9n
         SFvgo1lVovvZC+EnAH0iU4WQt7d9rYwCxAgI9Mm6iMis1QCebmdnsoZCFKdwBdNg11W2
         4UVIIHYJrs0F9jqMdPSA/HSOr2Aq79BL/+NTJ5DG4zRmWWpStq3YYkBktv1KcGdm3zC4
         oaQxQJQebFgahry5Hge4OLC3ij5CClI7uu66uzL0hHvtIZBuJvlcu7Zh0Dy/hdVbbHVL
         7Blt8SDf9S5o1t7C+UyVSRt09BMBO46racbOa3x54JN88bjmk5p8YrauD6GFnCGUAjTD
         HsjA==
X-Forwarded-Encrypted: i=1; AJvYcCXwTZ9bL8bo0dNwYVJd9QvIPDLcz/j6PxbN7+w6BVhVxrqVxOjUJ6r1lK+D6uKkKzeD+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsnZ2ouuUWIWj4xoSrw3Z0aAT5My3RRNda1OOcgzWd2ihxTO+
	5tpDa8eBr4pe819A0ArcdiAngvz1PtdF6TAK9O6wN7BhdpbzQihDWTbKb5oBGdOC0BspItp6MIa
	I5Xq7YATFzu6zca86b9x2lVJvTzA=
X-Gm-Gg: ASbGncuRxHqNljtcIOVUU4XKaaN8SoJ47f1sxvvW5q0hO1l+52SniJ83Q4inE8B53Ke
	pvzw82EgQJev4FZT/rQZK0wP70u1M6q6fAgqPgNyrQmPHS8hG24WROw==
X-Google-Smtp-Source: AGHT+IHDFNV+EJHBFM2xKZ7Srkfl6cUouqIu/9vplePKLd4IOoyNomz9E+2IYqCboHhHPLrEPYhXlgLiDPgnvIKWZK4=
X-Received: by 2002:a17:90b:5250:b0:2ee:8e75:4ae1 with SMTP id
 98e67ed59e1d1-2f2e7899645mr785351a91.21.1734460355489; Tue, 17 Dec 2024
 10:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com> <20241213232958.2388301-12-amery.hung@bytedance.com>
In-Reply-To: <20241213232958.2388301-12-amery.hung@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Dec 2024 10:32:23 -0800
Message-ID: <CAEf4BzY5E7JEPJ_W3T-bcKmdAJa-zpM4G+4H2rv2dOtLZMFbvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/13] libbpf: Support creating and destroying qdisc
To: Amery Hung <amery.hung@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, 
	ameryhung@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:30=E2=80=AFPM Amery Hung <amery.hung@bytedance.co=
m> wrote:
>
> Extend struct bpf_tc_hook with handle, qdisc name and a new attach type,
> BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
> addition to clsact.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  tools/lib/bpf/libbpf.h  |  5 ++++-
>  tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b2ce3a72b11d..b05d95814776 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1268,6 +1268,7 @@ enum bpf_tc_attach_point {
>         BPF_TC_INGRESS =3D 1 << 0,
>         BPF_TC_EGRESS  =3D 1 << 1,
>         BPF_TC_CUSTOM  =3D 1 << 2,
> +       BPF_TC_QDISC   =3D 1 << 3,
>  };
>
>  #define BPF_TC_PARENT(a, b)    \
> @@ -1282,9 +1283,11 @@ struct bpf_tc_hook {
>         int ifindex;
>         enum bpf_tc_attach_point attach_point;
>         __u32 parent;
> +       __u32 handle;
> +       char *qdisc;

const char *?

>         size_t :0;
>  };
> -#define bpf_tc_hook__last_field parent
> +#define bpf_tc_hook__last_field qdisc
>
>  struct bpf_tc_opts {
>         size_t sz;
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 68a2def17175..72db8c0add21 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -529,9 +529,9 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 *p=
rog_id)
>  }
>
>
> -typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
> +typedef int (*qdisc_config_t)(struct libbpf_nla_req *req, struct bpf_tc_=
hook *hook);

should hook pointer be const?

>
> -static int clsact_config(struct libbpf_nla_req *req)
> +static int clsact_config(struct libbpf_nla_req *req, struct bpf_tc_hook =
*hook)

const?

>  {
>         req->tc.tcm_parent =3D TC_H_CLSACT;
>         req->tc.tcm_handle =3D TC_H_MAKE(TC_H_CLSACT, 0);
> @@ -539,6 +539,16 @@ static int clsact_config(struct libbpf_nla_req *req)
>         return nlattr_add(req, TCA_KIND, "clsact", sizeof("clsact"));
>  }
>
> +static int qdisc_config(struct libbpf_nla_req *req, struct bpf_tc_hook *=
hook)

same, const, it's not written into, right?

> +{
> +       char *qdisc =3D OPTS_GET(hook, qdisc, NULL);
> +
> +       req->tc.tcm_parent =3D OPTS_GET(hook, parent, TC_H_ROOT);
> +       req->tc.tcm_handle =3D OPTS_GET(hook, handle, 0);
> +
> +       return nlattr_add(req, TCA_KIND, qdisc, strlen(qdisc) + 1);
> +}
> +
>  static int attach_point_to_config(struct bpf_tc_hook *hook,
>                                   qdisc_config_t *config)
>  {
> @@ -552,6 +562,9 @@ static int attach_point_to_config(struct bpf_tc_hook =
*hook,
>                 return 0;
>         case BPF_TC_CUSTOM:
>                 return -EOPNOTSUPP;
> +       case BPF_TC_QDISC:
> +               *config =3D &qdisc_config;
> +               return 0;
>         default:
>                 return -EINVAL;
>         }
> @@ -596,7 +609,7 @@ static int tc_qdisc_modify(struct bpf_tc_hook *hook, =
int cmd, int flags)
>         req.tc.tcm_family  =3D AF_UNSPEC;
>         req.tc.tcm_ifindex =3D OPTS_GET(hook, ifindex, 0);
>
> -       ret =3D config(&req);
> +       ret =3D config(&req, hook);
>         if (ret < 0)
>                 return ret;
>
> @@ -639,6 +652,7 @@ int bpf_tc_hook_destroy(struct bpf_tc_hook *hook)
>         case BPF_TC_INGRESS:
>         case BPF_TC_EGRESS:
>                 return libbpf_err(__bpf_tc_detach(hook, NULL, true));
> +       case BPF_TC_QDISC:
>         case BPF_TC_INGRESS | BPF_TC_EGRESS:
>                 return libbpf_err(tc_qdisc_delete(hook));
>         case BPF_TC_CUSTOM:
> --
> 2.20.1
>

