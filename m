Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16132B55D3
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgKQAnq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 19:43:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4734 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730583AbgKQAnp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 19:43:45 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH0hSqq032321;
        Mon, 16 Nov 2020 16:43:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=S00pb+GeQU1Zfd1U4XC+4/fXk0CPOz08L1s0Vb5ICjQ=;
 b=VnSlpwZl1GPM4Be+TnhnVRkoRH7EoEGiUDokhsU1tURZwfIHQVy2dFy6rBXWFDA1rEzy
 McWUaBiemZW4qmutdLIx5bHV6rMa1UfqZC224gZYWVydWusyvzEctUPYFuplD1mWpqkL
 WxUmdGVUCo3A7WHB9F0Plu1z6CkhZGbv+wk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34uwyg27cf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 16:43:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 16:43:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blzg/DETaosO0D2IVVxTLgl6ukHOgVe9lwrO6arQ09++EMGT4YiReT1Qet36OJrV2Lmuu0/GMIxmIgwtXb2+o50HIFpGXufFV7skCL7LjtqGY2laxT1/+2g/E8Rukxodw4snLlZoyYcY4WnyPJRqT/qxQePIKWQ4xHnNhxrW0FsdW7cpcVHR92qz6U3U3oozFHnrsm8TWBEzhIc/Xy3PzS0s56JniJyLwQHmz2D68DAe/F6tAPkAz8CMKu1L4I7RCz0Is8BQlvhjotU87zLsmvFn4/ozn4VcbDhJ3O3QnUgJ0DKWaRaxhlBxlvDYt9ZhTkrXbYrOeNaOGFv9CVuiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S00pb+GeQU1Zfd1U4XC+4/fXk0CPOz08L1s0Vb5ICjQ=;
 b=c0399vLEqGEWz7QP7xi68zSP88kcbpgNZ4DCVU3TeQo2FYR3/uBupvSLl3ivSsM/W+umM1Hp7KsnNHqEmqKdNd/OZBtnCYFF7E1IXUgw8TKJcu8yBjrzlq8uPG19aYOJ4TlDCP3QQpqnA1KKMQyGuF8NpaGk3Z5zGWpM1mM6sISV+Ex30HuEOU5sU6nyo8bMWFFGOkb5W3uz1D6zPU+Z2pmrJTJzcwYpvpRlJLjTJ2ToEzstaZi+d1PHIn12mB8HrP+FKV+UQltqxUmf57xaa5+8cRNoq41njxUJ/GxItGb0Ou5x/LpBgXiiBo3ohd33vmhEGjNqZcYzhciDHRHCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S00pb+GeQU1Zfd1U4XC+4/fXk0CPOz08L1s0Vb5ICjQ=;
 b=cYXEQh3CVK+iYu5cZdGy4Aw8zpp4pOuTUbQZFpY80u/JGXfc5iRyHBrlLiTjLgj4X/AECh+RaRAd1TM4i25J/GdK/ujET/JMthVJ1xapLcgqVBcwQkQGeENOEqkH/Qzajqnx/a6z5GTcOnXp+7ZezNuBnrP62p5bZJE3qlVWCMc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2373.namprd15.prod.outlook.com (2603:10b6:a02:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Tue, 17 Nov
 2020 00:43:09 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 00:43:09 +0000
Date:   Mon, 16 Nov 2020 16:43:03 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
Message-ID: <20201117004303.zpzoqluhslwbp7ce@kafai-mbp.dhcp.thefacebook.com>
References: <20201116232536.1752908-1-kpsingh@chromium.org>
 <20201116232536.1752908-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116232536.1752908-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:8f7f]
X-ClientProxiedBy: MWHPR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:300:94::31) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:8f7f) by MWHPR19CA0069.namprd19.prod.outlook.com (2603:10b6:300:94::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Tue, 17 Nov 2020 00:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4177c7c8-71fd-42b3-7816-08d88a91c191
X-MS-TrafficTypeDiagnostic: BYAPR15MB2373:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23736B1AF4D3C658154D34A0D5E20@BYAPR15MB2373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFVT64jIlcwObSbDf0il/rnBr0cMx2lRPU5Q7sJ9vJxN+qM+ozc5SBs2Wfmm9Zrn0hoOCAwqHz/51ocz3146+VM5DexIT4wW26P8LdJkzSTHplmQN6mxHJkC0KrfR6x0bfuxgkOqk9Oy5rpQgQpO5EbJ31WYztM67uCY18kaynyYOK4os0ZnBzgnn5aR6zptALVBXpSXUhgvJI2pMRUJ8RhNWwtJ2VQat879MeCRTYHigH5JeNhdmtLmMUlU8OmrXfL5qbF7WAfOlvb6yrm5jCr8qInxpvK+MPdhlnVveB4eY8GXEZPpAf+G+8d3SH/rGCYrGBMAWutWcF2ZVwuoaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(478600001)(55016002)(54906003)(86362001)(8676002)(9686003)(83380400001)(2906002)(6506007)(6666004)(1076003)(16526019)(66476007)(7696005)(66556008)(5660300002)(66946007)(6916009)(186003)(52116002)(8936002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: W5G5T7yDTWoHJdRN2bfsX5ZYWpzp3fV7S7rRv6X8JA/AzfXtI178Zeq1FT7w+ekgycc9fZXgaCVd46YDK3cRm5MPBHOGlM6iTvyc3pJuye/TWw8lRuawz+Ufly0axWaIKNOfYVlHxmtOj197vBq2oeQiny0Q+GJ9EYT/L1kWeeFc4p+8fGxaZuhQIZrVZm5Futw2r+VKGsXyBsLUUpr6gbztgXA2KqY1ox67Uw3JtTPHzNmxsf6UuAK+T+qy3oMNf4NMERJc0njZOSsSMV0uTdZ+qftEh75ZUGe75D035Jpzu9juE4FwNbds/rcROt33nsYkMKDwbKSiOpvxwqzg+2lSYhfiVLOXlR1yI6HiJCsfIe4U8cCIqwcG5Yxzj4r+o5DvGBTUhQK3c7rDhim8/EG8JWYylfEVQE1aWPhE3tVj6LtJGIxVJTAZvkPC5mBas3gCS1N+Ip3XO2w73FBPxF/pGCXI3UirVzR9z2Py/ncM6S7UshmjKttxjSNkuk8bDDthKjE1tg42CpVC6DIfGu+IHsL8hjG6ZSrqElgGnwTMHskBai1NBNLCcu5V4QiNRn3uS4qJItXHJer/TfdSoexcQO8THmW4TY+l9R6PBTiYcsUtdgLmEDnI9is6/GpwW17kYJxNr//StjSoAzibtKt8zZODE0M1YCGNl6aGljrAMYWPedFF722qjwn1pjszsAbbqxWyxULmZHAJlbuFK97P//p2msB+0+s3AbWrM+ASmfjnUvzLia78qc5N7+VOUCzQRNbF2ie4hVObn6hS4IapDZSLkSwM5jVqCSq+TmaxZZyF0chOIjtTxfmbMjx4glqfkkqPGOLNF9C6DvCHmNEolUjQSKs2h7r5nQrHp9Ak7IjGyGSMCVgGKRRSCvDwEbgQUvZzCTJntT+5qecLP3DPglgKpf0+6MabvfFxf3M=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4177c7c8-71fd-42b3-7816-08d88a91c191
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 00:43:09.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4S+u1Uh4UI7bKsJqdWKD1cg3JWVR54FIO3JZ/GZU2GUY9qcib+E3RXbBeCLGSvW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_13:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 11:25:36PM +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test forks a child process, updates the local storage to set/unset
> the securexec bit.
> 
> The BPF program in the test attaches to bprm_creds_for_exec which checks
> the local storage of the current task to set the secureexec bit on the
> binary parameters (bprm).
> 
> The child then execs a bash command with the environment variable
> TMPDIR set in the envp.  The bash command returns a different exit code
> based on its observed value of the TMPDIR variable.
> 
> Since TMPDIR is one of the variables that is ignored by the dynamic
> loader when the secureexec bit is set, one should expect the
> child execution to not see this value when the secureexec bit is set.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  .../selftests/bpf/prog_tests/test_bprm_opts.c | 124 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bprm_opts.c |  34 +++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bprm_opts.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
> new file mode 100644
> index 000000000000..cba1ef3dc8b4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <asm-generic/errno-base.h>
> +#include <sys/stat.h>
Is it needed?

> +#include <test_progs.h>
> +#include <linux/limits.h>
> +
> +#include "bprm_opts.skel.h"
> +#include "network_helpers.h"
> +
> +#ifndef __NR_pidfd_open
> +#define __NR_pidfd_open 434
> +#endif
> +
> +static const char * const bash_envp[] = { "TMPDIR=shouldnotbeset", NULL };
> +
> +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +static int update_storage(int map_fd, int secureexec)
> +{
> +	int task_fd, ret = 0;
> +
> +	task_fd = sys_pidfd_open(getpid(), 0);
> +	if (task_fd < 0)
> +		return errno;
> +
> +	ret = bpf_map_update_elem(map_fd, &task_fd, &secureexec, BPF_NOEXIST);
> +	if (ret)
> +		ret = errno;
> +
> +	close(task_fd);
> +	return ret;
> +}
> +
> +static int run_set_secureexec(int map_fd, int secureexec)
> +{
> +
> +	int child_pid, child_status, ret, null_fd;
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		null_fd = open("/dev/null", O_WRONLY);
> +		if (null_fd == -1)
> +			exit(errno);
> +		dup2(null_fd, STDOUT_FILENO);
> +		dup2(null_fd, STDERR_FILENO);
> +		close(null_fd);
> +
> +		/* Ensure that all executions from hereon are
> +		 * secure by setting a local storage which is read by
> +		 * the bprm_creds_for_exec hook and sets bprm->secureexec.
> +		 */
> +		ret = update_storage(map_fd, secureexec);
> +		if (ret)
> +			exit(ret);
> +
> +		/* If the binary is executed with securexec=1, the dynamic
> +		 * loader ingores and unsets certain variables like LD_PRELOAD,
> +		 * TMPDIR etc. TMPDIR is used here to simplify the example, as
> +		 * LD_PRELOAD requires a real .so file.
> +		 *
> +		 * If the value of TMPDIR is set, the bash command returns 10
> +		 * and if the value is unset, it returns 20.
> +		 */
> +		ret = execle("/bin/bash", "bash", "-c",
> +			     "[[ -z \"${TMPDIR}\" ]] || exit 10 && exit 20",
> +			     NULL, bash_envp);
> +		if (ret)
It should never reach here?  May be just exit() unconditionally
instead of having a chance to fall-through and then return -EINVAL.

> +			exit(errno);
> +	} else if (child_pid > 0) {
> +		waitpid(child_pid, &child_status, 0);
> +		ret = WEXITSTATUS(child_status);
> +
> +		/* If a secureexec occured, the exit status should be 20.
> +		 */
> +		if (secureexec && ret == 20)
> +			return 0;
> +
> +		/* If normal execution happened the exit code should be 10.
> +		 */
> +		if (!secureexec && ret == 10)
> +			return 0;
> +
> +		return ret;
Any chance that ret may be 0?

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +void test_test_bprm_opts(void)
> +{
> +	int err, duration = 0;
> +	struct bprm_opts *skel = NULL;
> +
> +	skel = bprm_opts__open_and_load();
> +	if (CHECK(!skel, "skel_load", "skeleton failed\n"))
> +		goto close_prog;
> +
> +	err = bprm_opts__attach(skel);
> +	if (CHECK(err, "attach", "attach failed: %d\n", err))
> +		goto close_prog;
> +
> +	/* Run the test with the secureexec bit unset */
> +	err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
> +				 0 /* secureexec */);
> +	if (CHECK(err, "run_set_secureexec:0", "err = %d", err))
nit. err = %d"\n"

> +		goto close_prog;
> +
> +	/* Run the test with the secureexec bit set */
> +	err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
> +				 1 /* secureexec */);
> +	if (CHECK(err, "run_set_secureexec:1", "err = %d", err))
Same here.

Others LGTM.
