Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236123B66AC
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhF1Q1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhF1Q1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 12:27:08 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE2C061766
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 09:24:41 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id ay19so4056627vkb.9
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpJ7w32iGqwOk/oM/d0ecaefQixseDwgEeakcU32Bpk=;
        b=J5VVzZnCPxO4E4iVGvXs0S0FNIqPMIYqCPljwFsfMFBLSG5Xf/XsoDBBgz7XgOAHmm
         vj7AoYTLWtcJtxnNJHMOS4ONGe4/xLbiLzUhOqtIS+2VZ8TjR/p4Jp/sjGyshvcYALQV
         jiVsg2puI6vff5H82ZCHshluIz/QfrLLq8Q1ODcK2NxRkPvQDq4NlK8sQLRWj/URdKEZ
         ZLO4SE0JpCoP3lPkkachFV5wjB0I/V2WtBgJTHN8spUvLb5bKq89e41L9bsmNvmMK9vp
         dTyECvKDxu/nb0CWQCyyvTe4MPcCoERzBGkhHsCI7FYD+dGi9i2beYvViJ6+e6YeCT47
         NvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpJ7w32iGqwOk/oM/d0ecaefQixseDwgEeakcU32Bpk=;
        b=EIBTRMrjT3myyLsiLPNND0rywIwtyRzhd0VXP0KIBB4d8JtH8BoKrgm15G2T+xwa4h
         xo7eZZrbrPePWt37gQk4yBeX0lUbAtyFEPuHWraisUwyIa/oidOsctusKSP2xcxrmSK7
         YpFR5/6o2jare+C/j9h24xr5hILRXWyc7lQV1f0OoFSwkW9DsAcWXCWzCpql/KurWrgx
         K/fz3wDXSWCQQCEbaWf7Zr3uyrqPgJGWHDZlB2AeHQU0msPhSvIh3Q6ncXpvXLZQP5VP
         tu9HuTkbK/XmuczrwHEamRg7vY50chFFJ7/hklZ8WBtzJb3ocRlUF/Ubn7ZCuTZNHme9
         +SDQ==
X-Gm-Message-State: AOAM530UP+3zs6ao9I7K4gNPtrrW3V/09/6khDTYYhPC4bTU9Z/AyzUk
        rCI0LPf3h4+tJL779kGNQ7HVESNXhS2eSx9HWcJqFw==
X-Google-Smtp-Source: ABdhPJw91nOsdpuFZV/dLpAyCemkIwoeS+zWUP869PzyBrf5GyGV7tXMqGOVFz318/U7RCY6IgxhF5tRCxgIjbMCSos=
X-Received: by 2002:a1f:280e:: with SMTP id o14mr17539002vko.19.1624897480401;
 Mon, 28 Jun 2021 09:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210628144908.881499-1-phind.uet@gmail.com> <CANn89iJ6M2WFS3B+sSOysekScUFmO9q5YHxgHGsbozbvkW9ivg@mail.gmail.com>
 <79490158-e6d1-aabf-64aa-154b71205c74@gmail.com>
In-Reply-To: <79490158-e6d1-aabf-64aa-154b71205c74@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 28 Jun 2021 12:24:19 -0400
Message-ID: <CADVnQy=Q9W=Vxu81ctPLx08D=ALnHBXGr0c4BLtQGxwQE+yjRg@mail.gmail.com>
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

On Mon, Jun 28, 2021 at 12:18 PM Phi Nguyen <phind.uet@gmail.com> wrote:
>
> On 6/28/2021 10:52 PM, Eric Dumazet wrote:
>
> > Unfortunately this patch might break things.
> >
> > We keep changing this CC switching, with eBPF being mixed in the equation.
> >
> > I would suggest you find a Fixes: tag first, so that we can continue
> > the discussion.
> >
> > Thank you.
>
> Thank for your feedback. I will resubmit it with a Fixes tag.
>
> Regard.

Thanks.

Can you also please provide a summary of the event sequence that
triggers the bug? Based on your Reported-by tag, I guess this is based
on the syzbot reproducer:

 https://groups.google.com/g/syzkaller-bugs/c/VbHoSsBz0hk/m/cOxOoTgPCAAJ

but perhaps you can give a summary of the event sequence that causes
the bug? Is it that the call:

setsockopt$inet_tcp_TCP_CONGESTION(r0, 0x6, 0xd,
&(0x7f0000000000)='cdg\x00', 0x4)

initializes the CC and happens before the connection is established,
and then when the connection is established, the line that sets:
  icsk->icsk_ca_initialized = 0;
is incorrect, causing the CC to be initialized again without first
calling the cleanup code that deallocates the CDG-allocated memory?

thanks,
neal
