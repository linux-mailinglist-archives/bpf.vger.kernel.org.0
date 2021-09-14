Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4240A5E7
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhINFXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbhINFXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:23:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BCC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:21:47 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z18so25541027ybg.8
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qaf8IpO3Dw6NGHNq4bJoQMBvk9OvC5HucNLLWk8D7f4=;
        b=bu6YOqE5gJVzn0YoDAn1FssZjbx4cdCt4o0qKhN45arH0zncnddZtcBoyAOxGPJ4xB
         eAmVbEDGBHP73BTe3k90c1CXEk/r3BSy2iejcXdDSdPUEgo37Fx35sreW0xBcB9oaZ1j
         8vc0B+XCw8LZ9vrxoa4IBXPfsMDpoLfnedtJClANrg0qghkQHrRLuJNEQLlqNWXRKTtw
         vnTJ1IU9brzevvBF0RMP5OzpE8Zhi+OfNDmXiOXzQgQpeikQoEd6a0oBSegSpuk70PJC
         mQI5L+6xozRrZry9xu2scn4aRUIJ2BKOLKCCBXwKihfPmIeMOEAP3w/WYTBHlKDvZqbB
         Bszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qaf8IpO3Dw6NGHNq4bJoQMBvk9OvC5HucNLLWk8D7f4=;
        b=Q2E+wLN8EuPi0vhorYz9ER8TODvY72QmP7mqJQv0I4PNpAvgt4gA/CUSGH5ofma/mY
         YktGuqge4FK18uC2qdWXmghfW1IIcknFP6IeItrPFYS4BRIwz53E8OpigT/fTBBbdNOb
         8JveIOamHXN6zxRrp4nLxEXUgc7yJn7KjA00TADxddiz84XJ3IgKq385LnWQ0aqN5nox
         uArLE5LsAkzCzMlX4jg3yT3wRBh03jPt64swuDgaYs7Iv3WA9dtB245/sV1s8wXDEzzQ
         dlz3JXPj6lrXa4aGFkI+FbkWuW4elSPIpNp+C3zs6HhDCW6ONa9+DJIPWrnBM0dsNStS
         jZ8w==
X-Gm-Message-State: AOAM53335q6abXv9ulfJ5Wbe3nvQvgNFctPxkx1yQQ8ShaVymJh6cXHM
        DPIpcVs8mpbFY4GD5joVLxQ7ysis1T4JBrIj9yI=
X-Google-Smtp-Source: ABdhPJzQXwgEUvDIWaVgWx2pc8E3nwSI4EAbb21203hv71HnCbVLO5ndIPz0YzCXB+iQ0sMXJT3bCRDUHhwNCGD33OA=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr18610392ybt.433.1631596906721;
 Mon, 13 Sep 2021 22:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com> <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
 <1EEF48CB-0164-40B3-8D56-06EDDAFC5B1E@gmail.com>
In-Reply-To: <1EEF48CB-0164-40B3-8D56-06EDDAFC5B1E@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:21:35 -0700
Message-ID: <CAEf4BzZYEi_FS_UT9Ypp5iNL60t07KT_8DyQaSzSCNN_nfC1NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 10:03 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
>
> >> Allow kprobe tracepoint events creation through legacy interface, as the
> >> kprobe dynamic PMUs support, used by default, was only created in v4.17.
> >>
> >> After commit "bpf: implement minimal BPF perf link", it was allowed that
> >> some extra - to the link - information is accessed through container_of
> >> struct bpf_link. This allows the tracing perf event legacy name, and
> >> information whether it is a retprobe, to be saved outside bpf_link
> >> structure, which would not be optimal.
> >>
> >> This enables CO-RE support for older kernels.
> >>
> >> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> >> ---
> >
> > I've adjusted the commit message a bit (this has nothing to do with
> > CO-RE per se, so I dropped that, for example). Also see my comments
> > below, I've applied all that to your patch while applying, please
> > check them out.
>
> Thanks. I'm assuming you don't need a v6 based on your adjustment comments, let me know if you do please.
>

Nope, I've applied it to bpf-next.

> ...
>
> >>
> >> -       if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
> >> -               err = -errno;
> >> +       ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0);
> >
> > what's the reason for dropping the error check? I kept it, but please
> > let me know if there is any reason to drop it
>
> From: _perf_ioctl() -> case PERF_EVENT_IOC_DISABLE: func = _perf_event_disable;
>
> _perf_ioctl() will always return 0 and func is void (*func)(struct perf_event *).
>

And what about all the future kernels? This is an unnecessary
assumption that it will always succeed.
