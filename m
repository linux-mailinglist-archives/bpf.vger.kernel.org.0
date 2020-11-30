Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9509C2C8AAD
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgK3RTN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 12:19:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387420AbgK3RTM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 12:19:12 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUHD9ud012484;
        Mon, 30 Nov 2020 09:18:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3iYmPYBHlImkJTSyBBsABRdDjv1fbL5wtifAQFxx8CI=;
 b=CLAXo3aBUgKCR1+u7SiX3IZP+vULqM7TcpNcz52eXv2IjYYqzJEFp7CDwmRYO3jxPfU/
 BHMOTVd5x6nRuFRjzgd6gew7VMWndnm4vXZIv/0yRhZdKklA+N8nLopWmcoZvK1BG+Ia
 CdJhPgUOlhIH8JZr5Jg5wJEXKRcs3H46XeY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 354g9ucjpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 09:18:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 09:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKFatuWJaoOmurIt1SGUlLhG+rGtsGmtPuOKcWyz11tJtKu2MVk/L8+eMl9FAWJdmbfiwqunIO8UhnoZ3kvxenMktBmT4JVMbvZVZorAz88fInhyuR725JTediTXqI62LovlIfpfHmK2YlYGanq8SUNyLnNa+KAgXwJcxWjeBJGV8oph5/DPe0llOT7c8EtLjra5J+h84mAu9GSRHdMbapW/mITKydmYx76SqeaiGUfP36LKnCChM8J/oK8xWnL2EflFnAVvdgnW4INN/kJ+vGoKaU5NuyefKKEotIRjz/9O5PKt1rbNJ23hA9vQmH7NQCHH4L2b0Q4pzUbp26wSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iYmPYBHlImkJTSyBBsABRdDjv1fbL5wtifAQFxx8CI=;
 b=GH5quthtAHlId2FKfSHWGskyFzqTlOta0zfS2pZmw2eBLWCuRrg3DW1sgWvvNfYQJvmbtrlrPXPRgGKGtPvSPOZDI48P+zfOdJ4ewcQ5VBq5ll/pLRcAKQOtkFHWuIR9Xrb9/mrCJlytmZ+vDgMJwaywmpjyJ1R1I1KUcKdr5U7k5TcAI6dqFIQcqenxHlkBsbGpmCfroHtzzcm61PefCkFnbZAa4zzwuNW4szfhHkslEVWl7Np0vOnwKUz5E9iwIXMgmcvoyVT8jnCrjUa0XZFm0f5+J6OEXTkTxkiE9LmreDkuS0TPT8lJnIFSNxlHWrCMisFcOvsVTHo+gfJBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iYmPYBHlImkJTSyBBsABRdDjv1fbL5wtifAQFxx8CI=;
 b=Q8JRmX4QekCQAqi5imdubyGnlXTd0PPdKpA3fO5h/ZUWjh65iy33/RN/vur3D9X+aSnTweVtvWuH0IJYaqvtslNFB7q83/gnW1tPymJieK5M66o8zQlkjgYWW8lcXbMyFt40ukMAk3biKwXb2+hzyZbLBHRzZuibudOWrMpMbnI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2565.namprd15.prod.outlook.com (2603:10b6:a03:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 17:18:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 17:18:12 +0000
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for
 atomic[64]_[fetch_]sub
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-11-jackmanb@google.com>
 <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
 <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1dfd2e5e-f8d2-eac2-d6b2-7428ceb00c36@fb.com>
Date:   Mon, 30 Nov 2020 09:18:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5f96]
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::124e] (2620:10d:c090:400::5:5f96) by MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 17:18:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1673778f-cee3-4557-f8b7-08d89553ea4e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2565:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2565C1F9154883DC2C18029ED3F50@BYAPR15MB2565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhWWCnRZh2Y2NFRUoY6wHv1Z5D2Sdpzq6phOog9ABzefLTdL2Aq8sK0mCabdUkgNfVdSongZD9UIkXMLsqL7/LHFdbvE6GgPIk9bhErGg2c1wxthyV7huVyeJ2yeAGZG2yGLUEbNTea5Q/KZ5/rRjjEAcMVlifUBUjq0NaQGr8BAJJfahpkRtOHVRJhh60Ye6LBgX135sHRfPsyA/tvcnIerPlboDAZkIK9y+k2hmwG8IQDXv2UK0l7LjOa3MEHYzhZfc5RhlTcuHmJv5TtK14p3OO8OW3MGsHEmnrjwnqO6TzMf8SNGteynrj92S/uHsYibbOMgg5M7HL2TPOKYxpnJpt0vZkNMLI/MOMZlr9xsXhhWDfjgi7ipwKhcV8QN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(83380400001)(316002)(36756003)(54906003)(31686004)(2906002)(8936002)(8676002)(16526019)(53546011)(66946007)(52116002)(6486002)(186003)(2616005)(66556008)(66476007)(86362001)(5660300002)(6916009)(31696002)(4326008)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFRUZ2JHQlMyaVBZbElrMk5tTGkzR0lBaU50anNIdFJtNFJLQURva1UzYmhQ?=
 =?utf-8?B?bit1ZzA4ZmFLTHJRNmQyY29hQkZoeXFaeGl3ZytYOVdTMHN4R3g4cER3QThS?=
 =?utf-8?B?d3oyTzdmbEtQd0F3MnJVZHJnT2JBMzVJK1BibWVOa2docGtaNzNCREZPdG1I?=
 =?utf-8?B?V0tMNlRUajRpbUUyVm5xckxZbFFoMnJxa0xhQm1zaDVma0J2b3I5aFNGQVVi?=
 =?utf-8?B?SW4vUkF5NHM3azM2L0VQWlZxZDJCTStyN2RzUUh6dXplbU1uRUdtcStIQ2Ey?=
 =?utf-8?B?aVdHaXlKaEdHQ0tzTDlZejhwRlpDSEo3bnN0eHhUeXl6UlBQc3Rmdldib1Ro?=
 =?utf-8?B?WFgzMktKSUphT0dhclJWcmppRHpXeFRqSEd3VGlwY0IyOElVT3ZYd1NRYkVG?=
 =?utf-8?B?Rlh6ZDRyWFZ1dWhJSlRBWkxGK3NmNW9Ha3NQNWxZZG9tZnRJRkhQSWFDUXFo?=
 =?utf-8?B?L1E5Y2FScWtEYmlZdVc1emtZekY3YStBei9HYVVPU0NKeVFsZXBVdXJGWlBB?=
 =?utf-8?B?cURmWDR2cG4zMzhIbXp3NzRxSGhQNjZpbklrdkVmWTdXTll6RjcxN2lFSHRI?=
 =?utf-8?B?TmQ3Q2FrbDlsb2QvbGNtUHI1SVpQWUdvRElMRXBSUkV4WCtXWVUvYjd0MVZG?=
 =?utf-8?B?NjRQTGN5Y0d1cjJBNGVMTk40a1lnUXdUTmtVVnQ4SXEyVHozUk5sZWlIaGU4?=
 =?utf-8?B?M0kxNEhjUjdpS2FaazBRaFkrNUlVVjU0QzVZWWl1d1NZWG4rZ0NGd2QvYndT?=
 =?utf-8?B?LzlXdWtmUTQzQjhsR0QxeEMreThWRHUzZWgwb0ZVZVhpL1NHQS9XQnlCaUVQ?=
 =?utf-8?B?MDlIem92SXQveVlCdXgySG1SK2Rybk9FSEFzcHh1UFJFSDR3NDAvS3pIOFVh?=
 =?utf-8?B?RXNsRVRLYllGL2pQT1d3VDhWSUluWk1sakFYa291L1VWZWpGU2NNZXFNUkp3?=
 =?utf-8?B?akJ6UnlDaXlLeUxzVlp3NWRGbzEyUk5Zb3ZuVWFkQkp6VDE5MHJCZEd0Nmdv?=
 =?utf-8?B?cWJMZlkzbHhEamJ1Z3c3WFFXWjRFNjF4V2hxOTM1Q01OVEZNR1lsbStXVU9y?=
 =?utf-8?B?dGdjUmtuLzJHVDhSZ1B1UUcvLzdacGlrR1lveEFJeDZDMHA4U2ZHV0w1M3NN?=
 =?utf-8?B?Y2lxRFlaU1M3ci9WTVhPekRTSE41cUVlL29qdFhDQytjd25IZ296SnhraTFT?=
 =?utf-8?B?VStiZVFBSE50UmhPRGt5SkprMHprbTNrMlVoblU2MWlySTI1bEVRcjIxb09n?=
 =?utf-8?B?Z1NYUU81SE0zM1JILyswKzhOUnZ5OGJhbHBNQUN3ODFiblRZbjZmZmlBL1di?=
 =?utf-8?B?dFpDVWU1djhsZnRFa0pPWUk0bFBFaG9HMTR2c2FXdUNCbXZKRnhvUkkrVG51?=
 =?utf-8?B?cmNaeEd4ZjdkNVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1673778f-cee3-4557-f8b7-08d89553ea4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:18:12.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9XiH9iiHmhqNl4A1JiaQfaLlvybAi1cFrOrbDjhGwwS5AoBJpd/2lMe7GgstWDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_06:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/28/20 5:34 PM, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 09:35:07PM -0800, Yonghong Song wrote:
>>
>>
>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>> Including only interpreter and x86 JIT support.
>>>
>>> x86 doesn't provide an atomic exchange-and-subtract instruction that
>>> could be used for BPF_SUB | BPF_FETCH, however we can just emit a NEG
>>> followed by an XADD to get the same effect.
>>>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>    arch/x86/net/bpf_jit_comp.c  | 16 ++++++++++++++--
>>>    include/linux/filter.h       | 20 ++++++++++++++++++++
>>>    kernel/bpf/core.c            |  1 +
>>>    kernel/bpf/disasm.c          | 16 ++++++++++++----
>>>    kernel/bpf/verifier.c        |  2 ++
>>>    tools/include/linux/filter.h | 20 ++++++++++++++++++++
>>>    6 files changed, 69 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index 7431b2937157..a8a9fab13fcf 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -823,6 +823,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>>>    	/* emit opcode */
>>>    	switch (atomic_op) {
>>> +	case BPF_SUB:
>>>    	case BPF_ADD:
>>>    		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>>>    		EMIT1(simple_alu_opcodes[atomic_op]);
>>> @@ -1306,8 +1307,19 @@ st:			if (is_imm8(insn->off))
>>>    		case BPF_STX | BPF_ATOMIC | BPF_W:
>>>    		case BPF_STX | BPF_ATOMIC | BPF_DW:
>>> -			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
>>> -					  insn->off, BPF_SIZE(insn->code));
>>> +			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
>>> +				/*
>>> +				 * x86 doesn't have an XSUB insn, so we negate
>>> +				 * and XADD instead.
>>> +				 */
>>> +				emit_neg(&prog, src_reg, BPF_SIZE(insn->code) == BPF_DW);
>>> +				err = emit_atomic(&prog, BPF_ADD | BPF_FETCH,
>>> +						  dst_reg, src_reg, insn->off,
>>> +						  BPF_SIZE(insn->code));
>>> +			} else {
>>> +				err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
>>> +						  insn->off, BPF_SIZE(insn->code));
>>> +			}
>>>    			if (err)
>>>    				return err;
>>>    			break;
>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>> index 6186280715ed..a20a3a536bf5 100644
>>> --- a/include/linux/filter.h
>>> +++ b/include/linux/filter.h
>>> @@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>>>    		.off   = OFF,					\
>>>    		.imm   = BPF_ADD | BPF_FETCH })
>>> +/* Atomic memory sub, *(uint *)(dst_reg + off16) -= src_reg */
>>> +
>>> +#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
>>> +	((struct bpf_insn) {					\
>>> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
>>> +		.dst_reg = DST,					\
>>> +		.src_reg = SRC,					\
>>> +		.off   = OFF,					\
>>> +		.imm   = BPF_SUB })
>>
>> Currently, llvm does not support XSUB, should we support it in llvm?
>> At source code, as implemented in JIT, user can just do a negate
>> followed by xadd.
> 
> I forgot we have BPF_NEG insn :)
> Indeed it's probably easier to handle atomic_fetch_sub() builtin
> completely on llvm side. It can generate bpf_neg followed by atomic_fetch_add.

Just tried. llvm selectiondag won't be able to automatically
convert atomic_fetch_sub to neg + atomic_fetch_add. So there
will be a need in BPFInstrInfo.td to match atomic_fetch_sub IR
pattern. I will experiment this together with xsub.

> No need to burden verifier, interpreter and JITs with it.
> 
