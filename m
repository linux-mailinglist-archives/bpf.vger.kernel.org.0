Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD01540B402
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhINQBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 12:01:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235231AbhINQBB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 12:01:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EFQpw5019889;
        Tue, 14 Sep 2021 08:59:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=X36mzk0IBwO0LNKaeiBOilvd6U4dqa0Gwrsaih9stsk=;
 b=TWTa7ejmnjVZ10oSi7DXjmk13qFnIVJgIYZYxVQov/Qwnq8P9+Kg2BXB/P7pG4scGHfF
 hGQcnlXM2wVNvNZplXVz+LFOye2mhI2aSTp1tjM5Xk6jDACswa9OOof+ugMfKbhoZ+Hw
 AJlyYjFPmtzTY2pzRWgR2VB7iSwpzABtbp8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kh03xww-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 08:59:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 08:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeR65otQjtg1Z4rg+7wZsB/NOhZ46qFmZwD584voV7XsalJhzx2oMYF63wnQXEshF5+sFDTayWwGcfGekFaWR8+WT/RTsUkWm+ewtpat2xJLG7dulTnpFEkrE0gMrX4a0oR4kdYuF3Od18P8lKKFm93aYLJciI7WL7jY2rv7qZGzekeGDkToFRGrNB0TEmPkanOTWwX/5B4+I78JRWdzchVnSdvfOpJYmQisbUBMCcR9gN6faejPrlzFFlxze1XQ4gDbjwSlq/fn+xZP4ygl1/UgZVqic3eVDAzMw3qvK7p2N+e40ZA37Js1gWQ9ulr5kOYewfPWQeJY3l0x9tgT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YC4Otmeplz77OeMqji0AJvZcCjxnfc4r3KOcyeF33DQ=;
 b=BMP0TGdyTstOkIPHOtVQgNAuOhI3p4d60rNooROkGlwLGr8RTLNvRGlXNJCkFrW4ZPckKh5NvWHczqHRfjUJx+yk9qnu3JZREqjNAZ/XK0yHsAQMUUmSo11hg4j+ki8qr/kbU8ym3/S8WBTpcP63LZYhzubUprcyCXcNe7RtbHeTlBiJ56JTHoepr3ZXOrrgvQFFWQmaBB7V0YXciXlhWpFW4ikkuWMAVDmbMG8CC2TJDeeVEA98XfIxz41OFLEgricQ1NMzDjbIgSSc489Hz/lsPlhGA9nlfcXliMX6mdsVNnxV8Eh1IBGs50bCkTDge6aMDAyUjputpalSaV5E4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4386.namprd15.prod.outlook.com (2603:10b6:806:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 15:59:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 15:59:22 +0000
Subject: Re: [PATCH bpf-next v2 02/11] bpf: support for new btf kind
 BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155133.3723769-1-yhs@fb.com>
 <CAEf4Bza69r-Sp4nFZqd4i1xhD+Dy5u+Xb=FB7TNNSfHzNNvosg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5a079457-88f9-5ed5-83bf-b0a456186323@fb.com>
Date:   Tue, 14 Sep 2021 08:59:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4Bza69r-Sp4nFZqd4i1xhD+Dy5u+Xb=FB7TNNSfHzNNvosg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 15:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b21d9508-7dec-4e28-9545-08d977989e4d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4386F906DB2C088FBF0368DDD3DA9@SA1PR15MB4386.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGiLN3XO6n3whGmBQvwL42C0APrYwoyb+cH0vZdMtSE2d1TkxaEM0XsSqPNJYY50iOADs317Ihg6kN5nQbeVzZxUIW86UKrtAU4cCJu1ViMaw6PT94zF+knRCjyDV+Fy96zCO2NY+vf8PViyj7MQ6YWBDv//HAm2z5ZcP0l9dLXmPN6Clt4UC4FwK0NblH1FTx4UmIqnfPjFHJiIGJfW/qzdbGJJegDrhsthJAyo/vMzTtDs6KlicukJg+wDaphafZL5mxHASZwieGV9SP8Hf/xfSuMuELb0pFrsv9+1HRHrB6hKbZlj/xhsYB6UFqFjZ33QGc4rIzFRsqlnddK9wGwdcWZXrKoWKQL1tSCOer1/4ir4xkB0l0BkhAspHQJNr2KGG8RBmPzsZCEJV7EL/oafOdHcET2dI1eJ2ohybNtBVoETYHDQ8Dd2DKQX/2bbl8fSmDVZEVmxerGj214zxMNjejUYWnyxELSEWQfiLGC6NVfzo1IHMWyGxQM7w4XErFWqElLXsIJBlpOkiJsNXENy+IXkqoUI0HfT0xRF1ziCQnthYSy+5rbdQoRJPfozIyqpWWFPS8NDxn0txY83pT8KJxDLjYpT7H/G37Fvz9wGo3aHQsOoODH8sNho7wM8CZMrdBLnNa++qQekPc03ngnUqT0e58jcImJ1/yqTD7VrmzDWMCj+HhXMovVuck9lf/koKMSr18UnRpwTXzQW47bGUHRqOyG9rdgABmcannsCNJTLgsR2JecJiAfvzmdSSg+JluW1svZ2c+/90BM/jL1qUpkHnzGilCoiQ/MmaEdJkx7pPd1dj+X3wS8FS47SHrR4th1+i3FGebJOZEGw/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(31686004)(6916009)(31696002)(53546011)(38100700002)(6486002)(36756003)(186003)(8936002)(478600001)(2906002)(8676002)(4326008)(5660300002)(83380400001)(86362001)(966005)(2616005)(316002)(54906003)(66556008)(66946007)(66476007)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1I2Y3NybS9XQS80cmlZNTJEbkttTitHQnYvdVUwM3RNQTk4TEZLWXlTbjV1?=
 =?utf-8?B?MUVSckhJUGYvUG1rbGFpRm4yUXFpMjBNdUtsV01iNUdHSUN2MDlNRExhNkVC?=
 =?utf-8?B?dkVkdXROblBOOEZsY3Zwa2pJNzB1MDFYazdVTi9qc3FzVGVRTWJOOUlZS0FX?=
 =?utf-8?B?NXhNNmhoUW1HQkFDM1FpT1VLdEZtVXR2bTRxbUhNRy9kVmFTSU0zMERLMU1X?=
 =?utf-8?B?R3B3Zm01UVEwZDFURW1NL3pxVTg4SnkyL2lObU1FKzBXOWxJMDB3Vm52Mnl5?=
 =?utf-8?B?VmlBdDJRSGhDU3FaUm10QWlNV04wRHBlTHRna2ZIc3ZYczZRd2V5eDZvVDJm?=
 =?utf-8?B?QS82eWU5bWpKOXdWelNTVW9YUXpuclcrZURncFczVEF2T2NsM0NnMjc5Q3dM?=
 =?utf-8?B?Skx5UjdpZXZ0VlhGZ1RpTFNSQkVuYW96OElYNUt2WUFqSmhBc1hhOEJXV3dI?=
 =?utf-8?B?SElUR1U4V01oOGQvb1ZMRDAySFZuekxXeGZiZ1ptbFJST0I1dFFqcWJPbENy?=
 =?utf-8?B?RHY0akE5ZXF6ajg0VVBzZ3JjNnVYSzRUK1BKeWpQK0wxazZXdkRsemNIV3FF?=
 =?utf-8?B?T2hDUHF2akRCY2x3TWd5VCtXUTM3d2VTMmR3Zk1xSXVxU3pub0VIV0o0Y1BC?=
 =?utf-8?B?dStGN2tEWEFyUlc4dDVkRDgvSkJKbk51OGIwa2VlSnIwRWNSRzhxTk1ZN3Ba?=
 =?utf-8?B?RWVTZE92b2pqWjdMMXMycmNJSjhHOFVrVHJCbUQwWkxxNGdQV1dYdUlDZGFF?=
 =?utf-8?B?SFdKVDN5UlJtNGpCMGxHOWtRUnpKMkhaU2MwVUZsbExKZjgyWjBmelgwanQw?=
 =?utf-8?B?bVFVYUFDREJIR1FWd2lJQVNxQkoxdXBiQ1NWR25KQ2FORHNlbjR1aWpSTExJ?=
 =?utf-8?B?S1VOd21YMmI0TkpMUmhEa3NRUEFpZjJSL2l3cktuYlQ3cFBsR2EreGh1Und5?=
 =?utf-8?B?NVZBUzFLcEIxcDlyOUNsOXM1ZUlSRGl2VElJR1gyK0VCMkJHRUFnZTdPYmZw?=
 =?utf-8?B?Ykl3N1pVOW5ScFlJY0Viakd3Um12ckI3eFRMN01tZ1dXMHpTSzEvSyszaXl0?=
 =?utf-8?B?bDV4UjhES3RDU08yMlNMN05TbW1ybVFBRSs5TkpKK0kvMEdYc0JIbFA1Skh4?=
 =?utf-8?B?cmlQeCtSYXI2R2IvWHQ4MmhRMkxhcFFCR3p5OGRXUGVGZGY5ZHh3TjFuSzhQ?=
 =?utf-8?B?d09PRldjSk8xc0FPOHlQZUZrVi80cXo5Vm51WW00M1c1bjFiQkNrRFMrSmxa?=
 =?utf-8?B?SVBObmE5R3dBSGUxY0hTY3BCWXdQaitFc1EzaVc4ZVZPa0pJbXNMWWd5MHBP?=
 =?utf-8?B?RzlObGZ3Tkk2WDVtMGZPVjZWbzlpQy9QamRoQmh1VEVUWnRBcmdHZ0FrdUtE?=
 =?utf-8?B?TGdQc3RPUnFhZE5lMHdQdXV3Nk1MWWJlT3NLMnpaV3N1Zmp1d1d1Y3FyZE9I?=
 =?utf-8?B?d1RjRFUvclB5WmdkZkM3ZDB2MlJRVmNPdkd5UGVkNEZXamw5TlhsOUE3L2ds?=
 =?utf-8?B?RHlSL1NmSzJ4djN4d05NMCtiakNGR3RuejMxaDkyUXdaTUxoTVBsYlhmN0lU?=
 =?utf-8?B?V1ZES0VFNVM1Y1djNXVnTWwzS2w5b0xPcWlqRXlITVFMazN5VktDZHhKbWVI?=
 =?utf-8?B?cGZhQ284a05pR2VsOFV0V01FMG5HREhBSHhIY1crZXZJd1FlajUreldmdkcy?=
 =?utf-8?B?Q3FGWDVHRFhTa0U1aHhHMXJaQm9mMUplUkErNTduRXdkam5KbVpvK1FVOUxW?=
 =?utf-8?B?YVR4Si94RVVqNU55Rm9VZlBNYXdiUi9Kam4vcjQ0MUFKQjBNZmVYSlNHS1FV?=
 =?utf-8?B?SEtLSXhTOWxjM3haQytTZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b21d9508-7dec-4e28-9545-08d977989e4d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:59:22.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB9d7rKRMxZg3oCGZccMbFWCDGUeZY+D4qOhillRTT0gYc5vUXLwOAt0OpKrOX3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4386
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FHgNjfbA0QDuz6P_nvQjMziHZbP3kWCu
X-Proofpoint-GUID: FHgNjfbA0QDuz6P_nvQjMziHZbP3kWCu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_06,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 10:08 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM14 added support for a new C attribute ([1])
>>    __attribute__((btf_tag("arbitrary_str")))
>> This attribute will be emitted to dwarf ([2]) and pahole
>> will convert it to BTF. Or for bpf target, this
>> attribute will be emitted to BTF directly ([3], [4]).
>> The attribute is intended to provide additional
>> information for
>>    - struct/union type or struct/union member
>>    - static/global variables
>>    - static/global function or function parameter.
>>
>> For linux kernel, the btf_tag can be applied
>> in various places to specify user pointer,
>> function pre- or post- condition, function
>> allow/deny in certain context, etc. Such information
>> will be encoded in vmlinux BTF and can be used
>> by verifier.
>>
>> The btf_tag can also be applied to bpf programs
>> to help global verifiable functions, e.g.,
>> specifying preconditions, etc.
>>
>> This patch added basic parsing and checking support
>> in kernel for new BTF_KIND_TAG kind.
>>
>>   [1] https://reviews.llvm.org/D106614
>>   [2] https://reviews.llvm.org/D106621
>>   [3] https://reviews.llvm.org/D106622
>>   [4] https://reviews.llvm.org/D109560
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/uapi/linux/btf.h       |  16 ++++-
>>   kernel/bpf/btf.c               | 120 +++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/btf.h |  16 ++++-
>>   3 files changed, 148 insertions(+), 4 deletions(-)
>>
> 
> [...]
> 
>>
>> +static s32 btf_tag_check_meta(struct btf_verifier_env *env,
>> +                             const struct btf_type *t,
>> +                             u32 meta_left)
>> +{
>> +       const struct btf_tag *tag;
>> +       u32 meta_needed = sizeof(*tag);
>> +       const char *value;
>> +
>> +       if (meta_left < meta_needed) {
>> +               btf_verifier_log_basic(env, t,
>> +                                      "meta_left:%u meta_needed:%u",
>> +                                      meta_left, meta_needed);
>> +               return -EINVAL;
>> +       }
>> +
>> +       value = btf_name_by_offset(env->btf, t->name_off);
>> +       if (!value || !value[0]) {
>> +               btf_verifier_log_type(env, t, "Invalid value");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (btf_type_vlen(t)) {
>> +               btf_verifier_log_type(env, t, "vlen != 0");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (btf_type_kflag(t)) {
>> +               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
>> +               return -EINVAL;
>> +       }
>> +
> 
> probably need to enforce that component_idx is >= -1? -2 is not a
> valid supported value right now.

I tested below. But I can test here for kernel practice, testing error
case earlier.

> 
>> +       btf_verifier_log_type(env, t, NULL);
>> +
>> +       return meta_needed;
>> +}
>> +
>> +static int btf_tag_resolve(struct btf_verifier_env *env,
>> +                          const struct resolve_vertex *v)
>> +{
>> +       const struct btf_type *next_type;
>> +       const struct btf_type *t = v->t;
>> +       u32 next_type_id = t->type;
>> +       struct btf *btf = env->btf;
>> +       s32 component_idx;
>> +       u32 vlen;
>> +
>> +       next_type = btf_type_by_id(btf, next_type_id);
>> +       if (!next_type || !btf_type_is_tag_target(next_type)) {
>> +               btf_verifier_log_type(env, v->t, "Invalid type_id");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!env_type_is_resolve_sink(env, next_type) &&
>> +           !env_type_is_resolved(env, next_type_id))
>> +               return env_stack_push(env, next_type, next_type_id);
>> +
>> +       component_idx = btf_type_tag(t)->component_idx;
>> +       if (component_idx != -1) {
> 
> so here, if it's -2, that should be an error, but currently will be
> ignored, right?

It is not. See below. At this point, component_idx could be -2 or 0 or 1 ...

> 
>> +               if (btf_type_is_var(next_type) || component_idx < 0) {
> 
> if is_var(next_type) then component_idx should only be -1, nothing
> else. Or am I missing some convention?

So if it is a variable, the error will return.

If it is not a variable and component_idx < 0 (-2 in this case), return 
error. So we do test -2 here.

I will restructure the code to test < -1 earlier, so we won't have
confusion here.

> 
>> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (btf_type_is_struct(next_type)) {
>> +                       vlen = btf_type_vlen(next_type);
>> +               } else {
>> +                       next_type = btf_type_by_id(btf, next_type->type);
>> +                       vlen = btf_type_vlen(next_type);
>> +               }
>> +
>> +               if ((u32)component_idx >= vlen) {
>> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       env_stack_pop_resolved(env, next_type_id, 0);
>> +
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
