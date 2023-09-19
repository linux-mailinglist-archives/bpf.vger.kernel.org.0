Return-Path: <bpf+bounces-10382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742C7A5F54
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43DD2819ED
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE58538C;
	Tue, 19 Sep 2023 10:20:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B08110B
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:20:04 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A08F3
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZKJXqIdeTwqKyLhtuDkaSerz+2QHF6QcxHB89sin0dM=; b=WsTNbrRqc3aV+Om7mbD+1ozjCh
	NvwvFpeL1eOS0D+mTMXA5WBVmYlfL00cLWZmRa8k8wEWuDdy7fuiFXBQzntWrZpJgNKNDH+ARaP+9
	ls1H7Ud5o+s3QaIwDuAKmUjvAbSRLTcxJZ899zR8iSigmqTFLZP3/eVP4rxFPBI2VzFJhBZWjIayE
	nBszr2OvKoPUI+JmYfXACHIyq5SXkF1CBVUpxL4El42X8h5J9POa0YB4M/5sxxuh8elHzBVHsNmUa
	y6xSqoNdY52SipJNduthnUdRu43eUSTuo/mX7D52Rsx3T+XUgc5n+KxVz14+nw2OHxt349CNH3ADh
	bwdQPt/A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiXpm-000FGI-Go; Tue, 19 Sep 2023 12:19:58 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiXpm-000FVH-8O; Tue, 19 Sep 2023 12:19:58 +0200
Subject: Re: [PATCH bpf-next v2] bpf, x64: Check imm32 first at BPF_CALL in
 do_jit()
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, tglx@linutronix.de,
 maciej.fijalkowski@intel.com, kernel-patches-bot@fb.com
References: <20230914123527.34624-1-hffilwlqm@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a5c67a25-0b5a-f7f4-ad96-1c595b099128@iogearbox.net>
Date: Tue, 19 Sep 2023 12:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230914123527.34624-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27036/Tue Sep 19 09:42:31 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/14/23 2:35 PM, Leon Hwang wrote:
> It's unnecessary to check 'imm32' in both 'if' and 'else'.
> 
> It's better to check it first.
> 
> Meanwhile, refactor the code for 'offs' calculation.
> 
> v1 -> v2:
>   * Add '#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7'.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>   arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2846c21d75bfa..fe0393c7e7b68 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1025,6 +1025,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>   /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>   #define RESTORE_TAIL_CALL_CNT(stack)				\
>   	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> +#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7
>   
>   static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>   		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
> @@ -1629,17 +1630,16 @@ st:			if (is_imm8(insn->off))
>   		case BPF_JMP | BPF_CALL: {
>   			int offs;
>   
> +			if (!imm32)
> +				return -EINVAL;
> +
>   			func = (u8 *) __bpf_call_base + imm32;
> -			if (tail_call_reachable) {
> +			if (tail_call_reachable)
>   				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> -			} else {
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = x86_call_depth_emit_accounting(&prog, func);
> -			}
> +
> +			offs = (tail_call_reachable ?
> +				RESTORE_TAIL_CALL_CNT_INSN_SIZE : 0);
> +			offs += x86_call_depth_emit_accounting(&prog, func);

I don't think this makes anything significantly better, I would rather prefer to keep
it as is.

>   			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
>   				return -EINVAL;
>   			break;
> 
> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
> 


