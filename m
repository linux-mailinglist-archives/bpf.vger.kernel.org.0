Return-Path: <bpf+bounces-9973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B451979F940
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 05:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C5AB20A26
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A117F4;
	Thu, 14 Sep 2023 03:58:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E67F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 03:58:53 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898FE4B
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 20:58:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab3aceaf2aso304025b6e.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694663932; x=1695268732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NVYAV6FsczTu8e+aieLH0YCoAEujLEST7FsrbBEEks=;
        b=N8OxMnVCjO9UXhSduLyjaWdetYbAEl4Gnmw/MQdfG0UX5yUKJGXZt4I8bxFf8i0YtR
         Cim2Rvov/PIkod3Ewgtd7AY/CV3S5NwOhFd0qS8Dmr05gwbvnbe6+oB7xOZtSpodHZnY
         fwqK4Qy05Qma+uJmCGHTMEW/X6AW6/BxUskfPm8NugcpNj3/843gD8gLqxUkoqIyMCCx
         hWZRyuyyJ/lvJawVa+4h77y5OJvzsWM+p31VdMHm/LG3VTeYpXhUCoTIpJSPzdKy0IyC
         2ihzZbDK8M0Zcu8r92ji4LED3SeMRaPnJ4rArjRxN+ZPo1V2w6/0jUhv03UKr6UFvBF8
         Zh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694663932; x=1695268732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NVYAV6FsczTu8e+aieLH0YCoAEujLEST7FsrbBEEks=;
        b=LYtIT0kx+hqv1cOLdml0LjMRqIoIzY9hMStl4oJ8H13kVMoVBOU6Zvn9ZGhb+a+P0+
         P9F4VygPXM56Q6s06oj1VkIoaYGIqYRnZTrRxs3YGYoNnNo1V0QF2v7fPCvKgZo/zyf/
         LMT2nQucqjxYskRoNsHk0n9EgxDxf5NXd2PYt2bzZ0pyWBId183OHtYYYkXlv9uESIQI
         E/baSZx4LONcYE0AANjHPmtdFw1UT47EbaUlwt4s5VL4ajvdM6cGDOrfYHIvum58RvUe
         aFGWMHe8aMqvK4tVgMJrILfchp0CIRHqbUNoKKQhOkWTwNjjgCLcz6leZ2rNXuPRcCgA
         AFVQ==
X-Gm-Message-State: AOJu0YzLsnnSIKcmSyKhdNHltnve3ZN2wfHcgbRgOdCSQpGpwDGXizMJ
	LV2I1Pg2qfRI766nRCmi9GIZCdGFyAg=
X-Google-Smtp-Source: AGHT+IGx8DRuFGiQ/ifDbSsOaLdWjVUirTO34MienklF9dxXrvRpFWGeXYi3NaYr9ECKNEKGYD5+OQ==
X-Received: by 2002:a05:6808:1901:b0:3a4:8251:5f43 with SMTP id bf1-20020a056808190100b003a482515f43mr5901406oib.40.1694663931814;
        Wed, 13 Sep 2023 20:58:51 -0700 (PDT)
Received: from [10.22.68.46] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id e23-20020a62aa17000000b0068fba4800cfsm317254pff.56.2023.09.13.20.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 20:58:51 -0700 (PDT)
Message-ID: <6cf21ca2-a6b2-680b-2833-bfdb8ac0b539@gmail.com>
Date: Thu, 14 Sep 2023 11:58:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next] bpf, x64: Check imm32 first at BPF_CALL in
 do_jit()
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 tglx@linutronix.de, maciej.fijalkowski@intel.com, kernel-patches-bot@fb.com
References: <20230913163607.25428-1-hffilwlqm@gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20230913163607.25428-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/9/23 00:36, Leon Hwang wrote:
> It's unnecessary to check imm32 in both 'if' and 'else'.
> 
> It's better to check it first.
> 
> Meanwhile, refactor the code for 'offs' calculation.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2846c21d75bfa..f06e9a48afe52 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1629,17 +1629,15 @@ st:			if (is_imm8(insn->off))
>  		case BPF_JMP | BPF_CALL: {
>  			int offs;
>  
> +			if (!imm32)
> +				return -EINVAL;
> +
>  			func = (u8 *) __bpf_call_base + imm32;
> -			if (tail_call_reachable) {
> +			if (tail_call_reachable)
>  				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> -			} else {
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = x86_call_depth_emit_accounting(&prog, func);
> -			}
> +
> +			offs = (tail_call_reachable ? 7 : 0);

This 7 is the byte count of RESTORE_TAIL_CALL_CNT instructions.

I'll update it to RESTORE_TAIL_CALL_CNT_INSN_SIZE in v2 patch.

Thanks,
Leon

> +			offs += x86_call_depth_emit_accounting(&prog, func);
>  			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
>  				return -EINVAL;
>  			break;
> 
> base-commit: e4f30c666b4933dcd140d5110073aa01a69d2b39

