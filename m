Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B003A280669
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJASTq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJASTU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 14:19:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49719C0613E3
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 11:19:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so9458911ejb.8
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QA7LeF2qBheMMLcfazviLbAdkWU8DJ0SHO9LgKI517k=;
        b=a6/AKuLO+I4CN+TMUjHSBr60dhhYt2MStlCukeOxb7tSCFx191nyiwvXlYbx/oULgM
         Qjm1B7m2UGwjacKKYaNXPULYCd6pYcf0W5/JGNdhPPJ4TPh4u53cacymVqRATF9XFnZ5
         m1yQeHk9D8JcvcmVO3bWytivPIFmqqdzrEA56gm1NzYGoMTiqgvTvWdb7YBVb9KnjGFu
         9EjOj0GQDKmMfH5lOLFXtHC/Og/rDVZBo5vzx/AJpOsuCoPlNn/wZe40Zt77WTJbLLVx
         epUS8duTssquZj+AZsJ24noqMXJe4fheY6/TEFjBy8a4/CaW7hfoJNvNDOxJyXGHARek
         TGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QA7LeF2qBheMMLcfazviLbAdkWU8DJ0SHO9LgKI517k=;
        b=NjlfutorFk9CE8eIsh2rq93mw1E4yHYkiF8o79Y5UYp+kIj1XtGGOBb2PIm/WULPL+
         ln2J6EMagFD/P3YKGTxfIA8XD4skpLYuZcdkeZIcfefY9M6MW0QDye/i7X9ASf94/wgO
         N6B88anZ0/ERjHGdeJO/PJhgDBhSLSrs5C0V16eBnkTueTeqm87GTNuDP1SMoKF/EyOw
         n9qM/HMini/2IfkmFO9ludMFjIM8D2ih2Ur9orr9M36w2pin1ApEJhqAu6xXar5l7+Jv
         3MpB/GmVrc7dG3J5jmb6EGDehRCaAslxJC963YghiE5OB4m2SWBQ3Ymv34JINH36W4lU
         68lA==
X-Gm-Message-State: AOAM531M7nGHplm7ZJQxT/MXR9EvzjQv8rBMhrIuAs6M0Bq0rOt5QUoi
        KC+ffmkFjCOlF7v8OW3SOTQRkvDhaEAcJz25Itw8og==
X-Google-Smtp-Source: ABdhPJxsiRsxYcHsuimS2roWYvKY4tDFvDoqHRG6FGHNTwGrOtVjCR7kuJzEufOvz3pAyBvOKtunPrSfTb5XNoYe65E=
X-Received: by 2002:a17:906:1f94:: with SMTP id t20mr9609666ejr.493.1601576356489;
 Thu, 01 Oct 2020 11:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <20201001125043.dj6taeieatpw3a4w@gmail.com> <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
 <20201001165850.GC1260245@cisco>
In-Reply-To: <20201001165850.GC1260245@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 20:18:49 +0200
Message-ID: <CAG48ez1W+Ym5=-PdUhyei_UCJov0agEF4YVyARL=pooWYmdEAg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Tycho Andersen <tycho@tycho.pizza>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 6:58 PM Tycho Andersen <tycho@tycho.pizza> wrote:
> On Thu, Oct 01, 2020 at 05:47:54PM +0200, Jann Horn via Containers wrote:
> > On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
> > <christian.brauner@canonical.com> wrote:
> > > On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wr=
ote:
> > > > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > > > NOTES
> > > > >        The file descriptor returned when seccomp(2) is employed w=
ith the
> > > > >        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored=
  using
> > > > >        poll(2), epoll(7), and select(2).  When a notification  is=
  pend=E2=80=90
> > > > >        ing,  these interfaces indicate that the file descriptor i=
s read=E2=80=90
> > > > >        able.
> > > >
> > > > We should probably also point out somewhere that, as
> > > > include/uapi/linux/seccomp.h says:
> > > >
> > > >  * Similar precautions should be applied when stacking SECCOMP_RET_=
USER_NOTIF
> > > >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting =
on the
> > > >  * same syscall, the most recently added filter takes precedence. T=
his means
> > > >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> > > >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allow=
ing all
> > > >  * such filtered syscalls to be executed by sending the response
> > > >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE ca=
n equally
> > > >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> > > >
> > > > In other words, from a security perspective, you must assume that t=
he
> > > > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > > > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > > > calling seccomp(). This should also be noted over in the main
> > > > seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
> > >
> > > So I was actually wondering about this when I skimmed this and a whil=
e
> > > ago but forgot about this again... Afaict, you can only ever load a
> > > single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
> > > already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER propert=
y
> > > in the tasks filter hierarchy then the kernel will refuse to load a n=
ew
> > > one?
> > >
> > > static struct file *init_listener(struct seccomp_filter *filter)
> > > {
> > >         struct file *ret =3D ERR_PTR(-EBUSY);
> > >         struct seccomp_filter *cur;
> > >
> > >         for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev)=
 {
> > >                 if (cur->notif)
> > >                         goto out;
> > >         }
> > >
> > > shouldn't that be sufficient to guarantee that USER_NOTIF filters can=
't
> > > override each other for the same task simply because there can only e=
ver
> > > be a single one?
> >
> > Good point. Exceeeept that that check seems ineffective because this
> > happens before we take the locks that guard against TSYNC, and also
> > before we decide to which existing filter we want to chain the new
> > filter. So if two threads race with TSYNC, I think they'll be able to
> > chain two filters with listeners together.
>
> Yep, seems the check needs to also be in seccomp_can_sync_threads() to
> be totally effective,
>
> > I don't know whether we want to eternalize this "only one listener
> > across all the filters" restriction in the manpage though, or whether
> > the man page should just say that the kernel currently doesn't support
> > it but that security-wise you should assume that it might at some
> > point.
>
> This requirement originally came from Andy, arguing that the semantics
> of this were/are confusing, which still makes sense to me. Perhaps we
> should do something like the below?
[...]
> +static bool has_listener_parent(struct seccomp_filter *child)
> +{
> +       struct seccomp_filter *cur;
> +
> +       for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
> +               if (cur->notif)
> +                       return true;
> +       }
> +
> +       return false;
> +}
[...]
> @@ -407,6 +419,11 @@ static inline pid_t seccomp_can_sync_threads(void)
[...]
> +               /* don't allow TSYNC to install multiple listeners */
> +               if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER &&
> +                   !has_listener_parent(thread->seccomp.filter))
> +                       continue;
[...]
> @@ -1462,12 +1479,9 @@ static const struct file_operations seccomp_notify=
_ops =3D {
>  static struct file *init_listener(struct seccomp_filter *filter)
[...]
> -       for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
> -               if (cur->notif)
> -                       goto out;
> -       }
> +       if (has_listener_parent(current->seccomp.filter))
> +               goto out;

I dislike this because it combines a non-locked check and a locked
check. And I don't think this will work in the case where TSYNC and
non-TSYNC race - if the non-TSYNC call nests around the TSYNC filter
installation, the thread that called seccomp in non-TSYNC mode will
still end up with two notifying filters. How about the following?


diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 676d4af62103..c49ad8ba0bc1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1475,11 +1475,6 @@ static struct file *init_listener(struct
seccomp_filter *filter)
        struct file *ret =3D ERR_PTR(-EBUSY);
        struct seccomp_filter *cur;

-       for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
-               if (cur->notif)
-                       goto out;
-       }
-
        ret =3D ERR_PTR(-ENOMEM);
        filter->notif =3D kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
        if (!filter->notif)
@@ -1504,6 +1499,31 @@ static struct file *init_listener(struct
seccomp_filter *filter)
        return ret;
 }

+/*
+ * Does @new_child have a listener while an ancestor also has a listener?
+ * If so, we'll want to reject this filter.
+ * This only has to be tested for the current process, even in the TSYNC c=
ase,
+ * because TSYNC installs @child with the same parent on all threads.
+ * Note that @new_child is not hooked up to its parent at this point yet, =
so
+ * we use current->seccomp.filter.
+ */
+static bool has_duplicate_listener(struct seccomp_filter *new_child)
+{
+       struct seccomp_filter *cur;
+
+       /* must be protected against concurrent TSYNC */
+       lockdep_assert_held(&current->sighand->siglock);
+
+       if (!new_child->notif)
+               return false;
+       for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
+               if (cur->notif)
+                       return true;
+       }
+
+       return false;
+}
+
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
  * @flags:  flags to change filter behavior
@@ -1575,6 +1595,9 @@ static long seccomp_set_mode_filter(unsigned int flag=
s,
        if (!seccomp_may_assign_mode(seccomp_mode))
                goto out;

+       if (has_duplicate_listener(prepared))
+               goto out;
+
        ret =3D seccomp_attach_filter(flags, prepared);
        if (ret)
                goto out;
