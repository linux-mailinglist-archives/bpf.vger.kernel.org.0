Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081C6313E4D
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 20:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhBHS7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhBHS6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:58:22 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0DC06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:57:41 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id b187so15609928ybg.9
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KERZYToexTihT1cjL2s5aXZz1xA/L6flPfDbhWN201I=;
        b=FoSEjTJj/Dqj6arRxv3osJSU4tEItU8ZCq2I/qN77PiauAK7RCShm3yI3zyXGcBOx6
         dKaUyQqRNGIW9OS4HIUoZpS3d+sQ+NWiRZQ1AfNCBqMLUcpfd6MAQ0IHhfqvpPKwHB6I
         cZiRC+Oeo7TogCKz25/cbjeDn5NnY+nVwGBf2Va76jkugMEmRu71et3wuYSGwIVRv4ym
         e55elyCdjmPmb0RkxBbOlbC3Ook0KG2VS7ThUyKTLevj88ECwUFPlB0DmeKIiFClmlH9
         hK6q8Plvvbs3Em0XoEoc2fWgYI4gvWgHuOJIUs5G0uxUso2Jy+a1O+jgiClDLKe9X0u1
         xcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KERZYToexTihT1cjL2s5aXZz1xA/L6flPfDbhWN201I=;
        b=OAVUKBR7eshkPCpGVN00n85cbxbsTXvjC68aR6Ngagu/natiwXmgKsSU/zqxGJqvBL
         /VZWt4B8tZUkZ3WbiroJgzDdXVk6DOiZP4RDnZ3DpmJZLuSrcDl7dE1zpmw92Bq9Oqtr
         6H6uTyf05WcZw/tyEXA0yguJAUlZWHyKHiOn/oopbKcA8F7cIZTfHYEAFmsa/mCDgUS9
         M/PybkFSbpfOrWcsZWDz51FXcX6uv3b/cydx6mbOifn2+ZdxSUir0FTpJ0HZr6iUKAoo
         /x6lcusJrPIPareebuNtIfpgx5QOwhpdFHTxYgyUzafI4y/ygrOS3pbjEUzHBpScI+Kw
         kUHQ==
X-Gm-Message-State: AOAM532CMYKPl+Spc+RQTle26NM4ponMQZxsexB8DXfhNyU4HJnvVwd/
        Lim1qBJrNJvDl5jUrK+0Cw89c9fmA84XOorHo/U=
X-Google-Smtp-Source: ABdhPJz6wJAiJZshuS5UpKtsX5D6RCp5uYmN5pL7Rq0O+rXyOxv5SY93BVXyKOz57kSbZ32ss8A2J71A/Mp5LNEBM+c=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr4898564yba.347.1612810661097;
 Mon, 08 Feb 2021 10:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-2-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:57:30 -0800
Message-ID: <CAEf4Bza72Vbi1bdTum=drQms3UFdqK+cjO5kthRRAK-sAxzyhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: Optimize program stats
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:05 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Move bpf_prog_stats from prog->aux into prog to avoid one extra load
> in critical path of program execution.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h     |  8 --------
>  include/linux/filter.h  | 10 +++++++++-
>  kernel/bpf/core.c       |  8 ++++----
>  kernel/bpf/syscall.c    |  2 +-
>  kernel/bpf/trampoline.c |  2 +-
>  kernel/bpf/verifier.c   |  2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
>

[...]
