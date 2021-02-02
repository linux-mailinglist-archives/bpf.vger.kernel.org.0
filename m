Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD630CDCA
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 22:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhBBVOf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 16:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234051AbhBBVOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 16:14:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6CA64F66
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612300432;
        bh=WFAakCCW4ST6ni4l02Rd3iB3DRMgZwUoaVzwMxRkwpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1ouyT6UMmSd91pPDwA7VQ3c5PeIQu6XSAimxKDUK0KeR0tTr3s5HnWZ6PFtybO83
         E97hHnhjmQd4pdVO3YslKv24Dkt6n3ns0WxGZoyzUeZrW9qt2YOvnRUKBl8pQsi41+
         AvrnKyDolGGTsbN2eLE+ESAMPk+0tv+7J2aO42YrqXWSCY0hFfu3+bCiW/X57fcqFh
         lBIVR1XMm2NOQrhF6SNfXEJNDtFvw32VDeMhQn0XjhnMPhqHGkQLCOtCsWjehalLT2
         +HvmNQhQ7w/M4ha6O4Vw3vCDikTGPLvDSO1k0BqjmyLaDmKlhbzTGR+9N5e2tdWSff
         /5jstoNCLOh9A==
Received: by mail-lj1-f172.google.com with SMTP id f19so25716657ljn.5
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 13:13:51 -0800 (PST)
X-Gm-Message-State: AOAM530Il0CB2AUAVSIix9m6z3k0mFy4xzDarQ+qP+Ep/4VsPKZ+I1Q5
        CKLOykTWkk2MOfavghuWeSQn/0t56u1kqxsbYs+lbA==
X-Google-Smtp-Source: ABdhPJzAqw4Nif5XHcvxzHFjweTwmbWL5ANk085kfhCxzVIYDIJxpmDIPrCZKbZwTPlD2jZPgB61SR81LxK+UF7bAgI=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr13605406ljs.468.1612300430144;
 Tue, 02 Feb 2021 13:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20210123004445.299149-1-kpsingh@kernel.org> <20210123004445.299149-2-kpsingh@kernel.org>
 <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com>
 <CACYkzJ7nqXyqBv9px1e4pANyNyYmqt18Dx=cL90otKK1oPYU-g@mail.gmail.com> <CAEf4BzagU3B2yWKAw6p9cu_J+StW1DoFhX2JyvFMt3tZ2_1wpQ@mail.gmail.com>
In-Reply-To: <CAEf4BzagU3B2yWKAw6p9cu_J+StW1DoFhX2JyvFMt3tZ2_1wpQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 2 Feb 2021 22:13:39 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5sGC0GzXWNOPZ-VQPO+pjT7kh78jnkEzopuFsT1xs0eQ@mail.gmail.com>
Message-ID: <CACYkzJ5sGC0GzXWNOPZ-VQPO+pjT7kh78jnkEzopuFsT1xs0eQ@mail.gmail.com>
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

[...]

> >
> > >
> > > 2. Then something is re-downloaded every single time:
> > >
> > >   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
> > >                                  Dload  Upload   Total   Spent    Left  Speed
> > > 100 77713  100 77713    0     0   509k      0 --:--:-- --:--:-- --:--:--  512k
> > >
> > > Unless it's to check if something newer appeared in S3, would be nice
> > > to skip that step.
> >
> > This is the kernel config. I wonder how we could check if there is something
> > new without downloading it, the file is called "latest.config".
> >
> > Maybe this is something we can add to the URL index as well in format similar
> >  to the image. But since it's just a config file I am not sure
> > it's worth the extra effort.
>
> Curl supports the following option. Given we have a local cache in
> .bpf_selftests, check if it already has .config and pass it as -z
> '.bpf_selftests/.config'? Would be nice, if it works out. If not, I
> agree, config is small enough to not go to great lengths to avoid
> downloading it.
>
> -z/--time-cond <date expression>
>
> (HTTP/FTP) Request a file that has been modified later than the given
> time and date, or one that has been modified before that time. The
> date expression can be all sorts of date strings or if it doesn't
> match any internal ones, it tries to get the time from a given file
> name instead.

This does not work with the github github raw URL so I had to do something like:

diff --git a/tools/testing/selftests/bpf/run_in_vm.sh
b/tools/testing/selftests/bpf/run_in_vm.sh
index 46fbb0422e9e..132017981776 100755
--- a/tools/testing/selftests/bpf/run_in_vm.sh
+++ b/tools/testing/selftests/bpf/run_in_vm.sh
@@ -14,6 +14,7 @@ MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config"
+KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/latest.config"
 INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"

@@ -236,6 +237,27 @@ is_rel_path()
        [[ ${path:0:1} != "/" ]]
 }

+update_kconfig()
+{
+       local kconfig_file="$1"
+       local update_command="curl -sLf ${KCONFIG_URL} -o ${kconfig_file}"
+       # Github does not return the "last-modified" header when
retrieving the raw contents of the file.
+       # Use the API call to get the last-modified time of the kernel
config and only update the config if
+       # it has been updated after the previously cached config was
created. This avoids unnecessarily
+       # compiling the kernel and selftests.
+       if [[ -f "${kconfig_file}" ]]; then
+               local last_modified_date="$(curl -sL -D -
"${KCONFIG_API_URL}" -o /dev/null | grep "last-modified" | awk -F ': '
'{print $2}')"
+               local remote_modified_timestamp="$(date -d
"${last_modified_date}" +"%s")"
+               local local_creation_timestamp="$(stat -c %W "${kconfig_file}")"
+
+               if [[ "${remote_modified_timestamp}" -gt
"${local_creation_timestamp}" ]]; then
+                       ${update_command}
+               fi
+       else
+               ${update_command}
+       fi
+}
+
 main()
 {
        local script_dir="$(cd -P -- "$(dirname --
"${BASH_SOURCE[0]}")" && pwd -P)"
@@ -314,7 +336,7 @@ main()

        mkdir -p "${OUTPUT_DIR}"
        mkdir -p "${mount_dir}"
-       curl -Lsf "${KCONFIG_URL}" -o "${kconfig_file}"
+       update_kconfig "${kconfig_file}"

        if [[ "${kernel_recompile}" == "no" && ! -f "${kernel_bzimage}" ]]; then
                echo "Kernel image not found in ${kernel_bzimage},
kernel will be recompiled"
>
>
> >
> > >
> > > 3. Every single time I run the script it actually rebuilds kernel.
> > > Somehow Linux Makefile's logic to do nothing if nothing changed in
> > > Linux source code doesn't kick in, I wonder why? It's quite annoying
> > > and time-consuming for frequent selftest reruns. What's weird is that
> > > individual .o's are not re-built, but kernel is still re-linked and
> > > BTF is re-generated, which is the slow part :(
> >
> > I changed this from not compiling the kernel by default, to compiling it and you
> > can "keep your old kernel" with -k. This is because users may run the script,
> > not compile the kernel and run into issues with the image not being able to
> > mount as the kernel does not have the right config.
> >
> > The -k is for people who know what they are doing :)
> >
> > so you can always run
> >
> >  ./bpf_presubmit.sh -k
> >
> > after you have the kernel built once.
>
> That's not what I'm saying. When running `make` to build Linux, if
> won't do much at all if nothing changed. That's a good property that
> saves tons of time. I'm saying your script somehow precludes that
> behavior and make does tons of unnecessary work. It might be because
> of always re-downloaded config, which might make the above (not
> redownloading it if it didn't change) more important.
>
> Sure -k might be used this way, but it's expected to happen
> automatically. I'm just pointing out that something is not wired
> optimally to allow make do its job properly.

Ah, now I see what you are saying and yeah, it was indeed the downloading
of the config every time that was causing the kernel and selftest to be
recompiled.

With the change I posted above this does not happen anymore. I guess, with
this we can simply remove the -k option?

>
> >
> > >
> > > 4. Selftests are re-built from scratch every single time, even if
> > > nothing changed. Again, strange because they won't do it normally. And
> > > given there is a fixed re-usable .bpf_selftests "cache directory", we
> > > should be able to set everything up so that no extra compilation is
> > > performed, no?
> > >
>
> And this won't be solved with '-k' alone, probably?

Yeah..

>
> > > 5. Before VM is started there is:
> > >
> > >
> > > #!/bin/bash

[...]
