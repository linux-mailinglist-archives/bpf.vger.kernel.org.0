Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CA692048
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjBJNzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjBJNzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 08:55:46 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165191C5BC
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 05:55:45 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id rp23so16015557ejb.7
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjBVJN436c7cYcZZ30ILBonljKmQq8TDsmNtnn8Qsm8=;
        b=mgD9HufvHGlyDCfqalRuzOsmDpholhdwVK/twsGkk0ZxzPs6MIMDl2gUv+5hzhtCpg
         nq6zrDDKV7ahTzYY7ofmZy4owjGco/3J1xToMAsPVdXnIEPvZp/ezg1TYuK9JYLEa8Ds
         bkhmSBe09iOT/s6zSTjfRzqvsmSgyyYBA5PjQQiHwCZCTfVCNVNNTsP2DUHw+z/qB9Jq
         IcVXtdjXn6VSQtvYKNTZGJjkAQsHgXAUmXYsoXrdjxG5zEXHxKvqvwTrMPuYrWGw4fDK
         S2woJu33YitFPSOEGvQnJxq+wwo6FJRwIEvdOBT0IYSsc9KC3UfLBzudqm9KLH7l7blX
         fY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjBVJN436c7cYcZZ30ILBonljKmQq8TDsmNtnn8Qsm8=;
        b=4i7azfFGCys6mjpd+z9WHO+jOaao6ifMQ6kWp0veUpa1arMohuI6/Ei72h5jJI9pFD
         VXEQF56+PQ1NfV78JOTgy34kAwVhsTkJFSWavkvNXkIANBVZqgj1DH9MiU0r4juytIJz
         ZgVeXTY+ApB0jg8vWDd7fjp8H5zjzOQqWOfN7vSLRQeZJBu+UCLUixrr8spYQJIexXlt
         akGFcXlF4fwqXz3al8sc5R/6SmQHPJTvHnJmRWhaGfRSBoirwagDsggm4N9oV3/AuaKw
         C7k2hUEtQrBWcIfE04U8RnN+2KrPc1QHCbUbwqA7t3UnY7XUjKkuqWV3cJgG+Z35Xf9t
         RJJg==
X-Gm-Message-State: AO0yUKVf/oNi961UfJY4LKBevHfew8DaD0dE4NjDeTuRwRaqyDn0MqTn
        zvRKS2U4NR/x71AjLJDrBhc=
X-Google-Smtp-Source: AK7set+p9lYg8EBxzZhBH3xmkEeJ9IWGThGhPVom7SfLXiqeSXIfZroi9+fnszqawZdY/1p4yC2dSw==
X-Received: by 2002:a17:906:4c8a:b0:87b:d60a:fcbb with SMTP id q10-20020a1709064c8a00b0087bd60afcbbmr14777117eju.47.1676037343534;
        Fri, 10 Feb 2023 05:55:43 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:ed0])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b008a5cbd8f7d1sm2396966ejb.127.2023.02.10.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:55:43 -0800 (PST)
Date:   Fri, 10 Feb 2023 14:55:41 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210135541.xtwn6wzng7mspgrm@apollo>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209174144.3280955-9-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 06:41:41PM CET, Dave Marchevsky wrote:
> Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> that require handling in the verifier:
>
>   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
>     the bpf_rb_node field, with the offset set to that field's offset,
>     instead of a struct bpf_rb_node *
>     * mark_reg_graph_node helper added in previous patch generalizes
>       this logic, use it
>
>   * bpf_rbtree_remove's node input is a node that's been inserted
>     in the tree - a non-owning reference.
>
>   * bpf_rbtree_remove must invalidate non-owning references in order to
>     avoid aliasing issue. Use previously-added
>     invalidate_non_owning_refs helper to mark this function as a
>     non-owning ref invalidation point.
>
>   * Unlike other functions, which convert one of their input arg regs to
>     non-owning reference, bpf_rbtree_first takes no arguments and just
>     returns a non-owning reference (possibly null)
>     * For now verifier logic for this is special-cased instead of
>       adding new kfunc flag.
>
> This patch, along with the previous one, complete special verifier
> handling for all rbtree API functions added in this series.
>

I think there are two issues with the current approach. The fundamental
assumption with non-owning references is that it is part of the collection. So
bpf_rbtree_{add,first}, bpf_list_push_{front,back} will create them, as no node
is being removed from collection. Marking bpf_rbtree_remove (and in the future
bpf_list_del) as invalidation points is also right, since once a node has been
removed it is going to be unclear whether existing non-owning references have
the same value, and thus the property of 'part of the collection' will be
broken.

The first issue relates to usability. If I have non-owning references to nodes
inserted into both a list and an rbtree, bpf_rbtree_remove should only
invalidate the ones that are part of the particular rbtree. It should have no
effect on others. Likewise for the bpf_list_del operation in the future.
Therefore, we need to track the collection identity associated with each
non-owning reference, then only invalidate non-owning references associated with
the same collection.

The case of bpf_spin_unlock is different, which should invalidate all non-owning
references.

The second issue is more serious. By not tracking the collection identity, we
will currently allow a non-owning reference for an object inserted into a list
to be passed to bpf_rbtree_remove, because the verifier cannot discern between
'inserted into rbtree' vs 'inserted into list'. For it, both are currently
equivalent in the verifier state. An object is allowed to have both
bpf_list_node and bpf_rb_node, but it can only be part of one collection at a
time (because of no shared ownership).

	struct obj {
		bpf_list_node ln;
		bpf_rb_node rn;
	};

	bpf_list_push_front(head, &obj->ln); // node is non-own-ref
	bpf_rbtree_remove(&obj->rn); // should not work, but does

So some notion of a collection identity needs to be constructed, the amount of
data which needs to be remembered in each non-owning reference's register state
depends on our requirements.

The first sanity check is that bpf_rbtree_remove only removes something in an
rbtree, so probably an enum member indicating whether collection is a list or
rbtree. To ensure proper scoped invalidation, we will unfortunately need more
than just the reg->id of the reg holding the graph root, since map values of
different maps may have same id (0). Hence, we need id and ptr similar to the
active lock case for proper matching. Even this won't be enough, as there can be
multiple list or rbtree roots in a particular memory region, therefore the
offset also needs to be part of the collection identity.

So it seems it will amount to:

	struct bpf_collection_id {
		enum bpf_collection_type type;
		void *ptr;
		int id;
		int off;
	};

There might be ways to optimize the memory footprint of this struct, but I'm
just trying to state why we'll need to include all four, so we don't miss out on
a corner case again.

> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> [...]
