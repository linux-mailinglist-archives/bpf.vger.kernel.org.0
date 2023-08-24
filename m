Return-Path: <bpf+bounces-8529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D04787B25
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBD92815DC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1EA95F;
	Thu, 24 Aug 2023 22:04:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292FA945
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 22:04:32 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D71BF2;
	Thu, 24 Aug 2023 15:04:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso4128171fa.0;
        Thu, 24 Aug 2023 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692914667; x=1693519467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfWfQ+lRO+WKeDH70mlU0lgd8cz1Kx8i7ys96tkzebQ=;
        b=S7NZJZ+VOsav0sm/ft26D6Am3LCuAyVsp1LgE/P0MvSw0PgpyVIrSlhTUdqCRQZx0Q
         6jGbYAmoXjd+l1k2UEpRUtp3wf0dnehG+voSHBpQHZQUIcNy2bzD7Lx3SYdMYSwbTUt1
         lDbxvrvN0Uvww5Dux82iOCG7s0ZDy419I/wItkmjUxslMl92oM0fiC3mqotaZJvpl9y0
         a2toHbjNxPddjYofXoUcCuTEeFmaESPtLfhtk5JcrD2C2BJXNQC94JrIqkT9GJ8Ad350
         Fvii1hj0VSe4wGhiLqCFpTX8MHow++qZu0S6zrPbeg5Y8oyN7YdI667ERQICARg6xgxP
         aiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692914667; x=1693519467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfWfQ+lRO+WKeDH70mlU0lgd8cz1Kx8i7ys96tkzebQ=;
        b=aVdoLukj596anxSMHjH7BGUQ0/Fzj60wyznG/duZXzwqDfk7LeAevLDC5qd2y54scq
         m/z/RbIh4ydThrOvH3ToPWiCdOGraCQs5eZ87vIAH+2FGRVLhF9ccxjqx9KPnuPiAsdm
         HSAOORBSgo6I4G0it9ZFIxEqP5Lp+jOci4IZvcPsVkccO/sS66vzDAjY8rikgl41ttaB
         el6gz0QoQMq1JFkm35m4LltRCS+UxbaxYUx2/7Ry7o/8TEm3dPq7+1H3KLOOjWXftDLq
         6djZh76H9p8mR7jnsP0IN3Sq2jdF8SKASiRIX+QfxNnxXeXATfzGDqU2UcePz9ft5Imw
         Nx5Q==
X-Gm-Message-State: AOJu0YyGWYyTzFY3tOM6xK1+jGs5Sy1FpCqXYXFo0W4Pbu3Puku9JOdl
	MPhkQFjsV8kKKEj5W1wOFeWA+ArfF+YqaO9BKfU=
X-Google-Smtp-Source: AGHT+IELeWgckaV4V/XWmfU+4z0tlYBZeZ4Q0PJTA5DJsAayONqHOr3jMuSh5u/qLWsZhrs02IZo919xV5Fr25tn+Jg=
X-Received: by 2002:a2e:9d10:0:b0:2bc:de8d:4ab1 with SMTP id
 t16-20020a2e9d10000000b002bcde8d4ab1mr4024122lji.6.1692914666983; Thu, 24 Aug
 2023 15:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-2-puranjay12@gmail.com> <CAPhsuW5mMQbZ729W_5fhX0iYaNxG5JA1L7Sck-h0jQZQzEH8+Q@mail.gmail.com>
In-Reply-To: <CAPhsuW5mMQbZ729W_5fhX0iYaNxG5JA1L7Sck-h0jQZQzEH8+Q@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 25 Aug 2023 00:04:15 +0200
Message-ID: <CANk7y0i8YS70xbcXT7g0RmgR1Oi_Psk7gdNUdHzGCLvpddPd3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] riscv: extend patch_text_nosync() for
 multiple pages
To: Song Liu <song@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, 
	kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Song,

On Thu, Aug 24, 2023 at 11:57=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 24, 2023 at 6:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > The patch_insn_write() function currently doesn't work for multiple
> > pages of instructions, therefore patch_text_nosync() will fail with a
> > page fault if called with lengths spanning multiple pages.
> >
> > This commit extends the patch_insn_write() function to support multiple
> > pages by copying at max 2 pages at a time in a loop. This implementatio=
n
> > is similar to text_poke_copy() function of x86.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > ---
> >  arch/riscv/kernel/patch.c | 39 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 34 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 575e71d6c8ae..465b2eebbc37 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -53,12 +53,18 @@ static void patch_unmap(int fixmap)
> >  }
> >  NOKPROBE_SYMBOL(patch_unmap);
> >
> > -static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +static int __patch_insn_write(void *addr, const void *insn, size_t len=
)
> >  {
> >         void *waddr =3D addr;
> >         bool across_pages =3D (((uintptr_t) addr & ~PAGE_MASK) + len) >=
 PAGE_SIZE;
> >         int ret;
> >
> > +       /*
> > +        * Only two pages can be mapped at a time for writing.
> > +        */
> > +       if (len > 2 * PAGE_SIZE)
> > +               return -EINVAL;
>
> This check cannot guarantee __patch_insn_write touch at most two pages.

Yes, I just realised this can span 3 pages if len =3D 2 * PAGE_SIZE and
offset_in_page(addr) > 0.

> Maybe use
>
>     if (len + offset_in_page(addr) > 2 * PAGE_SIZE)
>         return -EINVAL;
> ?

Will fix it in the next version.

>
> Thanks,
> Song
>
> >         /*
> >          * Before reaching here, it was expected to lock the text_mutex
> >          * already, so we don't need to give another lock here and coul=
d
> > @@ -74,7 +80,7 @@ static int patch_insn_write(void *addr, const void *i=
nsn, size_t len)
> >                 lockdep_assert_held(&text_mutex);
> >
> >         if (across_pages)
> > -               patch_map(addr + len, FIX_TEXT_POKE1);
> > +               patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
> >
> >         waddr =3D patch_map(addr, FIX_TEXT_POKE0);
> >
> > @@ -87,15 +93,38 @@ static int patch_insn_write(void *addr, const void =
*insn, size_t len)
> >
> >         return ret;
> >  }
> > -NOKPROBE_SYMBOL(patch_insn_write);
> > +NOKPROBE_SYMBOL(__patch_insn_write);
> >  #else
> > -static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +static int __patch_insn_write(void *addr, const void *insn, size_t len=
)
> >  {
> >         return copy_to_kernel_nofault(addr, insn, len);
> >  }
> > -NOKPROBE_SYMBOL(patch_insn_write);
> > +NOKPROBE_SYMBOL(__patch_insn_write);
> >  #endif /* CONFIG_MMU */
> >
> > +static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +{
> > +       size_t patched =3D 0;
> > +       size_t size;
> > +       int ret =3D 0;
> > +
> > +       /*
> > +        * Copy the instructions to the destination address, two pages =
at a time
> > +        * because __patch_insn_write() can only handle len <=3D 2 * PA=
GE_SIZE.
> > +        */
> > +       while (patched < len && !ret) {
> > +               size =3D min_t(size_t,
> > +                            PAGE_SIZE * 2 - offset_in_page(addr + patc=
hed),
> > +                            len - patched);
> > +               ret =3D __patch_insn_write(addr + patched, insn + patch=
ed, size);
> > +
> > +               patched +=3D size;
> > +       }
> > +
> > +       return ret;
> > +}
> > +NOKPROBE_SYMBOL(patch_insn_write);
> > +
> >  int patch_text_nosync(void *addr, const void *insns, size_t len)
> >  {
> >         u32 *tp =3D addr;
> > --
> > 2.39.2
> >

Thanks,
Puranjay

