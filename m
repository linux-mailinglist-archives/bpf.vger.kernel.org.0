Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E593A2CE792
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 06:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLDFf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 00:35:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgLDFf1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 00:35:27 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B45YHqM012630;
        Thu, 3 Dec 2020 21:34:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZzUOl57QEV/hnGLdOc85/3cEQaSCUo3vblCcx10I1oY=;
 b=M5ag1hHbgxNN8wlQVerkz5J2avWs7JWfOnPE/dEkKnmJ6LUqke7F9z6jix6XvBLMTX9a
 OslgOnOW/S6OLx8Lp1DCS+kTpLqrcmhPhww/YcownZyjjxLtNIoSr2z3sBbArfBzecf+
 EgGCCVCDEVJdYAsY2DkOn0VNgDoO4Rjq/l4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356fsfmvht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 21:34:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 21:34:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2DGalMtMomCEX3FK4j8JFz2D224n9CVhYFH0bCxuUTJdLCHhlxqQp3dVrw9RaWnNyHznPp2/iwDU9EZeFHBzeE48B+4puUSQ346onoh/nTU7dRYVgCZ465v4VqmRcVuOW3x8nEpFhuYQl3N0ToaAS5+FCCVy7w4Yn9wHfrsBnu9YW9pV2AlRga9V2m3ADCcUgU7k9hKwfrPLNtkmhhmk2p3hH88tJ/NIPzPJoTqM2rvCKfQVeK2LuGtRZTEu9HoWTFLXC6Bnj2+Wn3luN4uvCX65tRAiIRr2URjXh1kPskwJyOcFbLo9phgJhayIOV0Rnto5gSVqTRONHU+mvxpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzUOl57QEV/hnGLdOc85/3cEQaSCUo3vblCcx10I1oY=;
 b=KPtgPt7qOPRb/h2ijVpCgW1ZKI6TqcjBVCOjbq9ingF+c59J0KNshLJyxJd5+t73zS5CaFDgMxc6SYq3Bm5DGgKu13rkeejF+bNBVARa9R5mCWNnzAN4BuKJwUthWDY0E5aIr5wXgxt/sA/J9ERtUjvvPlHfKqOpuGZTyaQKhCMIS3uDEqWPFdtxMf12i9c1Kl32y2VQKWb93WJAywQSJ7sxFNo5hNoxuRDE/vaajQ53XWRCTH8Qer6Te16/n41vZSqxq40/c80K9kVqgiOfpUbZxficEfyoIroQDKViZrW1QlG66ggW8Lmac8QubebMKgs3NTJTnJXKlXHj4PRc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzUOl57QEV/hnGLdOc85/3cEQaSCUo3vblCcx10I1oY=;
 b=M0BFKGmmRQDnlo06tGdF2gteT7Fk4RNpQbHATrru4ThAkb5JqfB82VXcllo/Sc6j9FmCW8KND+D+52whzdhwFrAoNXFhnLjM3tGFyZiVS08+zp1hqs8YQhyEMcV/yamcJ1smyNdSmKcH8x78PcgJerVCwJvMHEgNqzhmEAMv46g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4247.namprd15.prod.outlook.com (2603:10b6:a03:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 05:34:26 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 05:34:26 +0000
Subject: Re: [PATCH bpf-next v3 08/14] bpf: Add instructions for
 atomic_[cmp]xchg
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-9-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <34cf7a6e-4e97-9895-6dca-b38e631599b9@fb.com>
Date:   Thu, 3 Dec 2020 21:34:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-9-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: CO2PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:104:7::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by CO2PR04CA0127.namprd04.prod.outlook.com (2603:10b6:104:7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 05:34:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 578d5b47-eae7-485b-98ea-08d898164386
X-MS-TrafficTypeDiagnostic: BYAPR15MB4247:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4247F5929A03E5AFCB4CD0A4D3F10@BYAPR15MB4247.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9NxnY3kNzyFPIkc6N+YaFS+UNNuTh+GRrl7+/p9rYfeLq+hNQGaJvq61aHUnvgXCKrcOApFZtD98N9rHrDR505XXSnnE81dG63IBB6eEFJdNfUkR7I/PotJy7sv3418Z0R9GAX+ApOEbbEMF9NQqtgZjSkPuXgIJlyNQ/mHl8WpsP6WfK6CWBUBxi5Qfa6xn+ijpWAmj9A4+q4W5wG753AOEiHGJtc3blF+hD+2Z60VL4mFoziEfuQKvC0T9Qbxximt+CCIXmUBqkdsCmCJeWmZvZ/vDzfUAonHiFniQpY2wUDGKQqhoeFCTm4q7gZBajFtqtxuKa9H55EF6s09qJRpHn5hEng6w9CoiXm/6Fgpeiaqiror3hMGw9y3OObUyEuiCTEAm1WVz2RM6rO6Bzlu7yvNJHPlwfm6aZ0gbrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(5660300002)(66556008)(52116002)(66476007)(66946007)(4326008)(86362001)(6486002)(2616005)(478600001)(8936002)(36756003)(8676002)(53546011)(83380400001)(186003)(2906002)(31686004)(54906003)(31696002)(16526019)(316002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFdSR1VrRVpDZFkrNXZMOTRjYlBjTWRqeVpHVmxZTklQRDNvZWJ5alBUYTZa?=
 =?utf-8?B?bnZGc01XWk53TmxUTGU4WDd0R2ViTXFDTElNTGVkUEVVamw4c1VHVFRtdmxX?=
 =?utf-8?B?YU1iNitoenM0QW9YS1JsbDJuU0NLZmt3d09vRDA4VFV4RXhxV3ZZdmRMYlhN?=
 =?utf-8?B?RENENUJhYVdZaE1CdWtZanNaY09sWHRtUmI5UGM5UEJZN2lsRmVQM1A4UXJP?=
 =?utf-8?B?ZmZFOW5jVVV3TnRacWMrem5lL1lzK0ljdm5Da3Judm1LZDQwWmFNTGVIQmpo?=
 =?utf-8?B?Q3JZMzVIMXhMV2NuZzFFbHpYRlNwZWtjNlNTczRBWTR2NS96anF2T1NxL3JH?=
 =?utf-8?B?MXRxVU5JNHVKRmdrL2liUkp4M3YvZXUwc25WSnRqNzB1MTNVYXhtTmV3N3E0?=
 =?utf-8?B?N3FsRkZaWUxPTzNaOTNTS0Z5aU44cncwejBTRnY3OFY0NGxGeklGQlh6YUpF?=
 =?utf-8?B?VWhubHFMbUVGTGRHK2tuZFhBMkVHMGVNd2YwRUxkaWw2b0RsRGJadXhIZmlM?=
 =?utf-8?B?dGNiSys1d1UrdWg5UVNNYnVtaWZLeEp3K3ZRdkZacDFGTlpVMnlnVHN0R3F3?=
 =?utf-8?B?ekZybUVNbFVMTmx1ckw3Sk5mUHF6YXVIR2VDd1VrYmhOTHFBQkNlckVRMkxG?=
 =?utf-8?B?TGQ1Zkd5cVlwQ0xCeDJwOEJ3RngxMmFpOGQ5WDRKdWdiZ2oxeGg2L3hZUlRn?=
 =?utf-8?B?dEc0emk0Q09ldVpDWGJma3IzWmhMR2cxdktIRDRGYk5WNmltbWtvMGw4enpj?=
 =?utf-8?B?MVJlYi9TQnBZSFlMYURPeW53S0FXUGVXM2hST29XMDExaS9hQktxZldlMHJB?=
 =?utf-8?B?dGtNTVdVb1pNVVBBMEpudW1RWG5ZSUEvblh1bTJBeXBHb1IycjEramZSVUJp?=
 =?utf-8?B?azFubDFxSVZpam13VzJDN2tVMTljbzhyZi9oRWp1Z1I2SnI3bWxtck1QdFc0?=
 =?utf-8?B?MnlXZG0vZDV4ZFJzM2NQVlQ2alNkV08vQmFjYkx3b3dLN2ZndDBrL1c2bVJC?=
 =?utf-8?B?S3JWYng4ci9wY1JJMHFXUmhBZko1emJJREZHZ3MxekE0SzhRQ2JVc0w0RUVj?=
 =?utf-8?B?bW90TWpzRGQvb0FxdmZwSHM1WkFJMEtMOHMzcFFNMnZsUVRDVlRHNUFYT3FQ?=
 =?utf-8?B?MWJlaURmTnkvYTFEUWZJWWViMHRJcEtRK2x1Vy9lbTFlZFRhSGxjQjlFZ1BL?=
 =?utf-8?B?TTRvSUZqYkIyTEZnL1A5dEdDMFFkV1Z0SlR3TG1LVUVjRmhSRlVaeit5WC9O?=
 =?utf-8?B?TGRORGJVVkxsMDV0WmxiMFFvZHY2a1ZWNmJZdkVDSGhzU1Y0TVFOaHJ4RHpF?=
 =?utf-8?B?V0VjckdaQXk0YzFzSEN5OWRYQVp3REFRRER5eTNCWDl2SFA1TXF4VGxjb0kr?=
 =?utf-8?B?TXEvSEQzSEFTV0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 578d5b47-eae7-485b-98ea-08d898164386
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 05:34:26.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOZtJrAYvRQJcB44+Pre3S3afqBux3uwSyrMluBPyKBMtrdLUvRRAcAUzZoOYog6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4247
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> This adds two atomic opcodes, both of which include the BPF_FETCH
> flag. XCHG without the BPF_FETCh flag would naturally encode

BPF_FETCh => BPF_FETCH

> atomic_set. This is not supported because it would be of limited
> value to userspace (it doesn't imply any barriers). CMPXCHG without
> BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> an operation in the kernel so it isn't provided to BPF either.
> 
> There are two significant design decisions made for the CMPXCHG
> instruction:
> 
>   - To solve the issue that this operation fundamentally has 3
>     operands, but we only have two register fields. Therefore the
>     operand we compare against (the kernel's API calls it 'old') is
>     hard-coded to be R0. x86 has similar design (and A64 doesn't
>     have this problem).
> 
>     A potential alternative might be to encode the other operand's
>     register number in the immediate field.
> 
>   - The kernel's atomic_cmpxchg returns the old value, while the C11
>     userspace APIs return a boolean indicating the comparison
>     result. Which should BPF do? A64 returns the old value. x86 returns
>     the old value in the hard-coded register (and also sets a
>     flag). That means return-old-value is easier to JIT.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with minor comments in the above and below.

Acked-by: Yonghong Song <yhs@fb.com>

> Change-Id: I3f19ad867dfd08515eecf72674e6fdefe28424bb
> ---
>   arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
>   include/linux/filter.h         | 20 ++++++++++++++++++++
>   include/uapi/linux/bpf.h       |  4 +++-
>   kernel/bpf/core.c              | 20 ++++++++++++++++++++
>   kernel/bpf/disasm.c            | 15 +++++++++++++++
>   kernel/bpf/verifier.c          | 19 +++++++++++++++++--
>   tools/include/linux/filter.h   | 20 ++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  4 +++-
>   8 files changed, 106 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 88cb09fa3bfb..7d29bc3bb4ff 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -831,6 +831,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
>   		EMIT2(0x0F, 0xC1);
>   		break;
> +	case BPF_XCHG:
> +		/* src_reg = atomic_xchg(*(u32/u64*)(dst_reg + off), src_reg); */

src_reg = atomic_xchg((u32/u64*)(dst_reg + off), src_reg)?

> +		EMIT1(0x87);
> +		break;
> +	case BPF_CMPXCHG:
> +		/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */

r0 = atomic_cmpxchg((u32/u64*)(dst_reg + off), r0, src_reg)?

> +		EMIT2(0x0F, 0xB1);
> +		break;
>   	default:
>   		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
>   		return -EFAULT;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 4e04d0fc454f..6186280715ed 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD | BPF_FETCH })
>   
> +/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */

src_reg = atomic_xchg(dst_reg + off, src_reg)?

> +
> +#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XCHG  })
> +
> +/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */

r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg)?

> +
> +#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_CMPXCHG })
> +
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 025e377e7229..53334530cc81 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -45,7 +45,9 @@
>   #define BPF_EXIT	0x90	/* function return */
>   
>   /* atomic op type fields (stored in immediate) */
> -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
>   
>   /* Register numbers */
>   enum {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 61e93eb7d363..28f960bc2e30 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1630,6 +1630,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   				(u32) SRC,
>   				(atomic_t *)(unsigned long) (DST + insn->off));
>   			break;
> +		case BPF_XCHG:
> +			SRC = (u32) atomic_xchg(
> +				(atomic_t *)(unsigned long) (DST + insn->off),
> +				(u32) SRC);
> +			break;
> +		case BPF_CMPXCHG:
> +			BPF_R0 = (u32) atomic_cmpxchg(
> +				(atomic_t *)(unsigned long) (DST + insn->off),
> +				(u32) BPF_R0, (u32) SRC);
> +			break;
>   		default:
>   			goto default_label;
>   		}
> @@ -1647,6 +1657,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   				(u64) SRC,
>   				(atomic64_t *)(s64) (DST + insn->off));
>   			break;
> +		case BPF_XCHG:
> +			SRC = (u64) atomic64_xchg(
> +				(atomic64_t *)(u64) (DST + insn->off),
> +				(u64) SRC);
> +			break;
> +		case BPF_CMPXCHG:
> +			BPF_R0 = (u64) atomic64_cmpxchg(
> +				(atomic64_t *)(u64) (DST + insn->off),
> +				(u64) BPF_R0, (u64) SRC);
> +			break;
>   		default:
>   			goto default_label;
>   		}
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 3ee2246a52ef..18357ea9a17d 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -167,6 +167,21 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>   				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
>   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>   				insn->dst_reg, insn->off, insn->src_reg);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == BPF_CMPXCHG) {
> +			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",

(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)?

> +				insn->code,
> +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off,
> +				insn->src_reg);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == BPF_XCHG) {
> +			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg(*(%s *)(r%d %+d), r%d)\n",

(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)?

> +				insn->code, insn->src_reg,
> +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off, insn->src_reg);
>   		} else {
>   			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
>   		}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a68adbcee370..ccf4315e54e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3601,10 +3601,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
>   {
>   	int err;
> +	int load_reg;

nit: not a big deal but maybe put this definition before 'int err' to 
maintain reverse christmas tree coding style.

>   
>   	switch (insn->imm) {
>   	case BPF_ADD:
>   	case BPF_ADD | BPF_FETCH:
> +	case BPF_XCHG:
> +	case BPF_CMPXCHG:
>   		break;
>   	default:
>   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> @@ -3626,6 +3629,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	if (err)
>   		return err;
>   
> +	if (insn->imm == BPF_CMPXCHG) {
> +		/* Check comparison of R0 with memory location */
> +		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
> +		if (err)
> +			return err;
> +	}
> +
>   	if (is_pointer_value(env, insn->src_reg)) {
>   		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
>   		return -EACCES;
> @@ -3656,8 +3666,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	if (!(insn->imm & BPF_FETCH))
>   		return 0;
>   
> -	/* check and record load of old value into src reg  */
> -	err = check_reg_arg(env, insn->src_reg, DST_OP);
> +	if (insn->imm == BPF_CMPXCHG)
> +		load_reg = BPF_REG_0;
> +	else
> +		load_reg = insn->src_reg;
> +
> +	/* check and record load of old value */
> +	err = check_reg_arg(env, load_reg, DST_OP);
>   	if (err)
>   		return err;
>   
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index ac7701678e1a..ea99bd17d003 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -190,6 +190,26 @@
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD | BPF_FETCH })
>   
> +/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */

src_reg = atomic_xchg(dst_reg + off, src_reg)?

> +
> +#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XCHG })
> +
> +/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */

r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg)?

> +
> +#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_CMPXCHG })
> +
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 025e377e7229..53334530cc81 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -45,7 +45,9 @@
>   #define BPF_EXIT	0x90	/* function return */
>   
>   /* atomic op type fields (stored in immediate) */
> -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
>   
>   /* Register numbers */
>   enum {
> 
