Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225C45AD0C
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhKWUMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 15:12:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240262AbhKWUMD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 15:12:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANIdPML032711;
        Tue, 23 Nov 2021 12:08:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=37Fz0ztTG+KmTjD1B/m8JJgDogiuU2MMh9jGvSb8AYg=;
 b=Yb9oHHyLYQT5kR/QOjL/h7prjlsJVBnUiMlq5+CAtCK+MieyQ5tMZBjbtXAjiowY8QYN
 UCb70ougLW7oAe15Lbtm4seD0lcm/9jNUF5Cfg1GMwOtD9mz0FyJfMWJIB+EPZ8V5fgr
 bPdWnNgq2t3iQeYBblcr5m06coGajh6VmDA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jsst8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 12:08:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 12:08:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyxqWExI3ZNITKf1bdSk+Blov8lwYWyhWhX4Zntwp4RhO7l2j/OQS5eH4HAU/pWfnHLduXCuafbwMKwxQFgGpEjTdvpy2yduXx9vM/qoeA7CtCSg75eJAOVEj6ptMDYBESZgszNImRUXR73z6O7XDJPNDQbjdQvRB9wxcUFYK/QorpHFC2Eyd5yWNbrORKc8vlZ4H8jESpIv6EUm94nVdSniEN72ulhaWr3hodGgxPAhs9KBoYKpo6a8e0nv9MMHMVD0eytHCJVOZ32cQ0RKGo89Ysxf0erR8Y82BabGO+s6PQSDNC5AnKsJ8+olF7XWeXp+ztKL7xGyoS92yFgySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15mDjlo7yNtvtOuaL2ywrvKaBRIc9NniXWorRGWwGQ8=;
 b=h/DqIoZSRGko2y19dAXKLBBwYzB2ZeRGRNlskH5qKmZHsk5uRofva/NY05kCbAGevW6tCTiMorU0qjzQAJC9OZuNSnKUw1tQA4TuLXkwU7KrJxIqhe6tykEWwujVbTEdsi4zI7Y3AdjhD/S1JmsX73kF9ry9xUwOSraHeylVhL04Cg2JUYAV90sAU0xi9ZMHvKqyzkhNuA02bT0B23Fycgc03xGIsIFL2DA5fymYOYIWwiCuWHqtQpBy0VcMLr+zycyNGJthGkQS3CrP/o0Btdr+OFU0D4e4oeMvIw2jXkbcf20joJGxTbnA2yrWCB7mUQwzCmOek+Wt5vJ/kH8HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 20:08:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 20:08:49 +0000
Message-ID: <8ea7650f-e863-2648-cc3e-254ee9f6c0ae@fb.com>
Date:   Tue, 23 Nov 2021 12:08:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: BPF CO-RE and array fields in context struct
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>
CC:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
References: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
 <CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com>
 <c3c0922e-28b3-ff6d-3877-4fe869776004@fb.com>
 <CAA-VZP=JK21mEObrWNWkb=Q-3oKrQMPfVbtA2LpeHDkJVysvsA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAA-VZP=JK21mEObrWNWkb=Q-3oKrQMPfVbtA2LpeHDkJVysvsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:300:117::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21c8::12a9] (2620:10d:c090:400::5:924f) by MWHPR03CA0010.namprd03.prod.outlook.com (2603:10b6:300:117::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 20:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12c6e31-4be6-406a-dfbd-08d9aebd104b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:
X-Microsoft-Antispam-PRVS: <SA1PR15MB46415CD660AD74B0F2C660ADD3609@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khw3n7y3J7JJzn/kyA7gch/yN+PtWKIUubkughkszz/h6RMfwGLdQc3NosHFqwqUzb0pXaX2Hej23bkCTJ1SDQKPjGGoB24zal6L/1ODYpLkbuL0kQ+aM+p3xkUYnHXCpO9fJXsm01Lndy+VVYU31aHoM2XfkSchyYutlQTLbAMhlDGOll9A+dcN+y2QSdpBCekOk/UcUeWNxGSZAxXjkYNQV4QQ+JjuPMniiW87csu14YM5s/PWuKX7NGY9hFwSvjNCqFUi4drpGCxD45XBDrD1xn7MeZb/9+hHA1hkdk+rqnaFewAPAfogBQq88VoRDg9wLN1rwsVu6Z+SE1mgEOx4tudrqFyQhGKppXX0NZ2uQX+EYjOEj8yWrl/Iv3exFePoVnC3UPWleiUxby9ANuJ1ChDBMbGRMNgMKM8kIOi5fwIKU2WC9F2dQXlCnsy4mNrTP01pXBoV4IOZ/znMCx8IJa9uyzbO/q82uu+bHptvQ0AmLwOF48ezoBgA23PEC14NxmOsqc2250fAEigxKEGyA1GDeTK3Y3CKBtSUy3Ro2kyquTlk3LrSFF4YF71RtX9HwYD1SlleLskqSk7zXf1iyEshHI22G9a/hq6CheW2pAfhqKL5SDRYR3/HcyMK11MGzB8iJkW0xw76islj077vPI1DA6BFQXE6bbSsIR2PEwaQ6L91pb1E4rwsen5Mz8k+5Hx4lb7Sh49q5nECYTS7HbhJ9QspelwtN7J7V0ylH3zs/Z+M95jGNwiTvqvyQW3Ol86oB1nCc7sTgijM+N7C9uBIVZmRYnWkdHvpXcitwQ9FImsKol23YP4exd2+pUiqpziRUE7My+TWuhmlCuqLjkVM359l3bStl0QzPLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6916009)(30864003)(83380400001)(4001150100001)(52116002)(86362001)(38100700002)(966005)(66556008)(31686004)(66946007)(53546011)(8676002)(2616005)(186003)(8936002)(54906003)(31696002)(316002)(36756003)(2906002)(66476007)(6486002)(5660300002)(508600001)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRuRVlmajFUVUZZNW9acXlBek45eVJDNkt0UFc3Q2p3UExoa3hSN2lRYkY2?=
 =?utf-8?B?VmNxVTNkMWpVVlNpZlYwbDBsMnEvYzZxYUxxSldUa05GUlpEejc1TUhZK3Vo?=
 =?utf-8?B?T0d6ckNhMkJ6Si9MUkl2SXJvYzlreHYyam5LUklTcjZpVVFXRU0rRGRaUGYv?=
 =?utf-8?B?U2lLQk9YV0pZWFRsTnUvaExnM0RselcxTndKTk5USXVKUlBMZ2d1VnNmOXhF?=
 =?utf-8?B?cHREdHIycURCcG5yRm9zbyt4dlF1cldZZFg5eUMwSDRjbGY4eFZQdHNOUk1n?=
 =?utf-8?B?cEdyV2RhM1Y2cVo1WWtadnZsUGNXdmFzOVFSMFVoR1pnRHZ1UE93RVBaYWMx?=
 =?utf-8?B?VTFIakV1eEx5eW0wZG9TNldycmlSekJKbTdTdVA3V3NqK2N6QytvamlvOGs3?=
 =?utf-8?B?WXVFMDhlUkcvY0tnQlVUWW5GdkdGZW84anllcmYyOXBpMnl5Q0hZMUx4MjN3?=
 =?utf-8?B?ZTdxRlhibDkwZWNRcEJFeDI3NG5yZEJFMkpMdnBYamRISlhVT1VVZytQS0dU?=
 =?utf-8?B?TUxvVTdYTjgzUEMvcWp5WWxySWZrdk9VTUVTOE5TQmRrdm85dy9XN2lBaXly?=
 =?utf-8?B?enpHYnltakZ3YWRwYk5qRHFwLzlSMlprS3VRTEozTVJWd1N2dThSWmh0R3lB?=
 =?utf-8?B?em9GYUtwNERyRUFLVUxZeUhQKzV0VHVLVDR4ak1WdzdGaE9DbmptZklYeFRE?=
 =?utf-8?B?N2pwT0MwbmhRcEZEZHhPazAwOFNobEZJU3JPY3RlYnk2Q0V6RjdkZ0lIbUk4?=
 =?utf-8?B?ME1mM0JvSXBvaVlTMXdqdWJpMW9QWGV2YWVmNWhaSTd3WnBheXlkY0Z4TzVP?=
 =?utf-8?B?NGp4ZUYwZ0xkaUhiSytkMkI2cEk5aDNBMFNhdW9BUkRWTjN3bFVuOGcxSkNP?=
 =?utf-8?B?SkJ0V2VGUy96TDZuSzI5dDNCS2UrdlI0bzM1VWx0N0dUbHlERlJTek4rSkZB?=
 =?utf-8?B?STUwT055eHJVejRRcnhNQ1JzWkIwcExwSWVycGYvYXJHczZOUXpZY3RzSWpT?=
 =?utf-8?B?cEd0ZUpaaEs1cW5CTVJiZGg1QnZYQ3ppc1hpdFZuNHhoNEZjQ0NtenVIMUUw?=
 =?utf-8?B?ZkJHQ1NlSkk0a0R6YmV1cklPT2VIc2tkQzlwTUpBQm9CVnRqYU9xczZPbFRY?=
 =?utf-8?B?aThScHVjV1RQczg1dG1Dd0xhTkZuUFI3RnYxeGRVNnhjamdsNHBySXJUck5L?=
 =?utf-8?B?RS9SU2RGdFpuQlNsVml4cnhTbkpEUDgzV2ZMSnliRU1sMjNTMXdkcERWdkJj?=
 =?utf-8?B?R2R6VWxOazJCaG44MW9zOC90QzRPd0tmYzMzSVJCVHU0Smh1TGYzbkUrQ0xk?=
 =?utf-8?B?Q1lqV3kyZGR0Z0t3WnVVUEorYnRSMjBiR3V0V3VaN1AzRzc4dnhFQWNoeEt1?=
 =?utf-8?B?eVhhVU5IbTNKK0hHVW40UXI1RHNoTC96dkQzVWRyVkVRc2I5WW9TeHlUQXJG?=
 =?utf-8?B?eEZ3emp4QW1sZE5JeXFJZk13YXhQU29IS1BiUG9CL1p2cnUwQUxORWJuZHBr?=
 =?utf-8?B?T2EvUThIVlAyNE1oRis2VTl4dWRFMnFvUTJmdFVSTncwWVhGU2RkV3duQlV5?=
 =?utf-8?B?OHg2V3RYZzN3UUtndkhYL09iUkhoOUkyZzd6U1ZzbGlhNHBJZ0d5Q2hwdkVG?=
 =?utf-8?B?SVhwM24wZExTQTUxQmtRVUhDUDlFdnRXbUNnbjd6R0JNTHEyQ0pIVEhWN05V?=
 =?utf-8?B?NE1DaXMvWTJ5SUZZUDk2bzd4bklEYkp4U0dHQ1c5Y1VjTzZpT01Hd2VqZXBo?=
 =?utf-8?B?UTRHQUJyRGdGekoydUdVZXpsY3RIbisxc2ZKZHpOQ1N1emdPeXZQMGx6TTE0?=
 =?utf-8?B?ZWlnZlpQMXRFTHdhdlp4K3VhMk9KUmkwZ215S1pJYldZbDlZMitKeW9Xc2Qx?=
 =?utf-8?B?eFc3ODVkYlk3d1E4bFIvbnhpaStPRXVYSlVCcWUrVGViQXdyMDk5N2E4Y3Ew?=
 =?utf-8?B?Qk1oQkp3eHBqN3ZzQWQ5L3A5Z1lWSTU5WG82OHBOb2Z3NTJ3RmFicEdINm0r?=
 =?utf-8?B?TVFhWmpObjhIWjQ3TTRXdkNsb0dTR3Q3dHlHSUFBVURJL3ZmM3VVOU9zZ2Jr?=
 =?utf-8?B?ZTJJSXArb2xtR0V1SDEreWF5M1hpN2FxRTJCVmgvMHRKbHpxSk4xZ0RuaHdy?=
 =?utf-8?Q?Nytv3h8660PXi6Vst/WRPLFCd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c6e31-4be6-406a-dfbd-08d9aebd104b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 20:08:49.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsuhyMQWf2LCkHNwlN2GwSkziw1l8bbyuVpklKngDbL/aaO41Ag/V4pKg/LyeTVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3EaFInKbwoesHMkTthA_HzOx9OK0mpQz
X-Proofpoint-ORIG-GUID: 3EaFInKbwoesHMkTthA_HzOx9OK0mpQz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_07,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/21 8:15 AM, YiFei Zhu wrote:
> On Mon, Nov 22, 2021 at 4:24 PM Yonghong Song <yhs@fb.com> wrote:
>> On 11/22/21 12:44 PM, YiFei Zhu wrote:
>>> On Mon, Nov 22, 2021 at 8:19 AM YiFei Zhu <zhuyifei@google.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> I've been investigating the use of BPF CO-RE. I discovered that if I
>>>> include vmlinux.h and have all structures annotated with
>>>> __attribute__((preserve_access_index)), including the context struct,
>>>> then a prog that accesses an array field in the context struct, in
>>>> some particular way, cannot pass the verifier.
>>>>
>>>> A bunch of manual reduction plus creduce gives me this output:
>>>>
>>>>     struct bpf_sock_ops {
>>>>       int family;
>>>>       int remote_ip6[];
>>>>     } __attribute__((preserve_access_index));
>>>>     __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>>>       int a = d->family;
>>>>       int *c = d->remote_ip6;
>>>>       c[2] = a;
>>>>       return 0;
>>>>     }
>>>>
>>>> With Debian clang version 11.1.0-4+build1, this compiles to
>>>>
>>>>     0000000000000000 <b>:
>>>>            0: b7 02 00 00 04 00 00 00 r2 = 4
>>>>            1: bf 13 00 00 00 00 00 00 r3 = r1
>>>>            2: 0f 23 00 00 00 00 00 00 r3 += r2
>>>>            3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>>>            4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
>>>>            5: b7 00 00 00 00 00 00 00 r0 = 0
>>>>            6: 95 00 00 00 00 00 00 00 exit
>>>>
>>>> And the prog will be rejected with this verifier log:
>>>>
>>>>     ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>>>     0: (b7) r2 = 32
>>>>     1: (bf) r3 = r1
>>>>     2: (0f) r3 += r2
>>>>     last_idx 2 first_idx 0
>>>>     regs=4 stack=0 before 1: (bf) r3 = r1
>>>>     regs=4 stack=0 before 0: (b7) r2 = 32
>>>>     ; int a = d->family;
>>>>     3: (61) r1 = *(u32 *)(r1 +20)
>>>>     ; c[2] = a;
>>>>     4: (63) *(u32 *)(r3 +8) = r1
>>>>     dereference of modified ctx ptr R3 off=32 disallowed
>>>>     processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
>>>> 0 peak_states 0 mark_read 0
>>>>
>>>> Looking at check_ctx_reg() and its callsite at check_mem_access() in
>>>> verifier.c, it seems that the verifier really does not like when the
>>>> context pointer has an offset, in this case the field offset of
>>>> d->remote_ip6.
>>>>
>>>> I thought this is just an issue with array fields, that field offset
>>>> relocations may have trouble expressing two field accesses (one struct
>>>> member, one array memory). However, further testing reveals that this
>>>> is not the case, because if I simplify out the local variables, the
>>>> error is gone:
>>>>
>>>>     struct bpf_sock_ops {
>>>>       int family;
>>>>       int remote_ip6[];
>>>>     } __attribute__((preserve_access_index));
>>>>     __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>>>       d->remote_ip6[2] = d->family;
>>>>       return 0;
>>>>     }
>>>>
>>>> is compiled to:
>>>>
>>>>     0000000000000000 <b>:
>>>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>>>>            1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
>>>>            2: b7 00 00 00 00 00 00 00 r0 = 0
>>>>            3: 95 00 00 00 00 00 00 00 exit
>>>>
>>>> and is loaded as:
>>>>
>>>>     ; d->remote_ip6[2] = d->family;
>>>>     0: (61) r2 = *(u32 *)(r1 +20)
>>>>     ; d->remote_ip6[2] = d->family;
>>>>     1: (63) *(u32 *)(r1 +40) = r2
>>>>     invalid bpf_context access off=40 size=4
>>>>
>>>> I believe this error is because d->remote_ip6 is read-only, that this
>>>> modification might be more of a product of creduce, but we can see
>>>> that the CO-RE adjected offset of the array element from the context
>>>> pointer is correct: 32 to remote_ip6, 8 array index, so total offset
>>>> is 40.
>>>>
>>>> Also note that removal of __attribute__((preserve_access_index)) from
>>>> the first (miscompiled) program produces exactly the same bytecode as
>>>> this new program (with no locals).
>>>>
>>>> What is going on here? Why does the access of an array in context in
>>>> this particular way cause it to generate code that would not pass the
>>>> verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
>>>> strict?
>>>
>>> Additionally, testing the latest LLVM main branch, this test case,
>>> which does not touch array fields at all, fails but succeeded with
>>> clang version 11.1.0:
>>>
>>>     struct bpf_sock_ops {
>>>       int op;
>>>       int bpf_sock_ops_cb_flags;
>>>     } __attribute__((preserve_access_index));
>>>     enum { a, b } static (*c)() = (void *)9;
>>>     enum d { e } f;
>>>     enum d g;
>>>     __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
>>>       switch (i->op) {
>>>       case a:
>>>         f = g = c(i, i->bpf_sock_ops_cb_flags);
>>>         break;
>>>       case b:
>>>         f = g = c(i, i->bpf_sock_ops_cb_flags);
>>>       }
>>>       return 0;
>>>     }
>>
>> This is another issue which actually appears (even in bpf mailing list)
>> multiple times.
>>
>> The following change should fix the issue:
>>
>>    $ diff t1.c t1-good.c
>> --- t1.c        2021-11-22 16:00:13.915921544 -0800
>> +++ t1-good.c   2021-11-22 16:12:32.823710102 -0800
>> @@ -5,13 +5,14 @@
>>      enum { a, b } static (*c)() = (void *)9;
>>      enum d { e } f;
>>      enum d g;
>> +  #define __barrier asm volatile("" ::: "memory")
>>      __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
>>        switch (i->op) {
>>        case a:
>> -      f = g = c(i, i->bpf_sock_ops_cb_flags);
>> +      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
>>          break;
>>        case b:
>> -      f = g = c(i, i->bpf_sock_ops_cb_flags);
>> +      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
>>        }
>>        return 0;
>>      }
>>
>> Basically add a compiler barrier at the end of case statements
>> to prevent common code sinking.
>>
>> In the above case, for the original code, latest compiler did an
>> optimization like
>>        case a:
>>            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
>>        case b:
>>            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
>>      common:
>>        val = load r1, tmp
>>        ...
>>
>> Note that reloc_offset is not sinked to the common code
>> due to its special internal representation.
>>
>> To avoid such a code generation, add compiler barrier to
>> the end of case statement to prevent load sinking in which case
>> we will have
>>       val = load r1, reloc_offset(...)
>> and verifier will be happy about this.
>>
>> The commit you listed below had a big change which may enable
>> the above compiler optimization and llvm11 may just not do
>> the code sinking optimization in this particular instance.
>>
>> I guess the compiler could still enforce this. But since it does
>> not know whether the memory access is for context or not, doing
>> so might hurt performance. But any way, this has appeared multiple
>> times internally and also in the mailing list. We will take a further
>> look.
> 
> I see, thanks for the explanations. What is interesting is that prior
> to that commit reloc_offset(i->bpf_sock_ops_cb_flags) is generated
> only once. The disassembly matches that of
>      case a:
>      case b:
>            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
>            val = load r1, tmp
> 
> Whereas with the compiler barriers, both compilers generate (no common code):
> 
>    0000000000000000 <h>:
>           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>           1: 15 02 0a 00 01 00 00 00 if r2 == 1 goto +10 <LBB0_3>
>           2: 55 02 11 00 00 00 00 00 if r2 != 0 goto +17 <LBB0_4>
>           3: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
>           4: 85 00 00 00 09 00 00 00 call 9
>           5: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>           7: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>           8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>          10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>          11: 05 00 08 00 00 00 00 00 goto +8 <LBB0_4>
> 
>    0000000000000060 <LBB0_3>:
>          12: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
>          13: 85 00 00 00 09 00 00 00 call 9
>          14: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>          16: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>          17: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>          19: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> 
>    00000000000000a0 <LBB0_4>:
>          20: b7 00 00 00 00 00 00 00 r0 = 0
>          21: 95 00 00 00 00 00 00 00 exit
> 
> Did the linked commit create the special internal representation so
> that they cannot be common code sinked, or is there some other issue
> going on, or am I misunderstanding something?

Yes, the linked commit added a special builtin with additional
ever-increasing argument to prevent reloc_offset from sinking.
This is to ensure the relocation related codes won't be separated into
different basic blocks. But this won't be able to prevent the issue
you described in the above.

> 
> Thanks
> YiFei Zhu
>>> The bad code generation of latest LLVM:
>>>
>>>     0000000000000000 <h>:
>>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>>>            1: 15 02 01 00 01 00 00 00 if r2 == 1 goto +1 <LBB0_2>
>>>            2: 55 02 0b 00 00 00 00 00 if r2 != 0 goto +11 <LBB0_3>
>>>
>>>     0000000000000018 <LBB0_2>:
>>>            3: b7 03 00 00 04 00 00 00 r3 = 4
>>>            4: bf 12 00 00 00 00 00 00 r2 = r1
>>>            5: 0f 32 00 00 00 00 00 00 r2 += r3
>>>            6: 61 22 00 00 00 00 00 00 r2 = *(u32 *)(r2 + 0)
>>>            7: 85 00 00 00 09 00 00 00 call 9
>>>            8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>           10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>>>           11: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>           13: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>>>
>>>     0000000000000070 <LBB0_3>:
>>>           14: b7 00 00 00 00 00 00 00 r0 = 0
>>>           15: 95 00 00 00 00 00 00 00 exit
>>>
>>> The good code generation of LLVM 11.1.0:
>>>
>>>     0000000000000000 <h>:
>>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>>>            1: 25 02 08 00 01 00 00 00 if r2 > 1 goto +8 <LBB0_2>
>>>            2: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
>>>            3: 85 00 00 00 09 00 00 00 call 9
>>>            4: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>            6: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>>>            7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>            9: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>>>
>>>     0000000000000050 <LBB0_2>:
>>>           10: b7 00 00 00 00 00 00 00 r0 = 0
>>>           11: 95 00 00 00 00 00 00 00 exit
>>>
>>> A bisect points me to this commit in LLVM as the first bad commit:
>>>
>>>     commit 54d9f743c8b0f501288119123cf1828bf7ade69c
>>>     Author: Yonghong Song <yhs@fb.com>
>>>     Date:   Wed Sep 2 22:56:41 2020 -0700
>>>
>>>         BPF: move AbstractMemberAccess and PreserveDIType passes to
>>> EP_EarlyAsPossible
>>>
>>>         Move abstractMemberAccess and PreserveDIType passes as early as
>>>         possible, right after clang code generation.
>>>
>>>     [...]
>>>
>>>         Differential Revision: https://reviews.llvm.org/D87153
>>>
>>> YiFei Zhu
>>>
