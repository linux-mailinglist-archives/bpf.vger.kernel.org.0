Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8960EBD0
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiJZWrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiJZWrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 18:47:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC743E6C
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 15:46:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2812295wmb.3
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rxp50k6/fdyfIAoGJwO+c4YrHDnFXsq7g7I5FnDONAg=;
        b=EUPqVzLsep6K79Xzgk36Y/KOsDTqapwNaVZ6DAF/cGLDg55ZN+RsUXNJOApEootWqi
         xH6lN7j54GrBlmQ+4yMTpNpMuzdk4+oYiOEWXGc8vyvHOilxypuNPu+aWQevTByOhMyW
         NplO1KELDd2BHkZL5kNPv7cKeOkQ+yiUYjRCQc1TNi5yqoeA7lmlrJ2uwclfvt5guZOX
         qc4T+LJh/hvffjywxdOJQ0iX/dz6lVIOuHUcMTKBqIfdG6buq9HqO6LmZZ2kYFQDDijd
         XYgQ3foLLVvBi8PF/YHi5RVUx3DfQLsngHfDO9MFM/e/HvaeSAno2eqTcvjl70uEldL+
         s/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rxp50k6/fdyfIAoGJwO+c4YrHDnFXsq7g7I5FnDONAg=;
        b=DeuHgbFMw9f/DgQO1mxXkTEY3CMci3CGsCMvVALB/15vWBolSNHXlODjwq7Fclzflb
         mdXTXhLv/DhcnJGMAgohcBjtk0YC/vooNKscTXgZmKOH/LnuyZtoeREpLvFji4LhbAhk
         kSgPZfFkHhrUVvvulNHyJfLY0WpAstTDGz95tdO5Q9kjXFGMzYsMQDA+ZVpTKhPKH9Mj
         aLT5RFdWNwGRinD1JhajI0J+O5W0D9TJWYsYA2FIp1b/dUB5wmAyROVXa3QF1th+h5Br
         XX0QaCeb2Czjbi+g5s9w24zkVzgYY69LfLH1aQ7dn0KG8ravWEMLeegzJ4xZB8tiUEyD
         PwXA==
X-Gm-Message-State: ACrzQf2keKo52h4VeQpqIYGfXZ5Sq6za5O3v/N50pFy6Apdqw6KCd9qz
        +cdFYJg96aAZIIzzZ8BHkNM=
X-Google-Smtp-Source: AMsMyM5GYQzCRzSjn8O1EuXlQS/IDC6fbu7jqdnveXUR0H385LKe1R/LCiFe2+X3CGKQc+WrFMS8Mg==
X-Received: by 2002:a7b:cb8d:0:b0:3cf:4969:9bc7 with SMTP id m13-20020a7bcb8d000000b003cf49699bc7mr3978898wmi.71.1666824415248;
        Wed, 26 Oct 2022 15:46:55 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm3366127wmq.23.2022.10.26.15.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:46:54 -0700 (PDT)
Message-ID: <999da51bdf050f155ba299500061b3eb6e0dcd0d.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Thu, 27 Oct 2022 01:46:53 +0300
In-Reply-To: <20221025234629.xsjnhobxl2ky35i5@macbook-pro-4.dhcp.thefacebook.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <20221025234629.xsjnhobxl2ky35i5@macbook-pro-4.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-10-25 at 16:46 -0700, Alexei Starovoitov wrote:
> On Wed, Oct 26, 2022 at 01:27:49AM +0300, Eduard Zingerman wrote:
> >=20
> > Include the following system header:
> > - /usr/include/sys/socket.h (all via linux/if.h)
> >=20
> > The sys/socket.h conflicts with vmlinux.h in:
> > - types: struct iovec, struct sockaddr, struct msghdr, ...
> > - constants: SOCK_STREAM, SOCK_DGRAM, ...
> >=20
> > However, only two types are actually used:
> > - struct sockaddr
> > - struct sockaddr_storage (used only in linux/mptcp.h)
> >=20
> > In 'vmlinux.h' this type originates from 'kernel/include/socket.h'
> > (non UAPI header), thus does not have a header guard.
> >=20
> > The only workaround that I see is to:
> > - define a stub sys/socket.h as follows:
> >=20
> >     #ifndef __BPF_SOCKADDR__
> >     #define __BPF_SOCKADDR__
> >    =20
> >     /* For __kernel_sa_family_t */
> >     #include <linux/socket.h>
> >    =20
> >     struct sockaddr {
> >         __kernel_sa_family_t sa_family;
> >         char sa_data[14];
> >     };
> >    =20
> >     #endif
> >=20
> > - hardcode generation of __BPF_SOCKADDR__ bracket for
> >   'struct sockaddr' in vmlinux.h.
>=20
> we don't need to hack sys/socket.h and can hardcode
> #ifdef _SYS_SOCKET_H as header guard for sockaddr instead, right?
> bits/socket.h has this:
> #ifndef _SYS_SOCKET_H
> # error "Never include <bits/socket.h> directly; use <sys/socket.h> inste=
ad."
>=20
> So that ifdef is kinda stable.

The `if.h` only uses two types from `sys/socket.h`, namely:
- `struct sockaddr`
- `struct sockaddr_storage`

However `sys/socket.h` itself defines more types, here is a complete
list of types from `sys/socket.h` that conflict with `vmlinux.h`
(generated for my x86_64 laptop):

Type name       System header
iovec           /usr/include/bits/types/struct_iovec.h
loff_t          /usr/include/sys/types.h
dev_t           /usr/include/sys/types.h
nlink_t         /usr/include/sys/types.h
timer_t         /usr/include/bits/types/timer_t.h
int16_t         /usr/include/bits/stdint-intn.h
int32_t         /usr/include/bits/stdint-intn.h
int64_t         /usr/include/bits/stdint-intn.h
u_int64_t       /usr/include/sys/types.h
sigset_t        /usr/include/bits/types/sigset_t.h
fd_set          /usr/include/sys/select.h
blkcnt_t        /usr/include/sys/types.h
SOCK_STREAM     /usr/include/bits/socket_type.h
SOCK_DGRAM      /usr/include/bits/socket_type.h
SOCK_RAW        /usr/include/bits/socket_type.h
SOCK_RDM        /usr/include/bits/socket_type.h
SOCK_SEQPACKET  /usr/include/bits/socket_type.h
SOCK_DCCP       /usr/include/bits/socket_type.h
SOCK_PACKET     /usr/include/bits/socket_type.h
sockaddr        /usr/include/bits/socket.h
msghdr          /usr/include/bits/socket.h
cmsghdr         /usr/include/bits/socket.h
linger          /usr/include/bits/socket.h
SHUT_RD         /usr/include/sys/socket.h
SHUT_WR         /usr/include/sys/socket.h
SHUT_RDWR       /usr/include/sys/socket.h

It would be safe to wrap the corresponding types in the vmlinux.h with
_SYS_SOCKET_H / _SYS_TYPES guards if the definitions above match
between libc and kernel. To my surprise not all of them match. Here is
the list of genuine conflicts (for typedefs I skip the intermediate
definitions and print the last typedef in the chain):

Type: dev_t
typedef unsigned int __u32                                vmlinux.h
typedef unsigned long int __dev_t         /usr/include/bits/types.h

Type: nlink_t
typedef unsigned int __u32                                vmlinux.h
typedef unsigned long int __nlink_t       /usr/include/bits/types.h

Type: timer_t
typedef int __kernel_timer _t                             vmlinux.h
typedef void *__timer_t                   /usr/include/bits/types.h

Type: sigset_t
typedef struct                                            vmlinux.h
{
  long unsigned int sig[1];
} sigset_t

typedef struct                 /usr/include/bits/types/__sigset_t.h
{
  unsigned long int __val[1024 / (8 * (sizeof(unsigned long int)))];
} __sigset_t

Type: fd_set
typedef struct                                            vmlinux.h
{
  long unsigned int fds_bits[16];
} __kernel_fd_set

typedef struct                            /usr/include/sys/select.h
{
  __fd_mask __fds_bits[1024 / (8 * ((int) (sizeof(__fd_mask))))];
} fd_set

Type: sigset_t
typedef struct                                            vmlinux.h=20
{
  long unsigned int sig[1];
} sigset_t

typedef struct                 /usr/include/bits/types/__sigset_t.h
{
  unsigned long int __val[1024 / (8 * (sizeof(unsigned long int)))];
} __sigset_t

Type: msghdr
struct msghdr                                             vmlinux.h
{
  void *msg_name;
  int msg_namelen;
  int msg_inq;
  struct iov_iter msg_iter;
  union=20
  {
    void *msg_control;
    void *msg_control_user;
  };
  bool msg_control_is_user : 1;
  bool msg_get_inq : 1;
  unsigned int msg_flags;
  __kernel_size_t msg_controllen;
  struct kiocb *msg_iocb;
  struct ubuf_info *msg_ubuf;
  struct sock *, struct sk_buff *, struct iov_iter *, size_tint;
}

struct msghdr                            /usr/include/bits/socket.h
{
  void *msg_name;
  socklen_t msg_namelen;
  struct iovec *msg_iov;
  size_t msg_iovlen;
  void *msg_control;
  size_t msg_controllen;
  int msg_flags;
}

>=20
> > Another possibility is to move the definition of 'struct sockaddr'
> > from 'kernel/include/socket.h' to 'kernel/include/uapi/linux/socket.h',
> > but I expect that this won't fly with the mainline as it might break
> > the programs that include both 'linux/socket.h' and 'sys/socket.h'.
> >=20
> > Conflict with vmlinux.h
> > ----
> >=20
> > Uapi header:
> > - linux/signal.h
> >=20
> > Conflict with vmlinux.h in definition of 'struct sigaction'.
> > Defined in:
> > - vmlinux.h: kernel/include/linux/signal_types.h
> > - uapi:      kernel/arch/x86/include/asm/signal.h
> >=20
> > Uapi headers:
> > - linux/tipc_sockets_diag.h
> > - linux/sock_diag.h
> >=20
> > Conflict with vmlinux.h in definition of 'SOCK_DESTROY'.
>=20
> Interesting one!
> I think we can hard code '#undef SOCK_DESTROY' in vmlinux.h
>=20
> The goal is not to be able to mix arbitrary uapi header with
> vmlinux.h, but only those that could be useful out of bpf progs.
> Currently it's tcp.h and few other network related headers
> because they have #define-s in them that are useful inside bpf progs.
> As long as the solution covers this small subset we're fine.

Well, tcp.h works :) It would be great if someone could list the
interesting headers.

Thanks,
Eduard
