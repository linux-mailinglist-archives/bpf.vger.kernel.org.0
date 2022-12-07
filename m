Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E976461CB
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiLGTgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGTgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:36:21 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA04385D
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:36:19 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n3so14110692pfq.10
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4v6qElYRZtUMUTE8tCfEKuV0mY/hjaZ50svJEvmjSpM=;
        b=HQps1tverOtzcBA6yF89n91j3OZ8T6Jga9aay6F+t3ofvgEqIgn3LIQvFLUEcoKRw3
         ZL6tCr8ucteYqkythG5p/DW8qdKXCbVIybCSENhCYmhqM6+9ZLnG/jA1thZUjQ/QOxSn
         4xMQCDdOxtutAJF/Cm0rH2AXnGEAhNQQIHmgbJWpla9EmL7FwAqN5k35MhYB9QyL3KTz
         ATUMEfJny5HLFRIqk0m94DLrGBM9J2oESsve2QoU+gptiT5wIiYqkAaLR0MYMrGUiTOf
         BuxAj2E5B5sRby2JScw9qETFV62J2mbOCBAoJZ9EjrBlMrWBo8Afgf30JUmQnMBqyms0
         IF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v6qElYRZtUMUTE8tCfEKuV0mY/hjaZ50svJEvmjSpM=;
        b=256tspqDmqPiEyxsPus2qvK6h81gBmyz5pzZLJvSIb1toaMRGavjDFDN1ORt/6r/42
         haYFga8eIKtLYgZStLDqr69HdTtcKBjyFE4OCC/otC0Hp/uQ6H178WA6VoNusDoUKVVC
         uWy2oFDEc5f76P8TpxQqQz1qjGOSBT5xUEZqSAWYGX6ZEIi10zzDPwYlCygzL0VozqTG
         pdJPeY1s7mdNwZK3EQv1VKcg+tcvgPnBIozD8GOTJGlm8ntKplXm5/m6o58iOYxBOhQA
         svxlp8cjDHEiiGVixtqmchJzW+scVMSrWxOz1xDR/Bu6KW9CPm7zmo9kyVDGX/RHcZaq
         rQag==
X-Gm-Message-State: ANoB5pk0yM5c3Lm+mFgTSMnYHAddNf7PStXRttbErmBJ50ipbcFP1IAv
        G7WJn1I4MD7wWuMCKNQVnXbPUlQb4oEIufHc
X-Google-Smtp-Source: AA0mqf6KrK43nXb1cRYbd/0oQbdPE9qaKf9EcNNE6T+5swyAyCCz2j5Ff0TCU38VjcYwUQtN/KYs9g==
X-Received: by 2002:a63:d742:0:b0:478:bc19:a511 with SMTP id w2-20020a63d742000000b00478bc19a511mr13731531pgi.380.1670441779330;
        Wed, 07 Dec 2022 11:36:19 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00189e1522982sm5665473ple.168.2022.12.07.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:36:19 -0800 (PST)
Date:   Thu, 8 Dec 2022 01:06:16 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221207193616.y7n4lmufztjsq6tr@apollo>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 04:39:47AM IST, Dave Marchevsky wrote:
> This series adds a rbtree datastructure following the "next-gen
> datastructure" precedent set by recently-added linked-list [0]. This is
> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
> instead of adding a new map type. This series adds a smaller set of API
> functions than that RFC - just the minimum needed to support current
> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
>
>   bpf_rbtree_add
>   bpf_rbtree_remove
>   bpf_rbtree_first
>
> [...]
>
> Future work:
>   Enabling writes to release_on_unlock refs should be done before the
>   functionality of BPF rbtree can truly be considered complete.
>   Implementing this proved more complex than expected so it's been
>   pushed off to a future patch.
>

TBH, I think we need to revisit whether there's a strong need for this. I would
even argue that we should simply make the release semantics of rbtree_add,
list_push helpers stronger and remove release_on_unlock logic entirely,
releasing the node immediately. I don't see why it is so critical to have read,
and more importantly, write access to nodes after losing their ownership. And
that too is only available until the lock is unlocked.

I think this relaxed release logic and write support is the wrong direction to
take, as it has a direct bearing on what can be done with a node inside the
critical section. There's already the problem with not being able to do
bpf_obj_drop easily inside the critical section with this. That might be useful
for draining operations while holding the lock.

Semantically in other languages, once you move an object, accessing it is
usually a bug, and in most of the cases it is sufficient to prepare it before
insertion. We are certainly in the same territory here with these APIs.

Can you elaborate on actual use cases where immediate release or not having
write support makes it hard or impossible to support a certain use case, so that
it is easier to understand the requirements and design things accordingly?
