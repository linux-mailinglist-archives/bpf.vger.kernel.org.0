Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DB6EB494
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDUWRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjDUWRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 18:17:52 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D70103
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 15:17:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so3155114a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682115469; x=1684707469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6P6TFC0CklVpHKCZQA5K8w6hBhVznuAy9jhUE/lxHpg=;
        b=r9uYOXlAuqBulVVzVTgCp7oGWYmE5FT6dCSlFY71CbmtsEPjxbfEgQ+ZKz1sHER0YH
         FgVH7fhwCYsI9U9N35PBs3q0kMjTMvM40+50R0gMAmsK39nM2CPkyShvw3hFaNDoEksC
         j0/EynThyr16orBW1Agtj5BrrZcT2GriJQzmHdoqtISnQtbrQsBswSCx1xQxE26lVDrZ
         9bbnKuE/TTMNqk0O87gGdn7wWA06ntllJVhWaW0vGFrJtejoJQK/WPsU7Q7zO1/fAaoM
         Nc00EdMcUTEVRWyfhzhSXqozFRNVTDt/YhKIFfOUy+5B5CeHehotWeBHDsEWNN0DTra2
         pKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115469; x=1684707469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P6TFC0CklVpHKCZQA5K8w6hBhVznuAy9jhUE/lxHpg=;
        b=LsCyMRVnACuNMMEByuUZVIbwgxMe1r2J+CFCPPbsfiD1pOTDzSvxlfldwCniualfDs
         lz8RBZ7BhloVYesq9PFFIaeb4bphbuyGR67orsIjqkVP9JF/6RxwQuxQYYk1b5zli+Bn
         wVPZyGLDkQI2MJXiof9aaeDdiL2DawlhafczTXLNLUgYkCciqk9wVlJEb4gAZpNYMndw
         Wl6djQn+glJzMnGyEgiqU07e/q1psYpfrAKwRktXEB6HqS1FfvusEeqp7Fz9NzQkuVaj
         x/0iXy51l3eJjg5FjUM2DFHhdsECoZ/TM2tRtmERWcWdMlnpp34LXSvywFOiViB36udH
         R/Jg==
X-Gm-Message-State: AAQBX9cZQuUjcYYfiYMIy2MMp4l2ZhJHATtaUDahkLaLZzUy9dVX+x8r
        Q31gbmGtl/JAMLYGb5Sj0wE=
X-Google-Smtp-Source: AKy350YsbfE6hNFzM/UVCneWt/XKQWzMHEtmd4zn2ktF/lGVj2FtcQZnVvkf/nKU6EC3RlFIxSqqZg==
X-Received: by 2002:aa7:db85:0:b0:506:87e9:d4b2 with SMTP id u5-20020aa7db85000000b0050687e9d4b2mr5689175edt.2.1682115469509;
        Fri, 21 Apr 2023 15:17:49 -0700 (PDT)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7cf8f000000b005067d6b06efsm2233657edx.17.2023.04.21.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:17:49 -0700 (PDT)
Date:   Sat, 22 Apr 2023 00:17:47 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Message-ID: <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-10-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415201811.343116-10-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 10:18:11PM CEST, Dave Marchevsky wrote:
> Test refcounted local kptr functionality added in previous patches in
> the series.
>
> Usecases which pass verification:
>
> * Add refcounted local kptr to both tree and list. Then, read and -
>   possibly, depending on test variant - delete from tree, then list.
>   * Also test doing read-and-maybe-delete in opposite order
> * Stash a refcounted local kptr in a map_value, then add it to a
>   rbtree. Read from both, possibly deleting after tree read.
> * Add refcounted local kptr to both tree and list. Then, try reading and
>   deleting twice from one of the collections.
> * bpf_refcount_acquire of just-added non-owning ref should work, as
>   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
>
> Usecases which fail verification:
>
> * The simple successful bpf_refcount_acquire cases from above should
>   both fail to verify if the newly-acquired owning ref is not dropped
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> [...]
> +SEC("?tc")
> +__failure __msg("Unreleased reference id=3 alloc_insn=21")
> +long rbtree_refcounted_node_ref_escapes(void *ctx)
> +{
> +	struct node_acquire *n, *m;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return 1;
> +
> +	bpf_spin_lock(&glock);
> +	bpf_rbtree_add(&groot, &n->node, less);
> +	/* m becomes an owning ref but is never drop'd or added to a tree */
> +	m = bpf_refcount_acquire(n);

I am analyzing the set (and I'll reply in detail to the cover letter), but this
stood out.

Isn't this going to be problematic if n has refcount == 1 and is dropped
internally by bpf_rbtree_add? Are we sure this can never occur? It took me some
time, but the following schedule seems problematic.

CPU 0					CPU 1
n = bpf_obj_new
lock(lock1)
bpf_rbtree_add(rbtree1, n)
m = bpf_rbtree_acquire(n)
unlock(lock1)

kptr_xchg(map, m) // move to map
// at this point, refcount = 2
					m = kptr_xchg(map, NULL)
					lock(lock2)
lock(lock1)				bpf_rbtree_add(rbtree2, m)
p = bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) // A
bpf_rbtree_remove(rbtree1, p)
unlock(lock1)
bpf_obj_drop(p) // B
					bpf_refcount_acquire(m) // use-after-free
					...

B will decrement refcount from 1 to 0, after which bpf_refcount_acquire is
basically performing a use-after-free (when fortunate, one will get a
WARN_ON_ONCE splat for 0 to 1, otherwise, a silent refcount raise for some
different object).
