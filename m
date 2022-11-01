Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68300614FE9
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKARCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 13:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKARCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 13:02:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289A260D
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 10:02:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 192so14018777pfx.5
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jE7AvJG+Pz67X1gNkDD5t0oKXb/RV/Yt8yibr4qw2hM=;
        b=X/gV7zp6dIxPh1lTFK7XJ1Lzpq/BU9+/KVrCvofn1ZEe/klpVutZ0tyFNEqWnHK+tY
         djh1iYMcH01+Smh7fhNrKsh315ifrlU7gHoZ6kjKTsMX9a0o5hYJW5pF4EDXqmJ4VfVP
         v94BSqS5Z6rlDc3T715VlRhA7zcP2usCNyuUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE7AvJG+Pz67X1gNkDD5t0oKXb/RV/Yt8yibr4qw2hM=;
        b=Vg1eX2x7cMvA8kMvAAiwn+9RKgpRgEseClcGIDoItucPXja+4Y1BodymegTAEBo3te
         hE0EGhvfbwtG7SpE2jEDquKlDmc9P0VFIUGAdStY/2yBky6bv+fKKuqM9fHfvGZGEG2X
         8SxyBsdqvSB4TiHOr30p8lUEBnUiC68JWLmNCavF0MPlJpg2HfvVXHshZ9TBmsOuiB1c
         UXIcudsl58XTvttt8lnuopPwnH9U6Vc0u/+gkh1epIrFzs7DXWOPSszwxHWb1kSPXvyh
         j2PGwXRi8+5Ziw6uzHWw7bu1T/F9i+FwDE5Rxb7LH1auh96j3GBss4LWoeWF132jF+SI
         RoFQ==
X-Gm-Message-State: ACrzQf3K9dFCqjrMdaDQmQmb9wGdYM4o7q/IuJHaGZw00bobZj9+7icU
        OG5ulK2gRUEFudzzKFBOV/Tk9A==
X-Google-Smtp-Source: AMsMyM5i16ttcVnnTVedidHBJ9bNsg59Epj19woNCj4kXnyFV8ovuhhEUMMKJaZDZxaCdd+pCO2HVw==
X-Received: by 2002:a63:551b:0:b0:44b:7dcf:92ee with SMTP id j27-20020a63551b000000b0044b7dcf92eemr18373150pgb.610.1667322120754;
        Tue, 01 Nov 2022 10:02:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0016eef326febsm1597080pln.1.2022.11.01.10.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:02:00 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:01:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf/verifier: Use kmalloc_size_roundup()
 to match ksize() usage
Message-ID: <202211010937.4631CB1B0E@keescook>
References: <20221029024444.gonna.633-kees@kernel.org>
 <20221029025433.2533810-2-keescook@chromium.org>
 <da0959e7-a91c-ab4c-56be-3c3cd280e592@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0959e7-a91c-ab4c-56be-3c3cd280e592@iogearbox.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 01, 2022 at 02:52:16PM +0100, Daniel Borkmann wrote:
> On 10/29/22 4:54 AM, Kees Cook wrote:
> > Round up allocations with kmalloc_size_roundup() so that the verifier's
> > use of ksize() is always accurate and no special handling of the memory
> > is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> > information back up to callers so they can use the space immediately,
> > so array resizing to happen less frequently as well.
> > 
> [...]
> 
> The commit message is a bit cryptic here without further context. Is this
> a bug fix or improvement? I read the latter, but it would be good to have

It's an improvement -- e.g. it depends on the recently added
kmalloc_size_roundup() helper.

> more context here for reviewers (maybe Link tag pointing to some discussion
> or the like). Also, why is the kmalloc_size_roundup() not hidden for kmalloc
> callers, isn't this a tree-wide issue?

The main issue is that _most_ allocation callers want an explicitly sized
allocation (and not "more"), and that dynamic runtime analysis tools
(e.g. KASAN, UBSAN_BOUNDS, FORTIFY_SOURCE, etc) are looking for precise
bounds checking (i.e. not something that is rounded up). A tiny handful
of allocations were doing an implicit alloc/realloc loop that actually
depended on ksize(), and didn't actually always call realloc. This has
created a long series of bugs and problems over many years related to the
runtime bounds checking, so these callers are finally being adjusted to
_not_ depend on the ksize() side-effect, by doing one of several things:

- tracking the allocation size precisely and just never calling ksize()
  at all[1].

- always calling realloc and not using ksize() at all. (This solution
  ends up actually be a subset of the next solution.)

- using kmalloc_size_roundup() to explicitly round up the desired
  allocation size immediately[2].

The bpf/verifier case is this another of this latter case.

Because some of the dynamic bounds checking depends on the size being an
_argument_ to an allocator function (i.e. see the __alloc_size attribute),
the ksize() users are rare, and it could waste local variables, it
was been deemed better to explicitly separate the rounding up from the
allocation itself[3].

Hopefully that helps clarify! :)

-Kees

[1] e.g.:
    https://git.kernel.org/linus/712f210a457d
    https://git.kernel.org/linus/72c08d9f4c72

[2] e.g.:
    https://git.kernel.org/netdev/net-next/c/12d6c1d3a2ad
    https://git.kernel.org/netdev/net-next/c/ab3f7828c979
    https://git.kernel.org/netdev/net-next/c/d6dd508080a3

[3] https://lore.kernel.org/lkml/0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com/

-- 
Kees Cook
