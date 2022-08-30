Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7C5A68CF
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3Qwk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiH3QwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:52:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3911B3E4
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:51:36 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFouHG004811;
        Tue, 30 Aug 2022 09:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DXZZVkg6Gg/yi00AMbFxcKKVvFWRPajAe59a7V25w54=;
 b=OaGj57pJXTmEKkSBq+mkM2C2sgVj9c5vUVb6Ai9B2lho797lCWfXfTieW+HLGYlTA9Se
 ZuMUcUNWXIxexS/9iApzAtFil79fl8J/LNb4/z7uo2F+otsOrfDePSmdSqHfsrtF7Xe8
 Ub2fuAEdkshHWlsJ52xpoBMWYV9mm7Fv/QI= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4budc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 09:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWevFErDLpDEsBUpmC+PAPjkfDjdHFdDkTJvwrZQYU9rTHNiw4IMDD/MdZ3bnlqM6aTK9hVizVK1RhEvHwhcEUTW/ndDceOQKmrjVl5lw7NOqvhbe9yTYLHo9ZIXrrX4jx4pXk0SHS5V46rVC/reI40nn58bnLJyn+zjPLRyzltSykpYhTXYqiXZwpQb1CNmW9KgfLPwObM04hHDZH4zHzM5txVkKVtu232JlhREsrnonO4AP3wbsGbJpPZM5rmieoTPtAkXb4ZNqyEwiFD5YDViaQR4iVpA+pVI9mrlwPdf0BY1qV/1n1N8hQSe42miMUaeNJhPgk7wtjCfjIv2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXZZVkg6Gg/yi00AMbFxcKKVvFWRPajAe59a7V25w54=;
 b=fX/TlX0Z7xW3Vf7x6I0IKbI0AAxw+P0//wxIX83kEowta3U7GkiRERvUA/alb0jMgLWkl/Eh4Gq2NlhxuJ2c+SjGU+8crdy8lzZ5KOkWM+qz9Xt93PQFyzcvXsgli0/jq0EWZAMMRF6l1ggU/9NYeYA0OWUW1Tp9Zg/hCTvwZb+VxHatT+DeHhUQdjUyfpZJyaYzrUP+fox54XGSTxxEd9vCr93V7b7zZQ4p027lkx3/vxS1HGUXO7bkhcEC1u9vM8hS67lIFp6PpVcT5M8QVWuNRho8n4pqhoKdeslVoBeKqLldCy5YxBbReb+wGMkevXL+/hCFDrR7WhX2p2yUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1640.namprd15.prod.outlook.com (2603:10b6:903:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 16:50:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:50:51 +0000
Message-ID: <38061ac2-aef9-fd01-cd05-04114a304c82@fb.com>
Date:   Tue, 30 Aug 2022 09:50:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v3 5/7] libbpf: Add new BPF_PROG2 macro
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025504.144855-1-yhs@fb.com>
 <23f677132165602d3721484ff09b14184d49c664.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <23f677132165602d3721484ff09b14184d49c664.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1acf80d-d4a7-4cd6-a7ed-08da8aa7cc4c
X-MS-TrafficTypeDiagnostic: CY4PR15MB1640:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiWbcl/yYTIxotHkBcWvKrDK9o09CzNDaULOHYyorOoZ0+HRTfR9CJB5+bgUCEmvNEmuWWLKjwZwJRssDqCkt4plqqD+GHsHfKBOnHts9e6d2sLWBcfkBBdAccqhemeU/d38MPhPeuLb0Prm+2kbztmJRJZIss+wiIzVnF7r4lmL1OQ8hJ0kXySg42QPhA0CbD0xPzCOjSQSG6ZcHYDfEWSqbDGaH3imrT29i/K/hIS2SpvuiIEJqO6bZ+PBYLWYtgAQQ/FW628mcH7ggs+IY+B+AhJm265QvvcTNTkKvoz5GKA0nkC2rdebO+HumXZZifBkbP3ZyknqCgzjxxriTkx3Z9sSDO0JplqAqHlj4XutjP7OtigDUTdNVjDLi0YC9lKs2yORXLtt9KAF0Jk6cIbMT8hD1zSkeYgTzSX61jwD3P1EKEoJZWHjpCPa+q0mJ+uuUM76n3wtE4P7DLcUZvCd6j6bFC69OooebPbqtYXq+oKgYl3Rn1T7bFzBXfFCxSrZB/zw2FMqPXsNhHDg9IstWzY06L9XWCoZp3ZP7OVFAVJGNZAKtcHj78o9/FwmFULsvbEcz35JioUWnAU7ExB8I+DADiR2GzDLRuPnwh2cThTqbNMUbP1+z78XWdF83S+1CxOnFtBKPLcqlappuK1H8AKCSQ2futhGiZrTJHqBfChBppO3Gd05WEG2s+iAaB1O/NY3OlHdZHAO90wsehgfDDSksrNqsGEdfX4Dj/40yNFH234FuApIKVAHVQ1zn8OYWJdzXhLU9IUL279GBscIZ+sY6gQaXwzZuPtmGSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(5660300002)(8936002)(41300700001)(186003)(2616005)(86362001)(31696002)(6506007)(6512007)(53546011)(2906002)(31686004)(316002)(36756003)(54906003)(110136005)(66946007)(478600001)(66476007)(38100700002)(4326008)(6486002)(8676002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpSVThWMDN4UitJRmZtUUFWdXRmUjU5anJ6QU1NN2gxMzdZUS8xQy9JSkRW?=
 =?utf-8?B?QVJ1c3FOckpOeThpMHlxTkZCUnp4eWpFTFR1cktzNWRDVkd0eHVFNkNqR3dS?=
 =?utf-8?B?RHVNQ2xMVkR1bURwRlRWSnZ2UWprT09McE4yUUYxSi8rNUVCZWNTMnI4dG9O?=
 =?utf-8?B?cGxDZ2dWcjYyTEFXampOVU5QUE1zOGJkTTVpMDNBZHJFOE8vT1ZDb3RQWXVn?=
 =?utf-8?B?RnFlZUJ1TWpyN0tDYitMNkFaTkFPRVoyVmNmYjl5RmZGbGpwaDRXVktyMmkr?=
 =?utf-8?B?cFdjbERISytBUUd5YTRwdnpEZDR3ZktiWDNWTklnMWxaVksrTklzbG8xQkwy?=
 =?utf-8?B?ajJHQlhTaXVhNTRkZFFYai9IRlFyTDRzSW4zRWJWeVpUYUM1clN1WXpveFds?=
 =?utf-8?B?dTZ4cy9jeW1HQjY2bDVjZEhrWmJYWWJpWlJlbHAwVG1iTjEyUmh6OGVLNkd2?=
 =?utf-8?B?cG9iNXBFZGovb2hrbVNLclpoRVhyNEROZmhVMnFVS3YrclllcGdPbHJTUGd5?=
 =?utf-8?B?WXdVV29uYWU0Y2FyLzhlWmxwTHFtWHdzT3FlMmZVcDNpcjNRYWxvSjhKUnhv?=
 =?utf-8?B?UE9WWHFQWklzMlNDb0V5N0l6T1BLT3BxeXZXWGpPMmpkU3J3WWVwVStMTTAv?=
 =?utf-8?B?ZVpSQTdyZ3dwRzNSbGJrMzAwV2lDcDFkc3p3SGg2Q2FzdVN1YlFlVGdOTVBS?=
 =?utf-8?B?aWs5aHZlaXU4bTJ1bXJWUVZjeklXS1Q0K3NHRmZJWnBzYXcwR1FXQWF2WnZh?=
 =?utf-8?B?R1BmK0RETklRMlhIaG5TSFkza0RQajhMME9xdFV6b2FwZ3RHa3VOeUk1aW9t?=
 =?utf-8?B?d3BMODhLaDN4ZGl6T0RacHFOcS90OHJ5cmNnWDZIdjVVMktnaFJ0TWozUWFn?=
 =?utf-8?B?MlRzMGVIcE9NNU9LZlNHVjdOb3VrT2pzUHh6WkhaM0tvcEhZdFk0TG5PSW0v?=
 =?utf-8?B?WGdqQSs1ckdDVlFqQnQraVF6SklUWGUwUkVkV2pGU2hhZXpEZ3NKaE5MY0JR?=
 =?utf-8?B?N1RhS0ZkS0ZMdmZwUDRqdEhHVURrTmtVa243TjZ0REltMXdBbm9MVjJEeHVz?=
 =?utf-8?B?ZjRwQU93WXlXUzZJOWZvVEpFT1R5NG5JNThQRVRBai9iRUhmUkJhR0hrbWxJ?=
 =?utf-8?B?Tm1kVktqMVA2R09WY2VmYk1sMmlRZUYyL3BueFYwOFRrVUxML1dKeCtoZ3Zt?=
 =?utf-8?B?VldGVENOQUVGczlwdWlhbmFiOUE2SGNrN1cxZWovRlFHS2JTNDhzZkdlRjNL?=
 =?utf-8?B?UUR5Z2FLWE9XNHYrWnczUy9GWXRtV0ViL2xBSUFieGtZc2VKSE41UnJGS0pt?=
 =?utf-8?B?WTRaRmtLYXllb1NrcEVjVHQ5a2ZQWkNkVXVuNVZ4OWxQN29XUXhISDlYN0VG?=
 =?utf-8?B?dFhuc3NWMXE1ckIwb1JhbUJudE1CWlU5dUsrR2RBdGRTZmJFUFdoa25JTVYx?=
 =?utf-8?B?MCtlcDdXdi9UYnA0WDEyQ1ZNR2JrUWlZN2NiUktQYkp6OEI2aXNnVzNnVzBn?=
 =?utf-8?B?R3NQb1JkTUhQUjZTUElrTEM1YnBQaEVxVUVQUHM5MkVoemRpUTJiYXpxZVFH?=
 =?utf-8?B?MTBjbWc3eEZmT25VRVR3WEpsMkRQZ2hKenpYMjVuWHFLQzhxM1pRNWpMUVdI?=
 =?utf-8?B?OHVxNkhVUHdmVzg3Y25KKzRJc2ptMEozWlI1UExoMkc5Z25OQ21IRWRDQXlZ?=
 =?utf-8?B?K1hMNDNIMmZ0ZTUwcUpwT3U1WU5WVlZRVmhmbWNqR0ZWdkI0Zkk2OGZkdnhh?=
 =?utf-8?B?RTFpR3Q1T094MU0yZGJqTWw5SnVIajBKbXZZSDdqSHBXeW9jSVpFRHlpMjdV?=
 =?utf-8?B?NnFSQWJyaDdWK3pJRTkyQzRXYWNSQW9kLzhmaDcvN3cxR3NrUEtuRGxqRVBE?=
 =?utf-8?B?LzhQWUhzOVVSa2VaR2ZMa1pVOEttWlZMZXZTaitjbjRuU3VTNUcxMUJnYVJq?=
 =?utf-8?B?eFlWMFJOYVB1RytnNllFNmNvS2QwK1UwWDV2ZUg2NXRtalJPb1BkUk55TGh4?=
 =?utf-8?B?UWEvYmt4V0RNeWZuWUJnK3BpUmdZSS9PeGxNb3pha1RTWDlPckMycnpGVURv?=
 =?utf-8?B?eEdYWHpCQUZxTUVqeFpwbnh6OTJTYlZydkJkWlF5dEhkeXBoS1VmcDZWYkpW?=
 =?utf-8?B?azZiWVFSanNlUGlZQlBiRkFDSVgvUXgvV1J4RTZMZTRkQnBFN2xzbEFENWxO?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1acf80d-d4a7-4cd6-a7ed-08da8aa7cc4c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:50:51.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61TDwdFZa1JJVWhlUlGsLPdj16OScG0rvfu6Dt9gXxKzR9FXzC+iAyB4Sesvms4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1640
X-Proofpoint-ORIG-GUID: rfneDGKePsjVYQv7hHMkQtzeGenkDDDI
X-Proofpoint-GUID: rfneDGKePsjVYQv7hHMkQtzeGenkDDDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 5:32 PM, Kui-Feng Lee wrote:
> On Sat, 2022-08-27 at 19:55 -0700, Yonghong Song wrote:
>> To support struct arguments in trampoline based programs,
>> existing BPF_PROG doesn't work any more since
>> the type size is needed to find whether a parameter
>> takes one or two registers. So this patch added a new
>> BPF_PROG2 macro to support such trampoline programs.
>>
>> The idea is suggested by Andrii. For example, if the
>> to-be-traced function has signature like
>>    typedef struct {
>>         void *x;
>>         int t;
>>    } sockptr;
>>    int blah(sockptr x, char y);
>>
>> In the new BPF_PROG2 macro, the argument can be
>> represented as
>>    __bpf_prog_call(
>>       ({ union {
>>            struct { __u64 x, y; } ___z;
>>            sockptr x;
>>          } ___tmp = { .___z = { ctx[0], ctx[1] }};
>>          ___tmp.x;
>>       }),
>>       ({ union {
>>            struct { __u8 x; } ___z;
>>            char y;
>>          } ___tmp = { .___z = { ctx[2] }};
>>          ___tmp.y;
>>       }));
>> In the above, the values stored on the stack are properly
>> assigned to the actual argument type value by using 'union'
>> magic. Note that the macro also works even if no arguments
>> are with struct types.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/bpf_tracing.h | 82
>> +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h
>> b/tools/lib/bpf/bpf_tracing.h
>> index 5fdb93da423b..c59ae9c8ccbd 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -438,6 +438,88 @@ typeof(name(0)) name(unsigned long long
>> *ctx)                                  \
>>   static __always_inline
>> typeof(name(0))                                     \
>>   ____##name(unsigned long long *ctx, ##args)
>>   
>> +#ifndef ____bpf_nth
>> +#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,
>> _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N,
>> ...) N
> 
> ____bpf_nth() is a confusing name.  I will expect to give any number n
> to return the nth argument.  However, here it return the value of an
> argument at a specific/fixed position.  ____bpf_25th() would make more
> sense for me.

In bpf_tracing.h, we have
#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, 
...) N
for 12 arguments.

The above is similar to ___bpf_nth (with one less _ compared to 
____bpf_nth).

On the other hand, I can just modify the existing ___bpf_nth for 24 
arguments so we don't need ____bpf_nth any more.
Will do this in the next revision.

> 
>> +#endif
>> +#ifndef ____bpf_narg
>> +#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11,
>> 11, 10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
>> +#endif
>> +
>> +#define BPF_REG_CNT(t) \
>> +       (__builtin_choose_expr(sizeof(t) == 1, 1,       \
>> +        __builtin_choose_expr(sizeof(t) == 2, 1,       \
>> +        __builtin_choose_expr(sizeof(t) == 4, 1,       \
>> +        __builtin_choose_expr(sizeof(t) == 8, 1,       \
>> +        __builtin_choose_expr(sizeof(t) == 16, 2,      \
>> +                              (void)0))))))
> 
> nit: Using ternary operator will still work, right?
> For example,
> 
>   (sizeof(t) == 1 || sizeof(t) == 2 || sizeof(t) == 4 || sizeof(t) == 8)
> ?  1 : (sizeof(t) == 16 ? 2 : 0)
> 
> Compilers should be able to optimize it as a const value.

Good idea. Will change in the next revision.

> 
>> +
>> +#define ____bpf_reg_cnt0()                     (0)
>> +#define ____bpf_reg_cnt1(t, x)                 (____bpf_reg_cnt0() +
>> BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt2(t, x,
>> args...)                (____bpf_reg_cnt1(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt3(t, x,
>> args...)                (____bpf_reg_cnt2(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt4(t, x,
>> args...)                (____bpf_reg_cnt3(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt5(t, x,
>> args...)                (____bpf_reg_cnt4(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt6(t, x,
>> args...)                (____bpf_reg_cnt5(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt7(t, x,
>> args...)                (____bpf_reg_cnt6(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt8(t, x,
>> args...)                (____bpf_reg_cnt7(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt9(t, x,
>> args...)                (____bpf_reg_cnt8(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt10(t, x,
>> args...)       (____bpf_reg_cnt9(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt11(t, x,
>> args...)       (____bpf_reg_cnt10(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt12(t, x,
>> args...)       (____bpf_reg_cnt11(args) + BPF_REG_CNT(t))
>> +#define ____bpf_reg_cnt(args...)
>> ___bpf_apply(____bpf_reg_cnt, ____bpf_narg(args))(args)
>> +
>> +#define ____bpf_union_arg(t, x, n) \
>> +       __builtin_choose_expr(sizeof(t) == 1, ({ union { struct {
>> __u8 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 2, ({ union { struct {
>> __u16 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }),
>> \
>> +       __builtin_choose_expr(sizeof(t) == 4, ({ union { struct {
>> __u32 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }),
>> \
>> +       __builtin_choose_expr(sizeof(t) == 8, ({ union { struct {
>> __u64 x; } ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
>> +       __builtin_choose_expr(sizeof(t) == 16, ({ union { struct {
>> __u64 x, y; } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} };
>> ___tmp.x; }), \
>> +                             (void)0)))))
> 
> Is it possible to cast &ctx[n] to the pointer of the target type?
> For example,
> 
>    *(t*)&ctx[n]
> 
> Did I miss any thing?

This won't work.

ctx[n] represents a u64 value.
Let us say type is 'u32'.   *(u32 *)&ctx[n]
works for little endian, but won't work for big endian
system.

> 
>> +
>> +#define ____bpf_ctx_arg0(n, args...)
>> +#define ____bpf_ctx_arg1(n, t, x)              ,
>> ____bpf_union_arg(t, x, n - ____bpf_reg_cnt1(t, x))
>> +#define ____bpf_ctx_arg2(n, t, x, args...)     ,
>> ____bpf_union_arg(t, x, n - ____bpf_reg_cnt2(t, x, args))
>> ____bpf_ctx_arg1(n, args)
>> +#define ____bpf_ctx_arg3(n, t, x, args...)     ,
>> ____bpf_union_arg(t, x, n - ____bpf_reg_cnt3(t, x, args))
>> ____bpf_ctx_arg2(n, args)
[...]
