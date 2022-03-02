Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F217F4CB1A0
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbiCBV5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbiCBV5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:57:47 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878B5EDE3
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:57:03 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMhvK029783;
        Wed, 2 Mar 2022 13:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KF5z7knBYq/Fva4WhvwN7PAujim4iEqHxQn1ulxuKyI=;
 b=EQt7YqoqCsPoNgBIvbQN6ZgQRuViNARtJrh2+Z35aGym8vjPlTUxKIwjiOwu9f6QsMHE
 Z+QaEfuHvOnb3U5zRUXY/OtZQKlXMTdFy2AkBEojCXzbIEYTRgMcUhlNezVMAVvIVOCX
 sAEtPOzV1apRkDW8ioD2+V3uWb5o4RXCSZk= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej1r0rafv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGdNgRkcUvXEU5ASr+iGD0mKcbWHlT/3nnch3GmKuiQxdfjwWvG3NoQSxCbxQA6bHI/NHoCFusjQBIg2oFIYtJLKw0266NjFQttmwhFwsx6/JytWOOcFGo9d54vr+rb+RWITfFTRid0+W0WmKw0oZRFeG9RjSh/WKAiQcMQaaCFKNyIMKrnKh1TCA2sZ8EZCtOufTCTuF2u/nK6weN/hJB0wD28YQfvGJvsfY/QtkC/GQbeI3vcXUtcp3pOeefS8DbIIDdM6/J55CLqHENoVfXCsf2Zo5a3ABbs4i/zWE51sOJq79RDCaHlaXz4mWIeNOomNnnuPWX+MimdHZn8k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF5z7knBYq/Fva4WhvwN7PAujim4iEqHxQn1ulxuKyI=;
 b=RjEvOgC2FH94oNonVfQV/0CP7KYK69hSTY2OtrhlsbRJojGm8uGqI0r7kokjbU/PZKwv0pw68LbBouDcIBKLFCiKChnZSzRLLTyn//RumKy17kHIrnC7StmINWLyUM6ZN5jYBv5dq7Uvs35eN92t0oj3Awdk8DOek+0IpYzxr6tAkaFJTPxBT61mNX5gGp1FdJcZViXnWt1RVT5D5NibHxcQsmA2P2vLl1mA+W1nO3TLD9yqHabqXE1/gR3ya/sFc8GRXlfnXvJFKP5vuswowBCFInLrXOWym+EIGRZuiv1HPaoWcSBBDSKM5x0XDYLQKTSVsoxNbEMi+8gUAQraow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM5PR15MB1756.namprd15.prod.outlook.com (2603:10b6:4:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 21:56:45 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 21:56:45 +0000
Date:   Wed, 2 Mar 2022 13:56:40 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
X-ClientProxiedBy: MWHPR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:300:13d::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e824565c-0acd-416d-1bd1-08d9fc978b32
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB17567C06C7CD5359EC940DC0D5039@DM5PR15MB1756.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LPzoYpC+wIP3A59ehF1opXbiN9Bo4u23x/Os84XUE3/idcEA963V0BG0qeFgLo+zK5iZVAJFOXfZ97FuScEWFRA7c4KYGa0zvjAY6dsLyv5be9x95j+5PoyI+kNXMZYDQ8i+SDanNliL9oMIkbeLzi1lQGHM0rIvm+F/U3fSaZjhHTOBAHBVO6o8ZiJUsZ4NurUjj15nrEWN6HwDPgVtn3StH0qTSwks388CXYwSZioYNHtyKA4cSL1VbQkwFpTQmeNyX0IVgDuoRlQmoPW5q2h1brmRjhAt4z81GyVRTjWHWxcw2cbTy36RCF5YREBCD82inWRf7EovK92LfoouTp/9As1sezgwkZ25cy39+KXnIE0prQTlhutIFAnheR9te0moS7BWyBfPdwGvAnJqPrgTAzlKTSJwjzy5XZpmMG505ZmkplJd85guOp0F+qCIax7qPyoDNA+30DX2bbv3im9yYJg260SSvELUhrUDWSycPeyeTVXJauwC7oPfvhf/Q/mQcc6VI7O81IrjVSgcKk/haaRleaWHIMeEW3CRGzA2BTCIgWARVY6TAVqzSSfNxy3l76u1mcqynHBIICHLOHEeW/7Y3j2j93edAAr7k4IT2DySuxXFougGzDxLccVbdxeToeFpDNqDSSZnc0avV2UryKzO4mbzFrGAiaRMkEQPh2N0O10mpaQ6J2AWwr4ScdoBJeLOODEqO+ss+4s4I2OmhhTSPhp70I/tYe/yLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(2906002)(6916009)(186003)(1076003)(6486002)(9686003)(8936002)(966005)(54906003)(66476007)(6512007)(86362001)(508600001)(5660300002)(6666004)(66556008)(33716001)(66946007)(52116002)(6506007)(38100700002)(4326008)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIuwJRq/MXs6ye4Ltp7prLACU5iFT1aWI/maaPoVj/WSc5DJ0FXxP6Lco4or?=
 =?us-ascii?Q?vLE4cYdfVpylDcKRkxjIMYuaa1UgMX5UQvc9anGI947Qu6InYLqmUc5TeZx1?=
 =?us-ascii?Q?a2JPZjxsXoRVYpNtW6jFmyIAj4QFxeFjhe/ifHd0LMlUSb1/P35dvvJp3NZ/?=
 =?us-ascii?Q?hCPay5rfY9RgTXbxVmpil9rCZQeaP1aDhyRCP1DcTJ+wNeeiy0FfmN+vJeCo?=
 =?us-ascii?Q?SCMeO7365GDYyLE24XbNborFQMMqxz/3rrF6URob4mfJJa/zvf+944QS4pA7?=
 =?us-ascii?Q?PvI4SXolSiBSmpHVG+R1LhtJ+55kWH7yjrD0JSVZjL0ziuMSXvJWarmXLF0l?=
 =?us-ascii?Q?9K5LxQajwmtpdnlaHL5EccdhuTLq8f71oreO4k6LxKst2+mxIyR4TiDDGB6F?=
 =?us-ascii?Q?wx9sTDRR4u3V5Ote/40vX3fRk7ZEBGIYLiZQqlm+5OQg1ZLnBGewM8UrfqLx?=
 =?us-ascii?Q?RpnBLH0+pjac66Y4cp5rEGsTgExIcrf6xedAFOMDu8hpnFi1wZlt57VGWTZs?=
 =?us-ascii?Q?AynWvDDkzEUPhB2rtOcLSfWsDBtJVAwEvURBm8aoUNlWMEV5Tx7zLW+R2dSB?=
 =?us-ascii?Q?U5jjDwugwrfk6X7KJo8YHukcPsh+DM3CBnrjX4xhJcK/Ua4g1ByYFWfrnjEl?=
 =?us-ascii?Q?hbahSWpR2iMZOHiVSG0ZHIELC9lkK9nOdH+Ufq9cqlYAsCxo28pg9HHph01G?=
 =?us-ascii?Q?JBl6lt3CepScE8+nRLKoJzvDRVbXu7DWozLt5Azh8sdBNEfceHMORHldMl1y?=
 =?us-ascii?Q?9/Acfh5woY0Y2Hr4gx8dMNFMUdDMDjxkGpy6+MQhOLBUJfcCtcOe0urruC46?=
 =?us-ascii?Q?yGruELJqA+pRXT7QL15B8zS2GZVI9HskwRRjqMwUZzs/a++J97kwZN0FCIb4?=
 =?us-ascii?Q?JMCQ+2b47KhMS5hJm0FknRZVhK8KNrjc2eVGr0fjaj8En5T4c9ZhG9Isz8bi?=
 =?us-ascii?Q?MRBDQp1Ig/R0BjCrB1NOMSJFNH1W0sPmSUGLeoYqHdYO4ojewityNrXxfBRz?=
 =?us-ascii?Q?595rRIpFmY84jMt+pg1uDhiQF7GfTRzAmWW52s0CmgqxkND+EC5BxuiqWtIT?=
 =?us-ascii?Q?CMWddXSYS10u5LI+Y2zG0GL2qEEdsW1wl9Tw+Sat5tbgqhcAFhNI/eDSMPlE?=
 =?us-ascii?Q?Vho/+p2dyWfdN7+si7yGP3jv4v5IKY+IVyAUgntSKbna3huAit14Ukx98X3F?=
 =?us-ascii?Q?46I20eOufTKgmmXTuJRsw4GwVQzNyABLTJm5qlCRrIZ6BnF6YPLCw0i9ZLdI?=
 =?us-ascii?Q?i844vIMxWPZbV8b8N4WjxrGCGH2wWs+L4r/ji7bGmXw5bMEAgShOuLxb28gx?=
 =?us-ascii?Q?IWyG96WaI/p2yJ6In5FbYHjuqCSHlp+WCL2oPCZTGC29gXS3oFrEuduJ7TS4?=
 =?us-ascii?Q?jKcy5Dq+ybRln28ZnrH+Ad2chNL4Tzjy4mZdaTskZL9rGNhQ8nmFXx0OYag/?=
 =?us-ascii?Q?ZcZq3jGdGD10r/4CX7o+cpaqOfAp3GglEqkeEx9zP7gu19iru6J40+k9TJRc?=
 =?us-ascii?Q?gw2nuLK4fcj64zBPjD3rKXDSjPwE8rZpWHjsLf5ZL+crJ1UOxWmeJg62z2qS?=
 =?us-ascii?Q?wxzg0WR17szSe+U4AcugPn0XDoYmpLUJnRVBs5Hq?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e824565c-0acd-416d-1bd1-08d9fc978b32
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:56:45.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rdo6S9vQsWd9gQBGTSgwrD39mV7mGr2sycp+dSnJwE4W/f2rFa78of1J3Vg2A2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-Proofpoint-ORIG-GUID: iq7X1SfHrxBFkDPfyFrD0iLJxulC_Rpj
X-Proofpoint-GUID: iq7X1SfHrxBFkDPfyFrD0iLJxulC_Rpj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020092
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

On Wed, Mar 02, 2022 at 03:12:18PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, Mar 02, 2022 at 08:50:24AM IST, Martin KaFai Lau wrote:
> > On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> > > always has its offset set to 0. While not a real problem now, there's a
> > > very real possibility this will become a problem when more and more
> > > kfuncs are exposed.
> > >
> > > Previous commits already protected against non-zero var_off. The case we
> > > are concerned about now is when we have a type that can be returned by
> > > acquire kfunc:
> > >
> > > struct foo {
> > > 	int a;
> > > 	int b;
> > > 	struct bar b;
> > > };
> > >
> > > ... and struct bar is also a type that can be returned by another
> > > acquire kfunc.
> > >
> > > Then, doing the following sequence:
> > >
> > > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > > 	if (!f)
> > > 		return 0;
> > > 	bpf_put_bar(&f->b); // release kfunc
> > >
> > > ... would work with the current code, since the btf_struct_ids_match
> > > takes reg->off into account for matching pointer type with release kfunc
> > > argument type, but would obviously be incorrect, and most likely lead to
> > > a kernel crash. A test has been included later to prevent regressions in
> > > this area.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 7f6a0ae5028b..ba6845225b65 100644
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
> > > @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  							regno, reg->ref_obj_id, ref_obj_id);
> > >  						return -EFAULT;
> > >  					}
> > > +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> > > +					 * always zero, when passed to release function.
> > > +					 * var_off has already been checked to be 0 by
> > > +					 * check_func_arg_reg_off.
> > > +					 */
> > > +					if (rel && reg->off) {
> > Here is another reg->off check for PTR_TO_BTF_ID on top of the
> > one 'check_func_arg_reg_off' added to the same function in patch 2.
> > A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
> > considering the btf func does not need ARG_* to begin with.
> >
> 
> Right, arg_type doesn't really matter here (unless we start indicating in BTF we
> want to take ringbuf allocation directly without size parameter or getting size
> from BTF type).
> 
> > How about directly use the __check_ptr_off_reg() here instead of
> > check_func_arg_reg_off()?  Then patch 1 is not needed.
> >
> > Would something like this do the same thing (uncompiled code) ?
> >
> 
> I should have included a link to the previous discussion, sorry about that:
> https://lore.kernel.org/bpf/20220223031600.pvbhu3dbwxke4eia@apollo.legion
Ah. Thanks for the link.  I didn't go back to the list since the set is
tagged v1 ;)

> Yes, this should also do the same thing, but the idea was to avoid keeping the
> same checks in multiple places. For now, there is only the special case of
> ARG_TYPE_PTR_TO_ALLOC_MEM and PTR_TO_BTF_ID that require some special handling,
> the former of which is currently not relevant for kfunc, but adding some future
> type and ensuring kfunc, and helper do the offset checks correctly just means
> updating check_func_arg_reg_off.
> 
> reg->off in case of PTR_TO_BTF_ID reg for release kfunc is a bit of a special
> case. We should also do the same thing for BPF helpers, now that I look at it,
> but there's only one which takes a PTR_TO_BTF_ID right now (bpf_sk_release), and
> it isn't problematic currently, but now that referenced PTR_TO_BTF_ID is used it
> is quite possible to support it in more BPF helpers later and forget to prevent
> such case.
> 
> So, it would be possible to move this check inside check_func_arg_reg_off, based
> on a new bool is_release_func parameter, and relying on the assumption that only
> one referenced register can be passed to helper or kfunc at a time (already
> enforced for both BPF helpers and kfuncs).
> 
> Basically, instead of doing type == PTR_TO_BTF_ID for fixed_off_ok inside it, we
> will do:
> 
> 	fixed_off_ok = false;
> 	if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> 		fixed_off_ok = true;
For the preemptive fix on release func and non zero reg->off,
should it be a release-without-acquire error instead of a ptr-type/reg->off error?
The fix should be either clearing the reg->ref_obj_id earlier or at least treat
ref_obj_id as zero here and then fallthrough the existing release-without-acquire
error.  It is more to do with the ref_obj_id becomes invalid after reg->off
becoming non-zero instead of reg->off is not allowed for a specific ptr
type.  It is better to separate this preemptive fix to another set.

> 
> Again, given we can only pass one referenced reg, if we see release func and a
> reg with ref_obj_id, it is the one being released.
> 
> In the end, it's more of a preference thing, if you feel strongly about it I can
> go with the __check_ptr_off_reg call too.
Yeah, it is a preference thing and not feeling strongly.  
Without the need for the release-func/reg->off preemptive fix, adding
one __check_ptr_off_reg() seems to be a cleaner fix to me but
I won't insist.
