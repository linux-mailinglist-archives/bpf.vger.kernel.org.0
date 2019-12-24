Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A0129E36
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLXGtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 01:49:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40976 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXGtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 01:49:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so15386272qke.8;
        Mon, 23 Dec 2019 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0iWCxYNiohR6WwhEbZybBC5LDbEHyzHqqdr/s35y2A=;
        b=ocHLjwlgwQvTgt5s8m6AoIqr3nSoecTTinGqUMnsnTJU2Fn9HkhAf21+Vl424/hcA6
         W/bkkobX2Kacb5uyVmV8mvqUfugHcNZ5sbSGIch8ZTcq51gtHjN2Q99AybvXvNbJ/GAE
         yP5+Qt/nVewgtXKiG2Zf97x+rl0eEm1PztpnfpFH6xfTSUEN2FeDuQWnfP8/hvZbMrqN
         fYQhaG3lsSlN6V1eyz7n818WJSSGNMH2sBTYwZmzc3f9HbDZ7odmBEevFRNyeOKyj/cC
         G83fq6RoabavJ91XfaFBxBuPeuaxXnVbkvcfRvBZ9O/96HU7NpOy8K/WGiLbqDUc69qS
         LtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0iWCxYNiohR6WwhEbZybBC5LDbEHyzHqqdr/s35y2A=;
        b=IxGZbMin4Vi4fovcriz3Z+G18Cds1BhXDBRRVlCvbC07QPdKddwuJ5JeSszglJnv+d
         q0jjIe1BFb1T521erHgeFceikqdTxjlMukKl3pq4QB3qzZU2w4kygqgEqzJ8qPLiXbbY
         iCVrZYvwuo3yVGqptAXUUnIrVughDR7s1Y+weHBxHo5ePV/ATIsxb+eZJm43QpnD1Qi5
         HtmEI5ub+3VtClzZZcg51B8CkHTLavwDzozM51tG7/24caX8cbfm3na3nyz73PYm1jfw
         T0CYyW4k3CwGgjTEH7FBpyixfswOf8LUQ0L3NMiqJbxJZcm1K3GKBBCq8QDp2+DdpgMG
         GI8A==
X-Gm-Message-State: APjAAAVXMHLXQR1y0/cjfYinLRAi6THq4nHcz0zbGzqFXLrQxGtFUF48
        LUd8eigo3FWSG3ShW8O+KV7Df/TdNYvuHLvh5NA=
X-Google-Smtp-Source: APXvYqx063YpqLWsE5eZLPp9MLPEcL75/CYO1EL5WVhFsRLVGm0/BcTK4xHhjYVcgT/wmpWMMkiGzVWihz8aUBSWOO8=
X-Received: by 2002:ae9:e809:: with SMTP id a9mr29498123qkg.92.1577170153656;
 Mon, 23 Dec 2019 22:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-13-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-13-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:49:02 -0800
Message-ID: <CAEf4BzY4K-vgSFPjV=pn3quc5DT1+eGkJnZfSw4+b0fERzPVfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/13] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
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

On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Load a BPF program that audits mprotect calls
> * Attach the program to the "file_mprotect" LSM hook
> * Verify if the program is actually loading by reading
>   securityfs
> * Initialize the perf events buffer and poll for audit events
> * Do an mprotect on some memory allocated on the heap
> * Verify if the audit event was received
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  MAINTAINERS                                   |   2 +
>  .../bpf/prog_tests/lsm_mprotect_audit.c       | 129 ++++++++++++++++++
>  .../selftests/bpf/progs/lsm_mprotect_audit.c  |  58 ++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
>

[...]

> +/*
> + * Define some of the structs used in the BPF program.
> + * Only the field names and their sizes need to be the
> + * same as the kernel type, the order is irrelevant.
> + */
> +struct mm_struct {
> +       unsigned long start_brk, brk, start_stack;
> +};
> +
> +struct vm_area_struct {
> +       unsigned long start_brk, brk, start_stack;
> +       unsigned long vm_start, vm_end;
> +       struct mm_struct *vm_mm;
> +       unsigned long vm_flags;
> +};
> +
> +BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> +           struct vm_area_struct *, vma,
> +           unsigned long, reqprot, unsigned long, prot)
> +{
> +       struct mprotect_audit_log audit_log = {};
> +       int is_heap = 0;
> +
> +       __builtin_preserve_access_index(({

you don't need __builtin_preserve_access_index, if you mark
vm_area_struct and mm_struct with
__attribute__((preserve_access_index)

> +               is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> +                                    vma->vm_end <= vma->vm_mm->brk);
> +       }));
> +
> +       audit_log.magic = MPROTECT_AUDIT_MAGIC;
> +       audit_log.is_heap = is_heap;
> +       bpf_lsm_event_output(&perf_buf_map, BPF_F_CURRENT_CPU, &audit_log,
> +                            sizeof(audit_log));

You test would be much simpler if you use global variables to pass
data back to userspace, instead of using perf buffer.

Also please see fentry_fexit.c test for example of using BPF skeleton
to shorten and simpify userspace part of test.

> +       return 0;
> +}
> --
> 2.20.1
>
