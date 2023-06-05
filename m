Return-Path: <bpf+bounces-1853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF36722ECC
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770FF281406
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CBFBE49;
	Mon,  5 Jun 2023 18:34:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD620EA
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 18:34:06 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BAED;
	Mon,  5 Jun 2023 11:34:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so31778901fa.0;
        Mon, 05 Jun 2023 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685990043; x=1688582043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlbBib9nCyYV+iIws2sR7sUNPZc1W01Uy7DoW0E5ju0=;
        b=cisPSQ6oJePCmzNmkFwbVOP5+wEqDWKfSGNe/yt6+9N0kdFTR0her6nqH9V/zS1MeA
         1SvF70kUzd1JzXiC49jwRtLY/7Ycut3NqjD5jE4quqk5dsPZc6eE5iU/J53lxv7V2bfO
         IEtIoxUQPozlbMRyOyuPaMGhkJiv+GDBy5CLGDKE3v6rFMVKwKeVDa/L1B/12iaNRFF/
         29ithsZ9wuAP7RhSPELR2C47j8Tn5ZXDVOOUARgsYKsqC0Dr1GmHJYxGuI1T4V1mr6mN
         Yvdd67p9P5M2/dPNnw5H3ebd8OP9v67309MgCt7j0AlR3H3w7kMsdqtcyPWN2vWoua3+
         h6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990043; x=1688582043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlbBib9nCyYV+iIws2sR7sUNPZc1W01Uy7DoW0E5ju0=;
        b=deB5HnTm2CtTgSjBwtMzT/TDdzRMPjOwfIWymScx9iymQDkzc49bZqBTyl54+La+7u
         rmfv3npNQPGDzLXoqNC6oFj1KuGy8W+mTRdjNXuE3X+2Tq/q2qeJnOPDCKkuop7HHVdd
         mIGcpcFdSJBQ3zOd8XQvCBWL4bIgYeoyoB2xc+2IbiDQT4eCDmxJ56o/XvxezZBK0pg4
         11Ket4sfhcQ5L6r8cnsY+Uot7r6He0sb5gFW1qRvvzZufeo8LhFbta2MKsQ8i0boCN2S
         hagkpLmmaikskySbpzBAvjjTwmLE/qBMKXBsjbCtFJZDzxJ6ZesNmJD2Nrb1XZkS3jaI
         4ukg==
X-Gm-Message-State: AC+VfDyMdmX6qZ0weT/ZrJdJCMKrmc6ax+UvAMHZDe3cQzLhPcoTGPns
	jD1EpnH4pRyQs2PlaCX4Rm662rrz+Cv4UQPTnnU=
X-Google-Smtp-Source: ACHHUZ5PCYmedNWIllyP2yLrq7PD/Q4nq7rQbc5kIjfmI+yPdEQEJqphRtIaZbBMgX7YDfDNiCqcmbAMACuyfgy8+Dk=
X-Received: by 2002:a2e:9ec3:0:b0:2b1:eae8:5e8b with SMTP id
 h3-20020a2e9ec3000000b002b1eae85e8bmr34289ljk.24.1685990042590; Mon, 05 Jun
 2023 11:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com>
 <20230605074024.1055863-4-puranjay12@gmail.com> <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
In-Reply-To: <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 5 Jun 2023 20:33:51 +0200
Message-ID: <CANk7y0jrPPW6GqPFi4SOTzgHyVPG_KY2tcrm=S0cG8P9=w0m1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Jun 5, 2023 at 7:05=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> > ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and R=
X
> > buffers. The JIT writes the program into the RW buffer. When the JIT is
> > done, the program is copied to the final ROX buffer
> > with bpf_jit_binary_pack_finalize.
> >
> > Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> > JIT as these functions are required by bpf_jit_binary_pack allocator.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++-----
> >  1 file changed, 102 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index 145b540ec34f..ee9414cadea8 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -76,6 +76,7 @@ struct jit_ctx {
> >         int *offset;
> >         int exentry_idx;
> >         __le32 *image;
> > +       __le32 *ro_image;
>
> We are using:
> image vs. ro_image
> rw_header vs. header
> rw_image_ptr vs. image_ptr

Will use "rw_image" and "image" in the next version.

>
> Shall we be more consistent with rw_ or ro_ prefix?
>
> >         u32 stack_size;
> >         int fpb_offset;
> >  };
> > @@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned int=
 size)
> >                 *ptr++ =3D cpu_to_le32(AARCH64_BREAK_FAULT);
> >  }
> >
> > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > +{
> > +       __le32 *ptr;
> > +       int ret;
> > +
> > +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32)) {
> > +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH64_B=
REAK_FAULT);
>
> I think one aarch64_insn_patch_text_nosync() per 4 byte is too much overh=
ead.
> Shall we add a helper to do this in bigger patches?

What would be the most efficient way to build this helper? As arm64 doesn't
have the __text_poke() API. Calling copy_to_kernel_nofault() in a loop migh=
t
not be the best way. One way would be to use __put_kernel_nofault() directl=
y.

Also, what should we call this helper? aarch64_insn_memset() ?

Thanks,
Puranjay

