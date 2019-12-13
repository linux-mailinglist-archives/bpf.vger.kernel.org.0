Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46811DE5C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfLMHB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 02:01:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41707 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfLMHB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 02:01:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so1463551qtk.8
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtsAa0hfplae23hA/jTNYgr7SVgcp09aRVARDJDWBYI=;
        b=vJTiGUaPhVqw7KXe6Vm6G5j3m7/yJira7BWznoY9gs9mX1+V6Pjoyibr8dWkwqQu6C
         WMmc5KDiVRbX3N4daUBanabuLy8u7f3vL7gIHujhonCoAgMNE4UFSgYAiUcCwYB+HIG5
         aX/mP52EqUp65jDS+jrG84QpdQsgyky3rzGybJf/gx6TtFndnAHDlz9vg1Odd8ucLtJ3
         0edGnOki65xx3Q5cdYp1zx3bT7G+V0PGWkB+2hL+XbX0g2f6mMvxfyi2PCtu5e7h+v1i
         E4jhKzK36Ufkn+K6jemH0ZZrxtQmQB0RWU5rIepmbqxX//ltZ4gTGUdnHC/UuS0fjARA
         +juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtsAa0hfplae23hA/jTNYgr7SVgcp09aRVARDJDWBYI=;
        b=cVjuTLEJtAUDKIickJOP/j/QMa7DGBWDjXE2Wos3M1QXBa+SIEorDq0xagyeZtysSa
         r9OVxzUKM2K24LOcMfsAc/OXIb1ld40He0unZi2IRUmkQP1daFX3MFZkyiRhJCNYNLt/
         Z0n54k+suezNwQD2wK/ri3BWNGbFKnJrKOlUxHlXWtBhD7uy9r/8CoDHW4lGDVNuhrp3
         ISHoc5YykJFzBqYBsbPXVZH3NDYdOu1n0ZqLY+L+eWgG99SaLsv96e23INlw6VFrqpuc
         rARTZ7bhfBmug8dA89KOp6enQZkwl5tNMFWdadVDy2K31iDfqD3o4rdaJ2HQP2xYcsN5
         wDCg==
X-Gm-Message-State: APjAAAXc1iX+4ZM6TpHtUyCaZeo7F2wWEIIlUkFtn1l2wQjVtyfv2bqh
        A2prCyiMqK7wUXYzS8WGKX9zWrFvT3IMqBYJq9xSjQ==
X-Google-Smtp-Source: APXvYqzMkEKkCvA5Gd1UPPXAIgVeqU2/st0FEMgv1KGpJbI6VM2Nqvw9JTzGeXPjaUQyyPGjbwa+pOi8FbcNpqAAZME=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr10573783qtq.93.1576220485630;
 Thu, 12 Dec 2019 23:01:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576193131.git.rdna@fb.com> <bc55a274ea572d237bd091819f38502fa837abb5.1576193131.git.rdna@fb.com>
In-Reply-To: <bc55a274ea572d237bd091819f38502fa837abb5.1576193131.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Dec 2019 23:01:14 -0800
Message-ID: <CAEf4Bza7KU1r3iRuXiwL7AiOnEbNmxx_hsEUZL8up2OVtJX3XA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in test_cgroup_attach
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 3:34 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Test replacement of a cgroup-bpf program attached with BPF_F_ALLOW_MULTI
> and possible failure modes: invalid combination of flags, invalid
> replace_bpf_fd, replacing a non-attachd to specified cgroup program.
>
> Example of program replacing:
>
>   # gdb -q ./test_cgroup_attach
>   Reading symbols from /data/users/rdna/bin/test_cgroup_attach...done.
>   ...
>   Breakpoint 1, test_multiprog () at test_cgroup_attach.c:443
>   443     test_cgroup_attach.c: No such file or directory.
>   (gdb)
>   [2]+  Stopped                 gdb -q ./test_cgroup_attach
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   35       egress          multi
>   36       egress          multi
>   # fg gdb -q ./test_cgroup_attach
>   c
>   Continuing.
>   Detaching after fork from child process 361.
>
>   Breakpoint 2, test_multiprog () at test_cgroup_attach.c:454
>   454     in test_cgroup_attach.c
>   (gdb)
>   [2]+  Stopped                 gdb -q ./test_cgroup_attach
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   41       egress          multi
>   36       egress          multi
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  .../selftests/bpf/test_cgroup_attach.c        | 62 +++++++++++++++++--
>  1 file changed, 57 insertions(+), 5 deletions(-)
>

I second Alexei's sentiment. Having this as part of test_progs would
certainly be better in terms of ensuring this doesn't accidentally
breaks.

[...]

>
> +       /* invalid input */
> +
> +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts,
> +               .target_fd              = cg1,
> +               .prog_fd                = allow_prog[6],
> +               .replace_prog_fd        = allow_prog[0],
> +               .type                   = BPF_CGROUP_INET_EGRESS,
> +               .flags                  = BPF_F_ALLOW_MULTI | BPF_F_REPLACE,
> +       );

This might cause compiler warnings (depending on compiler settings, of
course). DECLARE_LIBBPF_OPTS does declare variable, so this is a
situation of mixing code and variable declarations, which under C89
(or whatever it's named, the older standard that kernel is trying to
stick to for the most part) is not allowed.

> +
> +       attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> +       if (!bpf_prog_attach_xattr(&attach_opts)) {
> +               log_err("Unexpected success with OVERRIDE | REPLACE");
> +               goto err;
> +       }
> +       assert(errno == EINVAL);
> +
