Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274B727EC23
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgI3PMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:12:53 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56947 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbgI3PLm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 11:11:42 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 11:11:41 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7A529ED7;
        Wed, 30 Sep 2020 11:03:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 11:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=O
        2EF17WZ/x8X1RI5MVWmt+xk1RyPo0vTQ3NX9Sb+vZs=; b=am7DDlxzNqJJ/HMKX
        6EImaKQCRBO+YQBosmTU/MBeym+pIXYs5pFWxWkM6VxrpHVLUKc32Ws2e8CSNR2b
        rTvg8Hpqhnq7udku+D88pmcWVSPfQJcR5U2+fP9FTHH+EyMuOL4/5ylW5B2QSOoY
        Z95ONSBf3M9Wx9mqv75OapljZryJqNYkz5oLa69Bx2lwz2AHYq8ypXUw3Jeu5o8s
        uxuSP/Tz8QNumVG9xX5CxDumLaSFhoMIJLiNUwhn7/reSN2MD64cy5YJMV/hUJ7B
        YKVN3P3Y+yiQEqKdo/93n3rjYTV1vweTVjusGX7N45XPM3oO1u6saGatdMFUymwC
        LBipg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=O2EF17WZ/x8X1RI5MVWmt+xk1RyPo0vTQ3NX9Sb+v
        Zs=; b=JFD7JWMS9HiqvLK4HnO73eiL0Th4Re6mGAXJ6LjJr8uoj9ZxRXmZTRiOu
        Y+VlCn0rWJBYfMy2DXiltOm+bybcRBDI+926ctq4SoWdS+iEzjY2viEh4nBtKb4G
        tLIUHWZDV3S3bkDGig/tjzifoVc+9eLUqCWBG/llXO1ikFSBphNLWVRhXvjUk/dc
        UHqqykliIh5m2m9I0iooKqJbNOX50U18Q+/xhYCufJXKgbTX6tF7axKqFv4b6LNb
        h+cMqqKmDRe102FSfxndG0HOXx4P/4NIxb5PSCWpviILJlDm8mGXdAbeQwG9/d0r
        MJCtFobuMEMT/7Q91qWjGg9plWbCA==
X-ME-Sender: <xms:SJ50X9WMVf6wrFQnac_h2hPhuA3CPkdOz7fcapezvARx8gaFW-6AoQ>
    <xme:SJ50X9lwRvlf5WiuP-8ry6Z6SqY2oBJg-CQQwvNIFKCChHoBRJ2Y7C7XSGmHYjuI8
    fvgT99VQtdcALDZqF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpefhuedvvdelieevgeegjeeukeeuleejtdejfeetfeeujeefvdeltdethffh
    ueekffenucfkphepuddvkedruddtjedrvdeguddrudekgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:SJ50X5ZazZm7gmw0_d6hj_We0RbvDkbp-VGtgt5kfYoLSVDqgMZgWA>
    <xmx:SJ50XwXC_daxyOb9ci8kzAyalUy4RR8AsRAwodN_8dkJC-hcq4dGAg>
    <xmx:SJ50X3neO_WdEqGaDpwC7TFSObpShpW7mAkhw16qj5K5zOzyDpkzHQ>
    <xmx:Sp50X89No2tDqetjd-skXbluhpOVZx6eOVB7yGxWe-fvmXQsUVyDouO9QCLIiUuX>
Received: from cisco (unknown [128.107.241.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09B593064685;
        Wed, 30 Sep 2020 11:03:32 -0400 (EDT)
Date:   Wed, 30 Sep 2020 09:03:30 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20200930150330.GC284424@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
>        2. In order that the supervisor process can obtain  notifications
>           using  the  listening  file  descriptor, (a duplicate of) that
>           file descriptor must be passed from the target process to  the
>           supervisor process.  One way in which this could be done is by
>           passing the file descriptor over a UNIX domain socket  connec‐
>           tion between the two processes (using the SCM_RIGHTS ancillary
>           message type described in unix(7)).   Another  possibility  is
>           that  the  supervisor  might  inherit  the file descriptor via
>           fork(2).

It is technically possible to inherit the fd via fork, but is it
really that useful? The child process wouldn't be able to actually do
the syscall in question, since it would have the same filter.

>           The  information  in  the notification can be used to discover
>           the values of pointer arguments for the target process's  sys‐
>           tem call.  (This is something that can't be done from within a
>           seccomp filter.)  To do this (and  assuming  it  has  suitable

s/To do this/One way to accomplish this/ perhaps, since there are
others.

>           permissions),   the   supervisor   opens   the   corresponding
>           /proc/[pid]/mem file, seeks to the memory location that corre‐
>           sponds to one of the pointer arguments whose value is supplied
>           in the notification event, and reads bytes from that location.
>           (The supervisor must be careful to avoid a race condition that
>           can occur when doing this; see the  description  of  the  SEC‐
>           COMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)  In addi‐
>           tion, the supervisor can access other system information  that
>           is  visible  in  user space but which is not accessible from a
>           seccomp filter.
> 
>           ┌─────────────────────────────────────────────────────┐
>           │FIXME                                                │
>           ├─────────────────────────────────────────────────────┤
>           │Suppose we are reading a pathname from /proc/PID/mem │
>           │for  a system call such as mkdir(). The pathname can │
>           │be an arbitrary length. How do we know how much (how │
>           │many pages) to read from /proc/PID/mem?              │
>           └─────────────────────────────────────────────────────┘

PATH_MAX, I suppose.

>        ┌─────────────────────────────────────────────────────┐
>        │FIXME                                                │
>        ├─────────────────────────────────────────────────────┤
>        │From my experiments,  it  appears  that  if  a  SEC‐ │
>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
>        │process terminates, then the ioctl()  simply  blocks │
>        │(rather than returning an error to indicate that the │
>        │target process no longer exists).                    │

Yeah, I think Christian wanted to fix this at some point, but it's a
bit sticky to do. Note that if you e.g. rely on fork() above, the
filter is shared with your current process, and this notification
would never be possible. Perhaps another reason to omit that from the
man page.

>        SECCOMP_IOCTL_NOTIF_ID_VALID
>               This operation can be used to check that a notification ID
>               returned by an earlier SECCOMP_IOCTL_NOTIF_RECV  operation
>               is  still  valid  (i.e.,  that  the  target  process still
>               exists).
> 
>               The third ioctl(2) argument is a  pointer  to  the  cookie
>               (id) returned by the SECCOMP_IOCTL_NOTIF_RECV operation.
> 
>               This  operation is necessary to avoid race conditions that
>               can  occur   when   the   pid   returned   by   the   SEC‐
>               COMP_IOCTL_NOTIF_RECV   operation   terminates,  and  that
>               process ID is reused by another process.   An  example  of
>               this kind of race is the following
> 
>               1. A  notification  is  generated  on  the  listening file
>                  descriptor.  The returned  seccomp_notif  contains  the
>                  PID of the target process.
> 
>               2. The target process terminates.
> 
>               3. Another process is created on the system that by chance
>                  reuses the PID that was freed when the  target  process
>                  terminates.
> 
>               4. The  supervisor  open(2)s  the /proc/[pid]/mem file for
>                  the PID obtained in step 1, with the intention of (say)
>                  inspecting the memory locations that contains the argu‐
>                  ments of the system call that triggered  the  notifica‐
>                  tion in step 1.
> 
>               In the above scenario, the risk is that the supervisor may
>               try to access the memory of a process other than the  tar‐
>               get.   This  race  can be avoided by following the call to
>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ver‐
>               ify  that  the  process that generated the notification is
>               still alive.  (Note that  if  the  target  process  subse‐
>               quently  terminates, its PID won't be reused because there
>               remains an open reference to the /proc[pid]/mem  file;  in
>               this  case, a subsequent read(2) from the file will return
>               0, indicating end of file.)
> 
>               On success (i.e., the notification  ID  is  still  valid),
>               this  operation  returns 0 On failure (i.e., the notifica‐
                                          ^ need a period?

>        ┌─────────────────────────────────────────────────────┐
>        │FIXME                                                │
>        ├─────────────────────────────────────────────────────┤
>        │Interestingly, after the event  had  been  received, │
>        │the  file descriptor indicates as writable (verified │
>        │from the source code and by experiment). How is this │
>        │useful?                                              │

You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
reasonable.

> 
> EXAMPLES
>        The (somewhat contrived) program shown below demonstrates the use

May also be worth mentioning the example in
samples/seccomp/user-trap.c as well.

Tycho
