Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88D309FAE
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 01:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBAAXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 19:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhBAAXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 19:23:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9C0164E2A
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612138950;
        bh=vHfMs31w3AI1A2Qi/m7NUJaM6ZQp/QvFVNE7T1arg4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CbNXM2VOb52C/fiTT9YSllsuLi/I0gBCBcMHNQ9Ss32Ovk7AbYDNYxj6xtDQ40fu8
         fZagwkAePi5fobiehbf0U8Enx3Vm9hmCVso3LpB1dTcOT+IG9IOKLIocB6a5HWHvXw
         HZUQ+QvXnxoIqnPQEpHXOlLNz58ACLe55g8NdXYpuqIt32/R2QtP46Rl8SJr28olo+
         RK35Po+RTj5Z/i69ihOlsDVWI40oXhMs1Q8PPjl+o8HfLWpfbE3QmRVhJ4JkGbj7k5
         1PuFCVBJu+HJu2tE1r1rXxv2pr9LX6KgGhn6E2CSQlKcZb+wMTYCPNhgKfCwCaVQjN
         d0rP+E4/AK5OQ==
Received: by mail-lf1-f47.google.com with SMTP id q12so20382530lfo.12
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 16:22:29 -0800 (PST)
X-Gm-Message-State: AOAM5307RPALsIrnI9DNd35P6LnjxMd2u3a/Ai4FT46dz8PsqSzcSbiH
        z0BUdV2IARwQs3mcGCqZ8RdZ0MiMngTH7qZcNt1PfA==
X-Google-Smtp-Source: ABdhPJwL+8x3n0gVnZPSrjntdYWtMkYbYym8PiamRcOHzsfhrv23vreyO4hSlJ29SMKI8SzwCdTSqiqaf8bhZsXa3pU=
X-Received: by 2002:ac2:5f5b:: with SMTP id 27mr7172274lfz.375.1612138947926;
 Sun, 31 Jan 2021 16:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20210123004445.299149-1-kpsingh@kernel.org> <20210123004445.299149-2-kpsingh@kernel.org>
 <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
In-Reply-To: <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 1 Feb 2021 01:22:17 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7nqXyqBv9px1e4pANyNyYmqt18Dx=cL90otKK1oPYU-g@mail.gmail.com>
Message-ID: <CACYkzJ7nqXyqBv9px1e4pANyNyYmqt18Dx=cL90otKK1oPYU-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 3:10 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 4:44 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The script runs the BPF selftests locally on the same kernel image
> > as they would run post submit in the BPF continuous integration
> > framework.
> >
> > The goal of the script is to allow contributors to run selftests locally
> > in the same environment to check if their changes would end up breaking
> > the BPF CI and reduce the back-and-forth between the maintainers and the
> > developers.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
>
> This is great, thanks a lot for working on this! This is great
> especially for ad-hoc contributors who don't have qemu workflow setup.
> Below are some comments for the extra polish :)
>
> 1. There is this long list output at the beginning:
>
> https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/vmlinux-5.5.0.zst
> https://libbpf-vmtest....
>
> Can we omit that?

Sure.

>
> 2. Then something is re-downloaded every single time:
>
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
> 100 77713  100 77713    0     0   509k      0 --:--:-- --:--:-- --:--:--  512k
>
> Unless it's to check if something newer appeared in S3, would be nice
> to skip that step.

This is the kernel config. I wonder how we could check if there is something
new without downloading it, the file is called "latest.config".

Maybe this is something we can add to the URL index as well in format similar
 to the image. But since it's just a config file I am not sure
it's worth the extra effort.

>
> 3. Every single time I run the script it actually rebuilds kernel.
> Somehow Linux Makefile's logic to do nothing if nothing changed in
> Linux source code doesn't kick in, I wonder why? It's quite annoying
> and time-consuming for frequent selftest reruns. What's weird is that
> individual .o's are not re-built, but kernel is still re-linked and
> BTF is re-generated, which is the slow part :(

I changed this from not compiling the kernel by default, to compiling it and you
can "keep your old kernel" with -k. This is because users may run the script,
not compile the kernel and run into issues with the image not being able to
mount as the kernel does not have the right config.

The -k is for people who know what they are doing :)

so you can always run

 ./bpf_presubmit.sh -k

after you have the kernel built once.

>
> 4. Selftests are re-built from scratch every single time, even if
> nothing changed. Again, strange because they won't do it normally. And
> given there is a fixed re-usable .bpf_selftests "cache directory", we
> should be able to set everything up so that no extra compilation is
> performed, no?
>
> 5. Before VM is started there is:
>
>
> #!/bin/bash
>
> {
>
>         cd /root/bpf
>         echo ./test_progs
>         ./test_progs
> } 2>&1 | tee /root/bpf_selftests.2021-01-25_17-56-11.log
> poweroff -f
>
>
> Which is probably useful in rare cases for debugging purposes, but is
> just distracting in common case. Would it be able to have verbose flag
> for your script that would omit output like this by default?

Sure. I can omit it for now and submit a subsequent patch that adds verbosity.

>
> 6. Was too lazy to check, but once VM boots and before specified
> command is run, there is a bunch of verbose script echoing:
>
> + for path in /etc/rcS.d/S*
>
> If that's part of libbpf CI's image, let's fix it there. If not, let's
> fix it in your script?

Nope, this is not from my script so probably something from one of the
CI init scripts.

>
> 7. Is it just me, or when ./test_progs is run inside VM, it's output
> is somehow heavily buffered and delayed? I get no output for a while,
> and then a whole bunch of lines with already passed tests.  Curious if
> anyone else noticed that as well. When I run the same image locally
> and manually (not through your script), I don't have this issue.

I saw this as well but sort of ignored it as it was random for me, but I did
some digging and found that this could be related to buffering within
test_progs, so I changed the buffering to per-line and now it does not
get stuck and dump its output as you and Jiri noticed.

--- a/tools/testing/selftests/bpf/run_in_vm.sh
+++ b/tools/testing/selftests/bpf/run_in_vm.sh
@@ -165,7 +165,7 @@ EOF

        cd /root/bpf
        echo ${command}
-       ${command}
+       stdbuf -oL -eL ${command}
 } 2>&1 | tee /root/${log_file}

>
> 8. I noticed that even if the command succeeds (e.g., ./test_progs in
> my case), the script exits with non-zero error code (32 in my case).
> That's suboptimal, because you can't use that script to detect test
> failures.

I found this was because if the unmount command
in the cleanup block fails
(when the directory was not mounted or already unmounted)
we would never get to the exit command.

The snippet below fixes this.

@@ -343,8 +343,10 @@ main()
 catch()
 {
        local exit_code=$1
-
-       unmount_image
+       # This is just a cleanup and the directory may
+       # have already been unmounted. So, don't let this
+       # clobber the error code we intend to return.
+       unmount_image || true
        exit ${exit_code}
 }

>
> But again, it's the polish feedback, great work!

Thanks! :)



>
> >  tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
> >  1 file changed, 353 insertions(+)
> >  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> >
> > diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> > new file mode 100755
> > index 000000000000..09bb9705acb3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> > @@ -0,0 +1,353 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -u
> > +set -e
> > +
> > +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
> > +X86_BZIMAGE="arch/x86/boot/bzImage"
>
> Might be worth it to mention that this only works with x86_64 (due to
> image restrictions at least, right?).
>
> > +DEFAULT_COMMAND="./test_progs"
> > +MOUNT_DIR="mnt"
> > +ROOTFS_IMAGE="root.img"
> > +OUTPUT_DIR="$HOME/.bpf_selftests"
> > +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config"
> > +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> > +NUM_COMPILE_JOBS="$(nproc)"
> > +
> > +usage()
> > +{
> > +       cat <<EOF
> > +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
> > +
> > +<command> is the command you would normally run when you are in
> > +tools/testing/selftests/bpf. e.g:
> > +
> > +       $0 -- ./test_progs -t test_lsm
> > +
> > +If no command is specified, "${DEFAULT_COMMAND}" will be run by
> > +default.
> > +
> > +If you build your kernel using KBUILD_OUTPUT= or O= options, these
> > +can be passed as environment variables to the script:
> > +
> > +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
>
> "relative_to_cwd" is a bit misleading, it could be an absolute path as
> well, I presume. So I'd just say "O=<kernel_build_path>" or something
> along those lines.
>
> > +
> > +or
> > +
> > +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> > +
>
> [...]
