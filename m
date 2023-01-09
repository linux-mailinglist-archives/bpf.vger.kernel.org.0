Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22D06624B1
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjAILxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbjAILwy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:52:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA21A3A5
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:52:44 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id v23so4319511plo.1
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCF1alsPBSG2XfKNfFcoUe5C7ySQ/Wrcwer42jVv4+o=;
        b=gx0L15o8QkYy+Ft9M3WfnfhEh/NPSaC9f70bIntMoxaBqJCjyjEMEt32FBV5tF9O1e
         65r9hsye/krCv7gkb5M0Oj2AyVwu7ohqL2N1etw2zytzfk0dTgbufhEl/igSak3K2Nxu
         a6GgHOQMNCxOB9qEw21JEVY0nZmG0MlNjkjQ8thz9GruRsX/6XMK64yfYcPZodpH/pVb
         QF8MhhsNOcBgYdoUApvQZSqFyEf1KY3XaqA0KbWMpLOlKGS1HkgP+tm493jdm5Dsze1M
         zuTj1Df7khpTLrdg8/N+86slGjxYF+cFs4C5Ub/Td7FI0L8oVDtL7BS5R+gvpJscFNWW
         x+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCF1alsPBSG2XfKNfFcoUe5C7ySQ/Wrcwer42jVv4+o=;
        b=x2Se3r05LkZVb9XKUPGfdSSs2tezAp64j+Ri+zGtNS+PHnWh0ko0AgyZ8wZD+2Uky2
         F3aUMSbdwL2BVREZlfmVv9kZSLQMS92sUJnifMqpMWZCCtbOfsTebG0pqtqT5a1+y9GB
         0Nv7iREjNg4GHRryQi6ori7//lj17aFeJQzXP9XISlaBVsYmxDa2PeAZ7vGAEOjkUc/N
         bUpNQALpApwZdAIWtPg2sAB0LjmR0OW7L1uYHFd8uKiwzobrGgmzmIiRD26ELDhC5iL5
         AKCxa6Ad06Dnn+A4nS+zQW8UADb2x6hn1Ac4HsjTriY5DS7mtVwrX9oV1otO/U+pvu9V
         rjyA==
X-Gm-Message-State: AFqh2kq/FL8PRm85UKl7Ltl61yegws4jEvGeThFSRuusPkVvBCE2X942
        giPYlvszBWB9KLogGD1/lFE=
X-Google-Smtp-Source: AMrXdXuXW+UInCw3WtLNlPCe1qs9ALa7OcOWFF940g71JJw1EKe1nNEBpsfXKQMq2DBwC+EUc6bbtw==
X-Received: by 2002:a17:902:f80c:b0:189:340c:20c4 with SMTP id ix12-20020a170902f80c00b00189340c20c4mr67086830plb.66.1673265164194;
        Mon, 09 Jan 2023 03:52:44 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id c21-20020a63ef55000000b00478bd458bdfsm5003950pgk.88.2023.01.09.03.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:52:43 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:22:40 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot
 reads/writes
Message-ID: <20230109115240.kb3opxak5qi4bxd6@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-4-memxor@gmail.com>
 <20230105030607.hnaxgzejx4uwpby5@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105030607.hnaxgzejx4uwpby5@macbook-pro-6.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 08:36:07AM IST, Alexei Starovoitov wrote:
> On Sun, Jan 01, 2023 at 02:03:57PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Currently, while reads are disallowed for dynptr stack slots, writes are
> > not. Reads don't work from both direct access and helpers, while writes
> > do work in both cases, but have the effect of overwriting the slot_type.
>
> Unrelated to this patch set, but disallowing reads from dynptr slots
> seems like unnecessary restriction.
> We allow reads from spilled slots and conceptually dynptr slots should
> fall in is_spilled_reg() category in check_stack_read_*().
>
> We already can do:
> d = bpf_rdonly_cast(dynptr, bpf_core_type_id_kernel(struct bpf_dynptr_kern))
> d->size;

Not sure this cast is required, it can just be reads from the stack and clang
will generate CO-RE relocatable accesses when casted to the right struct with
preserve_access_index attribute set? Or did I miss something?

> and there is really no need to add bpf_dynptr* accessors either as helpers or as kfuncs.
> All accessors can simply be 'static inline' pure bpf functions in bpf_helpers.h.
> Automatic inlining and zero kernel side maintenance.

Yeah, it could be made to work (perhaps even portably using CO-RE and
relocatable enum values which check for set bits etc.). But in the end how do
you define such an interface, will it be UAPI like xdp_md or __sk_buff, or
unstable like kfunc, or just best-effort stable as long as user is making use of
CO-RE relocs?

>
> With verifier allowing reads into dynptr we can also enable bpf_cast_to_kern_ctx()
> to convert struct bpf_dynptr to struct bpf_dynptr_kern and enable
> even faster reads.

I think rdonly_cast is unnecessary, just enabling reads into stack will be
enough to enable this.
