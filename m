Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B6619243
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDH41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDH40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:56:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590A175B4
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:56:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e129so3735313pgc.9
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwQZmbBcngQQ+2e4kwJZm5MYVpMy2oOO0D5VjNja9IM=;
        b=I0rjbWHWpzVjKvBTyAnZ4n+8aSx692+ZpIX9ao9bt62ITC1GPAJZo4dVUzMc+LHpbA
         FkuGMt0IjkQ+i3o17ZvKHxOINhHeROhKp0z3fDh1csBoUkQUZQMxDLbtGRy/tytFsGRK
         sAADIqQE1GpbmsLq8rep/+BPz9LKckdsTOox3NAvTvzIkRsUtm5aRlJDsiCpiX9B1oyi
         2xnXdF+R1XNoA12IFUXBw/OLOcu1EHv+QoM4bD4x9/kLXjdsWP9HW68iq4H39BDjCGpo
         oY+rW61r5u+BdedB8RhWMinGbJCusE7OVGm3aYGFEd8dAJa0xUtgmxAmPhvLlzy2Y01K
         yb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwQZmbBcngQQ+2e4kwJZm5MYVpMy2oOO0D5VjNja9IM=;
        b=5JsO/90vmDKWBl8U43JK/3LX/PtAPRPilSqie9daI/YYHAj5oc9yOmrNO2qP+zLIaw
         RRWuxxfPyTraTvTWxd0sZV82vaEpyvOqZNdfW7LfjONfZb9lSzY/KNMy//5pW0+2C2fI
         Dk8cxWEefjiu6MpLCATic4Zwf6uOMIJOE1+O8JUjRqE0rn1gIJo7YLE46Ot/dvVbQE2+
         vPb78KHpQOUhSb4JiSFZvkOE6LjQRCQIFtX+4fqgfs6SST3eiGFbkKKxqTyIXhfFfPys
         v0rTPoJHCPpmKGYxTfV9ZRfhr6hADKgMSDZyIYMk4OiFzHKXyppDj7KHF7QJ1FGjjnf1
         G6eQ==
X-Gm-Message-State: ACrzQf2BBFW4NbJ08N3GsxJ+4l1lsosUy6bb/zPLSy5xOT2TxwN+qo2j
        3vqglC50wipvO8ZBqlhJRxk=
X-Google-Smtp-Source: AMsMyM5X2zNndwdPE+kMoEXrCv6Cifp+/q4SgzTHsEG9cG6J2sU18GIdzAyqxC78lYQOLPzYixOS6A==
X-Received: by 2002:a65:5386:0:b0:46e:dbd3:413 with SMTP id x6-20020a655386000000b0046edbd30413mr28750646pgq.240.1667548584273;
        Fri, 04 Nov 2022 00:56:24 -0700 (PDT)
Received: from localhost ([157.51.134.255])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b00176dd41320dsm1967079pln.119.2022.11.04.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:56:23 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:26:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 14/24] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20221104075600.gdz3jydssctga6sc@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-15-memxor@gmail.com>
 <b0e329c1-730f-5ed1-633c-5823a36c5a23@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e329c1-730f-5ed1-633c-5823a36c5a23@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 08:24:22AM IST, Dave Marchevsky wrote:
> On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> > Global variables reside in maps accessible using direct_value_addr
> > callbacks, so giving each load instruction's rewrite a unique reg->id
> > disallows us from holding locks which are global.
> >
> > This is not great, so refactor the active_spin_lock into two separate
> > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > enough to allow it for global variables, map lookups, and local kptr
> > registers at the same time.
> >
> > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > lock. But the active_spin_lock_id also needs to be compared to ensure
> > whether bpf_spin_unlock is for the same register.
> >
> > Next, pseudo load instructions are not given a unique reg->id, as they
> > are doing lookup for the same map value (max_entries is never greater
> > than 1).
> >
> > Essentially, we consider that the tuple of (active_spin_lock_ptr,
> > active_spin_lock_id) will always be unique for any kind of argument to
> > bpf_spin_{lock,unlock}.
> >
> > Note that this can be extended in the future to also remember offset
> > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > in the same allocation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  3 ++-
> >  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
> >  2 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 1a32baa78ce2..bb71c59f21f6 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -323,7 +323,8 @@ struct bpf_verifier_state {
> >  	u32 branches;
> >  	u32 insn_idx;
> >  	u32 curframe;
> > -	u32 active_spin_lock;
> > +	void *active_spin_lock_ptr;
> > +	u32 active_spin_lock_id;
> >  	bool speculative;
> Back in first RFC of this series we talked about turning this "spin lock
> identity" concept into a proper struct [0]. But to save you the click:
>
> Dave:
> """
> It would be good to make this "(lock_ptr, lock_id) is identifier for lock"
> concept more concrete by grouping these fields in a struct w/ type enum + union,
> or something similar. Will make it more obvious that they should be used / set
> together.
>
> But if you'd prefer to keep it as two fields, active_spin_lock_ptr is a
> confusing name. In the future with no context as to what that field is, I'd
> assume that it holds a pointer to a spin_lock instead of a "spin lock identity
> pointer".
> """
>
> Kumar:
> """
> That's a good point.
>
> I'm thinking
> struct active_lock {
>   void *id_ptr;
>   u32 offset;
>   u32 reg_id;
> };
> How does that look?
> """
>
> I didn't get back to you, but I think that looks reasonable, and "this can be
> extended in the future to also remember offset used for locking" in this
> patch summary supports the desire to group up those fields. (I agree that
> offset isn't necessary for now, though).
>

I will make this change in v5.

However, do you have any suggestions on what we can call the id_ptr thing? In
patch 22 in the big comment above check_reg_allocation_locked I call it lock
class, but I'm not sure whether it helps or is more confusing for people.

In active_spin_lock_ptr, 'ptr' alone is confusing as you've pointed out before.
