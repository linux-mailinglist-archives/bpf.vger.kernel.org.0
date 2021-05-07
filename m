Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12C2376A0E
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEGSd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 14:33:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52674 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhEGSd0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 May 2021 14:33:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147IPx31023496;
        Fri, 7 May 2021 11:32:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=f4poWmenBk1kDi39JHcvq3MG5cZ49vsQtZHtYYpSmLg=;
 b=po1MHisVsdiPgMrMhRclErl9J/f/PRS3MHeYySu0PNjDV5a0oMWiDNrZvFxH9N3/Atou
 18zPrSOtUWKoG3UXQE7DphFdEuswqU4tIBafGIeGX/VnHGcd9NEBTKdaqhmOzl+L6bec
 gYuLanD76Hqqpcw8MBL8G2SX4vTqNeBPimM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38csptvr8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 May 2021 11:32:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 11:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFaO3wqc2MaDbydB35YjXnrX5WelCngQNzFwv4Wsqd37G+I5B25UgKKt0TDXSRbLlG6ma95FAt6vdsHcSxng0XoLL0ONUjtFX7SlBMT09EVcvwjcWKLbl5q92u/2p/HIjENLvYA1YcTWTGAIjL2v/e64rrACtjeouHYMvaMGmeke3LglJ4s/p5d+7MuZBjPRxFAHaQOMwO0dPcZ7HJ4IDgbxmcG7MtmeDS9gGyIcznozP6kJ7MJag+YaTmtrdl+xwZDXHvzmyMRmK2btoOPlsP3u+ActZ7/ANHzjkSZqsLjRzyGETZaX+nUXMoKHC7/67JxK++hoK56ornDQxsXXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4poWmenBk1kDi39JHcvq3MG5cZ49vsQtZHtYYpSmLg=;
 b=Zr0Wg9lR/4QLgMhPlB/s/HFEpSHvbSLFy7G5nUMi3bmkptQCA+VkjjfbwOyVbuXDZPGE3o+5aAwJmnkbVA7FPoF9F6zC+Fu//xKzPyufJBbyk0dL4iDdFERi8Ana0VcQiay4HuHQLywkzYdvb2pgbiFpl0BTUnzVOK5wO5g+Wfl4ZAXcgO52iqx8QdBRz3c7gw/Z21njKrg4kmIk8+99sPN+w2Oq+mei/1B2sUAq/FWdqvJrQaNBb5wU7JiwLfxX3PlYAQ5gdwVMoPDgMFThWFKGJrAnu41jpSfe9VG8mOYOH8WkBli2Qb4agUO1cYDXmj1/TysoXBNjbhFT6/2qJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 18:32:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 18:32:09 +0000
Subject: Re: Help with verifier failure
To:     Brendan Jackman <jackmanb@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210421122348.547922-1-jackmanb@google.com>
 <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
 <3933ce3c-6161-2309-88bb-72707997ed76@fb.com>
 <CA+i-1C0tV0m+HY1WwivrYE-iouF9b8NGVSXhL_ZmRz6JL36TzA@mail.gmail.com>
 <0da3a605-198f-cd1b-f6f2-7ca95082fd94@fb.com>
 <CA+i-1C0K1-b04-3w32J6CJ18CN=9brddn80zuOEpTjwS=fODFA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <103c41eb-cbc1-5af2-f158-9875adb03d6b@fb.com>
Date:   Fri, 7 May 2021 11:32:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CA+i-1C0K1-b04-3w32J6CJ18CN=9brddn80zuOEpTjwS=fODFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2f35]
X-ClientProxiedBy: CO2PR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:104:3::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::126b] (2620:10d:c090:400::5:2f35) by CO2PR06CA0065.namprd06.prod.outlook.com (2603:10b6:104:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 18:32:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb56ddbf-fbb5-403e-52ff-08d911866c4f
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4223E3C35EB5539DDC56E5FDD3579@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed/8bnh5KVGogEe25Xw5TxtVrmw35+8YuuUEG+D3pudY3em7h23bV2YhCi8BFhbzclXX//Fyu3OURTdnDwApFXf2zC11a+gJzWxvMgB62HIdjmCpxJ2KL6K9+epKHCodzdUadqbrSJaO/g03yn7PV9Uuspst4WbQn7F8VqUM5G0+pOmcWdWpbZ1oJqIN95SsdRjG2FRdj2IVv4+PdoJhpTM5YMGbp8ozaiyykb+Q+8wRdDpbcg80wgLqtisR93WwcjPCZtgmxN3xgWH1VUN1dFmZX4Po+4Ga8kiMqQiTUNJSMHf7d/lW6GMlwwePQBqm8uh+JYdVMObma4TS3uvWGIRhQJPb+SdzkZL+S5RZM/4voXQbvRmToJRYR5EzG7yd2mu1BQ4hdhOmsLVBWt3m70OWoJY94jsxvbyLJiBwE4MB/TNXN8PHocTWUo44PMEMW0y1KifmYM9cxjDApfAsBDlVaP4/77XMSwmf0sNfCK1gqXgfG4JWctPCBJil6Z2LMwBJZIsdcsefCVy3usuLP/ON60ohBKiPnLpoR7SIDsJ50ppU4zpu05Wh8Gs9kIIPOgbGzfgfNILOvdeNdouOZa9qkHEKP7cf8kAB1V4lP1645/kHeZE+IikmceoPXntFJw0R7a2P4gPzJV0/MVLjufO06OC5kgrX6sRfYF8pQa60ZLzrIEQwFA9lr5OS1n/c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(2906002)(86362001)(8936002)(31696002)(6916009)(3480700007)(36756003)(8676002)(186003)(31686004)(6666004)(478600001)(2616005)(83380400001)(16526019)(52116002)(316002)(66946007)(66476007)(54906003)(66556008)(38100700002)(4326008)(6486002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MlArU1JtKzF0NXFlRWFRTkpGME5WcXpZUkIwa25GRENudjJvK1NMUEErMkVu?=
 =?utf-8?B?YjVzRE1sWVdDZ1pSQVB4aXhidkkvSjI2eHhZUGtqdkxBVGlYL0NGcDVsUkdl?=
 =?utf-8?B?bDUrd21ZOTltVjJTV25ibXdCRk1NVE5nSXFxQ3ZDNFBxSG13Y1h2eCt2VE5P?=
 =?utf-8?B?VTEybjNvWEhweEp2bStqZFR4eHZ3MWdBZHBYZHBZSDUvLzUrejJvSythNWxs?=
 =?utf-8?B?K1FZVXZZZDM4WFlHZ1FyeWdIWS96NGNpcGxXVHBzWW1KcU1kY2V4N1FscEVy?=
 =?utf-8?B?b1Y1elYxbjdHVmFOdFV2eXhBRkE2THFjMktHaVRaYm5NZ2hDdFh1bmR5MVlz?=
 =?utf-8?B?QkJSZUUxcFVoU0toRnVDYmlqd2ZFSWFVd1VpaThxVExoaHhOSkxVMXp3MzEy?=
 =?utf-8?B?eXFCczJpM2xSYkN4SnMrSnNGNENRNHJ3UVBPLzM1dU1pdkZ5a1pHM3VwZGc3?=
 =?utf-8?B?Mm00aCsvM1pMODdkTEl3N2ZHYnYxK1ZONWpKNU9ZTTN4cFNpd3h4YnFVenlq?=
 =?utf-8?B?UWRQd0d1dTRyVUxGdzZxQUJGbkNIUzJsd2lYQlR0M0RJWVorMWNBK1RXQmJ3?=
 =?utf-8?B?cU9oeVAwa3BBUTh0Y3JmUnJIak5rN05lY2VFeE1VenJkdnhjRGxZcW1NYWVq?=
 =?utf-8?B?T1pTZWhLVEo0KzBjeEtaQ3lGOXZCSkIzeGlpSXhmcGFXTGpnYjdjeWFxS0FB?=
 =?utf-8?B?VlRCdWlvNk1xSVBERTNacWozNzRkU1U2UUtYMjZwcnFxanNyQzZxWUZ6TzZT?=
 =?utf-8?B?My9wNE0xTFdHcCtiNnk5STl2RWtkYzg3QzBPb3JCTkM5SUFSUDFFdFdubEEr?=
 =?utf-8?B?WWFvcitPZlRPRE5pOWhPOTQ1SVhZSW9MWTh1OHBxZG1HMndyZmtKT0M5MWZU?=
 =?utf-8?B?ZGk4dFFSRHVMV2JveWV0VXhNdXpNbGFtU29hMUhLK0JFcGNPMVRwdGFaWHEx?=
 =?utf-8?B?czU4TnV1YU45WmxIRTh6SEF6TE1SeFZ0U2cxVlc0VXRmdDVHamg5b1NRaGla?=
 =?utf-8?B?RlNUUzVCMXJMTGw1UUcyVE1VakYyeGExUnRDTTNabCtjRE5Gdk1MM3EzRUVR?=
 =?utf-8?B?SlFkdVV0VkhyUVRqQnI0RnNQT0NVcndjL1BjbWk3UGRLUmVGSXdQZU9aVWMz?=
 =?utf-8?B?ZnBOZHhEWGkxZkxrSUFFM3FyY1kxUWdkSUZ3NTdCMDM2MEoxTlJ0TEFNbEhy?=
 =?utf-8?B?WG1XYWlvUVpEY2JtbE5pVFVKQ2NNc1lOUFczZEhzSjA1eFZrTUU1d24yQmZo?=
 =?utf-8?B?S2R5RjJ3dzBKamd3MHQ5MXk3bkZDTkVMYUlrbTZuSG5MV1ZDNzdIS21KRWMx?=
 =?utf-8?B?b1V2RnM2SXFnd2JxTkFubkFUcUJndUUzYmhqSS8vTnd3TEtTRHBDaEpwTXk1?=
 =?utf-8?B?VWtCZlBYWlQxVTZVWjE3cTk0dnE4WHRZRFR0ZE4xUHVMMU9EL2tvT3JGbG04?=
 =?utf-8?B?aUVGOEE3amlBUWhZUisrNzNKejZKN25kMWZGdTEzKzFORGlQbUQ2dE9rbE45?=
 =?utf-8?B?RVFGWjBROHMzdmN6SWdSbEhHUkppVWpyWG5PUERtc0FhYkxrNzhFSGhsRlNT?=
 =?utf-8?B?d3Y5eEtjVEwyY0RQZVlxUkJNekYrdWV4WmppTjBJTEd4c2tmREFSeFRvK1dv?=
 =?utf-8?B?WHVnRW15TE9rL0ZYdC9Jd2dFTVh1WVllM2VTcVZVdkJaL0kwYXN3RHFXei90?=
 =?utf-8?B?T3F5YUlvRDI3cmYvdkNRSTh4UUhHRFV4NkdOZVRFREdIR0RLbXlxRjRjZmZW?=
 =?utf-8?B?SUswaHY5Y255dUdwWDlRSlliL3phMGNtb0lpVC9XU2FERC9RRk5oSXlxK3FV?=
 =?utf-8?Q?qVkFO8AHeNWcKdmOkR83WUR04pwnf9HV6o7bE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb56ddbf-fbb5-403e-52ff-08d911866c4f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 18:32:09.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM8xcNcNtz1agUy50/WMmqj7cnN1bpvtSRPRY90USieJ6Pr7sZrWF9h7B/kb3tMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GCGfWfP_gj5I-tcJ3uQ74Y2x7ALNsp3F
X-Proofpoint-GUID: GCGfWfP_gj5I-tcJ3uQ74Y2x7ALNsp3F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_07:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/7/21 8:05 AM, Brendan Jackman wrote:
> On Thu, 22 Apr 2021 at 16:35, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/22/21 6:55 AM, Brendan Jackman wrote:
>>> On Wed, 21 Apr 2021 at 18:59, Yonghong Song <yhs@fb.com> wrote:
>>>> On 4/21/21 8:06 AM, Yonghong Song wrote:
>>>>> On 4/21/21 5:23 AM, Brendan Jackman wrote:
>>>>> Thanks, Brendan. Looks at least the verifier failure is triggered
>>>>> by recent clang changes. I will take a look whether we could
>>>>> improve verifier for such a case and whether we could improve
>>>>> clang to avoid generate such codes the verifier doesn't like.
>>>>> Will get back to you once I had concrete analysis.
>>>>>
>>>>>>
>>>>>> This seems like it must be a common pitfall, any idea what we can do
>>>>>> to fix it
>>>>>> and avoid it in future? Am I misunderstanding the issue?
>>>>
>>>> First, for the example code you provided, I checked with llvm11, llvm12
>>>> and latest trunk llvm (llvm13-dev) and they all generated similar codes,
>>>> which may trigger verifier failure. Somehow you original code could be
>>>> different may only show up with a recent llvm, I guess.
>>>>
>>>> Checking llvm IR, the divergence between "w2 = w8" and "if r8 < 0x1000"
>>>> appears in insn scheduling phase related handling PHIs. Need to further
>>>> check whether it is possible to prevent the compiler from generating
>>>> such codes.
>>>>
>>>> The latest kernel already had the ability to track register equivalence.
>>>> However, the tracking is conservative for 32bit mov like "w2 = w8" as
>>>> you described in the above. if we have code like "r2 = r8; if r8 <
>>>> 0x1000 ...", we will be all good.
>>>>
>>>> The following hack fixed the issue,
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 58730872f7e5..54f418fd6a4a 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -7728,12 +7728,20 @@ static int check_alu_op(struct bpf_verifier_env
>>>> *env, struct bpf_insn *insn)
>>>>                                                    insn->src_reg);
>>>>                                            return -EACCES;
>>>>                                    } else if (src_reg->type == SCALAR_VALUE) {
>>>> +                                       /* If src_reg is in 32bit range,
>>>> there is
>>>> +                                        * no need to reset the ID.
>>>> +                                        */
>>>> +                                       bool is_32bit_src =
>>>> src_reg->umax_value <= 0x7fffffff;
>>>> +
>>>> +                                       if (is_32bit_src && !src_reg->id)
>>>> +                                               src_reg->id = ++env->id_gen;
>>>>                                            *dst_reg = *src_reg;
>>>>                                            /* Make sure ID is cleared
>>>> otherwise
>>>>                                             * dst_reg min/max could be
>>>> incorrectly
>>>>                                             * propagated into src_reg by
>>>> find_equal_scalars()
>>>>                                             */
>>>> -                                       dst_reg->id = 0;
>>>> +                                       if (!is_32bit_src)
>>>> +                                               dst_reg->id = 0;
>>>>                                            dst_reg->live |= REG_LIVE_WRITTEN;
>>>>                                            dst_reg->subreg_def =
>>>> env->insn_idx + 1;
>>>>                                    } else {
>>>>
>>>> Basically, for a 32bit mov insn like "w2 = w8", if we can ensure
>>>> that "w8" is 32bit and has no possibility that upper 32bit is set
>>>> for r8, we can declare them equivalent. This fixed your issue.
> 
> I just got around to looking into this - spent some time reading and
> realised it's simpler than I thought :) I also double checked that it
> fixes the test with my current Clang too.
> 
> Beyond cleaning up and putting it into a patch, did you have anything
> in particular in mind when you called this a "hack"?
> 
> Do I understand correctly that in this code we only need to check
> umax_value, because it anyway gets folded into the other bounds fields
> during adjust_min_max_reg_vals?

If the umax_value is less than or equal to INT_MAX, if all *_value's are
consistent in the register state, yes, it will be sufficient to
declare the reg is indeed holding a 32bit value in a 64bit register.

I mentioned it as a "hack" as I did not go through all the reg
range refining before/after this piece of codes. Since you have
looked at it and it seems fine. I would suggest you can just
with my patch above plus your test and submit it to the mailing
list for review.

> 
> It seems like the next rung on the "ladder" of solution completeness
> here would be quite a big step up, something like a more comprehensive
> representation of register relationships (instead of just "these regs
> have the same value" vs. "these regs have no relationship"), which I
> guess would be more extreme than necessary right now.

We have to weigh between verifier complexity and whether it is general
enough for compilation transformation. Yes, if you have such use cases,
please share and we can discuss how to address them.
