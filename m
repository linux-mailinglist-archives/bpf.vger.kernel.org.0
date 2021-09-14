Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B6940B6C2
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhINSXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 14:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhINSXE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 14:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631643706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RzRQOokEbdUeicnCoLmtUmPl1TTH24mpTDbC+pUZi8=;
        b=iQdZlPhjSW4f0Ni0weaASIbPtJ82cuDK+ZLvehgp3vhLNsw4uvQZcLidPJCkqCwdC27It7
        GDf6sEY3C9PuPQxREu3mlECI5a827bSmuNU+9kIxNoWbkmg2hdaGG1PqSOXO6hEzbfLOPj
        dk9tt2E2k9Db0XQJyZYmhfWZ7dno/e8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-0zXNNTNEMqqrGJLS2R2rzg-1; Tue, 14 Sep 2021 14:21:45 -0400
X-MC-Unique: 0zXNNTNEMqqrGJLS2R2rzg-1
Received: by mail-wm1-f72.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso122353wmc.7
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 11:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2RzRQOokEbdUeicnCoLmtUmPl1TTH24mpTDbC+pUZi8=;
        b=4sHJLxKj9TH8YgxLYqrM5CWI/KerbAGpeRm5f6H8vttZTLC+PPl8Zv2u1eJXRPpAoY
         zx4xN7FDF3dHFDW6vsWKRqKSXId2RCi5vacDD+OuYY2Ms1mSKZ0ktaEl3cq8ou+LJCcj
         0OQBapwVjd3Q9aQlc1OT7W5zXSIQe6GSw97qy40Asj+iJBLT42LVojslejwY7xO+Wnca
         DNmjHx1vg7y0KANzcaXCru3FA5Z0Ag4mvhE0qMWVxwMS46mt6CHs0YFubD8LYxS29ovd
         OEL03Q2Rh8TvcgMHgjlVxI/hHpSz+h8p17wA9jjHoC/Qqihu+3dB2SnIh8Y6Jwh8RWSI
         UJww==
X-Gm-Message-State: AOAM532+5d6aa1Mmov6MzBEDxE12ZcaH+srDWt612GKO0aJ0/7BhddnN
        B3q5MKqdcv+V3kgB5FjPCBLWx/44N+zRE5NNXzkUn00LtgUswlMY7ozyCQ7GaK5fyuoN8RuGCBS
        M3gfclZozKVSy
X-Received: by 2002:a5d:530c:: with SMTP id e12mr584695wrv.81.1631643704159;
        Tue, 14 Sep 2021 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHX114+4ddP/vyY3zGWHlIpqyrz+peRm/giBAKyFao004xx7dh9UMPOH5Ec1nlffZVZNPgUw==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr584684wrv.81.1631643703990;
        Tue, 14 Sep 2021 11:21:43 -0700 (PDT)
Received: from krava ([83.240.63.251])
        by smtp.gmail.com with ESMTPSA id x21sm1922476wmc.14.2021.09.14.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:21:43 -0700 (PDT)
Date:   Tue, 14 Sep 2021 20:21:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using
 libbpf's btf__get_from_id()
Message-ID: <YUDoNX0eUndsPCu+@krava>
References: <20210914170004.4185659-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914170004.4185659-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
> Perf code re-implements libbpf's btf__load_from_kernel_by_id() API as
> a weak function, presumably to dynamically link against old version of
> libbpf shared library. Unfortunately this causes compilation warning
> when perf is compiled against libbpf v0.6+.
> 
> For now, just ignore deprecation warning, but there might be a better
> solution, depending on perf's needs.

HI,
the problem we tried to solve is when perf is using symbols
which are not yet available in released libbpf.. but it all
linkes in default perf build because it's linked statically
libbpf.a in the tree

so now we have weak function with that warning disabled locally,
which I guess could work?  also for future cases like that

jirka

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/util/bpf-event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 683f6d63560e..1a7112a87736 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -24,7 +24,10 @@
>  struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
>  {
>         struct btf *btf;
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>         int err = btf__get_from_id(id, &btf);
> +#pragma GCC diagnostic pop
>  
>         return err ? ERR_PTR(err) : btf;
>  }
> -- 
> 2.30.2
> 

