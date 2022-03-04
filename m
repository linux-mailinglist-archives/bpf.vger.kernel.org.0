Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E844CDF35
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiCDU3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCDU3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:29:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DF156979
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:28:52 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQVL7015645;
        Fri, 4 Mar 2022 12:28:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xEk5so0ZOPtQFiMBFDv6NmE60xU1VRLQQdK64cnLbEc=;
 b=DWRNF/+O772F+TNsC83ONz4+G1Bl4knBy/4rgAYfiAiQ4fPUSBnrVj7/TwDSsjDzS/g7
 1zL2XtwwGdor49ard7s1vF6RwtCyr4Lxrdg3TVEfVXW04dnpDKfouBnlA1Qn6+Xyv/UU
 sHS2O8gnlN2z3KECwwy0xNj7pf0frzXmf1c= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4jnqx67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 12:28:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf75m1yA45JmGYv9ISd5k5hYXrNZ3Amgi8TSNlK03BfIuP21Bznkx22x4LeL6oB5SDqcPNieBXUQ8GoMbxGfSszxrm/Jo9IEKq8m/mDO2PxHNOw/dq82ox5PEjYO382fu7eIGJy1Cs36Orp0M6A3fGDVPycy9V2SIGm6GPasH/3AhdrtrzTZOaeuy/Gtz9VZDdCg6Ze/oZbvfE6yfjD9Y2AHXZOHATA+QuSaU6kfzXWSBqgxDyTbHKTUXB51rW8S4LCLl0qMXz8FRImumtxy4AGL/ySv1t4dFH2eCoS06XgoI1P+IDvu0dk0J/3ik/cj1Ke8Ecn9K5LUX5muSVVEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEk5so0ZOPtQFiMBFDv6NmE60xU1VRLQQdK64cnLbEc=;
 b=imCy73Euy4jS5OdguJcpXWiQUJBEqSR5SQwmo/EB/kGCLUSxf1MQuZE7CSjlbushlU6Y9RcW1hIpk4NsmtJHuANFpxHzFqjNad31B6uL5vdZ+RBdr4YPvUybGNLihjNMd9j50S53uz6psiIfdnkQIRTjLAcffZoRRBsHULOzdVdO12rfXQ6EaW6TDtIT/4cT/5w00lnXXpEVWHxxk4EouyD9kwxpcRWXCXDif0MdH0KQRRZ8at5nG6StX10gvo0nokEQnurgAXZoGjcx4QBybSU20dNV2ZqTqEvMzqKKomvVXdx38NX3LQCy9pz6ploqx5bkFVNFfglkjpP3M2R68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN6PR15MB1636.namprd15.prod.outlook.com (2603:10b6:404:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 20:28:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 20:28:33 +0000
Date:   Fri, 4 Mar 2022 12:28:30 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000508.2904128-5-memxor@gmail.com>
X-ClientProxiedBy: MWHPR18CA0063.namprd18.prod.outlook.com
 (2603:10b6:300:39::25) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1cfb07-06bc-4e13-e665-08d9fe1d8da0
X-MS-TrafficTypeDiagnostic: BN6PR15MB1636:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1636EF6717D642725FB5B406D5059@BN6PR15MB1636.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbMd17GwgN1SZqWXxno5BGnQMmGEIveVag3OaO3AgXgHd1fp+P+uc5XTw2gIbs9/gV/tsg3G3qwWE8rYH03Px+bPA/S2b1R+qUF2spzwh3aNGjPbSOeLeHoeShyJquldP8CVmBMgLgmBlXiK1U+KYUM7OY+MugJ0DZQuyFWa0PND7KZHmaVe59e0yldYa8KkL4iQIcAEvkUeFQF0g0SDxzu9+BwEckbT6RAuj3i5Awfk872581EnBInpbCilosf0Tf1jk+U4I8GdGaAiX4DRbNutokkvV8Stjs9JYxngt4hS5W6jcT32UC97e82GfQkDOVb/3H+S9IHL7XZJY1tNocgIZ56FDoK71LHgUUu5sdbURbQn/N5fKr3Jykdx5gq4PCEXP6bYImLfgvcPep4CvHWhJcNWkLwZxwprC8BQASif7wrDWyxX9ota7b0k/xcFEpwi+V5ZFFw4KJ+gNCJGXCcBbXJfkmvs5M63e4liVIH9n4HY3+/5c39+CEt+PjhbQ7t8fwQsQ6iYI9BRM7w5grBkFZDEUjU2ubuJN262VvIfhLstStIrnrVvTSQOTfNHnoll99rUnK+YGC1bogXm0XDwgGL8IGRkYUPoeKGGcSmdrRQgkWhtGWeQEG+zJnhpkEyaG0oTh8njt/7LSNPi9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(6486002)(52116002)(6506007)(4326008)(66556008)(8676002)(66946007)(9686003)(6512007)(66476007)(2906002)(38100700002)(8936002)(86362001)(1076003)(83380400001)(6916009)(54906003)(508600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eUyOVn0pS48Lq0Gl3WgtxfKRE7ZY9S5gKODtYLB6A4bp2yBtnMExNmJMbM0S?=
 =?us-ascii?Q?JfrBNhKdwZHYUiBBOpcezLcro38z/sTab5OpLI8df50wtXSwnKeV+R63/y9t?=
 =?us-ascii?Q?H/tjObSgGHC7V5ZTbfJVYk/KGKK0BgUlxmuMBhF3eZmvetimTxLboQUSptex?=
 =?us-ascii?Q?bt8nipF6ZKk08pSgdKlgAUlkZcugEwLYd7ewYrkvWpe3E6In4OBIzi89en+o?=
 =?us-ascii?Q?Zd4/vKsO7pBpJ/Pbaoduwyo9y5uUGdAeedHi/4jednqSPrzoiVULpP4lcA6A?=
 =?us-ascii?Q?4XyrSX+lqOlEhWDagKqzE/BZn1Gwwul00Ucwjkg9Bb3hqkAM0pSWzW6mj1Au?=
 =?us-ascii?Q?PzdK5I84FxHk/rObOEa8btDwgV2ybrzgbelmBhF0HdPr81ty91KYayYPbpzH?=
 =?us-ascii?Q?eRAfC2wzWJEmckvjUUKG9qmQRIKKnpF+p07M+5ZTY1ScdG/kePpnkbBdMwrZ?=
 =?us-ascii?Q?QLdJU5uNC+BIBB+NEyV0s03BVQUBdHhaDK44QJiH/G0P/Z3GZ4zqnMtj3WZ/?=
 =?us-ascii?Q?D+YLT5fDknCtsDSWb59QSffBQg5/aWTAjNtmmLVvSm1bQlbpI/bASYCHMcd3?=
 =?us-ascii?Q?hhJ1DPFdXMZ5DtkK/04VJWSsw/VvCAa5aOSZM5tV247vtvycvdmwKSroiVqN?=
 =?us-ascii?Q?S7A4R09W+sPS/McnNBBWub+jOCn5Qt9n4zKNLHl9kw6391AZVIjALy6emI1H?=
 =?us-ascii?Q?FoIr+X26BqbB3MIv46Zp+t5gu8qmEjPhunD4qSE0w+Rl/GQhWA1ST3AKQCsv?=
 =?us-ascii?Q?Ipm6H7wzgycpu9JAHA1mi7/AEKkm/90G3MkOp9UItrty55Huyn3zJT1+Gqrs?=
 =?us-ascii?Q?aO4wsjLjJgZpUjdWM8DVHjih58TPrkw21eLQ4aA/P5H27cfJQfR7RhNzvGav?=
 =?us-ascii?Q?FPbpHN6v416MepzcO2aaxlCsVjqFVJzdy6hoF+l97iqLK29f4F3eHQFtPwCY?=
 =?us-ascii?Q?EO//tdxD+Hv5UE9Ppr7ZhwNqT5mCtcS0xKYkaZb0F0q4RDpTfx33rbAPH3lN?=
 =?us-ascii?Q?YFDvlehC8QEe/kDyyDzief+NsZ8nE+4OMouATZF7C9JxEEMRGpai3qs75K5d?=
 =?us-ascii?Q?mSMCBynyfnJ4BCfJpRvqpxdeDeQKzJxsN3LHJWBRUJtRQ0lofCBCYm9+Fxxh?=
 =?us-ascii?Q?zvx0dQBk6cMYFJqmnphSyzvhJ+BivJSHaOuTr9Ebih4m6Tykc6p6kO9I8StK?=
 =?us-ascii?Q?zQKilyiCftf00MuAqJ2BurI4R9muLxxOu4RNlo7EeJSlA70hOWfYpKYDNh29?=
 =?us-ascii?Q?ob+uC/dUk4uBmUkrDl+nX/+A/eTR8D3Mo6hjPwP2tjAqSZQ2abPmlnMrjjas?=
 =?us-ascii?Q?kW1Fa6dbAvmTWul0nR0RqKClRFDbVR0HZt4tmQ65kEoUD2zA+heXg/MveqvG?=
 =?us-ascii?Q?1b5OhU+rG1gPaHF/jF07VU3zDw8k7QgiXXjiIVSvz2xmC/qDoaxnlW/Vrz+T?=
 =?us-ascii?Q?58xDToUIGunxXWDxnfXHHsSgo97+VpSz1jkQoAikj5wyQng1i7k5kPGGXV/C?=
 =?us-ascii?Q?xv241lTEwN9Y+mpEjDzSruip0ZuI2HOsFuS1RaQf8VUrA4FYwzyykTWWJM7a?=
 =?us-ascii?Q?x/NjW7GhWEBDc/7AMSsbodzycPyHhh8zx971URPvXMk334RF+CoQjb9YFOeZ?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1cfb07-06bc-4e13-e665-08d9fe1d8da0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 20:28:33.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA0FreiPhtUXBYdd16u/MJVardFbTZgIZRj+Jc3i20Q7D5mnP6HWTZOyZ/7BZLcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1636
X-Proofpoint-GUID: kNkzQ0ZZZD9A8kDFYIX8HPWhvShVmCbY
X-Proofpoint-ORIG-GUID: kNkzQ0ZZZD9A8kDFYIX8HPWhvShVmCbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040101
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 04, 2022 at 05:35:04AM +0530, Kumar Kartikeya Dwivedi wrote:
> Let's ensure that the PTR_TO_BTF_ID reg being passed in to release BPF
> helpers and kfuncs always has its offset set to 0. While not a real
> problem now, there's a very real possibility this will become a problem
> when more and more kfuncs are exposed, and more BPF helpers are added
> which can release PTR_TO_BTF_ID.
> 
> Previous commits already protected against non-zero var_off. One of the
> case we are concerned about now is when we have a type that can be
> returned by e.g. an acquire kfunc:
> 
> struct foo {
> 	int a;
> 	int b;
> 	struct bar b;
> };
> 
> ... and struct bar is also a type that can be returned by another
> acquire kfunc.
> 
> Then, doing the following sequence:
> 
> 	struct foo *f = bpf_get_foo(); // acquire kfunc
> 	if (!f)
> 		return 0;
> 	bpf_put_bar(&f->b); // release kfunc
> 
> ... would work with the current code, since the btf_struct_ids_match
> takes reg->off into account for matching pointer type with release kfunc
> argument type, but would obviously be incorrect, and most likely lead to
> a kernel crash. A test has been included later to prevent regressions in
> this area.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/btf.c             | 13 +++++++++----
>  kernel/bpf/verifier.c        | 27 +++++++++++++++++++++++----
>  3 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 38b24ee8d8c2..7a684050495a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>  		      const struct bpf_reg_state *reg, int regno);
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
> -			   enum bpf_arg_type arg_type);
> +			   enum bpf_arg_type arg_type,
> +			   bool is_release_function);
>  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7f6a0ae5028b..c9a1019dc60d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> +	if (is_kfunc)
> +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> +						BTF_KFUNC_TYPE_RELEASE, func_id);
>  	/* check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
> @@ -5777,7 +5780,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  
> -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> +		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -5809,7 +5812,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			if (reg->type == PTR_TO_BTF_ID) {
>  				reg_btf = reg->btf;
>  				reg_ref_id = reg->btf_id;
> -				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
> +				/* Ensure only one argument is referenced
> +				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> +				 * on only one referenced register being allowed
> +				 * for kfuncs.
> +				 */
>  				if (reg->ref_obj_id) {
>  					if (ref_obj_id) {
>  						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> @@ -5892,8 +5899,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  	/* Either both are set, or neither */
>  	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
>  	if (is_kfunc) {
This test is no longer needed?

> -		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> -						BTF_KFUNC_TYPE_RELEASE, func_id);
>  		/* We already made sure ref_obj_id is set only for one argument */
>  		if (rel && !ref_obj_id) {
>  			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e55bfd23e81b..c31407d156e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5367,11 +5367,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
> -			   enum bpf_arg_type arg_type)
> +			   enum bpf_arg_type arg_type,
> +			   bool is_release_func)
>  {
>  	enum bpf_reg_type type = reg->type;
> +	bool fixed_off_ok = false;
>  	int err;
>  
> +	/* When referenced PTR_TO_BTF_ID is passed to release function, it's
> +	 * fixed offset must be 0. We rely on the property that only one
> +	 * referenced register can be passed to BPF helpers and kfuncs.
> +	 */
> +	if (type == PTR_TO_BTF_ID) {
> +		bool release_reg = is_release_func && reg->ref_obj_id;
> +
> +		if (release_reg && reg->off) {
iiuc, the reason for not going through __check_ptr_off_reg() is
because it prefers a different verifier log message for release_reg
case for fixed off.  How about var_off?

> +			verbose(env, "R%d must have zero offset when passed to release func\n",
> +				regno);
> +			return -EINVAL;
> +		}
> +		fixed_off_ok = release_reg ? false : true;
nit.
		fixed_off_ok = !release_reg;

but this is a bit moot here considering the reg->off
check has already been done for the release_reg case.

> +	}
> +
>  	switch ((u32)type) {
>  	case SCALAR_VALUE:
>  	/* Pointer types where reg offset is explicitly allowed: */
> @@ -5394,8 +5411,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	/* All the rest must be rejected: */
>  	default:
>  force_off_check:
> -		err = __check_ptr_off_reg(env, reg, regno,
> -					  type == PTR_TO_BTF_ID);
> +		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  		if (err < 0)
>  			return err;
>  		break;
> @@ -5452,11 +5468,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	if (err)
>  		return err;
>  
> -	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> +	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
>  	if (err)
>  		return err;
>  
>  skip_type_check:
> +	/* check_func_arg_reg_off relies on only one referenced register being
> +	 * allowed for BPF helpers.
> +	 */
>  	if (reg->ref_obj_id) {
>  		if (meta->ref_obj_id) {
>  			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -- 
> 2.35.1
> 
