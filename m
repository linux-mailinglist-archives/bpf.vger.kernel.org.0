Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502DB5AF474
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIFTac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIFTa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 15:30:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324A3B976
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 12:30:26 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286HRgN6001469;
        Tue, 6 Sep 2022 12:30:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=boRQn3mKnc9sFEQZ/oFAE+DJW4mDJ6eMwQrQxl2gt+Y=;
 b=WErSl0N62uFKOAKugBE0WNhLf3GnZZi+g557Ia84/PGf92ln+RV1AwJ9EUYDootRC8qh
 aUl34JsSTsX1XMMcbq4k0JdgpCdKDkyjn1jnTqUOnUuFl0kvJkaHydoqEiKqnQj7P9X/
 4H+PlF18VZE0+IlEqOts4HsOzxaB7a2GTRM= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jeamh8vbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 12:30:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuRjzOQGxdJNYlROkRFr991LVUM74IjYoptW6u7P2Vrth+oY+nGXaO+zO8AiNLIYKxabVIyz+/5cDSl3FtBUcGR4RGjCEoVSsr1np/zqph3UL+SRm13TsAr5OmueXihPzIyBRjXyfyALf6IyjjtL0SsuXyiLRELX0cA090DCtEPOEtbUMyCVL7oDW0JfZOuK2A2YP2Yy0blcDOil23PG6SEMNKrPx85ULXFAAZF/0KkZIvz4S8pn6TVZISZqEQt00n5B0wWm0b/XrzU0n4NswvWpYdeO9rgspw6XI1S3DMbCJXfZ8oUmEj4j+kmSohiE+A0pV7Zx47xz23E9V4NgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boRQn3mKnc9sFEQZ/oFAE+DJW4mDJ6eMwQrQxl2gt+Y=;
 b=ZKGIJFrWcPjaDxnezwqFQvl/5qfUg+ChAagfx592UQZZz3cZk1YV7vsSUN84Iz6zNtO48WiAA/SLQW4HXOvwAJCFD4pTqA87uwIlzp7i83Y01tNNEEWZVG/M+OVNt13XVeDSSgJ8wBSIez8eyYUwnPmGMCk+oaXylDS9HepRFqrKETxKTkUUGONAYBKoQ0Zp0AFFZ/1r+KVv2h+C/veO5tdzp26pyT9DqkKcCZ4Moi+bfzU/Sd4DzJVE5RwdMMJI6uYdCKl80D0y7/beMkWbcm8mjBO0BHRjjw2Co2eDYYrIK4omYCKXb/f87UKocxqhOYT0tC76NMOkoqEwjKFGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2399.namprd15.prod.outlook.com (2603:10b6:805:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 19:30:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5588.016; Tue, 6 Sep 2022
 19:30:07 +0000
Message-ID: <6d20e6e9-2fb1-0277-9052-fcdbb9433425@fb.com>
Date:   Tue, 6 Sep 2022 12:30:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: x86: Support in-register struct
 arguments in trampoline programs
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220831152641.2077476-1-yhs@fb.com>
 <20220831152652.2078600-1-yhs@fb.com>
 <720da915f55ec58eda8b60d2c27568a3fff70999.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <720da915f55ec58eda8b60d2c27568a3fff70999.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033b1b31-a06d-41ea-9f64-08da903e3504
X-MS-TrafficTypeDiagnostic: SN6PR15MB2399:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTTY3rDoZXEodlIEI2AKqdeprxPELW4OMLTwlzsuYILne3GYCz6cGQvER+hvDBTJXbCM/gp3VM5Phv+3xT5WSLWJrfPcRlGA0T1zgf//mGNVXt+gAg2rUZ8eGprk7dUGrGNafD4OJ/DTPLVVL9O98/D2SAxdz/V2bWcQ6NklqYaQrQunD1faNqwOwSXxFHkqkmDhgqtBLfffFzmpeajPIWFSNvhykSUmxqydf8wS3ID6X4TcVOPgm9up37ENmo3GD/jQPcvPq91Cdqb5eNsV+9t2LpS/DaHeVGjIG8taOMjiPphHHUUNYXmxmCYlPHsHTvOhJHWmMWEXNkD6TMnfIBV5pNC3EV7XtPllyjCssrMl6XDBmohd6mJRU+Xu88DTQB6Y9q6XSG66tasOKb1AP6xWow6q4KzdVUEPb8kNLCuIhK8f06LuIDLJSRA+MYgTCQb9feOV8+NcSK3y8l453LI8BjCOKlLUDKZaUxXywRO+31ySbWnFzGAaVYA0rlO2VbfYv5wLmVqs2GegCijlZeG1ug/sEX2vZA9N4CCHqDqV2r6gZIkV3jVaqynAbbuI0ZIokMn7N5PTkPbV19FJXV8Cvah7zxX8wOCJXmJv0Q38lJwsPjxdVBFv1gOV/e3eBdhFGi1dsmvlLjWq1KCw/fvRdm7UtiFvd9mejudQPmlnbJprYrDajcd/C3O+UBJQ9pXlOy822tdG9KzaW/AHdfcWzEo3oQTstupP0TdTWAf7nzmTEZeC2ZPS9Edvxqp0SNMaH5G4or/rdF3yObZXzHDW3lALAe/u1tTG2yGVni1Ut3BF9im1IWikVWLKTEWPOm5c9T6EXImFaRBsGKx0sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(36756003)(5660300002)(41300700001)(6486002)(966005)(2906002)(38100700002)(478600001)(66476007)(66946007)(66556008)(86362001)(8676002)(53546011)(4326008)(8936002)(6506007)(31696002)(110136005)(186003)(6512007)(31686004)(54906003)(316002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5PcklUclc4cjEwN2l2SHY1Y1NOUWtTWHp0WVg1MGV0NDduUWFlNXEzVWVu?=
 =?utf-8?B?dzBvV2gvQno2NlIwUVdYczNYTXl2VUV5ZWRZckZFUkFidGoyU0FTZG9IbXdR?=
 =?utf-8?B?Mmo0dDJyNndyZzB0M0dEREwzb0VKakhYY3crZ2tUMHFLNHVPSE5QVXo3Z3Nu?=
 =?utf-8?B?ekVvS1VzeGQydWN0NGxIQlRZaWl6TEIrMG8yVTNtampkeTRJdWlDU0JQRTFk?=
 =?utf-8?B?VjltZHVuRFFiVEYrbWVrdjU0RG5STzJYZS9VdDAwTGpGU01qd1daNmNHVm5t?=
 =?utf-8?B?dkdQSHBsbWlGazRlVHI0SzhTLytmaHpqaHFsQTVtTThWaUNEaHYvRUhHem5N?=
 =?utf-8?B?bVVOVENTaGxLc0RwclBha3NqZzVNVHhMN2JFMENCRDdoQXV2SFdsdHhtVWZU?=
 =?utf-8?B?NVFDUGF0aEYyaXY0QVBIeWswdy9EcEwrMjVpNWV0eUcwLzUyY0JOeGkyRjQ4?=
 =?utf-8?B?SWo5MVFJaC8vaEEyMWEwYWR2NDZHNG5iQld4VU5xZXUzekNaUHFqTkhhb1dv?=
 =?utf-8?B?NWJDeWtYTzBaZURsb3RRelhKMkIzYWtCa2gzU0w2RFZ1Wm5kUXpGdHR2dndS?=
 =?utf-8?B?QWVZZjdEUEl5VUdnTDJvRWtMOWcySitpUXFjd1dmMjg5UzhJcGRNNWpLUEFD?=
 =?utf-8?B?enRUbzAyKzNVdzViQnd3QW9mN0dSK0pSbThBTTVmeHdSUUk2Vi9WT0RONmkz?=
 =?utf-8?B?YlZkOXlXUkFGZml5Tk8wOTJSajFHM0oxWmVhRVlPZVdmS2JDVVpRRnlxc0Iz?=
 =?utf-8?B?QTlVRGEzSGlram54WFdrblFjVDEwL2FvVXNkc0h1SzFneER0YXlycnpubldB?=
 =?utf-8?B?TTlTWXk3Z3NqVWFkeDBHektKbWJOZXc4RWVlZjgxN3BiZ09iU0RqRUZBTWRi?=
 =?utf-8?B?N3ZXallKWm1kelZwMGlVbUxVNERoTXRZRFBHK3pzS0FjUFRPblJlaFpRNVVH?=
 =?utf-8?B?MXdydGJlYmhrdVZqTTZIWnlxQmhCMGZVbm53NXVrU2RPZUczRzQyQVBWbmtp?=
 =?utf-8?B?dDRCOXRmTUQzWXYxb2hlN2J3OWVwaGg5MlVSRktaanhNMlJMWFhpNlY0Sko1?=
 =?utf-8?B?UE42ZXFxSng3dk1STzBwUXZxM3BlVzlBem5HUHIvVEVSVnJDdnBEd3FKcmoy?=
 =?utf-8?B?VGVXdWR5dlFJQnN4LzdFNWMrKzUzN1c3RVB5cnhPL0R5eUtQaDdXazZGeElk?=
 =?utf-8?B?MVBLTHlxMUdFRlQyN3orWlg4RVA5RGhzWFZnMFh4SEliVjlhVEFHWHJ6L2Qx?=
 =?utf-8?B?bDQrY1pmREZVNmlRNHFrYW5qYXduWmFFc243Z3RuaytzWmwxZnJqMGxrK2Zu?=
 =?utf-8?B?dmRIQ0tmT1dId3pnbXFNUlJ0ditmYlp5UDczVGZnbEpFSUFxZ1NDMU5CZ0xU?=
 =?utf-8?B?cFIvcTdWaGtRdnFlYVFlN3VZRmQ3V3NMNVlhR041aFRLajMyTTdSejF0Sis3?=
 =?utf-8?B?WUlwalFUZmxSVXZHUnZncEFEUWV1Z0pCUUdZdys1akYxa2VueGVkeHd1dVpH?=
 =?utf-8?B?NFRPN08vLzFpbFpJTTF4RlVuNG1vZ2diSk9ndXJ0Vk9sWTc0RStGMWVwaUxM?=
 =?utf-8?B?SUlocFFvOENQdDhlV216M2twMzdmaThHTUdZQjNLQ1lTNjJVSndSWHlGVU9H?=
 =?utf-8?B?QkZaZkg4by9CY3FRNStQcG9qaFl6bmdLd0pvaHE5OEdpbVlGTmNXTTFReTVy?=
 =?utf-8?B?Q0NJd1JwV2sxM3ZTb21HdW5MYU1BTU5PS0RGc1FUbXhxL1Vic004SUtmQlFr?=
 =?utf-8?B?YkkwVHRPWjlIQ09CZ3BWcStpWDNqemdJaTFZdEpES1dCSzRka2FnWi9qTCs0?=
 =?utf-8?B?WjdtY1Y2aVBDekJQSU10blFqcEVmSUFzK1BKMmYwUzhkMWZpREo4Q2s0UlZz?=
 =?utf-8?B?YytaMUg3QnJ1dElQWlZRY2dBQ1NpREhBdDlTbFZWNGhKaGxjQUQ2b0FWVGZu?=
 =?utf-8?B?OU5XdTluMzBjZDAweWprRDBWRm1ONUhKV3Q3SEwvNXVqZUo2Z1I0QUxORnhK?=
 =?utf-8?B?TGxvUk5ocUJuN204QnhFMW16S1JEMXA2TUlrRUZzTDJDVmxzd0Q3NFVQeVF6?=
 =?utf-8?B?MTZYc0FBQjVpWkJQWHBNNEp1ajk1Ulo2S0dlWUk3c2ZxdHhqaExlZ1ZlZTFk?=
 =?utf-8?B?YTVKMnRqc2w3aTRKOTFnMml0SnZIOHdPamp2UndxS3dBNVF2MCtFdTJ1bXlV?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033b1b31-a06d-41ea-9f64-08da903e3504
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:30:07.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC9j5fwLnUB9ULKxxOmI4RvEDPIY82JtCTof78VIdg+7YbbLJ79XHYlipirUNZLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2399
X-Proofpoint-ORIG-GUID: xabLjXb4p3FdYZaoxbsq--aLbHHpv83X
X-Proofpoint-GUID: xabLjXb4p3FdYZaoxbsq--aLbHHpv83X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/6/22 9:40 AM, Kui-Feng Lee wrote:
> On Wed, 2022-08-31 at 08:26 -0700, Yonghong Song wrote:
>> In C, struct value can be passed as a function argument.
>> For small structs, struct value may be passed in
>> one or more registers. For trampoline based bpf programs,
>> this would cause complication since one-to-one mapping between
>> function argument and arch argument register is not valid
>> any more.
>>
>> The latest llvm16 added bpf support to pass by values
>> for struct up to 16 bytes ([1]). This is also true for
>> x86_64 architecture where two registers will hold
>> the struct value if the struct size is >8 and <= 16.
>> This may not be true if one of struct member is 'double'
>> type but in current linux source code we don't have
>> such instance yet, so we assume all >8 && <= 16 struct
>> holds two general purpose argument registers.
>>
>> Also change on-stack nr_args value to the number
>> of registers holding the arguments. This will
>> permit bpf_get_func_arg() helper to get all
>> argument values.
>>
>>   [1] https://reviews.llvm.org/D132144
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++--------
>> --
>>   1 file changed, 51 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c
>> b/arch/x86/net/bpf_jit_comp.c
>> index c1f6c1c51d99..ae89f4143eb4 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1751,34 +1751,60 @@ st:                     if (is_imm8(insn-
>>> off))
>>   static void save_regs(const struct btf_func_model *m, u8 **prog, int
>> nr_args,
>>                        int stack_size)
>>   {
>> -       int i;
>> +       int i, j, arg_size, nr_regs;
>>          /* Store function arguments to stack.
>>           * For a function that accepts two pointers the sequence will
>> be:
>>           * mov QWORD PTR [rbp-0x10],rdi
>>           * mov QWORD PTR [rbp-0x8],rsi
>>           */
>> -       for (i = 0; i < min(nr_args, 6); i++)
>> -               emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
>> -                        BPF_REG_FP,
>> -                        i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>> -                        -(stack_size - i * 8));
>> +       for (i = 0, j = 0; i < min(nr_args, 6); i++) {
> 
> Is 6 still correct since an argument can take more than one register
> now?  Perphaps j < min(...)?

'min(nr_args, 6)' probably a historical artifact. It can be
replaced with 'nr_args' since in the beginning of function
arch_prepare_bpf_trampoline(), we have

         /* x86-64 supports up to 6 arguments. 7+ can be added in the 
future */
         if (nr_args > 6)
                 return -ENOTSUPP;

so nr_args <= 6 is true.

> 
> I am not sure how to deal with a corner case that a 16 bytes struct
> arguement happens to be at 6th place.  Does that mean first 8 bytes are
> in a register and the reset bytes are in the stack?

This won't happen, see below change in arch_prepare_bpf_trampoline()
where it is checked to ensure the number of registers holding
all arguments mush be <= 6.

> 
> 
>> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>> +                       nr_regs = (m->arg_size[i] + 7) / 8;
>> +                       arg_size = 8;
>> +               } else {
>> +                       nr_regs = 1;
>> +                       arg_size = m->arg_size[i];
>> +               }
>> +
>> +               while (nr_regs) {
>> +                       emit_stx(prog, bytes_to_bpf_size(arg_size),
>> +                                BPF_REG_FP,
>> +                                j == 5 ? X86_REG_R9 : BPF_REG_1 + j,
>> +                                -(stack_size - j * 8));
>> +                       nr_regs--;
>> +                       j++;
>> +               }
>> +       }
>>   }
>>   
>>   static void restore_regs(const struct btf_func_model *m, u8 **prog,
>> int nr_args,
>>                           int stack_size)
>>   {
>> -       int i;
>> +       int i, j, arg_size, nr_regs;
>>   
>>          /* Restore function arguments from stack.
>>           * For a function that accepts two pointers the sequence will
>> be:
>>           * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-
>> 0x10]
>>           * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
>>           */
>> -       for (i = 0; i < min(nr_args, 6); i++)
>> -               emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
>> -                        i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>> -                        BPF_REG_FP,
>> -                        -(stack_size - i * 8));
>> +       for (i = 0, j = 0; i < min(nr_args, 6); i++) {
>> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>> +                       nr_regs = (m->arg_size[i] + 7) / 8;
>> +                       arg_size = 8;
>> +               } else {
>> +                       nr_regs = 1;
>> +                       arg_size = m->arg_size[i];
>> +               }
>> +
>> +               while (nr_regs) {
>> +                       emit_ldx(prog, bytes_to_bpf_size(arg_size),
>> +                                j == 5 ? X86_REG_R9 : BPF_REG_1 + j,
>> +                                BPF_REG_FP,
>> +                                -(stack_size - j * 8));
>> +                       nr_regs--;
>> +                       j++;
>> +               }
>> +       }
>>   }
>>   
>>   static int invoke_bpf_prog(const struct btf_func_model *m, u8
>> **pprog,
>> @@ -2015,7 +2041,7 @@ int arch_prepare_bpf_trampoline(struct
>> bpf_tramp_image *im, void *image, void *i
>>                                  struct bpf_tramp_links *tlinks,
>>                                  void *orig_call)
>>   {
>> -       int ret, i, nr_args = m->nr_args;
>> +       int ret, i, nr_args = m->nr_args, extra_nregs = 0;
>>          int regs_off, ip_off, args_off, stack_size = nr_args * 8,
>> run_ctx_off;
>>          struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>          struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>> @@ -2028,6 +2054,14 @@ int arch_prepare_bpf_trampoline(struct
>> bpf_tramp_image *im, void *image, void *i
>>          if (nr_args > 6)
>>                  return -ENOTSUPP;
>>   
>> +       for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
>> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>> +                       extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
>> +       }
>> +       if (nr_args + extra_nregs > 6)
>> +               return -ENOTSUPP;

Here to ensure the number of registers holding all arguments
must be <= 6.

>> +       stack_size += extra_nregs * 8;
>> +
>>          /* Generated trampoline stack layout:
>>           *
>>           * RBP + 8         [ return address  ]
[...]
