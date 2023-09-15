Return-Path: <bpf+bounces-10156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9197A2398
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F9281239
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CEC125B6;
	Fri, 15 Sep 2023 16:29:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551711CAF
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:29:19 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CC268E
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:29:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so1275983fac.2
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1694795356; x=1695400156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75VIBFWysFjhghxFJlM1nAPOhfRt9qZzTD3QiP8oJGQ=;
        b=WqbNG7Fv51C2tgmfTJql5MwvRzQhtvJmC7TZwwTWJD+XeocpEXdLR9U/QuJrdBDk+K
         +rEELDyc3MIDBzvlA63ritWODf7TCsQmlV5IX8ocSUdsDLMqm6Q0BXZ6c87P9oK1WbWf
         cSW2c4JOqnVQ0bjvHg/yN83Yx3LTAWQCtXmVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795356; x=1695400156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75VIBFWysFjhghxFJlM1nAPOhfRt9qZzTD3QiP8oJGQ=;
        b=AOQUTbDVmTpvC3TUPr7GrYTCJcr7ozi1xdzS52Os78oSodG6Iy7AoOV1ey8g38Kkev
         AIg6rt/P/xYYUwZKKMylD8oylGeY8cskjLKdBglDAllXWOZPR0ZMiqq6uYM9Vt55ub4f
         GtabGCrRdGIS0cB4LPVxMYGZvKYUMPN6EgKVmEYFQIGzpLtew0I7//oUFI+rwIufywvj
         Q9fkDKFusHUxWiU+WvfoDienbX6AXc36zWrYfNJPHG3p+kT35hzRJxOleg0lnWNHUe4w
         7fW/q0msoSDvDdRsf4KIoqx8Eu59Q7t6/lNxvNOO2CMn6BOP0Jk18ltbgOcbM52Bs+21
         OyQg==
X-Gm-Message-State: AOJu0YyKg23CUW/96eTZmGV3oJzQpQ4k2UO9IePvaHEWMgtc4SMUNQwI
	BK4Ki9xZp5mKQd6B3ecrmAh7mKlsKYToOHwqsHLVjw==
X-Google-Smtp-Source: AGHT+IEn26Vxkt4OIvLRCg3nvOfo2pseKiXPCbRffSpw8hr/ARWePuXqTxeB8WBqo0cFThFrQ3GaQMgTp4JtjLbgCM0=
X-Received: by 2002:a05:6870:5387:b0:1d6:97:bd7d with SMTP id
 h7-20020a056870538700b001d60097bd7dmr2730060oan.34.1694795355805; Fri, 15 Sep
 2023 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914123527.34624-1-hffilwlqm@gmail.com>
In-Reply-To: <20230914123527.34624-1-hffilwlqm@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Fri, 15 Sep 2023 11:29:04 -0500
Message-ID: <CAC1LvL3vTzKx8mcObCKbVJFNVjj0DjS=RF+wytryJZYrqnwhBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, x64: Check imm32 first at BPF_CALL in do_jit()
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, tglx@linutronix.de, maciej.fijalkowski@intel.com, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 7:36=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
> It's unnecessary to check 'imm32' in both 'if' and 'else'.
>
> It's better to check it first.
>
> Meanwhile, refactor the code for 'offs' calculation.
>
> v1 -> v2:
>  * Add '#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7'.
>
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2846c21d75bfa..fe0393c7e7b68 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1025,6 +1025,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8=
 src_reg, bool is64, u8 op)
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define RESTORE_TAIL_CALL_CNT(stack)                           \
>         EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> +#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7
>
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
>                   int oldproglen, struct jit_context *ctx, bool jmp_paddi=
ng)
> @@ -1629,17 +1630,16 @@ st:                     if (is_imm8(insn->off))
>                 case BPF_JMP | BPF_CALL: {
>                         int offs;
>

<snip>

> +                       if (tail_call_reachable)
>                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stac=
k_depth);

<snip>

> +                       offs =3D (tail_call_reachable ?
> +                               RESTORE_TAIL_CALL_CNT_INSN_SIZE : 0);

I'm not sure which is preferred style for the kernel, but this seems like i=
t
could be replaced with

int offs =3D 0;
...
if (tail_call_reachable) {
    RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
    offs =3D RESTORE_TAIL_CALL_CNT_INSN_SIZE;
}

which is easier for my brain to follow because it reduces the branches (in =
C,
I assume the compiler is smart enough to optimize). It does create an
unconditional write (of 0) that could otherwise be avoided (unless the comp=
iler
is also smart enough to optimize that).

Also not sure if the performance difference matters here.

> +                       offs +=3D x86_call_depth_emit_accounting(&prog, f=
unc);
>                         if (emit_call(&prog, func, image + addrs[i - 1] +=
 offs))
>                                 return -EINVAL;
>                         break;
>
> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
> --
> 2.41.0
>
>

