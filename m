Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6996D323117
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBWTBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:01:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38210 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232878AbhBWTBg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 14:01:36 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NJ0MCt024963;
        Tue, 23 Feb 2021 11:00:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IY2IGJc3srW0BHXzAETQ6y/Ny3zleUr/BBLrvrg64as=;
 b=k6iCdYihCz6RcrKcz+pB2n2n1MilBiOANg1yxwSj8VojtNKfk1Tu76P6IdFPgKtxR4jA
 +O7DtHM7tQDmxa7f9jwjUktXE6pfZTCbyDpaN7edx1C2e88Lv9MsuHFpUXB6uFWaL+em
 mgrWjuBnw260yguChbC8f82mhjxgw2ScpOs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36v9gn95fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 11:00:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:00:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9cPZHMFg/fAk/9zX+7RxnyNmsAnSG58qVhh6BAEEJ53ztZ9w6LdJ/X29AGKg5IcoP8YC0QD9umBfuWbL4ioYXac2MRW5Vf0ZylTuoa4GkHwQDHsXMCm3Ey0flcOtsckDXlYp9sQQcH+mzv3Jvg8SKOuP6KjTOKGKJb3iRMf+37ToNe6sbQHrGyag+QhiOk5Y4wd55Q1akGV+mm0StdIiIejU/lb/hmpXL8icX3otYvl6ugU3cf63ELlLo+eNC+tfdCzyFMszkpYVfd2BhriMnQZEHICmsyffUfP+u5TbmnkpzBjSHmGgzKBl5ZTGe5ugFf1hD+yfqH9Ml9n/BWatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY2IGJc3srW0BHXzAETQ6y/Ny3zleUr/BBLrvrg64as=;
 b=bdMQLbFJ/P37LDfrJvL88ZlaAcAJdMhnQnBH3IibkaKKtn3E2Ht68ELQDxYujry1ZBiv9OWO5GCNabyv0SL8xaiGOCC8XTp+/ywe37yLQJXmrtcXPgPkQ8mwuMoJC8oMU8+ax+taF8iQvcHyZW3sg+WzVHgIAUUz/eADd09/wXKwlkD7HHMwjUOHBrubG1AYrXClNHytS019AWMuLBYdQGTKj7mhMn8tqehoJc3rph+0z2ssebgXVHq7Neau5P4NZKwE/8BrhopIYHE5uCRiZkYwFz4CJfr1kTizbHm9YdKXUNiDqDcM7uJZwCS4fWo1rH9Gese3lMFMx/7UxawGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 19:00:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:00:39 +0000
Subject: Re: [PATCH bpf-next v2 09/11] bpftool: print local function pointer
 properly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181813.3191699-1-yhs@fb.com>
 <CAEf4BzYgtusa_e3ULwgh4ZCsVRqpVRXi-rnmPrxWyk0WoFt_8g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <916d6dba-d5d7-597b-6be8-7aca43aaacf3@fb.com>
Date:   Tue, 23 Feb 2021 11:00:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzYgtusa_e3ULwgh4ZCsVRqpVRXi-rnmPrxWyk0WoFt_8g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: CO1PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:101:1f::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by CO1PR15CA0044.namprd15.prod.outlook.com (2603:10b6:101:1f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33 via Frontend Transport; Tue, 23 Feb 2021 19:00:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd359834-b731-4501-d497-08d8d82d4f53
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4641961849CE94B790F88EF8D3809@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK13Ze52YP1sgsQZbwCQbVOoFcYdn0BEYZr9V5fw8n8/cK0VKmChP3CIP7WwLsnQsRiaHEd8aBkiqi0RMhSoz/D/Ay/+3Z4+9Dx9/rjlBtMFwzm2rL8i1iV/fyOa5w/rwejir2M86CGcjx7eQQ6Vfog6k4jtmMuLpIFSOcPF6QkiGMJDGjLzpF+ArMXFcx79l2OOTpkTblmsOt9otlV9XD48gj/ZFbZYaLJHT1tj9QWzLKBt/m+AjL55WmzgRgQ+/AYpGMrY85p6qDkCO/BBzJrfKtTwbSdvqKfFqBWoTkNDnRJUGpoF02IXSJXZ2exeWYSUWVMsseREPbJOwxdqDA8k4fTDwJ5CuU+0ME9TtAv631zeqE8upvxXuP0Vgip9ARFvW6z9cd6CvRhZsrj/emSVgFu2zmj5b/uEf2CcFoHWiFc/H0ApGDEw4zeYRLBRCAi/0kkg2rOJe9UMZLj/f6bvAOKipBoK5S2LtRU2Nz8udCOsfgo0SLP0hf5xJwHG050lX4lxajJHrEOLsahbka2jL4Af47YyV/FO6A6GXI1U72jsgSlmfzMKQx/dGAHJWjebZWhbmJE4emwZh/eqjUubr4dauf1eesQRpKhan/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(66476007)(66946007)(6486002)(16526019)(31696002)(66556008)(4326008)(31686004)(316002)(2616005)(2906002)(186003)(86362001)(478600001)(54906003)(8676002)(36756003)(5660300002)(53546011)(52116002)(6916009)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVdNVkxtMmIvOEs1dTgwcDJsY0w3Wmt4TFk2NTdvNVhvdUNMRkVDb2NGSmZ0?=
 =?utf-8?B?ZG1BYVpUV1gzanhuVXhMU3pHejZaUkxPV3NVR0dETFBEWVpBditNbjA4eVlY?=
 =?utf-8?B?cnBWMmtxVEdSNU15TGx3aU9Ed1YxRkVTM1M0NUMzeS9wUm84RGpHRFpOUlhQ?=
 =?utf-8?B?NXBSOVkyNm9jaHNmYnUwcFhIbUxSbkxOOXVxOG9CM05UYXVpR1ZrM3lYRE1j?=
 =?utf-8?B?R0c2SC9QUm5zRHM5SUFNZ3NGeHZQQVpGdmJhYWN1VzY3TUpkRmJFYy93U1JO?=
 =?utf-8?B?aVI5cWptbnBhVkMrTGlXcUFxemNXNWxuREY1Q2FzbWtXU0VXN1crM2ZaOE0y?=
 =?utf-8?B?QUJQSWhoT2U3TE1YRFllbG9xNGZraHB3V2RpQzZyd3BqSXNCTW0wSTRjR3F6?=
 =?utf-8?B?K3ljck83ZDZrMTRZKzhsRXlNK3pvNFJDZ1RyeUdlRFYrdi9hTWZ4OU9RVi9o?=
 =?utf-8?B?VytYQkVzWVJOVEV4bEd5d3IzWGtvdUVrSEI3dGNuTGRQRHQ4NTEzVnZKcVQv?=
 =?utf-8?B?dE5KN01HTmY0K0VWUzdpaTBjbE53N284Z1VQTlpQSFV1UUFLaXAzZDdoYTdQ?=
 =?utf-8?B?SGZiOFVKbVVHZU9yTnhOVkZSazRQMTVEVHJJenJnSkljeVYxUGpuZWFva2li?=
 =?utf-8?B?OFo4cm9oQWZBNHZBWkhUbVFOTHRqRWt0eXJmWUdzeTNiMU1McGpLMDZONUJU?=
 =?utf-8?B?V3NPcDRzd0VEdDhkQmxVNGZCRUZrakFCTllTamlPTXRPMS9Qcm9jU2E0a1dw?=
 =?utf-8?B?eFlwaE8zY3IyWGNPay9iMmpPUUVraStMTVhveUpUMWFuekpwbWMwV0tKNnJF?=
 =?utf-8?B?Q0pTZEExM0RKWWtUcDk3RDFaK0RJM0doRVJGRU9xZXZLVUg3aEtYUlNvWjRX?=
 =?utf-8?B?UVEyWldnRXNHRk1mMWlpUEhyLzE0VkFRYnIveTIxVVNTKzBJQ29nMERFck15?=
 =?utf-8?B?cnQvUTViQys3bzJtZGwvTzlKdDRvdXIzMUlWY2Q4SkdySTVRNW5veUE5TFk5?=
 =?utf-8?B?R3Blb1hWU2R1MU9KUE9UTlB1K0hjT2VZWVpzUW41WDFYRlJSZFlLYXB6dllH?=
 =?utf-8?B?UlJJZ3A1SmRmei9rYXlJM080MUJBcE5jTE5ZT3ptWEp6RDdRUG1LZkRKWG9N?=
 =?utf-8?B?U3VVaTlBam03bHJUYkJRSzluSVJUQndKdEdqeGMwcStwRzJLN015eTdsNjRM?=
 =?utf-8?B?RkpmaDlmZ1RPc2V0L2VEQXRsKzBtSFVNVDlnVHU4VFowMFYvOThwbVVnS2V0?=
 =?utf-8?B?QnNheW4vTThFOVp4MHFRancyejkxVVhENGlEYmRPMUN2SDZIREcyUFgrUEVw?=
 =?utf-8?B?TTNRZVphKzFhMUFoYk52Y0ZWZ3F0RlBnUjBnZThMYUk2YWgzVVNlTkFlcVFR?=
 =?utf-8?B?bUJ4VUhOYWFMbWNUM211aFJVNTZkeXNrNHZLOXhMMmwzSVFHL1hLN0FOdDRm?=
 =?utf-8?B?RHRDZDY0dEd4ZUdQZ3hGOGcraDFrVEEwdnZQdDRHWE9YK29oYkMyamtPU2do?=
 =?utf-8?B?bytILzVaZWFoMzBZVzVsV0xMTmZ0UFdnTHRSbmtOdjdDckxXWE1hc0J3Ukcy?=
 =?utf-8?B?UzdlMVJ4a2RBNG1KaUxQMFQ2dlNTOVNkSmpSa0ttdFFaT3N4Q1lTc2o0ZjFl?=
 =?utf-8?B?WWk2QUNZWFNKOHZqcDJLSm1FRU1hTVJmT3BML3paS2dwRlBwdXdNVUo4Qmpk?=
 =?utf-8?B?MTlJY2NQK0ZBSmlSZlZNNUN6RlBoWDRTTlkveGFRZVFVeXFURTVjTGZnOGxa?=
 =?utf-8?B?ZHROemM0elVMNXFUSno0bERTV1dhY3NZclhDY2ZCYzhiMUtvMWNCS1FhSE5K?=
 =?utf-8?Q?aYlcjVtvg3tnNorgtkXaItkWnIunn9O89VQx4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd359834-b731-4501-d497-08d8d82d4f53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:00:39.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZWRTnSmnHGwBERa19eB7aV4+0KodeYFMKQIrKgByNtLgaCoN71Z2v7tRVT71SVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=939
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/23/21 12:06 AM, Andrii Nakryiko wrote:
> On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With later hashmap example, using bpftool xlated output may
>> look like:
>>    int dump_task(struct bpf_iter__task * ctx):
>>    ; struct task_struct *task = ctx->task;
>>       0: (79) r2 = *(u64 *)(r1 +8)
>>    ; if (task == (void *)0 || called > 0)
>>    ...
>>      19: (18) r2 = subprog[+18]
>>      30: (18) r2 = subprog[+26]
>>    ...
>>    36: (95) exit
>>    __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
>>                          struct callback_ctx * data):
>>    ; struct bpf_iter__task *ctx = data->ctx;
>>      37: (79) r5 = *(u64 *)(r4 +0)
>>    ...
>>      55: (95) exit
>>    __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
>>                            __u64 * val, void * unused):
>>    ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *unused)
>>      56: (bf) r6 = r3
>>    ...
>>      83: (18) r2 = subprog[-46]
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/xlated_dumper.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
>> index 8608cd68cdd0..b87caae2e7da 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
>>          else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>>                  snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>>                           "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
>> +       else if (insn->src_reg == BPF_PSEUDO_FUNC)
>> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> +                        "subprog[%+d]", insn->imm + 1);
> 
> print_call_pcrel() doesn't do +1 adjustment, why is it needed here?

original intention is to have imm + 1, so user will directly get to the 
target insn. But yes, it makes sense to be consistent here. bpf 
programmer may already know to add 1 implicitly to the current insn
index for the target. Will fix in the next version.

> 
>>          else
>>                  snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>>                           "0x%llx", (unsigned long long)full_imm);
>> --
>> 2.24.1
>>
