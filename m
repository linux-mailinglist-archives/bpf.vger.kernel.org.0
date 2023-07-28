Return-Path: <bpf+bounces-6186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC796766A66
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9722C282650
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99054125CE;
	Fri, 28 Jul 2023 10:25:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AC125A1
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:25:52 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9604487
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:25:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so2491028a12.3
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690539931; x=1691144731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F9+fGenjRAvmbDdymEKXPrCcUwzQwH2Q3W4+IMBnd04=;
        b=nPiGOiGiQgkvDg7MC/1nNnlkYNkmD1hcHCfYVmzC62s9cA1WDP93xgsyWYYswKHta8
         o5anbWMv6VinDNlCC+3KUkd6TyVM9ScRtHD/3BJYgAtVI6Zo41QUhtXZGRazBRkGa0Xz
         gcFMl1P8RuIghq5qHRaa5EwavLyI3YD9UBmjcSnDIGhvEM636ZfUki1vY8CM3/HsrMTF
         geo8Y0SBztE27tkcJDb41QcyiuPlw128PyEcgroVJ9NNqZgnQrtl5C7Qmo7leVoN5wG3
         LiZoEbe0SN3Tp4V/q5hvsIUzfV+pJ1fQR6jZTsg8I0XJbe+xN1ZlV/Q7G4HAlfB/JD6L
         +htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539931; x=1691144731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9+fGenjRAvmbDdymEKXPrCcUwzQwH2Q3W4+IMBnd04=;
        b=BHKVREcr/ECqPZtuvtoRIDcIbmWMzcx4Fx4yk1CoJ24gTr1fny9T54oGi/EZO6mWmL
         dl2cunHFGY0679sFruq2iO1Bui0PRqoP81OJt2UoVPMgeif9LCOLp3kNoIxYr2qiNZlN
         2/gJ7xQJh+bmcbJBAFh4DA0ajpqMy+F5KS//t/VIV3t5acDZ9FAY+JjjRmTr21tUpGDF
         5PGSAZM/C0X8DT0x8Q239IFd66Nxmoydlx64s2pXZWgN4sTUCA9P0TSs62TBf6gF5A5P
         dQ0l77MSaMNyFdIE/Ewg6z8Q+34C4+dVg/WVY6s/Xonv4QFkat51Aj8KWOWU4BJ7D/3K
         q+XQ==
X-Gm-Message-State: ABy/qLb9/rx0Lk3KYd5aPE4wDhM7Y9D1dH/tz3+nUtg2ngmO/4PYdX00
	ETlDyZvhjKVvxBNnc1OvBTA=
X-Google-Smtp-Source: APBJJlHgFHvK9Kw4qQHHLaAfjtKRzUVN15EqoErb1o1LDvRdSmP46+KxmqkEza2xJBP/VzUgnpSqww==
X-Received: by 2002:aa7:d40b:0:b0:51d:fa7c:c330 with SMTP id z11-20020aa7d40b000000b0051dfa7cc330mr1364166edq.26.1690539930588;
        Fri, 28 Jul 2023 03:25:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7d945000000b005223e54d1edsm1622010eds.20.2023.07.28.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:25:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Jul 2023 12:25:28 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix compilation warning with
 -Wparentheses
Message-ID: <ZMOXmM4/pdACHPBq@krava>
References: <20230728055740.2284534-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728055740.2284534-1-yonghong.song@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 10:57:40PM -0700, Yonghong Song wrote:
> The kernel test robot reported compilation warnings when -Wparentheses is
> added to KBUILD_CFLAGS with gcc compiler. The following is the error message:
> 
>   .../bpf-next/kernel/bpf/verifier.c: In function ‘coerce_reg_to_size_sx’:
>   .../bpf-next/kernel/bpf/verifier.c:5901:14:
>     error: suggest parentheses around comparison in operand of ‘==’ [-Werror=parentheses]
>     if (s64_max >= 0 == s64_min >= 0) {
>         ~~~~~~~~^~~~
>   .../bpf-next/kernel/bpf/verifier.c: In function ‘coerce_subreg_to_size_sx’:
>   .../bpf-next/kernel/bpf/verifier.c:5965:14:
>     error: suggest parentheses around comparison in operand of ‘==’ [-Werror=parentheses]
>     if (s32_min >= 0 == s32_max >= 0) {
>         ~~~~~~~~^~~~
> 
> To fix the issue, add proper parentheses for the above '>=' condition
> to silence the warning/error.
> 
> I tried a few clang compilers like clang16 and clang18 and they do not emit
> such warnings with -Wparentheses.

I just hit it with gcc and this fixes it for me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307281133.wi0c4SqG-lkp@intel.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/core.c     | 4 ++--
>  kernel/bpf/verifier.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index db0b631908c2..baccdec22f19 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1877,7 +1877,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  		case 1:
>  			AX = abs((s32)DST);
>  			do_div(AX, abs((s32)SRC));
> -			if ((s32)DST < 0 == (s32)SRC < 0)
> +			if (((s32)DST < 0) == ((s32)SRC < 0))
>  				DST = (u32)AX;
>  			else
>  				DST = (u32)-AX;
> @@ -1904,7 +1904,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  		case 1:
>  			AX = abs((s32)DST);
>  			do_div(AX, abs((s32)IMM));
> -			if ((s32)DST < 0 == (s32)IMM < 0)
> +			if (((s32)DST < 0) == ((s32)IMM < 0))
>  				DST = (u32)AX;
>  			else
>  				DST = (u32)-AX;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0b1ada93582b..e7b1af016841 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5898,7 +5898,7 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>  	s64_min = min(init_s64_max, init_s64_min);
>  
>  	/* both of s64_max/s64_min positive or negative */
> -	if (s64_max >= 0 == s64_min >= 0) {
> +	if ((s64_max >= 0) == (s64_min >= 0)) {
>  		reg->smin_value = reg->s32_min_value = s64_min;
>  		reg->smax_value = reg->s32_max_value = s64_max;
>  		reg->umin_value = reg->u32_min_value = s64_min;
> @@ -5962,7 +5962,7 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
>  	s32_max = max(init_s32_max, init_s32_min);
>  	s32_min = min(init_s32_max, init_s32_min);
>  
> -	if (s32_min >= 0 == s32_max >= 0) {
> +	if ((s32_min >= 0) == (s32_max >= 0)) {
>  		reg->s32_min_value = s32_min;
>  		reg->s32_max_value = s32_max;
>  		reg->u32_min_value = (u32)s32_min;
> -- 
> 2.34.1
> 
> 

