Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110F4561EC
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKRSGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:06:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhKRSGu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:06:50 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI9x3ud003927;
        Thu, 18 Nov 2021 10:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DFOEf5OQW9Qcmjrm5fhmPmEm1SUiYGQahpfNEEC6kcE=;
 b=gFk35TDe26q02Vl2OayiIMznSXQlvqsIduCj9Vo4SGd8bjdMOdCCUMZk2ZTKh1Qlzzac
 NsY1ABKk0CaiCRUcQZWufxgeQRaOwSS3H4kPxNvXW+4GeP5sespKz6ofqp7q76NELPVT
 dVSLj25+P2Zm/riv+2U0JC6ce4Hnsur+4uI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdmp0kcwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 10:03:36 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 10:03:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M14zJNZ27dwDO8ASZg13xS+1pHfELn5+zk1fE7BK0hKvrJvL8wgyAdXYNkNDwQCNTBbFiYDFG2K/PIhAzVRjdzRsdtYs65qMMn3vczB9tPOVsj7kcM7UTdBG2HcaqVSGrY6lLfA5tLdJ2NoxveK3vDt/Hx63NG0PL6/sTkAOdbA/+9WrAVheHdDc1/B5AqXuC7CGrIFSQBoV6KWePwyF0dCeGF4lXL5129njZkUStFRiFh/tWGu0S/nyxGx9XHVWylhQHfLUVltG+pJo2cTMOuoaA/80GeD/+JLVQI57ysNpK0iGWiawXJvrVQoDvm/6bgVuv1VBFfkPEgpfLt4oKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFOEf5OQW9Qcmjrm5fhmPmEm1SUiYGQahpfNEEC6kcE=;
 b=RH7J9ctXObKrEhB9ph39y8JJnT0Hdr7ZNn/bDye0tm7Wv/Yq0gmmGwL66yXpOBqfhbxCoIphvZlanbCeItA54YfXixHhz7+lqPanZIjIU70qiOuwB4mlhq4n/+cDyGhoj7hPufOggmiQyh5iWDq7MScmokuBOZbptopwSRJbOlTtzxiRTCSbF9wa7aDI3vKWJvBDax4Yz9IZA4RUW1AP32yuQQWybcrynyHv6xWrkFwDJFOI88cPpO8AG2GNzazflBWc9AsOsR1sggSQMpUqQDTAXFDvuf8aSNUpSCt3Hx3J4g0P12Ap2ePL8PUYoiDW30u0g9Qgo/2YA9kxFffGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 18:03:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 18:03:34 +0000
Message-ID: <43eae5e9-1741-001f-45fa-a516f291fecb@fb.com>
Date:   Thu, 18 Nov 2021 10:03:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com> <87wnl5en13.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87wnl5en13.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::1798] (2620:10d:c090:400::5:184a) by MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 18:03:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0703c1d4-9b50-457d-d3eb-08d9aabdbcce
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2031B82269A8684079FA7B8BD39B9@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNRanN3AuO60Rgl/CZf81H4DpqVvLJAOK/w0Ny15BQWqmkl4T0x+Xr7Gtxe97/4g3o65X1HfatJp1RmytGS0UPOIbd3DT9Po76lozjZzg2YoIWOI8Tr9jBTv/iIWvm+4ny7zF/457AV6YMXsuUzCP/N2Q08VkU8EDbBy8D07KCg4VQPZ+CUheifMEssFJLOnlWPCmAWSphLJJsTcbWcfXjjDTpSBXSkyBwSf5AapJ0hI7bCqLLEJAX1TVDqkFASfZjHJiQvsDAvsam4qbIC1IQrffSYQ/YDGOe7ULwx5ohSt3QLdd1lNCQP01M2Tx5AD+jTM6pLeuBi1Z1L9+hxRWYCkAtoN9vK6w7YoyPicW5J3S88BQg1fuBBXVI3tYEUoWOcuAxWObUQKbYAuCGuhfIE0/KDDRd0wbyVVMg/iHOjdv27xz9a6mClt4qGneQixrFikGQyNMb1Nh0biR9RRMFEClBxnWapPmvN1duibsFbFPl7HTzexylcqiAYXMjK/LIWNfzK6eoXA8Ivq7m2fsRFdbSWcfMTII3J0ISn9RLKuGr5K+CdXtTMRxu475wCIOEpTHn2VUrs4Vw2dRJtdpRAbCJeUYAQVzB78ioSy9Ji5Qn1iYnKl2UNm8cNpmYth06yrq/WL6xMAkMVTNwwHu2+/xwXGgJRFGLOcgEeJC7/i7dz9ulATaB4QJPqkXY9hj/N76SOuE2hKozMKdpMqbRpoUQXnsKGdbfaD/sB4zEqMMsGpGVPTCibtf/lX+nxw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(2616005)(2906002)(508600001)(86362001)(6486002)(186003)(38100700002)(66946007)(66574015)(83380400001)(66476007)(66556008)(36756003)(53546011)(5660300002)(8936002)(52116002)(8676002)(110136005)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFB1aW43aGhiSnVsdWdycUVRTEdhVHhkWmpRVEk2QWl2L2d4NmY3dHR0NU5o?=
 =?utf-8?B?UGVMeFhtR1BEY0ZRWFNibGhiV2Ewc05pK1VvTHd0MkJKOVVmTDFXaGVka3Vl?=
 =?utf-8?B?YmxWaHB1aUJ5ZU44L09UQmdDTnNDeUtJRE5jKy9qbE5WQXR2dExUdWllYVVQ?=
 =?utf-8?B?OUVSLzUraW5HV3RMMVF3cTNlSmlrWW1XdG8yUXlVVUJwVi8yTVVsN2lHMllx?=
 =?utf-8?B?K2gxK2dyYjg4VTlKdElZbUFkUi9GUDNXK1Yyd0R0b3VhZG1qeUp5Szk3aElu?=
 =?utf-8?B?QnJhaHF1T2IzdUkydk44UmgrNlhLWk5reGNRc2dSdEF2VkV4NmFNQ1FLRTRV?=
 =?utf-8?B?cDFVZVNOMmdWWGdJNEN1Zncxa25EZGNaYk8venUrQ2M4RkNBSDZVeTJkZEk5?=
 =?utf-8?B?NFJrWDBRejhmOFBJakhEL1pKSXYzam9jWWNKNXJyamFQOUNiU2ViN1JySW1s?=
 =?utf-8?B?Vk9MWXZQQVN2YmMvOGRraFFpdEwxRkNWSnRneWxyVTNEaE42VjJOR1ZUcEpz?=
 =?utf-8?B?d2dIekJQRHpMejRzMEphVDA2aUtlOGNaakl3R1AzYzlFc1A0U3NBN2NhUnB0?=
 =?utf-8?B?VTlyNHdsdHVpUnRzc2VObUxnMWd2RGcwb2JNTW1TRysxZW5tR1hRRzlTUWk2?=
 =?utf-8?B?dTJlSVYvUHBLd0VxaExROFUvMlJSWHhNcUk3U1R5cEZ2c0NHVjN1aWdvWmJw?=
 =?utf-8?B?Y2s0YldoQUR3T2w3RVFPQ2Z4QlUrREY0RDljM2p0ZllxaFUrVWkzNGpmd3BC?=
 =?utf-8?B?YWhHeG9wQjYwUTJNSXV4bzVwbGNDZWdJRGx6VVZYbnBpcHphT2RxL2s2dXhT?=
 =?utf-8?B?WS96bVhCU0ZTa0pzbUl3K1JHVmlpY1RNQ2JhTWY1MUdOUWRXa0N2SGZMdU9B?=
 =?utf-8?B?enZzb05mTmdCWkJHdjJ5bmpENkc1aDJpbDZuMnNhaytOcHZldWFSd3NuUWw4?=
 =?utf-8?B?QS9HK29lMEZudGNnYzU0V1J4RCtsVk5hWGcxYlFrTEMxeU5rTy9FMFRSeVJy?=
 =?utf-8?B?alo3dmdZVzg4S2V6cTJCYmFqeTRlNllkMHVMdDFRN25waFAwRDFYcXNtUUMw?=
 =?utf-8?B?NW8vQ1g1RkQ0cFlFL1FJOUg5VHIrWjBkZEx6YWNpaXo2MldIc3l0bCtibFpr?=
 =?utf-8?B?Vk9sa3krUzNjVG10dnJaQnJBSkRzYnlaMmQxM1h1RlM4ekRUSXlLdkZIZS9z?=
 =?utf-8?B?TkdmQ1NraXBVdHEwOE8wN0x2TTF5V1g3MXV6b3Z0WklYbTFabzJkZG5yUkhS?=
 =?utf-8?B?UjNjVkc5Qlc4K2lIRG1FS0xCaFFINVdHUDhmMDJEVFAyQThCbFVPdVVKUnMy?=
 =?utf-8?B?cjk2ZnhSQ014MmtIWkZsVmFVNGp0UTlWbkV2WUYyTFpGdDZlL3M3Z2hJVUk0?=
 =?utf-8?B?WG9SOUp6RlNuQS9PSmVlMk8wVVRGMisxVnloZVU0cDRIZzEyc2RwdXhEb3Bm?=
 =?utf-8?B?cFh4ZU5CR0ZPNi9sNXdFWnczeVJ0ZEU3L3VFU20wcms3TUNpM0FrMGdLbG9S?=
 =?utf-8?B?Nko0bDV2WkpCeDA0NlpTSE1UcStjVzNKZ1hETUZsRnNjVU1DS1k3N2RVLzdr?=
 =?utf-8?B?Q25ORUxxODZKeVJIZ1g2bE0rV0Y5WEpWTnRjWEhoSkM3NnZITTFITjQvRVBD?=
 =?utf-8?B?dzZPSVNoUU9NU3lGMWQxbzdrZUR4VXB4SVkwS0U0aVlBaFRPcXNURFhhTXd4?=
 =?utf-8?B?TUJZNnBNWW9iQTJtc3ZwS3MzQzFuZ3JLKzg5aDVXTTJjeDdLNC82N1N6UTNj?=
 =?utf-8?B?L01PRnVOazlibmdDcnkwT1oxVFdGYjkrcTZHeE1GWlAxc3pMVmZOd2E2cTRD?=
 =?utf-8?B?U2pBekJuY1FYVGV4SnF3cXY2cGpJLytsRy9oSmo5WXE3ZWRoR2hqRXJKWTZl?=
 =?utf-8?B?WlgwR0h5TTA5ZXRGSGJHbUNhM3psN1U5b24zSStwUFBrVWg5dWozZUtkSjZS?=
 =?utf-8?B?NTAxakxVMlZoUVNTeE9FbklkZEJiTTJpWE8zTkpYREkxV0pCZUZxY0xjQ3Fv?=
 =?utf-8?B?d1RqZjJPRDdPbjZ2UklrWUNHVk1kcVNMT3ovR2JueFgvV254L0xSa2VOQ3dN?=
 =?utf-8?B?cUxFKzhqSjU0dzRzMVNVSFNGbTRrVEtYd3lIQVM2Z0l0SXA4WFdjZ21ZZXJ5?=
 =?utf-8?B?b0ZjbW5qbndVbENiZmJkNGl4ZXkydmhQanlCOWlicWIrMEEyNDIxeEpUVFNU?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0703c1d4-9b50-457d-d3eb-08d9aabdbcce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 18:03:34.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bh2mgYdJXMwgDEoVhhGJg/dmPKWajc3+Zo7q7ViazbS5m1or4oAK5uf9bP1RsC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2KFZtN2loBg9ZqQwYjR4h4-38YB5emtu
X-Proofpoint-ORIG-GUID: 2KFZtN2loBg9ZqQwYjR4h4-38YB5emtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/18/21 3:11 AM, Toke Høiland-Jørgensen wrote:
> Joanne Koong <joannekoong@fb.com> writes:
> 
>> This patch adds the kernel-side and API changes for a new helper
>> function, bpf_for_each:
>>
>> long bpf_for_each(u32 nr_interations, void *callback_fn,
>> void *callback_ctx, u64 flags);
>>
>> bpf_for_each invokes the "callback_fn" nr_iterations number of times
>> or until the callback_fn returns 1.
>>
>> A few things to please note:
>> ~ The "u64 flags" parameter is currently unused but is included in
>> case a future use case for it arises.
>> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.c),
>> bpf_callback_t is used as the callback function cast.
>> ~ A program can have nested bpf_for_each calls but the program must
>> still adhere to the verifier constraint of its stack depth (the stack depth
>> cannot exceed MAX_BPF_STACK))
>> ~ The next patch will include the tests and benchmark
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> 
> Great to see this! One small nit, below, but otherwise:
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> 
>> ---
>>   include/linux/bpf.h            |  1 +
>>   include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>>   kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c           |  2 ++
>>   kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>>   6 files changed, 109 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 6deebf8bf78f..d9b69a896c91 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>>   extern const struct bpf_func_proto bpf_task_storage_get_proto;
>>   extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>>   extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
>> +extern const struct bpf_func_proto bpf_for_each_proto;
>>   extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>>   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>>   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index bd0c9f0487f6..ea5098920ed2 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4750,6 +4750,28 @@ union bpf_attr {
>>    *		The number of traversed map elements for success, **-EINVAL** for
>>    *		invalid **flags**.
>>    *
>> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callback_ctx, u64 flags)
>> + *	Description
>> + *		For **nr_iterations**, call **callback_fn** function with
>> + *		**callback_ctx** as the context parameter.
>> + *		The **callback_fn** should be a static function and
>> + *		the **callback_ctx** should be a pointer to the stack.
>> + *		The **flags** is used to control certain aspects of the helper.
>> + *		Currently, the **flags** must be 0.
>> + *
>> + *		long (\*callback_fn)(u32 index, void \*ctx);
>> + *
>> + *		where **index** is the current index in the iteration. The index
>> + *		is zero-indexed.
>> + *
>> + *		If **callback_fn** returns 0, the helper will continue to the next
>> + *		iteration. If return value is 1, the helper will skip the rest of
>> + *		the iterations and return. Other return values are not used now.
> 
> The code will actually return for any non-zero value, though? So
> shouldn't the documentation reflect this? Or, alternatively, should the
> verifier enforce that the function can only return 0 or 1?

This is enforced in verifier.c prepare_func_exit().

         if (callee->in_callback_fn) {
                 /* enforce R0 return value range [0, 1]. */
                 struct tnum range = tnum_range(0, 1);

                 if (r0->type != SCALAR_VALUE) {
                         verbose(env, "R0 not a scalar value\n");
                         return -EACCES;
                 }
                 if (!tnum_in(range, r0->var_off)) {
                         verbose_invalid_scalar(env, r0, &range, 
"callback return", "R0");
                         return -EINVAL;
                 }
         }

> 
