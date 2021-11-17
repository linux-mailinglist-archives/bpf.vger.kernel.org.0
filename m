Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66262454CCE
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKQSLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 13:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbhKQSLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 13:11:49 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200EAC061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:08:51 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y68so10166815ybe.1
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNEGdJOfsOjNUTaARAR31UQ+wBKz+ReoN5wkaPk0xFE=;
        b=qnPuDXnFVedv5O1tEfsyz0cTwwxvH7YQ6uHUP/kV3qXeUFPpp0YtzcDxj+Nd+PxYsi
         cv9jXrvQHBUXHVdEIR7vOZ0cJ1ZSEvCwQxPjM2UDymv0nv4eG2NTUs2XspTLm9Yb/ZsB
         ZMmXh3c3eIc4KXk6UJx8TZ25MzCStTpMB03NDbxRowkk0y0lA8vOt4SIwxnnOtSkR595
         YLpNlcSk5mNs+5CKSz7c5hXopQNLAg8nLFBQ4YkXBUb7VWVXinoM/KSVgMMXtcQQ3Qew
         qN6Fgn9ZCptuzvhn68PSCjou9FVfDZAhchcdvtC6+3h3UN6Al4PIxp4/bLdha5xGj8yI
         vaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNEGdJOfsOjNUTaARAR31UQ+wBKz+ReoN5wkaPk0xFE=;
        b=6RtW1FHOHCbZMX7C0wm0AOd/TwGw3QGVsUnoLIg/dK+H5SyNx2iFRLywmrLaklKF4F
         RDH5uduDjU5IKSWQisHRZdI2TACwai7923bd3ZNevl2B9I3muoVUf1XNxpWnx6w7dQqj
         LZwR4QNw9hflIht6GpdblMGpaQN2O1QKsK1u91hTqmewhsP9Uf1eLgvPQ+GcxCdszzZs
         78OdYiWUwgVSJ66fhJ1vgAsDESXeAqC3KiBPEQpMsDq59XiTGV8CgFGq8vfDeu9tJOoN
         AK1SZuwtmu0Vib60lBkBcqUCnnPxfwSAmPTtNcBY/fNU+F9044fcYanDXFll1Wudlhue
         l/7w==
X-Gm-Message-State: AOAM530AsDeCUCMQrFjLatBd1E3TFcLfuaqLapHPz+u8mImxLKY1Hnfz
        9vuP1q1v3yKVAMa6RA7eVn5eCSGbjIASxg38KP0=
X-Google-Smtp-Source: ABdhPJzS0yHfDSt2AATHpFxhOVt4KQn+DyBiwLmMSi2IwelKmjnF+8LHnW05pmhahLY9T6rp2xLzrUgR8NKqW0G4i9o=
X-Received: by 2002:a25:d16:: with SMTP id 22mr20048848ybn.51.1637172527033;
 Wed, 17 Nov 2021 10:08:47 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch> <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
 <6195432baf114_1f40a208aa@john.notmuch>
In-Reply-To: <6195432baf114_1f40a208aa@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Nov 2021 10:08:35 -0800
Message-ID: <CAEf4Bza6HHeVTFxrmPJRUgsLYU7g06MctMoAGy3ayKq8ES9FTQ@mail.gmail.com>
Subject: Re: sockmap test is broken
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 10:00 AM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Sun, Nov 14, 2021 at 9:21 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > >
> > > Alexei Starovoitov wrote:
> > > > test_maps is failing in bpf tree:
> > > >
> > > > $ ./test_maps
> > > > Failed sockmap recv
> > > >
> > > > and causing BPF CI to stay red.
> > > >
> > > > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> > > >
> > > > Please take a look.
> > >
> > > I'll look into it thanks.
> >
> > Any updates, John? Should we just disable test_maps in CI to make it
> > useful again?
>
> I'm debugging this now. Hopefully I'll have a fix shortly (today I hope).
> Maybe, it makes sense to wait for EOD and if I still don't have the fix
> disable it then. Anyways fixing it is top of list now.

Sounds good, let's hope you find it and fix it today.

>
> >
> > >
> > > .John
>
>
