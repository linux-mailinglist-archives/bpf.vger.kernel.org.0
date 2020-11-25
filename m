Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83A2C401A
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgKYM2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 07:28:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgKYM2E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Nov 2020 07:28:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APC394w121862;
        Wed, 25 Nov 2020 07:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UbzirwkjfgdomKJA+29wtILa4mu/T1pTH0be6wGGd2I=;
 b=fa1Qm2FJDWMjThdDGTleoY8JFuQOIAPO6KOjl/W1untBkPUl3wJ3NsMRLRT0YqFFJWoc
 HsX571eJ4x3L2Zn7sf1KaRyjx1wRrfLALrufG6Wr9StJ23QxJCGdgy9FVB4UBA1j/FKk
 QNdcfls8lghXeTNiCMLuxOE1iDEe5iziNVjW8MtvPJ3mE8gUqAKGbFZ7nDFes3U6VVC5
 8laEjE8pWMpUEhMcpqYD2GGXQpt4YbrWMmw+0Iopr84Lck6wA2H1Iwi1XwQYY+WS8/IZ
 06+MfNM4aU8v+UADFdr76gC3SCmjBwWHjQ0nV3FWphGghWkoW4ShqcVfFYL9tky1GPUq Sw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351nfg42ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 07:27:48 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APCPY7F011658;
        Wed, 25 Nov 2020 12:27:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3518j8gnxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 12:27:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0APCRiOv15270224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 12:27:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E39B05204E;
        Wed, 25 Nov 2020 12:27:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.213])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E08AC52051;
        Wed, 25 Nov 2020 12:27:41 +0000 (GMT)
Message-ID: <38bfd8e3f4642095c88cc456e010c44697c57af9.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for
 bpf_ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Date:   Wed, 25 Nov 2020 07:27:40 -0500
In-Reply-To: <20201124151210.1081188-4-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
         <20201124151210.1081188-4-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_06:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250072
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test does the following:
> 
> - Mounts a loopback filesystem and appends the IMA policy to measure
>   executions only on this file-system. Restricting the IMA policy to a
>   particular filesystem prevents a system-wide IMA policy change.
> - Executes an executable copied to this loopback filesystem.
> - Calls the bpf_ima_inode_hash in the bprm_committed_creds hook and
>   checks if the call succeeded and checks if a hash was calculated.
> 
> The test shells out to the added ima_setup.sh script as the setup is
> better handled in a shell script and is more complicated to do in the
> test program or even shelling out individual commands from C.
> 
> The list of required configs (i.e. IMA, SECURITYFS,
> IMA_{WRITE,READ}_POLICY) for running this test are also updated.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Suggested-by: Mimi Zohar <zohar@linux.ibm.com> (limit policy rule to
loopback mount)

> ---
>  tools/testing/selftests/bpf/config            |  4 +
>  tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
>  tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
>  create mode 100644 tools/testing/selftests/bpf/progs/ima.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 2118e23ac07a..365bf9771b07 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -39,3 +39,7 @@ CONFIG_BPF_JIT=y
>  CONFIG_BPF_LSM=y
>  CONFIG_SECURITY=y
>  CONFIG_LIRC=y
> +CONFIG_IMA=y
> +CONFIG_SECURITYFS=y
> +CONFIG_IMA_WRITE_POLICY=y
> +CONFIG_IMA_READ_POLICY=y
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> new file mode 100644
> index 000000000000..15490ccc5e55
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -u
> +
> +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> +TEST_BINARY="/bin/true"
> +
> +usage()
> +{
> +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> +        exit 1
> +}
> +
> +setup()
> +{
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> +        mkdir -p ${mount_dir}
> +
> +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> +
> +        local loop_device="$(losetup --find --show ${mount_img})"
> +
> +        mkfs.ext4 "${loop_device}"
> +        mount "${loop_device}" "${mount_dir}"
> +
> +        cp "${TEST_BINARY}" "${mount_dir}"
> +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> +}
> +
> +cleanup() {
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +
> +        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
> +        for loop_dev in "${loop_devices}"; do
> +                losetup -d $loop_dev
> +        done
> +
> +        umount ${mount_dir}
> +        rm -rf ${tmp_dir}
> +}
> +
> +run()
> +{
> +        local tmp_dir="$1"
> +        local mount_dir="${tmp_dir}/mnt"
> +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> +
> +        exec "${copied_bin_path}"
> +}
> +
> +main()
> +{
> +        [[ $# -ne 2 ]] && usage
> +
> +        local action="$1"
> +        local tmp_dir="$2"
> +
> +        [[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
> +
> +        if [[ "${action}" == "setup" ]]; then
> +                setup "${tmp_dir}"
> +        elif [[ "${action}" == "cleanup" ]]; then
> +                cleanup "${tmp_dir}"
> +        elif [[ "${action}" == "run" ]]; then
> +                run "${tmp_dir}"
> +        else
> +                echo "Unknown action: ${action}"
> +                exit 1
> +        fi
> +}
> +
> +main "$@"
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> new file mode 100644
> index 000000000000..61fca681d524
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
> +#include <test_progs.h>
> +
> +#include "ima.skel.h"
> +
> +static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
> +{
> +	int child_pid, child_status;
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		*monitored_pid = getpid();
> +		execlp("./ima_setup.sh", "./ima_setup.sh", "run", measured_dir,
> +		       NULL);
> +		exit(errno);
> +
> +	} else if (child_pid > 0) {
> +		waitpid(child_pid, &child_status, 0);
> +		return WEXITSTATUS(child_status);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +void test_test_ima(void)
> +{
> +	char measured_dir_template[] = "/tmp/ima_measuredXXXXXX";
> +	const char *measured_dir;
> +	char cmd[256];
> +
> +	int err, duration = 0;
> +	struct ima *skel = NULL;
> +
> +	skel = ima__open_and_load();
> +	if (CHECK(!skel, "skel_load", "skeleton failed\n"))
> +		goto close_prog;
> +
> +	err = ima__attach(skel);
> +	if (CHECK(err, "attach", "attach failed: %d\n", err))
> +		goto close_prog;
> +
> +	measured_dir = mkdtemp(measured_dir_template);
> +	if (CHECK(measured_dir == NULL, "mkdtemp", "err %d\n", errno))
> +		goto close_prog;
> +
> +	snprintf(cmd, sizeof(cmd), "./ima_setup.sh setup %s", measured_dir);
> +	if (CHECK_FAIL(system(cmd)))
> +		goto close_clean;
> +
> +	err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
> +	if (CHECK(err, "run_measured_process", "err = %d\n", err))
> +		goto close_clean;
> +
> +	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
> +	      "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
> +
> +	CHECK(skel->bss->ima_hash == 0, "ima_hash",
> +	      "ima_hash = %lu\n", skel->bss->ima_hash);
> +
> +close_clean:
> +	snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
> +	CHECK_FAIL(system(cmd));
> +close_prog:
> +	ima__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
> new file mode 100644
> index 000000000000..86b21aff4bc5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ima.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +long ima_hash_ret = -1;
> +u64 ima_hash = 0;
> +u32 monitored_pid = 0;
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("lsm.s/bprm_committed_creds")
> +int BPF_PROG(ima, struct linux_binprm *bprm)
> +{
> +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (pid == monitored_pid)
> +		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
> +						  &ima_hash, sizeof(ima_hash));
> +
> +	return 0;
> +}


