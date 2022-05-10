Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420885226FC
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiEJWlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiEJWky (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:40:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7418D3615E
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:40:49 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AKxEAg024852;
        Tue, 10 May 2022 15:40:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L84NdEGYLVx4WcI4XUVePWtP11WFzhNVmuOgYNkVigg=;
 b=HJauDj78RFu5EGfQ6CvMTpBwEtW3sciw1PnP4RpyCTBXqNo/nmZK89Fg6SSuYCtsZQRi
 Cg+sZY8ApORQsSMBgKUHB6O4JB94bvHQMVSARGoAfHVqyZLVX5CK5rVt2nP3FM7tnLf+
 stNijbTR/omjsCARkM89gcIjedrV9cnMgqI= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fym645v11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yld0ato+48yE3Sk1bAhSZDrIcxXldzXt1Ao6MIthnPaytuigdvkHq0bkReLY9u6zK6FXQOsiEUSxgh+sjPfYWkxZ5l0L8eIGTjNf2ByeGNcuALENfFocNqmHxrzVzjiqFnBBeXWdEehLwx3Jjk5//WMutaW2SI0cGkcgvLZP34H3nH/aDQ/p4vvKo71DcayuVG8N7X9nO7qT03qWvdQqba5xLPt6sjfbDWZyyUt9BLAnD8ihGusmgHoxAWPfiVTQxKIgLv4CSd1sfC0B6nAxmaj0mR4jTY9ZBQxus395byPItloO+mqgTW0XMu4FUXzfcw5VgHeqEMLm+xtwcTwsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L84NdEGYLVx4WcI4XUVePWtP11WFzhNVmuOgYNkVigg=;
 b=J+UyMPCgCtHlOaRXPO7Q5iF7R0QRWTeFni/5mkdj1msM9PNJQoCCUPm54XMj74zvogT1zeCn9TeVawbhblZWAamxnD7RPiI+0stqLYR3+b9xNKEaJBhpNAC6VC9E2H3UGr0cOv6jDSm6xWiLlsuBtR9NmT+5CcWpd+vwNPAGGapxZAkdq80Oy2AJR1C+YC2fBWfPY+6tm5Xc/a1Z/Fr1Rd8avheKncYz4b+UmimXuQebqCkZcVEWfxxIR7shgFdck5EouiXAlYY19rT4Avb42Mh0jZz6kmqQG5lFpq57EOEHkQ2m/AZR6cHbWQPAoox7GeIaO4+aZV6It6aRELxLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:40:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:40:30 +0000
Message-ID: <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
Date:   Tue, 10 May 2022 15:40:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e329cc-67e7-4d4b-ffc9-08da32d615f5
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB23365308E8BC907C3809888CD3C99@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6ZaKzVyj/J/EyOz8+TrwjCupcx/BEzaX62ihtohOX1PmPMb0SAJT0UXmu/Qamlrsj5WaWpDFp5QT3VTiKBkWTMCrhvhjmUOqBKjUsoDUOtlo0HUfMy4N0VEtn1oyeooQNx9ulBs0oQin5Uls0QXc/fJpKUI6rwUGmO7WWL6gPnWMiNWGk3VAqFRsGWhzvRIdXqMMshYSERrLwxe02UqZ8CT2Xdqgba2rhS5b3IyCb4Cpb9NzBv5Qks6f/TZjdScIfePYkpaI4W8gH2VcNebE0mCexJXpvIj786uApa+l0QPLktqPhJHOcL4WAXgv8LSVA8A1YfTq9+wcOfIYJz0HFOPcrnuT+lCVxj0ilBsB6B5NyzL8TH2x93sctd0phjqrG+jqCRCRLJ0JXffpvFh0Z6gqp/YjLRzwkiXgqnx9Dbv7oIkQ1tUp/3S3p7rM3O6JQ8D3oZZR+uivTfKhh32uwK3kObEvw7usq4ZULGFSJsSW7Li3v3UG9EOC3XqLy7GIPOBDapfkFvOYp902yhKhC2rrn9HLh61zejuHaAAX2Vo4n32CtdjPU7UBNimyiRw+RyxN9Soldf6V9u3bIEIjLEoJfS4iprXesCgx1KJr3IymdElnMXoY5WZl26H/pLf1PWeNX3mmGFfm/p6T3gpLIxPxsSwN7g33f6+PWfzyGLf2Qwoy2/DQ3IKCjVf3cpNAqEbug1nXqSIazXpboXiSvU5UAz0O4206cZ+Eg4oKrW2BtsRC3bHBnPcuAbbafDE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(66946007)(66556008)(31696002)(8936002)(66476007)(6916009)(54906003)(2616005)(38100700002)(8676002)(4326008)(6486002)(53546011)(6512007)(6506007)(52116002)(508600001)(2906002)(36756003)(31686004)(30864003)(83380400001)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VqM2xDN1JrSUhGU21FM003RHplUE9VOCtqZFlQQnpNRUlqUjBrNWoxM1RG?=
 =?utf-8?B?UGsxdmJBems4YmJoamloTkNDYXRGR3grbjk0SXJ2bWFnRGxpL0YybVRvWDFm?=
 =?utf-8?B?eVdJZjB0QkhJZVZwQlU3c0tyUUVtQkZtYnJTL29jN0JnTEY1QkNrN0M5ZUE2?=
 =?utf-8?B?QStaNHNlOUsvVmdWbTc5NDZXQVp1RU5CYnk5ZHRrMVRJY1lnWk1XbS9PdXFI?=
 =?utf-8?B?NzF4WWhPZTA0NnF3UTlDNXd4d2pVV1k0NXpHVElTZnVqWTV4K295NUZ3Zitt?=
 =?utf-8?B?M1FhTnFSK3dYNGFObld3OS8vOER6cE5zb0RoNmFOK2ZqcnpiVWFhS2xIajhj?=
 =?utf-8?B?emN2ckp3ZGYyKys2TmlkMlA1aytsdXZFRUhPNjd2ZDFvc3NPUER4VHB0OVpi?=
 =?utf-8?B?bWE4OEs2SmRFbnVDR0JDZ2NvcWsrbG1wUnZMSU95aXAySlcrL01SelBNNldL?=
 =?utf-8?B?Zjh6Mm5BSUFUVWpSRHFhenBYcWpCV1BjeEJCaEo0d2MrVlZrNlZVZHdzbXZ1?=
 =?utf-8?B?eEJKM09CMVJFb0ZmYUIyR0VNWi9JRFFoME9KR3RKaEZycnlSWk1zNHFsMkJh?=
 =?utf-8?B?MGdBdkdzaXRDcE5mU3JkUHBDamgxUzJ2OFJNcWJXajNzSUlhRHZYckMyWmZL?=
 =?utf-8?B?UklEUHhINitrTzZUZ2FUeWNOaXJvNnhaenAvaWFIeWg5dWVnVE41R3ZJNnZU?=
 =?utf-8?B?ejNTZnd1aGhUVzZZbS8xdTNWR0NKTjJYV05oRXBFZVVzRFk1aXBQWXd2UkVk?=
 =?utf-8?B?TThsRVJFM3hHQ2RrZkVFRmN5NmQ2Y2cyT0dYbDE5UzJsd0lNVnplZTZRcDVr?=
 =?utf-8?B?REdYK2ZsNS9CQVY0WHlUSlp2UCsrRHphblc1VVllcjFWUjR1YThuSzFXbU1H?=
 =?utf-8?B?dFNBcWFkNHp2ZGZySi9Sc3dhMTEvKzBJZ1A2eDdUTFE0VVRJcGtZV3FLeUJp?=
 =?utf-8?B?NTgrNHdzV3prSnFvdWExRTA3QlNpNnZEUVNNUkdZS08yL0loa1dRRDdQSWI0?=
 =?utf-8?B?emxuWnpwT1ZNNUVTNGdVdWhXWVBRSWlQeG5ONjAyblFnaGtKaTF5T3kvU0NY?=
 =?utf-8?B?aHNNbGVpOENiV05EaE1XZzljVnZteG9rTll2TUxBNVU2V2pJRy9IVGRnV1dj?=
 =?utf-8?B?ZktwZDd3d3JwZS9aUFBjeGxkTEYwZHZITUtmWk9rS2hYQWc1enpLc2UwdzE2?=
 =?utf-8?B?OWJMWU4wdGZLVktGcmZNZjh5L3NpSFlkSTU4Q0lXV05TWUE5QnhtTk9FbXJZ?=
 =?utf-8?B?dXpYYStwSkVGSmZqTFUxN0pPcHB3TU1xNXRpeXZsMlNOS0NYdjhBbkdXQ21F?=
 =?utf-8?B?QlhzMGZ5dU9kZkVOUnB6dk5QRHhIRHI2VFVibVJ5RzNQUXNOQnhPWnVNbjVG?=
 =?utf-8?B?Ukw0ZmtEUVJKaHVIaS9oVmh5M2NKVjU1TjkzZnpUV0hRU0JpWnVOTWUrM1h1?=
 =?utf-8?B?N3o4MHMrR3RlSGRycnY5M2xyWUR1a28xZmdZSktNV2ZZODY4cElZaDVZTTNF?=
 =?utf-8?B?WkZ2amlpeksvSlBxZTl3T2tHUmYwWVlSS3YrNk5RR3Q5VU1ON0hXRVFDY0V5?=
 =?utf-8?B?b01PcDcvUTYyZXFhWFBkZXpjMGxVZGVOZVRBejBtUmJSYWJHazJmTkxmb0ts?=
 =?utf-8?B?NFpjUXRlVXZ0eUxaZ0VaeU1OTVNDUEFqOFNQVFZkc0srSHliWUZHYTRsc29r?=
 =?utf-8?B?YTBuVVhSQmMwQmdWcCtpSlIzTW0zNGc1bm5mVy96ajk3a2R1ejhGTzIzaDUy?=
 =?utf-8?B?eSs3MzlpY2lDVlpuU3lWUHVqeTlpQUFYV0pMaUJrekZyTFJZdTB3V3dla1dr?=
 =?utf-8?B?RHJhdWRFbHpvRnpDcGZIZEx6bjljVS83TUpSN0dZWjNIZTdYL3JQblZOTVUw?=
 =?utf-8?B?aTI1ODlPS2dJNXQyaXY0RnJ5RkFTY3ExcWhhTEFiS1JtQS83VXlONkVuU3hr?=
 =?utf-8?B?cGY1RllrV3grSDUzalBxVnI1bjRhRFROdEFmRXhUd0RqeFZTWFVRd0tsdkF3?=
 =?utf-8?B?S3VCbmMydUw1ZTZDeXRkbHhOWUJSSzdiajVTQjF0VlNtRXdvQzhmTHNkbUcr?=
 =?utf-8?B?Z093Z0MxSFh6U3Iwanhoc3RHSmk4NVFMdXRBZG9uR3o0OExsUGRUY0hxcnBT?=
 =?utf-8?B?bVRHSHdRSnFPeHJiVG9pUFJlbTZYakhQOHhhWEg3a3pEKzVSb2cva2gzb2JD?=
 =?utf-8?B?VWdXV0x1ZVN5NFlpYzhYZWxDM2M0WW5RMnZKbyt1dVNNUVdraHJiV05PWTcr?=
 =?utf-8?B?N092eHFZMlI1Z2hiQy82bExyWGJoc3lSN0lRcm83WVhNb3JIKzN4NTFlMVAw?=
 =?utf-8?B?VE5SUVlnS255VmlJQWR5OVlzNUVjTjZBMWNwZ1R6eXhLZ1BvYk5adGprdFgy?=
 =?utf-8?Q?fy6vFVHYPzRCWFyE=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e329cc-67e7-4d4b-ffc9-08da32d615f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:40:30.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QpF24Hxhk/wmhDJYxqWb1L92Cs2B6ttzGDXSiv8Y76vUP4CVjzBCnWR9fxT/8qs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-Proofpoint-GUID: YulgFGdGeAvsYIGBFuQNR1bzLqZoo9GX
X-Proofpoint-ORIG-GUID: YulgFGdGeAvsYIGBFuQNR1bzLqZoo9GX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
>> btf__add_enum_value() and introduced the following new APIs
>>    btf__add_enum32()
>>    btf__add_enum32_value()
>>    btf__add_enum64()
>>    btf__add_enum64_value()
>> due to new kind and introduction of kflag.
>>
>> To support old kernel with enum64, the sanitization is
>> added to replace BTF_KIND_ENUM64 with a bunch of
>> pointer-to-void types.
>>
>> The enum64 value relocation is also supported. The enum64
>> forward resolution, with enum type as forward declaration
>> and enum64 as the actual definition, is also supported.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
>>   tools/lib/bpf/btf.h                           |  21 ++
>>   tools/lib/bpf/btf_dump.c                      |  94 ++++++--
>>   tools/lib/bpf/libbpf.c                        |  64 ++++-
>>   tools/lib/bpf/libbpf.map                      |   4 +
>>   tools/lib/bpf/libbpf_internal.h               |   2 +
>>   tools/lib/bpf/linker.c                        |   2 +
>>   tools/lib/bpf/relo_core.c                     |  93 ++++---
>>   .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
>>   .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
>>   10 files changed, 450 insertions(+), 72 deletions(-)
>>
> 
> This is a huge patch touching very different and logically independent
> parts of libbpf. Please split it into smaller parts, e.g.:
>    - libbpf.c changes (sanitization and kcfg);
>    - BTF public API helpers (btf_is_enum64, btf__add_enum64);
>    - btf_dump changes;
>    - btf__dedup changes;
>    - CO-RE relocations.
> 
> It will be easier to discuss each in a separate patch.

okay.

> 
> [...]
> 
>> +static int btf_add_enum_common(struct btf *btf, const char *name,
>> +                              bool is_unsigned, __u8 kind, __u32 tsize)
>> +{
>> +       struct btf_type *t;
>> +       int sz, name_off = 0;
>> +
>> +       if (btf_ensure_modifiable(btf))
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       sz = sizeof(struct btf_type);
>> +       t = btf_add_type_mem(btf, sz);
>> +       if (!t)
>> +               return libbpf_err(-ENOMEM);
>> +
>> +       if (name && name[0]) {
>> +               name_off = btf__add_str(btf, name);
>> +               if (name_off < 0)
>> +                       return name_off;
>> +       }
>> +
>> +       /* start out with vlen=0; it will be adjusted when adding enum values */
>> +       t->name_off = name_off;
>> +       t->info = btf_type_info(kind, 0, is_unsigned);
> 
> As mentioned on another patch, I think unsigned should be default
> (despite UAPI having s32 as type for enum's val), because that's what
> we assume in practice. It makes backwards compatibility easier in more
> than one place

okay.

> 
> 
>> +       t->size = tsize;
>> +
>> +       return btf_commit_type(btf, sz);
>> +}
>> +
>> +/*
>> + * Append new BTF_KIND_ENUM type with:
>> + *   - *name* - name of the enum, can be NULL or empty for anonymous enums;
>> + *   - *is_unsigned* - whether the enum values are unsigned or not;
>> + *
>> + * Enum initially has no enum values in it (and corresponds to enum forward
>> + * declaration). Enumerator values can be added by btf__add_enum64_value()
>> + * immediately after btf__add_enum() succeeds.
>> + *
>> + * Returns:
>> + *   - >0, type ID of newly added BTF type;
>> + *   - <0, on error.
>> + */
>> +int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)
> 
> given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
> btf__add_enum()/btf__add_enum_value() and not deprecate anything.
> ENUM64 can be thought about as more of a special case, so I think it's
> ok.

The current btf__add_enum api:
LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32 
bytes_sz);

The issue is it doesn't have signedness parameter. if the user input
is
    enum { A = -1, B = 0, C = 1 };
the actual printout btf format will be
    enum { A 4294967295, B = 0, C = 1}
does not match the original source.

> 
>> +{
>> +       return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
>> +}
>> +
> 
> [...]
> 
>>   /*
>>    * Append new BTF_KIND_FWD type with:
>>    *   - *name*, non-empty/non-NULL name;
>> @@ -2242,7 +2419,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
>>                  /* enum forward in BTF currently is just an enum with no enum
>>                   * values; we also assume a standard 4-byte size for it
>>                   */
>> -               return btf__add_enum(btf, name, sizeof(int));
>> +               return btf__add_enum32(btf, name, false);
>>          default:
>>                  return libbpf_err(-EINVAL);
>>          }
>> @@ -3485,6 +3662,7 @@ static long btf_hash_enum(struct btf_type *t)
>>   /* Check structural equality of two ENUMs. */
>>   static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
>>   {
>> +       const struct btf_enum64 *n1, *n2;
>>          const struct btf_enum *m1, *m2;
>>          __u16 vlen;
>>          int i;
>> @@ -3493,26 +3671,40 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
> 
> they are so different that I think separate btf_equal_enum64() and
> similar approaches everywhere makes sense. Yes, it's enum, but in
> practice two very different kinds and should be handled differently

okay.

> 
>>                  return false;
>>
>>          vlen = btf_vlen(t1);
>> -       m1 = btf_enum(t1);
>> -       m2 = btf_enum(t2);
>> -       for (i = 0; i < vlen; i++) {
>> -               if (m1->name_off != m2->name_off || m1->val != m2->val)
>> -                       return false;
>> -               m1++;
>> -               m2++;
> 
> [...]
> 
>>   enum btf_fwd_kind {
>>          BTF_FWD_STRUCT = 0,
>> @@ -454,6 +460,11 @@ static inline bool btf_is_enum(const struct btf_type *t)
>>          return btf_kind(t) == BTF_KIND_ENUM;
>>   }
>>
>> +static inline bool btf_is_enum64(const struct btf_type *t)
>> +{
>> +       return btf_kind(t) == BTF_KIND_ENUM64;
> 
> please also add #define BTF_KIND_ENUM64 19 to avoid user breakage if
> they don't have very latest kernel UAPI header, same as we did for
> TYPE_TAG and others

okay.

> 
>> +}
>> +
>>   static inline bool btf_is_fwd(const struct btf_type *t)
>>   {
>>          return btf_kind(t) == BTF_KIND_FWD;
> 
> [...]
> 
>> @@ -993,8 +996,11 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>>                                     const struct btf_type *t,
>>                                     int lvl)
>>   {
>> -       const struct btf_enum *v = btf_enum(t);
>> +       bool is_unsigned = btf_kflag(t);
>> +       const struct btf_enum64 *v64;
>> +       const struct btf_enum *v;
>>          __u16 vlen = btf_vlen(t);
>> +       const char *fmt_str;
>>          const char *name;
>>          size_t dup_cnt;
>>          int i;
>> @@ -1005,18 +1011,47 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>>
>>          if (vlen) {
>>                  btf_dump_printf(d, " {");
>> -               for (i = 0; i < vlen; i++, v++) {
>> -                       name = btf_name_of(d, v->name_off);
>> -                       /* enumerators share namespace with typedef idents */
>> -                       dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
>> -                       if (dup_cnt > 1) {
>> -                               btf_dump_printf(d, "\n%s%s___%zu = %u,",
>> -                                               pfx(lvl + 1), name, dup_cnt,
>> -                                               (__u32)v->val);
>> -                       } else {
>> -                               btf_dump_printf(d, "\n%s%s = %u,",
>> -                                               pfx(lvl + 1), name,
>> -                                               (__u32)v->val);
>> +               if (btf_is_enum(t)) {
>> +                       v = btf_enum(t);
>> +                       for (i = 0; i < vlen; i++, v++) {
>> +                               name = btf_name_of(d, v->name_off);
>> +                               /* enumerators share namespace with typedef idents */
>> +                               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
>> +                               if (dup_cnt > 1) {
>> +                                       fmt_str = is_unsigned ? "\n%s%s___%zu = %u,"
>> +                                                             : "\n%s%s___%zu = %d,";
>> +                                       btf_dump_printf(d, fmt_str,
>> +                                                       pfx(lvl + 1), name, dup_cnt,
>> +                                                       v->val);
>> +                               } else {
>> +                                       fmt_str = is_unsigned ? "\n%s%s = %u,"
>> +                                                             : "\n%s%s = %d,";
>> +                                       btf_dump_printf(d, fmt_str,
>> +                                                       pfx(lvl + 1), name,
>> +                                                       v->val);
>> +                               }
>> +                       }
>> +               } else {
>> +                       v64 = btf_enum64(t);
>> +                       for (i = 0; i < vlen; i++, v64++) {
>> +                               __u64 val = btf_enum64_value(v64);
>> +
>> +                               name = btf_name_of(d, v64->name_off);
>> +                               /* enumerators share namespace with typedef idents */
>> +                               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
>> +                               if (dup_cnt > 1) {
>> +                                       fmt_str = is_unsigned ? "\n%s%s___%zu = %lluULL,"
>> +                                                             : "\n%s%s___%zu = %lldLL,";
>> +                                       btf_dump_printf(d, fmt_str,
>> +                                                       pfx(lvl + 1), name, dup_cnt,
>> +                                                       val);
>> +                               } else {
>> +                                       fmt_str = is_unsigned ? "\n%s%s = %lluULL,"
>> +                                                             : "\n%s%s = %lldLL,";
>> +                                       btf_dump_printf(d, fmt_str,
>> +                                                       pfx(lvl + 1), name,
>> +                                                       val);
>> +                               }
>>                          }
> 
> yeah, let's just have btf_dump_emit_enum64_def(), there is very little
> that can be reused, I think it will be cleaning to keep enum and
> enum64 separate everywhere where we actually need to iterate
> enumerators and do something about them

okay.

> 
>>                  }
>>                  btf_dump_printf(d, "\n%s}", pfx(lvl));
>> @@ -1183,6 +1218,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
>>                  case BTF_KIND_UNION:
>>                  case BTF_KIND_TYPEDEF:
>>                  case BTF_KIND_FLOAT:
> 
> [...]
> 
>> -       btf_dump_type_values(d, "%d", value);
>> +               btf_dump_type_values(d, is_unsigned ? "%u" : "%d", value);
>> +       } else {
>> +               for (i = 0, e64 = btf_enum64(t); i < btf_vlen(t); i++, e64++) {
>> +                       if (value != btf_enum64_value(e64))
>> +                               continue;
>> +                       btf_dump_type_values(d, "%s", btf_name_of(d, e64->name_off));
>> +                       return 0;
>> +               }
>> +
>> +               btf_dump_type_values(d, is_unsigned ? "%lluULL" : "%lldLL", value);
>> +       }
> 
> ditto, also beware of %lld/%llu use with __u64/__s64, it gives
> compilation warnings without cast on some architectures

okay.

> 
>>          return 0;
>>   }
>>
> 
> [...]
> 
>> @@ -2717,6 +2720,17 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>>                          /* replace TYPE_TAG with a CONST */
>>                          t->name_off = 0;
>>                          t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
>> +               } else if (!has_enum64 && btf_is_enum(t)) {
>> +                       /* clear the kflag */
>> +                       t->info &= 0x7fffffff;
> 
> please use btf_type_info() helper (defined in libbpf_internal.h) or
> just plain BTF_INFO_ENC() like all other cases around instead of
> hard-coding magic masks

okay.

> 
>> +               } else if (!has_enum64 && btf_is_enum64(t)) {
>> +                       /* replace ENUM64 with pointer->void's */
>> +                       vlen = btf_vlen(t);
>> +                       for (j = 0; j <= vlen; j++, t++) {
>> +                               t->name_off = 0;
>> +                               t->info = BTF_INFO_ENC(BTF_KIND_PTR, 0, 0);
>> +                               t->type = 0;
>> +                       }
> 
> I don't think we can replace each enumerator with a new kind, it
> breaks type ID numbering. struct btf_member has matching layout, so we
> can replace ENUM64 with UNION (easier to keep offsets as zeroes),
> WDYT?

Yes, my above approach won't work. I will replace it with UNION with
members be int/ptr types.

> 
>>                  }
>>          }
>>   }
>> @@ -3563,6 +3577,12 @@ static enum kcfg_type find_kcfg_type(const struct btf *btf, int id,
>>                  if (strcmp(name, "libbpf_tristate"))
>>                          return KCFG_UNKNOWN;
>>                  return KCFG_TRISTATE;
>> +       case BTF_KIND_ENUM64:
>> +               if (t->size != 8)
>> +                       return KCFG_UNKNOWN;
> 
> I think I don't like this t->size == 8 more and more. At some we'll
> decide it's ok and then we'll have to go and adjust everything again.
> It requires pretty much zero effort to support from the very beginning
> and makes tons of sense to allow that, let's allow it.

Will remove this.

> 
>> +               if (strcmp(name, "libbpf_tristate"))
>> +                       return KCFG_UNKNOWN;
>> +               return KCFG_TRISTATE;
>>          case BTF_KIND_ARRAY:
>>                  if (btf_array(t)->nelems == 0)
>>                          return KCFG_UNKNOWN;
>> @@ -4746,6 +4766,17 @@ static int probe_kern_bpf_cookie(void)
>>          return probe_fd(ret);
>>   }
>>
>> +static int probe_kern_btf_enum64(void)
>> +{
>> +       static const char strs[] = "\0enum64";
>> +       __u32 types[] = {
>> +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
>> +       };
>> +
>> +       return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
>> +                                            strs, sizeof(strs)));
>> +}
>> +
>>   enum kern_feature_result {
>>          FEAT_UNKNOWN = 0,
>>          FEAT_SUPPORTED = 1,
>> @@ -4811,6 +4842,9 @@ static struct kern_feature_desc {
>>          [FEAT_BPF_COOKIE] = {
>>                  "BPF cookie support", probe_kern_bpf_cookie,
>>          },
>> +       [FEAT_BTF_ENUM64] = {
>> +               "BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
>> +       },
>>   };
>>
>>   bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>> @@ -5296,6 +5330,15 @@ void bpf_core_free_cands(struct bpf_core_cand_list *cands)
>>          free(cands);
>>   }
>>
>> +static bool btf_is_enum_enum64(const struct btf_type *t1,
>> +                              const struct btf_type *t2) {
>> +       if (btf_is_enum(t1) && btf_is_enum64(t2))
>> +               return true;
>> +       if (btf_is_enum(t2) && btf_is_enum64(t1))
>> +               return true;
>> +       return false;
>> +}
>> +
> 
> maybe simplify and rename to
> 
> static bool btf_are_enums(...) {
>      return (btf_is_enum(t1) || btf_is_enum64(t1)) && (same for t2)?
> }

Right this can be simplified.

> 
>>   int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>                         size_t local_essent_len,
>>                         const struct btf *targ_btf,
>> @@ -5315,8 +5358,10 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>          n = btf__type_cnt(targ_btf);
>>          for (i = targ_start_id; i < n; i++) {
>>                  t = btf__type_by_id(targ_btf, i);
>> -               if (btf_kind(t) != btf_kind(local_t))
>> -                       continue;
>> +               if (btf_kind(t) != btf_kind(local_t)) {
>> +                       if (!btf_is_enum_enum64(t, local_t))
>> +                               continue;
>> +               }
> 
> let's extract this into a helper and call it btf_kinds_are_compat() or
> something along those lines?

okay.

> 
>>
>>                  targ_name = btf__name_by_offset(targ_btf, t->name_off);
>>                  if (str_is_empty(targ_name))
>> @@ -5529,8 +5574,10 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>>          /* caller made sure that names match (ignoring flavor suffix) */
>>          local_type = btf__type_by_id(local_btf, local_id);
>>          targ_type = btf__type_by_id(targ_btf, targ_id);
>> -       if (btf_kind(local_type) != btf_kind(targ_type))
>> -               return 0;
>> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
>> +               if (!btf_is_enum_enum64(local_type, targ_type))
>> +                       return 0;
>> +       }
>>
>>   recur:
>>          depth--;
>> @@ -5542,8 +5589,10 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>>          if (!local_type || !targ_type)
>>                  return -EINVAL;
>>
>> -       if (btf_kind(local_type) != btf_kind(targ_type))
>> -               return 0;
>> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
>> +               if (!btf_is_enum_enum64(local_type, targ_type))
>> +                       return 0;
>> +       }
> 
> and reuse it in many places like here and above

ditto.

> 
>>
>>          switch (btf_kind(local_type)) {
>>          case BTF_KIND_UNKN:
>> @@ -5551,6 +5600,7 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>>          case BTF_KIND_UNION:
>>          case BTF_KIND_ENUM:
>>          case BTF_KIND_FWD:
>> +       case BTF_KIND_ENUM64:
>>                  return 1;
>>          case BTF_KIND_INT:
>>                  /* just reject deprecated bitfield-like integers; all other
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index b5bc84039407..acde13bd48c8 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -448,6 +448,10 @@ LIBBPF_0.8.0 {
>>                  bpf_object__open_subskeleton;
>>                  bpf_program__attach_kprobe_multi_opts;
>>                  bpf_program__attach_usdt;
>> +               btf__add_enum32;
>> +               btf__add_enum32_value;
>> +               btf__add_enum64;
>> +               btf__add_enum64_value;
>>                  libbpf_register_prog_handler;
>>                  libbpf_unregister_prog_handler;
>>   } LIBBPF_0.7.0;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index 4abdbe2fea9d..10c16acfa8ae 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -351,6 +351,8 @@ enum kern_feature_id {
>>          FEAT_MEMCG_ACCOUNT,
>>          /* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
>>          FEAT_BPF_COOKIE,
>> +       /* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
>> +       FEAT_BTF_ENUM64,
>>          __FEAT_CNT,
>>   };
>>
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index 9aa016fb55aa..1e1ef3302921 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
>> @@ -1343,6 +1343,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>>          case BTF_KIND_FWD:
>>          case BTF_KIND_FUNC:
>>          case BTF_KIND_VAR:
>> +       case BTF_KIND_ENUM64:
>>                  n1 = btf__str_by_offset(btf1, t1->name_off);
>>                  n2 = btf__str_by_offset(btf2, t2->name_off);
>>                  if (strcmp(n1, n2) != 0) {
>> @@ -1358,6 +1359,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>>          switch (btf_kind(t1)) {
>>          case BTF_KIND_UNKN: /* void */
>>          case BTF_KIND_FWD:
>> +       case BTF_KIND_ENUM64:
> 
> this should be lower, along with BTF_KIND_ENUM (btw, maybe keep it
> next to BTF_KIND_ENUM64 in switches like this, e.g. in the one right
> above in the patch)

My mistake. Will fix.

> 
>>                  return true;
>>          case BTF_KIND_INT:
>>          case BTF_KIND_FLOAT:
>> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
>> index f25ffd03c3b1..1e751400427b 100644
>> --- a/tools/lib/bpf/relo_core.c
>> +++ b/tools/lib/bpf/relo_core.c
>> @@ -231,11 +231,15 @@ int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
>>          spec->len++;
>>
>>          if (core_relo_is_enumval_based(relo->kind)) {
>> -               if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >= btf_vlen(t))
>> +               if (!(btf_is_enum(t) || btf_is_enum64(t)) ||
>> +                   spec->raw_len > 1 || access_idx >= btf_vlen(t))
>>                          return -EINVAL;
>>
>>                  /* record enumerator name in a first accessor */
>> -               acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
>> +               if (btf_is_enum(t))
>> +                       acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
>> +               else
>> +                       acc->name = btf__name_by_offset(btf, btf_enum64(t)[access_idx].name_off);
> 
> mild nit: it seems like extracting name_off into a variable (based on
> btf_is_enum(t)) would be a bit cleaner, then just one
> btf__name_by_offset() call with that name_off?

Will do.

> 
>>                  return 0;
>>          }
>>
>> @@ -340,15 +344,19 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
>>
>>          if (btf_is_composite(local_type) && btf_is_composite(targ_type))
>>                  return 1;
>> -       if (btf_kind(local_type) != btf_kind(targ_type))
>> -               return 0;
>> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
>> +               if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
>> +               else if (btf_is_enum64(local_type) && btf_is_enum(targ_type)) ;
>> +               else return 0;
>> +       }
> 
> use proposed btf_kinds_are_compat() here?

Right. Can do this.

> 
>>
>>          switch (btf_kind(local_type)) {
>>          case BTF_KIND_PTR:
>>          case BTF_KIND_FLOAT:
>>                  return 1;
>>          case BTF_KIND_FWD:
>> -       case BTF_KIND_ENUM: {
>> +       case BTF_KIND_ENUM:
>> +       case BTF_KIND_ENUM64: {
>>                  const char *local_name, *targ_name;
>>                  size_t local_len, targ_len;
>>
>> @@ -494,29 +502,48 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
>>
>>          if (core_relo_is_enumval_based(local_spec->relo_kind)) {
>>                  size_t local_essent_len, targ_essent_len;
>> +               const struct btf_enum64 *e64;
>>                  const struct btf_enum *e;
>>                  const char *targ_name;
>>
>>                  /* has to resolve to an enum */
>>                  targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id);
>> -               if (!btf_is_enum(targ_type))
>> +               if (!btf_is_enum(targ_type) && !btf_is_enum64(targ_type))
>>                          return 0;
>>
>>                  local_essent_len = bpf_core_essential_name_len(local_acc->name);
>>
>> -               for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
>> -                       targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
>> -                       targ_essent_len = bpf_core_essential_name_len(targ_name);
>> -                       if (targ_essent_len != local_essent_len)
>> -                               continue;
>> -                       if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {
> 
> 
> so idea here is to find enumerator with matching name and record its
> name and position, let's extract that part of the logic into a helper
> and keep the targ_acc/targ_spec initialization in one piece. It will
> be easier to follow the intent and less opportunity to get out of
> sync.

Will do.

> 
>> -                               targ_acc->type_id = targ_id;
>> -                               targ_acc->idx = i;
>> -                               targ_acc->name = targ_name;
>> -                               targ_spec->len++;
>> -                               targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
>> -                               targ_spec->raw_len++;
>> -                               return 1;
>> +               if (btf_is_enum(targ_type)) {
>> +                       for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
>> +                               targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
>> +                               targ_essent_len = bpf_core_essential_name_len(targ_name);
>> +                               if (targ_essent_len != local_essent_len)
>> +                                       continue;
>> +                               if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {
>> +                                       targ_acc->type_id = targ_id;
>> +                                       targ_acc->idx = i;
>> +                                       targ_acc->name = targ_name;
>> +                                       targ_spec->len++;
>> +                                       targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
>> +                                       targ_spec->raw_len++;
>> +                                       return 1;
>> +                               }
>> +                       }
>> +               } else {
>> +                       for (i = 0, e64 = btf_enum64(targ_type); i < btf_vlen(targ_type); i++, e64++) {
>> +                               targ_name = btf__name_by_offset(targ_spec->btf, e64->name_off);
>> +                               targ_essent_len = bpf_core_essential_name_len(targ_name);
>> +                               if (targ_essent_len != local_essent_len)
>> +                                       continue;
>> +                               if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {
>> +                                       targ_acc->type_id = targ_id;
>> +                                       targ_acc->idx = i;
>> +                                       targ_acc->name = targ_name;
>> +                                       targ_spec->len++;
>> +                                       targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
>> +                                       targ_spec->raw_len++;
>> +                                       return 1;
>> +                               }
>>                          }
>>                  }
>>                  return 0;
>> @@ -681,7 +708,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>>                  break;
>>          case BPF_CORE_FIELD_SIGNED:
>>                  /* enums will be assumed unsigned */
>> -               *val = btf_is_enum(mt) ||
>> +               *val = btf_is_enum(mt) || btf_is_enum64(mt) ||
>>                         (btf_int_encoding(mt) & BTF_INT_SIGNED);
>>                  if (validate)
>>                          *validate = true; /* signedness is never ambiguous */
>> @@ -753,6 +780,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>                                        const struct bpf_core_spec *spec,
>>                                        __u64 *val)
>>   {
>> +       const struct btf_enum64 *e64;
>>          const struct btf_type *t;
>>          const struct btf_enum *e;
>>
>> @@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>                  if (!spec)
>>                          return -EUCLEAN; /* request instruction poisoning */
>>                  t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
>> -               e = btf_enum(t) + spec->spec[0].idx;
>> -               *val = e->val;
>> +               if (btf_is_enum(t)) {
>> +                       e = btf_enum(t) + spec->spec[0].idx;
>> +                       *val = e->val;
>> +               } else {
>> +                       e64 = btf_enum64(t) + spec->spec[0].idx;
>> +                       *val = btf_enum64_value(e64);
>> +               }
> 
> I think with sign bit we now have further complication: for 32-bit
> enums we need to sign extend 32-bit values to s64 and then cast as
> u64, no? Seems like a helper to abstract that is good to have here.
> Otherwise relocating enum ABC { D = -1 } will produce invalid ldimm64
> instruction, right?

We should be fine here. For enum32, we have
struct btf_enum {
         __u32   name_off;
         __s32   val;
};
So above *val = e->val will first sign extend from __s32 to __s64
and then the __u64. Let me have a helper with additional comments
to make it clear.

> 
> Also keep in mind that you can use btf_enum()/btf_enum64() as an
> array, so above you can write just as
> 
> *val = btf_is_enum(t)
>      ? btf_enum(t)[spec->spec[0].idx]
>      : btf_enum64(t)[spec->spec[0].idx];
> 
> But we need sign check and extension, so better to have a separate helper.
> 
>>                  break;
>>          default:
>>                  return -EOPNOTSUPP;
>> @@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>                  }
>>
>>                  insn[0].imm = new_val;
>> -               insn[1].imm = 0; /* currently only 32-bit values are supported */
>> +               insn[1].imm = new_val >> 32;
> 
> for 32-bit instructions (ALU/ALU32, etc) we need to make sure that
> new_val fits in 32 bits. And we need to be careful about
> signed/unsigned, because for signed case all-zero or all-one upper 32
> bits are ok (sign extension). Can we know the expected signed/unsigned
> operation from bpf_insn itself? We should be, right?

The core relocation insn for constant is
   move r1, <32bit value>
or
   ldimm_64 r1, <64bit value>
and there are no signedness information.
So the 64bit value (except sign extension) can only from
ldimm_64. We should be okay here, but I can double check.

> 
>>                  pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>>                           prog_name, relo_idx, insn_idx,
>>                           (unsigned long long)imm, new_val);
>> @@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>    */
>>   int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
>>   {
>> +       const struct btf_enum64 *e64;
>>          const struct btf_type *t;
>>          const struct btf_enum *e;
>>          const char *s;
>> @@ -1086,10 +1120,15 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>>
>>          if (core_relo_is_enumval_based(spec->relo_kind)) {
>>                  t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
>> -               e = btf_enum(t) + spec->raw_spec[0];
>> -               s = btf__name_by_offset(spec->btf, e->name_off);
>> -
>> -               append_buf("::%s = %u", s, e->val);
>> +               if (btf_is_enum(t)) {
>> +                       e = btf_enum(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e->name_off);
>> +                       append_buf("::%s = %u", s, e->val);
>> +               } else {
>> +                       e64 = btf_enum64(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e64->name_off);
>> +                       append_buf("::%s = %llu", s, btf_enum64_value(e64));
> 
> %llu problem here again

okay.

> 
>> +               }
>>                  return len;
>>          }
>>
> 
> [...]
