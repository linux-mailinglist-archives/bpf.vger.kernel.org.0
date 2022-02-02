Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77C4A7831
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 19:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbiBBSqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 13:46:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346729AbiBBSqF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 13:46:05 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212HGY0i007275;
        Wed, 2 Feb 2022 10:45:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1VFl/t0IyVhR4SqOApVt+tFLyl9YuYFjM4KJjbbuLCM=;
 b=gW0GCfacJgydFGxVu0JgcH1+MJcWvPsq7Tsfyd/160Et/ji7dHORdXhUt+VxfZfse8MY
 GAEX13/3l2+hMCN5IQZqV7sXNKm/4Me1jXcQxST34VlL4RL3ZATj8ymoDNH9sc6WbtIn
 DtNhSNF1hcVsSwdT2khzTrqbNxjdWBAYcWg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dycx0x58y-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 10:45:32 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:45:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQTTaVxUKTEzH9MOU3QecBYD7pOphNWpIEBRHl9bhurrPzmuezIW8mE5cQBtwT5xJNbAk7ZcLpxjhs3olidQJfrFyuN8xkm80/eKd4OQ+YMwsJLeMKTDZWX3vPlvZpuai7AupgObSqXv6HlUlPxi7SM4ZCpoyJKXew+NwTPWifcQjNhr8mplY1IQiwscmukU+YiJEmsyAOsGgSy/pu+m/dvjhRrBmWfCpvX8JlS+L/9UrQPy48UcTlvoFkKqdnb2H+hcQ4rJTEWclUJZCg5Rj0vDPJ2jgKXr2yaDcWLbTmoCzmOZwdPrkapGtdDa5MPmQ1IhpHwG2MpygXTOIzOWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VFl/t0IyVhR4SqOApVt+tFLyl9YuYFjM4KJjbbuLCM=;
 b=YwoOI9UK34Nq8c/GID5wdXHe1DCGiyK01pI3F5LljoPbnUNovO7FuSL0gBOJP5/E641OHnW5mcT6QaJXA8n2blEyL2EeiFUThkQ0VQ4ipKKWwNJY3FaVO1HVRIwb5VIRAs1orrv3pLAwdSR9gLEz/b7mwH53E4PReZqB9XvMe8QAyB6tTRz6BsR/5iP71CG74yratnHCoNhFocpndDFy5OKA7ourmo8G/oGlz20B8ujqHtdU5VMv6kjwNlyNs/rvG2+ZfsCoUhSSfBqCC8Ur2UxqQuAuv8R4EtAn7dbH+2tnJLiQArBRsYRnTYgVgTzpKpVAfC/4SK0PjPRnF/46yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB3708.namprd15.prod.outlook.com (2603:10b6:5:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 18:45:29 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 18:45:29 +0000
Date:   Wed, 2 Feb 2022 10:45:25 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, arm64: calculate offset as
 byte-offset for bpf line info
Message-ID: <20220202184525.ydj3a7jc73o64dws@kafai-mbp.dhcp.thefacebook.com>
References: <20220125105707.292449-1-houtao1@huawei.com>
 <20220125105707.292449-3-houtao1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220125105707.292449-3-houtao1@huawei.com>
X-ClientProxiedBy: MWHPR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:300:39::21) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff18ffd9-d7e4-4f04-d51b-08d9e67c2f49
X-MS-TrafficTypeDiagnostic: DM6PR15MB3708:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3708C02E6F92796C1FC1E6BCD5279@DM6PR15MB3708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x9az33G8TU/wG0ph0CcUNScamNH4blMjm3kQxpfRsEzTygxsE8l9wHmajI2shrJcM7FZ1Qx4rzqZheUfvIWVKhh5wFOSwf+ejFd3hjWOYNFA8CVhCEolOjjDc8HvS0YrBfV4nW19GS71ouxAeNle+FWZiwR29FPl2RkX1TMpbF5402ZkV6vWve4iUeSujAd5HoxN3R96znbng46lkGEZHiCUVy1F+7/7wfPT00YhGwV9M43wvYnpPHtf6QQKhkPpfJIszqhNwLM5dBmcjwe9gib8N9RbHomHBARlVnO44psnDF7LvGS9cgMu8fM+vRIhDxQ2Bcg86yrov65purKNKFH6KDmITijzw8obZxNVwDGGMSxuSZJdBwqJ8OxjA+phEM6biMzaoxeqlQ5ym5CONPoRMQHJM8rn7KYWbl1A/OJntvbA69NncDGo31i+u4da08wkQXz45pyfwY40RYf+IkBso4ucB35i7BNrBNiDRtRVAvB1rEISQrGawUEh+JB641zXRios/y74+zqyNK0NePXUbeoUYyvZu98LemtqqsZWStTg+K81W5SeYj0wr0V6DHNOk/JGDNfGXV7AXMKdDtFoFbWDv4tBSCeTJn51xKDsv89nGGuz4IH4jRovuaUPgrLiAzNlg6ePJJsQ4IMgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(54906003)(6916009)(6486002)(316002)(1076003)(38100700002)(8676002)(5660300002)(66556008)(66946007)(7416002)(9686003)(6512007)(52116002)(2906002)(66476007)(4326008)(6666004)(6506007)(508600001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOZDRge/IHq7qR8mq7Ld6pW223CahZh5Sl8LYm3JE/LAEHVSB0QnyGGdIeIT?=
 =?us-ascii?Q?N+1ILYm/HrfyipCmbzaJXE6bgY7lg8bqhqu+GKps8lQ1sCzi5OTkrcDQBN5c?=
 =?us-ascii?Q?J5+X1a9k3GfLnXsqbaC7Wyzs/el2kxzc7YdSJLZBhUujQq48zSwfBd0aTper?=
 =?us-ascii?Q?CiH60IEU59XkDXlGX0BqtgZyiITo0ge9yVcMjUoG0kh6iUk+8lpnOhsq9dew?=
 =?us-ascii?Q?A1q6sQvteir4c6+xdx2fLi+lHoU/bSqkJAovBWRO7UH7OG6l55QdFyPZFNPv?=
 =?us-ascii?Q?RXYv6pcKzWQY0WQltFN6bSpGdo3ksd7rGeDvfiAd/j5RdoSf1kg7zeTspF/y?=
 =?us-ascii?Q?Ba5EWghtTaASanEVfkTEETI190yCXkTn0HSfc5WfehlUAa8fxMd3aKf5H8je?=
 =?us-ascii?Q?8dEOG9dS1CAQTCAoQXRSIaRgHaEue7Sj06cCa0SgfSMQWPnRwj2pr6Ll+Npd?=
 =?us-ascii?Q?na72hweHIBGx7Jo0qMwT6Qx4l+uza2UpE5TgD9Uj/3bS0yXy9OYMa7smKFdo?=
 =?us-ascii?Q?nObxixI/4vuTqnlfSRqM3fIaxProEvriWen3ShNjtrUUY6Q/qPthCF0RBxNE?=
 =?us-ascii?Q?ppN2eoHKJOZVi+PaERS8Lbnra/1PipH78AyNGyL7Pc8ZaoanQgU2q3385oBd?=
 =?us-ascii?Q?jIvruA+kCMYtEDU8zJ9xvTousGPRuQIiCi+xFKudwXHkvxh6ZZnTZ2MlIs3U?=
 =?us-ascii?Q?hWUH9+HxD/vnvzad310UXQdEXVjK8dgtfxW3Bptokz2K7hrq8FnQs5bnFr1b?=
 =?us-ascii?Q?B1fSZl3UA72S1fsvmh3XMwka2384UT5Y+PCfd40ihsql4VS2SgGnc3JS29fU?=
 =?us-ascii?Q?eoOo5ozht6kxrzWYF4D3z+rJDy4Dk8jk7uZjtISU6HlrEx6EqSfB1rl9VXbs?=
 =?us-ascii?Q?aiCDGWKOghg7NHvvRdaMAaHR/d0bBQm3rqu/Kuc2yKsoSh9b7hVK/2kdmswZ?=
 =?us-ascii?Q?8JTYVKPRbpoZ2OQyXY5JO205XfBw3Hbcp+zljfNjHFBLMq57YbNABJPGGXPv?=
 =?us-ascii?Q?1gIwRGhWMWB0oDGAjkvhs1tIXAAyTQxXSs0IsFXpTKNAbEZObMWPtkuc8GQB?=
 =?us-ascii?Q?ksFIt6QLZIyCHE0ku3NVi28hXKqI60qKXlZ572EHnOVtq4VSZ/OJGOP9vrFZ?=
 =?us-ascii?Q?zLS/vvEkAWshpP/ImthEacJL84Ro8fhn+pXRgR5jRRFKzitp6klBXb4r5mUn?=
 =?us-ascii?Q?i7jTFcrIdc8cy6ysSzCRhWwk7bicS+C0AJHto3BVfqr+Rk68GRyMnZ9D2VNn?=
 =?us-ascii?Q?MeQUZmATst5rv4umrfIf3v8B5PUzzNFt3aNahN3zozY2Tyhv+0NrIB9BH+2o?=
 =?us-ascii?Q?7jvRnW3Em3RayIy3/QLlahdLlwvC3ro1I5TK1yEuj46WWckXS0NDZnxvjIrS?=
 =?us-ascii?Q?hsvpblk+ppa0MkGrL55ad6ylTIQzyU6g3beRbS/IiNFTBUNBhpkziQMpN4dr?=
 =?us-ascii?Q?1XVK45tGwVLDW41GmpCY5n4k/09lzkB6ytv1UT8nXjM+w5mxB4JJl7uSCG42?=
 =?us-ascii?Q?AlMOqLBtFtyYonF7yI0tipDbzQNRfSdMitPQzOSooTueKiE8yhahLX62LqI1?=
 =?us-ascii?Q?8nHK3jCCkgkX9MFwDAfttSQ9ISoOcFbbNKemKWXF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff18ffd9-d7e4-4f04-d51b-08d9e67c2f49
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 18:45:29.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYDuVjfuYlHI1DwLKv/1nPsPxLL0H3l7f9aJLvhkovjpSxIbiOeLrbHwZPc17b8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3708
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jjOW4DnRn--htm-jiOcD7RQczlcc-rZl
X-Proofpoint-ORIG-GUID: jjOW4DnRn--htm-jiOcD7RQczlcc-rZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 06:57:07PM +0800, Hou Tao wrote:
> insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
> in instruction granularity instead of bytes granularity, but bpf
> line info requires byte offset, so fixing it by calculating offset
> as byte-offset.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 6a83f3070985..7b94e0c5e134 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -152,10 +152,12 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
>  	bpf_insn++;
>  	/*
>  	 * Whereas arm64 branch instructions encode the offset
> -	 * from the branch itself, so we must subtract 1 from the
> +	 * from the branch itself, so we must subtract 4 from the
>  	 * instruction offset.
>  	 */
> -	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
> +	return (ctx->offset[bpf_insn + off] -
> +		(ctx->offset[bpf_insn] - AARCH64_INSN_SIZE)) /
> +		AARCH64_INSN_SIZE;
Is it another bug fix? It does not seem to be related
to the change described in the commit message.

>  }
>  
>  static void jit_fill_hole(void *area, unsigned int size)
> @@ -946,13 +948,14 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>  		const struct bpf_insn *insn = &prog->insnsi[i];
>  		int ret;
>  
> +		/* BPF line info needs byte-offset instead of insn-offset */
>  		if (ctx->image == NULL)
> -			ctx->offset[i] = ctx->idx;
> +			ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
>  		ret = build_insn(insn, ctx, extra_pass);
>  		if (ret > 0) {
>  			i++;
>  			if (ctx->image == NULL)
> -				ctx->offset[i] = ctx->idx;
> +				ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
>  			continue;
>  		}
>  		if (ret)
> @@ -964,7 +967,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>  	 * instruction (end of program)
>  	 */
>  	if (ctx->image == NULL)
> -		ctx->offset[i] = ctx->idx;
> +		ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
Changes in this function makes sense.
