Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C02183B05
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 22:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCLVHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 17:07:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45199 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgCLVG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 17:06:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id e9so639281otr.12
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=f+l+gXIKYD8ZqIsbSKM4dLqAUjD21JGnao8P6oy+6Zmm9Rb8AXN6l/tS4s9RT9ecgP
         8OTh+Gt18uKCXrL2agzWwd/jaz4kTY1PcHwRp8AM/PzPPozlKad5X4ZfeHipH/tIBjxa
         99BbLEDknWH+7czLa5Ds6pxh1qQr+8L/YyNq5vH159Q93v9ftJQBMYn9MTLI0ylozz0g
         SxF6JBvVR6aRYy+G/pWJCbP5kvTgAoAwODj4DnUgeTdzCZUniI5BUzeE45A4/CVcJor4
         PJTNqoA2uuZZ4WpMILVN15YTIvUc7nqvO81ayj7Ez+wssmSZmgvM6o862uS0AIZwCaSh
         XIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=pRIHdkEI7U7k15R5Y+dcVTJj5murkn0+ZcknOx98nx+3xgK6jUd4c1Bz2nZ/ytklbM
         Z9zE25/z5G6OggcXKw+jdpaz9BNwKGwmnxPoa4xI5Zq6h2voZBFiwOO5ogHYQCh572q0
         LVnM9Wtfd3YCmF9nXXq/gw8XRgjFR8H32I3ymaBp+gkljknRwBXAFRt1sVAKvrfjV7kG
         +qE9yLhsDoj9ardSHdCw2KoySyejzt8nVuCpH1FR/LAPrp2QCv99O8ZYInlB3UE9iPwM
         MMw+BXr4ysvkXwiYa7SjEIcYM5i49u5gpyrP44+HLWmXdgR3klGpH07TL2qeV5yOEwVg
         2CUQ==
X-Gm-Message-State: ANhLgQ2R6mZ7gWMSh4KS55K8i5uvG6MYc+Vg+jlOIdJB4K5dxAmct4Or
        qS2fBvmOZ6cS6PKPpA2yHTtlw/3c9MfLjz75/vJC+A==
X-Google-Smtp-Source: ADFU+vuorKp4Am1Eft4fdcP1G8Nf7OvlWyXXPJjJAuw2HysSDIhCcZVTlSzqZ6RrA6JxKhMxZ3B+h9vZHTYAu4IJG2I=
X-Received: by 2002:a9d:c24:: with SMTP id 33mr8191344otr.355.1584047218074;
 Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000041c6c205a08225dc@google.com> <20200312182826.GG79873@mtj.duckdns.org>
In-Reply-To: <20200312182826.GG79873@mtj.duckdns.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 12 Mar 2020 14:06:47 -0700
Message-ID: <CAHS8izPySSO07dHi3OZ_1uXjmMCGnNMWey+o-qwFM7GnD7oSHw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in cgroup_file_notify
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, andriin@fb.com,
        ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        christian@brauner.io, daniel@iogearbox.net,
        Johannes Weiner <hannes@cmpxchg.org>, kafai@fb.com,
        open list <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, netdev@vger.kernel.org,
        sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 12, 2020 at 11:28 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 08:55:14AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c99b17ac Add linux-next specific files for 20200225
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1610d70de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6b7ebe4bd0931c45
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cac0c4e204952cf449b1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1242e1fde00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1110d70de00000
> >
> > The bug was bisected to:
> >
> > commit 6863de00e5400b534cd4e3869ffbc8f94da41dfc
> > Author: Mina Almasry <almasrymina@google.com>
> > Date:   Thu Feb 20 03:55:30 2020 +0000
> >
> >     hugetlb_cgroup: add accounting for shared mappings
>
> Mina, can you please take a look at this?
>

Gah, I missed the original syzbot email but I just saw this. I'll take a look.

> Thanks.

>
> --
> tejun
