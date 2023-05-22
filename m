Return-Path: <bpf+bounces-1017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A070C10E
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD051C20AA0
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121814287;
	Mon, 22 May 2023 14:27:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A014266
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 14:27:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0860E7A;
	Mon, 22 May 2023 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rNjaU9cgFCRClTkTmVi7MpCda9Uzhq6n29hmf53/eBQ=; b=TghWKnQt4J6SmA/Auua1W7jkSw
	mkEF8oOpUoC36dbYdD81JaJR1LjRoC/QBEOeD7/aHHxCYvLbrUehiKxmE4ejimsE297o8B8LS8zuO
	Lxbr0waJViAjnIVUqWUD+8V47GZ3MdK3U59BbqmPaNyaUr2CpVYeruPGoQnMDZOrBHBZYgXebBFps
	Li5ZAUZw/IVraXhKOHs1d7cysHI4rtN4mkgQqDW88qx+syq4teAicUwXwhjVOh9S4BBBrjQrTOvqL
	CW3cWYfLUhsPx0MPNxWFwi9Lj0/db9WRpUIOvWCZNtbP5aumvAdyWZjUVzROcpzMPedzFR5dz4CsE
	sX7wo0Ng==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q16Ue-000KQq-BJ; Mon, 22 May 2023 16:26:36 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q16Ud-000Qea-Dh; Mon, 22 May 2023 16:26:35 +0200
Subject: Re: [PATCH 1/2] bpf: hide unused bpf_patch_call_args
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Delyan Kratunov
 <delyank@fb.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Menglong Dong <imagedong@tencent.com>, Yafang Shao <laoar.shao@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517125617.931437-1-arnd@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b5eefaaa-0566-a545-ffbe-e23c51397126@iogearbox.net>
Date: Mon, 22 May 2023 16:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230517125617.931437-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26915/Mon May 22 09:23:18 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/17/23 2:56 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
> is enabled:
> 
> kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
> 
> Hide the definition as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   kernel/bpf/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7421487422d4..6f5ede31e471 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2064,7 +2064,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   };
>   #undef PROG_NAME_LIST
>   #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
> -static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
> +static __maybe_unused u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
>   				  const struct bpf_insn *insn) = {

Patch 2 lgtm, small nit above: could you fix up indent?

>   EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
>   EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
> @@ -2072,6 +2072,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   };
>   #undef PROG_NAME_LIST
>   
> +#ifdef CONFIG_BPF_SYSCALL
>   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   {
>   	stack_depth = max_t(u32, stack_depth, 1);
> @@ -2080,6 +2081,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   		__bpf_call_base_args;
>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
>   }
> +#endif
>   
>   #else
>   static unsigned int __bpf_prog_ret0_warn(const void *ctx,

Thanks,
Daniel

