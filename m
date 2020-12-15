Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7C2DB3D7
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 19:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLOSgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 13:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbgLOSgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 13:36:09 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37AC0617A6;
        Tue, 15 Dec 2020 10:35:29 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id x2so19893179ybt.11;
        Tue, 15 Dec 2020 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1WWEUvnMjs5fUymJpL74+Mkojs1oxn/NtiIZL/uohY=;
        b=lAR/gkidY3WSAoyBwj/99CU/bROfG4oB6YtdT9F/qSbQb+wFQcZppSTgO5q5pIGINV
         P0cEoUBrko0baGhgqKAald4iGzEMyeCAYSyjUx9xlRjaI5dYmNagiX2cLewFTE1qd+0z
         hIJy4qfOAr+yGOKao/9bIDG1fBg3OY+vWf9Oy40jD5Yuue8WJhjld4OR4l7gIZbLqkY+
         YJtlwPmW0ITh8miz7gnbkWz84syT0C9Wzhua8jiTh+QSGNnObCoRLEp97Q7hZ5Jk+8CS
         HpO2D3Argl9l5qPMKi3OnzXRm2L4xWbtehCypZa5Be2PJZES4IfjgUi4VBUWlng65mw8
         8FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1WWEUvnMjs5fUymJpL74+Mkojs1oxn/NtiIZL/uohY=;
        b=IRSgw8JhRas3hQRZyRWHRDooHC17EsmdBp31qKBvp3VcVs1/aMfNpY7wynHSYLbiPm
         cGVUmt1IkRPHE7vCNY1PR64sHbvDaHWL+0JjLonZORi8HUSWznCjWg+vT/DY5fNtKr+L
         Z1R0BmSYYIXEg765IUNTiZvL01uvi/scoRYW8NT3thzqIgZBG0GDJkru8nX8q94yEBTx
         ImJMX4fgliX8vpPeDLzny30Hlm0fdjwm/xS7a8LrMAc4yTsYjp7H3UNE8a2GOv8JvVoB
         rYOtX2a2oqlUPV723iGzY62IuGTCKDIq9V6lBFbRjHxAIOYlHuVKA3fPPQRhim92H9hE
         NQmQ==
X-Gm-Message-State: AOAM530ufwhr/lV8QHVN/fXbkLNeIefhRH+DG6mGgPufOcFm+gSQ3g91
        P3H8q3TS3qVc4PdkTg1+t1Ibd68uT6GDFmN60Ak=
X-Google-Smtp-Source: ABdhPJzFuTXAo1E3eKRHHyiwE36Wh7a/y1HISuCLneF2Up/eJieZSttT24z0f7GIVKgELfCkfZlBR4kcr+vBx7XQ+Ds=
X-Received: by 2002:a25:4107:: with SMTP id o7mr2644943yba.459.1608057328878;
 Tue, 15 Dec 2020 10:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com> <20201215121816.1048557-3-jackmanb@google.com>
In-Reply-To: <20201215121816.1048557-3-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Dec 2020 10:35:18 -0800
Message-ID: <CAEf4BzaaasZkYK6NtXytoY7gGjbeMi93FyKUpV4OvjqSm4P9tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
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

On Tue, Dec 15, 2020 at 4:18 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> This provides a convenient perf ringbuf -> libbpf ringbuf migration
> path for users of external polling systems. It is analogous to
> perf_buffer__epoll_fd.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Difference from v1: Added entry to libbpf.map.
>

I've already applied this yesterday as a4d2a7ad8683 ("libbpf: Expose
libbpf ring_buffer epoll_fd"), no need to re-send.

>  tools/lib/bpf/libbpf.h   | 1 +
>  tools/lib/bpf/libbpf.map | 1 +
>  tools/lib/bpf/ringbuf.c  | 6 ++++++
>  3 files changed, 8 insertions(+)
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
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7c4126542e2b..7be850271be6 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
>                 btf__new_split;
>                 xsk_setup_xdp_prog;
>                 xsk_socket__update_xskmap;
> +                ring_buffer__epoll_fd;

I've put this in the alphabetic order...

>  } LIBBPF_0.2.0;
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

... and also added const here, btw.

> +{
> +       return rb->epoll_fd;
> +}
>
> base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
> --
> 2.29.2.576.ga3fc446d84-goog
>
