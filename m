Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341A03DAE79
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhG2VpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhG2VpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:45:03 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218DC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:44:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k65so12434433yba.13
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfN3ktA8jhkYhK7fdUz27apvp5FlYi5C3WmJ0bDrG9s=;
        b=YoOLnFDh52eSTuI/r7G74vGRJfDcL8vPuOWBl1+7K+Ma81lcsAN6SoAFGUWTA5D9UK
         214lFTpPjJqxzgBLEeCAaBBroXuCi4wQlPiFRBmg+eYsyPovLLtMkhJjnLMp0BfvBYnb
         Jx0o9yaHfERqyNKUzEqcMNOjBkDOW3MIODBp2AID5y+pZj4B6rWMAGOgiaclO4Pda+wZ
         uYbd1QCcZP+ugMNfp4fBqam590EUQJIVc9x7pGaik9Pk8kT+6mtQj4mRG/eWpqDEHsMb
         nhXETYsTOf6yub+BVtjHby8XojF8/HUhbZae4xlt4H7Nm28++y6QHtpz/pGvXgk4WCiu
         qhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfN3ktA8jhkYhK7fdUz27apvp5FlYi5C3WmJ0bDrG9s=;
        b=Y8ADh5X6zyNLsymfUGlViKidvLn7r6zQQK3ME669wH1s7SKQ3/I8pdJGO8vzrLhzG0
         sIeVo9g+uit1ovFHz3tCSqyfFb8xw3rUubxOvAdFy7vu8gXcNCI0vRiJXWvge8dy07i6
         2ZNb6MdAOO7RZ+3bad0x1hoyTdA+t3sojmR0qNuqA+IQgV8v30kmxq9D3luaKZerhSoI
         XKxskd1yF1ufcxsXbMzNrqwzUFlh34Z+Wn2O7TUAyzaTrV6typG91SoFGUUXXqNZiP6f
         +8wfzUIbAciYbJfNVqPNbLGKsZJQq3TuGsk1wG9qFHiKhJ5DBkJ5EqW+9tw5UPUPsRc7
         9ABg==
X-Gm-Message-State: AOAM533UZInb53A8w4kPaPPbbxFNAMj3i/KDic9YOiF3SNMc6/BdyuVW
        rn0MoOgWIO5E3qVqYKLI+zIdQY8qrRSQdjRlWcI=
X-Google-Smtp-Source: ABdhPJwa7jKb8/Hp+elQWS7GjzuLhqdx0fe7Fc2jKb/8reBnQ9p+j1lsqp7tQuNbXHt9qtQ1DRhFwxVAQdpalfEDJ9k=
X-Received: by 2002:a25:2901:: with SMTP id p1mr9721741ybp.459.1627595097828;
 Thu, 29 Jul 2021 14:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210726141013.2239765-1-hengqi.chen@gmail.com>
In-Reply-To: <20210726141013.2239765-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 14:44:46 -0700
Message-ID: <CAEf4BzZ-w9QES5AgNLt61crA8S1SZP3OoFM+d6eSbrphSiuJHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: expand bpf_d_path helper allowlist
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 7:10 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> This patch set adds more functions to bpf_d_path allowlist.
>
> Patch 1 is prep work which updates resolve_btfids to emit warnings
> on missing symbols instead of aborting kernel build process.
>
> Patch 2 expands bpf_d_path allowlist.
>
> Changes since v3: [3]
>  - Addressed Yonghong's comments. Sort allowlist and add security_bprm_*
>
> Changes since v2: [2]
>  - Andrii suggested that we should first address an issue of .BTF_ids
>    before adding more symbols to .BTF_ids. Fixed that.
>  - Yaniv proposed adding security_sb_mount and security_bprm_check.
>    Added them.
>
> Changes since v1: [1]
>  - Alexei and Yonghong suggested that bpf_d_path helper could also
>    apply to vfs_* and security_file_* kernel functions. Added them.
>
> [1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
> [2] https://lore.kernel.org/bpf/20210719151753.399227-1-hengqi.chen@gmail.com/
> [3] https://lore.kernel.org/bpf/20210725141814.2000828-3-hengqi.chen@gmail.com/
>

I've applied the first patch to bpf-next. I'd like some more eyes on
patch #2, so I'm leaving it up for review by others for a bit longer.

> Hengqi Chen (2):
>   tools/resolve_btfids: emit warnings and patch zero id for missing
>     symbols
>   bpf: expose bpf_d_path helper to vfs_* and security_* functions
>
>  kernel/trace/bpf_trace.c        | 60 ++++++++++++++++++++++++++++++---
>  tools/bpf/resolve_btfids/main.c | 13 +++----
>  2 files changed, 63 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>
