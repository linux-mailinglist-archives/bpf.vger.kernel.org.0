Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846C84CDFDA
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCDVon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 16:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 16:44:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A31FEFBD
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 13:43:54 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQqoR023974;
        Fri, 4 Mar 2022 13:43:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fS6ARAtuWUk/4bakDaLtbTZBUeh0haezRT9GzB6BZZ8=;
 b=J7aTAO0KNLfQdJ2FIyDFhVM6ygGNvGC4cf89NG2Ov6tHepCUdBf8SzOeQwbviOl8VzHT
 KwyR9IvHYzFSrNipvrzPTvSMLMmIO8mT1jSc99nKF0jR6BnuReWGnQanO9D6AIAiQ7PY
 OmYu+Gy63zMXR81OnfomYkvPN+sMqtEfD5s= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4j6ge17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 13:43:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n75ADuQmyOnBGwy/UhalszANqpy3Hf97wv5w92rYMRTPRYTtRM0CHvESslZqnjNIMvfTf0dS/l7oN+CGKS3TAyBdIugQ6ZzVyknd2gamHYsHfyGk4eq3GCOYYH0aFkGWpY40EJu2Sqr1GysRbOL0qDy10TeaatskG4v/LhIkYPLyOPAzEgnVAoNzkhF3AmTZiic0c/MLle4fcPRdb+oJCYCZXbI38KHu1wzsAtF5iGk2tx8Mhp0PuifMK19nCeoBaEi/IePpZsudO3P9CguRczX0Lx+QIS/o0/I7dC/Kus2w/PxYA8RbmiAIXKntOm+ApYW6MrAGj9lJCFObaK+Asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS6ARAtuWUk/4bakDaLtbTZBUeh0haezRT9GzB6BZZ8=;
 b=az3tAK/veRQDV5Fs6YZjrWKrL/XD7cHETQTur/IBkVhPWkSUq0uKCqpjp2boKWWWFKEDpnPmYrH/SJQuwG80XMx9OD9VTcalKCmfhmHjVQ49vQJxjDuS/QicGte1vZpbHXrXCMI8O4wdmOz2Cbt08ojdhgxuEEFcUIwynZs6RAuZSdKlKLVlGsQqwlDEiUF6l3DvvNe+deXoLbtrkwfxrIVigdzOmeC8kT0CqkZw3Fb8g4rITOUcvhGZxiM6fenU7pkinYf+stXGbQefBxnAmT6UzDwjxuKbCAD/DUEdKDl1Ashjmboqv+qDo+VRQFor40KIuQbODXU1GrDWwT4LWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB3211.namprd15.prod.outlook.com (2603:10b6:5:168::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 4 Mar
 2022 21:43:36 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 21:43:36 +0000
Date:   Fri, 4 Mar 2022 13:43:33 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304214333.5f3yzrhghmqf7rkd@kafai-mbp.dhcp.thefacebook.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
 <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
 <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
X-ClientProxiedBy: MWHPR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:300:13d::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21fe6c38-5676-4ef1-094a-08d9fe2809b1
X-MS-TrafficTypeDiagnostic: DM6PR15MB3211:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB32111A7C224D62667A85CE03D5059@DM6PR15MB3211.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHrfbE1ShV+W3DHPsKa9SFi2WxK3ZSRVBygqs9WMdTz3Yr8sPfdWRn55gAe+nGmLLzwGrYGRJh1POZViytldpBMTgIFAmBJzbAjsaawlfzPtvuzADCdjgRLfX7DxYNOSxTshJvEOwDWPMTC4gwgSQ/4RCd0WZyxrWqJlgm6RuqNqfcKwax8TNXmmS28cB7dTUDMc9CKCiHkqzIq4hij0ISzQLiAaTvyfkWrDk2xWOiiGUnxImr4Bm1eQ5S635UyYXRLoWmynCQA0aiv6bsu4/ZxO54y/gpNtTzBbQUtZaULTFtmLtkzhq+Sa2dOlJwhrHdX8ywOP18jKa4Ij8BndFwFythkVG3sHSH+KMHG+mlBT2IGnBeRboa2DkWQ+MmSzmZPW6piemg3rpQ4CjuZTxBEhuYXhc4W5PWG2aZCMrF2CdYEQoB/xbqj3VOd6RDoc9OQJ0Lv/IznGpopUTXWVwFDlTLfb5bQnLD9+F3Mo2/9i3BySvPxjENkMaNUe+VUYhyHL17te7YsFR4WSv4gF8hCAP05grr5MpMpVaXnFv/QjN5D97NMl8vOPMXDtgbDVK3JNz2jJEBcGPKmvVOpiNNWRtOOlP9bN8cQBuyhqyg+HFmFjuLbJaVQmlqcvotrEhSOHngY/5MBmAwe614oXdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(8676002)(2906002)(86362001)(83380400001)(5660300002)(4326008)(8936002)(66476007)(66946007)(66556008)(6916009)(316002)(54906003)(6486002)(6506007)(6666004)(186003)(1076003)(52116002)(6512007)(38100700002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChH3Ogc9U8A6NYAwkj9HPSf5rPfk9nc7DvUtSQH3KvirsLViguG5lGVRuivx?=
 =?us-ascii?Q?LqDo2XqzBHOJAgnV+n5cWLxF3Kw2Wg6x/DJ4T5IJBt65Mj75u04X2DZQAvhC?=
 =?us-ascii?Q?Z1Eo69IxHzAsvEhn9hYafh/uVpWpK7OLcd8h94moPuAr0ERwIyfz8m6/3VHl?=
 =?us-ascii?Q?+kqLlVHvd3QNngm3yLUWu7qXbmUeI7X/UpAPqmKh66Wr+jIAWiHuGVGRMp7t?=
 =?us-ascii?Q?tbklJHlcVN98nov8kZ2qmzf8r8b3973Yo1VaTMJMhAnF08eVVprTmxszsmE0?=
 =?us-ascii?Q?kZ7RpwQ95xs/VCJ6aPd0lm68zQf3czeqEV43rsiJ/ZsuA69cuqxXyTUfLdDA?=
 =?us-ascii?Q?bdrqQxV2BvfH/si/+SEaFMRyLDZNpQdVca5kQuhUWYuQtdpe+qkEnciaW9Iz?=
 =?us-ascii?Q?MtUERv/HQapoxWUF5NDscPytifsPvyweNRJqd8dU5kWcAp7uTjTik2vQFhJD?=
 =?us-ascii?Q?PldLTKVQCwK4IjpeE+bme9qfMbfWKKZHyru6MbyKx81XjPFMwlriv0OdKLuD?=
 =?us-ascii?Q?AFcQrv9+/O+SU1xk6ZE/ETD8i5W6hLWTZ0BZK6Fj5hfyabs0JVuBOC4uq0+X?=
 =?us-ascii?Q?1eVjt7ZeGRjEQB6oQiw6CIcElB4oQrBiFQadxYLoLgupy4Uhjzz1z5OSyM4X?=
 =?us-ascii?Q?+ueW5wzqVwX21krPMWvHuWXn4swbOrVS3CL7lBuySlWBCDmxktV1B0U494g5?=
 =?us-ascii?Q?SY6XHuQ7ojmc/7mzpfI5Uq2aZRBonCgabxA2weKJiwB4KSQAMugoECpPTH0U?=
 =?us-ascii?Q?NrzH52xrPgMHKSdOiXxNS/Y+cDzlLpj/DyAklpnD6icWiqVtfOSoDIq16Fre?=
 =?us-ascii?Q?5Oxk/BCOCb8tJPaJ2lF31zztJGe3VtwWr+e2i9DzYdH5okdsBCG1COwpreL0?=
 =?us-ascii?Q?EFfdIySJ5YoPVFrBBQOMsIPufvxjjVLebfs0zc8FwGHLDolcyul05xT0WRrN?=
 =?us-ascii?Q?7TwUUFXE+LDO4IlKgWySH+ouBvoGKrs6h77lo2HV9Pq0SYpO0CfLZC3KZzDg?=
 =?us-ascii?Q?3s49WjF2Ro8G6Dt0qejzJiOMU9AdsM5vf5glYC2jgpciHF3ZTb5kROD5MGZ1?=
 =?us-ascii?Q?osN6ssNGcICvDhmgLreUe694Hwzo78ai6TmA/RuhUgdJcbiSt1cHNvUPiEMw?=
 =?us-ascii?Q?v3+4tsJcqaOiVQN1ET66LqKj7Dc/qdHKD1vVVA80/JgLQWC9erqqdoDcWG2b?=
 =?us-ascii?Q?DESJkGG76nu6ipklvzV1F9YnhSjJCugomeVi4fVY2Ps/sFiGpdQCY1vvJNYB?=
 =?us-ascii?Q?yT5emkIsRyVPpMAq0k18EERv9DXrMvv/CuKJhhBnO1QWfl5W2lO2Y/2rGbm/?=
 =?us-ascii?Q?v/GdGQmX27eGwVTqd4gJChGZFzAdPFqAmAOjhuB4cqvtMktvaZKVfgLPXOB6?=
 =?us-ascii?Q?64vwHblViVChiGnO0VzvgPVBoI0mPde6cm/uApKn8hp8ik2fMb55ZLckQ7Fx?=
 =?us-ascii?Q?o5sxiIy82Cc2fshmquN0zWxc4W65uGMEA5/0TXG+6NS8vDb0A2aO7M+OQxJt?=
 =?us-ascii?Q?+q2lFCcy/MhkXoO9b4XwR5fZkBNFMGRPTqkfEIpHFjHNU8DoT8HgReXkTnu8?=
 =?us-ascii?Q?pESB/bG/yUAFpKVCyB7KK/2EcaHy3jTimgCd6VQX?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe6c38-5676-4ef1-094a-08d9fe2809b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 21:43:36.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xazx0hLZs5ZO5j0PQAviDuGuE5aKvrAgmjWVoZztr0CbmWgoWjGVnbJOA24hhhB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3211
X-Proofpoint-ORIG-GUID: ZXkaj7Ktdk6EnxjOp__3kpqpzgvC4nS6
X-Proofpoint-GUID: ZXkaj7Ktdk6EnxjOp__3kpqpzgvC4nS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040107
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

On Sat, Mar 05, 2022 at 02:18:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sat, Mar 05, 2022 at 01:58:30AM IST, Martin KaFai Lau wrote:
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 38b24ee8d8c2..7a684050495a 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> > >  		      const struct bpf_reg_state *reg, int regno);
> > >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > >  			   const struct bpf_reg_state *reg, int regno,
> > > -			   enum bpf_arg_type arg_type);
> > > +			   enum bpf_arg_type arg_type,
> > > +			   bool is_release_function);
> > >  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > >  			     u32 regno);
> > >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 7f6a0ae5028b..c9a1019dc60d 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	if (is_kfunc)
> > > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> > >  	/* check that BTF function arguments match actual types that the
> > >  	 * verifier sees.
> > >  	 */
> > > @@ -5777,7 +5780,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> > >  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> > >
> > > -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> > > +		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
> > >  		if (ret < 0)
> > >  			return ret;
> > >
> > > @@ -5809,7 +5812,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  			if (reg->type == PTR_TO_BTF_ID) {
> > >  				reg_btf = reg->btf;
> > >  				reg_ref_id = reg->btf_id;
> > > -				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
> > > +				/* Ensure only one argument is referenced
> > > +				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > > +				 * on only one referenced register being allowed
> > > +				 * for kfuncs.
> > > +				 */
> > >  				if (reg->ref_obj_id) {
> > >  					if (ref_obj_id) {
> > >  						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > @@ -5892,8 +5899,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  	/* Either both are set, or neither */
> > >  	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
> > >  	if (is_kfunc) {
> > This test is no longer needed?
> >
> 
> If you mean the rel && !ref_obj_id below (which is guarded by this check), I do
> think it is needed, why do you think so? Because of the check in
> check_func_arg_reg_off? That only checks reg->off when it sees that both
> release_func and ref_obj_id are true, but ref_obj_id may not be set for any
> argument(s) passed to a release function, so we need to reject when we don't get
> atleast one referenced register for release function.
> 
> Or were you referring to the WARN_ON_ONCE above it?
I meant the "if (is_kfunc)" test.  rel can only be true
anyway when it is_kfunc.

> > > -		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > -						BTF_KFUNC_TYPE_RELEASE, func_id);
> > >  		/* We already made sure ref_obj_id is set only for one argument */
> > >  		if (rel && !ref_obj_id) {
> > >  			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index e55bfd23e81b..c31407d156e7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5367,11 +5367,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >
> > >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > >  			   const struct bpf_reg_state *reg, int regno,
> > > -			   enum bpf_arg_type arg_type)
> > > +			   enum bpf_arg_type arg_type,
> > > +			   bool is_release_func)
> > >  {
> > >  	enum bpf_reg_type type = reg->type;
> > > +	bool fixed_off_ok = false;
> > >  	int err;
> > >
> > > +	/* When referenced PTR_TO_BTF_ID is passed to release function, it's
> > > +	 * fixed offset must be 0. We rely on the property that only one
> > > +	 * referenced register can be passed to BPF helpers and kfuncs.
> > > +	 */
> > > +	if (type == PTR_TO_BTF_ID) {
> > > +		bool release_reg = is_release_func && reg->ref_obj_id;
> > > +
> > > +		if (release_reg && reg->off) {
> > iiuc, the reason for not going through __check_ptr_off_reg() is
> > because it prefers a different verifier log message for release_reg
> > case for fixed off.  How about var_off?
> >
> 
> If reg->off is zero, we still call __check_ptr_off_reg with fixed_off_ok =
> false, which should handle non-zero var_off.
Understood that __check_ptr_off_reg handles both fixed_off and var_off case.

The question was why only single out reg->off case to have a special message
but not the var_off case.  The var_off case does not need a special message?

> 
> > > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > > +				regno);
> > > +			return -EINVAL;
> > > +		}
> > > +		fixed_off_ok = release_reg ? false : true;
> > nit.
> > 		fixed_off_ok = !release_reg;
> >
> > but this is a bit moot here considering the reg->off
> > check has already been done for the release_reg case.
> >
> 
> Yes, it would be a redundant check inside __check_ptr_off_reg, but we still need
> to call it for checking bad var_off.
Redundant check is fine.

The intention and the net effect here is fixed_off is always
allowed for the remaining case, so may as well directly set
fixed_off_ok to true.  "fixed_off_ok = !release_reg;"
made me go back to re-read what else has not been handled
for the release_reg case but it could be just me being
slow here.

It will be useful to at least leave a comment here
on the redundant check and the remaining cases for
PTR_TO_BTF_ID actually always allow fixed_off.

> 
> > > +	}
> > > +
> > >  	switch ((u32)type) {
> > >  	case SCALAR_VALUE:
> > >  	/* Pointer types where reg offset is explicitly allowed: */
> > > @@ -5394,8 +5411,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > >  	/* All the rest must be rejected: */
> > >  	default:
> > >  force_off_check:
> > > -		err = __check_ptr_off_reg(env, reg, regno,
> > > -					  type == PTR_TO_BTF_ID);
> > > +		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > >  		if (err < 0)
> > >  			return err;
> > >  		break;
> > > @@ -5452,11 +5468,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >  	if (err)
> > >  		return err;
> > >
> > > -	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> > > +	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
> > >  	if (err)
> > >  		return err;
> > >
> > >  skip_type_check:
> > > +	/* check_func_arg_reg_off relies on only one referenced register being
> > > +	 * allowed for BPF helpers.
> > > +	 */
> > >  	if (reg->ref_obj_id) {
> > >  		if (meta->ref_obj_id) {
> > >  			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > --
> > > 2.35.1
> > >
> 
> --
> Kartikeya
