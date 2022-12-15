Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A2464DCEC
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 15:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiLOOeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 09:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLOOeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 09:34:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFD23EB3
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:34:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d3so7036916plr.10
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvKOVyzZE6m+dy4ICll/p6OYV/c+ytiVcHQqdMWtYuw=;
        b=RKjzSrjoXDwnj3R4QKsYp3MX9j32b22s8S4dJ5b4Pq/6uWVxj7Ir9XiqOvkmfT6sa5
         RKftFQDm3QISdzPm7fWkxwGL3zpL44EasIHn3OdjSnokTTWPq7vCDLhoXT87vSdVy8Ag
         pNa9exS7onfbc9g8DxTuzgGiHeQNTEqUotTt4EFsY0L8iUVvPGm9kgKg5q+PiUiERXMo
         +ZrE95SuAYw5q6rQtIFlnpwGR4oYSt2LI2MjooRAjD570FxyqDvDrrl08NRS4wi3xMBQ
         SdVNSfMeJZ74mEWm6Ki2d+D/0+smGBq42mLZbKX58DHhdu1w6kXjJwlnmpiw7i+YW8cL
         lmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvKOVyzZE6m+dy4ICll/p6OYV/c+ytiVcHQqdMWtYuw=;
        b=rnaiL1a6QxmT0+cXIgqxQky2uT0H6thdGjcpGqu35b7E/cOg2+xjcrR1sZwzwnoqSN
         uYM6C2hYks7zaYN29E9zDjlED8PB2OiQesj6BAVDam7E0D4FoSfVzXqwnW6eE/6dWJgs
         3EFaG0VJVGIkB+nTb4+aR0qYMS9a9Da8AT2a5IfqZ6fyVRHhSKDPuZjhlRM5p/3RxO8q
         79rMVMX42B+VO3ZJK2x5xm98cf8cQoA7cXbA1PNQpHKHMR6vLPtlqArryqZzQxa86V6x
         +zLg9w+tPtE6JJx4696VTH4Wi0RlRcUgWcIQbshFNn4MHBO5aon3q1q50V1k6Dj3Zo47
         TtLg==
X-Gm-Message-State: ANoB5pmPOevXt28SN+H/BrNBaoqcEY6SsIhEA+2+hdP/9IlN5T/zH/dx
        5MiVrZmKFhEJ8y6EQNDgZS9gXNLAUL8lsq+F/lQ=
X-Google-Smtp-Source: AA0mqf6J+9mxCWSJvDhz/VI5Ur+OyCJjdCCiP+VMD/+9ZkkJRlSE61WDDMCcZwnz+2tvfaWWFsgVdlvfXRNi4ur67mk=
X-Received: by 2002:a17:903:110c:b0:189:8351:8bd9 with SMTP id
 n12-20020a170903110c00b0018983518bd9mr55701913plh.94.1671114874950; Thu, 15
 Dec 2022 06:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-6-daan.j.demeyer@gmail.com> <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
 <CAO8sHcmNKN6kagFeCoWzjf1K0sOqTQxfdDG-U8iqBGN=TaHefg@mail.gmail.com> <76c8be5a-685d-539c-7323-ab1dc9b06464@meta.com>
In-Reply-To: <76c8be5a-685d-539c-7323-ab1dc9b06464@meta.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Thu, 15 Dec 2022 14:34:23 +0000
Message-ID: <CAO8sHc=aWEaDiAaPSyquMdH3q-2=szb9WLFAUmQm+jdk5Sp+zA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> >> On 12/10/22 11:35 AM, Daan De Meyer wrote:
> >>> These hooks allows intercepting bind(), connect(), getsockname(),
> >>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> >>> socket hooks get write access to the address length because the
> >>> address length is not fixed when dealing with unix sockets and
> >>> needs to be modified when a unix socket address is modified by
> >>> the hook. Because abstract socket unix addresses start with a
> >>> NUL byte, we cannot recalculate the socket address in kernelspace
> >>> after running the hook by calculating the length of the unix socket
> >>> path using strlen().
> >>
> >> Yes, although we cannot calculate the socket path length with
> >> strlen(). But we still have a method to find the path. In
> >> unix_seq_show(), the unix socket path is calculated as below,
> >>
> >>                   if (u->addr) {  // under a hash table lock here
> >>                           int i, len;
> >>                           seq_putc(seq, ' ');
> >>
> >>                           i =3D 0;
> >>                           len =3D u->addr->len -
> >>                                   offsetof(struct sockaddr_un, sun_pat=
h);
> >>                           if (u->addr->name->sun_path[0]) {
> >>                                   len--;
> >>                           } else {
> >>                                   seq_putc(seq, '@');
> >>                                   i++;
> >>                           }
> >>                           for ( ; i < len; i++)
> >>                                   seq_putc(seq, u->addr->name->sun_pat=
h[i] ?:
> >>                                            '@');
> >>                   }
> >>
> >> Is it possible that we can use the above method to find the
> >> address length so we won't need to pass uaddr_len to bpf program?
> >>
> >> Since all other hooks do not need to uaddr_len, you could add some
> >> new hooks for unix socket which can specially calculate uaddr_len
> >> after the bpf program run.
> >
> > I don't think we can. If we look at the definition of abstract unix
> > socket in the official man page:
> >
> >> abstract: an abstract socket address is distinguished (from a pathname=
 socket) by the fact that sun_path[0] is a null byte ('\0').  The socket's =
address in this namespace is given by the additional bytes in sun_path that=
 are covered by the specified length of the address structure.  (Null bytes=
 in
> >> the  name  have  no  special  significance.)   The name has no connect=
ion with filesystem pathnames.  When the address of an abstract socket is r=
eturned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., gr=
eater than 2), and the name of the socket is contained in the first (addrle=
n -
> >> sizeof(sa_family_t)) bytes of sun_path.
> >
> > This specifically says that the address in the abstract namespace is
> > given by the additional bytes in sun_path that are covered by the
> > length of the address structure. If I understand correctly, that means
> > there's no way to derive the length from just the contents of the
> > sockaddr structure. We need
> > the actual length as specified by the caller to know which bytes
> > belong to the address. Note that it's valid for the abstract name to
> > contain Null bytes, so we cannot use those in any way or form to
> > detect whether further bytes belong to the address or not. It seems
> > valid to have an abstract name
> > consisting of 107 Null bytes in sun_path.
>
> Okay, it looks like bpf program is able to set abstract name as well.
> It would be good we have an example for this in selftest.
>
> With abstract address setable by bpf program, I guess you are right,
> we have to let user to explicitly tell us the address length.
>
> I assume it is possible for user to write an address like below:
> "a\0b\0"
> addr_len =3D offsetof(struct sockaddr_un, sun_path) + 4
> but actually it is illegal, right? We have to validate the
> legality of sun_path/addr_len beyond unix_validate_addr(), right?

This is not actually illegal according to the man page I think, let's
look at the following quote from the man page:

>  Pathname sockets
>      When binding a socket to a pathname, a few rules should be observed =
for maximum portability and ease of coding:
>
>      *  The pathname in sun_path should be null-terminated.
>
>      *  The length of the pathname, including the terminating null byte, =
should not exceed the size of sun_path.
>
>      *  The addrlen argument that describes the enclosing sockaddr_un str=
ucture should have a value of at least:
>
>             offsetof(struct sockaddr_un, sun_path)+strlen(addr.sun_path)+=
1
>
>         or, more simply, addrlen can be specified as sizeof(struct sockad=
dr_un).

So when doing a pathname based path, the address length is allowed to
be bigger than the actual path. So I don't think
we need to do any more validation than what is done by
unix_validate_addr(). The selftests are already using abstract
unix sockets because they don't need any cleanup.


On Tue, 13 Dec 2022 at 21:54, Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/13/22 3:36 AM, Daan De Meyer wrote:
> >> On 12/10/22 11:35 AM, Daan De Meyer wrote:
> >>> These hooks allows intercepting bind(), connect(), getsockname(),
> >>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> >>> socket hooks get write access to the address length because the
> >>> address length is not fixed when dealing with unix sockets and
> >>> needs to be modified when a unix socket address is modified by
> >>> the hook. Because abstract socket unix addresses start with a
> >>> NUL byte, we cannot recalculate the socket address in kernelspace
> >>> after running the hook by calculating the length of the unix socket
> >>> path using strlen().
> >>
> >> Yes, although we cannot calculate the socket path length with
> >> strlen(). But we still have a method to find the path. In
> >> unix_seq_show(), the unix socket path is calculated as below,
> >>
> >>                   if (u->addr) {  // under a hash table lock here
> >>                           int i, len;
> >>                           seq_putc(seq, ' ');
> >>
> >>                           i =3D 0;
> >>                           len =3D u->addr->len -
> >>                                   offsetof(struct sockaddr_un, sun_pat=
h);
> >>                           if (u->addr->name->sun_path[0]) {
> >>                                   len--;
> >>                           } else {
> >>                                   seq_putc(seq, '@');
> >>                                   i++;
> >>                           }
> >>                           for ( ; i < len; i++)
> >>                                   seq_putc(seq, u->addr->name->sun_pat=
h[i] ?:
> >>                                            '@');
> >>                   }
> >>
> >> Is it possible that we can use the above method to find the
> >> address length so we won't need to pass uaddr_len to bpf program?
> >>
> >> Since all other hooks do not need to uaddr_len, you could add some
> >> new hooks for unix socket which can specially calculate uaddr_len
> >> after the bpf program run.
> >
> > I don't think we can. If we look at the definition of abstract unix
> > socket in the official man page:
> >
> >> abstract: an abstract socket address is distinguished (from a pathname=
 socket) by the fact that sun_path[0] is a null byte ('\0').  The socket's =
address in this namespace is given by the additional bytes in sun_path that=
 are covered by the specified length of the address structure.  (Null bytes=
 in
> >> the  name  have  no  special  significance.)   The name has no connect=
ion with filesystem pathnames.  When the address of an abstract socket is r=
eturned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., gr=
eater than 2), and the name of the socket is contained in the first (addrle=
n -
> >> sizeof(sa_family_t)) bytes of sun_path.
> >
> > This specifically says that the address in the abstract namespace is
> > given by the additional bytes in sun_path that are covered by the
> > length of the address structure. If I understand correctly, that means
> > there's no way to derive the length from just the contents of the
> > sockaddr structure. We need
> > the actual length as specified by the caller to know which bytes
> > belong to the address. Note that it's valid for the abstract name to
> > contain Null bytes, so we cannot use those in any way or form to
> > detect whether further bytes belong to the address or not. It seems
> > valid to have an abstract name
> > consisting of 107 Null bytes in sun_path.
>
> Okay, it looks like bpf program is able to set abstract name as well.
> It would be good we have an example for this in selftest.
>
> With abstract address setable by bpf program, I guess you are right,
> we have to let user to explicitly tell us the address length.
>
> I assume it is possible for user to write an address like below:
> "a\0b\0"
> addr_len =3D offsetof(struct sockaddr_un, sun_path) + 4
> but actually it is illegal, right? We have to validate the
> legality of sun_path/addr_len beyond unix_validate_addr(), right?
>
> >
> >
> > On Tue, 13 Dec 2022 at 06:20, Yonghong Song <yhs@meta.com> wrote:
> >>
> >>
> >>
> >> On 12/10/22 11:35 AM, Daan De Meyer wrote:
> >>> These hooks allows intercepting bind(), connect(), getsockname(),
> >>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> >>> socket hooks get write access to the address length because the
> >>> address length is not fixed when dealing with unix sockets and
> >>> needs to be modified when a unix socket address is modified by
> >>> the hook. Because abstract socket unix addresses start with a
> >>> NUL byte, we cannot recalculate the socket address in kernelspace
> >>> after running the hook by calculating the length of the unix socket
> >>> path using strlen().
> >>
> >> Yes, although we cannot calculate the socket path length with
> >> strlen(). But we still have a method to find the path. In
> >> unix_seq_show(), the unix socket path is calculated as below,
> >>
> >>                   if (u->addr) {  // under a hash table lock here
> >>                           int i, len;
> >>                           seq_putc(seq, ' ');
> >>
> >>                           i =3D 0;
> >>                           len =3D u->addr->len -
> >>                                   offsetof(struct sockaddr_un, sun_pat=
h);
> >>                           if (u->addr->name->sun_path[0]) {
> >>                                   len--;
> >>                           } else {
> >>                                   seq_putc(seq, '@');
> >>                                   i++;
> >>                           }
> >>                           for ( ; i < len; i++)
> >>                                   seq_putc(seq, u->addr->name->sun_pat=
h[i] ?:
> >>                                            '@');
> >>                   }
> >>
> >> Is it possible that we can use the above method to find the
> >> address length so we won't need to pass uaddr_len to bpf program?
> >>
> >> Since all other hooks do not need to uaddr_len, you could add some
> >> new hooks for unix socket which can specially calculate uaddr_len
> >> after the bpf program run.
> >>
> >>>
> >>> This hook can be used when users want to multiplex syscall to a
> >>> single unix socket to multiple different processes behind the scenes
> >>> by redirecting the connect() and other syscalls to process specific
> >>> sockets.
> >>> ---
> >>>    include/linux/bpf-cgroup-defs.h |  6 +++
> >>>    include/linux/bpf-cgroup.h      | 29 ++++++++++-
> >>>    include/uapi/linux/bpf.h        | 14 ++++--
> >>>    kernel/bpf/cgroup.c             | 11 ++++-
> >>>    kernel/bpf/syscall.c            | 18 +++++++
> >>>    kernel/bpf/verifier.c           |  7 ++-
> >>>    net/core/filter.c               | 45 +++++++++++++++--
> >>>    net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++=
----
> >>>    tools/include/uapi/linux/bpf.h  | 14 ++++--
> >>>    9 files changed, 204 insertions(+), 25 deletions(-)
> >>>
> [...]
