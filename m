Return-Path: <bpf+bounces-9381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDB796E13
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527232814C4
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55093807;
	Thu,  7 Sep 2023 00:40:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197077EC
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 00:40:10 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C142172E
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:40:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bd6611873aso7060111fa.1
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694047207; x=1694652007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBJZpKotgksVoJ+0EjwMTCZE7nTiRe5bojyrG2Lg6BI=;
        b=cCh7PUwuOcfIVYSnTsAUZ+Yt9E0D7mZjeJGhYOxef3Foozni8G4mBwGnXuNJ/AeNNn
         GYK+pA1CCh91Em51xbcTqVSKxYUeCQglJ5lWCyZsocKV1EsuN94m0HDRJ59LuSCStc88
         LT06PjHITvuVSJSkBhi0er1eXxdAIuJKVLYct/z3t4LhKPQYAnwHkCxJSwDM9mQlPIJi
         LkmCYPhAQmxUlTK0xXMddJtZOnIwsi/qMw/I1jU8TiLAkpS1r7uKxcXKhdvCBUPZqo3X
         T2jkJkF3nU+oY4LPcLMlsSWEGrL67QS7QUE97cBaGb3nP9zOKLQ4pHN6uhwWE4ywI6hv
         ON4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694047207; x=1694652007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBJZpKotgksVoJ+0EjwMTCZE7nTiRe5bojyrG2Lg6BI=;
        b=jHYKkPeHqezKazLwRZkQkLQOOjVihHvLCi5bwih/gUCPQVVGlWG+rsolxRWdRQGBw8
         MMiBd7n7H9l2spMxwVR286O12V7xYTfbXwMVrm2fAotp9WoEgdyliUmoWm7391+7ffSG
         Lajo002Wv9wW+AwDT3vnnsCQeJbv4ctGbgM6HTG3p9OMOOe7YyXYGHsLVDF0N8cOOGHC
         H+TgM0lcn5WcEh/fpj9Wc7vT1DNKRXhmdk5ZN3ZJR7IiCTMPp9XDGs+g+RhbOS5cjEgz
         jS5VzNKQbRoFuqqw4KMPYP7ZcnnrVxBmeshF6+KLlkWqsL1Ms39Fgcxcj+Mn0dr6rGd8
         Y+rQ==
X-Gm-Message-State: AOJu0Yzit2oevyRwEeRuSCuSVBX76Q2OsNBv6LUwRQJccGCtmsU0u+Hd
	Co/9DcEa+zVL2HXveINPZ6urZiJe5IviWPHDmCHFw6j2
X-Google-Smtp-Source: AGHT+IGJkUuL8eF1FnsZw6afzUdc9yni/tc49jMUWQ8b9v8Cab9M2EzBqCdd8+5DULX2KZavTaPYbfKPMlHH5sbGoY4=
X-Received: by 2002:a2e:9c9a:0:b0:2bc:dcc2:b186 with SMTP id
 x26-20020a2e9c9a000000b002bcdcc2b186mr3200148lji.36.1694047207288; Wed, 06
 Sep 2023 17:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com> <mb61p5y4u3ptd.fsf@amazon.com>
In-Reply-To: <mb61p5y4u3ptd.fsf@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Sep 2023 17:39:55 -0700
Message-ID: <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Fri, Sep 01 2023, Puranjay Mohan wrote:
>
> > The problem here is that reg->subreg_def should be set as DEF_NOT_SUBRE=
G for
> > registers that are used as destination registers of BPF_LDX |
> > BPF_MEMSX. I am seeing
> > the same problem on ARM32 and was going to send a patch today.
> >
> > The problem is that is_reg64() returns false for destination registers
> > of BPF_LDX | BPF_MEMSX.
> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
> > sign extension so
> > is_reg64() should return true.
> >
> > I have written a patch that I will be sending as a reply to this.
> > Please let me know if that makes sense.
> >
>
> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NOT_SUBREG=
 for destination
> registers if is_reg64() returns true for these registers. My patch below =
make is_reg64()
> return true for destination registers of BPF_LDX with mod =3D BPF_MEMSX. =
I feel this is the
> correct way to fix this problem.
>
> Here is my patch:
>
> --- 8< ---
> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2001
> From: Puranjay Mohan <puranjay12@gmail.com>
> Date: Fri, 1 Sep 2023 11:18:59 +0000
> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extended loa=
d as
>  64 bit
>
> The verifier can emit instructions to zero-extend destination registers
> when the register is being used to keep 32 bit values. This behaviour is
> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the case
> of a sign extended load instruction, the destination register always has =
a
> 64-bit value, therefore the verifier should not emit zero-extend
> instructions for it.
>
> Change is_reg64() to return true if the register under consideration is a
> destination register of LDX instruction with mode =3D BPF_MEMSX.
>
> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb78212fa5b2..93f84b868ccc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env *env, =
struct bpf_insn *insn,
>
>         if (class =3D=3D BPF_LDX) {
>                 if (t !=3D SRC_OP)
> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || BPF_MODE(=
code) =3D=3D BPF_MEMSX);

Looks like we have a bug here for normal LDX too.
This 'if' condition was inserting unnecessary zext for LDX.
It was harmless for LDX and broken for LDSX.
Both LDX and LDSX write all bits of 64-bit register.

I think the proper fix is to remove above two lines.
wdyt?

