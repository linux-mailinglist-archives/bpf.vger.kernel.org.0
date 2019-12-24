Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCEC129E11
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfLXG2p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 01:28:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36600 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfLXG2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 01:28:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so7174784qvl.3;
        Mon, 23 Dec 2019 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0GuElMuTFkehjy6FB6Db/tI9DDfpT2zdCzSc2Sc8R4=;
        b=sjaOFGapq8vFjrdXnfskp/dnLNdOvtAGNA6pIDirEwqEMl43lnJsw9CMHeOBCA1RfT
         VzsTRasZwhXQpbyy7iqR5sZzKMOMyAysOVcYhnkH1PHsgIPuVbz6vGXx1nNZk89b8WBB
         01vBD2hXTvijsLVVeC0qMVkv2tcdqTmpV5mQ7cFwrNQRdz4FgSqIhgKJ0pUtRjwcbuMY
         AqnCmDw4mQPxPj3ZFM7EJMUcTdfb701uf2uOwscZPW5zBGPQYOfLtXDLUrGVWR3Fpj0d
         k8ZgZEHRcFo5aDWSnA9maQMKcCFGVE9pqNiXOK7TO3XotSuO+e+CYyImJTd8niBF7FPy
         fJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0GuElMuTFkehjy6FB6Db/tI9DDfpT2zdCzSc2Sc8R4=;
        b=A+zbeqgFRZ0cu48Y/UvdfqzKi96b9vR7LCPRoVbwq7coQkNQQNY9COyTEC+wz0KKpb
         aZKn2q9d/iA6GXAL3SfAhC+74RZ+HN7WQk5vcY/vlLM3ke8Yeb1wS+mGR8vZprbRUzZ3
         Vnlkv8B8ZYYFdspUQFgW/u5u+MQURYH1UNGgrIKyeRxeqUsYQo19QRA8Kk8sTgT1YlAC
         foDpj+oXN51CSCrm6xnzLwmEDXUYhGr40UzvQpE20Nd1EigMP5EyTKAO3G8yJJWHbwnu
         waL/hNytKGP/WbrZQYyp7X3blW05tEWQxHxBFWZLzkZUoc7PKDu5mCxUmmlLn/hxg16n
         wQfg==
X-Gm-Message-State: APjAAAXL/yIXjjVHGVMi5rVZsM0QWE3rzcTqI8RgfwmG94NYPGLmvVWN
        I6vcO6BwPknT0n7qkpfe4axQfBq63KK3eTfahz9Q+obC
X-Google-Smtp-Source: APXvYqxj/Kuh5GLp7e+RU0qvFVaVpbxcz/JXdZhPkZRKQALPCmzLefkTf1AgZIxbQiLUUfBtxFwPKub+9mtVy3BOrbw=
X-Received: by 2002:ad4:514e:: with SMTP id g14mr27580830qvq.196.1577168923502;
 Mon, 23 Dec 2019 22:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-7-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:28:32 -0800
Message-ID: <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
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

On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The LSM creates files in securityfs for each hook registered with the
> LSM.
>
>     /sys/kernel/security/bpf/<h_name>
>
> The list of LSM hooks are maintained in an internal header "hooks.h"
> Eventually, this list should either be defined collectively in
> include/linux/lsm_hooks.h or auto-generated from it.
>
> * Creation of a file for the hook in the securityfs.
> * Allocation of a bpf_lsm_hook data structure which stores
>   a pointer to the dentry of the newly created file in securityfs.
> * Creation of a typedef for the hook so that BTF information
>   can be generated for the LSM hooks to:
>
>   - Make them "Compile Once, Run Everywhere".
>   - Pass the right arguments when the attached programs are run.
>   - Verify the accesses made by the program by using the BTF
>     information.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_lsm.h        |   12 +
>  security/bpf/Makefile          |    4 +-
>  security/bpf/include/bpf_lsm.h |   63 ++
>  security/bpf/include/fs.h      |   23 +
>  security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
>  security/bpf/lsm.c             |  138 ++++-
>  security/bpf/lsm_fs.c          |   82 +++
>  7 files changed, 1333 insertions(+), 4 deletions(-)
>  create mode 100644 include/linux/bpf_lsm.h
>  create mode 100644 security/bpf/include/bpf_lsm.h
>  create mode 100644 security/bpf/include/fs.h
>  create mode 100644 security/bpf/include/hooks.h
>  create mode 100644 security/bpf/lsm_fs.c
>

[...]

> +
> +/*
> + * The hooks can have an int or void return type, these macros allow having a
> + * single implementation of DEFINE_LSM_HOOK irrespective of the return type.
> + */
> +#define LSM_HOOK_RET(ret, x) LSM_HOOK_RET_##ret(x)
> +#define LSM_HOOK_RET_int(x) x
> +#define LSM_HOOK_RET_void(x)
> +
> +/*
> + * This macro defines the body of a LSM hook which runs the eBPF programs that
> + * are attached to the hook and returns the error code from the eBPF programs if
> + * the return type of the hook is int.
> + */
> +#define DEFINE_LSM_HOOK(hook, ret, proto, args)                                \
> +typedef ret (*lsm_btf_##hook)(proto);                                  \
> +static ret bpf_lsm_##hook(proto)                                       \
> +{                                                                      \
> +       return LSM_HOOK_RET(ret, LSM_RUN_PROGS(hook##_type, args));     \
>  }

I'm probably missing something, but according to LSM_HOOK_RET
definition for when ret==void, bpf_lsm_##hook will be a noop and won't
call any BPF program. Did I miss some additional macro magic?

>
> +/*
> + * Define the body of each of the LSM hooks defined in hooks.h.
> + */
> +#define BPF_LSM_HOOK(hook, ret, args, proto) \
> +       DEFINE_LSM_HOOK(hook, ret, BPF_LSM_ARGS(args), BPF_LSM_ARGS(proto))
> +#include "hooks.h"
> +#undef BPF_LSM_HOOK
> +#undef DEFINE_LSM_HOOK
> +
> +/*
> + * Initialize the bpf_lsm_hooks_list for each of the hooks defined in hooks.h.
> + * The list contains information for each of the hook and can be indexed by the
> + * its type to initialize security FS, attach, detach and execute eBPF programs
> + * for the hook.
> + */
> +struct bpf_lsm_hook bpf_lsm_hooks_list[] = {
> +       #define BPF_LSM_HOOK(h, ...)                                    \
> +               [h##_type] = {                                          \
> +                       .h_type = h##_type,                             \
> +                       .mutex = __MUTEX_INITIALIZER(                   \
> +                               bpf_lsm_hooks_list[h##_type].mutex),    \
> +                       .name = #h,                                     \
> +                       .btf_hook_func =                                \
> +                               (void *)(lsm_btf_##h)(bpf_lsm_##h),     \

this btf_hook_func, is it assigned just so that type information for
bpf_lsm_xxx typedefs are preserved, is that right? It doesn't seem to
be ever called or read. If I'm not missing anything, check out
Martin's latest STRUCT_OPS patch set. He defines EMIT_TYPE_INFO(type)
macro, which will ensure that BTF for specified type is emitted into
vmlinux BTF, without actually using any extra space, defining extra
fields or static variables, etc. I suggest using the same for the
cleanest result.

One more thing regarding lsm_bpf_ typedefs. Currently you are defining
them as a pointer to func_proto, matching LSM hook. There is an
alternative approach, which has few benefits over using func_proto. If
instead you define a struct, where each argument of func prototype is
represented as 8-byte aligned field, this will contain all the
necessary information for BPF verifier to do its job (just like
func_proto). But in addition to that, when vmlinux.h is generated, it
will contain a nice struct bpf_lsm_<hook_name> with correct structure
to be used **directly** in BPF program, as a single context argument.
So with vmlinux.h, users won't have to re-define all the argument
types and names in their BPF_TRACE_x definition. Let me provide
concrete example from your cover letter. This is what you provide as
an example:

BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
            struct vm_area_struct *, vma,
            unsigned long, reqprot, unsigned long, prot) {...}

on kernel side, you'll have:

typedef int (*bpf_lsm_file_mprotect)(struct vm_area_struct *vma,
                                     unsigned long reqprot,
                                     unsigned long prot);

So you can see that user has to go and copy/paste all the arguments
and their types and paste them in this verbose BPF_TRACE_3 macro to
define correct BPF program.

Now, imagine that instead of typedef above, we define equivalent struct:

struct bpf_lsm_file_mprotect {
    struct vm_area_struct *vma;
    unsigned long reqprot;
    unsigned long prot;
};

This type will get dumped into vmlinux.h, which can be used from BPF
user code as such:

SEC("lsm/file_mprotect")
int mprotect_audito(struct bpf_lsm_file_mprotect *ctx)
{
    ... here you can use ctx->vma, ctx->reqprot, ctx->prot ...
}


Meanwhile, there will be just minimal changes to BPF verifier to use
such struct instead of func_proto for verification of LSM programs.

We currently have similar issue with raw_tp programs and I've been
thinking about switching that to structs instead of func_proto, so we
might as well coordinate that and reuse the same logic in BPF
verifier.

Thoughts?



> +               },
> +       #include "hooks.h"
> +       #undef BPF_LSM_HOOK
> +};
> +

[...]
