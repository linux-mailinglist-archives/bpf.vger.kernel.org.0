Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3945CE46
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhKXUp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 15:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKXUpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 15:45:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3054C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 12:42:43 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q64so4764175qkd.5
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzYX8FdE1pFhE/6BDT7RCVWLMI2IQHDHzyEp3OtLX7c=;
        b=RxXVlI7q2Elgv/2V8IYhEcjO7yhInJnGPymHAIM/KObIIm99F+L/eLF3wwe87jY3wu
         b6tepxBxIAIqaYY6L4QO0z4pnxs12FW6LkasaG9k0mgkmqH3+BOrMHw1NK6GBxXzwKiQ
         XwVy857Zv5bFhzNKge994cZmOz/eZGQqjf9IOI1p+65yawZSW3qMuOoLwEHgomrMBmXA
         ViJPPPZMTAbsubi17JszBaSfJSQIUuZ/guqOHjy6uV/Y9bcsWiIJAgJ6JFIqCJ8ULYGj
         lXmFPX93SaBQSgg78ty+C7c1sJCp124xv6op7cYntzzeDD1+rWyHrI6C7bwTp1kDMW8L
         Z9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzYX8FdE1pFhE/6BDT7RCVWLMI2IQHDHzyEp3OtLX7c=;
        b=yL0rH0Qi+HgpS7UtgCvoHGhpDhTMvp8K7hSk21ZDm2AbmCQnFoooS2Byp/X1NVto3e
         L7H3iTHKfHGNPfgBkScqPymefdR6xEBfSHI39C+QlSA6HrvQUv4HmWCnmqVqrwMW9RHi
         HuGwIm5YMYEc3lhGtFR9v8oCW+T56mWkMxKU/NrsDVTLJuzsLpMC2b7iMo7lrcxZiQkF
         rLamRj3yRT7U8S7G/u+eyUBB+4oMA0oVSUcXfrnVlI8MeNQKAqOnxPkJDTZG6TArS8zM
         Frr+EGtGmlNhnqDSzxiNAb8hraMa3N/8fI0eSNmTknC3KX9PdmykIcr7B+LUNqqpIVKL
         fY+w==
X-Gm-Message-State: AOAM533k8MT9u1P1939m52/H7PmKclyZhvduri3cBI/BqEGxGDVRdXw2
        L/Nc0eB42CbmfFI8PboTbNWl3BOaa3wlYKlWkmya3eHEOXc=
X-Google-Smtp-Source: ABdhPJyZtqdoO17vet6u60Y/GSmLOojaEjMtj5voIy0er0liNjwocYi0rnSdSX/oMYhjyb0H+G3JdW+KWRlAIYXYc6M=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr19943212ybf.114.1637786563075;
 Wed, 24 Nov 2021 12:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20211117194114.347675-1-andrii@kernel.org> <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava> <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
 <YZ4kUzG26392CvWi@krava> <YZ5UFmJlb7rf4mKI@krava> <CAEf4BzZ5DXdKAVD15r4tViH8neaKV4Pq82P6bWKRT2SAt7Jd9Q@mail.gmail.com>
 <YZ6ezpVG8jgLV12k@krava>
In-Reply-To: <YZ6ezpVG8jgLV12k@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Nov 2021 12:42:31 -0800
Message-ID: <CAEf4BzZpvJRLz-DxoXQcVjnedAkZqZG_6SXJTAObqzZziYuReg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 12:21 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 11:20:42AM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 24, 2021 at 7:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 12:39:00PM +0100, Jiri Olsa wrote:
> > > > On Thu, Nov 18, 2021 at 02:49:35PM -0800, Andrii Nakryiko wrote:
> > > > > On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > > > > > > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > > > >
> > > > > > > > According to [0], compilers sometimes might produce duplicate DWARF
> > > > > > > > definitions for exactly the same struct/union within the same
> > > > > > > > compilation unit (CU). We've had similar issues with identical arrays
> > > > > > > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > > > > > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > > > > > > same for struct/union by ensuring that two structs/unions are exactly
> > > > > > > > the same, down to the integer values of field referenced type IDs.
> > > > > > >
> > > > > > > Jiri, can you please try this in your setup and see if that handles
> > > > > > > all situations or there are more complicated ones still. We'll need a
> > > > > > > test for more complicated ones in that case :( Thanks.
> > > > > >
> > > > > > it seems to help largely, but I still see few modules (67 out of 780)
> > > > > > that keep 'struct module' for some reason.. their struct module looks
> > > > > > completely the same as is in vmlinux
> > > > >
> > > > > Curious, what's the size of all the module BTFs now?
> > > >
> > > > sorry for delay, I was waiting for s390x server
> > > >
> > > > so with 'current' fedora kernel rawhide I'm getting slightly different
> > > > total size number than before, so something has changed after the merge
> > > > window..
> > > >
> > > > however the increase with BTF enabled in modules is now from 16M to 18M,
> > > > so the BTF data adds just about 2M, which I think we can live with
> > > >
> >
> > 16MB for vmlinux BTF is quite a lot. Is it a allmodyesconfig or something?
>
> looks like my english betrayed me again.. sry ;-)
>
> size of all modules without BTF is 16M,
> size of all modules with BTF is 18M,
>
> so it's overall 2M increase
>
> also note that each module is compressed with xz

Oh, so those 16MB are binaries of modules, not just BTF. Would be nice
to do just .BTF ELF section comparisons, but up to you, just my
curiosity.

>
> jirka
>
> >
> > > > > And yes, please
> > > > > try to narrow down what is causing the bloat this time. I think this
> > > >
> > > > I'm on it
> > >
> > > I'm seeing vmlinux BTF having just FWD record for sctp_mib struct,
> > > while the kernel module has the full definition
> > >
> > > kernel:
> > >
> > >         [2798] STRUCT 'netns_sctp' size=296 vlen=46
> > >                 'sctp_statistics' type_id=2800 bits_offset=0
> > >
> > >         [2799] FWD 'sctp_mib' fwd_kind=struct
> > >         [2800] PTR '(anon)' type_id=2799
> > >
> > >
> > > module before dedup:
> > >
> > >         [78928] STRUCT 'netns_sctp' size=296 vlen=46
> > >                 'sctp_statistics' type_id=78930 bits_offset=0
> > >
> > >         [78929] STRUCT 'sctp_mib' size=272 vlen=1
> > >                 'mibs' type_id=80518 bits_offset=0
> > >         [78930] PTR '(anon)' type_id=78929
> > >
> > >
> > > this field is referenced from within 'struct module' so it won't
> > > match its kernel version and as a result extra 'struct module'
> > > stays in the module's BTF
> > >
> >
> > Yeah, not much we could do about that short of just blindly matching
> > FWD to STRUCT/UNION/ENUM by name, which sounds bad to me, I avoided
> > doing that in BTF dedup algorithm. We only resolve FWD to
> > STRUCT/UNION/ENUM when we have some containing struct with a field
> > that points to FWD and (in another instance of the containing struct)
> > to STRUCT/UNION/ENUM. That way we have sort of a proof that we are
> > resolving the right FWD. While in this case it would be a blind guess
> > based on name alone.
> >
> > > I'll need to check debuginfo/pahole if that FWD is correct, but
> > > I guess it's normal that some structs might end up unwinded only
> > > in modules and not necessarily in vmlinux
> >
> > It can happen, yes. If that's a very common case, ideally we should
> > make sure that modules keep FWD or that vmlinux BTF does have a full
> > struct instead of FWD.
> >
> >
> > >
> > > jirka
> > >
> >
>
