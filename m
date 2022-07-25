Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175F6580560
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiGYURg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 16:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiGYURT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 16:17:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B521806
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 13:17:18 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJWGpA030943;
        Mon, 25 Jul 2022 13:17:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cNUx9zMtVUn9Zm5uctyBdtMlAODIjLBnmMHUjr4xKgw=;
 b=W3qe+Ei5lSBepWWAZjgzChX2U/qA/CH0M0zpfCLfmSiNAWYxeXAA3S6zkbls2oqt/KlI
 eUhReCZKo0SJQHCZjYAGbK7S+Mjhs/O0ql4wybQRU88GeQEBdT10GWdmns/pebdng7Wk
 aYMouSqvF20X0ifIOxwndMApvq+kxP0TGac= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgd1hv077-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 13:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntMFSNc/AEXs4K/HJY4489GHFiGwKSAiFZZPC1Cux5WxRJttPb0vuqUhold/9h0wbtpzGIoocxPv30CLKHg7h2YaOG1/ylyv/gK0/BvdJq7h12aeDX46pBHOM+eQg6/h1oG+hlE5SEAEl2upFU6j78baTRhg6AXHMGPeriIZy2f5ikVDYV5QMCJv5KXwug19i1Wghpgbu1jpE3ZIl+DuLXGC59/2SW6e1OYHkEhe++5IYylQpMgyLk92ARmsavjRz1JluJP+5wNPgfedNxRFfk4pFskBlDmquT0248QKbV5vHZPzK67KzQlvYFIZLzITS2/PQVefiO7yX4yOooHoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNUx9zMtVUn9Zm5uctyBdtMlAODIjLBnmMHUjr4xKgw=;
 b=dY7AxAI5DDYtbq7GdKE3BKazcjvxOmKt10v2dMNpPZquZ6DjB7m07BSFSQ1aSlv2l/VJesVqtDLDmJAiaUwl0dKJ+0qB07n+vnjnPRYUPjvMdd1xCWX2Rr3YYrMcdVu8S2P4LCFh2zPCbnE2QuUL1jAsJJ9cWlCF5OudaZxupYRKVPPTbntGVIom1BZChHpPA4K1Uw9/yb6Bq4nDyHYNWg6oQfQ+Ph+zf9jupthGFI/mOUqqfHyKigUsPmj/Pf2RcbhbT0+wAdUGhqd6jmbyd7RaPoSfRAmzTWaMr++3YUv+hcSwX9I3/bbxlGs5nZ+r4rDx0GLsncSeydxT5uHbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB3534.namprd15.prod.outlook.com (2603:10b6:208:185::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 20:16:59 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 20:16:59 +0000
Date:   Mon, 25 Jul 2022 13:16:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, lorenzo@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
Message-ID: <20220725201658.t55raspwmj2eguek@kafai-mbp.dhcp.thefacebook.com>
References: <20220722220105.2065466-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722220105.2065466-1-joannelkoong@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93b85379-a896-40d8-5b24-08da6e7aa126
X-MS-TrafficTypeDiagnostic: MN2PR15MB3534:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaGUIBptlfaZv35AsKQ2QSn804GkDfCeDF+TEDgBzymd8dU0CiHkhJ8c1XP8sg8ZMzC3zFzSfT3edZU7Gol6k7eBs+l57MYGqLkW+JYP0OXqvmu7Xu8Z3xX0ICPG+m67nyrHwfn7Toa5lM8insnTJYi+sbBZcF1MkqpwrprLmPCUi0uvHCoBtEk1gSmE2NwjEczeF+SvDm5voCqxkWVL3MGbD/1PG9JqNxQMeyuokpykoBMAV5lXHg134DlWxmtkB2fU+iUHnf55yuq+LyxtX0GCjyqqoIxXRiRD91ry8RuW1pA4ZMP53HsF76RqF5Fgy0DBUZHUvYNqfJsjVvIkCehXNRSftJjV+3dN3qLR1ecURR6pvDupH6D8VJFbkbrSdoVmu+z2SOCnEr5GdRZPr+nNmcQ5F/x9W1n7629uOj+gUFcjkNp8iAleGz8Qxdx+Ge1RtqDHNh7B+o2r7OrsRXTFg92x0rgZFum/0zG85n+TI6giqSkJDPGwlq/WTWIXQBlXrXXycW+2yi65W54LQ81pWl2aqgy+pBnvXtXlGSOwcpM/8DUAB9cXyJwdbb8BvI45XrrYiIFc6FSmajp8mVfGnMx/xGTo0V2PEBQoFoj7Y4FvOn1JGVijU217jN6ipFTL6sRjXhvNNfBqks5vI9L7nWn7g5n2s0Y2oPCtC1o7qoPfUJ4t2/vZIcppwTf1DZxvlOIwh02BoLTb2tagHRsTM6QCpjEawP+M6BHm64VA+EKExf1oOul0C8T1ApB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(38100700002)(83380400001)(4744005)(9686003)(478600001)(316002)(86362001)(6486002)(52116002)(6512007)(6506007)(8676002)(8936002)(1076003)(5660300002)(4326008)(66946007)(66476007)(66556008)(6916009)(41300700001)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+3gA4lz2upZBDsv64k9ZA6HTtpFGSn/kqxUeszBHChWJSSoZfjvfgQp3te4?=
 =?us-ascii?Q?ugNf9MZzDrK4lbbNIuz4N8pkr9RtufkGc6CAjRfxt77LxrWtlTnBC6VTPZnX?=
 =?us-ascii?Q?goHz5X6JRIVwdaxpuxo1BPYNPHERfrK+cL88OLNyj0jeNovqiHVi6GmA2IIM?=
 =?us-ascii?Q?viJtPSTuqMIscwfo2YIKw4vxI0xWPBqXhhAw3LuRYzw6kHguwfyMsRzHvBfC?=
 =?us-ascii?Q?1HEePQ2PbGKbL6RW7xwq/93jxg0l/AF81u91xauaPfRgcZhrTxFKLidO0RMa?=
 =?us-ascii?Q?x8p1+3difVvlX6ypxoiPNmLNK2kYKvDMQFUGFMJXGQDux9qchyLkQ1RHdbaW?=
 =?us-ascii?Q?N2DzfQQvWfymrN2KWkQn6Ro0iv68ZPN9spV1tcS6wGEjiX2wTuizm93dmP6V?=
 =?us-ascii?Q?5MVEyoGvCUpRdVPsbS+i4/sgnbyH00vDnuDbEGGfwan5qNPqJAVCchyReEUE?=
 =?us-ascii?Q?q1DgJ4FqLR6LXmXkzff2sDGnadQ8pRFF8EvdlBHgDQmJ4TBWugVavuxBdkPx?=
 =?us-ascii?Q?FOvW380jusQG+628Avr7x0BI+32zy7FhNy712noIOfXI8t47HbI5Gk92XSuw?=
 =?us-ascii?Q?TIEF6n7kt5LPDdX/p6BgNO03rN47l1ix82tA3iIhmDizfGi5UYq/VpB/zc0x?=
 =?us-ascii?Q?Sk/xDB7E+L3vuk1zxepumaPwapbZYM3XL5TykK3bC8K5onmdR9C6jCv9Sb1I?=
 =?us-ascii?Q?g18Vv3cU4w1Ldn4QunMctrNbJaq66pwwvuHD9Zj7ifXmty1uYj86/2XsRAgz?=
 =?us-ascii?Q?QbpvxRZE5uB7FaSj50XlIKt+yYc/0+UGHeD3ptXYX2jQB24jc1GqtXA5aSl1?=
 =?us-ascii?Q?eT33hXic84B8sKVHrILSMkmRvZaSMvsbPox9L7l2/0xsZ7Uw/GRMwlhRt4PI?=
 =?us-ascii?Q?maGVVwL+ytLd+Cxv06P1aCnChucgUJMnIiBItUzP/dd2g30QU6X0cVBxTIxY?=
 =?us-ascii?Q?+NazSsCZZ4KxilRqau1FRG3m0sGPxJHDSmA89rVkYbe1LPSSDim3Jj/GI6tq?=
 =?us-ascii?Q?6jhkrHB50oMzHWrg/c3i5sQichr2R0fdk06vkoIiJgzL95D7tsR1RoiH9edl?=
 =?us-ascii?Q?t0VERbSFR0ypLEf1W1bN3e5i186UVQPGLXT1VPg4n1evEOLrYJl54VKntXBc?=
 =?us-ascii?Q?C7paN/6g4ZLfdCJ9guTP7HWPN0K5CFEPJc9s2vvc3UaYzxYWKZsA5+MgXBRt?=
 =?us-ascii?Q?85zT5BIn9+MM0T4X/RzIyLkMHKNBjkYRyB0hrzYEl6zV5pzkoB3O6/A18GoN?=
 =?us-ascii?Q?YzSDvkLWWqkqRrflASN16WOPoa9DZo4QKZNvW9VmRxFTDb43vG88vWG/FN2L?=
 =?us-ascii?Q?agLeY/eAkbEAM1ygOSAQLDsa+wPabwd2w7WaW8SDo5vL9DhFFUo3KtEZz4ZD?=
 =?us-ascii?Q?xAmWJJADb3v0lTc5nbr/u4Jd18zHTYWkURbZPMxBnFQFx/5O2ch0RFA3830v?=
 =?us-ascii?Q?NFPQNyRxmLyhwhLovyW24MyDJ3YlyJSirb5ZzEh8UnvJ+nfZeRyQnHd7yMCj?=
 =?us-ascii?Q?/cItwUyhvRgk5SHwYgxMaiYS/IT6MtmtHpuTaDrbW7gz7Rj3qdM9NHuAOBXI?=
 =?us-ascii?Q?wCd2m8zhjbKWuW/hK1NHvPjwlOyfr71wc3Y4IrQjrUDlf0FI7+jYOZRCwOC6?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b85379-a896-40d8-5b24-08da6e7aa126
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 20:16:59.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV7Dl3auCH9OnxYZ6CXEM4xY7Hx7ziGX6Bi4FrD2ABRs3rleuXWTtmxOEmpox1M5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3534
X-Proofpoint-ORIG-GUID: 97RcWG_nxPBC2sHXwBDLKoKCVkrMJF4p
X-Proofpoint-GUID: 97RcWG_nxPBC2sHXwBDLKoKCVkrMJF4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 03:01:05PM -0700, Joanne Koong wrote:
> For the case where offset + len == size, bpf_xdp_pointer should return a
> valid pointer to the addr because that access is permitted. We should
> only return NULL in the case where offset + len exceeds size.
> 
> Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 289614887ed5..4307a75eeb4c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3918,7 +3918,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
>  		offset -= frag_size;
>  	}
>  out:
> -	return offset + len < size ? addr + offset : NULL;
> +	return offset + len <= size ? addr + offset : NULL;
This fix should be for the bpf tree.

Acked-by: Martin KaFai Lau <kafai@fb.com>
