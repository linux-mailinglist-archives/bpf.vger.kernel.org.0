Return-Path: <bpf+bounces-22497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DB85F653
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C972B27037
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427E2BB1B;
	Thu, 22 Feb 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJtztTcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C23FB14
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599550; cv=none; b=jmxCAUcqCdZooIr13s1yb383fp9n9Ee0e2HPOSbb7dBpjMeAbDryfx3ZmsacYuuI4IvrPxUiO+DdKg2wgbw0RobxWt8c60Q/13cUdaZ9SgI9OysVAv2c92iNusjdMqz0PUDSw9dTPwxerbsvQ6uczBfdRqym4jacbNeMu1WF17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599550; c=relaxed/simple;
	bh=xsN1woqjhTaZzHg1L5EWVAxSQBzjfQv72jFRzjPdpbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yffe+WYD0MSgAw5vnXr4JqanwraJdPiVnpvyIoOv66PHiDAl+QZbqezcGfXuJo6LiGja0X6SlyyKmHsiu3wHX+RaV+WttRz5RMLyA9Q1us6VN4YHJ0iO8sTwmboObxtDfSPD/ewZrrLKqtTSM2Si/yoGN3UvrY3EAtmqKBbD3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJtztTcN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so2187566a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 02:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708599547; x=1709204347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcZfx4AliYVnhSY26l9zF1vP5pwRheqyq6q2/sNsxGU=;
        b=HJtztTcNsvmWG9twc4uw9UNH8VK1gvQW6TQ5e3mz04ebys9siUYb5q7j3OZ8Rbyu2B
         BNiHHEjhNeuMH1+lQ3gYFKtL8rMJPfEXThRXp/KdxPd2nYtVM/lJB+OUV/FfnyaBrnjG
         Sck8TaTpPrEQ4aHwiYUQRBDzf5haH9z/n+wfnZZYVoufc1G6nF63CZilTumRL9jkTGci
         lmG/R1XPBQYNdUKkr93N5ooh2NQrAO0Sgh5qDLlhshDS5matOTTNXDE2pZ/mmqGktB9h
         amfwu2bd03hv6g0xJnUckIBmW1v3617BznbLyNB7cBJwpuvbyv8TskLQmnRoV8JbJbUT
         baVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599547; x=1709204347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcZfx4AliYVnhSY26l9zF1vP5pwRheqyq6q2/sNsxGU=;
        b=YqDyIpOU/nTEAYhifdJqwDAJ910BTS0AIqq9OPPJzlozQwajV9f55r4af64RdQITel
         I/Ed8wmCD60d5newuDZYvxdkig4bHC+IL78Hbkp/6FxyFVEsYJac7n66MFSShrCZl7C7
         46qeDJnDLSC8jp/b/cugC1f2VFlCGL15jwSLn5OXj5964eQpIIvHl1vHnqFQCNwzTB1d
         C4IuM+L5S15xWKVvvD0wQfHfiPCJ9k1icIGtlo0zO9bfbzetl2ubFtYIZ7lc/pAm4wxf
         EGVi0nWOwPoBX3alO4M0j+5m3km9T7HudrIyfDe8wpv3x0tBp1zgZUlqSdwMw5RvcbIr
         EK3A==
X-Gm-Message-State: AOJu0YxAMpkuL8s2PBq9l0M52++AxU2XcZCN4qlFofVO98A4J+v3uQz0
	Vu+h3JAOiMfIMO8nwK0idUfqFMC5kB/9Wv8J5QvoS8uLuqUQige70iKF8oh2rdM=
X-Google-Smtp-Source: AGHT+IHle8ut5AVZi8kcUtNsBU5XoDVf+YU+YxtM1RivgAjBVJ+dV1joS6IbU2m7fbRwBxUt4RBaKQ==
X-Received: by 2002:a17:90a:5606:b0:299:2924:8bbb with SMTP id r6-20020a17090a560600b0029929248bbbmr16309277pjf.11.1708599547248;
        Thu, 22 Feb 2024 02:59:07 -0800 (PST)
Received: from [192.168.11.208] (220-136-196-149.dynamic-ip.hinet.net. [220.136.196.149])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b0029942a73eaesm11449825pjn.9.2024.02.22.02.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:59:06 -0800 (PST)
Message-ID: <b657e890-84e9-4cd0-82a2-12cb8294851c@gmail.com>
Date: Thu, 22 Feb 2024 18:59:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com, kernel-patches-bot@fb.com
References: <20240222085232.62483-1-hffilwlqm@gmail.com>
 <20240222085232.62483-2-hffilwlqm@gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240222085232.62483-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/22 16:52, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> How about:
> 
> 1. More than 1 subprograms are called in a bpf program.
> 2. The tailcalls in the subprograms call the bpf program.
> 
> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> 

[SNIP]

> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 128 ++++++++++++++++++++----------------
>  1 file changed, 71 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e1390d1e331b5..3d1498a13b04c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -18,6 +18,7 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include <asm/percpu.h>
>  

[SNIP]

> +
>  /*
>   * Generate the following code:

nit: the "tail_call_cnt++" of the comment should be updated too.

>   *
> @@ -594,7 +641,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>  					u32 stack_depth, u8 *ip,
>  					struct jit_context *ctx)
>  {
> -	int tcc_off = -4 - round_up(stack_depth, 8);
>  	u8 *prog = *pprog, *start = *pprog;
>  	int offset;
>  
> @@ -615,17 +661,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>  	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>  	EMIT2(X86_JBE, offset);                   /* jbe out */
>  
> -	/*
> -	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
> +	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
>  	 *	goto out;
>  	 */
> -	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
> +	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip + (prog - start));
>  	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */

[SNIP]

Thanks,
Leon

