Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2308511F3AC
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNTZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Dec 2019 14:25:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36557 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNTZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Dec 2019 14:25:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id i4so3553619otr.3
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+JLub6tSjjD0VYNukHxlnNiCf3LxZUN97TOzGRferM=;
        b=ZJvhEehw1yFXqi+lWP9b9cl2E0XC6f082DGJD8gnBV6/Opz9r+odAxXuiLFiF86/1D
         fdI+R4u6fCCVbU5BZZb8LU8YZk2Rw8c3J3XFa4g0pVwPqlCYQSFonp3CVVyb3PXVOXHG
         5/LV6VUNa3XdvI2w1wDD3gVMjUyxDiHUOycibvUMxUgGsVbrjUnrRoIXPd54XQmi1Pbx
         li+egwTNYQuShi/eCzq3yjAClZZ55TUIVxXFFNuf+iRlkesI7SesUOMMYI58F5ss6Fhr
         6m1INRULw3vne6deq1Y3wZbH8/PjCFRJnvhYUfFQx+cVnVBHDcV00cXVGXTybYEQoibd
         4N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+JLub6tSjjD0VYNukHxlnNiCf3LxZUN97TOzGRferM=;
        b=kgn0jMKOdpYcmgakjnB8TSEZJiWmg1FkpoFGEWlGkx+KR6nbRjo0zVOKUaEtX01kPo
         BMXi2EfoiOwppCvKlunbQS9Q6wygldyNsAFzBTb0GBb7oQGuU71OkCSVqKPVwmKJLyYo
         fplGGbyfaHD7r5jQ01BaCucliRsf8/IJYr/sWvWJbiapL8nmhaIK7qZFGSWQDYTw1xnE
         AkoSt0ZpIXjpLo4LehFdTOOM0KltasKyN8tt9cBE4qMMr/RSHRN6d5BLoPTmSilAt2MN
         N7lWh6z/YwgtolEgqzxk6o7r9psLPiNc988taGyqs87l8LfoaB01dxZ5DplFhagzrq3E
         jFvg==
X-Gm-Message-State: APjAAAXPj7Q2VPbYUTS/u5n8s//cwRIdW4jN5+Q15GLIfzDGhMT38KZz
        2G7+bhQBjxsD/+flzzAA27Dw5meRo/6fDLsI+TPotQ==
X-Google-Smtp-Source: APXvYqw2rYLpk9L5q0n/ZsuZpXWvZm9n8UOyRMu3hYSCo+t5nPvK2xICr9ARcUqVVMXjv6l5co0QhzUMARbQzR8kA2I=
X-Received: by 2002:a9d:480c:: with SMTP id c12mr23269628otf.255.1576351530462;
 Sat, 14 Dec 2019 11:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20191214004737.1652076-1-kafai@fb.com> <20191214004758.1653342-1-kafai@fb.com>
 <b321412c-1b42-45a9-4dc6-cc268b55cd0d@gmail.com>
In-Reply-To: <b321412c-1b42-45a9-4dc6-cc268b55cd0d@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sat, 14 Dec 2019 14:25:14 -0500
Message-ID: <CADVnQy=soQ8KhuUWEQj0n2ge3a43OSgAKS95bmBtp090jqbM_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] bpf: Add BPF_FUNC_jiffies
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 13, 2019 at 9:00 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 12/13/19 4:47 PM, Martin KaFai Lau wrote:
> > This patch adds a helper to handle jiffies.  Some of the
> > tcp_sock's timing is stored in jiffies.  Although things
> > could be deduced by CONFIG_HZ, having an easy way to get
> > jiffies will make the later bpf-tcp-cc implementation easier.
> >
>
> ...
>
> > +
> > +BPF_CALL_2(bpf_jiffies, u64, in, u64, flags)
> > +{
> > +     if (!flags)
> > +             return get_jiffies_64();
> > +
> > +     if (flags & BPF_F_NS_TO_JIFFIES) {
> > +             return nsecs_to_jiffies(in);
> > +     } else if (flags & BPF_F_JIFFIES_TO_NS) {
> > +             if (!in)
> > +                     in = get_jiffies_64();
> > +             return jiffies_to_nsecs(in);
> > +     }
> > +
> > +     return 0;
> > +}
>
> This looks a bit convoluted :)
>
> Note that we could possibly change net/ipv4/tcp_cubic.c to no longer use jiffies at all.
>
> We have in tp->tcp_mstamp an accurate timestamp (in usec) that can be converted to ms.

If the jiffies functionality stays, how about 3 simple functions that
correspond to the underlying C functions, perhaps something like:

  bpf_nsecs_to_jiffies(nsecs)
  bpf_jiffies_to_nsecs(jiffies)
  bpf_get_jiffies_64()

Separate functions might be easier to read/maintain (and may even be
faster, given the corresponding reduction in branches).

neal
