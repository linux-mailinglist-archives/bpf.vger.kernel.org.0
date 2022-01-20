Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5419494638
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 04:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358375AbiATDqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 22:46:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3972 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbiATDqJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 22:46:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K3RpP6012178;
        Wed, 19 Jan 2022 19:45:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=z6o/oNgZj6zdrr9HUAIOmSXqpMbkhH6Xy8LF32bffiY=;
 b=k3vfTBeoLkmhSazykLSuySFWR9wFTbJyThrVJfZmfWm+yMBN1T8eoDv5HAhcjzWxywjg
 aX9y0rYiN7gsGiWYOoSVZTqwF9vNdi2uBOn+QqnI0jieJp80Y0Ick81s1uzgHtSgHnxp
 GQX+wPE2sBAGD7+KbWRzdXJlNS6LAZoDrNU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpyup020y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 19:45:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 19:45:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fayD/rGMkc8LXEdluCCJn1rQLQZBqlGHcmSg5Sv7sOWcng6n1RiRCku+ztHsHR6VzzsrysXQETpBumn19NMcZQVqgHuk/G2KoBP1CmCEZnO+qjHwKv+YbV44a2YqWvD+43w68QTQ03utG1Bs3EE3lDReGgv36wkty5yYeDMYK4BwXrzTTMDiFQV2XlNtCjwDXKAPcCy3NUCSHyrWYZjTcgwOptzOzMiI1mjjO35S+lrXxpnrDRQ6vjL+k2RGnaDdIxtmF7E2U0wvjvKSaaMvjYcol2XmTUHQxvhUBiCSEZL05CvW++MfV99Wcy0iuLN3lybaLTlzMFSFf/l7PPwHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6o/oNgZj6zdrr9HUAIOmSXqpMbkhH6Xy8LF32bffiY=;
 b=k0/QdCD3DsVHjXqEjLY1DJXvNaHnMc3UvzyRyAwsNzpXXB6yiwiWdAQiSGKsgH61Qnpx2HroGljIR0Ef9xjgjCCskRDAN8fIi0pf7CY1L6mfbjaHkgmneefbLubN93yhsZtxkrKH4qWptC6ePZQaVxpzfkkmJO2G61YNV8nzXBuMj1R3jkmtjzSTQ+fd3/VNDUGC1tMoru2fPP4B7y1/HJS2xcwtmbUgt/wOBjjqKiYW9pOwQuwPg6BND9rv9xPCr2kDaawJZ+LQf7jlFdreIt6kwAr6C8+Xp/grJw5oKCCk8AwDdXW4lM1ooHpR0ifYpC6AbL2jHppA2epzEZkbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2414.namprd15.prod.outlook.com (2603:10b6:805:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 03:45:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 03:45:46 +0000
Message-ID: <cae83c38-3c83-af42-a0ef-551611d0af5f@fb.com>
Date:   Wed, 19 Jan 2022 19:45:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Content-Language: en-US
To:     Kenny Yu <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <phoenix1987@gmail.com>,
        <alexei.starovoitov@gmail.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220119225929.2312908-1-kennyyu@fb.com>
 <20220119225929.2312908-2-kennyyu@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220119225929.2312908-2-kennyyu@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282b87a2-1b98-48e4-c820-08d9dbc7573a
X-MS-TrafficTypeDiagnostic: SN6PR15MB2414:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2414086CBD87D3B1059C675BD35A9@SN6PR15MB2414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6bBIm1Jd4ZvHXsqdfp5021imGr205WaRfO0bPxSNKIg8KFuSfIZLHfgJ5NbotTnLEnZRtC/payInOcqx+UNYTdZs9u8ByC9xt5AUL/sGK3Sw+MENUtptdnmT5q5NfkGcV/ALS7xj5LhhUYLSmj6ZBIPUHoKxos0HCYenyrNRMjuXu+3YgxhqOupN+yimb9hiI8pRQRpfsupMazml4KT8+Hpz1UKy6ogOLbUzJ6N6MZGvTDftPffFir6w87/q9Qs0o39JHoWHbgRiGMmiX4BYUlNLnLgU6leRF+ccqRVdhCQB6qaHCWrKK62vPWcmVuilOn0M/y6zx0C1AcpG+Ca8dimU++awv6ArA2bWH/w2GORb7JQVYD6tn0i//bzLzc+Xb72xcEpr36bfu4tosYAv8D2Q+tII+YTEsv7EoBxlk9PHQKR36kC3vFcbSNKhVDEgnBscpXEG3qQc5fx5XCptet02mPRoVQHm0sWpbF6PiuNE04pLvpLDLSTayx7dWNiB+2iEFuzWrSc/IbiUze2oG9BC2IeLrCw+ORI+jE+XxV54h3H9PXv35cAzESF5rsrPfo0XrpBgipf785HuSrS04/bgWhBKbCUmzxcWcX324pUzIkX2txaH5+hrysBgs3kL61XetJ5rsIARBO6gUQ7yNURjCdV6jP09sT3QoZrfJlVMQUtr6hO2zvn0RKdVUbbCB+4HtM7ZSw3gs2ksvTP0C4s11RUvUc0wuIZaTRh5Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6636002)(52116002)(38100700002)(8676002)(6506007)(2906002)(8936002)(2616005)(53546011)(86362001)(6486002)(4326008)(316002)(31686004)(36756003)(37006003)(6862004)(66946007)(66556008)(66476007)(83380400001)(508600001)(6512007)(31696002)(5660300002)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUYwSzBwTEs1NGp3V1VackFPdWJrbXVHemFoaGR4YXU5RWJ1djJYay9LRUJK?=
 =?utf-8?B?NGdkcHpTTjgyOTFpKzh0Rno4dnV2QzJzRzNTSnNwbkJ5aHArZUFRaFpTTWtu?=
 =?utf-8?B?eWRPNGtSNmJaVGJrdE5FVWlJNjFraS9FL2Z4ME14UkgxanYvMWpjaDJHZkVE?=
 =?utf-8?B?ZjFCdGI5N1QyWEkwLzhGWHNrVUNpS214ek9CU2VhK0R6ejNRSTVkUkZRQ2F6?=
 =?utf-8?B?ZTBIdW52Z3BFNmpFYUtCdm1xK1JubUFlM0lvK3ZZN2VWbHNVSTdKN1VRdkMw?=
 =?utf-8?B?RGwxWGRTNEx1SHJFcXgvVEp2UWEwT09tS3pGejRZWjM5UnBxQUlWZUx3WUVN?=
 =?utf-8?B?bmZnUVdNQWtpWU5POG5HdGIzK3RRU212RW04NkNVZVNrQ0w0aC8xbm1PcDhw?=
 =?utf-8?B?U1hJaUxUYk0zYU1McVFGTjdlZWZ1YXRKeXBxbUgxZUZkNGlYU1k3eTU3WGtX?=
 =?utf-8?B?Mld1c055NnhvL3E4RHQzelpMM1g4ZXdQVjhaVy9UN0hlMDI1ZlMwb05DVWxs?=
 =?utf-8?B?TUNwTnEzUnlzM2JrNUFhNUEwdzlPQlVtempoWkFuMTdodHI1clk1TjVZVFd6?=
 =?utf-8?B?KzlzbVNkNzRpamQ3WnkzOThrVHNNVEFUeWJmaXBHclJPRkg2TEhkNHpKZGpF?=
 =?utf-8?B?Q0NkKzdxOEVVdGYza2lUSEh5V1NYckZnWDRKdGZ5UlRIYVFWUktDeGQ2SVli?=
 =?utf-8?B?Q0RGZHppTUw0VThwR1hJbVBtVVljYkNjTGV4MEhoNlBpaDVqb1lGc0MvdnZR?=
 =?utf-8?B?QXR5S2ZFMmVnem9uRTlxWThtUVk5YXVwaTR3OCs4NVlNdHQvWG9lb2NKcXJM?=
 =?utf-8?B?M1dpWDNvYlNxaHBEUHhINjNzbWdIMGFBR04xZGZFVUZYaGpKQTRpLzU4MEV0?=
 =?utf-8?B?SGg2R3ZodjVLNVBRbngxb0M0clcwbld4UG9sSnArRXA1OFRDZnNza00vMHkv?=
 =?utf-8?B?TTNCekVxaFZKaXZreldCK2lSSkdjNklXNnRJRU95dlJ4eGV2K2R1ODRyMkRC?=
 =?utf-8?B?OGVUTGhqMEVoZXRDZDkwYlEyTzU0RHEwemdPd0VZK0RQK2xlSjlvQk5zZTda?=
 =?utf-8?B?UnZrbEl0U3lST1g3OCtTKzZCdENQVmt3aWh2N2hyRlpzS0ZGY3FMNmhEWlYv?=
 =?utf-8?B?UldrUEhRRHFoeU02R0c0WTcrZzhjeEZtcDN0bndObmZrN0dNNklUL0w1cUJY?=
 =?utf-8?B?Z2tEd3dzNXJIcVUyOFhiN1FpaEY5TDZjWVlGRDlXTHNVbGNmSlMvU0xKdER3?=
 =?utf-8?B?cjRNSzIyVmpYY1lDelR2ZWszMDVSR3JseXJxMTFvYyt4MXpweXlLeHRxMEJO?=
 =?utf-8?B?OTBxSEN3OFRSWXRYaVdFZk9xREFBeVZTeDlpNElOSUVJRGdIbkU0SllQWERG?=
 =?utf-8?B?ZkRXc01GdmJyYmpVSHY0RTBoRkpQQWIwNjAzSDU1Mmp0RlhqalVVZWpmWmxx?=
 =?utf-8?B?SFJpQlFNS2lQK2VidWZ2eVZlOWM2bUw5V3lmaFlZQytoaEY2aHBwVi9wcjFV?=
 =?utf-8?B?MEh2OUxGOEJ2OEVxS1dUNGRlbkdmZURMalZETDNncnVrQWkwbjVyWENuOHpX?=
 =?utf-8?B?ZnhkaXp2dVN3TDFhWDFLV1hBSXd6aC9Kdkhrc1BycEZ3RDd4Wm1xOVhsRUtT?=
 =?utf-8?B?QUNqUXRwVDZjZ2dMODUrYjJLakwvTW53T05HUlQyZE9leWVRWlVYVWhZR2Jw?=
 =?utf-8?B?Z2RsQVNzSXBYODlOQmRaLzEwWVRUTWhlTHB1N2p3VXAxSkJISm5leExWRGJ4?=
 =?utf-8?B?YnVtWXNybWk0VmlpRUpXSWRISEdTTVk1V1hSMmo2Z3k4RVh1ZW90L20vZnhi?=
 =?utf-8?B?SHh2RUdCck9DdWUzb0FsZGxpdTc1cnJPVjdVYmlIL3RXOG1WMmRqQ0xteTVu?=
 =?utf-8?B?bFJZZUFiNzh6UmlJUkhrcGpUcXZsMFR3eEhMQ0dtcC8rUkoyQUdDR2krdU1a?=
 =?utf-8?B?dVdRL0J1MHlLbWlaN2lUS2ovclU4ZmR3MW44eThXZlFCRzZ2UE4wcFpSdVdK?=
 =?utf-8?B?NTczTGpoTW1HTStmZkFHQkcrMVVPbVRxTEE3WUZaaXhBNXU1SnI2WVM3NExT?=
 =?utf-8?B?TGFXK0JXWHhLL29QbUVONzdQa1BVb2NBdmlRMUZjcitXLzdxQXhYOHI2YThz?=
 =?utf-8?Q?Fa6g4oC7vbmhbpLKH2wU57+Ql?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 282b87a2-1b98-48e4-c820-08d9dbc7573a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 03:45:45.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ0R0Kbk6ZUSJ15toQaT7rCyPZjRvqvPM4nGzgRt0OrHdtF+n8H/Wah91T+XM0Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2414
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pvWVXa09OKs9tTsPdkkmERvWsnjvT-xz
X-Proofpoint-GUID: pvWVXa09OKs9tTsPdkkmERvWsnjvT-xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_01,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/19/22 2:59 PM, Kenny Yu wrote:
> This adds a helper for bpf programs to access the memory of other
> tasks. This also adds the ability for bpf iterator programs to
> be sleepable.
> 
> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
> sleepable bpf programs. With sleepable bpf iterator programs, we can no
> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
> to protect the bpf program.
> 
> As an example use case at Meta, we are using a bpf task iterator program
> and this new helper to print C++ async stack traces for all threads of
> a given process.
> 
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---
>   include/linux/bpf.h            |  1 +
>   include/uapi/linux/bpf.h       | 11 +++++++++++
>   kernel/bpf/bpf_iter.c          | 20 +++++++++++++++-----
>   kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
>   kernel/trace/bpf_trace.c       |  2 ++
>   tools/include/uapi/linux/bpf.h | 11 +++++++++++
>   6 files changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dce54eb0aae8..29f174c08126 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2220,6 +2220,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
>   extern const struct bpf_func_proto bpf_find_vma_proto;
>   extern const struct bpf_func_proto bpf_loop_proto;
>   extern const struct bpf_func_proto bpf_strncmp_proto;
> +extern const struct bpf_func_proto bpf_access_process_vm_proto;
>   
>   const struct bpf_func_proto *tracing_prog_func_proto(
>     enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fe2272defcd9..38a85e6756b2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5049,6 +5049,16 @@ union bpf_attr {
>    *		This helper is currently supported by cgroup programs only.
>    *	Return
>    *		0 on success, or a negative error in case of failure.
> + *
> + * long bpf_access_process_vm(void *dst, u32 size, const void *unsafe_ptr, struct task_struct *tsk, u32 flags)

Maybe we can change 'flags' type to u64? This will leave more room for 
future potential extensions. In all recent helpers with added 'flags', 
most of them are u64.

> + *	Description
> + *		Read *size* bytes from user space address *unsafe_ptr* in *tsk*'s
> + *		address space, and stores the data in *dst*. *flags* is not
> + *		used yet and is provided for future extensibility. This is a
> + *		wrapper of **access_process_vm**\ ().
> + *	Return
> + *		The number of bytes written to the buffer, or a negative error
> + *		in case of failure.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -5239,6 +5249,7 @@ union bpf_attr {
>   	FN(get_func_arg_cnt),		\
>   	FN(get_retval),			\
>   	FN(set_retval),			\
> +	FN(access_process_vm),		\
>   	/* */
>   
[...]
