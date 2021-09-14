Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2940B5F7
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhINRek (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:34:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231816AbhINRe2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:34:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG1e9r002012;
        Tue, 14 Sep 2021 10:32:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XGolDWNsSxGN9e2DgietBuM+TGkmoirnYFuINMj/5fw=;
 b=qWlL3AXoHTKAiB+HJbWjkb4mDvt+jLiggzhMh9dQ0hKu+qrJiCfmVPkrNGxiP88XDTf2
 WzhPt09cxAlTckE9KtmteaF0ej7emyFNBQ18YKzUe3217NZrVHPZ9k/VsP4KnDy0+/Bf
 fY9S8D4CURTfV6FV5CqexnXR5C/GjB7P/pM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b2uq0j12x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:32:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwPbA+6GifbwTHNJBiZ5QI4FEH6DNFi6IV8VOOYI+Xp1Y31XbH73MMpUkwZVCcexkyJpS0SLAi5FPxg21y3P1Ph4piuur6zLiJ1b6ea007Zd0R/yMlrfoqiMYFsq0CzEbbPq3dt7fYVs7DuHuBZakkA1xqJ2JsvCvY9p9fQSNlZSdqc7WzBIP3bkCRvVyAhOr7DUiHv1FMhZ25K7U0oaCu228QzBLQqchBFfd0ZCpdMtzRpc3edCEpmBz3DUQKhZa1DE5uf+aQKdvln1LhU2V+OoSbRjp6wCVXg1Md4pr/d7OLOVYg6u8byhAIvdgWuorN+A5gUZnBnjYgSkvTVTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XGolDWNsSxGN9e2DgietBuM+TGkmoirnYFuINMj/5fw=;
 b=iYBQRz7LSgqjly+FpvOmmKHoLVbp3nZhtS6lpfZoAIA9iY2jnOzbrzk/Vdcw9mwQMFFe0PyVV2A6TInKeGHfHnlFN9K7aJO2zoieyvs7How4WwYP2aI+22PoxIbAercfilCjc0ICIoSSR6zNnFNTEhENbkc3VusylgRMd7R9wIE5tUeCFC6aVPyYrnCV37L0MIYboQkwZu5XKuNnKBcCEY5haRd5iKrioR9ZQGfQa5fj7g2PYt8Oz6Sw8sHvd0/7L+jyyTmpXY8ITBrlBGIA2noSdH8+cXeU+2jQLuPU52M0g9xvncoEDXkVjxcNMxsy5tfTkFFseuZ2aud1vaeE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB2096.namprd15.prod.outlook.com (2603:10b6:805:9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 17:32:58 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:32:58 +0000
Date:   Tue, 14 Sep 2021 10:32:53 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/4] libbpf: minimize explicit iterator of
 section definition array
Message-ID: <20210914173253.kmwc6vva6mln5vu7@kafai-mbp>
References: <20210914014733.2768-1-andrii@kernel.org>
 <20210914014733.2768-5-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210914014733.2768-5-andrii@kernel.org>
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c091:480::1:c86c) by MN2PR19CA0037.namprd19.prod.outlook.com (2603:10b6:208:19b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 17:32:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78278daf-4b7e-4488-f6a0-08d977a5b152
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB209667BAFADD98A9FDD718DDD5DA9@SN6PR1501MB2096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMNRlI/NjbpSwmWMW4c8ei5sRtvSaYKwhD8RnadobAHsYKkAiRpZ5bfWjNMCDiRd6XO1K5q5/uxSh+Ysf5M+l6zbWihz1aF7qEALxFQdZGYOEiYgCWnU9B3Q/UzjG7H7ELfjoET+AG/nTHnWps2/L3eFuZVBzhaB4TBKp1wSqZiV5Yr+moDGCNfqVKVY5Jdhua1zBgmDXMIvoETbv+MRU3nAtTLlbGamSrL4kKWQ7yD4nRRpd60l0lXuo7prlMESOYRTuaG2K29OUm8oG8nJFihamR2cB2Mht6HeMAo7rqT/b0TRKyQ4LjC/NpU2kAQcur3pDCaWBLEqUSmsjkpjKCiJG05/QC04EELkCLy84UrgRQc367niy6Uc9Vvsh9spNDUsLUywIj8VBBIj2pDi/CFnChtYJbACRQ0WTH13Vglk9UOi1tbWsOujC2qCjXbpFn7BwRRqryVBqt2U9K4K4S05JCo8QkbKfashcw0T3qhFgdymTiTYoj99aSYf3FtQQhXNdo4eOyian3tO7swEFDjyj5gx/HtrFv5N3wClSFeChqUKwfTkioSeywqnAOumoXcFcb/PSmSIsNUm2mEcI6jDeWJwKn8qgi7oOPh/hsqZYDPdW38mRvftbXfJXw5RDZeIdYkn8Lpss64pDbLcjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(478600001)(8936002)(2906002)(66476007)(86362001)(55016002)(66556008)(4326008)(66946007)(1076003)(316002)(6916009)(9686003)(186003)(5660300002)(52116002)(6496006)(33716001)(4744005)(38100700002)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5NJjg7vpqW+gzAnvFf6nudS0TX/1GBZK7IVnuwPBX2W9+79f9IxdBMsftrZq?=
 =?us-ascii?Q?sG0KWIqLLtk8T/9jjHTKAp5dFy4r2xc77nJ+kK5hYsrRxEsEc97NKpCEuJ0E?=
 =?us-ascii?Q?jKk3erQrNiqgHNoGFctDEUoM8MjHIbE+mAcoDoVgC8HDRWS9AKxZtvXtgkH3?=
 =?us-ascii?Q?hkEjhCH+jfCgM4LGiSwfENQpITV6myWCRH+r6K6+o8ZsjdXfFarGLjwAloIj?=
 =?us-ascii?Q?NfHnLHZcrZJ1iMruIcTyedM4R6YNBkbnNINjMrEuCeY9PRlUPvrpo43R+g3a?=
 =?us-ascii?Q?HJXZ97Wc88mpFUeMpz/WzQhotKiALmGDWRU2IOHuttVZ06fzxce8UqyS2I54?=
 =?us-ascii?Q?L5tFrmwFtgYVyt5bwWxI7hLgvKcJfg01IocBrqRCtstaNVN0RVkAoR4Grxpg?=
 =?us-ascii?Q?GaYKJBFU92iLE2whjr/x3Oey6lq3Fu0rBMt8sHGTfmJgiRZ9Fk9stPNaDC2y?=
 =?us-ascii?Q?WLtdtfh9gNtoTvIVmLrTA2j56rhwGd72TOncb2uxySAqMheSgLEPY8Vutagg?=
 =?us-ascii?Q?wF9G2uCrKZlPwbERUAesODe5KgF1VK2dqWPYeE+L5iPtCNhlxWlxhfyflIoN?=
 =?us-ascii?Q?wck5IRfwRVpjw55GJdty4jZfV0bf3dCmleT3ALN83HSAt+w8U8y1S4whGFEQ?=
 =?us-ascii?Q?4yCU71IVzRxWySdo7LT5iWVkT3d4qwKtENAK9vhjWEjYFzCRlF8XUhkm4KKs?=
 =?us-ascii?Q?heSMCbJ+cjFRoQgx7125Zbha4I/UVgx+88MVNB4m8Y61ory7m+UbPIiWcE5r?=
 =?us-ascii?Q?fY/k18PSZtoEbrrAK+J9487Bkyl2AUd/Ghm3VAyuhrJ3cTz6uy1vHWxLP+ml?=
 =?us-ascii?Q?FVBukijT+gBtIDLXnD40zQWwIbRhE1geR3fos99D+L2jIN89dqDuyIeZoldz?=
 =?us-ascii?Q?q/m/Pvwt552iZsBmdHpb+bXQyhvw0XuaQ4vZB/jMgZLNpYGH5dKzebehRCON?=
 =?us-ascii?Q?3vk59Egy6t1+eQhMEH7F0B5l2XUxzkeYsCDQOkAMJnaL16GkLI+zfZdR9Kd5?=
 =?us-ascii?Q?Su7j46wnRxKRR8rDX8NbGJBp85sfptRyqANzBheYmFeLZII6AkbsqvsRv6f2?=
 =?us-ascii?Q?83k0mjdYYZNjLdfX80FeYb4HZTJ/STjz45NfTeuJDh9fJhbblSqq0i+6B3/q?=
 =?us-ascii?Q?KxFfdLKIP6Zy3KAkHKiPtISqjor1++vv3X+GYtqvhj2ZqvYsIK84zdE4mSUy?=
 =?us-ascii?Q?Mfdzd5bfwPkflzM2/vZS87KzHv5vkaE9GfQ+R0M3ONuUBvRJCj2N5+XG1Y9J?=
 =?us-ascii?Q?TSluWvKJE2T5r2HkpoDVM0H+1PWu/DrdysnashNZrh/GOHIl+7B6W8wzlY2+?=
 =?us-ascii?Q?JU5d1BQBLugrTvDLyoZDWQkNa04hWov5rmmbZyFlPTzyFw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78278daf-4b7e-4488-f6a0-08d977a5b152
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:32:57.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YA6FnsiPHGLq0I+mTXYJCHv1lrippm+oo7MEKhFtYWkxiGBZg/XU7MHcvdILesZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2096
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: YLPOPKIShzZzj6HENKNYo3U-TaT7qS1V
X-Proofpoint-GUID: YLPOPKIShzZzj6HENKNYo3U-TaT7qS1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=713
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:33PM -0700, Andrii Nakryiko wrote:
> Remove almost all the code that explicitly iterated BPF program section
> definitions in favor of using find_sec_def(). The only remaining user of
> section_defs is libbpf_get_type_names that has to iterate all of them to
> construct its result.
> 
> Having one internal API entry point for section definitions will
> simplify further refactorings around libbpf's program section
> definitions parsing.
Acked-by: Martin KaFai Lau <kafai@fb.com>
