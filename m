Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2060BB6A
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiJXU7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiJXU7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A92147D20
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 12:05:30 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29OIxJAj022726;
        Mon, 24 Oct 2022 12:04:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VSL+6z29AJOQviCMv/RTctL0PR8zp5DiUlZFy2mnp/Q=;
 b=elw/CyoYSXR/Agq05RJo8uqMAJzpN0+V6Ty1uxhzzAhQmja2gAWCfVyuvmRxvSMiKfV5
 mos2S67pFpoNOweS9WuuRRj8UQ/n6dYwdQ+X8bTQnibfKnNiegH6DGniAnAuycVi7e4A
 YdWRGfr1Bt6jWln5X9l1lRBAorIrNJ9J4tA9L+zhIyfWaJ1mm3Vzjcfv5OmBhvue1rVo
 Jj/zUlOK0I0+1hxq5044oLP6O6P8vas1y90ryZVynubSFmagKNxgKUX1hQXfvTHh5qXU
 FaIu84Fweu/bUznqO1/0zGq7j3z7u2q0tqFkenLcCoTWmz9bN3uorMzL1R/9vqTxB4J5 Mg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kcc1bmyuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC7kjEnqO6rUHEUc5Vqy0yiXk0aSED8+WsVo2fn0qf5KmdJToPUoH75wAnkr59pZEYq1yienzbDiccP2l2q+77XU4Z80u2I2RYDKjLX+ke/iBtUZ4A2om1Rms71x+fofnispXhWE6/rnUx5BMfK8AH33t48uziYjvUY+bnphlUcMNfBkaZ3EPNvaQnV6bkpdCg4zDEaesdr7zTuo43Qg+ftqsdSn7NHblyEZVG2E1k1vePQ7SrriZUz6350dYRYM5bkllgb/yrJgMMmBkFYdWcXEPscvGpk/xbzdIE0PK9vvkU1z5xi3PzfBeIX8DnkcQ7Ncv0OouYih1QkG7r3uRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSL+6z29AJOQviCMv/RTctL0PR8zp5DiUlZFy2mnp/Q=;
 b=QiD60V4ggyNSOqXZRUB7jTzhuhKXrnrZsGH5UVPspnHA68oUbM/IvZ6HYsCXutBuJ7tczNCM4s8+Wq1Mjkb0dpXRuBoAdfFYv9gJMTUDUj5MKMy8lXLsPrPJajtxRM9R0agM/Ur5Yly8TEKQhVNiwpcg2Zijv0+27GRr6ohOWFBP6CeA2NUCJjZ2QcrsYTxrl8pvxg2fIXLV/74U/som9LIiVkyo+QmVrZA5kHHtMyU4jfB5coWS9S3hDW+5mnoM+W5VJct1u8rzFT7sOnAdHBKW2BABzJJRLU8KYCfTJqMxipujGncGqB/5zhm++C9XphakwaWHaymFC7+NF/+HLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2249.namprd15.prod.outlook.com (2603:10b6:5:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 24 Oct
 2022 19:03:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 19:03:57 +0000
Message-ID: <bff18442-fd2d-a4b8-5153-bfbb08c218a9@meta.com>
Date:   Mon, 24 Oct 2022 12:03:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Add selftests for new
 cgroup local storage
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180546.2863789-1-yhs@fb.com>
 <Y1Wgkt6fnWlXuLYD@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1Wgkt6fnWlXuLYD@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9116bd0a-8897-4250-f664-08dab5f280d7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9Hh6X2j+JNuoQi6FHpj3kYDm955p23SoKl0e9tEofLKRVR8bY4TR6b9PTkJpnLcyCGikk2YCPIudF5HZ00W5QdqB04s39Re7EF12AaBqb0zOXRjjjmm8C02h3bCLU3vP76MvCdxc9/D37kpD39MPoC3ws9C1rwxZLtLMW+zPkJF1Z/Jz8s22xZ88psAZ3nyjBmkw+iUfkYjpIVqSEdnN2sS3qt7yQIexxcTW6V2OZBv5Z4PWNTeUKbWdQEiVKbTC9qk6JpxUzoKtNBHaBN+YkhR+2NSRyLAXTAIKaXAg5f5rnGkZ6TmvqBN1J4XX1jlt2/R+U/t6wiVNwrjiT9yfp1Ta+CNecr2wJrdP3ASLFuf1xqLQ6eDT+uLvHdHfXA345I7bFnJDrO/FNn9QW5rilKjnDoMPRPWnCjnV6+v9jKRoJJ9py8Oq/glKQAf94ZDhEiE6WEfVUGVdcKZNVGrsgf3CQAnldE4RlmUTOeX4pfZk2++F9Da3KN4vwmcVrSt/79o1bp+nxeHEMnVg6dKvxc3dy+dk+8Nq2U+WETa95IZOoDOdsgpRWGPgrSdtxCVRZqD2Yo+I5wH2QESsZsOURxxDohwOkSef9RQVHequMgy+fS4DSoGpAJkcW744XBgQ3jV83LocEOzKzCepe7RylefOmJb8zm9WyLRdDDeoFmSYq5lbl368otN6uOaNt6thNkdwLk5lwFo1JHV35iZubN2s6a1tbiQH1V1L5Vvi2GZxvcbqNm/2js0l/7KAoX3q7djJg4ANRo8HzUMgtgaewP0WpGXGcaYpsGVDYyD2EU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(41300700001)(86362001)(31696002)(36756003)(6506007)(6512007)(4326008)(8676002)(53546011)(2616005)(66476007)(8936002)(6486002)(478600001)(5660300002)(6666004)(66946007)(316002)(110136005)(38100700002)(66556008)(54906003)(186003)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BWUk1RSTd5ai9wd0pIVkJVWE1JVzV0SnZRVmFwQXFKdFNXNEtJODhmdE50?=
 =?utf-8?B?ZW1NUTR2ZCtSZHMyRXRPTnB2T28rbitYYWdkRFlsK1RsQi9IdUU4NEM3VDRF?=
 =?utf-8?B?UzJ6dGlVcmZESnU2MDVjR01kdEszbVZUMTFXU0dQNTVnTjRtcWRSZ2hiRUtH?=
 =?utf-8?B?ZjNBNHR5TkVySC96VFlWRXFDNk1pb0FQNUMzb2V2QW9uTzVDcUhNdnpuTVpK?=
 =?utf-8?B?TTZMUUl1K09wMUJ5YWs5eERwQlYwYkFvZnRtWGRHTmthQnl3cUkzYUpKczhw?=
 =?utf-8?B?Q2hQbnpHYWRGQWV1MEtiREphUTl4c3R1WUJQcCtQejByWHovRFJrNlA3U3B5?=
 =?utf-8?B?MktpalNOOHQ4TlVMUENLekZQZTBqdDBqYXJWTG44UC9SQlhBWDBVTHBON1Jz?=
 =?utf-8?B?c3hOLy9qbVdNd1NVamVSUGM1SlpqMSs0N1FiSUtQZmVsaTJOR1hUR1Q2S1VZ?=
 =?utf-8?B?M2hwNW1NN2d2RmZKb2sza2dNbEtsZGs5SjBoU3VHclNPa042N2l5N1d6c0Iy?=
 =?utf-8?B?VkJodzdHZVBZTlljR3VhejFMY2diT2Eyd0xMMGIzU1dZUEJSZCt6dFdJV0JI?=
 =?utf-8?B?UjYyVmVObFNZOTROdlNwWTVGSWlkOENHTlNKSzl5blAyRGlJei9HRHlaYWh6?=
 =?utf-8?B?WFVrM3g4T2ZlclZlZkVSaUhOMWlmSU9tQlBMU1hySldEc2RzbWg1NTliS0Yr?=
 =?utf-8?B?WGZoYTYwcmlkU2ZPVmlyaEM1elJwZExSNnEvbzZqWi9UYkcvcDJ1OEZ6dldV?=
 =?utf-8?B?VlRTdVN2SnBEV2lyeExpSFZXNktXTmxweGxEbWIyZllyQ1RTYVVraUR2OWFN?=
 =?utf-8?B?SlZTZmtHd0VGK2RKQWM4T05lTGZzaVZJeTVpRGN5QS83cTY4WDBZTWhZZy9B?=
 =?utf-8?B?eDgxd083U1FMOG5KQTZOc1lXK1ZKbTlZVFhRakRpa0F2ZHVZWGVjOVU0a1U3?=
 =?utf-8?B?eWdjQ2hmY3RrMTJ4S09iVXRBY2VEcXZNdS9lOHBGZlJROThmYmpXWUpZN3VJ?=
 =?utf-8?B?aGl2RXFPZTBldmtHT2dVWmFNSnlXUWZ6cXM5a3hvN1RoMnV6RFk3S253eWg1?=
 =?utf-8?B?dGEwTHNwNEpJSWNxZEk5MVhwTWltTVA1Vi9tNlBQMGxmY3NNVkZlbUdaUnYr?=
 =?utf-8?B?RTBsTGNaN21yVm1VS2FXODl4U0hkWGRZQk9WSjFBaW5GR0dpRGFqbmZwNENK?=
 =?utf-8?B?Vmtud3FhbGp1TTNMNDE0cWZzeDA2MjFGZWQwYkxWRDNWcG8wMUd4eE9xQ0JR?=
 =?utf-8?B?TjZGRGx2d2ZaSW9OekxUTmgrNngzcG1VVUQzaVN3MlZnajZLUkd1MWV4MW5D?=
 =?utf-8?B?eUR5a0RmWkdvOXI1VW14NGFXUTI0Mnd4dm01Q05vc0owOW1ra1FQbVlCVXVQ?=
 =?utf-8?B?QXBPaVE1SXhWd0hNcERkeENUT1hlMGlMVVBxaUl6WTF0cHlNNFhFNmhPay94?=
 =?utf-8?B?MmlXUXlPQlpwRVI4aytJanROUkdoaDVMaDJLZ3pPQTczZFJvVWtsZWxWeDNC?=
 =?utf-8?B?bzhsMHdReUpRRkZJM0hqVXg1Q2xnUkRqeTBQbEJ1M3VzdmxqRlZRSGN3a2h1?=
 =?utf-8?B?ZEFZb1pmNmpMVG9SWWxzeXZYWWd0SnZWcmk5SmxEM2t2aW5nTUxrWWVDY3NK?=
 =?utf-8?B?andzcWVncklhakhVaHBGSUNxcS9QNEtZOEdETmlZb0QyT0N5bEN4Sm4wWWdN?=
 =?utf-8?B?YW1nU2YxWVk5VHRqd0pLd0t2SU9BUG5PWHhzT0Y3RE42NnNaaCtvNGR6L2t4?=
 =?utf-8?B?RXdlclU3WUdIVExRSjRONk9OMkk2aWg2SjdPdnJZOUp3SFVBOS93L3paTnpj?=
 =?utf-8?B?Z0IvL25veHVGT29EYjhRN0RMaHRaUUhZZWxscjVoWkNmMU1nT1VlNXRKYW9G?=
 =?utf-8?B?YjBkdkcrR3NUR2lFVFdIQU4xOXJHQ1ppRm5tQm1RZ1NlK3hLRUtKam1OOEZG?=
 =?utf-8?B?QWFjWWxsWnlvcXl6WnlDbkMyaG5UOVk1MGdEU3JML3hTSGltT2F4dzJHQVo2?=
 =?utf-8?B?ZTQ3cWJsQmk5ZWlKaitIRDA2Q0plc1pOQm5YWTZISFo2VlFLbUFKNm1LRjRt?=
 =?utf-8?B?UU54akZCTjMxVjlhdTVlWWhNY3lKaUkwakV2ZmFIMmhrOFNNWmtHQUY5YmFK?=
 =?utf-8?Q?qRJ9Ns7sR9d645rQuu6Q4U/n/?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9116bd0a-8897-4250-f664-08dab5f280d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:03:57.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPU3RA9p8nAP73SfGWuIFkLDWwwPeErq8fctLlNqCZeJFQseowqMgSuyXDmbSG1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2249
X-Proofpoint-GUID: k_ORIlOGl8rlZ-RdSq-LbcrQr_umZvWN
X-Proofpoint-ORIG-GUID: k_ORIlOGl8rlZ-RdSq-LbcrQr_umZvWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_06,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/23/22 1:14 PM, David Vernet wrote:
> On Sun, Oct 23, 2022 at 11:05:46AM -0700, Yonghong Song wrote:
>> Add two tests for new cgroup local storage, one to test bpf program helpers
>> and user space map APIs, and the other to test recursive fentry
>> triggering won't deadlock.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../bpf/prog_tests/cgrp_local_storage.c       | 92 +++++++++++++++++++
>>   .../selftests/bpf/progs/cgrp_local_storage.c  | 88 ++++++++++++++++++
>>   .../selftests/bpf/progs/cgrp_ls_recursion.c   | 70 ++++++++++++++
>>   3 files changed, 250 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/cgrp_local_storage.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
>> new file mode 100644
>> index 000000000000..7ee21d598195
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
>> +
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <sys/syscall.h>
>> +#include <sys/types.h>
>> +#include <test_progs.h>
>> +#include "cgrp_local_storage.skel.h"
>> +#include "cgrp_ls_recursion.skel.h"
>> +
>> +static void test_sys_enter_exit(int cgroup_fd)
>> +{
>> +	struct cgrp_local_storage *skel;
>> +	long val1 = 1, val2 = 0;
>> +	int err;
>> +
>> +	skel = cgrp_local_storage__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>> +		return;
>> +
>> +	/* populate a value in cgrp_storage_2 */
>> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd, &val1, BPF_ANY);
>> +	if (!ASSERT_OK(err, "map_update_elem"))
>> +		goto out;
>> +
>> +	/* check value */
>> +	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd, &val2);
>> +	if (!ASSERT_OK(err, "map_lookup_elem"))
>> +		goto out;
>> +	if (!ASSERT_EQ(val2, 1, "map_lookup_elem, invalid val"))
>> +		goto out;
>> +
>> +	/* delete value */
>> +	err = bpf_map_delete_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd);
>> +	if (!ASSERT_OK(err, "map_delete_elem"))
>> +		goto out;
>> +
>> +	skel->bss->target_pid = syscall(SYS_gettid);
>> +
>> +	err = cgrp_local_storage__attach(skel);
>> +	if (!ASSERT_OK(err, "skel_attach"))
>> +		goto out;
>> +
>> +	syscall(SYS_gettid);
>> +	syscall(SYS_gettid);
>> +
>> +	skel->bss->target_pid = 0;
>> +
>> +	/* 3x syscalls: 1x attach and 2x gettid */
>> +	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
>> +	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
>> +	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>> +out:
>> +	cgrp_local_storage__destroy(skel);
>> +}
>> +
>> +static void test_recursion(int cgroup_fd)
>> +{
>> +	struct cgrp_ls_recursion *skel;
>> +	int err;
>> +
>> +	skel = cgrp_ls_recursion__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>> +		return;
>> +
>> +	err = cgrp_ls_recursion__attach(skel);
>> +	if (!ASSERT_OK(err, "skel_attach"))
>> +		goto out;
>> +
>> +	/* trigger sys_enter, make sure it does not cause deadlock */
>> +	syscall(SYS_gettid);
>> +
>> +out:
>> +	cgrp_ls_recursion__destroy(skel);
>> +}
>> +
>> +void test_cgrp_local_storage(void)
>> +{
>> +	int cgroup_fd;
>> +
>> +	cgroup_fd = test__join_cgroup("/cgrp_local_storage");
>> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
>> +		return;
>> +
>> +	if (test__start_subtest("sys_enter_exit"))
>> +		test_sys_enter_exit(cgroup_fd);
>> +	if (test__start_subtest("recursion"))
>> +		test_recursion(cgroup_fd);
>> +
>> +	close(cgroup_fd);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/cgrp_local_storage.c b/tools/testing/selftests/bpf/progs/cgrp_local_storage.c
>> new file mode 100644
>> index 000000000000..dee63d4c1512
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/cgrp_local_storage.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> +	__type(key, int);
>> +	__type(value, long);
>> +} cgrp_storage_1 SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> +	__type(key, int);
>> +	__type(value, long);
>> +} cgrp_storage_2 SEC(".maps");
>> +
>> +#define MAGIC_VALUE 0xabcd1234
>> +
>> +pid_t target_pid = 0;
>> +int mismatch_cnt = 0;
>> +int enter_cnt = 0;
>> +int exit_cnt = 0;
>> +
>> +SEC("tp_btf/sys_enter")
>> +int BPF_PROG(on_enter, struct pt_regs *regs, long id)
>> +{
>> +	struct task_struct *task;
>> +	long *ptr;
>> +	int err;
>> +
>> +	task = bpf_get_current_task_btf();
>> +	if (task->pid != target_pid)
>> +		return 0;
>> +
>> +	/* populate value 0 */
>> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	/* delete value 0 */
>> +	err = bpf_cgrp_storage_delete(&cgrp_storage_1, task->cgroups->dfl_cgrp);
>> +	if (err)
>> +		return 0;
>> +
>> +	/* value is not available */
>> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0, 0);
>> +	if (ptr)
>> +		return 0;
>> +
>> +	/* re-populate the value */
>> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (!ptr)
>> +		return 0;
> 
> Should we also add a global int err variable to this program that we set
> any time we can't fetch an instance of the local storage, etc  and then
> check in the user space test progs logic?

I think we are fine here. The enter_cnt below should ensure all above
should not prematurely return. Otherwise, the test will fail.

> 
>> +	__sync_fetch_and_add(&enter_cnt, 1);
>> +	*ptr = MAGIC_VALUE + enter_cnt;
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("tp_btf/sys_exit")
>> +int BPF_PROG(on_exit, struct pt_regs *regs, long id)
>> +{
>> +	struct task_struct *task;
>> +	long *ptr;
>> +
>> +	task = bpf_get_current_task_btf();
>> +	if (task->pid != target_pid)
>> +		return 0;
>> +
>> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	__sync_fetch_and_add(&exit_cnt, 1);
>> +	if (*ptr != MAGIC_VALUE + exit_cnt)
>> +		__sync_fetch_and_add(&mismatch_cnt, 1);
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>> new file mode 100644
>> index 000000000000..a043d8fefdac
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> +	__type(key, int);
>> +	__type(value, long);
>> +} map_a SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> +	__type(key, int);
>> +	__type(value, long);
>> +} map_b SEC(".maps");
>> +
>> +SEC("fentry/bpf_local_storage_lookup")
>> +int BPF_PROG(on_lookup)
>> +{
>> +	struct task_struct *task = bpf_get_current_task_btf();
>> +
>> +	bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
>> +	bpf_cgrp_storage_delete(&map_b, task->cgroups->dfl_cgrp);
>> +	return 0;
>> +}
>> +
>> +SEC("fentry/bpf_local_storage_update")
>> +int BPF_PROG(on_update)
>> +{
>> +	struct task_struct *task = bpf_get_current_task_btf();
>> +	long *ptr;
>> +
>> +	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (ptr)
>> +		*ptr += 1;
>> +
>> +	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (ptr)
>> +		*ptr += 1;
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("tp_btf/sys_enter")
>> +int BPF_PROG(on_enter, struct pt_regs *regs, long id)
>> +{
>> +	struct task_struct *task;
>> +	long *ptr;
>> +
>> +	task = bpf_get_current_task_btf();
>> +	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (ptr)
>> +		*ptr = 200;
>> +
>> +	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
>> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +	if (ptr)
>> +		*ptr = 100;
>> +	return 0;
>> +}
>> -- 
>> 2.30.2
>>
> 
> 
> Looks reasonable overall. Should we also include any negative tests,
> like e.g. trying to invoke bpf_cgrp_storage_get() with a struct other
> than a cgroup?

I can add one.

> 
> 
> Thanks,
> David
