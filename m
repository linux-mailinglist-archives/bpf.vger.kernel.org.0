Return-Path: <bpf+bounces-47135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8789F56B1
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06807A2CCB
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EA1F8F04;
	Tue, 17 Dec 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YykCZ1Bf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4413EFF3;
	Tue, 17 Dec 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462516; cv=none; b=CYeyf9jWAdZVEfaaXQ1mwKzEtycKBOyZAOUzhRzDGY0DLxpJzxtDiv6jvBQNFFek20ZRAAwqrqvlb26A2mnOBzjeznFr1MTpjO2Muy+6mS7zwwmxA2WBvniYeDT/4H0cr/nT9FayEAelZ4nrlStBSS115Cmstctz+OlMJyoNe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462516; c=relaxed/simple;
	bh=7ZdNW3ee5oYhzDTi243PPqSUvcJI9ZzI2i0PiRyxYxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRzjxrddvT/iplKGe4PzyGdBW+eh2oRtT3qH0dZ0b5FN0nUz54N0n3ZgkFdCPFvhxFYJFWq7sTHnwlC+1b22TcoGR47wHLlSfl1ulTrpckBfbNJFI9zwwac77CWgsb/Qn4JpM4U1YCsJA2MldIWSlw3tcNurICA7UKZwlKypRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YykCZ1Bf; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e399e904940so4379862276.2;
        Tue, 17 Dec 2024 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734462514; x=1735067314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGBXmULFKlM/MdgIOWMrBJkLUNui9xu0Ezluc9DX3c8=;
        b=YykCZ1BfGdbduvC6IUNaCS+7iiURV8uFzLyNKfQZrBBwITwvDOKLGpzui0v34VjwKU
         anG3pjLSvkG4tJ4Xl6ZtVPjWjUdm3ro4AMORPlKIvaS7Aar0tvbFZtw0ihbkeBidpdGA
         ItnE6PeBsewHqWGHzXqI4HSgOEMtKMqJunIMYD+6E3JgKz6OGTLQVl2nK7rkZ/05+aY3
         iISVR9TVo3RCVhPtOWzC08nNLnH/CKEGqF1sc3MZBn3CXjOVG41djBAS0tILTFDiU98B
         496p6WQ1NIXJPiSFWsNjhleIDSQrLBiV98gMYZ6A8+WXljQS04fZOnhidfPu2KnAifuG
         ifUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462514; x=1735067314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGBXmULFKlM/MdgIOWMrBJkLUNui9xu0Ezluc9DX3c8=;
        b=mcpiI9/wVRP4IgVpk+NLQ4hQjclCBnHdt63FSXxdAim0nY8OTKOWS9PoRorsJPt42F
         xi+P21Rnt27R7x8eLauzQ8DwGSXzPeVSXBP/aeR6TeIPC0T2ZUNNHZGz36028jaoe5KH
         AOOXKbAqNt666kwD4gscUwAmkKv6JeFJKFgSr2NtUukALuR0lOaMrPokGntlp+U41bml
         uBgkuuMAH8CWKRTLlFrmBnkBFM22cPW2XfHqstlM6emoIOI2BQrTGqasCD7UzKCYW8Cc
         Eo99vALgLI4ZTmmYiPPEay7X+V1nTDdGf2U7dgjKv2vZqD2tnhM0avHYXZZN12hhrLOp
         EfNg==
X-Forwarded-Encrypted: i=1; AJvYcCUAwFsBCqO2o5heEKqxOWxf8P9dF58iL7sOOeP+Yv2ueL890tbAuZ1MjafN1M9yicly8wpDhjf/@vger.kernel.org, AJvYcCWiubOM8x12D1bVgMtjjydVRaiweLm5E5MSeXYYxmdT657ReQaCFsqaC08t06GA4heznOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANGTzyX3tMtFHhSPDla6PsaZ06wxBXBej9TT+FIvT02nU64Fg
	d5ZdYUV7CDmTzBzKWT2nYWXehM7R3+DH1/z95JkhWebm0gTB9G9H7yT3uTGSejw5FOwYpBu0gLl
	bTny9Zak5nC2M74El3joXJE8euGc=
X-Gm-Gg: ASbGncuAjy4xdCjxOIUt3NiWw/bNi/Llzo3RN5OJocWtOYvEf4kpf+K3h0/s4bqEhF/
	k/lQZyhJ3PThfypBrwvuEd+KJ4P4hkv3i4dmYCsY=
X-Google-Smtp-Source: AGHT+IFTvwsnXpjtPDdkNLbrNtT0pUjGSMpmrR9V8pIS0sEJBZJC/xRdw8PK/8X4acUDKncNTXtIe9i0/DMf4C/a2Es=
X-Received: by 2002:a05:690c:dd4:b0:6ef:4c6c:3049 with SMTP id
 00721157ae682-6f2bb307b95mr44481297b3.14.1734462513851; Tue, 17 Dec 2024
 11:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-12-amery.hung@bytedance.com> <CAEf4BzY5E7JEPJ_W3T-bcKmdAJa-zpM4G+4H2rv2dOtLZMFbvA@mail.gmail.com>
In-Reply-To: <CAEf4BzY5E7JEPJ_W3T-bcKmdAJa-zpM4G+4H2rv2dOtLZMFbvA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 17 Dec 2024 11:08:23 -0800
Message-ID: <CAMB2axN5BeHPTZtxcU1zFo02ywnUCZd1V8H3dY_TqJjhodvDFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/13] libbpf: Support creating and destroying qdisc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <amery.hung@bytedance.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right. I will add const to the hook argument and bpf_tc_hook->qdisc=
.

Thanks,
Amery

On Tue, Dec 17, 2024 at 10:32=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 13, 2024 at 3:30=E2=80=AFPM Amery Hung <amery.hung@bytedance.=
com> wrote:
> >
> > Extend struct bpf_tc_hook with handle, qdisc name and a new attach type=
,
> > BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
> > addition to clsact.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  tools/lib/bpf/libbpf.h  |  5 ++++-
> >  tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index b2ce3a72b11d..b05d95814776 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1268,6 +1268,7 @@ enum bpf_tc_attach_point {
> >         BPF_TC_INGRESS =3D 1 << 0,
> >         BPF_TC_EGRESS  =3D 1 << 1,
> >         BPF_TC_CUSTOM  =3D 1 << 2,
> > +       BPF_TC_QDISC   =3D 1 << 3,
> >  };
> >
> >  #define BPF_TC_PARENT(a, b)    \
> > @@ -1282,9 +1283,11 @@ struct bpf_tc_hook {
> >         int ifindex;
> >         enum bpf_tc_attach_point attach_point;
> >         __u32 parent;
> > +       __u32 handle;
> > +       char *qdisc;
>
> const char *?
>
> >         size_t :0;
> >  };
> > -#define bpf_tc_hook__last_field parent
> > +#define bpf_tc_hook__last_field qdisc
> >
> >  struct bpf_tc_opts {
> >         size_t sz;
> > diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> > index 68a2def17175..72db8c0add21 100644
> > --- a/tools/lib/bpf/netlink.c
> > +++ b/tools/lib/bpf/netlink.c
> > @@ -529,9 +529,9 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 =
*prog_id)
> >  }
> >
> >
> > -typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
> > +typedef int (*qdisc_config_t)(struct libbpf_nla_req *req, struct bpf_t=
c_hook *hook);
>
> should hook pointer be const?
>
> >
> > -static int clsact_config(struct libbpf_nla_req *req)
> > +static int clsact_config(struct libbpf_nla_req *req, struct bpf_tc_hoo=
k *hook)
>
> const?
>
> >  {
> >         req->tc.tcm_parent =3D TC_H_CLSACT;
> >         req->tc.tcm_handle =3D TC_H_MAKE(TC_H_CLSACT, 0);
> > @@ -539,6 +539,16 @@ static int clsact_config(struct libbpf_nla_req *re=
q)
> >         return nlattr_add(req, TCA_KIND, "clsact", sizeof("clsact"));
> >  }
> >
> > +static int qdisc_config(struct libbpf_nla_req *req, struct bpf_tc_hook=
 *hook)
>
> same, const, it's not written into, right?
>
> > +{
> > +       char *qdisc =3D OPTS_GET(hook, qdisc, NULL);
> > +
> > +       req->tc.tcm_parent =3D OPTS_GET(hook, parent, TC_H_ROOT);
> > +       req->tc.tcm_handle =3D OPTS_GET(hook, handle, 0);
> > +
> > +       return nlattr_add(req, TCA_KIND, qdisc, strlen(qdisc) + 1);
> > +}
> > +
> >  static int attach_point_to_config(struct bpf_tc_hook *hook,
> >                                   qdisc_config_t *config)
> >  {
> > @@ -552,6 +562,9 @@ static int attach_point_to_config(struct bpf_tc_hoo=
k *hook,
> >                 return 0;
> >         case BPF_TC_CUSTOM:
> >                 return -EOPNOTSUPP;
> > +       case BPF_TC_QDISC:
> > +               *config =3D &qdisc_config;
> > +               return 0;
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -596,7 +609,7 @@ static int tc_qdisc_modify(struct bpf_tc_hook *hook=
, int cmd, int flags)
> >         req.tc.tcm_family  =3D AF_UNSPEC;
> >         req.tc.tcm_ifindex =3D OPTS_GET(hook, ifindex, 0);
> >
> > -       ret =3D config(&req);
> > +       ret =3D config(&req, hook);
> >         if (ret < 0)
> >                 return ret;
> >
> > @@ -639,6 +652,7 @@ int bpf_tc_hook_destroy(struct bpf_tc_hook *hook)
> >         case BPF_TC_INGRESS:
> >         case BPF_TC_EGRESS:
> >                 return libbpf_err(__bpf_tc_detach(hook, NULL, true));
> > +       case BPF_TC_QDISC:
> >         case BPF_TC_INGRESS | BPF_TC_EGRESS:
> >                 return libbpf_err(tc_qdisc_delete(hook));
> >         case BPF_TC_CUSTOM:
> > --
> > 2.20.1
> >

