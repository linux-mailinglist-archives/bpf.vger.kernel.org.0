Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592CC3408A0
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhCRPSa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhCRPSQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 11:18:16 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202AC061760
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 08:18:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o19so3392014qvu.0
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOFBEPOr1SLeNR/Um5yDZSZIjOy82REcErjZY7pyKDQ=;
        b=CGGA9HuO0wmX6avzNQTVJ1nxLiQT7aoA7o7FrVE3h5ceaWoUInIhyTeqemyADCS6SS
         J1aSW/VAUL1LnUkoNWIaeeSEzosnmOzekeP/Cd/AKRy6XHe9D7fDF40I0pEkVfgkcW04
         Wueno/T53xBADAnWoqeonhzXD9XNteEmC/vWz3nlkLOJoxqPjJij8jrdxkVtid3qxIiG
         I0rOFVlJAHwmbMjA/2dQi7Yn2BAdLee9UC8U/FG16CmNV2srxQv8jKGwqOFHX+vGZrEo
         6/yLe1Nt7gWUUdg+KAGLwVM8/EjMxf07fwbwGl6wHOYdCUuiAcVwJliH313dDR58H1k5
         zZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOFBEPOr1SLeNR/Um5yDZSZIjOy82REcErjZY7pyKDQ=;
        b=jpMCj5ScOq3DMvvRtYtTpjGQKfiv/wPvBRPMIdNjQ3cYFpEPTXLfitzjNmI/3gLuPr
         44/K3or+UzGCWdwGsqr5aLqtb4/lxyrR6iTw37Oaot5A4fF0gHpoz0Ghj0XLCHfgX0qW
         pwHth1o3gbVVJmsuEwOtCuMNnOrBYy8dW29yuyASYIAWk50FziQI5AXYiFFOs7ojnJv/
         hjrwrqPcTU1xLT1mlwtpurSje9/BVCv+ZovZd91tSlJbMPwbX4ybQ4BGvdMy9N/U9oZe
         HoK/cI/CjSCiL3/v4NC+VdMNXgIl5MMYWq89NV8pkyIyej9T3xY1dy3BoLHyR/GJ1GAD
         3Jqw==
X-Gm-Message-State: AOAM530E11f2lLgREd9D6a7RgqmDFveDIjr9P/y4r4Rf/HV9EryNiDJ/
        dbqBFWWEQxqswnoDZRbkL1eUj+dtsPCsi8kHRja7gQ==
X-Google-Smtp-Source: ABdhPJy+OexF6sUgIP9Tj4vBricdu5cz15i4H10NQtNRkmkVuuYT5vaIDniBeQ+tCfWs2JPm3+l6eTr6bCrP19dyYj8=
X-Received: by 2002:ad4:410d:: with SMTP id i13mr4704593qvp.44.1616080694677;
 Thu, 18 Mar 2021 08:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000096cdaa05bd32d46f@google.com> <CACT4Y+ZjdOaX_X530p+vPbG4mbtUuFsJ1v-gD24T4DnFUqcudA@mail.gmail.com>
 <CACT4Y+ZjVS+nOxtEByF5-djuhbCYLSDdZ7V04qJ0edpQR0514A@mail.gmail.com>
 <CACT4Y+YXifnCtEvLu3ps8JLCK9CBLzEuUAozfNR9v1hsGWspOg@mail.gmail.com>
 <ed89390a-91e1-320a-fae5-27b7f3a20424@codethink.co.uk> <CACT4Y+a1pQ96UWEB3pAnbxPZ+6jW2tqSzkTMqJ+XSbZsKLHgAw@mail.gmail.com>
 <bf2e19a3-3e3a-0eb1-ae37-4cc3b1a7af42@codethink.co.uk>
In-Reply-To: <bf2e19a3-3e3a-0eb1-ae37-4cc3b1a7af42@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 16:18:03 +0100
Message-ID: <CACT4Y+ZVaxQAnpy_bMGwviZMskD-fy1KgY7pbrjcCRXr24eu2Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in sock_ioctl
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     syzbot <syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>, andrii@kernel.org,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, kpsingh@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 15, 2021 at 3:41 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 15/03/2021 11:52, Dmitry Vyukov wrote:
> > On Mon, Mar 15, 2021 at 12:30 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >>
> >> On 14/03/2021 11:03, Dmitry Vyukov wrote:
> >>> On Sun, Mar 14, 2021 at 11:01 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>>>> On Wed, Mar 10, 2021 at 7:28 PM syzbot
> >>>>> <syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> >>>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=122c343ad00000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=c23c5421600e9b454849
> >>>>>> userspace arch: riscv64
> >>>>>>
> >>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>>> Reported-by: syzbot+c23c5421600e9b454849@syzkaller.appspotmail.com
> >>>>>
> >>>>> +riscv maintainers
> >>>>>
> >>>>> Another case of put_user crashing.
> >>>>
> >>>> There are 58 crashes in sock_ioctl already. Somehow there is a very
> >>>> significant skew towards crashing with this "user memory without
> >>>> uaccess routines" in schedule_tail and sock_ioctl of all places in the
> >>>> kernel that use put_user... This looks very strange... Any ideas
> >>>> what's special about these 2 locations?
> >>>
> >>> I could imagine if such a crash happens after a previous stack
> >>> overflow and now task data structures are corrupted. But f_getown does
> >>> not look like a function that consumes way more than other kernel
> >>> syscalls...
> >>
> >> The last crash I looked at suggested somehow put_user got re-entered
> >> with the user protection turned back on. Either there is a path through
> >> one of the kernel handlers where this happens or there's something
> >> weird going on with qemu.
> >
> > Is there any kind of tracking/reporting that would help to localize
> > it? I could re-reproduce with that code.
>
> I'm not sure. I will have a go at debugging on qemu today just to make
> sure I can reproduce here before I have to go into the office and fix
> my Icicle board for real hardware tests.
>
> I think my first plan post reproduction is to stuff some trace points
> into the fault handlers to see if we can get a idea of faults being
> processed, etc.
>
> Maybe also add a check in the fault handler to see if the fault was
> in a fixable region and post an error if that happens / maybe retry
> the instruction with the relevant SR_SUM flag set.
>
> Hopefully tomorrow I can get a run on real hardware to confirm.
> Would have been better if the Unmatched board I ordered last year
> would turn up.

In retrospect it's obvious what's common between these 2 locations:
they both call a function inside of put_user.

#syz dup:
BUG: unable to handle kernel access to user memory in schedule_tail
