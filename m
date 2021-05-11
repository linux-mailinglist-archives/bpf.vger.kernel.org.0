Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947B37B1BB
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhEKWtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:49:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848DC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:47:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e190so28389571ybb.10
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbamoN6Sj/reLeeB02eyzNwzl2x3pUKQzro1Y46eDTg=;
        b=Ynr+GxVsh5SHb0HwnZP9pr1Y5PSEt1/Vcoo+iihyqlmSIhBtihtxGuJ7wymf9W/C9x
         KN6fhFqsugJSPr9UDne4W+xtC4LwbFnPiBbhNGM89OfA6xX8boB5hGaYsfvRlsl8gxtg
         vlMGkp8bUVloOWn738DtF7MvIMyYwbDd6Aw8DptFPrWBt63W6qZOIXFqShBHmhRrsoRH
         /xdyFcDTvdmxqAvwcu5uhAkyAGS0g+j/zTr2oBiJZBwiwg+b/+SAP7Kjw6/l5XCU5wRf
         C2Rx7DdL54K3Oy6TQltmV2YDuM5DZ0ANPwvVd++tyM2qN5v7AO3LNDAwn5NIgMrUfZDp
         c9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbamoN6Sj/reLeeB02eyzNwzl2x3pUKQzro1Y46eDTg=;
        b=h/mTmOLbLNmUoUIUZe5oiazoshMUc022Ta2pEp0JeBoT15lJIujwd9JCRhrOkVJaQL
         KF5FY1wY0iZFgSHkAv3990R7wVwgfovGLGSKoEDTkXxWVS+jMV17oswhiVraE1TOKLmA
         KkK1oSA7y0LPrMA0RAPKDj8h6etQ7pnZT7Ngkt2hAPSbsa94/FdYKIje+N3XiXvKDnG8
         FrzEQk/4yOMZPiB+FFk/kX0rTVDDToNzdbRHY0pz0rTPbO5b2jUVYcUojSlE/Psf8RQW
         smX5D1yQoQ7xvfHmxNqsHoXwuWmRQ+b73ZOXjQphvBVgM9mc4dGdh8VyAO+e9kAi+EHR
         oJ6w==
X-Gm-Message-State: AOAM530pUGaNbTv4dKr2ZRJwq6nAhzVvKSrL9H5xqvUezV6Nx5afD4Ms
        q4FVnOFzOyp5BadA2t3nFNfw+9wN7WgY6aGAPjk=
X-Google-Smtp-Source: ABdhPJx3zxD29M44qaWbo4oyHxvSjcRnsp+SpE0u2dGbKFBLiZ4kJAia3GIS1V1Kq5Go8RpM5o1tojcI5Bep2OKY8BQ=
X-Received: by 2002:a25:9942:: with SMTP id n2mr45817581ybo.230.1620773277644;
 Tue, 11 May 2021 15:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-9-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:47:46 -0700
Message-ID: <CAEf4BzbyiFcrCzVOUQTLs0nuh7LCsEN+V4vrEMVXaLAVFeyLVw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/22] bpf: Introduce fd_idx
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Typical program loading sequence involves creating bpf maps and applying
> map FDs into bpf instructions in various places in the bpf program.
> This job is done by libbpf that is using compiler generated ELF relocations
> to patch certain instruction after maps are created and BTFs are loaded.
> The goal of fd_idx is to allow bpf instructions to stay immutable
> after compilation. At load time the libbpf would still create maps as usual,
> but it wouldn't need to patch instructions. It would store map_fds into
> __u32 fd_array[] and would pass that pointer to sys_bpf(BPF_PROG_LOAD).
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h   |  1 +
>  include/uapi/linux/bpf.h       | 16 ++++++++----
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/bpf/verifier.c          | 47 ++++++++++++++++++++++++++--------
>  tools/include/uapi/linux/bpf.h | 16 ++++++++----
>  5 files changed, 61 insertions(+), 21 deletions(-)
>

[...]
