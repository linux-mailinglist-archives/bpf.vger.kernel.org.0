Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC73AD244
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFRSk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhFRSkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 14:40:24 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399AC061760
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 11:38:13 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id n61so3737571uan.2
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DB2KtV4huzDvhq/Zw0R+/LkrQSRw1LO05/D22qr6dbU=;
        b=tIIgm2cZNItj/jycwMzyYp3p96yXQ4kK1YCraXyqsKQp3CntGE7q58d7awGidqAldZ
         KTeDW7VMONgTvlomLboOwEJC+XNLpnBj83yWCpcZ3rwW7N/CpWGOrn56qf/N6ueEuKAv
         Rs+0Cttg0oqOzeN65pYDcFq+0dnIPaOpbx6vu+ZntyURMYHTkyv2T6mng7/Te7XmxcA1
         wd7+PIHBAbaHCGLqJ9bLZjTS4LdERnO4ChIcg/dSKQJwOYKNSJWv2SYWlRatAFIAt0oQ
         n63V02/IPwj2PjgsWvNIYUhMMj68GAEpH9aoAA6a8oNAV5TAcwrOrVO/GeP4MsWv31xg
         //Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DB2KtV4huzDvhq/Zw0R+/LkrQSRw1LO05/D22qr6dbU=;
        b=QoSl4GDKfZO01UyiMkvIWaJ9GbtbwVf0aOHfBu5Y+m4yHdSl3ZhUey6p26FNXXuKx4
         9z/RIBPb88rRUiQFt0FRgmjDs84ULTc6lQQA6FyYfI6C2fV9egCZytc04+6vfpy1QR94
         GcZQgh/1tBQxk0H6ExRaBDPg22mH24jmgDKkRE8Ii2VyyvqpF7O3DD1irb2WUuaYzSSn
         jobfPaO62+u5g0cE7FzAhi/F9PDJyyMJNtUiQH0t1J74GElf3wAFT5F931Rk5MlUzIA0
         1BO0DPpm8RIHEKX59yQihmk2+e8h41gTkM1MIgMGO78yLOs8Fzfxt//5eIDcdR6+CmSq
         ePbQ==
X-Gm-Message-State: AOAM533K+QKKrcRD6uMsRXIXKfXtUUQGujvy09vxfagAoykU7vrqfdFY
        JQxPjPI8hv+uI0Cb2fo/FAJ96qPZ6e8WPPZkui/uyA==
X-Google-Smtp-Source: ABdhPJwz2ZJpfcsl04Unjheqw2xcmn3vHpAq9WrE/MNE1GmJYx0xXDii3HA6hXdDlYY9b3I3uvLTtIsMxZJggcn3Hlk=
X-Received: by 2002:ab0:30d4:: with SMTP id c20mr9018989uam.60.1624041492697;
 Fri, 18 Jun 2021 11:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com> <CACAyw99k4ZhePBcRJzJn37rvGKnPHEgE3z8Y-47iYKQO2nqFpQ@mail.gmail.com>
In-Reply-To: <CACAyw99k4ZhePBcRJzJn37rvGKnPHEgE3z8Y-47iYKQO2nqFpQ@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Fri, 18 Jun 2021 11:38:01 -0700
Message-ID: <CANP3RGcj_C-DorLcg58M2FYQMtz8wcX=qqVQmW6MH3uE-suh=w@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 4:55 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Fri, 18 Jun 2021 at 11:55, Maciej =C5=BBenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > This reverts commit d37300ed182131f1757895a62e556332857417e5.
> >
> > This breaks Android userspace which expects to be able to
> > fetch programs with just read permissions.
>
> Sorry about this! I'll defer to the maintainers what to do here.
> Reverting leaves us with a gaping hole for access control of pinned
> programs.


Not sure what hole you're referring to.  Could you provide more
details/explanation?

It seems perfectly reasonable to be able to get a program with just read pr=
ivs.
After all, you're not modifying it, just using it.

AFAIK there is no way to modify a program after it was loaded, has this cha=
nged?
if so, the checks should be on the modifications not the fd fetch.

I guess one could argue fetching with write only privs doesn't make sense?

Anyway... userspace is broken... so revert is the answer.

In Android the process loading/pinning bpf maps/programs is a different
process (the 'bpfloader') to the users (which are far less privileged)
