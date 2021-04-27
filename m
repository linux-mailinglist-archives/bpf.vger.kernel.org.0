Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1314536CDE5
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 23:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhD0VfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhD0VfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 17:35:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A9AC061574;
        Tue, 27 Apr 2021 14:34:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so71173977ybi.12;
        Tue, 27 Apr 2021 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsQ19BQZ7BYI6oxOmcTVL+nfuau2yGAWJogNYnlPUJA=;
        b=ZKCZoqaL8Y58veyVy1diVyoL4KWEQe2UG2r5xTR3zujDOTNNg9lq2KADdJDoM3jYOs
         wTQ55gOe/wvEm1sXFVrg0tRCL3Y/7vyrvTAM2an9+YAGedSjYK66CNgD1jJO04zaoKhb
         3MLzEfvMINJFzwmfvVVvm3FXPsgqpwKsGfgU4lzKsrvoG3aUZ9HA7kuYAnE8smvtqrWY
         JGxCmp7GGXk+TXPfgZHrbCfyj/5V4+BCtrvdUIX8P2w+/AWL5M5NiCTZiJq4BQIt4xRQ
         fpyImymHcF7YT8OzkN0W2guplscdeqArz05qp3ZyWig+Z6cD/UARp3ne5lQMJDlJYROI
         9xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsQ19BQZ7BYI6oxOmcTVL+nfuau2yGAWJogNYnlPUJA=;
        b=jAqueK5v58Tsmb1bIKCPKP3fbzL0uJmJ3KWDmXqmkFR5JmL/gEWr+Nd6EH0U+DPi3Q
         ugEAN24jCsCrHLwvTZINdlUjnK4ODjKLIw5WKPfYfilEI1MkTHu+aq+MdKFurTMeSN4Z
         kkPsZJFB56c003QeY0Pfrf9ChRIf01SQ6axGBKzcJAsmvDcc3Y5dg6BVIvYNQ2xASVIe
         NVHjF2DBARpX3W26N75DdhtEAoBMJuh93stjuTpbNpP/SoYJ0Y+am7xj7cbCqFIN+wst
         g5aOcO+WhlmX9r1KrwzROqgwsRPif13nlK0PWYcKpDuJydm+uzo9uCkUt5NKcEHuFnbm
         LS6A==
X-Gm-Message-State: AOAM531mXdsVZvpl7rpQITIDLH6mk05DJF7ahylGc7VNh2TJMSHoK4z3
        IAqnBdftTXMfKugs1b9ywMZcEysqguxcOkuviZo=
X-Google-Smtp-Source: ABdhPJxBlSyJL2+xE2UXkyPjIK7DmBFlqEqKixhRYFli9RtlAQlK3/WMuGjEzra5efgJBgMnQjEUzrOOWKIOl3BwT9E=
X-Received: by 2002:a25:7507:: with SMTP id q7mr15048566ybc.27.1619559261570;
 Tue, 27 Apr 2021 14:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com>
In-Reply-To: <20210427170859.579924-1-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Apr 2021 14:34:10 -0700
Message-ID: <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 10:09 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> One of our benchmarks running in (Google-internal) CI pushes data
> through the ringbuf faster than userspace is able to consume
> it. In this case it seems we're actually able to get >INT_MAX entries
> in a single ringbuf_buffer__consume call. ASAN detected that cnt
> overflows in this case.
>
> Fix by just setting a limit on the number of entries that can be
> consumed.
>
> Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/lib/bpf/ringbuf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index e7a8d847161f..445a21df0934 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
>         do {
>                 got_new_data = false;
>                 prod_pos = smp_load_acquire(r->producer_pos);
> -               while (cons_pos < prod_pos) {
> +               /* Don't read more than INT_MAX, or the return vale won't make sense. */
> +               while (cons_pos < prod_pos && cnt < INT_MAX) {

ring_buffer__pool() is assumed to not return until all the enqueued
messages are consumed. That's the requirement for the "adaptive"
notification scheme to work properly. So this will break that and
cause the next ring_buffer__pool() to never wake up.

We could use __u64 internally and then cap it to INT_MAX on return
maybe? But honestly, this sounds like an artificial corner case, if
you are producing data faster than you can consume it and it goes
beyond INT_MAX, something is seriously broken in your application and
you have more important things to handle :)

>                         len_ptr = r->data + (cons_pos & r->mask);
>                         len = smp_load_acquire(len_ptr);
>
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
