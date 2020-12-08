Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA92D204D
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgLHBsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:48:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbgLHBsu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 20:48:50 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0B81h0iM016402;
        Mon, 7 Dec 2020 17:47:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cGDSQdHV4n/tqKb0jC4+TEkB7eVzDNa2+NK1Tj2igdY=;
 b=kKWcQCIHl5pfmd5r7isyemtLygIFMaLN09xMUFVd3UPedmJLiAN/GSHPPjqihYjc/jvP
 4E/fHwbSJ7w/F1WMeEi2P4y7sy+GdM/PJLzDMQl86hYd+99U8zsSVfUCWV7KMbJtHhaH
 U8tgG1ZeJKjoi4m9o7YcAVUhSN5PpWKcr0k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35882fns59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 17:47:52 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 17:47:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXLMfuBWzx7/XeQPobaGz+7iIOuoHnDFX4ypg1zOSc/OM65bzQjXSLTJPz8qbBIT1XWlu3yQiJ/n1raBCFO7pq7Xb77sw7W4xJTS825oAwZqzjeiqhhqsR8BTCMTHnFvRJ3mmHy/j2K6ZWg2s57yMiAphc0CumBhV53aG3BuS4GXiNRkbV5GlzKHTYfLKoWn4w6bhOOS0pI38oF/gMThmoOP3kHCdqlXoI0kyo+p1eWMd6WmswTAf9qQeTQ2HaYgK+fsvXQOLx8kCBj8zSJX/8ztGAZz8o6IQ0DZmEp6UV/iBu01g9PxbFIu+CM1UdXDnpX4Lm1K7kPW9OXSV7iI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGDSQdHV4n/tqKb0jC4+TEkB7eVzDNa2+NK1Tj2igdY=;
 b=RDGkI6PiZLSV6F91sPJ6KRjpdqjqK9ZUi/0kiCDt2eAoqMszUcAxO4AeZm0YChSzjI1lPigZVKR7VIbTwxf3m/5EAGvCsLe1nDDPMuhfyVzKrIOKf9uGo0o7LpMOEvYFmyp5UjqQOLwINW4aTzOV239ZJ8kiOHu94EasRqC16n9mzFhFT2clt9S8zuYsdKkdAv/rB0oBESwtBsqSMbGa4DSfblGyBSwOq419V+srXpxI0Pro1Zd+vEi2N+ekJhltqeFvjbpWNwJXDuFi7MN1k1+6oVv0LHR0BnsT+Tjy4w64BDiMxvPJI7EVKmVIjGR/AnUtT6j6+czWhAIWeD02Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGDSQdHV4n/tqKb0jC4+TEkB7eVzDNa2+NK1Tj2igdY=;
 b=TZOKNwH6/KhyUbKiYhvYuG73rbk8azcNTVadWdck0d4tDLDr1BPIztP4pyhAp2y90s0qK7u/l5yyAKooO4SBiiNp4MivFczDpBC3EC7ehmzQgh0Jrz3ZAeqkENhexjTzMKGTbqx4F70hAfC5KOA0Bq157xGTPa/lpLoCb7iFShc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 01:47:49 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 01:47:49 +0000
Subject: Re: [PATCH bpf-next v4 09/11] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-10-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3d8192e2-6167-bbd3-e23c-ef7a4e8238c1@fb.com>
Date:   Mon, 7 Dec 2020 17:47:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-10-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ee04]
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ee04) by BY5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:a03:1a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19 via Frontend Transport; Tue, 8 Dec 2020 01:47:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f399ca-5b67-405a-9617-08d89b1b4517
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2646E70C5A5836D9F0A01792D3CD0@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeTSOK4MnlFSRK2dpMwTcfc6YBNUgXn/0MGnydyejmcHv0VZWBIcnvEMAMRuO+DZgy6i5pufQ18Dm7ofPHAzjpundV9OqmbPGzqvWXHufwtsD+NeAfGNCdwQJfX1kIiifRHNI6MZbYQiAAnT4Rm+KqSj2//CPLBr4A4VbcF5wMi2Oq1BJo21RWbUWAq5I8MvPJGOJPBgZoonBw+GDvm5ExqNxcFDNGTpojMvnOSYhx2DChwGus1Rutz8AGk+igunjJ+cu/OVz0bbst4f+pTrXNQQomS0QU/E4xQOKSaxemLoBOKmUFCqGLXVyPsU9L+snRCUDuxt08VUboebv9TuAMrF5pCWZg4SduTr7saKBlIV1lJ/qhUEioBHBEB7BrBjT/V/QouE2CycO3x+FI32Xuk16UN/adlBNbQz+MTuOqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(52116002)(66946007)(66476007)(8936002)(66556008)(5660300002)(2616005)(2906002)(8676002)(36756003)(53546011)(316002)(4326008)(186003)(86362001)(31696002)(6486002)(478600001)(16526019)(54906003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MWo0SklsTzVHSWZHSTl0N29LdjdJMExxZjlxTWNaRjdhMS9naVFOdFg1VHNu?=
 =?utf-8?B?QjRMN0ZVbXRWdm5iSnhVOEkxTDhMYm5jK3RoeEZGdXJodXZTUEJEaEpQMVBj?=
 =?utf-8?B?ZnhFNnJHeVB6VkV2WUJ0MXFXTlQzdTQrRzg2Y2xUd1hIb3BXb1dzNkNwenhV?=
 =?utf-8?B?NGw3L2kzOUtTU2JYZlNJTWdiQXZRbzQ5b0sydDlNRitJVVNqYllkZitTaUM1?=
 =?utf-8?B?bUZDNjJKdDZ1TkZrSEpNQVJQK3RDbnE2TTJrM3V6MmcyaVFLM2YwSTczVVN3?=
 =?utf-8?B?T3BpdFp3cXlIUGs5endubnJWYTRkbWd6YTI1Q3JvbFJ1anMvTzJadWxtaFRY?=
 =?utf-8?B?Y1VKZVQwTmhWcC9jenF5VWFOcDRZTkFXWnpQYWcyTFNMdXZRdFRDUmRSY2FZ?=
 =?utf-8?B?bCtJcnZ3U2p6MXpHMlNjUmR0UDZ2OHRoZlZvUVl1dkVUZDNQWDl3MjZUcXhF?=
 =?utf-8?B?OEJVZ1JLdE9pV1JBTlJRSlUrM3Fkb3VPZ3dmZm1CVGNTKzhUTW1aZjc4UU8x?=
 =?utf-8?B?L0tzTEFwN0NSUTVucWZmRlo4WXVOQW5mMkgvRkFrRUgxNTZ0eXNEYVE2dXRv?=
 =?utf-8?B?UU43ZkFOZkpKb3dOb05qbWRleTVOK3EyM0VvNjBNQ3RGWk1WSCtROEgrVjJ6?=
 =?utf-8?B?Rk93Y2prM2twajd2VmVNZ2F2ZVY0RGlRZnFFRko0SzNtK3A0RnhJZEdrajFQ?=
 =?utf-8?B?V1Q0SGJiWjEwVlZ2MUZLcDJ3VzVCYkxMRHU3SisxOTk1YVduRitlU2M3aVFL?=
 =?utf-8?B?T0pERXhueUV6ZitlTWQwQ1Y0NFlBWEtINldwMisxZWlKNFlqQkd4Y1J2MS9S?=
 =?utf-8?B?YTVyUVQrNEVhYnc3aWhNR3paN3oxSkRodjA4MlNYQWdMN2Jyb3RKbktLSjhh?=
 =?utf-8?B?anFoSnNvM3Rwb2JPTWVjYmxIZGN4UmdWYnltcmJMWnROejJVU3pwZVZZcVpD?=
 =?utf-8?B?Z3NXUmE3UDNQbERTZytWREprM3JBUHA4S0M2RnR4K25MWndMZXFmVGR1T3Np?=
 =?utf-8?B?TTFKaVQvYVdWeTJONzJYRjNqMFNMc3RFc01aR2hsOGh5RW1qaGwyOFlIK1I4?=
 =?utf-8?B?bUFDSjE4a2ZtM3J2Y21Ba296NjdrVG1vQ0NjRFJGLzdsMnBESmRyL3lzaFFx?=
 =?utf-8?B?Z0dOT3RNbG5udFVHYVYwMVdJa0JPTmFFMnZKK3RJSGFtVnV4enBqeGhZV0or?=
 =?utf-8?B?dXgzZ1JSQlFUTTR4emNveGdoVWdaYUQ3UU5VZ0pRNDY1dG5tU3h4MEVZZXhi?=
 =?utf-8?B?VGlDSkl4Q0RVbDkyb0JMbWVEOXZTeE9ORWhrS0wveEhzQW9IWWZFTndSZHU0?=
 =?utf-8?B?dmdsRVB0WUdjeHUzSytjUHVoeWkyanJMbFZhckZqWmdKdURHQlF1N3E0ZGtr?=
 =?utf-8?B?L05XQldKcEF3T2c9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 01:47:49.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f399ca-5b67-405a-9617-08d89b1b4517
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISgSNafLZlG4PAVIrWr8ZaE3qpkedWSabJE8jeaUu0dhdsohvpzBTqa46Vi3YloL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
> This adds instructions for
> 
> atomic[64]_[fetch_]and
> atomic[64]_[fetch_]or
> atomic[64]_[fetch_]xor
> 
> All these operations are isomorphic enough to implement with the same
> verifier, interpreter, and x86 JIT code, hence being a single commit.
> 
> The main interesting thing here is that x86 doesn't directly support
> the fetch_ version these operations, so we need to generate a CMPXCHG
> loop in the JIT. This requires the use of two temporary registers,
> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c  | 50 ++++++++++++++++++++++++++-
>   include/linux/filter.h       | 66 ++++++++++++++++++++++++++++++++++++
>   kernel/bpf/core.c            |  3 ++
>   kernel/bpf/disasm.c          | 21 +++++++++---
>   kernel/bpf/verifier.c        |  6 ++++
>   tools/include/linux/filter.h | 66 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 207 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 308241187582..1d4d50199293 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -808,6 +808,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   	/* emit opcode */
>   	switch (atomic_op) {
>   	case BPF_ADD:
> +	case BPF_SUB:
> +	case BPF_AND:
> +	case BPF_OR:
> +	case BPF_XOR:
>   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>   		EMIT1(simple_alu_opcodes[atomic_op]);
>   		break;
[...]
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index e1e1fc946a7c..e100c71555a4 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -264,7 +264,13 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>    * Atomic operations:
>    *
>    *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> + *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
> + *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
> + *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
>    *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
> + *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
> + *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
> + *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
>    *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
>    *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
>    */
> @@ -295,6 +301,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD })
>   
> +/* Atomic memory and, *(uint *)(dst_reg + off16) &= src_reg */
> +
> +#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND })
> +
> +/* Atomic memory and with fetch, src_reg = atomic_fetch_and(dst_reg + off, src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND | BPF_FETCH })
> +
> +/* Atomic memory or, *(uint *)(dst_reg + off16) |= src_reg */
> +
> +#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_OR })
> +
> +/* Atomic memory or with fetch, src_reg = atomic_fetch_or(dst_reg + off, src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_OR | BPF_FETCH })
> +
> +/* Atomic memory xor, *(uint *)(dst_reg + off16) ^= src_reg */
> +
> +#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XOR })
> +
> +/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(dst_reg + off, src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XOR | BPF_FETCH })

Use BPF_ATOMIC macro to define all the above macros?

> +
>   /* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
>   
>   #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1d9e5dcde03a..4b78ff89ec91 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1642,6 +1642,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   	STX_ATOMIC_W:
>   		switch (IMM) {
>   		ATOMIC_ALU_OP(BPF_ADD, add)
> +		ATOMIC_ALU_OP(BPF_AND, and)
> +		ATOMIC_ALU_OP(BPF_OR, or)
> +		ATOMIC_ALU_OP(BPF_XOR, xor)
>   #undef ATOMIC_ALU_OP
>   
>   		case BPF_XCHG:
[...]
