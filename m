Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F439E607
	for <lists+bpf@lfdr.de>; Mon,  7 Jun 2021 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGSBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 14:01:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230434AbhFGSBC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Jun 2021 14:01:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 157Hr9iu012158;
        Mon, 7 Jun 2021 10:58:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Pfd0ILr0/Ss8yzTH7sjwm5mp9BhujMzneLD6/Wlmgkk=;
 b=RZ3yCiYBlHPXCmzPpJZ1QGWthbAP23VLncYTo4auII7zsXdtPy/0LsTcxYsxUm7PMtsA
 BS6imnNPyK7tnAi1n53YxihWl9f4CorthAPqApH4JvmupI7DGxlj10r418b8h7MPq6eU
 08XnvoncDpYwG8Pd9yzhy6k1QEqRicNacdA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 391pw5rkma-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Jun 2021 10:58:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTidi+woD98uX8vBr7Lb3hEL16IeB4d0FhW60fJthRgxN7Egb4duUyPUSg38Cr9KLn5U0rog85LQyIFM7ueov/6eG0VG2YvnPVOouVh+M/VPTGHgEby4v+/AyNjDE0F0bgxnYUyS83VKn9bO/zkEA0vntp9ldPqay+n03IYNmXSvCrWacV2bB00p2E0P6/ps+4rJ98Z1unAdT5+CoYvfKjbsenxRo+sfIjhB5bQVVw+0BudLkhVhTQDh5Fy0URt/Cedn14+zhxCAdivJCGDV5bxC+l6r3jJpuaPr8IiNQ0rMHfUuSyUHhdRE6OhmV4sgLuNf16Z9FtzyGtoePwDkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfd0ILr0/Ss8yzTH7sjwm5mp9BhujMzneLD6/Wlmgkk=;
 b=A7HqbwzMhCi4WxWAhMMR9lKK4mbUbc8z1OA80rVtML7S/UUuoUrZVztucScXqCjNJnRp0PgxkmoVdGVwtlKM9f4Fc90kwEKw12sPsDj5r5WbSCtNFC5i2JxlklwhDPZPIiRF/h0neh9ESzptdUFmbGUbm/h1jmmb2QFXg10uLt1M3VN/jZKSewVy+VMfGCmx7r4S7Hoi44LIcHE6dQYJZMsCE70xjZEZaJJZu/k75H3TqJHb12YfsF7DlJlewHVwUb53IHHqo2AFxbK3zC80Kh5QynUjyPpJpLGZ/rrNb+I5Q4ZGjfj7QdHdwIrbG+vAlLxocm832DabvIkut4mhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4840.namprd15.prod.outlook.com (2603:10b6:806:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 17:58:49 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f88a:b4cc:fc4f:4034]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f88a:b4cc:fc4f:4034%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:58:49 +0000
Date:   Mon, 7 Jun 2021 10:58:46 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Zvi Effron <zeffron@riotgames.com>
CC:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
Message-ID: <20210607175846.k6hxm3jya7mqzicd@kafai-mbp>
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-2-zeffron@riotgames.com>
 <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:37d5]
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:37d5) by SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend Transport; Mon, 7 Jun 2021 17:58:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3f1722-13d0-442e-e0d8-08d929dde704
X-MS-TrafficTypeDiagnostic: SA1PR15MB4840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4840AED2F92516A373526D25D5389@SA1PR15MB4840.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96GQfhaCNfr6C1r9I5boIIR/7+cvbsCA2sryC/JXFYvGMKLIhJnb5Anhel0fZozHfGGaHTRHblOulBCkZLVvf3DTVXaRzcZunvVrsOH0yWNQXzwQWrFbn/OFJESEMK4x1fzeLUwl4pktyKTxCZKZ7dAUysTl7rGu8wbr3ExTC4h8JYRFCWf1HHVED8ybP0gUjVh/0kiDdRtAC55H3eN9eKwKCG6p1DGG5aHqTXWB34jQlpW5isf4Fheu9PGvN1t3GnjCcs6If8Nf8FkbTwKbZA4GLIQuyYdaabue+CpTuiFxMU1XOifnu2aKvkhBx8BEeF6rozxdVCGapn15HuUAGTQSTwu7E5Si2aowDR70t2XtuaELG8tImCJBvnBr+hVfTYxoC65VbmlMLHirkkFhicS4cxeyTSVfv+CGFagRfiYFw+UitBjhpFNiCt2Snq7cg/IrkU3AQKJz2irKjgdsJEWzPIkI+4qxC/beTRDdDiRzR/xLV8I7KzdRqi/JJkzn3CKVAFJlXAzqvqAAB+Gc+Ad+RbZs7gXtFCE+z9eSeAgSQIXhekMlnDaprRGbXjeD1IxkZ5uvHnhFo/fHhsX/8t8enPqfW8vyEcsJqmDKURg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(7416002)(1076003)(8936002)(478600001)(52116002)(6916009)(53546011)(16526019)(2906002)(6496006)(186003)(38100700002)(54906003)(66556008)(66476007)(83380400001)(5660300002)(66946007)(9686003)(86362001)(33716001)(316002)(55016002)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qZg0FJK0lTitbz+VXeEM6boABBsTe5vyrxVw44lsBDddUTuyptXQFn1P77sf?=
 =?us-ascii?Q?0NpAAIbKLdPpVfguAn38cn4MSugonAPYN/UdGWA2gBPV5JgRhWRxn5sk+FNM?=
 =?us-ascii?Q?kW9mvG4yy5XSpw8J4NvUkIYZK/N8FExBVe7kNmcGJIYbXqBXaqfz4Is59AVB?=
 =?us-ascii?Q?AK7MbAZMpZhr5Di77XTVNb8gbKNsOnPFZ+PyP0/TUjudEFVnB7JigHKl1AMf?=
 =?us-ascii?Q?y/ZsMmI7Fq+8LIYU81Tsi+l4sFZNqCmkN0DVvWher94NAExQ+YI+fDTDAijt?=
 =?us-ascii?Q?r2tlvAF/gqadKLYTgWWrjxHOGnYlvqexR6YRws+HsUJioFXvmfQpi9ibrbsL?=
 =?us-ascii?Q?u1QttmJ1+jN98wPNAwP90lK7zEcqzV0ZjTxjMYj+r0tMHccdKYj9AkD4jJYW?=
 =?us-ascii?Q?iCQIvvMKlUpVz23o0TI/7oD20LX14QJL8UqLgxKKPFJ8+fYx88kGeL14qeMT?=
 =?us-ascii?Q?HPuHwtIkPrD3jNoaTP97bochNan2lPsQLk33KNjFNqczFPKNdm18zPOsQMxb?=
 =?us-ascii?Q?0wznca0msEz9MMMJUlwFCuTFB/i6BEurP24BWX5nOka4jeRuZAU2IssxKuej?=
 =?us-ascii?Q?XWQTk24FgtMJlCOGcruiW7yr1riZHDNP4t4s3vZP9mUVq3tJy5JACM9HSNpr?=
 =?us-ascii?Q?/KrrqLwaHgQpiDpvCGAaEA3EMDGL9yedr4w4sfC2QX5IKqLn/SZzdNMDQcV8?=
 =?us-ascii?Q?a8WIK6xFWJRVLV0iGGBAZZ2ic9bjP66XQOYh2RELWLHzStlUwowAQxWQPYwy?=
 =?us-ascii?Q?m4yTfCHmYZiLUEQuqUF2BAI37RMbgxiN3aaokvHv8WiEH2WXxAjCk05tXX7c?=
 =?us-ascii?Q?Jfh2+JtGuyQY29JyedQ1SZ28wGlBBUwpb9nhWbh5cFT837Jsples/xMQdxYV?=
 =?us-ascii?Q?1qPtt7+Wj4kRnmJZ437nOaa1RsuNCeJ/ubRkvEPDTPywcGgiAvY1Ao9AsIHk?=
 =?us-ascii?Q?SSs/l67LLtnthuYOvfi06/7nfVncurKsW0rki2jMPgNexzFQsBCO9WCykSNV?=
 =?us-ascii?Q?1cDa+TNIy4p711v14QSAp9pUTWjVaPD+sgQ+SGL9eAvY1Nvc213sDkce9jdF?=
 =?us-ascii?Q?N/dGFiJaj0xoMf2Zo0SPRo2s080z0a3CuyREpcX7hCH06E2jXKSu8irPrfv0?=
 =?us-ascii?Q?zwrg2YMHfsS73N3cL2BgVBzsK9AZtMzpXK5G/ft5RnA6Hvc6O+VfK+uWQR47?=
 =?us-ascii?Q?v3CE5xjEHcUFY4rhEgEDEox6IpUUmfaYr3e2NK9E3iYjsnQLzXh7ruvaJFtj?=
 =?us-ascii?Q?LnwgOLsRTyEz+GqRJCdOUuiYJpfGiwktNd3P0GMKcgg3q8yLUoZpG0zBP2IX?=
 =?us-ascii?Q?nzNZy+cHg3MH6Wnn7XvKaPvNX/hGD/iflACFRj1LFh2uEA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3f1722-13d0-442e-e0d8-08d929dde704
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 17:58:49.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDKKyXs7yUuQCS+AE7Is3DTVLB/M2kXuGJ8la6qhEqeigP1D1o+LdNYLw2pcdYKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4840
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 4BtmS1MlJqXGKaUPiKZu6ADozQ4t8bQn
X-Proofpoint-ORIG-GUID: 4BtmS1MlJqXGKaUPiKZu6ADozQ4t8bQn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_14:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106070124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 05, 2021 at 08:17:00PM -0700, Yonghong Song wrote:
> 
> 
> On 6/4/21 3:02 PM, Zvi Effron wrote:
> > Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
> > BPF_PROG_TEST_RUN.
> > 
> > The intended use case is to pass some XDP meta data to the test runs of
> > XDP programs that are used as tail calls.
> > 
> > For programs that use bpf_prog_test_run_xdp, support xdp_md input and
> > output. Unlike with an actual xdp_md during a non-test run, data_meta must
> > be 0 because it must point to the start of the provided user data. From
> > the initial xdp_md, use data and data_end to adjust the pointers in the
> > generated xdp_buff. All other non-zero fields are prohibited (with
> > EINVAL). If the user has set ctx_out/ctx_size_out, copy the (potentially
> > different) xdp_md back to the userspace.
> > 
> > We require all fields of input xdp_md except the ones we explicitly
> > support to be set to zero. The expectation is that in the future we might
> > add support for more fields and we want to fail explicitly if the user
> > runs the program on the kernel where we don't yet support them.
> > 
> > Co-developed-by: Cody Haas <chaas@riotgames.com>
> > Signed-off-by: Cody Haas <chaas@riotgames.com>
> > Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> > ---
> >   include/uapi/linux/bpf.h |  3 --
> >   net/bpf/test_run.c       | 77 ++++++++++++++++++++++++++++++++++++----
> >   2 files changed, 70 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 2c1ba70abbf1..a9dcf3d8c85a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -324,9 +324,6 @@ union bpf_iter_link_info {
> >    *		**BPF_PROG_TYPE_SK_LOOKUP**
> >    *			*data_in* and *data_out* must be NULL.
> >    *
> > - *		**BPF_PROG_TYPE_XDP**
> > - *			*ctx_in* and *ctx_out* must be NULL.
> > - *
> >    *		**BPF_PROG_TYPE_RAW_TRACEPOINT**,
> >    *		**BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE**
> >    *
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index aa47af349ba8..698618f2b27e 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -687,6 +687,38 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >   	return ret;
> >   }
> > +static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> 
> Should the order of parameters be switched to (xdp_md, xdp)?
> This will follow the convention of below function xdp_convert_buff_to_md().
> 
> > +{
> > +	void *data;
> > +
> > +	if (!xdp_md)
> > +		return 0;
> > +
> > +	if (xdp_md->egress_ifindex != 0)
> > +		return -EINVAL;
> > +
> > +	if (xdp_md->data > xdp_md->data_end)
> > +		return -EINVAL;
> > +
> > +	xdp->data = xdp->data_meta + xdp_md->data;
> > +
> > +	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> > +		return -EINVAL;
> 
> It would be good if you did all error checking before doing xdp->data
> assignment. Also looks like xdp_md error checking happens here and
> bpf_prog_test_run_xdp(). If it is hard to put all error checking
> in bpf_prog_test_run_xdp(), at least put "xdp_md->data > xdp_md->data_end)
> in bpf_prog_test_run_xdp(),
+1 on at least all data_meta/data/data_end checks should be in one place
in bpf_prog_test_run_xdp().

> so this function only
> checks *_ifindex and rx_queue_index?
> 
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> > +{
> > +	if (!xdp_md)
> > +		return;
> > +
> > +	/* xdp_md->data_meta must always point to the start of the out buffer */
> > +	xdp_md->data_meta = 0;
Is this necessary?  data_meta should not have been changed.

> > +	xdp_md->data = xdp->data - xdp->data_meta;
> > +	xdp_md->data_end = xdp->data_end - xdp->data_meta;
> > +}
> > +
