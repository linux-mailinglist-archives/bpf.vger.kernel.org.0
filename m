Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91852B507
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiERIXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiERIW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 04:22:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771A106367
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 01:22:55 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HMwtsc004341;
        Wed, 18 May 2022 01:20:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OnxAhEsgti3bqdH/jxF98H/Odd+aLpavWwzgf9TNhd8=;
 b=STIwvAb9DJvkuvvSoaE+azgqP3q/V2y/9jYrO3zpSHNniVbG0jh+EZ4gi29+oCcbSVuo
 WAQu+sjGQ5EoH18wWQZvOWMMWhiLkLxHTSzfe7iRKM1XPtC4bDoEfj/JksbNxzr94uMw
 mh9/SST8OLR5WIwgAuxrDH771XO3TktyO38= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g4myhjab2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 01:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l15+dJPwS1h2GR1tpM/4A7RLYn6/Cckat4AAHXFx1wzGfrqvjah2UofYRTLGtKxqYBt4FIOizUTGNUhYrulwsFXPURPPXbB9ATzLzqNg0Ao0Bce398bX7ZVdBPesEb3C6cB4r4fEGIZAW3c33C9fFBd2ZVXZLEb3yNiznDdUNiU//g50dZ+6DwbmEJUsPZSLHk5bU5hIJ4PVHu30kB++mvGICKdO4XxxdmDNvj7pMQE+Az7BARMsGPAcLm03AhWhhvaL473s+/b5w+SO3KjJQ/VSdWdp8TmeoCyJHu813gJTSIGjduMfHXrnJfV8H1TfGLDidaiBeyeVPn2N49Th2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnxAhEsgti3bqdH/jxF98H/Odd+aLpavWwzgf9TNhd8=;
 b=AGdpK0MZnK/HYLFdQg1wPsw2TwioPFmwciZRJfay8G+y3rXGa59RAkH0AtIVkP4sy7X0/gILd6WN+zogvuz2V4G1ntb6rRHDS28b38uItr1zmPx+pmtBNL+o92gZCMYQXlJCdV590h4nkqoC3qNP2eEY+UonzVPx6Axe+DD0mdAigzUqM1bauwI/Jza7XuX/q22DAIlBG2aUc7YRCXgjPk3z7Yqemim5SagZaBy6uMLmMusdseJsmB4MXXQhr5AU4nJYUs4k5CrkSy97YzcSI9rVQcinukIgDbn44FbdurXNKn310wJgb9MZ1ppUB78bdyssyqD19TGYHL0CSgWOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3706.namprd15.prod.outlook.com (2603:10b6:5:1f5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 08:20:23 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 08:20:23 +0000
Message-ID: <9b7cefd5-4906-35d6-ad61-bf7d2ee06033@fb.com>
Date:   Wed, 18 May 2022 04:20:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH bpf-next 3/5] libbpf: usdt lib wiring of xmm reads
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-4-davemarchevsky@fb.com>
 <CAEf4BzaM0SC3D66NC3djt1fsEQcJ-af0-EgPx5UV8YLDLu8ibg@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzaM0SC3D66NC3djt1fsEQcJ-af0-EgPx5UV8YLDLu8ibg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::33) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b596d2c8-6700-494d-2cdd-08da38a7413f
X-MS-TrafficTypeDiagnostic: DM6PR15MB3706:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3706E7C87A67DC0707F5933DA0D19@DM6PR15MB3706.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2w1ID7vcESrz8BasUkPHMBpBUNGSbV2YQRLNWH2FBhoQZLCEoB1ewl0ux4VXLAghjJEuyIj2swuqsrpFicSHwEx0mkY1phv1REKlRqTlqblwx+sxPREuO52xnIz1kq0QZ2bGKtMoCdFtg8L7fSTlBIDbgL4BjU2OUcB1ZJfOA3UmI/845p13u/4ZPuA0B1ofH7e3tAslvm7e0gl2WdAPvdMGrSxJVvg5aFWKk6QX1TRBnglUNcVGOOWyOhchBTJ0YCdiPr/2h7fiXAe7KNWl1kyPay67sFSV4aLJ93oUVyTpLH8kWRXdVL4eEOs4KoBR1WJvRED5wbaaUZbS+HH1/+o8lkwvhtwRviBPc4t70Ia5+FkEL/GEXLrWSOO5bqNX3xIRXHJTYQCr6KDIQOuSrn8qqiKUwM6DLcDtmq4iKbd8uGz7SYVLdSqdQog0TsUuiMkkhsU97bmMSxJZzk8jFaCVPkn5uRSPi8UuSgkGyCP9/ZVy7RIhCG3q+ff09ELqtDtEl13rDSYALjgg4YxOTMLX0NnyH3NhlDK5EWeQ5baOgQBbg5v+uaORGOpYYUnEJCCURYLOAftp/eFNmvObC/riU590IjDEQINbvu1HAtfxVuZFionmsxaNMyRc/AWuKi5wrV5BJN19rp1LteLs1YbA9YP9aaaQ65xDQfygeM0NgfEIkEIAEZTw/rxpy3Kt/OZCb3RzMyimwtfFajRVG6z3SI+2g2fvY5+KKCAXgkC7SwdPZdjPNy1JMZwz7Knj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(54906003)(6916009)(31686004)(316002)(66556008)(38100700002)(8676002)(4326008)(36756003)(83380400001)(66946007)(66476007)(186003)(86362001)(2616005)(5660300002)(508600001)(31696002)(6512007)(8936002)(2906002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhUc0t0cDFlK1V6ekZSTG5YeVgxaEhGc2xkSWVGZEdRWnJmN2l0UkRiTy9k?=
 =?utf-8?B?b0czV29HeTlWWGd1cmtmeTBWaUdJSVhid2RiV0Znak1wV0wySER2M1ZjU3Yv?=
 =?utf-8?B?SHJsbnI3OTJaTUhwd0tmNGcyVWUyeUxoV1BnOGpvUFFLSzJnSFNsYWs3aXdn?=
 =?utf-8?B?U3ZmVUJOc0NxaGhMWHRtV1RVdUV2SHIxNkVkMHdHOUtkT2MvQnZlQ3RORWxn?=
 =?utf-8?B?ZWNsSXZmUVc3SGM3QytzQytGcWJIaHFPSmFiYkY1OCtOVnNVNklFdGdZR2dj?=
 =?utf-8?B?dWszQ2xGOHNqY2hGdGVhM3ludGhwMW1Xb2lBSnpkTlVlTkJ0TUJBSkZRSEJE?=
 =?utf-8?B?MityYm9wSTgvVVNobWo3ZGZmdzhRT3V2d1VNNDZMbkQ2cFFrekNqUFVXaHFp?=
 =?utf-8?B?ZWFyOEp0c3RESG9NQnU1T0UxL3NtWUcxSmlOWWJHSjl5N0N3M0djMit2dXdS?=
 =?utf-8?B?anhYcHI4LzQ4UGI0N1duVVZJSEFYeHd4dWUwYUtYWERIemJzdm1rMnlMZzdV?=
 =?utf-8?B?MDYvVmVmWEJRRHN0eVhMNXJ4TkxmQlh3ZHZuN2k4N3lPVGoxYWNNR0dmcDZ6?=
 =?utf-8?B?VkdlUk9JSkFmWnFBNWUyb3Vqb1pVa2NDd1ovTFgxNGNURlRiWnV5UkRpRjBk?=
 =?utf-8?B?aUFXMHUvWWJHMytPNUZraTNLZy9LYllET3lCVU1CanRKMG9vbi82TWxEbmdj?=
 =?utf-8?B?UmZpcU1KM2hXSzFSWUVyUjU0NjFNTXhUOFd1aUhzMnJxaFArQVpadnFKczZR?=
 =?utf-8?B?Vnh0bngzbUgrQjVVTHd1Njl1ZWdUTTlTaHhld2FHWFFPaHNyQjVjb1Q5cm9G?=
 =?utf-8?B?NlVwMWo4THRwd2xLK016K051SG1uR1d4MEZzRk0rVUtUWEdhbnZVR1c5cXRv?=
 =?utf-8?B?MURROGlEQ2ZFbGVad3dsY1NydVQ1VjdpRzB2ZzU4aDhlcGpQa01lcjM0d0JU?=
 =?utf-8?B?Qk8vcTVSb3lhTk4rWkNnNDFXVFJlZlE1Wkw0WE02NGdkaGh0RytVUW51WDUx?=
 =?utf-8?B?R2lkZjgxRk5KUXlnUnBycC9FQ2E1ckMwVWdFa290d1RwSm5QVEptQnR3OWtt?=
 =?utf-8?B?aktCSGxLdFczL3BvZVV4cE9QYlhqRmczOG5mRkdJV2lraVBzYjVvU3d1bWti?=
 =?utf-8?B?OTBhbkgzSHhMbTQ5T2FESzkyT2xtL1QydGJBYmJwNFA5K256RGNEM0c1Mi96?=
 =?utf-8?B?T1lFOEZaUVpTaktLbUUyS28rVkhjRWpJcERSTTJkZHgyWFZpeFdnMWg3N01S?=
 =?utf-8?B?WitDODRNVXBoSUFIOGs1NTdIZlVMdWFtcHRUSXJNQXZFdTJRMHlUQkw1Yy9n?=
 =?utf-8?B?U2F2ZVVoVjlhRVN3M3BqOGlabHlicEFYOWJaTjVraTNxa0FJOE9BUzhFZFJq?=
 =?utf-8?B?OEJQMU1FOFdOWFE5OEpUajN1WVgxTmdiUExQRzJXY2RUcUU5dGUwNm01MTli?=
 =?utf-8?B?aHM5SHlUQTRhYTFhSkpPSUJGb21uNHZLZUl2MGV6RDFIRVVpankvN0E1NDg5?=
 =?utf-8?B?VHo0NGxqL1FUekxHeVpLRjJ6RXlCVjlpYVZINk8rNExzekpmOE96QlNVNFp1?=
 =?utf-8?B?bE92T2RMdldHMGNpVjZMd1dNVmUvK1V4REJRQkZGZm1wRUNaRHBERTlSK3Fi?=
 =?utf-8?B?VHZmV1lndmkvTUZHaUpZMW14bFZ3Q0JQQnF6NUhTYzdVaUx1amVpK3NYajRE?=
 =?utf-8?B?aVo5RFhPZm1DR0ZFRWwwSUxQNi9ZaTNSa0pJbDROMEY5MzJpME9IWmFlWTdB?=
 =?utf-8?B?cFZiS0dKOVVDTDRVMEtvY211K0F6NlUvUllNUmlKQTg2b0pjVGcweVI0NnIx?=
 =?utf-8?B?THRILzNYYzRXTnR6NFpwWGhJY3ZFN0JyTjZ0RXJ2dDA4U0J2NjM5dW5FS2VK?=
 =?utf-8?B?R3VYRXlEcXdTb1dSTHBLZTRhMmFTQjY4V2hKOFhyMlk0UjVXVEFLM0pCdUQ2?=
 =?utf-8?B?dmo2Q1NTK3NINUtxMHNvT0ZwNkU2aDFJQTljR21rMi9OYUxtcGVXSWx1RVNa?=
 =?utf-8?B?N2NBYTVMOUp2RFBzNXBjQVc2Q0RNd3JxbXlqQlEzU0VKVkZpUXdNNUJrQW95?=
 =?utf-8?B?MDlWSk9vVCtONXBYN1pCS3FhZ3l5REhnbVZkbkZWMUNHNmtxV2UyZzdVa2Fp?=
 =?utf-8?B?UkcvemxDV080NG5yR285eXlKOVNQdUJod3BBQVQzNjFiSE9hWU1LVU9BTDA5?=
 =?utf-8?B?N0dXWVltbHlmTXJIajVpWUR5eER0aVBoQlFGcFVRYzJlOGNDU0lzdzBrUUhv?=
 =?utf-8?B?OWVjNk9GRjl3cTNac05FSk9qY0RNVXdtY05FUXhYRHYvK2RMckxLbUt1TXJT?=
 =?utf-8?B?bEp6UmVUQWpWV1FXZk9hc0hVM3FCOTBncUpUMWM4a2tiakx4bkJtZWpUVC9D?=
 =?utf-8?Q?xzv0pIGTsTDAFCB0IMe0aAQELB2bjXGekaGR0?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b596d2c8-6700-494d-2cdd-08da38a7413f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:20:23.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMsCjSNnrxOoeZsSY2jySIXKtS+MARy0k7yfAjGrzxnjO81UHNZW4HpscdLpK8+s7kE0lO0+c1RTO2JwkGjoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3706
X-Proofpoint-ORIG-GUID: MFbWH3We-NLCnvHqOHmjTGM1etp93_T0
X-Proofpoint-GUID: MFbWH3We-NLCnvHqOHmjTGM1etp93_T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/16/22 7:26 PM, Andrii Nakryiko wrote:   
> On Thu, May 12, 2022 at 12:43 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> Handle xmm0,...,xmm15 registers when parsing USDT arguments. Currently
>> only the first 64 bits of the fetched value are returned as I haven't
>> seen the rest of the register used in practice.
>>
>> This patch also handles floats in USDT arg spec by ignoring the fact
>> that they're floats and considering them scalar. Currently we can't do
>> float math in BPF programs anyways, so might as well support passing to
>> userspace and converting there.
>>
>> We can use existing ARG_REG sscanf + logic, adding XMM-specific logic
>> when calc_pt_regs_off fails. If the reg is xmm, arg_spec's reg_off is
>> repurposed to hold reg_no, which is passed to bpf_get_reg_val. Since the
>> helper does the digging around in fxregs_state it's not necessary to
>> calculate offset in bpf code for these regs.
>>
>> NOTE: Changes here cause verification failure for existing USDT tests.
>> Specifically, BPF_USDT prog 'usdt12' fails to verify due to too many
>> insns despite not having its insn count significantly changed.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  tools/lib/bpf/usdt.bpf.h | 36 ++++++++++++++++++++--------
>>  tools/lib/bpf/usdt.c     | 51 ++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 73 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
>> index 4181fddb3687..7b5ed4cbaa2f 100644
>> --- a/tools/lib/bpf/usdt.bpf.h
>> +++ b/tools/lib/bpf/usdt.bpf.h
>> @@ -43,6 +43,7 @@ enum __bpf_usdt_arg_type {
>>         BPF_USDT_ARG_CONST,
>>         BPF_USDT_ARG_REG,
>>         BPF_USDT_ARG_REG_DEREF,
>> +       BPF_USDT_ARG_XMM_REG,
>>  };
>>
>>  struct __bpf_usdt_arg_spec {
>> @@ -129,7 +130,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>>  {
>>         struct __bpf_usdt_spec *spec;
>>         struct __bpf_usdt_arg_spec *arg_spec;
>> -       unsigned long val;
>> +       struct pt_regs *btf_regs;
>> +       struct task_struct *btf_task;
>> +       struct { __u64 a; __u64 unused; } val = {};
>>         int err, spec_id;
>>
>>         *res = 0;
>> @@ -151,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>>                 /* Arg is just a constant ("-4@$-9" in USDT arg spec).
>>                  * value is recorded in arg_spec->val_off directly.
>>                  */
>> -               val = arg_spec->val_off;
>> +               val.a = arg_spec->val_off;
>>                 break;
>>         case BPF_USDT_ARG_REG:
>>                 /* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
>> @@ -159,7 +162,20 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>>                  * struct pt_regs. To keep things simple user-space parts
>>                  * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
>>                  */
>> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
>> +               err = bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg_spec->reg_off);
>> +               if (err)
>> +                       return err;
>> +               break;
>> +       case BPF_USDT_ARG_XMM_REG:
> 
> nit: a bit too XMM-specific name here, we probably want to keep it a bit

Agreed.

> 
>> +               /* Same as above, but arg is an xmm reg, so can't look
>> +                * in pt_regs, need to use special helper.
>> +                * reg_off is the regno ("xmm0" -> regno 0, etc)
>> +                */
>> +               btf_task = bpf_get_current_task_btf();
>> +               btf_regs = (struct pt_regs *)bpf_task_pt_regs(btf_task);
> 
> I'd like to avoid taking dependency on bpf_get_current_task_btf() for
> rare case of XMM register, which makes it impossible to do USDT on
> older kernels. It seems like supporting reading registers from current
> (and maybe current pt_regs context) should cover a lot of practical
> uses.
> 

Yep. We talked about this today. Will remove.

>> +               err = bpf_get_reg_val(&val, sizeof(val),
> 
> But regardless of the above, we'll need to use CO-RE to detect support
> for this new BPF helper (probably using bpf_core_enum_value_exists()?)
> to allow using USDTs on older kernels.
> 

Will add.

> 
>> +                                    ((u64)arg_spec->reg_off + BPF_GETREG_X86_XMM0) << 32,
>> +                                    btf_regs, btf_task);
>>                 if (err)
>>                         return err;
>>                 break;
>> @@ -171,14 +187,14 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>>                  * from pt_regs, then do another user-space probe read to
>>                  * fetch argument value itself.
>>                  */
>> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
>> +               err = bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg_spec->reg_off);
>>                 if (err)
>>                         return err;
>> -               err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
>> +               err = bpf_probe_read_user(&val.a, sizeof(val.a), (void *)val.a + arg_spec->val_off);
> 
> is the useful value in xmm register normally in lower 64-bits of it?
> is it possible to just request reading just the first 64 bits from
> bpf_get_reg_val() and avoid this ugly union?

For USDT usecase, I've only seen lower 64 bits used. Should be possible to just
grab those, will see if there's a clean way to integrate such an option.

> 
>>                 if (err)
>>                         return err;
>>  #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>> -               val >>= arg_spec->arg_bitshift;
>> +               val.a >>= arg_spec->arg_bitshift;
>>  #endif
>>                 break;
>>         default:
> 
> [...]
> 
>> +static int calc_xmm_regno(const char *reg_name)
>> +{
>> +       static struct {
>> +               const char *name;
>> +               __u16 regno;
>> +       } xmm_reg_map[] = {
>> +               { "xmm0",  0 },
>> +               { "xmm1",  1 },
>> +               { "xmm2",  2 },
>> +               { "xmm3",  3 },
>> +               { "xmm4",  4 },
>> +               { "xmm5",  5 },
>> +               { "xmm6",  6 },
>> +               { "xmm7",  7 },
>> +#ifdef __x86_64__
>> +               { "xmm8",  8 },
>> +               { "xmm9",  9 },
>> +               { "xmm10",  10 },
>> +               { "xmm11",  11 },
>> +               { "xmm12",  12 },
>> +               { "xmm13",  13 },
>> +               { "xmm14",  14 },
>> +               { "xmm15",  15 },
> 
> no-x86 arches parse this generically with sscanf(), seems like we can
> do this simple approach here as well?
> 

Agreed.

> 
>> +#endif
>> +       };
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(xmm_reg_map); i++) {
>> +               if (strcmp(reg_name, xmm_reg_map[i].name) == 0)
>> +                       return xmm_reg_map[i].regno;
>> +       }
>> +
>>         return -ENOENT;
>>  }
>>
> 
> [...]
