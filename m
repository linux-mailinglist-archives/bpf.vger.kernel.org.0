Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD139992D
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCEga (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 00:36:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhFCEg3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Jun 2021 00:36:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1534X0wA024615;
        Wed, 2 Jun 2021 21:34:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2GKUuqKoqnJ4mEMlJoMBQ0qZ0NQ2uH94i5zMOh9Y0G4=;
 b=IVbF7OofVgBhkXtSDjPqO5wvNQgfpkzTWSYeit8eJsVfok3wQ0sXgWzEdXOnGavYIwEr
 hlkecfLHI7KiVnSSCEQUlHMO24OWVDaruP33TAbLcDqYjTcncBRVSE/IjqHL6sFmXb41
 SNV9OzPmLZlCFeHx8N6MDwq4ce1RqWl7t1U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38x34w7fnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Jun 2021 21:34:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 21:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0i9cfeNgd+jNBpISfeoIQJzo9+ZiewGWuJP7NCW75O37Eu24fxbTPpjycU4XO3s0hCtutVvPmyHGMuy7g7Zqs+sQurfx8D6SYtlabxn/ASjP6UAe1qoDPu8qnRxv1BRkRt3fI3E3765Ot4w3t7qw4OpG6PuwCr2QiKVQT+VPpxMXz1jcaG5dw4bW0nlamP8WSsHE6jzlnCKiVS3WsSGfvHbiZMgQwO1GhycL5N3TyehsKuwUYnohRFNP6Llpx90TOBlvRSoTn2km0gbQR+DyhjB033eFaC9hteffBV8BpChBjZNM0w4BHiCvsuhUKpWYamoztleuaPa5D0yFYYjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GKUuqKoqnJ4mEMlJoMBQ0qZ0NQ2uH94i5zMOh9Y0G4=;
 b=iSsKAtp/sVsF/6YXUkWfuiAD8M5UeUwWtvoVhsgCOj8ZElYg+HJgKhCACDp8OICXO9JUyImvlpA1AyEzbqFlpKN7ECE9Ha9zLxHQppdca27/43us/z6idoUSSEJ7X0VMCpSz6jeNY1FuteaOwYLePKUAITPOSI+UlvJNW53KKh/nrng8ccUipNEPXfM3G76kKiwccjWkegM+jJf7uGJ+Uj4DKF3flMAqL/IUl9K0D8CoscE9iNaF0uqxXC83VU6cBsf26z2ZGhIBXNLPmEkfMRysoCxTXHBNLKiRRavraL0fnZI/2o9rkyhJBbGVj/6eb/UFZ3/GJmUMoTQ8TOli+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 04:34:25 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 04:34:25 +0000
Date:   Wed, 2 Jun 2021 21:34:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Zvi Effron <zeffron@riotgames.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
Message-ID: <20210603043421.3a4fsjbegcwy623f@kafai-mbp>
References: <20210602190815.8096-1-zeffron@riotgames.com>
 <20210602190815.8096-2-zeffron@riotgames.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210602190815.8096-2-zeffron@riotgames.com>
X-Originating-IP: [2620:10d:c090:400::5:caaf]
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:caaf) by MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 04:34:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac56eb1-b726-44a0-2e41-08d92648ddb9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR15MB300059EE12C78E59AB579881D53C9@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24zbLUMhIW3TCldyMyPmW+1e3rwJ5mlnfZ8W6+knsw9qXImnF29muowKD/n4AtW9hbC2T1k+0GrFE3SnfRaUfcsME50zz9ED/mANc4SIVjxSXU6L3LjUDb2cDbV4SUAGGvZMZP6RK1Mg9sUsWuhtkVAy+62Dkc1LLNVMBYt+wj0Xrpsb8eN5zqLi6caDtpEgWQDova8rs39T14Hqam0gv2vKUEWw0RaJaBcW792/Qkymvcl6O9bbGCkhxdTRsaklEakfhGQK2TCdRvatiyfwGnjDc3cBBGlPiIp10ET9o8AuoSOL1pWaV3q6mVqW8d5cnTLhdgRTLhLHOUHEnORD555/sRRviW+sEEdg7/PGHfJ3RBFlQyadSyA2baFd+DN4RLEaUN9xcakVnKgVMeVv8KXEZU/rHyhauMheHMIxlT7r4yBqND4OWzs8XOMWB/F+L3Q49iOMmrl3bDh9hsR3wrtFNCmlxh6Y5gcESb5of+vtfj3GlnYPaHNDxfnu11yYAnL6JiL5udZemz4JAscsS+7yZlMg0rfWgERdzfiyggB+agCkwnwBmPCUAbMDVeoJNbs0TzRXM6raRSq3hLJ+is0R6tf1MMtw5XtIg0yNJbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(6916009)(54906003)(86362001)(55016002)(9686003)(52116002)(33716001)(316002)(6496006)(38100700002)(8936002)(6666004)(4326008)(16526019)(186003)(2906002)(8676002)(66946007)(66556008)(66476007)(5660300002)(1076003)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RsCTRy1ynXpnEGYLKKuBcpwvHUK1qDs+5Pm65WbH0/Dv0Obh2aKRD4hdI23C?=
 =?us-ascii?Q?RQFEfilBGZMgoLVMT5w2JVuwzxXYN95raQ3rMwanTmQUjLvHs3EGgnejjapd?=
 =?us-ascii?Q?XpyjW/UANhflvuFHZZ5IYvuPqJ2edasMxoY0HFHdHgQrHJnEztGgMJ+GvD7u?=
 =?us-ascii?Q?voxzPLxHO6aNYPSTEayqsimQqshJZIu4xm6VZQtLKfI2ECtTInaMcifeGAlj?=
 =?us-ascii?Q?UTSUSdMkNyGr2XD+4vpH4efq2CCfu0UE21tIlBMn9oyKhxEnsmZGgdakkNjy?=
 =?us-ascii?Q?dAl4/dCg5BQ3SiOTnZWI/bZH3K1b7ZCwDBPEelKBQ0X7//2VO/9aB53qRgv6?=
 =?us-ascii?Q?hkKHC+7ENdW5m6NpkRHe1I0AIVMaeYvsZzD4sZHXf4/LyX38bIz+qGFXMcnY?=
 =?us-ascii?Q?dCzhoS+IYhKby4UwRC9QCJyGynMPLhRCxiH6vZgdAlb+T1gi2KcSo2u6j7bb?=
 =?us-ascii?Q?G9lTEcyHkNe/jhsW+uf/yIXnw6QPkMAY/d7t34DO1Py91kg0WxfDr/RLSCEa?=
 =?us-ascii?Q?Rb5VU3WC9tmPjpupV6BMOQx5t/SaxduMtrc0PnKsMTl9315UGm1NJJZys7Ke?=
 =?us-ascii?Q?1qbI9QeW1ch3EIr1Ls+aRQkE11F7RbQT57HNqz1lnb0p4r2sp8/a7hjQNXO+?=
 =?us-ascii?Q?VmTqq+zyge78IQLsnTc0TQI3xUpC3y9Sc0RIn/2ZFWI9ABM8/iVEY8a8AsiC?=
 =?us-ascii?Q?NCK9zSvtIhKgbxpNVA9BfZbe9RhfiO/2bfk4RIkMCZZcjZ36rkXhDjyt5SaL?=
 =?us-ascii?Q?/2cePcl3FDCeo/ANqalA5mGJWfczOTSJljK01FxABfkZvXKBTVX925Yfi4Zy?=
 =?us-ascii?Q?hZSQC8/sttooFPb43zxf0zyYkRwRzb/Ep+maJU6kC5r2hd50Ua+7jyA5tPt5?=
 =?us-ascii?Q?Q+6uxUyKt8S1OGU9p8gt9Hc6V8GsevlxeCKnaztgOXhUO77XL2kDfF3PlB2X?=
 =?us-ascii?Q?G6K6xYu28S6pH5mzb9JMmmqTw627v/o4ybZVBYk1sOBEp2VhE4cfV6/HHtQT?=
 =?us-ascii?Q?Y/9QLZ+lxJ7JQExwLKj4D4nFBaV//Phs0DrZZ1rIRw7gSli5MIlPvCcK6V3X?=
 =?us-ascii?Q?6zfDVOQ0Z15SoEJ4kEpN1dLbp2QNq0Uq+aCoMwtT3gx61YmTuzkJGOOYO2Nr?=
 =?us-ascii?Q?Qawyj7/emlib1xa+jLLE1GOVr+bJfm2le5YwYv/bWJ2wUCKPAvHcuVHdMiLZ?=
 =?us-ascii?Q?9tqcrnrvqz369rSSLcCeDGAxFOggywigcl91LGacMDJIeZkcOBaKUmJO/xfL?=
 =?us-ascii?Q?irQbESRoXgihPy7L/KnoTpBZDoFhZRHpqNKyyZ4bw+yOGn20UWOHn3cLGr5k?=
 =?us-ascii?Q?xp+TAy6QBnXG6TMlLV0SstD6JEvWffkdZ7TXRw69BDZElg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac56eb1-b726-44a0-2e41-08d92648ddb9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:34:25.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO1XHYd4U49Nrb/Qz6Zr8PdDxiS6862AQGEziVvJaDqOxS4FAGzJUa/IL4VUrk9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EZqKAyKE-YNUUquajJ6ASbJfHl4j5t1s
X-Proofpoint-ORIG-GUID: EZqKAyKE-YNUUquajJ6ASbJfHl4j5t1s
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_01:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 02, 2021 at 07:08:13PM +0000, Zvi Effron wrote:
[ ... ]

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index aa47af349ba8..ae8741dd2a54 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -687,6 +687,43 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	return ret;
>  }
>  
> +static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> +{
> +	void *data;
> +	u32 metalen;
> +
> +	if (!xdp_md)
> +		return 0;
> +
> +	if (xdp_md->egress_ifindex != 0)
> +		return -EINVAL;
> +
> +	metalen = xdp_md->data - xdp_md->data_meta;
Remove "- xdp_md->data_meta".  It is 0.

> +	data = xdp->data_meta + metalen;
> +	if (data > xdp->data_end)
This test and...

> +		return -EINVAL;
> +	xdp->data = data;
> +
> +	if (xdp_md->data_end - xdp_md->data != xdp->data_end - xdp->data)
this one.  It is because the user input "xdp_md->data_end" does not
match with kattr->test.data_size_in?  These tests are disconnected from
where the actual invalid input is.  How about direclty testing
xdp_md->data_end in bpf_prog_test_run_xdp() instead?

> +		return -EINVAL;
> +
> +	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> +{
> +	if (!xdp_md)
> +		return;
> +
> +	/* xdp_md->data_meta must always point to the start of the out buffer */
> +	xdp_md->data_meta = 0;
> +	xdp_md->data = xdp->data - xdp->data_meta;
> +	xdp_md->data_end = xdp->data_end - xdp->data_meta;
> +}
> +
>  int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  			  union bpf_attr __user *uattr)
>  {
> @@ -696,36 +733,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	u32 repeat = kattr->test.repeat;
>  	struct netdev_rx_queue *rxqueue;
>  	struct xdp_buff xdp = {};
> +	struct xdp_md *ctx = NULL;
"= NULL" is not needed.

>  	u32 retval, duration;
>  	u32 max_data_sz;
> +	u32 metalen;
>  	void *data;
>  	int ret;
>  
> -	if (kattr->test.ctx_in || kattr->test.ctx_out)
> -		return -EINVAL;
> +	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	/* There can't be user provided data before the metadata */
> +	if (ctx) {
> +		if (ctx->data_meta != 0)
nit. "if (ctx->data_meta)".

> +			return -EINVAL;
> +		metalen = ctx->data - ctx->data_meta;
It is confusing.  "ctx->data_meta != 0" has just been checked.

> +		if (unlikely((metalen & (sizeof(__u32) - 1)) ||
> +			     metalen > 32))
> +			return -EINVAL;
> +		/* Metadata is allocated from the headroom */
> +		headroom -= metalen;
> +	}
>  
>  	/* XDP have extra tailroom as (most) drivers use full page */
>  	max_data_sz = 4096 - headroom - tailroom;
>  
>  	data = bpf_test_init(kattr, max_data_sz, headroom, tailroom);
> -	if (IS_ERR(data))
> +	if (IS_ERR(data)) {
> +		kfree(ctx);
>  		return PTR_ERR(data);
> +	}
>  
>  	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
>  	xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
>  		      &rxqueue->xdp_rxq);
>  	xdp_prepare_buff(&xdp, data, headroom, size, true);
>  
> +	ret = xdp_convert_md_to_buff(&xdp, ctx);
> +	if (ret) {
> +		kfree(data);
> +		kfree(ctx);
> +		return ret;
> +	}
> +
>  	bpf_prog_change_xdp(NULL, prog);
>  	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
>  	if (ret)
>  		goto out;
> -	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
> -		size = xdp.data_end - xdp.data;
> -	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
> +
> +	if (xdp.data_meta != data + headroom || xdp.data_end != xdp.data_meta + size)
> +		size = xdp.data_end - xdp.data_meta;
> +
> +	xdp_convert_buff_to_md(&xdp, ctx);
> +
> +	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval, duration);
> +	if (!ret)
> +		ret = bpf_ctx_finish(kattr, uattr, ctx,
> +				     sizeof(struct xdp_md));
>  out:
>  	bpf_prog_change_xdp(prog, NULL);
>  	kfree(data);
> +	kfree(ctx);
>  	return ret;
>  }
>  
> @@ -809,7 +878,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>  	if (!ret)
>  		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
>  				     sizeof(struct bpf_flow_keys));
> -
>  out:
>  	kfree(user_ctx);
>  	kfree(data);
> -- 
> 2.31.1
> 
