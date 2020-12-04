Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96C2CE714
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 05:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLDErc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 23:47:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgLDErc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 23:47:32 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B44i315020381;
        Thu, 3 Dec 2020 20:46:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=skg28eS3ynyrlH5aaGzWIeTeC7NoPpqR+g4m10jRe4U=;
 b=FQCBy6BtDcmyH/AkzXAXZLuqq+nAAFAmG0GYGHtuAEw6pfzj0adDO6dgugleX4jPHVLe
 +jeSOqB5abN0bIvKy+o2k6yMolL0kDVG8lRwjCkm4KGQ4spx2V6TKxEK3pXimf3laL88
 V+8b9KfGC+ePN5THiDOHAMD8rrC5AAhjlh4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356fsfmm6h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 20:46:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 20:46:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+9HnoNUkOm7mB2U87cdouAU9p8vG3VJyNC5KPJ/ppmhzhnjH/hXmKWJeommnM1e1kjFi5jbZDHvqbdVaykG/YpEnzjHL4EJ2kCTFNDe9eyq/c0MXVTaQchiebSXOXIn9ATHbquMh8Oyo5ftPCHXEnl0uaSxDjCqXVZFJEdcsQTSvXk69ntsksrOmZdhNhsliMAvYTLg8MNA3N4kts29f51rBR47sL5aayWnEEpbK4moKxqnwxaa53770AjvEc7ZW4KZIpZMTRl6kBkbMil2CvPk/e5rizBApNgUsYS+4/fj/RqN9eGuucvbu/GuceQGG3qzab8u97qRCnP9YImWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nekb9bSgCRct00XPkVl3XFwk1j18mmU4nQUQ0VSRmI4=;
 b=EViYULtHzEZ/e0eaxiggaNd6tAiMqRYz1svyrxwES5QGUL4HSTQPf4hXVhF8A7EkTLDsWznVrfnmfz6zlrwufqR77RNQo0OdMATZFdGOamMi1y2rSfJbG1vYXoGQHvym652RhXmpQFRAs8Qv9I9Sm9a8fx9K6QI+3ucMhQ6Du9ywPIpkKxs+cWEBbHqzjbA+pYgYfEYsIirCb3V0iDUnGeOz/rrpP9a5Aa3Gw8duCkdZboKj7Ff6YDbQomezW7keRbDqSUdhkbhFZ4KWo1FDIJ+2vk6T7XgQCqRFsqiq9T5inHhwtmkzXWIRqPeOEwnXK3tOyPa8TZecZlxcgnkkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nekb9bSgCRct00XPkVl3XFwk1j18mmU4nQUQ0VSRmI4=;
 b=TCJM6Gdr3+rg/v1Vi2VopxRNfDKYxjIOBEloJBNktxLR5czDFkpoDVzNRAajTtIYt/chUs4b0RxlwrCsfLe22JikCK4Kx4zmf4iJOEyLTV6Sbk/0y0Ed8iuZQY5FFyWM6ThzhBj7mpryhmioFeh6OmSXI8uD3GssDEoq+SHlelc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 4 Dec
 2020 04:46:22 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 04:46:22 +0000
Subject: Re: [PATCH bpf-next v3 00/14] Atomics for eBPF
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a3ca1f24-bfe8-f85f-6729-46fafd00b2a0@fb.com>
Date:   Thu, 3 Dec 2020 20:46:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: MWHPR18CA0071.namprd18.prod.outlook.com
 (2603:10b6:300:39::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by MWHPR18CA0071.namprd18.prod.outlook.com (2603:10b6:300:39::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 04:46:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e344c133-fbe9-42a0-0e41-08d8980f8c86
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30009F4A22D20C0319E4BDA4D3F10@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt4WEHSyUfwImC4OJ3on+M8DIo1pne8nt7yRrljYg9AExhysF4fOHSJsAQHmIZ9jboin6VI67BNB2tj7qMWQgXIbGa6mjasd/UhwJhq/yNIsJR2we4c+mmKVjMyKOL537LVO6DexdXq64CFm785S0qnqAjetIzXcFNZYjga08BFrLJ9xgELBEtD5IsE8bgbLx9Ur7tCmRzhaG7H90I2uTD/NkuPo5TMu0lqhK+NuHsoe/yO3A5NE1+FxCrg65Im7YSFippi2fHF3rvG2NoKTbUFyiv34P/bwN+nh8eNbbHTvaqrd9d+P4uUtU2OVLciNDFC9CPFSYXiKQQ+cCuJczz8rkslQHC/5wZ6u1+U65obFyQVxA/r2TMV8C0R4d3FrwDZ9THHnWGk5fFyGX7GLXD9sVranKI0sW9jR27s8oFRtacr8JefEAzMr2fJF+y2ERVSEJB/48TIVsI+6TxMpFC3ai4p00VBtPdK/IJi2uAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(966005)(36756003)(2906002)(478600001)(8936002)(31686004)(4326008)(52116002)(8676002)(5660300002)(31696002)(53546011)(316002)(2616005)(54906003)(86362001)(66556008)(66946007)(6486002)(16526019)(66476007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UDRvWU91QWt3WWVqMmlVeWhyb3pPTXllU0RyZEJNSjlobTZsSG0xMGFjdU9y?=
 =?utf-8?B?aHlKR1pocFZIWVp0dXYvQ2RtQ3QrdWdzQjhHdXlxeHROVEc3aXkwWjh6WXp6?=
 =?utf-8?B?Qkl6eG9Ia0NwbjJrNVlVSitoN0RCYXlrQXpLeFFuaHR4ZlUzK2tlSVdRTDM1?=
 =?utf-8?B?aXZyNVp2TnNYT2Z2K2VQa3NGTVRZaXBXMDc5WmxsdjJEUTRGNzgvRUYzVWlI?=
 =?utf-8?B?S2VuS1YreVE5bytBOWY2alpqbHByVWtTSkdHY2Z4KzZHdmZXb1Q3V01OdGJY?=
 =?utf-8?B?ZVlEc2ljR0YxWlBuNS9pQXdBeHhFRmN0VGVEeXpxU0JpaHB6ZEVranpUZG5P?=
 =?utf-8?B?SGs2c2F2dE9SdUFTR0RpNHZiQXlKdUo1OUJGYit2ZzBJeXBQMzY2WHlocHFx?=
 =?utf-8?B?UEFTVFFrVEhZb2srMDJXVXI2em0ySEd3bGQ4V2EzZlpDaitSbnBzVnRDanY4?=
 =?utf-8?B?Q1loMUdTY3BBckVac0k4and2WVlKTWY4akY3M0xSTmZQTmhzelZGKzFjS0Jt?=
 =?utf-8?B?blg4QUNUK1FiZUhoZ2RHTkRpaXJCTWhGZEdHSjhkVWNzMVk0dys3ME5ncnQz?=
 =?utf-8?B?YUdwRlVRVWR4NmtuVXNPWDZCbHJvd0lKL1RMeDNJTWRkRVdhWXRTL2tVS1Zk?=
 =?utf-8?B?NzhUUzlGOENadmJwYUJPVUlSb1ZkaUh0Qk5IUVFtYk5PUWdCVTZodnUyUUhy?=
 =?utf-8?B?aHVXMTVmaGpiZWxTRUo5T1pYQkJPNFd2ei9pYnh2eDlJMlA4TnVndDFwaWVz?=
 =?utf-8?B?dFNYcEtZNkxSdjdXKzlITjJEaVArY3pRRWd3ZDlCaHh6b0svQ2ZzT2t4RzJ3?=
 =?utf-8?B?NGxmTG5aNWpYeTNTcVl1RUdwVU1ndndkWWVxSXVBZW43NERjSjlaU3pES0Uy?=
 =?utf-8?B?TTh0ZlZkMUZNcUZERW83cU81T2RqZFhhSm9aVWVzcEovQXpBcDUwZVZhTzgv?=
 =?utf-8?B?cm5MUjJVdnRyeFMyRVZXV2N4VkcwbUxtV2NaOVNDK1MzYko2ZUQ1cE9qSUN3?=
 =?utf-8?B?d3kyV254dnBEdHFlWDIwZkpZNmpjOFpxTjcvUUhvV2lkQU5Wa3d2QzFZWGhC?=
 =?utf-8?B?R3V2bzVDOHB1NmxtM1c0aW92aXVleEU5MEtZalg3RlpxZGlGNDM0ZUt1eSsw?=
 =?utf-8?B?cERVeno4ZGZWZVZtWmZFRFNiRDlKZkNEQThWeG1aZ3lrT3Nwai94MjdkK1Zz?=
 =?utf-8?B?RUU1ZWltMjgxc2JocDNmcnNVOUdxVGlURHk0bnUxNkFEQWdtUEdVOG1lMllw?=
 =?utf-8?B?VmwvQ3FmZHkrZjVVSnptZ0RRR3lSOSs2MDNtQ1o0Z0s1VVpsQkpGek56QlpD?=
 =?utf-8?B?c0N5R0U3SEl4M1BRSWo4bnBSQk9XRlBGQit3bnlNRzlwdHo5ZU9Ecm16UXh5?=
 =?utf-8?B?QXM2YXRWdGtkaGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e344c133-fbe9-42a0-0e41-08d8980f8c86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 04:46:22.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXWa7lQB3vwEhKalp2fEP3KOiibfsDFHO0UdzsyF88bjUJn31WaHY7w9r+RlQaGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> Status of the patches
> =====================
> 
> Thanks for the reviews! Differences from v2->v3 [1]:
> 
> * More minor fixes and naming/comment changes
> 
> * Dropped atomic subtract: compilers can implement this by preceding
>    an atomic add with a NEG instruction (which is what the x86 JIT did
>    under the hood anyway).
> 
> * Dropped the use of -mcpu=v4 in the Clang BPF command-line; there is
>    no longer an architecture version bump. Instead a feature test is
>    added to Kbuild - it builds a source file to check if Clang
>    supports BPF atomics.
> 
> * Fixed the prog_test so it no longer breaks
>    test_progs-no_alu32. This requires some ifdef acrobatics to avoid
>    complicating the prog_tests model where the same userspace code
>    exercises both the normal and no_alu32 BPF test objects, using the
>    same skeleton header.
> 
> Differences from v1->v2 [1]:
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

Just let you know that the above patch has been merged into llvm-project
trunk, so you do not manually apply it any more.

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
> * atomic[64]_[fetch_]and
> * atomic[64]_[fetch_]or
> * atomic[64]_xchg
> * atomic[64]_cmpxchg
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
[...]
