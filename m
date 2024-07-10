Return-Path: <bpf+bounces-34422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803A92D852
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EC1C20E00
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FB196438;
	Wed, 10 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpjxA57B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CA257D;
	Wed, 10 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636745; cv=none; b=mnaL9Ahs2nrj7Qz9V5kmNcLpgi22yeUMDezvKS6sItKvvlKeFJgCNYtNESoAQfVevt1CIGwAvQ0YB89zYmvqd24JRIy06A65upkd7MDiyBIxYzonFu8+O43qBYGPBKaVTy7Sn0zLG05CI0GXeI/CZJoBKLgI+CrfSBvBo5ZONlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636745; c=relaxed/simple;
	bh=1EoAa/AmhNuclk2x9Yo4mBdL40sJBA6UUazcYZTxKQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZKIj4NJH8P8dWYSpt27Se5z3zm/OM/9VaR31dn4pCAm7FFuXD87R9lzsx3eS6z8qRIV6VfBj+oPsEkhWk3E1vEu6FsLulM+HNm8JIhlbmRfGq1TPdvZiw8QU9prBRGkAPOa30GFKWaljt+z/AHzicf3yUrqZ3r64G24mtIiQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpjxA57B; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367b8a60b60so2861599f8f.2;
        Wed, 10 Jul 2024 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636741; x=1721241541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+c/uAX+gfaXTN3G9nM1mEmOxMkFaMUwGwxmh1TvO3g=;
        b=JpjxA57Bnc/MNIG0IwI+9lG5/jH/Q1rMo+Szc9sJBwNXrvsO3WIr5OfgGMiZuq1D+Z
         XYEd99Avg/5SgFrAEe6FRO/Lgz/fDLfNJ6un3+G140O4V7SZu4o0u3256uZ9HNH3s/y1
         kZrcHNtJ49zljfjCLI32pKauLZ4OQ5zvl7oCFBNwoVeVc1k92ZpXGvbB9WluGjHC4Tbs
         0Y4OXKBTJZ6JKllWH5VQNIYVbjU6e18j41+LuI9nmbjSr+HfGR5vXhbBOsx7B0aJVVmO
         fl8b+uoEuhazj76TpqLf+xV9nyKcYvBDcBTonfq7jbLCSrlnK6zD4hr0bywApqAVa9al
         g/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636741; x=1721241541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+c/uAX+gfaXTN3G9nM1mEmOxMkFaMUwGwxmh1TvO3g=;
        b=uv8agK8IBI9FNrRIblFX3a17aW1Vs7tD4i4D+jK4cN31cu/RKEH0DZcLWC1WtYdqla
         YE7j3lo0zuzsYfbguKWSPrr2yQVjAnww6ZENLmRnLiHWEGQP6Po9h4TP/rqAI5Yb4iHl
         i9iGbCf3i3YxsJo18qKX+TU8lkaLE5nrHqix5K3vsKRklXk515U+WJmGMVNrJeA9nxSq
         3DF+Q6MUs9bi1M91S/J0IQxv6GE5BoVq0cBQpzN7hJaTXwyFFXT0BrS4/bEHPKzhIlCX
         mQUKIc9ckF+rjTtPDOhT6aaPvULKs56iZpIlpzhljnmIgEYkoeDmDJHpa1QICJ/C9SC7
         hKCA==
X-Forwarded-Encrypted: i=1; AJvYcCWRCAtvUlCKGukrKJ+Vr1+a6WxRedKMeDlpvJp01UIfnzjo2gd5EUWj7oFWHZrFX6Oo625p6EV9Eww08Yuoy+0P7G1VjZfmLL3FT4taW4b4Lw7wnOE25LUqBLwYahyynm54dNs8U4nKifOyXhjx+XCdJX/fJdO64LAs
X-Gm-Message-State: AOJu0YyZ+szd5ikqk496nhyKmZBYgjv67WklRpnZRCPsN46sjGtxcMjr
	5aNmWxmFckWHNQTUf9ZE9codnjXYDP4OBn4WWxov2uwNkH2cUhPlQCh91htLq4A9gxIFC/MYtxN
	b5SwfjdZ+jFRbsA/dJKCzO1b0A1g=
X-Google-Smtp-Source: AGHT+IHsPP8rxAlZIrz6b3npTF1WDVE0RTBSUFNCW6j7UhoywHqT7giMNyX2dg9WJV7T5/7TbXcgdf4Kz62f7Me8m9M=
X-Received: by 2002:adf:e692:0:b0:366:ec2f:dbc9 with SMTP id
 ffacd0b85a97d-367ceac4ba5mr4214557f8f.51.1720636740515; Wed, 10 Jul 2024
 11:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084633.2229015-1-michal.switala@infogain.com>
In-Reply-To: <20240710084633.2229015-1-michal.switala@infogain.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 11:38:49 -0700
Message-ID: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context initialization
To: Michal Switala <michal.switala@infogain.com>
Cc: Florent Revest <revest@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:58=E2=80=AFAM Michal Switala
<michal.switala@infogain.com> wrote:
>
> This commit addresses an issue where a netdevice was found to be uninitia=
lized.
> To mitigate this case, the change ensures that BPF programs designed to t=
est
> skb context initialization thoroughly verify the availability of a fully
> initialized context before execution.The root cause of a NULL ctx stems f=
rom
> the initialization process in bpf_ctx_init(). This function returns NULL =
if
> the user initializes the bpf_attr variables ctx_in and ctx_out with inval=
id
> pointers or sets them to NULL. These variables are directly controlled by=
 user
> input, and if both are NULL, the context cannot be initialized, resulting=
 in a
> NULL ctx.
>
> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dcca39e6e84a367a7e6f6
> Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com=
/

Something doesn't add up.
This syzbot report is about:

dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
__xdp_do_redirect_frame net/core/filter.c:4397 [inline]
bpf_prog_test_run_xdp

while you're fixing bpf_prog_test_run_skb ?

pw-bot: cr

> Signed-off-by: Michal Switala <michal.switala@infogain.com>
> ---
>  net/bpf/test_run.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 36ae54f57bf5..8b2efcee059f 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -970,7 +970,7 @@ static struct proto bpf_dummy_proto =3D {
>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *k=
attr,
>                           union bpf_attr __user *uattr)
>  {
> -       bool is_l2 =3D false, is_direct_pkt_access =3D false;
> +       bool is_l2 =3D false, is_direct_pkt_access =3D false, ctx_needed =
=3D false;
>         struct net *net =3D current->nsproxy->net_ns;
>         struct net_device *dev =3D net->loopback_dev;
>         u32 size =3D kattr->test.data_size_in;
> @@ -998,6 +998,34 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, con=
st union bpf_attr *kattr,
>                 return PTR_ERR(ctx);
>         }
>
> +       switch (prog->type) {
> +       case BPF_PROG_TYPE_SOCKET_FILTER:
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +       case BPF_PROG_TYPE_SCHED_ACT:
> +       case BPF_PROG_TYPE_XDP:
> +       case BPF_PROG_TYPE_CGROUP_SKB:
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_SOCK_OPS:
> +       case BPF_PROG_TYPE_SK_SKB:
> +       case BPF_PROG_TYPE_SK_MSG:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +       case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> +       case BPF_PROG_TYPE_SK_REUSEPORT:
> +       case BPF_PROG_TYPE_NETFILTER:
> +       case BPF_PROG_TYPE_LWT_IN:
> +       case BPF_PROG_TYPE_LWT_OUT:
> +       case BPF_PROG_TYPE_LWT_XMIT:
> +               ctx_needed =3D true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (!ctx && ctx_needed) {
> +               kfree(data);
> +               return -EINVAL;
> +       }
> +
>         switch (prog->type) {
>         case BPF_PROG_TYPE_SCHED_CLS:
>         case BPF_PROG_TYPE_SCHED_ACT:
> --
> 2.43.0
>
>

