Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91801299C7
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2019 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWSSd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 13:18:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38325 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWSSc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 13:18:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so7484444plj.5
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=d6V52s4BKPdQEpKD1SI2Bsly2g14ETlTsMHFdZhaKlY=;
        b=Qkwlw+Ij3PJFQxO4sc7jGlpz5uhxnFhk5DVuVfP2vARkXal4HIih6A3mW8RrTYZTvp
         ICXsjLwgegS/rsC+Hem7BQ4/R5Z8oNb5WB1/i4VKeEixjJzAumbCGKk3ctZ0gNc7eqlP
         jXrnUhhmUBJJLaoNJXQlomTmlIMevULmq/IbEzbbbEQyrsWFlbS2CD/xmM1/vUKpzf6R
         Zn9n2miOFQjXH9ph0eX9Az63DK0huTVMNr+dIxrX6U3Il1vmgna+rGCRgtYiIT0QUZ/E
         mkJNKTsL0NbVqT0ekA01dwxghcvk+/LFT1ROT/iMy1wLQYjyH1DoGr+09kEg/eCZyJzQ
         XeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=d6V52s4BKPdQEpKD1SI2Bsly2g14ETlTsMHFdZhaKlY=;
        b=pPzXNAGW3M8Z/jni40yl8V9AEJIKvfEZ2VBnzXI8+aT6XzgHQKIs0z12X88FP24bqP
         8FJvFLP7q6xoVqq1/9pzE8QuR9KPomXGYBsukbDWwqQRXeuEAJqHqT9RGoyCOhL69nE5
         85TpbKHepWx4qLCgcQmWRnW3AmvHRLlQLJtA5/H8OFd2DkLhtjosV2FlzM2vMb9dao/t
         QQkeYNBEdvyW7PiPPfvsIGXzCkDB9lplIITfbH7/26AxsERoA4PXVT+s8A/CgiIGM/6n
         isR5TVDwaaKY8/MpUJRFN9AFyGHHbPX3lZWO+EE/WqLvVXUbgPP/Q7b/oqv99Ga2jNo3
         tmfw==
X-Gm-Message-State: APjAAAUQHMsn2ZnJ34LrQ9UGJVzN4//YmyMox6EXIojoiBwtXLtgsZij
        AZDHp+D4xWZ18JIvJVzALiLI9A==
X-Google-Smtp-Source: APXvYqxNkRz1IM63bfQgOhAxwSwTHbysAAjI6yuR5hi+uX515zg1SMQxxfRyXcnH0a8YFQqmrfACcQ==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr31418813plr.243.1577125111719;
        Mon, 23 Dec 2019 10:18:31 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id k1sm121461pjl.21.2019.12.23.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 10:18:31 -0800 (PST)
Date:   Mon, 23 Dec 2019 10:18:31 -0800 (PST)
X-Google-Original-Date: Mon, 23 Dec 2019 10:09:23 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH bpf-next v2 3/9] riscv, bpf: add support for far branching when emitting tail call
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <20191216091343.23260-4-bjorn.topel@gmail.com>
References: <20191216091343.23260-4-bjorn.topel@gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com>
Message-ID: <mhng-09e718bb-9ed9-4bc7-a4e6-e39eb0888acc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Dec 2019 01:13:37 PST (-0800), Bjorn Topel wrote:
> Start use the emit_branch() function in the tail call emitter in order
> to support far branching.
>
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
> index e599458a9bcd..c38c95df3440 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -496,16 +496,6 @@ static int is_12b_check(int off, int insn)
>  	return 0;
>  }
>
> -static int is_13b_check(int off, int insn)
> -{
> -	if (!is_13b_int(off)) {
> -		pr_err("bpf-jit: insn=%d 13b < offset=%d not supported yet!\n",
> -		       insn, (int)off);
> -		return -1;
> -	}
> -	return 0;
> -}
> -
>  static int is_21b_check(int off, int insn)
>  {
>  	if (!is_21b_int(off)) {
> @@ -744,18 +734,14 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>  		return -1;
>  	emit(rv_lwu(RV_REG_T1, off, RV_REG_A1), ctx);
>  	off = (tc_ninsn - (ctx->ninsns - start_insn)) << 2;
> -	if (is_13b_check(off, insn))
> -		return -1;
> -	emit(rv_bgeu(RV_REG_A2, RV_REG_T1, off >> 1), ctx);
> +	emit_branch(BPF_JGE, RV_REG_A2, RV_REG_T1, off, ctx);
>
>  	/* if (--TCC < 0)
>  	 *     goto out;
>  	 */
>  	emit(rv_addi(RV_REG_T1, tcc, -1), ctx);
>  	off = (tc_ninsn - (ctx->ninsns - start_insn)) << 2;
> -	if (is_13b_check(off, insn))
> -		return -1;
> -	emit(rv_blt(RV_REG_T1, RV_REG_ZERO, off >> 1), ctx);
> +	emit_branch(BPF_JSLT, RV_REG_T1, RV_REG_ZERO, off, ctx);
>
>  	/* prog = array->ptrs[index];
>  	 * if (!prog)
> @@ -768,9 +754,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>  		return -1;
>  	emit(rv_ld(RV_REG_T2, off, RV_REG_T2), ctx);
>  	off = (tc_ninsn - (ctx->ninsns - start_insn)) << 2;
> -	if (is_13b_check(off, insn))
> -		return -1;
> -	emit(rv_beq(RV_REG_T2, RV_REG_ZERO, off >> 1), ctx);
> +	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
>
>  	/* goto *(prog->bpf_func + 4); */
>  	off = offsetof(struct bpf_prog, bpf_func);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
