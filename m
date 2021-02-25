Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7532591E
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBYV5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 16:57:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234460AbhBYV4f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 16:56:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PLihvw024235;
        Thu, 25 Feb 2021 13:55:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sSW+vWB6I141PgJn71Yz2CIc0ESjO4ti5yFC0AR8ngE=;
 b=gpcddub/inTW9DmGhXhwFY2CvQRCuzCSF0xAU3c/Ffgkcw4hYKhO+Uc27MbVN0Bi68dP
 H1XHecvcBka2Jp2fThaztaLukZ8q+oDgW6bR12VFuGTtkFT/3iUQSTQvImaYsHg3pE4v
 4TJmnyz1k3vxQ6WMKomqLBhzXnV3AwQSzWM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfk87rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 13:55:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 13:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccCxktF/6riV4E5XPLyeXKRRwkvvSZtFffVKTE+SNjY9H1nB0EfcdSLnKrylEmDuJJnEtERpZwQV7e1l1J1/lgP4E9Byq+8Ux8kSM1k2igUvjsFSusgZYsTgUM8SHQRv6qxIJt0zxvXt+FjAgugytAbAtSktqcU2VJgGhC0cEI+5smEhWD+yv+367bBcNNp390t6mrDS8WdGaxDCW+IpIW5Bt3vMZ1BB2Zpp7805PkjEMR/I1b91dsPFZU/LPgyDk/s+YX6/6HUBi/6EvqXRwT16fHuyJbnDCUnQjvTChiBxuxA/4ObADb190ibkJC1teR7hQzknDUdRi/I3IVw07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSW+vWB6I141PgJn71Yz2CIc0ESjO4ti5yFC0AR8ngE=;
 b=RT9w6sevVuNT1MwxLUezxPXtesHKxzzJbP8IYRtJjsGxI6ruU6oEeJaUjg5q43YzaOASi36/zOyoH43mn6iAr8sSJf6+EZElmW5Y2rXB2rHnRTxUw7F7Zv0XpemiiXfJhL/aKFmieoQRkoet1QaGNS3JMLg27ogLumLOX8aXr3JaviiSYakp1xMyXrT6PLifmJQJg42bl2OLvcTEzqDZoah89ZZmtt0KT32k5fSmAe9Wpe51atvkPe/qpWoaYqMdEvBA3YS8hJ+UaAf1j0u7bxWrg7Zo9rQ30LPlYCFMj8LGpgcnCURtgQHVhuXisiaPzyS3JPwXJa7cCE4/DWnKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubique.spb.ru; dkim=none (message not signed)
 header.d=none;ubique.spb.ru; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2773.namprd15.prod.outlook.com (2603:10b6:a03:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 25 Feb
 2021 21:55:09 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 21:55:09 +0000
Date:   Thu, 25 Feb 2021 13:55:06 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>, <rdna@fb.com>
Subject: Re: [PATCH v2 bpf-next] bpf: use MAX_BPF_FUNC_REG_ARGS macro
Message-ID: <20210225215506.xktvt6kf3mpwyiii@kafai-mbp.dhcp.thefacebook.com>
References: <20210225202629.585485-1-me@ubique.spb.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210225202629.585485-1-me@ubique.spb.ru>
X-Originating-IP: [2620:10d:c090:400::5:fa88]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:fa88) by MWHPR11CA0020.namprd11.prod.outlook.com (2603:10b6:301:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 21:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5edca2-5447-4b4e-f0a0-08d8d9d8051d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2773391C1EB48B6BB12ABAF4D59E9@BYAPR15MB2773.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgIMX8/PErEB3Vy0aSF6dyuXnGQvJcrWidAZ5cfCc8FLhws62JWmfg63lO7zD5sRAcIOh6sIHfXSGsFSkSlM66vHilxaaReQJ8e7ZL0g1PZLLkDRfxjFVmjbam8NQpxd3+SdaoJhmTzMagtEV9HSJf1MyAXOTQtmxw5o9UF3bGXRX4pEm5adW0ORCjYPPfKVVtLBY8JqFojHyWH7yDiy1KoOdR9tJ5crzjdvF1j2/c+CSFOXPvHv8XUBxMV/2e/tsF2+nzubs3z1yMRD4JF+iJaakUL8z+c+ye+6H8R+qzIiOzA5B4UEOvXT/fUenGid/f1azy988/OYEWojYUvy7xWqP7pWeGkvekPaXXbg9D1owdJCCKrwoUD/6Z1m5ifBHVUl0Viwb77+75l7LJyAoa/v3vyW/0/iNUNdLQDLy88GB14SLAxLSpTJMuXb8+KLUm5X5ngv+d4dfbi6eJsAhBZLH/Mk/9BTfU1JzqzQ2ozREL1wA4e9Xo5hOt049K+RCQK9RxcwDNA2ruhPPtKcHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(316002)(8676002)(4326008)(478600001)(8936002)(52116002)(6916009)(558084003)(66556008)(6506007)(55016002)(86362001)(66946007)(186003)(2906002)(66476007)(9686003)(7696005)(16526019)(5660300002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FNsdVDtqdYuPDkFf1qLq1WLA7mGSjCktaC0am4AgfpSWB4x2E4cz3Iv77wZR?=
 =?us-ascii?Q?6eDE/vn0LJ5s8/sD753g3O3nliIcyuPoYpB3xkhPYxGIcpvIbV9n46kEY3VI?=
 =?us-ascii?Q?25AgE62omS9FAnLAQVpc/FrMBkzUJm05u0dIBh11FNRUXq+B5XVYQXVZmGt8?=
 =?us-ascii?Q?6U+XHHllLdJHJ+brGH6+ZgXm9SVPXTOqCwdrVUT1XwLULkqQM1TVmJAkhgL2?=
 =?us-ascii?Q?4yiSFEaLT8Md9ndDzjYlV+sOK6Zhp0Mmr0V09uTtJ3HBrWKk/Kzf6gVfYjNE?=
 =?us-ascii?Q?kr3gL/lOlTjaZ4OQ5EwcVIegXJfE2CXe+9FUkPPX1u93yxRmCiD0/ndqiqVo?=
 =?us-ascii?Q?tEBUWJs6sEKWHV6OVAWExOlPjCFibVTPlAhhE6eIkZg95IVMVYHiholn+XqH?=
 =?us-ascii?Q?1Q0CPQDGgI7wOxJLuS40N1Zx6dJnqOg+cIMM8tBBGw24F7yu6Cyiz8R2sUFD?=
 =?us-ascii?Q?NjW4hh0AwyphvyqPbdVPqgv+/iAKA76Ppg/bSU7C8ndwycjlmUTrk/7DOmVR?=
 =?us-ascii?Q?ckSd2dJCCbHk85IC+nyyp0YFTfrK31LD4gp+nzLh06oDmrt0sryFLKlwMvI6?=
 =?us-ascii?Q?c21e26ezS10IkB3gNMceaiUO0ShwCf9jR9uavqT+PO3lbLWzJ1fobwvK7z+8?=
 =?us-ascii?Q?LIe3WKxGMVB2bInkBG+EZ3uc7ZDXhlE+14ylbTmApxJq2awn0xGyRehzgBhC?=
 =?us-ascii?Q?5u7X/qvejk8LFctDnTeKAV1/ZDM7HKjRrqhqf4w8FlTf6Q0XrG8K1dkr50GZ?=
 =?us-ascii?Q?cWzDRWhXSxyZrcbtyPG5fdqvEJ7I8HYwCj6ju5qLfklZwwkOhEzfbucQ7HAa?=
 =?us-ascii?Q?f76mItsKeHogdiGYKdFl37l14enT6UFSn+jhjeUC2fYf/IGENGZKLboeyRBc?=
 =?us-ascii?Q?si8km1oA7dg0mFxyXsgrrp+R4N9cQhcRV6PGkC7h+eoPYKGEP9TPZ+4QNvIG?=
 =?us-ascii?Q?17K42sGg9O6YYXR9Scf8/3QyFzgzj+zqH6lEDIIK/4NhW8as5qzxtusRlmmE?=
 =?us-ascii?Q?MOXjCORi1BDjfVpeNEpfxBJAVS7GLG862VveF6Hf8xYKDsjrVPYL8WTZfqAJ?=
 =?us-ascii?Q?YM3+zbwECsC/dK0qTOoSHqVtSSKfgiVChIHperSolH0V2K4pFhUJqxwQnSvt?=
 =?us-ascii?Q?0ATmSaz0TcR0fcBMWDPdzoM/OAbT21QMsBDOj3QBrPYg71BfVa9Lqos5BsmL?=
 =?us-ascii?Q?WlKV++eKGFYq8wSksov43BV9iABZ5JiHwvPcyr5Moa74S8IuDuE+mXYp3Mcw?=
 =?us-ascii?Q?i/M3tqdBswAUX9nUvc9lX85oji/OwJPIMAk5IAydg7hMSYzfPnq1qD1aCmyW?=
 =?us-ascii?Q?FSBpCBra7Mo2B+J8jBh7o8MdhTXBsIwgRaqRuq6ZeFnMJA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5edca2-5447-4b4e-f0a0-08d8d9d8051d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 21:55:09.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekm0jVuqS5zMP7pQtDc2mmlwQ1K7h49DbMFpJgsEMSSro1IZ7agZ+yNbuyY5QXgs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_14:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=883 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250164
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 12:26:29AM +0400, Dmitrii Banshchikov wrote:
> Instead of using integer literal here and there use macro name for
> better context.
Acked-by: Martin KaFai Lau <kafai@fb.com>
