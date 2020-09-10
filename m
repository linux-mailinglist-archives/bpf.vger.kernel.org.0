Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B158264B4B
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIJRab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:30:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727819AbgIJR3T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 13:29:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AHStsY004018;
        Thu, 10 Sep 2020 10:29:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7lNaQ1uRbwDj6oKmiXY4yfg7WhjjUYYkje8RUL3iFag=;
 b=XSq76U6Ylc/yudkNz9eEnsCixn3fbAXgZyOUSDepU+aoTEEz/dNli5S1JfGGYN1s12Tm
 RvuC26bcE4v6v4CVlh/DZhGy1qCFFq8WwHBOnvutFuUUoCUp69SgIym9P7IZhIahHXLP
 y0UiHPNYOO7+Jg8HEwPiAN3q1trwngc9A0I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctxneh9a-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 10:29:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 10:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIxXU9NvCERJAAr3CX2oyJTmQD52S70yA7afvT4gVFdeFUsUCceq0xMa8v7UZjLHmgkObm7vPWsl6oCfOHnEl/PhaeZtRhJTsP8nNnAHFpuSMowzlbSMySAIAx/GMTTwtFiamoHkMW6/7s9xMq29h/ssb7CUl1YK0DpLB1be5oY21RiPaDCpYCwPZjWI/UF1jwWjF6M4TPRmeCjo0R4ydUFl/Zt7z7JiUjsswpG1A0Qa5mlo7a0/3cAdJ6Je28PnTC+jvBb8XdPWksot9xFdSOkSqTaHWS4dr59EOSw/q3DtbsbvILAPu2dmAG0hfxs0bg1fPwjFHqfWdTsh9CyoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lNaQ1uRbwDj6oKmiXY4yfg7WhjjUYYkje8RUL3iFag=;
 b=OPfvJKz6K/cnlNn2lf154iIsApsZWEFV9+ohe1BR1bBo2Dt9WIiPk8EObyHuj6BTGqEcahkwGojhiB2cKy0toTAwNVt1O4bRfwDsXoE42m8Tgdfa73wZtKIAB4ELiDGIshYYzrseBGXR3cG8+86q0dQDxGhQqlEN5sajIsKlz23FEXW8VrgN0Aj1AEj3iF//olJDdaEr41TNVluuodN0qQHZsJf3jAn4CcBeXr5mS8QzIzg8u8hivTzcP55nfYFMivQMmrSx3IHB/0UpuNom3bWF7pxcOVL8Z2beAPDhcAMvAo7AivseZUSD9NhWwAfK/DMcHy7qpyfaEloRy12VsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lNaQ1uRbwDj6oKmiXY4yfg7WhjjUYYkje8RUL3iFag=;
 b=E7GofWAHOukFiv3mgIFHJr5ssUjzetMHGuwYTXQjvfCqjlEIgC+VLFckA6nvr0FCr7iB3F0PJmty+d2NAG6mXDdBl2ZkP+9Pl/ZZ4I2k9/9eutuFqujhD7G5alAGMfpQEi2aC/WWcSGlN13ouxzgGW5EydswpYR5JM2culdL2cE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2245.namprd15.prod.outlook.com (2603:10b6:a02:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 17:28:57 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:28:57 +0000
Date:   Thu, 10 Sep 2020 10:28:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 03/11] btf: Add BTF_ID_LIST_SINGLE macro
Message-ID: <20200910172851.vpteyduzdhgrle4a@kafai-mbp>
References: <20200910125631.225188-1-lmb@cloudflare.com>
 <20200910125631.225188-4-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910125631.225188-4-lmb@cloudflare.com>
X-ClientProxiedBy: CO1PR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:101:20::12) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:f5ef) by CO1PR15CA0068.namprd15.prod.outlook.com (2603:10b6:101:20::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 17:28:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:f5ef]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0281bd04-d6bd-49f8-4e92-08d855aeff36
X-MS-TrafficTypeDiagnostic: BYAPR15MB2245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2245D05264A59E40E4188E44D5270@BYAPR15MB2245.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R27SqHS9rc7h8JP/OJGRYR8ThcFtCzltTUBZn0j8ErQ3FB6eVq8QBU3D8TZ8D+7EocWa0J0JbrKzaPYC4dKukX1Y9fcfx0Y/3ozmKrbo//IKup4YEFFL/BmzZa1sn8U+zLmRUcvlj0vu64LwWld0qdsoUVLlKJO+7t70hT9YMITGNzPlm21yrEi5vHP0k4crdL8bcxuJFSj39g/y0pMGvoZZJHSPeSaBYVV26/IGXrGg/wcaIAp1w59nACFpyxLh54q/bv+Y+fQYFfZody+vZc9RkNJ1jQxcpVVEn5YIIOhr5p4iaG1HD2egUdXKd6yFHxgWTbi3aQuoB3b9FPTLPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(5660300002)(6666004)(1076003)(316002)(6916009)(33716001)(52116002)(558084003)(6496006)(16526019)(186003)(8936002)(478600001)(8676002)(4326008)(66476007)(66556008)(66946007)(86362001)(55016002)(2906002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: z4TGM9e2EZUagjgUnCq5Ie98e86IujvXzGWmJG7oqMrCdiRluOJeQ/JxcGQPt1t94Wrb4ZGJDOqhaFrYAfrk+Z6SmEt+OWTlQaTGfyQFnwmGy6hacKkCUTkzZYZNDSgu47csw11dn6OMgBT0jttYI0NKJTJL6FXmF+JxfuLSNVh3UaUUklzrzRTBVYCcUjy/GTKoMn6RzJMlF4XMvRjjOIp2gpWHTJjjbKzpHjoBflzcAjYqa7quetCjNTMYvqRIHNqcmrvvKtia2KUMGzsuDyaQt2MJ3sA1vKhqtIiKf0TfcaJ0LmDWfcSr/pV48DqAOWMiM4qG93OOqrPOoX6PzK4vrQL6OI8NUpHL+IXnDOz3nKty2IonHmaTGtYxjXPNWafQyCsmkWTBMljFkbhhjr55nPYjVL14eUSoTJY+3MgXP07QnPCANpWskftSiN2jJgVNancO8TSodts+D7pcErnNYSwOHqdNJK1UcGMbkb7vOv24TYuINkluZfnkl4IYrE6AoMcURltD75pxzZ9ZE0TSd0rsJtRPnQJL5W41QUzzt4u1uHQkNDCG8I3/JR1khMxgXbZLZx3TqL+wOnGAb5I1tsE9SfbU2wKOHl7VlK9qxnQNJ63GxVCKy9rq5fxUG262vgrHBiMTwhl4XU/2ZuuYFfLNa5Fm1Iyan75PLfM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0281bd04-d6bd-49f8-4e92-08d855aeff36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 17:28:57.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSmLiskQTVuP2Vy5mFEPmrR/gz1TRjFCFbS9CAH7BF2ulJPHrC5vFoOZ8PvTxRAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=811
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=1 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100162
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 01:56:23PM +0100, Lorenz Bauer wrote:
> Add a convenience macro that allows defining a BTF ID list with
> a single item. This lets us cut down on repetitive macros.
Acked-by: Martin KaFai Lau <kafai@fb.com>
