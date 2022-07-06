Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8925A56926E
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiGFTMN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiGFTML (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 15:12:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4726105
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 12:12:10 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GsJih018100;
        Wed, 6 Jul 2022 12:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0Ki1gfsPuUDJhsfF41ycX1CyWVgMJmH6qJew6FXQyDk=;
 b=ffMjtF6QkTcpIsEKYLBrIbBLkT6eo0qO7a51hPTmFRU5ttnwq2LiqD5X+btMPX8rjcfO
 OnjT+YRKZeylOG362V8r2wqqAIJ5h78JYgfGfYRKivYw0mqxNjOFT0voWFJ0AeWMBiIA
 d6WegHmPn5A4V88+7abw5ZnWvX6Q17Ik7pI= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uck8ag9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdnSUp2QiaDFKMITEB9owh/oZFZE8eq2M0qy4PYC7MuMh7ZU9xVdx9ylyl5Np8/fJqwVDYhdY5g3GGrGs1DXwYosGz/wBgFGIfBHcdOYV36bpyLaBWFY2IPGsPH6YK86+q/SbQCpfVL+sO2u/4cypNAdE2t+53lwMJObPHEMeGoWRebdP6TBSWts6vqb/1cU+Kj+220rjLLXpHcL/PSd1k7CIK/dxwcb3rcoUuTf3iwDkr3xhwxQoYmUbKBrru/ne1sh1dEvMqxxjr2s1Je6alDtmqbUKVwIFSrnOwFX3cWuVIBV1p5+6CXWMD8lscE0rkOI9M+c+Tulwx2Wkbb00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ki1gfsPuUDJhsfF41ycX1CyWVgMJmH6qJew6FXQyDk=;
 b=UXlxMXB3dZQYTyb+2GzX8ku5S1/gi7Ajy6+ZoxhY7VuebhhCZCul1OoSJutQLHMXjEZasC4hMsuWPASkeXECL9eOLvLzzyLNzuURClPWAZVqsGzLBoBBv3Mxlz0ukmQpJv58AItf/K+Ldrz035B8fHbrX+4RyYca6juykQsxKRaxQNyKrztBMBsMoc9nKCOq5IgonjeYaaUpSe8eb6lkRevdt4hgayxQM20jN6hRhO2yvnBLLWg6QZ4RUh9u+JTdT5mpUXoHmioMG8Ga7b+jB2shF0uWpqC6s26Sq0RK46v9FdXOfNxqi614dJpfxPr1LeYml6GAOa58q5XowQdxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4754.namprd15.prod.outlook.com (2603:10b6:806:19d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 19:11:46 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 19:11:46 +0000
Date:   Wed, 6 Jul 2022 12:11:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] bpf: check attach_func_proto return type more
 carefully
Message-ID: <20220706191143.n42gembkotglgzu4@kafai-mbp.dhcp.thefacebook.com>
References: <20220706174857.3799351-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706174857.3799351-1-sdf@google.com>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc92b9f7-fc9a-4a44-0b71-08da5f835eb9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4754:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5cOygTcAz5KQHP8lkNsIKTdS//CF0geZiY1XnFxGBmYLTDYQnQjPjYl4MWbyMiHf45ZMtpfSENDu/4Rj5n2e/VmhRTdwcqMvbIwMl3POTq1A6G4VMmVPGfEQF2SodwnIQKiFU4Hzn4lCf1OdYLdUJv4af1SqX/qL1mtQgxRnarD6kOX9DC0tcFA9LakRQQTA/yFkW2Xf56GYhmUyfP5ELaijyaLgYjlD0G1655zoMs5d8McJtUYkl6O8oCkPlooZE/SD4hCQQlIy7scTYoyqdA7C3Y009ALF8fwWxtC42Oj5PAp1v+WN1/Gb1EIUlFroMWtLJexoP4H8iwi6teL3ma9IHHsWz9sUTTZ1W6ORDDus7htPOkolR4goZyQqLDwxNBSkCeRL+0wtiOce0vGWCRqsi7+ilH2QSZhbYyIfLtgJaZ/pU8gl/QKiDz7YfnS8GeUWMO0dI5W0iRb9Lx63yA6TfU8cvaysQas72HtTPvMkY7Lqs2Rf9iO7GVRF8i7BdZg7u4R/IscfKHGLJOMGO35hnAk5L0UrxvHv/1S7uJHnIEJB1j908CCoRcSiS4R+wjvByDTnVR2zxdexBA+DZAJPWSpcVy8K3prkCXZ1PIM/RW6sEXEi+wf2KSMTFfmJfdBYJmxpRPuNi1lkk5qyVCz41ao8QQ0OXELULUJpebW4XGYnGImjtpCaAWbyJJmvJ2uHHWZyV01mWpKY575cIm5PapCvKep4ZSA1oMNW6NmsIRgRhXYD+QGVj3sfH55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(186003)(66556008)(66476007)(6916009)(66946007)(1076003)(6512007)(52116002)(9686003)(6506007)(83380400001)(4326008)(8676002)(8936002)(6666004)(478600001)(86362001)(41300700001)(6486002)(38100700002)(316002)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKpIzF20/f14xwMOWec+L+4VTzB+cLu1QjFNXAMEGZ088eelRx+hx32QgDI9?=
 =?us-ascii?Q?K91tMELUvJAKnzUnlqzcytQuz/ouPp5iFHzcMZaEfuRO7o5jT5TLZPkZLB02?=
 =?us-ascii?Q?IS1fMXefuhFvZsjhsrbk5YnGJBf9aEqCxSqX1MpTfuc2UhKIasdS9/34oKRZ?=
 =?us-ascii?Q?zGSdJjwDTJ4kHFXcvoORXUa7ZBYii20k9jP0O6RkJMwqFI+Oclg/I0XSfJ5d?=
 =?us-ascii?Q?q4TaJaBVLwGGJ2OftPXSTGCli8cA7WFxjjicdYHcIe1riGopHp6LfUTzak/j?=
 =?us-ascii?Q?dnWZZNEPkNs/hceIXiPLQqXI2NBNYsWF0M9+lg3cabKMKMMB40CRP8UCHM9C?=
 =?us-ascii?Q?DNw6ZBbAMQyK6TKwwBnWhkZSpYed1MLzlZ/Wd87xfMJLCAY0PGZN5iNR+SN7?=
 =?us-ascii?Q?cSOnYKu7gvKlw00tYJspzb57hD4m7jd1nURn56ezGLIcJG5lU57BDaDOGJl+?=
 =?us-ascii?Q?/aZtBre76ZeMNSEaL0akRu2vpgOx6gEAxdnMuHqi24lYdPKQtLEtUEwT47Zk?=
 =?us-ascii?Q?g855WAGrwkTvsDSx3lXmjti1CKw+P4zKtRvta3TwuffIZkgmBV1VcmiYVXmE?=
 =?us-ascii?Q?A3g1U3bv0SVVUqGFGQ8nTrg0miVqSTRw2o0QwaG3lEaYttsYSWGW5E7P25qW?=
 =?us-ascii?Q?xHodECCeSvA5dFS7KtWnMd56Vpml5sd1oA5ZIQBylBkzr+AMxGQB8Y1Sj6QM?=
 =?us-ascii?Q?sFRqG/A4QASmNCBHxfLqj4vySZY1c20KiEcSVc8aUyo6HzZktXyOBd7aMYxl?=
 =?us-ascii?Q?0EVJrQfSNUCtM89VC9/TUNA5MU2WjkK+c9bxKa3P72ZfpXmfCQQYE+lRQTF2?=
 =?us-ascii?Q?rqi3+zm8RF8SQ4sTK7VblAbfeYShTIs8vfHUSmYziWRexkT7LsJs1bBa6DzH?=
 =?us-ascii?Q?eK9WTKpBS5WLssGZKl0bMs/bU0UwVAe/rROVmy/yk+5ne9z5gfIbNgAI/sxS?=
 =?us-ascii?Q?N4y04W/+76psK1RyUpGFSZo+KyfA22BY8ja5G5bBo084yaXtOLw5bjy0V8Fo?=
 =?us-ascii?Q?M0zNTWro1xmCPo+pBZDCWjQy+2FooZ4r6m1dYJ2fBAF31KI249uyScSo0FHA?=
 =?us-ascii?Q?V0YBZO7tvirLowE/z7LO6vKaqzvSXQB5aTUdnGDO24uOBcvAkws7sUaZzW4G?=
 =?us-ascii?Q?GikfLkLuYaMsZHOJpxyGtADmCZ9GOIozW75x/A0dNLZ9xhT0ivE63d14u9qP?=
 =?us-ascii?Q?gD9WH2ZT9+i+/Vv14IOjYIiiaQJGpvRFwXCWO04pcvk7Mavq1IG5c7u1Ny+C?=
 =?us-ascii?Q?N1Emor3iGoqXq36LEhg+P0ky6ebU6mHMJYqdFNW8IL8ipAN2KVaNl6Q4NOYT?=
 =?us-ascii?Q?JXVhlJHN7+AlpHmgwepknKCZkxhsj7/bJ6qT4baZJSrfeeqev5nh82XmjPlh?=
 =?us-ascii?Q?e6Jvx2SFt9zmQfvHhXM0KDIO00ya8fb+ImJTskTDK9ZM59hhGE8H7HfCQJtD?=
 =?us-ascii?Q?WQCT71SkX6D+OlRMIsp/ub1d1a76b+woj8gzPSnkbOgye8SAXoig96iDu3UA?=
 =?us-ascii?Q?qbvoSUsecXYS5LCfr/qJG8E86C9xZOIan6f15q/ky4mZvWclg4AqfmuB/pc7?=
 =?us-ascii?Q?pdzesYZSJE6QaJITWZNNQbxVoyIbsr6xuMtcjkthbEjHo8qbzUqIwhBng+cv?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc92b9f7-fc9a-4a44-0b71-08da5f835eb9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 19:11:46.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25+5ooK4Ex/HwE6y+k1XUxUUZtGDxOvnvPPj/1QHMUOIzQ+MoV5q2ML82vwyXo16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4754
X-Proofpoint-GUID: D9KptznUcdvBZNUw8hESKovGgRO2TDGR
X-Proofpoint-ORIG-GUID: D9KptznUcdvBZNUw8hESKovGgRO2TDGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_11,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 10:48:57AM -0700, Stanislav Fomichev wrote:
> Syzkaller reports the following crash:
> RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> 
> With the following reproducer:
> bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> 
> Because we don't enforce expected_attach_type for XDP programs,
> we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> part in check_return_code and follow up with testing
> `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> is NULL.
> 
> Let's add a new btf_func_returns_void() wrapper which is more defensive
> and use it in the places where we currently do '!->type' check.
> 
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/btf.h     | 5 +++++
>  kernel/bpf/trampoline.c | 2 +-
>  kernel/bpf/verifier.c   | 8 ++++----
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1bfed7fa0428..17ba7d27a8ad 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -302,6 +302,11 @@ static inline u16 btf_func_linkage(const struct btf_type *t)
>  	return BTF_INFO_VLEN(t->info);
>  }
>  
> +static inline bool btf_func_returns_void(const struct btf_type *t)
> +{
> +	return t && !t->type;
> +}
> +
>  static inline bool btf_type_kflag(const struct btf_type *t)
>  {
>  	return BTF_INFO_KFLAG(t->info);
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 6cd226584c33..9c4cb4c8a5fa 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -400,7 +400,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
>  	case BPF_TRACE_FEXIT:
>  		return BPF_TRAMP_FEXIT;
>  	case BPF_LSM_MAC:
> -		if (!prog->aux->attach_func_proto->type)
> +		if (btf_func_returns_void(prog->aux->attach_func_proto))
>  			/* The function returns void, we cannot modify its
>  			 * return value.
>  			 */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3ec6b05f05..e3ee6f70939b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7325,7 +7325,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		break;
>  	case BPF_FUNC_set_retval:
>  		if (env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> -			if (!env->prog->aux->attach_func_proto->type) {
> +			if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
>  				/* Make sure programs that attach to void
>  				 * hooks don't try to modify return value.
>  				 */
> @@ -10447,7 +10447,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>  	if (!is_subprog &&
>  	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
>  	     prog_type == BPF_PROG_TYPE_LSM) &&
> -	    !prog->aux->attach_func_proto->type)
> +	    btf_func_returns_void(prog->aux->attach_func_proto))
>  		return 0;
It seems there is another problem here.
It returns early here for prog_type == BPF_PROG_TYPE_LSM.
It should only do that for expected_attach_type != BPF_LSM_CGROUP.

Otherwise, the later verbose(env, "Note, BPF_LSM_CGROUP...") will
not get a chance.

>  
>  	/* eBPF calling convention is such that R0 is used
> @@ -10547,7 +10547,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>  			 */
>  			return 0;
>  		}
> -		if (!env->prog->aux->attach_func_proto->type) {
> +		if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
>  			/* Make sure programs that attach to void
>  			 * hooks don't try to modify return value.
>  			 */
> @@ -10572,7 +10572,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>  	if (!tnum_in(range, reg->var_off)) {
>  		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
>  		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
I think the problem is more like missing
prog_type == BPF_PROG_TYPE_LSM [&& expected_attach_type == BPF_LSM_CGROUP] here
instead of testing !attach_func_proto in all places.

> -		    !prog->aux->attach_func_proto->type)
> +		    btf_func_returns_void(prog->aux->attach_func_proto))
>  			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
