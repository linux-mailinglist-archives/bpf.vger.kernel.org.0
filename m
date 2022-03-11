Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B74D56CA
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbiCKAfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiCKAfK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:35:10 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78256190B75
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:34:08 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AI56Ww020669;
        Thu, 10 Mar 2022 16:33:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6dUk8AFHMz3XfrkTp6fZOx/T3F4X8VG97O9CTCr+dPY=;
 b=nuPW78ViCD0Js67/PvWn2IuF3TLBRg4pfLHb2cHK0/NzWOuWgaACrNjVDKML1YA9ocQj
 UhUfCyxgGzNv4OpeNROLI7kNCVgiWwxDdl7r8JpuHIJZREjqqpG4t0yT+MD4bxbMtZL1
 Obq1ReULgSyzbU8nRE7ApW1WqaPSuTiXL4Q= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqkue49jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 16:33:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiYWWz7uIsMFKEh8DrafwqXSAYE3dyjMQpfdysW5T9re7xH0xFnx+pcQR17SXn9Z82oKkZPR30kK8/MLD3W4hqQvRAe33Tw/wdPJX+4YMmjitYTG7Ho+CuHjPgT3rNHWjtc+4/NhfAScaxeG46cN0iIn3wEMoTgxQcv3RsIcd31AtfGs9PrT3CZwsorNh49IzthTog6HcajtUXhXmg4Wzbgws5QSRdcvb/OaH4bpZsvz3oVMUB2ygUZ4L7SExY7+zwTUPAzYo9UJlw3KaTusS6xHBePgJvtVW6DZJep1lwcxCU7/PuazlN0T9xLwZ9t1ILtQ2Yo+SpRYRurXfBfTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhHtaPcvgRCQG8rR7OauUkSC1EwLvhlelY2rrJhUDaQ=;
 b=oPXo8KNo4MXgfCsyCJD+zr1OfNLikJYDYzHNxzLdl5G4f0Kqlnirvc8ckE32SBGgyR/zrqaa/O1p7Xjy6yLApyWRy92rwVL/a8pkvAxN8COxwbwZxGTuvPsgnBykSftU4MOUhSQnhd2f+sMV6e787MYKcNUh3fwrZ1sZPvQeAmcflAPl7tQZaBXF+UB+TcQvHhBtcYxjknIbdHJQpijzWB4c4NVq0t+mu1LpyHFP1IOmz9NILP0+Mw+jAIN7j7KesFKNxNzRcX18cylfHz+vDWdoz04vhpgwe2CQMzNZejQnyx9L4jroHgp9UkZop8b/fseVGN7qARnsL6/Km2KU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1370.namprd15.prod.outlook.com (2603:10b6:3:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 00:33:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:33:52 +0000
Message-ID: <4c80d814-3ab4-6659-9abe-f2f78ea6bd11@fb.com>
Date:   Thu, 10 Mar 2022 16:33:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang compilation error for
 send_signal.c
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220311000508.2036640-1-yhs@fb.com>
 <CAEf4BzY0r07gydqXm6OpPWuzefdvta0FUhOn+Tj9W+KLWxiKcg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzY0r07gydqXm6OpPWuzefdvta0FUhOn+Tj9W+KLWxiKcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a52e6b-8472-4686-dca7-08da02f6d176
X-MS-TrafficTypeDiagnostic: DM5PR15MB1370:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB13709CB3B00C5A872382D57BD30C9@DM5PR15MB1370.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZEsJt9YdGNpjCztZRDVHbjJkoV//ot0erIW9H3WsDkJ/a4k5lbVoFOIsBsQbhCHRNxWtds+htwwiDxq+POQg8BpmMZ1Qq9RKk5zQBe2ClL+76hTfWqvdrRQ72b6WYF84Z8INR3WNDNWyNrtDOoOw0eiY5xDnpkIiRLLI6F2iOOmlb4zNps6NQX8LITWlHj2WZ5E2RAiA3LMvRMn/6lboZmO3KT0jK8AbX0Rdf/hm4MgVocHFySCZfgmuxeD4KAv4GjwSc3H3wB1/AkK1BTczi2WHgobXg2EftRfYggnccR66BxtM2I4ImGn1ep1Z2LTqkf97IoidCqUkC6X1y4Nw/yVf3IG4bRcd8S07NcD3R23ATbB/3zsXahMZWxO01W3b9KB6aJTyZrDfN7XH7uldWxQKl6BZsxkPogSoh7gGbmlapm3qTXOWLq2dffCcR/TmMTUE7ygzpNz57gIF/+lchl++paIkEP66shBc9ZRGXVOGm4s/lFrT6daLKd/lRCvZcmDMWoWFClBRrN3UYN8/faQIaMSWY21eXqdNcZKFGYFe6VuandbPyN+owCZ6oc7VsgutkjH7oWEYeSPLmC7E/QWHvuFp1jKQA2gHr/M0Tg7FCkDt75a7vy8EWNttIvnUTmuTb7CBFsLk/VB0DvdN4wWFFgNMsQvRTDmwAKVbr5xffZbgF3yXp7IFZ2OM6ssb1UI8nGKdwjAY3Bpzsi+TOAhxPeFGc+Jfqv+VQwlc1yII7xlsr0G+w5BFAuhKmdpd+Ryr0XO0+0TZ4skPtrIZmwKkcYs/6e/8q+328R6p1+ZqPyjyCTEXistF3P7fg/C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(8936002)(6512007)(2616005)(36756003)(8676002)(86362001)(508600001)(4326008)(31686004)(316002)(38100700002)(66946007)(31696002)(66476007)(66556008)(6916009)(5660300002)(966005)(6506007)(6486002)(2906002)(53546011)(54906003)(52116002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZJc0djcDVqc2FZUi9vKzJYaWpSdldTUEpsNm1ISklqeWwreExmVFN5anhk?=
 =?utf-8?B?SE12YlVaaTBtZGVTcE03ZnBDQ0ZWQ2x6U3VkNDlhMVdVSFJydnZ6VWVRV0dI?=
 =?utf-8?B?RndEaWFCaDl1S0hIZjVuK1ZSY2JrRmh6TlQ3Q2ZBcEUrQm14c3NSMnVPOVhD?=
 =?utf-8?B?VHBiVTdZNUVzM05rbGx6akoycFMxU2twU096aklHNGJINjBBc3YzUlJEMG9V?=
 =?utf-8?B?ZFhCcTRqSjBUUHJpVXJCTHlNSkMvYi85bjQxOXVCT0R2eHloQlFmYVYxcHYv?=
 =?utf-8?B?Y3Y1ako1RmhhM29iSnFORFU2bWhKS1FsY1UzV2lIT3hOSjB3QkdPclVsb1RG?=
 =?utf-8?B?RlNKZm9pa01ZU0pPVGIyVHk1NXFRc2lsakN4VG5DZ05NMmd5QU15THhyckNB?=
 =?utf-8?B?TTFVMHprcGJudnlNbTNucDgzcWdKL0FtaWt1dkhReVhqQjA2Y2pBVVE3QnIz?=
 =?utf-8?B?bzBNWkFhSXc3UDhCQWd6N1NLODRCQnFuc1NPK2FKaXZXRGRWc1hwN1lBQlRm?=
 =?utf-8?B?YTRTRkNETzI3TGZxN2NZNk9mRFVIVnk1UndlR2lxK3cxSzBVa3p3aTdIdzVZ?=
 =?utf-8?B?RCsxSnJMUWNMR3MyemJpM05tdUV4MFl6NnpxWlBObTZKaWN4NDdvSVc5NVBP?=
 =?utf-8?B?NDE1TzQ3RXNpSUNmcEhJc0NqVTQxK2pDZHBHcS9FSU5nemw1NjZGRU9FWm9r?=
 =?utf-8?B?QkJQS1pwbkNmTXlXamZlaGo3dFlJOVREYlNValpYaVI4RkFGakRBcE1NbmlY?=
 =?utf-8?B?Z1A0dENSbkEzaU5LQmEremJpRmpRRmlBKytDTGd0RE42VkZhZHlIUWJzWVJj?=
 =?utf-8?B?ZjBPYi84SGYwbVBqQzV0RUVQV0ZxQ1FEK3NCOFpucGluYUI0c0tlWkQ5WlB4?=
 =?utf-8?B?RFJ0eDVyRE8vTDEwVE5IZGhYcGFnbzd0MlZyQXAzSnhIQnp4MThhSVRWVWFV?=
 =?utf-8?B?dkVOakkwdEY0b2piV3FKcGZ4MFlOMEpBN0lTNzFpckRFU3ZORTA0MTc5Mmx3?=
 =?utf-8?B?eU1rTjFBRXZjanFuN0szOFZTZi93RzRGRFFlMzdtQjJZTktlT2s4RDRML0hY?=
 =?utf-8?B?UUpvL21jM0g1bzJxNXFKdDlMWWdmanQyZjlET1RlUDlSZWdjY2JzbW5Gd1Bj?=
 =?utf-8?B?VVh4V3VKRkN6WTBhTDg4NVNqeU5jbDJCRk00VHViVFBXbWJjbHZqd0d0UEla?=
 =?utf-8?B?bXl5dFdiNEhWR2pYVWFTdHNKU1Y4TGhLNUxqV3JseTNvREVuc2xLd0Yvdy9G?=
 =?utf-8?B?VXVEQXFQNURVSWNGd1JjRmhsWVRhWDA4Si91dExLeEZEOThJQXJhMnVHbElG?=
 =?utf-8?B?MzgyUGpFZkh0L3RLSFF4UnNKUm9TSjY4T3F6ZjdiVERxR2VCcUFKVW9ZcnRm?=
 =?utf-8?B?bmd0K01HVGlMcUlXQnp0ZWgzV1lVL0JJM0FSMnVNeFJHS1lLVS9sek00SFAy?=
 =?utf-8?B?Sk5obTZnNnFnNUZpMFpUUlVjeEN4djBIMGFKWnUzK29FY3ZIS3A3K0ttSFpR?=
 =?utf-8?B?WjQ3Z3VUeFQvNzJiSlBsWW9wL0FMRWt1RC9vTDJzY0VqQ1NxZzVrazArTUR3?=
 =?utf-8?B?Y0pSdC9CZm5pcjNmOEVmSHpZcGpIL1Z1YStXNDlEWkxseWtFeUwzczgvSCs2?=
 =?utf-8?B?Rmh6T1JHWmo5TjhOYTByd0pXbThmT0p1ZjkxWXZBRjh4Tk9DTlNseG9MUUl3?=
 =?utf-8?B?NXRaTGRMLzVyemZoTyszWlBzQXRNdnlMUW1NeXo1M1A2Z0dtdnNxZjduOUox?=
 =?utf-8?B?bWk1aVN1LzZjY1hkdU5YSTB3aytBTDNJMkczMDRHMjJDUWhTU2NuOE9zQzJQ?=
 =?utf-8?B?amhiQnh0b1FwRVgxcWRBR0MxdDZwRXhvWnZxbmthSGJVTW5xbUdiLzl6WHZX?=
 =?utf-8?B?WjhlTXN0OTdwUjdITDBnc1p4dVdpdXVYUlY3MWlyWVUrYW90MVdycENWc2o3?=
 =?utf-8?B?azFKQ0VDRWkzMFVkUlgxQWdFelFCbUV6T2M5WTN1WnZod3pFK0FWZ3JmaFBN?=
 =?utf-8?B?c0dtVTRRbDhnPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a52e6b-8472-4686-dca7-08da02f6d176
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 00:33:52.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQKf11POBvuLc90zR2mqlTnTqfswXAG37kTt3AEKZb7bxDxUrILJGOmhceGyzTGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1370
X-Proofpoint-GUID: klBZhKFDp9AVt7dHVJ1u3JXcrgfat3cT
X-Proofpoint-ORIG-GUID: klBZhKFDp9AVt7dHVJ1u3JXcrgfat3cT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/10/22 4:17 PM, Andrii Nakryiko wrote:
> On Thu, Mar 10, 2022 at 4:05 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Building selftests/bpf with latest clang compiler (clang15 built
>> from source), I hit the following compilation error:
>>    /.../prog_tests/send_signal.c:43:16: error: variable 'j' set but not used [-Werror,-Wunused-but-set-variable]
>>                    volatile int j = 0;
>>                                 ^
>>    1 error generated.
>> The problem also exists with clang13 and clang14. clang12 is okay.
>>
>> In send_signal.c, we have the following code
>>    volatile int j = 0;
>>    ...
>>    for (int i = 0; i < 100000000 && !sigusr1_received; i++)
>>      j /= i + 1;
>> to burn cpu cycles so bpf_send_signal() helper can be tested
>> in nmi mode.
>>
>> Slightly changing 'j /= i + 1' to 'j /= i + j' or 'j++' can
>> fix the problem. Further investigation indicated this should be
>> a clang bug ([1]). The upstream fix will be proposed later. But it is
>> a good idea to workaround the issue to unblock people who build
>> kernel/selftests with clang.
>>
>>   [1] https://discourse.llvm.org/t/strange-clang-unused-but-set-variable-error-with-volatile-variables/60841
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> index def50f1c5c31..05e303119151 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -65,7 +65,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>
>>                  /* wait a little for signal handler */
>>                  for (int i = 0; i < 100000000 && !sigusr1_received; i++)
>> -                       j /= i + 1;
>> +                       j /= i + j;
> 
> `+ 1` was there to avoid division by zero. Let's make it `i + j + 1` then.

Good point. Previously I did this 'i + 1 + j' and run the selftests and 
it works fine. And for preparing the final patch, I removed "+ 1" to 
simplify the code but didn't actually run the test which is not great.

Will fix in v2.

> 
>>
>>                  buf[0] = sigusr1_received ? '2' : '0';
>>                  ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>> --
>> 2.30.2
>>
