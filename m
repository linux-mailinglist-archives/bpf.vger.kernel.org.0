Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968AC5F1667
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiI3XAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiI3XAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 19:00:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636122C123
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:00:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so11895151eja.6
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwcUEIhPlqwQufYFb1z5ve0Q/Q6KL37Nz0wMTOhji54=;
        b=C9OuWQ+lXK0phfUtNJEVziRKPYkAKGfv8JN21q772NjvxpeksRtkmxByVyvNJmStV5
         rOywUvc1UCNmJmyIMBc6kSLcNUYs+JDqvtCUuGuLdWOyt7dfEm5wPpG/GArbd38oSnky
         R+VrL8G9uCa9Hy6pk65FKqRnRqa6pUlbh/wBcvQL97aj0KvlRmOfOjCZlkjzBCEjRqUO
         ako+7vKkKA2fDkWIQANxnw2080gsONdCed3FdqJgOC7jkLPTmTbIpTKyK8gSR7VjUzcN
         77ZqWINdUMGKBKDSiFqaiIqN2nqHatxwIE4Jn/edtLjFDQ6X1qTGoHbQHlSmSI3jzdAx
         hdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwcUEIhPlqwQufYFb1z5ve0Q/Q6KL37Nz0wMTOhji54=;
        b=HmxeLRyoGpv5K4C2wvTn2PhPtKrWuUlZSpjNHV1OQM7prM31zqOtqEpLStYRDeSzyH
         Qilu4jjQ7k1et1JlVWfgBV3nxaAdEfj05qNQbKuIsHeBMA+KZroyzU/yveaiwGSeepYl
         n1Ggmgs1F4CMrQebw3tVr8yTbh1o7mp3N7sbXPhKop+9PozHLRoRhIduRCruStU3jn2G
         1y/yYHhc/5HXDQ2oJ8LLp9prJRRHW5SbIwy+MxyUBKITAtUOG7AxPYJKvcwGojVhskQa
         hX9OcdehY9fSr3uQkogAbKC/QJ4+G2hrxAAYyzlFYmrjZvX6CmC5S/c/wxvKFbLRgiD7
         q4WA==
X-Gm-Message-State: ACrzQf12UCtWxMgsu/K52Q2Ne4oJarxEp/qOAZhanAI5U3HqLRXbsZoP
        8vfexxfLoEMS5xoJyCk6FWRxoWHtUvJvITpV8WI=
X-Google-Smtp-Source: AMsMyM4rnFLIavAqDtRuYjSBnS9t2sJ8tsoF8rYMrMcyg/k3Kg2swZLs3OQHRGAvv0kFpIN+C1vfdgEIib6AhxvSrLw=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr7971180ejc.226.1664578804939; Fri, 30
 Sep 2022 16:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220930164918.342310-1-eddyz87@gmail.com>
In-Reply-To: <20220930164918.342310-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:59:52 -0700
Message-ID: <CAEf4BzY7kNdZHGGhZRVt9CFKcXXpEZpcOcHNwvpa3RNpiWMpag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpftool: fix newline for struct with padding
 only fields
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 9:50 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hi Everyone,
>
> a small fix for bpftool, copying commit message from the first patch
> as it explains the modification.
>
> An update for `bpftool btf dump file ... format c`.
> Add a missing newline print for structures that consist of
> anonymous-only padding fields. E.g. here is struct bpf_timer from
> vmlinux.h before this patch:
>
>  struct bpf_timer {
>         long: 64;
>         long: 64;};
>
> And after this patch:
>
>  struct bpf_dynptr {
>         long: 64;
>         long: 64;
>  };
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>

Some general feedback about cover letter submission:

1) Contents of cover letter is embedded into merge commit when patch
set is applied, so "Hi Everyone," looks rather weird there. Best to
just get straight to explaining the purpose of cover letter.

2) Please keep capitalization ("a small fix" -> "A small fix").

3) I don't think we add Signed-off-by into the cover letter, so please
drop it for next revision.

> Eduard Zingerman (2):
>   bpftool: fix newline for struct with padding only fields
>   selftests/bpf: verify newline for struct with padding only fields
>
>  tools/lib/bpf/btf_dump.c                         | 15 +++++++++------
>  .../bpf/progs/btf_dump_test_case_padding.c       | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> --
> 2.37.3
>
