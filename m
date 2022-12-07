Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1822645192
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLGByp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLGByc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:54:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048F5434E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:53:41 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6NZqTY001302;
        Tue, 6 Dec 2022 17:53:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=s8a/5wKBti1X2L8hkSFwuVNAHdWVAxU1LzUG3+mAo+4=;
 b=Bnb0CxTRrTAOjVJU54wUaEUcXH+HdfUKK1GZYzek5ee5cC3lxO65B1Yqov3I56pnHOlP
 V9b403y5ec5P4FbEuooM4qWBO4NoWsZtrq730+2F7dZCOc6CQOv9S7Nkx/V1ZAujr8sz
 7ZCmJPQ4nCOhmF+EHUUrb6PDOLUMZucBLHDAr0D3tqVSXTTO/H5OOS4T4rQ0o3S0Cx6z
 OrNBhtXfjiGg0RyeIsIBc1wSarKizYzylYtgg40XcSYFGfp+hW5yeHv91Y+SNffjOf+z
 BDiXuhTu+FpvW/30VJ/E7MPUEERhWCRBuIYdQ2kFIArR3S+0esbbH9652mB7Y9I+bRhN TA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x70yjgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 17:53:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2A4min+ErpSl4mggXlhX6ECGnu84oWR11UKXnWtHPW1GJm9SaMH13SpJWEfpetA2txkRM/RBIvbbEUiUKx8UJKAxF0l7q4+3uZZrmde/BCMNS5+W6vccA9Q5cNAwt5U+JE9sgAqUNErcglsSzZZPHkIpDfL1wcuk1kkuYLEXp0OvN/Q2WCVr3eWnPa6kGjypO39nvGXOBMQyMVtiNGBJ8i9B0MaekeLcOCgdN7l+2mJHe2p3TUthArlvVgc1EIAa6z/J5t0yu9Cd/bNOTB1ZwdDH9qVsg9JzAuV6KvnRY4VBtl076y53zmKbTLiogoTPKWwBzmi80lDFPe6wZAb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8a/5wKBti1X2L8hkSFwuVNAHdWVAxU1LzUG3+mAo+4=;
 b=ZsTMFcQA1drZwiFgogYGfEuaPuOiopqDFXjgVmLAIPEu5iNjmnuHSAGnt/11tnRluNrGEOjj9ms3UUxpimcRbxwpeM+of2QRys3asse7foVXqwoOKQpZ29vxiOxNWXkbpSw3ERdsYwZIR8JQUEGJNMt7SzgqGMfYc3PGXbxEKwrbGn4ZCjNG5qDG+zodZ45GWcEPGOx5ZbF8HhhMtD/RaADn343CQURMOra6Cwxih1AHXqPUvZXwmLYkStAvjUdPtOvG4cJn+VJgyR08VyNMflZPblwISwDrbHmGf/xw27tcSnl1TQBCI9UEz7ad4X2/AMifgErVpIzHk5S206u57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1492.namprd15.prod.outlook.com (2603:10b6:404:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 01:53:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:53:00 +0000
Message-ID: <05d1f326-55cc-d327-9e0a-e93add2a29cf@meta.com>
Date:   Tue, 6 Dec 2022 17:52:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 1/2] bpf: Reuse freed element in free_by_rcu
 during allocation
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-2-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221206042946.686847-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1492:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e2fe5e-063e-41e8-06f4-08dad7f5c53c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urfvjWglcz5tM1QINJRmMmXB4CcSBUoXgPnbUTJf09iIPJN9vMhSN9SBLpW5LbxyfgpmQODUufJI+QNf88y1TPpyy3dmHcwRKWzHRGz+8mojFXzuJ2fc+LaVpmWlnsDuyFng5I8lEt+cOpxWDHITX8YY8aa5XBKGRcmnViG0GIHDpYqp+rD1CYaGpKMSYVHZ1G4+kpkY8/46u2rVEENseEulhu7mr2f1GsXwn7Ngt/6IhBHZin/ZR2KRNCs5xFrV3XTfohpR7D7kwbQTdMY+J5qJ74IgrQzBo8LIluL8NpHgPYZ60Qc1qaxpS4aUVBcO4DlwjypTFEVVzC0WbhueoL9PzcCQjYQVhID3gqs9jkgTwfprNsZ6nP3JUGMxw2DGGpNngws0HFblm1XJmheyCNilgxmRonORxJUSL2ZFxIxW+3bwoVGxzJ56kD1r0JJmF1HYD6fN5PIH9DIoxpCvrfM8164Jpanv6yF6ORMZrVOsUOzSQwtlwTs9spBnRsYR2NNOqFXuYvXPUOCRu2ekCkp1LTle0TIYESGW3O1zzVqHvivU+PummU1auwzwaKqUpqMHfbDk1DQvKWzsWLdooHM/KwR4Sdj9NQaJ5MN1bWQpLswyb1+z88WP3kwbMu2h559n95nhCnjufAqSL04bgu08vkPYVtcuzQtvStvhXwQYZ1A2PzSyd+0tTpv/gnqGCErMKQB8NdvuF+h6RDmPKRKnLoaugwCh4bpC/KaBW2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(83380400001)(6486002)(86362001)(8936002)(31696002)(5660300002)(2906002)(7416002)(4326008)(41300700001)(8676002)(6666004)(186003)(53546011)(478600001)(6506007)(6512007)(66946007)(66556008)(2616005)(316002)(54906003)(66476007)(38100700002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNBOEhJM1BqTko2a2wwTFVUNDVKMkYwaVQ5K2orbXZSRko2djhOdGp4ZUs1?=
 =?utf-8?B?MDg3UkRQcFdtQmJidGFyNUp2bEV4cDVMZ241R000Z1RDZ28raEJzSVZVeUVX?=
 =?utf-8?B?aU9wL3J0VlB1OTI2dFZidFE1S2E4RXhaQWlOR3BqTHQ5K0ROUHB0RWtqd0Na?=
 =?utf-8?B?dHBtNDhiL3BldVQrd05TcjlBN3dGSngrMVE2M0xod012L1RGK0t1dlp1WUpv?=
 =?utf-8?B?cHN0eld3T3lZUzhtMlRqU3BpZTBvUWVDT2kwNElGay9jOHNUU2V1aTBRVzJr?=
 =?utf-8?B?Z0k4b1dXNnd3MVl5ZWFnWXl4MEo4a28yZGJGeFFMdGR6eWhlZlBTK0E2R0dr?=
 =?utf-8?B?T3hwR0MvWXNSYjlHTlJsS0I3aURkK1h1L1p5UisvblZsOUowLzUyNUh3UUU0?=
 =?utf-8?B?aVFPelU4SEk1cG9iVDR6a2g3SFNFOGxNeXFrTVRRL2c2UFA2NStublJsZ3lJ?=
 =?utf-8?B?KzJYYW1HSGFlVHpiTHZINVNKZGRoQnhpcEljWWVoM0ovaGo0K0lBdEFaaDRn?=
 =?utf-8?B?WVVkY2JDNkp6SDlzZ1hQdHVaZm1aa2lBUUlnSjBROUxpMmxCclY3YktiL0oz?=
 =?utf-8?B?WWg3RkNmRHZuems3ektFQi9WQXVyd3MyV2tUZ0tuQXRrRHA1OStsTmhhTU5T?=
 =?utf-8?B?N2V3Zmkrd085LzJqMHZibVZPeVlJRHJGcE5lTUEzRkVnbHZIL1psZytSZG14?=
 =?utf-8?B?ZW5YaFpsbG55Yk9Bck43TStnRG0vNnhHVXI5MU5mRFlxUTlWbHBsQmtLeVFJ?=
 =?utf-8?B?dElWbG1GeFlhcFJxcXdUbmNyenJJNmcyeFg0RlpyUCsrVlR0dEhCSXFPaTk4?=
 =?utf-8?B?eUEzS2pvMmZEQmo4dEdsUjhuSy96eTVWYUJRYlpIMFVCWTNCbDJMWmJReUt4?=
 =?utf-8?B?ODNqaytGd09ScmJZN1ZUN3gxREc1a2dXMVIzWjVvNmgxWGJSbmovdlZjYnMw?=
 =?utf-8?B?Y2J5Vmdma0EyWk5paHRMckFtenRCY3pZT0pxemxKRmw3aUZ0YTYwWmljd210?=
 =?utf-8?B?TDdKN2lpMHNHd3RaQVJqSXo3NzBmaXE3ckg4bWxENFowelhZa0U2aDdNK2hJ?=
 =?utf-8?B?bkNGTjZLTEpFbjl3ejkvNVo4QnlqbFF5K1RmSW4vSjN2NXg0WHI3RWtMTVFV?=
 =?utf-8?B?a2ZYMERJaUpsbnp4dzRybjBLU1EyOWV3T0VDT25WdkR5OU5tbElLK1hXbnJm?=
 =?utf-8?B?YlBDWkdBNVpRV3lkdHFoeCtlUzhaTm9Uajc3cWQ3aHlNak1ZS3ZnWlI1bjZX?=
 =?utf-8?B?NWt2SUwzUkRLYnZhQTBlRHZicHU0NTRWdjFaY3o2MWI0WURxNytnR3NvVlJS?=
 =?utf-8?B?S1Q3SjlLdWRvbFFDOXd5UmNiMlFybWxOQlJQL0F0VXhDdERpampTTUJBOW5R?=
 =?utf-8?B?TTlHU3JjMGdkSDJ3eTd6UThCN1Vmc1g1eFZ3ZWJuT0tId2dTcHNEN21pb0Jy?=
 =?utf-8?B?TXdLU0dka0VQQnNCZElQTHZsWVV6RDE2ZjgvMDZSQ3JqYzdFdUIwTFRHVXY4?=
 =?utf-8?B?TktKRVZhQzEwUUVlM1g5anlRZzZMQ0U3UEVwMGs2UGRtSjJtbms0VmdTWExX?=
 =?utf-8?B?TnFreER0NFV2YUYwKzRkMC9raUdFS1ZNWGRZcnRMOHB1elBxWkxhMXd0bWYy?=
 =?utf-8?B?UU4vMWs5bXFQdnVNUzNGRmZydFpRZ2hvZ2d4bDJnejJkcG1IZDJITW9PeXlN?=
 =?utf-8?B?eGNrU0tRdlpKVGlWZGV0Q3JtQ1ZsVS95YTBmUFpjNUVNUDZhUlJrOUhYaFVH?=
 =?utf-8?B?UjE0NitWNEE3NW1Ia0NGQWpnaVNoQUUvZ01EcW42RGlXc3htTnN2Q1pGVFla?=
 =?utf-8?B?TDgyS2dXMXJhL09QakFHYWlZL0NXK1BwY3VCbUQwcWlDSWRUdVRUM1RkaTVV?=
 =?utf-8?B?VWxjaWhZOVRSM29Oa3lTUHJZRGFjZVFKRzlNb0d0UHNrWDkxdWRzdFlrTFJF?=
 =?utf-8?B?QTNvN1hJQ0lDbmkwZUNUSFdrSkg5TXNsblFOak1yb20ybkVOdkZnd01GSkls?=
 =?utf-8?B?TGU3THM4ck1CajRDcUNGdTk1RU9xS1Nhc1JUOEZLYmR6Zmc1a0RYMnFFbTR5?=
 =?utf-8?B?UFNzaHNCcVFoTHBXd3cySkRvZ2lucmx5ZVlGSjdxdVBpVzhWc1h3ZnZiR255?=
 =?utf-8?B?R1NwZTU1TURWWlp4dGtWR3FiWXlmdzdXRlRBY2M0eVRIK2dXb1NiVXBiY054?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e2fe5e-063e-41e8-06f4-08dad7f5c53c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 01:53:00.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TnN1jmpvbyJut2chBw6FL5XgtA9P2tjjFEUxUwevpFfKhisExVTY5yBgcIzLC7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1492
X-Proofpoint-ORIG-GUID: eEOKH4-CU_TJkeHjTRKdo1L1RyYQpE8a
X-Proofpoint-GUID: eEOKH4-CU_TJkeHjTRKdo1L1RyYQpE8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/5/22 8:29 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When there are batched freeing operations on a specific CPU, part of
> the freed elements ((high_watermark - lower_watermark) / 2 + 1) will
> be moved to waiting_for_gp list and the remaining part will be left in
> free_by_rcu list and waits for the expiration of RCU-tasks-trace grace
> period and the next invocation of free_bulk().

The change below LGTM. However, the above description seems not precise.
IIUC, free_by_rcu list => waiting_for_gp is controlled by whether
call_rcu_in_progress is true or not. If it is true, free_by_rcu list
will remain intact and not moving into waiting_for_gp list.
So it is not 'the remaining part will be left in free_by_rcu'.
It is all elements in free_by_rcu to waiting_for_gp or none.

> 
> So instead of invoking __alloc_percpu_gfp() or kmalloc_node() to
> allocate a new object, in alloc_bulk() just check whether or not there
> is freed element in free_by_rcu and reuse it if available.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM except the above suggestions.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/memalloc.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 8f0d65f2474a..7daf147bc8f6 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -171,9 +171,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>   	memcg = get_memcg(c);
>   	old_memcg = set_active_memcg(memcg);
>   	for (i = 0; i < cnt; i++) {
> -		obj = __alloc(c, node);
> -		if (!obj)
> -			break;
> +		/*
> +		 * free_by_rcu is only manipulated by irq work refill_work().
> +		 * IRQ works on the same CPU are called sequentially, so it is
> +		 * safe to use __llist_del_first() here. If alloc_bulk() is
> +		 * invoked by the initial prefill, there will be no running
> +		 * irq work, so __llist_del_first() is fine as well.
> +		 *
> +		 * In most cases, objects on free_by_rcu are from the same CPU.
> +		 * If some objects come from other CPUs, it doesn't incur any
> +		 * harm because NUMA_NO_NODE means the preference for current
> +		 * numa node and it is not a guarantee.
> +		 */
> +		obj = __llist_del_first(&c->free_by_rcu);
> +		if (!obj) {
> +			obj = __alloc(c, node);
> +			if (!obj)
> +				break;
> +		}
>   		if (IS_ENABLED(CONFIG_PREEMPT_RT))
>   			/* In RT irq_work runs in per-cpu kthread, so disable
>   			 * interrupts to avoid preemption and interrupts and
