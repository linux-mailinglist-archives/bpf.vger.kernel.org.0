Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D8397CF6
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 01:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhFAXVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhFAXVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 19:21:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4FBC061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 16:19:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C78432CD;
        Tue,  1 Jun 2021 23:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C78432CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622589592; bh=8KhMPtJWIEmZMx9mXaLd5iSGuhXCcfH7VWiAH9vlXC4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DEWZ6XVY6h8HSdTvGUoCiK+Wxsi5iriCzit4KHd52/wQFnFIHA+XDgfmTbg0L6Qoy
         RCnbdhP9b9Lv/sQQra1mh4pA1W3umHJE+Mgg/N1bjD1waAPELTQ5rq21ABOCbmzrf0
         4Rvy3MtlDEhKym+uwWYoCK3mqB/9e70w3a4Zb/lTLEv/7NTQkuONBmwy8L1WgPSEm/
         X+DmrgjKMNzB/8ldMRtvaXDNeYad259xzmvZXyoE2W2j7czmVg09rmFmpO3tdVHGPf
         EuqQ1hIJ2bwC5hhhreB8A7fuVLwzCiLNxq3weylVj6kSJm50CjqmSjUKVjjwWLefZs
         vW5D0bCNia3qQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
In-Reply-To: <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net>
 <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net>
 <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
 <87wnrd9zp8.fsf@meer.lwn.net>
 <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
Date:   Tue, 01 Jun 2021 17:19:52 -0600
Message-ID: <875yyx895z.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Grant Seltzer Richman <grantseltzer@gmail.com> writes:

> Andrii cuts releases of libbpf using the github mirror at
> github.com/libbpf/libbpf. There's more context in the README there,
> but most of the major distributions package libbpf from this mirror.
> Since developers that use libbpf in their applications include libbpf
> based on these github releases instead of versions of Linux (i.e. I
> use libbpf 0.4, not libbpf from linux 5.14), it's important to have
> the API documentation be labeled by the github release versions. Is
> there any mechanism in the kernel docs that would allow us to do that?
> Would it make more sense for the libbpf community to maintain their
> own documentation system/website for this purpose?

It depends on how you want that labeling to look, I guess.  One simple
thing might be to put a DOC: block into the libbpf code that holds the
version number, then use a kernel-doc directive to pull it in in the
appropriate place.  Alternatives might include adding a bit of magic to
Documentation/conf.py to fetch a "#define VERSION# out of the source
somewhere and stash the information away.

If you're wanting to replace the version code that appears at the top of
the left column in the HTML output, though, it's going to be a bit
harder.  I don't doubt we can do it, but it may require messing around
with template files and such.

Thanks,

jon
