Return-Path: <bpf+bounces-69265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439DB93219
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212D1884824
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14C2F39BE;
	Mon, 22 Sep 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgsPgqvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46C1519AC
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570517; cv=none; b=dUjXbqkOOgdqsa4zSE+RYrkKl5xjaRcJs0gRVp6UFITeHOfNoHENgjC2p0NUI10QisZM/mauPDzXbFvfZ6hvgCo6pdb30PQNdntU6Y0J4xPhzdPjy/Fxv0I7I2mwj6GAMwfmxc1PDdeyC7lyp5A0KkjgNUNsCmi58obYpSB9HPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570517; c=relaxed/simple;
	bh=qXPBZfUeP/x6RysCp+DHEFbAwgv+uy1CyVQOf6oSNis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9Us4rKfjAU1MyJGinOVc/MBRR4gy0oc0QFCVnipQyxzqAOm0yUmlSpsRxzS++hHZ5DgMQdsY4b9+ZCSrAeiTuSPfwCST/g+BE5gym5Ft/MvxkOw6NpaRcYgRy9+MP6onc0FNzFR6PaEGrHqBbqu6LJpSb1+yFqMQGBoYlOkrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgsPgqvx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603b674aso32866087b3.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570515; x=1759175315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkdVW60zSe89lw4PQimfW9ADIdTFhU+1bpHfkRIYwaU=;
        b=VgsPgqvx1S+RMmk2fP4TxxO75nCxcfOaxbOczC7qY9ndPoElJYnmikB/KLaO9miT+D
         YGe346AyXSCExL3FNYOtzRH4VPj3tUtEgp9QNueSc0DQGV2clKoUjXShNn1NMofJH/7+
         dmr4IXiC1OI5gyqcJHYhMhImGz5b07vVWx1oab0r++/dLPr0arSraY5dcD1/gy43xkzn
         hY0DG7twZG140YNWerxYK+zhQ53h8SyIgWxYHNmKY8bWwXVEIp+HgsJD5OIrvontCOta
         LBZe/qI3H7Sn9xzTlovOXJ4LIMy8yTU22+MXGm7iNNoxMeJnHN7mW7QTrrXP0lDdbQct
         0Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570515; x=1759175315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkdVW60zSe89lw4PQimfW9ADIdTFhU+1bpHfkRIYwaU=;
        b=iJq0ZlmhVwvAyehOTvZr486cPXT0wAqZMJnFHxJwC+wyXOBgnZeHiOUR+xwrO17Xr9
         RhEXoQ95NMMhhWISkQlJoZ2npQ67QIOQ/2CkoALb8R8slP9q11zD94KvEpRszixAURCT
         YcFtHp7q/BbIrkEsNqNL5PpD9cRfAqLSh2su1dgfDA3OBmgsIjF2yzUNl+NcjEiKqWsY
         ViTl/10uhsAvoMc6GYV37iNGvHdMFeWPB24xz5cJHud43TcKT/Fx6nKEbxhgLmSVJCi1
         Wcl0UCgJ2iADDn6Mnia7d0tLql1doaiwD88oIjVPZjM5VmS3hYmRZlEsIJe2NyDj4Cky
         aFFQ==
X-Gm-Message-State: AOJu0YyV9UUb70c8eJkb/SruzUgPigCr8N44CvCoqX919CI9MSwAGyoS
	6o3EgfTFGYIVmmXriJho5f9fyl93SGZxK6P7w0BrN5X7SKasGC+OxCXaDyb7vePejV+EipdWIdW
	jf8uc3+np6F55cigKqQx1AZknbD7Lzxc=
X-Gm-Gg: ASbGncv2p3+RCBpls2rvaChU9QeuzeM3Cq7vYmQ+mhWDIqU5BOKNEGqEuwWw+hkB62P
	Rh7aOOdq9G3Rw4STJWyn3hWlqnHtIGf42BJVnfQ9JFfPBzmW7rBVCOMItFD/34tXrorn6XQT5Bh
	OrHWBvdpfmjAu4Xli8hzLeSzwC61Y+hPKFhaVKZnpGZtPdwZlYvdXvZiEcwcpJBYqvKBMPzU300
	/ZE8Xa1DMTT4mlUq1VH1EA=
X-Google-Smtp-Source: AGHT+IEZ5OncBWjcOYfngJq1dEgQo4TW2iU0lYmppckWvFdyt93kHvoBkPjsNglkApCcVkY9EaDblmp++PIMna5urqo=
X-Received: by 2002:a05:690c:6307:b0:754:ee80:db85 with SMTP id
 00721157ae682-754ee80f937mr25242347b3.19.1758570514761; Mon, 22 Sep 2025
 12:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919230952.3628709-1-ameryhung@gmail.com> <20250919230952.3628709-6-ameryhung@gmail.com>
 <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev>
In-Reply-To: <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 12:48:23 -0700
X-Gm-Features: AS18NWAYbVJlzqPm94m4ngsATayGeBcreL_L477PqE-kxQKC0ytWFqOJ2spEQRE
Message-ID: <CAMB2axPU6Aoj6hfJcsS0W7CDL=bvAFLtPm2ZrsJef3w+aNoAXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:21=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 9/19/25 4:09 PM, Amery Hung wrote:
> > To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
> > as free linear data area after xdp->data_end needs to be created.
> > However, bpf_prog_test_run_xdp() always fills the linear area with
> > data_in before creating fragments, leaving no space to pull data. This
> > patch will allow users to specify the linear data size through
> > ctx->data_end.
> >
> > Currently, ctx_in->data_end must match data_size_in and will not be the
> > final ctx->data_end seen by xdp programs. This is because ctx->data_end
> > is populated according to the xdp_buff passed to test_run. The linear
> > data area available in an xdp_buff, max_data_sz, is alawys filled up
> > before copying data_in into fragments.
> >
> > This patch will allow users to specify the size of data that goes into
> > the linear area. When ctx_in->data_end is different from data_size_in,
> > only ctx_in->data_end bytes of data will be put into the linear area wh=
en
> > creating the xdp_buff.
> >
> > While ctx_in->data_end will be allowed to be different from data_size_i=
n,
> > it cannot be larger than the data_size_in as there will be no data to
> > copy from user space. If it is larger than the maximum linear data area
> > size, the layout suggested by the user will not be honored. Data beyond
> > max_data_sz bytes will still be copied into fragments.
> >
> > Finally, since it is possible for a NIC to produce a xdp_buff with empt=
y
> > linear data area, allow it when calling bpf_test_init() from
> > bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
> > xdp_buff. This is done by moving lower-bound check to callers as most o=
f
> > them already do except bpf_prog_test_run_skb().
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   net/bpf/test_run.c                                       | 9 +++++++-=
-
> >   .../selftests/bpf/prog_tests/xdp_context_test_run.c      | 4 +---
> >   2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 4a862d605386..0cbd3b898c45 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *ka=
ttr, u32 user_size,
> >       void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
> >       void *data;
> >
> > -     if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - ta=
ilroom)
> > +     if (user_size > PAGE_SIZE - headroom - tailroom)
> >               return ERR_PTR(-EINVAL);
> >
> >       size =3D SKB_DATA_ALIGN(size);
> > @@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
> >           kattr->test.cpu || kattr->test.batch_size)
> >               return -EINVAL;
> >
> > +     if (size < ETH_HLEN)
> > +             return -EINVAL;
> > +
> >       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> >                            size, NET_SKB_PAD + NET_IP_ALIGN,
> >                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> > @@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog=
, const union bpf_attr *kattr,
>
> I just noticed it. It still needs a "size < ETH_HLEN" test at the beginni=
ng of
> test_run_xdp. At least the do_live mode should still needs to have ETH_HL=
EN bytes.

Make sense. I will add the check for live mode.

>
> >
> >       if (ctx) {
> >               /* There can't be user provided data before the meta data=
 */
> > -             if (ctx->data_meta || ctx->data_end !=3D size ||
> > +             if (ctx->data_meta || ctx->data_end > size ||
> >                   ctx->data > ctx->data_end ||
> >                   unlikely(xdp_metalen_invalid(ctx->data)) ||
> >                   (do_live && (kattr->test.data_out || kattr->test.ctx_=
out)))
> >                       goto free_ctx;
> >               /* Meta data is allocated from the headroom */
> >               headroom -=3D ctx->data;
> > +
> > +             size =3D ctx->data_end;
> >       }
> >
> >       max_data_sz =3D PAGE_SIZE - headroom - tailroom;
> It still needs to avoid multi-frags/bufs in do_live and the "if (size >
> max_data_sz)" needs some adjustments. I think it is cleaner to specifical=
ly test
> "kattr->test.data_size_in". Something like this (untested) ?
>
> -       if (size > max_data_sz) {
> -               /* disallow live data mode for jumbo frames */
> -               if (do_live)
> -                       goto free_ctx;
> -               size =3D max_data_sz;
> -       }
> +       size =3D min_t(u32, size, max_data_sz);
> +
> +       if (kattr->test.data_size_in > size && do_live)
> +               goto free_ctx;
>

Looks correct to me. I will try to rename some variables to make
things less confusing.

Thanks for catching the bugs, especially this part.

> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_ru=
n.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > index 46e0730174ed..178292d1251a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> > @@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
> >       /* Meta data must be 255 bytes or smaller */
> >       test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0,=
 0);
> >
> > -     /* Total size of data must match data_end - data_meta */
> > -     test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
> > -                            sizeof(data) - 1, 0, 0, 0);
> > +     /* Total size of data must be data_end - data_meta or larger */
> >       test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
> >                              sizeof(data) + 1, 0, 0, 0);
> >
>

