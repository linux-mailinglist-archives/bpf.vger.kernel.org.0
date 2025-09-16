Return-Path: <bpf+bounces-68458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573FB5894C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 02:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08131620C7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E31A8F84;
	Tue, 16 Sep 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2+HSRbj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FD1A0711
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982441; cv=none; b=sTrJZPNC80NQ3EzzR7P3sGL34+w6CeRZkwxCbX0HpOReqLLXdvrRALfavqnVtPpzjlKj8qCcV98f4KcsvjcPBhxHJasxyU5rfzel9YDLjxIufzqM2VTRro+FvlfUcly8OJGDprMKL6P/ngSXWrcZolFroV1uA4BGVCXYIv7TTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982441; c=relaxed/simple;
	bh=twDoemgyd7WvTcXJIWyoI2u6NtUjbv2DJLLIapsuz+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr6p9L/EOZrKUz6OLQ66glDffwA1XM9iwROG+Mmx7dFS7cdSEYVXEdSHRcT3kj/HXbMUIsazDTPiAgRpYr9LcShw4gkqyRmDYR7nB8DAR3dXFAIuoIaS7TuGqHKwRgyzsF6X438tpKDl58ovoec9JpTLh7unOqzqBCTH/JeZmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2+HSRbj; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea411f21bfdso1157626276.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982438; x=1758587238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woWePHw75Xwwc8cTedQvUf0FVtyqO8joUi+efLnOVMs=;
        b=e2+HSRbjYSvbzxNXJMlm1vIgO4eA7+oOnTH7fstQQrZGqAPJmsbxkpMwR4N35Kzvdj
         spXDp+HNnqHzrMI/duzOp9Upn5JKaTP2OiqjP+mCLAN702JtBviwNdm7VIing36mPuxR
         bZK7FXOwjNC90EzwWgJd3Ivc9kRwcw31Q2JDRrltiCrHb0Vwlv55BpUtY0qfZ/meJgT8
         dEXgNA+S/V+dLfZPjXK5qC6qarHGHgGw92fkcbYz22bwZ7xDlP1CiDkXh4wqpYDXticX
         3ncEf/mJN4qE/38zlV4J2DtaxfReHaVjQYIfjr1ZSGhtU6we9GaDkShqzL7DKQV3B3tD
         0S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982438; x=1758587238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woWePHw75Xwwc8cTedQvUf0FVtyqO8joUi+efLnOVMs=;
        b=XQWEydT5NyFJgaEJE3KhZkBG+vCTFme4i1sCxisNRXFCPReXF2XVJC13ZHHYYD9DP/
         MC8+GptsRnF2FU338ZwfKCbYaqkI99wgy6qmACT4ow74jNcS0G9MznCyFft8vmrcCo4h
         ALu7rW+2R7m4uyKJ8EBCEbkQMJswYcm82ymZx7rZGOIs6Ak+RBwjfWMrK7YGaZzW03Sb
         9szVqGhNKU6E12IR03kJjwN/iDtRXh3WNEOKjOx5YDLxmjdS/Zi54x75twLHo1XeQL1x
         seVdWyU+lFr09tfw1CeP8LCrJTg6waiwee0Lsse3vwjHH8J+kSJDn0VYcQzRy/KEUUb2
         7UJA==
X-Gm-Message-State: AOJu0YxUaN9qfBrgq3gzY87oU88I32fN3bOQ1LrfHY6txss6QbI4ip2a
	2wpAyF7SpO69DXfLEx6fEAQVBQE5sTXOIYw/RZj+3hQkWft1EWIDXqnw8sJWvPKohD0LXRLPFKv
	bVo/oHnIrsScKKF8/hpc9QXnLb9+c4JI=
X-Gm-Gg: ASbGncvJ7xWYSXHDzU/tswGmSD5pseE5wj/VRxHhWRZXzNZYMdmVEIuaXVh/NvMNUfj
	cILokJn24lbImsucTy9oLL2xgt51BQjfX9uQm14BhXvtnxksd7kToDljJCoGlw3DGGVXnMFtd7w
	se4KfPTtWq/Qj4lrruNYwM1nYtJlnFDFF3Qjc0mnA6rZoUJwMHVHriQlwAfqAdOFHiaKFbBXDbl
	ZyCmQ7ubSJ+l01SOA==
X-Google-Smtp-Source: AGHT+IEgLEvMSn9vgN3IbEN636lH8ovEig/2r7MQb/YllrIEQh4HZJ0ooDmSuN+nLaQMtf4GZn1x3Sf9NgDqCSukDAs=
X-Received: by 2002:a05:690c:4a10:b0:722:830d:2851 with SMTP id
 00721157ae682-73063096024mr126082137b3.18.1757982437598; Mon, 15 Sep 2025
 17:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757862238.git.paul.chaignon@gmail.com> <6bed34f91f4624c45fd7f31079246d3b3751a31f.1757862238.git.paul.chaignon@gmail.com>
In-Reply-To: <6bed34f91f4624c45fd7f31079246d3b3751a31f.1757862238.git.paul.chaignon@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 15 Sep 2025 17:27:05 -0700
X-Gm-Features: Ac12FXw-esqRq59vHdEiwW6ZKeGyDA_Y02ljk3LeJ7xUA4FnzQ_wTjkxa32RNxk
Message-ID: <CAMB2axOX-J5fDa8EuB42oHEvXQ+OGpUmEaetCQb4g41imvaYCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 8:10=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> This patch adds support for crafting non-linear skbs in BPF test runs
> for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
> flag is set, the size of the linear area is given by ctx->data_end, with
> a minimum of ETH_HLEN always pulled in the linear area.
>
> This is particularly useful to test support for non-linear skbs in large
> codebases such as Cilium. We've had multiple bugs in the past few years
> where we were missing calls to bpf_skb_pull_data(). This support in
> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> BPF tests.
>
> In addition to the selftests introduced later in the series, this patch
> was tested by setting BPF_F_TEST_SKB_NON_LINEAR for all tc selftests
> programs and checking test failures were expected.
>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |   4 ++
>  net/bpf/test_run.c             | 102 ++++++++++++++++++++++++---------
>  tools/include/uapi/linux/bpf.h |   4 ++
>  3 files changed, 82 insertions(+), 28 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382..34272cd07dd2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1448,6 +1448,10 @@ enum {
>  #define BPF_F_TEST_XDP_LIVE_FRAMES     (1U << 1)
>  /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>  #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE       (1U << 2)
> +/* If set, skb will be non-linear with the size of the linear area given
> + * by ctx.data_end or at least ETH_HLEN.
> + */
> +#define BPF_F_TEST_SKB_NON_LINEAR      (1U << 3)
>
>  /* type for BPF_ENABLE_STATS */
>  enum bpf_stats_type {
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index a9c81fec3290..aaa8f93d2fdb 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -660,20 +660,29 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_=
RELEASE)
>  BTF_KFUNCS_END(test_sk_check_kfunc_ids)
>
>  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> -                          u32 size, u32 headroom, u32 tailroom)
> +                          u32 size, u32 headroom, u32 tailroom, bool non=
linear)
>  {
>         void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
> -       void *data;
> +       void *data, *dst;
>
>         if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - ta=
ilroom)
>                 return ERR_PTR(-EINVAL);
>
> -       size =3D SKB_DATA_ALIGN(size);
> -       data =3D kzalloc(size + headroom + tailroom, GFP_USER);
> +       /* In non-linear case, data_in is copied to the paged data */
> +       if (nonlinear) {
> +               data =3D alloc_page(GFP_USER);

Do we need more pages here for non-linear data larger than a page?

> +       } else {
> +               size =3D SKB_DATA_ALIGN(size);
> +               data =3D kzalloc(size + headroom + tailroom, GFP_USER);
> +       }
>         if (!data)
>                 return ERR_PTR(-ENOMEM);
>
> -       if (copy_from_user(data + headroom, data_in, user_size)) {
> +       if (nonlinear)
> +               dst =3D page_address(data);
> +       else
> +               dst =3D data + headroom;
> +       if (copy_from_user(dst, data_in, user_size)) {
>                 kfree(data);

syzbot reported a bug. It seems like data allocated through
alloc_page() got freed by kfree() here.

>                 return ERR_PTR(-EFAULT);
>         }
> @@ -910,6 +919,12 @@ static int convert___skb_to_skb(struct sk_buff *skb,=
 struct __sk_buff *__skb)
>         /* cb is allowed */
>
>         if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> +                          offsetof(struct __sk_buff, data_end)))
> +               return -EINVAL;
> +
> +       /* data_end is allowed, but not copied to skb */
> +
> +       if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end)=
,
>                            offsetof(struct __sk_buff, tstamp)))
>                 return -EINVAL;
>
> @@ -984,7 +999,7 @@ static struct proto bpf_dummy_proto =3D {
>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *k=
attr,
>                           union bpf_attr __user *uattr)
>  {
> -       bool is_l2 =3D false, is_direct_pkt_access =3D false;
> +       bool is_l2 =3D false, is_direct_pkt_access =3D false, is_nonlinea=
r =3D false;
>         struct net *net =3D current->nsproxy->net_ns;
>         struct net_device *dev =3D net->loopback_dev;
>         u32 size =3D kattr->test.data_size_in;
> @@ -994,25 +1009,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>         struct sock *sk =3D NULL;
>         u32 retval, duration;
>         int hh_len =3D ETH_HLEN;
> +       int linear_size, ret;
>         void *data;
> -       int ret;
>
> -       if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
> +       if ((kattr->test.flags & ~(BPF_F_TEST_SKB_CHECKSUM_COMPLETE | BPF=
_F_TEST_SKB_NON_LINEAR)) ||
>             kattr->test.cpu || kattr->test.batch_size)
>                 return -EINVAL;
>
> -       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> -                            size, NET_SKB_PAD + NET_IP_ALIGN,
> -                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> -       if (IS_ERR(data))
> -               return PTR_ERR(data);
> -
> -       ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> -       if (IS_ERR(ctx)) {
> -               ret =3D PTR_ERR(ctx);
> -               ctx =3D NULL;
> -               goto out;
> -       }
> +       is_nonlinear =3D kattr->test.flags & BPF_F_TEST_SKB_NON_LINEAR;
>
>         switch (prog->type) {
>         case BPF_PROG_TYPE_SCHED_CLS:
> @@ -1029,6 +1033,27 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>                 break;
>         }
>
> +       if (is_nonlinear && !is_l2)
> +               return -EINVAL;
> +
> +       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> +                            size, NET_SKB_PAD + NET_IP_ALIGN,
> +                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)),
> +                            is_nonlinear);
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> +       if (IS_ERR(ctx)) {
> +               ret =3D PTR_ERR(ctx);
> +               ctx =3D NULL;
> +               goto out;
> +       }
> +
> +       linear_size =3D hh_len;
> +       if (is_nonlinear && ctx && ctx->data_end > linear_size)
> +               linear_size =3D ctx->data_end;

I think BPF_F_TEST_SKB_NON_LINEAR may not be necessary.

To not break backward compatibility (assuming existing users most
likely zero initialized ctx), when ctx->data_end =3D=3D 0 || ctx->data_end
=3D=3D data_size_in, allocate a linear skb as it used to be. Then, if
ctx->data_end < data_size_in, allocate a non-linear skb.

WDYT?

> +
>         sk =3D sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
>         if (!sk) {
>                 ret =3D -ENOMEM;
> @@ -1036,15 +1061,32 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
>         }
>         sock_init_data(NULL, sk);
>
> -       skb =3D slab_build_skb(data);
> +       if (is_nonlinear)
> +               skb =3D alloc_skb(NET_SKB_PAD + NET_IP_ALIGN + size +
> +                               SKB_DATA_ALIGN(sizeof(struct skb_shared_i=
nfo)),
> +                               GFP_USER);
> +       else
> +               skb =3D slab_build_skb(data);
>         if (!skb) {
>                 ret =3D -ENOMEM;
>                 goto out;
>         }
> +
>         skb->sk =3D sk;
>
>         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> -       __skb_put(skb, size);
> +
> +       if (is_nonlinear) {
> +               skb_fill_page_desc(skb, 0, data, 0, size);
> +               skb->truesize +=3D PAGE_SIZE;
> +               skb->data_len =3D size;
> +               skb->len =3D size;

Do we need to update skb_shared_info?


> +
> +               /* eth_type_trans expects the Ethernet header in the line=
ar area. */
> +               __pskb_pull_tail(skb, linear_size);
> +       } else {
> +               __skb_put(skb, size);
> +       }
>
>         data =3D NULL; /* data released via kfree_skb */
>
> @@ -1127,9 +1169,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>         convert_skb_to___skb(skb, ctx);
>
>         size =3D skb->len;
> -       /* bpf program can never convert linear skb to non-linear */
> -       if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> +       if (skb_is_nonlinear(skb)) {
> +               /* bpf program can never convert linear skb to non-linear=
 */
> +               WARN_ON_ONCE(!is_nonlinear);
>                 size =3D skb_headlen(skb);
> +       }
>         ret =3D bpf_test_finish(kattr, uattr, skb->data, NULL, size, retv=
al,
>                               duration);
>         if (!ret)
> @@ -1139,7 +1183,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>         if (dev && dev !=3D net->loopback_dev)
>                 dev_put(dev);
>         kfree_skb(skb);
> -       kfree(data);
> +       if (data)
> +               is_nonlinear ? __free_page(data) : kfree(data);
>         if (sk)
>                 sk_free(sk);
>         kfree(ctx);
> @@ -1265,7 +1310,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>                 size =3D max_data_sz;
>         }
>
> -       data =3D bpf_test_init(kattr, size, max_data_sz, headroom, tailro=
om);
> +       data =3D bpf_test_init(kattr, size, max_data_sz, headroom, tailro=
om, false);
>         if (IS_ERR(data)) {
>                 ret =3D PTR_ERR(data);
>                 goto free_ctx;
> @@ -1388,7 +1433,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_pro=
g *prog,
>         if (size < ETH_HLEN)
>                 return -EINVAL;
>
> -       data =3D bpf_test_init(kattr, kattr->test.data_size_in, size, 0, =
0);
> +       data =3D bpf_test_init(kattr, kattr->test.data_size_in, size, 0, =
0, false);
>         if (IS_ERR(data))
>                 return PTR_ERR(data);
>
> @@ -1661,7 +1706,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
>
>         data =3D bpf_test_init(kattr, kattr->test.data_size_in, size,
>                              NET_SKB_PAD + NET_IP_ALIGN,
> -                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> +                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)),
> +                            false);
>         if (IS_ERR(data))
>                 return PTR_ERR(data);
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 233de8677382..34272cd07dd2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1448,6 +1448,10 @@ enum {
>  #define BPF_F_TEST_XDP_LIVE_FRAMES     (1U << 1)
>  /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>  #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE       (1U << 2)
> +/* If set, skb will be non-linear with the size of the linear area given
> + * by ctx.data_end or at least ETH_HLEN.
> + */
> +#define BPF_F_TEST_SKB_NON_LINEAR      (1U << 3)
>
>  /* type for BPF_ENABLE_STATS */
>  enum bpf_stats_type {
> --
> 2.43.0
>

