Return-Path: <bpf+bounces-1862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4272310B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001DC281363
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5572261CA;
	Mon,  5 Jun 2023 20:19:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA034DDC0
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:19:55 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F761E7B;
	Mon,  5 Jun 2023 13:19:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1b084620dso48821321fa.0;
        Mon, 05 Jun 2023 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685996382; x=1688588382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W96UEYuBtjbti00Xl+zHBE3PvU7J3K5NYfzeZyJf/zQ=;
        b=GA+HO0b52UQvj7V8Qj/QJPdkkM996YzSk7v7eMjnCk+0QGAtDD8N8RYNFwWFF52ScF
         bweOr5uFNEJ+CWkhW0J761u6gXHoZYbjbkIYEj+N80WO46tpRTkpyWZp/kRs+m5dmXxG
         m8jbBJmEEOlWOc7mndYgIRJ1lMGv5B9plFcfyG2/tFyqR1GWOGl7ZqjkpZ46NC8qfzVZ
         uT5kCPszg2TDW+uRBsBsNYtBahDhGXOGFG8nyBBt5vNxlf22ItXcnuf0zmvBy35YHPTI
         S/aeLhoAQekWsRSIwJWRRlEzvb6HMQYPP4cT5W85qu7kZiLQ2bfHDgeuqz5P1l7opVoH
         7UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996382; x=1688588382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W96UEYuBtjbti00Xl+zHBE3PvU7J3K5NYfzeZyJf/zQ=;
        b=RQloqjeGPSYZAgyw2jTJMet7/pMqCjM9c+AWlekoj02nzBNxTn4FlzGYMJjTa6IpWs
         SkXrP15aZlc/ajTh6pFRn8rKnn9mxrg1LK5jjApte7levhFt7rvYlRh/MnweIhUcEyuu
         hTS7vfePEb4XEsqzNbs2gf7jJ6ON0no64c98+05jwc0oOX/HkGlY5UIBMDCy4t9X93EI
         EgTEceFZZQqeDJWmmKuKL0CKlLgC4hyWrvTUsYJPWKM1QiLD0whpeKSrord7gwURiIt5
         OdQSIOc6DT6Q1pIvcCzNXYLGhN/KSAcJORR01g7vry89Q8Zjn4zFAm2F364oqQ5Gpwbu
         nljw==
X-Gm-Message-State: AC+VfDxuGU2AXpEeTz4KEs3nz5wSJ6J0ADfvyrJHekD8PLQMa1ak1sfc
	IZmxk3sRzPO0S61awUHQBBT1rrPKN/vvhT4QmWw=
X-Google-Smtp-Source: ACHHUZ5JlTcwPlpw7pJ4FSQxYqZlEK45W38wyXUhhtIDRXqJXxWBJs9eHduk57NVSa4iseRQkTmhQT64hF1WAsiFW1g=
X-Received: by 2002:a2e:958b:0:b0:2ac:78b0:8aef with SMTP id
 w11-20020a2e958b000000b002ac78b08aefmr182117ljh.16.1685996382100; Mon, 05 Jun
 2023 13:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com>
 <20230605074024.1055863-4-puranjay12@gmail.com> <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
 <CANk7y0jrPPW6GqPFi4SOTzgHyVPG_KY2tcrm=S0cG8P9=w0m1A@mail.gmail.com> <CAPhsuW79OdJigXU+6D8c=dKRWWeatF8+140CP-AV5xDsn2wpCg@mail.gmail.com>
In-Reply-To: <CAPhsuW79OdJigXU+6D8c=dKRWWeatF8+140CP-AV5xDsn2wpCg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 5 Jun 2023 22:19:31 +0200
Message-ID: <CANk7y0i0Ujjb=rq18bkS_hFYpdmLbbA_kP1KcajO1niUz96_Qw@mail.gmail.com>
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

On Mon, Jun 5, 2023 at 10:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 5, 2023 at 11:34=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Hi,
> >
> > On Mon, Jun 5, 2023 at 7:05=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > >
> > > On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > Use bpf_jit_binary_pack_alloc for memory management of JIT binaries=
 in
> > > > ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW a=
nd RX
> > > > buffers. The JIT writes the program into the RW buffer. When the JI=
T is
> > > > done, the program is copied to the final ROX buffer
> > > > with bpf_jit_binary_pack_finalize.
> > > >
> > > > Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for A=
RM64
> > > > JIT as these functions are required by bpf_jit_binary_pack allocato=
r.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > ---
> > > >  arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 102 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit=
_comp.c
> > > > index 145b540ec34f..ee9414cadea8 100644
> > > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > > @@ -76,6 +76,7 @@ struct jit_ctx {
> > > >         int *offset;
> > > >         int exentry_idx;
> > > >         __le32 *image;
> > > > +       __le32 *ro_image;
> > >
> > > We are using:
> > > image vs. ro_image
> > > rw_header vs. header
> > > rw_image_ptr vs. image_ptr
> >
> > Will use "rw_image" and "image" in the next version.
> >
> > >
> > > Shall we be more consistent with rw_ or ro_ prefix?
> > >
> > > >         u32 stack_size;
> > > >         int fpb_offset;
> > > >  };
> > > > @@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned=
 int size)
> > > >                 *ptr++ =3D cpu_to_le32(AARCH64_BREAK_FAULT);
> > > >  }
> > > >
> > > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > > +{
> > > > +       __le32 *ptr;
> > > > +       int ret;
> > > > +
> > > > +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32=
)) {
> > > > +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH=
64_BREAK_FAULT);
> > >
> > > I think one aarch64_insn_patch_text_nosync() per 4 byte is too much o=
verhead.
> > > Shall we add a helper to do this in bigger patches?
> >
> > What would be the most efficient way to build this helper? As arm64 doe=
sn't
> > have the __text_poke() API. Calling copy_to_kernel_nofault() in a loop =
might
> > not be the best way. One way would be to use __put_kernel_nofault() dir=
ectly.
> >
> > Also, what should we call this helper? aarch64_insn_memset() ?
>
> I just found aarch64_insn_patch_text_cb() also calls
> aarch64_insn_patch_text_nosync() in a loop. So it is probably OK as-is?

Okay, then we can go ahead with this.

Another thing about the consistency of rw_ and ro_ prefix.
The ctx->image is used all over the place in the JIT, so changing it would
require a lot of changes. Therefore the naming convention that I will follo=
w is
"image" and "ro_image". By this naming convention, ctx->image can be left
untouched and only ro_image would be used at some places like:
-       prog->bpf_func =3D (void *)ctx.image;
+       prog->bpf_func =3D (void *)ctx.ro_image;
etc.

I will use this in the next version of the patch.

Thanks,
Puranjay

