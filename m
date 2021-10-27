Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9385A43D0E6
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 20:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhJ0SmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 14:42:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240281AbhJ0SmW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 14:42:22 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19RGZLhY005372;
        Wed, 27 Oct 2021 11:39:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=82Aq6jIheTZmp8XE0muAttf+CSHTs5n855HFApE/c3Q=;
 b=UwhM8pMZrm624HxU9ie3cuF1os1KO0VnPDU2g6tDplDKwnooJ+pycFNZ7JgKzkER4ILF
 5xkLxlrKaAb5x7Rx2NSAAsKZdCisgkA7GTdBuWmupd2+51hqfxIIf/xWJkGKZqaynwTL
 q4MBPZnJtlWWtAbnmN5an8h7dzxB1+iPmCw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3by7psuq47-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Oct 2021 11:39:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 11:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ech4WECGt43o7prBc+g2SICU6pOJv6vLeqqEwuPbgt5g/0rP2iUS7jay+WjIzChO7UcEh0Hwc8Tn79LUP5hrNtwf5+zv8TYK+LLrvY0ybsFVOYLkNrlGaUCgtvtpCw8pcR6m3D60ZtQrfnhGfqVpHXVrALYUwo1TP9J8NWKV+bjX6Qjg8Nt7xCcZknmMeBnzUWjf44IeRPSDW3h/t2sli5W76oVltkUOjxPJm293tpm8esauMqggzh627Vg3I/iKCxAlxPeU/mOmbZ0K51AabQjN9TJ8v+d37Zlvp10ivxtrzOt02WkXP8ONG6/dGzU8iYowVmvLGG7ASQP5KKB19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82Aq6jIheTZmp8XE0muAttf+CSHTs5n855HFApE/c3Q=;
 b=kiwfrwaOsTBoON/QRaCv9991MTZFBPpZ+i5E2gBZcMS80aTQnMQWLQ5yL1ynz6pgyGDcWcbabwZDWQ/8IdwHyBVh5X2gMzeJigydRfq58Bs6+GLn/uZ4gGm+oGxy+vHsY1yXM6nETsIFbhOleoiBsVcThjOJBQr1vt8E8RRjWGAUDgdZQpCV0T8Yth2PE8xwbtHcmLYe/aa3N+93gtCnlXYY952dBBqrZ55ximp3boM3f2IabYVWMf7HQmvQ+KhobEcms/oD1LOJ+ATUqQtcfj5cHFHgTkoX91UuK8l6GShfPNzKs3LOceWdAUz+EPyvh8Z56ulYB/WUvANRYHx3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB4031.namprd15.prod.outlook.com (2603:10b6:806:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 18:39:53 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 18:39:53 +0000
Message-ID: <1d6fff4c-eaaf-09d3-7d9f-4d5184048fd6@fb.com>
Date:   Wed, 27 Oct 2021 11:39:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v5 bpf-next 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
Content-Language: en-US
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-3-joannekoong@fb.com>
 <3bc83103-6c5a-6cfb-9ea3-1b98fb50352b@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <3bc83103-6c5a-6cfb-9ea3-1b98fb50352b@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:300:117::11) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::17ab] (2620:10d:c090:400::5:8b71) by MWHPR03CA0001.namprd03.prod.outlook.com (2603:10b6:300:117::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 18:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6135f00-9923-44eb-2887-08d999792a67
X-MS-TrafficTypeDiagnostic: SA0PR15MB4031:
X-Microsoft-Antispam-PRVS: <SA0PR15MB403143494F2B4BAC4F1F7D22D2859@SA0PR15MB4031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLcFO2Kg6534AufQYScL8U5hx5suM/Eiqqq/vSgbaT5ircQ3TgN0VG5Rq7jSu77naY5mgJPz8v60H/7VqEkScThmR+ilLh28QuFQBc3UkVWghmi5pnOaagNVkd+h63SUQmJR8GRNVu3DPTzeaEPOOHlI5L1fupVWNkfCTvPfR8oJVCaPQOzTPQqqhIGQLCkm2G/jaUu6I77aGCCD+ubqxWMovovRFrIhlX1ow63Qg/2mTbaqTFPtH64Gv8dGISQ4Me2X8KBheY4I3/KtGd6dQuCMod/kYMMWKx6Oqx24Nbp1P9H1eydIPwQb6MxjS04+p5EUoZL5fCFBsTEnmPnKpz3Cd49v8Z9C6S6osuGXV0rwbxlNHJJpY11fp4A3WYz1+V3Cv/BbJzQItqiG0B5K9CRz3wT5K8JgYMrfJZJNEEW3F8XnzVQ11pLpeUW3ESo0BaRk20zZJQyEO1fsC3ZtYIpKU5a26X+ICeJkAivNk/Xg4Z3JwLfjzucwzamGh5QKODNLi/dv51ymYsEVO5TT9KrBl4tH/UIUARRryTCoZmeVD/jCitnyGRMVT6NgBjjnhrirk+aqUNsMzidbGf6YH3K290yAABb6el96pIwrx/R0pTsXmDgnN1na6e/AurE01kv4eST0xvKnc8l4GoDdU1bdulEQmPhgMvCO4+kpl8Slfzaj0sxFNA1Od8uycfm7eQC7aiC7mnAw+njf46dyYKc1jJ3a+GhCDV0bgdJaG/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(2616005)(36756003)(4326008)(66946007)(31686004)(508600001)(8676002)(38100700002)(53546011)(31696002)(83380400001)(66556008)(186003)(5660300002)(66476007)(316002)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklWZWJaVnRpWk5MODh4L2N3bDRTYnowWUFGNlQxUVpMSHNnY0cwNmtReUI4?=
 =?utf-8?B?d3RpL3R6cnRja00xRnlqMGJQZ0FuOXZaYVM1aEpvQ0Z4bTJoNFBIWmhjc1Bl?=
 =?utf-8?B?TjRkYjhJVkNudk10NHR5RFdEcEJsaDNJai9udmc2N0xLTW5HNkdqK1d5dGEx?=
 =?utf-8?B?WDVOd2VSZWIrSFZ5QlppSU92UnFNWktia3dlSDg1TFoxdTdWWTZnZUdQS0NC?=
 =?utf-8?B?T3A2NDRXWTVNRkZhc0lLR1BuY1R5amt3cUdXV0NDb20wa2Zpais4bnlIYmJv?=
 =?utf-8?B?a3F5Z3JJTi9yZktpZWJOQUtLQm53Nzc1YU12UVgySFExeW9sOWhrSFN6aHkx?=
 =?utf-8?B?azdUaXNZTnd6Rm0raFh6K1ArZ2VObm1CK1ZabWlOT3daYmVna2FOanRqOVBi?=
 =?utf-8?B?ZzRPN1piczlqd2phUEdUUytrcUNjMHdQVWw1YnJMTi9lMlduTnp6S3Z4UXUv?=
 =?utf-8?B?TkFJZnR4MDlSWExSaHhzYXpGY1dXcUE0WkIzTGRLc3h2bFY3Q3BLaHBNeGdU?=
 =?utf-8?B?YXFRTE0zMUJGaE9iTEhSVE9SYkdYaUxLZ3RIcUpORGFOcjBaVVQwWHdoREMr?=
 =?utf-8?B?eTJMbUErTUd2RzRLV1hIdlNoNGc3UHRkcGhsbkZ0RUVpOFdMckVPaVU2V1ZF?=
 =?utf-8?B?cnNQaFlWMzBBMkczL3doZnVKa1lmOFRWM0RidXpZOUtaQ01CZDdCN3I2c0Zm?=
 =?utf-8?B?ZWFLdytEN2RsU253ME5LdUJKQXAxaVZJTlM4NHh0MHpqMkVPMmswTTF2dklv?=
 =?utf-8?B?ZTdVL0xFQ2Q2K3kzMkVZQWdUeXRnYUhXM0F3YTBQWGI4RUNrU0svcnBORG45?=
 =?utf-8?B?cldpV3cycUtHZUdWemhuNVJaVlpEdUZ5S1V0cGFrV25ldWZmY2Z5bDRNNVFK?=
 =?utf-8?B?QlI4MlR6V2RlQnliazM1eUV6c3VnTlpheFRqd2hlLzV5OVAxK216TjlzOXNj?=
 =?utf-8?B?RU9nSVlkR3FEMUZxTWN2OU4vbnpFTGFDM2JUVk5PYzMwQSs2UUhmNnFhTHhC?=
 =?utf-8?B?ZjRFV09XTGRDZE94S3NFbHl0MVBHcDFvMEVyQkVDazN4UkRDUFVWRVVDNStV?=
 =?utf-8?B?U3psdmtRdFQvZlNwQ1d0VGhjSmJmQjlTbmo3ZG93S3J1Mk43TnVtMDNHZW51?=
 =?utf-8?B?anhMWmswdWVVeHA2NEpaNDdpRGcvejBrRnZablRVUXAyUks0U3ZydE40bDZX?=
 =?utf-8?B?bUN6Ny9IVU1CanQ2Sm03THF0ZURJb3VnWTdYVUtYcUpTUHlUVHl3MmxndlI2?=
 =?utf-8?B?cTErVE90eVMvZG9BM3l5dGp4alJ5Mks1Z3JIMHpEY3F5RlNmTU1wZEVBN2sv?=
 =?utf-8?B?YndIMUlRSEt4VGx5U1hxb3h1UlZ6Yk12Y1ZUN0JMT2lUTndudHpkY0VoWjlj?=
 =?utf-8?B?aUc3dXN5dnN1Q2xlZDBUTmtiUkdWazliQnVaVzYvL0lXSFdCZHJTR0pia2w2?=
 =?utf-8?B?RmFXcTFCWDl3WE1TWlI5TTUxTzhlVm9pL0ZFWkNGY0xXMWRHd094ODNEVG4w?=
 =?utf-8?B?OFlOM1BxOStuY2RDM1FaV293eVVBWkJNYUJHc2phb1hxRjN2Nnl2djNGU0p2?=
 =?utf-8?B?bzVMMmtDemlHeGtiUU95MlJGREMvUDNxWVRhTU5DdCt4c21mR2cwZ1k5V2d0?=
 =?utf-8?B?b3JzdHFNRnhqemhCTVpxTjE3cTFxWmZqdnArNTNxcEVtcW11KzF4S1FOVDdt?=
 =?utf-8?B?eE5YSWxEM1FYbXAyekxCbHl6Y0JvUzR6UlNobDdMVzQ2N0RLdERFNFUrWEpV?=
 =?utf-8?B?ZkszOUFHQVJBeGtFZmZGdlRGU2tuQ3FvSTlLN2pGV0xUUGR4Y2NWSmVNRkVv?=
 =?utf-8?B?V2tpTkxwZXJ6Uk82V0l2L0RHaG9YTGlXL0pHeEtYbDBXTi84cktuU1E0b3kz?=
 =?utf-8?B?M1J1MlJtcEFOb1kraUpvaXE5ZmI5TnpLTU9rcVFhSSt4NjM5bkdiSm5YN245?=
 =?utf-8?B?RDA2aHgvdDFYU2lleHdCWjh0RGlLMThHYVJwazdTRmc0dHQwanJoRDN0MVUx?=
 =?utf-8?B?OStKSEI5emptQVR3eSttWHRLQjMyYXZxTzVCWGUxaWpEaFcxbnZwN29iVnJq?=
 =?utf-8?B?SE42aU9MWmM4bWNQR2wwd0R4OU50b0M2TEQ5VENUb2UvTGR6ZVFzRjFGcWIx?=
 =?utf-8?B?UUNHaFZFSEV3RTZXZ0Q4M1h6Q3Vqajk0YmxkcmExVlN6cEx1T3ZrZkR1OXNu?=
 =?utf-8?Q?hy4IAwxb/K/s5YTm1hRYzu7ZQzbcAWO2hEovN8KF4FQK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6135f00-9923-44eb-2887-08d999792a67
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 18:39:53.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmFTsPq+vGTQxeHk/NgQhEEmRFMbgI2udId00z+gGT6ljp5igSseXHnzMpmsF9sDxiKdFqLMtkZ+YZsCPVukkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3ejJVH8P2wLI75wTNV2sXpwZOoNpMz8z
X-Proofpoint-ORIG-GUID: 3ejJVH8P2wLI75wTNV2sXpwZOoNpMz8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/21 8:30 PM, Andrii Nakryiko wrote:

>
> On 10/22/21 3:02 PM, Joanne Koong wrote:
>> This patch adds the libbpf infrastructure for supporting a
>> per-map-type "map_extra" field, whose definition will be
>> idiosyncratic depending on map type.
>>
>> For example, for the bloom filter map, the lower 4 bits of
>> map_extra is used to denote the number of hash functions.
>>
>> Please note that until libbpf 1.0 is here, the
>> "bpf_create_map_params" struct is used as a temporary
>> means for propagating the map_extra field to the kernel.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
>>   include/uapi/linux/bpf.h         |  1 +
>>   tools/include/uapi/linux/bpf.h   |  1 +
>>   tools/lib/bpf/bpf.c              | 27 ++++++++++++++++++++-
>>   tools/lib/bpf/bpf_gen_internal.h |  2 +-
>>   tools/lib/bpf/gen_loader.c       |  3 ++-
>>   tools/lib/bpf/libbpf.c           | 41 ++++++++++++++++++++++++++++----
>>   tools/lib/bpf/libbpf.h           |  3 +++
>>   tools/lib/bpf/libbpf.map         |  2 ++
>>   tools/lib/bpf/libbpf_internal.h  | 25 ++++++++++++++++++-
>>   9 files changed, 96 insertions(+), 9 deletions(-)
[...]
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index db6e48014839..751cfb9778dc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -400,6 +400,7 @@ struct bpf_map {
>>       char *pin_path;
>>       bool pinned;
>>       bool reused;
>> +    __u64 map_extra;
>>   };
>>     enum extern_type {
>> @@ -2313,6 +2314,17 @@ int parse_btf_map_def(const char *map_name, 
>> struct btf *btf,
>>               }
>>               map_def->pinning = val;
>>               map_def->parts |= MAP_DEF_PINNING;
>> +        } else if (strcmp(name, "map_extra") == 0) {
>> +            /*
>> +             * TODO: When the BTF array supports __u64s, read into
>> +             * map_def->map_extra directly.
>> +             */
>
> Please drop the TODO comment. There are no plans to extend BTF arrays 
> to support __u64 sizes.
>
I see, I will remove this.

If BTF arrays never support __u64 sizes, then people won't be able to 
define a map in libbpf
that uses bits 33 - 64 of the map_extra field, correct? Or is there a 
workaround for them that
I'm not seeing?

>
> [...]
>
