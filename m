Return-Path: <bpf+bounces-70214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA28BB489B
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D619E48C5
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76D525A2D8;
	Thu,  2 Oct 2025 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSf67Oz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4381DA0E1
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422534; cv=none; b=FKx7pMqEYH/E8T8D3bMnoQAWiiyJgoDlcdHH2l7mXTBx1Vs0MaIiHnMBAThV4juVaRuaBjnl/4u+AdjuCS/xDZO8cMff1NCCz4LbHwmlP0pcL3gwBH8srOKzATx+bFGrLXUIb+WZ9YQc/dzbu99M+DMzOYoMStkhhJUmCsUnrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422534; c=relaxed/simple;
	bh=gHfSQXSnYE/lH5bnhiVso599AYB/Qrm+mTcSp3Cb/Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT35mKiKSqYxe/x4Ei9h7fpx4PWyyQPrsHLdx+n7IgjzAqQ4wxtKWTy9VrFO38SUVqFlSUuodJCpm0MiOMpLoVf4yyHOuHJ+ph6A9e210F52nIafgrTOaMQT8Yyc7uym+TLYX9AGEXvEq5ZtG64FdvHIkMISEDoo3UUHfv3jWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSf67Oz2; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6360f986fb0so1451492d50.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422530; x=1760027330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+yu+khfe3DJvC0L7zfWNzDlqhnpTqz9bnHVD5QNWOw=;
        b=dSf67Oz2Ls+ZQs3YnXpDsPCC8EnKhBKSX3NWFnRDSmfHRQAW5cCQaKW0A0eBodnWPk
         6QAwYVeB98E1o0hZeHjolCs1IRlZBNYXhsC+aAyuV4OAgFE9W8wv3HygUEnhOS4+qfXJ
         NRq5AY8D2PBb/s09uA11HiY7sJ3f/BFXkGmMmoUex2eFRWCuYnxz/RhVyKjfpqhDEUqY
         yCp4DWpOqgiHQ7fAdisEBMSvLMcbJz9Hkyts4fNu0euk/WmCv/+BUXYe807yfeQLueFb
         h68u3yJhAzcBDEzrGwteio+R5Klni/A1BEqXV8sklohX1332Jkcvk8z6FeLUsvqX2EOZ
         HL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422530; x=1760027330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+yu+khfe3DJvC0L7zfWNzDlqhnpTqz9bnHVD5QNWOw=;
        b=PgvR5EzQDQ8W/cnJsrFVMiSNjPWlaE42JTMl1Fm7x0di3qWM69wQhqr8h6vhJ/uKOF
         6KMIwKc9aA0thy2OSNO1yTQr4Z+OqAm4ZJCb3WDfb6o1HS9Wyz5UqkjBaeFcDPhLRI0f
         Qiufr7zj6Va1UDiQxXTrAHPnQueeQM/SJJiIiduVZFWZrQrj2iQTpJ+XLo7w/J87BjfA
         6tjuEi9S6USBR1Neha8/umuPArwUrg9Ji0K1nkBYIbKt0vtGSNIbFzukM21zuHmnZvZA
         oOg9ncdPQPTGBv+Kwg2LCWFB+K0980cR2BN/TpWNSBlnvRoqe9JYNTs5JLdWawG94Gh8
         Hg3A==
X-Gm-Message-State: AOJu0YyF0okBep15dzh+fxM2dQvvw2B73n+Virw5kPgwT30H7+qgim2E
	Xmcpe4r5LQ+q/vx7b8ClHIeQCXVE1mAUizU2SGFUGqmGpqJxVgrziRAARszjfsxOFTUqBKLyKnP
	1APWCP0Eqy90XayAMqwZ5podfQsqSsAc=
X-Gm-Gg: ASbGncv2Tg7l+g898QfU3iM3rFiQx6W+tQYBSWmqNXYSYkfacSzKAsqIkp2MGgoz5cA
	PKOfVcHKZM8euk95DT9hutBY1EX8mBOwX/OBfNwe9RSPfE5BmAJpJlE3wNa5+isp6ZffAxi8REV
	7RbXTpIT8jRQfUNgekn1wu72N9yOBlG1CVdb0k1/5NnRiq2Q7KiNDut44TOX3eqt1Y3+n5Y3Gfg
	xgRmenPh9aNugCVgv2eHTTXSTuZ7Defyo/GYC/75Z2azLg=
X-Google-Smtp-Source: AGHT+IFM7i1L8EpvalN9tcccyTuXDVVFfmTPdfIYTzYCIYzv/K3R5V3qMxPu3b0YUio8g94LVm8vaf9qQjffN8h9wT8=
X-Received: by 2002:a53:a38e:0:b0:62a:b545:54b4 with SMTP id
 956f58d0204a3-63b7009cff8mr7313051d50.26.1759422530141; Thu, 02 Oct 2025
 09:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759397353.git.paul.chaignon@gmail.com> <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
 <CAMB2axP+gYUmD73RyOjGCCykAZWbu5aUcAN=emkbbYSw4mAJOA@mail.gmail.com>
In-Reply-To: <CAMB2axP+gYUmD73RyOjGCCykAZWbu5aUcAN=emkbbYSw4mAJOA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Oct 2025 09:28:39 -0700
X-Gm-Features: AS18NWD6rguUU54szNatkiDLNwuOw3fjVQrvEHXCibGMD4vUqpjuKR3o1j8mWmU
Message-ID: <CAMB2axOXaU9Br+FL+ZZ=CrPMDxxpV6r331SVEgBS3Rfh07BZuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:07=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Oct 2, 2025 at 3:07=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
> >
> > This patch adds support for crafting non-linear skbs in BPF test runs
> > for tc programs. The size of the linear area is given by ctx->data_end,
> > with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> > ctx->data_end are null, a linear skb is used.
> >
> > This is particularly useful to test support for non-linear skbs in larg=
e
> > codebases such as Cilium. We've had multiple bugs in the past few years
> > where we were missing calls to bpf_skb_pull_data(). This support in
> > BPF_PROG_TEST_RUN would allow us to automatically cover this case in ou=
r
> > BPF tests.
> >
> > In addition to the selftests introduced later in the series, this patch
> > was tested by setting enabling non-linear skbs for all tc selftests
> > programs and checking test failures were expected.
> >
> > Tested-by: syzbot@syzkaller.appspotmail.com
> > Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >  net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 61 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 3425100b1e8c..e4f4b423646a 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *sk=
b, struct __sk_buff *__skb)
> >         /* cb is allowed */
> >
> >         if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> > +                          offsetof(struct __sk_buff, data_end)))
> > +               return -EINVAL;
> > +
> > +       /* data_end is allowed, but not copied to skb */
> > +
> > +       if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_en=
d),
> >                            offsetof(struct __sk_buff, tstamp)))
> >                 return -EINVAL;
> >
> > @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto =3D {
> >  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr =
*kattr,
> >                           union bpf_attr __user *uattr)
> >  {
> > +       u32 tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info))=
;
> >         bool is_l2 =3D false, is_direct_pkt_access =3D false;
> >         struct net *net =3D current->nsproxy->net_ns;
> >         struct net_device *dev =3D net->loopback_dev;
> > +       u32 headroom =3D NET_SKB_PAD + NET_IP_ALIGN;
> > +       u32 linear_sz =3D kattr->test.data_size_in;
> >         u32 size =3D kattr->test.data_size_in;
> >         u32 repeat =3D kattr->test.repeat;
> >         struct __sk_buff *ctx =3D NULL;
> > @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,=
 const union bpf_attr *kattr,
> >         if (IS_ERR(ctx))
> >                 return PTR_ERR(ctx);
> >
> > -       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> > -                            size, NET_SKB_PAD + NET_IP_ALIGN,
> > -                            SKB_DATA_ALIGN(sizeof(struct skb_shared_in=
fo)));
> > +       if (ctx) {
> > +               if (!is_l2 || ctx->data_end > kattr->test.data_size_in)=
 {

Maybe we should reject non-zero ctx->data and ctx->data_meta to
prevent confusion from the user space.

> > +                       ret =3D -EINVAL;
> > +                       goto out;
> > +               }
> > +               if (ctx->data_end)
> > +                       linear_sz =3D max(ETH_HLEN, ctx->data_end);
> > +       }
> > +
> > +       data =3D bpf_test_init(kattr, linear_sz, size, headroom, tailro=
om);
> >         if (IS_ERR(data)) {
> >                 ret =3D PTR_ERR(data);
> >                 data =3D NULL;
> > @@ -1044,10 +1060,47 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >                 ret =3D -ENOMEM;
> >                 goto out;
> >         }
> > +
> >         skb->sk =3D sk;
> >
> >         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> > -       __skb_put(skb, size);
> > +       __skb_put(skb, linear_sz);
> > +
> > +       if (unlikely(kattr->test.data_size_in > linear_sz)) {
> > +               void __user *data_in =3D u64_to_user_ptr(kattr->test.da=
ta_in);
> > +               struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +
> > +               size =3D linear_sz;
> > +               while (size < kattr->test.data_size_in) {
> > +                       struct page *page;
> > +                       u32 data_len;
> > +
> > +                       if (sinfo->nr_frags =3D=3D MAX_SKB_FRAGS) {
> > +                               ret =3D -ENOMEM;
> > +                               goto out;
> > +                       }
> > +
> > +                       page =3D alloc_page(GFP_KERNEL);
> > +                       if (!page) {
> > +                               ret =3D -ENOMEM;
> > +                               goto out;
> > +                       }
> > +
> > +                       data_len =3D min_t(u32, kattr->test.data_size_i=
n - size,
> > +                                        PAGE_SIZE);
> > +                       skb_fill_page_desc(skb, sinfo->nr_frags, page, =
0, data_len);
> > +
> > +                       if (copy_from_user(page_address(page), data_in =
+ size,
> > +                                          data_len)) {
> > +                               ret =3D -EFAULT;
> > +                               goto out;
> > +                       }
> > +                       skb->data_len +=3D data_len;
> > +                       skb->truesize +=3D PAGE_SIZE;
> > +                       skb->len +=3D data_len;
> > +                       size +=3D data_len;
> > +               }
> > +       }
> >
> >         data =3D NULL; /* data released via kfree_skb */
>
> It seems that it can still double free if we error out when building
> fragments. Maybe data need to be set to NULL right after
> slab_build_skb() succeeds.
>
> >
> > @@ -1130,9 +1183,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,=
 const union bpf_attr *kattr,
> >         convert_skb_to___skb(skb, ctx);
> >
> >         size =3D skb->len;
> > -       /* bpf program can never convert linear skb to non-linear */
> > -       if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> > +       if (skb_is_nonlinear(skb)) {
> > +               /* bpf program can never convert linear skb to non-line=
ar */
> > +               WARN_ON_ONCE(linear_sz =3D=3D size);
> >                 size =3D skb_headlen(skb);
> > +       }
> >         ret =3D bpf_test_finish(kattr, uattr, skb->data, NULL, size, re=
tval,
> >                               duration);
> >         if (!ret)
> > --
> > 2.43.0
> >

