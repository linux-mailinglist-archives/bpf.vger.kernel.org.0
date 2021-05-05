Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1968373342
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhEEAij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEEAij (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 20:38:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CBAC061574;
        Tue,  4 May 2021 17:37:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z1so466741ybf.6;
        Tue, 04 May 2021 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZ6UQO/t/anayyvxHYL8y/BSgNgKydNeCjijU78LDB0=;
        b=hTrd2XUlYhsfMMGGIx5klGnci50oDrRl0xMOhc7gSeBJ6JyUSZSgBRRcYDumzNziIN
         EW5jBXVq223SV2a2bUU3WoIC2DwuDg5vWWm5sxYcwOcg1nDU3F/lctBBfvTbHTFoxASa
         ULAT2IF1dTAC+zmX7fZNwTcLNckpJtwUJ4+wntOO3gx/MlKWZgPbwVDAEtAcwEMesfWu
         p/H9/NmzXx0tqku0UN23HP3r4o/La/tBByaHFsGTe5yFG6uoXGnqmdXYAyYWVzKSBE61
         x8EXnsRW67ETjsqK/6yFzR8w7Z5BICLypDRkgtNRZg6RuYY1nGehmrqkvHgApzUrVEtp
         MSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ6UQO/t/anayyvxHYL8y/BSgNgKydNeCjijU78LDB0=;
        b=PS2LyAhrRBXCR9FTkdVfGzfh1IG0e7iVCHVWQz4R4uDsVE3U1vrUb+SOzSc+hyDNrN
         QZcGK97UTR9m2STN45Z/AixGG8j3iIXTaUO/9RY7AHyB85akUtW0UoTwBoXn1tqAqizn
         8zrUm13bMxc+BZEQ/57h1Y2zisPQiYb215CodhU5JfFMr9y9qXLgqd6eV7QYzNQTvnh+
         XCKDPhE06livCavy/2D5NZ9DRQEY8/cDRKUmAhohSdmcajx+maI35JmmTGVUdrLhWT6q
         zO0vgrmo6gaJgw1ipXdgTCK6/0BwUwqjgHMk0joVA7z2+Jm134ejP4rv0EhwKJaquOBX
         zsvg==
X-Gm-Message-State: AOAM531LGCR5RcL8NfPWU5AiDEj0hGc+wc7VbSpDB6lP7v/BhJxlth9y
        6abGEQLiQRpOxO2DkB1G7IG50Zl4PzJGwO739J7rhma1
X-Google-Smtp-Source: ABdhPJyyONDl3K01zcGdj6oYMRlUtnCxG36FjryB+ubEE2VbFeOxgGehiFhaGcrhhos2lFw5JA54ckYwgpAgywOogj0=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr36960466ybf.425.1620175062113;
 Tue, 04 May 2021 17:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
 <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com>
 <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com> <CA+i-1C1V4b3LvB+pwDn5zomGG1ehSppX=r6TMfPutbgaoG_53Q@mail.gmail.com>
In-Reply-To: <CA+i-1C1V4b3LvB+pwDn5zomGG1ehSppX=r6TMfPutbgaoG_53Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 May 2021 17:37:31 -0700
Message-ID: <CAEf4BzZ-qxd9Xb11zWetKaPpG+sYiF6D1c9+gc3L3BevBrhTYg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Brendan Jackman <jackmanb@google.com>
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

On Tue, May 4, 2021 at 2:01 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, 3 May 2021 at 19:46, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 3, 2021 at 5:01 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > So while doing that I noticed that you didn't fix ring_buffer__poll(),
> > so I had to fix it up a bit more extensively. Please check the end
> > result in bpf tree and let me know if there are any problems with it:
> >
> > 2a30f9440640 ("libbpf: Fix signed overflow in ringbuf_process_ring")
>
> Ah, thanks for that. Yep, the additional fix looks good to me.
>
> I think it actually fixes another very niche issue:
>
>  int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>  {
> -       int i, cnt, err, res = 0;
> +       int i, cnt;
> +       int64_t err, res = 0;
>
>         cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
> +       if (cnt < 0)
> +               return -errno;
> +
>         for (i = 0; i < cnt; i++) {
>                 __u32 ring_id = rb->events[i].data.fd;
>                 struct ring *ring = &rb->rings[ring_id];
> @@ -280,7 +290,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int
> timeout_ms)
>                         return err;
>                 res += err;
>         }
> -       return cnt < 0 ? -errno : res;
>
> If the callback returns an error but errno is 0 this fails to report the error.

Yeah, there was no need to be clever about that. Explicit if (cnt < 0)
check is obvious and correct.

>
> errno(3) says "the value of errno is never set to zero by any system
> call or library function" but then describes a scenario where an
> application might usefully set it to zero itself. Maybe it can also be
> 0 in new threads, depending on your metaphysical interpretation of "by
> a system call or library function".
>
> +       if (res > INT_MAX)
> +               return INT_MAX;
> +       return res;
