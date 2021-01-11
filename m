Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5875B2F1E65
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbhAKTAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbhAKTAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:00:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C0C061794
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:59:38 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y13so140516ilm.12
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iid3TDnaf9WQOqcIoQQgF4jMfSru8r+JKK19trGCH3g=;
        b=WMMAmJvQ8UcbFldHDjquXbDsP0TIlYtorRi2Uu/PLkIDQsreMFAMyZMlI/NI9hUY9S
         81pMyILWj2c/HKpa5XzHz3JwmUf9xqIl4A4HrBwjrX0Icg8g3qVDO5xbpUldgHZqr61G
         2amaac2UZxh7fpQmI5H7FEVQTiE7I1X1ugIfWBDP/nGvpZW4gcnYH37NLe20sMYxVVAt
         CpppInJmOlpTT5M898u+a7XFmZvt0Bbq7pfx2QxW22NksMjU/hli/8JDU24bl00/zsc2
         DlLoLuNz6SUpbjvE7gaAeJ1FQ3eq/VGo59qukMepqLgWsFQP1G0BcFZCaL4xhtQjfOxc
         E84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iid3TDnaf9WQOqcIoQQgF4jMfSru8r+JKK19trGCH3g=;
        b=jex5d9OY+Xcrh7yyGLOzJBhLXy7dOsAVHWNSa2qOLjJilYutSQlPWF+chPYAPyHSNO
         llBSrt9eb/FfGfC59ul8ogEbGZNkwRXLap+YQdpsAbs6L2Ha1gCaVg3dojBbiNFTrJ6o
         wYJzGSngLsz8ejOVuZMHrX8ALSyYHPTH/D1AoqPrvPrI6DzcwQDYf/PuQrT6u9TuJjnO
         MqjLs1f0X2qFTEFLyVWt+ujI2sSlJ20EG+OoKRVvksdlmYBwcdUjEgTExUFqcWAzt3TZ
         d9CmMPnf8UugPO+ExAd2h+verhFbaR40WzH0VpMsqAePz/x/D1c0kW4poS3tYYlQHPKg
         8H1A==
X-Gm-Message-State: AOAM530WzTzipTwMBoGsLOGVCLj5objp9CxLaETJDfT0zxPvM+5fXr4C
        ewEvJ5fUJo1k2wI8NE3YKYMUin5VVex+9QoxPs1asA==
X-Google-Smtp-Source: ABdhPJy8h7ZPQl6W8ujlx7HY6S5M1edD1HQfVY0iKicGbb+yL1zF2wliH+064vPJxkqEodqFjkcFjFhXODkSIL8dJwQ=
X-Received: by 2002:a92:351c:: with SMTP id c28mr533060ila.61.1610391577408;
 Mon, 11 Jan 2021 10:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20210108220930.482456-1-andrii@kernel.org> <20210108220930.482456-5-andrii@kernel.org>
 <2e7a9040-6b16-bb9f-0cab-73161899e1f1@fb.com>
In-Reply-To: <2e7a9040-6b16-bb9f-0cab-73161899e1f1@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jan 2021 10:59:26 -0800
Message-ID: <CA+khW7jcXf=qLQB1zcV9TQKNKb64onWicmrx3iH8FNj5broahA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/7] selftests/bpf: sync RCU before unloading bpf_testmod
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Hao Luo <haoluo@google.com>

On Sun, Jan 10, 2021 at 8:05 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/8/21 2:09 PM, Andrii Nakryiko wrote:
> > If some of the subtests use module BTFs through ksyms, they will cause
> > bpf_prog to take a refcount on bpf_testmod module, which will prevent it from
> > successfully unloading. Module's refcnt is decremented when bpf_prog is freed,
> > which generally happens in RCU callback. So we need to trigger
> > syncronize_rcu() in the kernel, which can be achieved nicely with
> > membarrier(MEMBARRIER_CMD_GLOBAL) syscall. So do that in kernel_sync_rcu() and
> > make it available to other test inside the test_progs. This synchronize_rcu()
> > is called before attempting to unload bpf_testmod.
> >
> > Fixes: 9f7fa225894c ("selftests/bpf: Add bpf_testmod kernel module for testing")
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Yonghong Song <yhs@fb.com>
