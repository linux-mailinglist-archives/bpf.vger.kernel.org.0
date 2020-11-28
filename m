Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E62C7277
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 23:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbgK1VuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 16:50:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731449AbgK1SCj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Nov 2020 13:02:39 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS5oZos016483;
        Fri, 27 Nov 2020 21:53:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R7U0eosPby3JTqhJVkY+ckfc49RGGjjUqM8zASPBHM0=;
 b=CFtdPZkbiCQ4LAsfMAa2L05zzbCjBSw2I37yc5vYS6gqd61BzBGowTtaPLmuhfeHpiRP
 QCwhkSdA2BjbbS5RG7n6wQUrfPPdXECmDUb4TB5S/Xm+/AHe4irCeEmePjGPqo4pRJ0B
 b4/4zgLadZ1p8DMDBe5AsvmLK9QfhLY6f1Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3536c31yh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 21:53:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 21:53:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8mfGtTcac6I9ZrMfoM3O1F6P1M/elMVNsVGd3WkN1ED//o+phY0z0YfWhmVf1TPMUI+6TAcXapCm6xGtWK1X/ZLXN0kxAhr5eRaOMh6aWhDNM99eAZ0AnYtJjBuRiZnrQ0fguL02+IEEPFi3GqxQLvCHiyVJLbDaMc7/UNSRlpTd3ngs8N6AsaaLD0owj5J6CXsHZzGHIB69mYeJ9gK012Kn0iI3PuwE6s5y40sKDr9bRFllDZpNERcKsLdmUwY7PCFvTIKNbdMJlyS0Y5l7ZzmI5hFfBetTZPsHKJqlyNVHPcCVxV4Hgb8HXPe0CiDaHri65uLUkS2e2UR0Q0KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtIUjV9tBRdQZy4O5rc/pRgsDUakxd8dSGoNVg13cOM=;
 b=gAGd3CwFFFEG/PygysR1iKd6RaZEfAncrFficxgcjdL8T90FDv4981OxTF3nckAa1JyrvI5yREZRfx5dy7iBluIrlb3YlNs1mKHO+YtH4UQD2kYmd1zkugzBCm51IPlaOuxAUlFeDCQ7k/wIOxTMzoMtlF5Eq3SGvSH1wiTB/CdKfBUpCIMkVL9b2Rkn2dil+725b3naBsfKgMKssnsjhnxC8n800HAAtFgFKjgpRbm9O+5l8BhXxQJr5jVBOPtEgYtDKCU79KHh91RmF1Z2BuPIsMTETY5q2Zit35KzJoGZQ6HtQL/fiMmFaePzcI1Y329qUFUflb+fN1+t4CIA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtIUjV9tBRdQZy4O5rc/pRgsDUakxd8dSGoNVg13cOM=;
 b=FJAiLheKLRwx/Z0oqHSCzR2wY4wS3CkPbSToU69W0B3OVF5/Bq3Us23XqZWqaT/aDSzDy6EyNbQcvcXbtyo3WzhGtTVCfYXUPM1vFOIwpPpi+QISVd32U3GH+9ROfc4mdoD/yFr/nkxEvTBS1NSuwJioV0hIjZGmSj1wKzl3my4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4203.namprd15.prod.outlook.com (2603:10b6:a03:2e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sat, 28 Nov
 2020 05:53:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 05:53:07 +0000
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
Date:   Fri, 27 Nov 2020 21:53:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fca2]
X-ClientProxiedBy: MWHPR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:300:12a::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:fca2) by MWHPR22CA0070.namprd22.prod.outlook.com (2603:10b6:300:12a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Sat, 28 Nov 2020 05:53:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a27c699-9d82-4156-5318-08d89361e17e
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4203:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4203842F17A8BD530EBBEDB2D3F70@SJ0PR15MB4203.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MOTL57apLhaTnhwHQTS7JLXRtOv6eTsDhn9lkTio+Yj4zVUz2QKIuvJLyGoITikRK1EQKg3EOfGsdb+g+UMYxyD2nFzMgHv9Dn3oTzuEWKLGjLLbeF+u1YQMaAYtirN81bwvcEKpQgvMQQ40u/Ams7Xzqv6PJMjasPvBAmmk2f4s57qzlMCeiOTYPN0zzzSeuONeFxqC4nKHfT3rFJ1Nm5CwCWIQCbHZ9uv7GdCVSC0Eo64lSIvpwMyMfMigVhNIWVRY9tKIivuFXvLYEhRl/CH+pb2d7WavlDu4yIsSqM7t7h67RBiomRY1M+KR4DIBpVKQv1s7+hR1/711KfQzsg1TIalbXWS2trDaqR+xOxZ6vGWfRvCpLaUPJAYfJ/qdyDu3jVc//F94vlwZ9BxMdTAWN5oiQ6LFX9Za5NHsfrAcbbXGYClDoBRGpuLOu/LmMj6YhPG6nsvBY+VPMutNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(36756003)(83380400001)(5660300002)(52116002)(4326008)(6486002)(66946007)(966005)(16526019)(53546011)(66476007)(31696002)(8936002)(86362001)(31686004)(8676002)(478600001)(2906002)(54906003)(2616005)(66556008)(316002)(186003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?czlmcms5S0hxcHJJM0NyNFR0ejNnRDQ0QWU4MERiS29lbE5Eemc5bU9WNElt?=
 =?utf-8?B?L3JCQWlOYmw4VGdjZTlKNFZkNXVwb1hpSlZsMDdISlpUTko4cWFsOFJ4L04v?=
 =?utf-8?B?TnlQYTl5T1RudnpiTFI3V1I1ejRCQUI0S3FtVWhKUk9vdWc2eXRSSktKZDJO?=
 =?utf-8?B?djJabWM4dDRkSzF0QWE1RWxraS9sQXBNZWJnUktLMEtmcHVnb1cyTGdzQjAv?=
 =?utf-8?B?Sy9odmN4WGR1bFVsaTh6VXNEYnI1dUdPakhxcEMwUmhPeW9mT1poeDNnSkN3?=
 =?utf-8?B?cGhBZy9ZVFNFU09hR2JtR0J0TXJxa1RpTFhYQ2wybldPdTkyWnkrekQ5Sk9Q?=
 =?utf-8?B?dnFaVlFCRElscEx2N2l5eWZtcjd0MHZtWCtmd0JSZVEzU3hyaE02Zy9QRVlT?=
 =?utf-8?B?Uy9JYm5GUUZoU2NWRmkzNDJqUU9vaTNuY0ZsajV1T3ZiQ3F2dFdYUzQ0bFBG?=
 =?utf-8?B?dGNVMlpyZDVPTGw3b2tZbmhhMDloRVdaeHgzRjBzbTA3Wkt0TkhrR3FzeFpJ?=
 =?utf-8?B?aVZYcEhGWU00bXprQ05CcXFCbFZHM3o5d1pDVGlYTGRYRkpvNkN1RUQrTzFi?=
 =?utf-8?B?ZzJIdWNJYS9OTlloY0t2NlVEVnN2Q2EwSUZxTXlLKzBmMGlSeVhDbnlqdnVv?=
 =?utf-8?B?OFcwR2pXZWphZGNzSnFkZHFzdkU3Y29yV2tBNUR6cG80dzRlTGNCSS9JTjFU?=
 =?utf-8?B?aWpSZTVBSkxvVWg0UFhmQ0ZZZnl6RUtjbGVJUzhSYmdkQ3gzWXNCRnAydVpl?=
 =?utf-8?B?clV6VE9Ld1VxVTVKT2hBS0VvK3VVWitlaGRhaHo4Y2lLS1owa0Q3OG00UXd3?=
 =?utf-8?B?cGt4OGErSWJwNVU4TFdlN29pdzdWZjlibDIwZDhkTzQwZERiZjJtUUl5SU1w?=
 =?utf-8?B?MUFsZFAyMW8wTzFtcEo3YUpBR01sdmZPb05TL2d5Q051dklDYzE1aHhqR2Z2?=
 =?utf-8?B?dW1NeVJTbTROUlkzZ3UxdlNvcWVuU3NDSXM3ZjlmdzFNZGdUS3BLK1NMcTRC?=
 =?utf-8?B?Ri9LYXpld01MNzIvUmRjK09Ba3V6aXBWbTF1NzVIUWFkMjdPRFFXblNPWVRh?=
 =?utf-8?B?OGxuRHFkY1cyOFZ1bVI1TEJFeGV5UHJoQ25rTXM5emJxL0x5Q1FIRVZUWHRI?=
 =?utf-8?B?UFhhL2xUMElCdUovejZoK2p1NUtheGFYbmdUTGtRZkJwZlErRzBHUFBubUJM?=
 =?utf-8?B?WmovSVppS3g4OVVBWSsrRVRmZ2hsMy9hclJQaE56MEdNRy9ERXlvNktJYVNU?=
 =?utf-8?B?RVlBbzR4dEZPVS9PNUVSVmhYTWJiTkpBVVh1YzJndTF3cCtzSTZIZkE4WDF1?=
 =?utf-8?B?U3V1bEUrQmxRQTlBOFQ1V1RXcjdEaUNUcDEzbE5xMVlPRGhRSHRNcHBpbnRF?=
 =?utf-8?B?K1hnalQ0QVRlZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a27c699-9d82-4156-5318-08d89361e17e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 05:53:07.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUCvWKVdp9QiEVjD0nAEjPAJvh7weE0mYkNZ7zd34dgNUM3U4ThVtizonr7htlTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4203
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280042
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> Status of the patches
> =====================
> 
> Thanks for the reviews! Differences from v1->v2 [1]:
> 
> * Fixed mistakes in the netronome driver
> 
> * Addd sub, add, or, xor operations
> 
> * The above led to some refactors to keep things readable. (Maybe I
>    should have just waited until I'd implemented these before starting
>    the review...)
> 
> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
>    include the BPF_FETCH flag
> 
> * Added a bit of documentation. Suggestions welcome for more places
>    to dump this info...
> 
> The prog_test that's added depends on Clang/LLVM features added by
> Yonghong in https://reviews.llvm.org/D72184
> 
> This only includes a JIT implementation for x86_64 - I don't plan to
> implement JIT support myself for other architectures.
> 
> Operations
> ==========
> 
> This patchset adds atomic operations to the eBPF instruction set. The
> use-case that motivated this work was a trivial and efficient way to
> generate globally-unique cookies in BPF progs, but I think it's
> obvious that these features are pretty widely applicable.  The
> instructions that are added here can be summarised with this list of
> kernel operations:
> 
> * atomic[64]_[fetch_]add
> * atomic[64]_[fetch_]sub
> * atomic[64]_[fetch_]and
> * atomic[64]_[fetch_]or

* atomic[64]_[fetch_]xor

> * atomic[64]_xchg
> * atomic[64]_cmpxchg

Thanks. Overall looks good to me but I did not check carefully
on jit part as I am not an expert in x64 assembly...

This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
xadd. I am not sure whether it is necessary. For one thing,
users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
return value and they will achieve the same result, right?
 From llvm side, there is no ready-to-use gcc builtin matching
atomic[64]_{sub,and,or,xor} which does not have return values.
If we go this route, we will need to invent additional bpf
specific builtins.

> 
> The following are left out of scope for this effort:
> 
> * 16 and 8 bit operations
> * Explicit memory barriers
> 
> Encoding
> ========
> 
> I originally planned to add new values for bpf_insn.opcode. This was
> rather unpleasant: the opcode space has holes in it but no entire
> instruction classes[2]. Yonghong Song had a better idea: use the
> immediate field of the existing STX XADD instruction to encode the
> operation. This works nicely, without breaking existing programs,
> because the immediate field is currently reserved-must-be-zero, and
> extra-nicely because BPF_ADD happens to be zero.
> 
> Note that this of course makes immediate-source atomic operations
> impossible. It's hard to imagine a measurable speedup from such
> instructions, and if it existed it would certainly not benefit x86,
> which has no support for them.
> 
> The BPF_OP opcode fields are re-used in the immediate, and an
> additional flag BPF_FETCH is used to mark instructions that should
> fetch a pre-modification value from memory.
> 
> So, BPF_XADD is now called BPF_ATOMIC (the old name is kept to avoid
> breaking userspace builds), and where we previously had .imm = 0, we
> now have .imm = BPF_ADD (which is 0).
> 
> Operands
> ========
> 
> Reg-source eBPF instructions only have two operands, while these
> atomic operations have up to four. To avoid needing to encode
> additional operands, then:
> 
> - One of the input registers is re-used as an output register
>    (e.g. atomic_fetch_add both reads from and writes to the source
>    register).
> 
> - Where necessary (i.e. for cmpxchg) , R0 is "hard-coded" as one of
>    the operands.
> 
> This approach also allows the new eBPF instructions to map directly
> to single x86 instructions.
> 
> [1] Previous patchset:
>      https://lore.kernel.org/bpf/20201123173202.1335708-1-jackmanb@google.com/
> 
> [2] Visualisation of eBPF opcode space:
>      https://gist.github.com/bjackman/00fdad2d5dfff601c1918bc29b16e778
> 
> 
> Brendan Jackman (13):
>    bpf: x86: Factor out emission of ModR/M for *(reg + off)
>    bpf: x86: Factor out emission of REX byte
>    bpf: x86: Factor out function to emit NEG
>    bpf: x86: Factor out a lookup table for some ALU opcodes
>    bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
>    bpf: Move BPF_STX reserved field check into BPF_STX verifier code
>    bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
>    bpf: Add instructions for atomic_[cmp]xchg
>    bpf: Pull out a macro for interpreting atomic ALU operations
>    bpf: Add instructions for atomic[64]_[fetch_]sub
>    bpf: Add bitwise atomic instructions
>    bpf: Add tests for new BPF atomic operations
>    bpf: Document new atomic instructions
> 
>   Documentation/networking/filter.rst           |  57 ++-
>   arch/arm/net/bpf_jit_32.c                     |   7 +-
>   arch/arm64/net/bpf_jit_comp.c                 |  16 +-
>   arch/mips/net/ebpf_jit.c                      |  11 +-
>   arch/powerpc/net/bpf_jit_comp64.c             |  25 +-
>   arch/riscv/net/bpf_jit_comp32.c               |  20 +-
>   arch/riscv/net/bpf_jit_comp64.c               |  16 +-
>   arch/s390/net/bpf_jit_comp.c                  |  27 +-
>   arch/sparc/net/bpf_jit_comp_64.c              |  17 +-
>   arch/x86/net/bpf_jit_comp.c                   | 252 ++++++++++----
>   arch/x86/net/bpf_jit_comp32.c                 |   6 +-
>   drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  14 +-
>   drivers/net/ethernet/netronome/nfp/bpf/main.h |   4 +-
>   .../net/ethernet/netronome/nfp/bpf/verifier.c |  15 +-
>   include/linux/filter.h                        | 117 ++++++-
>   include/uapi/linux/bpf.h                      |   8 +-
>   kernel/bpf/core.c                             |  67 +++-
>   kernel/bpf/disasm.c                           |  41 ++-
>   kernel/bpf/verifier.c                         |  77 +++-
>   lib/test_bpf.c                                |   2 +-
>   samples/bpf/bpf_insn.h                        |   4 +-
>   samples/bpf/sock_example.c                    |   2 +-
>   samples/bpf/test_cgrp2_attach.c               |   4 +-
>   tools/include/linux/filter.h                  | 117 ++++++-
>   tools/include/uapi/linux/bpf.h                |   8 +-
>   tools/testing/selftests/bpf/Makefile          |  12 +-
>   .../selftests/bpf/prog_tests/atomics_test.c   | 329 ++++++++++++++++++
>   .../bpf/prog_tests/cgroup_attach_multi.c      |   4 +-
>   .../selftests/bpf/progs/atomics_test.c        | 124 +++++++
>   .../selftests/bpf/verifier/atomic_and.c       |  77 ++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++
>   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++
>   .../selftests/bpf/verifier/atomic_or.c        |  77 ++++
>   .../selftests/bpf/verifier/atomic_sub.c       |  44 +++
>   .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
>   .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++
>   tools/testing/selftests/bpf/verifier/ctx.c    |   7 +-
>   .../testing/selftests/bpf/verifier/leak_ptr.c |   4 +-
>   tools/testing/selftests/bpf/verifier/unpriv.c |   3 +-
>   tools/testing/selftests/bpf/verifier/xadd.c   |   2 +-
>   40 files changed, 1754 insertions(+), 188 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_sub.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> 
> --
> 2.29.2.454.gaff20da3a2-goog
> 
