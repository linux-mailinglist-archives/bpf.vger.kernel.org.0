Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE5F4BA857
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 19:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbiBQSe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 13:34:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiBQSer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 13:34:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B8D41FBF
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:33:03 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HGxssO000531;
        Thu, 17 Feb 2022 10:33:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Nd9OHypsUEHi38BAXSiuA+eJHZuTEgjfHAXzLfHe92Y=;
 b=bGoovcTiHpaFCcfOuy8pI1xzt6Z/RoDE4WvWr0fEw/2vuMb3LHfu4Ry6Cy5Oi5VUVcyY
 lJlMUm449P499v2LjA9t+NXZAj56ztHBw1pNs7MIisl3zDCrX6+3NaW68csq1uSfc4Xx
 KI3VOpIBOI0BvVh1oP0QIXFs79oTzxSeshw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9f7rcvge-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 10:33:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 10:32:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVYhy9h6QD4j4Kio4U0K6GIo/6P/1uRYZQQkiRgUw4F8RMwzeuuAAzRzQgleWzPlWm18l7QBtVCkdy+1Z8m/YhzBudy/S6RTQzRRPjYW6yqMKGkYeBT0+KNpK103m/ajIQRPiOQBt2xBpcV+z5YG+dfUZjsQ7OZ6gr1Vv+IxJML0Gi+qBuG7X9lAfGd7DwNzIHVH3bYtt8O1Lfbd/GaPCC92Qicvy+ews5rFfiDrTibDuQwsArzKUqMUDnUjAS0ZpPlH3ObVJYWq+oD5fBmySh1qf86qRXDSWP2+dn15VuUu9El5dSgf1Xom/QCPdBy1KwKsQML8pCzkjQr29O5Q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd9OHypsUEHi38BAXSiuA+eJHZuTEgjfHAXzLfHe92Y=;
 b=fVByM/GWd4I21fclkn4GOJZRtSKR8xalT27ZWKMU0DkTwrXjOFNRgTo4VBmrnumm8LFH2CsQ+yfPceC9Ge5EtId58fgou6dd1DluO5XFrCkDm39iruXyFBxqyG2DnHbjm+HhueMnNT7GqDQ7u/ZlKoD1T6NlcengMW+CK+Q3cIZEtSPbDex21MbHXEoDsdFMjfMLhKGcU4N07VRijdJzYE3rHt8EAf7KHqdWqqlUyAGBrTLFAg46LdrNU0xIF+aHKR49stu6UTEfUCahIp0hF0u6RrQzqIzJp93GQAFZXtx2Rv8hlGgcy4Y71ye8nGOe09fVgEVeS2Cjduw0llU9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN6PR15MB1634.namprd15.prod.outlook.com (2603:10b6:404:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 18:32:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%6]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 18:32:57 +0000
Date:   Thu, 17 Feb 2022 10:32:53 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yucong Sun <fallentree@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when
 bpftool btfgen fails
Message-ID: <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
References: <20220217180210.2981502-1-fallentree@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217180210.2981502-1-fallentree@fb.com>
X-ClientProxiedBy: MWHPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:300:ee::22) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb0b879-3b7a-4e59-ad18-08d9f243eb3d
X-MS-TrafficTypeDiagnostic: BN6PR15MB1634:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1634EFD65303AA01070AF653D5369@BN6PR15MB1634.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Su+uNYAvE82+VwRQhaWjL9BS5kO25nKZrPkwcgkGHbW2RcHJWQLJjIbjMO1QaoK/bedSNo8V5zphd98WTQ9c5Humt6ewRv5v3/b5YzrTI9R62c2yYhpChgHv9oI46swl3OeqmszuTOSl3tOHW7yFkW1mWNBorwmiuExx12VvbSs8AwcQFyjMwc00PBiUzRfLV7Ue43SdRhEi3QJ3ByAIh6oTR4UUSbPHKIDP2V/hv95iE1wSFYvPT/QimAqgJDaxTYu2m9Uy/uE2VZndFJWxBzju6mz+QfuMxoN/OUYHzySd9RKDXsRYa1KTgN/Aw2kfMNaplHAM07Y6FN2L/bhVnviOx06fNFA5ZbfiMLwFK/vK/uPYINzVszEHt27JykTkGm+XkYyt0QfLwkF0wYWRvNnol5gaDHKXpmIQdQtwkCTXmYNuXSygfZ5bQgpp0bdIHPM4M9TOXQZ0OciyWyVdOPvevWSq3KqkqZychNDAThg+XqTotZ1H9NQdPZC0Y9H1JDETELic6IaBkxN6K14Q+METZCp3dUYvOSpgMEqWrC3Y/pPPQFl2p5sA/JPg7PmBOFzHNRG8EeFkCLEqmmGdyeDpLDrUH9FmLHnsMcCO5L4zKsAw2bXvI7Ho3YueobiupAD/F/AGMBYvFTEDoTFZxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(508600001)(6636002)(6666004)(6486002)(83380400001)(8936002)(6512007)(5660300002)(316002)(2906002)(38100700002)(86362001)(1076003)(4326008)(66476007)(186003)(66556008)(66946007)(6862004)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od1NXarDuP+sp7jF9oRq1ibODO7Y0AfdZpyMnWi+bqq520olGFcKFlkQZGCa?=
 =?us-ascii?Q?9/plQpNyhEk/AW7xejw0/l1xQuIbCou7zhXRy9Ts7VWnmt853XLB+8zzgquP?=
 =?us-ascii?Q?rpMqtNy6HMy9+3CS3m4nkQWg14/F/zgaIPIHFdNQy94WE2ME7p44S0xxsJOo?=
 =?us-ascii?Q?UXJqeGY4rEp3b3p2yQpL5DuVdgDWG2QH1NuUwCxA0iD467SFeL1GAkCPOSH9?=
 =?us-ascii?Q?iu/1sgLxJ0Z/StRoVmJdOlQCnrL8j5Vddp+zVGZGfWefxFx/ms0G5IKSzZfo?=
 =?us-ascii?Q?lLPkZ/PzxvimVfGdTwwCzUW672zr9czbpC5aY2QsjA+ulTHtR+YZtb9oYsEc?=
 =?us-ascii?Q?A9dbyc2LgV/9lwKgFieVQ6UYp8soT49PZpTQ7vmDfFmYbHNzDc+tRkBgfx+n?=
 =?us-ascii?Q?aSUOHqUC00MDu0Za3Em9CvEAwW/tfT2beCD6jWvcdUd5n5secXOL3beBowXt?=
 =?us-ascii?Q?8oRUq9ahiuTTRZWWkFnBScfZt1u6pawtO1de+5Ma4cQpWtxzwKR4geME9eBO?=
 =?us-ascii?Q?xQfzzd20shIxdX+GUTvlhIJ3VJ7MZBZbymC1QohIlQFJLMWUgYRbPFanaXKO?=
 =?us-ascii?Q?cZyT07xeNAWrDukzqY2thPQdU6RIMAYVyZZxART5pD9izihT6AtMwqlGmE5R?=
 =?us-ascii?Q?coTWSC7/TxNGsgpDS8hBDxxAlAvrQWaVjH3Wp59SxYI9CMzGJNtEyTz1kPu+?=
 =?us-ascii?Q?oJXAVe8dw9q2b+4YDxNHEGkkS1xF5Qykg5tCBQrHo/3f3BuRs2P42Zyp5krx?=
 =?us-ascii?Q?84qhw0v3z8btMRj1TlS2BIpx0Lda6l4YaR5Lff7HohdjyL2N2P9uo768RVRl?=
 =?us-ascii?Q?7SjqOsH1n8QW7gjhUjfmtUSxGUHkbF9WslxiD3drNtrLYCgx9B+d80otdMxL?=
 =?us-ascii?Q?CdEMXxwi/avzTrQMSFurVEvHrW8hJ52BQ2xpz94KlnTsZa0ik2CiH+hEjw3s?=
 =?us-ascii?Q?uIONZnbvknCTnoj7imH1TGZVSD9s1GBPbXTBKONW90htsxVr8zf5NA5PRb+0?=
 =?us-ascii?Q?0CuGKuBGmEhZLXtkMI1cbPuORAW8aBU4bVbLP/QjXrhLEsCF2upEJPpdsx6Y?=
 =?us-ascii?Q?wxLvO6rbfwJZ66K7b0m/yP1oMFFcjSeGREchP9VhtI8lOpYiEkFgaStpo+lT?=
 =?us-ascii?Q?uzX7WFQUn/xCHxqyrMOAOphP1LkBQpP+2Q9WlPT1/V0lt/+ZdshI4oR48NW6?=
 =?us-ascii?Q?hBIhfrHIR1tfonMZS5M8BgzRxElAR26djU+TNPcWvtRDLaG+Q4rlGPmisZkN?=
 =?us-ascii?Q?JTINiU0TGuyrYNiGldB9XdYmX4EVN0pfGstM95/fPxiTKzaOJkI95Kue5DGg?=
 =?us-ascii?Q?VOqaSeoO6OvNXEWyhY14jZQ8NWA0hFP2UGSkJ7Lsq8+Hp/rWevBD9Ob84Ns+?=
 =?us-ascii?Q?ZTTzLTgHk6GmxIENk0xY8k1Dm6ieZCA0LyvGS3pqvuCrqHJ5oiDklPqfpu1m?=
 =?us-ascii?Q?+BdXg2r3lGtdKIEtsr80dbOGqJl5yE69rY3ZbrKX+SsFlyQZ9r+VhrjjhKad?=
 =?us-ascii?Q?I235PdVWaYK8cOcRMmKBJkUqrviBH4bBrjJZzsHwJbH2IUlEcv2obiVNUrdt?=
 =?us-ascii?Q?42ApJf3mTBuxml7aIHXBJHJ9fC5SKGSvEC7L9ahq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb0b879-3b7a-4e59-ad18-08d9f243eb3d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 18:32:57.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jcs65jw+AHAlcRbS5CBD1oj2hd1w6BfO4+uwL1c8LJCpbbgfZrkhfpry4Ln82ZEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1634
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LvFbYs6h_ER1-sGxycKdp2QBrPniDbLc
X-Proofpoint-ORIG-GUID: LvFbYs6h_ER1-sGxycKdp2QBrPniDbLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_07,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170085
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 10:02:10AM -0800, Yucong Sun wrote:
> Initialize obj to null and skip closing if null.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> index baf53c23c08d..7211243a22c3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -861,7 +861,7 @@ static void run_core_reloc_tests(bool use_btfgen)
>  	struct bpf_link *link = NULL;
>  	struct bpf_map *data_map;
>  	struct bpf_program *prog;
> -	struct bpf_object *obj;
> +	struct bpf_object *obj = NULL;
>  	uint64_t my_pid_tgid;
>  	struct data *data;
>  	void *mmap_data = NULL;
> @@ -992,7 +992,8 @@ static void run_core_reloc_tests(bool use_btfgen)
>  		remove(btf_file);
>  		bpf_link__destroy(link);
>  		link = NULL;
> -		bpf_object__close(obj);
> +		if (obj)
> +			bpf_object__close(obj);
Should it be:
		bpf_object__close(obj);
		obj = NULL:

>  	}
>  }
>  
> -- 
> 2.30.2
> 
