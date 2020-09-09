Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615BD2638EE
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIWXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 18:23:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIWXI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 18:23:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089MImTS005745;
        Wed, 9 Sep 2020 15:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=W2+VV9ujMO1e5hwDmCKEkd31H5Nr4OEpoMBEN7hCeVo=;
 b=IsKPTEkYKCp1iYVeMEMTbIS4mi1D23SAWkaobJ/78HCiWMUizYSI1sTaJ1BaoaqXtkDa
 LyhjuN+4ghmYOKTc0Xar84lEvMUVboodYw2j1OsQWAYzgGd1PTQAqTsJcoyMu9/wf8zs
 DfpkaQgL76P1HampwfwWNAqSxMNE9w6+NYw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctxn9yf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 15:22:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 15:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nThBcb2Hq/Bjwh+F3KOA4bP713woGXiZNnmMYddkIA6krqZe+rzfev8rKcxyHXyv7se0CoonrDr/TRIltvwqX8kRfWoFgyO1aE/3xGz0hsWw7sIC/ZlQe4uqQV42M1FtT5EbigBUI62B/zp76BaWtwPioCNg2k6ibZsvTzPg6d92g4t9iFrVTu+p6sdAndO7OOrnVsC6zSg+8R5lMSg8uhaBlDfC5oHyg84XjzHn4eE85hLM2pOwbSOwtLjCvVgW2mYZNNlBfRvBqtZsmW6J/5S79ptmwAAHIxgndcx0nTZbP0faX5UwITJKHyCQJlabAEHRSY/7EZsfVJxtwRhNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2+VV9ujMO1e5hwDmCKEkd31H5Nr4OEpoMBEN7hCeVo=;
 b=lYNeEPl9XMuwjiTvCVe4RCbGlEoFZdQIlBSbafrLNKyHKg5yUNzaqr2Ln+O2Ep9v3QLK3fVERWgsqMGWuQkCfvoxNxUdpoyovggeBa4vj3h2WBCWrjBCRePpiJs5s3aqWe09sA+KJXGZp4O5cMHjgCcQjh+iZY+FHWqsWP3ylOgZTJf4W6uh9rRh+d9m+ozNJ7d3zB/ZbKGZII0IVnJkUzgB7hua97vH+EulQh9CRGjQnjjNNzhbTyg03wR6Vr7pCTzl/7LOhLfTia42M2/aRpgnXrQHDWIn7NjX6ApwTExvrlvWcPWmRGJsBVogWNIddoz/EE5B4o3GMvmjskViuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2+VV9ujMO1e5hwDmCKEkd31H5Nr4OEpoMBEN7hCeVo=;
 b=Xg2ZFfH7ZMymP5yUcCGrY9zDJjCPUFttb0QimT7xJtIBW3GhY4o3Yfy+vxBMCn3pf8hp+QdNFMhHaIVS7Y1Lhs7LHFhEmiPAVJauqlC1pDiXc6jZHzL5Lhb11toVJUybpLS2ppv2/KAr7FeQTpqxa4nxGFQyyoaJ292xQFpGb5U=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 22:22:51 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 22:22:50 +0000
Date:   Wed, 9 Sep 2020 15:22:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 11/11] bpf: use a table to drive helper arg
 type checks
Message-ID: <20200909222243.zewt2n7g4fx5mce5@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-12-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-12-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:300:d4::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR19CA0005.namprd19.prod.outlook.com (2603:10b6:300:d4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 22:22:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfdad8c9-f9aa-450b-e1d0-08d8550ee35e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26945F624A36BE8849074CADD5260@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDw2/aP6TJesYGCVMtZTqj1qRdyw9kdiU96ALXkHZL38vriwFWBxE5pCu6NbuPaUuJlN2q+ZzsW9lFXZFZCrEcK/nStJhenRpfI8DuGnDLuHayYPCyq6/+bRCkiEdKxyH6AjoMvXzt7uVnVqZhRSDv74axd1XVbQW1GXF3AnhcbMPz9emr0hTotTzbaKLBmNRPAGaemRIbwoLZOqY+zxHhOQlp/BV7LeNl2NLOh+YiOe3O9f3irqoWqHwBExJ3VrX0fHqNy6jlk3w/Dl8T1GcbzeHRJieiPWFYIwGVcOtyeAGyZ33hFhAoAco1O2PCEK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(6666004)(5660300002)(1076003)(9686003)(6506007)(55016002)(83380400001)(186003)(16526019)(66556008)(66476007)(66946007)(4326008)(86362001)(8936002)(6916009)(2906002)(7696005)(52116002)(478600001)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7E4ezzcYqA9ac5GOZBGY7lfdra5/HvSAlZlDhlhmAZkZAUAYLlXTB5j+/UpBd7ZDkjIrkN/efHUNLtkGoWzct3GujpuDAQqCnlfiimY0eISkXoHx/5LCNhEYacpNvzs8QFBGfWRSHWj5HRpybPs8LLDnhj84A1Vy6LRrz2Hxsd2xeqfLOxlOhpHOZriuXZKnkqqUM8gXnHj1Yg8eU3VKMrRji2fy2CzrJGgOu0T/jKbuaBhArisTt2FryMVvng8JCYF3ivHqTqM32DC4FE4fle99DzZhTOpc4n1xcGvqFJHUR1ZocDIeKs3Pv+gbOdNgPfhFx7AHdIii9w+VsZcxuavsOXqHDHGbGFjGDrgVDqH71U4s03CNpMGFRLEuLOgLYYYdl0AgXFTQC+hAVWPS0vhFFbCFkri2BTwxY78Uzu3eWKaJB7vyLOxsBLHV2TGK6kbKRW7vMO/Pipho3aMWaIGXIKzcW1CZ/ltglByOYUusaCnL0z3JmA42JlKGd508o6E4833kYMy00rsDMmcLP3Xep1nAtEIklJVEU676ZxNBJyNcMeU4CYOSs15Af65RhkQa16w1m2T1rAgfLX2aPQhqZkogvdPH5ZX/QdbiC10NUXkihtfQx1FlijANis0cS9FIwJSy4sxsHtX2IvT81rx5s39oTwPiBCBMWLTGKqU=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdad8c9-f9aa-450b-e1d0-08d8550ee35e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 22:22:50.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBpBL6iEZMVJrNoBsEzvPyKAY/ew/Fg6Htwp3ru7vZcnlnVKaCQytx5DNkUiWWST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=1 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090195
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:55PM +0100, Lorenz Bauer wrote:
> The mapping between bpf_arg_type and bpf_reg_type is encoded in a big
> hairy if statement that is hard to follow. The debug output also leaves
> to be desired: if a reg_type doesn't match we only print one of the
> options, instead printing all the valid ones.
> 
> Convert the if statement into a table which is then used to drive type
> checking. If none of the reg_types match we print all options, e.g.:
> 
>     R2 type=rdonly_buf expected=fp, pkt, pkt_meta, map_value
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/linux/bpf.h   |   1 +
>  kernel/bpf/verifier.c | 189 +++++++++++++++++++++++++-----------------
>  2 files changed, 116 insertions(+), 74 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index aabbc8bb52bd..7cf7e90f55bb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -292,6 +292,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
>  	ARG_PTR_TO_ALLOC_MEM_OR_NULL,	/* pointer to dynamically allocated memory or NULL */
>  	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
> +	__BPF_ARG_TYPE_MAX,
>  };
>  
>  /* type of values returned from helper functions */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ebf900fceaf0..9c9728c81d4c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3856,12 +3856,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
>  	       type == ARG_CONST_SIZE_OR_ZERO;
>  }
>  
> -static bool arg_type_is_alloc_mem_ptr(enum bpf_arg_type type)
> -{
> -	return type == ARG_PTR_TO_ALLOC_MEM ||
> -	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL;
> -}
> -
>  static bool arg_type_is_alloc_size(enum bpf_arg_type type)
>  {
>  	return type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
> @@ -3910,14 +3904,121 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +struct bpf_reg_types {
> +	const enum bpf_reg_type types[10];
> +};
> +
> +static const struct bpf_reg_types map_key_value_types = {
> +	.types = {
> +		PTR_TO_STACK,
> +		PTR_TO_PACKET,
> +		PTR_TO_PACKET_META,
> +		PTR_TO_MAP_VALUE,
> +	},
> +};
> +
> +static const struct bpf_reg_types sock_types = {
> +	.types = {
> +		PTR_TO_SOCK_COMMON,
> +		PTR_TO_SOCKET,
> +		PTR_TO_TCP_SOCK,
> +		PTR_TO_XDP_SOCK,
> +	},
> +};
> +
> +static const struct bpf_reg_types mem_types = {
> +	.types = {
> +		PTR_TO_STACK,
> +		PTR_TO_PACKET,
> +		PTR_TO_PACKET_META,
> +		PTR_TO_MAP_VALUE,
> +		PTR_TO_MEM,
> +		PTR_TO_RDONLY_BUF,
> +		PTR_TO_RDWR_BUF,
> +	},
> +};
> +
> +static const struct bpf_reg_types int_ptr_types = {
> +	.types = {
> +		PTR_TO_STACK,
> +		PTR_TO_PACKET,
> +		PTR_TO_PACKET_META,
> +		PTR_TO_MAP_VALUE,
> +	},
> +};
> +
> +static const struct bpf_reg_types fullsock_types = {
> +	.types = {
> +		PTR_TO_SOCKET,
> +		PTR_TO_BTF_ID,
PTR_TO_BTF_ID should be added at the sockmap-iter-update patch instead.

Others lgtm.
