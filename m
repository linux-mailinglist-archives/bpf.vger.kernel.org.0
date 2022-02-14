Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F94B4D44
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiBNLGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:06:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350197AbiBNLGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:06:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C289BC0D
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:35:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E81cKh003692;
        Mon, 14 Feb 2022 10:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uP23a9uX9rl7IH/U1YZaVs0EQ96ZiIB7e6DwkH7X6dY=;
 b=rOo5IRgmUA2IziysP6PZwRxKAz/kx5BIxZdwHGHDjUAe20kOfL7JaHnqjugXd0Adysp4
 das7TIzV79TUlzfN5Hek1w8/9bNqIKt5UIsankSJ1pQF3W0So8KWZ5BWGtgzqcsnircD
 k/VZHh0gRXYbaeWK0x/LFKYhdG591vfq/GpgFnzXu3ThDivuUtVaM/wzP0zNSYMfBMUF
 rlqaUEH4vX53nJYbu8y/drT4+N6HlQc40xM9Dkspjmyp6k4Dy2dpwR21hmXD/8VfdASj
 +a+kYC2QtfBEv+GhxGzgp9xq+3zbLqc+ZY8+MAF3xGXqXZ8WV2xPB6K4PNcR/olLMSVG 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63ad420s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:34:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EAUhq3122513;
        Mon, 14 Feb 2022 10:34:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3e66bkt33c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCexqg5FU89DMwX0vIHxekZ3ByI4NteTcuKJOs3gf6lNhDcUsLmBOgN6By9JIyMS8N1Bp9vAan0anBdclVGFf3w0gYN/H/6+FQ2jtpPuY8HjsaE87boskT2DBnFbaltmoPe28LOjdTJD2XknDJkHnUDMepUTjxI5Q2pvKCdvfF1yLcLu8qlURoV2EjHyeCATKJKNq5fZmpOs+DxlaZS+MD0yy3Bz/cumGXPusyJIbF5riRr02OUJ5GzuBbisMctCCzoj68L9EO5UcAhQoiA08vF6NgjlC3RJe5W9HXH1yTqCjbtjF+m+eB2s50oJBOdPI5in9d7E/nHri4psh/tchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP23a9uX9rl7IH/U1YZaVs0EQ96ZiIB7e6DwkH7X6dY=;
 b=Rr+GH3q5uCjY+6cYkA4wvHjqX9od1qv3JlwL2SKHeePw/UyrngLPFO1soRClu4/HvhP4Pf+5suKzOpgx7cbpaPgb2D/cyewUFrYjG+Ayw+rEnSxbQ6Fpr5jsO8dkcj09iwibhT/rxilQUuCnauVEr/iENLib14JTwFKImpGxR6glSFBai4X/GuZm6/5Y2lcJihJf4UnfCYwDkow50pgQJ2TXh1Ca6IoCRNZxSPNhBAFHlLzz2ARk3h6UaHxffe6bOB/WmJ3WlTI0B/TtqQ1AAyGn30iuDMeUrUCtvdOyoyhmz1b9zulpKH5cxY0Anm+QFq+jZH7gwyBI6z72D9ab0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP23a9uX9rl7IH/U1YZaVs0EQ96ZiIB7e6DwkH7X6dY=;
 b=srZlHtLcjHCG5f1I8FhkrBklglpLm3z3eteYEhpZkPYn8RKaHIsvhndMj/+AjF7tIAi0SYmK7Oo098PBY2Ysk17tZwowt3lmyJ0XQVWcnKLobHoCVB4hRXbmVupXNAUmQZB+jRp8DYJ1Jh9ba6DoTfO1AXyVR8BR4LniQuJuBvw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 10:34:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 10:34:40 +0000
Date:   Mon, 14 Feb 2022 10:34:14 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 2/3] libbpf: support custom SEC() handlers
In-Reply-To: <20220211211450.2224877-3-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202141032160.9032@MyRouter>
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-3-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daa1f96b-7b8e-442c-c024-08d9efa59b17
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5439421002EA89F87CB8565DEF339@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj+llUPxqoKJtPo2tGsnszUM73zuAxD0A3QMqcATqD3fSf5x4ZU6Qp5BFAyKUDuksiquRr++HhV31BGvtDpvqj1ro4sRc6ePiiMFVprRybwvwcaTbwPd1qG4E4ef9/tu0z1+sVThgd5djBQC05pGKzG0QLiUx355cETzwV7EysA1T9s6Bz+KZD3ntvf7zIteQXgGhQx3onLUIptl5aW3qXsZAaVGlB+flGxusXGkjQ4rViBtPjzZKqlIhY+6OiKZ4SxUbV5XqpWWvG/det1xITJoizHrJSn0K/j/PRZuBuXpRnuFmm6gHskMk/GSvkl3d8LV01w2lNqEHWFyvava0N5XzsSqnAx5qGaq8qlkoM3BnAVy0AWjGgLMgd1KBA352KHKYThJP2sXDNgIEmCSKKSQ+GHj9ikdqGu+JYDdeXviMpnr7lrwfAacV7whZiAcE/4sFWulGDofyNnsSQlMMS/fRuX9fYhxEwcjcxKER566KYCxkDIVMCX2BI7q+Jbc+PCK5ytMcZEd03glsJGE9AdxVj/+ln3BkBqngzQsAb1l4LKLnPTPG5gptRbh3kJd9LHxt1VA0dgIkLDNjYlCDtMOGMLnvxrMR2oZ6q1IOBqyp8W/cCtpFXRbyIc4TUf1XLh4YPZAu1Anw2fMFLX4cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(83380400001)(9686003)(5660300002)(107886003)(30864003)(186003)(6512007)(316002)(66946007)(66476007)(66556008)(6486002)(508600001)(4326008)(8676002)(44832011)(52116002)(6506007)(33716001)(38100700002)(86362001)(8936002)(6666004)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lEBs+Pq023oI6TSMELRtJ2Xy1WjnAvUTW6WoHOP5QaAiJ7wwh3JhXz1G1u7d?=
 =?us-ascii?Q?8TZ2p/ur01UdohATQn1QAbW9RM5QLoBKy2Ahnj60mShwTqMzSUtO9sZ3HtD6?=
 =?us-ascii?Q?0kOmx3i2kaFqZmfV4nG8UbXd5aVotVhEeOreySMeCt++h+JDTg8Jxa7/ov/m?=
 =?us-ascii?Q?ds7RW/duEFyy3y0CIyoBuwQM00dUo5/Is4QwwzhH4VSe3Da81Yx21dNd6E6W?=
 =?us-ascii?Q?V6JQ/K42uq2SN8Cdy+S1JUcMl1X5hlUz1edki+lA+t/eE8ZHG8qbURLLWP98?=
 =?us-ascii?Q?gjT0HbA0YqrfdmbWvQAyKtEQVlx1brA7kQ2dIl8bukY34pNxj0IopFez/M2o?=
 =?us-ascii?Q?576ECdnJ+yWDjpq+xM8dfTNignV8F1GsuPA+LFXHip4pbqkvA8ikAvbL97Iq?=
 =?us-ascii?Q?Bjt19yIgnepFevCz5nT7Nw92Fm39VUXXU+yQV4RHNnc52ACeZs4ybaFk1XBs?=
 =?us-ascii?Q?Fu9io5FOOnGtHpYF5JxzeT+u8waPKbBGQJ+Ke0kUxmqM5lZZHuNDKhoqVZN+?=
 =?us-ascii?Q?h48SaK0WKP82ZSL/NP4FRO337ep59dQsPFDrz5X8Yq9pSDcV4DDxrFRnvp9i?=
 =?us-ascii?Q?WF43r7G8sLtfFaBqKryqdvaZ5LXPFl3O5fC8RTNj6kGZyjkyQEdQitxZrg+2?=
 =?us-ascii?Q?6JKqILXIbLwAB/CscktHRiiYjxnBEDC2UsgStIVyIDkswe4kEfmehuX4ZeDp?=
 =?us-ascii?Q?yrrkxebdhPACAlyVOovv6vKQ+g8wyVjwIuufv1o5mb81FvijR+e0NMMYoX3K?=
 =?us-ascii?Q?NT4VbkpNqxxq0DSYwi62+FfSguWe2ToUGl0g0TqUfmY4ASw16HG2K2cdC9hF?=
 =?us-ascii?Q?YaT9Zta8OIZB/9tMY/GF6fWQmRNTlfxus04V9UeEJUBqyunOG0JeEK22ppuE?=
 =?us-ascii?Q?yaAn1AW55viWMABRzOoRboHBUGF5jFtz11+8zb/pqfVkiZ6DLrA9k+zN8kbg?=
 =?us-ascii?Q?XvGqxK8KZTop4T7kifPJhKPxZBKEVqh7gCyt2hnNxbwYpvOP427OmRA2T1gS?=
 =?us-ascii?Q?+0p69dTKvsJh9Ex635qrHY7fiXi0NPA/1WyQ4n7b6bqhwm364mfEynOCAJ0N?=
 =?us-ascii?Q?HDZTK6UPRI6F5zLwVFEsR80uTFOCluD0/Pd9gik7bQd51DMOjlaKftdDAYPG?=
 =?us-ascii?Q?fFSKX2qu0vGhLxdiMnfEkQ7N8MpM6kkS6HSAWXLRvJo3VxJrXAnePpqCjkbO?=
 =?us-ascii?Q?77YGiK4ox5RScHbAr3Wm5kg/P4Dvj9F34NhBw4jDkwCJRS+lcTjWBkzZKAYY?=
 =?us-ascii?Q?bvlZqdZs7xzFBE3cHv2e7yC5UNRV+ve+R1CnvzGM81lODg60lFIsiWRIcTsX?=
 =?us-ascii?Q?fu9Lmk5c7fEImmL4e2rcp7Cjtk4Kyd5ic7YAPJ+z70hx1QUnkAcUXCJsKvop?=
 =?us-ascii?Q?J9TXL0B0rlR0v4cKlid6r7BDSt4GfZiiBJKro157CNV0QnolcwaCkS654pGT?=
 =?us-ascii?Q?ilL8zEPZOUIX7fpR8ghxp5sN7YI/+wXpG166TL2F4B7peJvwCts19c6OozUC?=
 =?us-ascii?Q?ExqSCPAlRD5LdbTO3D9BuFFo/zA9TV/OjqY5K8spWdd0OI/CMtutSkXz/8W4?=
 =?us-ascii?Q?H27cBR8oVR604+nMx+Y5yeMNovOtYyVWJaxGrWkwSD83wYy1tnK8goTd8LSj?=
 =?us-ascii?Q?OXfgKyaRd7N71ype8BOPNyME7aTHBtlIicyjpRpkBlBk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa1f96b-7b8e-442c-c024-08d9efa59b17
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:34:40.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41MOnRyFdpkTvi4SDUyHUj2sYSGmf6BVtQFxDJ3N1ZuHHiXcTrqXpjr2exJCZwb6tMNbLwUDeb4jgaPVfpPofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Proofpoint-GUID: Z2za4lkuKF7LOiaO46iBpwpER3eCuyxl
X-Proofpoint-ORIG-GUID: Z2za4lkuKF7LOiaO46iBpwpER3eCuyxl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Feb 2022, Andrii Nakryiko wrote:

> Allow registering and unregistering custom handlers for BPF program.
> This allows user applications and libraries to plug into libbpf's
> declarative SEC() definition handling logic. This allows to offload
> complex and intricate custom logic into external libraries, but still
> provide a great user experience.
> 
> One such example is USDT handling library, which has a lot of code and
> complexity which doesn't make sense to put into libbpf directly, but it
> would be really great for users to be able to specify BPF programs with
> something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
> and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
> uprobe) and even support BPF skeleton's auto-attach logic.
> 
> In some cases, it might be even good idea to override libbpf's default
> handling, like for SEC("perf_event") programs. With custom library, it's
> possible to extend logic to support specifying perf event specification
> right there in SEC() definition without burdening libbpf with lots of
> custom logic or extra library dependecies (e.g., libpfm4). With current
> patch it's possible to override libbpf's SEC("perf_event") handling and
> specify a completely custom ones.
> 
> Further, it's possible to specify a generic fallback handling for any
> SEC() that doesn't match any other custom or standard libbpf handlers.
> This allows to accommodate whatever legacy use cases there might be, if
> necessary.
> 
> See doc comments for libbpf_register_prog_handler() and
> libbpf_unregister_prog_handler() for detailed semantics.
> 
> This patch also bumps libbpf development version to v0.8 and adds new
> APIs there.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks great, thanks!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/libbpf.c         | 204 ++++++++++++++++++++++++---------
>  tools/lib/bpf/libbpf.h         |  87 ++++++++++++++
>  tools/lib/bpf/libbpf.map       |   6 +
>  tools/lib/bpf/libbpf_version.h |   2 +-
>  4 files changed, 246 insertions(+), 53 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c4acb72d3c7e..2849017aec07 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -201,13 +201,6 @@ struct reloc_desc {
>  	};
>  };
>  
> -typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> -typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> -					struct bpf_prog_load_opts *opts, long cookie);
> -/* If auto-attach is not supported, callback should return 0 and set link to NULL */
> -typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> -				       struct bpf_link **link);
> -
>  /* stored as sec_def->cookie for all libbpf-supported SEC()s */
>  enum sec_def_flags {
>  	SEC_NONE = 0,
> @@ -235,10 +228,11 @@ enum sec_def_flags {
>  };
>  
>  struct bpf_sec_def {
> -	const char *sec;
> +	char *sec;
>  	enum bpf_prog_type prog_type;
>  	enum bpf_attach_type expected_attach_type;
>  	long cookie;
> +	int handler_id;
>  
>  	libbpf_prog_init_fn_t init_fn;
>  	libbpf_prog_preload_fn_t preload_fn;
> @@ -8574,7 +8568,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>  }
>  
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
> -	.sec = sec_pfx,							    \
> +	.sec = (char *)sec_pfx,						    \
>  	.prog_type = BPF_PROG_TYPE_##ptype,				    \
>  	.expected_attach_type = atype,					    \
>  	.cookie = (long)(flags),					    \
> @@ -8667,61 +8661,167 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>  };
>  
> -#define MAX_TYPE_NAME_SIZE 32
> +static size_t custom_sec_def_cnt;
> +static struct bpf_sec_def *custom_sec_defs;
> +static struct bpf_sec_def custom_fallback_def;
> +static bool has_custom_fallback_def;
>  
> -static const struct bpf_sec_def *find_sec_def(const char *sec_name)
> +static int last_custom_sec_def_handler_id;
> +
> +int libbpf_register_prog_handler(const char *sec,
> +				 enum bpf_prog_type prog_type,
> +				 enum bpf_attach_type exp_attach_type,
> +				 const struct libbpf_prog_handler_opts *opts)
>  {
> -	const struct bpf_sec_def *sec_def;
> -	enum sec_def_flags sec_flags;
> -	int i, n = ARRAY_SIZE(section_defs), len;
> -	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME;
> +	struct bpf_sec_def *sec_def;
>  
> -	for (i = 0; i < n; i++) {
> -		sec_def = &section_defs[i];
> -		sec_flags = sec_def->cookie;
> -		len = strlen(sec_def->sec);
> +	if (!OPTS_VALID(opts, libbpf_prog_handler_opts))
> +		return libbpf_err(-EINVAL);
>  
> -		/* "type/" always has to have proper SEC("type/extras") form */
> -		if (sec_def->sec[len - 1] == '/') {
> -			if (str_has_pfx(sec_name, sec_def->sec))
> -				return sec_def;
> -			continue;
> -		}
> +	if (last_custom_sec_def_handler_id == INT_MAX) /* prevent overflow */
> +		return libbpf_err(-E2BIG);
>  
> -		/* "type+" means it can be either exact SEC("type") or
> -		 * well-formed SEC("type/extras") with proper '/' separator
> -		 */
> -		if (sec_def->sec[len - 1] == '+') {
> -			len--;
> -			/* not even a prefix */
> -			if (strncmp(sec_name, sec_def->sec, len) != 0)
> -				continue;
> -			/* exact match or has '/' separator */
> -			if (sec_name[len] == '\0' || sec_name[len] == '/')
> -				return sec_def;
> -			continue;
> -		}
> +	if (sec) {
> +		sec_def = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt + 1,
> +					      sizeof(*sec_def));
> +		if (!sec_def)
> +			return libbpf_err(-ENOMEM);
>  
> -		/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
> -		 * matches, unless strict section name mode
> -		 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> -		 * match has to be exact.
> -		 */
> -		if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
> -			if (str_has_pfx(sec_name, sec_def->sec))
> -				return sec_def;
> -			continue;
> -		}
> +		custom_sec_defs = sec_def;
> +		sec_def = &custom_sec_defs[custom_sec_def_cnt];
> +	} else {
> +		if (has_custom_fallback_def)
> +			return libbpf_err(-EBUSY);
>  
> -		/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> -		 * SEC("syscall")) are exact matches in both modes.
> -		 */
> -		if (strcmp(sec_name, sec_def->sec) == 0)
> +		sec_def = &custom_fallback_def;
> +	}
> +
> +	sec_def->sec = sec ? strdup(sec) : NULL;
> +	if (sec && !sec_def->sec)
> +		return libbpf_err(-ENOMEM);
> +
> +	sec_def->prog_type = prog_type;
> +	sec_def->expected_attach_type = exp_attach_type;
> +	sec_def->cookie = OPTS_GET(opts, cookie, 0);
> +
> +	sec_def->init_fn = OPTS_GET(opts, init_fn, NULL);
> +	sec_def->preload_fn = OPTS_GET(opts, preload_fn, NULL);
> +	sec_def->attach_fn = OPTS_GET(opts, attach_fn, NULL);
> +
> +	sec_def->handler_id = ++last_custom_sec_def_handler_id;
> +
> +	if (sec)
> +		custom_sec_def_cnt++;
> +	else
> +		has_custom_fallback_def = true;
> +
> +	return sec_def->handler_id;
> +}
> +
> +int libbpf_unregister_prog_handler(int handler_id)
> +{
> +	struct bpf_sec_def *sec_defs;
> +	int i;
> +
> +	if (handler_id <= 0)
> +		return libbpf_err(-EINVAL);
> +
> +	if (has_custom_fallback_def && custom_fallback_def.handler_id == handler_id) {
> +		memset(&custom_fallback_def, 0, sizeof(custom_fallback_def));
> +		has_custom_fallback_def = false;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < custom_sec_def_cnt; i++) {
> +		if (custom_sec_defs[i].handler_id == handler_id)
> +			break;
> +	}
> +
> +	if (i == custom_sec_def_cnt)
> +		return libbpf_err(-ENOENT);
> +
> +	free(custom_sec_defs[i].sec);
> +	for (i = i + 1; i < custom_sec_def_cnt; i++)
> +		custom_sec_defs[i - 1] = custom_sec_defs[i];
> +	custom_sec_def_cnt--;
> +
> +	/* try to shrink the array, but it's ok if we couldn't */
> +	sec_defs = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt, sizeof(*sec_defs));
> +	if (sec_defs)
> +		custom_sec_defs = sec_defs;
> +
> +	return 0;
> +}
> +
> +static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_name,
> +			    bool allow_sloppy)
> +{
> +	size_t len = strlen(sec_def->sec);
> +
> +	/* "type/" always has to have proper SEC("type/extras") form */
> +	if (sec_def->sec[len - 1] == '/') {
> +		if (str_has_pfx(sec_name, sec_def->sec))
> +			return true;
> +		return false;
> +	}
> +
> +	/* "type+" means it can be either exact SEC("type") or
> +	 * well-formed SEC("type/extras") with proper '/' separator
> +	 */
> +	if (sec_def->sec[len - 1] == '+') {
> +		len--;
> +		/* not even a prefix */
> +		if (strncmp(sec_name, sec_def->sec, len) != 0)
> +			return false;
> +		/* exact match or has '/' separator */
> +		if (sec_name[len] == '\0' || sec_name[len] == '/')
> +			return true;
> +		return false;
> +	}
> +
> +	/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
> +	 * matches, unless strict section name mode
> +	 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> +	 * match has to be exact.
> +	 */
> +	if (allow_sloppy && str_has_pfx(sec_name, sec_def->sec))
> +		return true;
> +
> +	/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> +	 * SEC("syscall")) are exact matches in both modes.
> +	 */
> +	return strcmp(sec_name, sec_def->sec) == 0;
> +}
> +
> +static const struct bpf_sec_def *find_sec_def(const char *sec_name)
> +{
> +	const struct bpf_sec_def *sec_def;
> +	int i, n;
> +	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME, allow_sloppy;
> +
> +	n = custom_sec_def_cnt;
> +	for (i = 0; i < n; i++) {
> +		sec_def = &custom_sec_defs[i];
> +		if (sec_def_matches(sec_def, sec_name, false))
> +			return sec_def;
> +	}
> +
> +	n = ARRAY_SIZE(section_defs);
> +	for (i = 0; i < n; i++) {
> +		sec_def = &section_defs[i];
> +		allow_sloppy = (sec_def->cookie & SEC_SLOPPY_PFX) && !strict;
> +		if (sec_def_matches(sec_def, sec_name, allow_sloppy))
>  			return sec_def;
>  	}
> +
> +	if (has_custom_fallback_def)
> +		return &custom_fallback_def;
> +
>  	return NULL;
>  }
>  
> +#define MAX_TYPE_NAME_SIZE 32
> +
>  static char *libbpf_get_type_names(bool attach_type)
>  {
>  	int i, len = ARRAY_SIZE(section_defs) * MAX_TYPE_NAME_SIZE;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c8d8daad212e..b7b5aa1b30dd 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1328,6 +1328,93 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
>  LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>  LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>  
> +/*
> + * Custom handling of BPF program's SEC() definitions
> + */
> +
> +struct bpf_prog_load_opts; /* defined in bpf.h */
> +
> +/* Called during bpf_object__open() for each recognized BPF program. Callback
> + * can use various bpf_program__set_*() setters to adjust whatever properties
> + * are necessary.
> + */
> +typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> +
> +/* Called right before libbpf performs bpf_prog_load() to load BPF program
> + * into the kernel. Callback can adjust opts as necessary.
> + */
> +typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> +					struct bpf_prog_load_opts *opts, long cookie);
> +
> +/* Called during skeleton attach or through bpf_program__attach(). If
> + * auto-attach is not supported, callback should return 0 and set link to
> + * NULL (it's not considered an error during skeleton attach, but it will be
> + * an error for bpf_program__attach() calls). On error, error should be
> + * returned directly and link set to NULL. On success, return 0 and set link
> + * to a valid struct bpf_link.
> + */
> +typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> +				       struct bpf_link **link);
> +
> +struct libbpf_prog_handler_opts {
> +	/* size of this struct, for forward/backward compatiblity */
> +	size_t sz;
> +	/* User-provided cookie passed to each callback */
> +	long cookie;
> +	/* BPF program initialization callback (see libbpf_prog_init_fn_t) */
> +	libbpf_prog_init_fn_t init_fn;
> +	/* BPF program loading callback (see libbpf_prog_preload_fn_t) */
> +	libbpf_prog_preload_fn_t preload_fn;
> +	/* BPF program attach callback (see libbpf_prog_attach_fn_t) */
> +	libbpf_prog_attach_fn_t attach_fn;
> +};
> +#define libbpf_prog_handler_opts__last_field attach_fn
> +
> +/**
> + * @brief **libbpf_register_prog_handler()** registers a custom BPF program
> + * SEC() handler.
> + * @param sec section prefix for which custom handler is registered
> + * @param prog_type BPF program type associated with specified section
> + * @param exp_attach_type Expected BPF attach type associated with specified section
> + * @param opts optional cookie, callbacks, and other extra options
> + * @return Non-negative handler ID is returned on success. This handler ID has
> + * to be passed to *libbpf_unregister_prog_handler()* to unregister such
> + * custom handler. Negative error code is returned on error.
> + *
> + * *sec* defines which SEC() definitions are handled by this custom handler
> + * registration. *sec* can have few different forms:
> + *   - if *sec* is just a plain string (e.g., "abc"), it will match only
> + *   SEC("abc"). If BPF program specifies SEC("abc/whatever") it will result
> + *   in an error;
> + *   - if *sec* is of the form "abc/", proper SEC() form is
> + *   SEC("abc/something"), where acceptable "something" should be checked by
> + *   *prog_init_fn* callback, if there are additional restrictions;
> + *   - if *sec* is of the form "abc+", it will successfully match both
> + *   SEC("abc") and SEC("abc/whatever") forms;
> + *   - if *sec* is NULL, custom handler is registered for any BPF program that
> + *   doesn't match any of the registered (custom or libbpf's own) SEC()
> + *   handlers. There could be only one such generic custom handler registered
> + *   at any given time.
> + *
> + * All custom handlers (except the one with *sec* == NULL) are processed
> + * before libbpf's own SEC() handlers. It is allowed to "override" libbpf's
> + * SEC() handlers by registering custom ones for the same section prefix
> + * (i.e., it's possible to have custom SEC("perf_event/LLC-load-misses")
> + * handler).
> + */
> +LIBBPF_API int libbpf_register_prog_handler(const char *sec,
> +					    enum bpf_prog_type prog_type,
> +					    enum bpf_attach_type exp_attach_type,
> +					    const struct libbpf_prog_handler_opts *opts);
> +/**
> + * @brief *libbpf_unregister_prog_handler()* unregisters previously registered
> + * custom BPF program SEC() handler.
> + * @param handler_id handler ID returned by *libbpf_register_prog_handler()*
> + * after successful registration
> + * @return 0 on success, negative error code if handler isn't found
> + */
> +LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 47e70c9058d9..df1b947792c8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -439,3 +439,9 @@ LIBBPF_0.7.0 {
>  		libbpf_probe_bpf_prog_type;
>  		libbpf_set_memlock_rlim_max;
>  } LIBBPF_0.6.0;
> +
> +LIBBPF_0.8.0 {
> +	global:
> +		libbpf_register_prog_handler;
> +		libbpf_unregister_prog_handler;
> +} LIBBPF_0.7.0;
> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
> index 0fefefc3500b..61f2039404b6 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>  
>  #define LIBBPF_MAJOR_VERSION 0
> -#define LIBBPF_MINOR_VERSION 7
> +#define LIBBPF_MINOR_VERSION 8
>  
>  #endif /* __LIBBPF_VERSION_H */
> -- 
> 2.30.2
> 
> 
