Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720B4ABF38
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiBGNEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 08:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382646AbiBGMWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 07:22:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385C2C01DF05
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 04:17:25 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217Ax4oq021313;
        Mon, 7 Feb 2022 12:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=k3apBlEcoOd/e6l1/KNlmGCEHp/eBqygKEeNpYXtv+E=;
 b=Aesl7+yJMP6r6hYrN2KT9zjiFozenR6j0rBpOhXmt2sUyvu9dSzBfAxuQ0YZT3Q5PICv
 yB66AT1F+L4VkCmCwtrrnafmnjytiG3xBKHH4rNFPXa9U0/sq8pthMUl7OolUAzBrVsM
 ibE7K7TOIHKP4BNz7evSfkRyA56aC9bYwUokWbaxWJ24C2Fry24K3MvkxQ+NYIrsp06U
 ze1ZZ+TtF4Fz5AjLjlSp6ERckREvz4IRv+S/emaQgU6eJXzZ/3R14UsVrFW/2jN0UTvh
 NPKfIcz3yQ0llkRSzX4GlDuqoVLefgHZCPhfHDjClA2v3AIPIB240nOPgqjOKrgn05Kl ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13p2nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 12:17:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217CFURw055116;
        Mon, 7 Feb 2022 12:17:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3020.oracle.com with ESMTP id 3e1h247d68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 12:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OahuA4nxwn8sceBalNetvVuBB0OQ9FROqHdRN9PKIBlLTVIbiyaKChqJ2qfxGL4pANqoCRc4CBsmjD/c06jlXubcbC6ppsI0zw3C4mP4+d41oOsLVka5IPkLivai3PykZ0dgtlI7KvqTd5W3kDU8D6HUKcniSWgecxvuw3p+QKvNB+4GN/V0IXkUReyc1nmfSCcfBn10T5lugwPV29dZtp5/NyBbzPSfWrpyHmOLrmtk5rlUYCp+wwPsFDGMtb8V/B+uv+1ABcpU61Js3owB8H34g3W9iWYSxuNf5mtNK7heoF2gWJgU21oF4ZjU/BTxd6WYwpAsNbYqAL1zpVyzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3apBlEcoOd/e6l1/KNlmGCEHp/eBqygKEeNpYXtv+E=;
 b=SvozbbkcL5myxDwYA5iI7dz6KUADAoAIgd9x+kcyzhbfoRBdHQWRlf3wbhfD/8SDxQQ9bS+BvS3S5vyqkLSPDW4XqFs4OdPm7dHM3dipgPU+B5ubd0ndDhICyeFTYGjVcf9eBcnqibN5lpDLjcc9AjZDuq1HkT+AdNcxfmeFIjKNJ43P/yXJhkRIUTWBchmMzhdJTNePBOERpbLglk4m1y9JPyux4ZMTkAOHICdJLpDX+m55etcLwIc6PemwQc5VcOSgWS6EJPNncNheXdue2/K6iifULKc9CsgeH7NC6njjuLNY5x/FUJ0948wuWkwgK5o8G6jAJapwoHRxkg7nZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3apBlEcoOd/e6l1/KNlmGCEHp/eBqygKEeNpYXtv+E=;
 b=d3TnFV/3ZybL2OIqzjAc/THfQ2wKO6EN/xVpSmcIHzHO1qxWnWSUwqW2LlfwCy2tadUSFVtXXHRgig4xrP/fC1Bt++0GMLiW1LapNxnpG8bCJ3y0oY6zKO0CbS9xR6n7Moxh6xvUYEkGIptQqmbdc90ZuSQ1JLhYDHBnvtIgFPw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 12:17:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835%4]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 12:17:06 +0000
Date:   Mon, 7 Feb 2022 12:16:53 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: allow BPF program auto-attach
 handlers to bail out
In-Reply-To: <20220205012705.1077708-2-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202071054010.9037@MyRouter>
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-2-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af8cffa-6297-481a-7486-08d9ea33c17c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5838:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB58384A3AC547E7C88DBE6114EF2C9@MW4PR10MB5838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhq5fb4X3krpn/T5NL0VJPRP5oqKsHrcib8RYkLea9XP3tV4uS+qNwCbWkfeITfOFBOsKCBj5a/6QnSTAwnXHnE4lh9NZYPvKDzuYxxA/DKQF+6zzxXLgZmctZCn8YGalaJ2mIK86uT5hwiQPVQWcBuwxVvY8csODo+dLd3Q4/GfdXTUkGjINp+zUYfzzdM878gfaEV2KOcLAT+M0E3K88hzyHRYBawUunW0NuhOTkFQ9TjnR9iNcW+pvqobYyhYtbG1Zkm3A/K3QwAWYdvT0AA+rH3cVCcCJSKyTisYz3mk+tEebSnW0zWIG4tzHiYKVz4ZaxMpLsm97oqICPF16xLt4kpu5e3fTsskU69VoQFllFPbjY6G1tuRHRxDV461vG9gyovVhplmcaQay2/9qzK4od8ASxA4IsEVYJ+jBUV7avZzNyKo0lSxEYCrzx0RMm/qFxZTOzKFejh/fyRftCXhg8v4emQBdze0gD2dOQlWWaYxsGhE9gOyl33oOkxw1xXn0YJb6bQLcW/SkWeNWnTI+Ycawaiw5WMLCmF9PDHFwdQMGy1m2jIF7/xlDQfP+YmHuxZtTo/AtRMWNWBIUT3ZBdYEQ1v1wx+3o9uIzGf0HaPnW02aN6qKVIEnoRKea9CfHx23xbNGbjLw9t12eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(6506007)(6666004)(5660300002)(9686003)(6512007)(6486002)(86362001)(30864003)(44832011)(2906002)(508600001)(38100700002)(186003)(107886003)(33716001)(8936002)(66476007)(83380400001)(8676002)(4326008)(316002)(6916009)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om5EStZagLPvKnyeRakt2edv+K7aIRwAoJj6xbDXpgnVgZ3eshyTZju8x8tg?=
 =?us-ascii?Q?ljv0kS7CZrY6uOeqYs+5AKFudWtpN+cokBrpnltfbjcM15uiGFRLZ9XlQEv+?=
 =?us-ascii?Q?Ey7XSWBfgdCHu0fGBb0VFQoAeAxCqdYzFr3x5XY/bwCb+MHm9gALT0T/EMee?=
 =?us-ascii?Q?CUlhnzO1SsYR4Aen6namDUreyHPFMwJz+gs5oROLlIQeSkDDZqRGj+eFlBM4?=
 =?us-ascii?Q?psFVGfnOr47tkrtH9udFo1d02LDzm9Q391qdURnVA9Bj66b1Eox5E7ta0znu?=
 =?us-ascii?Q?aKnpqw+wsSYrXTDXBzAF4dBNMrrrR2nfi3vYol4YP/4aD6tKiOV2kkIcXnRU?=
 =?us-ascii?Q?orhtwaxnSEAF3tW/3fWHvysaidHBg50nj1DOmuGgzx6mwTNpcqDMA8n+KLtO?=
 =?us-ascii?Q?OTmsRPki3mSwOpAVrtNrx9UrKFWrUVf7M0dX2K4TxwIPPcfxGO9OpHCEMnSC?=
 =?us-ascii?Q?YSZodriojweyeFaKs43WtCjLc7/1O63ogTUuX44dajfnjuBRj2LSLYWb4Py1?=
 =?us-ascii?Q?9Djs3WQFPfBJjLKMIeql1NT1c/roX5ettzk/9vUfnFBOHXB2sNvHSgbt9Eo8?=
 =?us-ascii?Q?0fVeqI40HbMe5XOCiQvi7TEFeq0zUCIAWvLTOHIf3pavg7V8Sppt3cdt7K2Q?=
 =?us-ascii?Q?GoDHZhYLsjKn9HxFQRYmFosgi3hwmubLhYhEqghpr30x1WQ1ND/XYnz/KNVk?=
 =?us-ascii?Q?ALMFPy2hr3kHljTski7VlUuPsyVeyoNU5YPLEDv0hSezDPPTcq+WdtM7vuwz?=
 =?us-ascii?Q?xPJj1JhFeh6iBC4qsxaJ3IV+9CsHlZeefl8Bqu8JLHJiBhHieGqebjr38vy/?=
 =?us-ascii?Q?uDlTUaX5A+r6zU6wdKWqx3nkCkkYi7qf/cqQkD/eApHyq90lvXChpPGaM+97?=
 =?us-ascii?Q?izCywDlzIv5REe3EgWwOiH6VlIP9F73vTo+H259knrDfULPz53NriiL3HWkS?=
 =?us-ascii?Q?ITxMRL/xditU7/GeqKzSCd+JH1eQ4/MEnT8h8Ezl2nk7wEUk9llldjZ2qmd0?=
 =?us-ascii?Q?G8rQe/81PBvtQZ6LYchHRMOQkI4L+OyMGQdYzZWVCA9GJYcGmAzCPlbzQ0HA?=
 =?us-ascii?Q?yAH73Ey7N2k3HzBX9nB2REWJSM42PhLvXPbTO7QtyEHrnf+nB7/3HYVyvJep?=
 =?us-ascii?Q?Um8BMVVUDLYTJLy9HTEttn/wUO2PmRvh0F+Xd1YIbi7/3wrsn/KoP+RJeBHQ?=
 =?us-ascii?Q?2V80lm7zjdRlvFgIopq1U7dn5Xla9BvwaXk9wyZm0N/gBoAao5Tcklv7oPDm?=
 =?us-ascii?Q?jtvU1idAfrYuT3oBUxUuLZo5GV7MYDpEl1cD8+olj0sOFrjiYoXiau18hFh9?=
 =?us-ascii?Q?pKtsBDIaFnGtJUE1vbohsX8BMb4V7q8dGj/Ew4ifYF7N/F9lYWw36M5s38CP?=
 =?us-ascii?Q?FENgv7mxBV7VftkExP0/248wacULP29AMG7aF5iX3gSjCDdd2lKtCI9bIlCp?=
 =?us-ascii?Q?rM7qJucqKdad+ss1utMPTlAFA7DmjPD9flmwvB461wb8AhQRifM/1uWoye72?=
 =?us-ascii?Q?LlzCHO6o7kBLH14N4T4hgy41LO6GrXZtl/mJ5M44E+0rGpz6Bd/6003JUn2y?=
 =?us-ascii?Q?7eBMhbBEk4v/+Kk87S1QD+NJr3EnP6DtDBbUKWwkQm89yq7sCzqWkX64bisx?=
 =?us-ascii?Q?gs2//q9nrKSst8H3sewSQrCOq0Oo7kqL080wRoA74qo3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af8cffa-6297-481a-7486-08d9ea33c17c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 12:17:06.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kp9PnaK1rnF91FrRbK87fn+M/H2S3WTlq3Zm6NLnwrYHFp71NpGyEYz4zYk3MgHuoCXJSjyH2ZT8DiV4X3J7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070080
X-Proofpoint-GUID: yTzUL29awUhIstLJxBwCglpVlfgG67Tm
X-Proofpoint-ORIG-GUID: yTzUL29awUhIstLJxBwCglpVlfgG67Tm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 5 Feb 2022, Andrii Nakryiko wrote:

> Allow some BPF program types to support auto-attach only in subste of
> cases. Currently, if some BPF program type specifies attach callback, it
> is assumed that during skeleton attach operation all such programs
> either successfully attach or entire skeleton attachment fails. If some
> program doesn't support auto-attachment from skeleton, such BPF program
> types shouldn't have attach callback specified.
>

This is a great feature! I've had cases where I had to
implement custom section-specific handling before, so this 
will make that process much easier!

> This is limiting for cases when, depending on how full the SEC("")
> definition is, there could either be enough details to support
> auto-attach or there might not be and user has to use some specific API
> to provide more details at runtime.
> 
> One specific example of such desired behavior might be SEC("uprobe"). If
> it's specified as just uprobe auto-attach isn't possible. But if it's
> SEC("uprobe/<some_binary>:<some_func>") then there are enough details to
> support auto-attach.

Would be good to describe the different handling for explicit
bpf_program__attach() (which fails when auto-attach is supported
but does not return a non-NULL link) vs bpf_object__attach_skeleton()
(which skips the NULL link case) here I think; it's all clarified in 
comments below but no harm to reiterate at the top-level I think. 

> 
> Another improvement to the way libbpf is handling SEC()s would be to not
> require providing dummy kernel function name for kprobe. Currently,
> SEC("kprobe/whatever") is necessary even if actual kernel function is
> determined by user at runtime and bpf_program__attach_kprobe() is used
> to specify it. With changes in this patch, it's possible to support both
> SEC("kprobe") and SEC("kprobe/<actual_kernel_function"), while only in
> the latter case auto-attach will be performed. In the former one, such
> kprobe will be skipped during skeleton attach operation.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

A few nits and suggestions for future, but this looks great!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/libbpf.c | 110 +++++++++++++++++++++++++----------------
>  1 file changed, 67 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 904cdf83002b..2902534def2c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -209,11 +209,12 @@ struct reloc_desc {
>  	};
>  };
>  
> -struct bpf_sec_def;
> -
> -typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
> -typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_opts *opts, long cookie);
> -typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
> +typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> +typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> +					struct bpf_prog_load_opts *opts, long cookie);
> +/* If auto-attach is not supported, callback should return 0 and set link to NULL */
> +typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> +				       struct bpf_link **link);
>  
>  /* stored as sec_def->cookie for all libbpf-supported SEC()s */
>  enum sec_def_flags {
> @@ -247,9 +248,9 @@ struct bpf_sec_def {
>  	enum bpf_attach_type expected_attach_type;
>  	long cookie;
>  
> -	init_fn_t init_fn;
> -	preload_fn_t preload_fn;
> -	attach_fn_t attach_fn;
> +	libbpf_prog_init_fn_t init_fn;
> +	libbpf_prog_preload_fn_t preload_fn;
> +	libbpf_prog_attach_fn_t attach_fn;
>  };
>  
>  /*
> @@ -8589,12 +8590,12 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>  	__VA_ARGS__							    \
>  }
>  
> -static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie);
> -static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie);
> -static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie);
> -static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie);
> -static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
> -static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
> +static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>

One thought here - in the future it might be useful to export
these internal auto-attach functions.  The reason I suggest this
is some use-cases of auto-attach might involve pre-processing of
the section name, and once the required info is extracted the
auto-attach function could use the original auto-attach functionality.
That could be done separately to what you're doing here of course.

One concrete example of this: I had a BPF program which consisted
of BPF programs containing required attachments to top-level protocol 
module functions along with a set of optional attachments to
transport-specific module functions.  Since multiple transports were
possible, it was always possible that module A wouldn't be loaded
while module B was, or vice versa.  To deal with this, I used the
"o" prefix (optional) for the associated kprobe/kretprobe section 
definitions; an "okprobe" might not attach, but a "kprobe" should.

Using the mechanisms in this patch set, this could be easily
implemented by a custom auto-attach which looked for the "o"
then passed the rest of the section string into the default
auto-attach function for kprobes, handling attach errors for
optional sections while passing them through for required ones.
Tracers might find such pre-processing combined with the default
mechanisms useful too; we could even potentially implement
support for ":" separators this way too (convert instances
of ":" to "/" and then call default auto-attach)!
   
>  static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
> @@ -10101,14 +10102,13 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
>  	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
>  }
>  
> -static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie)
> +static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
>  	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
>  	unsigned long offset = 0;
> -	struct bpf_link *link;
>  	const char *func_name;
>  	char *func;
> -	int n, err;
> +	int n;
>  
>  	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
>  	if (opts.retprobe)
> @@ -10118,21 +10118,19 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cooki
>  
>  	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
>  	if (n < 1) {
> -		err = -EINVAL;
>  		pr_warn("kprobe name is invalid: %s\n", func_name);
> -		return libbpf_err_ptr(err);
> +		return -EINVAL;
>  	}
>  	if (opts.retprobe && offset != 0) {
>  		free(func);
> -		err = -EINVAL;
>  		pr_warn("kretprobes do not support offset specification\n");
> -		return libbpf_err_ptr(err);
> +		return -EINVAL;
>  	}
>  
>  	opts.offset = offset;
> -	link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> +	*link = bpf_program__attach_kprobe_opts(prog, func, &opts);
>  	free(func);
> -	return link;
> +	return libbpf_get_error(*link);
>  }
>  
>  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> @@ -10387,14 +10385,13 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
>  	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
>  }
>  
> -static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
> +static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
>  	char *sec_name, *tp_cat, *tp_name;
> -	struct bpf_link *link;
>  
>  	sec_name = strdup(prog->sec_name);
>  	if (!sec_name)
> -		return libbpf_err_ptr(-ENOMEM);
> +		return -ENOMEM;
>  
>  	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
>  	if (str_has_pfx(prog->sec_name, "tp/"))
> @@ -10404,14 +10401,14 @@ static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
>  	tp_name = strchr(tp_cat, '/');
>  	if (!tp_name) {
>  		free(sec_name);
> -		return libbpf_err_ptr(-EINVAL);
> +		return -EINVAL;
>  	}
>  	*tp_name = '\0';
>  	tp_name++;
>  
> -	link = bpf_program__attach_tracepoint(prog, tp_cat, tp_name);
> +	*link = bpf_program__attach_tracepoint(prog, tp_cat, tp_name);
>  	free(sec_name);
> -	return link;
> +	return libbpf_get_error(*link);
>  }
>  
>  struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
> @@ -10444,7 +10441,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
>  	return link;
>  }
>  
> -static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie)
> +static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
>  	static const char *const prefixes[] = {
>  		"raw_tp/",
> @@ -10464,10 +10461,11 @@ static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cooki
>  	if (!tp_name) {
>  		pr_warn("prog '%s': invalid section name '%s'\n",
>  			prog->name, prog->sec_name);
> -		return libbpf_err_ptr(-EINVAL);
> +		return -EINVAL;
>  	}
>  
> -	return bpf_program__attach_raw_tracepoint(prog, tp_name);
> +	*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
> +	return libbpf_get_error(link);
>  }
>  
>  /* Common logic for all BPF program types that attach to a btf_id */
> @@ -10510,14 +10508,16 @@ struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
>  	return bpf_program__attach_btf_id(prog);
>  }
>  
> -static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie)
> +static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
> -	return bpf_program__attach_trace(prog);
> +	*link = bpf_program__attach_trace(prog);
> +	return libbpf_get_error(*link);
>  }
>  
> -static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie)
> +static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
> -	return bpf_program__attach_lsm(prog);
> +	*link = bpf_program__attach_lsm(prog);
> +	return libbpf_get_error(*link);
>  }
>  
>  static struct bpf_link *
> @@ -10646,17 +10646,31 @@ bpf_program__attach_iter(const struct bpf_program *prog,
>  	return link;
>  }
>  
> -static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
> +static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
> -	return bpf_program__attach_iter(prog, NULL);
> +	*link = bpf_program__attach_iter(prog, NULL);
> +	return libbpf_get_error(*link);
>  }
>  
>  struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>  {
> +	struct bpf_link *link;

might be no harm to initialize link to NULL; we could imagine
a user-supplied auto-attach function bailing early and not
remembering to set it explicitly.

> +	int err;
> +
>  	if (!prog->sec_def || !prog->sec_def->attach_fn)
> -		return libbpf_err_ptr(-ESRCH);
> +		return libbpf_err_ptr(-EOPNOTSUPP);
> +
> +	err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, &link);
> +	if (err)
> +		return libbpf_err_ptr(err);
> +
> +	/* auto-attach support is optional (see also comment in
> +	 * bpf_object__attach_skeleton()), but when explicitly expected by
> +	 * user it's an error if it's not */

nit: checkpatch wants the closing "*/" on the next line.
Also I think it would be good to clarify along the lines
of "when calling bpf_program__attach() explicitly, auto-attach
support is expected to work, and a NULL link is considered as
an error.  See comment in bpf_object__attach_skeleton() which
describes different handling of the 0 return value/NULL link
there."

> +	if (!link)
> +		return libbpf_err_ptr(-EOPNOTSUPP);
>  
> -	return prog->sec_def->attach_fn(prog, prog->sec_def->cookie);
> +	return link;
>  }
>  
>  static int bpf_link__detach_struct_ops(struct bpf_link *link)
> @@ -11800,13 +11814,23 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
>  		if (!prog->sec_def || !prog->sec_def->attach_fn)
>  			continue;
>  
> -		*link = bpf_program__attach(prog);
> -		err = libbpf_get_error(*link);
> +		err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, link);
>  		if (err) {
> -			pr_warn("failed to auto-attach program '%s': %d\n",
> +			pr_warn("prog '%s': failed to auto-attach: %d\n",
>  				bpf_program__name(prog), err);
>  			return libbpf_err(err);
>  		}
> +
> +		/* It's possible that for some SEC() definitions auto-attach
> +		 * is supported in some cases (e.g., if definition completely
> +		 * specifies target information), but is not in other cases.
> +		 * SEC("uprobe") is one such case. If user specified target
> +		 * binary and function name, such BPF program can be
> +		 * auto-attached. But if not, it shouldn't trigger skeleton's
> +		 * attach to fail. It should just be skipped.
> +		 * attach_fn signals such case with returning 0 (no error) and
> +		 * setting link to NULL.
> +		 */
>  	}
>  
>  	return 0;
> -- 
> 2.30.2
> 
> 
