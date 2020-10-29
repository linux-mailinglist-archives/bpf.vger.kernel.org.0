Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE529E48E
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 08:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgJ2Hjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgJ2HYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF6DC0613A6
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 21:26:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l2so1652797lfk.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 21:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bZHSqby9xc03fv8b/uQtgTC0sysq05Jdo5tS6hC7Bk=;
        b=vCF7BqYvpPENaZQ1ij18cOuBn3mjiDl59S9e8pNu4I8MoMuZo8/ftg0Y9yOuESZN09
         VBw04wGTblOlqn6/d//nxST8d02fERV2k+Yqvoj5KIf/bU8IslsX99d6mIRXJv1H9eZ7
         dPdYqdkXenA5Mtf/Ci6Vn4NPk9RQpMYT+WOlqRhTU68ApcUfhfJDbQ4ydF1Vj8SKnJb5
         kYkD7iFe2dzDG5UlFj7yPh8AaapCSTfLe8HSbb08Qh60EKjEcTHQBTCNu6MPXVwS2U+e
         ddO/4+yG92LPOzOsogodfabgmFl0yPhga3RhQIlJ6Ulkl1MZebH5vSSbg1KnGyrTMNXW
         E67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bZHSqby9xc03fv8b/uQtgTC0sysq05Jdo5tS6hC7Bk=;
        b=mYTvB2nydXHattuyH3J8LUUXJyR7kRGttdmnWlscBl+tHAa3JN4+igJrn+GD8RroH/
         sjFCPgBwdx5FWCmCVIpjkQKCgI0Z4TFLJlKpec6QEB0NRDItBdNGd5797P07XZl5nFWu
         n/Qsoqy32Cq3lXsOI10xPSQePdw3UYNcMtCR7dFcDDSi+iT5xAgykV2e32JyNYA4dB+h
         2R/OjGyE3z5NDktrAFMoMIurOakUx6o2lx9dACh/xZKqOW+oqZ1RRYudQsdN59X6Qkck
         iZM6xkcTlHTJfbAYQ1UHpUmdk6rkpimfNGJjomTxi73rhD5aqcth6XyNGviHDn3fUJ2T
         sP9g==
X-Gm-Message-State: AOAM533Pz1z2+XZHstT/w6aN6qXvey+id0BMiitrOWkkvNrie2CTBUMN
        18NlEWmU8SsP9rcm2wUJ6u0C+lHtuFBFohmsHXP5AQ==
X-Google-Smtp-Source: ABdhPJzKHFLrtcctmkuqmI3RamhnK2a1wmI/Y3U/6ijUcRKMrl5Xg1LaPRSJKCqbjtr8CcoK5kQQWSIr/nf0z+LrQ9A=
X-Received: by 2002:a19:c357:: with SMTP id t84mr773624lff.34.1603945592793;
 Wed, 28 Oct 2020 21:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook> <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
 <CAG48ez2OWhpH3HHUJSrAmokJ8=SVwKrmQMSw0gEbTJmKE4myCw@mail.gmail.com> <20201029021348.GB25673@cisco>
In-Reply-To: <20201029021348.GB25673@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 05:26:05 +0100
Message-ID: <CAG48ez2=8RBh_2D=WRKta4n3jvfTpD90j8DA-uOFAm86fKjSzw@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 29, 2020 at 3:13 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > > Consider the following scenario (with supervisor "S" and target "T"; S
> > > wants to wait for events on two file descriptors seccomp_fd and
> > > other_fd):
> > >
> > > S: starts poll() to wait for events on seccomp_fd and other_fd
> > > T: performs a syscall that's filtered with RET_USER_NOTIF
> > > S: poll() returns and signals readiness of seccomp_fd
> > > T: receives signal SIGUSR1
> > > T: syscall aborts, enters signal handler
> > > T: signal handler blocks on unfiltered syscall (e.g. write())
> > > S: starts SECCOMP_IOCTL_NOTIF_RECV
> > > S: blocks because no syscalls are pending
> > >
> > > Depending on what other_fd is, this could in a worst case even lead to
> > > a deadlock (if e.g. the signal handler wants to write to stdout, but
> > > the stdout fd is hooked up to other_fd in the supervisor, but the
> > > supervisor can't consume the data written because it's stuck in
> > > seccomp handling).
> > >
> > > So we have to ensure that when existing code (like that crun code you
> > > linked to) triggers this case, SECCOMP_IOCTL_NOTIF_RECV returns
> > > immediately instead of blocking.
> >
> > Or I guess we could also just set O_NONBLOCK on the fd by default?
> > Since the one existing user is eventloop-based...
>
> I feel like it's ok to return an error from the RECV ioctl() if
> there's never going to be any more events on the fd; was there
> something fundamentally wrong with your patch here:
> https://lore.kernel.org/bpf/CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com/
> ?

No, I have a new version of that about 80% done and hope to send it
out soonish. (There's some stuff around tests that I still need to
cobble together).
