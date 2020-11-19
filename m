Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464042B9CCE
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKSVOO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 16:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgKSVOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 16:14:14 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3CC0613CF
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 13:14:13 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 18so3630813pli.13
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZGj0oIna+UduCQLR0+PjVPjVl9hL9hj6VDeUHmIQpA=;
        b=mswBFci17dGbCtf84CRFOcgst+BzEvYcSvutJupIJsxPzrnAaZM58FBbcME4BQOd3I
         WX4GKvP31SkrTbEIk+/yGrSQLDEdsRJnR9Kdauz2KbGlpOT4MRbqxZsGeRFblBKz83vU
         IkuFiuB97Xx4I6/2zcoZU1431r2zCJeJsfXcsZZhi0T8RyYO4ydPGiECVbpNlk8i2OQx
         yCdMfrMhX0GWQSfEO7IEK8vN5UivuFmllua/U5sUbGXMMya+3naXZ5kCxelw1ZnNqtGC
         O+GagxXO6Uur8HF5Y6oi+1cp00ppga2qZaOizSy8dYbqs/Cax63LxvD6kyZv/ACf51R2
         grLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZGj0oIna+UduCQLR0+PjVPjVl9hL9hj6VDeUHmIQpA=;
        b=TG7fQxl779JxXyWi1pUrd0UuB301LXa6y7j6eG+gtmA5R4j0l5m0eTYAlWIB7dGR0X
         G6WbRKuH+UOGSmpo07xY2kfku4/9WL7SZYqM/tjOlEbg3HfY9Hh1LAsqavis5hiqyt1U
         YWBp8JSDs1xI7S07u9TSaEw1GkEJLhA8tIuVBBhWfqXNnr429yXcpvG6Rn92No1FML+y
         RAhfoOfjQm9Ry5YNfXud2H/hU/sHNDdwOy+WylJtdpzUfB+/EFBvsR3mOhb0L9xGBnBM
         MnQDFJTRsbDyPC8N7aAOAkoD+xPMrROD1jTlfqwA5KLpcOvBZkyLokl5+6zbXjYqXYLv
         C5gQ==
X-Gm-Message-State: AOAM530efgvPDJkjaTnV53i8j70eZ4R3iT+DAgWNvquyUkNAxgnQoj36
        e2t37Ys9c78LZj0Yz0veacB5g2lOQCn1B8lR5mCg0Q==
X-Google-Smtp-Source: ABdhPJzLoefWxNuolViSU2dd6TqJGgosXjrWgwaTjJFj+EN5lBIGqVWU4UsWIXZu0IVhHR3wbrC9hahuKnGZLmqWIPY=
X-Received: by 2002:a17:902:b28a:b029:d5:f36b:44af with SMTP id
 u10-20020a170902b28ab02900d5f36b44afmr9918635plr.51.1605820453161; Thu, 19
 Nov 2020 13:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119085022.3606135-1-davidgow@google.com>
In-Reply-To: <20201119085022.3606135-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 19 Nov 2020 13:14:02 -0800
Message-ID: <CAFd5g45MO-F-Jw9oRzdvOHJ0+19OQWDC-HwgRDwz2iPrkXJAww@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: preload: Fix build error when O= is set
To:     David Gow <davidgow@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 19, 2020 at 12:50 AM David Gow <davidgow@google.com> wrote:
>
> If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
> make O=<path>, compilation seems to fail with:
>
> tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
> make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
> make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
> make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [.../Makefile:1799: kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:185: __sub-make] Error 2
>
> By the looks of things, this is because the (relative path) O= passed on
> the command line is being passed to the libbpf Makefile, which then
> can't find the directory. Given OUTPUT= is being passed anyway, we can
> work around this by explicitly setting an empty O=, which will be
> ignored in favour of OUTPUT= in tools/scripts/Makefile.include.
>
> Signed-off-by: David Gow <davidgow@google.com>

Seems sensible to me. I have no strong feeling as to whether we just
turn this off on UML or whether we do the fix you proposed here
though. Nevertheless, I would like to see *some* fix go in before
v5.10 is released.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
