Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32A5B1159
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIHAfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIHAfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:35:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF9F1E3D5
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:34:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y136so11318331pfb.3
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KpRjRhqPptQlWj1yGYidcRQHQ2FSDh2huCzU88AfK4g=;
        b=BFA0/ph4tCVS4V0eM2ZovkGkDCe/WzMQIIbS7u+cpKmIEHREMJxlUCbwJn4uXUOX34
         J5YO5TylAMmCuf76lfzpR2suCHmhcd3+XXbvch4pFeAMWR8WpgPGt7TNiV7F6YzUwtZe
         4GNNoMmfV6rAoLvAadXmP7piikN51k96vKezhUAoaGvXh2dl6jcdQ9/QsTdVX7O/raqr
         osqH1Jw+9E3PdmJGt+PS+gVniQW2aokKgk4uC+2f4/cODArIYTadqhnPUiH2zkz39NXS
         AgDFayhXdeJAYRsGkYZkjt4CB+lLty0h726EiQrjCf9bg1REdBt5atm7YCKO036XU3tM
         qLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KpRjRhqPptQlWj1yGYidcRQHQ2FSDh2huCzU88AfK4g=;
        b=67lG4GXLTN5ENBFh//rNcSh0k2RSshjdsqwNVmu5OVfZouM7owDHo3XJ/wZUkETE9v
         QRaEcnfUOkmr09b+C8QMB1T9w/PT+qKLfpVwpKlV7PmJ32e3wED/oqgX25YHpIcXR1kK
         6P6oBkSL9SeVBF13eW5HmFMmf3mO7awgdxMpS+uhVy9h022Hd2fbWg+YTF4kHQIxoWb5
         yNcxoZJsuGfcP8PRsZqV37lMdM7G8Tf/CGO1IP0LWFpn2ZLd4HlUtpBp6g2APmvolcbq
         vOO5X1U5UKOl1p3AGKBs9caNx/DYfKB5tTUFLgK0tXlBnVYhUQGngBPr/YLm8xvZFsCp
         rPKw==
X-Gm-Message-State: ACgBeo0bTqoE6k4zOBWj07kjYIMk1woJ0zLiwrVqqAZcjVKwrFsqnPit
        52O/xjgGWWMJoknZdb+hFu4=
X-Google-Smtp-Source: AA6agR7j4OZr8x3Izsyolrj4FTrypAnUUqXPDNzzESz5NnP0yfeeVpnI0dmiqro038534GFTt6TDFQ==
X-Received: by 2002:a05:6a00:4ac5:b0:53e:86a0:7abc with SMTP id ds5-20020a056a004ac500b0053e86a07abcmr4327930pfb.34.1662597271852;
        Wed, 07 Sep 2022 17:34:31 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:66c4])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b0053e84617fe7sm2024458pfq.106.2022.09.07.17.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:34:31 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:34:29 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object
 model
Message-ID: <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-17-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904204145.3089-17-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 04, 2022 at 10:41:29PM +0200, Kumar Kartikeya Dwivedi wrote:
> Add the concept of a memory object model to BPF verifier.
> 
> What this means is that there are now some types that are not just plain
> old data, but require explicit action when they are allocated on a
> storage, before their lifetime is considered as started and before it is
> allowed for them to escape the program. The verifier will track state of
> such fields during the various phases of the object lifetime, where it
> can be sure about certain invariants.
> 
> Some inspiration is taken from existing memory object and lifetime
> models in C and C++ which have stood the test of time. See [0], [1], [2]
> for more information, to find some similarities. In the future, the
> separation of storage and object lifetime may be made more stark by
> allowing to change effective type of storage allocated for a local kptr.
> For now, that has been left out. It is only possible when verifier
> understands when the program has exclusive access to storage, and when
> the object it is hosting is no longer accessible to other CPUs.
> 
> This can be useful to maintain size-class based freelists inside BPF
> programs and reuse storage of same size for different types. This would
> only be safe to allow if verifier can ensure that while storage lifetime
> has not ended, object lifetime for the current type has. This
> necessiates separating the two and accomodating a simple model to track
> object lifetime (composed recursively of more objects whose lifetime
> is individually tracked).
> 
> Everytime a BPF program allocates such non-trivial types, it must call a
> set of constructors on the object to fully begin its lifetime before it
> can make use of the pointer to this type. If the program does not do so,
> the verifier will complain and lead to failure in loading of the
> program.
> 
> Similarly, when ending the lifetime of such types, it is required to
> fully destruct the object using a series of destructors for each
> non-trivial member, before finally freeing the storage the object is
> making use of.
> 
> During both the construction and destruction phase, there can be only
> one program that can own and access such an object, hence their is no
> need of any explicit synchronization. The single ownership of such
> objects makes it easy for the verifier to enforce the safety around the
> beginning and end of the lifetime without resorting to dynamic checks.
> 
> When there are multiple fields needing construction or destruction, the
> program must call their constructors in ascending order of the offset of
> the field.
> 
> For example, consider the following type (support for such fields will
> be added in subsequent patches):
> 
> struct data {
> 	struct bpf_spin_lock lock;
> 	struct bpf_list_head list __contains(struct, foo, node);
> 	int data;
> };
> 
> struct data *d = bpf_kptr_alloc(...);
> if (!d) { ... }
> 
> Now, the type of d would be PTR_TO_BTF_ID | MEM_TYPE_LOCAL |
> OBJ_CONSTRUCTING, as it needs two constructor calls (for lock and head),
> before it can be considered fully initialized and alive.
> 
> Hence, we must do (in order of field offsets):
> 
> bpf_spin_lock_init(&d->lock);
> bpf_list_head_init(&d->list);

All sounds great in theory, but I think it's unnecessary complex at this point.
There is still a need to __bpf_list_head_init_zeroed as seen in later patches.
So all this verifier enforced constructors we don't need _today_.
Zero init of everything works.
It's the case for list_head, list_node, spin_lock, rb_root, rb_node.
Pretty much all new data structures will work with zero init
and all of them need async dtors.
The verifier cannot help during destruction.
dtors have to be specified declaratively in a bpf prog for new types
and as known kfuncs for list_head/node, rb_root/node.
There will be unfreed link lists in maps and the later patches handle that
without OBJ_DESTRUCTING.
So let's postpone this patch.
