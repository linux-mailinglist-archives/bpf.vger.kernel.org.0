Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8070712D3C3
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 20:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfL3TOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 14:14:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33693 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TOm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 14:14:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so30272400qto.0;
        Mon, 30 Dec 2019 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4sEgUtwHkvHXm6kxnCw44xifL2xMp4eJ03f3y2BaIg=;
        b=g88l+/3NdP/VGlOsY1jvntu4la8QfgOPM+FwA7L7GMH4wc3eF0JMiVQChtTfrp4CHv
         jTnAWdQDSKkyXqq6u+0lH7QlROqpLo52+s0hs/4dvPfnlT17rnIduRvutOL+D4kxIW8h
         L/5/5nNv6BYckoyG5Tvp8CrKRFJiYGgtlclvAMJDs2Sai1GdT81QkNtMf1ASnUQSaYEW
         2W+dReJ9sHhwds2Io51DpmQErJXTZZl4bki/KvgWo1PVPFaTVj+1PJkg4LVagexFd32D
         zjJn5JryihQ/cSW1RNatt8W5I5s8+yCL0acyiTgLOwaW0AIFzWrnrWghx1ZYa9JSulrj
         Q9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4sEgUtwHkvHXm6kxnCw44xifL2xMp4eJ03f3y2BaIg=;
        b=bRJ70P4nVCnaymRliQqAfphh4tuBDGtPFBlhzjBauZ82JH0COtTV2a+Mf/bFhoUqzs
         hOlWPRe4yYXCBcH2k+E5Ax8mxAWjdYDl2SaVVgCrnuXg5cc4K6Wyf54kV0r7sCfqm+IR
         XuHoxlnF7ctECnu1JhA7b8r7qW/DwAocuILRmClF7wGQgd51u3HjhgeJ3Is0aZFTpDOo
         eiQiCcDe87qmsx+kQrGU5YjteXuDgmNItzr9M0erPwHkjTJW3T2Rwe1I3dUs7dbbx198
         YYV+mzudPi089FcaBsKtvO5I63ZXCHYEwsTKaGGLjWpwa9fCAxCCdBvMlv+yRBNBsy5y
         cfhA==
X-Gm-Message-State: APjAAAVD3qrXxjx254NWs6kxkbTxXxKFj877NiaG5EfcOJvJUbd6b1qw
        2bZl9Uik7hmzZYUayhk+1tfifNv8CohhftSjZ1Q=
X-Google-Smtp-Source: APXvYqydoHP2aJG4M0oXdv45l/M+b6QHVDvGqX7qqVnyRZJeLc8B9u+losS++IjVOAJgS1Yo7G0qzl5fNVpH+n7j+Fk=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr17405431qtu.141.1577733280923;
 Mon, 30 Dec 2019 11:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191222012722.gdqhppxpfmqfqbld@ast-mbp.dhcp.thefacebook.com>
 <20191230145846.GA70684@google.com>
In-Reply-To: <20191230145846.GA70684@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Dec 2019 11:14:29 -0800
Message-ID: <CAEf4Bzbytf6ZJp_-Y66k5LzB46dBqs=d79VN82mP0UqzBKnDGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 30, 2019 at 6:59 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 21-Dez 17:27, Alexei Starovoitov wrote:
> > On Fri, Dec 20, 2019 at 04:41:55PM +0100, KP Singh wrote:
> > > // Declare the eBPF program mprotect_audit which attaches to
> > > // to the file_mprotect LSM hook and accepts three arguments.
> > > BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> > >         struct vm_area_struct *, vma,
> > >         unsigned long, reqprot, unsigned long, prot
> > > {
> > >     unsigned long vm_start = _(vma->vm_start);
> > >     return 0;
> > > }
> >
>
> Hi Alexei,
>
> Thanks for the feedback. This is really helpful!
>
> > I think the only sore point of the patchset is:
> > security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
> > With bpf trampoline this type of 'kernel types -> bpf types' converters
> > are no longer necessary. Please take a look at tcp-congestion-control patchset:
> > https://patchwork.ozlabs.org/cover/1214417/
> > Instead of doing similar thing (like your patch 1 plus patch 6) it's using
> > trampoline to provide bpf based congestion control callbacks into tcp stack.
> > The same trampoline-based mechanism can be reused by bpf_lsm.
> > Then all manual work of doing BPF_LSM_HOOK(...) for every hook won't be
> > necessary. It will also prove the point that attaching BPF to raw LSM hooks
> > doesn't freeze them into stable abi.
>
> Really cool!
>
> I looked into how BPF trampolines are being used in tracing and the
> new STRUCT_OPS patchset and was able protoype
> (https://github.com/sinkap/linux-krsi/tree/patch/v1/trampoline_prototype,
> not ready for review yet) which:
>
> * Gets rid of security/bpf/include/hooks.h and all of the static
>   macro magic essentially making the LSM ~truly instrumentable~ at
>   runtime.
> * Gets rid of the generation of any new types as we already have
>   all the BTF information in the kernel in the following two types:
>
> struct security_hook_heads {
>         .
>         .
>         struct hlist_head file_mprotect;   <- Append the callback at this offset
>         .
>         .
> };
>
> and
>
> union security_list_options {
>         int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqprot,
>                                 unsigned long prot);
> };
>
> Which is the same type as the typedef that's currently being generated
> , i.e. lsm_btf_file_mprotect
>
> In the current prototype, libbpf converts the name of the hook into an
> offset into the security_hook_heads and the verifier does the
> following when a program is loaded:
>
> * Verifies the offset and the type at the offset (struct hlist_head).
> * Resolves the func_proto (by looking up the type in
>   security_list_options) and updates prog->aux with the name and
>   func_proto which are then verified similar to raw_tp programs with
>   btf_ctx_access.
>
> On attachment:
>
> * A trampoline is created and appended to the security_hook_heads
>   for the BPF LSM.
> * An anonymous FD is returned and the attachment is conditional on the
>   references to FD (as suggested and similar to fentry/fexit tracing
>   programs).
>
> This implies that the BPF programs are "the LSM hook" as opposed to
> being executed inside a statically defined hook body which requires
> mutable LSM hooks for which I was able to re-use some of ideas in
> Sargun's patch:
>
> https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal/
>
> to maintain a separate security_hook_heads struct for dynamically
> added LSM hooks by the BPF LSM which are executed after all the
> statically defined hooks.
>
> > Longer program names are supplied via btf's func_info.
> > It feels that:
> > cat /sys/kernel/security/bpf/process_execution
> > env_dumper__v2
> > is reinventing the wheel. bpftool is the main introspection tool.
> > It can print progs attached to perf, cgroup, networking. I think it's better to
> > stay consistent and do the same with bpf-lsm.
>
> I agree, based on the new feedback, I don't think we need securityFS
> attachment points anymore. I was able to get rid of it completely.
>
> >
> > Another issue is in proposed attaching method:
> > hook_fd = open("/sys/kernel/security/bpf/process_execution");
> > sys_bpf(attach, prog_fd, hook_fd);
> > With bpf tracing we moved to FD-based attaching, because permanent attaching is
> > problematic in production. We're going to provide FD-based api to attach to
> > networking as well, because xdp/tc/cgroup prog attaching suffers from the same
> > production issues. Mainly with permanent attaching there is no ownership of
> > attachment. Everything is global and permanent. It's not clear what
> > process/script suppose to detach/cleanup. I suggest bpf-lsm use FD-based
> > attaching from the beginning. Take a look at raw_tp/tp_btf/fentry/fexit style
> > of attaching. All of them return FD which represents what libbpf calls
> > 'bpf_link' concept. Once refcnt of that FD goes to zero that link (attachment)
> > is destroyed and program is detached _by the kernel_. To make such links
> > permanent the application can pin them in bpffs. The pinning patches haven't
> > landed yet, but the concept of the link is quite powerful and much more
> > production friendly than permanent attaching.
>
> I like this. This also means we don't immediately need the handling of
> duplicate names so I dropped that bit of the patch as well and updated
> the attachment to use this mechanism.
>
> > bpf-lsm will still be able to attach multiple progs to the same hook and
> > see what is attached via bpftool.
> >
> > The rest looks good. Thank you for working on it.
>
> There are some choices we need to make here from an API perspective:
>
> * Should we "repurpose" attr->attach_btf_id and use it as an offset
>   into security_hook_heads or add a new attribute
>   (e.g lsm_hook_offset) for the offset or use name of the LSM hook
>   (e.g. lsm_hook_name).

I think setting this to member index inside union
security_list_options will be better? Or member index inside struct
security_hook_heads. Seems like kernel will have to "join" those two
anyways, right (one for type info, another for trampoline)? Offset is
less convenient either way.

> * Since we don't have the files in securityFS, the attachment does not
>   have a target_fd. Should we add a new type of BPF command?
>   e.g. LSM_HOOK_OPEN?

Semantics of LSM program seems closer to fentry/fexit/raw_tp, so maybe
instead use BPF_RAW_TRACEPOINT_OPEN command? On libbpf side it's all
going to be abstracted behind bpf_program__attach() anyways.

>
> I will clean up the prototype, incorporate some of the other feedback
> received, and send a v2.
>
> Wishing everyone a very Happy New Year!

Thanks, you too!

>
> - KP
>
