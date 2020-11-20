Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A72BB230
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgKTSMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 13:12:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgKTSMQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Nov 2020 13:12:16 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIAUQ4014010;
        Fri, 20 Nov 2020 10:11:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YIfURhYkSQ4UO4oFQGpve4NgesaLM1X7nuM5FrfThP0=;
 b=PySwzJXu6sl8HZBcX8nZqzyUPl9KUXg/nPPqTFwJ06jsGz1xF37RiGnpEnf/4+S7eQ6P
 wd0AvuBPaL6atWfVkq7sDMqRzgRVXsCuNWrabj/0xe26KwETdtn7ySFsNIgf2e6sMN6r
 Alf99m4Y+ydEPGKM8/0OdnV6wKQ8pmnlMNk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34x5qxv10y-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 10:11:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 10:11:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyKjaH8qWZtdgPo+4vjPcPMb/4CfwnX4tPnsC7QALj6ogD1jLXxFN6xtOOnzEy32sxbQC5RtXVWCfOj+QrZotwETgVlDvDRQDAshdVPNspVyYCfUG14ZvUhVv6jZF16hzGoIoo86MHyXiyFaZ5b96X6ZwfOAreCM9SFT/2utTEhskelzUTLY3ZyDS1AmXeEAjvGyP+aHqgqY2XogS57JG4vcE1s8/GU/V8rjJaJkOBHP9uyrJWTeuLZtBg0FQON7cX4nXHSHDvOm/1VEPGbKBSKfqgnSkgqTWWJ+Sb6wnKWh24QWcLNgfTCdeth6MZcjrqdi/GWaBrTBBtLgCfPcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIfURhYkSQ4UO4oFQGpve4NgesaLM1X7nuM5FrfThP0=;
 b=fBDsDjaCYUR+3yAjFmEQXApjkbhxDEIO+iFpSuw9z3iuXYz61WIr3MNgAiNRK6pVQTt2db/hZ85E3jat0xKBDCekN7+bKvBxFwo4304kRtwbGtnHg+kvuKcswktrEogSxY4uxxASiFdnOY2hELpRUHj0MH5hNAa5o8Gml9CpLlNf+yuSqw+L///dlv7n9b9Gi1FKt3JQaAhhoV+eYnrzq1BiEyjATtUz4IZr8btIVdXduweXUaItxoxuJlZTL+ie6iTYqtSR1cniV0HvEZEVfzsiCm9oX6XePvkjrjreSE077uk2sF6ajP2hd9CodPscPeRN0IPg0k0YhnS9qsQI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIfURhYkSQ4UO4oFQGpve4NgesaLM1X7nuM5FrfThP0=;
 b=Hk7OmXBWmVpiktfH1cnrU7+WFti6zLBzJAoeGGtbvxnZ7YLM1YX5n8A32ftYPd/lYErLuiJ/11gLsGZ8M1CCmAFxVkjkoMlDXEhuWiz2tDCfvo2jljoipU+i6g0/bs0+g06Qo2hqvEhLWqztQ4erwdBT4gfoGccoUUU0jAbYqMM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2197.namprd15.prod.outlook.com (2603:10b6:a02:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 20 Nov
 2020 18:11:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 18:11:54 +0000
Subject: Re: [PATCH bpf-next 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-3-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cad0ea25-8567-368a-1f99-b4adc7440a7f@fb.com>
Date:   Fri, 20 Nov 2020 10:11:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201120131708.3237864-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f0a]
X-ClientProxiedBy: MWHPR21CA0050.namprd21.prod.outlook.com
 (2603:10b6:300:db::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1688] (2620:10d:c090:400::5:f0a) by MWHPR21CA0050.namprd21.prod.outlook.com (2603:10b6:300:db::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4 via Frontend Transport; Fri, 20 Nov 2020 18:11:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a7b4fde-d99d-4c95-5054-08d88d7fc2fd
X-MS-TrafficTypeDiagnostic: BYAPR15MB2197:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2197D69025D108130B302A60D3FF0@BYAPR15MB2197.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cw1aIraauabUAnqMr3wYovtu9c8S+nelqcoo/A2MoVE7nzTCm3kzAhZIfIHmUhP4vQ5dlpBriW+VUsPFBp4L5dH+dIdlSdoYrZE/CHHbTnB+ub7I/CL8VfnlmN8z0z+SFAW+HK2w1UQRvjQ0bADmay3kCz3TjdXUF9lysqEFQv44tqARgvezQX/gSTHOersEdtkfKsedvy6kYI2H5CUBJCvw2VLcc/9VN/0cXu03tmHYN5E9kwob4lAj2rvmJCObVS6H1ASWXYC5ZcV19oka82MGr4Vh+CtvtFPAQ+j4gEPwfDVqZmTWQCrB9gMYjeM+1I5YH0EHleX0fPsoj5gTKbk7MdCWsRqm+tMhiW4qfCwb/9698qs6Qy5d6ZLz0CD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(396003)(346002)(186003)(53546011)(15650500001)(316002)(54906003)(7416002)(2906002)(5660300002)(36756003)(110136005)(31696002)(66476007)(16526019)(2616005)(4326008)(8936002)(8676002)(31686004)(66556008)(66946007)(83380400001)(52116002)(478600001)(6486002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NRHwBio38nrZJaK83zPtIcTg9o0zC+BQoPyeQp+D3IrvD0izmBb6CQYKihg/Uwzk19j3pAPspa6X+AcdaByFZZ+GrKXAvh2W6g21IpcFS/mSZwadqBbXzL7pT07lv+tQvvLMrE6A+WGS972Dxe+KclIXjrirgJl/gtE7pRWGRXhLbgFI+EC98iSfMCWCW6qyakLgoVamnx1o3nekeYDyaCoe1/fd75SzJEotfEGzYCprAwyYVAfqIvtHKtXn9DN0TpXQcMKbertf/6+2l9rxDxjF/wG1wSjKD2rWzpnR45ukbswRP6HhQV2g43hFrKTGe1KqjuoYZmxg/3fAP3RMJLmDkK+xvmXDGzGmffNHZ83rb8jVQ+XZ7NrRE1gfig1jfeQSEh8l76sFdWLs4XBnJ5H1orzvpx/M4GH2k3mZoPOK8rzNapVm6YHI/VCSuP+hkGQHD+IkYWD39e4Y+jacF7k5mlBWtEhUuf7JXtynSHlYbrjdRGx83hjyTVoqRJJD7ZX3NtVQZGm3AK6w50eQeVEY3zwmKWkCq0dbWvt7UVjp3O0o2mXkszoRYzvRfeUVinQOagYNx+tveiL3xMiuLJ7fsfzBK6FRDu+vZ2OR7YJRXJnakigCcn8oFIn1RmLsNlMKyjJe7cVlkZWbLCe6+OgTVkPns7aK44NFoDDzSY3d/XnZNwd/ceuNAWB79b5f+LnjrUW4FY7RaiB9X4mw9Yy8Cx2mXa4f1+XNtZoDBIScgod3CjAMxDFIi6hRJbTFmodwmhtwwPmn/W6VNhUvbVzWP+eRBhOqxRBAV3gi6kPqxDmUxb0pCqOx0khI5daJRqNgzmiSCOKsGpBLmKgFwqzPZaD+WD+/TIxRAFUEINOAgVyponXlKKAoxGrv2yew08XtiagzrthIqHR2rXjtyJZsVb8VFYdb/90+ZBiYlyY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7b4fde-d99d-4c95-5054-08d88d7fc2fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 18:11:54.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mysx3qPjzU7z3+hXXqP3dqHldaDTYfvoZBk+OJFW9MRVwi4f/HvDiQuHAWHZUnpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_12:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/20 5:17 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> - Update the IMA policy before executing the test binary (this is not an
>    override of the policy, just an append that ensures that hashes are
>    calculated on executions).
> 
> - Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
>    if the call succeeded and a hash was calculated.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/config            |  3 ++
>   .../selftests/bpf/prog_tests/test_lsm.c       | 32 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/lsm.c       |  7 +++-
>   3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 2118e23ac07a..4b5764031368 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -39,3 +39,6 @@ CONFIG_BPF_JIT=y
>   CONFIG_BPF_LSM=y
>   CONFIG_SECURITY=y
>   CONFIG_LIRC=y
> +CONFIG_IMA=y
> +CONFIG_IMA_WRITE_POLICY=y
> +CONFIG_IMA_READ_POLICY=y
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> index 6ab29226c99b..3f5d64adb233 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> @@ -52,6 +52,28 @@ int exec_cmd(int *monitored_pid)
>   	return -EINVAL;
>   }
>   
[...]
> +
>   void test_test_lsm(void)
>   {
>   	struct lsm *skel = NULL;
> @@ -66,6 +88,10 @@ void test_test_lsm(void)
>   	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
>   		goto close_prog;
>   
> +	err = update_ima_policy();
> +	if (CHECK(err != 0, "update_ima_policy", "error = %d\n", err))
> +		goto close_prog;

"err != 0" => err?
"error = %d" => "err %d" for consistency with other usage in this function.

> +
>   	err = exec_cmd(&skel->bss->monitored_pid);
>   	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
>   		goto close_prog;
> @@ -83,6 +109,12 @@ void test_test_lsm(void)
>   	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
>   	      "mprotect_count = %d\n", skel->bss->mprotect_count);
>   
> +	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
> +	      "ima_hash_ret = %d\n", skel->data->ima_hash_ret);
> +
> +	CHECK(skel->bss->ima_hash == 0, "ima_hash",
> +	      "ima_hash = %lu\n", skel->bss->ima_hash);
> +
>   	syscall(__NR_setdomainname, &buf, -2L);
>   	syscall(__NR_setdomainname, 0, -3L);
>   	syscall(__NR_setdomainname, ~0L, -4L);
> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
> index ff4d343b94b5..b0f9639e4b0a 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
> @@ -35,6 +35,8 @@ char _license[] SEC("license") = "GPL";
>   int monitored_pid = 0;
>   int mprotect_count = 0;
>   int bprm_count = 0;
> +int ima_hash_ret = -1;

The helper returns type "long", but "int" type here should be fine too.

> +u64 ima_hash = 0;
>   
>   SEC("lsm/file_mprotect")
>   int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> @@ -65,8 +67,11 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
>   	__u32 key = 0;
>   	__u64 *value;
>   
> -	if (monitored_pid == pid)
> +	if (monitored_pid == pid) {
>   		bprm_count++;
> +		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
> +						  &ima_hash, sizeof(ima_hash));
> +	}
>   
>   	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
>   	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
> 
