Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF132636FF
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIIUDi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 16:03:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIIUDf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 16:03:35 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089Jwluv011789;
        Wed, 9 Sep 2020 13:03:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dof2PRmXLbPBXekbFamFcuawz4PlAT9kG6uyQsV6IPg=;
 b=GGhY3z1huNlD5uzsZn31dPZMJ9FL5QRTqueLKyYH0YUC2pqWThT1WwW00VKCj0c8z8UQ
 XuJ7s7LQHwCl/3UTXSXydUtVPokUq4BGcvxX0NIOaTQhsUS6tkxx83g67huQgsb2KjON
 fcBzEoacj/sQp6WKccvzSwkXufU0zKCan5w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctxn9ars-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 13:03:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 13:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II+3HFJ+aiA8OziHvyzh3S2hRUW+6HyJwWEvFWGfScYvKVvG9StwQj8jX1NPsJ1l7yjq3a5jv4LGul1Pwhc2oHJgijyeXthd5hH/kqDeDJaWeUeELQYzJQLpLCW/wGyh/zNX4tVlldbKOMVONo35XqelPAGCOBW2AktXCWPPeabxl2NDlaimulXXQWDmPbrPrvgPIWjk1hSg/mTEsfhkQU63tlBE5hZqZExfvxoRHWygltLXLielHpokS1LNhmdL8V84pRuzRrOEXz0jonUz8du+di43V2pxdcnm6YIsDSY0rbIRy9gRgLoCZVsY2ezhh+irZC/SDN8ConRmGK7pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dof2PRmXLbPBXekbFamFcuawz4PlAT9kG6uyQsV6IPg=;
 b=e3r1HnYjQDocaVMgwRpooB254gnXOO22T99fxVHjN9lVJi1mBeGziD+WgLGxHsG4+MVZVQVD2enc/mom4l2n3qf3AfUCuyBSPR3ZO9zUWSyXQLxgApiwDu4ORPn/V91BOKOUjxlrR/yLS47aR16hUlZOOO3KCk0rZaOsIkPSISuUKFN9TnODTANEiY6l/4zGjySL3U9dvBu1K49aER/c2MVW+Axmq8S/7zrOJMwPYfO4BcruSswrcu2U07V3CMAoJnFMi9+J9aNSexu0ASRyvI9QGOiXofzNF+hTVwJMSkgKZm7IPnR/kzkPjz+ZIbZpX8nOHZ74uVhTDRjLHG/gqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dof2PRmXLbPBXekbFamFcuawz4PlAT9kG6uyQsV6IPg=;
 b=SLRRc3A6yC9aJDAwY9Agpu9TgynnzYtw8GELm2pD/nO+f1WLpZKZoUBJcPOu0PM1TVll+9OBfJ6hJtai7Amdb9A3bbjVpT3IsI0aYhK4ekDMR9zWPjyROgbacMIKKdGXGZ+s1w9+/kaWASYDejp/fWRWbdrRAID6r8ibNNHu1Uc=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2198.namprd15.prod.outlook.com (2603:10b6:a02:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 20:03:16 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 20:03:16 +0000
Date:   Wed, 9 Sep 2020 13:03:09 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: allow specifying a BTF ID per
 argument in function protos
Message-ID: <20200909200309.psebk7iweqmugkcu@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-5-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-5-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:300:81::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR14CA0053.namprd14.prod.outlook.com (2603:10b6:300:81::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 20:03:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e19ee2-0786-41cd-2954-08d854fb639d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2198D92085D09F78AB010F4ED5260@BYAPR15MB2198.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkPORcWwC2vTT3UL7IjyOyNp7zz2LPMLR4vHyoi+Le6jX3ac/JsbJDRORIkmVfry3P7Q/u/7xB25MMTL4+ABDfiBioiWKg5FASbnLmCxO3jIC1z9nwjeXvPWjEM1KVx7qyBkeL3BPE0BJ2HSuZfjmYz+J0wTwe662gXwmqDL5RKRCJVJo1PX8/mbVREKSPVp0O97o9ZxYS/tyNYzWQ3E3VsEL7tgkIn/GwEo51iHcsjT0REuPu5v9KqlxX03blCwdbowLhSDW55LntX4H+Hf61mzFp7huJJh9JzWbVCjAws1XivdZ/4g2WRna6g4Sk7pF9bEBsIlO1323dQHhk7YCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(66946007)(6916009)(478600001)(55016002)(6666004)(316002)(8676002)(5660300002)(4326008)(2906002)(8936002)(6506007)(66476007)(1076003)(66556008)(52116002)(7696005)(9686003)(83380400001)(86362001)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BR69QPwUkogEcUWfgbPgNL7Q3rVyYJS5mUTurjFsJZu9MLbEWitDX7Z7N4NWiYJo1wfUT0LBiImf+USUnx3jGS9eNw96vicSd1i/B5WRIZsTCe5PN/g+YVsmo30U2KgLMuZVTOIy3UbFrzuUv1VrsApSxOOOonrP6M0c66KiuryEPwZl18g84SuoqZ9LBMm44KVSPMMFIrNIDoVnkwaprUKVENDQYYAuXUEVxvN3G3ysDjdtncyjrLDja722oxJpE87/NNNKMcg2pTKLJp2Ox601woTIOyMSP9+nWvnrc0biNdxae9gWlSaFwSp0Icle3J3iYFIY/Yf5m35XBk0MZNzNkG1EDSZ3dk19g97RHSDka5J0LAJ8jQlsSfv6LPV649f9nILfih5av6u4KGYjk1GEiWL4UlsguoSPhDqGppkskEKfIz6TtE3QCw5mI0lfTITspyqv/3GPnMUcxHAPshFMK9KrNDput1P3g1M/JK1vqSuePLgWZG8catEXajGuVX9KutcvFnQMZ9mueCOVYBkPTggBBLAKZKOwwGAETYjpSGlQVo/xN/ur+6EdwRn2BnC/FGUpCeYqz88iEFRk//v0xTwSO4o12B7dGVkoK9cQhKzayUXMvagMjSkr2fsyCVf+c2BCKwxqeYKgpKSlyVmCT+w3Go4fyq5SXeRW83E=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e19ee2-0786-41cd-2954-08d854fb639d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:03:16.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpsdwLLWzlw8lgWgCMMN+6Yw+wD+wHrv8dcIisIA/a+hEp0Nf9ecFbvBMFTEbiQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_16:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=1 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090178
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:48PM +0100, Lorenz Bauer wrote:
> Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> IDs, one for each argument. This array is only accessed up to the highest
> numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> is a function pointer that is called by the verifier if present. It gets the
> actual BTF ID of the register, and the argument number we're currently checking.
> It turns out that the only user check_arg_btf_id ignores the argument, and is
> simply used to check whether the BTF ID has a struct sock_common at it's start.
> 
> Replace both of these mechanisms with an explicit BTF ID for each argument
> in a function proto. Thanks to btf_struct_ids_match this is very flexible:
> check_arg_btf_id can be replaced by requiring struct sock_common.

[ ... ]

>  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c997f81c500b..7182c6e3eada 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -238,7 +238,6 @@ struct bpf_call_arg_meta {
>  	u64 msize_max_value;
>  	int ref_obj_id;
>  	int func_id;
> -	u32 btf_id;
>  };
>  
>  struct btf *btf_vmlinux;
> @@ -4002,29 +4001,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  				goto err_type;
>  		}
>  	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
> -		bool ids_match = false;
> +		const u32 *btf_id = fn->arg_btf_id[arg];
>  
>  		expected_type = PTR_TO_BTF_ID;
>  		if (type != expected_type)
>  			goto err_type;
> -		if (!fn->check_btf_id) {
> -			if (reg->btf_id != meta->btf_id) {
> -				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> -								 meta->btf_id);
> -				if (!ids_match) {
> -					verbose(env, "Helper has type %s got %s in R%d\n",
> -						kernel_type_name(meta->btf_id),
> -						kernel_type_name(reg->btf_id), regno);
> -					return -EACCES;
> -				}
> -			}
> -		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
> -			verbose(env, "Helper does not support %s in R%d\n",
> -				kernel_type_name(reg->btf_id), regno);
>  
> +		if (!btf_id) {
> +			verbose(env, "verifier internal error: missing BTF ID\n");
check_func_proto() could be a better place for this check.

> +			return -EFAULT;
> +		}
> +
> +		if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
> +			verbose(env, "R%d has incompatible type %s\n", regno,
> +				kernel_type_name(reg->btf_id));
>  			return -EACCES;
>  		}
> -		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> +		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
Removing "(reg->off && !ids_match)" looks fine to me since it is
checked in btf_struct_ids_match().  Just want to highlight here
to get more attention.


>  			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
>  				regno);
>  			return -EACCES;
> @@ -4892,11 +4885,6 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  	meta.func_id = func_id;
>  	/* check args */
>  	for (i = 0; i < 5; i++) {
> -		if (!fn->check_btf_id) {
> -			err = btf_resolve_helper_id(&env->log, fn, i);
> -			if (err > 0)
> -				meta.btf_id = err;
> -		}
>  		err = check_func_arg(env, i, &meta, fn);
>  		if (err)
>  			return err;

[ ... ]

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index a0d1a3265b71..442a34a7ee2b 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -357,6 +357,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
>  	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
>  	.arg1_type	= ARG_CONST_MAP_PTR,
>  	.arg2_type	= ARG_PTR_TO_SOCKET,
> +	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
This change is not needed.  It is not taking ARG_PTR_TO_BTF_ID.

>  	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
>  	.arg4_type	= ARG_ANYTHING,
>  };
> @@ -377,21 +378,18 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_CONST_MAP_PTR,
>  	.arg2_type	= ARG_PTR_TO_SOCKET,
> +	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
Same here.

>  };
>  
> -BTF_ID_LIST(sk_storage_btf_ids)
> -BTF_ID_UNUSED
> -BTF_ID(struct, sock)
> -
>  const struct bpf_func_proto sk_storage_get_btf_proto = {
>  	.func		= bpf_sk_storage_get,
>  	.gpl_only	= false,
>  	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
>  	.arg1_type	= ARG_CONST_MAP_PTR,
>  	.arg2_type	= ARG_PTR_TO_BTF_ID,
> +	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+1 in reusing btf_sock_ids.

Others lgtm.
