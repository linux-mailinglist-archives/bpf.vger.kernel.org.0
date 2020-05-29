Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B651E84D1
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE2Rbz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2Rb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:31:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D632C008634;
        Fri, 29 May 2020 10:31:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so215118ljn.4;
        Fri, 29 May 2020 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ttnFiSgTFcA9bsBuJjpQ07w9QZNxtFa6q/Uv5VxYCnY=;
        b=VT5wHJ649RlneCJBvi04+KfyfEYKt3LcRfU5tnAXyJkr3GKgdD1md//2dZFtciINqj
         o8djEDfAjQCXIlWpHJR8uOcu8A6CjpEKn3rLDZjj4M/aJMI7/VxKf+ELBwSVwkBBwLCj
         dFTDF+kJ8aUNhPaJZ9gfvE2abgLXqIWEJexWoMKBiOQ9bu6FVH4rPUpOQ5kH7rgG9fKp
         UDd+vHfbS/XJcrttidZox89hP/Y4qOg5DsLrABNAYwPDcH6GzNAB7aMzk5c5BZrpwdq1
         lBz5ZeI546kXlNRK09CCLjn62lzFNVDhmZRPe0DyB4QJ3dCgyFKlW6dlDpDAb+CASbn7
         SG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ttnFiSgTFcA9bsBuJjpQ07w9QZNxtFa6q/Uv5VxYCnY=;
        b=SOKkbWHvgbHtJCuhx8hsfbF+wHziPwtDjdxbyOik9HL+yBZALxTHgvE2uMqIDvYhcF
         UVem6EyUu94ERtfb+Lie2MOToFa2VMT2T9WXTElWR+tKzuB5mxBuH8DngL9rlc4MvseM
         B6WqlnDIMUx8K6S80cBQTwGnUUxdoC3R8wxivtWBkZ+FSRZfKRKaIMyzgYmyDqQqSuoR
         r3VFuGSAGzBx7ASc9H0rE2INfvg2WFx0tIPIM0rjMphu29MNR1FbIXWQb7m/yeecN/ZU
         S5f32PE5+efVSmj/dRBBU9QdfJ316tTIRShOidBOsbcGWz7ZLHOpF252nGQy0UyyFZks
         5RMQ==
X-Gm-Message-State: AOAM530L5nchlcnbD3+IsLQsIZzS1SjOSAHxsAqos+PzmPzs+yb/sEuc
        37kwlzRhcGJ0qq6SYsrBH4x3+Oh/z0xkLwbeLPY=
X-Google-Smtp-Source: ABdhPJyVqzjOtqZW3copbX8PaKgTwOYBVo/jLi1F2/mksD9f6+C2PBaBY09o4eLFXR3LyhDARaCWoQN74WfHw83YGLM=
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr4824524ljg.91.1590773482693;
 Fri, 29 May 2020 10:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com> <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
In-Reply-To: <202005290903.11E67AB0FD@keescook>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 May 2020 10:31:11 -0700
Message-ID: <CAADnVQLciPUdO4hP2a2EbUE2zdE3AUxb8KZPkVaM+6+1CMNFzg@mail.gmail.com>
Subject: Re: new seccomp mode aims to improve performance
To:     Kees Cook <keescook@chromium.org>
Cc:     "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 9:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 29, 2020 at 08:43:56AM -0700, Alexei Starovoitov wrote:
> > On Fri, May 29, 2020 at 5:50 AM zhujianwei (C) <zhujianwei7@huawei.com>=
 wrote:
> > >
> > > Hi, all
> > >
> > >=E3=80=80=E3=80=80 We're using seccomp to increase container security,=
 but bpf rules filter causes performance to deteriorate. So, is there a goo=
d solution to improve performance, or can we add a simplified seccomp mode =
to improve performance?
>
> Yes, there are already plans for a simple syscall bitmap[1] seccomp featu=
re.
>
> > I don't think your hunch at where cpu is spending cycles is correct.
> > Could you please do two experiments:
> > 1. try trivial seccomp bpf prog that simply returns 'allow'
> > 2. replace bpf_prog_run_pin_on_cpu() in seccomp.c with C code
> >   that returns 'allow' and make sure it's noinline or in a different C =
file,
> >   so that compiler doesn't optimize the whole seccomp_run_filters() int=
o a nop.
> >
> > Then measure performance of both.
> > I bet you'll see exactly the same numbers.
>
> Android has already done this, it appeared to not be the same. Calling
> into a SECCOMP_RET_ALLOW filter had a surprisingly high cost. I'll see
> if I can get you the numbers. I was frankly quite surprised -- I
> understood the bulk of the seccomp overhead to be in taking the TIF_WORK
> path, copying arguments, etc, but something else is going on there.

Kees,

Please show the numbers that prove your point.
I've seen people making this mistake over and over again.
Intel folks also said that calling into bpf is slow only to be proved wrong=
.
It turned out to be the cost of retpoline and bpf_dispatcher logic resolved=
 it.
