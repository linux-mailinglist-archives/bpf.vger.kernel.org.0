Return-Path: <bpf+bounces-16899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE6807628
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915CAB20E0E
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC394AF9F;
	Wed,  6 Dec 2023 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXQyrUDn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1A90
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:12:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso4375602e87.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882753; x=1702487553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYmuJSdCpZUDt4DMdt/hFMQA/HWdBOVnItqV0G2O4jc=;
        b=dXQyrUDnpmdfubtmkiXFMDEy+HOsPbR84KeoroLQxgXOTILMhGcJYdalWjePtQZr0U
         lMUTYeNiR84BOX64PUZjvXcVpOGAH1Ya3hollDxAghcpqY3/1xHN/oBNxFnyQvaE41un
         IJNaAAneL3QpBPV2yhpSKQth0bQXFPdWAFdnBfG26N5xhw2YU1Nz680AbKtD88Ta4Qgw
         60/UqZIXDu71D8vSqitt1j9vKdYJsM8zxKw8rWyxCbeJSGQ3QTJ5c4uvtdE2OOHkFDP9
         LDL6gmNAl2ssQHQwRhBxMd4SnidD5nU5v+lMzrnZIpQeOMuUzH7puolDrRdEqfB7UxLx
         2PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882753; x=1702487553;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYmuJSdCpZUDt4DMdt/hFMQA/HWdBOVnItqV0G2O4jc=;
        b=VpyeB5tjDDO9BhLNAVE0RCuGeg4BYdz5mhWo/szfo8Xv3lUPpSDJsmPaUPr904nqZc
         G29B83xpbQQ0vDuH8XJy1aXh990D5pIxsJpqx3stuq/2AbIK4pEFdreSw/Uaa340z2CS
         RuM6JZk9A+sS/YDAA2v0V3jLE1aY52dmxuxwfbxYEMoLIBzfHdJdDMB+TdYS3SNebxOJ
         89UhihPJNLqflnzqAQOA5Z5lRQrxxpqjS1DLfACLMuPClNPZtN/JW9+G0hYClAUzA1IG
         Tjqd1i+DEDGpmu5HtOr+8DH03xYAb8sZzj2ap7ISLckyNdTnCOw0inChSSe8OC7nvqMl
         lxGQ==
X-Gm-Message-State: AOJu0YxGZReeYUenoXp8XHKevH0e3/2MqZ3EKoRN/NcXyGjYqdTgRtqU
	pvmriYe1bqTpQvZPB3xlI6/KLQenKyw=
X-Google-Smtp-Source: AGHT+IEkFc7GaYKcDO5dJPokBW+HCIpHgKY3A78liDDQKoQaO1nLo1jDnuesjzFXn1HziAUAFZb07g==
X-Received: by 2002:a05:6512:230e:b0:50b:e697:10d5 with SMTP id o14-20020a056512230e00b0050be69710d5mr799794lfu.68.1701882752594;
        Wed, 06 Dec 2023 09:12:32 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d18-20020a196b12000000b0050bf4803234sm1052798lfa.194.2023.12.06.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:12:32 -0800 (PST)
Message-ID: <aa7421147262d1b8be628cb7d98c4c43199bc20e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: fix verification of indirect
 var-off stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com, sunhao.th@gmail.com
Date: Wed, 06 Dec 2023 19:12:31 +0200
In-Reply-To: <20231206165802.380626-2-andreimatei1@gmail.com>
References: <20231206165802.380626-1-andreimatei1@gmail.com>
	 <20231206165802.380626-2-andreimatei1@gmail.com>
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

On Wed, 2023-12-06 at 11:58 -0500, Andrei Matei wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c

You would probably be asked to split this patch in two.
Usually selftests are submitted as separate patches with
'selftests/bpf:' tag. Tests are updated in 'bpf:' patches only if
changes to verifier make some tests invalid (so that it is possible
to do bisects over commit ranges).

Otherwise, lgtm, thank you for adding the test and please add my ack
for the test if v5 would be submitted.

> index 83a90afba785..9fb32b292017 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -224,6 +224,35 @@ __naked void access_max_out_of_bound(void)
>  	: __clobber_all);
>  }
> =20
> +/* Similar to the test above, but this time check the special case of a
> + * zero-sized stack access. We used to have a bug causing crashes for ze=
ro-sized
> + * out-of-bounds accesses.
> + */
> +SEC("socket")
> +__description("indirect variable-offset stack access, zero-sized, max ou=
t of bound")
> +__failure __msg("invalid variable-offset indirect access to stack R1")
> +__naked void zero_sized_access_max_out_of_bound(void)
> +{
> +	asm volatile ("                     \
> +	r0 =3D 0;                             \
> +	/* Fill some stack */               \
> +	*(u64*)(r10 - 16) =3D r0;             \
> +	*(u64*)(r10 - 8) =3D r0;              \
> +	/* Get an unknown value */          \
> +	r1 =3D *(u32*)(r1 + 0);               \
> +	r1 &=3D 64;                           \
> +	r1 +=3D -16;                          \
> +	/* r1 is now anywhere in [-16,48)*/ \
> +	r1 +=3D r10;                          \
> +	r2 =3D 0;                             \
> +	r3 =3D 0;                             \
> +	call %[bpf_probe_read_kernel];      \
> +	exit;                               \
> +"	:
> +	: __imm(bpf_probe_read_kernel)
> +	: __clobber_all);
> +}
> +
>  SEC("lwt_in")
>  __description("indirect variable-offset stack access, min out of bound")
>  __failure __msg("invalid variable-offset indirect access to stack R2")



