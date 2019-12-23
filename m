Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986B61299DF
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2019 19:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLWS3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 13:29:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44508 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWS3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 13:29:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so9194794pgl.11
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=ETCAz2nAecl12u4VuGxwDzQ9bwqkvTCnDzDrKnZSkaE=;
        b=NQ/x9Xan0pE4XVpqheHlJ4CgdWe9LDhiMKidcqqT/im1ZAJ8dXpX0qu/PHgUy31UXc
         G6lwCJOBwiAh/ft2PEvg80+4POa6qy7ZUAtsi0I51DRIPt1txRBs1ubVABHHkMq84bx6
         Kfcs79SAgBwfBBF2bxH2cNdP4dfjRRRLwYt8VfjTO6bR8exPyX8qx8azKgm/U2X7npz0
         /6McjwgckB8P17bxehoGhsQtMyxnja/2UTTroiKjpoLuAVsfKCH6Xa0FOzHNYjE/TGoQ
         UN8DeWzbvbMYNHdgcA1zhyqEpumsqCinN9aKr8Qtsu+5X8j40ZMJqXM6DCkuCNoHPGbf
         FWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ETCAz2nAecl12u4VuGxwDzQ9bwqkvTCnDzDrKnZSkaE=;
        b=Vs7bthtGMw4mzykRpbjZPYP3nx6VGSMGDTTzfR7/g/E4cP8nAKz6+BetDzCMSuU58u
         91hrgzUle8ROndQ7mfgX0B/YVPh2ApRj+IiBnZ6NPS0CkYJcI2qCLv013rXlD+UjSi04
         MRwWjZKzcp4Ok73qUhipHw0oviDENy/9tkQczlbWjbBo3L2ZccdDuhcFWjq4DH/colAO
         nkWZzm0q+ZLPh/25EgS7cTAYax/nsJdCTgsr+MTDKRxmjvaXFl+rqnNaQ16AdLlyxFZJ
         lYJfjsbq649He5ASapY39GIzgF8mYBxecy1ouFJ6DqMjRav5Chp0oMQFwEY68ligsIjS
         WgMQ==
X-Gm-Message-State: APjAAAUcIA4etOzTCnqWyq3t101KU4IpVKCBoslQJSinwHw9EJfXhCK2
        aXGcJucPK5PCnt7oAQ3Xt8UQZw==
X-Google-Smtp-Source: APXvYqzyXbXysDM2meGOAdnFewhF96oWfXTEbytcsUZtAPxGdzhU1sBVIYdYLoMQmjWY+UsfFcIGRQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr34004010pfm.128.1577125779770;
        Mon, 23 Dec 2019 10:29:39 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id w20sm15751188pfi.86.2019.12.23.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 10:29:39 -0800 (PST)
Date:   Mon, 23 Dec 2019 10:29:39 -0800 (PST)
X-Google-Original-Date: Mon, 23 Dec 2019 10:29:24 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH bpf-next v2 5/9] riscv, bpf: optimize BPF tail calls
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <20191216091343.23260-6-bjorn.topel@gmail.com>
References: <20191216091343.23260-6-bjorn.topel@gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com>
Message-ID: <mhng-01fe07e5-a27a-4fde-a7ab-22bbad6eb668@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Dec 2019 01:13:39 PST (-0800), Bjorn Topel wrote:
> Remove one addi, and instead use the offset part of jalr.
>
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
> index 2fc0f24ad30f..8aa19c846881 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -552,7 +552,7 @@ static int epilogue_offset(struct rv_jit_context *ctx)
>  	return (to - from) << 2;
>  }
>
> -static void __build_epilogue(u8 reg, struct rv_jit_context *ctx)
> +static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>  {
>  	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
>
> @@ -589,9 +589,11 @@ static void __build_epilogue(u8 reg, struct rv_jit_context *ctx)
>
>  	emit(rv_addi(RV_REG_SP, RV_REG_SP, stack_adjust), ctx);
>  	/* Set return value. */
> -	if (reg == RV_REG_RA)
> +	if (!is_tail_call)
>  		emit(rv_addi(RV_REG_A0, RV_REG_A5, 0), ctx);
> -	emit(rv_jalr(RV_REG_ZERO, reg, 0), ctx);
> +	emit(rv_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
> +		     is_tail_call ? 4 : 0), /* skip TCC init */
> +	     ctx);
>  }
>
>  /* return -1 or inverted cond */
> @@ -751,9 +753,8 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>  	if (is_12b_check(off, insn))
>  		return -1;
>  	emit(rv_ld(RV_REG_T3, off, RV_REG_T2), ctx);
> -	emit(rv_addi(RV_REG_T3, RV_REG_T3, 4), ctx);
>  	emit(rv_addi(RV_REG_TCC, RV_REG_T1, 0), ctx);
> -	__build_epilogue(RV_REG_T3, ctx);
> +	__build_epilogue(true, ctx);
>  	return 0;
>  }
>
> @@ -1504,7 +1505,7 @@ static void build_prologue(struct rv_jit_context *ctx)
>
>  static void build_epilogue(struct rv_jit_context *ctx)
>  {
> -	__build_epilogue(RV_REG_RA, ctx);
> +	__build_epilogue(false, ctx);
>  }
>
>  static int build_body(struct rv_jit_context *ctx, bool extra_pass)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
