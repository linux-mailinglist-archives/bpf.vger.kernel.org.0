Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE22FDE83
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 02:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392075AbhAUBKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 20:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbhAUBIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 20:08:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ADAC23888
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611191240;
        bh=3UzDy2nXgtSa6ho90T2qncuWzvoUEPHExPkqD38R4Ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VHDvimbhhqXA2/I2GMVhMse5/t1uSwFYvP+aMOG3CVeJYcacdq3R6PEpEaphB4Den
         7J/ZYxPBNL6dCm7AY3WZGMPYYGoXnIBVyF28Md9CbKSA0h9FVSZ/fLX7Oo6eB44byI
         EvRvcuwkuca/xnvl7ILFydLVV2nBe3coNzUV9OTvm7QA9SFAYFsthoKMZ7lDPOzg6l
         NAWfE8KFwF6Svprhl8CYIqg7VqUKPV03Xr8zSScgey/k4jBCI/IE2UAOnzEi6CD3NY
         J7Dn4qGHA4zaWCBTA2tw2r976z1vBkY5thMRWFMRY4t+y5+/Zq8XcSBTMpcWzYdK3P
         Bn+EVvHulibzA==
Received: by mail-lf1-f41.google.com with SMTP id a8so192706lfi.8
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 17:07:20 -0800 (PST)
X-Gm-Message-State: AOAM530AqeRyQY1ze+rfpAwv05lHQldvYErTXYgpw0hjgBq1Py0KmYjw
        suM7vOy73B4d749B9zoi2Tuszosku14cNmFcglmj5w==
X-Google-Smtp-Source: ABdhPJw5YinYf+6xPQJd0MaHJu40SGVFmoepA+xXrCbImnDMgtwkgZjYJdHOgxHbrRZ4jZdIzkj/6/Kgvz1Dk1NFme0=
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr5753976lfu.9.1611191238723;
 Wed, 20 Jan 2021 17:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20210118141955.2033747-1-kpsingh@kernel.org> <0d577037-769a-35fc-b07f-bba2cf2bd3d2@iogearbox.net>
In-Reply-To: <0d577037-769a-35fc-b07f-bba2cf2bd3d2@iogearbox.net>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 21 Jan 2021 02:07:08 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7Ldpcc-2w3j7gPXu_ERZpqA_0sOpEOns6Uc0R8rGAvuA@mail.gmail.com>
Message-ID: <CACYkzJ7Ldpcc-2w3j7gPXu_ERZpqA_0sOpEOns6Uc0R8rGAvuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Helper script for running BPF presubmit tests
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 3:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/18/21 3:19 PM, KP Singh wrote:
> > The script runs the BPF selftests locally on the same kernel image
> > as they would run post submit in the BPF continuous integration
> > framework. The goal of the script is to run selftests locally in the
> > same environment to check if their changes would end up breaking the
> > BPF CI and reduce the back-and-forth between the maintainers and the
> > developers.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Looks really nice! I gave it a run, some minor feedback:

Thanks! :)

>
> > ---
> >   tools/testing/selftests/bpf/run_in_vm.sh | 346 +++++++++++++++++++++++
> >   1 file changed, 346 insertions(+)
> >   create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> >
> > diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> > new file mode 100755
> > index 000000000000..a4f28f5cdd52
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> > @@ -0,0 +1,346 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -u
> > +set -e

[...]

> > +
> > +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> > +
> > +Options:
> > +
> > +     -k)             Recompile the kernel with the config for selftests.
> > +     -i)             Update the rootfs image with a newer version.
> > +     -d)             Update the output directory (default: ${OUTPUT_DIR})
>
> Probably best to have a small howto in tools/testing/selftests/bpf/README.rst for
> people to have a 'getting started' point. Initially I forgot the -k, so VM paniced
> on boot, but after that it was working great modulo a small change below.

Makes sense, I totally forgot about the case when one already has a
precompiled kernel
and it does not work well with the image.

Will update the docs.

>
> [...]
> > +main()
> > +{
> > +     local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> > +     local kernel_checkout=$(realpath "${script_dir}"/../../../../)
> > +     local log_file="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S.log")"

[...]

> > +             esac
> > +     done
> > +     shift $((OPTIND -1))
> > +
> > +     if [[ $# -eq 0 ]]; then
> > +             echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
> > +     else
> > +             command="$@"
> > +     fi
> > +
> > +     local kconfig_file="${OUTPUT_DIR}/latest.config"
> > +     local make_command="make -j KCONFIG_CONFIG=${kconfig_file}"
>
> I had to fix/limit this locally to -j <num-cpus> as otherwise this was OOM killing
> my box. make man page says 'if the -j option is given without an argument, make will
> not limit the number of jobs that can run simultaneously.'

I thought that -j without an option did something smart. I will update
it to be -j `<num_cpus>`
Thanks!

>
> > +
> > +     # Figure out where the kernel is being built.
> > +     # O takes precedence over KBUILD_OUTPUT.
> > +     if [[ "${O:=""}" != "" ]]; then
> > +             if is_rel_path "${O}"; then
> > +                     O="$(realpath "${PWD}/${O}")"
> > +             fi
>
> For future follow-up, would be amazing to auto-grab nightly build of llvm + pahole
> as well. And even further out maybe also to allow cross-compilation + testing on
> other archs. :)

Indeed, these are definitely on the radar :)

- KP

>
> Thanks,
> Daniel
