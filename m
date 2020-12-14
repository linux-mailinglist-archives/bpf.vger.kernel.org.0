Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83A22D975B
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394804AbgLNLaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 06:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393351AbgLNLaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 06:30:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32897C0613D3
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 03:29:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c5so12471685wrp.6
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKBOc/54rTuEfLfIwPR538WyqjrILhStLJWcw6gVpQ0=;
        b=bg2OizyVWBvIxQlZDUzsqJObmhh53MgJPyPRJd1zYHSWQx2CnP3a6v7JxFJPh+KpWp
         QWtD1IDRjyld7D/F/UkJ0hUceBAjPMfWdRY51NRCqIwb+G4IdCcY/33RMGHwtHKvk7Rg
         nRh7CR0iixVKGcVMfw3y+R3c05t/o5S32W4rWwYFBEtDnihhKs6rbgo481tg7fD4GFAh
         PVCz23i3THu8/E/hSS4ZoqLH1nUMeTG5nK9882/8NgusRU1xIkVey2ElUrInvnIVD2iK
         W4xh98iFeWi/ApLsZGZGTA+uwKUEZgqoSWYn2NgMyUKSrw0is4LCLZrPvGY6WVwVm79c
         XCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKBOc/54rTuEfLfIwPR538WyqjrILhStLJWcw6gVpQ0=;
        b=e18phqF/6dNkHppzRAi65/W4n0tWXqp+NEAm4lijjBa6lwouIbZddpqwJjwIs4djA5
         MApuh3FhkoxWmX36Pqgpo1L0USbazpbK9PIvYxzOERjihgva5wVX7czp88k+CofyEyir
         A0wJhvdfHBHbdwKnS7CrbgDIWeCwJsw7HhEguVwhna77LhWzUxfWIyBI+LmLgeMyCmPO
         J/736CCBOj5biEdsUuP4B5tGR8S2TsHsZVwzxM0Aj3BnwxDy/QsNfFkzmkROSQF2boNk
         EUkMF+Nsz+Y+0z/d1C+Qcx13zZW3XF4d+wzXnjc3U/greh4JFOAYpAnXm1ZpmGTYdOVd
         qpGw==
X-Gm-Message-State: AOAM530xO09WQ2TN7Hm5DuMkjdZ+Doowk84dV7f1nRiiHPPvhgvEerqB
        kO81lE62zkGLISnAjO7vmzsKhUCEg7gb+Q==
X-Google-Smtp-Source: ABdhPJybwa1V9GSOdU/Znt8LkgWnoXR3CQFThhJjRovuxhjiFsp1Y9MLfUqCTxA5gWjaj7GHAi09cg==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr28813812wrn.408.1607945381616;
        Mon, 14 Dec 2020 03:29:41 -0800 (PST)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id d191sm30233491wmd.24.2020.12.14.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:29:40 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:29:36 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Expose libbpf ringbufer epoll_fd
Message-ID: <X9dMoJtsQA2zgZra@google.com>
References: <20201211172409.1918341-1-jackmanb@google.com>
 <CAEf4BzYTKQR9cPHaiPe6DMSpUo+_LKa2qmGMZX+V7Mhf5UzT5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYTKQR9cPHaiPe6DMSpUo+_LKa2qmGMZX+V7Mhf5UzT5w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 11, 2020 at 11:44:41AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 11, 2020 at 10:58 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > This allows the user to do their own manual polling in more
> > complicated setups.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> 
> perf_buffer has it, so it's good for consistency. In practice, though,
> I'd expect anyone who needs more complicated polling to use ring buf's
> map FD directly on their instance of epoll. Doesn't that work for you?

Yep, thanks - on closer inspection I think that would be a better
eventual solution.  However this API provides a convenient migration
path. I suspect it's a similar situation to what motivated
perf_buffer__epoll_fd in commit dca5612f8eb9d.

> Regardless, though, you need to add the API into libbpf.map file first.

Ack, will send a v2. I guess this falls into Linus description of 'happy
sending it in this upcoming week' for the 5.10 window so I'll put it in
libbpf 0.3.0.

> >  tools/lib/bpf/libbpf.h  | 1 +
> >  tools/lib/bpf/ringbuf.c | 6 ++++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 6909ee81113a..cde07f64771e 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -536,6 +536,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >                                 ring_buffer_sample_fn sample_cb, void *ctx);
> >  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> >  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> > +LIBBPF_API int ring_buffer__epoll_fd(struct ring_buffer *rb);
> >
> >  /* Perf buffer APIs */
> >  struct perf_buffer;
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 5c6522c89af1..45a36648b403 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -282,3 +282,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
> >         }
> >         return cnt < 0 ? -errno : res;
> >  }
> > +
> > +/* Get an fd that can be used to sleep until data is available in the ring(s) */
> > +int ring_buffer__epoll_fd(struct ring_buffer *rb)
> > +{
> > +       return rb->epoll_fd;
> > +}
> >
> > base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
