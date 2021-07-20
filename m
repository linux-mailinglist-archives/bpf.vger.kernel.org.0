Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3370D3D01D9
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhGTSCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhGTSCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 14:02:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8404C061762
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 11:43:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so116696wmq.3
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0JG7RUcBoSxlQgScK4tXTDK4hQK4CAab6KB4pPNlfE=;
        b=eISU/vW2BdVHQNC3zl/KZ2Q17ivOvcD445b7Z4xQBhPdICxxgvw6viBtTlS/5ztzm4
         98RlGQriOQbfdb8qwHyW6TkClztan43ZYN5XwBDxvhz8cEqONTbixuNbvb1bKkgCLAEC
         ZrIXhEoAXkeCV5HZgEJvSENi3+QYql6ebowAIVvIL2wvEl/EHbk8tSGwJEovPQckYYSX
         rT7h42RxIXTcXDWDyuQr7MqjXrqmBmvmFyuzNZUvJ2PXuWXSrfBW6og3Vvm4v6J0//W3
         59lPMN62lQrGavMZBXcpku+vDpCMqgJY1MPjCWB2R7hukoNtYOYvo7clYSfSVDUw1QIC
         1pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0JG7RUcBoSxlQgScK4tXTDK4hQK4CAab6KB4pPNlfE=;
        b=jPu+skPhITyZTOo4V7gRUAFGPjWnLPkPGlt3tm9i1qZxmvXV3SPjOo4TIimNeQvaO6
         HtVr98uOEkPoHoLRBOTz7BTWYlagC/A4lnIsEzf6zo646GO2I9pLVLT6r/f0GrApcnnI
         1kOCNqT2wykmYKdwzoLseJQJECqHbhs3SZeQ5p0MfQBT5em5P207BPpTBpd/2gh1mjyG
         NMPBXqFsuLvq+Mba6xv9d2lNrWjjEFsQhhWfT2vGrXHVwre+wX1gs/1/ssubbY9aTI3s
         BvE2U2By9GBG7cFfi4CnkvM+ZkKZbU0qDDOerBt4ype+Rj++K9aRe03I3wnTYDrTnKI7
         riNg==
X-Gm-Message-State: AOAM531fnxeV9POnXqjdmQCyzvfeGt5XCUrU40fLgjieBzKbehmIq0Ya
        dzArNVE5dhYzPX21rkMw4paO8GH5GOjgNw8u+1dbyQ==
X-Google-Smtp-Source: ABdhPJxHAg5kwm++HDia0tzF4oJAiNObsuLxBJyiYT+4+osWFuZA0OtPJx9zsrUqy4L/1dpTfpRYZV/uC4/8B5Dre48=
X-Received: by 2002:a7b:ce82:: with SMTP id q2mr38485181wmj.60.1626806583773;
 Tue, 20 Jul 2021 11:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210701200535.1033513-1-kafai@fb.com> <CAADnVQ+Y4YFoctqKjFMgx1OXknAttup10npCEc1d1kjrQVp40w@mail.gmail.com>
 <CAADnVQ+RYgHYO=aJwoh7C_=CeX+nwYopb+pk=Pp709Z-WwQnPw@mail.gmail.com>
In-Reply-To: <CAADnVQ+RYgHYO=aJwoh7C_=CeX+nwYopb+pk=Pp709Z-WwQnPw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 20 Jul 2021 20:42:50 +0200
Message-ID: <CANn89iKjP6xaax7c2mr5NE-AWCkHehH3NQXWyGbt=TP95zq7yg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/8] bpf: Allow bpf tcp iter to do bpf_(get|set)sockopt
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi there.

I was indeed on vacation, but I am back, and done with my netdev presentation :)

I will take a look, thanks !

On Tue, Jul 20, 2021 at 8:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 14, 2021 at 6:29 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 1, 2021 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > This set is to allow bpf tcp iter to call bpf_(get|set)sockopt.
> > >
> > > With bpf-tcp-cc, new algo rollout happens more often.  Instead of
> > > restarting the applications to pick up the new tcp-cc, this set
> > > allows the bpf tcp iter to call bpf_(get|set)sockopt(TCP_CONGESTION).
> > > It is not limited to TCP_CONGESTION, the bpf tcp iter can call
> > > bpf_(get|set)sockopt() with other options.  The bpf tcp iter can read
> > > into all the fields of a tcp_sock, so there is a lot of flexibility
> > > to select the desired sk to do setsockopt(), e.g. it can test for
> > > TCP_LISTEN only and leave the established connections untouched,
> > > or check the addr/port, or check the current tcp-cc name, ...etc.
> > >
> > > Patch 1-4 are some cleanup and prep work in the tcp and bpf seq_file.
> > >
> > > Patch 5 is to have the tcp seq_file iterate on the
> > > port+addr lhash2 instead of the port only listening_hash.
> > ...
> > >  include/linux/bpf.h                           |   8 +
> > >  include/net/inet_hashtables.h                 |   6 +
> > >  include/net/tcp.h                             |   1 -
> > >  kernel/bpf/bpf_iter.c                         |  22 +
> > >  kernel/trace/bpf_trace.c                      |   7 +-
> > >  net/core/filter.c                             |  34 ++
> > >  net/ipv4/tcp_ipv4.c                           | 410 ++++++++++++++----
> >
> > Eric,
> >
> > Could you please review this set where it touches inet bits?
> > I've looked a few times and it all looks fine to me, but I'm no expert
> > in those parts.
>
> Eric,
>
> ping!
> If you're on vacation or something I'm inclined to land the patches
> and let Martin address your review feedback in follow up patches.
>
> Thanks
