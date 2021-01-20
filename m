Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF56C2FDA95
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbhATUO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 15:14:58 -0500
Received: from www62.your-server.de ([213.133.104.62]:33104 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbhATOCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 09:02:03 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l2E2q-0000aV-TP; Wed, 20 Jan 2021 15:01:12 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l2E2q-000JKx-M2; Wed, 20 Jan 2021 15:01:12 +0100
Subject: Re: [PATCH bpf-next] bpf: Helper script for running BPF presubmit
 tests
To:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210118141955.2033747-1-kpsingh@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0d577037-769a-35fc-b07f-bba2cf2bd3d2@iogearbox.net>
Date:   Wed, 20 Jan 2021 15:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210118141955.2033747-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26055/Wed Jan 20 13:29:54 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/18/21 3:19 PM, KP Singh wrote:
> The script runs the BPF selftests locally on the same kernel image
> as they would run post submit in the BPF continuous integration
> framework. The goal of the script is to run selftests locally in the
> same environment to check if their changes would end up breaking the
> BPF CI and reduce the back-and-forth between the maintainers and the
> developers.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Looks really nice! I gave it a run, some minor feedback:

> ---
>   tools/testing/selftests/bpf/run_in_vm.sh | 346 +++++++++++++++++++++++
>   1 file changed, 346 insertions(+)
>   create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> 
> diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> new file mode 100755
> index 000000000000..a4f28f5cdd52
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> @@ -0,0 +1,346 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -u
> +set -e
> +
> +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
> +X86_BZIMAGE="arch/x86/boot/bzImage"
> +DEFAULT_COMMAND="./test_progs"
> +MOUNT_DIR="mnt"
> +ROOTFS_IMAGE="root.img"
> +OUTPUT_DIR="$HOME/.bpf_selftests"
> +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config"
> +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> +
> +usage()
> +{
> +	cat <<EOF
> +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
> +
> +<command> is the command you would normally run when you are in
> +tools/testing/selftests/bpf. e.g:
> +
> +	$0 -- ./test_progs -t test_lsm
> +
> +If no command is specified, "${DEFAULT_COMMAND}" will be run by
> +default.
> +
> +If you build your kernel using KBUILD_OUTPUT= or O= options, these
> +can be passed as environment variables to the script:
> +
> +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> +
> +or
> +
> +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> +
> +Options:
> +
> +	-k)		Recompile the kernel with the config for selftests.
> +	-i)		Update the rootfs image with a newer version.
> +	-d)		Update the output directory (default: ${OUTPUT_DIR})

Probably best to have a small howto in tools/testing/selftests/bpf/README.rst for
people to have a 'getting started' point. Initially I forgot the -k, so VM paniced
on boot, but after that it was working great modulo a small change below.

[...]
> +main()
> +{
> +	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> +	local kernel_checkout=$(realpath "${script_dir}"/../../../../)
> +	local log_file="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S.log")"
> +	# By default the script searches for the kernel in the checkout directory but
> +	# it also obeys environment variables O= and KBUILD_OUTPUT=
> +	local kernel_bzimage="${kernel_checkout}/${X86_BZIMAGE}"
> +	local command="${DEFAULT_COMMAND}"
> +	local kernel_recompile="no"
> +	local update_image="no"
> +
> +	while getopts 'hkid:' opt; do
> +		case ${opt} in
> +		k)
> +			kernel_recompile="yes"
> +			;;
> +		i)
> +			update_image="yes"
> +			;;
> +		d)
> +			OUTPUT_DIR="$OPTARG"
> +			;;
> +		h)
> +			usage
> +			exit 0
> +			;;
> +		\? )
> +			echo "Invalid Option: -$OPTARG"
> +			usage
> +			exit 1
> +			;;
> +      		: )
> +        		echo "Invalid Option: -$OPTARG requires an argument"
> +			usage
> +			exit 1
> +			;;
> +		esac
> +	done
> +	shift $((OPTIND -1))
> +
> +	if [[ $# -eq 0 ]]; then
> +		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
> +	else
> +		command="$@"
> +	fi
> +
> +	local kconfig_file="${OUTPUT_DIR}/latest.config"
> +	local make_command="make -j KCONFIG_CONFIG=${kconfig_file}"

I had to fix/limit this locally to -j <num-cpus> as otherwise this was OOM killing
my box. make man page says 'if the -j option is given without an argument, make will
not limit the number of jobs that can run simultaneously.'

> +
> +	# Figure out where the kernel is being built.
> +	# O takes precedence over KBUILD_OUTPUT.
> +	if [[ "${O:=""}" != "" ]]; then
> +		if is_rel_path "${O}"; then
> +			O="$(realpath "${PWD}/${O}")"
> +		fi

For future follow-up, would be amazing to auto-grab nightly build of llvm + pahole
as well. And even further out maybe also to allow cross-compilation + testing on
other archs. :)

Thanks,
Daniel
