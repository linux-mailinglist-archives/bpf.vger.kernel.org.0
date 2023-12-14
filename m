Return-Path: <bpf+bounces-17895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042E813E29
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21E21C21F4B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95A6C6DF;
	Thu, 14 Dec 2023 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyMepOFe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89166C6C6;
	Thu, 14 Dec 2023 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso78748a12.3;
        Thu, 14 Dec 2023 15:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595968; x=1703200768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le+yUYWAeO85szFc6hh7ahjEHZ3iGHzhPjaN5WD/XWo=;
        b=YyMepOFeqUeRQ8THH+QMMB8q0weWRji9bdHWo6nfFIQ6aDTqFXKH6/EKAsRtlDHk1G
         0fdFb45vXBRxgzDvt3GXvGxt58/dydbSU3ru7SgDiQixYJ+s6mAHhFGnEQTJ8A6YZjNR
         lAhQTBvBDOBoJ2GvLr6RHfnobjDrqBnlriLlF+aAwqZnw82VXRnQx4t00XwDPqwWq2qv
         vVARAb+US9DCkGxOShe9wEKi+HWvYFEtauJrIi+hM31T1h6h+1yPw3bTwgPtOlGgQsSp
         CVLPZYwMoL9xCiaGrQZzzU/CXLPmNUvmh6F+Zf9XgZptaZEd5iza8wU6hk+PRMEXvC7t
         Tv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595968; x=1703200768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le+yUYWAeO85szFc6hh7ahjEHZ3iGHzhPjaN5WD/XWo=;
        b=ZoOK/jLCg/d7NEXSvtlBc7fr6D5OPpq8iE4/sfcE2w474GmWG0B5fiRw9/LLEuVXqt
         O3a14/mnDtYA59hZxF9rCvvJqaLB8bAIGbntDjeak8eTzXt070HGowaQhs/wik5VQNjd
         FXVFaqYWLLYx208DwpxMN99G71UvUKEIECHs9e4f9PIunMj8kLi/D7s6D5P8PFQlXLTb
         mWyQYWIEZNBhvfDH5p6Dtu01kvC7IvcIpHtnvS/0f+cA1K7IoCmH6vAUWRiCcd8+eOFf
         9rsxziA7aqYRqsBZwV5xdOTkrs3UyE2XY/vDrdgquxxLEqdGcVB4EUYlafc6xWheNt0Z
         I7yw==
X-Gm-Message-State: AOJu0YwthFgLyfBl7durvVsyQSXDFyvn+6Vlq2Ju4y7Ce8rU/sxJRZGG
	zZtLPUVGoL20WyvXtnja/0TmxrzvW0ox/gNsVNk=
X-Google-Smtp-Source: AGHT+IGZI8HKP27/QxlYEUGlhRTTtRIByszekRE0ONv360E2rUAdxrnaIpB7d7fcHQxP3LX6TiWqwfHu3uaPikt4zRI=
X-Received: by 2002:a50:cd94:0:b0:551:f56c:c01d with SMTP id
 p20-20020a50cd94000000b00551f56cc01dmr1701838edi.54.1702595967760; Thu, 14
 Dec 2023 15:19:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com> <20231214062434.3565630-2-menglong8.dong@gmail.com>
In-Reply-To: <20231214062434.3565630-2-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:19:15 -0800
Message-ID: <CAEf4BzZsXhM0wGdP3udGF9y7qGfwUTB7jrGR9vp=nC60-vCozQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
>
> In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0". I=
n the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v2:
> - fix a typo in the subject
> - add some comments, as Eduard advised
> ---
>  kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>

The logic looks good

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 727a59e4a647..9b1932e51823 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14332,7 +14332,43 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>                 }
>                 break;
>         case BPF_JNE:
> -               /* we don't derive any new information for inequality yet=
 */
> +               if (!is_reg_const(reg2, is_jmp32))
> +                       swap(reg1, reg2);
> +               if (!is_reg_const(reg2, is_jmp32))
> +                       break;
> +
> +               /* try to recompute the bound of reg1 if reg2 is a const =
and
> +                * is exactly the edge of reg1.
> +                */
> +               val =3D reg_const_value(reg2, is_jmp32);
> +               if (is_jmp32) {
> +                       /* u32_min_value is not equal to 0xffffffff at th=
is point,
> +                        * because otherwise u32_max_value is 0xffffffff =
as well,
> +                        * in such a case both reg1 and reg2 would be con=
stants,
> +                        * jump would be predicted and reg_set_min_max() =
won't
> +                        * be called.
> +                        *
> +                        * Same reasoning works for all {u,s}{min,max}{32=
,64} cases
> +                        * below.
> +                        */
> +                       if (reg1->u32_min_value =3D=3D (u32)val)
> +                               reg1->u32_min_value++;
> +                       if (reg1->u32_max_value =3D=3D (u32)val)
> +                               reg1->u32_max_value--;
> +                       if (reg1->s32_min_value =3D=3D (s32)val)
> +                               reg1->s32_min_value++;
> +                       if (reg1->s32_max_value =3D=3D (s32)val)
> +                               reg1->s32_max_value--;
> +               } else {
> +                       if (reg1->umin_value =3D=3D (u64)val)
> +                               reg1->umin_value++;
> +                       if (reg1->umax_value =3D=3D (u64)val)
> +                               reg1->umax_value--;
> +                       if (reg1->smin_value =3D=3D (s64)val)
> +                               reg1->smin_value++;
> +                       if (reg1->smax_value =3D=3D (s64)val)
> +                               reg1->smax_value--;
> +               }
>                 break;
>         case BPF_JSET:
>                 if (!is_reg_const(reg2, is_jmp32))
> --
> 2.39.2
>

