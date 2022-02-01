Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE54A658E
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiBAURu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbiBAURt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:17:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0EEC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:17:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3816313pjp.0
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwBCSnCCzUrn1U9jsc6LiigvHAh+jLOqf16IvcLLCyc=;
        b=SXIUfBmEd3u6dftdc44NpRlcovK5cgZyRyyPGIF0VXl1riPnIFN67+s3HKgqWt2vFp
         7NMbCXlGDqm120YIWDj6oTanDRLl973VMPAYUbrRYEtmaWj+mmoHV2mBBhgfdd5cBYDT
         vIVPNbqlv+lxD2WOdP62Txb+UAaQ4t4PJj0ILKWExdSY+tOiE1WVuObEFPfvUmU/l8YA
         rMdh7ooBvj0cpMJlLAo14xanD805aGm4AvPRR12rCTvzy7PoIJGDq6CY8hR1vH3B6kYR
         MqiRSHfTO5RablGfjg4I1MP1fED0A+4o44z8JPEwAQoL94WcXjvqSV23ofNr+u8QHtLa
         Tsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwBCSnCCzUrn1U9jsc6LiigvHAh+jLOqf16IvcLLCyc=;
        b=rEMPDenoi5KkgIqzrSlVUOQgQmrqMOt+GVmmY8Z8+/a6E3FaXdSK1t6maJFzwsW6z0
         pUrVLLBuEzWhZ3ehjAXCn9KUoBm6qcuWASkMf6oB14sEpn1mZAHBacRiLYbCeEIF4Hkj
         x+fyS37VMpf6QFVhFEWThSiqU9XcULO1H/FC213mzH29HgNyxmRcPmstAPS9rHbI59/I
         gQ7XAg4KbZR9dn+wyn+BlWi2iEHD0VXWTVJtNxQqSF4zgURmN7KuzC6LBxjPJeXlUqEI
         f2kVlMLwjgef4z8DIPSoyc1ojQBVOBzzzTo7R+43ilkvF5dH/OecMf67EBZPY53UvzEP
         G04w==
X-Gm-Message-State: AOAM530jJKAQBxMW+pE5Ys1aM2+m6y18hGIsr9G0sBm+LRpD6OrN6u0l
        jGX6DCH1t6CeIrkz7OLpLUOWo+M5xQXDagIF5Bw=
X-Google-Smtp-Source: ABdhPJz6FcJYF6Uyejd1HydpMd7yH9nH6yWXV0nKJeKD8JzJypqwL/D/j4qbnIqFj7qut4fLfECnmD3JUQ1PTbkdqY8=
X-Received: by 2002:a17:902:e54c:: with SMTP id n12mr26826404plf.78.1643746669174;
 Tue, 01 Feb 2022 12:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <20220126214809.3868787-5-kuifeng@fb.com>
 <CAEf4BzaLaPfnYTQppVq1ixACLQJcDWYyjMRD42YuQFMUb4rLDA@mail.gmail.com>
In-Reply-To: <CAEf4BzaLaPfnYTQppVq1ixACLQJcDWYyjMRD42YuQFMUb4rLDA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Feb 2022 12:17:37 -0800
Message-ID: <CAADnVQKEQFhkcnQLqNWDkmtyBq-35UkPGf0Rcj3BtFXCZQXLQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: Attach a cookie to a BPF program.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 10:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> >  struct bpf_array_aux {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 16a7574292a5..3fa27346ab4b 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1425,6 +1425,7 @@ union bpf_attr {
> >         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
> >                 __u64 name;
> >                 __u32 prog_fd;
> > +               __u64 bpf_cookie;
> >         } raw_tracepoint;
> >
>
> As an aside, Alexei, should we bite a bullet and allow attaching
> raw_tp, fentry/fexit, and other tracing prog attachment through the
> LINK_CREATE command? BPF_RAW_TRACEPOINT_OPEN makes little sense for
> anything but raw_tp programs.

raw_tp_open is used for raw_tp, tp_btf, lsm, fentry.
iirc it's creating a normal bpf_link underneath.
link_create doesn't exist for raw_tp and friends,
so this is the best place to add a cookie.
We can add an alias cmd (instead of raw_tp_open)
to make it a bit cleaner from uapi naming pov.
We can allow link_create to do the attach in all those cases as well,
but it's a different discussion.
link_create.perf_event.bpf_cookie isn't the best name.
That name was a cause of confusion for me.
I thought it applies to perf_event only,
but it's for kuprobe too.
So plenty of bikeshedding to do if we decide to do
link_create for raw_tp. Hence, for now, I'd add a cookie to
raw_tp/tp_btf/lsm/fentry like this patch is doing.
