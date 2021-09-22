Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AF413EEB
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhIVBSh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:18:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42460 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhIVBSg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 21:18:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLGMdr014657;
        Tue, 21 Sep 2021 18:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=se1y3w4KAMRnUKskfTHSvJUN6y75kn/UDHw+GYY4gpg=;
 b=cHOzKALgQztgwbFyo/K+E3HuagNZhWrppG29RoAaQsMqvD7VlFxqtMlUhOcqrOKYXwze
 Esmn5MOb7uJ6Yi7CUsm9YgFmUrmoEaV4vwGuQekx2uiOOYLpk4AdYobNHSU+4rlm9QRB
 P6KAbN0ruuNP2W4SghW5MZMvqUbq6SMclPE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5bh4wh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 18:16:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQsuvbDsZnEb31hNSisJ9qhPGqx1tc2ncGYz1knfkRPAj+pD6x/GSISP4ROeImLsL6jp9KBMYxBAhkIlLtxeYZjPOf+mJraOah1r3I3rVFNe7TBxyptPyIGE1WitHnDYcJiDseiZWZ8McfK8sCAPfoiZ7q14mCaD0+QH/0i3ZJ+cgrs9VsLUo8QDc+6XObrSujYyAYWZVy9D+bX+4GuXOxdmgLsajMlyvKACu0+WDI/n6/f7QoY0QTe4Fid2TMn38SsuAQQozACt0TyxuGs4mFmd6Bh7sYdP8brzCx3KcZ/apAl2nbP+kCSrXsBZEQidRlqNzlrCZ0yTYnCtr7kuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=se1y3w4KAMRnUKskfTHSvJUN6y75kn/UDHw+GYY4gpg=;
 b=YuP0VCXFyK7DIHVHlPhv8x7TmMPacAMGZ5YoAJbHtLo8uiSjHwOWtL+azkZTixfInQniP6PvkwJQrzG/jgVNN0MEBwVTSl8gScV71cd0nbFNxLHhM6GeiJCybekVInFmkSPZvZtm/qCiucwUsIWqqpUsOzCSP1ipewYxa026lgIEiDuDamMLbi13NJfvU3PFn/QEFLSDWxB3uvQzI2YYNKqB0hC2nqZua0IgtmIeg4tPcvuooIwkQuDXqSVbz/FgqjjeJhWMU6fVfURufaw/CVa2b6vlAZNFODCvAKZ8PiVdxvYe62BjmBRBVdLSJzAWDlNp3gQVN8asptRWNsyfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2416.namprd15.prod.outlook.com (2603:10b6:805:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:16:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4523.019; Wed, 22 Sep 2021
 01:16:09 +0000
Subject: Re: [PATCH dwarves 2/2] btf_encoder: generate BTF_KIND_TAG from llvm
 annotations
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210920003545.3524231-1-yhs@fb.com>
 <20210920003555.3525533-1-yhs@fb.com>
 <CAEf4BzZ2kros1tWOscUOt5nmDd=GZfvtTsn7K7b==QgM-4gsKA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0431c617-5465-6451-c278-b2077ff3d9d4@fb.com>
Date:   Tue, 21 Sep 2021 18:16:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZ2kros1tWOscUOt5nmDd=GZfvtTsn7K7b==QgM-4gsKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21c8::1a51] (2620:10d:c090:400::5:5f7) by SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 01:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8016c75e-dcb0-463d-ac53-08d97d668f60
X-MS-TrafficTypeDiagnostic: SN6PR15MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB241663901BD693DC4541FE1FD3A29@SN6PR15MB2416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8HeVIbKgDX8Fy5yJ4EyQh7Q+P8+ASuFALD144FPcRzTda3iQZf7gW/8kYG4TEE7z4WggODWTb+ldZP3g4AwC7RTIXt/PxeZjhi34y/hp3DKvCLEMl5BJWK0bQuo3ES9b3Pr6gQoIfdohOk/Zt2boCLgm2KZBY3oPQJSoW9eYMkbJu+ON3S/DC2XYxzy+gFZQUXxHd935/F0wWTLgXAZSrYv9o5Bhv+DJMq/kk5TunCAPQ8/MmCzfeR9AHeRKzu+Y2Yz2LHyTRU0iOTCzD3WQ0+OQ+6eGsztqhkwXkNwP/gt5cJhqRk8vRnu/E3iiMBf+S+ul+SvoNP2hfuK3L3o1tt2xj/3+SZyAUnZZL/DjVd+cF/qz2u1nOq0UQz6ZrBi+RMdg74KrxC7iizDckgzOPyb6rGqXUasfcc/oYzDH7QhFCck/i9BbNxiDmcVTLtzcwYXn7MzZOn6JM7cM/uvsAIdEYTz95oVKbumWldHEh/anrP21bzm1fcmF2R6jl+mGwukCYhMwpQUw7W0XUpOKkPJ525XOAt5H6KxCQV93S7Qdwi/fCX5mwFBQ3bWuI5eQjt5KkxknwFdo1Ug8B9A3sdA7NT1esRAAjUeK6XVO+lLEFT+umRSocDyOmdvzCRPRWbBlnl7DSHcwQZ+qiTIpR477SosuRwbvtS9TMigfftpvkZrh7eWyy7RCI8yw5q2v/BhyMJdGmWITrFyuALkW5TEDvGgZYBGRBSPy48NjtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(86362001)(8936002)(52116002)(508600001)(2906002)(31696002)(66946007)(6916009)(2616005)(31686004)(38100700002)(4326008)(54906003)(186003)(316002)(8676002)(6486002)(83380400001)(5660300002)(53546011)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2RzZ0E3Z2lkR2RaT3EzUDVGb05XYWNRNmhNdUF6WlhMamFtVmtUNUJYSUdq?=
 =?utf-8?B?UnRKdC9LOGtjQ0FpSEpNRFUrSzk4M1owbHJjMGVQeHNFWXJTdHdDMWM2MEtS?=
 =?utf-8?B?RnRtT1Z6Q21CWWN6VEhhbXl0VkxsT3FXNDdwR1ZrZVRvS25QbjIzdnRHa3A3?=
 =?utf-8?B?SkJrbjZENkU2SE5zdkxXTlI0a2RST2FWYmJOVkFadXZMblQzOHBMTmsyaERp?=
 =?utf-8?B?YjkzSXpaTzNMWE9QdncxZWFIUE1yNVdtdGFWaXFNM3k0Wm94NzhuR0RpQS9E?=
 =?utf-8?B?WldGRUYwbEdoOUQ2K1A3L1lYbjgzNDBQNWdDV0tPMlN5SWcySGMwdm16ek5K?=
 =?utf-8?B?ZDNYMTVXRFpCdzByYU1vQ29wWHB0VkRLbGQ5YnZYRWh5Z2M2ZGdneDlEbnJK?=
 =?utf-8?B?TW94dzVzVkdSY0FMSlA0eEsrRFpZTmU5dnkwRXpvQm9TU2w5NDBKRysydzdh?=
 =?utf-8?B?YnUrYXJTb0xPSWhUNCtPUXlldDdVVDd4ZDlBdHFQSUI4dWx5UXkwRm9JMlhq?=
 =?utf-8?B?NmIybjcxMGlMMHpRZjFKcmhKZTF4aVBmZk9PcnFMUDc5U0xTdHVXTEdET0Vy?=
 =?utf-8?B?L0JrNVZPMjk0akpwbVZrbmRXSmJZTjd3MEZidmhvN1VkczlqczdYZE1kUTlF?=
 =?utf-8?B?cWQ0V3RQdDdGUWlIS00zZnFKYS9DSVlLSzV2L0VKR2NrYnJmU1hSSURyT1ZF?=
 =?utf-8?B?U0JyRXlRS2N2ZXd1S2ZDV2w1RERYWWpUSFRUREFZb3RVNGRERDFzbWRUUTB3?=
 =?utf-8?B?Y0RlbjhVRWwxbmJTOGZRYXREN0Jka1ljaEtWQ3V2YnZxa0lJUS9yb1lFcEFT?=
 =?utf-8?B?Z2U4Z28xUGhKaHdKN2pCT1g5dklrcThWYkhadTdDSGxocFJJVUlQZEhuMVpp?=
 =?utf-8?B?LzZSeGtMVmdPRE9JeVRuRjZmemNhVVZaUitXcm82NHFtRW9EOS9sWEZ4WWU2?=
 =?utf-8?B?U0srTGMxNWdYT1FqN0tyUUlJY0ZpdFFJUGI2VWo5d0JSMVBmajIwMndXSWdn?=
 =?utf-8?B?YWg0aGpJRGhkTXJKb0JPS3RPZGUrUnZEM0hOcGZRQmlmeEM4T1ZwR25admc1?=
 =?utf-8?B?R1crTmRxV2lpUXliQk8rdHluWWM4RFRuQ29ucjM2SmdBTTBrcFEvSjM3dHo5?=
 =?utf-8?B?bWhkSHV4RTAyQXUzY2dpeE54ZXh3NnFkdHpRUGJuUmxVckFneGtQV3hOMHdm?=
 =?utf-8?B?aUkxMVR4cE91Z0V5aDRlaEhhY3dPOVdtWGgvNWcrVFV4R24xRjJibGF0Z0lP?=
 =?utf-8?B?VDhpZHNwNjdINWo1R1NmT0ZNMUxNOVo4UHE1dnRYT1l0WEp5akRtYThlVzRW?=
 =?utf-8?B?TkxMRGZOZ2RiaUFweVdtdGxsbGEzcUFtenhMTit4OG9INmlZZlY2cGd3ejVm?=
 =?utf-8?B?MnlSaGhpNjhKKzVqbDM5UVl4VE40T2cycGt2bFpGb1VuR09FWnVFWWpKVDdk?=
 =?utf-8?B?NHpnTnNLVnNaUHg4WFFvNHpyNHpSL0hMZlUwWXFHSGYyN3FucUsrcGQxUjF1?=
 =?utf-8?B?aVd4ekg1N3dJNWNzK3cvcXViMHhUb2dYVmNPMW5XSjkxQUhNMXhmSC9ueFJW?=
 =?utf-8?B?Um0wZ0w5YUtzWHZWUi9GU29jQWhTWFVVK1BxU1orYnhoS0hsWHAxVytSWHJ2?=
 =?utf-8?B?aVYzUWl1ajRXM3M5OGw5VE9OYnh2TGRCQWl2UU9GSlFaVlZhdUViQVcxbjd2?=
 =?utf-8?B?QTJQZnJlWnBpM3pHZ0E0MDU3WHUrRklnK25qREZUdHdRWFVjOW11djBYUTBT?=
 =?utf-8?B?ZFZnWWt5NGhZTjdWaUozMTZUbzFmMjhTVjBwVTQycldXa2FJVjVHekZLRW9p?=
 =?utf-8?B?NzFDQUo4WEZWQmgzV084dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8016c75e-dcb0-463d-ac53-08d97d668f60
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:16:09.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di4bOzLyBDtQMD89KQF+l28oe+14C1sTCmNat7F2H90J9fze3OLAX2x9F5+a0eiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2416
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FGUtVBZ-PCIcBJ177_aPwM_z3-bCjffd
X-Proofpoint-GUID: FGUtVBZ-PCIcBJ177_aPwM_z3-bCjffd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/21/21 3:02 PM, Andrii Nakryiko wrote:
> On Sun, Sep 19, 2021 at 5:36 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> The following is an example with latest upstream clang:
>>    $ cat t.c
>>    #define __tag1 __attribute__((btf_tag("tag1")))
>>    #define __tag2 __attribute__((btf_tag("tag2")))
>>
>>    struct t {
>>            int a:1 __tag1;
>>            int b __tag2;
>>    } __tag1 __tag2;
>>
>>    int g __tag1 __attribute__((section(".data..percpu")));
>>
>>    int __tag1 foo(struct t *a1, int a2 __tag2) {
>>      return a1->b + a2 + g;
>>    }
>>
>>    $ clang -O2 -g -c t.c
>>    $ pahole -JV t.o
>>    Found per-CPU symbol 'g' at address 0x0
>>    Found 1 per-CPU variables!
>>    Found 1 functions!
>>    File t.o:
>>    [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>    [2] PTR (anon) type_id=3
>>    [3] STRUCT t size=8
>>          a type_id=1 bitfield_size=1 bits_offset=0
>>          b type_id=1 bitfield_size=0 bits_offset=32
>>    [4] TAG tag1 type_id=3 component_idx=0
>>    [5] TAG tag2 type_id=3 component_idx=1
>>    [6] TAG tag1 type_id=3 component_idx=-1
>>    [7] TAG tag2 type_id=3 component_idx=-1
>>    [8] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
>>    [9] FUNC foo type_id=8
>>    [10] TAG tag2 type_id=9 component_idx=1
>>    [11] TAG tag1 type_id=9 component_idx=-1
>>    search cu 't.c' for percpu global variables.
>>    Variable 'g' from CU 't.c' at address 0x0 encoded
>>    [12] VAR g type=1 linkage=1
>>    [13] TAG tag1 type_id=12 component_idx=-1
>>    [14] DATASEC .data..percpu size=4 vlen=1
>>          type=12 offset=0 size=4
>>    $ ...
>>
>> With additional option --skip_encoding_btf_tag, pahole doesn't
>> generate BTF_KIND_TAGs any more.
>>    $ pahole -JV --skip_encoding_btf_tag t.o
>>    Found per-CPU symbol 'g' at address 0x0
>>    Found 1 per-CPU variables!
>>    Found 1 functions!
>>    File t.o:
>>    [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>    [2] PTR (anon) type_id=3
>>    [3] STRUCT t size=8
>>          a type_id=1 bitfield_size=1 bits_offset=0
>>          b type_id=1 bitfield_size=0 bits_offset=32
>>    [4] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
>>    [5] FUNC foo type_id=4
>>    search cu 't.c' for percpu global variables.
>>    Variable 'g' from CU 't.c' at address 0x0 encoded
>>    [6] VAR g type=1 linkage=1
>>    [7] DATASEC .data..percpu size=4 vlen=1
>>          type=6 offset=0 size=4
>>    $ ...
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   btf_encoder.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
> 
> [...]
> 
>> @@ -1244,6 +1266,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
>>                          goto out;
>>                  }
>>
>> +               list_for_each_entry(annot, &var->annots, node) {
>> +                       btf_encoder__add_tag(encoder, annot->value, id, annot->component_idx);
> 
> check errors?

Yes, I missed it. Will fix this and the following two other instances 
and send v2.

> 
>> +               }
>> +
>>                  /*
>>                   * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>>                   * encoder->types later when we add BTF_VAR_DATASEC.
>> @@ -1359,6 +1385,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>   int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>>   {
>>          uint32_t type_id_off = btf__get_nr_types(encoder->btf);
>> +       struct llvm_annotation *annot;
>>          uint32_t core_id;
>>          struct function *fn;
>>          struct tag *pos;
>> @@ -1396,6 +1423,20 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>>                  encoder->has_index_type = true;
>>          }
>>
>> +       cu__for_each_type(cu, core_id, pos) {
>> +               struct namespace *ns;
>> +               int btf_type_id;
>> +
>> +               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type)
>> +                       continue;
>> +
>> +               btf_type_id = type_id_off + core_id;
>> +               ns = tag__namespace(pos);
>> +               list_for_each_entry(annot, &ns->annots, node) {
>> +                       btf_encoder__add_tag(encoder, annot->value, btf_type_id, annot->component_idx);
> 
> same, this can fail
> 
>> +               }
>> +       }
>> +
>>          cu__for_each_function(cu, core_id, fn) {
>>                  int btf_fnproto_id, btf_fn_id;
>>                  const char *name;
>> @@ -1436,6 +1477,10 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>>                          printf("error: failed to encode function '%s'\n", function__name(fn));
>>                          goto out;
>>                  }
>> +
>> +               list_for_each_entry(annot, &fn->annots, node) {
>> +                       btf_encoder__add_tag(encoder, annot->value, btf_fn_id, annot->component_idx);
> 
> and here as well
> 
>> +               }
>>          }
>>
>>          if (!encoder->skip_encoding_vars)
>> --
>> 2.30.2
>>
