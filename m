Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEDB32B356
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352535AbhCCDu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1835349AbhCBTCc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Mar 2021 14:02:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122IOPdG031055;
        Tue, 2 Mar 2021 10:43:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=84TwUps1cgNpaypXvzbOdv3QYHjdjOkOb/pnOVlFbTE=;
 b=XWRAwx8GJWQ4zhXSN/Pa+l+XV3OuceoiSzHXc9UOIvSKb3bf1JcRrdJ4uUi7vZLhke9c
 nxd6sz0yjlYN/rV3qUBI8sbWlAxqvUrSGEwnAH0AALss1ZM7uRyjjsJi2XLWw4Leup3j
 wT1lJ9axp5O6m2a+w+Z/gwLzyLicPde8lHg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ymfx7wc9-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 10:43:13 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 10:43:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PegYVYq73PCdCqUol0JP+t1FDwS3TYfa26c6WaRAI4i5qyjlgg2NBdof0Q++wXaLQP2SF8zj/57GMSNnokd5bVrYzamXZ5xoLlFaMfs7xNMNZkmnEV2nD+Gdyr/8Xvn9AgxAdQ56s2zbjR7cmNStNq6Jeyc+zX2OmXpotlBiqhOjz8jqsCjcyVO7nHguiUFTuWQDv/RdjHGqEtm2Xm8/oGIRpaa0iTM/g3u0tAuS9FY3VjX4vmA842B0rmj797zHXETiZNTbzKjz5E44gu3XLdUtJgc6nr00ipqqlHDP/tU04Q88J+6BoXUnSiiXbVcaKVGsIrR5UrN2YeS4nsafZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84TwUps1cgNpaypXvzbOdv3QYHjdjOkOb/pnOVlFbTE=;
 b=g9qIsB7erQ98R7s8HXEXXLVtMH0P98DRANqktHdGmdC1NmgmAhaNPadmsPIMRvAiZROVOxm16bF6JvhJgYbbmpYZo24gUkZbnejC63UU7Zwb2nFvhP0O8U3q2L2romQOks9NzjD8hXWVWwgpDtU4Ba+1ze0kBOVQEcPmFHWQYeToVmtlO1KnMJh2JoryRTSauCgtveKsI5rfcCyXVBbudw1BxOecFUzTcjqvRDsPiHqKcboO/eDkYJeuEQKsRac9zYBQSUBHeMXTBLvhJPxLrov6Io85NijKmwXQLe0lUiU3PPwvW+xjlPBylcQEdq6VnH/luA47canyT7SGtJQTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3366.namprd15.prod.outlook.com (2603:10b6:a03:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Tue, 2 Mar
 2021 18:43:09 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 18:43:09 +0000
Date:   Tue, 2 Mar 2021 10:43:06 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
Message-ID: <20210302184306.ishsga6xkg2glnzj@kafai-mbp.dhcp.thefacebook.com>
References: <20210302105400.3112940-1-jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210302105400.3112940-1-jackmanb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:11fd]
X-ClientProxiedBy: BYAPR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:a03:80::38) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:11fd) by BYAPR11CA0061.namprd11.prod.outlook.com (2603:10b6:a03:80::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 18:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907ff194-fa7f-496f-cd0d-08d8ddab0659
X-MS-TrafficTypeDiagnostic: BYAPR15MB3366:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3366EEABB7C13EC433BAC34BD5999@BYAPR15MB3366.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzv7+K2CGff+1TGnV8W9RRi9a2zrGdptyPyRLCEU5H1vGVUqBTGUWxk0fWYx3vfEErLyPkopysvOABQSd1x1ik2vNme4LjSYdjbQmskJujGyacmcNhS/os7N1du17wf8vZN6ldVBKbIysRuTqCjjM67lk2ZVUzCiTe4uA3DcyDNip88i56897hXvDA380Mf87vnv7ZR4EKKZXEfkYUz+CjQ1QKj2lJ0Np1gXePYfHOk5ZpFcOYJbQ93BJEvcIxY3gFkvKAjWPAJUk26FJeo/0NWqDnVw7Vwo6/Q9fvRpxtW3oO4tm0OJHJiigNL+ycen0zksmeT8ATESicJz2DsuHUVimrZhKpL6RU3cxY+W2Ym0vGUsaLNC5v6o4cx4fbrEqNqFChu3FPMMggMCYnC0gFbmXxWj/yijMH1zjh8ijMmePNCra51gOgbVobXVuKfUmOBj7PDhxBRpMZzU8HJEbXQgtVKzeuJL3eFMe4Zi0RKeOmI/IFEjy1C3xbY21/7dSXkuAAasSdlJRPCSnS/H7DaYTtOwhbVOBM7epMH5+lcrdcAzih8pYNvLwLAuCABy10xiL9gVFoqeX3FkkDa+e5SQ1LWVkfV0YrqMb0gPchjf63VYLkWA42ZxX8ELBe6njDNe3EwYFxq+kknetPswKylkrDKTqq+75LbuuO03RmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(478600001)(966005)(2906002)(16526019)(4326008)(86362001)(5660300002)(54906003)(9686003)(55016002)(316002)(66946007)(66556008)(66476007)(8936002)(52116002)(7696005)(6916009)(186003)(1076003)(83380400001)(8676002)(6506007)(17423001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AQhhBIiPXm+lzfVL6DbKpRxkFNv/PeuFp72ILD5fZtcb5EQEL7y/LykHOY2F?=
 =?us-ascii?Q?1t4U01hxCtMRUHWqHZ6tdCWy/M3+u9m0SzBEBshwpbnv5/qYCwMFNftaKTKO?=
 =?us-ascii?Q?wCfn8x8jrK3mtz1n1AL7KVHGaXKrBlLeDUpFwQeXKfDPSmxOSMmH1MMxQOSW?=
 =?us-ascii?Q?CHUxRE7sXdxwNkLKqTnqcacwwQcxM6gD/Xhg6jCFcJ6HgesARTc4AflsGsky?=
 =?us-ascii?Q?VDc4VIGPeWv+XZh1A9QkL+84PzVTlMiotarOIcOM2R0yV7SoRVXwUydWYOuh?=
 =?us-ascii?Q?fqjGXd0oyEh4/m6w4i4tYdOeT/QFLJGQnRlkF7ieuq+RbfnpoooxrW3KERT9?=
 =?us-ascii?Q?85yaTrLeYA/p401I7wR5jAyn8FTg2ThIxrwGdsHTgibL3xEEBkM6hyMOt3WG?=
 =?us-ascii?Q?gikxuM8K0WOlj9UBjM15TqNHCCzxvlUqeSYHd4ttNjUIqBA3JRXIi8DzBhmp?=
 =?us-ascii?Q?DhrxQf9JnUzAVM5dwrvURbNHHguHRAjyeO5ihs1ToqhZWEW4YwAFjWJoe9QF?=
 =?us-ascii?Q?m1EQf96hOLE/vj4HqcudsqqOCIA4+sm+0No3SYf2uQacwdi+YLTUwYfxNNjC?=
 =?us-ascii?Q?YdUPXhcZ9seTE7IOdS/qlx0edlTY1Nzsun+Z/8QP36Bs1w8tMh71dTKAvmQe?=
 =?us-ascii?Q?NcRcjgaipNyx1rjRkEX+F5NBL84wYnUVOt9xyjrtKZYN+zg53ujVBbRX45T5?=
 =?us-ascii?Q?1DjohuHNUJQImM1LtzuVMKiVthYWu71QkpECA/vm5hdIbKt3owZtr3J0SCw4?=
 =?us-ascii?Q?rpOuiAV4gZ+gY2bgsHSrep5Day5THf6UseD39jmykuHAqspYcfglg+ZXgLeD?=
 =?us-ascii?Q?0Sx64tcCPRvZgiycDhaXckT/ThagOhHZJQa9Y3eCyrDAMmyE4SRh72XyvcE0?=
 =?us-ascii?Q?Uv0JLbUNdD/BmHcXu+Dt3zTf95ToGZN+qm650Yixj1BmESZN71XmC2sPqVQ4?=
 =?us-ascii?Q?tTT9tNQNb2LMUs6qQO5iRSdDdIlfHrlta2sh6OQ9zFLDtX8PFPIMKG2DfKwI?=
 =?us-ascii?Q?j8X9f9V02sEEQNFEj4ggiVuywIlEnet9T0mH1lyELdgM0PYlbM03YcmPdwUq?=
 =?us-ascii?Q?3pE9TjtQzok8uGVFrg9/b2ZN+4HbrO4PBy8JA1CQVxF1ujXpCPerWHHNmWT3?=
 =?us-ascii?Q?JZy3EFKzST4p+JJcxttqH3e37OuTC2/OpeeiGkszRtSTBP1GU7mEtkq6dlm2?=
 =?us-ascii?Q?rZ37KJCfjS5qU5LYk4nRMl4W1qZhumLZMkothr9n+zZJ/hIeibvKC7hf39PA?=
 =?us-ascii?Q?4KbEUB0ofmJEVko+FMW4nYZ7iImXj2/n9OGpdXomcFRlKkCYcR5tDZXLLuI3?=
 =?us-ascii?Q?bZRHOseR+47ww1VjtiwDfkGr4lyc0QvjWM3eqZTqGIJ2Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 907ff194-fa7f-496f-cd0d-08d8ddab0659
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 18:43:09.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZQanyMjw3cUMbose/xSIm9XGUQ+RKoZ/SRQuVIsRGuYBPJsw38TiSAwTMrYox1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3366
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 02, 2021 at 10:54:00AM +0000, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> 
> Differences v4->v5[1]:
>  - Moved the logic entirely into opt_subreg_zext_lo32_rnd_hi32, thanks to Martin
>    for suggesting this.
> 
> Differences v3->v4[1]:
>  - Moved the optimization against pointless zext into the correct place:
>    opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
> 
> Differences v2->v3[1]:
>  - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
>  - Added extra commentary on bpf_jit_needs_zext
>  - Added check to avoid adding a pointless zext(r0) if there's already one there.
> 
> Difference v1->v2[1]: Now solved centrally in the verifier instead of
>   specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!
> 
> [1] v4: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
>     v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>     v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>     v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> 
> 
>  kernel/bpf/core.c                             |  4 +++
>  kernel/bpf/verifier.c                         | 17 +++++++++++-
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
>  4 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0ae015ad1e05..dcf18612841b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
>  /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
>   * analysis code and wants explicit zero extension inserted by verifier.
>   * Otherwise, return FALSE.
> + *
> + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> + * you don't override this. JITs that don't want these extra insns can detect
> + * them using insn_is_zext.
>   */
>  bool __weak bpf_jit_needs_zext(void)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4c373589273b..37076e4c6175 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11237,6 +11237,11 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>  	return 0;
>  }
> 
> +static inline bool is_cmpxchg(struct bpf_insn *insn)
nit. "const" struct bpf_insn *insn.

> +{
> +	return (BPF_MODE(insn->code) == BPF_ATOMIC && insn->imm == BPF_CMPXCHG);
I think it is better to check BPF_CLASS(insn->code) == BPF_STX also
in case in the future this helper will be reused before do_check()
has a chance to verify the instructions.

> +}
> +
>  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  					 const union bpf_attr *attr)
>  {
> @@ -11296,7 +11301,17 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  			goto apply_patch_buffer;
>  		}
> 
> -		if (!bpf_jit_needs_zext())
> +		/* Add in an zero-extend instruction if a) the JIT has requested
> +		 * it or b) it's a CMPXCHG.
> +		 *
> +		 * The latter is because: BPF_CMPXCHG always loads a value into
> +		 * R0, therefore always zero-extends. However some archs'
> +		 * equivalent instruction only does this load when the
> +		 * comparison is successful. This detail of CMPXCHG is
> +		 * orthogonal to the general zero-extension behaviour of the
> +		 * CPU, so it's treated independently of bpf_jit_needs_zext.
> +		 */
> +		if (!bpf_jit_needs_zext() && !is_cmpxchg(&insn))
>  			continue;
> 
>  		if (WARN_ON_ONCE(load_reg == -1)) {
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> index 2efd8bcf57a1..6e52dfc64415 100644
> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> @@ -94,3 +94,28 @@
>  	.result = REJECT,
>  	.errstr = "invalid read from stack",
>  },
> +{
> +	"BPF_W cmpxchg should zero top 32 bits",
> +	.insns = {
> +		/* r0 = U64_MAX; */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
> +		/* u64 val = r0; */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> +		/* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
> +		BPF_MOV32_IMM(BPF_REG_1, 1),
> +		BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
> +		/* r1 = 0x00000000FFFFFFFFull; */
> +		BPF_MOV64_IMM(BPF_REG_1, 1),
> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> +		/* if (r0 != r1) exit(1); */
> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
> +		BPF_MOV32_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN(),
> +		/* exit(0); */
> +		BPF_MOV32_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +},
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
> index 70f982e1f9f0..0a08b99e6ddd 100644
> --- a/tools/testing/selftests/bpf/verifier/atomic_or.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
> @@ -75,3 +75,29 @@
>  	},
>  	.result = ACCEPT,
>  },
> +{
> +	"BPF_W atomic_fetch_or should zero top 32 bits",
> +	.insns = {
> +		/* r1 = U64_MAX; */
> +		BPF_MOV64_IMM(BPF_REG_1, 0),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> +		/* u64 val = r0; */
s/r0/r1/

> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
> +		/* r1 = (u32)atomic_sub((u32 *)&val, 1); */
		   r1 = (u32)atomic_fetch_or((u32 *)&val, 2)
		   
> +		BPF_MOV32_IMM(BPF_REG_1, 2),
> +		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> +		/* r2 = 0x00000000FFFFFFFF; */
> +		BPF_MOV64_IMM(BPF_REG_2, 1),
> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
> +		/* if (r2 != r1) exit(1); */
> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
> +		/* BPF_MOV32_IMM(BPF_REG_0, 1), */
> +		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> +		BPF_EXIT_INSN(),
> +		/* exit(0); */
> +		BPF_MOV32_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +},
> 
> base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63
> --
> 2.30.1.766.gb4fecdf3b7-goog
> 
