Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB79443D17C
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhJ0TQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:16:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51824 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240526AbhJ0TQb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 15:16:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGZSnA019485;
        Wed, 27 Oct 2021 12:14:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tAkY3MXW8DEGNAPl9udLODSA83mbOz69FszY8uzectw=;
 b=TQlpPupt7uIJcUwRdT8yrNhKVFsns2BDWccLj+UeXxaYy41fVYPAB6ysp5C80SgY8y05
 y8ez1iMP9TprD8NfD90XYWWtMg1q6SWhewM7axKef83/lRkYuF9CcH65ziWKVCFxwlbj
 jZv4NyPyzG/LXH5305Y/Sw8jlhQFBVk28QY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxy9e7395-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Oct 2021 12:14:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 12:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpvMRFNBghPXa7gkXg8gvuHnp04ehRAS1dbajicK9yjnQ0E0pTxX4qg9jENZ9GBiKsiG3EqQ26GmyqBAqHm95kCnI/UWNNhrcKX/BUxB+NpbNwT6Wxj7DOnA/OWOe14lQ70o9dIyO3aan2CJXTk9VGHq13z20PcWSMc6gJrY1TGAvbVwUqk1KFqJHGJoEaEm6vN0GecvSuN4wvwGt2EDw6WaXFLQM+t8YNN7rekPAI9PSlo0NbfXMllL8E1zpon8pM0Wkd1JrNvznKLC6IeI5+cK/Dn/n8qiyWONJIVSN7wjB2ETNYFpxCA6swT3PDYqK1pANKmYQqgoeitRQVmeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAkY3MXW8DEGNAPl9udLODSA83mbOz69FszY8uzectw=;
 b=n2efORZaDZ9xEq+MGl756hGaf9/ddm04hiTQIp+MmP9yc+qGthlCyUK4pIe0JH/IR2GmZOmGgBX1tKq6n7i3tzwr+5KId4e6GLtvMAhNPHqxscieoOk0DENGzumu8iVYJpK3nAagUQGxuSLiAG+z5ff6ftReHbDvBpXgNtDWxFCcX+EchUQYdodjTsLii8ukdzr0l0yu1hzSFwkfa/DArP8wIOrJ8YooWracBXkTSxAVPIeU/OiK1w70X5WRNWT43xGtyqcu0nd/37WsUBiwi03TMnu1vMhQoVtXbmas8Ma7BOCaqUbWSbBdrwsEIrlyRMVDxmFn8JjhdswJOXbZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2397.namprd15.prod.outlook.com (2603:10b6:805:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Wed, 27 Oct
 2021 19:13:58 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 19:13:58 +0000
Message-ID: <8c07e81e-7dc2-2ae3-6109-b15ad3da4850@fb.com>
Date:   Wed, 27 Oct 2021 12:13:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v5 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-2-joannekoong@fb.com>
 <086460a2-6213-2b1b-9368-166229a91847@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <086460a2-6213-2b1b-9368-166229a91847@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:300:4b::17) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::17ab] (2620:10d:c090:400::5:8b71) by MWHPR02CA0007.namprd02.prod.outlook.com (2603:10b6:300:4b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 19:13:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca017427-3e51-4e86-76ac-08d9997ded4f
X-MS-TrafficTypeDiagnostic: SN6PR15MB2397:
X-Microsoft-Antispam-PRVS: <SN6PR15MB23970BAC3F39EE00F3742900D2859@SN6PR15MB2397.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFqz/BfSdV8nc3ucbIvinzaZG/jomgF1DGmOKyT7tI/DincoQTsvGSwWCUcstpUrANaJ9lMECq9XSVEKHcsxFGLeFzC560IlnCIItjP5TLuDkgTxXPQLV4/6larVJlbCX1MYwwBVObVBv462MbarxxEoqTRwbHlsyJ/Qt35hBujD2VpuQFUR1cw105T4Ez5elmVtZucQWOm2LvWhdLgm1xWcPX6HYo+81eEEzqFsX7Lk8MyGkRAPqkZ9UpMeHnuINCFMN6WlHWUQkLfUPB2lTFdK6FZE9dhNzUCNEJeCkIS1V9ptrebFlAtp2eh5BlwDXoB9LIynk+yoOAURc6oD15gQ/glU62qKrc7m7SHJm6TybU2KBw9lu017qSa0zZQt4NEt+O37Y8Ko2DbDGAQxSYSg/y1vG3W0DC4mGPtkSaCwpytS1mqoZpIkeG4hKaCP3Lab85yB7+7IlMzRBFlclPbPQWJ/MDODFETHzx8TBKwG1s1Zs619HpDtFVE5r666QjbxIqQInMIkAFr1bVfWLgeXXYHABPs5c3MhMEc6WPjIqE/H9oCMqq1QzGQuwF56rSZifWC7uauYVCCSiAEPYmvUPCNwamcZ4X+BqQbdXscMJPgvWuU9V76A4912scx7eHcWnavVI8FD76H+LakLsc1TGONxd+9EfMfZXTuRO1b7NTRei5e7NUC9w7MENucafncQhW2TALVFg8JHbd7+LJFigUSDuBj0d3DPlRFfU9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(316002)(86362001)(6486002)(2616005)(5660300002)(53546011)(508600001)(66556008)(36756003)(31696002)(66946007)(83380400001)(186003)(38100700002)(8676002)(66476007)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtqSW84UDZ5UW5RcCt6U0syZERIRUc0YXVacmprME9EZGlmbEJzUnNCYVZJ?=
 =?utf-8?B?VnJuUXhTQTIzWEZoNlVVMEJ4MzdGT0ZzOCtVVCt0dFVHTGRwb0Y5WWtpNDRY?=
 =?utf-8?B?bmZVODFobytEZEVsQ093RUMzL005QmFZUkUxYXNYK1drMnZjYWFZdmlQTGlQ?=
 =?utf-8?B?Mm9FbjMySXdoak91aE9KNHEyclVrQTBIOW1QWXFvMTk2bC9UNnJWdE5pMjVU?=
 =?utf-8?B?NTFMTkpYSmw2WS9WemhHQnJ0TmxOWEpGNExBekJPL3h2SytMRWM1a2FrdHdD?=
 =?utf-8?B?aDFiK2E2YWh0eGRjcHlkK25CbittejZaYVRJaWhUaTh4TU9rRFJIOE83U0h2?=
 =?utf-8?B?S0RwT3lKSW5aU2IyR2JFMmh4VU5lY0QvUm9LRzZJRDVVMytueXA0SlgvM3kr?=
 =?utf-8?B?aWdYY1kvdzNIUm12U0p6NVhSSG4wTmpORllmOVhFSittNFN4NmdJeE9oYlp6?=
 =?utf-8?B?bVhXOGhXTzZYRmxESnJEM2twL21qVHpVVFNYTmpJenhqcXUzaVhEaklSUFRC?=
 =?utf-8?B?cmd4aGhBcUkvb245WmJOVmtKam1HMHIweHZHL2ZvVVhHVzVWU0pDOFpoaEZY?=
 =?utf-8?B?RmFsQlN2MVZ3OEZQc3ZDdk85ajZKMDQ1YlFmUGMyaDlubmJPMll6YlE0cEsz?=
 =?utf-8?B?ampCNEIvY2t2TTRCR291eG1JWGtXRjBIYWt1UllGYnZnZ1Zabit6QkxuajBt?=
 =?utf-8?B?Vit4VkRETHkvb0Q3UUZ1OWFoby9Yak9CWE0zOFkwamhjQVBPakVzUU1HQ1JU?=
 =?utf-8?B?T0RUL2Z3elBoWEFqQ1JRWDh6Nlo0TGI0Rm5Cb2c3Y051T1BhaSt6V3YzRzdj?=
 =?utf-8?B?ancyVWtNMVgyZm5PbytnOVRYaU9TOGFLMnJPRXl6WU9vZWxtU0dla2k0Qk1u?=
 =?utf-8?B?V3JoZ0o4UTFydkpXb0xHa3VLdzlIVFdOYTZ4dThsdDM3eGJJUS8zMWNjeE9t?=
 =?utf-8?B?VVBaUTVmQkRKT1hnVWFKNEZGRDRvZFRnV2Nrb09RMFpFZnZjKzRHcGkzVGlI?=
 =?utf-8?B?dlROanZIVVZzNkdLY29sR0dZWVhwOXZqTkJwSjhUUkJQY25nUlRIRnhaMWZ4?=
 =?utf-8?B?V2ZBSWhxd1B5REgyVFA4OVdocHRqNVBYcUMzYUdydVFXRDByc2pnUUNNV3ZC?=
 =?utf-8?B?QnpxaTAyOFUyOHJxNkZlNW5qcGdINTlVVlpMM2JEeTgzMkVRMytkMUJNM0xZ?=
 =?utf-8?B?ek1QM3U3bkRWRHg5ZTA0S2xBT3JPS3lCTUtwWnc0ZG9vS0l4VTNCbHFpOS9L?=
 =?utf-8?B?UklRSG5UR3BDY0hROU40cldtUmxPSEl3SFFLNjV5MC9lMVpMZE1UdGFWVEow?=
 =?utf-8?B?TDBFVkFUSjQyQVYrV2lUbDU3M0luZUUwRFR2WUVhNVNlbW9EZWJVcHM3aE56?=
 =?utf-8?B?cUR1TTRYMjZHK2FLTkw5dzZXZm41elBYNmdlSHUwQ0xmd3gveXFiUFpuMHlX?=
 =?utf-8?B?TkQweSt5b0d5aU1TUnRIbDBKY3NLVmdtVjZxRVpHZGhBNHl1TnpiZ2ZNQ0ZK?=
 =?utf-8?B?TFJNMFFhV0YxbUZ5WTUxOCtCLzJOMHZ2V21qbzJIRXpXTkFPRElGODBhV1JE?=
 =?utf-8?B?K3FBMEErTWU1YjJjN1ZZZmZFTG5xWElpRzk0VytNUkdoRHV2eHd4SzZwZE8x?=
 =?utf-8?B?Z3dzSWh0L1I2dFhtQWpBS3Vza2hsQnV4cGRQOU5UWmhKZGFPUjYrUkNNaDMy?=
 =?utf-8?B?TEMrdWpsbHIwaDFvazZ0VllOTEVSZUtTQVo2VUxQQmkrVlVsSFpNQ3JRM3pN?=
 =?utf-8?B?RzJSWVhkMWJIWjJxNVFGSm9XWlRRa2syZUllc1BTN0lwazRPSUp4ang1N0NJ?=
 =?utf-8?B?L29laTJRNWg3eW10WlEzTDA0L1Y3c3VYN1Yvb1JnbFJaVEVHQ3JVQVlQMlZF?=
 =?utf-8?B?djRyRW90L3pMV0ZUTy9YODh4QVMyT0U4Yklucm9FVG51MlpDZGRoSGVpaHpS?=
 =?utf-8?B?Y1BVaWhJYjFIOTRqOHpuQ3hremhLclV1Z2xBdkVnSlZCUGRLYndoc1QxenU4?=
 =?utf-8?B?ZmRyanRscHlRd0RSQjNIRnNqRXRlS0lIeTd4ZUh0QmRiNXRZUEVBUmtMdlRH?=
 =?utf-8?B?aXFFZGRpL2ZRcDV0Z1d0T0ptWHNac01BYllWV3BjSU5jR1JqVE94aXFaby95?=
 =?utf-8?B?V0VxaE0wZE5xMTZ3VC80MEdaemZFaXczYWRoa3JVdW5YWVVNZUtWSGhXU25l?=
 =?utf-8?Q?IjXv+7TC4xMVUhidk6GsUYcMNe2+Bk2o65h5t+L1j5K7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca017427-3e51-4e86-76ac-08d9997ded4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 19:13:58.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pX/vV7rmHn6XBQVy6XQ+ZYRRGgIdnnBsW4rIVuKB5740nhZZE3qUmkHJyGSMa7NebfXNs7iozBDJJsjYBoNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2397
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: EV6Rg_4QCsLdqmDSMfDUxzamTnKhi2N9
X-Proofpoint-GUID: EV6Rg_4QCsLdqmDSMfDUxzamTnKhi2N9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/21 8:18 PM, Andrii Nakryiko wrote:

>
> On 10/22/21 3:02 PM, Joanne Koong wrote:
>> This patch adds the kernel-side changes for the implementation of
>> a bpf bloom filter map.
>>
>> The bloom filter map supports peek (determining whether an element
>> is present in the map) and push (adding an element to the map)
>> operations.These operations are exposed to userspace applications
>> through the already existing syscalls in the following way:
>>
>> BPF_MAP_LOOKUP_ELEM -> peek
>> BPF_MAP_UPDATE_ELEM -> push
>>
>> The bloom filter map does not have keys, only values. In light of
>> this, the bloom filter map's API matches that of queue stack maps:
>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
>> APIs to query or add an element to the bloom filter map. When the
>> bloom filter map is created, it must be created with a key_size of 0.
>>
>> For updates, the user will pass in the element to add to the map
>> as the value, with a NULL key. For lookups, the user will pass in the
>> element to query in the map as the value, with a NULL key. In the
>> verifier layer, this requires us to modify the argument type of
>> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
>> as well, in the syscall layer, we need to copy over the user value
>> so that in bpf_map_peek_elem, we know which specific value to query.
>>
>> A few things to please take note of:
>>   * If there are any concurrent lookups + updates, the user is
>> responsible for synchronizing this to ensure no false negative lookups
>> occur.
>>   * The number of hashes to use for the bloom filter is configurable 
>> from
>> userspace. If no number is specified, the default used will be 5 hash
>> functions. The benchmarks later in this patchset can help compare the
>> performance of using different number of hashes on different entry
>> sizes. In general, using more hashes decreases both the false positive
>> rate and the speed of a lookup.
>>   * Deleting an element in the bloom filter map is not supported.
>>   * The bloom filter map may be used as an inner map.
>>   * The "max_entries" size that is specified at map creation time is 
>> used
>> to approximate a reasonable bitmap size for the bloom filter, and is not
>> otherwise strictly enforced. If the user wishes to insert more entries
>> into the bloom filter than "max_entries", they may do so but they should
>> be aware that this may lead to a higher false positive rate.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
>
>
> Apart from few minor comments below and the stuff that Martin 
> mentioned, LGTM.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
>>   include/linux/bpf.h            |   2 +
>>   include/linux/bpf_types.h      |   1 +
>>   include/uapi/linux/bpf.h       |   8 ++
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/bloom_filter.c      | 198 +++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c           |  19 +++-
>>   kernel/bpf/verifier.c          |  19 +++-
>>   tools/include/uapi/linux/bpf.h |   8 ++
>>   8 files changed, 250 insertions(+), 7 deletions(-)
>>   create mode 100644 kernel/bpf/bloom_filter.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 31421c74ba08..953d23740ecc 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -193,6 +193,8 @@ struct bpf_map {
>>       struct work_struct work;
>>       struct mutex freeze_mutex;
>>       u64 writecnt; /* writable mmap cnt; protected by freeze_mutex */
>> +
>> +    u64 map_extra; /* any per-map-type extra fields */
>
>
> It's minor, but given this is a read-only value, it makes more sense 
> to put it after map_flags so that it doesn't share a cache line with a 
> refcounting and mutex fields
>
>
Awesome, I will make this change.

One question I have in general that's semi-related is about 
backwards-compatibility.
I might be completely misremembering, but I recall hearing something 
about only adding
fields to the end of structs in some headers under the linux/include 
directory, so that this
doesn't mess up backwards-compatibility with older kernel versions.

Is this 100% false or is there a subset under linux/include (like 
linux/include/uapi/linux/*)
that we do need to adhere to this for?

>
> [...]
>
