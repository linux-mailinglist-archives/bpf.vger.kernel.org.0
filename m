Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5F5B10A3
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIGXsr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 19:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGXsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 19:48:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90476C6E91
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 16:48:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so15061933pgq.6
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XVsnauWkWOvQqLoOpgffQ6QOY9xzc9gkS3uPCEqVuIU=;
        b=c4iDBgOBjvQvva3FMiJf59XQbOYaJTghbiBN6+wf1yVFYJcsc0h0RH6A6HWZ554t/T
         5GOWMv6e2g56MDJBzLhUqhGl6AmirF/nz4JsfAbQZv2Vqfk3w1Vuu0eb/V335oXETA1M
         GgLfmTVwvj8gcv//LrGQhJZw00XQr8SwToRUreoB2DUoRbP34+xAfTYK3yim8+w2iWjJ
         n8fs7JRv++UPT6l8nwi0praAHhMdmfw4fpBcBQF691gW2Srra7+ye7R7s9xgHZeo9Mvw
         0Y+AU1ivsYnCrw+kq+lStYA15GyMWAQye5PWRA7eWay8XyLkC48c1BCaey3empUgMke+
         gmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XVsnauWkWOvQqLoOpgffQ6QOY9xzc9gkS3uPCEqVuIU=;
        b=5VEzPVDlrfV0WDA6feR+MkFxkq3RFYDTu3EKpJRcBZBT8hFmjwDT7cdFaIuWN9Ldc0
         OfgMNEBuyD4je1pZO3gqahuL8L00XwuzWH6XdeP5XyBBuTJT4Cv0PZh8T341TCEXv7A0
         kF9HxU7YSS+mcuMTAOrLM6vx9Jlx1OciwRXi0AyyMOniW5ZI+Qf+CWhweugyfbJHFwGq
         HEQos4pro5s8WqZ91i/tbP9ojwrgFgmtKs3yZNwap6y5CiMcdZKQj/QpTekeIYvLK/pG
         th6/pav2m1O0w7UgbQdmyUaRlQiLDyAb/RtzhzaGDbyP5pE07q/cbJx7/xOPw2qXPVkW
         0j9Q==
X-Gm-Message-State: ACgBeo2igZ+6ur7676XIUlAtViG3FPHchx5ISpMroIcxETIUIh85Eaye
        AApvQCgBppMbVZy5WR5CYhMnesEiwGc=
X-Google-Smtp-Source: AA6agR74JbrUtQZqD7vDp8MyRZAa3RTxIg8i+4B69AfVi3k7o7VuK73QOc7sqS/mlYwC+xDeVij6uQ==
X-Received: by 2002:a05:6a00:2282:b0:53f:6f3b:bbce with SMTP id f2-20020a056a00228200b0053f6f3bbbcemr1245817pfe.62.1662594525027;
        Wed, 07 Sep 2022 16:48:45 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:66c4])
        by smtp.gmail.com with ESMTPSA id n7-20020a622707000000b0052d46b43006sm13149123pfn.156.2022.09.07.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:48:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:48:42 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 15/32] bpf: Add helper macro
 bpf_expr_for_each_reg_in_vstate
Message-ID: <20220907234842.ireun3cffuhauww2@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-16-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904204145.3089-16-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 04, 2022 at 10:41:28PM +0200, Kumar Kartikeya Dwivedi wrote:
> For a lot of use cases in future patches, we will want to modify the
> state of registers part of some same 'group' (e.g. same ref_obj_id). It
> won't just be limited to releasing reference state, but setting a type
> flag dynamically based on certain actions, etc.
> 
> Hence, we need a way to easily pass a callback to the function that
> iterates over all registers in current bpf_verifier_state in all frames
> upto (and including) the curframe.
> 
> While in C++ we would be able to easily use a lambda to pass state and
> the callback together, sadly we aren't using C++ in the kernel. The next
> best thing to avoid defining a function for each case seems like
> statement expressions in GNU C. The kernel already uses them heavily,
> hence they can passed to the macro in the style of a lambda. The
> statement expression will then be substituted in the for loop bodies.
> 
> Variables __state and __reg are set to current bpf_func_state and reg
> for each invocation of the expression inside the passed in verifier
> state.
> 
> Then, convert mark_ptr_or_null_regs, clear_all_pkt_pointers,
> release_reference, find_good_pkt_pointers, find_equal_scalars to
> use bpf_expr_for_each_reg_in_vstate.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  21 ++++++
>  kernel/bpf/verifier.c        | 135 ++++++++---------------------------
>  2 files changed, 49 insertions(+), 107 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c6d550978d63..73d9443d0074 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -354,6 +354,27 @@ struct bpf_verifier_state {
>  	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>  	     iter++, reg = bpf_get_spilled_reg(iter, frame))
>  
> +/* Invoke __expr over regsiters in __vst, setting __state and __reg */
> +#define bpf_expr_for_each_reg_in_vstate(__vst, __state, __reg, __expr)   \

Very nice.
I renamed it to bpf_for_each_reg_in_vstate to make it less verbose
and more consistent with existing bpf_for_each_spilled_reg.
And applied to bpf-next.
