Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC216486004
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiAFEyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 23:54:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231971AbiAFEyP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Jan 2022 23:54:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205N7PfB005928;
        Wed, 5 Jan 2022 20:54:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hJVl1tlnpiW5jfxh7ssd8Y1XV7Y8UoLpNWs+tDFmz8o=;
 b=IdC1k4RzrcPizDpjF8Paqhw2k4fjziuUCWhgXylKkjxhjtsgcUOp+m2xwHlV9N7MFO8s
 EXhw51qXFFSbOIIRIogBNBxheEsfxIswqVQa6/UrK7gp5upj3rYSX12nFj1gjIEVq6ty
 IjFFcQV2bN95dRIQbwZAFN5ATp2czZRuG7s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ddmqshav5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 20:54:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 20:54:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7k1FMTsm/2rLpS3vT2Q5slgdnfZR28RuYOR7YNtjEguecdIuQDsRhGhpP4ds2EcEPXD9gqC9oRogbGVcegnKKLqM8KNlluZq4vhPFW7Ph3plViiyZqfi1SMbroRv9+t2ZgMqOZm2xSe6VEQElt3j2ur+f+Q5Jc92XgmTZKQzAUHJF9U65Hpxf0OMgrU0us9yqN2NWJg+IXEOMddfuKueR2GF6OqtrYlNXPNlMPC43PoreEpuGWOMHyiv8q/0l1iMq5uJBrid+QxhKkAGv/Aw/fyMKpa1rwScq1+lcGprTvI/8A4YPDeIUI1ZMs1Dhprru70NgH1mIPRZgGJtMkqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJVl1tlnpiW5jfxh7ssd8Y1XV7Y8UoLpNWs+tDFmz8o=;
 b=EfgwaQjMWfgBZU/iXsm8ATz3kfydcgdJTsCyspKNrihqCn9Q+BOCH/I7sCSA4Mrrp65HXMcZW0QXdUagcmw9nmlmqxM38qvJvqXqxY6Wm0fysRefwL2Nl4+wPIm7RkvigwioapGpO2PKH59okcTcmdRnc63QBDpn5267VmFo0ejs7hqGwDvEg6fPYYg22pl0UQH5wQknEyVHsiD9YwVi+szATMjxioqoFFFP1LEkSpdbK6U4gIG1OI7Ls9kY5KbzptQbsqxoiiV47TKutHS9x2Ro8DAbbzo5GaPsk6GTG+J5zwxx4DdACXj6zZ/S4tPt+vxeGBtBzNdd8WH3oCqKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3837.namprd15.prod.outlook.com (2603:10b6:806:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 04:54:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 04:54:09 +0000
Message-ID: <ecd9da57-e784-0b33-fc24-f71f59a28556@fb.com>
Date:   Wed, 5 Jan 2022 20:54:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch
 operations
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        grantseltzer <grantseltzer@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20211225203717.35718-1-grantseltzer@gmail.com>
 <CAEf4BzbZn7s3nHrXd=ruLSmiQ-VSU46R62hCTaprEe60bKF_oA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbZn7s3nHrXd=ruLSmiQ-VSU46R62hCTaprEe60bKF_oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:300:ad::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dfa133c-1986-4cd4-5b19-08d9d0d09366
X-MS-TrafficTypeDiagnostic: SA0PR15MB3837:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB383786EA6BBDE72C51024C28D34C9@SA0PR15MB3837.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLVIYw+EcNK0qn1gTp5JDb7FPNIVTJ4xxsi56btMJH7GdZC+tsBIsJm28rv0fuUhO4DEZcZcIG+eD/dcUt0nFDSWJ9j0IYScP89MoJP9eN5tLYbkE9+tkCE/Bw45i7xCk2c7l3LC2PveHozUqxYaRIPgKQTMXWaLNZcaR0vOl3GoFcwSO45uKcgz/ITDfQLPEvoe4B3QS2JibrWsv4P9jerpkdvu+cGea6QNsER4608x7L9Vx2h7e46v9mBoJAAP9eDl25dK1gtqHv0YsM0LZF/c14aprTBIjLHAbgfLK4qqiia29tuC/E4aWtYu3V6sg+xLK4WgJj8kz2MWLasjhIAyB6rAsRnnAIfXgPTw+uFxaQ7/4nALRGk2PvBNG3FwJrHJrb0lXGx72K2pCFZxPwgpBtQH92FkDJ9aykdHZSV0XZUeq9d9iTNFPGjGw549tjICtcpVVSp9pNsygALuCMWwcHud4Zy160y5Bb1a7/nVT/Fn9f+r+kv9wSQ1jVLYNepR620SnztSn/rB90te0wPZZOiWSSkonwHW0OHbvJmhFuyIKRgyHLToa6wIqbzrJrHdYDwMN9w87ucK36cZODC0xe89pDqhL9n3QTNi5VAf8lBzLj3cvDkrr+ZXwke+cZ3S9rOUKWWs9yb2edNmWwiTS1GOQhRkpMTx3O0vvQqeQIRTI0r6/1ZEI4/4yWnBNmPvr/ikn8N3HmQ8LLZvdqZtRezPZ3nyjPeWM/bg+HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(53546011)(52116002)(5660300002)(36756003)(83380400001)(2616005)(31686004)(86362001)(66556008)(66946007)(66476007)(54906003)(6512007)(31696002)(110136005)(6506007)(38100700002)(6666004)(186003)(316002)(8936002)(8676002)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUM3TE5zRXRFZnlpN3RvcElRc3FMN3l6bDA1cXl0Y3EvSE44M3oxNHJRcU9y?=
 =?utf-8?B?UWRVVlRvS2tZWmkxZ1dIekZoMG02aHdTbnB2eWRHR2tDd3B5WW4rQ1BmcEcx?=
 =?utf-8?B?VEw1V0ZFTjRGVmY2U0ZXSk5tYURFODBNUVBTUXRSTWN1UXhkV09UcVhNVS9p?=
 =?utf-8?B?V1RrU05CYkVlNXJQK0orb1JnVDcwaFR6ZWl1QndEZnUxbEZ0N200emVFVWdz?=
 =?utf-8?B?VytxQ1p0QTBOMTBSNTFYTDVBOWkwWlpLeGQzMk5JYmFUUGJyNDE1QVpsbTZN?=
 =?utf-8?B?RG5BeU9rMHkyekhWaWI2ajIzWGFZSjlPMVdEdFhDZEQ2QXRMQmJzaXNzZUgy?=
 =?utf-8?B?M2puQTI2TXhzS09VUU4xWUVKNWRYYmlTTC9aN3BmV1NISGp0Z1JhbkZWVVA4?=
 =?utf-8?B?bDQza3ZISFpoMXptdGRyOUFMTjhyWmlqQ1I1VnN4R2crN0xCbEhUZGNnSTBE?=
 =?utf-8?B?LzFDQnE3d05nSWhtZXE4bkkrV01XZEkzRkpZdEJNdU5YdUZUWmxOMEczTlIz?=
 =?utf-8?B?U1UrZEdkV3BvN1A0VGdYcXRHb2pkV1lKQjVtL3BFQ1dGMStlaG5mNXBUTjl0?=
 =?utf-8?B?Y2RVUkFLMnYyK05pMlBkemNoREdDZVVmVFRIRzRVTC92TUFoZFZSVEZPQjdu?=
 =?utf-8?B?aEJEOWVoWEJwZGNJYW9BNWsvc1Y4WjFyS2g0OUVtZW5FVjAwRkVRM2JqRW92?=
 =?utf-8?B?QTdCQjczT0NkTUpKd3VqMUZ6eUJpVFZYOGVhb3Nkd1RDLzB6MldRRzZObXdn?=
 =?utf-8?B?YlU1YTJCS1lFTDlQdW9DbmdCYkplbENLbk1sUTdOYnBxbnVva0tkQ0d4a1JE?=
 =?utf-8?B?YlovKzJiUitwUnNYeGFYSGVEK1p4aloxNGNGRS83dUpNb0t6c3RoUWV3a0ZV?=
 =?utf-8?B?ZWtGcTU0d2NpdWFXSEtkS3JWYnJBaGcxSVc2YlFOakNsRnppbUlKZjBPdHJy?=
 =?utf-8?B?cjFKRTBuOExpV05wWUU0cTJmd0MyMEIyVmNhcE0zNEVxUWhldlUwaGhmUHdB?=
 =?utf-8?B?WXloTksvZVZ5Y0tUTldyd0UxR0c3cmtwTWJtc05mWlhiWFZtWGkraUZsT3R0?=
 =?utf-8?B?ZitUaGY0VmpWZEg1dklMZ1QyZEkrWkVINGdEc2dEeCsyNmF5dkN6ZFMzdVNU?=
 =?utf-8?B?UWNEc29KNGg0bG11WVpzMVNZL0h3OS9UaUovMkxIaTg2SGM3Y0pteDFEb0NU?=
 =?utf-8?B?UFJRZWE4WEVHekJPNjl4d0NTcWdXQnJuWEdXbmx2VTVrdFNEOUp4cG1FdHJz?=
 =?utf-8?B?NFRLa3hnWW41VUlCYXpjUElqRjM0SlB6aVR4OG5uaWJNMjRNRkRRdkdUUVdU?=
 =?utf-8?B?Ull5SndUUTJNb3pmREIvcXQ1L3dzNzU4UVNuOGd3N2FmRVdZWkZQU1RJZUsx?=
 =?utf-8?B?MlJiVUVlZ1RYeFdFdUdMbmMzMkJsVGFqbnBLYW1MbDY4RnorbGY4Y1A0NSs1?=
 =?utf-8?B?eUdnV3JFN0I3a1ExVnlUVVlPN2xicC9FWjdRN28rQXdUdCtob2Z1amNrZ0dO?=
 =?utf-8?B?aHV2NzlvRWRFdHI3Unp3NW5BY3ZySldnLzNISTA4L3VJUjlpUThrb041NG13?=
 =?utf-8?B?eml2c3RvZDB2R3drNjh0bUF4dngxdi9keW94MGYyVHNGczdzcXR6SFF6elVT?=
 =?utf-8?B?VTY4OW0vSmQ3bUlHRXk0ZlZJQ3pva1U0V0NqbE1SYjRmQS9FbnhEMnpYYSs3?=
 =?utf-8?B?VWhkK0F4bXk4NzJRaEhaNXRta2tuOStLcjFyYUZwK2lmQnZtYVV2U21uK1Fa?=
 =?utf-8?B?cElLd2RsQkZTRUhXMWRxMHJKQ3ROaFU1QzZkLzNDT1YxYlZqSldOZC9sZlE4?=
 =?utf-8?B?MUl0Wm1BdEZmM0xzMnRoTFBJdjlGTThhU09OZk1LOWsxR3hMSXRkUWcyUktv?=
 =?utf-8?B?TmY0czNNY1lYbGk4TktWLzBleGFDbVlLQXJOV00ybEY0a3dnMSs5Vm5rN1hL?=
 =?utf-8?B?NFRpVlUzckc5YzF6YjJLOGNqTDFZK201TlZ5WFI3NnBtWEh2UFJkMmg4YVQr?=
 =?utf-8?B?QzdMUXVyUU15VWphSk41dmltRldWUEwvT08zL0VhV0VJTGw4UlNmRXd0ZFhV?=
 =?utf-8?B?VzVZQTVZQ0NhUEN6N0REUTU1SGF2Rko2VkFkSU5HU3F6MWVXbEY3UnRBQnh5?=
 =?utf-8?Q?8KBPzAJ8TYk56RiFSRTiXfaac?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfa133c-1986-4cd4-5b19-08d9d0d09366
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 04:54:09.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZT89YcUF1ZNcN9qYSZ6NCIyVXmrUEdnxy/LXtLZftb+KAjtf+mIxnlb0hrPL+0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3837
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Gs-d0zdhHJPqv3Mz8SMd4j313sLO4nwp
X-Proofpoint-GUID: Gs-d0zdhHJPqv3Mz8SMd4j313sLO4nwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_01,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/5/22 6:37 PM, Andrii Nakryiko wrote:
> On Sat, Dec 25, 2021 at 12:37 PM grantseltzer <grantseltzer@gmail.com> wrote:
>>
>> From: Grant Seltzer <grantseltzer@gmail.com>
>>
>> This adds documentation for:
>>
>> - bpf_map_delete_batch()
>> - bpf_map_lookup_batch()
>> - bpf_map_lookup_and_delete_batch()
>> - bpf_map_update_batch()
>>
>> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
>> ---
>>   tools/lib/bpf/bpf.c |   4 +-
>>   tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9b64eed2b003..25f3d6f85fe5 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>>          return libbpf_err_errno(ret);
>>   }
>>
>> -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
>> +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
>>                           const struct bpf_map_batch_opts *opts)
>>   {
>>          return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
>> @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
>>                                      count, opts);
>>   }
>>
>> -int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
>> +int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
>>                           const struct bpf_map_batch_opts *opts)
>>   {
>>          return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 00619f64a040..01011747f127 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
>>   };
>>   #define bpf_map_batch_opts__last_field flags
>>
>> -LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
>> +
>> +/**
>> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
>> + * elements in a BPF map.
>> + *
>> + * @param fd BPF map file descriptor
>> + * @param keys pointer to an array of *count* keys
>> + * @param count number of elements in the map to sequentially delete
> 
> it's important to mention that count is updated after
> bpf_map_delete_batch() returns with the actual number of elements that
> were deleted. Please double-check the other APIs as well whether there
> are important points to mention. These batch APIs are one of the
> trickiest ones in bpf() syscall, let's do a thorough job documenting
> them so that users don't have to read kernel code each time they want
> to use it
> 
> But other than that, great job! I've CC'ed Yonghong to take another
> look, as he should know the semantics of batch APIs much better.
> Yonghong, please take a look when you can. Thanks!

Will take a look later today.

> 
> 
>> + * @param opts options for configuring the way the batch deletion works
>> + * @return 0, on success; negative error code, otherwise (errno is also set to
>> + * the error code)
>> + */
>> +LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>>                                      __u32 *count,
>>                                      const struct bpf_map_batch_opts *opts);
> 
> [...]
