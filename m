Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0E44C672
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKJRvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 12:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhKJRvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 12:51:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84CC061226
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 09:48:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so5447491wrh.4
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEOc7+m69jizZAlnXFl3o/n8mpgNRufl6cVFO1xVigA=;
        b=sy7YSYGBR6dBHpVk6Fnuyk/vJ261XG8NuCeSpdS+YRofI2vDC/dTi33bB5EDXDwv9G
         vIB3srE/V/vbVOXAgnrToXvsdV+iUqbfHp8KFDorgtlPBG815xZ4eCBVTR+sUFd79NdI
         1yNOd+N7y9PfJ2UhpBTQMckTDh7EtPs2GSsRfkYy65yxMJxvuiSd3/5MvXp5SG6al3vc
         pvPtjh4qhh0R7ewYu3lJma/pqkKiOKuheMpqJYyQt8kt/ycK6XaKxLw30KlVkG0brLMd
         bO+OubNFSlmwruNL5wUjeKuTyfnTDnsET7Xu/dkkxeXxo1OHuRsitRQG2Kvwh9FEv/Z9
         hAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEOc7+m69jizZAlnXFl3o/n8mpgNRufl6cVFO1xVigA=;
        b=LNOxGHR+UXexTks+jiWRnQizvtFg7KKaN1HA+fPEfbMBqmWiNLD+4rmkRKCisf/+cH
         9KB1hkmqZCjdoFtfwZx0VwGwspYWgZv7EbHQu27qBwMTW+NjEExxU8haByu8bpsluQKT
         V++bOFfQU7zQIPkU3TuQPyQIjAnXkN9DlbVEOwSGuRNI1imuj0PK9V5pmEJfvjm4ihqF
         m6QxERGXxIDCXQFIJ9/pOVqFPEDnJBB5upcoTO0EeKXdSOSPpC7ydqiVrAsPDftIYJTm
         rGP6nvRd04P56joNziUJyikdFFrbF9N4kM4Og4hdl2HhHB7XoahhHQdbyHvu2h/A34p9
         SmOg==
X-Gm-Message-State: AOAM5328BqfYpDPMJS9aMgp28Iijx+IUJ/kAF+eGglqZ4EkQ+L23dH9p
        wFC8G8wf76vs88Bkz7/KHlTSVvUHaG2l8aFdX1Ivqw==
X-Google-Smtp-Source: ABdhPJzjmCm/Cdm27H8eWQG+cGJGMYNznKYx/KNYWc6n/AEVwCFXaePw4502mWUCx+tgkPAfUA20fy124uo1X+098EU=
X-Received: by 2002:adf:f40b:: with SMTP id g11mr1027874wro.296.1636566503738;
 Wed, 10 Nov 2021 09:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20211110174442.619398-1-songliubraving@fb.com>
In-Reply-To: <20211110174442.619398-1-songliubraving@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Nov 2021 09:48:11 -0800
Message-ID: <CANn89iJ4r10f0375hoGC-227AWTEqJop88qEZRhOinxQWn7oKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: extend BTF_ID_LIST_GLOBAL with parameter
 for number of IDs
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, Kernel-team@fb.com,
        syzbot+e0d81ec552a21d9071aa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 9:45 AM Song Liu <songliubraving@fb.com> wrote:
>
> syzbot reported the following BUG w/o CONFIG_DEBUG_INFO_BTF
>
> BUG: KASAN: global-out-of-bounds in task_iter_init+0x212/0x2e7 kernel/bpf/task_iter.c:661
> Read of size 4 at addr ffffffff90297404 by task swapper/0/1
>
...
>
> This is caused by hard-coded name[1] in BTF_ID_LIST_GLOBAL (w/o
> CONFIG_DEBUG_INFO_BTF). Fix this by adding a parameter n to
> BTF_ID_LIST_GLOBAL. This avoids ifdef CONFIG_DEBUG_INFO_BTF in btf.c and
> filter.c.
>
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Reported-by: syzbot+e0d81ec552a21d9071aa@syzkaller.appspotmail.com
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/btf_ids.h | 6 +++---
>  kernel/bpf/btf.c        | 2 +-
>  net/core/filter.c       | 6 +-----
>  3 files changed, 5 insertions(+), 9 deletions(-)

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
