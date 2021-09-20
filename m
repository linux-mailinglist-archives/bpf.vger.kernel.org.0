Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4478412AD8
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhIUCAw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 22:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhIUBwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Sep 2021 21:52:45 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8EEC0363F0
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:23:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m21so48200631qkm.13
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iY6x3M+TDDR2/wyB4ZLyz97xWlAqzYMqrWbj2WDiXRc=;
        b=fA9rb5ehp2Vqv3pKmyvYshSXOTs1nbUS8fDUZOQRlg2GQNmbZbnu2rJNOAiQe/W7Sz
         p4IzK/pDIPZNIHMwJWdq0rzcr2eha1ImUDKAoPEbqp5QQRQsXaX/EktBh30PEdv2b524
         gZRrBoiAJAl+Du451aur18m1AAg9qc81+Z8aEALmfapU0WUK1gdzDZ2WS30R23JxKvGc
         SzHlvQ0jWdnWqZKwjJQMRMg2Trcwm9sFXylQM2L8nCFJ2YoYwNqC05weF3anQJweJtFx
         dQnVQnUr8vVvH6cXNqaP02hrnMldUmS5AYDy9mMO+xxfWIgDBLJzCU/xOLsgbQr46gQL
         MWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iY6x3M+TDDR2/wyB4ZLyz97xWlAqzYMqrWbj2WDiXRc=;
        b=QI5w+QXPm159AuJZDmitz/tzPVHHWeXSab2mnui9kyVp/goNNau0SX2Nlm2nd5HNbs
         4sxzoZKE7Lhq3u8uLJuSfWuxNL5Kmdqk/6vEjX0XnFZvexgOC/MJL5jqzu7Rk0WmGNzu
         x8sAgq1ENJZp8mALfmLMybrLz+8i/L6duAtjxQ2xLiOVhWRkkAriuxCPAxQbHGv7Oc+A
         BfbDnMUO1pHsWTzwguZy7mQQl9FhCQd4/QAVsEUaBEoioHPeMKoZi67LWT+GkVRcWWBx
         y0zZoIn2LanRRyEt0ILxPVKIEiM5WuGRWeRxxyI0X6c5lkuZKaSaiZ1BcWxRrPDjvE5v
         cg7Q==
X-Gm-Message-State: AOAM533tvG/wXIQbJU7X+6xhFOp65Woti+Y+FhuuGS2MzLUITH5WaVzG
        oX2m42NndwzR2JbzeJ8HsbJPxzyzSIxvog2/cAM0mjcnHxs=
X-Google-Smtp-Source: ABdhPJxlL6rQ37DPxyvUhZxB7SwUZT5UvXyZRiiGT3lfGvZ1Z0UBYf31L390HNA3Zp3fJ9M/LQn84rgYb2NPKTFLk6Y=
X-Received: by 2002:a25:1884:: with SMTP id 126mr17858312yby.114.1632180199166;
 Mon, 20 Sep 2021 16:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210920181959.1565954-1-andrii@kernel.org> <20210920181959.1565954-2-andrii@kernel.org>
In-Reply-To: <20210920181959.1565954-2-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 20 Sep 2021 16:23:08 -0700
Message-ID: <CAEf4BzZK=eMsuDcpey-tTYMVYtWZ5obuRdA-t6V4EGs_-RGf5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix legacy kprobe event creation FD
 error handling
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 11:20 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> open() returns -1 on error, not zero FD. Fix the error handling logic.
> Reported by Coverity statis analysis.
>
> Fixes: ca304b40c20d ("libbpf: Introduce legacy kprobe events support")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

This patch is superseded by a new patch series ([0]), please don't apply.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=550083&state=*

>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6d2f12db6034..761497be6ffc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9036,7 +9036,7 @@ static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_
>         }
>
>         fd = open(file, O_WRONLY | O_APPEND, 0);
> -       if (!fd)
> +       if (fd < 0)
>                 return -errno;
>         ret = write(fd, cmd, strlen(cmd));
>         if (ret < 0)
> --
> 2.30.2
>
