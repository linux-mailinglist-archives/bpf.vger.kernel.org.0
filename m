Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC02CE82A
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 07:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLDGbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 01:31:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgLDGbZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 01:31:25 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B46T2te008074;
        Thu, 3 Dec 2020 22:30:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h+rVcsTEac9GhRn8AmDK55Y1KA/0T+E8grHYCH3slUE=;
 b=UM34xw5OCUoJ3D+dlGnO+X52NfWwodeR7a6SWdVoGKEn4kiKNCLIeqLyxch375cY9Frm
 Hn+nJbCmdEZCM47UHL9YSQef/0MlOUwFkY+1JA3au/vfHjbRrmko1NGSHaeprWGabxIn
 +cekgn+oiujTmYI0PsM9C1J6ZFUYtpYLwi0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35615fsy3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 22:30:23 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 22:30:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdCYmYA2+96y8P3Vk+GjEmraABKl+G/i8ENQ+RCAxxfugQ4vK8RPcmjFcRlWnU4bCsLtGJZOGmEf/otS3Dk+McvY/H9SCL+XIV0vG3hfDB1vvQykpxR4MTJHxnWGCTK3qyaT6nq9NXwaCwfE2E8exv07/zm/6M0aeSjWG6Oj/vcJzArFt6hGbyp3FIbYKHZc3NnpyMoRFIrUd7yC+knurGkBBFCvYDe+ZFaHHlJ8dxEpZFlLq9wamSohRM5I2Hz053IdXBkHmxI+X2zG2ARsWOIw9CutM/kYITyKgzZl8TAf3HRc5NgCVSVgi6HCZ6sQKeN5UiFPY8XmpkyxihypHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+rVcsTEac9GhRn8AmDK55Y1KA/0T+E8grHYCH3slUE=;
 b=kF6T0iQCxO30/ljIZBzmm5zYOANlJiir/vZLe9ZZ8KO98/nbw9h9VX/oo59T6vWV4V0ETs4ObHWd9/OgSJtYS3386sToE8jW21NP1RexxfPSDN+TAefse1j6iM3SWxE08Rt3/RB+/q/TqkqEZ2agbq86jKLk0JVce7Dwsw2jDgisuxKw1ERGihu6vFA1RX79ga2mcilnby75KOs5oRR00cNFdlWSTk/A5TvJmPjxNd2Y5bFqHMQe+uKDupb3FyfBXn4Va6HP+VsazkvDk/0WC/VfiGQb1FQU/scptAIoRo1Ya6mOmwcrg4/jpAHihoVk98v4JqIFUxo84bXRQSTreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+rVcsTEac9GhRn8AmDK55Y1KA/0T+E8grHYCH3slUE=;
 b=KiIxsdtPSdAx13bG3bwyFLcjZLN+Cc8Gwh811au2vUQ0uTYS17bbpQxP1pGwSFkkvGriphSK30rHbOKYqMnlM8rvpWlF2bVHW+tEl3AOJJnAMmSpXQ13NRetrIhNfTQ3HEDxeje4LUkyrtbfWbj0YJMBWJpi59+zDBpSRRK4Xas=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4085.namprd15.prod.outlook.com (2603:10b6:a02:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 06:30:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 06:30:20 +0000
Subject: Re: [PATCH bpf-next v3 09/14] bpf: Pull out a macro for interpreting
 atomic ALU operations
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-10-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f1d5ec7e-6231-0876-f25d-9dd5da4112d0@fb.com>
Date:   Thu, 3 Dec 2020 22:30:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-10-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1dae]
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:1dae) by SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Fri, 4 Dec 2020 06:30:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 935eac4b-bd40-4e22-7630-08d8981e125e
X-MS-TrafficTypeDiagnostic: BYAPR15MB4085:
X-Microsoft-Antispam-PRVS: <BYAPR15MB40859B750998FF06FCF56208D3F10@BYAPR15MB4085.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoU5dRtnUH00sQEHdIR+M1CX0MTQImK/vZaO3WnjgmlPJMkG7h9FallFTvmQQBv4Om0lGy0rA3xj9jBilSVh3CoqkbqRPsq2Ce+L0zURux0gYv9YCCIn6VFbM1it/L1KgcDt7xv5Si8YcOWQxA6u+SMxRq5IZCa2Dv+rnRf3ob8SHO65YZO3hlUCwzMl36P7COsZ7xxm7ukUgLzyJH9nTqg3qkyX2GAUYtefO3f61AOKxYm0Ou//gycdvxSbq3h6r8KwxO/OnUIqe1wUWZ19fFvorA2JGufSP0Kp7gwlSpjmRWUTy/gMWMBhrqY5LuzIjZQrnHG4XYPD+VBEyWTJtICkWxKVSWm46SGPpcHczMg5p391zvqPgC6tXSO3OX97Ks7kv973h9RDcDGFfH+w3T9UPXocWZE8FgeAXogMrIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(478600001)(4326008)(31686004)(83380400001)(66946007)(52116002)(66476007)(66556008)(31696002)(36756003)(16526019)(186003)(8676002)(53546011)(2906002)(8936002)(86362001)(54906003)(5660300002)(316002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHhqYVZoZmQ5elJrVmZHb2QrbG9WWWdDdGpOdHAza2RPUktqRkJFVDRQVkNz?=
 =?utf-8?B?Z1VSTXh1NGJYc1dzZlpPenZSdzN5NFJjcmV5M0lvdlRpdnFxS0x0VGhSSnA3?=
 =?utf-8?B?NHpaYjRneitOUlR3UHBlcnZNdWpkMUxyYTlpMFR3NlI5WVA2V29OY0xCQ2Ji?=
 =?utf-8?B?a3ZPNGhzNnZmbFhaY2JXbFZSRUpzS0hObkZnOVRuWWMzVENLRzBnNzZUaEJ1?=
 =?utf-8?B?OEdUNUJoUGtCWjJxdlFFVzdPVVIrYWQxazNnRkl5NXJWb2F6RVc3d2pQZW9O?=
 =?utf-8?B?bjJCN2ZvdWM1SWtrRm1EV1g1YU9zQzExeTJ5eDhOc0tOQk9zT09hc3cxT0lU?=
 =?utf-8?B?L0t4UmtnRkdxK1QyMDN0TWRiMHZIL0xXTTZnR2JjWU8xNDNmUytPL3ozckZ1?=
 =?utf-8?B?aEhlNW80di9sMjNiQVh0OU04Ulc2VmE2ekhFRTUrT09zM244OGZFNVpVSjhw?=
 =?utf-8?B?RktoMDN4M2JwaElQcWRlVE9XdGo5SUJaSnJFYWRMY05GUnlvTnJsMHhPTEFv?=
 =?utf-8?B?b0I2dlFkU1RPNWVJV1ZCRndDZ2FjcC9TandJSTFLbDdHbjBzK2xQaHRHRFRU?=
 =?utf-8?B?UkVhSWZqSWFvckswVlhJREsrM1FQamhxMEJHdVNWZDF0Qkk2SzNWaG5KTDZI?=
 =?utf-8?B?NHVlRkd6djlOM01oU1hZdXptZ3BZSU5kNkxQNVpwTFJjZWJ5dUl3TDN6UDBU?=
 =?utf-8?B?TUt6YkV5a0hmbE15R0lrK3F5Y2tTa2xoN3Z2RUVSMWUwUEkyMUxKcFFjNDZw?=
 =?utf-8?B?MlRIRSs0bTdQbndlK1BBbnhJbndOemdzZ1grSWM2Y2R4Zkc5UDhBcDhRd1o1?=
 =?utf-8?B?VjFuS2lKaHFmNlB2WmMrM1k4aEdCeXlmNjR6QjF2RnJqbC8zV3FMT0pyUWlE?=
 =?utf-8?B?UTlUTFJRUE9GSEZuS2puamdIa2tVZ1Nmb2E4ZlF5V0ZnYzQzTnNhL2ZBeUkv?=
 =?utf-8?B?bzUxbFBXRit5S3JnZy8rcTlIM3NDcy9QdDVrbkVpSmlmYW1FRXFxeUhXOEpu?=
 =?utf-8?B?V09MUFROTDJFbmJmTWlUL0k5SXdseDl2Unhyb3JNWk5rWEJwOVhmVUFqaGhy?=
 =?utf-8?B?enF1Q0h2SmUxUUZlRGU3R1ZmbXNRd0pOR3BaSGEwaTJVK1FNQm1xOUs3Y3BS?=
 =?utf-8?B?TXN4dVQ3SnZISFFrc3lrVjRwTmRKNUtvY0gzdGd6alVNTklqSG5rRjVNZzhJ?=
 =?utf-8?B?cHJ5ZE8wMnRuQWdORVo2ZkZzRzJobnI0MndZdkFkTVUrNHF1Z1FPdGRXbTgw?=
 =?utf-8?B?aVBVWE9BdlpXTGg3Ulp0NGp5ckRqUmNmcmFtYU83elE1UXhDVmYvd3FtRUhk?=
 =?utf-8?B?aE1FS1Vlcm9NcDBLZUVqRUZzM0F6OWpEejlOWFFFbXpCNTQrOEQxQSs5blly?=
 =?utf-8?B?d2RSc1J2c3BLNGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 935eac4b-bd40-4e22-7630-08d8981e125e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 06:30:19.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbOyLDrFFgF+sx9Xk5lL5fYYvQm4QuwgfAoj8eCq7d03R9//ynX92Hasxp80uOGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> Since the atomic operations that are added in subsequent commits are
> all isomorphic with BPF_ADD, pull out a macro to avoid the
> interpreter becoming dominated by lines of atomic-related code.
> 
> Note that this sacrificies interpreter performance (combining
> STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
> need an extra conditional branch to differentiate them) in favour of
> compact and (relatively!) simple C code.
> 
> Change-Id: I8cae5b66e75f34393de6063b91c05a8006fdd9e6
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with a minor suggestion below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/core.c | 79 +++++++++++++++++++++++------------------------
>   1 file changed, 38 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 28f960bc2e30..498d3f067be7 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1618,55 +1618,52 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   	LDX_PROBE(DW, 8)
>   #undef LDX_PROBE
>   
> -	STX_ATOMIC_W:
> -		switch (IMM) {
> -		case BPF_ADD:
> -			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
> -			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
> -				   (DST + insn->off));
> -			break;
> -		case BPF_ADD | BPF_FETCH:
> -			SRC = (u32) atomic_fetch_add(
> -				(u32) SRC,
> -				(atomic_t *)(unsigned long) (DST + insn->off));
> -			break;
> -		case BPF_XCHG:
> -			SRC = (u32) atomic_xchg(
> -				(atomic_t *)(unsigned long) (DST + insn->off),
> -				(u32) SRC);
> -			break;
> -		case BPF_CMPXCHG:
> -			BPF_R0 = (u32) atomic_cmpxchg(
> -				(atomic_t *)(unsigned long) (DST + insn->off),
> -				(u32) BPF_R0, (u32) SRC);
> +#define ATOMIC(BOP, KOP)						\

ATOMIC a little bit generic. Maybe ATOMIC_FETCH_BOP?

> +		case BOP:						\
> +			if (BPF_SIZE(insn->code) == BPF_W)		\
> +				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
> +					     (DST + insn->off));	\
> +			else						\
> +				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
> +					       (DST + insn->off));	\
> +			break;						\
> +		case BOP | BPF_FETCH:					\
> +			if (BPF_SIZE(insn->code) == BPF_W)		\
> +				SRC = (u32) atomic_fetch_##KOP(		\
> +					(u32) SRC,			\
> +					(atomic_t *)(unsigned long) (DST + insn->off)); \
> +			else						\
> +				SRC = (u64) atomic64_fetch_##KOP(	\
> +					(u64) SRC,			\
> +					(atomic64_t *)(s64) (DST + insn->off)); \
>   			break;
> -		default:
> -			goto default_label;
> -		}
> -		CONT;
>   
>   	STX_ATOMIC_DW:
> +	STX_ATOMIC_W:
>   		switch (IMM) {
> -		case BPF_ADD:
> -			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
> -			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
> -				     (DST + insn->off));
> -			break;
> -		case BPF_ADD | BPF_FETCH:
> -			SRC = (u64) atomic64_fetch_add(
> -				(u64) SRC,
> -				(atomic64_t *)(s64) (DST + insn->off));
> -			break;
> +		ATOMIC(BPF_ADD, add)
> +
>   		case BPF_XCHG:
> -			SRC = (u64) atomic64_xchg(
> -				(atomic64_t *)(u64) (DST + insn->off),
> -				(u64) SRC);
> +			if (BPF_SIZE(insn->code) == BPF_W)
> +				SRC = (u32) atomic_xchg(
> +					(atomic_t *)(unsigned long) (DST + insn->off),
> +					(u32) SRC);
> +			else
> +				SRC = (u64) atomic64_xchg(
> +					(atomic64_t *)(u64) (DST + insn->off),
> +					(u64) SRC);
>   			break;
>   		case BPF_CMPXCHG:
> -			BPF_R0 = (u64) atomic64_cmpxchg(
> -				(atomic64_t *)(u64) (DST + insn->off),
> -				(u64) BPF_R0, (u64) SRC);
> +			if (BPF_SIZE(insn->code) == BPF_W)
> +				BPF_R0 = (u32) atomic_cmpxchg(
> +					(atomic_t *)(unsigned long) (DST + insn->off),
> +					(u32) BPF_R0, (u32) SRC);
> +			else
> +				BPF_R0 = (u64) atomic64_cmpxchg(
> +					(atomic64_t *)(u64) (DST + insn->off),
> +					(u64) BPF_R0, (u64) SRC);
>   			break;
> +
>   		default:
>   			goto default_label;
>   		}
> 
