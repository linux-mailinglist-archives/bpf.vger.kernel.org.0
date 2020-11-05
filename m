Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58D12A897F
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgKEWDY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:03:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20726 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731508AbgKEWDY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 17:03:24 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5LslTC019688;
        Thu, 5 Nov 2020 14:03:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=olpVCGm3cUUHACm1jRmiaM8LxETLXNZhxBUGW1fRhjM=;
 b=ddFACvBkI1rUe7TdpLoiIebCDs9WY61LCgmsQOM0CUDSu0LL6bQluO8ISardlB+AhL7k
 H3L+SjRyNUpB3kjHmcPNhCQzCQsOhQD5vg3glA5zgfCwnZTOew6jN5NPV5naSiHlPP1S
 vlktcq0wp2e+bFo2k7TJyNS1xff3HkpnQdU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5r5p812-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 14:03:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 14:03:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYr0UUqiv4MuGv7i2IQ1I/nrhCq0YGGegffzQLyKSjB2rclAIq+54as/K5NpK4HtHA1mV4cE7WCnLqMfTQlYIKVd3WmTEz2JOCtB7Ko6R0LNFWa/Qm3URHDGG8rXGyC0nYqoOf62VMxmZV6gGQoidyxz+qvyyoD/sabz31tod54EbYHEkwDDb1FfaPtMaJKMoENu6S3MOeRni01iTuhkrERp1at/HO7Wfp6P+x+jVAm7QocTpkjcBvPOl6gpqd7EmMNCZtQ6/RXV0V1DrYWyrr3vk6SI5YsWb913w+iAq3QbnX055+IVrmhe7EN3eCpzKJIVwwXMutSZX0K28EHsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olpVCGm3cUUHACm1jRmiaM8LxETLXNZhxBUGW1fRhjM=;
 b=Jkd51mcDnU3Hz8LnWJMb/j6X7oTiDu16K+l2nwUXKaacE3JqXOn+giW64nEXFIOZIuYxg3nZR3RUFg0OHerb0cl0bKTJJtXu4tgrlE4NO4ypMhawponhZBXoO4Udt3AjkjM1ZL4sPmscDHZcG5iaC3UcKG7l0YQhma1ovkJuSaq19RkFaGdaenTUBIRGKMWVNVht0r+RjNdYKUtW7s8xOoBEw/H/Oua+NK640pjaPrz8t1OunnGHYoedkza3DgQB/ShtZ1uOHONmqHoxjKT5DYvVqjKGF37g8fg8WMEUUYv1gb5ujAc8elaa01Nj+D4TQOaqFBwZ4BfJZJPIPDy6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olpVCGm3cUUHACm1jRmiaM8LxETLXNZhxBUGW1fRhjM=;
 b=gdQdonjl8IkXIzS6Ibu9nNaeudOt8s/jGKEuzbJgo5QvBWSk6E2Pl5IRxqR8oj4uc5G4f/FeCsbRKzU6pwL6YZOHizTM7OPg5VMAsuAj8pSkpjQIM9nneMzso/Mg1MiQiFeUw3jotwaUFpzOv5dH+wj8g9ABqb/tR2lDyHnbdXw=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3302.namprd15.prod.outlook.com (2603:10b6:a03:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 22:03:03 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 22:03:03 +0000
Date:   Thu, 5 Nov 2020 14:02:50 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 8/9] bpf: Add tests for task_local_storage
Message-ID: <20201105220250.uvm3unmbne36lsoz@kafai-mbp.dhcp.thefacebook.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-9-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-9-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:300:ed::34) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR20CA0048.namprd20.prod.outlook.com (2603:10b6:300:ed::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 22:03:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7497240e-fcfe-4604-3fd0-08d881d69116
X-MS-TrafficTypeDiagnostic: BYAPR15MB3302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB33022C35A9A4ACE643B5955CD5EE0@BYAPR15MB3302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8H8yIA1agSMS0VE6Jsp7+Qku+4UBOA0dwWNKMfx2qS/VzMIFuh0t1Bjnt7q/iTcWtMT8R9JXBwaE1iLfIZ0yiKYZrlpq4PZUkCF36iaQKkNOCm3Z3M1WSiFyl6M5uIaTBHLJZtX+363w9LnpZBohyrwx7mTZA4CJETzhrFL7IM0ZahwUBlbbXpYk+Ut0r+F7ork4m+0bBfXaCgr/ER8v2njWxoNjYviCPDTQ1xDF9EHrYWu/+7ioP5ZlLMR6euVRRYckb6mCzb9Vjbsto6btWnUnZ0RhUo0nhyKlLcxd1d2YhyBb3dmoJ8cwSvRNvpx/wAm2mC4R3o7upRdMQ1DU3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(9686003)(52116002)(54906003)(7696005)(55016002)(8676002)(2906002)(83380400001)(316002)(4326008)(6506007)(86362001)(66476007)(66946007)(1076003)(478600001)(5660300002)(8936002)(6666004)(186003)(16526019)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4uCrdaPpYqPDdV83BRaEN+3cOUpJzSToe9f5A0wLIq5PjZVVLZzsshRTBFl2tXFYWXJs9RPJC9tTs7yzcuPDH7N4qeM+AreWTY2PzsSXKC2xushBH/IOMenIOCwpsRibKAqc0pOXvrygTGGLLvYxIPT9FBMH3/jJbxFR8srBFiPpYrWOseCsTAk5aKanSLvkeA3vYgPWj6up1aCdooGM8hWsGaDyhnU6Sn3uFRTHHitDAoKtX0P2+QYT7Un4MbTxFA4zPRzaK2fy3Bg7auoyUPRK5JMVUnpgdyAk74EfwqDNPrOU9kazda05SAi1W0Y45jwnM4O0svvaklQJcilmZe48ORIBAMzg5mHW03wBax7rB0urYk4KaiBsBy3TAKV1G/T2Xq9Ohg5blu5WMtrs3MaH0/9fupGYDDIe363TVwYbzhlfFuKdHSQA0LT5SVmzVzHv1vyYbzMRTrC5WrIf7UkWWDu5FKhxUleSTJEDAM9alNFRfYSvVKVxP4/4aBKC4hCZtlAOzHMSQy9X4+L+I4gQHrlj7EYrJOt/HEjissBcOibYuDHrM5zo1VFbJwwihheCdIcCVDV0qe2C6HYx0jXEP87702R28Hwg4uLMI8NYu2BsPD9gXRqGFVaJP+Jj3N0gsITOhkZjtStiSvdzYAFw2sGL26mDgnhgm4uUVVyy7Pj5SZcct4gyspDB8gl6
X-MS-Exchange-CrossTenant-Network-Message-Id: 7497240e-fcfe-4604-3fd0-08d881d69116
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 22:03:03.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTkZN5mWdqcfHAivna3zocH843oG5PPUIUtzv+KgxRf+/0RblWrO3P7iQLJOydmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=1 clxscore=1015
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:54PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test exercises the syscall based map operations by creating a pidfd
> for the current process.
> 
> For verifying kernel / LSM functionality, the test implements a simple
> MAC policy which denies an executable from unlinking itself. The LSM
> program bprm_committed_creds sets a task_local_storage with a pointer to
> the inode. This is then used to detect if the task is trying to unlink
> itself in the inode_unlink LSM hook.
> 
> The test copies /bin/rm to /tmp and executes it in a child thread with
> the intention of deleting itself. A successful test should prevent the
> the running executable from deleting itself.
> 
> The bpf programs are also updated to call bpf_spin_{lock, unlock} to
> trigger the verfier checks for spin locks.
> 
> The temporary file is cleaned up later in the test.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  .../bpf/prog_tests/test_local_storage.c       | 167 ++++++++++++++++--
>  .../selftests/bpf/progs/local_storage.c       |  61 ++++++-
>  2 files changed, 210 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> index 91cd6f357246..feba23f8848b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> @@ -4,30 +4,149 @@
>   * Copyright (C) 2020 Google LLC.
>   */
>  
> +#define _GNU_SOURCE
> +
> +#include <asm-generic/errno-base.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
>  #include <test_progs.h>
>  #include <linux/limits.h>
>  
>  #include "local_storage.skel.h"
>  #include "network_helpers.h"
>  
> -int create_and_unlink_file(void)
> +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +unsigned int duration;
static

> +
> +#define TEST_STORAGE_VALUE 0xbeefdead
> +
> +struct storage {
> +	void *inode;
> +	unsigned int value;
> +	/* Lock ensures that spin locked versions of local stoage operations
> +	 * also work, most operations in this tests are still single threaded
> +	 */
> +	struct bpf_spin_lock lock;
> +};
> +
> +/* Copies an rm binary to a temp file. dest is a mkstemp template */
> +int copy_rm(char *dest)
static

>  {
> -	char fname[PATH_MAX] = "/tmp/fileXXXXXX";
> -	int fd;
> +	int ret, fd_in, fd_out;
> +	struct stat stat;
>  
> -	fd = mkstemp(fname);
> -	if (fd < 0)
> -		return fd;
> +	fd_in = open("/bin/rm", O_RDONLY);
> +	if (fd_in < 0)
> +		return fd_in;
>  
> -	close(fd);
> -	unlink(fname);
> +	fd_out = mkstemp(dest);
> +	if (fd_out < 0)
> +		return fd_out;
> +
> +	ret = fstat(fd_in, &stat);
> +	if (ret == -1)
> +		return errno;
> +
> +	ret = copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, 0);
> +	if (ret == -1)
> +		return errno;
> +
> +	/* Set executable permission on the copied file */
> +	ret = chmod(dest, 0100);
> +	if (ret == -1)
> +		return errno;
> +
> +	close(fd_in);
> +	close(fd_out);
fd_in and fd_out are not closed in error cases.

>  	return 0;
>  }
>  
> +/* Fork and exec the provided rm binary and return the exit code of the
> + * forked process and its pid.
> + */
> +int run_self_unlink(int *monitored_pid, const char *rm_path)
static

[ ... ]

> +bool check_syscall_operations(int map_fd, int obj_fd)
static

[ ... ]

>  void test_test_local_storage(void)
>  {
> +	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
> +	int err, serv_sk = -1, task_fd = -1;
>  	struct local_storage *skel = NULL;
> -	int err, duration = 0, serv_sk = -1;
>  
>  	skel = local_storage__open_and_load();
>  	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> @@ -37,10 +156,35 @@ void test_test_local_storage(void)
>  	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
>  		goto close_prog;
>  
> +	task_fd = sys_pidfd_open(getpid(), 0);
> +	if (CHECK(task_fd < 0, "pidfd_open",
> +		  "failed to get pidfd err:%d, errno:%d", task_fd, errno))
> +		goto close_prog;
> +
> +	if (!check_syscall_operations(bpf_map__fd(skel->maps.task_storage_map),
> +				      task_fd))
> +		goto close_prog;
> +
> +	err = copy_rm(tmp_exec_path);
> +	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
> +		goto close_prog;
> +
> +	/* Sets skel->bss->monitored_pid to the pid of the forked child
> +	 * forks a child process that executes tmp_exec_path and tries to
> +	 * unlink its executable. This operation should be denied by the loaded
> +	 * LSM program.
> +	 */
> +	err = run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path);
> +	if (CHECK(err != EPERM, "run_self_unlink", "err %d want EPERM\n", err))
> +		goto close_prog;
> +
> +	/* Set the process being monitored to be the current process */
>  	skel->bss->monitored_pid = getpid();
>  
> -	err = create_and_unlink_file();
> -	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> +	/* Remove the temporary created executable */
> +	err = unlink(tmp_exec_path);
Will tmp_exec_path file be removed if there is error earlier?

> +	if (CHECK(err != 0, "unlink", "unable to unlink %s: %d", tmp_exec_path,
> +		  errno))
>  		goto close_prog;
>  
>  	CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
> @@ -56,5 +200,6 @@ void test_test_local_storage(void)
>  	close(serv_sk);
>  
>  close_prog:
> +	close(task_fd);
>  	local_storage__destroy(skel);
>  }
