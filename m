Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C853B9330
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhGAO0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhGAO0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Jul 2021 10:26:02 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24ACC061764
        for <bpf@vger.kernel.org>; Thu,  1 Jul 2021 07:23:31 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id n61so2519463uan.2
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZYZZPLtxm0D8wKCq6t4+Fy+RhxhZRnjK7G5sIibVAY=;
        b=kBv9cdGrIayWfMzZazwxNI9/duBTp2RkiZ5RCpTGoMmI4sxwPfmxtyqijgoC6eFaHP
         vuY6nQPmSg0rBx1F6AnU3iGjJXVrIv6hMPT5BDZnXtJ8kZ6ta2AKfwvSzsQiBoGDBLxe
         Dmi2eQ+66de1aSZjyItIFwNWh1cy7b6EjIO393RJPGKNXebp3P4Yx/mAegF28z7zxu3H
         LLjGSN1TkEEC2gynwHgOJdUg1KIDxVmNmxUfSOg+YNg1SDUVOYC9QVrLdvNk9oHHIut5
         NEaw07sNcTuAQPUw2+IKV8UcC+TCiR2ZQmvtrZRt2mROer1FgbKX1f54BG6f/nPVo19B
         +X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZYZZPLtxm0D8wKCq6t4+Fy+RhxhZRnjK7G5sIibVAY=;
        b=UG/syKCr6xczGGUNDIUymEYIwMirRGoiwrQswy4b6tNSfIp5EKAzzlpqdr6m28av7z
         /Zfz2oVlZM8T75yZCm+4D7YBAdrlmTb6ZmX7138w7ow6EEvPAKasntq8XWzCB2DsU/nS
         F+0SqSmgr5Jhb08Quge5bi4K43/KDJ6UhljLKMCUyqjJ7rJtEg+yVI0/JAidVuP/M9Wt
         UsJz6XnYzpoWB+9DkYnCTu2zWOX+Grg79JFwnFnig1BI/nPmZ/hQ39jnxXl6x3xTRa/o
         rGqRy2LP2QqPmXd0EDIjffzAm1vCncrsFEDX0easI0dCF7yPRTCa9ek44UgEenZ4jxIX
         /jiQ==
X-Gm-Message-State: AOAM532cLbjnKzM1FE2av713EkDk7XFSFm6DKL0ydbfoMVTAXtZu61AI
        5On3haEYxMeZ8+vXIPYSIbYb3hq1X4FVRbUBsKDRgw==
X-Google-Smtp-Source: ABdhPJx2oBw+TeBECEm0/q5V+pChm69gVODCsQXZeTvzl9jaJ3WWW/V23J8lrJcxwiS1GyjoBORkKFEfajqRXSJj0AE=
X-Received: by 2002:ab0:3ae:: with SMTP id 43mr211048uau.63.1625149409711;
 Thu, 01 Jul 2021 07:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210628144908.881499-1-phind.uet@gmail.com> <CANn89iJ6M2WFS3B+sSOysekScUFmO9q5YHxgHGsbozbvkW9ivg@mail.gmail.com>
 <79490158-e6d1-aabf-64aa-154b71205c74@gmail.com> <CADVnQy=Q9W=Vxu81ctPLx08D=ALnHBXGr0c4BLtQGxwQE+yjRg@mail.gmail.com>
 <ee5ef69e-ee3f-1df0-2033-5adc06a46b9c@gmail.com> <CADVnQynqMQhO4cBON=xUCkne9-E1hze3naMZZ8tQ-a0k71kh8g@mail.gmail.com>
 <205F52AB-4A5B-4953-B97E-17E7CACBBCD8@gmail.com> <CANn89iJbquZ=tVBRg7JNR8pB106UY4Xvi7zkPVn0Uov9sj8akg@mail.gmail.com>
 <1786BBEE-9C7B-45B2-B451-F535ABB804EF@gmail.com> <CANn89iK4Qwf0ezWac3Cn1xWN_Hw+-QL-+H8YmDm4cZP=FH+MTQ@mail.gmail.com>
 <CADVnQyk9maCc+tJ4-b6kufcBES9+Y2KpHPZadXssoVWX=Xr1Vw@mail.gmail.com> <30527e25-dd66-da7a-7344-494b4539abf7@gmail.com>
In-Reply-To: <30527e25-dd66-da7a-7344-494b4539abf7@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 1 Jul 2021 10:23:13 -0400
Message-ID: <CADVnQyn_965EHdQke_S7FUySiamyyRx-3b8o+cm+=4jYxG_GOw@mail.gmail.com>
Subject: Re: [PATCH] tcp: Do not reset the icsk_ca_initialized in tcp_init_transfer.
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 30, 2021 at 2:25 PM Phi Nguyen <phind.uet@gmail.com> wrote:
>
> On 6/29/2021 11:59 PM, Neal Cardwell wrote:
> >    On Tue, Jun 29, 2021 at 8:58 AM Eric Dumazet <edumazet@google.com> wrote:
> >  From my perspective, the bug was introduced when that 8919a9b31eb4
> > commit introduced icsk_ca_initialized and set icsk_ca_initialized to 0
> > in tcp_init_transfer(), missing the possibility that a process could
> > call setsockopt(TCP_CONGESTION)  in state TCP_SYN_SENT (i.e. after the
> > connect() or TFO open sendmsg()), which would call
> > tcp_init_congestion_control(). The 8919a9b31eb4 commit did not intend
> > to reset any initialization that the user had already explicitly made;
> > it just missed the possibility of that particular sequence (which
> > syzkaller managed to find!).
> >
> >> Although I am not sure what happens at accept() time when the listener
> >> socket is cloned.
> >
> > It seems that for listener sockets, they cannot initialize their CC
> > module state, because there is no way for them to reach
> > tcp_init_congestion_control(), since:
> >
> > (a) tcp_set_congestion_control() -> tcp_reinit_congestion_control()
> > will not call tcp_init_congestion_control() on a socket in CLOSE or
> > LISTEN
> >
> > (b) tcp_init_transfer() -> tcp_init_congestion_control() can only
> > happen for established sockets and successful TFO SYN_RECV sockets
> Is this what was mentioned in this commit ce69e563b325(tcp: make sure
> listeners don't initialize congestion-control state)

Yes, exactly.

> > --
> > [PATCH] tcp: fix tcp_init_transfer() to not reset icsk_ca_initialized
> >
> > This commit fixes a bug (found by syzkaller) that could cause spurious
> > double-initializations for congestion control modules, which could cause memory
> > leaks orother problems for congestion control modules (like CDG) that allocate
> > memory in their init functions.
> >
> > The buggy scenario constructed by syzkaller was something like:
> >
> > (1) create a TCP socket
> > (2) initiate a TFO connect via sendto()
> > (3) while socket is in TCP_SYN_SENT, call setsockopt(TCP_CONGESTION),
> >      which calls:
> >         tcp_set_congestion_control() ->
> >           tcp_reinit_congestion_control() ->
> >             tcp_init_congestion_control()
> > (4) receive ACK, connection is established, call tcp_init_transfer(),
> >      set icsk_ca_initialized=0 (without first calling cc->release()),
> >      call tcp_init_congestion_control() again.
> >
> > Note that in this sequence tcp_init_congestion_control() is called twice
> > without a cc->release() call in between. Thus, for CC modules that allocate
> > memory in their init() function, e.g, CDG, a memory leak may occur. The
> > syzkaller tool managed to find a reproducer that triggered such a leak in CDG.
> >
> > The bug was introduced when that 8919a9b31eb4 commit introduced
> > icsk_ca_initialized and set icsk_ca_initialized to 0 in tcp_init_transfer(),
> > missing the possibility for a sequence like the one above, where a process
> > could call setsockopt(TCP_CONGESTION) in state TCP_SYN_SENT (i.e. after the
> > connect() or TFO open sendmsg()), which would call
> > tcp_init_congestion_control(). The 8919a9b31eb4 commit did not intend to reset
> > any initialization that the user had already explicitly made; it just missed
> > the possibility of that particular sequence (which syzkaller managed to find).
>
> Could I use your commit message when I resubmit patch?

Yes, feel free to use that commit message verbatim or modified.

thanks,
neal
