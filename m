Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E528046F
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgJARBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 13:01:22 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:49693 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732096AbgJAQ71 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Oct 2020 12:59:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 73129C9A;
        Thu,  1 Oct 2020 12:58:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Oct 2020 12:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=j
        w8E05t8pF0s/VlD5rMYENGSZUwN/eshe0KaWjZtgSE=; b=RQKAcECy89S2+fERA
        s1+f8jWlq237Tj+3z5yAZW8JrgwJH8Fo8RPQzXtxoPl/bkZRMg8UrBZHR422AUTf
        zV8Hq6lIb7I3AH7tHIBySIKlV6JjsTkyMDuEvktVFDAR560enk/NRYpR/h7jyMU+
        CGmzBQG7OLptq8MOh7acEy7gyykqydAZDLwFw88eVK99+QaEauWs5coa3WwSoSJp
        UaN5hmefFUkOk4DyiGx0haS850p+/Cvv3LUZGbD1Yswk7cUC4rk9dMcw72OXMbxZ
        Pz2pQJ42nKXlHxGrtYeqhcxOHxSVJ+lpKJnxNWZqnvR745QKIXB5M/94JG3huNKW
        c6E/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=jw8E05t8pF0s/VlD5rMYENGSZUwN/eshe0KaWjZtg
        SE=; b=MrOs6cFrxutvZegwyYNltSEHDLdOSjpwXMiLacNBvZjMrDNbnzFSTmOn1
        6ZfnsPjUePtwG5ESSQ1bXy53R1NMaW3umbaWYXVOI2fOLSmwvfsXbfnofenGAZUr
        3r3WrNw3kCZujuT3R6SZ9j5YGasf6uKJOA9w/QatkRjxTW9hAsdn7iDjnEOREbdH
        3NUBzRi4meYGUBTdsIsM8g0+DIbnrecns5/ek1UUBn+K10l462ltJdu/Q8pkO3Qw
        I+Dh0l3aEFg2hndYc8kWMkYOMsvGPEyKDoPbeqKgvaigWkbeaKUdg+e8FwQ3RYDG
        womaxI3t06K8R8lRekzY5WOJVnN1w==
X-ME-Sender: <xms:zAp2X28Rkx_V8WOUabydtQflqWwCEADvMCXVrznXs9yq7FQjA_nHgw>
    <xme:zAp2X2tCki8uYj66JXivxwdmhljf5l8Uew8D_l50fdRNoXOMpMHP1KGc7r7znhSVD
    qQkMgy9Q1y8zkslj9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhephfeuvddvleeiveeggeejueekueeljedtjeefteefueejfedvledttefh
    hfeukeffnecukfhppeejfedrvddujedruddtrdeitdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:zAp2X8DB9qT-ZW2Bm7gZpxu9WVMfn9K8DVUNVBI9dfwKeMLkSrRNbg>
    <xmx:zAp2X-dqBlHk6wYD_sYQyDBuUyRjeJyaLYjU8Zsp7QpeUJsbGiRE3w>
    <xmx:zAp2X7PS_l50JJbFV8Tfdu8XwlW1Ma6LmwRNOOEkxQiikC8HnKJZRQ>
    <xmx:zQp2X5tV--qQ2FKSKVYCI7VmhgqYJjOxggJpb_o_zZ1M6ImHDm6OCECtrTvLHuze>
Received: from cisco (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A5E33280064;
        Thu,  1 Oct 2020 12:58:51 -0400 (EDT)
Date:   Thu, 1 Oct 2020 10:58:50 -0600
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
Message-ID: <20201001165850.GC1260245@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <20201001125043.dj6taeieatpw3a4w@gmail.com>
 <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 05:47:54PM +0200, Jann Horn via Containers wrote:
> On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
> <christian.brauner@canonical.com> wrote:
> > On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wrote:
> > > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > > <mtk.manpages@gmail.com> wrote:
> > > > NOTES
> > > >        The file descriptor returned when seccomp(2) is employed with the
> > > >        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
> > > >        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
> > > >        ing,  these interfaces indicate that the file descriptor is read‐
> > > >        able.
> > >
> > > We should probably also point out somewhere that, as
> > > include/uapi/linux/seccomp.h says:
> > >
> > >  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
> > >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
> > >  * same syscall, the most recently added filter takes precedence. This means
> > >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> > >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
> > >  * such filtered syscalls to be executed by sending the response
> > >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
> > >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> > >
> > > In other words, from a security perspective, you must assume that the
> > > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > > calling seccomp(). This should also be noted over in the main
> > > seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
> >
> > So I was actually wondering about this when I skimmed this and a while
> > ago but forgot about this again... Afaict, you can only ever load a
> > single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
> > already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER property
> > in the tasks filter hierarchy then the kernel will refuse to load a new
> > one?
> >
> > static struct file *init_listener(struct seccomp_filter *filter)
> > {
> >         struct file *ret = ERR_PTR(-EBUSY);
> >         struct seccomp_filter *cur;
> >
> >         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> >                 if (cur->notif)
> >                         goto out;
> >         }
> >
> > shouldn't that be sufficient to guarantee that USER_NOTIF filters can't
> > override each other for the same task simply because there can only ever
> > be a single one?
> 
> Good point. Exceeeept that that check seems ineffective because this
> happens before we take the locks that guard against TSYNC, and also
> before we decide to which existing filter we want to chain the new
> filter. So if two threads race with TSYNC, I think they'll be able to
> chain two filters with listeners together.

Yep, seems the check needs to also be in seccomp_can_sync_threads() to
be totally effective,

> I don't know whether we want to eternalize this "only one listener
> across all the filters" restriction in the manpage though, or whether
> the man page should just say that the kernel currently doesn't support
> it but that security-wise you should assume that it might at some
> point.

This requirement originally came from Andy, arguing that the semantics
of this were/are confusing, which still makes sense to me. Perhaps we
should do something like the below?

Tycho


diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..7b107207c2b0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -376,6 +376,18 @@ static int is_ancestor(struct seccomp_filter *parent,
 	return 0;
 }
 
+static bool has_listener_parent(struct seccomp_filter *child)
+{
+	struct seccomp_filter *cur;
+
+	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
+		if (cur->notif)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * seccomp_can_sync_threads: checks if all threads can be synchronized
  *
@@ -385,7 +397,7 @@ static int is_ancestor(struct seccomp_filter *parent,
  * either not in the correct seccomp mode or did not have an ancestral
  * seccomp filter.
  */
-static inline pid_t seccomp_can_sync_threads(void)
+static inline pid_t seccomp_can_sync_threads(unsigned int flags)
 {
 	struct task_struct *thread, *caller;
 
@@ -407,6 +419,11 @@ static inline pid_t seccomp_can_sync_threads(void)
 				 caller->seccomp.filter)))
 			continue;
 
+		/* don't allow TSYNC to install multiple listeners */
+		if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER &&
+		    !has_listener_parent(thread->seccomp.filter))
+			continue;
+
 		/* Return the first thread that cannot be synchronized. */
 		failed = task_pid_vnr(thread);
 		/* If the pid cannot be resolved, then return -ESRCH */
@@ -637,7 +654,7 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
 		int ret;
 
-		ret = seccomp_can_sync_threads();
+		ret = seccomp_can_sync_threads(flags);
 		if (ret) {
 			if (flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
 				return -ESRCH;
@@ -1462,12 +1479,9 @@ static const struct file_operations seccomp_notify_ops = {
 static struct file *init_listener(struct seccomp_filter *filter)
 {
 	struct file *ret = ERR_PTR(-EBUSY);
-	struct seccomp_filter *cur;
 
-	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
-		if (cur->notif)
-			goto out;
-	}
+	if (has_listener_parent(current->seccomp.filter))
+		goto out;
 
 	ret = ERR_PTR(-ENOMEM);
 	filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
