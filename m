Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F297400861
	for <lists+bpf@lfdr.de>; Sat,  4 Sep 2021 01:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbhICXpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 19:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhICXp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 19:45:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E8C061575
        for <bpf@vger.kernel.org>; Fri,  3 Sep 2021 16:44:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so688126pfo.12
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xhqf9OXOWyWh29UmDJWsjhes633vEBDxVhEjuay2+iA=;
        b=cvoezng5laklxmiPL9p5dJv72jMbcv7OErvcayTD9FENt/KyAHb8baBenPZYDZNxvw
         O6eAIzlE0SkSXvWeTsCU5jAl26OygkrKbatYJqUgNbJXDlU6OQ24j0zbM1Bhtkm+XfU3
         FPuRous0PFy3191pBBzLI8I4NMuoxoVLZGWi+l1vJSG9AyZ4ZlyowZ7yxHlNRqVJAfz6
         f2gQ6dQ+BRUcmygBIMPONgeCqQk8jJSwpwXezQXyl3FQd1RrtGKRFF2DAFXqqbB0Zm6b
         xWNZ1UCVfYSb5GnqD2YkGUTXJmV4pGV7clsbefc0sOcOJKk/70Du8fadKcHldn0Um9vc
         xV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xhqf9OXOWyWh29UmDJWsjhes633vEBDxVhEjuay2+iA=;
        b=Ow2WJUUfAz8yyyNMg/CPaU0qmFgCdsl3M1Mtr2SzUhdqQ9Dhccy0Tyxc8JWQ4ZSaoI
         B0ejbmnqy5l2Iu17355/kly5XCqhu8xkUq1vkTSAFJrniIIsMJN3CZh88+O00sx9nlxT
         8Be7Ry4X0mfwtLkb/s+nAWvsDxGMqlvCkxWRlI172dnYjuAmZhCpbG538nJmLIHqOABF
         e/0xCnVBQzBlgi0+9qhZeBGw9iEly2gk6K8u1rV4i2Fx/j3wXU78DfJsLvHhSosJAoj2
         NWZE4TRQTCMU0HciZ5Uq10NqY87eJo4SSG7Hqic+9rC3HtDsnIwenGJSEdG3CsM8oYZj
         mQaw==
X-Gm-Message-State: AOAM530Z/fmq8zh/cADx/Yw1re7i65pubyBV6pZ1NjX6rSxwQ2GzfHOB
        +je7rXpTWcPru1x9b3rlXa2d0il3tKcnEQGXPYk=
X-Google-Smtp-Source: ABdhPJyKGJ/LfrFH330bIUDhvgmQr9e7/3ERpcpflv6CV0eeMGVX9JjqeZjAukp8JQndR/68+4DR66DDHSsqk6krXuY=
X-Received: by 2002:a05:6a00:8c3:b0:3fd:4333:897 with SMTP id
 s3-20020a056a0008c300b003fd43330897mr1179225pfu.67.1630712668085; Fri, 03 Sep
 2021 16:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
 <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com> <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com>
In-Reply-To: <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 3 Sep 2021 16:44:16 -0700
Message-ID: <CAM_iQpWt8F18_B5b9cYyT7Ri3sua2T2B5ztEGg2h3v9u2-i+Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 1, 2021 at 8:35 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Wed, Sep 1, 2021 at 9:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 12:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > Like I mentioned before, I suspect there is some delay in one of
> > > the queues on the way or there is a worker wakeup latency.
> > > I will try adding some tracepoints to see if I can capture it.
> > >
> >
> > I tried to revert this patch locally to reproduce the EAGAIN
> > failure, but even after repeating the sockmap_listen test hundreds
> > of times, I didn't see any failure here.
> >
> > If you are still interested in this issue, I'd suggest you adding some
> > tracepoints to see what happens to kworker or the packet queues.
> >
> > It does not look like a sockmap bug, otherwise I would be able to
> > reproduce it here.
> >
>
> Cong, the issue is not that read() sometimes returns EAGAIN.
>
> It is that when using select on the redirected socket,  it will hang forever.

Hmm? We don't use any select(), do we? Before your patch, I used
a for loop. With your patch, it is a loop with usleep().

Actually I just reproduced this EAGAIN issue here. I ran `git revert`
but it didn't actually revert your patch for some reason, so I had to
manually remove those usleep() and finally reproduced it.

I used strace -ttt to get the time spent on 100 times of read(), it is
about 0.2ms in total. However, runqslower shows the kworker wakeup
latency can be 10+ms:

19:29:16 kworker/2:0      19836           14071
19:29:18 kworker/1:0      19836           14369
19:29:20 ksoftirqd/2      19794           12731
19:29:20 kworker/2:0      23              11059
19:29:21 kworker/1:0      19836           11020

So clearly repeating read() for 100 times is too far away from the worst
delay. And the wakeup latency is only part of the packet latency, so in
other words, in the worst scenario a packet can be delayed for more
than 10ms, which is roughly 5000 times of read().

Anyway, this is a not a bug in sockmap, it is a problem of not using
blocking mode in sockmap_listen tests.

Thanks.
