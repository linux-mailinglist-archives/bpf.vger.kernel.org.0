Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956058DFDD
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345320AbiHITHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiHITGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CEC10E
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:46:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279HqYB8017181;
        Tue, 9 Aug 2022 11:46:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Cdg+Sk9Vf7/RC0Q2uhowx7rrwV1V9QasHHXGKCjTkOM=;
 b=Gza77bCIv4Z6AGq4Iu4tDAEx0rxuyQ2sTijT+oWwpSNITEKRm5QRKPlKBVaRoWVcOWDR
 bRjqGSOeW43AJI+/rdU+87g7aFhpiFQQ4gUxqtkchm6UDhvEqJzAflx2lc63FTpo20qA
 /5MPJkAkWNiZUfFK2Vbf/FGkO+Ta8JIlmx8= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huagr7694-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 11:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsmiCZCg1b26/wocXe0Jg5OI/YUFxirbH0e7esefdYaVKGED3oibFzdR9uYniHXsIBHs85ZzshIuF8gccK10kl4H7JeZ7ayA75kmM5n5c0PL9krZKwRiuISA/t6u+VS01NRoeq5lYPAPxqBW2xozK5cs/NrxIEupbSmSae48ciGadNm3gWMHKnZjS5rhMODCckXYpymImAqlc13Zy7Z+rrffaIuuEAZQh1Tl8P9ABLZSJgCkmvC0TMr9bJwgya6JKedM/QBdaHnw4xmognGgUSMy21xI5mOE6zudcxyV2WkRRQ0Ti3koKkMLig5yBUVls8VLtwcdX8Av0l5bUAzHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdg+Sk9Vf7/RC0Q2uhowx7rrwV1V9QasHHXGKCjTkOM=;
 b=Q8PZmtqJog3R7LMkL+6dkgYph47DF3PI39O7+agLYsxO6Ua/9rTM0i304SrGDX39hMwmT/OXb7iuplsnrJa6r/BZzelb6zu8BCAk+IC2D7RYrIxel/DAVF5PDlL9JWuu12H5jDXABMCGYUnA+rYw3g83jkrWMpLxy9O9tqHvqaczR6TnqofhbrGD/mO5Et/jYUXUT2iB9Ss/Yf32rhDJrxgLybGFjtRP4QQg663a+texiqxSgQj3m2oN7FuLUZmZ8r2rpC+Sc7iqgpmjnJVQ1q5Bj5UP++89qBaS5BfFiorks7rY1RSUaMdYwJ1VDiPsdw1NgbKqwYuy5vFyil1Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17)
 by BN6PR15MB1475.namprd15.prod.outlook.com (2603:10b6:404:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 18:46:05 +0000
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a]) by SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 18:46:03 +0000
Date:   Tue, 9 Aug 2022 11:46:02 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf 5/9] bpf: Check the validity of max_rdwr_access for
 sk storage map iterator
Message-ID: <20220809184602.equlp2thcs2j4774@kafai-mbp>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-6-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806074019.2756957-6-houtao@huaweicloud.com>
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To SJ0PR15MB4472.namprd15.prod.outlook.com
 (2603:10b6:a03:375::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f85153-1dbc-453d-d3a3-08da7a376922
X-MS-TrafficTypeDiagnostic: BN6PR15MB1475:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKNX5Jk/u+AxxLHzTCU3UWQ3cgY7SLwDFVqkeR38Nm6BUEl3WZGCptQnL7zCsJ9aT2vq7e+6m7X4h5cLD3mDJCWmLOfQVS8K/5B5afAmaf7/JL098OifH57r4+pUnmxRI7jk0iIFVqBqZXknvXdz0SKZXsCoWQvqGAXBmSGYA4JfVAqmCqyDfmOCCB3eM13E1pZHMqRbpyZk3tti3/X8PsuiN2XXgLmJvQlubFK1dkIDK0RBM31Zl3hnLHz9ubfhtkioi1r8ZrarzcEtM1P1vUeJBGXDJYX1TneJhEwYES5Oy0L9urTjdpq7zYoT0tNrlkdYm1w3s4IS7iLwf8E24+cSYvtOhg1X48SSqNF2MRMU+6XOiQcUYwxMw54X8G4hIh/n8INoZPAYwExdwhzmRe5/mMxGCPrGwCHMWcHgSgIp5ZBe4QhfC7VmCRuESJVIzQ9t4M5s9saaYK0Qa8vQkddicKfBlVAP+juZ+J8CsbvwjrE+0Ero3PHQjXMmRzCB6mBPbAXsx33M+qORbbPyYPfywttu10YcmaCG5iKShZmNXj6Ue3sP6TQ4x097AcpYXt3E2GS3lwIxp/70X8LOXv2P8lZhKchZgS+Jf/69US9qBUFaFF6/qHGdimri1U6ztF3mcdAwhrkFP730jsCOLr3FEMbDYg2xLYlOs1uplLvvJJjGrwlepeJazcc2hellA9DAczRTtYFhT/XauFrfsvz856NlHhuvF5ta117ClG3T2FbLHt7Jfw21NDc2prbl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4472.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(8936002)(66476007)(66556008)(4326008)(66946007)(8676002)(5660300002)(2906002)(7416002)(4744005)(33716001)(38100700002)(478600001)(86362001)(41300700001)(6486002)(316002)(54906003)(6916009)(83380400001)(6506007)(9686003)(6512007)(52116002)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPs8NKdUlZxb7avEnei5KyiNz/M2Ce1cI7Nk7HtXsA30k9j6hVGrtV6gtkBA?=
 =?us-ascii?Q?U7do18+fAHDYcsB1POiUhyA7W1BAd1gsBwkNinoaTNAPN7ir11Ay4ad3/U1R?=
 =?us-ascii?Q?liFrNeE3JEvT+gi8lSlMcvCfjw6Kz0luXfAvJ3DR4RMN26V1liMYcs1kyGBi?=
 =?us-ascii?Q?NfbW+A99YjcLcoL3zvaMVVzpBFEHuD49DIRPtGZ8ij9S43g5kUT/C0m9xxA8?=
 =?us-ascii?Q?U/uE96nsZ3x5+lFwV0tQmeiLudKq8OPDt9UqVGl42vOb2VSMCkk1X9LBIRWD?=
 =?us-ascii?Q?t69sd2RbXbxhO99Z/pNOlrN0hogZchdQECroaq8faGt8sm/fytQ2zZ9Fgl3j?=
 =?us-ascii?Q?6sw0TMDgr429xwBpB2CCufpnd9BmCVAPKEd3ROQKdxYw9QHNU79LSKRUQRU4?=
 =?us-ascii?Q?P9WG0b/t6iutrloV4wGD6MIHk4Co0/J7SsbjDdjHtRQsJYBsRc4U22EACf49?=
 =?us-ascii?Q?gN3glrGC5aQz2zrTCcQeVxHsyBdXibl1KgAWkR+83h5ZqJTzXz0vEk/pLPoX?=
 =?us-ascii?Q?Y/EVXaU5uTC5d7LcQuvXmyRtAi2XrRLiTf/3VC6ZIoPcWfk4i0zzblZBs0Jy?=
 =?us-ascii?Q?6PVxv/xWWQGjq16jzByAxuuy+F7tN2A4znjgV+yXgKRasAs9W6OjQxSKuCdW?=
 =?us-ascii?Q?NWA7Lvg5l/Mb44L477xxjBLIn9G3HMhictqHYXrlysA/8ScS4eSOsRn3b192?=
 =?us-ascii?Q?Kj5Qb/HUO9w7+Vq5Uw/HPmadrtUtawcAGt0kcscNexJmBertdCbRqptyKPsV?=
 =?us-ascii?Q?IzHN65k7yriCvZjT10jytoehfc/u9/kYECq03hccjeWUp5MJvE8a1uOuODtH?=
 =?us-ascii?Q?nOFoVEa0N2TKdYG89Vo4Ux5QlEC19kg0V9eduoZjsZUlMpalm4g6vtVZ5a4R?=
 =?us-ascii?Q?PLuf/3U5DDP/LU8y1Aw9Sn22L1X7ZtmHvcCjxoaN25dugOFAWIfxyZ7w25tD?=
 =?us-ascii?Q?Vs6vrYTZZ5IkmSDp0ogLlYTw0XF+DMs4/2EkS9UgaOUh9Mj7ZeaLk3Pmyddl?=
 =?us-ascii?Q?4r5ro8srcbPboNo6rs0O26DugloK/QxU0CYmKosVrRkay2euwMpAtZv95gaO?=
 =?us-ascii?Q?WJkq2SE+afJcj9/Xayjhj/NQAXwkXJ1/BT4nCHJVeZxpT6Ns0aAkgSXgfT7z?=
 =?us-ascii?Q?LTCfrAsxgpullxKiQB7DFZEs8M7r9x/mlDTJQAcDKlWuyMZ2VKILce3kYeFk?=
 =?us-ascii?Q?nBKQxEoGGnGhqYDgeZRLivnho9Fo8CAnZOy9ED0ujY7hPOKyu4qXbRe77d+z?=
 =?us-ascii?Q?p0+MkzzFdXYbM2Baij10eBwzI8qCvjGuTdoMzEkS/8QNYlA/ijmy5ucuCe1v?=
 =?us-ascii?Q?SXJ2rlFd6ai/hu+TA/zMXQrfq9Elgj+sRgRYY9rcugPbavU2FEywfmc7ybSr?=
 =?us-ascii?Q?f7Z61TlKPltY8iDt5ER7ckc7TFVmRJ9BT7fGqj46kOUDZRVwyg50YZtPsbqr?=
 =?us-ascii?Q?x5g24GJg6d2Q1LMh2yzjURpVrOK9oXCLODwm6XEC9FhD9Ay2VjMlgcMX+H79?=
 =?us-ascii?Q?/3SU3tt9jF8H3JpsqFpGVPG7d51xfEUYA3NwKpm7YFGtkuttIw3P46bGASmG?=
 =?us-ascii?Q?9g1jMTUsaLPalMN2/NSCDJEUCpqhREm2DoCrLoAuOTWQ0FRsD1x0jEWgq9UC?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f85153-1dbc-453d-d3a3-08da7a376922
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4472.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 18:46:03.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+VpBG6iR5LDb9+EurWc4J5dm9T33GHI6FkBUC8di2eud9NIT6hp568txHXumOGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1475
X-Proofpoint-ORIG-GUID: hTNVFpCJgXUaKAsC1Tk04Mukxe2N2Lt4
X-Proofpoint-GUID: hTNVFpCJgXUaKAsC1Tk04Mukxe2N2Lt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 06, 2022 at 03:40:15PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The value of sock map is writable in map iterator, so check
Not a sock map.  It is a sk local storage map.

> max_rdwr_access instead of max_rdonly_access.
> 
> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  net/core/bpf_sk_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 83b89ba824d7..1b7f385643b4 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -904,7 +904,7 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
>  		goto put_map;
>  
> -	if (prog->aux->max_rdonly_access > map->value_size) {
> +	if (prog->aux->max_rdwr_access > map->value_size) {
>  		err = -EACCES;
>  		goto put_map;
>  	}
> -- 
> 2.29.2
> 
