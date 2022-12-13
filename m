Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F111C64C0F5
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiLMXxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiLMXxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:53:04 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9713DDE
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:53:01 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDMIYPE011102;
        Tue, 13 Dec 2022 15:52:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Z9ukFXpcSkLksOGUqktaobQviIK948zC02KcyJ7kv4k=;
 b=kBLo91CvcFIuKdrd04fRdr6+iYURT5LLHg1aZv/hPDcP5zhme8ysTYLXDI5o1D5l8zBO
 Rq1mNSAhve87ddlYjXVG9F1NPg2Vi6OMEmAOT2gUSfi/Upw64ExdXDbHKKUwD331wTAh
 6GzS9dgwdIbhujgtqk3SZHt0aDOFBaCn8oXSP9qX2n+xJeIRMGj2V9W77Y7GX8VKQZQm
 tTJO2JSBks5JcwtLf5ifczr6KuAUhGR7DPTdEUshC22aJo2qyTWFZ36Hf2id+tcAw47r
 oQdtn6w/8mwX0vZiNBYP/Zb1AeMEGpE8o3U8ARcSGC3DdFmMMhJy5IKRakKC7m9Ozj3v rA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3meyfju5ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:52:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akPi5KslpaY+1A897WI/6noiJV+h6oVeekyYxVh0Qm3zoF+fTvT755/aI4W/oA3TqPBYdvDUjpkwMX76V8zo2xcbuZnpob8s/JF9jTuppas7m2YJkt4H/OBC40YGJwlbCSV7EXwTFU+6+Xo8e+lahtarIr5X+ImV/QsLSED6C/dlKbmAj2nxPH7g8Fcza7sqLWDb5nuRWli/OPS7dxsmnwye/BRSFMv1Jh8qJL9Cpr+Ukdy/XBsOOtS1+eQX+5j3GSkFKsecgUIbgAX3AB6nlH4aLzn7kEj0H6og0Zp+ySaikwMreZcPzUNh7LFkX3vYXK+9iF6tqOjxGChAeA1WaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9ukFXpcSkLksOGUqktaobQviIK948zC02KcyJ7kv4k=;
 b=VkA1bCXlpYNXeVnVdRAHp0/By4Zlv2oc24Zw5u3+u/ZriytxBpLuDnEeSwvdN7CLhmwVvZ7V0ZQpeM3sYgi53eIuB6DPrCO2HJ/TIbGl5h4SkMyRRz/1sPLTG1nofzSYWpJo9fCqwWThHllhx5+BQW79Tnai+kZzQ08AoZt6DPyXr7Nvq6+a0RiR3IusAyhIEJ7ZuoErZV7zHIGNKRMAACyh3RA0e5f3Jf/VU9ghvGg0oFyQbqmjnuyGrH7Nq5EPbXPrGNPCjp/e4E0FL6jDk0Dr5eplkyrvj/jtQBe2Uip0kAveLKOeYfgZDn6XFuSnsDEzQW1uOad9ncxUEOHDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2323.namprd15.prod.outlook.com (2603:10b6:406:82::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Tue, 13 Dec
 2022 23:52:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 23:52:41 +0000
Message-ID: <aef233ff-095d-0f51-735e-8054fafcb4bf@meta.com>
Date:   Tue, 13 Dec 2022 15:52:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next] bpf: Remove trace_printk_lock lock
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20221213140843.803293-1-jolsa@kernel.org>
 <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
 <Y5j0XYQyiDP1Uu68@krava>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y5j0XYQyiDP1Uu68@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN7PR15MB2323:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b1425d-faa9-48bc-b23a-08dadd651f2f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEGvljV3IBXmwHFsT39kcB7yScugwHfdLPp/eV6AN6Ch2/nGscCMFw3kyr1PwgZIqju4UTCDHhRscwcTDbiyADLEMkkczWJB3yXjwW9ALs8Zo4vflH3q1GfWw7ZwVbjxrj+ZVboos0K7Ho+qgsqY+cjnAOIktgfvKbYNHVEFrkuHuaWyyJYb2otvEPvxRodsgIcbUigBtbPDtGn94ghB0uQFTgnADUUm8cSVpSshSteIr4d5vejQn3mhMX9XwRiqnzooQrEQgjgx03ex5+0fjjWYoqsrPJr9gocUsPZ3DxJoXAjneJn71CCPrwm4ucTUFAXMYEb8BSgpHnuNNcS6Ko5xb8fctuopfXVNtyQw9YAT8h6nlmw8RFhKzQ1X7OKvd0hZZ5kp13JMcmKmlVRnqFQwUrzJ/hQGqN7FPqxI3dwAnoMzwqXW1OHhYVI9SwffErMgWLjpx4ArceIXxXhMYBKqdiC8QdYDiUiYnw6DzI7LZd4lUThIDTTGFKfE2sXxmPzTPo61r0bl6Te0oe49vihj9bhy7q8adjwZkfzGDdUsWRsB3J0nXuvSGKKhkrrLmH0o0UNkp/xFHGRaZtWF4vD+4H6IlV5a07sWf7jzT53ppDJixBkZ6oQKaqpu4QvoviPdMZJpGfvyg6FwIIi659AnmVTYcxAnXzhHbPs9CJIdcPDIrRDUav2N9WtiMO93JcN8AHdMbHqrbJjeyyVeCByLFpGb5f+nUBfKmwwnMY0Hrx/qfKUiuIcjUiYGieIBAeLtVwItqqfP0uYtscomNBWfy8yVmR9K3G6/lfhxHxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(41300700001)(2906002)(8676002)(4326008)(86362001)(66946007)(66476007)(66556008)(31686004)(38100700002)(7416002)(8936002)(316002)(110136005)(54906003)(53546011)(6512007)(6506007)(2616005)(36756003)(5660300002)(83380400001)(31696002)(478600001)(6666004)(966005)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFEZGp3YXBpRm1EcVVVMHdLSm55TER4eFkzZGdTVE8zdVFuT0d4Q2lCbDBo?=
 =?utf-8?B?OUlkR0xmdDY5WUdreHVtRWhKdjB3UDRCQzE4SGR2VWNVejhpcS9ubE9mZ2NY?=
 =?utf-8?B?OFhrQmh0NUtGODlmdTR2UjhPNEZSblRBOXhUTzVWWmhGL3R5SjI2K1FhRjdm?=
 =?utf-8?B?b05GejZDbExCWkRFQi8xTkh4Z0VpSG1CVUNUcWVrZGowODQzdTZUbk9MdU1p?=
 =?utf-8?B?YkNHQVdrWGh0emZEQ2UrSElVYXhxZGVjTjVFNE9SMjF4ZXNzaDNqK0VUVGlO?=
 =?utf-8?B?TkhGblUvcDNPVzl4dlN6YzYxM0c5Zy9vZWRhQjhSejQwOVZ5RUI5SkhQUkV1?=
 =?utf-8?B?VTBZc1E1RHB4cFd4NDh0ZkN5VFlpeC9CTmdRZnZ4TjhYZDVXYmxIdmUvdUw2?=
 =?utf-8?B?Njd4clFjRFliVnljdm85eWxBSkJRUmpieWx2djlZNk9Kd1VNbnNvbU0vQzYr?=
 =?utf-8?B?MG1HWGd3NGo4bmwvSjN2Q2kyYVlQVkgvL3BFNWEzWWozSSttcG1IbHlxM1R2?=
 =?utf-8?B?Znd6ZkZnYm5SSDhKcVVQWlFhWnBKSDcranZqL0dYNzJGUUFJZHlsSmw1UVRG?=
 =?utf-8?B?ZGdOTjNhRHhNalpjSG9mMEhtMzBHdkhDYTRqSlRBMXhYNitxRWJpREtJbWpV?=
 =?utf-8?B?YW9aZUVBaEZ1YlREQkJha0NqUmFxdTNDNTYwTkxLcnRuTzlNL3MzdmxYRXBl?=
 =?utf-8?B?Q2pvMkRWS2NFVnhOcFZFNHJvR1NUTGJDZGs4RFJ0dlFvUWVIQ0V3a1FwN2ZT?=
 =?utf-8?B?WWk4TExuc09MOC9vTWEzc2RMMFFUdllQT1BHNTdVbGRMZmlKSzdrQjUwMVh2?=
 =?utf-8?B?VWlvY3g4UzVMV1NqSTF0S2xNendtT1VKeVNLYXFsYUdpUGg4TDlkdHhiT3ZS?=
 =?utf-8?B?ck9mS3dteFg0Q0FYWDRrQzBCdytzbWRlcjF0cUxTTDZPOU96aHo3Y2ZFRCtO?=
 =?utf-8?B?U0VVMFlpREljam1yL004WFF0Q0tLT29jVVVYa3RObFpLa29ZTlZ5bEFyMjll?=
 =?utf-8?B?ZWdBTXdQOGpUSWRmVUl1T1YvNkZNV2Y2d09sRi9NeERzdzkwdkkyR3Zvdnp3?=
 =?utf-8?B?RFA3T3dBcGZyQWFGRzhhV1ozMnVjaEpGQ3ViNUJHaU5zSThxYlVnOEdhSnhP?=
 =?utf-8?B?KzFNOGhCRlc4bDZTTFlXbUdjYTAxdnhQYmxpODdCUUVubWRnRVhSNHIzNmxL?=
 =?utf-8?B?dFBqWjg5bFdHMDZraTNnT2tWTmZ0K29UWGNxS0lqR3dSYzhJd2dXaVNhbm1Y?=
 =?utf-8?B?eTVRM2FmWmE4NGVjQk1nTTlWUU5tVXBVditIalFjNDFDUzBocWJQL1h1NXVL?=
 =?utf-8?B?elFnQ2JOQ2w3UXBDWUFXbUhqMzU0RWxxdVhTY3BLalJRcC9RWjFpZjNReWR5?=
 =?utf-8?B?UG9PNUFvUzVsQ2lFK0FJUEUvWlRkMGxVUVRMR1lkWEliWWZPYWNFaUpwQTB4?=
 =?utf-8?B?RllxdGZ6ZW5Obzd3RXowb3pydjgwTGd2bDJ0UTA3QjhFbkk3YXJVcWJxc3Z0?=
 =?utf-8?B?ei9SeGNubDIwVnJoQmtONG5FVnE5SkQrQVZzczQ5VmEyTklGVkZWMHlVSlRr?=
 =?utf-8?B?M1J1Z3NVN1hDOWpMdHhBMU1JTDFjTWJ6WDRqUWR5VmtwMklDQ01kb0RCUGsr?=
 =?utf-8?B?RWE4VWhKcnpPNm8vTThmNDJwZVVVMEQ0bFdCYzNrcS9PN1FtQnNxU0ZRVEVj?=
 =?utf-8?B?VWpBOEdzNzU2L2FIMVM1SStJWTlhdEVJQkpoMkt4anYwZ0ZCUHBjYlFFRkUv?=
 =?utf-8?B?R09mSmloYU9zT3pVeCtKUmpSd25vNHJLZzhaQXp4ZlZJQlNVcmwxcTVvK0lT?=
 =?utf-8?B?UDhPSy9LU0JjalZvMDB2Z0thUVZ5UzZmOTJNU084UG12RUxhOVZ4MHNnOUhl?=
 =?utf-8?B?MlVIY0FxUHZzT0JpaFJsa3FZTEVPay94VndVcU1zdHBtTGdFb3RwL1UrSlo5?=
 =?utf-8?B?QXRZWXVSRnBPcjVTdzdMNlFmcE9TbUtUUEI1S1MyNm90NVo3Z3hQbEVhM0py?=
 =?utf-8?B?UW5ydk1OZGJGYm8wbG1jM3g0djhITnA1bVFYZkJ2OW45eFBTd0J0ZU9aTVgx?=
 =?utf-8?B?eGxNaWVKbmY5QjF0dExyQk9YYURkMlpYL0hRQlNyTlVEL0JYL0E0Z1ZoRXJV?=
 =?utf-8?B?dmYrUCs0bW5BYVBMZnpXOUpzTUFlSC9CZTBRbkY1U1lHeGhDUnpubXVGb0dq?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b1425d-faa9-48bc-b23a-08dadd651f2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 23:52:41.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tF6tKaxcLpbwusYIH2Z8WHuZ6sob/dETiJ+DRvdJt5wQhztQBQsDZ/qNT1BW3f4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2323
X-Proofpoint-ORIG-GUID: yy71-dY09SkHo07WC4K5LvvkmmghPtSG
X-Proofpoint-GUID: yy71-dY09SkHo07WC4K5LvvkmmghPtSG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/13/22 1:53 PM, Jiri Olsa wrote:
> On Tue, Dec 13, 2022 at 10:48:43AM -0800, Song Liu wrote:
>> On Tue, Dec 13, 2022 at 6:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>
>>> Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
>>> guarded with trace_printk_lock spin lock.
>>>
>>> The spin lock contention causes issues with bpf programs attached to
>>> contention_begin tracepoint [1] [2].
>>>
>>> Andrii suggested we could get rid of the contention by using trylock,
>>> but we could actually get rid of the spinlock completely by using
>>> percpu buffers the same way as for bin_args in bpf_bprintf_prepare
>>> function.
>>>
>>> Adding 4 per cpu buffers (1k each) which should be enough for all
>>> possible nesting contexts (normal, softirq, irq, nmi) or possible
>>> (yet unlikely) probe within the printk helpers.
>>>
>>> In very unlikely case we'd run out of the nesting levels the printk
>>> will be omitted.
>>>
>>> [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
>>> [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
>>>
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Maybe change to subject to 'Remove trace_printk_lock' instead
of 'Remove trace_printk_lock lock'? The 'trace_printk_lock'
should already imply 'lock'?

>>> ---
>>>   kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
>>>   1 file changed, 47 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index 3bbd3f0c810c..b9287b3a5540 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>>>          return &bpf_probe_write_user_proto;
>>>   }
>>>
>>> -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
>>> -
>>>   #define MAX_TRACE_PRINTK_VARARGS       3
>>>   #define BPF_TRACE_PRINTK_SIZE          1024
>>> +#define BPF_TRACE_PRINTK_LEVELS                4
>>> +
>>> +struct trace_printk_buf {
>>> +       char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
>>> +       int level;
>>> +};
>>> +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
>>> +
>>> +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
>>> +{
>>> +       if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
>>> +               return;
>>> +       this_cpu_dec(buf->level);
>>> +       preempt_enable();
>>> +}
>>> +
>>> +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
>>> +{
>>> +       int level;
>>> +
>>> +       preempt_disable();
>>
>> Can we use migrate_disable() instead?
> 
> I think that should work.. while checking on that I found
> comment in in include/linux/preempt.h (though dated):

I am not sure about whether migrate_disable() will work. For example,
   . task1 takes over level=0 buffer, level = 1
   . task1 yields to task2 with preemption in the same cpu
   . task2 takes over level=1 buffer, level = 2
   . task2 yields to task1 in the same cpu
   . task1 releases the buffer, level = 1
   . task1 yields to task3 in the same cpu
   . task3 takes over level=1 buffer, level = 2
     <=== we have an issue here, both task2 and task3 use level=1 buffer.

> 
>    The end goal must be to get rid of migrate_disable
> 
> but looks like both should work here and there are trade offs
> for using each of them
> 
>>
>>> +       level = this_cpu_inc_return(buf->level);
>>> +       if (level > BPF_TRACE_PRINTK_LEVELS) {
>>
>> Maybe add WARN_ON_ONCE() here?
> 
> ok, will add
> 
> thanks,
> jirka
