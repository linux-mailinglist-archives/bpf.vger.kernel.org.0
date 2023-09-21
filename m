Return-Path: <bpf+bounces-10515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23F7A9185
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 07:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D251B208FB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 05:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DA2106;
	Thu, 21 Sep 2023 05:12:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC065C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 05:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C639C433CB
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 05:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695273136;
	bh=YXgZQ6Qzm1MMhypLJyFUCnHsVNGYxvGAiW2hv5qdOIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=upRji7WXAjgKg1NH1q7a8cMRO4wAD24X00M7+z9hPlMHjL9V2gAJ7J7WP4mG5Api5
	 Xb05+d3FtPrrTEEvYQLTmzG1OoeOMZgsYcIrGJpFKjHb+KRYZXlkigfrzJbrBWxZB4
	 vA4WzR7gavSc+ORiJFyp0W13zTnwku+rZcCWmSpmQ2whDt0WXMnBAPP12pd6G7Ibuh
	 EBQ0Z0xEPFdHBjZsj4QlyunZXG3vZXA7kTsV08+Me8bmh6Sy80VPma5MohOQSJLIWz
	 NvTpQK7fS7EfT2WWFkBjor8cYfF7fr0yze7jalM6N29+ThSeawMPrm3pj7e2VcOgpp
	 UfbanX3TIxSgQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-502b0d23f28so962560e87.2
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 22:12:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4T95o/Is8HV5XQ8rLwccOmFPrvv+MhWLCFy+RoHlihOuGREF7
	J/9+vk5UAujLMHq8aOrpsZ28gNKtjX6hBQ0/IcE=
X-Google-Smtp-Source: AGHT+IHCS1zHQvUXjs1uC58Cfjg1yVZOnM3W0xJIdAm7BnNhHHgkGyle+Zsu1LZQfQc8jihiW3QmWAdNlgy7DD2QeAw=
X-Received: by 2002:ac2:5283:0:b0:502:feeb:48b2 with SMTP id
 q3-20020ac25283000000b00502feeb48b2mr3787432lfm.35.1695273134805; Wed, 20 Sep
 2023 22:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920053158.3175043-1-song@kernel.org> <20230920053158.3175043-7-song@kernel.org>
 <00447f8b-bfd3-4bb0-946a-beb7f9fe0f55@huawei.com>
In-Reply-To: <00447f8b-bfd3-4bb0-946a-beb7f9fe0f55@huawei.com>
From: Song Liu <song@kernel.org>
Date: Wed, 20 Sep 2023 22:12:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7M4BbVSDiZK=N+pZSia8xOshyVN3Y6H3X+kj8KK-E5Yg@mail.gmail.com>
Message-ID: <CAPhsuW7M4BbVSDiZK=N+pZSia8xOshyVN3Y6H3X+kj8KK-E5Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
To: Pu Lehui <pulehui@huawei.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 5:46=E2=80=AFPM Pu Lehui <pulehui@huawei.com> wrote=
:
>
[...]
> > +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags=
,
> > +                          struct bpf_tramp_links *tlinks, void *func_a=
ddr)
> > +{
> > +     struct bpf_tramp_image im;
> > +     struct rv_jit_context ctx;
> > +
> > +     ctx.ninsns =3D 0;
> > +     ctx.insns =3D NULL;
> > +     ctx.ro_insns =3D NULL;
> > +     ret =3D __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, =
flags, &ctx);
> > +
> > +     return ret < 0 ? ret : ninsns_rvoff(ctx->ninsns);
> > +}
> > +
> >   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ima=
ge,
> >                               void *image_end, const struct btf_func_mo=
del *m,
> >                               u32 flags, struct bpf_tramp_links *tlinks=
,
> > @@ -1032,14 +1046,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp=
_image *im, void *image,
> >       int ret;
> >       struct rv_jit_context ctx;
> >
> > -     ctx.ninsns =3D 0;
> > -     ctx.insns =3D NULL;
> > -     ctx.ro_insns =3D NULL;
> > -     ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, f=
lags, &ctx);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     if (ninsns_rvoff(ret) > (long)image_end - (long)image)
> > +     ret =3D arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr)=
;
>
> Hi Song, there is missing check for negative return values.

Thanks! I will fix it in the next version.

Song

> > +     if (ret > (long)image_end - (long)image)
> >               return -EFBIG;
> >
> >       ctx.ninsns =3D 0;
> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.=
c
> > index e6a643f63ebf..8fab4795b497 100644
> > --- a/arch/s390/net/bpf_jit_comp.c
> > +++ b/arch/s390/net/bpf_jit_comp.c
> > @@ -2483,6 +2483,21 @@ static int __arch_prepare_bpf_trampoline(struct =
bpf_tramp_image *im,
> >       return 0;
> >   }
[...]

