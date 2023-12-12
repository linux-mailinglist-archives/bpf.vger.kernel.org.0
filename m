Return-Path: <bpf+bounces-17608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DE80FB44
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAB3B20FA3
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3B64731;
	Tue, 12 Dec 2023 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAU6orwM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE180AA;
	Tue, 12 Dec 2023 15:23:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c4846847eso25918195e9.1;
        Tue, 12 Dec 2023 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702423416; x=1703028216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMwDgbTyxwfql3aF4QbaoSSK24jbTU8Cu669x3rTF7M=;
        b=AAU6orwMPWc+NXbuZN1x717j65GSCgTkWsm2mLUWQK1aYJBcRJQNPUSkjynDWTchA5
         gwDez6vYV0EvkXZBMyt1txTMZ6F+eoewKe+n6rSZIymXV6U8RVS0o2X8+j7kxqWN1MEX
         i+fRMYQ/abV8H73oEduhgGcn+s4IMiTs2kDC0xoTfqzL/1HJtzdX4FIXiBPWhabsGGOV
         bHWjl9g9cdutnGZcaI2NunyEpXeMsn+5nFShOwdWA7VoSUUZvP8nMpAyF7MSNpH82QRY
         lMGlWL20CE1tyOJk3I1DKVhHZN23VO3RQWABSVjHze4vbQVlBrDTDpMoHodSMswdiYCw
         BHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423416; x=1703028216;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMwDgbTyxwfql3aF4QbaoSSK24jbTU8Cu669x3rTF7M=;
        b=nCoam/pcXd+DDBW1J2STdcZYobt2rAfMQqKn6jFnyZrNLLBMYBdVlZPB4XhZIXtvqL
         prylJXcpMyaBIz+9lngu8XY1L3tkBK8lOe7gQBWEUZ2f8FhSXgc6pFz8WaBic9mbMPqE
         8H530XR2tOkXs14XCZRABNk/xhar9LsX3EmiXME0o2UsvzzKvCNWQIeD7MkPxYIrnwnF
         0C5TSJkahTw/+QHyWB04l3pFEeSyptoW3atWtmg+sh76XutHhExXoxD/d5eDO+JcY4f3
         1jaorCOk2OWwl4qQ9ADsxqgBU1d3GgzW+ipQJ8KRA0uBqZBppP/0a+4NKZ4vYgi6FUAA
         kK6g==
X-Gm-Message-State: AOJu0Yxg2EXLPGipxRCWbrlrCpF9XR4PZeVvn0r6ESUH/mbhGB9z976W
	6tGzY2cx5H6rpfyKnZOkBqY=
X-Google-Smtp-Source: AGHT+IFwBjVW4miCYBt9OQQGYh/AGmPpL+lVR6Heqbzxcm0mGwzDyJPwVErTE/7ROLEDdAKm2Rk+Tg==
X-Received: by 2002:a05:600c:2a43:b0:40c:30e8:fc5f with SMTP id x3-20020a05600c2a4300b0040c30e8fc5fmr3764410wme.90.1702423416089;
        Tue, 12 Dec 2023 15:23:36 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm9792660wmo.17.2023.12.12.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:23:35 -0800 (PST)
Message-ID: <a7fa57335aa302898044207431e81f5f455e4971.camel@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] bpf: make the verifier trace the "not
 qeual" for regs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, andrii@kernel.org, 
	yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2023 01:23:34 +0200
In-Reply-To: <20231212131031.3088661-2-menglong8.dong@gmail.com>
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
	 <20231212131031.3088661-2-menglong8.dong@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 21:10 +0800, Menglong Dong wrote:
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>=20
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
>=20
> In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0". I=
n the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>=20
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
>=20
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 727a59e4a647..08ee0e02df96 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14332,7 +14332,34 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>  		}
>  		break;
>  	case BPF_JNE:
> -		/* we don't derive any new information for inequality yet */
> +		if (!is_reg_const(reg2, is_jmp32))
> +			swap(reg1, reg2);
> +		if (!is_reg_const(reg2, is_jmp32))
> +			break;
> +
> +		/* try to recompute the bound of reg1 if reg2 is a const and
> +		 * is exactly the edge of reg1.
> +		 */
> +		val =3D reg_const_value(reg2, is_jmp32);
> +		if (is_jmp32) {
> +			if (reg1->u32_min_value =3D=3D (u32)val)
> +				reg1->u32_min_value++;

Nit: I spent an unreasonable amount of time trying to figure out if
     overflow might be an issue here. Would it be helpful to add a
     comment like below? (not sure, maybe it's obvious and I'm being slow)
    =20
     /* u32_min_value is not equal to 0xffffffff at this point,
      * because otherwise u32_max_value is 0xffffffff as well,
      * in such a case both reg1 and reg2 would be constants,
      * jump would be predicted and reg_set_min_max() won't
      * be called.
      * Same reasoning works for all {u,s}{min,max}{32,64} cases below.
      */

