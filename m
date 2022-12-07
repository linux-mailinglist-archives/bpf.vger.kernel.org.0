Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7864527F
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 04:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLGDRp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 22:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLGDRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 22:17:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8C6596
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 19:17:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b11so16349159pjp.2
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 19:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4+L+oXCtVc2YgwORlo2pBJ9wNuBGn9p10kyjoJ6DMY=;
        b=bUSfyinEYQvaPbkK4ZVbV78Cj08RvpcgLWQ7n9v3juzUBEADuw3m2lBUHyLSRHvmhn
         oH0MdGfKYLfjUxpCd9NkjKN0lvA94LBwTIUd4PfruDZpeSi1IiExtdkoFvnkdAMIcqbU
         Ab+g94LTpcp9QG1AsRcM5HFUOuiy2uqo41DaliziZPYEhcT9IrVp5nFKhzGVxj+nbQmu
         a3hlLLr5SCgh/rpvFmBRyhnnvHGTy6GP6yw8A35UPrnRtOMF8waO4+1eqvg5NzZeJEw2
         Hi0TDQGvSMnS1dMntdU5U1PqQkLPvfFyLbNdSzqJR6hdRnlYZosxFA1o0nHPKDXjsXX7
         KsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4+L+oXCtVc2YgwORlo2pBJ9wNuBGn9p10kyjoJ6DMY=;
        b=wlhJI9NpiuCU0tbW93iPY1U7ZlsoatgvsJUDmrBULFvjsVAOjvq9CM6PDcqp8rE/Hc
         l0Rz73tDwzboBLzsog33kVtMVh5J5uwUKr+v7SPr/NowUOnqUz4kKh03V+icmYqBPJHe
         zCcSE5hDOfElKuT1xsiLUStLOxkrSD+3N03Fh2CRK34CNR+eRUFU1gSCpMxDDAL7t7C2
         4kUHGLC024/y9chRm0+9BjZAIxbs5VDcPerbWYhFo4WgA7XdHvpRRLeulaG+aHKlrGFK
         i93jHiwDEjTYjMNnVozvFcPLrL6w2NOvJiD+SR5r24tlLulZ0tJpnzRPOkBNcB4giDA2
         oMUg==
X-Gm-Message-State: ANoB5pk3t+4pJqfBBYySszKBzMsEZMVjLVfmJBr4VbCAT8F5HPZwajgG
        0CT/ieKXc9MMBG/Woc+jVy4O3BiyYHs=
X-Google-Smtp-Source: AA0mqf5oM7hcXxFlKh0KJa2egWHZf28DtwjwSrAn33C/y5IxYyX7W5WsnUcAkAryl+BSkjscWH3Lbw==
X-Received: by 2002:a17:903:515:b0:189:bcf7:1ec0 with SMTP id jn21-20020a170903051500b00189bcf71ec0mr503242plb.30.1670383062453;
        Tue, 06 Dec 2022 19:17:42 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b001868bf6a7b8sm13302010ple.146.2022.12.06.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 19:17:41 -0800 (PST)
Date:   Tue, 6 Dec 2022 19:17:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: remove unnecessary prune and jump
 points
Message-ID: <20221207031739.nvxsahedtr2ogv6j@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206233345.438540-1-andrii@kernel.org>
 <20221206233345.438540-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206233345.438540-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:33:45PM -0800, Andrii Nakryiko wrote:
> Don't mark some instructions as jump points when there are actually no
> jumps and instructions are just processed sequentially. Such case is
> handled naturally by precision backtracking logic without the need to
> update jump history. See get_prev_insn_idx(). It goes back linearly by
> one instruction, unless current top of jmp_history is pointing to
> current instruction. In such case we use `st->jmp_history[cnt - 1].prev_idx`
> to find instruction from which we jumped to the current instruction
> non-linearly.
> 
> Also remove both jump and prune point marking for instruction right
> after unconditional jumps, as program flow can get to the instruction
> right after unconditional jump instruction only if there is a jump to
> that instruction from somewhere else in the program. In such case we'll
> mark such instruction as prune/jump point because it's a destination of
> a jump.
> 
> This change has no changes in terms of number of instructions or states
> processes across Cilium and selftests programs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b1feb8d3c42e..4f163a28ab59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12228,13 +12228,12 @@ static int visit_func_call_insn(int t, int insn_cnt,
>  	if (ret)
>  		return ret;
>  
> -	if (t + 1 < insn_cnt) {
> -		mark_prune_point(env, t + 1);
> -		mark_jmp_point(env, t + 1);
> -	}
> +	mark_prune_point(env, t + 1);
> +	/* when we exit from subprog, we need to record non-linear history */
> +	mark_jmp_point(env, t + 1);
> +

With this we probably should remove 'insn_cnt' from visit_func_call_insn().
and in-turn from visit_insn() as well.
Pls consider as a follow up.
