Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E421431CFC5
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBPSAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBPSAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 13:00:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA0C061574
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 10:00:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q10so13354715edt.7
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VKwvcmRV5QIHqauRrAEAb/Sz46oJ+S2J/UjChJFZd+I=;
        b=qkjB1vW+QdTdy4UakxQ8+xmnw7cmkCQ7jyc0SE3nDqMv0vFuoRcixDyHo4JldnLry3
         8FrA58/Vzlcql0fuLuDR2fkKqgjU3nHAraz2gWU29P4rhw/3r9JcqI2smSDwXhT3QLve
         D7X298535YeD96aQdUNINuA6hkJrrfF0gJ+Ntfa8+vdPQDeZ7vFl2brxg8FLoRVQey/+
         3GU72GvIJaAzXWMxFMv6RE/pRwdNRzS6KOQbBbQQNkGZWbRcEULCH+EmwSkbk8Y3osjy
         zyMhV8Q9lnMC9dzDbUyWgzfu22wtQtKcUXq8fub1MiKfxgNF0NDfOHc6v+rRMMNGwlZ7
         8Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VKwvcmRV5QIHqauRrAEAb/Sz46oJ+S2J/UjChJFZd+I=;
        b=hAl3ihR5T4hvT1qcyXT1LkgEr+UZLLQv4XLuQ/NK53X9Yn6tcbCXVDKhnI4xDZd/7S
         fcsicX86qMOBII18QcVDZS9OBDYGxJRw31jMlOO+fYFNLnyC0xJ5Yn4zeYSvIoFmsXQs
         2Vy5Mc8lQ7i9Q1rGh2OJXtJL9hkewiMmgoMnkhFp8W86FYYV5H6BE1zqayFTsdeh+0CJ
         QeNv3Emhd1YFb9Sn95L/YvXXoByzNJ0nYEtZkGznrWCz8J64OrW2IUnAfW9PhF6ZBCnm
         mBalJlAk7gMfcRJEgoX9kkDREHuJci0H259sG/7mZ2qG4nIbIkEAgZqQIarVHKO6+Rdt
         gsCA==
X-Gm-Message-State: AOAM533Y/VJGsenE/Dn8IDVJC8cVpuq70pxw3gS/sV8RpVKkpbXLJfaG
        ZYHRwbSLlNLPqESVVxcP9rPGUQ==
X-Google-Smtp-Source: ABdhPJzlKareMpoPJrcoE5eCVFuy3xhgQMaoNFKGM9uGJs3NxGtUnvq8V7MvDhEfK7Oa1kj/LlXFyA==
X-Received: by 2002:a50:f1c9:: with SMTP id y9mr10737956edl.213.1613498408521;
        Tue, 16 Feb 2021 10:00:08 -0800 (PST)
Received: from gmail.com (93-136-108-248.adsl.net.t-com.hr. [93.136.108.248])
        by smtp.gmail.com with ESMTPSA id bm2sm14107012ejb.87.2021.02.16.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 10:00:08 -0800 (PST)
Date:   Tue, 16 Feb 2021 19:00:16 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Subject: Re: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YCwIMN3btcpQbIxZ@gmail.com>
References: <YBGe5WFzSc3Z8Oh5@gmail.com>
 <CAEf4Bzab4fZm04xR+3DYEHNaxAoaNM+hZFdYWGJ_qk1fNyAitQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzab4fZm04xR+3DYEHNaxAoaNM+hZFdYWGJ_qk1fNyAitQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 08, 2021 at 09:44:59PM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 27, 2021 at 9:15 AM Denis Salopek <denis.salopek@sartura.hr> wrote:
> >
> > Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> > hashtab maps, in addition to stacks and queues.
> > Create a new hashtab bpf_map_ops function that does lookup and deletion
> > of the element under the same bucket lock and add the created map_ops to
> > bpf.h.
> > Add the appropriate test case to 'maps' selftests.
> >
> > Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> 
> I think this patch somehow got lost, even though it seems like a good
> addition. I'd recommend rebasing and re-submitting to let people take
> a fresh look at this.
> 
> It would also be nice to have a test_progs test added, not just
> test_maps. I'd also look at supporting lookup_and_delete for other
> kinds of hash maps (LRU, per-CPU), so that the support is more
> complete. Thanks!
> 

Hi Andrii,

I'll also implement the LRU and per-CPU ones and resubmit. I don't quite
understand the test_progs, what kind of test(s) exactly should I add there?

Denis

> >  include/linux/bpf.h                     |  1 +
> >  kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
> >  kernel/bpf/syscall.c                    |  9 ++++++
> >  tools/testing/selftests/bpf/test_maps.c |  7 +++++
> >  4 files changed, 55 insertions(+)
> >
> 
> [...]
