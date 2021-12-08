Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24FC46CE75
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhLHHpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 02:45:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231469AbhLHHpw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 02:45:52 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7MKHZX004529;
        Tue, 7 Dec 2021 23:42:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mZVjOWsLzMAN42Xo7sIBKAreC1/7VAdu1ru5NtHzZc0=;
 b=LcAJUwE3SjytP1p6KQIrykQrcD8/XlGQLtRIjWOXfNl2eBfddFkQt4XDFZ32k5PhZ2Ex
 Yyu4p3ni/1z0rLB925k5PrpL5yXUUmGJd4iwCFuH732TGZcPUFz/p+NSva8Kg7IqYXYG
 36FOPi331p9EsW6BdcvBjCvAazsQKMXcWKA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ct90ne5y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Dec 2021 23:42:07 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 23:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJChKjISIl0esmrs/GEh/QLQN+vIO+DDm4HGK9XYWeRzAJ2r51VGDiANtUf3JC4j0HCSUj3rP16/oahlOlrXarq13lXdYTpHjzFjY4GcaZhe3CsudPtINgHcOn9ZMZj00hdosQFyLFk24/wZmiNfcyzSLPt8NWSMX4SyBCLLhysNXGZIi5w8s2tfQ4maG2TATuXZJKjwVgwz3jjA1A1gA6Cb9ObA0zXsy4IoKLVNCIuf/uCJMiiqrMavjENw7b4YGzVUcCVgJpvfhBejDL7aKSQPF82vujiijrL1gUqGlaUzvQnwV9qt9WI3paD2XdBblX38Fw0yYhsXhyntD8zPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZVjOWsLzMAN42Xo7sIBKAreC1/7VAdu1ru5NtHzZc0=;
 b=HsP6UBVL+7xnW2KEJOmeDTenAK+Z4R0WFvFWuIIh3DGDvrIjpFR2e0DlAB6KxiR/yTPTeXBdQV3ubgEkQv7fkvr7gBD51YvtvgmfnYbLVx3B7KQW9MB/cTmxMBlKp/L+V/8+meThSXDJw0yFYD5OJNosZfcezEZHgXm8KyPFZ21qTClNSLsUFzI/V3p3Zb+3MIiwXfmchx7zMnOmdRhrNig0LAOV+PkBVNIebi3PeWAqVqixJANiONBYPMW+7I8OaxRLeuizPrNdivEa+JktXQ9/84rDrj6eCknbvMr0Qm4mMHtprZSG3kRE9CAyLckCC7+JnCF0XNg5UW2wqid4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB2445.namprd15.prod.outlook.com (2603:10b6:805:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Wed, 8 Dec
 2021 07:42:05 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%7]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 07:42:05 +0000
Date:   Tue, 7 Dec 2021 23:42:02 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
Message-ID: <20211208074202.orr67beqmq5h6h33@kafai-mbp.dhcp.thefacebook.com>
References: <20211206151909.951258-1-kpsingh@kernel.org>
 <20211206151909.951258-2-kpsingh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211206151909.951258-2-kpsingh@kernel.org>
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4a0c) by MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Wed, 8 Dec 2021 07:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc7245c7-8109-454d-cdf0-08d9ba1e3b2c
X-MS-TrafficTypeDiagnostic: SN6PR15MB2445:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2445DA29564D258AAA3F3D98D56F9@SN6PR15MB2445.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mkm4OHOskVz9bEktXc+iu6fS87jNJUL0xNDoEo+XmXZiBJUhms96tydReIxhW23Qth4B30AxtgEK8BDIOekZpuYa3afaDMdWfbroMvcAdJdSQRwcgxAEW1UTndIUP1NuPSMYtonxs2J8N9kqb/QYYStky919WUUUSw5PoF7Pm+bhHgA7DISkffLOGt36p4xq8PNFayrQ09A3ZgpSl/QcUCr4ArwKPIsqvUOY65g5W2CfdnMuULCp3T4JilfxCIJ2+gSs3yLuz5OHCqJiy7POud/xvlGP8z2pfgrNSA3dtKUj3076XjH1xQM7OpVn7BKoODsERZWWiu7JO4rG3ewqFFUjAawrFMmrmgbkQgPVigJfG+Gbb5VgnAugri+OcmbLW66ujJvtkQW7WZ8enooLnLG+ySdZtgB/zIr3ZmoG8sZDNSC7g3xoj3mWInYm+xJOuVuKqGacy0s7jZrCPBfvnv1HCgl625uD5udkY8bqospPhk1PzMHODWI8wckjUhJS+5QjJsyVK2bPsGc/gWfXlnuf1PM2lE97TQGaeo+XCZCV4s8L/ILw1zKFXBAaDBqr7ST7NihmO9pD0LPN9tLpy3q8cnm6kG0TSKT4uOdsq2A34CcFxRPHKwBcLev8eAEkOAuh8mpf73tvL8SMioouRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(83380400001)(4326008)(1076003)(9686003)(4744005)(86362001)(508600001)(66556008)(38100700002)(66946007)(316002)(6916009)(6506007)(55016003)(186003)(66476007)(52116002)(7696005)(54906003)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bV/GqX+tbX+Jl6taaUZ2V6rtVfnFk/Ov0/olnST1r60/vFGje5m6f2hswEcC?=
 =?us-ascii?Q?zycwgwb7jNpd2p/IPcDqRBPG5XxxWn10SZIt2IcwCRVBtdcyYTq6zHUvMARb?=
 =?us-ascii?Q?KW6+qYj0ZK7YnK0v2TiWYp2kXsEkoSFtwWnkVGSFrC6wOp8Ba0y73vabP/qe?=
 =?us-ascii?Q?ZkkAk/sjB32MBVllZpSaidkebGrgI2bdpVvwZJPFTvg0H0R2mJ+jeiik7+hx?=
 =?us-ascii?Q?OkPfwTx3fulPVmk//banAZMU0P/HgSNhLB4KUnYg0Vfk+xxvKlbuCA/IZ9vi?=
 =?us-ascii?Q?L2sQKhk1+PIg72z/SFsPOFXo07TwD18Ux1wpmreljosCC7+DkYcg2y6XX3BD?=
 =?us-ascii?Q?XUTYVGJ47EsYuVRm+WUld5Fj5Rlcrg0DIGEd6CC3KdQVwmXEIt3Ia3eBq7zH?=
 =?us-ascii?Q?cUK3p8QpVk3s4g59lAJ3wrMAjNN8cKFFx5MJI2chTWwMWKvGY3X/LldVAQ/H?=
 =?us-ascii?Q?YcWb8jEAVcfyiw3Uon7W3af/ht+KkiNPJ1I7qV6Z0Tux4YFsQfTSr4PNtMXp?=
 =?us-ascii?Q?Kgn/Spk8uNvV7KEUQZJBXAeOGik5fG8kzd1XyoEA3NWSOb7gxUo+wVJk8Od9?=
 =?us-ascii?Q?SGIG2Qg9WCWgye6Vv5oDVZUhsGjiXLjyWoAKY7d+TM/9y4RRuo/0LSrbxR4H?=
 =?us-ascii?Q?sMol7Ti2ZHGJOJ5pPALuaFhIwiUdrHZJMqqs3JlLiFlVScZIo4LbK0h+FzUs?=
 =?us-ascii?Q?tf6zTHK6CYyMAxPOaxlgtl8AG2XstpOgroz911lQi7i7zwDSvwNw9OjKFZ55?=
 =?us-ascii?Q?xLLL5JSLQRGrwA6knFPCKOTv0aANoRF4EB84qmeXmOpKLDPmVNfRe9LUrme3?=
 =?us-ascii?Q?F8wOHDZkQplQCLcb2ZNUPzqnyKEY5+fAocqkms6CPyZqrO7wgljDXwuvwdKv?=
 =?us-ascii?Q?8YX2cpItlIG1n+nCnRtPV70D/2dvaEF4g+M1/yF0cFGARb0hgalZwrbi2Tbt?=
 =?us-ascii?Q?8UasyrVg17HcC4/hIaV1fcrMJPm4jX6iWBdhJtwU7gPaWg3lvOZroYujtsCx?=
 =?us-ascii?Q?obQvoYR0vlmF9hKV/GbnXRU9CYVr7gXOuFwHUXzEitlktS+xCTdWd5JfXKt3?=
 =?us-ascii?Q?v476YFwM69oEzL9/eN+s2lBCT1gNax3764xBZELsp4LzAGp/ZJPb9v04x52h?=
 =?us-ascii?Q?izITUWm/G02nPXVFwiENpiTAJin7Z3fVeXLQ4WFp4egMHBaLe98vyTgobmLt?=
 =?us-ascii?Q?5w+tBPwAMcED7ox0ixexZHjkPW62SPnGRQEqy4HWAMCNxwU0lsCg+ZoxIZzf?=
 =?us-ascii?Q?hQ63OYPbe6EvjY/jOpUwQ16b1F4JY5a99jymYbKUbQhAL5/fpIk2kKQM3Td4?=
 =?us-ascii?Q?KR5cEOMhgUc+F8vBUDU/MnkM5kvDZ6no9fS2It4B15rIXN96urp9O3ACySqB?=
 =?us-ascii?Q?CNKi4wjjzAv2Mf526vu+DHkRQ9bmXuZW90TxjmxE2HURo0DrMp9ysEgh6vyR?=
 =?us-ascii?Q?pzh62c5NwyAnHz7RTlYpuHN2ihFTo0K3mb8EcOFMAtcMVFqUWdZWc5t8i4vy?=
 =?us-ascii?Q?rFJoGrAuITyN4lhe+NZbyIvxqR+sWJCig+smPQFYIcN0vSvpfnql/GGbIHNh?=
 =?us-ascii?Q?DJ712osCp//YE2IedItcbU8bVClolNsyjV4UG8oZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7245c7-8109-454d-cdf0-08d9ba1e3b2c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 07:42:05.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vnmd3bSoqxOtQzvVna6WPf8f4D5F5UEyyXSZlDfUah66uwTzhdJm6vSHFkUaP6zs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2445
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CvfthGrZj9mhLl4J3Vdi6SIVJzfgy_44
X-Proofpoint-ORIG-GUID: CvfthGrZj9mhLl4J3Vdi6SIVJzfgy_44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_02,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=550 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112080051
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> @@ -213,7 +233,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>  	struct bpf_local_storage_elem *selem;
>  
>  	/* Fast path (cache hit) */
> -	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> +	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
> +				      bpf_rcu_lock_held());
>  	if (sdata && rcu_access_pointer(sdata->smap) == smap)
>  		return sdata;
In the slow path logic after this, it should need a
hlist_for_each_entry_rcu(..., rcu_read_lock_trace_held())

Others lgtm.  I will take another fresh look tomorrow.
Thanks for the patches !
