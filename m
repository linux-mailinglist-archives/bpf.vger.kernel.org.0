Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB92C4EB0
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 07:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgKZG2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 01:28:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgKZG2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Nov 2020 01:28:13 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AQ6P1EQ031211;
        Wed, 25 Nov 2020 22:27:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M0NxOMyqQo0pbR7iOlJS2fCaYg4sHkpVqm/3IFPjvqs=;
 b=GNnQuff43ZuVsjYbduG7MTXVFX5NBGuY23I6z1Jm0qyXxAisSsbGiiu8btmghYcqXH1g
 tRz5L/UVZ+YAzAfFPfdE07Atn4YQ6so806fNB+fRHnY1BUn9rz/i4tKIWJvLQRDWX9K6
 agq3nz8ziHFKdZfCAvGv+HcsKdsJgBzVk34= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 351aqe6xqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 22:27:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 22:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZxmHgNYmP/9cp+YYjHT3PAZJ4v+0Dcmj/lHiavv25B8v7gEb1K02qHINxNeIUhyQufi16fD4cdznphUnPOua4LRaSH5rR43PKDc8w+KBQ9cGQiS8K1UDxpAHzQxG0W8nI0zj6Sn2MOmJKjOnUO75q8hw0HeqnC8av7Bmm5qG7kyeJdLG2ooF4vJi2TFeQIrsajKUWUchC3xnk/g0S3uigNWoEVRSX/HZoWv4vZf1yq3nH8Pa3h1CcdVscKQ1QPTaueqVgbDafU/leKOUV3I6uOkANOr+oKSp4ateaj3CP54arrf6eYN9VDDkshF3///SWeYulaZQ/raqDefWGlPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0NxOMyqQo0pbR7iOlJS2fCaYg4sHkpVqm/3IFPjvqs=;
 b=dFRN1QyQasCH1yHbBVRK2uvIew/5S0AOpaQF4EP+qUixazeHQ7aV8HQs6yLB0URbJL88njKjBMIAu1VgLVwr2AjFZceuJl8KrCTBPGUjoIzc6CGjjjCnCIwVbUxHAnaNFJSVfVtLSOzid/30IuPJoTxPlj0x2TscOkX5cO0hS6h0+lHhdA4R0K+FqOMuzHgadRwG9GGhhJxDWoKhIkCfFKfiYihpQmXFJVAAlbj5OROWUci1fiQR7SZLkoy4NrZmHwmbS4Hyxl6r2klQntGpqqXdx5QfJ04oHrdwuGK+7tDnPa/dAbmrQBDGrLQHf65zl5hckHxPxywjIpdzOuyuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0NxOMyqQo0pbR7iOlJS2fCaYg4sHkpVqm/3IFPjvqs=;
 b=IcbG/Gd05LJdAtNkt/lmqgHWKLeaMHT/TE4Rm1wEl/W4bE0cfz+WcSbLl5RgnptPV/YR68s2+mHsJ2b6yOnVa7BT0qky555IGTx6YLnZ6Xqc+H25lZJQ3hgU9I7j7c6FW6XwfIb+xEF0OAoWe2s6LT4QOQkLHFlmnBRT/uY3GlM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 26 Nov
 2020 06:27:51 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Thu, 26 Nov 2020
 06:27:50 +0000
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for
 bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a5c2244f-c733-ef78-7347-ac0a2a6bb77f@fb.com>
Date:   Wed, 25 Nov 2020 22:27:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201124151210.1081188-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e5cb]
X-ClientProxiedBy: MWHPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:300:c0::31) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1145] (2620:10d:c090:400::5:e5cb) by MWHPR08CA0057.namprd08.prod.outlook.com (2603:10b6:300:c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 06:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f4e521-3233-4e10-e82b-08d891d46613
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4204:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4204BF5787D4614FA8FC9B2AD3F90@SJ0PR15MB4204.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8KBSiptM9xERKs8y47Gq1lFLbxVseEYKZJReAJ9pcpLgwX9+xEaLHdjQmCm3A9Eh5Qknw22pNESFSYGUT/r6QDo2RfyGSePfeHWnmhtVlxZL/xDz37FdkHBLmd1IE9E5kAlIxYmnkEErT7ZIDfuLwITyA+wUIONqkhLlt7qe3OKNzF74QPjEeF5JvxaGa4qdiIKkH29NOCB+D5U0j8SMcA8onc6SXDxUkCjD2GIfCeW+lPy8wUERp3eekKK13V+rQJ4tmBfbUFN+a3AQvbGg1uAYgE8XMUULz2kQ18fZD2Tl1lmEvEr9TJuz+BnKtyiB+sbyTnYSpjfjrRjkUz0RtCDnhIMceRnLtjdmavbiLmxDGXU9YOghOybNkCRepbG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(346002)(396003)(2616005)(52116002)(6486002)(53546011)(54906003)(16526019)(478600001)(66946007)(8676002)(186003)(110136005)(66556008)(66476007)(316002)(31696002)(36756003)(8936002)(5660300002)(83380400001)(86362001)(4326008)(2906002)(31686004)(7416002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VkZRWE5vNTNLYnBDNWliUjVOSHdXWVZZMzh2dFdIOU4rNVQwWEhCMXFMT3px?=
 =?utf-8?B?Sk9vakdFc1A5RFE3ZkhTYVMwSVVKOUQrMlFkYlpYUmlRaWt0b0Z5VTR4WjN4?=
 =?utf-8?B?cVpXNW1HU1BaRXpMT1lYZHRBRVlmMWtLSmV1OHZmdWxjVERuZktkaTBWRDNp?=
 =?utf-8?B?MmkxWk9BZDhPUXlyUkhKNGpJQVFtT1VYcEVLMWlSMlJzWjg4L0V1QkliYmYy?=
 =?utf-8?B?MnErL0l0OGVFQnNaS203RUJrN1pGY2pQT25aaVpVNkJ2SW9PUDAvY1Ewd0JM?=
 =?utf-8?B?anNXTzRZTGtvSnU2OTZmVURtOXdSQ1lUT3dBKzJyd1ljZHBOWEExNS9hUEVh?=
 =?utf-8?B?ajZqdFVqa0wyaHNCUDBFRzVlTWlwR1hlclR6aDFnM0VBdi83NmtIYW4zQ215?=
 =?utf-8?B?SzJWUVpSY2hvQWZaYUZ0WHdoNjZyRjVaZkVTUWxFQjlrMDhHRjF3WGhSU09S?=
 =?utf-8?B?Z3B4Sng3S0lYdytoRTZVdHQ4VmRvSllUSEhUUDVnM3M4M1ZHM3VMWVBpT2ll?=
 =?utf-8?B?ZDE2TFRqSnoxZ2lNSm84cVY0ZmNBUmNtMHllNGxQTUVtSjA5aDQ4UW1WUGJO?=
 =?utf-8?B?Y3YyYmJaRXZlYSt6TGdKeXlKS1VhUWhqdzVLeE5zWEJqbVhSVW5VeFdGUnNt?=
 =?utf-8?B?R2RweDYxUk5LZU1RL080Um5qL2hxK3kyZkhRNVFaZEFENnpKV0gxNVpXd2J5?=
 =?utf-8?B?aStSN0dlYXJEMnRmdEVkYzdEeGx1b2hySG5WK1pBYVRUTlI5eGhiWXRLelYx?=
 =?utf-8?B?Qi9Pc214aHY1VUpCR1VKRXlMaVV4aVFOS3VjaTJmQmpXSW5Ra0NpK29pY1VD?=
 =?utf-8?B?Tk1vNGt4RDZjeFhudGkyQXUvcy9neHBnYUdTaG1nTDRJK252bE1LTERMYXAr?=
 =?utf-8?B?TS9kRTBTVGpWNCtUQUsrZDVZbjJWYzZVSTJYNHYvbHlrcXRSZzd0REg5bWR0?=
 =?utf-8?B?Z1dKaENwTUtNRWszaWJiTnpWT1ROdy9yaTRINEZCODNSVnZjRGZJeUJBYU5G?=
 =?utf-8?B?UWdZbkp3QmFYZVFpTWwwc0t3R1JDaEsra0lmRFNwWEMwNkx6eHIxbktwcytR?=
 =?utf-8?B?azFVcHM4cUNEM3M2THVEaWFnTHcvUlpKbDNmMW01TFR3YmJaRkcxYXgxSmM4?=
 =?utf-8?B?andCZUdGK0NzVVlFWUd1MkJYbkRPQXJOOWlGaGcvL05Pek9TMk1HQmxMMSt0?=
 =?utf-8?B?bStwaDhOb1MrNnJRQ0ZLR2ovYmdVMWhnUE1nQWVBcWVEdDUvWG4zQ0s3RE05?=
 =?utf-8?B?SWFQOXVDeWNQTldHWHFYaVNOZWVmRDBtK1ZTSTJIYTc4ejA3ZGxCQWpMRi9B?=
 =?utf-8?B?Z2l0dkpqOE1pOTgwL0VZazQrZ09lOXBWM09xRzdYOFJpdXp5QXNIaVloVnAz?=
 =?utf-8?B?Z0FDeHJTcTNxUkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4e521-3233-4e10-e82b-08d891d46613
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 06:27:50.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5fVPn2mxhVPsuopjez+JwEHUNFuicNpzZrZFvkxFPzhLYPKmAMLpZSy3yOyiVFF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_01:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 7:12 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test does the following:
> 
> - Mounts a loopback filesystem and appends the IMA policy to measure
>    executions only on this file-system. Restricting the IMA policy to a
>    particular filesystem prevents a system-wide IMA policy change.
> - Executes an executable copied to this loopback filesystem.
> - Calls the bpf_ima_inode_hash in the bprm_committed_creds hook and
>    checks if the call succeeded and checks if a hash was calculated.
> 
> The test shells out to the added ima_setup.sh script as the setup is
> better handled in a shell script and is more complicated to do in the
> test program or even shelling out individual commands from C.
> 
> The list of required configs (i.e. IMA, SECURITYFS,
> IMA_{WRITE,READ}_POLICY) for running this test are also updated.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>   tools/testing/selftests/bpf/config            |  4 +
>   tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
>   .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
>   tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
>   create mode 100644 tools/testing/selftests/bpf/progs/ima.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 2118e23ac07a..365bf9771b07 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -39,3 +39,7 @@ CONFIG_BPF_JIT=y
>   CONFIG_BPF_LSM=y
>   CONFIG_SECURITY=y
>   CONFIG_LIRC=y
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

Running test_progs-no-alu32, the test failed as:

root@arch-fb-vm1:~/net-next/net-next/tools/testing/selftests/bpf 
./test_progs-no_alu32 -t test_ima 

sh: ./ima_setup.sh: No such file or directory 

sh: ./ima_setup.sh: No such file or directory 

test_test_ima:PASS:skel_load 0 nsec 

test_test_ima:PASS:attach 0 nsec 

test_test_ima:PASS:mkdtemp 0 nsec 

test_test_ima:FAIL:56 

test_test_ima:FAIL:71 

#114 test_ima:FAIL 

Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Although the file is indeed in this directory:
root@arch-fb-vm1:~/net-next/net-next/tools/testing/selftests/bpf ls 
ima_setup.sh
ima_setup.sh

I think the execution actually tries to get file from
no_alu32 directory to avoid reusing the same files in
.../testing/selftests/bpf for -mcpu=v3 purpose.

The following change, which copies ima_setup.sh to
no_alu32 directory, seems fixing the issue:

TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c 
     \
                          network_helpers.c testing_helpers.c            \
                          btf_helpers.c  flow_dissector_load.h
  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
+                      ima_setup.sh                                     \
                        $(wildcard progs/btf_dump_test_case_*.c)
  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
  TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)

Could you do a followup on this?

> +
> +	} else if (child_pid > 0) {
> +		waitpid(child_pid, &child_status, 0);
> +		return WEXITSTATUS(child_status);
> +	}
> +
> +	return -EINVAL;
> +}
> +
[...]
