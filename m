Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E224DAE7
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHUQaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgHUQaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 12:30:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5FC061574
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 09:30:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b11so1198262lfe.10
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAH7ibPtLUGHLgcgcRzPKVl9zfbTpcY+nZCs+tE1DXQ=;
        b=fLVWWjpFR/WJTNqtQxTkV/hZGhHLV3nkUFUVQsbouXfBQqoZPlM46XTSIQHJ1UzmoQ
         r85FEGnbcYL0mmeXoZ/zAKKyKQo9Shfz4Q0SHa6+J7tcigLBGCZZGnePAbOnEUR3f3C8
         iFCi574147qFY14i66t3Mfgc1pOmjJqr/+lKoDaLZ2u8Jwm0JNqri9rivqcneitSe6kF
         x3ZObTV5enH329D39sd2GQmaB4IOpeXJUzSOSilIDZCaBcuchI1qb7HWBqwvlSzT6NBg
         eAXDjFY8Y5Sk2t/CwUy4TiS0nVU/dwMwRWqtKKnl7zVqEhQhe1HU2XAaNMDNeJSeqJjG
         ntFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAH7ibPtLUGHLgcgcRzPKVl9zfbTpcY+nZCs+tE1DXQ=;
        b=KOhTTlM6PZi3KreFBaNaGqVP/yZy/IDfXrF2q4KTZnw94UjJL8PU5XJvWSMdR3CR9p
         HcCGByDwShn5BWGMLPmi7fuo5ZT82WPqqrDAqUzZ3NymCV1pnxLfQq06v5WbIzHh/2Sm
         olazHb+XTlUZdJosQQlElnNSVQwzalVl/KI1A01K7l5M0WeiymTsziH5fiFh+SXpMyJl
         AzUPiEmh+lgayTDgwqIo1kOR5tCc+nE9s6ET3hBcHFc8kGg8rhTjSJyWwfoeyoLlJ8Zl
         zfXaFYPrfDUWVMYO+/LMnZNLQFTGIRRmBHdBmJy9RnLRwbhAXs9ajQn/ijJawO3UAd+e
         FPRg==
X-Gm-Message-State: AOAM530xG+y/xrSMJm/y15nfdm6qW0tDjJ7fKUgTnhp6HIedKc9fTsgG
        9JbnkfhBwAGdXRsVApKSNk9OV3XXAuhDkLkvrDizZvwFFvDrKw==
X-Google-Smtp-Source: ABdhPJzYZYfgiTKQBUgvG4C88m6hlJq6g86K/IInaK/YVQrHcxL/vh0WRwMJ1TYegOTt9ep2KYX5shcv+jP3Gbwg5eo=
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr1830261lfo.124.1598027404830;
 Fri, 21 Aug 2020 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-2-guro@fb.com>
In-Reply-To: <20200821150134.2581465-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Aug 2020 09:29:53 -0700
Message-ID: <CALvZod4ou=jrGru6gp658zbkS+G-_eYNA44CwxNk4=Bs1pXxLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/30] mm: support nesting memalloc_use_memcg()
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:01 AM Roman Gushchin <guro@fb.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> Support nesting of memalloc_use_memcg() to be able to use
> from an interrupt context.
>
> Make memalloc_use_memcg() return the old memcg and convert existing
> users to a stacking model. Delete the unused memalloc_unuse_memcg().
>
> Roman: I've rephrased the original commit log, because it was
> focused on the accounting problem related to loop devices. I made
> it less specific, so it can work for bpf too. Also rebased to the
> current state of the mm tree.
>
> The original patch can be found here:
> https://lkml.org/lkml/2020/5/28/806
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
