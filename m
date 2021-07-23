Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93C3D382B
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGWJRi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhGWJRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 05:17:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0198C061757
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 02:58:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so1677644wrx.9
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5A/FebqA414tYs7IiBUTviygNuPc0o4KruGcqiTD/4=;
        b=gi2iF2goYAexCGPMuvR7xUk0gYCgVSgNvzSjZOAEs+YpYwDuBgFnPcfDMqGzBDuUuG
         fceP79kLjmnXdxLHx5Foo5K8ydvLID0CcfHq9CJ6KAuYBrkjLAxaMpQuixOVwoSYvJgX
         Ia/ZmIKGzkc9yrfPJGeYb1f+5gOQNJdtDHkURSPulJkjxiwKUhOTcEn2CVz90De7hXQ/
         NjfjTYs+Zs+2qCT51Xt5TFGB8/kfNFpEdc86EbUyN7WMmiJcqPAv4lqkrR7+16RZqcO0
         kd71BEtCnqXB4Yl9AEq01zx7bwYaQtkTC+PNpFRxuaCLppQKdBTnVthdm9LQ3FFp5ONI
         R20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5A/FebqA414tYs7IiBUTviygNuPc0o4KruGcqiTD/4=;
        b=AoZR7SKR9H1QFZs6V7ZT1m2E167ucMk6FDkN+raUm2jxDCi3oEcSV836QNeUsReJJT
         tuXdwMKGS7tX8+UaEq/sWWrbAo36K2JStCDr/gm6sDyN8ZMl+OvcUw8EMvgfXj02DD3P
         bTKuXtSTw+c64R2e+VvDM8196bIg6cYj5VYmiMIXHIJCcAeCzVDQgO2PoIeE34KkTQTB
         tq6QlavexruXweLz28eSY3Cyqz6GH/T0QpzG+G6H8WMx5+NdwIYsb6NMH/nFsgKSagdZ
         yIs1fKBHuJzdnvH9K+6M8MVzOnbaBwYX2Us8TPZC4j+lXgO7t086+RTbh+pNt+ANcEWS
         D8+w==
X-Gm-Message-State: AOAM532FA83dFyvG4yrmaKXJ/mkyxM43goROD+Uk0lkbMrBLOJnDPOQu
        Vo/TdpPy3L084ygIl15U5TYaTCDlKJlWK1Jd
X-Google-Smtp-Source: ABdhPJwnenaKTlWwtLa0gFXS9HJxTOU31SKQcBDK3CLeq0XZa5yydQAju3bcG7J5loTHJRbGl2Lc2w==
X-Received: by 2002:adf:c803:: with SMTP id d3mr4429419wrh.345.1627034290225;
        Fri, 23 Jul 2021 02:58:10 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.77.94])
        by smtp.gmail.com with ESMTPSA id m20sm11240467wms.3.2021.07.23.02.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 02:58:09 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: rename btf__get_from_id() and
 btf__load() APIs, support split BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210721153808.6902-1-quentin@isovalent.com>
 <CAEf4Bzb30BNeLgio52OrxHk2VWfKitnbNUnO0sAXZTA94bYfmg@mail.gmail.com>
 <CAEf4BzZZXx28w1y_6xfsue91c_7whvHzMhKvbSnsQRU4yA+RwA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <82e61e60-e2e9-f42d-8e49-bbe416b7513d@isovalent.com>
Date:   Fri, 23 Jul 2021 10:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZZXx28w1y_6xfsue91c_7whvHzMhKvbSnsQRU4yA+RwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-22 19:45 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Jul 22, 2021 at 5:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Jul 21, 2021 at 8:38 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>> As part of the effort to move towards a v1.0 for libbpf [0], this set
>>> improves some confusing function names related to BTF loading from and to
>>> the kernel:
>>>
>>> - btf__load() becomes btf__load_into_kernel().
>>> - btf__get_from_id becomes btf__load_from_kernel_by_id().
>>> - A new version btf__load_from_kernel_by_id_split() extends the former to
>>>   add support for split BTF.
>>>
>>> The old functions are not removed or marked as deprecated yet, there
>>> should be in a future libbpf version.
>>
>> Oh, and I was thinking about this whole deprecation having to be done
>> in two steps. It's super annoying to keep track of that. Ideally, we'd
>> have some macro that can mark API deprecated "in the future", when
>> actual libbpf version is >= to defined version. So something like
>> this:
>>
>> LIBBPF_DEPRECATED_AFTER(V(0,5), "API that will be marked deprecated in v0.6")
> 
> Better:
> 
> LIBBPF_DEPRECATED_SINCE(0, 6, "API that will be marked deprecated in v0.6")

I was considering a very advanced feature called “opening a new GitHub
issue” to track this :). But the macro game sounds interesting, I'll
look into it for next version.

One nit with LIBBPF_DEPRECATED_SINCE() is that the warning mentions a
version (here v0.6) that we are unsure will exist (say we jump from v0.5
to v1.0). But I don't suppose that's a real issue.

Thanks for the feedback!
Quentin
