Return-Path: <bpf+bounces-5038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C8754262
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2691C21490
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B515AD2;
	Fri, 14 Jul 2023 18:14:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9B13715
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 18:13:59 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E203ABD
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:13:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eb03457cso1570578b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689358416; x=1691950416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjKF7yFrXOSnaX5xv65w54druiP9KaX9NdsoY89c3LU=;
        b=GjAndaCOBIcln1jt4hhgJ3s1B4GQdB62lrQ+WPwXbTsp7tdXcOttltLSBGL4f1ur2n
         YfS0iZdX1ZjqZfCXCCtfUWO3OoNjiu0iyM2iMILRhmDHN0RefmY7SxpEcfk98dhKjg2j
         d2Mp1QYafzKzVNjdYfY4rKLupNm0gTfbtRfVgQ/84qFGdpfKiFec1Aisv26AzHqKBxeT
         bc+hIeIdRHB2sz8S4Pj41X00TThAHXSp7T65k9J5DUwCxclAnkyW9F9prW5V1x4EUhOq
         yY0hy6GRh5hp7FgMuhYDGlsw4Vf8zTGlWG6cos+JpFl6VNS4Gz7buY6+eJCSs6zLoPtC
         Gsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358416; x=1691950416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjKF7yFrXOSnaX5xv65w54druiP9KaX9NdsoY89c3LU=;
        b=HauSmJRMUPeB7QmQs9M2qEjsx7wZgkjowH5uHoKTXhxjPORVVVQOwXBcw77oIMLPSW
         l8dubv9wym481sljevkQ5kc5zOg55AlEmstjZW0FI74z3Y+IkeQkeqHx2dK5onXm3q15
         zGq2oxut5r+FaYOZCMornDTAKoj5Q69dj6ysNLISeB64x8sTvxI0P69Rp8p5J8tLzXrQ
         Asg+sFAQscRAt55sZMrAMKqLvapGeognQRXeoO5W3NP8+S4KI1rCOFGY24yea74HycWM
         hKvv4vodaMUdd7HUngLb7XIR3uWln+lKfduP7NZvVT/o+78vtYv+P3iAPpExTbhQ7Tnp
         eZzQ==
X-Gm-Message-State: ABy/qLbmLzoucqO5cLye2DIhQAVzMWGF7HMThK2Vjb/Si8qo4R2SuWyN
	RDtJx0TEZfoemcCpZdjAa50=
X-Google-Smtp-Source: APBJJlF2AtesARjBalnpVJNsF68KPqg4S4zfz3SrOruCIjzV61maguARGWxyhInNQrORaJP+sdltTw==
X-Received: by 2002:a05:6a00:1686:b0:67c:c8e4:8689 with SMTP id k6-20020a056a00168600b0067cc8e48689mr5455572pfc.12.1689358415936;
        Fri, 14 Jul 2023 11:13:35 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm7442033pfm.182.2023.07.14.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:13:35 -0700 (PDT)
Date: Fri, 14 Jul 2023 11:13:33 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Fangrui Song <maskray@google.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Support new sign-extension load
 insns
Message-ID: <20230714181333.lrxledwyh6f4mqri@MacBook-Pro-8.local>
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060724.389084-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713060724.389084-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:07:24PM -0700, Yonghong Song wrote:
>  
> @@ -1942,6 +1945,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  	LDST(DW, u64)
>  #undef LDST
>  
> +#define LDS(SIZEOP, SIZE)						\

LDSX ?

> +	LDX_MEMSX_##SIZEOP:						\
> +		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
> +		CONT;
> +
> +	LDS(B,   s8)
> +	LDS(H,  s16)
> +	LDS(W,  s32)
> +#undef LDS

...

> @@ -17503,7 +17580,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
>  		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
>  		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
> -		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW)) {
> +		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW) ||
> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_B) ||
> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_H) ||
> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_W)) {
>  			type = BPF_READ;
>  		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
>  			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
> @@ -17562,6 +17642,11 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  		 */
>  		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
>  			if (type == BPF_READ) {
> +				/* it is hard to differentiate that the
> +				 * BPF_PROBE_MEM is for BPF_MEM or BPF_MEMSX,
> +				 * let us use insn->imm to remember it.
> +				 */
> +				insn->imm = BPF_MODE(insn->code);

That's a fragile approach.
And the evidence is in this patch.
This part of interpreter:
        LDX_PROBE_MEM_##SIZEOP:                                         \
                bpf_probe_read_kernel(&DST, sizeof(SIZE),               \
                                      (const void *)(long) (SRC + insn->off));  \
                DST = *((SIZE *)&DST);                                  \

wasn't updated to handle sign extension.

How about
#define BPF_PROBE_MEMSX 0x40 /* same as BPF_IND */

and handle it in JITs and interpreter.
We need a selftest for BTF style access to signed fields to make sure both
interpreter and JIT handling of BPF_PROBE_MEMSX is tested.

