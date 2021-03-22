Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A294344DD7
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVRzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhCVRye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 13:54:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA5C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 10:54:34 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z1so7498520ybf.6
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6lS6SKv6sQqlQGE1PYirJluULRVNq9ZnN65xSO3d+Q=;
        b=rG6H7VwUFyAsrIUqxnpn1ZDqlJFJmJPqU8mOgG79nmvdRaxOKnm2pTiGlsKaaPs6w5
         7ICG+8Zzi2i+hZRsAUQqyjPRdny/YmY/gS3E02EIqJlsyJiK8ugfqgMSdGjaMpJehKn2
         mb04Rjwaqeat9h5OrUT+oHB3qWYXShdQAedKUdZWzthYXgVLjHXwluKc6idau1rKuIuS
         nTsJN4Evny4aZwrbRLSKR4blzXB2ehwPAyTpqhjaM/YFFt6+jd7DMFx+oHQCbfVldpWU
         xAdRm11dKv/gzwoNw6X8X0iB9zz1aA4e+RXGNoeo2XfZMqDFIC/h8xkYQKJoxWVsSbJi
         iXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6lS6SKv6sQqlQGE1PYirJluULRVNq9ZnN65xSO3d+Q=;
        b=Y3UjIuSUJEeU4BS1ZdraeAeSCsuPqlKJmZWAYU4b6Yj8v20/Zlir5URxox0pPxdyZR
         iZiDBPq4UxU7wUI2DRgpA3nXYShu9oIm640ufbl3uP74gEoFTjzC4+GNEYoVuiiNmdvy
         QJ3Ezvq4pi+piLW4xxmywk4QE89RHDxQktwx5+T6tIAWcZ3gQHtpqeyVWuTyYxjbOLk3
         QKee1qbqOcPF4i/XfqQJSdIjYOnjFYnhwOYhBpGvXBcRX6+tDCtGymJX0flPVqrtBGTT
         K3J1aOBrjvClH/OU7j3qpqDqjnyUzWRB/XVV0Jt+w/BMjC41NcpmPrYCdUF9p6bK83Jy
         +kSg==
X-Gm-Message-State: AOAM532kTaU5vmsY0yEj/6Y1Ah0fpgWMvVdFglE2oKNXGCSF9Hq69QkL
        i3svsHL0For20ROtrrrIL8O+lnDI6MOzv2GohCk=
X-Google-Smtp-Source: ABdhPJwuBxWZXSmjJUNCrFqdbJ9EZaBVN8Ipx/P9S58HRAYshRyaZh0TDrM/jb1RiAn9eOvxf2/VEhR4rhEZSY0blRE=
X-Received: by 2002:a25:9942:: with SMTP id n2mr942296ybo.230.1616435673576;
 Mon, 22 Mar 2021 10:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210322163659.2873534-1-kpsingh@kernel.org>
In-Reply-To: <20210322163659.2873534-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Mar 2021 10:54:22 -0700
Message-ID: <CAEf4BzYR2Ny2JnMVZ_N76EN1f-8PyFKj3aZkWmjzkC_d8U-30w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add an option for a debug shell
 in vmtest.sh
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

On Mon, Mar 22, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
>
> The newly introduced -s command line option starts an interactive shell
> after running the intended command in instead of powering off the VM.
> It's useful to have a shell especially when debugging failing
> tests or developing new tests.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 22554894db99..3f248e755755 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -24,7 +24,7 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
>  usage()
>  {
>         cat <<EOF
> -Usage: $0 [-i] [-d <output_dir>] -- [<command>]
> +Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]

wouldn't it make more sense to just run bash without any default
commands, if -s is specified? So "shell mode" gets you into shell.
Then you can run whatever you want.

>
>  <command> is the command you would normally run when you are in
>  tools/testing/selftests/bpf. e.g:
> @@ -49,6 +49,8 @@ Options:
>         -d)             Update the output directory (default: ${OUTPUT_DIR})
>         -j)             Number of jobs for compilation, similar to -j in make
>                         (default: ${NUM_COMPILE_JOBS})
> +       -s)             Instead of powering off the VM, run an interactive debug
> +                       shell after <command> finishes.
>  EOF
>  }
>
> @@ -149,6 +151,7 @@ update_init_script()
>         local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
>         local init_script="${init_script_dir}/S50-startup"
>         local command="$1"
> +       local exit_command="$2"
>
>         mount_image
>
> @@ -175,7 +178,7 @@ echo "130" > "/root/${EXIT_STATUS_FILE}"
>         stdbuf -oL -eL ${command}
>         echo "\$?" > "/root/${EXIT_STATUS_FILE}"
>  } 2>&1 | tee "/root/${LOG_FILE}"
> -poweroff -f
> +${exit_command}
>  EOF
>
>         sudo chmod a+x "${init_script}"
> @@ -277,8 +280,9 @@ main()
>         local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
>         local command="${DEFAULT_COMMAND}"
>         local update_image="no"
> +       local exit_command="poweroff -f"
>
> -       while getopts 'hkid:j:' opt; do
> +       while getopts 'hskid:j:' opt; do
>                 case ${opt} in
>                 i)
>                         update_image="yes"
> @@ -289,6 +293,9 @@ main()
>                 j)
>                         NUM_COMPILE_JOBS="$OPTARG"
>                         ;;
> +               s)
> +                       exit_command="bash"
> +                       ;;
>                 h)
>                         usage
>                         exit 0
> @@ -355,7 +362,7 @@ main()
>         fi
>
>         update_selftests "${kernel_checkout}" "${make_command}"
> -       update_init_script "${command}"
> +       update_init_script "${command}" "${exit_command}"
>         run_vm "${kernel_bzimage}"
>         copy_logs
>         echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
