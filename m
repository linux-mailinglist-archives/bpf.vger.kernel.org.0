Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD36082E1
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 02:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJVAdX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 20:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJVAdW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 20:33:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1472B3AEE
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 17:33:21 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M0JimF020714;
        Fri, 21 Oct 2022 17:33:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fRj54tEQSKdHPPKEAKi7m1vAzZgCLGVo2G7xEYSHLko=;
 b=WSoy9EeeUq3/pmP75g0gFsxwAl3l2GV2wyS5vIJoETGyKFyULVARNPLdKActizC6wNnY
 1KuJxulGEVmX6TrfSjw0Z15m46h3s31UImTlJbV3DpSgZ0FVs5fp8Z/KhBGco54NE0jT
 7W/OH9CjDf4BiSvR3T4ByAGdpgVxTiFkth8/cDGGPH4/9J7HLN3aV/RIwjCe4RDp30uI
 cC61QApKB2y4elQwN/XwnAjG5bbEDjXR/mI+ei9u+fd9XNTgI0CeNTTvKZBK+VOOr5Yw
 DfvIBmQBw2MI/Nbco0gGffK5NlliiqsKntOSp41YwSHTQS8kOaFazXk+P4dS/lfGg6VT tA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kbjx12829-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 17:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HywV9q36Ilhx5+/wom0cU3FO3DF2viWpDLXwvOLe5juFlDPKWZYoBDK9bt2DyI1FNpsz4PfTxOMmooHRh63kTIG6lyJ6sLYQZ+PToSla4jFMbgYNaj9NWgVgOYa67fB0HRmrmLXkUOsKBAadiErvqP5z13CqP9MzLtH2Mj5uBawVZhJUr2UWvuEv1LXzRVXLI8uV79bNBxZDH5AJeYNRyeEITVwWu1c73iF3byieGUf2muUivtjUHDrSrxjomtUNDZLqK1NchJCj4dL3bchyGYdDF6DlWLMdz84yK214BNJCPK4qKos+L6ZBMLEMV9DSfmAvBl7oru2hBp6eM4AZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRj54tEQSKdHPPKEAKi7m1vAzZgCLGVo2G7xEYSHLko=;
 b=GKBeO1+6MNDlrxkFGMNTABqsvt23R/DUGadbUXXsZPHanreMVOJVwSK3qVbRKKPvIsXHUoNR/IohJD5I6h6rQkXLb+DthG9T4yfe9JoDT5ljHHx597kxRv4oazPTWFDA6DwD2ibORODGddjGcOE7TbujhLzMd4ToEJegC1e+8B2NAM9IxEIEN2aoX6z7ffMeljbP8Qy7Ega8gAwRZgFznbPdVLC3WAfgHl/v/7zNrRaOZYX96NFaqKaHDpF9yuk+AekPmDqXKmRpBZhxV7lKE6R5Zc1VQaem2qGyZzVlDpiE5XAQZLfU7FxVetA1D05ZyOnHkOB1Tp6R6E8U6XZ41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2864.namprd15.prod.outlook.com (2603:10b6:208:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 22 Oct
 2022 00:33:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Sat, 22 Oct 2022
 00:33:01 +0000
Message-ID: <966cb96e-e0a0-aec5-1cce-a4c9fbc0ca5f@meta.com>
Date:   Fri, 21 Oct 2022 17:32:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Support new cgroup local storage
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221311.3554642-1-yhs@fb.com>
 <CAEf4Bzbi1UwGwnekjpWNZwF2G1_M-64EqH5BaKCf712nR1PUPg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4Bzbi1UwGwnekjpWNZwF2G1_M-64EqH5BaKCf712nR1PUPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1898fc07-ffbf-4ca1-4522-08dab3c4fa1d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVQvWz9PFGG6G1cMAaRXrEuuUtvir838nBY2EZsau5hw84I8vu6muOLNPAiRLYmdqJe6o1wuDFtbQEriLgDEfSEAL5j3E/45YF6WjJF0VOYbd1ZZ8xt8T4K8Pu8LzB7yIE7SRS/JEXdAxMouDOuMul9iMMfoySfp14MdzYpzaLGbbffUjTCTwqZfTaT7+KFBD6jkPjTcMhHh1VFX76GTfeoAUr+9iLbrXAZ/JQrF65aVoyRB0fT9XVU/3pmnBaK92NJDSMxHD9zAowB93+b/9S6sDl2ZhGMU2uiOcJcSJQFtar2lZixwTShKqOdlRbw5UDVacwZBEVZohshrZRRRYi/6JvxIThj9lbZkhrTZsiHSrESbp7JxF8JKCf3tZXPZ5QbvSaBJP4YwRnou4gXjFkqEiL50FdZ0CMhD9fuGGtf1iHTJnom6d/RMEiDshXuxmFOXN5rd7fKfFDGmnDlSRp0aNLFz9JgjvyNPB9htp8qBx7CmnI66jC59BpLC7M4gsx0T4CR9SlXcJs2ZJ7q1tOeCv/2ei37IZavEt5zKVPEAjzb4wAoXTl2eu/BqvlKC3ZZiwbbHE5u6OjhQn7xNqVcrWK6oBJ8CKNyE9pdnttBZ2d1yNqrxROAqc7qHYmMB0m5SfwVvkO7R1nfAygyNxCDGi3qm9CHNZJ7MIEGzPFzGj7TuCjrzC09iQB8DvkfeRWbBM9rwpthqtVn6P+HkbRLnTBeMsB5vrQxj8f08POLfkSvKZN5GZiBRdoqtzcDHmLqFiFIW4+69xPho1BszbV5fOLiIrBvvaEqIXyYb1Tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(54906003)(31686004)(110136005)(316002)(2906002)(5660300002)(6666004)(66946007)(8676002)(8936002)(41300700001)(4326008)(36756003)(86362001)(6486002)(31696002)(6506007)(66556008)(53546011)(478600001)(186003)(6512007)(2616005)(38100700002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFDMzFwcnh6VFNnM3lSVXVlOU03emxDQjRqR08vV252MloxbEUyVDBpNzdQ?=
 =?utf-8?B?Y3orYkVUS3Y2QnU2SHNzQU9STGFlc25GUmt5TEFlYTF3QzVMc1RLQ1hJOC9B?=
 =?utf-8?B?VEpGRitubENaUUtqSFhFTHVZQlpzWHJ5bkVrK0FBbVd1R2VGeDZPTDVPY0tX?=
 =?utf-8?B?NnZHRGJwa0RyTUttMzFvK0hlU25yeE1sUTNZeVliWXVqUmlWUzFnVGMvbzFx?=
 =?utf-8?B?Zm9BRDY4aTB3czZhRlIzZ2c1MHBraFBZYWdHMVpROUUrdVUzVUJLLzgwb2hF?=
 =?utf-8?B?bHpHOS9vbHk3dHF4ZVFXZGVUZE9vZkljYUhyWWdRMWNzditQdWhKcHUrR25h?=
 =?utf-8?B?MzBuREg2cWZwYWdjN3NVa0xpVjF2S0hrZHc2TW52ZEIzUmtERTJBeUZ4TXk4?=
 =?utf-8?B?RTNVenpUSVhFdzhiN1lYczlSYmlYandsRFh0Q1FUNnd5eDBvalN0NlZiTUkr?=
 =?utf-8?B?M3NDK0VSK05iT0tEWTBaQ0pFTmpuN3RZWlVjMC8vWVNFazJtRHM3cUIrZUZB?=
 =?utf-8?B?WE1FNGozVmpyWmZVSDBsUkEwd0hrekdpREFlcFlBbVFFNUVSMmsvN3BkYVFm?=
 =?utf-8?B?MlU4STNxWnoyZVBZU0ZCV1oydU8xaitWcXQ4eGM2UXNZRW9kdlZBOW5yMFMx?=
 =?utf-8?B?c1NlS21zOXUzS2VSRFc3M2pzQ09NQWt5M2YwU09kYk9KYnpKVnVmeE5zdFox?=
 =?utf-8?B?VXczanNVT0xmN1JXSExESFE4dEVRRmhyVEdjTUsrditnTnlXNVRzQVNmeUc3?=
 =?utf-8?B?cDVhckt1aXlKcFIvK05KY2tRVXZTdzVwUnkzeWVHb0hVckNoWThqei9xZEtL?=
 =?utf-8?B?K01melZZRmFNNmlQaFREOENJRkJ5Q1dGUXp1WmhzaU1ucjBOZTRnQWRpdmF0?=
 =?utf-8?B?UnpqbFdWVXRjaC9RQUlPVTk1MzZnbDg5bWRYOVBaUUk1a0lQbk1xTEkzZXUz?=
 =?utf-8?B?YjJPUGh3b3h4WXpsMlZuY3BNYWRFeFQrR2pIL2JNK1VzOUp3cjBuK1hoM0U5?=
 =?utf-8?B?ai8vRVpIRk85ME5iN2puci9EeVVMR2xRYk5qVDZib1FoblJkZ282S1VraDY1?=
 =?utf-8?B?c0xYQWd3R0RNNWRkUVQzcUUzeWxSSG1NSTJ6K1ZjWlYvUUlySXcwNWtobVhX?=
 =?utf-8?B?SVhtanR3TnFUSlNJNTYwWkNhSXovZU5zYkhvdjl1MHczaTVYaENYMHFwV1c2?=
 =?utf-8?B?UTJnbXJ2ZVdZMDJzQ1pKbzVqS1ZBbVlWVEo2aGdSL0p0ZEdvdGdGQ3NkNnp2?=
 =?utf-8?B?ZDBsUWlyVGN4bU1pVnRRWmFmbHVaeTJ3ZHNFbU1Md281R2Z6aU5qcE1tWUZs?=
 =?utf-8?B?cDBmRHVTd3hjdFVrQjNieFJTTVVMODdnRWJNS0VlSFR4MFhkeXdPMVBoTTJR?=
 =?utf-8?B?QkVmdHdkUzZiWFNaa2g3Y3BMRjJXVEZUTEp1U1ZZRHE3Z2ZBOWl0S1YxcFFV?=
 =?utf-8?B?c000bHBnaU9UKzRTYmgzSHhCV3hyYnZXSDhvdldmUkhTWTdjbnh4b3ZrNWlz?=
 =?utf-8?B?cFFaalA2T0ZNbG5CSFlOZFNqUkVCTE5hbFFZd1VIbzR2aEVkUFNmdUhTb1VD?=
 =?utf-8?B?MjhnQ0VsZ3NzeVYxM1hKT01vSFFzRkx1OVZUa0Y4czZHdm0yR0I1bmUzS2lm?=
 =?utf-8?B?elh2aTdnckNiV0J2VERTb0x5TElzUUpNejh1cHNXTkM0QldmdFpvem11NjMz?=
 =?utf-8?B?K0JsM3NPZG9uaXFYTDk1NFppeHF3MjFTdUVGMkMyNXcvZFR2alIrTlB6c2VJ?=
 =?utf-8?B?WmFzZGYvRDJoemVkWm04LzZqMXJ1cy9acVF2Tk1pb0x6NGpUeTdJZWRnSHR0?=
 =?utf-8?B?MkI1aG56dm1tbFJoME9MckgzcWhTSXVUUWtvNFE2bkEyYkVFWUliczJKZnA3?=
 =?utf-8?B?SVVYdUYxNGpXcGpmV211cWhJb3hxdFdsY0EwOUlmNUN5czhHNStYTG5jUnZh?=
 =?utf-8?B?akYrT3NibEpETlF3M2FoM1QyLzRuWGtLQkkwK1AxV29GNitmVzQxMlJJQjU5?=
 =?utf-8?B?TittWGM2ZVNSNGR4Z3VNV05QNm5oMFduWFYvK1Fic0xSbE9Mci9RQU8weFph?=
 =?utf-8?B?QkFVTHlzZ0d4TUxPSVZzdGd2dlU2YWZCOVlKdlpFSmRxSFR2ZkhrUm5OaDVP?=
 =?utf-8?Q?3YMhhyCQ/rtpnhA/Z+dI4uta0?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1898fc07-ffbf-4ca1-4522-08dab3c4fa1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:33:01.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELmo+axmPQmmdwTBq7NMcHIqcOpbFwpSbWt27QJUKMn/ceCjuPVsm1ErLdzHsrdx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2864
X-Proofpoint-ORIG-GUID: 8m5_TkJYjcnioZpBPLyaWlnRA5tkQZ14
X-Proofpoint-GUID: 8m5_TkJYjcnioZpBPLyaWlnRA5tkQZ14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/21/22 4:10 PM, Andrii Nakryiko wrote:
> On Thu, Oct 20, 2022 at 3:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add support for new cgroup local storage.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> 
> LGTM, but I do think that BPF_MAP_TYPE_CG_STORAGE and "cg_storage" is
> easier to read and talk about. But that's minor.

I searched kernel/cgroup/* and kernel/bpf/cgroup.c and 
include/linux/cgroup*.h. The 'cgrp' for abbreviation of 'cgroup' is much 
more than
'cg' for 'cgroup' unless 'cg' appears in like 'memcg' or 'rdmacg'. So I 
would just use 'cgrp' for now.

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   tools/lib/bpf/libbpf.c        | 1 +
>>   tools/lib/bpf/libbpf_probes.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 027fd9565c16..5d7819edf074 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -164,6 +164,7 @@ static const char * const map_type_name[] = {
>>          [BPF_MAP_TYPE_TASK_STORAGE]             = "task_storage",
>>          [BPF_MAP_TYPE_BLOOM_FILTER]             = "bloom_filter",
>>          [BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
>> +       [BPF_MAP_TYPE_CGRP_STORAGE]             = "cgrp_storage",
>>   };
>>
>>   static const char * const prog_type_name[] = {
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index f3a8e8e74eb8..bdb83d467f9a 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -221,6 +221,7 @@ static int probe_map_create(enum bpf_map_type map_type)
>>          case BPF_MAP_TYPE_SK_STORAGE:
>>          case BPF_MAP_TYPE_INODE_STORAGE:
>>          case BPF_MAP_TYPE_TASK_STORAGE:
>> +       case BPF_MAP_TYPE_CGRP_STORAGE:
>>                  btf_key_type_id = 1;
>>                  btf_value_type_id = 3;
>>                  value_size = 8;
>> --
>> 2.30.2
>>
