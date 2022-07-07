Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1156AD13
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 22:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiGGU70 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiGGU7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 16:59:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED81F612
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 13:59:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o25so34513001ejm.3
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVzOmaPVJNXCijWHbqoZx5/9f4GJ6zAP+fd071U1ouI=;
        b=hkhrepi660L8RFNuRwzWOLftqLYGuFRoBSU9SHDb78S57fRFhf0/ENTeGctClhpinG
         NM5guMou04ft9S+m9aeMO9zec0Ay1O4t4qvDZkWI4h7GFk88ogpSswcHbMRobbjLMhNv
         YpfIyt+z3Sq2uuLzJUMSFvceql37G6tyIgLEjKMqTIhdGXaipF5z3EqYNKpjytQypkkT
         9u4HwdDN6xP8ZleuSIZ9Ew3AYST4X7Q3RslcJDH6ZE7bHVnoafWWN7lt+SFW27XGI07O
         CY7n6U5RwKavNvU4N9z1IM1etS+nDk6Rbbb4z/o2DOusXLWTJyV+n6OxKqKMrNlwa69G
         +Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVzOmaPVJNXCijWHbqoZx5/9f4GJ6zAP+fd071U1ouI=;
        b=WRVvF/jsn7+ryM1kqi8CaPOYphk9xgPD7kk+DhCL0G0PyOt5cxXzHwnX7pukZjukD/
         X5g8S7brXPliskbLECri4ZjwiF7RvstK17Ac7VL9rngYbY9i7uONtf8amfn5JA6Ii/3U
         mWmokjvH/fLwJMcX9XRHUfMzL3MaL34WNQZLKZyGU/J5P3xJ7qzBfPY2mNxx2JpuNWTD
         OWeMtqdTJGwN1pVlAhH4ZgMgHX+/EQZ6+qkeqgjCJqJKBY/PPEktwb5d5i3Ndq4skqNh
         Q+0Q5vJEyV23zfqOLbx55yNVRT+k9Dttg0DPdS6O4mgraYBomiFvq7RDVNBmhXWY91Rr
         288g==
X-Gm-Message-State: AJIora//Jrt26YswhVP52uxptG3fa+L4ij1+ZPSWOKvOpslKpm1Mp6Df
        jrWsbB9CmtlY51seVTMBx8FshwgWQNkrqZm8MIw=
X-Google-Smtp-Source: AGRyM1vQyjCHbL95K88qLk1WaoBh2hbMl0/KeR8qdvBvjRPErSHgRp9VUEXiaUfHK4wurV24NAIQlUhgUvlmrTGt5AY=
X-Received: by 2002:a17:906:8447:b0:72a:f120:50cd with SMTP id
 e7-20020a170906844700b0072af12050cdmr38963ejy.114.1657227562638; Thu, 07 Jul
 2022 13:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
In-Reply-To: <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jul 2022 13:59:11 -0700
Message-ID: <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 8:51 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2022-07-06 at 17:41 -0700, Andrii Nakryiko wrote:
> > This RFC patch set is to gather feedback about new
> > SEC("ksyscall") and SEC("kretsyscall") section definitions meant to
> > simplify
> > life of BPF users that want to trace Linux syscalls without having to
> > know or
> > care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related
> > arch-specific
> > vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names,
> > calling
> > convention woes ("nested" pt_regs), etc. All this is quite annoying
> > to
> > remember and care about as BPF user, especially if the goal is to
> > write
> > achitecture- and kernel version-agnostic BPF code (e.g., things like
> > libbpf-tools, etc).
> >
> > By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly
> > communicates
> > the desire to kprobe/kretprobe kernel function that corresponds to
> > the
> > specified syscall. Libbpf will take care of all the details of
> > determining
> > correct function name and calling conventions.
> >
> > This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
> > BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
> > architecture is expected to use syscall wrapper or not (which is less
> > reliable
> > and can change over time).
> >
> > It would be great to get feedback about the overall feature, but also
> > I'd
> > appreciate help with testing this, especially for non-x86_64
> > architectures.
> >
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Kenta Tada <kenta.tada@sony.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> >
> > Andrii Nakryiko (3):
> >   libbpf: improve and rename BPF_KPROBE_SYSCALL
> >   libbpf: add ksyscall/kretsyscall sections support for syscall
> > kprobes
> >   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
> >
> >  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
> >  tools/lib/bpf/libbpf.c                        | 109
> > ++++++++++++++++++
> >  tools/lib/bpf/libbpf.h                        |  16 +++
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  tools/lib/bpf/libbpf_internal.h               |   2 +
> >  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
> >  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
> >  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
> >  8 files changed, 172 insertions(+), 39 deletions(-)
>
> Hi Andrii,
>
> Looks interesting, I will give it a try on s390x a bit later.
>
> In the meantime just one remark: if we want to create a truly seamless
> solution, we might need to take care of quirks associated with the
> following kernel #defines:
>
> * __ARCH_WANT_SYS_OLD_MMAP (real arguments are in memory)
> * CONFIG_CLONE_BACKWARDS (child_tidptr/tls swapped)
> * CONFIG_CLONE_BACKWARDS2 (newsp/clone_flags swapped)
> * CONFIG_CLONE_BACKWARDS3 (extra arg: stack_size)
>
> or at least document that users need to be careful with mmap() and
> clone() probes. Also, there might be more of that out there, but that's
> what I'm constantly running into on s390x.
>

Tbh, this space seems so messy, that I don't think it's realistic to
try to have a completely seamless solution. As I replied to Alexei, I
didn't have an intention to support compat and 32-bit syscalls, for
example. This seems to be also a quirk that users will have to
discover and handle on their own. In my mind there is always plain
SEC("kprobe") if SEC("ksyscall") gets in a way to handle
compat/32-bit/quirks like the ones you mentioned.

But maybe the right answer is just to not add SEC("ksyscall") at all?


> Best regards,
> Ilya
