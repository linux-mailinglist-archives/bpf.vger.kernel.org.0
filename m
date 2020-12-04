Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3762CF095
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgLDPVZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 10:21:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730337AbgLDPVZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 10:21:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B4FDiQ4030335;
        Fri, 4 Dec 2020 07:20:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3i65Qn8NKZ83k4T1MhDTWeDY78sst78m9VzlmEyTMG0=;
 b=O6m4SUpjYDO/ThkYlaznhkqFlsiAaaDa8hJck1D7fpH4FtZFidlLmbnNvaKqlKjYy1cW
 sIMbvtmkjIutavP0aYUJq+mxL0mQP3MT+zv17cPfwVAZH2I1bCcDm7sZXAiEvH45A/uJ
 xnsHv7sf+dMtn9bkYy4DVPInwxJgKjS3yok= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3562mac47k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 07:20:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 07:20:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1neBOxeXjNIIqt2s3ojYy00lYkCmO6nZxuYiR1sB/J4uLgOi4dOHruZ8xyDPtp5NfKChSAhsK1djm8CSVyBUebNh80CpQCsG3bLVGVXJZjoSNRjrDwM1KCWh3Y8utnHkIghVh4cvwAVCWGSMMXW58CxSDbx57sNSIyfqUELR+IGnTikSOFFnihov8VtzvZmOrhxnec2t/2T3rU1cb2gkzDXztZ3NYRIzjamvHOXHyBBFdXwUDs9DGG7MzWZ+HvZh1aLhi8LM3cLgilu8Q0BnN6EdiTTnPJjWp6/YhX06i95ln3oBawys5b57X+V/UJuPSnwthipPfxuF+qG2QNjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i65Qn8NKZ83k4T1MhDTWeDY78sst78m9VzlmEyTMG0=;
 b=W5HQ0DuWq3LeyrksUgqXseWzNvtzRNmFoJSmDcL/6/D09GoYKj0tRsofgosQsQy9pdXIODmfPDTGVLDtRa3r10DmisqR3mew0Mt4zGSBq2pKb4LBsJ6DSe8x+dKpITdScDeQzfBTDQODbuPX3hgfeYim4sRNF9odVmkn2Q2DFVCE8BuuJNuoAuExMDY9WtK0rFRxx9XbLB76Tu8iCKbJ+0f5WvEeID5MFIWGZeE2EOoSYawjsKjyA93zXrPuQV74uh1xSjpjaxaj2z6cju9DyqLso8T5/pGTqWMQYH9qcOPVnZaxTBQtagoB8J20DnVnotaAklyOMeFMlgFzE9XMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i65Qn8NKZ83k4T1MhDTWeDY78sst78m9VzlmEyTMG0=;
 b=M6qT3HczTM4A+SPgZADzZuxsHlfPCt3+w01YmP8Y0XoNBZWNFl0ENr70EtSE6U1WZah+GRFbwR8oLb+Cbji1PPqglu0HNJJU5/d78jF4Xhiwk8flFyeH4RBLtjpYIxb5NLYA8KOXv/ze70U+xvLT65rhRyJkm9dW5M91+qCNogQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 4 Dec
 2020 15:20:21 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 15:20:21 +0000
Subject: Re: [PATCH bpf-next v3 09/14] bpf: Pull out a macro for interpreting
 atomic ALU operations
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-10-jackmanb@google.com>
 <f1d5ec7e-6231-0876-f25d-9dd5da4112d0@fb.com> <X8oBaf4c+EAd8LQE@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4a39dd08-f0ca-595f-1f59-a6acb44f3176@fb.com>
Date:   Fri, 4 Dec 2020 07:20:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X8oBaf4c+EAd8LQE@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fab1]
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:fab1) by MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Fri, 4 Dec 2020 15:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784d476b-d2a5-4eeb-761d-08d898681d39
X-MS-TrafficTypeDiagnostic: BYAPR15MB2408:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24087B01FA1897297975E130D3F10@BYAPR15MB2408.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFRmoFGt1MUEWfNQyKY+ViqKkV9xaDCFLQlEsmtqTGcQmGDq6r+I4DrhsJeSuwq+CAtKsGMoU29r7ejpIkT+wgGvUuAgBhAM0BBlFOy945AQoijR1r8PQVCk7yEFaggj9nNzshZeK8oNwrFUhrygFiiLQs1yArgEBnWJ6hZaoRK2FOVleu+YUcQTzF67yqFonTqcM4qEKJ8w6ngQ21vJETqQwGFoThEePLrUQQnvC0iJXNRSkW1CHTP5dvzecmYngHpIh+vGqcCHecFq8nZ9BLevgrp6hh1sfDbSFlyMgBmezCJjY8qa8TEte6f4/t+Q+3UZ9rXslRjL02XjiNJsk29vib6CnPpkEhiFqOlPFjdSaMc6mNrQc1Y6pfHv84AHcvN1zUwzPqjoNx0MQVLgzpY4PZ8p/c0gWqsA7NTHgTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(52116002)(8936002)(8676002)(5660300002)(86362001)(316002)(2906002)(54906003)(6916009)(36756003)(31696002)(53546011)(16526019)(66946007)(66476007)(66556008)(83380400001)(186003)(478600001)(4326008)(6486002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTRaSXV1dUMzZXJUS2lKYzBMYjlhZ1NDOUd6ZGg2WFhaOFIvWEFvaE1aK1N5?=
 =?utf-8?B?NWgwS0FiZXQrWGFSaGtsSU5IY0FzUHN3MHlRcURZQUJQNzArU1NjNEQ3ZDJx?=
 =?utf-8?B?Y0dhbmY4aEVFK2FEekZ6bnF4VFJ2UjZsUGFWbXFuSlAzNHBia29YeFovWUNO?=
 =?utf-8?B?ZDBVYmtDb2FUMUlkV1l6bTJYbG9FYzExOTVlb1NkZEV2YTk2WWt6VVluYng4?=
 =?utf-8?B?L2ZZVlB3TWNlbittVTZjUkgrbGpaVjRYMWZlZHlyVVhTYy9sSWxIZFc5dFdx?=
 =?utf-8?B?SGtzcTQxT0o5NVVwalJNOEdmR0ZoamZOTlo5RU5sQXhIdWJYTXliS1kzQ2No?=
 =?utf-8?B?UUZLTEU5YmNyck9WcThKYjYxWjNwZEJ6L2kzS1MwNE12SDE0UmJLWnpRZFhC?=
 =?utf-8?B?RjNJQkNIU244R0ZRNlI2YUVzVEdQN2kwZkhETi9lTk01SUZWQTZwRGptV0Vh?=
 =?utf-8?B?ZU5vNjJRSVhhSzhOc1FnbzZWMDJUWFpVMFVqTUtQSllsRUtSY2Q4U2VtNGhR?=
 =?utf-8?B?RkE2TlFodUFCekI4eFlZOEVOMFhzYkd0SlpYMVpvWExWM0FGaU04YlJJdnZO?=
 =?utf-8?B?Z2xWS2VKb1NEb2lGY0JXWWttcWU2K2E4L1NhSjNzelBTMVpSK3NlbXNGdThk?=
 =?utf-8?B?Sjh2RVFGZDZOQ3JQdlZyRThLaG5vbWJzbWxybzFiREd4bWxGZkQ3SkcwdGhZ?=
 =?utf-8?B?eU9QYzFRd0Rib2xTZDljL0hKc2VWWVFpSlQ0ZFlkTElBRFJsbWJ4OEhGV3Vm?=
 =?utf-8?B?Rm1mYmVGdVVOdmxtck8xUXkvMmZIV1hzQ1huckxHbGVlVXZTNWtWUEVKdE9E?=
 =?utf-8?B?SW9ralRxTXlWcVN3UHRja0tJZ3JsMVZjNFFNYjdiUitVdGtSb3h0NXRrSThh?=
 =?utf-8?B?VDN5Qjg4ekxQQklOdEFEOEpob2xUSG00VHU5VjJpL3V1Unl1ZTJYOXBuejR0?=
 =?utf-8?B?RDcyVFVJeW03bVNHUXlxcS9IRUJxNzJSOUk0dDR4UGNUT0N1Z2dBeERnekQ0?=
 =?utf-8?B?aElZU25WU1FuQzlDWkN2T3M1WW8vODRXU2p2MlA3cXJJVGpCczhodjlnajFK?=
 =?utf-8?B?eHR5L2xKZ1NjanhBdlFFc0hJMkJLYkRISGk0TFJOazh5Y0d1ZmUvdlJib2tF?=
 =?utf-8?B?Y2F6WTNBMDc4YlkwRDB6RXJkQ3NaVHpRZXlzN1lYS3VVZHkwMWd3d1Rjdzdy?=
 =?utf-8?B?Qko1b3FHczF6eW1wS3VQZjlERi91ak5qUkorY216cEdHVXhmSGZrZy9PMVJl?=
 =?utf-8?B?aUZrK0xDek5xMnQzbHNXV25NeHkvQ1o0enZjSmFOU28rZHBXcXoyRTZkYk1i?=
 =?utf-8?B?UnVsa1cvcVlwM29nQlpPQ1dnemdRQVJ1VUVzSlBhWmZGQ2NyZmlZZHRTQUY2?=
 =?utf-8?B?czBIZjE1RmxKalE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 784d476b-d2a5-4eeb-761d-08d898681d39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 15:20:20.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCK/smc0y+xZVeAl8a/rtIK26U9phXrADEctXM++ScWbH0ZM40VgyHrn+J6R6GvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_05:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040089
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/4/20 1:29 AM, Brendan Jackman wrote:
> On Thu, Dec 03, 2020 at 10:30:18PM -0800, Yonghong Song wrote:
>>
>>
>> On 12/3/20 8:02 AM, Brendan Jackman wrote:
>>> Since the atomic operations that are added in subsequent commits are
>>> all isomorphic with BPF_ADD, pull out a macro to avoid the
>>> interpreter becoming dominated by lines of atomic-related code.
>>>
>>> Note that this sacrificies interpreter performance (combining
>>> STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
>>> need an extra conditional branch to differentiate them) in favour of
>>> compact and (relatively!) simple C code.
>>>
>>> Change-Id: I8cae5b66e75f34393de6063b91c05a8006fdd9e6
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Ack with a minor suggestion below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    kernel/bpf/core.c | 79 +++++++++++++++++++++++------------------------
>>>    1 file changed, 38 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 28f960bc2e30..498d3f067be7 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -1618,55 +1618,52 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>>>    	LDX_PROBE(DW, 8)
>>>    #undef LDX_PROBE
>>> -	STX_ATOMIC_W:
>>> -		switch (IMM) {
>>> -		case BPF_ADD:
>>> -			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
>>> -			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
>>> -				   (DST + insn->off));
>>> -			break;
>>> -		case BPF_ADD | BPF_FETCH:
>>> -			SRC = (u32) atomic_fetch_add(
>>> -				(u32) SRC,
>>> -				(atomic_t *)(unsigned long) (DST + insn->off));
>>> -			break;
>>> -		case BPF_XCHG:
>>> -			SRC = (u32) atomic_xchg(
>>> -				(atomic_t *)(unsigned long) (DST + insn->off),
>>> -				(u32) SRC);
>>> -			break;
>>> -		case BPF_CMPXCHG:
>>> -			BPF_R0 = (u32) atomic_cmpxchg(
>>> -				(atomic_t *)(unsigned long) (DST + insn->off),
>>> -				(u32) BPF_R0, (u32) SRC);
>>> +#define ATOMIC(BOP, KOP)						\
>>
>> ATOMIC a little bit generic. Maybe ATOMIC_FETCH_BOP?
> 
> Well it doesn't fetch in all cases and "BOP" is intended to
> differentiate from KOP i.e. BOP = BPF operation KOP = Kernel operation.
> 
> Could go with ATOMIC_ALU_OP?

ATOMIC_ALU_OP sounds good.

> 
>>> +		case BOP:						\
>>> +			if (BPF_SIZE(insn->code) == BPF_W)		\
>>> +				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
>>> +					     (DST + insn->off));	\
>>> +			else						\
>>> +				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
>>> +					       (DST + insn->off));	\
>>> +			break;						\
>>> +		case BOP | BPF_FETCH:					\
>>> +			if (BPF_SIZE(insn->code) == BPF_W)		\
>>> +				SRC = (u32) atomic_fetch_##KOP(		\
>>> +					(u32) SRC,			\
>>> +					(atomic_t *)(unsigned long) (DST + insn->off)); \
>>> +			else						\
>>> +				SRC = (u64) atomic64_fetch_##KOP(	\
>>> +					(u64) SRC,			\
>>> +					(atomic64_t *)(s64) (DST + insn->off)); \
>>>    			break;
>>> -		default:
>>> -			goto default_label;
>>> -		}
>>> -		CONT;
>>>    	STX_ATOMIC_DW:
>>> +	STX_ATOMIC_W:
>>>    		switch (IMM) {
>>> -		case BPF_ADD:
>>> -			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
>>> -			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
>>> -				     (DST + insn->off));
>>> -			break;
>>> -		case BPF_ADD | BPF_FETCH:
>>> -			SRC = (u64) atomic64_fetch_add(
>>> -				(u64) SRC,
>>> -				(atomic64_t *)(s64) (DST + insn->off));
>>> -			break;
>>> +		ATOMIC(BPF_ADD, add)
>>> +
>>>    		case BPF_XCHG:
>>> -			SRC = (u64) atomic64_xchg(
>>> -				(atomic64_t *)(u64) (DST + insn->off),
>>> -				(u64) SRC);
>>> +			if (BPF_SIZE(insn->code) == BPF_W)
>>> +				SRC = (u32) atomic_xchg(
>>> +					(atomic_t *)(unsigned long) (DST + insn->off),
>>> +					(u32) SRC);
>>> +			else
>>> +				SRC = (u64) atomic64_xchg(
>>> +					(atomic64_t *)(u64) (DST + insn->off),
>>> +					(u64) SRC);
>>>    			break;
>>>    		case BPF_CMPXCHG:
>>> -			BPF_R0 = (u64) atomic64_cmpxchg(
>>> -				(atomic64_t *)(u64) (DST + insn->off),
>>> -				(u64) BPF_R0, (u64) SRC);
>>> +			if (BPF_SIZE(insn->code) == BPF_W)
>>> +				BPF_R0 = (u32) atomic_cmpxchg(
>>> +					(atomic_t *)(unsigned long) (DST + insn->off),
>>> +					(u32) BPF_R0, (u32) SRC);
>>> +			else
>>> +				BPF_R0 = (u64) atomic64_cmpxchg(
>>> +					(atomic64_t *)(u64) (DST + insn->off),
>>> +					(u64) BPF_R0, (u64) SRC);
>>>    			break;
>>> +
>>>    		default:
>>>    			goto default_label;
>>>    		}
>>>
