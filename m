Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079861FA21
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKGQkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 11:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGQky (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 11:40:54 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD928A;
        Mon,  7 Nov 2022 08:40:51 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A75wLet013093;
        Mon, 7 Nov 2022 08:40:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=W2Y7pvAMQtxDjrkjWtfuRUjtId2LNBtJF6+taK74nM0=;
 b=RMzm5D3dLCzioUSLQ1eZl7KOx8jCizZ4uDnbjGKi9+DrF5WUwQ1ot78kjARDm/Mya3rd
 TVqJ2SYnwDpcCubS8Fi2NGWk8jLCDVVgivHKrNhJO7UKo5GXzcOe8DIr1GI7tBO90Zi9
 s9WOjvLeE+oPbsBZT2EDkZZCvnWGLV1SUUbOKjJmHAJUwVSTKOrzb6ktrloXaAriuC7U
 9O/AC41nCXxrhMzRhRMETYVYLpsQ6qUTQuc6T32SmGvPDSxWJ8CUYqLuw5gbUTGu06iI
 w4w6nW9B/lCMWX6Yr8Mx7qioF92A15r1kuk2nONHbVM35RJQ30/F78tbXcl9rrOa9cSe 9Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnbyqpdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 08:40:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf5VDdtJXY0LqLdtjrBtmmdq4g1ba4b7AQIDKU3XELgibPpheMVh0bzHB1li4AWX0/5uU6ouwcbaUfU7gFA6LXl7Lx4o3NIdHqv13QE/sLMWaoO4iKybDOq4tG7P6VAFUecRkLszA7n1VOPuhqENML7e4ls/ZWwG8149F+ud84AEzIwKiI8mnkrbXBXt/QDbIBR37al4InopImRm3nA0q76QVDQ43dPJ9vVIfRPaIHdCesW5ywB6feVUzseCXrGx0XLYlineKYqixUiluSy3d15/G7nKNh9rGySXcahsOa5egT5JafKQVzM66y1Z+dGwUUMgPXz+goLRdL90KsRXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Y7pvAMQtxDjrkjWtfuRUjtId2LNBtJF6+taK74nM0=;
 b=aJv6Nm189fhq0UCGLDGmINdJY3TdkeAoz9jRTWtkDgCwaEpK7LfqJWJNfBNx5Ep4yu91PBWcYc7QzQCcjAL/WRHv11GRkA9qH9uDSFY5iac9/k8qBg7D39qYO8pSRlUWrHbxnMGU3AK8bH3kRNym1FKIMiV/e10qE7f2E58UTPlekw1KzMCdzWN2tVtXsi0D6+9uCCBAkQeQlBSEoQ3yyHdZ1dLz1j+b6v+ccGNL2OGhycvCEUJwDqo3cyzmbDbexW2dFIICCoVoBqjs6SMVDPC8/2X8iGyujQnb/M5Ny21VOuymZybzRXZQadMIi3BcyBOL/zFmXj+Ddh2WYUJb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4196.namprd15.prod.outlook.com (2603:10b6:5:350::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:40:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:40:17 +0000
Message-ID: <7c3f3057-033a-f871-bd5d-0ac0da2b18a0@meta.com>
Date:   Mon, 7 Nov 2022 08:40:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221107085030.3901608-1-xukuohai@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107085030.3901608-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: eedb12d5-1d18-45be-ea38-08dac0dec087
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdwcMrqSzucZHBeWDbWXUTEmbHyViv4334+cZpojxOyQ7XS3l9e8ha1QQHaM/xRAo6h2qK6+g6BAhGDisrtWxDLypmWHwMvi+p57Pzw4kPS1K5oObY+5I8BWza7d37KNuVab7dDWliENH7I0IV8qBx+pjxYsEFVOtFm0vafBn8P9XvXH6dQnsHosU7RjJDUha4sT3MvvzWEfI8MWNVtjFaYt4d94eA/NznKCobU7rTrFAU1TSmjP1dpXkfkE+tXAS78dWPONFhqj1+gMmUabtnSlh/jJxCCvB85o5/bifLAveH6ldpQNjQM5NEfYMvee83KVLsALfdAnI/04kFRJo4INHf2alPjfnLfNt2pKujYIqiQUGCduRyLek+TY6BmFlS5zLwfoRU03CW6UTo1V0gLromoQTXJjpYsAQmShWW73Y6IKg9sq8gSw1qxgHOeNDaO0zuDo6Akh8Pkoy1gL4o8jyEQDUHYeQw6YQJY+O07eeQcSxqDuIrbHTG/+fKvuNcphXwUj1Mu5JfM+MNGcTSrb/XR07EO47qjo3NhUNBSdcJqNcvcyIkcYFu1J59T5Vwep4oykPkmBz6JazOv5WSCS9vAV9SE3DrSjEubrNO1XcGQzTso39j+++AaVBZQJIYOp4hpMVCSXQA53UCoE5hL8aJXXoSVFWON/GnQs/WSdMg4GDcG5pClDub3VVHGsMTuT7NNTwn9xUjYc3a9eVmXQGzMznEHo8E0iJBR5tTxT04pWZWsXoE1LDJtVpxb+4W0Uz4G+6hayZZheR/HFI3WL34R5E9e4/dd+D3gPEE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(36756003)(31686004)(86362001)(31696002)(83380400001)(7416002)(2906002)(186003)(38100700002)(2616005)(6666004)(6506007)(53546011)(6512007)(66476007)(66556008)(66946007)(478600001)(316002)(54906003)(8676002)(8936002)(4326008)(6486002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUsvV25lOXdzckp5dGhFcXhBUUhXV21aZGZkazJtQ1A4a0VQSEVuT0xaU2VB?=
 =?utf-8?B?QThBeUZFbzhjbGhZMTB2QUxOa2JXMFpTUE5OOTVHZ281bWE1Z0VIMmp5d2lo?=
 =?utf-8?B?cmhzTEdBY1FaNVhVN3VrU0xTd3k2ZFl2VlVhZU0vZGl5UEsrZU5kM3FLTkUw?=
 =?utf-8?B?WVpqd2lKeXN2Y0hLSVhBYi9JdjdTRnRBNU15K3VMN2JkVkJ6TXloRU1EQ1VI?=
 =?utf-8?B?SDNiVzVvcXNpdjk5TFE2VmtTNlJNM29EdXV3Y01RZmw4aWVxMEFPZnJvalZK?=
 =?utf-8?B?NGpScDIrZEdxQjRTdmZMdTFhaDN6amMzN1JOV045ZTFxc2t4dGE0djdCdDRT?=
 =?utf-8?B?cE5sN1VVZzlNRVlZYzNJVTk3UDNaQjhnQU44TXhQd1d3eWtDa3ovai8xMTVG?=
 =?utf-8?B?QzRXTkEyYzR4Z09lUmxveHNPb2ZKT2psT3JtZjZsa2NLR0VCcEhwUVp6dW9D?=
 =?utf-8?B?Y3pjVUZCS2lNSzNuVmpwaVhpWllnV2FXU0g1REJReHBERHV0TmwyWE1DZnFD?=
 =?utf-8?B?dnVZRmM2TnJ3NG82TVBoaVZKc0J3Snh6Sk1EdVlvUTMwb3FRUkFjOHdyQ1M5?=
 =?utf-8?B?cVBzVEtFTHhVNmx4QzY1NHdFZG5GV25Wd3AvZWhnZ3lzUnJQL0NwcFJoSjdv?=
 =?utf-8?B?V3lpQXY2dUQxaFBMcDhHNmhBWjhNcUtCVDIrMXlNbW5kcVJ3b0FZWWUwWGVT?=
 =?utf-8?B?cDVSbDREK0hudkFRUnUzNFBjWWhuUXZkSG9zL2dnTVMzL3FKQnMvdldpbktK?=
 =?utf-8?B?Wm1qNitsbjhjS3pHTTh6Q0lJVnFrMDZGY2VDcklhV1A0SG9ZWEh6M1IvWGEw?=
 =?utf-8?B?bHJ0YVltSDM2TTFFckdZT2xhZ2ZmWTNIOUQzdlphY2RwQXZBelVQdWRxR1dH?=
 =?utf-8?B?VU91WUVHMDdWNE56Q3dDWWl1OGZldmxnb25KYnBNN2l3UU52dTlST1V4Y3du?=
 =?utf-8?B?RFlDVnNVcXNVYnhxeDY1SFpxZHM1b3dZOENGOFVkZ1hvSWZEblFkd3BIdW5D?=
 =?utf-8?B?K1YzWE03MVFTMVFORlVZUFdEeEN4ZDhoVnBFeU1mYlowQ2ZHbExLZk9abGhI?=
 =?utf-8?B?Qzlxem5adWorN0VPTVNYU1ltdUVyd0FaYlpYZVB2ZXRUNlJxeDZRS1Z6Z3dD?=
 =?utf-8?B?SDVvMlZySTVpQ0ZrNjdRTzVmMkxJeVdCcmN6ck5reVdiMXFoODhHSCtQKzZZ?=
 =?utf-8?B?Q1R1VXB0TnRoLzZIaU1vTStxU1hyMmhPUDFNcVNibzhaaUFEUWZ5Z1dMUFN5?=
 =?utf-8?B?UWtZVGRUQ3BIWTQ0SHcxZllWVVhUT2RHRDNPWitJTmk2d0NldWxYdXVPelgv?=
 =?utf-8?B?alorYWdiWXZZdzI4MmZPWVkydGpsaEVvSlZJWGFiT050ZlpxenNyQUZ4cFll?=
 =?utf-8?B?ZmVWWXY4dUU0RDY4NUlyVzRhelpwQVpGV2o3NXY5TEhtM3RWNjIxSG1VL1VE?=
 =?utf-8?B?Wk1CT3VFaHVRM096TUtPWmZoblZDQkxvd3dzTVVUZ0lNdUkwNGM1QklpaXpS?=
 =?utf-8?B?OXlGTXlUbnRqNnpIZnNyTFE2NVdSL25WdjF4alZCUkxITXRwSjJCell6OHdS?=
 =?utf-8?B?a0NDK2FsWmJqQWdQc0hxMjRRcnY1UllJM0tCenprdi9IeHlIbElhb2xLYnlu?=
 =?utf-8?B?WkFNd2NJcmhIMFpML1lPMFBoZzNUMUgwRThiLzJNYWF0NDcxbXYwTTRHc0hq?=
 =?utf-8?B?ZVJxMFFQbHFDZkhLcDdqTm5VaHcxRG9OZGhiZFUxWUJMaEM5WmlZVnJDWkVm?=
 =?utf-8?B?ZjJYYWRaelR0M1JCSVRtNDJNY0grVFFRTTM4cEtONHV0cklYQmIrQ01YME5T?=
 =?utf-8?B?RjVqZWRaQ015dDllZDBlTGxHY0FVbk9yQ2hxak8wa1djWmdXTDdMMHZjWXEv?=
 =?utf-8?B?VXZZRXFrMmRvNnpUNkxrOGNnbVZHaU04MVFJMTZsdFFoWlFoa0xYZk1TNHdi?=
 =?utf-8?B?WTBKd01ISVVjYTJJTVF3T1ZiQk9EQ0NzNkZmSGQwSkJZcTRtVU1LWVAyRm5n?=
 =?utf-8?B?YURDTnUrVmpxb1hHOStDQW90Ry83a0NXRng1QStSck5RdTVXekVvNkFZMlJN?=
 =?utf-8?B?T1NqRjBlM2N0UjhINUF6akV1ZDk5YmwvRi9JM0RQODduaDV2ZnZvd1NXcUEv?=
 =?utf-8?B?enFZRytZeUlGOUNWMis5VlhmbVFhTWJKa0oyY3V3MTZQY3FBZVZUeUk0ODhs?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedb12d5-1d18-45be-ea38-08dac0dec087
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:40:17.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNO/XLlOJ7twy7kCn+LLwwY1VRhE6oiKdCBOMNsE46RC9yCJ6s9vfmtzpM4mrZTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4196
X-Proofpoint-ORIG-GUID: lSf5-mRIlaP2fXDqSJRjSFBDuqtx3X2j
X-Proofpoint-GUID: lSf5-mRIlaP2fXDqSJRjSFBDuqtx3X2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 12:50 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> free nodes for each CPU except the last initialized CPU, always making
> the last CPU get fewer free nodes. For example, when nr_elems == 256

... free nodes for some cpus, and then possibly one cpu with fewer 
nodes, followed by remaining cpus with 0 nodes.

> and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
> each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
> nodes, while in fact each CPU should get 8 nodes equally.
> 
> This patch initializes nr_elems / num_possible_cpus() free nodes for each
> CPU firstly, and then allocates the remaining free nodes by one for each
> CPU until no free nodes left.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

LGTM. Did you observe any performance issues?

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/percpu_freelist.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index b6e7f5c5b9ab..89e84f7381cc 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -100,12 +100,15 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>   			    u32 nr_elems)
>   {
>   	struct pcpu_freelist_head *head;
> -	int i, cpu, pcpu_entries;
> +	int i, cpu, pcpu_entries, remain_entries;
> +
> +	pcpu_entries = nr_elems / num_possible_cpus();
> +	remain_entries = nr_elems % num_possible_cpus();
>   
> -	pcpu_entries = nr_elems / num_possible_cpus() + 1;
>   	i = 0;
>   
>   	for_each_possible_cpu(cpu) {
> +		int j = i + pcpu_entries + (remain_entries-- > 0 ? 1 : 0);
>   again:
>   		head = per_cpu_ptr(s->freelist, cpu);
>   		/* No locking required as this is not visible yet. */
> @@ -114,7 +117,7 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>   		buf += elem_size;
>   		if (i == nr_elems)
>   			break;
> -		if (i % pcpu_entries)
> +		if (i < j)
>   			goto again;
>   	}
>   }
