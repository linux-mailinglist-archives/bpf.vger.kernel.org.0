Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872A759EF92
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiHWXPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiHWXPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:15:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3733DBFE
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:15:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f17so8706556pfk.11
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=A02YbxdUr0BYyICF6bOGGCI04dmGvp1Z8ADzipmIPMA=;
        b=DTAcCdq3XYEpPJui9t8NpLZbMqpRHevXLkUwilHzVi9H8hM5kduzWv9vX+bIhwbVIR
         1OsDbQfC2P4UyvByp/GttxW7Ej2w4Zq4sDTQRx4+rwtmF5ULha4jmiyJD5+LSXeTqrTd
         yEsGDaImuGSuuPFXjOEF3g0xVY+UAxR2QTh1JBQD22tytnIHYpFcjR2ry/ZA6eXZOAY9
         dzq3It6QiolcuoChMMvRLDk9SnmcPpdbzhwaBSIS4M/HeDADF5DcHVxBgrBpiSRrpiLq
         3qTBCXaz0FygEkspYRCyxlqz/tFIh9kDca1Dab04KS5BriAAeFN0pZc3sfL9xVaKtvxq
         vFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=A02YbxdUr0BYyICF6bOGGCI04dmGvp1Z8ADzipmIPMA=;
        b=EUqyCe7a5O1ZPUfTH25WcdOMJ5lhGXeE1+ke9FnDvygEYkHJwZyyLDdBfZ+g4wVGZV
         2QhRlbve4HcHzHojgtYEJYEzsIVBHMT/oIhYZKEEt33kucFj8QbO+xuSozQ/psW0a41L
         Ymx1VSaSgfG56NK67luoBjImIUmTpxLltf/6ErDQSNoLEyt6gzUQ/xroLiKl8RsPlFP+
         4JKb4kdVWgNq8vIrZJRl/WlogmH8Ez0l28W6i7hBIIOiQzKLvHmoUsBZkVAKaxolssPO
         RqN9KtGvBWZgtoBjzL3beYPyXJ3KDewZwZIXeWDRgV0ioaJxPWAE+eGl0DnONlOdjdKD
         HQ3Q==
X-Gm-Message-State: ACgBeo133rCbb0Q3HIhefJgX1DJ3CzFxuXyAfM9en1rmpb/n+y9TPMXK
        iwcOMqjDvOxw9znFB1t6T4g=
X-Google-Smtp-Source: AA6agR5E07P6OFJ7ZYsFrs9gNoOC0HcIRTdg+x1mXAjoL1asm5na/hJFMzmAsEP7ytGlgdcx1NdoBg==
X-Received: by 2002:a05:6a00:1a89:b0:536:5dca:a673 with SMTP id e9-20020a056a001a8900b005365dcaa673mr15985959pfv.71.1661296551722;
        Tue, 23 Aug 2022 16:15:51 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b001729db603bcsm10986909plm.126.2022.08.23.16.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 16:15:51 -0700 (PDT)
Date:   Tue, 23 Aug 2022 16:15:49 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Message-ID: <63055fa5a080e_292a8208db@john.notmuch>
In-Reply-To: <20220822094312.175448-2-eddyz87@gmail.com>
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-2-eddyz87@gmail.com>
Subject: RE: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eduard Zingerman wrote:
> Propagate nullness information for branches of register to register
> equality compare instructions. The following rules are used:
> - suppose register A maybe null
> - suppose register B is not null
> - for JNE A, B, ... - A is not null in the false branch
> - for JEQ A, B, ... - A is not null in the true branch
> 
> E.g. for program like below:
> 
>   r6 = skb->sk;
>   r7 = sk_fullsock(r6);
>   r0 = sk_fullsock(r6);
>   if (r0 == 0) return 0;    (a)
>   if (r0 != r7) return 0;   (b)
>   *r7->type;                (c)
>   return 0;
> 
> It is safe to dereference r7 at point (c), because of (a) and (b).

I think the idea makes sense. Perhaps Yonhong can comment seeing he was active
on the LLVM thread. I just scanned the LLVM side for now will take a look
in more detail in a bit.

> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c1f8069f7b7..c48d34625bfd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
>  	return type & PTR_MAYBE_NULL;
>  }
>  
> +static bool type_is_pointer(enum bpf_reg_type type)
> +{
> +	return type != NOT_INIT && type != SCALAR_VALUE;
> +}
> +

Instead of having another helper is_pointer_value() could work here?
Checking if we need NOT_INIT in that helper now.

>  static bool is_acquire_function(enum bpf_func_id func_id,
>  				const struct bpf_map *map)
>  {
> @@ -10046,6 +10051,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	struct bpf_verifier_state *other_branch;
>  	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
>  	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
> +	struct bpf_reg_state *eq_branch_regs;
>  	u8 opcode = BPF_OP(insn->code);
>  	bool is_jmp32;
>  	int pred = -1;
> @@ -10155,7 +10161,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	/* detect if we are comparing against a constant value so we can adjust
>  	 * our min/max values for our dst register.
>  	 * this is only legit if both are scalars (or pointers to the same
> -	 * object, I suppose, but we don't support that right now), because
> +	 * object, I suppose, see the next if block), because
>  	 * otherwise the different base pointers mean the offsets aren't
>  	 * comparable.
>  	 */
> @@ -10199,6 +10205,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  					opcode, is_jmp32);
>  	}
>  
> +	/* if one pointer register is compared to another pointer
> +	 * register check if PTR_MAYBE_NULL could be lifted.
> +	 * E.g. register A - maybe null
> +	 *      register B - not null
> +	 * for JNE A, B, ... - A is not null in the false branch;
> +	 * for JEQ A, B, ... - A is not null in the true branch.
> +	 */
> +	if (!is_jmp32 &&
> +	    BPF_SRC(insn->code) == BPF_X &&
> +	    type_is_pointer(src_reg->type) && type_is_pointer(dst_reg->type) &&
> +	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
> +		eq_branch_regs = NULL;
> +		switch (opcode) {
> +		case BPF_JEQ:
> +			eq_branch_regs = other_branch_regs;
> +			break;
> +		case BPF_JNE:
> +			eq_branch_regs = regs;
> +			break;
> +		default:
> +			/* do nothing */
> +			break;
> +		}
> +		if (eq_branch_regs) {
> +			if (type_may_be_null(src_reg->type))
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
> +			else
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
> +		}
> +	}
> +
>  	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
>  	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
>  		find_equal_scalars(this_branch, dst_reg);
> -- 
> 2.37.1
> 


