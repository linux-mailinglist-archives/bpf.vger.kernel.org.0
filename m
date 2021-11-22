Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DDD4598B3
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhKVX75 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 18:59:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47500 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230337AbhKVX75 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 18:59:57 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMMFXaC024967;
        Mon, 22 Nov 2021 15:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5PWq1ThBY4NZVxwaotO6k1q0L8KNS2xz3hZjtxLoDVE=;
 b=I1QN4KCioVw+wZBLPmmDYOvPcwBTdrMG2fcqd0CUMkL5mnjVIb/Te0bU6h11gkMspHGr
 8hl7lxl4L8UOZbfiM8YQ+2TRRpqvmf5nYOW2T24XquR1tu2cQluwcmcdCIVgN2FtedQb
 mysOB+vzV5bUdR1iIRUjzWv/LFPvd5LCEx8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cg2v9ewvn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 15:56:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 15:56:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+MrHywqeuG5I9E0SbOh7AvdpkZIQCY/ufadHHZQhkhSTIjhoH81yRjJ1qly9fvnqh/MU3jqGTRXTVv8+chslLZhHxAt8sG2itXiwGM1s9lXqvNVLGEyqRoAtmVp8a6bgBexsWlRCXq2q9mOQACaSgCQhBDdEqBcrAc0D10ChO44Y09xNvqzph3hR7Wsn4ye2T17y0z2UbKU6jmzZIjPscsvey8It8lm212+PGMytY9NtrIQxpx7CDJ4B0FIovDDhSPbVx10ZKA2UJg1WS90HBwERwR2MdqX+v3Pwdn3zfHwuIjHr7cYbD6v+M8hWSZ7oXV9JXnjsuyVn6LYh4Nkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PWq1ThBY4NZVxwaotO6k1q0L8KNS2xz3hZjtxLoDVE=;
 b=lLtCGXO7F6YjZ6MI5Ze3oRFzZ6LGy4qo3F4ZCthvKLzpfcXRjM5KRv6xsurJf7seDkGsSGbjJe1JIc3CX7rUZBxKKv0ZCigU4AVJY/T6xHL8pyzm58JxqDGU3uCeJnYSULHqgwOqmSIvL/juaKPdVdw18biLH4yOFAu5Jgfqxo5j2isA1nmSsbhrGm/me4KCJ4Fd7LwEeutbXQf7AGKxRdBToHpEPFl69ZtHUmmNVk/dn7GkhAj79eech6WTPRgc8yipTGdgfhFAJbQthbroFEienP/jdgfHMUiFpx+Bw506jrPaOGLciS1h0JTWc1kBTpKiBqDKp96Ia5s6FbiA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4872.namprd15.prod.outlook.com (2603:10b6:806:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 23:56:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 23:56:39 +0000
Message-ID: <94ae70b0-a422-c0b3-7c42-d6a787b45bbe@fb.com>
Date:   Mon, 22 Nov 2021 15:56:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: BPF CO-RE and array fields in context struct
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>
CC:     Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
References: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::14f6] (2620:10d:c090:400::5:7eab) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 23:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ca1ba4-d9c4-478d-951f-08d9ae13b998
X-MS-TrafficTypeDiagnostic: SA1PR15MB4872:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4872F342196B8E09EF23F9A7D39F9@SA1PR15MB4872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3MObT2U5FX647UcwgHZz6ip8TQHn1tm3bWw8BN4kThSOqspYwUmW7CN5noKdpfqaycUz7BEnTCVRsyDpJfj0YefiFnoSHNVMYqi1oVP3O1uTSIbPrtWIFyR9pAETWl7mz/QTv9GgbmxUgmWvpk64ufAkqo95JDK91LRtvUPZ6IydeIGumsborzKxeit/eF7HQch7kmlfBCFYiqC1zr2mRhDwU57UNReGg4eYFv6XTpVae32vim3N/Ml2IM0/N6GkkHQqYyhWw8DO6+HIHffRm4Qpzmj8wLZFwWwKZ9ZP2lytLSHR9DRk9c54lgR24KI6Ykrr8/Qt+ZPuqwKUSSWQHB+ROQAdd4noe01doS0s00pAwDmMUyS+iIKb3mmXPKwTG9PSbfDnrPc+/IsnNm2nlP8a3rjyxQDfB/BydEUvmggroZYmc2XTCUsviYZNZsQTtDuQ2fZmnrZ+zOA2YLcU9xB2I4jeitPOnx2F8hBqTHRD1CZ9YNT3VSxIDvQxVKtD82BQHpATnXUVxs8n4tUq755IjIPZKiyjLPY87+5Y1PBkGO3JsjwbQF1C4Han1z/Aey6/AC/ncw3G53LogUSIxRoqLPLlnbhkq1i6q/I/UcfwNsMwzC12ZNLl3QIc4y9buWVwWQUS8op2lf6dq2jV59G1bisHW/Y41ohf8Rl7r+J8O3FXdYKtaUz7k9lQgzwhLnmesAfESmwn0yGU4eEThA5HLwbH2UHkfnc5kxhmCBb7ybXvjKtj5YK0MyhQWx5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(2616005)(8936002)(5660300002)(54906003)(66476007)(66946007)(110136005)(316002)(2906002)(66556008)(6486002)(83380400001)(31686004)(186003)(53546011)(31696002)(38100700002)(6666004)(8676002)(52116002)(4326008)(86362001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elMzV0k1eE5lSmMraE9QbXZoamxUZ0JOcElPR0J6MHFpY0c3eHRjVTJsbjdY?=
 =?utf-8?B?cFN0UVg5TlBZL1pqTjRMSjNIcGhTQUJYTUovTktzWXdhS3R3ZmhxWldWcmlG?=
 =?utf-8?B?SGJGL21PNDJKNEdJLzR2Y2x5K3RLMzZ6SUdoMitjTEpGWXdOa1hMMHErYUVo?=
 =?utf-8?B?Z0dpb00vbDc4TjFHV3p6c3hReVBtMUFMemx1N3c2NFNWcE9QcFdpZFpQei9q?=
 =?utf-8?B?S0dvSlBkSHo1WVE5b2wxb0NmSTk5cVdvZStBQVBEV1BNNzdiWVgydjRaOTdO?=
 =?utf-8?B?WGJRQnAzcFdDaC91UkVnMWo5V0ZFKzJDaUFZaXNtemkrRGoyUVNBWWJxZmFC?=
 =?utf-8?B?M05wNWV2azZ2TUhBYUlKRzhtQmk0UEd0Wi9EdWdHdmZvOTNFOW1EaFM4TFh6?=
 =?utf-8?B?c1F1K1FHT09mL3VOaVFRTzNrQW5zaEw0S2VTTlFRdVRZVVRsN09ROFVybUMr?=
 =?utf-8?B?OEllbncwZ0JublBQZlBWdFNCV3Z3S0VDbzc1aGc5TG9GRnNhbTg1RDdnNUMr?=
 =?utf-8?B?QVlYVHQ5bG04T0JFUGxSQVJZcWJtSzczZDVFajZWdHMzRmpYQVo0dEtnSnlL?=
 =?utf-8?B?ZFFabzJsZ2IvK2hLMW1rTVlNNlc3L2VzNWtsaFNKeU4ydWdUaXVSaFp6ZUNG?=
 =?utf-8?B?c3JCVW1yVlA3MlBXOGNQdXFSV1hobGwwd2R6WmRSWWs4K3V5ekszVUZUK0Z0?=
 =?utf-8?B?Vmh6MldaUVB1emtNa0QzQzVXdVVRUCt5Ky94c1Yybm4wZDF1dllCMWJIMkFN?=
 =?utf-8?B?eXR5d3NRM3licTl5SHRiMXpOYS9taCtjWDczSXdVN25TUklRaW5OMkliWjFs?=
 =?utf-8?B?dEpyWkFqbUlGOHZ6dGxyd0hhN1JjenFFOVR6NXFRR3JDUllVdXNOeStLd1JR?=
 =?utf-8?B?UDBwcjFTZEtwODB3dlRwMTRNSHBrSDR6S2pwaXFOOUVld0w4dU1SNHlQOFpt?=
 =?utf-8?B?dVhwb2NlNzBoeGJQU2pTVDZmY0FoQXBlWjdRNVZIaE5McDBrRTlhejl2NHcx?=
 =?utf-8?B?THVXdlphb3M4NW4wanNSUWFLa0V1WnNSL01tVWc4WXhoV3dCUVNYQVVUWjdZ?=
 =?utf-8?B?eHFOYW1OYnlaUXQ4dFpDaEgvTmVsakZLbkNSZGN2ZXlLVkJUak5XMTk4TTRy?=
 =?utf-8?B?WXhFdmt3dTR3RXdZZjh6dkxXT2oybzdrc08yOVNHZGFxSWhhb2o1Y0R3M3Uz?=
 =?utf-8?B?dURjVWJaQzdlS0xLN3FQakJwWXkyLzRBMUZJTHdJYWZ0MHlHNGJWZk5nWmRB?=
 =?utf-8?B?TUZTTGdNVnYwRG1QUkxYNU9CY1BkZ2N1WkxUeng2TDQvcjBPWktzU25JMUNt?=
 =?utf-8?B?amNqcDNTS2ZyR1JLRUxDYWo5MG8rOE1na0FTVElHR2tTMXJIMVkzdWdNSi9x?=
 =?utf-8?B?UFE2ellvOEhsdzFWVWpJaGwxakozOXVva1IxbGlrYjRsOWN5dUVrRnA0UzBG?=
 =?utf-8?B?STg2bUt4YVdvdVIrL0xYQ2RKOGpoMi9LdjdYZzJXUHpNNmVTY2R3ZFBuek1L?=
 =?utf-8?B?MnFWeDNNY3BNVVYrYnUrV01TQ0VWMFVYa0xyQjROaFpwQTZzanphbktNZHZr?=
 =?utf-8?B?Z1NkbnhuTGJ3QTN6MlV2cTBMcDdDR3pzRGNHMDdEeHg5Q2RicDR6endoZlJV?=
 =?utf-8?B?cmtTNTNFWklxekJ0NlhmeXp0V3lyRjZ2dGlWTDYvTGJ2bWFsWktOSVRFSGth?=
 =?utf-8?B?UDFTYWd3RWxjTHhkaXlRQU9vd2xySmxCZjM2dkcyMFJkejB5SWlZWm9vOEhH?=
 =?utf-8?B?NlFLdjBja3NXeWNZZVkxajRaeUp4TlFlQ3ducTRnd1Y0RDVEQnhHNXBieU1l?=
 =?utf-8?B?WFB5NzFzNTlORVZRWEw3MEptQW15YjhhWGVJRzNGYjkvRlZWbUhNaHlrSUYr?=
 =?utf-8?B?NkZQVTZERk8rZllKNHB1cTNCdmhWNEJiUE1BTFFsQ2JtT25WUk44c2VuTGY3?=
 =?utf-8?B?eW5jRzNVU0JJMVZVTjBzNjBhNjlzd01oZXAwRFhzMFNRcFNRRFFjSUhPTlJI?=
 =?utf-8?B?WFBHRUpzc2JPdGlONUYxS2NqS09nTlZ0ampCVjNOeXk2TWlPRWE4SWxSNUlr?=
 =?utf-8?B?V0Q2QUhXMlplOG5LWllud1BHaDFPTXRySllxRmsvUEFHY1YyQnFsZGZaa3VE?=
 =?utf-8?B?S2lKZkZHUjhQS3ExM3BlVW96dEVYVkpkMHJlKzRZdExCSVl4eC9paHRRSi9I?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca1ba4-d9c4-478d-951f-08d9ae13b998
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 23:56:39.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj6/aac/j1xFLiq05mG1Ew+hOgThzbwBE0wLZwmd6dW5Tew7rvYkiOdGxN42mEAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4872
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hDdVb7I_UEuXBgaSn4v59NTk71IDBhG9
X-Proofpoint-ORIG-GUID: hDdVb7I_UEuXBgaSn4v59NTk71IDBhG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111220121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/21 8:19 AM, YiFei Zhu wrote:
> Hi
> 
> I've been investigating the use of BPF CO-RE. I discovered that if I
> include vmlinux.h and have all structures annotated with
> __attribute__((preserve_access_index)), including the context struct,
> then a prog that accesses an array field in the context struct, in
> some particular way, cannot pass the verifier.
> 
> A bunch of manual reduction plus creduce gives me this output:
> 
>    struct bpf_sock_ops {
>      int family;
>      int remote_ip6[];
>    } __attribute__((preserve_access_index));
>    __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>      int a = d->family;
>      int *c = d->remote_ip6;
>      c[2] = a;
>      return 0;
>    }
> 
> With Debian clang version 11.1.0-4+build1, this compiles to
> 
>    0000000000000000 <b>:
>           0: b7 02 00 00 04 00 00 00 r2 = 4
>           1: bf 13 00 00 00 00 00 00 r3 = r1
>           2: 0f 23 00 00 00 00 00 00 r3 += r2
>           3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>           4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
>           5: b7 00 00 00 00 00 00 00 r0 = 0
>           6: 95 00 00 00 00 00 00 00 exit
> 
> And the prog will be rejected with this verifier log:
> 
>    ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>    0: (b7) r2 = 32
>    1: (bf) r3 = r1
>    2: (0f) r3 += r2
>    last_idx 2 first_idx 0
>    regs=4 stack=0 before 1: (bf) r3 = r1
>    regs=4 stack=0 before 0: (b7) r2 = 32
>    ; int a = d->family;
>    3: (61) r1 = *(u32 *)(r1 +20)
>    ; c[2] = a;
>    4: (63) *(u32 *)(r3 +8) = r1
>    dereference of modified ctx ptr R3 off=32 disallowed
>    processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 mark_read 0

Thanks for reporting the issue. The example you had here exposed an llvm 
limitation.

For the following code:
   >      int *c = d->remote_ip6;
   >      c[2] = a;

The relocation will apply to d->remote_ip6. And the below code sequence
is for c = d->remote_ip6:

 >    0: (b7) r2 = 32
 >    1: (bf) r3 = r1
 >    2: (0f) r3 += r2

And later c[2] store has the issue as you described above.
Note that llvm does not generate relocation for array access itself.
It needs to be part of access chain like d->remote_ip6[2] to be
relocatable.

> 
> Looking at check_ctx_reg() and its callsite at check_mem_access() in
> verifier.c, it seems that the verifier really does not like when the
> context pointer has an offset, in this case the field offset of
> d->remote_ip6.
> 
> I thought this is just an issue with array fields, that field offset
> relocations may have trouble expressing two field accesses (one struct
> member, one array memory). However, further testing reveals that this
> is not the case, because if I simplify out the local variables, the
> error is gone:
> 
>    struct bpf_sock_ops {
>      int family;
>      int remote_ip6[];
>    } __attribute__((preserve_access_index));
>    __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>      d->remote_ip6[2] = d->family;
>      return 0;
>    }
> 
> is compiled to:
> 
>    0000000000000000 <b>:
>           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>           1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
>           2: b7 00 00 00 00 00 00 00 r0 = 0
>           3: 95 00 00 00 00 00 00 00 exit
> 
> and is loaded as:
> 
>    ; d->remote_ip6[2] = d->family;
>    0: (61) r2 = *(u32 *)(r1 +20)
>    ; d->remote_ip6[2] = d->family;
>    1: (63) *(u32 *)(r1 +40) = r2
>    invalid bpf_context access off=40 size=4
> 
> I believe this error is because d->remote_ip6 is read-only, that this
> modification might be more of a product of creduce, but we can see
> that the CO-RE adjected offset of the array element from the context
> pointer is correct: 32 to remote_ip6, 8 array index, so total offset
> is 40.

In this case, the statement is
    d->remote_ip6[2] = d->family;

And the whole "d->remote_ip6[2]" is relocated. So we generate a single 
instruction for it:
    *(u32 *)(r1 +40) = ...

So the workaround is to have all related field in the statement up to
the load/store operation so we have ONE complete relocation.

> 
> Also note that removal of __attribute__((preserve_access_index)) from
> the first (miscompiled) program produces exactly the same bytecode as
> this new program (with no locals).
> 
> What is going on here? Why does the access of an array in context in
> this particular way cause it to generate code that would not pass the
> verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
> strict?

How can we fix this issue? We could generate IR with relocation 
information for standalone array operation and later llvm can chain
them together. I will take a further look later for a fix.

> 
> Thanks
> YiFei Zhu
> 
