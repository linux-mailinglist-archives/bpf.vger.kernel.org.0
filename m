Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D927F5B3
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgI3XJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbgI3XJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 19:09:13 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE4C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:09:13 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id k18so2572861ybh.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mep4spQ9FIkTa10pAtvQf/myeFBKJ+f0HlpL7O14te8=;
        b=CGRVfmT73XupOrbhGbfJQjwVDZgOAxZPGoEsnwXt0LShs/+nZZajJtlRiQTLE4E53B
         hGnAKjrAMyaCUHdK3GVopBCkFLMD/6i7LBS0cstBnpD8JsXoB0NUjsrWDbzXh9IDQirR
         DfONg9Aw/Yfjm4eRQXnOWMgctfnegPHezPQGVWcpm2LPdfmPD4flp6JAwTOmE9Itkcdx
         6NAh/uJ7kthc2KVBEyGuuQ58Ot+LsolhLUMtlCg/O8X4WjkPYfMI0URA8lPh3G/E6sBH
         I21c4IAZlkooFfgpMKp+L6kftGTMca4E1EKR/h5h1wQVMbMYuxGYZQqABbtitfAfHg24
         kCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mep4spQ9FIkTa10pAtvQf/myeFBKJ+f0HlpL7O14te8=;
        b=tjbcBcfIoCjePIRRU1ltmUeMreq9cjytomCHbTzneRTYVDCpUUpjbgzXMg06bJV/FE
         UNdHfSIacH6PAzCrj0sWQtMr8H41opZmUZRl5KS4+QstwP5Fv+19nY83dleRM8rzTtyj
         xR9tGGvoAUp+loCT6KiOWiCqElzW+41OqIAJG0v4WxguOy+cHJFW5Gdn7gRtkhLb5MeL
         2l1l2uQ2AjVRTCK5OfOMKmI2lMDqa2UtIQurPsqV1Qeyh6VfTdSTLPRVN9wV8iBQ6c80
         zjJxX9EQQGUNfzyvnssGL8RfXDT1nudvSco70+HE+oZPS6QDb9ial3FhGWYROhjpK2Et
         hN1A==
X-Gm-Message-State: AOAM530BafeEv7z9Xk7j/pXRiOfAea0qG6RSLxJj9UV1kcjsYOjNUXKG
        w/aQJ18+xpTwjncs9BiL45NH8XEWMajUeb+vjfF119oMM5TzSw==
X-Google-Smtp-Source: ABdhPJz0TcI4NuoU/MoYebgHVVHNZO09TNGSJbw4/JZ+9a9rGsniyM9eShB9nuNzEBdSD0sm0wav3iH2w9ByXqyStxg=
X-Received: by 2002:a25:2596:: with SMTP id l144mr6522642ybl.510.1601507353041;
 Wed, 30 Sep 2020 16:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
 <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
 <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
 <CAEf4Bzb4JrfmENs197d30xU2fnWwu9_1rq-=n9szaWmmxaSckg@mail.gmail.com> <CA+XBgLWa7nWnQNTUdqgBK2E34PH8mUc_wUWR=_iM2Yjr=gxrVw@mail.gmail.com>
In-Reply-To: <CA+XBgLWa7nWnQNTUdqgBK2E34PH8mUc_wUWR=_iM2Yjr=gxrVw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Sep 2020 16:09:02 -0700
Message-ID: <CAEf4BzY1N_yZscKTT81fnexwPgD7XbD0UCyEsa1CUp_giyJwfA@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 12:26 AM Luka Oreskovic
<luka.oreskovic@sartura.hr> wrote:
>
> On Mon, Sep 14, 2020 at 7:49 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 14, 2020 at 12:55 AM Luka Oreskovic
> > <luka.oreskovic@sartura.hr> wrote:
> > >
> > > On Fri, Sep 11, 2020 at 8:14 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
> > > > <luka.oreskovic@sartura.hr> wrote:
> > > > >
> > > > > Greetings everyone,
> > > > >
> > > > > I have been testing various BPF programs on the ARM32 architecture and
> > > > > have encountered a strange error.
> > > > >
> > > > > When trying to run a simple program that prints out the arguments of
> > > > > the open syscall,
> > > > > I found some strange behaviour with the pointer offsets when accessing
> > > > > the arguments:
> > > > > The output of llvm-objdump differed from the verifier error dump log.
> > > > > Notice the differences in lines 0 and 1. Why is the bytecode being
> > > > > altered at runtime?
> > > > >
> > > > > I attached the program, the llvm-objdump result and the verifier dump below.
> > > > >
> > > > > Best wishes,
> > > > > Luka Oreskovic
> > > > >
> > > > > BPF program
> > > > > --------------------------------------------
> > > > > #include "vmlinux.h"
> > > > > #include <bpf/bpf_helpers.h>
> > > > >
> > > > > SEC("tracepoint/syscalls/sys_enter_open")
> > > > > int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> > > > > {
> > > > >         const char *arg1 = (const char *)ctx->args[0];
> > > > >         int arg2 = (int)ctx->args[1];

Luka, can you apply the changes below to bpf_core_read.h header and
read these args using BPF_CORE_READ() macro:

const char *arg1 = (const char *)BPF_CORE_READ(ctx, args[0]);
int arg2 = BPF_CORE_READ(ctx, args[1]);

I'm curious if that will work (unfortunately I don't have a complete
enough setup to test this).

The patch is as follows (with broken tab<->space conversion, so please
make changes by hand):

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index bbcefb3ff5a5..fee6328d36c0 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -261,14 +261,16 @@ enum bpf_enum_value_kind {
 #define ___type(...) typeof(___arrow(__VA_ARGS__))

 #define ___read(read_fn, dst, src_type, src, accessor)                     \
-       read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
+       read_fn((void *)(dst),                                              \
+               bpf_core_field_size(((src_type)(src))->accessor),           \
+               &((src_type)(src))->accessor)

 /* "recursively" read a sequence of inner pointers using local __t var */
 #define ___rd_first(src, a) ___read(bpf_core_read, &__t, ___type(src), src, a);
 #define ___rd_last(...)
             \
        ___read(bpf_core_read, &__t,                                        \
                ___type(___nolast(__VA_ARGS__)), __t, ___last(__VA_ARGS__));
-#define ___rd_p1(...) const void *__t; ___rd_first(__VA_ARGS__)
+#define ___rd_p1(...) const void *__t = (void *)0; ___rd_first(__VA_ARGS__)
 #define ___rd_p2(...) ___rd_p1(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
 #define ___rd_p3(...) ___rd_p2(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
 #define ___rd_p4(...) ___rd_p3(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)



BTW, this approach should work for reading pointers as well, it would
be nice if you can test that as well. E.g., something like the
following:

struct task_struct *t = (void *)bpf_get_current_task();
int ppid = BPF_CORE_READ(t, group_leader, tgid);

If you try it without the patch above, it should either read garbage
or zero, but not a valid parent PID (please verify that as well).

I really appreciate your help with testing, thanks!


> > > > >
> > > > >         bpf_printk("Open arg 1: %s\n", arg1);
> > > > >         bpf_printk("Open arg 2: %d\n", arg2);
> > > > >
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > char LICENSE[] SEC("license") = "GPL";
> > > > >
> > > > >

[...]

>
> Best wishes,
> Luka Oreskovic
