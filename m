Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D398056061D
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiF2Qoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiF2Qoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:44:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBF2F3A4
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 09:44:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T7FICk020298;
        Wed, 29 Jun 2022 09:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6dB6zJgchQWNiwBIy0PTgEzsQss10L8yOD0OglcsZIw=;
 b=VoCetRg+iGVR6g66EIRxoqwzv32WSrqhppfU0VOPktyZ64cwGpFlCmDbcu88xCM/EJF1
 dR/Nf2THF923gE/6rU3Sh+7jHEZLi/H8DW8tO7WM7rpnsZNFIUn1R9HTmkmT26Gp/cEw
 HkCVyNzXhqj+FH1NP36C4UAcFpEh1aw+eCk= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gyytujeyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 09:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIXKt4LZMGY/+3fSD2KCTsVR3DyDsB22Z46gE+w/l9Kb0VpUFE4CXRZJ+hLxM4FPH6KcxinuAAttIVAzBBSs0luA7auBTESfvvyPbrt6uwYYtz5yj5+hdvPQ1m8BsX1pREdOCraIN8zglZKMiVHtk+NUX0IiK7WmTfFjNeyZe5Ihgb8W2bDhblSQm/jES6qTsKRLBmMzGfQob8LZW2ByKa06QFXxlDAUXUMUxQwk379ZSY9m+D59JiBpTX/Ih+2igrmDQ/0Cm/cYfYIQ0xT7fYFmr9hJ9EuFf6mfktow5uBDjND3sSV43JDwCorjW2ZEsoFqXl0ZmvuiNM2YNQ7Ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dB6zJgchQWNiwBIy0PTgEzsQss10L8yOD0OglcsZIw=;
 b=CtHEAPx5Z+Hddx+U7zonbLXIrHUJZc+JH7/vT2uzzftJ7adcV1hgfnVcaeZdbT15IxzA7DMkVwnXxso6zaiFCg38NE1C/MW8iXGSICoMRY2fJ+gLovzvdWJSQI/a6hCJBh4SSW4znZuul2RWMjQgXLC27aXM5egHQ3x8L2wkyVKo5VBUoMR3vt3BrYXwXzhIpBAcdXLLSkzSL/rhoiLYLmLAnkdmBFxGErYXX6MEMfUvdXSsDLksplrnjh9dgocf0GZ+ea1tEmOTPzLw4Ymi/w0ME9SSV3JZtMsy14+ddmEX8AzPQm0jlf9fEpGUZcAsa0wS/JqkL7YETCf6wWxe9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB2309.namprd15.prod.outlook.com (2603:10b6:a02:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:44:23 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 16:44:23 +0000
Date:   Wed, 29 Jun 2022 09:44:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional
 test
Message-ID: <20220629164421.tfot4xktwbs7pv6k@kafai-mbp.dhcp.thefacebook.com>
References: <20220628174314.1216643-1-sdf@google.com>
 <20220628174314.1216643-12-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628174314.1216643-12-sdf@google.com>
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea76b3a-d317-478c-7d92-08da59ee9f43
X-MS-TrafficTypeDiagnostic: BYAPR15MB2309:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55pJVa+C3RlHvcfP9VTpju9Fg58+Wc2NAKiyoOA39WvByvHMsCj3NMwsKSQC+a/RPAUNaFULViBqQdiM1aT50KibaPBhf79pXRIXnWzHeK8iG247ouxJckL389HL/OYW9DgZVPmSb02FXpFZv1+7FnQ2Q2+gG02YlHFB6vZrjX9jUopT4nIqcAyL8DKPXmzSSJXxiD7Mea6jRZluyDrDZpBogWsFa3vf4/PaXP/vOOLVok3BcEn/5il1URtiwElFNQmngOZoPbUwSJuCdLHWXY7AAWNsUHRE5tsoSIviB7xLE/EtHMKg2sxJm+wTQla62KjKxbJy0PYqM6ib6DmH+CEnSvNYEYA4LzOKEWXHu5UCnwnTJtz1OBk0q7w3r3RRhkKadmUKGP9iQ5A/X6wPDRuixOwMRfiveS7gZV/a3aZRM2wWzDbB9AnDFC0OGqcts6pJDQd38RPpldSgPHPIX5d9DZwmoRsV75Fe7z3lL6SQN/lGh5bmRRkYy8Ft4KRazMWj6qPMlFwVePaqsqgZEc4pEfo3L8FZM1nMyF5HQaBCx9d9rUASJyPPva3R3XgPxNU2fMuxqncnebVFfx5nBHfiXRwpV1T0fg/6HtJIKFlFKMLuyBi4IRXhHUuNb+ZIfnFyAgt1b44gJZfYsIldBy5nmWvznGYC3C8l1dMibaTSV3PyinIySUZZEcZSxVGLE3RCvAAVjUIfgA0/y55vZAOIk0ZB8C9B34WjoFXMTNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(52116002)(6916009)(8676002)(1076003)(478600001)(186003)(66946007)(9686003)(6506007)(86362001)(6512007)(66556008)(38100700002)(4326008)(558084003)(7416002)(5660300002)(316002)(66476007)(2906002)(6486002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cM0HWTsxhT+YqfdSkoD0uOkjH7LN84QpntBbWWgFgEnRSKq8Bh8VTTaHWDt0?=
 =?us-ascii?Q?AmcBkEjHam/vGfGnB+SowZYH/KRaNvtdh9peJRRTJipZsbIVkSwo88EixILt?=
 =?us-ascii?Q?3lzcjTrjVNh+2NphRCeiu9MbfCqf8tFJKMDcxpV961AsGOvKmpg58X8IpEsS?=
 =?us-ascii?Q?kJ9AaK7v9R076cCEhZpu23XCa4u/4pz5JXwX+MRVxyDGtMgn7fAJWm+ctgXD?=
 =?us-ascii?Q?9OHJdscO0oV5Lifdnkdo6etqSgjnyWv/MX6JE9p7BhAAWysUwpnuUSzjqh6j?=
 =?us-ascii?Q?AYoqe2L6x6B6DX4MXOxYpqVbV0QSFGkob+I14sbG+UgRbUQoS3Ql4HF8y1g7?=
 =?us-ascii?Q?mfkQcPyFvdE3M2kcn/5VCCqa5wJu853sNRidu+Rg5TLkSoqvcJeXOgtZ3UZH?=
 =?us-ascii?Q?aBi8lDkkrnVHIdU7p/gUfwwhyJLOSsoJQ1OZOkRgxSjGU7X4CIkUQQX5KGHl?=
 =?us-ascii?Q?KxewghxbgntQyeYU8y9Rs9FASmPYA+nNOlpc/prfPo0AZlvM4Gw/oh1pASU2?=
 =?us-ascii?Q?c6+tqA44A/2xiemKQHZH9oc2YkcneyXi9kqf3Kegoqpf2LcMgywVOQbij1FA?=
 =?us-ascii?Q?CU9p3503UWZ0/TpRFfWq+F9/5axKSzop0spG/fJ/VTkNKhKsS/aUwCZd4I6i?=
 =?us-ascii?Q?bkGvGNqRdhB/0l80CWMDzBkMoj6sxbDKEDPhrYGBosdfNo5K8de9ERwC9qSh?=
 =?us-ascii?Q?dUIWlJe7c0ordFyOZfQqQdMG/ZhYYGtOK3OpLQNqedf/9itibeCBn06LBi9l?=
 =?us-ascii?Q?xqxGemhyX6M9cCC413ms/LKWZtZwleiVjPfqYvSaZAmPttFRpOJePTrBc0VP?=
 =?us-ascii?Q?1JUgOeWWkhTHTlzUyCWHjbnVXrwZzhOegyCGr/287fSVplprAjrBfFN5mNqz?=
 =?us-ascii?Q?bmsoxOrjCZQx6fIfrxSnWBwZHEMa5yd1l9EjwDmdUUL7j0NpCH3+Av1xq8dd?=
 =?us-ascii?Q?uinLCH2jFIsEm4ustQluUJlGaGneHSJbYfeR+2Z7JOjrjPbB968gC2EJth1W?=
 =?us-ascii?Q?dfXSpjJ3/9YchIfZAGLjRlEuACpgqZuIIs85QuT0shpN6p7RrViRnA6h5TLx?=
 =?us-ascii?Q?QSd9daPMFFGw4fo5x8ojpkTFxDVqIIeJEguSdzujtgXdRFLIThrTjVxgVj2T?=
 =?us-ascii?Q?bYBzFNN+hH92qGQ53P8ZSg2X/P9GFEfvslH1cVsddhuAetBnjpNsb0rc6/wv?=
 =?us-ascii?Q?zX4lZnj50Qwyty/Y2WwqLkZ3ciiQznpPB4jGxpBvNwdQFQhVgEyx71mZjC1q?=
 =?us-ascii?Q?mGTTPWAZdYmKsOfyLiHmxD8sdyUJAsdSLlF+00hYMp9/ErT1JUh/qnzBos3W?=
 =?us-ascii?Q?/4XKDaCoS9oEFPzKyvIm1zqsAfqb8LPCpW6euCF0xW4OeWmysrYGi6a7Cjmd?=
 =?us-ascii?Q?QrzKJytkHRAZC28hB8JUhLCptepukdmXWJE1RnirFHV5eAVt5NAzHPaEm5v+?=
 =?us-ascii?Q?J75nhnoOUgL1wvgdIpdwxkYYnXt/CNijLgOevhRHN/ml/E3GR4d9AacrFqAM?=
 =?us-ascii?Q?g7O4+eHs88ueA+KlU5QtrSzOsCYE5R6SoT8Up1A2hv5FO4KKF8m5fJ7ZgDYV?=
 =?us-ascii?Q?bKBI1xO5dJ6O1fmQeU91oj0xmvpK+5kO5jU7yIY4CprNRUiFcoTsPV2mAVVL?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea76b3a-d317-478c-7d92-08da59ee9f43
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:44:23.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABuVgrIBf4+LWXRUmOG0amkuhyJUe7i4VCYxdLTDxhTwa7eg67NJp5LAzhbGw9K2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2309
X-Proofpoint-GUID: x_VGHvKTq0A7EIZ6cdCjEC_xPblp8JRa
X-Proofpoint-ORIG-GUID: x_VGHvKTq0A7EIZ6cdCjEC_xPblp8JRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 10:43:14AM -0700, Stanislav Fomichev wrote:
> Functional test that exercises the following:
> 
> 1. apply default sk_priority policy
> 2. permit TX-only AF_PACKET socket
> 3. cgroup attach/detach/replace
> 4. reusing trampoline shim
Acked-by: Martin KaFai Lau <kafai@fb.com>
