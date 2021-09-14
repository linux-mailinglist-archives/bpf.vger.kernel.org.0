Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF940B513
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhINQnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 12:43:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhINQnt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 12:43:49 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG3ei1008930;
        Tue, 14 Sep 2021 09:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=W0EXRzd2yi6EQFKtzQ/tAPeMMMTUCX3ywgvuaG5LB4c=;
 b=pebEJkox7aVT1mUgniejfYla/zO3BqTjDdZCqPxshMuZ4enmfBhABf2+0DZvWPkxviV3
 pdgzseFaZifEAZgVtAWdXpD5gT11YGj7tWoucs8I3PtUJaqh/s3yUIhAtWqo2gcwION5
 +fdG/ORVPZdE4UFNB2z9lDv0ZBxDb9FlMNs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2hyqmm31-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 09:42:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 09:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iokZA2hgS5MCMU70LLe/2D7cyWN3lHlkOfatSyTIs4YEJT5drO/NFeEc0SkGDkPdk4Stm8bT3f0lbR6Guw/q9X42Vpqjvs7bPBSW6rO1r8OODhgYmijw0LthAc6wYrBY1Ke1yxsUy9hVJ7e7fd4FFRSN/EM4LljDrCAwqy3cGvdHA/QxoIUeUA2w2dNM1A26H8UFGhsGF0+Yg/eKIUBY68FQl4shrJiZKg7E1BdC8Cn4rVH04GcwG5rtykK0rQDofQHIGpFSrwUEPq6mH/BDWlYq1WwQA9ureHChjKyJQLmFJg7EZIdtIhpRRHZ608hzeWcIwVNcC021OFgBKCfNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W0EXRzd2yi6EQFKtzQ/tAPeMMMTUCX3ywgvuaG5LB4c=;
 b=IMIUaOrFG3mvZZGWYBtVRWwLxPzU4YByOBKODGGjim6u/vdoCel6J+2A4HofkMq33iz05eMr3X9lEfTHul2Rki20t39xKCPP6Z2M2VFLBxoMBtve7NG1o+d32aEA1F2/LjV8QS5n6bdXsWGIbP1Rgze0R3NvRF9D4ZCP2hBSTjLaJI0WCkZDv2mJgwU9wdzggp+e2ollW+E0XSEXLG1Q2KKbYSywzbyXbneFhgCyTncolbMb7SnphqSwrNxu/w93evU9G1tXqIzXdYTxeWSPio0+BOkgxz/alvGMVVIGRbuybI9pvl2YTcjmazqu5/C3rIFasBcTAzAxQ8A68Iqdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2160.namprd15.prod.outlook.com (2603:10b6:805:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 16:42:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 16:42:15 +0000
Subject: Re: [PATCH bpf-next v2 04/11] libbpf: add support for BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155145.3726307-1-yhs@fb.com>
 <CAEf4BzZC=AeZRGBeHk23zR8rZw3LaCjps5mf7jyjgqO9zgTTHg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <038918b0-04e6-1a17-03fe-56e988a3d5a5@fb.com>
Date:   Tue, 14 Sep 2021 09:42:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZC=AeZRGBeHk23zR8rZw3LaCjps5mf7jyjgqO9zgTTHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by BYAPR06CA0028.namprd06.prod.outlook.com (2603:10b6:a03:d4::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f253e656-af14-47e2-0a54-08d9779e9be6
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2160445791F67BB811919EB2D3DA9@SN6PR1501MB2160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okcv8EXyH6Lg5LFY4Mx9P7R4ZTK7tik0Ng38dPqp2wOKzkChHwV5EGRwKuRO5+p+ih3wB6MpFJYkks9quywL0FzKnWNg4nB60ySbboC0EcNpUf/Y6aCjVybmIITg32b3urNNJuJjHGu7OmUc1TpLVvmkr6I5N/gFTlSvoe9Cfp8pi1TncKBVbvvkeWH0FcL6OUJkocJ1Y5s+qMjxAoyK9/cAQWieljaTXRKWEH+j5gjnvTROVjqQqzYlIMqkrcx3r8qMbwlNzjZZ/cfLLfSSFc70QABEYh615F7H7n525mX1z9+0ppUE5MhlKKZJ8av5e+dLKlQo8Cj+JFqs/otN/XMMSMNw0ltra0B/RdGZTPSJwPdAz/2v+MsxrPx5fOFVLGxl0b1WIUDXpjtzhksVTsyPQrhFmg8RbCD6dJwz//J+xFzeU4+ACCs9eedO7pzJ0juwIjmzPS5FAjS9GfYtnv57PrztIzkVqKSUVv8G4CTeYUMHIzWkeUtEAyP193cdCZZHdADpYXsizGVKJj/RL0Ri1uPJfdyD8zAptkKviK66owsN5hNjq7BM9QQD1qaHQ9hO3yBeQ7j2dadncTitfMWfZKCPSszYOZUBpzKCl3yMHNY0m6pNca8kVNy3BQETT/N1Q06YBigxErlhYIWS6mVnfpsuq57qVPDEOdvo6QYzirz6jjzs3LHW/O09l/T+bYUChBB5xSm7ghhb2zFxq1F/0KREA3V6xhkOknQ7ZqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(52116002)(478600001)(53546011)(5660300002)(186003)(6486002)(4326008)(36756003)(31696002)(316002)(2616005)(8936002)(2906002)(8676002)(66476007)(38100700002)(83380400001)(66556008)(86362001)(66946007)(31686004)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dtVVZRT2lyRlhYdDllNXowU0NST2NKVENqTWg0dFJ1Ry9ZVE1UZmxsWHJT?=
 =?utf-8?B?NG5yMU9DKy9CdjBsaVVCMzg0d3ZwdmRVclk1VXhKVVhvNXl0WGRxZVZBZUht?=
 =?utf-8?B?ZDNHakVoL0dKcmNEMUxhbEY1WG1KckZWMmtwUEh0SkxPYU0rMFU5MVdNVkZk?=
 =?utf-8?B?bU5GN3o2ZlJaYlY5aHBjNHRyeGErSFpFWFJlamQ2LzVzdGJ1MnJPUk1TZzhJ?=
 =?utf-8?B?cGpMMjg5QVkxRWF1WHpiQ1lDL2RuNjIrSE9tZjZXV3REcU1JazBLWU9vdnA5?=
 =?utf-8?B?eVJQNjZBQlQweTFGc3BBNXFTM1IrbEFFbkx3MXR0Z2ZFLzd5Ui9CNXh3NWZV?=
 =?utf-8?B?OFRjcmxkam94WDdCRVMwRVgzWVNha1Rodzlnekg5RHlxbFZqODF4Q0xpU3F2?=
 =?utf-8?B?YVZpVjVWVlVYTlgzdyt6WjBvOHZKUVlPSFpIaGJhMEMrMEFwRlJONHRYQnFN?=
 =?utf-8?B?ejhvUXorcUtSK1lKdDRrWGx3cVh3b3F6aUE5cFhtWXpnZDFvdXgzOXUzQTBl?=
 =?utf-8?B?aU13NktVemIzZ29LeHNwM01DeFhqcVgwdHhQM2JZZko1NFZXQVIybmhENUR0?=
 =?utf-8?B?K2tNWWdVU3NGQ0JKbHJhWC9hWEVVTnp1cDVpWW5QSDNqdnBTL3hmZlltQzRh?=
 =?utf-8?B?L2JiM3drVXBuaE1vbkx3djNmeDJSY0lzakVxUUExdGxqNWVOYWVMYkpXbjhF?=
 =?utf-8?B?RzdpMjVvUW10elV0VktjQmRXVjgzL2JUTENxUGVPN3QzdGVxemRQYzc0aGs0?=
 =?utf-8?B?blR1MGoyMm1vT2hRdXdoS2tZN3hEcDQ3aUJXdW5DTXVqaW9lTHhWMW5aWVlV?=
 =?utf-8?B?RHBsKzlva1dOVjdFTzRmVGFMOHlxL2NFSTFRYWVNamRsRG42YjYvcEx0Y015?=
 =?utf-8?B?WTRaN0g4dWNoWEQ3U1RNckZuaFFWekJZVXBJTkN4KzJFTFJhTks1Sy9CTGta?=
 =?utf-8?B?dUUyclBuSllkMGh3LytFQjJkMVY5Um9iUTdUYzZLZlYxeElTZVVDcmFJOE5x?=
 =?utf-8?B?OUVscmwyU2tYQXFCM3NFUURhdVo0VnAvNGV4MVVzU3V3RUc2K0oxbmxVNTUr?=
 =?utf-8?B?dDEzN0VmRWIxaThCUE5rYXd4bXpESXdrS0tIbmRiRjlJUm1yNFIzTDBRbkZD?=
 =?utf-8?B?Skpsa2RlanRDZFlCelJCUzN3ZmFQZGdnbzJGNitaVlRSUHJ5U2lxbWxPSHd0?=
 =?utf-8?B?WlNNaFFOOGR0UCtOODRHTTBBaFo5WGRkNjJ1UzdxZG5EWkswZnhJbHJheFZl?=
 =?utf-8?B?ZnZURzc0MGVsMDZiZkJmTmEzcnhKVGNnVlNiZHFRODl0OTFjVmpOdVhXdS94?=
 =?utf-8?B?QVlXcHIwRENacVBqbXZxbHpDTVZSSnd4NWRvWHkzYzl6RW45aGVCRmViL25H?=
 =?utf-8?B?azZmdDY3eWVBQ2U1N0ljUWM3M1lNUVVPbSs4dUx1NWNvWm5xRGdXbmRJZ3VH?=
 =?utf-8?B?Nmtuc3JKSVVGa2NVSDc2NVdjVEVaRW5CRFN4ZFZQSll2Nkp3dVptdllVaVlv?=
 =?utf-8?B?dzFVYkwya1Q2L25Vb0VMLzVJbE51SHpGYitKRVNVa0RrTGdnRTVQRnVZUjN0?=
 =?utf-8?B?b1lhT2pQdjlzVGlmVEdleDgrS2wwS3AzYTZvZmFBaHZmdjZtQzBvU0VHODJk?=
 =?utf-8?B?eWNsV3JCd0swSythd3JhNkJYa2k5bDhFdUtJUHRtWDZoRU1QZTh6WkYyT281?=
 =?utf-8?B?bWVzdTFnbFRrUi9DUzRvTzBjN2h0U3BLSVRyWmVtWExpUEZuNjI1Sm95Q3du?=
 =?utf-8?B?NnNPdy9ZNmwwWTJiT3NaODZQekVjSDc1K2ZoenJ3ajFFbzN4a01VRTd4N0xN?=
 =?utf-8?B?MktWV3Uvbk5tbEkrRGw0Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f253e656-af14-47e2-0a54-08d9779e9be6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:42:15.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4dJjdj4s8/4+1546fGysHHePyT0qfvg3MoOjfwNu6ZYkm59kO5wXM8e27SuTy2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2160
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Xj3q1wtwTBexG2AtB3w3Wi6Eqdvydo6W
X-Proofpoint-ORIG-GUID: Xj3q1wtwTBexG2AtB3w3Wi6Eqdvydo6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 10:15 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_TAG support for parsing and dedup.
>> Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
>> supported in the kernel, sanitize it to INTs.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.c             | 69 +++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/btf.h             | 15 +++++++
>>   tools/lib/bpf/btf_dump.c        |  3 ++
>>   tools/lib/bpf/libbpf.c          | 31 +++++++++++++--
>>   tools/lib/bpf/libbpf.map        |  5 +++
>>   tools/lib/bpf/libbpf_internal.h |  2 +
>>   6 files changed, 122 insertions(+), 3 deletions(-)
>>
> 
> Just a few small nits.

Ack for all nits. All these are indeed missed leftovers from previous 
patchset/changes.

> 
> [...]
> 
>> @@ -2440,6 +2446,49 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>>          return 0;
>>   }
>>
>> +/*
>> + * Append new BTF_KIND_TAG type with:
>> + *   - *value* - non-empty/non-NULL string;
>> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
>> + *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
>> + *     member or function argument index;
>> + * Returns:
>> + *   - >0, type ID of newly added BTF type;
>> + *   - <0, on error.
>> + */
>> +int btf__add_tag(struct btf *btf, const char *value, int ref_type_id,
>> +                int component_idx)
>> +{
>> +       bool for_ref_type = false;
> 
> leftovers from the previous revision? let's just use 0 for kflag argument below
> 
>> +       struct btf_type *t;
>> +       int sz, value_off;
>> +
>> +       if (!value || !value[0] || component_idx < -1)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (validate_type_id(ref_type_id))
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (btf_ensure_modifiable(btf))
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       sz = sizeof(struct btf_type) + sizeof(struct btf_tag);
>> +       t = btf_add_type_mem(btf, sz);
>> +       if (!t)
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       value_off = btf__add_str(btf, value);
>> +       if (value_off < 0)
>> +               return value_off;
>> +
>> +       t->name_off = value_off;
>> +       t->info = btf_type_info(BTF_KIND_TAG, 0, for_ref_type);
>> +       t->type = ref_type_id;
>> +       ((struct btf_tag *)(t + 1))->component_idx = component_idx;
> 
> nit: btf_tag(t)->component_idx
> 
>> +
>> +       return btf_commit_type(btf, sz);
>> +}
>> +
>>   struct btf_ext_sec_setup_param {
>>          __u32 off;
>>          __u32 len;
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8f579c6666b2..4a62ef714562 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -195,6 +195,8 @@ enum kern_feature_id {
>>          FEAT_BTF_FLOAT,
>>          /* BPF perf link support */
>>          FEAT_PERF_LINK,
>> +       /* BTF_KIND_ATTR support */
> 
> s/BTF_KIND_ATTR/BTF_KIND_TAG/
> 
>> +       FEAT_BTF_TAG,
>>          __FEAT_CNT,
>>   };
>>
> 
> [...]
> 
>>   static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index bbc53bb25f68..9e649cf9e771 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -386,3 +386,8 @@ LIBBPF_0.5.0 {
>>                  btf_dump__dump_type_data;
>>                  libbpf_set_strict_mode;
>>   } LIBBPF_0.4.0;
>> +
>> +LIBBPF_0.6.0 {
>> +       global:
>> +               btf__add_tag;
>> +} LIBBPF_0.5.0;
> 
> you'll need a rebase for this due to my patch for libbpf_version.h, sorry
> 
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index 4f6ff5c23695..ceb0c98979bc 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -69,6 +69,8 @@
>>   #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
>>   #define BTF_TYPE_FLOAT_ENC(name, sz) \
>>          BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
>> +#define BTF_TYPE_TAG_ENC(value, type, component_idx) \
>> +       BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_idx)
>>
>>   #ifndef likely
>>   #define likely(x) __builtin_expect(!!(x), 1)
>> --
>> 2.30.2
>>
