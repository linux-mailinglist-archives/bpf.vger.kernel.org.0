Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6A41F775
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 00:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhJAWh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhJAWhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 18:37:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0AC061775
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 15:35:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u32so23515860ybd.9
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBakjPHb5vr1yoW0f3YrzVaSzfWFHgmYBDBTZ6xATX0=;
        b=gDTJ+5H/t4uWXT1VNSLvV6XZdNiLMKM0ap2FH9qhjpiH2V53LwIVEEzzHletm5kRHq
         SOGpsmXVbaAZWXHO9kmBiXn3rsVh9v8XpTa+BPHCikIWORbuEfmv8tnseobBixvM0IlQ
         0RgJtQwIKNDcEDmu0t2J01zPHtGGlK/+3tFll3hZMF8P2i3s63ob3Ufyga++df00WNJ8
         VaTDxPZ6jSE7ZCfX+pD2tvTih88GzM+LbB4esvcRWinuq2CN6MUeDWbU4eqF0SP+zsN4
         GnFXgf4ECJaqF9rFLn52kDBOl7j6EMgBl6cKRkwCt2zgAWfwiaCxQWQ5Q10NjuwatERh
         IFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBakjPHb5vr1yoW0f3YrzVaSzfWFHgmYBDBTZ6xATX0=;
        b=7YBojKOS8UNizrdeOtwk3i+UCQLhltBcvZ4xibECHgWYFKJxqge7Yds3EekkKXYcRl
         yv26FsDwUntWMLKqLps6dr12Al1rFWz50fI9E+uS1B8JIVq+8ezues8BwzCKjDVapUP7
         49EtVvOvZFbMwI12emf9n5qA4SuuIxGzSf9MrkQnpSi0oeHLV7j4r8L2xiflKqLuaXmp
         oz6Q5abDPui+f9+mAg6tx3tkUz+hUt+BTjj+QUm9HbVAOVHeAmqS4DWmJdvcFokp6GF4
         qM3c8hOsslx5E6ZCYVKPCRmB8El1md2jeSkNcoUde4NDvJjFM3YJjLWoTVsy3+Vr1r7S
         skYw==
X-Gm-Message-State: AOAM533uSFL6htKBef4Sg1qkvWpFSum0oyTsQo/HNVTX8XAsq0nKGIrz
        W+7eclFUfKPIuJv0/oNb9JBnyBnYCZMSB0g3Uz4=
X-Google-Smtp-Source: ABdhPJwG77R7pwu1896bsqDfvMHSbdRsUPyqmMMTPhadknNjlj8NGrOczZ0YZVm9Ozzzki1M210+QBMYqzz55Ki2TtM=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr385311ybh.267.1633127738297;
 Fri, 01 Oct 2021 15:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210930161456.3444544-1-hengqi.chen@gmail.com>
In-Reply-To: <20210930161456.3444544-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Oct 2021 15:35:27 -0700
Message-ID: <CAEf4BzZJCza+k7ssS39CEobEcVL8LpFDPK7QNkzEJu9iZ6nYoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] libbpf: Support uniform BTF-defined
 key/value specification across all BPF maps
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30, 2021 at 9:15 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Currently a bunch of (usually pretty specialized) BPF maps do not support
> specifying BTF types for they key and value. For such maps, specifying
> their definition like this:
>
>   struct {
>       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>       __type(key, int);
>       __type(value, int);
>   } my_perf_buf SEC(".maps");
>
> Would actually produce warnings about retrying BPF map creation without BTF.
> Users are forced to know such nuances and use __uint(key_size, 4) instead.
> This is non-uniform, annoying, and inconvenient.
>
> This patch set teaches libbpf to recognize those specialized maps and removes
> BTF type IDs when creating BPF map. Also, update existing BPF selftests to
> exericse this change.
>
> Hengqi Chen (2):
>   libbpf: Support uniform BTF-defined key/value specification across all
>     BPF maps
>   selftests/bpf: Use BTF-defined key/value for map definitions
>
>  tools/lib/bpf/libbpf.c                        | 24 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kfree_skb.c |  4 ++--
>  .../selftests/bpf/progs/perf_event_stackmap.c |  4 ++--
>  .../bpf/progs/sockmap_verdict_prog.c          | 12 +++++-----
>  .../selftests/bpf/progs/test_btf_map_in_map.c | 14 +++++------
>  .../selftests/bpf/progs/test_map_in_map.c     | 10 ++++----
>  .../bpf/progs/test_map_in_map_invalid.c       |  2 +-
>  .../bpf/progs/test_pe_preserve_elems.c        |  8 +++----
>  .../selftests/bpf/progs/test_perf_buffer.c    |  4 ++--
>  .../bpf/progs/test_select_reuseport_kern.c    |  4 ++--
>  .../bpf/progs/test_stacktrace_build_id.c      |  4 ++--
>  .../selftests/bpf/progs/test_stacktrace_map.c |  4 ++--
>  .../selftests/bpf/progs/test_tcpnotify_kern.c |  4 ++--
>  .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |  4 ++--
>  14 files changed, 62 insertions(+), 40 deletions(-)
>
> --
> 2.30.2

Looks good. Applied to bpf-next, thanks.
