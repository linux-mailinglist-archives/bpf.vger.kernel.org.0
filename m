Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC48A3048E1
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 20:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbhAZFip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbhAZCKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 21:10:41 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D8C061574
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:10:00 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id r32so15317837ybd.5
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gzTH46StfxgzTobR6yoYZoV6c5J1I7aOAZjzCN9JA4=;
        b=gLN/hWRNS7mzauj4iBEr0QWSkcnHUgTi4UtMzmQR8verpZXdkkK2XbJBOqyNzOtne/
         3P+yy1r723r/zitHykcrQAtYwiD1OG/Jjpj26J6AC335pb6oce/Xjq7psBL0IzHfeBYP
         nBY9FnFNXLGx6MJGr+JfWvvBlaDm5zzZD4Z3RuVUBCVnLuWmiaYfgJXNeR7Pw8KxcSyu
         fb3ltARN8RUukpGQ7bLzvBbH2kK83RHpcSgcIJBx3kvyQihPa/HEfDEjThGjgDPySa0N
         tPvQIm0daMw34dmsDbgyysNeVBUW6RxLB4gjTfOyf6nU3Oo3PO+ublwL3a85cSIZjSsa
         1JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gzTH46StfxgzTobR6yoYZoV6c5J1I7aOAZjzCN9JA4=;
        b=C6lTehg2DpYhQOKEN4M7x9w0OqoTAMtSi0boHm/KnnIRUHStfowkF06PEQeUKT1pGx
         5ZgTCOonWiIH5kG/D1WPl9j0JcPlGoQAEsoqa9faGrWe0jTg9Eiu0Y0/65YK8xk8b+Az
         vwaD6o9nvghmCdn1v37m448670P/OfCxzFuwztmHSZL2es43gj21sCsinAxIfBX59KGI
         Jb5Jox+R2qIK/Crkr4eJUJoTnOKv2R2kVVg804i3b/5B5BSTNRBYUHpZS1ikprYhjwph
         mdJoODvWa5fzSCyOHIr6aLupUAw9PdPTBmtlGWANs3fCiNysMYN/fBHRgWOqhu0Vlc47
         iyfA==
X-Gm-Message-State: AOAM532g7mmiD/xmat3ukxOY7hevd2TGXPCkCjRbMmcHCRv/vhFwLmXV
        Asun1lZIMkfoNOkFWdYi6YDu2b7A5EqUEttWg7xp5FHSIA0VtA==
X-Google-Smtp-Source: ABdhPJytM1JfDy/sWyKXT+WPItC/vOpILS0BEk15n/s+Uu5csq6tdsDG+JD78xEr9tDc/zcO/aROYfVYsBChC7pvN4A=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr4980865yba.403.1611626999264;
 Mon, 25 Jan 2021 18:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20210123004445.299149-1-kpsingh@kernel.org> <20210123004445.299149-2-kpsingh@kernel.org>
In-Reply-To: <20210123004445.299149-2-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Jan 2021 18:09:48 -0800
Message-ID: <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 4:44 PM KP Singh <kpsingh@kernel.org> wrote:
>
> The script runs the BPF selftests locally on the same kernel image
> as they would run post submit in the BPF continuous integration
> framework.
>
> The goal of the script is to allow contributors to run selftests locally
> in the same environment to check if their changes would end up breaking
> the BPF CI and reduce the back-and-forth between the maintainers and the
> developers.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

This is great, thanks a lot for working on this! This is great
especially for ad-hoc contributors who don't have qemu workflow setup.
Below are some comments for the extra polish :)

1. There is this long list output at the beginning:

https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/vmlinux-5.5.0.zst
https://libbpf-vmtest....

Can we omit that?

2. Then something is re-downloaded every single time:

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 77713  100 77713    0     0   509k      0 --:--:-- --:--:-- --:--:--  512k

Unless it's to check if something newer appeared in S3, would be nice
to skip that step.

3. Every single time I run the script it actually rebuilds kernel.
Somehow Linux Makefile's logic to do nothing if nothing changed in
Linux source code doesn't kick in, I wonder why? It's quite annoying
and time-consuming for frequent selftest reruns. What's weird is that
individual .o's are not re-built, but kernel is still re-linked and
BTF is re-generated, which is the slow part :(

4. Selftests are re-built from scratch every single time, even if
nothing changed. Again, strange because they won't do it normally. And
given there is a fixed re-usable .bpf_selftests "cache directory", we
should be able to set everything up so that no extra compilation is
performed, no?

5. Before VM is started there is:


#!/bin/bash

{

        cd /root/bpf
        echo ./test_progs
        ./test_progs
} 2>&1 | tee /root/bpf_selftests.2021-01-25_17-56-11.log
poweroff -f


Which is probably useful in rare cases for debugging purposes, but is
just distracting in common case. Would it be able to have verbose flag
for your script that would omit output like this by default?

6. Was too lazy to check, but once VM boots and before specified
command is run, there is a bunch of verbose script echoing:

+ for path in /etc/rcS.d/S*

If that's part of libbpf CI's image, let's fix it there. If not, let's
fix it in your script?

7. Is it just me, or when ./test_progs is run inside VM, it's output
is somehow heavily buffered and delayed? I get no output for a while,
and then a whole bunch of lines with already passed tests.  Curious if
anyone else noticed that as well. When I run the same image locally
and manually (not through your script), I don't have this issue.

8. I noticed that even if the command succeeds (e.g., ./test_progs in
my case), the script exits with non-zero error code (32 in my case).
That's suboptimal, because you can't use that script to detect test
failures.

But again, it's the polish feedback, great work!

>  tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
>  1 file changed, 353 insertions(+)
>  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
>
> diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> new file mode 100755
> index 000000000000..09bb9705acb3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> @@ -0,0 +1,353 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -u
> +set -e
> +
> +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
> +X86_BZIMAGE="arch/x86/boot/bzImage"

Might be worth it to mention that this only works with x86_64 (due to
image restrictions at least, right?).

> +DEFAULT_COMMAND="./test_progs"
> +MOUNT_DIR="mnt"
> +ROOTFS_IMAGE="root.img"
> +OUTPUT_DIR="$HOME/.bpf_selftests"
> +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config"
> +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> +NUM_COMPILE_JOBS="$(nproc)"
> +
> +usage()
> +{
> +       cat <<EOF
> +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
> +
> +<command> is the command you would normally run when you are in
> +tools/testing/selftests/bpf. e.g:
> +
> +       $0 -- ./test_progs -t test_lsm
> +
> +If no command is specified, "${DEFAULT_COMMAND}" will be run by
> +default.
> +
> +If you build your kernel using KBUILD_OUTPUT= or O= options, these
> +can be passed as environment variables to the script:
> +
> +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm

"relative_to_cwd" is a bit misleading, it could be an absolute path as
well, I presume. So I'd just say "O=<kernel_build_path>" or something
along those lines.

> +
> +or
> +
> +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> +

[...]
