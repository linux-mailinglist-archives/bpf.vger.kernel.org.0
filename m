Return-Path: <bpf+bounces-12970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8D7D2945
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5636B281434
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F71FB5;
	Mon, 23 Oct 2023 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z83bdHwF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AC1848
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 04:17:48 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C01A4;
	Sun, 22 Oct 2023 21:17:47 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso2393335fac.2;
        Sun, 22 Oct 2023 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698034667; x=1698639467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdVnM7GBjen/7bYV9j3b3MHhI6ezvP35wTCLXueTt5c=;
        b=Z83bdHwF9D79MFRv70eULZkl4EYdbSpDzgraFjm6rERBltuYIsfjrkbCMlNW0GeUZO
         MiqRObNWkP/06UBndeEvWqzP+ZuzXQFq1fQvG+slx9CgNyCozhkDvxfjT5P+a/PvDuTP
         8uOob5Zf9EBvPxeImL5GGAnd7nacqheciPM1AqOwSp5t7n3CTKC+V8ey4lobLp+0n1oP
         xQ7V52ybZxcdJ4FC8yj1VsqYLJQMOqF4dc5n2C5XOL5MCydTLTbi2p518UMWkK7q6Pvt
         t3LNDFhJ9BzcWI0uPJ7a/WuViPOM9cqxWOFh1RvO5FcwnD/BNM0xjIgXoddn26FRdaVY
         NGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698034667; x=1698639467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdVnM7GBjen/7bYV9j3b3MHhI6ezvP35wTCLXueTt5c=;
        b=Aqgr+etNHyMd63zCq2JIXXfdkKmyn/xxB1Ckd7+5miV8kdikChc1eAItJQLDaXZKCG
         G1dBHY6mGMYPHN8KYcUa7h9K5aXzfIXiqgNyoqfVRvcshosKdqxkBYnGtRaqOpokbRDk
         Usv9CKfgUons2XDI3o7JjUq3Z5aVPBV1T9ls8RzjJmeg2j/CGjnAjDY7Fj1xS8cad+D7
         azKj/rdx6h8vnuGrssVgZ6ESyG/ia8MeJEQbZGtVC7U6g6bL1JLxDLymZctE0iwP+CNb
         fFefinMXo8xhjL4EwiiHsPODdcXh0FVMVQwm7WAIAIFONzu/H76SkVjm1Mski+V34qJf
         G01A==
X-Gm-Message-State: AOJu0YxQrIxsLUDaoExjSjE3+vlB2Wzj9S/Txg47MSIOOme+cD0wVXdO
	LkJRwhgHg+yMA6BhqxC4I03B3yDHaHOUG7WYNQPxt8yoHvk=
X-Google-Smtp-Source: AGHT+IGFSvDDZ+OgOjxEJTlGedVsKn4iNFAqfdD1BZ6LLBw59GOfBTdz5hPIf34WT3/ILI/KGcrPywqPd4YRixEjUSo=
X-Received: by 2002:a05:6871:6b16:b0:1d5:b2ba:bc93 with SMTP id
 zg22-20020a0568716b1600b001d5b2babc93mr7251895oab.13.1698034666686; Sun, 22
 Oct 2023 21:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231015232953.84836-1-hengqi.chen@gmail.com> <20231015232953.84836-3-hengqi.chen@gmail.com>
 <0df30939-1ba1-5703-58cc-54058fbb1df5@iogearbox.net>
In-Reply-To: <0df30939-1ba1-5703-58cc-54058fbb1df5@iogearbox.net>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 23 Oct 2023 12:17:35 +0800
Message-ID: <CAEyhmHSoGFRjpkoRQxRSaqe9U0ttbf51uKNbE6YkcaiGQc_2FA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
To: Daniel Borkmann <daniel@iogearbox.net>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, luto@amacapital.net, wad@chromium.org, 
	alexyonghe@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:44=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/16/23 1:29 AM, Hengqi Chen wrote:
> > This patch adds a new operation named SECCOMP_LOAD_FILTER.
> > It accepts a sock_fprog the same as SECCOMP_SET_MODE_FILTER
> > but only performs the loading process. If succeed, return a
> > new fd associated with the JITed BPF program (the filter).
> > The filter can then be pinned to bpffs using the returned
> > fd and reused for different processes. To distinguish the
> > filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >   include/uapi/linux/bpf.h       |  1 +
> >   include/uapi/linux/seccomp.h   |  1 +
> >   kernel/seccomp.c               | 43 +++++++++++++++++++++++++++++++++=
+
> >   tools/include/uapi/linux/bpf.h |  1 +
> >   4 files changed, 46 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 7ba61b75bc0e..61c80ffb1724 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -995,6 +995,7 @@ enum bpf_prog_type {
> >       BPF_PROG_TYPE_SK_LOOKUP,
> >       BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
> >       BPF_PROG_TYPE_NETFILTER,
> > +     BPF_PROG_TYPE_SECCOMP,
>
> Please don't extend UAPI surface if this is not reachable/usable from use=
r
> space anyway.
>
> >   enum bpf_attach_type {
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.=
h
> > index dbfc9b37fcae..ee2c83697810 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -16,6 +16,7 @@
> >   #define SECCOMP_SET_MODE_FILTER             1
> >   #define SECCOMP_GET_ACTION_AVAIL    2
> >   #define SECCOMP_GET_NOTIF_SIZES             3
> > +#define SECCOMP_LOAD_FILTER          4
> >
> >   /* Valid flags for SECCOMP_SET_MODE_FILTER */
> >   #define SECCOMP_FILTER_FLAG_TSYNC           (1UL << 0)
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index faf84fc892eb..c9f6a19f7a4e 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -17,6 +17,7 @@
> >
> >   #include <linux/refcount.h>
> >   #include <linux/audit.h>
> > +#include <linux/bpf.h>
> >   #include <linux/compat.h>
> >   #include <linux/coredump.h>
> >   #include <linux/kmemleak.h>
> > @@ -25,6 +26,7 @@
> >   #include <linux/sched.h>
> >   #include <linux/sched/task_stack.h>
> >   #include <linux/seccomp.h>
> > +#include <linux/security.h>
> >   #include <linux/slab.h>
> >   #include <linux/syscalls.h>
> >   #include <linux/sysctl.h>
> > @@ -2032,12 +2034,48 @@ static long seccomp_set_mode_filter(unsigned in=
t flags,
> >       seccomp_filter_free(prepared);
> >       return ret;
> >   }
> > +
> > +static long seccomp_load_filter(const char __user *filter)
> > +{
> > +     struct sock_fprog fprog;
> > +     struct bpf_prog *prog;
> > +     int ret;
> > +
> > +     ret =3D seccomp_copy_user_filter(filter, &fprog);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D seccomp_prepare_prog(&prog, &fprog);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D security_bpf_prog_alloc(prog->aux);
> > +     if (ret) {
> > +             bpf_prog_free(prog);
> > +             return ret;
> > +     }
> > +
> > +     prog->aux->user =3D get_current_user();
> > +     atomic64_set(&prog->aux->refcnt, 1);
> > +     prog->type =3D BPF_PROG_TYPE_SECCOMP;
> > +
> > +     ret =3D bpf_prog_new_fd(prog);
> > +     if (ret < 0)
> > +             bpf_prog_put(prog);
>
> My bigger concern here is that bpf_prog_new_fd() is only used by eBPF (no=
t cBPF).
>
> Then you get an 'eBPF'-like fd back to user space which you can pass to v=
arious
> other bpf(2) commands like BPF_OBJ_GET_INFO_BY_FD etc which all have the =
assumption
> that this is a proper looking eBPF prog fd.
>
> There may be breakage/undefined behavior in subtle ways.
>
> I would suggest two potential alternatives :
>
> 1) Build a seccomp-specific fd via anon_inode_getfd() so that BPF side do=
es not
>     confuse it with bpf_prog_fops and therefore does not recognize it in =
bpf(2)
>     as a prog fd.
>
> 2) Extend seccomp where proper eBPF could be supported.
>
> If option 2) is not realistic (where you would get this out of the box), =
then I
> think 1) could be however.
>

The intention is to use bpffs, so we need a bpf prog fd.
I prefer option 2, though it requires a bit of work.
That way, we could also write seccomp filter in eBPF language.

Kees, could you share your opinions ? If you have no objection,
I will continue this work.

> > +     return ret;
> > +}
> >   #else
> >   static inline long seccomp_set_mode_filter(unsigned int flags,
> >                                          const char __user *filter)
> >   {
> >       return -EINVAL;
> >   }
> > +
> > +static inline long seccomp_load_filter(const char __user *filter)
> > +{
> > +     return -EINVAL;
> > +}
> >   #endif
> >
> >   static long seccomp_get_action_avail(const char __user *uaction)
> > @@ -2099,6 +2137,11 @@ static long do_seccomp(unsigned int op, unsigned=
 int flags,
> >                       return -EINVAL;
> >
> >               return seccomp_get_notif_sizes(uargs);
> > +     case SECCOMP_LOAD_FILTER:
> > +             if (flags !=3D 0)
> > +                     return -EINVAL;
> > +
> > +             return seccomp_load_filter(uargs);
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 7ba61b75bc0e..61c80ffb1724 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -995,6 +995,7 @@ enum bpf_prog_type {
> >       BPF_PROG_TYPE_SK_LOOKUP,
> >       BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
> >       BPF_PROG_TYPE_NETFILTER,
> > +     BPF_PROG_TYPE_SECCOMP,
> >   };
> >
> >   enum bpf_attach_type {
> >
>

