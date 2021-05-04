Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA37B3727B0
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEDJCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDJCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 05:02:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97FC061574
        for <bpf@vger.kernel.org>; Tue,  4 May 2021 02:01:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m12so12029858eja.2
        for <bpf@vger.kernel.org>; Tue, 04 May 2021 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BEtiHEyLUH0pHUzx4+zlxAJRANLxFJIE2T50Nx0vuQ=;
        b=eEhoA9OgAL3QwPqmzGoQ5J/vgDLmh59eBzeVStjZNQFW1WVZ7zmwHYS4bHjqXROkTJ
         oz9wR9HvE5nssKpODv77U8N+v1YdmKuEaYFNpob0ThWN/GzKV0lGeB4Q6e52PnxfV4k2
         Utlh6DJhVA+lhxwTqFyi88TlVxIIfwnm/io1tuMqEFrzApTRouEvUi1tJZ+CJZoXmEIR
         SUh43X7p+a1UL5HScIFnrFISbnOvhM1nvBXBcHv/pNgv1t84V0N5MuRleVz4X98zWEHE
         /E+vfo6TZ2AVLoLOIreuY5fkfEm/6FMoskfOlT/YIL/fXNZg0Nh0uu7KWEe7Vt0Svbg6
         C45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BEtiHEyLUH0pHUzx4+zlxAJRANLxFJIE2T50Nx0vuQ=;
        b=n/7mSgZiuC3ZGatvERE4jTLIKw0bK2LMhPU1MDZTmWZ2Q/sE9mLwJ0a/A6GyTqbSTR
         ACNXk2YQnkzxtnXZqjkktzx+VNfUTIW9ce8UoR4Rz/q5Y+p8Xj3t+JrGVg1wkhGlYN8J
         1NF12Zuq/bwZgqcEhSZ1Ag8vw3ZGt2hfi8gG5RZr126FXK8jnI8YY2sWRuVNAwO18C9z
         RKsRgsiencpzw67De9EustbYJKD7g4mMbX7Lux54Lj17ENfT3Q0DR/W0DXN8p7ka5yys
         Hk4MNdAG9XEN7xpeWotlsUvDp1WZ0AqnIi2Azb6CIUsNeTDy/Jh2xii5xvp2FFJ/g40k
         lWqw==
X-Gm-Message-State: AOAM533sejmDCjvlnDQ66oZkTKL9tG9clgXAKktxiBO8aIbntdo3z9cI
        plWGW9hS4+UC7ByvUvmETN8ui79Lrx0uGfVcXUhs1mfvMd5wDw==
X-Google-Smtp-Source: ABdhPJwYCCkP7QeC+gMHOoz7QkyDAFfSnVjkkSq44sDb0VpvaWMaw/HktvAxD5fp5zv08oi0tdNeJzF2poAgNO49GpE=
X-Received: by 2002:a17:906:2559:: with SMTP id j25mr20412002ejb.42.1620118904443;
 Tue, 04 May 2021 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
 <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com> <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com>
In-Reply-To: <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 4 May 2021 11:01:33 +0200
Message-ID: <CA+i-1C1V4b3LvB+pwDn5zomGG1ehSppX=r6TMfPutbgaoG_53Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 3 May 2021 at 19:46, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 3, 2021 at 5:01 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> So while doing that I noticed that you didn't fix ring_buffer__poll(),
> so I had to fix it up a bit more extensively. Please check the end
> result in bpf tree and let me know if there are any problems with it:
>
> 2a30f9440640 ("libbpf: Fix signed overflow in ringbuf_process_ring")

Ah, thanks for that. Yep, the additional fix looks good to me.

I think it actually fixes another very niche issue:

 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
-       int i, cnt, err, res = 0;
+       int i, cnt;
+       int64_t err, res = 0;

        cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
+       if (cnt < 0)
+               return -errno;
+
        for (i = 0; i < cnt; i++) {
                __u32 ring_id = rb->events[i].data.fd;
                struct ring *ring = &rb->rings[ring_id];
@@ -280,7 +290,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int
timeout_ms)
                        return err;
                res += err;
        }
-       return cnt < 0 ? -errno : res;

If the callback returns an error but errno is 0 this fails to report the error.

errno(3) says "the value of errno is never set to zero by any system
call or library function" but then describes a scenario where an
application might usefully set it to zero itself. Maybe it can also be
0 in new threads, depending on your metaphysical interpretation of "by
a system call or library function".

+       if (res > INT_MAX)
+               return INT_MAX;
+       return res;
