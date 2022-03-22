Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F04E47F2
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 21:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiCVVBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCVVBD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:01:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6740A0B
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:59:34 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22MII7fn003799;
        Tue, 22 Mar 2022 13:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YmPS74WKSTkhV3ADWSCR/qn5vpby5YZ7gSUBDpR4C7g=;
 b=orZbmODcfrmvyzZ6yqLGJvddppAHuih0lhVBp0fMyICE8uXSCeP/BDQPg+WA0WVdsbkW
 RpRakkEL8QvVXFMbS1ZwyMsTN4fPIFuu48l7HgPCxC36owCjKkPPIplwZtHbOu+A7aGn
 A9d8Sz9j67+fWHSgXWzFEVCWnJoBW2eeXCs= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ey8q1ed6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 13:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jeejcbv6SgfWlr+kc4bL9RHZc4PblHHz9u292X/PkF/sg16q2mTYRKsEpJbKRqc97ETRNv6rQdPxE6inbDEAdj3JkBReXk0Gc98yMlMRKT8dYglql6pT65mbo7UX/0x0x7h4uI1z2Dk+vo/dB9ClmdCMKRv47OFAOETlj0CUpxY6erWmMFYmnsON6mj8MQgZn5VwMJM09h7IQpjrXL7siFraj38Iv9I3lBAyqK2r6i2q43PqelLwYRGx8Mu9qApmOBJCFgEZCc1EygLq4lRfSJrcM42v/IUo2McTEj7pQ7QYR2OZXDVRTx/X9dpZEQD+T66EWcwVKC2OJRFeaosAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmPS74WKSTkhV3ADWSCR/qn5vpby5YZ7gSUBDpR4C7g=;
 b=SLCOrIm4m2rH0BWstynpSRXJaH8z+m8nlxFqTQqTh8VsTgMDNN5rVXkUzkYb+qMf5IuNYv98ljucZIjuBQvO+uateiy/2ik1tow9mRTgj+43Csf0g5EZ18gC0BWmRucZpcatxkKoBW+WnGV8388eO6aJG5Slqrf5FvyGnALerD0QRcKXL7+4iZKnUX9sCq98vE/bpPkWIilGVcK6fELG1lhiMvRe0xaEe+09lg56IfKEb1sn7IB2fWU16V5vNtPLNThwC6O6CTh4XnltV9Qz7nb+hs/5/Yrjt/y/1AWLMl8xPLaKmYv45KfhWHlr1TVDUL3JufcZRfwBHnWdRrhzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB2495.namprd15.prod.outlook.com (2603:10b6:805:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 20:59:16 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:59:16 +0000
Date:   Tue, 22 Mar 2022 13:59:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220322205912.h3pd4qc36zn2uepp@kafai-mbp.dhcp.thefacebook.com>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-6-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320155510.671497-6-memxor@gmail.com>
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ffb9631-7ead-45bf-b99d-08da0c46d3a1
X-MS-TrafficTypeDiagnostic: SN6PR15MB2495:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB249506970CB91FD94C45DB08D5179@SN6PR15MB2495.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb1fXoGKop2EVBmLnlebRaIG4CIPJB8L6jkFAIjkuRBz04WGb/1wzG49EEAwDvgJvCmBwkvpOtn/7ceARVT0BmTk3gFEqneN4YnVKKrbhn5kB3f25Ul/5wqRy+KBC9myOiSoesDQdm3W708nNy6ghUIBuwu+B7tIZ4/LbOAXxp/E/QEXjbi8JEjS0cDGKzCgxJwKu42nlDS5j+zhPta9X9yYSA2apLXUaxqEiZ6Cr2eVo1ldj4zcJCXGxos5fQBJMWVnMCaJFIw2NfXgcN85EatTxgHIUyCgdKpnsz9Mh/hFNCkjjKEwzA63eECJ7IA5LtYl/9DDMzWmhKkLGBU6aJgeDVPFlKResc36dMGUMtNb8NP5tvk539mMGzNrvSjC3GS3MDwA/A7or+fpWoddaHvUa2IQVGUtWxHPJ5w4uLFMAC4WtITl/jKii09wyJdAEJYZs7YpXZkpGlZSO4buvJq8K2D/G5+GpjaMf0E2tWG4j4R2zgWtiMCFwpMowYTkcao0s2aUzXH4Se0Z6CUNb+M2WFwYDEAab/ANMtI3dBM8rIFX00gSwtMA5uva6sk0IlCBN1XKhZRTJ9VfTJkvEfKkTtKCBJbb+pyG4A1KFPHyq/UswoW1dywYcyxFu1R19qXBZJTq7EWLkWDXgyecmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6506007)(316002)(86362001)(6666004)(186003)(2906002)(9686003)(6486002)(508600001)(83380400001)(6512007)(4326008)(66476007)(66556008)(8676002)(66946007)(54906003)(6916009)(8936002)(5660300002)(38100700002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qp4/I7bRkMgN9fZFsMeCM3Tlwvb4UCrjMn1mJleGHAa0Rcs89Ja/ouAl8zJC?=
 =?us-ascii?Q?CiKwN8HaRANeWmWpy+7iWtGZjbJWwUayJwnus26Aq4hl24nuyAJbGKGd2uJ0?=
 =?us-ascii?Q?LIO1NQ+TADa2v3BNOHo3zusZGkWXhzCSTwwlrJY1uuE2OtB8lXz6ezA82vCK?=
 =?us-ascii?Q?bGTHqYw+v9Ka6S02VLa+IxR91NDE4XhHRKkgpAgm5p7nUwzLMwFtCesyYmbZ?=
 =?us-ascii?Q?Prp35C8LY2940dQCHf697NR2Yh+eLAL3wBU5yOv2zFB0R77+Oe8VC+6LtSwc?=
 =?us-ascii?Q?Eax/cu0aYFkIhcVMv4DKOpnAvjjlHg49i7YW0zVINoMlToPVeq/VW6ek/jHl?=
 =?us-ascii?Q?qBEo/91kVJN09tGHfI2ybowqNVlD7JTs7WxlSXtSV70v18iCg89EIGgSiOBW?=
 =?us-ascii?Q?msxhWBiNUuJN2Z4FyM0J/UPHLeTPbpV/e6PR8pvCEpb1Eg6wJ12ZMuh01fOX?=
 =?us-ascii?Q?WDKk94PCbSmipfOgvmgV9rcdt399Jkcqd4Kv21BCJx08WVcSsBjyEFcaosN7?=
 =?us-ascii?Q?uoILmYOUVQGIT4p/BJyS+bOZ/PBDAisZIbDpQ0RU3TaPG8AYbSy5qC6z812r?=
 =?us-ascii?Q?dwxHqv06sCwNCDGWNGq71km7sXkeVdawNs/sLD3TFVGZ/flIBI+OhnbF4eaW?=
 =?us-ascii?Q?GWC/kq9dalzcRab4yPjnIbgZuR4IWUaV6zOOpRSNqTBsu2wI2pmMPN5tPYvg?=
 =?us-ascii?Q?AkAE+8SZ1ERm1W/FLQYa4t+KAiU1zeWXUoVyn1FpKKIudHwLB1I1rjjnWQlM?=
 =?us-ascii?Q?yx6Urq35Gt8U/qfT+96NV65/L6l7nCNT0Ig4cVSOkGM7z4OM+4O+mAopqiDx?=
 =?us-ascii?Q?iZfP3CmtvmblWXtWhTPjdL/C2bH7hfUbXh6XS0ICx3z4bemYCiDb68HR1RBa?=
 =?us-ascii?Q?ZEl0zQqx6SbUKYeCk/8AdRAl0aqaqVc7lfTCGlGoQUFb6iSEptSi0B0ZKDJr?=
 =?us-ascii?Q?vRuC79rm5nUBIB5pdg+nyvb+2cpCsrtyq7gQ5f8YMbgeQk0AivMZbLRhh8Oo?=
 =?us-ascii?Q?MN1t/n6hHr7vlGOrRrE7y/B+pX445zEqkLWkcuIpgYgCehqifIFYRZ8oauQP?=
 =?us-ascii?Q?q9yh6IJLw1bdiWJL0NoQM8c/bUHmQAUVszc4RrK8UQ6oWNux1kWCs5wb0Cdn?=
 =?us-ascii?Q?YGbkGDRcGhMUpZfmnMW88CxKy+benY4ovcYfXjZosM2NnIryQVAHijlVVV5P?=
 =?us-ascii?Q?Bv2WpIiHEBJlZ/o1NL78oOSW2cJRi+aNSajlvqzTi2Bq61au5wH374v2BBeP?=
 =?us-ascii?Q?SyfprADYSpM8DEoUU1QmcHfI9A+NMtQ5kKLBGc1OXMOHxEGVC1oCYOoZA/Gy?=
 =?us-ascii?Q?Sp2o0M9mp6ijpDO/hYFZUdZrpKO+Sj7Hj3nNfXgKLTJOhwT//LrkBYG6XUkm?=
 =?us-ascii?Q?4/i8mv4M7FbOfNxCOLARSrdDvs9mEdbnx0Jo53qPVV7gyFvOnoE9jcjdWAW4?=
 =?us-ascii?Q?3kvc/NF9nJbLU4ZKvTCjbmvtoAqncTuv+ppc1pP3MmWnfN4Rvl974g=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffb9631-7ead-45bf-b99d-08da0c46d3a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:59:16.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMKHtUppJBOsYWSgTHdaeij9N82X0eVCH7QnU36ftluD2eXYUCbTX2n0QY4Fri+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2495
X-Proofpoint-GUID: SLm_glO43q1Ndy-fm7s4ikGTBnp67v1g
X-Proofpoint-ORIG-GUID: SLm_glO43q1Ndy-fm7s4ikGTBnp67v1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 09:25:02PM +0530, Kumar Kartikeya Dwivedi wrote:
>  static int map_kptr_match_type(struct bpf_verifier_env *env,
>  			       struct bpf_map_value_off_desc *off_desc,
> -			       struct bpf_reg_state *reg, u32 regno)
> +			       struct bpf_reg_state *reg, u32 regno,
> +			       bool ref_ptr)
>  {
>  	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
>  	const char *reg_name = "";
> +	bool fixed_off_ok = true;
>  
>  	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
>  		goto bad_type;
> @@ -3525,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
>  	reg_name = kernel_type_name(reg->btf, reg->btf_id);
>  
> -	if (__check_ptr_off_reg(env, reg, regno, true))
> +	if (ref_ptr) {
> +		if (!reg->ref_obj_id) {
> +			verbose(env, "R%d must be referenced %s%s\n", regno,
> +				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> +			return -EACCES;
> +		}
The is_release_function() checkings under check_helper_call() is
not the same?

> +		/* reg->off can be used to store pointer to a certain type formed by
> +		 * incrementing pointer of a parent structure the object is embedded in,
> +		 * e.g. map may expect unreferenced struct path *, and user should be
> +		 * allowed a store using &file->f_path. However, in the case of
> +		 * referenced pointer, we cannot do this, because the reference is only
> +		 * for the parent structure, not its embedded object(s), and because
> +		 * the transfer of ownership happens for the original pointer to and
> +		 * from the map (before its eventual release).
> +		 */
> +		if (reg->off)
> +			fixed_off_ok = false;
I thought the new check_func_arg_reg_off() is supposed to handle the
is_release_function() case.  The check_func_arg_reg_off() called
in check_func_arg() can not handle this case?

> +	}
> +	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
> +	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
>  		return -EACCES;
>  
>  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,

[ ... ]

> @@ -5390,6 +5473,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> @@ -5417,11 +5501,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
>  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
>  	[ARG_PTR_TO_TIMER]		= &timer_types,
> +	[ARG_PTR_TO_KPTR]		= &kptr_types,
>  };
>  
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  			  enum bpf_arg_type arg_type,
> -			  const u32 *arg_btf_id)
> +			  const u32 *arg_btf_id,
> +			  struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>  	enum bpf_reg_type expected, type = reg->type;
> @@ -5474,8 +5560,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  			arg_btf_id = compatible->btf_id;
>  		}
>  
> -		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> -					  btf_vmlinux, *arg_btf_id)) {
> +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> +			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
> +				return -EACCES;
> +		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +						 btf_vmlinux, *arg_btf_id)) {
>  			verbose(env, "R%d is of type %s but %s is expected\n",
>  				regno, kernel_type_name(reg->btf, reg->btf_id),
>  				kernel_type_name(btf_vmlinux, *arg_btf_id));
