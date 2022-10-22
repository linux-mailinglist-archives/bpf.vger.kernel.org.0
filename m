Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF260830A
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJVBFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJVBFR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 21:05:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE025DBBC0
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 18:05:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i3so4129597pfk.9
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+Z+m5UuoZHqqDXA1rEmzYhm7dcY5Bs+/QhLDNEhRA0=;
        b=Pv2joy2iRYtTBgYdIUiLrZJD6ZX7HWAkDhmmll9hggwP7Y7vf/FgVwFQeoEWCIjeHJ
         H0ho2PI0/XT0AZYSwy2wq9Y/7wQOFPJeuanx0l4Ylf2xHjKyxKcYpJkZ96P1paJHmHrE
         GV8aNSp5yslQhDJMKjnNfl9yDYfLyzwKEYrCXbFOuE6lE/Qq7+FlEAB90H0KRbQWqS8U
         vA7zXo59QMyF6ousU0SfgsiVnfUAQT+g4NoCgiv7zAhudZr1kqVywtCMd1036xHTczwT
         qYBg27pMf6qEC6GV0zUHy8jPbrkAN0hJc915MNbPn3aQS1KlGYxN5py+k6W5tb1qUlIh
         ALRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+Z+m5UuoZHqqDXA1rEmzYhm7dcY5Bs+/QhLDNEhRA0=;
        b=PflzcPsbz9TbyRnFUKlLXCxXr42ZPjYv8WX5nfUxDP/VNvUbSc4jpFHA+k5DWZ4khn
         O8qf4krGJ11eAPmHpe1B1vpwWTe+nXE+iRKPthu58TbyKJUYIykOP5o7d9Kov7NGKwz+
         cuZ8yW2SfLNlfN+Gzku1U5ytSBdFEaj22DKTIZnw3XQt2EUqdPXzPvo1Q/T+rUua7D4e
         snN6eYLIKwcVYuqZC1kyM25aUONHWahAimRE1ZjMa9BWB9cDSl4HgjIov4KQi1zV9q0c
         ClZ6Z6Zl7jShBPdMTVWY+ML31RcySyS8ng8nw3ghs7qGRkJLtL3+ieXF2T7ZlYTSPyjK
         Vuqw==
X-Gm-Message-State: ACrzQf0xhI4CHT56ZBgoP31MSZiHPZmGgu9BdVGrH+RJI0W8267yYnkL
        jMh2ph4/nMfNGu9D9CW7qhRwEBUBGvS42A==
X-Google-Smtp-Source: AMsMyM7qHjOqP1zRXC9YSmfaO4u3sDgHDwfshDpcpr6SdGYKqCn4QNl5VG8gY2B8F1wErvNYSZH+Fg==
X-Received: by 2002:a63:4a4b:0:b0:439:837:cc8d with SMTP id j11-20020a634a4b000000b004390837cc8dmr18591550pgl.199.1666400714831;
        Fri, 21 Oct 2022 18:05:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 186-20020a6215c3000000b005626ef1a48bsm15638107pfv.197.2022.10.21.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 18:05:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Oct 2022 15:05:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Support new cgroup local storage
Message-ID: <Y1NByH+suY2s65Kh@slm.duckdns.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221311.3554642-1-yhs@fb.com>
 <CAEf4Bzbi1UwGwnekjpWNZwF2G1_M-64EqH5BaKCf712nR1PUPg@mail.gmail.com>
 <966cb96e-e0a0-aec5-1cce-a4c9fbc0ca5f@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966cb96e-e0a0-aec5-1cce-a4c9fbc0ca5f@meta.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Fri, Oct 21, 2022 at 05:32:58PM -0700, Yonghong Song wrote:
> > LGTM, but I do think that BPF_MAP_TYPE_CG_STORAGE and "cg_storage" is
> > easier to read and talk about. But that's minor.
> 
> I searched kernel/cgroup/* and kernel/bpf/cgroup.c and
> include/linux/cgroup*.h. The 'cgrp' for abbreviation of 'cgroup' is much
> more than
> 'cg' for 'cgroup' unless 'cg' appears in like 'memcg' or 'rdmacg'. So I
> would just use 'cgrp' for now.

Yeah, cgrp is more consistent for prefixes and variable names. cg is usually
used as a part of an abbreviated word - memcg, blkcg, cgid and so on.

Thanks.

-- 
tejun
