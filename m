Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA02D7F99
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgLKTpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 14:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgLKTpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 14:45:33 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FCC0613CF;
        Fri, 11 Dec 2020 11:44:52 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so8583949ybc.0;
        Fri, 11 Dec 2020 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRGKqHf4iwEt3TjWcP3Q5MjQ/uQIJtJpPWbQ5Zk+e3U=;
        b=JFqOGf6SQscn2ezlxm00wlKE1LUC8Ho53aY0g5ius2ClR0F+x67cL4JIXSPxFnqmIs
         I6PG9C97V2v6613KjntyK5gpTGJ/il1VtQ4uPEIcLGlK7rtiqHYTt/33jfSMzCgzprtq
         WPX6VN3OblFtiMk/LzKFpcXEmuzb0tEcyin0R8i6rGN+X60uSBPjXYTg8Bx1kwGEU1rT
         FndOT82FdgZjF575WQc8qBjGk2iI2eUWIQ3+H1bFiVAb7OOwCYYMb8m6rv7ZqgrEOz/u
         m8xKAeQlKZkFtBTLEG49bC7JRUbahhpcq3EWatA3k+gwASizOir+ZIuIhsaHtYtBzpi6
         tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRGKqHf4iwEt3TjWcP3Q5MjQ/uQIJtJpPWbQ5Zk+e3U=;
        b=lxwuh40E2DFWTQhE0ax+XqqGw8M2mA1gOg14XQLZbJSHH6PjNPSeNcbSoYGWGVp0mV
         UcJkXirEHtZEDd2gzN5ntEYNLRWHzL5geBHUfK/smuLPeV/nUk/iXsvzhAFGWagN0d5J
         LMWV4zxdPZzVI+qszR8dFqapFX2iJQ/tRllBEV9VndUhsSySjC/7tcqSL/EcjC+6Q4ZF
         o6vv/x4HK9/j8q2weB6HvanudS0/fJ6lnJo2QYXdiEt+BGpV2GoeobnTwfVvhMGN6cfU
         KIMNto4Q9YHAaJDMGAt1H85vKaP3AsUBPXT7Ib09NxePjNvK5ISyjxwWJl3TaYe8ypTC
         k04g==
X-Gm-Message-State: AOAM530sqSAvyonkq0mxNFpofpIw7MzBAg9ClMdH+8AlFi9Fmx/k2l9Y
        ZteP2/fzrWc97jTQt8Wcclzyb0FMMAsVFFAi504=
X-Google-Smtp-Source: ABdhPJxwvcEJcelyxuFUxO+BI18Zh0JiV26i4TkDuxA5WPLVl0xo8sYeQy5x9aHmISaF/Te5piET0tFBru5CsS/vDWQ=
X-Received: by 2002:a25:c089:: with SMTP id c131mr20240415ybf.510.1607715892173;
 Fri, 11 Dec 2020 11:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20201211172409.1918341-1-jackmanb@google.com>
In-Reply-To: <20201211172409.1918341-1-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Dec 2020 11:44:41 -0800
Message-ID: <CAEf4BzYTKQR9cPHaiPe6DMSpUo+_LKa2qmGMZX+V7Mhf5UzT5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Expose libbpf ringbufer epoll_fd
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 11, 2020 at 10:58 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> This allows the user to do their own manual polling in more
> complicated setups.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

perf_buffer has it, so it's good for consistency. In practice, though,
I'd expect anyone who needs more complicated polling to use ring buf's
map FD directly on their instance of epoll. Doesn't that work for you?

Regardless, though, you need to add the API into libbpf.map file first.


>  tools/lib/bpf/libbpf.h  | 1 +
>  tools/lib/bpf/ringbuf.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6909ee81113a..cde07f64771e 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -536,6 +536,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>                                 ring_buffer_sample_fn sample_cb, void *ctx);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__epoll_fd(struct ring_buffer *rb);
>
>  /* Perf buffer APIs */
>  struct perf_buffer;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 5c6522c89af1..45a36648b403 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -282,3 +282,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>         }
>         return cnt < 0 ? -errno : res;
>  }
> +
> +/* Get an fd that can be used to sleep until data is available in the ring(s) */
> +int ring_buffer__epoll_fd(struct ring_buffer *rb)
> +{
> +       return rb->epoll_fd;
> +}
>
> base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
> --
> 2.29.2.576.ga3fc446d84-goog
>
