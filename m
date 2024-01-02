Return-Path: <bpf+bounces-18771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB7821F49
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077B31F22AFA
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994514F6B;
	Tue,  2 Jan 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2FKSaEn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DB14F60;
	Tue,  2 Jan 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so95470961fa.3;
        Tue, 02 Jan 2024 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704212031; x=1704816831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4xCYs0xb0AKl7N7GGsMPlUYfHCJVdIQ68KKnAogFYu4=;
        b=F2FKSaEnayb4RhDdYENniVUNvB82Ie++A6wRQI1H8HUH5GzGbqGz168PqpU/q5pSXR
         R9jNHoTD+CGgAGsb0p6oPP5GFQEndcYFfhPRjr712XZahpe1bqlYiyE386uoaI3bpV3B
         57F7YdOs6q5NjrMgvt3ULG8v5WTLGBGgPvBqi+depzacXXXd0KwddT7v1c9CIsjLq56E
         gx+pSXZknNphxLvsdE4TyG7IF4jHcDTnLzsd88BHHed/p4vIigN3dtDt2iIsN6UyaDul
         mhKYiOy4eOviY5IaIc0sybhEK68uqNcrStrOdKkFY8LO9PnVcVvB79GcxCYgkl7nJKHT
         wfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212031; x=1704816831;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xCYs0xb0AKl7N7GGsMPlUYfHCJVdIQ68KKnAogFYu4=;
        b=nb76SAIXUHBBkGd+cGtUrQvY8VsBsXxcfxmqomSE6YocP0Y5cXNEEecBNz5v1aldqX
         n29bCzUOWtck7zisExK9g2uclP/0SbbVXWvPNg1u2w9kx3C5VdUIxLY4eiYn1k9EJs8F
         VBadjnYEHxnP3exH/1P/dv+2/dFpkV6OcpJhmibH/WghEs6079P1COcpEcZgW4zwjJAi
         Q5nNLQYWyMp27I8dOHACNCywq3Y9zD3fETpdQfdsyH58LLw/oMNLYJ3a4wiqE5+/un2B
         MTAYbBdqlvqOQy0YJ0BDH1lM74xcY/pDnWxZu1S8RFh9qpOn0aw7DDbpuNInXF8b4ffn
         dNhQ==
X-Gm-Message-State: AOJu0Yz3Yex1T6hqfnezuKweLtO7y3ddXgAhphlLRgXBSBYgBBE5XLo4
	o0fVVU/rS3sIfB3PdY5xSxq6yCYymnY=
X-Google-Smtp-Source: AGHT+IHbcndaDOIG7fOVUiSo4jHCswK69Q/Vc4wYfdHKyT0C56cw9IlN1m5RHADUYG6QUQkwUVedlg==
X-Received: by 2002:a2e:2a02:0:b0:2cc:fa53:d29b with SMTP id q2-20020a2e2a02000000b002ccfa53d29bmr2021279ljq.48.1704212031245;
        Tue, 02 Jan 2024 08:13:51 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7cc91000000b0055627eeb8b9sm3642990edt.32.2024.01.02.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:13:50 -0800 (PST)
Message-ID: <1179fcf4e4feaf5d9161eb0ec8fb41e4f08511a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Return -ENOTSUPP if callbacks are not
 allowed in non-JITed programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Jan 2024 18:13:49 +0200
In-Reply-To: <20231225091830.6094-1-yangtiezhu@loongson.cn>
References: <20231225091830.6094-1-yangtiezhu@loongson.cn>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-25 at 17:18 +0800, Tiezhu Yang wrote:
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
>=20
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #107/p inline simple bpf_loop call FAIL
>   #108/p don't inline bpf_loop call, flags non-zero FAIL
>   #109/p don't inline bpf_loop call, callback non-constant FAIL
>   #110/p bpf_loop_inline and a dead func FAIL
>   #111/p bpf_loop_inline stack locations for loop vars FAIL
>   #112/p inline bpf_loop call in a big program FAIL
>   Summary: 505 PASSED, 266 SKIPPED, 6 FAILED
>=20
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled, just return -ENOTSUPP instead of -EINVAL for pseudo
> calls in fixup_call_args().
>=20
> With this patch:
>=20
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 505 PASSED, 272 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a376eb609c41..1c780a893284 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19069,7 +19069,7 @@ static int fixup_call_args(struct bpf_verifier_en=
v *env)
>  			 * have to be rejected, since interpreter doesn't support them yet.
>  			 */
>  			verbose(env, "callbacks are not allowed in non-JITed programs\n");
> -			return -EINVAL;
> +			return -ENOTSUPP;
>  		}
> =20
>  		if (!bpf_pseudo_call(insn))

I agree with this change, however I think that it should be consistent.
Quick and non-exhaustive grepping shows that there are 4 places where
"non-JITed" is used in error messages: in check_map_func_compatibility()
and in fixup_call_args().
All these places currently use -EINVAL and should be updated to -ENOTSUPP,
if this change gets a green light.

If the goal is to merely make test_verifier pass when JIT is disabled
there is a different way:
- test_progs has a global variable 'env.jit_enabled' which is used by
  several tests to decide whether to skip or not;
- loop inlining tests could use similar feature, but unfortunately
  test_verifier does not provide similar functionality;
- test_verifier is sort-of in legacy mode, so instead of porting the
  jit_enabled to test_verifier, I think that loop inlining tests
  should be migrated to test_progs. I can do that some time after [1]
  would be landed.
 =20
[1] https://lore.kernel.org/bpf/20231223104042.1432300-3-houtao@huaweicloud=
.com/

