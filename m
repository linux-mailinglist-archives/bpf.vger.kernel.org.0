Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BA470CFC
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 23:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbhLJWVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 17:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJWVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 17:21:41 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD48C061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 14:18:05 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so24538450ybe.3
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mrua98xCLZWhZzCbDJhrwGhxGavLESWoApp61Ds5rko=;
        b=INtTqE3tFxVEoWh1nuMWSIu64HN+2uWdRP++mymrFtutXw5EOJb/DMFrM+FeYo6p6+
         DaVJsM/5qZxiSrHrgJRdj6OXgpnHOb6WEviYh5qRyDCXqKEJTVWwffXBFnFWNTd1UI/a
         qxXTzFqMs6YGJypgi/uXM1900oTw6icqdtF7i4RfjU7LSa2qfbWH30bmLHfKGErwDi87
         RoIg3+Wh+CIVaHMF+3BeVGOEOjgjUSmqlsMaklBl+INOWAqcv9a3mb+aiZt8/z6FKxnU
         UykQ2nnZYnEP4OcIbhdx3lPQ++5jAJ6upH+0tR7VIt8l3jCU7lQ1gF3zzGbaSKwqas6y
         ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mrua98xCLZWhZzCbDJhrwGhxGavLESWoApp61Ds5rko=;
        b=PyxwpyAKKKkjX9XHE69rmcTGhHYtdrGpQZerZBybPj+LYrkBGNwrUa1WhtJqzOGWNB
         R2mO9vIeogCuIW4cJIFr93KqDa4MH3kgwKSDKNBErBeQ3LmwK48INUWC6XVgaeidgAnU
         2fXmhBsdYaZTAHdqZVY3ndFPuBQaPSFWztPyid5UEzkvOe4UQoCLlBvwt5e8nYlH5Ddq
         fP0oVYOCnMTvHr4aQ6K1WEX8T1KRGJbap4fbI52jgWqvTpZ960mZl55WKM0T48+d+8C2
         /ieT7mLj0KML+lOSmEgSi3rfmMFG+j8zy5V9Xo6tYlBQCmQ+J67JpaPQ3mmN7AfYylR6
         FUJA==
X-Gm-Message-State: AOAM532GS6LRi8MaAfpkO/LNJf21WsCC2Y7rMj9ACLPiYgRCEyUXp6DD
        lNu/x++HN4aPTIr91m0ykPR2hkeCxeJUa8SMMc8XwbUgfgeHCw==
X-Google-Smtp-Source: ABdhPJwRvth/LJev2qpHyEjXMx6zmXauO89M9p27uNBr/uOc6p2DKIyHC8Ekgrxcw+kA99y8N1AlmcHlecXpG6Zckmc=
X-Received: by 2002:a5b:1c2:: with SMTP id f2mr18392057ybp.150.1639174684575;
 Fri, 10 Dec 2021 14:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20211210190855.1369060-1-kuifeng@fb.com> <20211210190855.1369060-2-kuifeng@fb.com>
In-Reply-To: <20211210190855.1369060-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 14:17:53 -0800
Message-ID: <CAEf4BzbrHE__GF1D117fXTCD0U-F_bq==2PxzxswU-P=umeA-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Stop using
 bpf_object__find_program_by_title API.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 11:10 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> bpf_object__find_program_by_title is going to be deprecated.  Replace
> all use cases in tools/testing/selftests/bpf with
> bpf_object__find_program_by_name.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Did you compile selftests locally? Seems like our CI has problems
compiling it, see [0].

  [0] https://github.com/kernel-patches/bpf/runs/4487805431?check_suite_focus=true

>  .../selftests/bpf/prog_tests/bpf_obj_id.c     |  4 +-
>  .../bpf/prog_tests/connect_force_port.c       | 18 ++---
>  .../selftests/bpf/prog_tests/core_reloc.c     | 79 +++++++++++++------
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 46 +++++------
>  .../bpf/prog_tests/get_stack_raw_tp.c         |  4 +-
>  .../bpf/prog_tests/sockopt_inherit.c          | 15 ++--
>  .../selftests/bpf/prog_tests/stacktrace_map.c |  4 +-
>  .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  4 +-
>  .../selftests/bpf/prog_tests/test_overhead.c  | 20 ++---
>  .../bpf/prog_tests/trampoline_count.c         |  6 +-
>  10 files changed, 112 insertions(+), 88 deletions(-)
>

[...]
