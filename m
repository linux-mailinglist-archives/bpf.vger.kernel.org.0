Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4146326955
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZVT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZVT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 16:19:28 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB11C061756
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:18:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c131so10264640ybf.7
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7RMRYNxAHROpp4W84p/D9fN43h7SVnZq95wbKF79wA=;
        b=hdDyVjX4kqyp552JAJagBbgV6vPPWQVRijJQjq6J2ssbHDq7ZBR/Iown8F9qx3tuvg
         W9/olUXGsPj1QOEqpTp+UTLN/3Vu9SJCosIlVmrqJqSPfWti7qnvnY+8B/XdFhjf/rUC
         p7nr5vTkrLdz2OXUmtzTaWGmVsxC+IekOdnfVZ00tsK7lGzk+RmlE7JPUSoqek7jTD2P
         0rchXIlDLqtXxBxjwdKADgRxXcF68lcacvI4YxjLB0rJXi4ti0GFLtfSTtKfQqvaYuS3
         b14T7Q3btYYEfRIcW/PIWeVodf9rhuE3PTcPdSwCv/s8iJytJGBl5sYwdGIIr4QePruw
         4+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7RMRYNxAHROpp4W84p/D9fN43h7SVnZq95wbKF79wA=;
        b=HVjftMQPezgrCXV+xC2a1ik14UHqu8whc0oEeoFU9tIoP/YJ9DJGIu+cUJudaubxEa
         HJYHWyOR+QGheW+v8AXbG3BfHMmBM/eaG2PipJ8d5nEFvo5rkmcMKm9nTdjzFbK7lU9s
         OmEVmzTOSJ8cf+3LdXJYnAtdR+UV992wDnNNdgmLwD4HLQlpGjsdW4kMdDfmkOWwpelt
         99niKD9ttZDgbpEO+qC2hCN2v9Si+obNji2E9eahwlPLFuYPfrglYLEow2HRGmnZyKYU
         CuVTgxSQl+pdQHhL3ALclVgH3jcbYlHrTzwS/xTDg2wb0HAMEvS/uoVRHSKDR4JPugPK
         OH1A==
X-Gm-Message-State: AOAM533QXKu4sbyrMpRudaQzXrv2nyBJdRwjLr84wPqiuXgfRh96WLWk
        Tgf0QPUzNo8qIgQ35z7r1FRXceE7kTP8ravX4bbkUNXh
X-Google-Smtp-Source: ABdhPJzs2rB6IW+gZN3945UtABVtV9b5meWk+qEYT+tw0bRq8N42qROZ4IH6TC5Hny7Z3vMQnHGTtQFhL+P/EN2ZnGM=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr7381554ybd.230.1614374327763;
 Fri, 26 Feb 2021 13:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20210225161947.1778590-1-kpsingh@kernel.org>
In-Reply-To: <20210225161947.1778590-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 13:18:36 -0800
Message-ID: <CAEf4BzYNTS0xU6dq-OS01mys77N-D_q=CyP6K+wupa-DwZR=qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Propagate error code of the
 command to vmtest.sh
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

On Thu, Feb 25, 2021 at 8:19 AM KP Singh <kpsingh@kernel.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> When vmtest.sh ran a command in a VM, it did not record or propagate the
> error code of the command. This made the script less "script-able". The
> script now saves the error code of the said command in a file in the VM,
> copies the file back to the host and (when available) uses this error
> code instead of its own.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Worked for me, thanks! Applied to bpf-next.

>  tools/testing/selftests/bpf/vmtest.sh | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 26ae8d0b6ce3..22554894db99 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -17,6 +17,9 @@ KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vm
>  KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/latest.config"
>  INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
>  NUM_COMPILE_JOBS="$(nproc)"
> +LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
> +LOG_FILE="${LOG_FILE_BASE}.log"
> +EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
>
>  usage()
>  {
> @@ -146,7 +149,6 @@ update_init_script()
>         local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
>         local init_script="${init_script_dir}/S50-startup"
>         local command="$1"
> -       local log_file="$2"
>
>         mount_image
>
> @@ -163,11 +165,16 @@ EOF
>         sudo bash -c "cat >${init_script}" <<EOF
>  #!/bin/bash
>
> +# Have a default value in the exit status file
> +# incase the VM is forcefully stopped.
> +echo "130" > "/root/${EXIT_STATUS_FILE}"
> +
>  {
>         cd /root/bpf
>         echo ${command}
>         stdbuf -oL -eL ${command}
> -} 2>&1 | tee /root/${log_file}
> +       echo "\$?" > "/root/${EXIT_STATUS_FILE}"
> +} 2>&1 | tee "/root/${LOG_FILE}"
>  poweroff -f
>  EOF
>
> @@ -221,10 +228,12 @@ EOF
>  copy_logs()
>  {
>         local mount_dir="${OUTPUT_DIR}/${MOUNT_DIR}"
> -       local log_file="${mount_dir}/root/$1"
> +       local log_file="${mount_dir}/root/${LOG_FILE}"
> +       local exit_status_file="${mount_dir}/root/${EXIT_STATUS_FILE}"
>
>         mount_image
>         sudo cp ${log_file} "${OUTPUT_DIR}"
> +       sudo cp ${exit_status_file} "${OUTPUT_DIR}"
>         sudo rm -f ${log_file}
>         unmount_image
>  }
> @@ -263,7 +272,6 @@ main()
>  {
>         local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
>         local kernel_checkout=$(realpath "${script_dir}"/../../../../)
> -       local log_file="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S.log")"
>         # By default the script searches for the kernel in the checkout directory but
>         # it also obeys environment variables O= and KBUILD_OUTPUT=
>         local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
> @@ -347,19 +355,23 @@ main()
>         fi
>
>         update_selftests "${kernel_checkout}" "${make_command}"
> -       update_init_script "${command}" "${log_file}"
> +       update_init_script "${command}"
>         run_vm "${kernel_bzimage}"
> -       copy_logs "${log_file}"
> -       echo "Logs saved in ${OUTPUT_DIR}/${log_file}"
> +       copy_logs
> +       echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
>  }
>
>  catch()
>  {
>         local exit_code=$1
> +       local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
>         # This is just a cleanup and the directory may
>         # have already been unmounted. So, don't let this
>         # clobber the error code we intend to return.
>         unmount_image || true
> +       if [[ -f "${exit_status_file}" ]]; then
> +               exit_code="$(cat ${exit_status_file})"
> +       fi
>         exit ${exit_code}
>  }
>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
