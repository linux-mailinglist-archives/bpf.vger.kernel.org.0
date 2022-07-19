Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A557A52D
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiGSR1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGSR1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:27:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8749B46;
        Tue, 19 Jul 2022 10:27:03 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDRbpY001088;
        Tue, 19 Jul 2022 10:26:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mdCYXKOhSudUBOaRwgCNNUjOrhBCe8zcuwqMj3BvhyI=;
 b=feKfc9VrEqetYXa5d8OopGlfkEHXUO16cw7R4UzjYEoRmxFB66Ruw81LRRf0ubRYXmxA
 eJK1kDJt8zy/8UuYLacFmsMyWeN1U0UP3hLJ2N/wAyoGMYoQGSFkGjCB58rfQtsb1bcI
 XSzLJXsKyfpmj559iAaENvo4KFNCIcDfQTQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hd7exh8r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 10:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV9aZ3iIQuNaFvoel0K7wQp2yZrUSJdqi9SxtBTzAd42ANkUgkfad/lCH+W66/DRvO1/M4/RZBi7+JOK0ifrmkkipdmWwa8/MK/qVjuCkxgKLWD3SbxldZqBI+9B7dGKAloYHOTsNmwaT9OmlzHQfZZieigSgzCEZI9jDDXzN0pN7qJ1cEd+HReQZj9vlOcZv+GuKxoBQM08gFxX7cWes0Z/GnPNz+fnu/BOi7KyZluz4t+2kWRvFyYED6MMqRBSzGGJe3tzkx6V+xKUNxuO8DedVKQD+v3nlgixefBfTMQCY1UUOj6jH9qLqbv5cuG8w0rUtNllrApoaq7LkDOeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdCYXKOhSudUBOaRwgCNNUjOrhBCe8zcuwqMj3BvhyI=;
 b=meuJpU6LrhYQy50bahqnPkcghLiuDXux70w5rZWqZjGwXJGuvraEsW5xnNcKg13jaUIYVqmylu7CZ+Cvc0TJ5Edakgbv554PqZVnroyccv5+fEm+PKYRXD5qV1okqXEpznqcxQmwVW+EPLSI+o3Tp0RE/BYw2mQcA/k1Gyc5O+pga8h/CVwSZr2V5Hd9SDuh6JXBSIVFzGe3tupfjGjhjuk+UqfKrpNM2EP3YJGaa0OuDwcGmaMyinHmtNDyn+rdpNUdskua/96FPfoDBgLT5KXc/WZjAat54BWl+0b3MfIszcY0JPjjuZPqU1eyE98/X0BGk2hdvUEPN4n5ia8hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MW2PR1501MB2155.namprd15.prod.outlook.com (2603:10b6:302:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 17:26:42 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:26:42 +0000
Date:   Tue, 19 Jul 2022 10:26:40 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix sign expansion bug in
 btf_dump_get_enum_value()
Message-ID: <20220719172640.pfbsfhdgmzn76kos@kafai-mbp.dhcp.thefacebook.com>
References: <YtZ+LpgPADm7BeEd@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZ+LpgPADm7BeEd@kili>
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f756da7f-69ab-445b-3f82-08da69abd895
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2155:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KROWcRGG75j3QwawHh+6acEmgj7mbjeJKACx1gfh+9HOm9oSTV895iw3EN/9dKWRNyQYt/RK/Y4uYOnlA1fmF40ez1XVlZgepdJlWWTbKOliQtjpy3E1za9B2ND/sE5SowWWQMrb12+O0uRkoMLnHVyDTisNELpUomOv7RjTV99VwB8qCp05Wf+MUmoVpb1SOvQ9hIj2t7ZTNOuNkuNYpmXalj1yVpLEm0NWETnzopSgCWJqXVKHWIkpw0/H48x+c+dV13KI4LK1ppzXsbOPFUz8DkMs7nYAqU14fgbPOXy/uG+eHCtsSMN0nixZ3qHqDSJK2OGOvWuys++43q2uBJJGfdn7zCbsQszkcZtFsvq/JPSfZTh3sAWTIsAQKxpnEDlLbpE4xdUExMzXmhiXBq/SScDpgXyjFFLpJe7rdTGZdxVBwr45TShzMsdmras+YN6J7Q73Ir8AW3YBHlhyS5go5M/VUME2SUUP2rINo70LWWDSIQTXU0v7KSdAib47xzH6KeduRXwZA/haibi8Vb71zfPjoC926QMCiuv5NDlExPAHLqJHWmPqffdvT04t0NeL9LclayKMBrR1Z8K4oeMhAfwWPAuqFr+0jaqz8CognBrK/PL2SqWz/3NpiK8mo003HEczvGa0potrmmk2BqddTVFbj4hYC0JJXSk3zW6ssc6d2L6cSqyUDjdkzACqguQDSgMvdsztsIsBMuA18fyRKHc9kVShh48MYasubP/3ZuWc4J9TIQlGrX6YVY2V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(54906003)(52116002)(478600001)(6916009)(41300700001)(6506007)(9686003)(38100700002)(6486002)(2906002)(6512007)(8936002)(316002)(8676002)(66556008)(66946007)(66476007)(5660300002)(4326008)(7416002)(83380400001)(1076003)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SRj+jQtizF7AGUsT7uJamzsv2i3QRof67tnH7ab7NMurxLzKefKozB1PVvCn?=
 =?us-ascii?Q?LGIuWZTTtGc4Djlk9Z8a4AP3Yv0q1yzJvij7GKrYJnqvJeccS7l+fBZ0Cvfi?=
 =?us-ascii?Q?aQ2km8cm3gmR1VDTgA/3MsWEAqxL0Dv2vKZKudMTBOvL0+desxxeGyhaFH7t?=
 =?us-ascii?Q?qg9D+nrcDe057BUnuiKDRQGWMAobQgbEw0aJRKupTbvUoGU8IgNHAxlLtOfN?=
 =?us-ascii?Q?r+hTgrJhQgVTE2a+VrNPw65AqvKRW4PoRTSFYTdwIYXSfVjwoCCx8/2XM5+P?=
 =?us-ascii?Q?HgBD4FSj2sXcTBV7N490VdrsbFXbtXm4Q740u5Y0OW2JD/o2Euoeux2PNITQ?=
 =?us-ascii?Q?RlQU0/TlIXHluUoh48/MfaJZkrRQc44c6LkhQQnfR7cyJVCoC2MwQ/WYU2rj?=
 =?us-ascii?Q?va396xk8pKEJTbp0RYstcD+0ecNnZj+xpHxfHct133GK/9BqmKUxNwxvKvfh?=
 =?us-ascii?Q?RCD+SEfu3c1PxUfOf5ew2FIe3QhmImXVSbDS6AMcjlU7EwDCpeLYKMYgZXkJ?=
 =?us-ascii?Q?RRRQAN5A/mxT53gyEdoSMn1a9/Ogr4+l9Hvtfbj99/LDkcch2nNWK/jCOI2M?=
 =?us-ascii?Q?vSPy69WxcoWJS7Vfrxu8csiV+ZpYd1hKg80ajOm442oRHooNB5VJjUBoviCp?=
 =?us-ascii?Q?JgEf7rkYw8rB2Q/r/aG6YhmrXhyO7mazbaqbuD4XaCbNPr2s9M78efIE78fa?=
 =?us-ascii?Q?xWLjbY0Pf9gPf7MKHZptP6+HRxFDEF2lQbMnIzRFd+DLrNV2D1pp8RUYruby?=
 =?us-ascii?Q?K1b5sHKRs1OhXXfub96yeG/ZrBk9VsjidCkkNQb3IFrucZTEFNI0RifNHL2g?=
 =?us-ascii?Q?RBJKuKkPezZBiiKrZTKD6pR63dld4vTO39k/oNeJkdw/4rwiwupP2R8piflm?=
 =?us-ascii?Q?xpUMYJudR5nnUondCW/U3/fCJVC7bWu4medkYxm2t7g/mQXkOiDx3bcibFs/?=
 =?us-ascii?Q?qIzRiYQ3EzbmmSqDKoDpOlHHf1R5ZYxk062sCsKc6WrVl7TTsHIwr3pGFMCk?=
 =?us-ascii?Q?AL+E22IDujijx1JbkDLCDJEuoBN3FScPoNng8CvwT09e4OUgPpIAzwx7Iro0?=
 =?us-ascii?Q?Loz6COyP4l4fbjbGbu4YlgSJkrfb208wQG2XIjaiukGKcQRIDiMqqCIbhCnC?=
 =?us-ascii?Q?3DHt8Kku2jfT7jEiIwY9koc7UweVkO9YIOL4ZlyVO9/N/uqIRoPoxJs3KnOx?=
 =?us-ascii?Q?ZHkNMhPp0uxutfUq4+8Z08KND1oDNcuIF2xJ/n+TViuChJn27z68tTDr91+9?=
 =?us-ascii?Q?izDZM3d+767ljJOKZopFhad7wDLZqOAAr/y4pz+zsTByMcYnctdQJmUQPJTv?=
 =?us-ascii?Q?f0T19F2soSyygz+X5ILx0VuBKckdStxBOHh36hE327gfFGe7lOFpZ5Z/dNH7?=
 =?us-ascii?Q?U05ERDP4GFcQULIk3W2kD45NYGw6zTs0EyzZgS2hjGFBC6kzsTLCpLs12Gei?=
 =?us-ascii?Q?v9Ex6Y0i+/DqgIVJa55B+feDZZXpviC/eVVpymoQFW0D8AUOMlrxb55UcFGp?=
 =?us-ascii?Q?ak1WzK9J9HS19ZqI+UMtLEOcPfP4dhXwFnPea5x7VKnSZHkx1mE6ZT1F59nZ?=
 =?us-ascii?Q?cYgA4yecY1gFBGIN9IAbwrdNqe1ITT85fuD0VQYUk/Ab1kgAxxLWR2s6JQmS?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f756da7f-69ab-445b-3f82-08da69abd895
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:26:42.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHislnVEAFpx1AyyVZeuDQ6whWAL7k/yPKxbbAyBVuKJ0As0RKrN0OlV+kG9+L1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2155
X-Proofpoint-ORIG-GUID: XieBXoB_0egvUV79wPbXvkzVAQQfnugd
X-Proofpoint-GUID: XieBXoB_0egvUV79wPbXvkzVAQQfnugd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:49:34PM +0300, Dan Carpenter wrote:
> The code here is supposed to take a signed int and store it in a
> signed long long.  Unfortunately, the way that the type promotion works
> with this conditional statement is that it takes a signed int, type
> promotes it to a __u32, and then stores that as a signed long long.
> The result is never negative.
> 
> Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  tools/lib/bpf/btf_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 400e84fd0578..627edb5bb6de 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2045,7 +2045,7 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
>  		*value = *(__s64 *)data;
>  		return 0;
>  	case 4:
> -		*value = is_signed ? *(__s32 *)data : *(__u32 *)data;
> +		*value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
Only case 4 has issues and what does the standard say ?

Do you have a sample dump to debug this that can be pasted in the commit log?

>  		return 0;
>  	case 2:
>  		*value = is_signed ? *(__s16 *)data : *(__u16 *)data;
> -- 
> 2.35.1
> 
