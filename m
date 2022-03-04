Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59B4CDEA0
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 21:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiCDUSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiCDUS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:18:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A612BF75
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:15:59 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQOFr020914;
        Fri, 4 Mar 2022 12:15:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=es/S+7SgL7jJP4kqMpoqU19Y0bCEYoAo1jsFna2iMRc=;
 b=do6dqSoZVVPw6ZgplQc41DZkfGOj0aERaV7K3GhPEUusQT7lbgG6nBAkLCdJpPj3/TEU
 p2GuvQJW6z3nbT/vIQGhqqvdz6CwiLEkoe/iolImQ6oO5qteC7ZS8Mhpn4XV6BPe7VhM
 YaH9u2aXJQfZnIfa+zRcZ2Rg3UonN8FYSCg= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4hrqtbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 12:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO1ENRaQekeTvotVw2gEgHvNpZGvjCCW3bKjYG4FHqRY2HwrLQyMYtLvHBqYqrJMFeXLLjGxl1ml1lY2vRsVIgIMxR4eV1/dHM8pUXO8CgeKfOWBTYotDoIzI0bTlQi2/F5lX9y+J5rFTAMN1bOQK5UOofigPH9Q95pQQGuASkMj1ssIMm8VtK1+NwATo9a5zhgpyVou1SpCq/Vo7U7aotWpKUpkOdg2NUj0dy8lCAkSh6O7YUjrxaUR0rhITL6emIsmgrutdZSNhdoiLcAVoNpOoyjVj268pea9nDNTf1gX4NtIPtPCYgYwLfzUQX2RHOc+xzikWU+LGBDaxGrb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es/S+7SgL7jJP4kqMpoqU19Y0bCEYoAo1jsFna2iMRc=;
 b=Fzl7YVr74mx8kRVyoFUQdxEq1OO1z5cLnz7sdKWOSp9LZRKOTH5XYQ8pWkaIDzNz7uNngcKEy54y/VmoJm376C950ZasvJQkA9g298XaRoROtNFN05lB07pgDkFI4dwoQfkMCnJgsqcz2IhZITQ9eF+R3spytkjhgyii+pTIbeJPvZ26JQaHccgEQcLNJ/CznoTisew9DxxvLUZ701oh+wmhuxtYYFFD9GexcZwhlT6P2c1E7zS766arIjSuhiXMevrkdBrQDEC354NLtH5+g7iYa8kQqDHvc52ic5cosESBJZx3Z/s5gwcPEhOUBEFdVs5x346LWN4ZLFMd59z2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4691.namprd15.prod.outlook.com (2603:10b6:806:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 20:15:43 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 20:15:43 +0000
Date:   Fri, 4 Mar 2022 12:15:39 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add check_func_arg_reg_off function
Message-ID: <20220304201539.hr5xzg7c5tlx4xvl@kafai-mbp.dhcp.thefacebook.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-2-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000508.2904128-2-memxor@gmail.com>
X-ClientProxiedBy: MWHPR19CA0092.namprd19.prod.outlook.com
 (2603:10b6:320:1f::30) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d534fa-271a-40ec-51f8-08d9fe1bc264
X-MS-TrafficTypeDiagnostic: SA1PR15MB4691:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB469110B3B5AE51409C6F9FDFD5059@SA1PR15MB4691.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ckst+aDuK8ToDITSOkS52sjMNCbarEO4W8/oEZozi2YF9bz/7tIkZ+Lwk19lXHdSaW1cwocTGxucGRcQXAr0mEwVLexNDmHFT+yS+rE9bOiJUKXLK3eg2Szp4OHNwrESUcJGqGL/5JsKItei10W0OQ9cclvc/I9Q4tu3GISOqUc6M51gZvN1iJsbr7PYdqIRzNwbHsdTJtKXMHNXfZHsLFsqoAOJPnToJuFwXwKHurjK2nvyKI2q2m7OfHEeE8jONWbow7ff4PPV7KvbSddXqr9CqhxUVR8LenvGYBYgdUm7mSW29OM2zFd2tSTccoJfXhLG64ms9Z1PinPQto68nIJaO3Y+JaSFzi9nFgNT3SEYVtOLtgFmfWPMdJ4bhJLOYeTmTUIKQfT48Pa3MW+c6kkeVUeS0zQd0gNghITwx0smiX0pNr4D3DAPYLxMGSfO3TmsJH7tOQnlMQHCIRTkToiPleWM9MU7qEx5yegAE3ksiDAU7R0AtYADaCYTHlDrC8m2sfAHcLVmpllvJ4dTZC0Hmu5jb7JnQik4VOQG5muQpyc8914a3ijUKBBbGjPstkIEH1Fp6DnGqF1qIvjRAG34WrEuxSJ+LoSguYxvbvd/9k7Zc8xu81/NUZAnlXpF9dRJDagN++sCIAuXtKHuTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(1076003)(6486002)(38100700002)(508600001)(8936002)(5660300002)(54906003)(316002)(66476007)(6506007)(6916009)(6666004)(52116002)(66556008)(66946007)(8676002)(4326008)(6512007)(9686003)(83380400001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4WRGPnmAiFpozHOBxlSQhieuOlWiOhuipt2NEfPCF/nkXYBbWqfbabWjU1/?=
 =?us-ascii?Q?3Fc556tmm8r4rUkzG7wCBcBSCoMU3iMVrw7zDDa4frYWByDbGCVOELhK8RGC?=
 =?us-ascii?Q?nptKpo1SDXusts6H4OkP+4rfrzvLZPDqNaFdOa9JNS3n+tdgTesnMN6TOvA3?=
 =?us-ascii?Q?zvI8HRCxfCj+PlRUI/KOnHNM4s9OKqEkQ472oeQZr3r9YQM02x1qzm8WpvGS?=
 =?us-ascii?Q?sWOjEHhNW7q/aS7z1Lo8hs7P/npLgHqRbg1qo00SBi/Bhl9Q3MV6AcJ40xGR?=
 =?us-ascii?Q?37TFTBiUYtINurNcjnkxS/EuDgGBuNN6W2xbqYb40Y+4oiBwBKsOJYNiBIRP?=
 =?us-ascii?Q?TaG3ZS2K+zL1xCrdfCZ9F68U+Wm19XgxRcZH14CUkuw03k9hhwEwu3R2lkIX?=
 =?us-ascii?Q?0Ieysp/XpmCIKS26QURX3v6dbfgZjrm7EhDX7SH15D6xANjpkRwxQwrbwa9/?=
 =?us-ascii?Q?iAc00NhC80++5SeGT8TsKEyk5UcycordY4hZE45TxLRI21AzLj21Qp0nWrXA?=
 =?us-ascii?Q?3bj5kMUR1UjLnQDwyq5tDM6eJvjDfaXxOZ7qXFI7No1izT7kCDWsWWq9fR2/?=
 =?us-ascii?Q?GKebIcY8FsJ4Pi8ZrjqKD/SWtjrISP/c1sNREj02YrQtOcmk4iROJLNLcIGO?=
 =?us-ascii?Q?XgEEtXwqYMF3WHdzMj4GKsAMGXkQsm1BWGkF5ZXAihttnjlP3YFpRiwXrhQp?=
 =?us-ascii?Q?EMUiEmZRjeMWreeletDMlwobBHACqskGNsknOGQ+1X+Z+fIjqfRl5eWlEXXd?=
 =?us-ascii?Q?jgQwENIJ5vGrA58uqJT+4J18WV1UK0WhoaodRn57I6N+zYVn8hMcGBIcF9dn?=
 =?us-ascii?Q?RYGiQAPdjXI0l/m7y+LUo+AlGbV2XqPiAzTb9z/q9z60JX2CuMDldYxRfELC?=
 =?us-ascii?Q?ywzT46I3dRYdGlGskPrCwbnbLRxo/SZhXrt58PVqgYnACS5wEOIFwoo/ty16?=
 =?us-ascii?Q?uzEQlkCG8hJSVbEHaLsIb/ZKec4mZAFgW8Pih3cAMvkTa3KSXtkJGstOmjTQ?=
 =?us-ascii?Q?6Hpt9yytipCSYlwO9g+/LJWSNKChs+kbOwMc2khT7ZRuutVFunpwOxIiUXdt?=
 =?us-ascii?Q?H6UgonOo8Jgi3fyZWSZf5U+5PHY4qUJhLrGgF2TJfGpdDAmsFCX4lYM86T9R?=
 =?us-ascii?Q?u7HBvjXx2qDH+gym7KeWHYt2SiCGYO4gyHsVwlzcgu9iHwYhZIDLFtG4RBXz?=
 =?us-ascii?Q?BI49tV4fu5B8cdx9jwhwui7rOI/9nFChTQ9Pom4kL7SP+4lLEhX+iS0AATk7?=
 =?us-ascii?Q?ZT0LEScdge2084GXQnn+f3yyh7LcNU4A+gl+yXTFeRPVysPzC6UH58iPYzTb?=
 =?us-ascii?Q?aaprZqNW8p0AcOkaY0SeBnuTjTkDGEV/6/s0a5d5VRFGtsg/MhLzEN+X6ZLp?=
 =?us-ascii?Q?FvmFWWfzcUVWJ0mMJOV6yyTWPLiDW8x/vQohcMK/nkS/sBvElPtw3t6EMB96?=
 =?us-ascii?Q?qZ4j3CSh0GJbHHdpQgKuC6m8FMqkhs8/HczYY3ZwggkokBur99TY/+dubSM9?=
 =?us-ascii?Q?kwmwOLvYqGj1jh9P3JBfDD34N/eIvg5e/KPvSlsHfyYogjSeG+8KN0MdPBsl?=
 =?us-ascii?Q?lztFYpu1EwdtaN3HDaYCXjS16PBqCOiUt0wYyhmR?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d534fa-271a-40ec-51f8-08d9fe1bc264
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 20:15:43.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOqXR9Yb4rKdJpoS+wBkFYbnrdkSHdvSakQoJLEE9lC0sC6rSgjuIsXpupmkL/hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4691
X-Proofpoint-GUID: WZ1FnhemDwSudwMMLAsAgb8oloPXQ_o-
X-Proofpoint-ORIG-GUID: WZ1FnhemDwSudwMMLAsAgb8oloPXQ_o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, Mar 04, 2022 at 05:35:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> Lift the list of register types allowed for having fixed and variable
> offsets when passed as helper function arguments into a common helper,
> so that they can be reused for kfunc checks in later commits. Keeping a
> common helper aids maintainability and allows us to follow the same
> consistent rules across helpers and kfuncs. Also, convert check_func_arg
> to use this function.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  3 ++
>  kernel/bpf/verifier.c        | 69 +++++++++++++++++++++---------------
>  2 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7a7be8c057f2..38b24ee8d8c2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -521,6 +521,9 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
>  
>  int check_ptr_off_reg(struct bpf_verifier_env *env,
>  		      const struct bpf_reg_state *reg, int regno);
> +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> +			   const struct bpf_reg_state *reg, int regno,
> +			   enum bpf_arg_type arg_type);
>  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a57db4b2803c..c85f4b2458f4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5359,6 +5359,44 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	return 0;
>  }
>  
> +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> +			   const struct bpf_reg_state *reg, int regno,
> +			   enum bpf_arg_type arg_type)
> +{
> +	enum bpf_reg_type type = reg->type;
> +	int err;
> +
> +	switch ((u32)type) {
> +	case SCALAR_VALUE:
> +	/* Pointer types where reg offset is explicitly allowed: */
> +	case PTR_TO_PACKET:
> +	case PTR_TO_PACKET_META:
> +	case PTR_TO_MAP_KEY:
> +	case PTR_TO_MAP_VALUE:
> +	case PTR_TO_MEM:
> +	case PTR_TO_MEM | MEM_RDONLY:
> +	case PTR_TO_MEM | MEM_ALLOC:
> +	case PTR_TO_BUF:
> +	case PTR_TO_BUF | MEM_RDONLY:
> +	case PTR_TO_STACK:
> +		/* Some of the argument types nevertheless require a
> +		 * zero register offset.
> +		 */
> +		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
> +			goto force_off_check;
> +		break;
> +	/* All the rest must be rejected: */
> +	default:
> +force_off_check:
> +		err = __check_ptr_off_reg(env, reg, regno,
> +					  type == PTR_TO_BTF_ID);
> +		if (err < 0)
> +			return err;
Nit. Since it is refactoring to a new function now,
it can directly return __check_ptr_off_reg().

		
> +		break;
> +	}
> +	return 0;
> +}
May as well flip the arg_type check and leave calling
the __check_ptr_off_reg at the end.

Uncompiled code:

int check_func_arg_reg_off(struct bpf_verifier_env *env,
			   const struct bpf_reg_state *reg, int regno,
			   enum bpf_arg_type arg_type)
{
	enum bpf_reg_type type = reg->type;
	bool fixed_off_ok = false;

	switch ((u32)type) {
	case SCALAR_VALUE:
	/* Pointer types where reg offset is explicitly allowed: */
	case PTR_TO_PACKET:
	case PTR_TO_PACKET_META:
	case PTR_TO_MAP_KEY:
	case PTR_TO_MAP_VALUE:
	case PTR_TO_MEM:
	case PTR_TO_MEM | MEM_RDONLY:
	case PTR_TO_MEM | MEM_ALLOC:
	case PTR_TO_BUF:
	case PTR_TO_BUF | MEM_RDONLY:
	case PTR_TO_STACK:
		/* Some of the argument types nevertheless require a
		 * zero register offset.
		 */
		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
			return 0;
		break;
	case PTR_TO_BTF_ID:
		fixed_off_ok = true;
		break;
	}

	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
}

Then 'case PTR_TO_BTF_ID' can then be reused in patch 4 instead
of adding a special 'if (type == PTR_TO_BTF_ID)' just
before the 'switch ((u32)type)'

Both are nits. can be ignored.

> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn)
> @@ -5408,34 +5446,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	if (err)
>  		return err;
>  
> -	switch ((u32)type) {
> -	case SCALAR_VALUE:
> -	/* Pointer types where reg offset is explicitly allowed: */
> -	case PTR_TO_PACKET:
> -	case PTR_TO_PACKET_META:
> -	case PTR_TO_MAP_KEY:
> -	case PTR_TO_MAP_VALUE:
> -	case PTR_TO_MEM:
> -	case PTR_TO_MEM | MEM_RDONLY:
> -	case PTR_TO_MEM | MEM_ALLOC:
> -	case PTR_TO_BUF:
> -	case PTR_TO_BUF | MEM_RDONLY:
> -	case PTR_TO_STACK:
> -		/* Some of the argument types nevertheless require a
> -		 * zero register offset.
> -		 */
> -		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
> -			goto force_off_check;
> -		break;
> -	/* All the rest must be rejected: */
> -	default:
> -force_off_check:
> -		err = __check_ptr_off_reg(env, reg, regno,
> -					  type == PTR_TO_BTF_ID);
> -		if (err < 0)
> -			return err;
> -		break;
> -	}
> +	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> +	if (err)
> +		return err;
>  
>  skip_type_check:
>  	if (reg->ref_obj_id) {
> -- 
> 2.35.1
> 
