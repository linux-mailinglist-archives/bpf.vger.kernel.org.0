Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29E630BDB
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKSEPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 23:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiKSEO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 23:14:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262944F18F;
        Fri, 18 Nov 2022 20:13:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z26so6687806pff.1;
        Fri, 18 Nov 2022 20:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KJvN+0p0Gw8A8+C0QSPGunSxZ6TW24ALLcT6/3nqn0=;
        b=bjxoS4AoFUeUdk/e1owgRIRzA3ovXkU8DVexFtsoEMcVQIHlWAL8BpvJJxOwdRqt4u
         U9LhFWCImLjOT0dcJp/cdHF7QCuQb1Jm/Pxz19LDROWLdwMLdhRLsg4QZDYbJnCJzL26
         CQe4idUaat9CQ8HQ5vZH04pTQAXJjwlHBmys7gY4gLMt+0L0ytXTtd5r2734YyA27aAv
         TFmld30nJk54stFD0IjBu516jA0EJ1aOUbgJPM0qVperNg3UGG7EFbfmuHhbzTTw2hTM
         9IqCIIY8WTQeFw0b9+ctNhSoTrgqiTvIiZcQnDFarKB9wjhUrhwJUxU8EPsF/WjmUFZM
         9A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KJvN+0p0Gw8A8+C0QSPGunSxZ6TW24ALLcT6/3nqn0=;
        b=Yu68A4/TL2tvUpjZRjHH1sX2uo1DD5eHzkXelTn6uzlQbbKQBx8WPXqEkDQj3EWNAa
         vzwvqTpYGKLSgdsaL/ZaHcejJ9FuITtEfuBIgDz9GRwmTJcZEM9zCDEJWkyiTPrpFfDN
         Gg9FPGdrw+xkFlvb79+g7tZV9G9IbSZkDWV1RySOItdTL3/7vy2K/Yq8NogF1oz9SSJv
         NYzPeY5lwsuAHER3v6mTI4wqn8lHoRayUSYv73EX5NEvnvJ9lbGikTDj8um8twQZhJgS
         QriYNIps90Yfgr2lRjpPtC+242Ix/181Qu8VPiRw04Og3UhecinBEGSJjlX3um6/x6kl
         LunQ==
X-Gm-Message-State: ANoB5pnyU20Dw934E+2q9RN+GJPg7LsPXwhT5qRhndSlpCqLDQQ26reu
        m9sBYwsy1ArzpUf2wTvQfKk=
X-Google-Smtp-Source: AA0mqf7tZLWZ+PuTbPRdHAQLfnsEKSRTCb/ELElrB/XM0q5vxwSybwY7fU9lkPcgO3p/VZpZsv7EEA==
X-Received: by 2002:a63:5422:0:b0:46e:be03:d9b2 with SMTP id i34-20020a635422000000b0046ebe03d9b2mr9243403pgb.406.1668831221442;
        Fri, 18 Nov 2022 20:13:41 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b00186e34524e3sm4538540pln.136.2022.11.18.20.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 20:13:40 -0800 (PST)
Date:   Fri, 18 Nov 2022 20:13:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221119041337.eejp2dfe6w5xqplo@macbook-pro-5.dhcp.thefacebook.com>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
 <Y3eamIVUVb6V47LF@maniforge.lan>
 <Y3e2sdqL1E0SKJ5/@maniforge.lan>
 <20221118184500.yshwvcrx2a34xkmc@MacBook-Pro-5.local>
 <Y3f8yqhRRBIzrDvH@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3f8yqhRRBIzrDvH@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 03:44:42PM -0600, David Vernet wrote:
> > > if it's a release arg it should always have a refcount on it.
> > > PTR_UNTRUSTED | PTR_TRUSTED would also make no sense. MEM_FIXED_SIZE
> > > though seems fine? In general, I thought it was prudent for us to take
> > > the most conservative possible approach here, which is that PTR_TRUSTED
> > > only applies when no other modifiers are present, and it applies for all
> > > obj_ptr types (other than PTR_TO_CTX which does its own thing).
> > 
> > Probably worth refining when PTR_TRUSTED is cleared.
> > For example adding PTR_UNTRUSTED should definitely clear it.
> 
> That makes sense for PTR_UNTRUSTED, what about the other type modifiers
> like PTR_MAYBE_NULL? We set and unset if a ptr is NULL throughout a
> function, so we'd have to record if it was previously trusted in order
> to properly re-OR after a NULL check.

PTR_MAYBE_NULL is another bit and I don't think it conflicts with PTR_TRUSTED.
PTR_TO_BTF_ID | PTR_TRUSTED is a valid pointer.
PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL is a valid pointer or NULL.

PTR_TO_BTF_ID | PTR_MAYBE_NULL is a legacy "valid pointer" or NULL.
That legacy pointer cannot be passed to KF_TRUSTED_ARGS kfuncs.

KF_TRUSTED_ARGS kfuncs should not accept PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL.
It's a job of the prog to do != NULL check.
Otherwise all such != NULL checks would need to move inside kfuncs which is not good.

> > MEM_ALLOC flag is probably equivalent to PTR_TRUSTED.
> > Maybe the bit:
> > regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> > should set PTR_TRUSTED as well?
> 
> We could, but that changes the meaning of PTR_TRUSTED and IMO makes it
> harder to reason about. Before it was just "the kernel passed this arg
> to the program and promises the program that it was trusted when it was
> first passed". Now it's that plus it could mean that it points to an
> allocated object from bpf_obj_new()". IMO we should keep all of these
> modifiers separate so that the presence of a modifier has a well-defined
> meaning that we can interpret in each context as needed.  In this case,
> we can make trust opt-in, so a KF_TRUSTED_ARGS BTF pointer either of the
> following:
> 
> 1. reg->ref_obj_id > 0
> 2. Either one of PTR_TRUSTED | MEM_ALLOC type modifiers are set, and no
>    others.

I don't think MEM_ALLOC conflicts with PTR_TRUSTED.
MEM_ALLOC flags means that it came from bpf_obj_new() and that's what
bpf_spin_lock and bpf_obj_drop() want to see.

Adding PTR_TRUSTED to MEM_ALLOC looks necessary to me.
It doesn't have to be done right now, but eventually feels right.

I've been thinking whether reg->ref_obj_id > 0 condition should be converted
to PTR_TRUSTED too...
On one side it will simplify the check for KF_TRUSTED_ARGS.
The only thing check_kfunc_args() would need to do is:
is_kfunc_trusted_args(meta)
&& type_flag(reg->type) & PTR_TRUSTED
&& !(type_flag(reg->type) & PTR_MAYBE_NULL)

On the other side fixing all places where we set ref_obj_id
and adding |= PTR_TRUSTED may be too cumbersome ?

Right now we're saying PTR_TO_CTX is implicitly trusted, but we can OR
PTR_TO_CTX with PTR_TRUSTED to make it explicit and truly generalize the check.

> Agreed that after the rebase this would no longer be correct. I think we
> should make it opt-in, though. PTR_TRUSTED | MEM_ALLOC is fine.
> PTR_TRUSTED | MEM_ALLOC | PTR_MAYBE_NULL would not be.

to pass into KF_TRUSTED_ARGS kfunc? Agree.
I guess we can tighten the check a bit:
is_kfunc_trusted_args(meta)
&& type_flag(reg->type) & PTR_TRUSTED
&& !(type_flag(reg->type) & ~(PTR_TRUSTED | MEM_ALLOC))

In english: the pointer should have PTR_TRUSTED flag and
no other flags other than PTR_TRUSTED and MEM_ALLOC should be set.
