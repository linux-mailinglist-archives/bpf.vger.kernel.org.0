Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500DE62EA14
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiKRAMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRAMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:12:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299EC66C99
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:12:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso6823452pjg.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIs4s2lDkUrZ2KY3IJsLE1tOL7S+DzmRmsJ9c1m7iGc=;
        b=g8pRuSISYNt9mf0P0HeLv+t0wnnFLCVMkMvhmH/9zUk6u5Z0ucjBjRX1Xvq2N+gGVY
         6V9BftUR2lzqfXcQR0wHvzN7OU3ZLLkyTLPahCFB4UkBDP4p3V+FAQPWHP+qi9vfEEOB
         pbYssYBCsdEN6T9DwHwwMzupY476ugiFLB0HlQeQ58lCiryDxl6slht8TO8AQhnNO3Wv
         FhUm+YjbNX4yK8VGNo5WFEfY06oAsS068LNup2PicqpvP8UTlv0C4/ZA9V0jZT+nGHgU
         TrAAVNdww5aTiaUnqKbQ2+1HaPr0tAkgyMBuNkMCN6Nn9KfHqHYO6mB/4/clRejghRXw
         3a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIs4s2lDkUrZ2KY3IJsLE1tOL7S+DzmRmsJ9c1m7iGc=;
        b=65w8ceFpvLw9ncX/hS4WXG7C39wkb+whpvn/yGEqCAFf2ep4DyuY1/OjvwqHaklqFv
         wh68W2SzXUT64JHV3IaTB8kXW8VJect4RUIhovppBtOiLrY4ikpd8zkZ+hSa8qFzQ/4B
         Vn5HiCtKbsFaCJj/YujXzTCAVrCRVuuPRt+Eu3OfbRhq9jWq58fAa17+xKXeXmci4apy
         B7vQ4fzaEFoPd0x9Ah+scmmxPlWxm0O6ZOchEbpBQDD3XrQDQLeHVyad0SS0Ly3+YgDi
         009w0PW01XVh3eUUirAq91do3uTy4D5NPAXte60RUPu1AZT6UMTEthtOtBB3jY//fulo
         tSSg==
X-Gm-Message-State: ANoB5plnihpEY6R45hYJORNWWYMMVdNsi9Gkq5wDn+7OIJiRBxNwh+Fo
        KNDO0vHi/pXEhXlyulVt0ZM=
X-Google-Smtp-Source: AA0mqf62GvvMgbJXFlGVCnIevJTTVC281kxyGXCHesM5n/Cm6a+D9FLiHrdMNsirwHQF2Rx8lDJ9KA==
X-Received: by 2002:a17:902:d212:b0:186:6d34:b7b5 with SMTP id t18-20020a170902d21200b001866d34b7b5mr5221080ply.37.1668730348538;
        Thu, 17 Nov 2022 16:12:28 -0800 (PST)
Received: from MacBook-Pro-5.local ([2620:10d:c090:400::5:411c])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a4b0900b001efa9e83927sm4084310pjh.51.2022.11.17.16.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:12:27 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:12:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v9 16/23] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221118001224.5wdzzcdgsrtsx54l@MacBook-Pro-5.local>
References: <20221117225510.1676785-1-memxor@gmail.com>
 <20221117225510.1676785-17-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117225510.1676785-17-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 04:25:03AM +0530, Kumar Kartikeya Dwivedi wrote:
> +
> +	if (reg->type == PTR_TO_MAP_VALUE) {
> +		rec = reg->map_ptr->record;
> +	} else /* PTR_TO_BTF_ID | MEM_ALLOC */ {
> +		struct btf_struct_meta *meta;
> +
> +		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> +		if (!meta) {
> +			verbose(env, "bpf_list_head not found for allocated object\n");
> +			return -EINVAL;
> +		}
> +		rec = meta->record;
> +	}
> +
...
> +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> +					   struct bpf_reg_state *reg, u32 regno,
> +					   struct bpf_kfunc_call_arg_meta *meta)
> +{
...
> +
> +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> +	if (!struct_meta) {
> +		verbose(env, "bpf_list_node not found for allocated object\n");
> +		return -EINVAL;
> +	}
> +	rec = struct_meta->record;

and counting process_spin_lock() there are 3 cases of very similar code.
Could you combine it into a helper?
