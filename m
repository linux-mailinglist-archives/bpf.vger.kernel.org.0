Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8DB280756
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgJAS67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 14:58:59 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:43087 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729990AbgJAS5F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Oct 2020 14:57:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 366651298;
        Thu,  1 Oct 2020 14:56:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Oct 2020 14:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=i
        bq8LGhrZAKigNWOBMJB3QC8JFPS6HWHnRsmip0Juf8=; b=faefTIbsKtfeTFnxU
        i6tdavFKCHLFdM2fxfyp1AHD15/aQqHWGz8vNOLmFkRRXqkpjgOsgLXT0+J0TZM5
        qc9c7yfgRZ5TLa2zdVqFAV+uXEpLR/t+uKd9UIHwbYy2BGVLLo8EgUla4FNkk6E4
        vK3g8QjsUQa0GfsJcY5g0+xbOEMp8ktmfX7VVq+AtUqd79eCBD7flPRARFIFWzlM
        S0GS7Nkkh+WsmhH/Fp6zHBe6tCNT9gKvxYm7qiRBoITQYF7S0gAljeOXlTIQrL82
        pFvMNcICudfy1edLjhUhpLzsIIvqI0fqXF7ogOTy6gwY1udn0/b+zhqyhyLacVBM
        HzsKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ibq8LGhrZAKigNWOBMJB3QC8JFPS6HWHnRsmip0Ju
        f8=; b=vbC/uYymsPNo3iCMQ0xDYDVah+dU7erOdTEDmHcMYHh7/G8rQptUkvKKA
        NXouI6bqPOdVVEmAdVZwFeiyQqzVsU405xvQG6b6xwCBS5EJaDqnmpqNcrJ6RHGU
        ZZK5qXcd1FVgkPQYEnTTcV2dxW2FDhydgh+1Fx9zHU+eN8JrbZQpKUVQve/zvP+N
        PDwR0BRNg01821QELz1wEM1QlrlnrBP0gkYyXXqy1fuB2dA2kpXwmEiq1jb2nIME
        xtGJYrTqngxi8q1mIM12Q+MDu2lGVYN32b1O3nLX8tDxRjRRLsBgVwRqxCcGAi2e
        /8RZ5PMfF6Jl/Czmu7jomZbGVhYJA==
X-ME-Sender: <xms:YSZ2X9IGt_5vqGNirJf3-Ds6_cUvWKo3DzBlb8o4ty41AieBQ4byOQ>
    <xme:YSZ2X5KvnJFI98_uNRJE89n48VbgHilW_yWe1xAJmEAVKIHt2VszIhHsI87kHw-tc
    i6pbRqEYDkpcLMcpJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhephfeuvddvleeiveeggeejueekueeljedtjeefteefueejfedvledttefh
    hfeukeffnecukfhppeejfedrvddujedruddtrdeitdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:YSZ2X1tFbDPM3jV86AKWVj2gldrMSRfYkbW-dWu7EJ38u3Xb6M8QKg>
    <xmx:YSZ2X-a1MEqFBm875iKjNBAXqENwyPQ-CZbWrDjZ1GwCziwqtM_CQg>
    <xmx:YSZ2X0bbdbrl1NPEBNDskCUWuTjwkPgT9N_KiGqk3Suy_dZFJ3nMoA>
    <xmx:YyZ2X0rL3WqWEU42QS71IgS-VqUZE0gAbbnzCHbHK1p5jaO9tNUVGFhnQGjv4E6G>
Received: from cisco (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id A23DD328005E;
        Thu,  1 Oct 2020 14:56:32 -0400 (EDT)
Date:   Thu, 1 Oct 2020 12:56:31 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20201001185631.GD1260245@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <20201001125043.dj6taeieatpw3a4w@gmail.com>
 <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
 <20201001165850.GC1260245@cisco>
 <CAG48ez1W+Ym5=-PdUhyei_UCJov0agEF4YVyARL=pooWYmdEAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1W+Ym5=-PdUhyei_UCJov0agEF4YVyARL=pooWYmdEAg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 08:18:49PM +0200, Jann Horn wrote:
> On Thu, Oct 1, 2020 at 6:58 PM Tycho Andersen <tycho@tycho.pizza> wrote:
> > On Thu, Oct 01, 2020 at 05:47:54PM +0200, Jann Horn via Containers wrote:
> > > On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
> > > <christian.brauner@canonical.com> wrote:
> > > > On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wrote:
> > > > > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > > > > <mtk.manpages@gmail.com> wrote:
> > > > > > NOTES
> > > > > >        The file descriptor returned when seccomp(2) is employed with the
> > > > > >        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
> > > > > >        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
> > > > > >        ing,  these interfaces indicate that the file descriptor is read‐
> > > > > >        able.
> > > > >
> > > > > We should probably also point out somewhere that, as
> > > > > include/uapi/linux/seccomp.h says:
> > > > >
> > > > >  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
> > > > >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
> > > > >  * same syscall, the most recently added filter takes precedence. This means
> > > > >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> > > > >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
> > > > >  * such filtered syscalls to be executed by sending the response
> > > > >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
> > > > >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> > > > >
> > > > > In other words, from a security perspective, you must assume that the
> > > > > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > > > > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > > > > calling seccomp(). This should also be noted over in the main
> > > > > seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
> > > >
> > > > So I was actually wondering about this when I skimmed this and a while
> > > > ago but forgot about this again... Afaict, you can only ever load a
> > > > single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
> > > > already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER property
> > > > in the tasks filter hierarchy then the kernel will refuse to load a new
> > > > one?
> > > >
> > > > static struct file *init_listener(struct seccomp_filter *filter)
> > > > {
> > > >         struct file *ret = ERR_PTR(-EBUSY);
> > > >         struct seccomp_filter *cur;
> > > >
> > > >         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > > >                 if (cur->notif)
> > > >                         goto out;
> > > >         }
> > > >
> > > > shouldn't that be sufficient to guarantee that USER_NOTIF filters can't
> > > > override each other for the same task simply because there can only ever
> > > > be a single one?
> > >
> > > Good point. Exceeeept that that check seems ineffective because this
> > > happens before we take the locks that guard against TSYNC, and also
> > > before we decide to which existing filter we want to chain the new
> > > filter. So if two threads race with TSYNC, I think they'll be able to
> > > chain two filters with listeners together.
> >
> > Yep, seems the check needs to also be in seccomp_can_sync_threads() to
> > be totally effective,
> >
> > > I don't know whether we want to eternalize this "only one listener
> > > across all the filters" restriction in the manpage though, or whether
> > > the man page should just say that the kernel currently doesn't support
> > > it but that security-wise you should assume that it might at some
> > > point.
> >
> > This requirement originally came from Andy, arguing that the semantics
> > of this were/are confusing, which still makes sense to me. Perhaps we
> > should do something like the below?
> [...]
> > +static bool has_listener_parent(struct seccomp_filter *child)
> > +{
> > +       struct seccomp_filter *cur;
> > +
> > +       for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > +               if (cur->notif)
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> [...]
> > @@ -407,6 +419,11 @@ static inline pid_t seccomp_can_sync_threads(void)
> [...]
> > +               /* don't allow TSYNC to install multiple listeners */
> > +               if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER &&
> > +                   !has_listener_parent(thread->seccomp.filter))
> > +                       continue;
> [...]
> > @@ -1462,12 +1479,9 @@ static const struct file_operations seccomp_notify_ops = {
> >  static struct file *init_listener(struct seccomp_filter *filter)
> [...]
> > -       for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > -               if (cur->notif)
> > -                       goto out;
> > -       }
> > +       if (has_listener_parent(current->seccomp.filter))
> > +               goto out;
> 
> I dislike this because it combines a non-locked check and a locked
> check. And I don't think this will work in the case where TSYNC and
> non-TSYNC race - if the non-TSYNC call nests around the TSYNC filter
> installation, the thread that called seccomp in non-TSYNC mode will
> still end up with two notifying filters. How about the following?

Sure, you can add,

Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

when you send it.

Tycho
