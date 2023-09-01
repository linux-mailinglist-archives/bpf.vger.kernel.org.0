Return-Path: <bpf+bounces-9118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E478FEE3
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6131C20C97
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D88C127;
	Fri,  1 Sep 2023 14:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA66AD41
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:20:24 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262A171A
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 07:20:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b962535808so36064571fa.0
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693578005; x=1694182805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAzCjQEY4/s44mMaFjbwGqFeLtGRbtjelNHAu1f4oP0=;
        b=NfTyKEn/kj/wVGVnPQwEVz5tGRrblkpMDWUNZ1el54hQySp+8O4BFT36dOQ5Zr3gCC
         fR1WvouiB2TQ4Sd7VBh1rNwL6AKCTQULsUTZEtAWON3ft6CJA4SlEzl+rAdQcU4frqE0
         U1PTVP7rBRCcqIN6M+6NG0xq4v1vti3YCWua0X9zVq4zLrNVat+RV0SVbu2IR5ubDkga
         9or5OBMhTm13et8RTmFcpJZntF7lbsqS+jJYmFtNKn3jPNkrcraIsMI/oFvR98ACxGKm
         SGOGYn/07CF8La2k7vIvHyUHzohkWfczuRcI5s9HOFu4JG/GOfpdv5NJ0Yrn38Jn1WXZ
         Ef0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578005; x=1694182805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAzCjQEY4/s44mMaFjbwGqFeLtGRbtjelNHAu1f4oP0=;
        b=XBl+/3A6tBNKUXFsV4LDlorcmVyY8VBVWidTenawSb/2XhPZ9nIPxJFKYEfKVRawQY
         l3w0LGEuTeEWa86vZ/dF5o6rnnnX4sLUlH5pQ8dJep82EDyMU5yYqrP4SHpjfPJclFJj
         OjU9mjUdHatuV3gtTY6i0/h1Tlp50ILiDpgAxFAUKpaHLTXsoor/9b0eMt7kRba/PiXQ
         /SZTx4tRE7KXOUhQA5VBjIaZG0RnAcddzCm4H810a4BODhWrhJHj6rNIgwMt99ffUbJ1
         kOdsry8rAOYzEQiYpN0Tnf7VFnaCF4jrB4iRHFvW4tK4ENI0dyH/iNQOO4A8aCkja22S
         vCBQ==
X-Gm-Message-State: AOJu0YynDvRxXRdm/hMHjzAg0w/pbHwZNQbElX/KWdwOvvUY9J+Fr1UN
	pTp53GlQDwFNxbLavs5tNsfdx28ft7uiyqhfqgqil9UWxkz+eujGB4s=
X-Google-Smtp-Source: AGHT+IGrLJmKOdiD62LHDliSiNYpuWocVj3/jvBHYIYxfkVW47hflwJYqOc9C9dqo4vVMEQhpD4+Gm3ID8Mqu8Z3r4s=
X-Received: by 2002:a2e:9303:0:b0:2bc:e470:1405 with SMTP id
 e3-20020a2e9303000000b002bce4701405mr1698562ljh.46.1693578004587; Fri, 01 Sep
 2023 07:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
In-Reply-To: <20230830011128.1415752-2-iii@linux.ibm.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 1 Sep 2023 16:19:53 +0200
Message-ID: <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ilya

On Wed, Aug 30, 2023 at 3:12=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On the architectures that use bpf_jit_needs_zext(), e.g., s390x, the
> verifier incorrectly inserts a zero-extension after BPF_MEMSX, leading
> to miscompilations like the one below:
>
>       24:       89 1a ff fe 00 00 00 00 "r1 =3D *(s16 *)(r10 - 2);"      =
 # zext_dst set
>    0x3ff7fdb910e:       lgh     %r2,-2(%r13,%r0)                        #=
 load halfword
>    0x3ff7fdb9114:       llgfr   %r2,%r2                                 #=
 wrong!
>       25:       65 10 00 03 00 00 7f ff if r1 s> 32767 goto +3 <l0_1>   #=
 check_cond_jmp_op()
>
> Disable such zero-extensions. The JITs need to insert sign-extension
> themselves, if necessary.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb78212fa5b2..097985a46edc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3110,7 +3110,9 @@ static void mark_insn_zext(struct bpf_verifier_env =
*env,
>  {
>         s32 def_idx =3D reg->subreg_def;
>
> -       if (def_idx =3D=3D DEF_NOT_SUBREG)

The problem here is that reg->subreg_def should be set as DEF_NOT_SUBREG fo=
r
registers that are used as destination registers of BPF_LDX |
BPF_MEMSX. I am seeing
the same problem on ARM32 and was going to send a patch today.

The problem is that is_reg64() returns false for destination registers
of BPF_LDX | BPF_MEMSX.
But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
sign extension so
is_reg64() should return true.

I have written a patch that I will be sending as a reply to this.
Please let me know if that makes sense.

> +       if (def_idx =3D=3D DEF_NOT_SUBREG ||
> +           (BPF_CLASS(env->prog->insnsi[def_idx - 1].code) =3D=3D BPF_LD=
X &&
> +            BPF_MODE(env->prog->insnsi[def_idx - 1].code) =3D=3D BPF_MEM=
SX))
>                 return;
>
>         env->insn_aux_data[def_idx - 1].zext_dst =3D true;
> --
> 2.41.0
>
>

Thanks,
Puranjay

