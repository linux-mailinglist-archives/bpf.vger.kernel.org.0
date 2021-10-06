Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C144D4239E7
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhJFIqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 04:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237543AbhJFIqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 04:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633509885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4rqTW7YP6/QaK2Hf98BXadt2YjhRXa1+qjKywUhD0U=;
        b=T6YJXfjjmD1wsaWpqTG9wdvvlXmy3QBLX7E9dbAM30vZ8PQgtQs4Rpi5dt22KXSEp1Jvcp
        NJqEmH+TTIzCUuthUZRE3d9F7RfnTHIOxPUNCn6snZnBT9I2py+vYfggSp4wDMc+VNDJdX
        jgu59h1bnzOpe1+3icRNAXrEHLS9nf0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ASr050-hOjaGTGrpR6i_Yg-1; Wed, 06 Oct 2021 04:44:44 -0400
X-MC-Unique: ASr050-hOjaGTGrpR6i_Yg-1
Received: by mail-wr1-f71.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso1410489wrb.20
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 01:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4rqTW7YP6/QaK2Hf98BXadt2YjhRXa1+qjKywUhD0U=;
        b=ivF5VS/sFQffrnaYt7DJ9SkPLwh+sfqERXZP0iQq1g/yed1MLYBefvMp4GF2JeJz/z
         ztsBIz7FxBeBbEZL9TWGZ/excrfOfYfzuoPVPfcJDFinuIOEiNd9Xi0tWHNdnX6s2iYr
         WCuP0j2MBzgbnf+63aqu3Kmrpn4ey40gh7xTVe8GBThYb6Lm+5Ulepcf+uyZOAh0VkOX
         Jpwp8+vomR7gVOLGK7ww9REOg6vKt6fkos33bPte5CJi32ubFMBOm4a86tswgm3/QLi8
         +zGcmqMlJHUb/X8MN+40vWlqFx0hcnyaz02sf09/76yirV65ScSeL7+TZGeGwEHPkQ4x
         QXrw==
X-Gm-Message-State: AOAM530qTPJt6lUmUiXaCz9dGt6kRd7DZ4VRm6MlTF0sK5zlv54NG6d+
        5RRyaBXZDtjlN5z91MVbbUNM0jzyARVwv9FkMRKwOVAuKV4LGvk00BOCo9zLdjIlB1ST3GoRuvo
        hSXKbCGrfxlkw
X-Received: by 2002:a05:600c:288:: with SMTP id 8mr8424643wmk.172.1633509883275;
        Wed, 06 Oct 2021 01:44:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZmt9DX7F4J4aQvQj2seP99mui2ad6YqkzOYLVsgFR4zZLLA04fNa4RrGxwqEugusmP+vctg==
X-Received: by 2002:a05:600c:288:: with SMTP id 8mr8424624wmk.172.1633509883016;
        Wed, 06 Oct 2021 01:44:43 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y8sm16313529wrr.21.2021.10.06.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:44:42 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:44:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] store function address in BTF
Message-ID: <YV1h+cBxmYi2hrTM@krava>
References: <YV1hRboJopUBLm3H@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV1hRboJopUBLm3H@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 10:41:41AM +0200, Jiri Olsa wrote:
> hi,
> I'm hitting performance issue and soft lock ups with the new version
> of the patchset and the reason seems to be kallsyms lookup that we
> need to do for each btf id we want to attach

ugh, I meant to sent this as reply to the patchset mentioned above,
nevermind, here's the patchset:
  https://lore.kernel.org/bpf/20210605111034.1810858-1-jolsa@kernel.org/

jirka

> 
> I tried to change kallsyms_lookup_name linear search into rbtree search,
> but it has its own pitfalls like duplicate function names and it still
> seems not to be fast enough when you want to attach like 30k functions
> 
> so I wonder we could 'fix this' by storing function address in BTF,
> which would cut kallsyms lookup completely, because it'd be done in
> compile time
> 
> my first thought was to add extra BTF section for that, after discussion
> with Arnaldo perhaps we could be able to store extra 8 bytes after
> BTF_KIND_FUNC record, using one of the 'unused' bits in btf_type to
> indicate that? or new BTF_KIND_FUNC2 type?
> 
> thoughts?
> 
> thanks,
> jirka

