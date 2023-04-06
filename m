Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7D6D9E03
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjDFQ4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbjDFQ4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:56:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBA35B1
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:55:59 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336EB2S1020855;
        Thu, 6 Apr 2023 09:55:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZYIyGhXHXTuxyCS6yZ30mhaTg2zIOOh3hC55ZLKg9wk=;
 b=hfj5NiS+NWB3V3N3OPDhXC/Ba9KJnfwyDBTtRzRco0i0NGwUzPoe31y35uXU22ud9CIj
 0+7Z4AQMGEjW51oNbIeI/Oll7TvGXvUkClfczS3XLlT6T1kOrLoaLqKzp7Aa73bFiYIs
 BSPiC6LkCtf/RjBb7/LHnpPiBoC79ezYh8A5WbQnESMZC+00K46f86Xnj4lG5xYc1Kog
 iO5iU2KfOB9nopz7qPl242s7qmHPz8nnksBiwqnoAoRmPYnwKuwKtzXZCrI9ZinUYrP5
 ThPAm3RZObBgW4v2+QbVypi37uc7vSYkHvK0D8sNbk7TW/PwQwYsnlcRLK/XxFsTE5Zt EA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3psym6h7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 09:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkpWhTLhIQh6ZnUmZmtdHPD5jVhGClt839rw6Ft6KCVbD+gAaq6iaaCSYY80ASl5SJTQstIV0lg8DGj8Hq9UWJ7GNNlp5OAGQEp/k1RzJjQbeLjGjsz+Kqj169RwTYXoonv5Tb9XThMd3IL11Yg/50iC+oQv7tfbYhmMF/UOTdmZWsaprFllK93/kH23fPflu0eVf8hJSZYampuEscA+ZPGqc9Ixi3bdOz+CwyoRWTZfDGf7I8wy+IgkqHSqVPHNZk/GyZ/pYD5kbVY6qfmgvOPtUSUlmtaMqcV5kxVTRSHowTHno2wdk4Ceiyuewglf3tEVNQOAL+DHBYE6GMUpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYIyGhXHXTuxyCS6yZ30mhaTg2zIOOh3hC55ZLKg9wk=;
 b=IuKLHJ28s2r4uX9qufN1kzKZh/SOXdgD4jUBG9vlds1GxYPXi76SP7298pDLn9hWNaUX0HNOlAKkAFKjNqNWeFAgLXdSEOFPOf92f9ImpafN22uT8OdjmsBUzShuH3vQK1LLa1omuTLAyfhGK3Q72FgvBMesyE9Xv0owT4h24gSfEkvpIe9qkhOh2trVBO8B1N7AheniRjaMzF6VumkP0czw2PMsWfaTx8fd5wa90Fk7YNi50kehjzXGIKObT0yW3Z7g2V7v4MmiPjGmDGXVsJC32YnqCCHfleSd4mx+buVw7eSQaxm5UG5gE6/yJZs0gPSw7NPKvwQHE6TSrOUGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 16:55:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:55:42 +0000
Message-ID: <4cd6c1b2-5e6a-1655-ab3d-1eda84aa4cbb@meta.com>
Date:   Thu, 6 Apr 2023 09:55:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055625.92148-1-yhs@fb.com>
 <CAEf4BzbhsWVK45OXBSY4tz9v-z-8j7ndMT=3BK4aDvza8FVnkA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzbhsWVK45OXBSY4tz9v-z-8j7ndMT=3BK4aDvza8FVnkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3882:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4e5152-df4e-460d-7ed8-08db36bfc1e7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuW+lR5JdctLPu0z1JZ4Jc6as8H6B/IN9FG+Rhs/nL+0tGwWk2Ng2UDFa53IEA7ubeg/xjG/bnXYIy7zofI/JcIYUxHSpaIeFe2CumVcps8lfY3V7xGhrM7/RDMg4C7W/hviWAcnDUOegDLwXSO1XTTxgi5C/mKjs7GJaU8//xzpH7SxBjknvy8si0zBW8E1SNFCio80u/IHqnP26sLYuWrtqW2RS9d4ipMEBkqky3qqt0KTAMebk8maMumrd3y3j2bvPSDqwninyLcewty9gBIYoNDUNnak9fU7e+Us8NkkA+ew2VJRGITkcuV/v5dWi93q63bT6wBcRMDxQi+ezAh/TqGnOYYIgfDRRohe2K+GK+mt+it9pCqMFkovbJwnl9CH1kzRbrIiqRB0IosD8rIRt7PdEz9jCj2tq90G228Oi1NkpnYJA0GRINpqQDJfCFGyDxorINnHXv5rEtVD8UJnoCMCctXqYHGTfKYNMlwf/jsbnyqzC9sOqc4xvR6+qDhUStRH3v2HuT3N8mRMIU8CaEev7atTdfLp8erqfhlWLgjBh6SOLPzJ61hg6Fg9LpP1IVVFdh7P/uq6/YezeIRAJ0UG207d3swNr55qYGONMnhX4d2kbud5BNdkVBNx8DE2M4XAcXVQYCEIxUGQmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(54906003)(478600001)(110136005)(186003)(2616005)(83380400001)(6506007)(6512007)(53546011)(36756003)(31696002)(38100700002)(86362001)(6666004)(6486002)(4326008)(66476007)(8676002)(66946007)(66556008)(8936002)(31686004)(2906002)(41300700001)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUF4TyszUTcrdXo1L21hVTdyb3NPOE1xWnZLVjRidTRoemkzU2JNNlArN0RX?=
 =?utf-8?B?WStBbTIyT2lnV1ZQVEl0SWFvWG1oakFveFB5UlJQOFhxcW9Bd2VVeEJsQTlJ?=
 =?utf-8?B?TkFUZndXRlpiOUIwM0dsUGxBRlZQS3V6cm1sN0ltbXlQZDVoMjZCdThlaU5K?=
 =?utf-8?B?Nnp3bjVYV0Q5a3JPcWFTVXZZU21ybGlXakJxSFY1TzI0TDZWZ1Nhbk5LcGN5?=
 =?utf-8?B?VlJMdHdBT2d0RjRIUmgvYlFFNGVoaTZlUm9UcjY5cmlCbWJLdlVWbkhoYTNP?=
 =?utf-8?B?Z21mdXFhRllBRkxiS29BZGJ5WjVOaFZtY1l2T1ZGWUsycWgwcEs4STRNY1RT?=
 =?utf-8?B?VVRPbmV4TXM1K25wZSszNjhvSVlLK29nR1BYQnQ0Nnh3RmhXY2cyL3VnOWow?=
 =?utf-8?B?bHloVWk2YTBSUnN3K25nWWJJcmo4aDA3Tncxa1JYMGFlTWFlVXJJZTN4cG9k?=
 =?utf-8?B?aEQ0MExhbXdjMzNVbUtMWnN5TlBhRmxNU0RUcUtqVmh5QkZNWk0vOXVqcUdW?=
 =?utf-8?B?b1pwMjJ3K0tmK2d1VSt2cGFlV2FzcDRLc0g4M3haNmxBVm9SeWt0Y3ZpL2lr?=
 =?utf-8?B?NTRmRE1oTU15aWFDSkFXMDFoWEM1VG9waFhxRlR3NUwxL0RybjlOUE5abStm?=
 =?utf-8?B?NXprNDFJOE9xSDAyc0NERlZORFN5ekdiUVNVU0FOVENDYmZKTHNOVlRmQ1N4?=
 =?utf-8?B?Q1ZpWkdjU1J1eGQrWTBoSXhxcEp5SjJ1MDlxWVVBY3k2S2t5ei9SQzNvQkpF?=
 =?utf-8?B?NEM5NUhrVW94V04vVkhQTHFLdi9qZGZPSW5KTXNzdGVRaU1aOW9RNUkwa1hn?=
 =?utf-8?B?VmtIR1c3Rk1UdkEyMTdERURrWEQzb28vUk00OFNpMFZKUkVEU1JiSFc1SGpQ?=
 =?utf-8?B?Vk9yZzRrVXJQN09uclVyRHk5NFlQUzZCbFBRb1RLZXhud2dUU0tOM2FReGQy?=
 =?utf-8?B?OXlvL0t0dmNDbGNSTm00eHEyRDM2SHVNdUJvRzUrSFcyY0RyZlFPNC9FRjJz?=
 =?utf-8?B?WkZkUmNIV3pjZkc1V21ldzd6dEVmOEZTMXo2SXJnbXZ6N0cxb1BpYmkvTXVs?=
 =?utf-8?B?dExPa3lOOUFLeE9HRCtxZGhwS09VOWJub2tsNDBuOXR4REp6Z293Y00vb3Vm?=
 =?utf-8?B?elJCQmhjQnZkUGgwaHp3NW5YRTBtV0ZhVjMwc0pDVitrU2c0MmNsUEVhOXNZ?=
 =?utf-8?B?OXJ6S3FvMW1lUTVXUm1SbzFQZ3BMbkRqWmVENm95aDl2R1JScDRmUkk3MlNJ?=
 =?utf-8?B?NUJaTHVRRGxNY0phMUZoM2JpUEZPRUxINTlBR3ppUmpta3hYRWh6Mk5wRFA1?=
 =?utf-8?B?eG9ST2I4a3hocDFvaWhUT244TVBVNzJHUmU2WWRyY3h3clVJaEkrNHJ6SHEw?=
 =?utf-8?B?Q1RwajRuY25Fd2pmRXFkZ1RORXExRjcxWHJjdnZQL1NpQm1NYzNQLzA2SGtG?=
 =?utf-8?B?RFJqOG1oT2M4emFMZU1XeXF0ck92NWFPOGFnaGF6eEEzbVkzYkVSTXhLSFVx?=
 =?utf-8?B?b3ZCS3ZnakxxWWFHaXc1MWsyKzkrSVM4czlYRm5PTmlWYkYxK2M1QVZGWkJE?=
 =?utf-8?B?S0hWaklBcEVtVXV2U0ZCVjBtS1NYd2Qxa3BEclo1dkxYTlhDSUJkMlc2a1Vs?=
 =?utf-8?B?cnhpYnBMdlZuakoxc0pzUWNHWnhUeUV3NFNHbUw1MWkrQXpvSWx2TExEMFBZ?=
 =?utf-8?B?QmdKbmcrZjhkUWV4QUN1dWF3V0dXVFZLWVpCQTlYNVVFQ3hnNmdGWWU0a0dT?=
 =?utf-8?B?ekVuRkYyNHhlNGVrbVk3K1hZY09TZXpWSUpYM05ueGNPcmdDVUJFUzVPZk81?=
 =?utf-8?B?RXVDS25abmRGTkFLTVJvVms4ak1KSzlOanlRbkNDUWpHRlVuajgyRHNSeWJ5?=
 =?utf-8?B?aFFEMlhPZFo0bVI4dzlIZEFDTms3WFdnQ2V1bkNXMlF4N2pJTDFZUWFpVUtI?=
 =?utf-8?B?VFc0VGp3UnRKVEJnTFRCOVNHOWRFZWZIVHMydTU3T0Y2RnZaeitUbmRheTFC?=
 =?utf-8?B?THlldGN2cTlwYmw2UGQ1RWdWNHF5NjNBQUlIRXNNY3UraWttZlh4NTFxdHo4?=
 =?utf-8?B?Vi96N2gyVnRNR3lhTkRnYm45MXZ1WXBqK2FCSmYwUDFEalhUcWFlN0NpOTcr?=
 =?utf-8?B?TkVZS1phSzRUZHhPTDJrdUJRZmRsdHZQaysrNkJERGttK3dOM2NXbCt4dUdF?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4e5152-df4e-460d-7ed8-08db36bfc1e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:55:42.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2coNhD7kkIcgd3ig2LUKN6HT7cvP5Eo1xKEgxqEL9hUC6e45HajpSfHRRhoLOfHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3882
X-Proofpoint-GUID: UmDLMf-Fwx8PVPwHLa8bYWdDik4DsFXf
X-Proofpoint-ORIG-GUID: UmDLMf-Fwx8PVPwHLa8bYWdDik4DsFXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/23 3:09 PM, Andrii Nakryiko wrote:
> On Wed, Mar 29, 2023 at 10:56 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> For a loop, if loop index variable is spilled and between loop
>> iterations, the only reg/spill state difference is spilled loop
>> index variable, then verifier may assume an infinite loop which
>> cause verification failure. In such cases, we should mark
>> spilled loop index variable as precise to differentiate states
>> between loop iterations.
>>
>> Since verifier is not able to accurately identify loop index
>> variable, add a heuristic such that if both old reg state and
>> new reg state are consts, mark old reg state as precise which
>> will trigger constant value comparison later.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d070943a8ba1..d1aa2c7ae7c0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>                  /* Both old and cur are having same slot_type */
>>                  switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
>>                  case STACK_SPILL:
>> +                       /* sometime loop index variable is spilled and the spill
>> +                        * is not marked as precise. If only state difference
>> +                        * between two iterations are spilled loop index, the
>> +                        * "infinite loop detected at insn" error will be hit.
>> +                        * Mark spilled constant as precise so it went through value
>> +                        * comparison.
>> +                        */
>> +                       old_reg = &old->stack[spi].spilled_ptr;
>> +                       cur_reg = &cur->stack[spi].spilled_ptr;
>> +                       if (!old_reg->precise) {
>> +                               if (old_reg->type == SCALAR_VALUE &&
>> +                                   cur_reg->type == SCALAR_VALUE &&
>> +                                   tnum_is_const(old_reg->var_off) &&
>> +                                   tnum_is_const(cur_reg->var_off))
>> +                                       old_reg->precise = true;
>> +                       }
>> +
> 
> I'm very worried about heuristics like this. Thinking in abstract, if
> scalar's value is important for some loop invariant and would
> guarantee some jump to be always taken or not taken, then jump
> instruction prediction logic should mark register (and then by
> precision backtrack stack slot) as precise. But if precise values
> don't guarantee only one branch being taken, then marking the slot as
> precise makes no sense.
> 
> Let's be very diligent with changes like this. I think your other
> patches should help already with marking necessary slots as precise,
> can you double check that this issue still happens. And if yes, let's
> address them as a separate feature. The rest of verifier logic changes
> in this patch set look good to me and make total sense.

Yes, this is a heuristic so it will mark precise for non-induction 
variables as well. Let me do a little more study on this. Just posted v2 
without this patch and its corresponding tests.

> 
> 
>>                          /* when explored and current stack slot are both storing
>>                           * spilled registers, check that stored pointers types
>>                           * are the same as well.
>> @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>                           * such verifier states are not equivalent.
>>                           * return false to continue verification of this path
>>                           */
>> -                       if (!regsafe(env, &old->stack[spi].spilled_ptr,
>> -                                    &cur->stack[spi].spilled_ptr, idmap))
>> +                       if (!regsafe(env, old_reg, cur_reg, idmap))
>>                                  return false;
>>                          break;
>>                  case STACK_DYNPTR:
>> --
>> 2.34.1
>>
