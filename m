Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72D318FE6C
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCWUFP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 16:05:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgCWUFP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 16:05:15 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NJwxYO002281;
        Mon, 23 Mar 2020 13:04:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zDQUiYqUEtVaSlwnu3iviqepgVeIuWn7rbrHs9xhwm0=;
 b=C7ikbZyyM2fas6YFpNLMUXshyXDMYiH0L7/1sC3k2HixXLp2ZcIvbTMa4JYuyJx1o99/
 BRlG7b0EMT7S/VkEYeWAy6ap+E8bhk0K+j25mlSwReAFYXa8iwyxAeSCLCgx1TvV5WaQ
 +VsdCHEZn92yE6r4TFRIM78y4JFjLsyt0nA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xy703c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 13:04:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 13:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNRk4ZWBdgCWUU4ZDh0vR7V0WbmprJxl+zbyjVITVv5OmBV1i/ueeREZLYjeC3gT04ImErtFoUjlr9LUp00AYAH0RLyg3p6BVuoZBuJ810Y1/J5gOYKRZHHjedFZ+vPaiFSIxsQIaSX7i3n0Zf+aNftkhlTR6byhUJt2g2sR/pcNjahRvNP/vLNB0qoDCrcD23+l+FwLk/nv8z01yyrraXj9qpenyWUUt8xgR+FMWo0LzelpSJFGg2vnecTQLUAjNcNkUBumsiGknq1HTdhVsetJC2AHUTgDpRkC2VIDvED9Pe7fGbtjLyshl1jSRhe8QnxMDR929KNulLXOeN0xQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDQUiYqUEtVaSlwnu3iviqepgVeIuWn7rbrHs9xhwm0=;
 b=GOD582jcMIByuRPX6xIacu00sQ1IJf7d8ZzPxl4U5UOkbwiL5Jbf6Qh9a68cCeQ4CuEw9KMZFRzO26M2BG6W9gp9+YeQxV87A4ToP457koxNXClBvc+SnyH32ocfONbrtAVylU9Qh+Sn1zJlth4iT6iw22k7j1UJ1to5z7nOFy8ogMZKQ1sGVAdsRHBkyM8U3ToZNsUYNJWpiF2vZkQnFz5/MOo8QyCF9ziIcoH8kueg2fy7pcTfeFq6wbCeBocolwMGaA6+nw9GEYS0vmsQBE5pPdZNqr5qbPu/dQSSWKXA0aRKE8/UQArUCT39uAn+ntEAx1A2TUD6qnC30XHK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDQUiYqUEtVaSlwnu3iviqepgVeIuWn7rbrHs9xhwm0=;
 b=O29kZKxA7zBNjhWg8fhmvmeSDKRAZyxm030nNtYgCRdINfAKmjPshCDKOFpGWFFL0l6C0L29wGE/OqMKPdfLJJodJrtkPiJur5uznnBTLK6NShL4v5eed9SlvE9kIEspGKYTCBSz9HrBs3Iav7ZIxNG6zuk9quhUw/fYp1iw0qI=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB4010.namprd15.prod.outlook.com (2603:10b6:303:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 20:04:51 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 20:04:51 +0000
Subject: Re: [PATCH bpf-next v5 7/7] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-8-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a071b4ce-9311-5d44-4144-56075a8aa812@fb.com>
Date:   Mon, 23 Mar 2020 13:04:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200323164415.12943-8-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23)
 To MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:2131) by MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 20:04:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:2131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7cce3f-260e-4964-1393-08d7cf657278
X-MS-TrafficTypeDiagnostic: MW3PR15MB4010:
X-Microsoft-Antispam-PRVS: <MW3PR15MB4010B2E2468700B3086D5D01D3F00@MW3PR15MB4010.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(66946007)(66556008)(81166006)(66476007)(8676002)(81156014)(4326008)(2906002)(316002)(52116002)(2616005)(478600001)(31686004)(53546011)(5660300002)(36756003)(16526019)(6506007)(186003)(6486002)(31696002)(86362001)(54906003)(7416002)(6512007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB4010;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5203wnVLbTiXHxhozID1umU6/CYKnhhHoNbsrr7Pkxl79CxF9GVFLKgBpHaxLY9Wondwv7li8vDvdMVTE3WehEyqFI6zSmzEwr534wDzSl0TCYokFeRKUKewY6Bb77sCHz09lbKhZ51G8BBTBQn33eb9WD0H+DYGwbqA8RI5geKfvf1PaZ5lySwJU5pGrqUgGBxI7icOIW43ydPVBo9g7M2pW33Nm5QYnIxEO5+snVz6yssIk//Po57gn91YDP97kPk4DEOl8i0RA/YS0KoihTnjskM5nRp5IPhcB6RsMTnqgHBl1Sv9WTGPVwTQKBqFyqlEfURSYFhkrlFtLMMREXlvl//LFCWZDAV/hrUdEgaRc4ZDv0q+MiKjWBRTkOV6T3c1tRxlV62xUhi4VPhZBHbYZZ7QAXdE/cEDtqG5GEracshfk9YJJuVIK64EIeiI
X-MS-Exchange-AntiSpam-MessageData: KTrFDw8tJaqkdwcXBCYn4FhzXxIbiVAG5vqaRCCJ0o1zFk1WJdY5nu4r44blIAxPbSF4ge/6wPd14uKWArLjnkegJR2ZtBZgx96UoiM1mjVq1SRSkUoycSV1lKPTg9mEZhH+Xv0FF1AADZKZVX4To04hQ/WEVWiFIo23m/rZ0iO0F80W2ETfjUy0uHUv8TQL
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7cce3f-260e-4964-1393-08d7cf657278
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 20:04:51.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49nvkkZ91fbpdA3HoaxjshLo8mXB6uUtJ1xKOA4NXgt3aTXiFlV2s/je73r/lkHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4010
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_08:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230099
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/23/20 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> * Load/attach a BPF program to the file_mprotect (int) and
>    bprm_committed_creds (void) LSM hooks.
> * Perform an action that triggers the hook.
> * Verify if the audit event was received using a shared global
>    result variable.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---
>   tools/testing/selftests/bpf/lsm_helpers.h     |  19 +++
>   .../selftests/bpf/prog_tests/lsm_test.c       | 112 ++++++++++++++++++
>   .../selftests/bpf/progs/lsm_int_hook.c        |  54 +++++++++
>   .../selftests/bpf/progs/lsm_void_hook.c       |  41 +++++++
>   4 files changed, 226 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lsm_int_hook.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lsm_void_hook.c
> 
> diff --git a/tools/testing/selftests/bpf/lsm_helpers.h b/tools/testing/selftests/bpf/lsm_helpers.h
> new file mode 100644
> index 000000000000..3de230df93db
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/lsm_helpers.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#ifndef _LSM_HELPERS_H
> +#define _LSM_HELPERS_H
> +
> +struct lsm_prog_result {
> +	/* This ensures that the LSM Hook only monitors the PID requested
> +	 * by the loader
> +	 */
> +	__u32 monitored_pid;
> +	/* The number of calls to the prog for the monitored PID.
> +	 */
> +	__u32 count;
> +};
> +
> +#endif /* _LSM_HELPERS_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_test.c b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> new file mode 100644
> index 000000000000..5fd6b8f569f7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <malloc.h>
> +#include <stdlib.h>
> +
> +#include "lsm_helpers.h"
> +#include "lsm_void_hook.skel.h"
> +#include "lsm_int_hook.skel.h"
> +
> +char *LS_ARGS[] = {"true", NULL};
> +
> +int heap_mprotect(void)
> +{
> +	void *buf;
> +	long sz;
> +
> +	sz = sysconf(_SC_PAGESIZE);
> +	if (sz < 0)
> +		return sz;
> +
> +	buf = memalign(sz, 2 * sz);
> +	if (buf == NULL)
> +		return -ENOMEM;
> +
> +	return mprotect(buf, sz, PROT_READ | PROT_EXEC);

"buf" is leaking memory here.

> +}
> +
> +int exec_ls(struct lsm_prog_result *result)
> +{
> +	int child_pid;
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		result->monitored_pid = getpid();
> +		execvp(LS_ARGS[0], LS_ARGS);
> +		return -EINVAL;
> +	} else if (child_pid > 0)
> +		return wait(NULL);
> +
> +	return -EINVAL;
> +}
> +
> +void test_lsm_void_hook(void)
> +{
> +	struct lsm_prog_result *result;
> +	struct lsm_void_hook *skel = NULL;
> +	int err, duration = 0;
> +
> +	skel = lsm_void_hook__open_and_load();
> +	if (CHECK(!skel, "skel_load", "lsm_void_hook skeleton failed\n"))
> +		goto close_prog;
> +
> +	err = lsm_void_hook__attach(skel);
> +	if (CHECK(err, "attach", "lsm_void_hook attach failed: %d\n", err))
> +		goto close_prog;
> +
> +	result = &skel->bss->result;
> +
> +	err = exec_ls(result);
> +	if (CHECK(err < 0, "exec_ls", "err %d errno %d\n", err, errno))
> +		goto close_prog;
> +
> +	if (CHECK(result->count != 1, "count", "count = %d", result->count))
> +		goto close_prog;
> +
> +	CHECK_FAIL(result->count != 1);

I think the above
	if (CHECK(result->count != 1, "count", "count = %d", result->count))
		goto close_prog;

	CHECK_FAIL(result->count != 1);
can be replaced with
	CHECK(result->count != 1, "count", "count = %d", result->count);

> +
> +close_prog:
> +	lsm_void_hook__destroy(skel);
> +}
> +
> +void test_lsm_int_hook(void)
> +{
> +	struct lsm_prog_result *result;
> +	struct lsm_int_hook *skel = NULL;
> +	int err, duration = 0;
> +
> +	skel = lsm_int_hook__open_and_load();
> +	if (CHECK(!skel, "skel_load", "lsm_int_hook skeleton failed\n"))
> +		goto close_prog;
> +
> +	err = lsm_int_hook__attach(skel);
> +	if (CHECK(err, "attach", "lsm_int_hook attach failed: %d\n", err))
> +		goto close_prog;
> +
> +	result = &skel->bss->result;
> +	result->monitored_pid = getpid();
> +
> +	err = heap_mprotect();
> +	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> +		  errno))
> +		goto close_prog;
> +
> +	CHECK_FAIL(result->count != 1);
> +
> +close_prog:
> +	lsm_int_hook__destroy(skel);
> +}
> +
> +void test_lsm_test(void)
> +{
> +	test_lsm_void_hook();
> +	test_lsm_int_hook();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/lsm_int_hook.c b/tools/testing/selftests/bpf/progs/lsm_int_hook.c
> new file mode 100644
> index 000000000000..1c5028ddca61
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_int_hook.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include  <errno.h>
> +#include "lsm_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct lsm_prog_result result = {
> +	.monitored_pid = 0,
> +	.count = 0,
> +};
> +
> +/*
> + * Define some of the structs used in the BPF program.
> + * Only the field names and their sizes need to be the
> + * same as the kernel type, the order is irrelevant.
> + */
> +struct mm_struct {
> +	unsigned long start_brk, brk;
> +} __attribute__((preserve_access_index));
> +
> +struct vm_area_struct {
> +	unsigned long vm_start, vm_end;
> +	struct mm_struct *vm_mm;
> +} __attribute__((preserve_access_index));
> +
> +SEC("lsm/file_mprotect")
> +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> +	     unsigned long reqprot, unsigned long prot, int ret)
> +{
> +	if (ret != 0)
> +		return ret;
> +
> +	__u32 pid = bpf_get_current_pid_tgid();

In user space, we assign monitored_pid with getpid()
which is the process pid. Here
    pid = bpf_get_current_pid_tgid()
actually got tid in the kernel.

Although it does not matter in this particular example,
maybe still use
    bpf_get_current_pid_tgid() >> 32
to get process pid to be consistent.

The same for lsm_void_hook.c.

> +	int is_heap = 0;
> +
> +	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> +		   vma->vm_end <= vma->vm_mm->brk);
> +
> +	if (is_heap && result.monitored_pid == pid) {
> +		result.count++;
> +		ret = -EPERM;
> +	}
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/lsm_void_hook.c b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> new file mode 100644
> index 000000000000..4d01a8536413
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include  <errno.h>
> +#include "lsm_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct lsm_prog_result result = {
> +	.monitored_pid = 0,
> +	.count = 0,
> +};
> +
> +/*
> + * Define some of the structs used in the BPF program.
> + * Only the field names and their sizes need to be the
> + * same as the kernel type, the order is irrelevant.
> + */
> +struct linux_binprm {
> +	const char *filename;
> +} __attribute__((preserve_access_index));
> +
> +SEC("lsm/bprm_committed_creds")
> +int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
> +{
> +	__u32 pid = bpf_get_current_pid_tgid();
> +	char fmt[] = "lsm(bprm_committed_creds): process executed %s\n";
> +
> +	bpf_trace_printk(fmt, sizeof(fmt), bprm->filename);
> +	if (result.monitored_pid == pid)
> +		result.count++;
> +
> +	return 0;
> +}
> 

Could you also upddate tools/testing/selftests/bpf/config file
so people will know what config options are needed to run the
self tests properly?
