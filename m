Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB12326770
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBZT1d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:27:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhBZT1b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 14:27:31 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QJP1bS002197;
        Fri, 26 Feb 2021 11:25:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NPghPJYr7zAdtSbp3YSSQUBwnAhgka/AddRhtIkgMcY=;
 b=XN/IU9bRcfZYH5exVSDgfZxROcsiPoQTnSK8tVNTGQnGiqGMR3U6Np+mi5iy7IHHuQBi
 7E6kEavbiPtfugmYUMq1AwlUgdVnT61e/t+Zq5cZQ9oZzTzW7VPYX4neAxm1n1cQsfBs
 XYIIo0C6oLMX/C3sxQb3uKB+yX5FrwTk0ZE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfkdu1u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 11:25:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 11:25:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIQiuGbjLiJfWFeo/ZLzmRb8929DV2p8y7YL1tTrJSsbg/ew6zUA2tNjAmNcc1gB0PONLb9nmB/HgJmhBR6jIyfv+e8Q950ehD1r7fkTRPWnxZw6Z3n+O57ucoFfLK1WojP2MgvXN9iJjXwcEZEN4CRHfERxn1WzWuHO138aQYKh1VedmVqHoAhxNZAp3TbhlDpYZhVHyCePpI7shU1tAgGQmyazfEcH6jNjJEPqWNdCJ4rJ/oKNTYV4eNyJ8ZusEYZUDxDcdlwHGFG7wHGFrDPVCJQEzCfV1rftdfq3ReDwE5BP5aNye8y0/So4JPB7rQTXdazEm89CpjodEK3s6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPghPJYr7zAdtSbp3YSSQUBwnAhgka/AddRhtIkgMcY=;
 b=dtsvva/XSx4pK8WHz4rqT0Zn9xzXF9nAt/Vje8rfLMIm37jNnSUU4OFtowkIGh+fVi5nUz6vM7QkD0cc87C+1PDWBsqv/u+IWcnULSk9LOO8Uyd9KKZsTGouzftAtsBzsFNzF4QPPzoYii3CJxqCn8Z+hHNnNwAaELTrokxpE0UonYsV7H/enXml17AQoOX5Oa4pD9SWIM+ubE9bGeaYvDm7x1F0HA6Rxyxj+xdfxZGZY3zWaMYMfQmuGh5lYuUomIvmkZVHv3MFyQUSdZo+os58vH18juGpwbkakVSFw71GDy8f0FKSrficRBd6Biu6izTHPLOex95CfZ4C2lYkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB4118.namprd15.prod.outlook.com (2603:10b6:a02:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 19:25:38 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 19:25:38 +0000
Date:   Fri, 26 Feb 2021 11:25:35 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH bpf-next] bpf: Account for BPF_FETCH in insn_has_def32()
Message-ID: <20210226192535.vjlrp5xylajtesoe@kafai-mbp.dhcp.thefacebook.com>
References: <20210224141837.104654-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210224141837.104654-1-iii@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:59eb]
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:59eb) by MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 19:25:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf5440a-ba21-4533-2942-08d8da8c4c3b
X-MS-TrafficTypeDiagnostic: BYAPR15MB4118:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4118A0E739FA56481B620D61D59D9@BYAPR15MB4118.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNAMilTS1xxkEOQFYiSPlBV4D2R8nbslV4O77hqvVMB+8hc5BnJyjGDXpU9Tm1ATteZMZ+VbWBJQd9ugJSHh03Isq4Z8UTVmBpX2kIhHt9U8byYhSBnnn44MbumMAYhAz9zO3krC0Kwm/uah+rPeeTireipXHSzKu/h8c/WJ38F/RKu5Mn5d9Xoe1boAl9LlglGWawQ7+E2guwjn9t5S/yIRVxFGJYueCcokPWRsgjlSd1MP8eq5nibjuRoDkr9YB5GD6yNKX+6w/3GSNA86wNQ6chfUudcZ7v2vIaRxJDu7L7T6dwmsVTHOqfSKwCAKgPLnWQA/FPQBnawpakmsKi13mnSdQolucBQVGQ+bfy97wBE963SQKPizTFPCCv5sy7jpkIpOyvXzRJeS92dQOvmpp3bfENTheGlHwL/zT78kSw562GGSE7KkHlHuNti5K+x7tBsF6trNGgFay+Oe4OB6JJgTv0zQFqMGwyAo/j6Yn2YeVpCqJq0ambxQphtywq9iAQu4wEZpCDjxWljsKm17vh07O9UttaIUSwpRBqObH+LJapmrKZgpFd+DfZ6DD9xWvZDrP/0e3VOWxzqq6k50CSX/0lzpnS3n4aRYglw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(66556008)(186003)(86362001)(6916009)(7696005)(5660300002)(8936002)(66946007)(8676002)(4326008)(2906002)(478600001)(55016002)(16526019)(54906003)(52116002)(966005)(83380400001)(66476007)(9686003)(6506007)(1076003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jra2IWQ14HTCfVoCgVgpGZ2qups44bjVVtZ/u5Q0CM/AZlaekLqQ6qLrlGb4?=
 =?us-ascii?Q?V5EYzhoL4zzMnwFnO0IAGv8cVw0Y8JTT9lIQ5YRCqXxHo4Z7CscGbBFuBqz5?=
 =?us-ascii?Q?ggPu0+C9ksycjK5YgRSmGj4grQSvINmUvwMnqNuI26wPmLUz8dc9eaGay8DS?=
 =?us-ascii?Q?+lkiJH/eH5ECtZIpjZPdB2oHHSlKH61YmKTalFuQ5Scsq32wDxB3l4o7Qwq4?=
 =?us-ascii?Q?RAs/Fu4ytg2Fe71AVk7nMFWNUVFknTQio+YIACI3OzjH60Y1Nn96bPXTIFwe?=
 =?us-ascii?Q?rsQwmr78HttOlrUAUjh8p+ToNK9DSM1KNZwXNZdxspSTby8j22ZNXChOHTWW?=
 =?us-ascii?Q?QnwyrGyD19ICILRk4v5g/DaBC7tHBixHIPO4Y/Id1hAWLrbducAlrVBupvZR?=
 =?us-ascii?Q?phdZoxK776CFqqBxsmxIfhryNYXQ+sb5gTursiHV494l/wEG7mIXhRd2xJr0?=
 =?us-ascii?Q?YsnFrg9YjFY0EIBXkDhJXMqG+juTMY4W6l9HT/3RdX6mUffsOYPiQkd3AUF8?=
 =?us-ascii?Q?SlX4ViKF9Cke4YMRy2bCa5btyS4Y3efH0Iar9tH8Taoq6sAm1PzYWkj9YtmK?=
 =?us-ascii?Q?MEhP2LNZaV8c9qIotLghbbx29oLGOAMVzQUIqiFvmYxbv8gS8q3zCGcEY8jz?=
 =?us-ascii?Q?hQKA5/dSD0ch/9xJt0RVJnwYItiSDrsMe6OhZ2/CCqB7IuHARUYxDfte0svW?=
 =?us-ascii?Q?MB//HFEtAt1Ny0uoa0BaPDbhF4XiM0ayrFsoKyog3JuxlichTBavZ8TXmjLz?=
 =?us-ascii?Q?WbuMu5wXi32YV0ap2tHm19UgD5zM7bOjyX2t0X9sj9K5wBWzb1OjVSdD0chu?=
 =?us-ascii?Q?LI/z2uRyZPBJ/Yntrh1eVwqkcBenBMdPKMfdjhuXLAZRypQxOcBXWwdnePBX?=
 =?us-ascii?Q?rs1xPGZQECRglr7yho+2osRwgiGnLUHhxEVKrlhh1uGVNmV+mlvnvuEGg/tg?=
 =?us-ascii?Q?v9sZtfb474AGAfQjOgMEcKljDlQjiW2AEPK9SQgj0UDazRxyoR8pGJGEQa3/?=
 =?us-ascii?Q?W0uAhYmAPZYEhEmLC35fheg+8DOa2slNDN0odOZcPprUf8TpcbKlS/2BLQNc?=
 =?us-ascii?Q?5KiqBhdyUH8koWwJuvzSGL6j6tonVS8GXzPNdAvDdr2bHeTmui4nppolIWwc?=
 =?us-ascii?Q?puDhrvW2q5/GQCcBltZ3MGTaHslTpTIsgm8uKX2vlbBR58ANHt1wPgyHTtTZ?=
 =?us-ascii?Q?R8U3e5X3DB31K97UDH+YslodGZhCcbelglDyaRkOPoImMERCAhiUmolyWudB?=
 =?us-ascii?Q?rmipl5duGjA3on8s2Q10GkOt9cAQIFkqvZHnF66DtL2BYyWPUOMYYBTm62q9?=
 =?us-ascii?Q?jDQy0/2ncjG3CuH1cAChKHViCwQiFm0Ww1+TuLKrimPlww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf5440a-ba21-4533-2942-08d8da8c4c3b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 19:25:38.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJfgA1PkOl7ZP5fGh5JEbwCH+iuqAdxNkge5eAPxf1Fg4I1+glSoCgRCr/tnHnTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4118
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 03:18:37PM +0100, Ilya Leoshkevich wrote:
> insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
> adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
> This happens because insn_no_def() does not know about BPF_FETCH
> variants of BPF_STX.
> 
> Fix in two steps.
> 
> First, replace insn_no_def() with insn_def_regno(), which returns which
> the register an insn defines. Normally insn_no_def() calls are followed
> by insn->dst_reg uses; replace those with insn_def_regno() return
> value.
> 
> Second, adjust the BPF_STX special case in is_reg64() to deal with
> queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
> information is no longer available. Add a comment, since the purpose
> of this special case is not clear at the first glance.
Thanks for the fix.  A few nits.

> 
> [1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/
> 
> Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
Is it fixing this instead?
5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")

and bpf instead of bpf-next?

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 65 ++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1dda9d81f12c..f4df805d6bfd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1703,7 +1703,10 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	}
>  
>  	if (class == BPF_STX) {
> -		if (reg->type != SCALAR_VALUE)
> +		/* BPF_STX (including atomic variants) has multiple source
> +		 * operands, one of which is a ptr. Check whether the caller is
> +		 * asking about it. */
nit. A newline for "*/".

> +		if (t == SRC_OP && reg->type != SCALAR_VALUE)
>  			return true;
>  		return BPF_SIZE(code) == BPF_DW;
>  	}
> @@ -1735,22 +1738,33 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	return true;
>  }
>  
> -/* Return TRUE if INSN doesn't have explicit value define. */
> -static bool insn_no_def(struct bpf_insn *insn)
> +/* Return the regno defined by the insn, or -1. */
> +static int insn_def_regno(const struct bpf_insn *insn)
>  {
> -	u8 class = BPF_CLASS(insn->code);
> -
> -	return (class == BPF_JMP || class == BPF_JMP32 ||
> -		class == BPF_STX || class == BPF_ST);
> +	switch (BPF_CLASS(insn->code)) {
> +	case BPF_JMP:
> +	case BPF_JMP32:
> +	case BPF_ST:
> +		return -1;
> +	case BPF_STX:
> +		return (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			(insn->imm & BPF_FETCH)) ?
> +		       (insn->imm == BPF_CMPXCHG ? BPF_REG_0 : insn->src_reg) :
> +		       -1;
A bit hard to read with multiple "?" stacking on each other.
How about using a more verbose "if else" here?

> +	default:
> +		return insn->dst_reg;
> +	}
>  }
>  
>  /* Return TRUE if INSN has defined any 32-bit value explicitly. */
>  static bool insn_has_def32(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
> -	if (insn_no_def(insn))
> +	int dst_reg = insn_def_regno(insn);
> +
> +	if (dst_reg == -1)
>  		return false;
>  
> -	return !is_reg64(env, insn, insn->dst_reg, NULL, DST_OP);
> +	return !is_reg64(env, insn, dst_reg, NULL, DST_OP);
>  }
>  
>  static void mark_insn_zext(struct bpf_verifier_env *env,
> @@ -11006,9 +11020,10 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  	for (i = 0; i < len; i++) {
>  		int adj_idx = i + delta;
>  		struct bpf_insn insn;
> -		u8 load_reg;
> +		int load_reg;
>  
>  		insn = insns[adj_idx];
> +		load_reg = insn_def_regno(&insn);
>  		if (!aux[adj_idx].zext_dst) {
>  			u8 code, class;
>  			u32 imm_rnd;
> @@ -11018,14 +11033,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  
>  			code = insn.code;
>  			class = BPF_CLASS(code);
> -			if (insn_no_def(&insn))
> +			if (load_reg == -1)
>  				continue;
>  
>  			/* NOTE: arg "reg" (the fourth one) is only used for
> -			 *       BPF_STX which has been ruled out in above
> -			 *       check, it is safe to pass NULL here.
> +			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
> +			 *       here.
>  			 */
> -			if (is_reg64(env, &insn, insn.dst_reg, NULL, DST_OP)) {
> +			if (is_reg64(env, &insn, load_reg, NULL, DST_OP)) {
>  				if (class == BPF_LD &&
>  				    BPF_MODE(code) == BPF_IMM)
>  					i++;
> @@ -11040,7 +11055,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  			imm_rnd = get_random_int();
>  			rnd_hi32_patch[0] = insn;
>  			rnd_hi32_patch[1].imm = imm_rnd;
> -			rnd_hi32_patch[3].dst_reg = insn.dst_reg;
> +			rnd_hi32_patch[3].dst_reg = load_reg;
>  			patch = rnd_hi32_patch;
>  			patch_len = 4;
>  			goto apply_patch_buffer;
> @@ -11049,23 +11064,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  		if (!bpf_jit_needs_zext())
>  			continue;
>  
> -		/* zext_dst means that we want to zero-extend whatever register
> -		 * the insn defines, which is dst_reg most of the time, with
> -		 * the notable exception of BPF_STX + BPF_ATOMIC + BPF_FETCH.
> -		 */
> -		if (BPF_CLASS(insn.code) == BPF_STX &&
> -		    BPF_MODE(insn.code) == BPF_ATOMIC) {
> -			/* BPF_STX + BPF_ATOMIC insns without BPF_FETCH do not
> -			 * define any registers, therefore zext_dst cannot be
> -			 * set.
> -			 */
> -			if (WARN_ON(!(insn.imm & BPF_FETCH)))
> -				return -EINVAL;
> -			load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> -							   : insn.src_reg;
> -		} else {
> -			load_reg = insn.dst_reg;
> -		}
> +		/* If no register is defined, zext_dst cannot be set. */
> +		if (WARN_ON(load_reg == -1))
May be a WARN_ON_ONCE and then followed by verbose(env, ...).

> +			return -EINVAL;
-EFAULT instead.  It is what most other places return also during verifier
internal error.  There are a few places return -EINVAL and probably we should
change them in the future.

>  
>  		zext_patch[0] = insn;
>  		zext_patch[1].dst_reg = load_reg;
> -- 
> 2.29.2
> 
