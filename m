Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E5371EDB
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhECRrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 13:47:17 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC32C06174A;
        Mon,  3 May 2021 10:46:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i4so8647819ybe.2;
        Mon, 03 May 2021 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61DmlyfSeY6yLCYawyfyAB+9RV3mvk/E1watnYBOyt4=;
        b=NIzJ7pGhABFW2kwxbJ9EkwgYblB66DQlx3vWG5XCnZmfiDtALwIvynEGGkg4bOLrjY
         ExsGaFEElS8M4udyTOcMq/mKQxl6ONSeCKRjQqham9YwI5EPa+km6RwYP+D+8BECR5qD
         +EajlaEf7qzOZZMR0eakjUZcvW14dxi7bbb68eB4GGnVa2EanPuXjdqIPwX54riI/LyI
         NEoVIG7HjW793pdw4vKhRVBQw3jvxK9EtHEzAJGrp51t9ys6scYCeBwCcfRYo6w9H3M+
         nXbNLCg4p0VQ251k2m3l5lcG/qbPzLScMOPwp+cznjz/AuaCzgT24yt3TUK3ieSNVGZ0
         d3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61DmlyfSeY6yLCYawyfyAB+9RV3mvk/E1watnYBOyt4=;
        b=TP8D99DjX/WPo6eHjrxLAP1lBpdGbmb+Z3b2SAvtJAfcCb+A0HmwrF81nZRss9Wl6d
         DsMsNIf1e15AS0S1lC/MFrhMPDkDRGfM+wx1n9jsEOUEDBW7Emty8GGzq7hsU5NWU85V
         pz/GSiwoV08PaDSmmiL9qUThFcTB1oMyIqI4JY/nSDavbtjYe9OHJ1Fay6uGVZ/ITJS+
         GN3Ai7r0axTc91FcRXggfvCZG5wFoiI69ok5FF1oxhYzidejkuWFUWTCAVq7M+oPnenI
         hslF4zsJYVlz69JWj+8ahe4JKlspXYfUuYIFROFWs0r+g7/AqreOgRuLnXHU3XtQv/CD
         Usug==
X-Gm-Message-State: AOAM531kpeTwyr8fF84oHV5zKD2B0VyL0bHTmWqu1KIfxWb8P61UNqG6
        pvqNzfxESBAFkxD+aM+KQWMLQ59IAhLJQLN0b+IjRTukzHQ=
X-Google-Smtp-Source: ABdhPJyBFe2d8eXARV5ezBH/NLtwjodf8LAxaff8eC3BlAOjEmPmg+5f9iQx5hql2Bu4ggKrvC8NflpzVHo/tISwzyo=
X-Received: by 2002:a25:1455:: with SMTP id 82mr28219792ybu.403.1620063982218;
 Mon, 03 May 2021 10:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
 <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com>
In-Reply-To: <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 3 May 2021 10:46:11 -0700
Message-ID: <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com>
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

On Mon, May 3, 2021 at 5:01 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 6:05 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> > > Note: I feel a bit guilty about the fact that this makes the reader
> > > think about implicit conversions. Nobody likes thinking about that.
> > >
> > > But explicit casts don't really help with clarity:
> > >
> > >   return (int)min(cnt, (int64_t)INT_MAX); // ugh
> > >
> >
> > I'd go with
> >
> > if (cnt > INT_MAX)
> >     return INT_MAX;
> >
> > return cnt;
>
> Sure, it has all the same implicit casts/promotions but I guess it's
> clearer anyway.

I might be wrong, but given INT_MAX is defined as

#  define INT_MAX      2147483647

(notice no suffix specifying which type it is), this constant will be
interpreted by compiler as desired type in the given context. So in

if (cnt > INT_MAX)

INT_MAX should be a uint64_t constant. But even if not, it is
up-converted to int64_t with no loss anyway.

>
> > If you don't mind, I can patch it up while applying?
>
> Yes please do, thanks!

So while doing that I noticed that you didn't fix ring_buffer__poll(),
so I had to fix it up a bit more extensively. Please check the end
result in bpf tree and let me know if there are any problems with it:

2a30f9440640 ("libbpf: Fix signed overflow in ringbuf_process_ring")
