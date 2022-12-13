Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228564B44B
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiLMLhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiLMLgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:36:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFC1CB1A
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 03:36:45 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 142so10230673pga.1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2yhGJwoyqJ1+UZgEPFuGFDjnoXbtZpSx38BOMIQhBs=;
        b=KMJvEh75JGH7VebeRj3dVHF9p87pqMvlkkJUOLkwocynzEHKPQTTHhhN1xeyz9NjR4
         B9SeyeVLKNxcu0+UsjNcGQKgvlm37tZrErNd8CZC++Uv38rkCPMQ7ork5G9VJ3GOuDes
         ywf/ZcrdzYvwtHjy0E74k2PHZY67OAPnOrtlSf/K3+e1GKvAI/ccWFCthPVsTRg03fB8
         vbBywkRgaMzqz5vF3/MAN9xiNeCK8WovEfvRnAzcV7Js0PpDBf3GjcDlU8bSNV5SMg6F
         Cu4s+StleX1CRHe5+tDfJoM82BNDrR96z/ihXIQnux48z82ACN1xEjw/u9v7NDcypqw5
         tgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2yhGJwoyqJ1+UZgEPFuGFDjnoXbtZpSx38BOMIQhBs=;
        b=k3hkA3EOuVTfB4l5UjpLTkBi1rJL12FkWE+NyKeI3R000CntZHu0SRtxHiDtz4vExR
         j8/uQ8B8CgjMbHnU52+/GUcpEEWyijMBxc4dD9Q59ramXD7oINrIpGHq+hKgfv7AbGdy
         PsCKqGrovyUNwCAO917jrNPS3y/JAup++Om1gkGoK1CrhFHtZhnnmPYZqiFjYc1wgk9F
         pTR9lX2SBo6xjE4797LqdwbzSvQ9IWYrlOdti2HMWKCzNLq6TeNrQGHLF/wj+pOUBkc9
         pU++tO1NB3GJbyeyauvcI51HO+0bEOyI1I5BvDaUxwwHE7WmCNwG6t7QwoGl6vs7DW9k
         KIpA==
X-Gm-Message-State: ANoB5pnwiKelzVzIFa75cXLbo02UOrVTPFehpjLM8UvL35Oo0MovGLsH
        YMtn6yIQV2ZOwsJ5bHQ+yeqUz5a4aFZilr/I45TdboQSoR/qtQ==
X-Google-Smtp-Source: AA0mqf4keP/3wvnvDTA1yeIc/tXpCh0xZR6x5pbo/Y3RWhL1X7CVNP2tgmZ91talAnKNwHwI5z/Fkgfb3UPD/3J0sQc=
X-Received: by 2002:a63:1747:0:b0:478:1391:fd14 with SMTP id
 7-20020a631747000000b004781391fd14mr47750994pgx.112.1670931404633; Tue, 13
 Dec 2022 03:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-6-daan.j.demeyer@gmail.com> <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
In-Reply-To: <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Tue, 13 Dec 2022 11:36:33 +0000
Message-ID: <CAO8sHcmNKN6kagFeCoWzjf1K0sOqTQxfdDG-U8iqBGN=TaHefg@mail.gmail.com>
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

> On 12/10/22 11:35 AM, Daan De Meyer wrote:
> > These hooks allows intercepting bind(), connect(), getsockname(),
> > getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> > socket hooks get write access to the address length because the
> > address length is not fixed when dealing with unix sockets and
> > needs to be modified when a unix socket address is modified by
> > the hook. Because abstract socket unix addresses start with a
> > NUL byte, we cannot recalculate the socket address in kernelspace
> > after running the hook by calculating the length of the unix socket
> > path using strlen().
>
> Yes, although we cannot calculate the socket path length with
> strlen(). But we still have a method to find the path. In
> unix_seq_show(), the unix socket path is calculated as below,
>
>                  if (u->addr) {  // under a hash table lock here
>                          int i, len;
>                          seq_putc(seq, ' ');
>
>                          i =3D 0;
>                          len =3D u->addr->len -
>                                  offsetof(struct sockaddr_un, sun_path);
>                          if (u->addr->name->sun_path[0]) {
>                                  len--;
>                          } else {
>                                  seq_putc(seq, '@');
>                                  i++;
>                          }
>                          for ( ; i < len; i++)
>                                  seq_putc(seq, u->addr->name->sun_path[i]=
 ?:
>                                           '@');
>                  }
>
> Is it possible that we can use the above method to find the
> address length so we won't need to pass uaddr_len to bpf program?
>
> Since all other hooks do not need to uaddr_len, you could add some
> new hooks for unix socket which can specially calculate uaddr_len
> after the bpf program run.

I don't think we can. If we look at the definition of abstract unix
socket in the official man page:

> abstract: an abstract socket address is distinguished (from a pathname so=
cket) by the fact that sun_path[0] is a null byte ('\0').  The socket's add=
ress in this namespace is given by the additional bytes in sun_path that ar=
e covered by the specified length of the address structure.  (Null bytes in
> the  name  have  no  special  significance.)   The name has no connection=
 with filesystem pathnames.  When the address of an abstract socket is retu=
rned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., great=
er than 2), and the name of the socket is contained in the first (addrlen -
> sizeof(sa_family_t)) bytes of sun_path.

This specifically says that the address in the abstract namespace is
given by the additional bytes in sun_path that are covered by the
length of the address structure. If I understand correctly, that means
there's no way to derive the length from just the contents of the
sockaddr structure. We need
the actual length as specified by the caller to know which bytes
belong to the address. Note that it's valid for the abstract name to
contain Null bytes, so we cannot use those in any way or form to
detect whether further bytes belong to the address or not. It seems
valid to have an abstract name
consisting of 107 Null bytes in sun_path.


On Tue, 13 Dec 2022 at 06:20, Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/10/22 11:35 AM, Daan De Meyer wrote:
> > These hooks allows intercepting bind(), connect(), getsockname(),
> > getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> > socket hooks get write access to the address length because the
> > address length is not fixed when dealing with unix sockets and
> > needs to be modified when a unix socket address is modified by
> > the hook. Because abstract socket unix addresses start with a
> > NUL byte, we cannot recalculate the socket address in kernelspace
> > after running the hook by calculating the length of the unix socket
> > path using strlen().
>
> Yes, although we cannot calculate the socket path length with
> strlen(). But we still have a method to find the path. In
> unix_seq_show(), the unix socket path is calculated as below,
>
>                  if (u->addr) {  // under a hash table lock here
>                          int i, len;
>                          seq_putc(seq, ' ');
>
>                          i =3D 0;
>                          len =3D u->addr->len -
>                                  offsetof(struct sockaddr_un, sun_path);
>                          if (u->addr->name->sun_path[0]) {
>                                  len--;
>                          } else {
>                                  seq_putc(seq, '@');
>                                  i++;
>                          }
>                          for ( ; i < len; i++)
>                                  seq_putc(seq, u->addr->name->sun_path[i]=
 ?:
>                                           '@');
>                  }
>
> Is it possible that we can use the above method to find the
> address length so we won't need to pass uaddr_len to bpf program?
>
> Since all other hooks do not need to uaddr_len, you could add some
> new hooks for unix socket which can specially calculate uaddr_len
> after the bpf program run.
>
> >
> > This hook can be used when users want to multiplex syscall to a
> > single unix socket to multiple different processes behind the scenes
> > by redirecting the connect() and other syscalls to process specific
> > sockets.
> > ---
> >   include/linux/bpf-cgroup-defs.h |  6 +++
> >   include/linux/bpf-cgroup.h      | 29 ++++++++++-
> >   include/uapi/linux/bpf.h        | 14 ++++--
> >   kernel/bpf/cgroup.c             | 11 ++++-
> >   kernel/bpf/syscall.c            | 18 +++++++
> >   kernel/bpf/verifier.c           |  7 ++-
> >   net/core/filter.c               | 45 +++++++++++++++--
> >   net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++---=
-
> >   tools/include/uapi/linux/bpf.h  | 14 ++++--
> >   9 files changed, 204 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup=
-defs.h
> > index 7b121bd780eb..8196ccb81915 100644
> > --- a/include/linux/bpf-cgroup-defs.h
> > +++ b/include/linux/bpf-cgroup-defs.h
> > @@ -26,21 +26,27 @@ enum cgroup_bpf_attach_type {
> >       CGROUP_DEVICE,
> >       CGROUP_INET4_BIND,
> >       CGROUP_INET6_BIND,
> > +     CGROUP_UNIX_BIND,
> >       CGROUP_INET4_CONNECT,
> >       CGROUP_INET6_CONNECT,
> > +     CGROUP_UNIX_CONNECT,
> >       CGROUP_INET4_POST_BIND,
> >       CGROUP_INET6_POST_BIND,
> >       CGROUP_UDP4_SENDMSG,
> >       CGROUP_UDP6_SENDMSG,
> > +     CGROUP_UNIX_SENDMSG,
> >       CGROUP_SYSCTL,
> >       CGROUP_UDP4_RECVMSG,
> >       CGROUP_UDP6_RECVMSG,
> > +     CGROUP_UNIX_RECVMSG,
> >       CGROUP_GETSOCKOPT,
> >       CGROUP_SETSOCKOPT,
> >       CGROUP_INET4_GETPEERNAME,
> >       CGROUP_INET6_GETPEERNAME,
> > +     CGROUP_UNIX_GETPEERNAME,
> >       CGROUP_INET4_GETSOCKNAME,
> >       CGROUP_INET6_GETSOCKNAME,
> > +     CGROUP_UNIX_GETSOCKNAME,
> >       CGROUP_INET_SOCK_RELEASE,
> >       CGROUP_LSM_START,
> >       CGROUP_LSM_END =3D CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 3ab2f06ddc8a..4de3016f01e4 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -46,21 +46,27 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type atta=
ch_type)
> >       CGROUP_ATYPE(CGROUP_DEVICE);
> >       CGROUP_ATYPE(CGROUP_INET4_BIND);
> >       CGROUP_ATYPE(CGROUP_INET6_BIND);
> > +     CGROUP_ATYPE(CGROUP_UNIX_BIND);
> >       CGROUP_ATYPE(CGROUP_INET4_CONNECT);
> >       CGROUP_ATYPE(CGROUP_INET6_CONNECT);
> > +     CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
> >       CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
> >       CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
> >       CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
> >       CGROUP_ATYPE(CGROUP_UDP6_SENDMSG);
> > +     CGROUP_ATYPE(CGROUP_UNIX_SENDMSG);
> >       CGROUP_ATYPE(CGROUP_SYSCTL);
> >       CGROUP_ATYPE(CGROUP_UDP4_RECVMSG);
> >       CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
> > +     CGROUP_ATYPE(CGROUP_UNIX_RECVMSG);
> >       CGROUP_ATYPE(CGROUP_GETSOCKOPT);
> >       CGROUP_ATYPE(CGROUP_SETSOCKOPT);
> >       CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
> >       CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
> > +     CGROUP_ATYPE(CGROUP_UNIX_GETPEERNAME);
> >       CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
> >       CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
> > +     CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
> >       CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
> >       default:
> >               return CGROUP_BPF_ATTACH_TYPE_INVALID;
> > @@ -273,9 +279,13 @@ static inline bool cgroup_bpf_sock_enabled(struct =
sock *sk,
> >               __ret;                                                   =
    \
> >       })
> >
> > +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen)       =
               \
> > +     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_BIND=
, NULL)
> > +
> >   #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)                           =
      \
> >       ((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||                  \
> > -       cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&                 \
> > +       cgroup_bpf_enabled(CGROUP_INET6_CONNECT) ||                  \
> > +       cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) &&                  \
> >        (sk)->sk_prot->pre_connect)
> >
> >   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)       =
              \
> > @@ -284,24 +294,36 @@ static inline bool cgroup_bpf_sock_enabled(struct=
 sock *sk,
> >   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)       =
              \
> >       BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
> >
> > +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)         =
              \
> > +     BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
> > +
> >   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)  =
      \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CON=
NECT, NULL)
> >
> >   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)  =
      \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CON=
NECT, NULL)
> >
> > +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)    =
      \
> > +     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONN=
ECT, NULL)
> > +
> >   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_=
ctx)       \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SEND=
MSG, t_ctx)
> >
> >   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_=
ctx)       \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SEND=
MSG, t_ctx)
> >
> > +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_c=
tx)    \
> > +     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_SEND=
MSG, t_ctx)
> > +
> >   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)   =
       \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECV=
MSG, NULL)
> >
> >   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)   =
       \
> >       BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECV=
MSG, NULL)
> >
> > +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen)    =
       \
> > +     BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_RECV=
MSG, NULL)
> > +
> >   /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
> >    * fullsock and its parent fullsock cannot be traced by
> >    * sk_to_full_sk().
> > @@ -487,16 +509,21 @@ static inline int bpf_percpu_cgroup_storage_updat=
e(struct bpf_map *map,
> >   #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype=
, flags) ({ 0; })
> > +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen) ({ 0; =
})
> >   #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; =
})
> >   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) (=
{ 0; })
> >   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; =
})
> >   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) (=
{ 0; })
> > +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
> > +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ =
0; })
> >   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_=
ctx) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_=
ctx) ({ 0; })
> > +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_c=
tx) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({=
 0; })
> >   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({=
 0; })
> > +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ =
0; })
> >   #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access=
) ({ 0; })
> >   #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({=
 0; })
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 9e3c33f83bba..b73e4da458fd 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -999,17 +999,21 @@ enum bpf_attach_type {
> >       BPF_SK_MSG_VERDICT,
> >       BPF_CGROUP_INET4_BIND,
> >       BPF_CGROUP_INET6_BIND,
> > +     BPF_CGROUP_UNIX_BIND,
> >       BPF_CGROUP_INET4_CONNECT,
> >       BPF_CGROUP_INET6_CONNECT,
> > +     BPF_CGROUP_UNIX_CONNECT,
> >       BPF_CGROUP_INET4_POST_BIND,
> >       BPF_CGROUP_INET6_POST_BIND,
> >       BPF_CGROUP_UDP4_SENDMSG,
> >       BPF_CGROUP_UDP6_SENDMSG,
> > +     BPF_CGROUP_UNIX_SENDMSG,
> >       BPF_LIRC_MODE2,
> >       BPF_FLOW_DISSECTOR,
> >       BPF_CGROUP_SYSCTL,
> >       BPF_CGROUP_UDP4_RECVMSG,
> >       BPF_CGROUP_UDP6_RECVMSG,
> > +     BPF_CGROUP_UNIX_RECVMSG,
> >       BPF_CGROUP_GETSOCKOPT,
> >       BPF_CGROUP_SETSOCKOPT,
> >       BPF_TRACE_RAW_TP,
> > @@ -1020,8 +1024,10 @@ enum bpf_attach_type {
> >       BPF_TRACE_ITER,
> >       BPF_CGROUP_INET4_GETPEERNAME,
> >       BPF_CGROUP_INET6_GETPEERNAME,
> > +     BPF_CGROUP_UNIX_GETPEERNAME,
> >       BPF_CGROUP_INET4_GETSOCKNAME,
> >       BPF_CGROUP_INET6_GETSOCKNAME,
> > +     BPF_CGROUP_UNIX_GETSOCKNAME,
> >       BPF_XDP_DEVMAP,
> >       BPF_CGROUP_INET_SOCK_RELEASE,
> >       BPF_XDP_CPUMAP,
>
> This is uapi. Please add new attach type to the end of enum type.
>
> > @@ -2575,8 +2581,8 @@ union bpf_attr {
> >    *          *bpf_socket* should be one of the following:
> >    *
> >    *          * **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> > - *           * **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT=
**
> > - *             and **BPF_CGROUP_INET6_CONNECT**.
> > + *           * **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT=
**,
> > + *             **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONN=
ECT**.
> >    *
> >    *          This helper actually implements a subset of **setsockopt(=
)**.
> >    *          It supports the following *level*\ s:
> > @@ -2809,8 +2815,8 @@ union bpf_attr {
> >    *          *bpf_socket* should be one of the following:
> >    *
> >    *          * **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> > - *           * **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT=
**
> > - *             and **BPF_CGROUP_INET6_CONNECT**.
> > + *           * **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT=
**,
> > + *             **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONN=
ECT**.
> >    *
> >    *          This helper actually implements a subset of **getsockopt(=
)**.
> >    *          It supports the same set of *optname*\ s that is supporte=
d by
> [...]
