Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2021F4E7B43
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiCYXnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 19:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiCYXnE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 19:43:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928AC171EDE
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 16:40:14 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PHOJ24009924;
        Fri, 25 Mar 2022 16:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1eGB3Sx2wnRLIPbVdzcTFxcm3aLSXq9t7Wd6u6+EW58=;
 b=Ak3UkiuIvk0wzsRNUiBG5sCE6h8iOHaA6kRNOhAv7TNCxLvBp5vx2/fFpRMPvvBLvPbO
 fzRbBFlFLop1VAN/44ctR4iWf5mYu31ap8ew0pgOjQRtbn3qsT+Ya5fwwYcnNSK3HJhJ
 sSY2N8xOMAiRczTx1fCEEUcTcCArxUnFFWg= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1hjutp18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 16:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4lMCBa7VhGkj4i1RSePmYj+I2Z2q678gDl8iCbNSil90nB7Y2NjdAzOmZXufUXsEqO42i7trEQgKJIlwDKnFBJkRMTobHA4TnhG78Fz+cOOs4pUrlZndyRxAUjMYrXj+EQ8xnwUlU+x1NJR9M7Mzn88eCrxqMuAXocxkVbWEWPVoSPtbNzhJ/3gJ7NmxENUjRa9/nP1GfPoMjc7mgfKpQO6yAUNRahHUzdcIwMfbClYxTGKKxl9YPS/B2OqB16BoYEpShfQWLnb418K9ru0xfZb3vu0+Z4m5sMLK4X8BCfaeTSaFM1i5WFNcf9GyhSVjhpx0l1p9In5BgmMdTg78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eGB3Sx2wnRLIPbVdzcTFxcm3aLSXq9t7Wd6u6+EW58=;
 b=Vi1P+L+2uY0B6yUyVG+gu0BIVrTG599Nu7nfI7t0+MePkA7OT67U0MdJZNztKZkBE5JDXU56WqTWxvqpO4EPpBeQmuMH+coz6PbzC4zxErRDG6VcagJkOUpCxauXpxrxhJMsSs758tbcxrJbEHjjjikHHgeTjxjFDm0FpHzCPDVqRQwbD8wyGefGm0+7ylpkcUgqfw7ei+a777MUm+FpxkIs5VQN+UenJeoJqhhsjK/p5MhNb9utsWs5zjAVrFWdywMdzNOnWRU0y0hzc0f4SdUz6ZabKk5YJ2qtfAJxxH9085J+LibdNXUollXoTgfwYvN1IIfQG1JcfVQpPB/XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BY3PR15MB4833.namprd15.prod.outlook.com (2603:10b6:a03:3b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 23:39:56 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 23:39:56 +0000
Date:   Fri, 25 Mar 2022 16:39:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220325233952.y4qdfivjlfgrx3x7@kafai-mbp.dhcp.thefacebook.com>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-6-memxor@gmail.com>
 <20220322205912.h3pd4qc36zn2uepp@kafai-mbp.dhcp.thefacebook.com>
 <20220325145700.li3ap2nii52qeyr6@apollo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325145700.li3ap2nii52qeyr6@apollo>
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e89becc-ab53-4994-bbc2-08da0eb8c44d
X-MS-TrafficTypeDiagnostic: BY3PR15MB4833:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB483376F7749DEC0A309F8E3FD51A9@BY3PR15MB4833.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdTzwBIvJfmq4Wzc7Rr/IO/woBbGkReTxRhQ+gW965qsEiNyImRt7l/fT4v2L6clc/lSDbu4I7Z1lsS24EeiNzCBlfLoBe6mh5JwKr76tmWaFbwuKdUUuWh2agiVJzwT0yHsDFbyj/4Nmld4CiVHcTXoS1ZhJC2pQd3EZWlsyZT/YSrJKDMRLJMTxV7ZRyZpoZpsacUA38GmM3jYSAtRe/Gv2nDLnPFu55HR3UbOVPmZY6yvwydSnwUbvp/TJ2Z1BpCfgSeYAwCKTeLLuhOQcRaoNch0jpol/tE6vsFuDzWU/kJsVutNusCuYqRSB1vm9j6kXFkS3QV1crZclM0gU3WVMGpCl/LNLzn1yzjbm757godestQEYN+Z+p941wlmveQ7G/orkiXiVKp7v9tKtOmdPWWLFiu9DX+61b8LiSYbXy8F19nCZy0XmaQyVNcQ9/pyzK6nSjimD2iwGzJV2WJIJVKh2v7ez4b4dFsAl/GJiOzDJi+go5rCl2nR7Nz/u8OhRU8bqf0ilUgnguJeJkFXEEpuhZKZM+YGxOVZASU/meodGr+tLtZQ2VCLysHS01Ywfsmw4c2fDs7O9muIng0yzmL8L0QDfLzEvEMs7JZ7VS+be5ErTPQDLaQ1cIwObSiY1o05X5oYdNiZ1WYZAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(8676002)(1076003)(83380400001)(316002)(86362001)(8936002)(9686003)(2906002)(66556008)(54906003)(66476007)(66946007)(4326008)(6916009)(508600001)(38100700002)(6486002)(5660300002)(52116002)(6512007)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXAjRJwSmt1cOwQMVh1fPaMLAhkwz/nmq+7p3WeKJTEjs/bjDJS6HcJavGyc?=
 =?us-ascii?Q?wSnn2NjozuFvOwtVl57Lx5yiSpMcGuJ3VFmkD7COa6ezOMKPBeiLXkc01puU?=
 =?us-ascii?Q?xnM019A1yqZ1hYHA9NZHv8X/EAfeypUNjVaz2acTyeIwAhZNk4Rbi/s9rtDi?=
 =?us-ascii?Q?yAb1JRgMEf8GdEMz4edAhShzSjJ3ABP65JmF2e7pnaPrBGrD+SfTwZBVJBLo?=
 =?us-ascii?Q?SG6U0apzo77hF2d0//eioi7WZfKOj+sl5gSVCGw0rjlbbexEK+KLhimos6XL?=
 =?us-ascii?Q?2bEVTFb3f1ussczd5jNlZ0ukqOFUEGE6Yyp4Cf4Eoi8rTTyFon0C+nZ5Kl+N?=
 =?us-ascii?Q?RTr8HMkDXAiJhEBEEuvfy+llavIPC0tJqW/3nlyk5IYNW1wnEuUmxIawGLg6?=
 =?us-ascii?Q?UN0nk5vdYbOHNnzESYcPZRIt5iGiZ2VGv/neKQi3TipJ/bhBEn1QqXkBbjXz?=
 =?us-ascii?Q?JrfO8hMs7+0DN4Aja1FiJ2BB5wmZj59nGowyfFF7zpnP6ykJNVm1rOJWY6l3?=
 =?us-ascii?Q?Kj1Y6wCUJbdNoRqVAL1fh62MoY7e7Wpmi2x22ztMcvK50mkUnSKPMhFuMciY?=
 =?us-ascii?Q?AgVBypdnpbMau5qtZsKiWiHfoKLcviCnwZra+uqUr0CauVRGrRwuk4QOPgyA?=
 =?us-ascii?Q?D/qDwpKDQCyZ3UtYvKFstO2T3swxgcex/yWzMmeRxMgbBfzvXBlqig+pGbhO?=
 =?us-ascii?Q?n1oX9B7UY6KYFtr3XXrxndiL7nUuUnhatkeaYeFqMMG7EwBvU9f+GlXLipLT?=
 =?us-ascii?Q?xDOJx5e0EBPoSaXeebh6I3uU5tIviQo6M2JcMa6nBlWxLnHzwQrI6pwHn9BA?=
 =?us-ascii?Q?1aGP8b0natloWKCMotf5enLlsJuPk7FLaJnfqW6ZLKqTqd/Aqia95uNwPW11?=
 =?us-ascii?Q?1dFftY9m4N33ti0GlaxTKSPbsYrDvuKUqCXbnMLwU+78KV2fLStwLlncCInH?=
 =?us-ascii?Q?M7Ecx0TyW+upmLopPgJnWvR8VvouOCuEu5hM97x9Wdk8Hc3CuAGTjrmmgngS?=
 =?us-ascii?Q?AL3qd+KRJk3jZ7N7tTY/3gHM0NvPbitU78vKTMDdqM2LWG/5MGvCcKEiVCjQ?=
 =?us-ascii?Q?UlMZ0b5kld8nSwDuOos2/Vnm1WyAnrfbLsO5VCKov5Wei8UAq4Fu3HqQd/7c?=
 =?us-ascii?Q?jX+GqPB0OtU8dJpD8yGaPnsFQQe4HC5JGjmwBFyhPxSrPykOJrLG7A+NR5+u?=
 =?us-ascii?Q?g6wYCjgjEjlWVTDeIVDuppnj7ZpgsG5tlAam52A57PyPxYgcZ4cBv6pQD6qD?=
 =?us-ascii?Q?QoWU0w/yqo+FcPo+W5wXspuLLYXXBUufmJ5+mRDJess50dLmpPa+LgUvQ5kk?=
 =?us-ascii?Q?IdMuJKUXr+JoxBmDAKHURuJyNcsuc04JdnF99y6GIOjv/gvA6N2fVejWZn/y?=
 =?us-ascii?Q?2Hei90mJrKDbdf2/ahOU266P1lxOh4t0lvcONjSZvA7EkEX/7ssxfxvY7vnI?=
 =?us-ascii?Q?EqD+5AHpugdOxeuLuYlFVw8jWPSYasHAltEw4HN/05G/+e/qYTy+NVN4hcTa?=
 =?us-ascii?Q?DvneIvjBF9rgwqjWRBPHfrcBeuDZxu4YiYVx29ItF/ip+p2rWrdO0KvXeOed?=
 =?us-ascii?Q?BOFwCcCHdX0NW+CrhLfKHsv2MnoygTbZkvCWbav9XmQx+EO8ilMyf1ZV4qHN?=
 =?us-ascii?Q?Aq9lSD8oYvfGjRgm2DtBTOK9dSU3oLtW2DhPe8wK5+xGVsVs1+7L+vd1E/C9?=
 =?us-ascii?Q?1GLqVvgIRK4ccQk9sUBYTKJtRVdXXmskzl6N7pCzR4K9cRJNDW8Jza9UFkHR?=
 =?us-ascii?Q?v1KcBdgCG5hYimOKkvtLZYX5cN+g/ac=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e89becc-ab53-4994-bbc2-08da0eb8c44d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 23:39:55.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0g9ylbH4NcamZ/+nSSbyCMOmLW3i/wczICT/7StVyDglfT8aG6qxluiOPGoSq33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4833
X-Proofpoint-ORIG-GUID: Vva6SrDsFwNUUsVG5JngIncM_9ukxqjV
X-Proofpoint-GUID: Vva6SrDsFwNUUsVG5JngIncM_9ukxqjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_08,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 08:27:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, Mar 23, 2022 at 02:29:12AM IST, Martin KaFai Lau wrote:
> > On Sun, Mar 20, 2022 at 09:25:02PM +0530, Kumar Kartikeya Dwivedi wrote:
> > >  static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >  			       struct bpf_map_value_off_desc *off_desc,
> > > -			       struct bpf_reg_state *reg, u32 regno)
> > > +			       struct bpf_reg_state *reg, u32 regno,
> > > +			       bool ref_ptr)
> > >  {
> > >  	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> > >  	const char *reg_name = "";
> > > +	bool fixed_off_ok = true;
> > >
> > >  	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> > >  		goto bad_type;
> > > @@ -3525,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > >  	reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > >
> > > -	if (__check_ptr_off_reg(env, reg, regno, true))
> > > +	if (ref_ptr) {
> > > +		if (!reg->ref_obj_id) {
> > > +			verbose(env, "R%d must be referenced %s%s\n", regno,
> > > +				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > > +			return -EACCES;
> > > +		}
> > The is_release_function() checkings under check_helper_call() is
> > not the same?
> >
> > > +		/* reg->off can be used to store pointer to a certain type formed by
> > > +		 * incrementing pointer of a parent structure the object is embedded in,
> > > +		 * e.g. map may expect unreferenced struct path *, and user should be
> > > +		 * allowed a store using &file->f_path. However, in the case of
> > > +		 * referenced pointer, we cannot do this, because the reference is only
> > > +		 * for the parent structure, not its embedded object(s), and because
> > > +		 * the transfer of ownership happens for the original pointer to and
> > > +		 * from the map (before its eventual release).
> > > +		 */
> > > +		if (reg->off)
> > > +			fixed_off_ok = false;
> > I thought the new check_func_arg_reg_off() is supposed to handle the
> > is_release_function() case.  The check_func_arg_reg_off() called
> > in check_func_arg() can not handle this case?
> >
> 
> The difference there is, it wouldn't check for reg->off == 0 if reg->ref_obj_id
> is 0.
If ref_obj_id is not 0, check_func_arg_reg_off() will reject reg->off.
check_func_arg_reg_off is called after check_reg_type().

If ref_obj_id is 0, the is_release_function() check in the
check_helper_call() should complain:
	verbose(env, "func %s#%d reference has not been acquired before\n",
		func_id_name(func_id), func_id);

I am quite confused why it needs special reg->off and
reg->ref_obj_id checking here for the map_kptr helper taking
PTR_TO_BTF_ID arg but not other helper taking PTR_TO_BTF_ID arg.
The existing checks for the other helper taking PTR_TO_BTF_ID
arg is not enough?

> So in that case, I should probably check reg->ref_obj_id to be non-zero
> when ref_ptr is true, and then call check_func_arg_reg_off, with the comment
> that this would eventually be an argument to the release function, so the
> argument should be checked with check_func_arg_reg_off.



> 
> > > +	}
> > > +	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
> > > +	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
> > >  		return -EACCES;
> > >
> > >  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> >
> > [ ... ]
> >
> > > @@ -5390,6 +5473,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > >  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> > > +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > >
> > >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> > > @@ -5417,11 +5501,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
> > >  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
> > >  	[ARG_PTR_TO_TIMER]		= &timer_types,
> > > +	[ARG_PTR_TO_KPTR]		= &kptr_types,
> > >  };
> > >
> > >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >  			  enum bpf_arg_type arg_type,
> > > -			  const u32 *arg_btf_id)
> > > +			  const u32 *arg_btf_id,
> > > +			  struct bpf_call_arg_meta *meta)
> > >  {
> > >  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > >  	enum bpf_reg_type expected, type = reg->type;
> > > @@ -5474,8 +5560,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >  			arg_btf_id = compatible->btf_id;
> > >  		}
> > >
> > > -		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > -					  btf_vmlinux, *arg_btf_id)) {
> > > +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> > > +			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
> > > +				return -EACCES;
> > > +		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > +						 btf_vmlinux, *arg_btf_id)) {
> > >  			verbose(env, "R%d is of type %s but %s is expected\n",
> > >  				regno, kernel_type_name(reg->btf, reg->btf_id),
> > >  				kernel_type_name(btf_vmlinux, *arg_btf_id));
> 
> --
> Kartikeya
