Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924852C7285
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389834AbgK1VuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 16:50:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbgK1SUd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Nov 2020 13:20:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AS5MhaG021879;
        Fri, 27 Nov 2020 21:26:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5nbMH/ALP3hzreYFl67GZxjRL0bCIwuc9GlE0eVfs98=;
 b=eOUAJ7ubKByEOJxWY9Wwz+lkHjVjl//4dQJG0EPa5AJhV44hlXRg2vNJRzDPmMRiosJp
 yzLYBj1EhOhASJyVWs/5hOYJ9f8QQCMDt7Rl8/VAql3ZcBlSfYcn4Zg1hmn0ng9wxL8Q
 ufOtVZES0ONuzPQA6ytsYeT02b8xd3/WpRA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 35357cj508-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 21:26:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 21:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5LWg7Nh9hgKOwXLQN43rIzzauRZLW0/H0KVhh0EWB/+sSsbfnU+eZkJh/FOb9+BssLzjwGKo/AMlyYVpMLl8sCsuYuOpLo4LuH7AiIZAAocKvker1cH9vwHi7InGu/ipficWpTSMEhV3MVmNWDrswAWUz9Hezf4a1kYCLoIiFrw9N794P4VftdpVAcu1fQI+1EGnMForX+iJK4IZ0Epv7iw7nQdXusCR8hGbydgzJox6UDz51aAwzKlfPxtC2NfMzPANNV1556p/64TAr2xAHtCrpKD/lHlsYxR1oJdD1z++BhMZ3lpaEAMJY7QPLJt+8JMpMplvePTAwLSV5PiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbMH/ALP3hzreYFl67GZxjRL0bCIwuc9GlE0eVfs98=;
 b=Lqjh9sxncxs/mKqj18HCA2S2gWWm+oVsUTUyeeumEdJ2Wptxe8ILsWEdXrhWImI8OvXQDBVQvfyoFOg0u1QUA7jAt0bicv7zOR4mmGko5T9Th/KsiuWERAbqQ6akYbe68oftkMDwkFPPYl/afBawUkExWzZiJr4FFBKVQuYT/R3wSaLcxLLVRy8iHDAWtIyPbAPUJOEyItdkFxbEVCH19tmxhftljdjNXTcPaTffKmoKkG48+E0WMZfPewIg7pvcPdrycVFoV9ssBRdZz6dt8GOcfo9WtidOKky5dtRK0TotrL57KoeZsfSi//k+NTq0vzNFCP08pJWzi95fUxV5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbMH/ALP3hzreYFl67GZxjRL0bCIwuc9GlE0eVfs98=;
 b=e2qzQKOCtM322DFuqUHsju+s6XtXguwTb7tZiHKkDvNviOImfOmemLnlEVQATjAcTaSEuzVFufyns9lyyHAE1fM/Upu6j0s5fon00PoeChh1IYrozVr0KIhWjj/XhcHHy0uOagjDq+MY4j62Ib9xkucmUgIZhIB0gonKdun8V90=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2581.namprd15.prod.outlook.com (2603:10b6:a03:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 05:25:56 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 05:25:56 +0000
Subject: Re: [PATCH v2 bpf-next 08/13] bpf: Add instructions for
 atomic_[cmp]xchg
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-9-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c6d1763a-9674-9af3-51c5-c1467332c22b@fb.com>
Date:   Fri, 27 Nov 2020 21:25:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-9-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fca2]
X-ClientProxiedBy: CO1PR15CA0100.namprd15.prod.outlook.com
 (2603:10b6:101:21::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:fca2) by CO1PR15CA0100.namprd15.prod.outlook.com (2603:10b6:101:21::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Sat, 28 Nov 2020 05:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e2a6507-7d0b-4009-49a6-08d8935e14f9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2581:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25819D9F607B5353ECCE3A70D3F70@BYAPR15MB2581.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcTkvHtWMwFN7A9MSM2qvhhVYeri3jgw6QWL2R5IOf4zCMxeDyKd323vyNiBSMzLxGVzPgUwfL/R09yRQQ8pcK1dGCJr6Tgig0e6gJjESPnJb5+YBdD/YiNd0o6zJzhSWBis15/cSyOxB0VAWgeqdG8nxR9QZP/pZVeoAlWE9RbpoLb6PCn3HRlU9+1PjyJn9849VA5V5l8qbkBReZ7mF1KnxOuILrV3HCaG7hZcJDlEK12KZq3P1WVCBiCqrAMwLRyc+Jt+Hz/P+6Ho5cBk9Z/VFkx6+F0PxvOhrCv7kWkk/Aoom2njhRP5PM3rE9BZGvmd+Ti2x/NLizO7Ap7CW6t4refvi2QQR2aEwU/q8h8934nC/54dTyc3sfVT/Chd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(6486002)(31686004)(2906002)(36756003)(52116002)(5660300002)(478600001)(8936002)(66476007)(66556008)(31696002)(8676002)(66946007)(53546011)(16526019)(4326008)(83380400001)(54906003)(316002)(86362001)(2616005)(186003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MlRJWS9qSWtsZjk2QUZkUStFMXhRMERRQjBmdk5xcXpDQnR1cXM4dzd1cGFv?=
 =?utf-8?B?eTFCNVh1UTA3aUloaFVITG1Uc3M2WGM1bG1Eb2JLZVIzWCs5V2NMUmpWaFND?=
 =?utf-8?B?NlBtQVN1elVrRUVpbjJaclFxdGgvYUIrMFhWc0Iya2hCYUUrMjVpUzMwNSs2?=
 =?utf-8?B?ZVVHMy9oTDcrN2JWdGJDUTlZekNPYkJaWnJOei96L2s1Q0M3Wnd6UThMbHRX?=
 =?utf-8?B?eURvY0d0ZGh4UDBhd283NzgyWTg4Rm54NzJpdmwzSURyVjhwNFRCYUozdGc3?=
 =?utf-8?B?d2MycHR4c1FVRmJaRHNVdm9EYTYvdENxRDRlZlkyd1RxRkMxci9hQ1Y1b1Z3?=
 =?utf-8?B?ZWx5c1Y0QmFGaWNka0dmWEsrdFI4K1ZWcS9BdktER2lRVXIwd0UyZ0hjYXp1?=
 =?utf-8?B?aitYQ0d6SG1vdEE4d0JrMjZuZ0tWWCtDNGE2N0ExRzdLU3Z5WE16Ynp3eUZk?=
 =?utf-8?B?RlVoVUY4QUU0TXdFRUtxOGxWQld0VkhFWG5EV3p1amJnZU10SjJSNk9YalJY?=
 =?utf-8?B?S2llenRiU3lFRlh0dDV1blFvOG9WWVh4Ny9Kb0UzbEV2WVdwYlhnb0JoTG0w?=
 =?utf-8?B?YUJYUUhLbnpjZ1hZOTE0enUxaVZydlFHK282bjBwTW90cllnVGljcSt5YVNN?=
 =?utf-8?B?aXlqU0ZFd3BDMnBNRU1tdHNCYmcwMHoyTHhGWjdRRFBNNzByT2ljZE5iUVhY?=
 =?utf-8?B?Kzc1Wk4wWVFWelRBWHV4Tmg0N3BzVXM1Ym80V2cxMHdOU1FBWFNpdDlvK05F?=
 =?utf-8?B?Z0I1U1lUblkyNTJITzRKcEM0anJMd3gvT1p4MHBvVS9wcDdVZWx5RmJ5TTZp?=
 =?utf-8?B?UGZzM0k1UGYwWlplMmNnUGFUYVJuVzdzajJvS2dTRWMyNW1pK0tnMFBNQktx?=
 =?utf-8?B?cXJQUXdJMDRFTUlHdkwrMWVLRi9zc05ZQ2g2SkJ5bzdUV1VLbW1WMzRQWWdM?=
 =?utf-8?B?T2JWNkM0RzBCMzdWcElPV05DQlZlVGc4Y1ZXa0hMeHNZOGRiTlh1VHRzT1Uy?=
 =?utf-8?B?RjAzVjdTSjJra2J4d0FYbi9kdHN1NEdoV1Uwbk5wYWJBSGdZUk1DMEdCRm9T?=
 =?utf-8?B?YTBGYXBnRUZvcVpYWW1ISmtMY3RlUzFsbmlicVJmNWR0OGEzK1gzRDZLRUVC?=
 =?utf-8?B?bjk3S3lodE9rQ3YrNkhJcXFtR1Vxekg1cmpTVndqbElZQmh3a0JTYlkwRk5T?=
 =?utf-8?B?aDdVaTJTSDMvdnkydUdPK0Uxd1BEV1lmVE90TFRvS3RvbXpCR0NtUFF4a0pu?=
 =?utf-8?B?Y3lrL1E4R0sxNkhpc2dzVTRCUXFMdWJwL2V5YXNNeCtYM1RhaE1FWklSRVFG?=
 =?utf-8?B?Umh0MjdjTVN2dW9ualo0VTBDY0s4ZFFCUnYzOXdNMVhnRVNDQVlFa21sdlpU?=
 =?utf-8?B?Q1duVU1GSDlpeFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a6507-7d0b-4009-49a6-08d8935e14f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 05:25:56.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSd70gsacnRvQSq8wORZ9F4qhfEQ50UmuxGqxMgUb2AV7kfKsN++s7ny9z+Le1dD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2581
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011280038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> This adds two atomic opcodes, both of which include the BPF_FETCH
> flag. XCHG without the BPF_FETCh flag would naturally encode

BPF_FETCH

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
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cd4c03b25573..c8311cc114ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3601,10 +3601,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
>   {
>   	int err;
> +	int load_reg;
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
> +		/* check src3 operand */

better comment about what src3 means here?

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
[...]
