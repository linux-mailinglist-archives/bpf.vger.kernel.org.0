Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DCC2CE83B
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 07:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgLDGnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 01:43:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgLDGnZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 01:43:25 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B46U2LJ029454;
        Thu, 3 Dec 2020 22:42:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SXjYDXb3ROXNRQiSZgdDH6PSn1lec5JuUQ2XOrYhPtY=;
 b=bOfniHGMCGIjb9/LvOzyAqCM/hDGjlMILEU4dk/t3vqJddC3RoTxMaTppY/uYlq4HUhY
 eWG4HGHTb9508FlZgbIJk+SkkOYd8wUq03Tb3wS432rRtpQebF5hQiGE2zvEw4za0egy
 99qelrhkWmCv5oBGTJjbBd377tydF0/NQeA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 357682bs38-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 22:42:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 22:42:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8OnqFQbU1Sst7eofWR4Vsz2uhf59aaEVApDSazNDmATeVYGNnoTilmEjeQ8iJBwU7o7elFTQD/UCOTu9phjwTO/Q7+3qMGoOzBbfP0hzbtoK5CxgC2zD7uyRwTsj3tbpzMXJtzViXOyV+qF8MCgjIljzVeTDAaRnugnwbhzhuJJ7VSoesrPuaILwCuJBAUA4UeLrhQ5kt2as0bej6LOIc71KNgSy2HGncDzaAbFxelfr8deCWz/B6XUJUxki3phU65WhK7Scq6jIfI3w9PuqDOved9o7VV0SIoMxpwfe21vw4+7GYKNVfolaCdGBaNYg2TC3YcjfW1LJAoiYJhkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXjYDXb3ROXNRQiSZgdDH6PSn1lec5JuUQ2XOrYhPtY=;
 b=Hqs4U/Z4gSLQxElk7uVP88MNfPdClmVgUMhALwy01+wXrqrZKmUDV1oA2gBE/Q15/vQuL9r34JwV2ssYp4GmYX8e27t6mUHKSGbkYAZ6jeovhiVZpkfbGq8wjt+x3plawlvJcyh+SG97tEhrNjY3Sxeqc7VlPaFK7DKW50WVjQemcxNE8sg4wV4WCTyyOAGivSSvZt7iorWh6Vw4x192r0JO5F6OLYXeuVHyPSTJ1dqmQHogP1JyFTeEBCjookFoChsnYZSs0/0EuAN60hU6PNVWte3i5+jwC5f2Ip4XBvDaHviIB0iUsojLfhzLJitGrgRFJbvRMDAAWKMPuuLOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXjYDXb3ROXNRQiSZgdDH6PSn1lec5JuUQ2XOrYhPtY=;
 b=BdMLwWpSSBbzTu3qkC7/gnK0J/Li+NoiKpVv2HXJW3LIwC6ZppYmHal9uZ9k+1AmRJDwNhocOWJuARriKUWEs4kTvPW7ZZUcK88oSp+7Vf0j7hWAkdydfcg9XmIXse3YqfKJa/NcYhcWl9sGe7X97Ayr1fM5BcE3TLfQu3HsACg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 06:42:22 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 06:42:21 +0000
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com>
Date:   Thu, 3 Dec 2020 22:42:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-11-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1dae]
X-ClientProxiedBy: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:1dae) by MWHPR1701CA0018.namprd17.prod.outlook.com (2603:10b6:301:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 06:42:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3971a6bf-8c77-491c-7221-08d8981fc0b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26948A405A0A213B514C889CD3F10@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:38;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD5EvIM9xy4uDowCnE4Yj/VJsieZZ0Wmm2qhwX183yUZGx4uhdIGwCCn6+OXSgqy6UkGPzmAJu9LzwmqHMAh4MHbro+drndYFm32I2/Mb9400+HgCtV31q2msyO6l1fz3b0fsHyOcknHjSiWQjOkEC6P7SNMawxnx4/lJdD688ASRWoFAPDf+thpfp2piV7KOju1V0h/Gdl8uXa4/F98kNYyPZ3kzC92B2oTWajMEakVJeELCcMfmu3aMc9n30A5TSrhkjmqfqw2YUcdzi5DJQoWG9Tao+QaaHClqu0tpghsojTg4nP3O70ZvBa5/+DUmkrILMsmjhFhlq69kcI8dMKiDcXrg+JPfI/gQW+7b5q/dx1SnXyZd9054UxJRJyMBw2vVJjPYT9iwkk+agdn1QgfsUVL1SN83hEI2vI/Dz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(31696002)(66946007)(5660300002)(316002)(31686004)(54906003)(86362001)(30864003)(186003)(36756003)(66476007)(16526019)(52116002)(8936002)(478600001)(53546011)(2906002)(66556008)(83380400001)(2616005)(4326008)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0ZKalFOUkdZeUxTZlJXd21OUFVDY2FiRlFOQy96cEpBL2RHSmpSUWFtK1V0?=
 =?utf-8?B?eU1PL2o5QS8wY3N0dlY1YmNYVGtFakhERFFDNDJKVTl1OEU0dEg4MldocmFO?=
 =?utf-8?B?QTY5TElDMCtLMU5pcExsenZ3UWJxc0Y2N3I1TW5HOG9ENERtdFlkRXNzZnRh?=
 =?utf-8?B?TTlLMGNrVVBZT1J5c2t6eWRRMkJTLzY1UllMY2tNQ2lZdHNRcnRYRGJKSy9Y?=
 =?utf-8?B?WnR3bGdGZ1kxVTlEZkNibHdmSy9TdDBpbUNDT1NSSXBES3lLMnZCRGlkOUlH?=
 =?utf-8?B?V3F0N1JYMUxQcjdoWVUydVhZVVNNR0hrK2FONlB0L2Z5aFNYZHowUlE2bVFU?=
 =?utf-8?B?QzVoVzhaUFlCMEFsU0tLdml0WEd5bUtiT2o2WlU5V3ZWeDg1MmxlSXJzeCtu?=
 =?utf-8?B?TkFwRE9ScnFKU0RGWWRBNnpZdzJRRzlPWlRXQ003OXYwZVNITG5KTkh0MTM2?=
 =?utf-8?B?M3dFeVJCRkV1UjRyZFV4Mk8vejFUV1BQSXpSTDJYV3lFalN2eDVwU1kwNWE2?=
 =?utf-8?B?VFVUT0NwM3dGNEJIcDRkalF2MllxeTBhaE83RnJNQmlFOU1HTmZSdm5neUJt?=
 =?utf-8?B?S2QzZ0JIYWIrK0JYZXFLQTJITU1QTW9Dcmp1MEs4bVJPbnEveldBbFE4RW1U?=
 =?utf-8?B?Q2NYeGRGNEFpRTZBakhDUElsWDY0SnFtY1pRbDhZUk56N3JoNkxKaEhyM0tZ?=
 =?utf-8?B?Sm9KMDJOV1F3eGl2aGVjajNpR2ljZ0hra1ZYN2Jna3RNcVYyVHRIbm5ueWtO?=
 =?utf-8?B?aG5UbHl3aDVPcDNNWlh3WWUvcG4xaUlCKzFYcFlwM0FQdlhwL3hDbU1Ob212?=
 =?utf-8?B?dXdHZWRBbEVpWnU4OERKZVRydmVaWG9ucVdHc3hBVzJST3d1WG9OZEFjTWdE?=
 =?utf-8?B?T2dGUWtaL0JZRXliSW82SkJxQTBJdm5tTHRPUkRlKytaYXBNMXJFcm9rczRa?=
 =?utf-8?B?QjlIMi9oY2dEbm5Ra0NUUGF3WUNSbWlSalVmQ0J1bm9ybWNEdmFnWEtJV2pj?=
 =?utf-8?B?YkppRTh5bXU2ME5ScVhXdnNZK2NHL3lQNmlXZlNSYTFBcE1rY0hnclV2MndZ?=
 =?utf-8?B?NGpLaTNlQjJtMGQ0eVR2UUVzTnNUYVJWcjBuLzFRV21yRURHenk4akhCdXRT?=
 =?utf-8?B?ck9VUnY5ejVjcnh0M0QxYWdtRXA2NG9hZU9NUWo5T1VvVHNFZ3dUelp5TU1G?=
 =?utf-8?B?eWdLK1FjQWd1UjNGTk1TRENtendSU2dTRnhibkxRUmlvc1MrSUpJdTZIRFQ1?=
 =?utf-8?B?WnpVaVFGWUNpcnF4MTVVM09UdnkzZW5Zc09LZ3RrY1ljam92K09BVUpPY2Rv?=
 =?utf-8?B?UFlUZ05OMFFOZlRiM1NOSXV6OG9PUjlOMjZVK3dEMXFFc1dKY3RjRDRZMmg2?=
 =?utf-8?B?bUMzcWJoSTNiUVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3971a6bf-8c77-491c-7221-08d8981fc0b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 06:42:21.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9fAE9zw4juy/+TqZhbDRaT5xH4OSD3MePIPBlQRao3doWaspy4KcD9dd1RkolCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
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
> Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
>   include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
>   kernel/bpf/core.c            |  5 ++-
>   kernel/bpf/disasm.c          | 21 ++++++++++---
>   kernel/bpf/verifier.c        |  6 ++++
>   tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 196 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7d29bc3bb4ff..4ab0f821326c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -824,6 +824,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
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
> @@ -1306,8 +1310,52 @@ st:			if (is_imm8(insn->off))
>   
>   		case BPF_STX | BPF_ATOMIC | BPF_W:
>   		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> +			    insn->imm == (BPF_OR | BPF_FETCH) ||
> +			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> +				u8 *branch_target;
> +				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +
> +				/*
> +				 * Can't be implemented with a single x86 insn.
> +				 * Need to do a CMPXCHG loop.
> +				 */
> +
> +				/* Will need RAX as a CMPXCHG operand so save R0 */
> +				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
> +				branch_target = prog;
> +				/* Load old value */
> +				emit_ldx(&prog, BPF_SIZE(insn->code),
> +					 BPF_REG_0, dst_reg, insn->off);
> +				/*
> +				 * Perform the (commutative) operation locally,
> +				 * put the result in the AUX_REG.
> +				 */
> +				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> +				maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
> +				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> +				      add_2reg(0xC0, AUX_REG, src_reg));
> +				/* Attempt to swap in new value */
> +				err = emit_atomic(&prog, BPF_CMPXCHG,
> +						  dst_reg, AUX_REG, insn->off,
> +						  BPF_SIZE(insn->code));
> +				if (WARN_ON(err))
> +					return err;
> +				/*
> +				 * ZF tells us whether we won the race. If it's
> +				 * cleared we need to try again.
> +				 */
> +				EMIT2(X86_JNE, -(prog - branch_target) - 2);
> +				/* Return the pre-modification value */
> +				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
> +				/* Restore R0 after clobbering RAX */
> +				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
> +				break;
> +
> +			}
> +
>   			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
> -					  insn->off, BPF_SIZE(insn->code));
> +						  insn->off, BPF_SIZE(insn->code));
>   			if (err)
>   				return err;
>   			break;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 6186280715ed..698f82897b0d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD | BPF_FETCH })
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
> +/* Atomic memory and with fetch, src_reg = atomic_fetch_and(*(dst_reg + off), src_reg); */

src_reg = atomic_fetch_and(dst_reg + off, src_reg)?

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
> +/* Atomic memory or with fetch, src_reg = atomic_fetch_or(*(dst_reg + off), src_reg); */

src_reg = atomic_fetch_or(dst_reg + off, src_reg)?

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
> +/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(*(dst_reg + off), src_reg); */

src_reg = atomic_fetch_xor(dst_reg + off, src_reg)?

> +
> +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XOR | BPF_FETCH })
> +
>   /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
>   

Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...

I am wondering whether it makes sence to have to
BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
can have less number of macros?

>   #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 498d3f067be7..27eac4d5724c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1642,7 +1642,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   	STX_ATOMIC_W:
>   		switch (IMM) {
>   		ATOMIC(BPF_ADD, add)
> -
> +		ATOMIC(BPF_AND, and)
> +		ATOMIC(BPF_OR, or)
> +		ATOMIC(BPF_XOR, xor)
> +#undef ATOMIC
>   		case BPF_XCHG:
>   			if (BPF_SIZE(insn->code) == BPF_W)
>   				SRC = (u32) atomic_xchg(
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 18357ea9a17d..0c7c1c31a57b 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -80,6 +80,13 @@ const char *const bpf_alu_string[16] = {
>   	[BPF_END >> 4]  = "endian",
>   };
>   
> +static const char *const bpf_atomic_alu_string[16] = {
> +	[BPF_ADD >> 4]  = "add",
> +	[BPF_AND >> 4]  = "and",
> +	[BPF_OR >> 4]  = "or",
> +	[BPF_XOR >> 4]  = "or",
> +};
> +
>   static const char *const bpf_ldst_string[] = {
>   	[BPF_W >> 3]  = "u32",
>   	[BPF_H >> 3]  = "u16",
> @@ -154,17 +161,23 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>   				insn->dst_reg,
>   				insn->off, insn->src_reg);
>   		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> -			 insn->imm == BPF_ADD) {
> -			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
> +			 (insn->imm == BPF_ADD || insn->imm == BPF_ADD ||
> +			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
> +			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
>   				insn->code,
>   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>   				insn->dst_reg, insn->off,
> +				bpf_alu_string[BPF_OP(insn->imm) >> 4],
>   				insn->src_reg);
>   		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> -			   insn->imm == (BPF_ADD | BPF_FETCH)) {
> -			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",

(%02x) r%d = atomic%s_fetch_add((%s *)(r%d %+d), r%d)?

> +			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
> +			    insn->imm == (BPF_AND | BPF_FETCH) ||
> +			    insn->imm == (BPF_OR | BPF_FETCH) ||
> +			    insn->imm == (BPF_XOR | BPF_FETCH)))  > +			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s(*(%s 
*)(r%d %+d), r%d)\n",

(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)?

>   				insn->code, insn->src_reg,
>   				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> +				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
>   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>   				insn->dst_reg, insn->off, insn->src_reg);
>   		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ccf4315e54e7..dd30eb9a6c1b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3606,6 +3606,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	switch (insn->imm) {
>   	case BPF_ADD:
>   	case BPF_ADD | BPF_FETCH:
> +	case BPF_AND:
> +	case BPF_AND | BPF_FETCH:
> +	case BPF_OR:
> +	case BPF_OR | BPF_FETCH:
> +	case BPF_XOR:
> +	case BPF_XOR | BPF_FETCH:
>   	case BPF_XCHG:
>   	case BPF_CMPXCHG:
>   		break;
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index ea99bd17d003..b74febf83eb1 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -190,6 +190,66 @@
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD | BPF_FETCH })
>   
> +/* Atomic memory and, *(uint *)(dst_reg + off16) -= src_reg */
> +
> +#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND })
> +
> +/* Atomic memory and with fetch, src_reg = atomic_fetch_and(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND | BPF_FETCH })
> +
> +/* Atomic memory or, *(uint *)(dst_reg + off16) -= src_reg */
> +
> +#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_OR })
> +
> +/* Atomic memory or with fetch, src_reg = atomic_fetch_or(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_OR | BPF_FETCH })
> +
> +/* Atomic memory xor, *(uint *)(dst_reg + off16) -= src_reg */
> +
> +#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XOR })
> +
> +/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XOR | BPF_FETCH })
> +
>   /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
>   
>   #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> 
