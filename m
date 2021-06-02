Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528283991D6
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBRn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 13:43:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhFBRnZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 13:43:25 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152HdjZX027402;
        Wed, 2 Jun 2021 10:41:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=SHVcBhaErL0yaPp40aLYJcixphCmZH+bdYhJRuxiV0Q=;
 b=jLPkydO6+AV4UB11/II9EBKFj6RaMCPUa6aP83Z3Dt/ucMsKdJ7vNoIwvx63rD22jNrz
 0+AfllABX/CaDn5pZlSwS3jvuHq/Q4GoGtda46z0hvi7wkX8E7CUz8NC1UTXu7bamitp
 /OQYPCw7cPlG2LJaw/QnLNTMLxBc7dE8EV0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xedh02ub-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Jun 2021 10:41:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGnEpvATEEb8VC0njYie/iDarkqqsXTI2loXPXbFtJt7a+Ia7Zn91Dz6hk5OUQXPgyTXlIo9wOSMC88JRl9M1In1lNGhDGNBqorv71gY9BFy50w1LzWeaaUKZ6dxa7cQQCAzLpwcD94BsDH3f3uez6mgpFL4sMRYyxRI6AX56eNldFnE6ACYj1xwW50qpnsLlx75GvG6IcM7sMC2m6sVek3J7mm70/3e4uibn9b0Akifmjeogo565GiUageMC4PKCSXb559TsX+n118vuQRMIyjm/3muWo8DhzwUjI7lJQ0mVNsy1WrJh3CVp2K+1Trbq29smqef/V8njLaBIz0APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IsmnZdGaNxKb/g7/907YGrAteJAwuVfIAq2SAHsy3Q=;
 b=kkC+QeAfJbbL1+4zCsCxe4lj/7DAhnTXaCTVy7Yb6YIFugQDuZg3na9oekJxDm6ZZ+pTBbcjnjyab34huUWAXKUb6CiGvBq/gzMuYVKaHgm07awPKE7wibxPeBYIPQ/Fj3pAfpjbfPDtx9SZtxK6uilsjCLNC9tQXVrZvzsAZKu/T0fIrVGX6GpcvUbdhZNMbZGzsPZNqWO5WKo5z/3EP4eHN1M8EXErQ2jvd8AkKxFbtsOmVQTrLChpHNwki74aQiCvMMzQMxAz0RdsgwB8xbTohs0IHrFLwF7e5Ci51Y9ao1E4uBzMsmZCwCFKtK9Vs9O9/MK2+yf4MLmsFLuaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: rub.de; dkim=none (message not signed)
 header.d=none;rub.de; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2888.namprd15.prod.outlook.com (2603:10b6:a03:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 17:41:29 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 17:41:29 +0000
Date:   Wed, 2 Jun 2021 10:41:27 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Benedict Schlueter <Benedict.Schlueter@rub.de>
CC:     <bpf@vger.kernel.org>, <benedict.schlueter@ruhr-uni-bochum.de>
Subject: Re: fix u32 printf specifier
Message-ID: <20210602174127.55ny556mki3uv4tx@kafai-mbp>
References: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de>
X-Originating-IP: [2620:10d:c090:400::5:2ff0]
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:2ff0) by SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Wed, 2 Jun 2021 17:41:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9159905-dc84-4d83-9519-08d925eda703
X-MS-TrafficTypeDiagnostic: BYAPR15MB2888:
X-Microsoft-Antispam-PRVS: <BYAPR15MB288854777F4D62CB9C4044A6D53D9@BYAPR15MB2888.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbSFS4B1SlyuKwn0gHx4lLa9tjKS/RrNQ0CmF7KtVx1GAfp9vOpduH7Y967r3Kht3qS+ubkH5Y8LIHf0LViupIh2etkhnIzYzYaUbsGM0fcLAV9/7aYdv5yEryHkIewEZ9wM6l0TZ/7YMS8Yt8Sr5oWwlF1A2hf5R2WyesmM8qWsojrKxZu5BxJqMo5MvHvCyHeJp3/QznW0kIJUtAUC12qYiU9vEKzfe/KTV4bbcPzegPRp97RGWd+gmG7iDcBHtskas9eTj1iiF1pHeEkVreKfknH7xqnKhs1J1tEdY5sPqmU/tPJ/3r+uv4wczL42AFGCbdxjFiEAmXbfBRANraF2cpeait/rcN1/2LH+duR5XQCvYzpl7w75FhTtC7EIfECWknp2cT35GpKx087QMg/6Fv6LbxXWS0b05zDu+FVQu+ZSCpXC6mLBKsG/xJgXbi8mhMCkQt1XnMo/YItz/gvyiSYdUMLAAOJKgUTKLxIeqmG+TM01LZcgenwnqrB+8cp5at+mdVnMzpIl5oIvSgbPUMfjLrhFgrzxkn+T9uRARNfjDhhJgcwSODUEPcIEfcUzsNFR8tYfqZe4ALacCIRVubhslTcoyJ2AKwKCq7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(8936002)(66476007)(66946007)(33716001)(86362001)(8676002)(1076003)(9686003)(52116002)(83380400001)(6916009)(5660300002)(38100700002)(53546011)(2906002)(16526019)(55016002)(6496006)(4326008)(66556008)(186003)(316002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?Lw8euD8wDznOsE00eLJX4HX7mQ96LB9aw79GNfyV/tnwM1p+c4kthWFaYi?=
 =?iso-8859-1?Q?CT1kZtErxS9mXrRNsDlqxTQXaCd3ghMjOyaq71M+9f0ZC1BbPEowfbMuHr?=
 =?iso-8859-1?Q?E4L3IFctTJ7XEnVrFTGju3UqFnej5cLtUnyvfTcF0yqwsjLvSuy5B6qL/P?=
 =?iso-8859-1?Q?wNf8YY/XWhqk6JJbYpu3iBG0Z62swLggdIjqV6ClrYropVQaCVXvqtSMJe?=
 =?iso-8859-1?Q?ZtKddHcgBEbNeN2VdFJd5ppVhLGB8qcEr/sDqvruEReuE3qa4Zats32STG?=
 =?iso-8859-1?Q?9HHQeluAJFWvvI7f8UmkCxMLJt4k1kN9yQpaNZAufxkQRneoUGIw35RO22?=
 =?iso-8859-1?Q?9+nQDzxXMZpJ0uw5RWnXZxPBf/YDS6KcKyjBW1A4Yy/TceZ0Jdj+bIP6tJ?=
 =?iso-8859-1?Q?aqJIiob1s/QDcQPk4HyVUNGhEz02Yfc2UtWdrjxvoAOsWisNjKY30sq9B5?=
 =?iso-8859-1?Q?JTjIbXqW1kMscCr5LxULoIvZUTsUwWBcv1cHaWTr0y4iWZ/rUztMoJfoc2?=
 =?iso-8859-1?Q?ryFC8ljmAN1ups08ALHulbFHOM62SPE7MqjK4yQYRcJC14Vp8ygIMcdExh?=
 =?iso-8859-1?Q?O03OC8PMphNE2dZdTHueW4sKHQpMm5jS66xhMGQdVqyb2cDBM0+ALwQ0/J?=
 =?iso-8859-1?Q?4JeqJkbv0Nowb0DuF4S6HSy0kL+DS84bMVpxoMSCghJJk3KZXkO2SNJ3/o?=
 =?iso-8859-1?Q?Vl8R5uJBEW357VwAjTpdqIulFg+IT9V4q9LynjM2TDO+AdeGdDvIhECvAU?=
 =?iso-8859-1?Q?VuPcs8OpNNizuu4iEIC4bigqHT5Fie5NRd+DVk5H/Krxe5UDi//RnuonHE?=
 =?iso-8859-1?Q?rPNKVe3BwTAsLB19tX6g7VbRFypNbuGoOGRb3uizuEXGGrSAkfw9tYHJEq?=
 =?iso-8859-1?Q?RqQHpoAp95nWUJK7aRUrAUxUmWJMAL9Y/LXGcQWGlII4FSmErdc3QGq41+?=
 =?iso-8859-1?Q?6cDswFC7cskEEgk5iB0ffkf63PWUMZaWCoTnOErJwzv76i0jhBIRV4BtdP?=
 =?iso-8859-1?Q?1IDZpvBWOLaGr9lY34G7ITsBPjyrVw8M3KfNeMOcCSuvZtd6VF5y4w2740?=
 =?iso-8859-1?Q?osrdTet4aAXGPaAnj0K1pyfkgp/IGPcRkg4Fhq6k/J7eQtdjM/MZE9CEuT?=
 =?iso-8859-1?Q?TLdDoeeFLHJcsZY8E4xlhMOMGY7+AcIzqktH9+wawthNyhI99/QXa7CInF?=
 =?iso-8859-1?Q?mc0vPEKzqQwCOWyqHsWI/Ey/nLp63gqF4dA7pncpxl/EObhfVUYshTHJwv?=
 =?iso-8859-1?Q?A1dXPozQI8qv7kyFZAByo0IBwCWvVGWAK7gnPaHd19gzViL0YjWpULFz7S?=
 =?iso-8859-1?Q?cYW3Bq/pdr6CpOdb5y/sNQ3bAumWm8Atr1RCGY97P40pUtC8lyp8mJW7Rz?=
 =?iso-8859-1?Q?oMqoCUUkxfPpDbWQ9Bjvy7t5ciur+QPQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9159905-dc84-4d83-9519-08d925eda703
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:41:29.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuLdsJWZpvvaz15ULPmZciSO/eQeSrPfpDNXdVr58utWIn7qUbGrlRJZK5yq2Uf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2888
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: RqImWgK1DaOp-bIufArXleKgW_M_acGH
X-Proofpoint-ORIG-GUID: RqImWgK1DaOp-bIufArXleKgW_M_acGH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_09:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 02, 2021 at 05:23:19PM +0200, Benedict Schlueter wrote:
> Hi,
> 
> I assume its clear what this patch does.
> 
> 
> From 9618e4475b812651c3fe481af885757675fc4ae2 Mon Sep 17 00:00:00 2001
> From: Benedict Schlueter <benedict.schlueter@rub.de>
> Date: Wed, 2 Jun 2021 17:16:13 +0200
> Subject: use correct format string specifier for unsigned 32 Bit
>  bounds print statements
> 
> Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1de4b8c6ee42..e107996c7220 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -690,11 +690,11 @@ static void print_verifier_state(struct
> bpf_verifier_env *env,
>                          (int)(reg->s32_max_value));
>                  if (reg->u32_min_value != reg->umin_value &&
>                      reg->u32_min_value != U32_MIN)
> -                    verbose(env, ",u32_min_value=%d",
> +                    verbose(env, ",u32_min_value=%u",
>                          (int)(reg->u32_min_value));
"%u" and (int) cast don't make sense.

It needs a proper commit message to explain why the change is needed
and also a Fixes tag.  Please refer to Documentation/bpf/bpf_devel_QA.rst.
