Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05E43806F
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 01:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhJVXCf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhJVXCe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 19:02:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3358C061764;
        Fri, 22 Oct 2021 16:00:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l203so203359pfd.2;
        Fri, 22 Oct 2021 16:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVeb3D+tSGKrjPnkZcjhGXbXuNKnnYnp+e4vgWt4h2M=;
        b=dJS/9S5uflOW3sBIPc+Xia2ya40eWIzrAxPxWOf2eWYnAgSAb4AOqXjXdPn42jG7dl
         1FgP+M21K7n3dG7LAO2e9T3qLOE6Ht1KF29wSo5aGa75cyjyaapaTQdHfAgxcqn/inAB
         SinFbFPdJH/tvPwyblI7Aym+08AIKqroiBEB6oqBU5tkBxXRUm0UtPOam7nAcMHEmJUv
         5JCBiynVfI8LxQnEaaQiqjxEKiK9fXhB9FvDERkxALCPQZ3Gg8TmSmK/winnXGnZ0q33
         tKRxHqfE2tZU7GvEvHd4VccZEB2rSVASzN4puy3gqlT6IjbwKuI7TYJtvE1HdWKNdQDD
         pxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rVeb3D+tSGKrjPnkZcjhGXbXuNKnnYnp+e4vgWt4h2M=;
        b=jkCvWgViEUzOlIyYneErT8tqfVUG0R1Q0Ct0AAyOYjbuSrQcF8fLmI3Yc5+pkXj+tO
         0zJiha55jaw1u1UnnNBrGaehVuwutzDER3uN688VUf2VfX27qE+qfChtedT1QfXsMpOr
         c9LyRuq2wSXqbTZGlVtDtH4iBeq/SWatODBx5uw7P9eOrvOy5J5H25lujEU6urxtKm4I
         GQOJJVGrhWTmPgX2+EIMe3zRi/ferKHkvfGa9DXyzMbZdQI0vEA14zb/mnBfks1s529q
         0e8yLKJORudWjW7NwJkoDtCu689Hk7UnftujqLWWEtK6l0ygMhy43SbBD9Z8T3/r/Upm
         EThQ==
X-Gm-Message-State: AOAM533TZFjTrFLPmvmPjQ1xilOanmcuPxJp1Iei6+SzKcKNIvqzscee
        HVL7Oc0L0KrBiZvF7aTLbPs=
X-Google-Smtp-Source: ABdhPJxSWFqWF2w2ZtWJBNcVJhl25Lqjy9w320ZKAduyMew0sXIGfA/TfuvWyrtes6ZfX+s9MAdoeQ==
X-Received: by 2002:a05:6a00:856:b0:44c:f184:9320 with SMTP id q22-20020a056a00085600b0044cf1849320mr2651202pfk.81.1634943615929;
        Fri, 22 Oct 2021 16:00:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a21sm10273011pju.57.2021.10.22.16.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 16:00:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Oct 2021 13:00:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 3/3] bpf: Implement prealloc for task_local_storage
Message-ID: <YXNCfQvOLlT8yXkH@slm.duckdns.org>
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
 <YXB5hWFCzJDISnrK@slm.duckdns.org>
 <20211022224733.woyxljoudm3th7vq@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022224733.woyxljoudm3th7vq@kafai-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Fri, Oct 22, 2021 at 03:47:33PM -0700, Martin KaFai Lau wrote:
...
> > +	for_each_process_thread(g, p) {
> I am thinking if this loop can be done in bpf iter.
> 
> If the bpf_local_storage_map is sleepable safe (not yet done but there is
> an earlier attempt [0]),  bpf_local_storage_update() should be able to
> alloc without GFP_ATOMIC by sleepable bpf prog and this potentially
> will be useful in general for other sleepable use cases.
> 
> For example, if a sleepable bpf iter prog can run in this loop (or the existing
> bpf task iter loop is as good?), the iter bpf prog can call
> bpf_task_storage_get(BPF_SK_STORAGE_GET_F_CREATE) on a sleepable
> bpf_local_storage_map.

Yeah, whatever that can walk all the existing tasks should do, and I think
the locked section can be shrunk too.

        percpu_down_write(&threadgroup_rwsem);
        list_add_tail(&smap->prealloc_node, &prealloc_smaps);
        percpu_up_write(&threadgroup_rwsem);

        // Here, it's guaranteed that all new tasks are guaranteed to
        // prealloc on fork.

        Iterate all tasks in whatever way and allocate if necessary;

Thanks.

-- 
tejun
