Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C536A419D
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB0MUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjB0MUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:20:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639219F31
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:20:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n5so3371009pfv.11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLMXRXE6p7M2wI/v/8zIreJMb38Cw+t13v0pmAsHMHg=;
        b=ISCrTbX0cGZo4rt8H1qM6YmqIFbVPz/ztodfosWEkfyna3o6tDcFIYSi216s73nw2n
         JU6mgjeL9DQNvrLbkhBskOCANmhf5G41bewOClq+DVnbEafyDGY6eF9gr031wc/13NqF
         EdF0fw9wir/BqotzQq+cGTXKsHIOkjx3DYHpwBp+S61bd9zdBvMlo/HInDe4IE1oubVY
         RFyFVWtUs1k2yEPuiFFQHsxoBe2i3KdHnrPWAOWsTM/0xbfEdTpkrrtIJjYqGEJv9txl
         WBWiqpJysadKTuFH8Y/T45FJTALW3evmXhH8oIXbz21P6qQxj/G3bi5fngXcE5cwrEE8
         TaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLMXRXE6p7M2wI/v/8zIreJMb38Cw+t13v0pmAsHMHg=;
        b=Ik64ubMeScXiIEZG5X+zNL7U8Kmag4gPLRkkOCCoG4yH/TNkjjmZcdn/y7ZtoDIHl6
         s4KgR9GTiRD8LfGxzJGlDRGhBoGSB40W22CnF75VgWsTZZsPZ7UfGLignlILYPb2FjVj
         +42hGPTRIsMVEXjZFGvBzTqeFCThpQM56Ep8fQdJK5WM0xl6+lWky+2CgC6W+DWEk4ZN
         zAj/g5LYbQ7rXAO79V7tb9IuVMYf6khby5RRsrzsElyL3NoPsRlWYr6ba3eQWkWKYfSw
         +VKle1aLyywI84o/hxPaQ0W2KVb5AXWNmKXW6y9o3mMNpaPO9ZinojCf1q3Vs1RNVlc/
         Sz8w==
X-Gm-Message-State: AO0yUKVmra8iPIIDayYDzAcTJQZ8f8mlYAGnwNOpELKqQG3lTfCjhxSX
        JSFFM5+T2+Iijl+uCcjno6w3sfQ/UPeW+6Oj3KrOCQ==
X-Google-Smtp-Source: AK7set+pRin2+DrQij1wsBd87m6EHrzz0VpUgURYwl63znWqJGO/4vKGVim0XwC9giSb9cx+snGEAxFrGhlofsJDJss=
X-Received: by 2002:a05:6a00:302a:b0:5a8:a56f:1c3a with SMTP id
 ay42-20020a056a00302a00b005a8a56f1c3amr3972323pfb.0.1677500400659; Mon, 27
 Feb 2023 04:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-3-jiaxun.yang@flygoat.com> <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com>
 <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
In-Reply-To: <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Mon, 27 Feb 2023 13:19:49 +0100
Message-ID: <CAM1=_QS_ewcFdrZ1ypV15wOkK_SKkb0UUe5_Ozi_CDBdxF5JmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 23, 2023 at 11:32=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
> >> --- a/arch/mips/Kconfig
> >> +++ b/arch/mips/Kconfig
> >> @@ -63,9 +63,7 @@ config MIPS
> >>        select HAVE_DEBUG_STACKOVERFLOW
> >>        select HAVE_DMA_CONTIGUOUS
> >>        select HAVE_DYNAMIC_FTRACE
> >> -       select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> >> -                               !CPU_R4000_WORKAROUNDS && \
> >> -                               !CPU_R4400_WORKAROUNDS
> >
> > Is the R4400 errata also covered by this workaround?
>
> Yes, R4400 errata is basically a reduced version of R4000 one.
> They managed to fix some parts of the issue but not all.

Ok.

> >> --- a/arch/mips/net/bpf_jit_comp32.c
> >> +++ b/arch/mips/net/bpf_jit_comp32.c
> >> @@ -446,6 +446,9 @@ static void emit_mul_i64(struct jit_context *ctx, =
const u8 dst[], s32 imm)
> >>                } else {
> >>                        emit(ctx, multu, hi(dst), src);
> >>                        emit(ctx, mflo, hi(dst));
> >> +                       /* Ensure multiplication is completed */
> >> +                       if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
> >> +                               emit(ctx, mfhi, MIPS_R_ZERO);
> >>                }
> >>
> >>                /* hi(dst) =3D hi(dst) - lo(dst) */
> >> @@ -504,6 +507,7 @@ static void emit_mul_r64(struct jit_context *ctx,
> >>        } else {
> >>                emit(ctx, multu, lo(dst), lo(src));
> >>                emit(ctx, mflo, lo(dst));
> >> +               /* No need for workaround because we have this mfhi */

For context, please specify which workaround this comment refers to:
"workaround" -> "R4000 workaround".

> > R4000 is a 64-bit CPU, so the 32-bit JIT implementation will not be
> > used. From the Makefile:
> >
> > ifeq ($(CONFIG_32BIT),y)
> >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp32.o
> > else
> >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp64.o
> > endif
>
> It=E2=80=99s common practice to run 32-bit kernel on R4000 based systems =
to save some memory :-)

Ok, I understand.

Looks good! I have run the test_bpf.ko test suite on MIPS and MIPS64
in QEMU with and without the workarounds enabled.

With above comment fix:
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
