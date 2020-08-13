Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0610244190
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 00:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMW7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 18:59:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgHMW7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 18:59:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DMcmcs021283;
        Thu, 13 Aug 2020 15:59:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=ftJ7zTJrUmqLTM7brG1SAYmLA3hajF0BFiQExmex7+Y=;
 b=X33QcJM7eH5W3PkSGLJdDgu/CbarthyVbOIBwKFG+u0W/ozmOkK/YDWn/QOoJHB4DGRp
 LAKAMQX5jrBuj17Fmdqw5MP4AYMRBBbwSjpiDDui3pPk/yRnUpLK/vZcqGGTsSMlFEUb
 i4D2FhijDqFGna4X/jdQENq4F1+61UmnM14= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kfmmed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Aug 2020 15:59:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 15:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh8j4YBLe3lRuArjNxNMItfWlFrIbt0RtKjtGAsfzqAYyNOqLyKYghWv8PkmmfDgqVFB/b3SabUFQUTvwr09HvE9WyDy78xXsldwflwkDCwmcJMm5AG1+ZBVB968s8rxFgYYYmb7f5d47kGaP4/bOLGEU/qfnhdnPkBNDVdZU91P5D9VRKrtvaDyHP45zx/8eUok4t0GSc0a/ZjNtVJCVqu/VMrRu3z9IQo00smGbCmh3BPPGBGT7td8EQxqbUIsQGXRhm1wYIl0JHM/jcn8LpNuLK+BV4Oo0CMLoCtWDiB4e5VWixL82jnAW90h8UiZn9hXnbuGLyiJbrxuxch23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhOWi2CwDkea7RIRaMfNAwqCWtuagpbBf4ObGVcQhAE=;
 b=iLY2RnEq6C7H9QqYNmy8d+7Ym6JgjXtXIrPTdj+hbyGfyjpLEBfY/gNcfH8XcJrSy7ZLtD3AkMQZTnBrHFfW98eLooRzXiKN+5uq8xaWIvEgqizq6ua5TvWmPftcmgzJR2PwUx3rU9daANxmxnbTo5ulmurNeosS4Ck30g2fd5GOQzcyJOVDveHERlzOOlT+8jfRSvh2Vxd6J2ourLlPeeHuKXaTnIXT1JyHywNcqrrBs+rZXJOtNoHQFaJw6vbCOVjEsdHqRp4ykBVhYCYwn3IQDLicH2LO6d4xT4O6BxyRWD5AaTPzovv/0q7y1ZdH6TNGuvM48VFm6tQILv9BYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhOWi2CwDkea7RIRaMfNAwqCWtuagpbBf4ObGVcQhAE=;
 b=c+t/kiyA9nXb+jIFxUMONiq4VhzPCVjCqVffNHq49rMEZNmLVmT1+YB4ILA8eAUg8K1ihUsbWi3eojt04HdM93EZODmrtb4lPMsNDwCPQNrbbfQetP1b0qHrLpYCPCl+yAzdynnubm0GNdHvIDzvqRvOwl9sr6PGHQkahsBLnJ0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3666.namprd15.prod.outlook.com (2603:10b6:a03:1fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 22:59:03 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 22:59:03 +0000
Date:   Thu, 13 Aug 2020 15:58:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <orbekk@google.com>, <harshads@google.com>, <jasiu@google.com>,
        <saranyamohan@google.com>, <tytso@google.com>,
        <bvanassche@google.com>
Subject: Re: [RFC PATCH 2/4] bpf: add protect_gpt sample program
Message-ID: <20200813225858.xuy7lbz3kaehvtgq@kafai-mbp.dhcp.thefacebook.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-3-leah.rumancik@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812163305.545447-3-leah.rumancik@gmail.com>
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:fd4e) by BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.2 via Frontend Transport; Thu, 13 Aug 2020 22:59:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:fd4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bee50f3-e68e-45c7-5318-08d83fdc7951
X-MS-TrafficTypeDiagnostic: BY5PR15MB3666:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3666BBD42FA264DE05AF1E4CD5430@BY5PR15MB3666.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCjr4j3Fp/KkdI6I8heL7T7YYn069o0EDW3QB0anBz22gm9cU7e1zNEhAW6gFcKxh9aWS8RREc0xOcZG0y4UvJxpLvouXkK/3nqr0R25QvsBthw2ltVmXmvRcu8208NrUUf2unL7u6MZLTijOZ7mVXdHpeSIVDgd6quMeLmogrC542hn0gP0x6Kf4mRong7KBEFpEUwGnsQgdejUedjXxqGhP5qEamgfi8olSmJ+LLPbcTBhPmijti/LqGH9F4FoBpALShRtbEq7Mnqe8Ve74q/AdcPMwyxwV7BXA+/bZfx+G5G44FyfKZnQWZ/TnWHF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(4744005)(16526019)(186003)(2906002)(52116002)(86362001)(7696005)(6506007)(66556008)(6916009)(5660300002)(1076003)(66476007)(66946007)(8936002)(316002)(4326008)(8676002)(6666004)(55016002)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K0q9JsDXo+68rofIah7Zzx8b+HwEeoyLw/yBkYNDuG6asLnrHxf+WZXvL+IfA+dz9pVK/DAPdRAXcckn5WG/rrwpgFMXqOyOcikJWEh2kmu3l3tRONQ1cxKoy/VMT0MxtA7F617s5qSWrXUHhy1FyGR3dWRPy7MvAdwMTn8pzHegjuWqVBfCmLnRoLdTcZcFO2MWpi584MNzCindAr91qBiwHDyA60usL63HqLKAMH2Amt0yKX/J7a2gloxMKvnU+/MbrsbuNCOAHXNKUm/LsAxRWJfa6WED+/y3qN7L18iJBjyVRnU/SaYMDssgCH2jQxEBhJfEaHmHdWX877FJw8TaHMwA4pFf07waPy6BuWoyYuSijUhFmaUjw1nZUo4qNDQGGLfMMgdQk7fj9tLCQXOd3Dh44ts5wYOZXE05APcyNO2uGCGh6pxV5tHH2oalVjRPCaB7w+/iw5MiAqBrrrDpmGh7QqSjRVN5P6CtTYtdHCV+7cOqrhQZwDot0bS2Th4AAWhva5pylDjItbq32JDlxWAgqQ3BtoW1OP2qcdUiPpWka/jmZequ4m/zODd3eNst5U47tKWKMhh/mmwHv37k97plW88KzpllhYkhwks2F+879Nui4Z4b3kwoAxxC6M6cYs0raM6WjNSJQEdxdIGfCQTXR6PmQawez2e2D7HYDtibaJqiB8wWPAnIeL7k
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bee50f3-e68e-45c7-5318-08d83fdc7951
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 22:59:03.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08bZmlZh/4nSIaWPFZ5m1/oOe6imx9ll5emnxMtPaC+g/AkiB24SoixUnE5JcACX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3666
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=865 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008130160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 04:33:03PM +0000, Leah Rumancik wrote:
> Sample program to protect GUID partition table. Uses IO filter bpf
> program type.
> 
> Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  samples/bpf/Makefile           |   3 +
>  samples/bpf/protect_gpt_kern.c |  21 ++++++
>  samples/bpf/protect_gpt_user.c | 133 +++++++++++++++++++++++++++++++++
Please add new tests to tools/testing/selftests/bpf/.

Also use skeleton.  Check how tools/testing/selftests/bpf/prog_tests/sk_lookup.c
use test_sk_lookup__open_and_load() from #include "test_sk_lookup.skel.h".
Its bpf prog is in tools/testing/selftests/bpf/progs/test_sk_lookup.c.
