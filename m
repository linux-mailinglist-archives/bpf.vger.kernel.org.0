Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE965DD0B
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjADToy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjADTon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 14:44:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3384E18B05
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 11:44:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso231823pjo.3
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DvL5QVYWg/UbWmA6+wkZYawOSBnwGHoIUPa2/e2M1w=;
        b=D8cVfGlWxhzFsGbgLl2h+dPsclXk/EpWKBHZpUexbZBYueBUI7dTLA0sDR2aCPG3nS
         LUXPWl+7pCNXwytk9fq+42ro1MyHZx6xYN3z76OBkvJD0aFjLr6mysh5D1/dHYDYi1/g
         jnqtLVu13YDkF9OyC3GkIAYN721ujkOrfaVNY75bv8vAcEgbmF3fhVoQDyoEARAbAwg6
         MurlAwkr+4ih5iqXHMKqgSlA6rAWWMLjCxfmTFbYbBieVZlNDAe6wXgMiKuZY5gK7zpY
         3AODJoKS8oF5YxKhR3eb84f/1zfPa2bcYdb8hwQzyYt/f626u8ipwq0aPje7t/H9oG0v
         rdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DvL5QVYWg/UbWmA6+wkZYawOSBnwGHoIUPa2/e2M1w=;
        b=gGeQVDeqo8kgHUJZn8w4ghhKSNkaL7Q9m+IRH7WU7JVNMbqgcK/xWK5scxk87k5zdP
         mmKzMzQS8ptGrdOBO8VyGhRsm5aVe/DXdqfhTzneTqGNyFZQ4A85obuKj4vr8BaDGA8i
         qIMgNcu4cYKPNzQbCWnzJrH7OCyEtJeK0HMIA7x23jBhZlNAKtB/neEsME1kmIA+1DtF
         VRFC72bxgNEfGoCkJ3HntGR6oRFq9T/xEtDS+eGB60quEVZf+3v92L0MCSviq48UH3j2
         y0tOwbWd1U1mbxxd/VpSaKwjDQowTrQSYgXgpsmm8gcqfpoaL9sZVwxjL6vKJB8I1mo8
         8fXA==
X-Gm-Message-State: AFqh2kpUhxweF5rD1ba7wgBWRi+QA8VXWH5cjiyK3caqaZgYDWincCAk
        NLKzLlIPXULLHgcyF7SZqRA4rtExb4w=
X-Google-Smtp-Source: AMrXdXuIXy4jaQhlydAHt6mgQQlEVa6YrjqSbZErx/0B9JtKIZlC8513ToW2kCnysxvMvlN3nUFXWA==
X-Received: by 2002:a17:90a:17a6:b0:225:e3e5:7558 with SMTP id q35-20020a17090a17a600b00225e3e57558mr37418062pja.29.1672861481604;
        Wed, 04 Jan 2023 11:44:41 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00225f49bd4b6sm15627160pjo.36.2023.01.04.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:44:41 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:44:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
References: <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 10:43:37AM -0800, Andrii Nakryiko wrote:
> > extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
> >
> > will likely work with both gcc and clang.
> > And if it doesn't we can fix it.
> >
> > While when gcc folks saw helpers:
> >
> > static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;
> >
> > they realized that it is a hack that abuses compiler optimizations.
> > They even invented attr(kernel_helper) to workaround this issue.
> > After a bunch of arguing gcc added support for this hack without attr,
> > but it's going to be around forever... in gcc, in clang and in kernel.
> > It's something that we could have fixed if it wasn't for uapi.
> > Just one more example of unfixable mistake that causing issues
> > to multiple projects.
> > That's the core issue of kernel uapi rules: inability to fix mistakes.
> 
> This is BPF ISA defining `call #N;` to call helper with ID N, which
> you agree that it (ISA) has to be stable, documented and standardized,
> right?
> 
> Everything else is just how we expose those constants into C code and
> how libbpf deals with them. Libbpf could support new attribute or even
> extern-based convention, if necessary.
> 
> But it wasn't necessary for years and only was brought up during GCC's
> attempt to invent a new convention here. And they successfully dealt
> with this challenge.

'dealt with this challenge'? You mean didn't, right?
gcc doesn't guarantee that '= (void *) 777;' will work even with optimization on.
In clang we cannot guarantee that either.
Nothing requires a compiler to do constant propagation.

> 
> Yes, we won't change existing helpers, but we can add new ones if we
> need to extend them. That's how APIs work. Yes, they need careful
> considerations when designing and implementing new APIs. Yes, mistakes
> do happen, that's just fact of life and par for the course of software
> development. Yes, we have to live with those mistakes. Nothing changed
> about that.
> 
> But somehow libraries and kernel still produce stable APIs and
> maintain them because they clearly provide benefits to end users.

Did you 'live with mistakes done in libbpf 0.x' ? No.
You've introduced libbpf 1.0 with incompatible api and some users suffereed.

> We'll get the same amount of flame when we try to change kfunc that's
> widely adopted.

Of course. That's why we need to define a stability and deperecation
plan for them.
