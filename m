Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770FC2D34AF
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 22:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgLHU4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:56:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbgLHU4N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 15:56:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8Km6Uf030985;
        Tue, 8 Dec 2020 12:55:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Qa3AUe7och9aYtOE4rmNcNEilzZhiM/vfr36Ic2uyoQ=;
 b=pGyLLQOVsXnSTsyZ2ucow37nb0cBtjm/mCNavvT4qXlQhzhmWOZDySRuwHJjSfapMCc3
 Aios4WxM5seFD1Wtl9ApBcuT++/EJOZLKjXNDI7cWbWyflAmB5Jca9QaHGhDfXSrLkLM
 bA9uzyOD0+j7SRmm0aRpEqHU0onqMfBF/2Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 358u5b1y0y-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 12:55:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 12:55:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3s8oB5uRAbud9D/O9mkgWH+MbsjWAQN8JU3G7JtANDS8Y+woWd/biMZr9TRbgc80eW60fBB8YgGlll6dwSgSORXO8X678pyW2aGRYtCt7gQBSmStYKStjPJAg0+27DRPCXSkjww+QqdXITNucdcqi+Zjn/z1oe+HAzUSmnKdQUg81ITfNtdA1XQcxPi3BK0sJAXJZQin0//cTpNZT5Hk9eH7V3O7pK/SLpzHjDer3qKPEZKwBM0hqoNNSy4C5FFcRQEHdDMwqbTgYVSa+8MJNkDnnRW8IWXsPBiDlWQZugEKLcDnT54vxtiubS1fw5L7aQMXHj8GnqQV+qYWljPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa3AUe7och9aYtOE4rmNcNEilzZhiM/vfr36Ic2uyoQ=;
 b=Z+k2zVZxvmVPLovhf1FbVXZJvKKnOa0fJF9O7iu/tryX4VJhoBDVhX2yikTs0hfs49BkxJL2bEKPtQBpVHt+pSn0Al+c3WHtbwCmBeAWWz2OXUT2UiepbXBLajEMODOCDabLlPO+Q535Zl4Oco8w/QUZtmpFGnzLAWtWFDsoUGmPspbEoRQ7ZOjWtB3MIFHnW0TKLGTIv2ACbKc16w+zVW1+dhXrAVb1AFYyFA01qPwF7YEsPDaEM3EtwAuRZx2IOz+ZJzG+tK7b9Jt6oA4pjFmv2yeUpTlMQHLokVPaGwdj73Y7fBkUTzkj5vmgM5XxyO50+Lz2gzgshyXjHVG4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa3AUe7och9aYtOE4rmNcNEilzZhiM/vfr36Ic2uyoQ=;
 b=XD7ANtTWI0bafaWRc12X301VfVwtF7QXs1Re4X1vCLb5kTDDQlT0XBFDAjOcCCG8tCQOBiFOp777u+ZekYZlVzypNkeq5gBkaJ21NKep5OGbRQb2jU076bwCSp1oBGLbBjRGZP8ac6+Tgg0hkT8J4zBmQkvBJhSHJgkxzZrHGVc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 20:55:05 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 20:55:05 +0000
Date:   Tue, 8 Dec 2020 12:54:58 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@chromium.org>,
        <rdunlap@infradead.org>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next v3] bpf: Only provide bpf_sock_from_file with
 CONFIG_NET
Message-ID: <20201208205240.hucgnmi76ng2r5s7@kafai-mbp.dhcp.thefacebook.com>
References: <20201208173623.1136863-1-revest@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208173623.1136863-1-revest@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:d011]
X-ClientProxiedBy: MWHPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:300:117::13) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d011) by MWHPR03CA0003.namprd03.prod.outlook.com (2603:10b6:300:117::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 20:55:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833a7350-2cfd-40a5-9852-08d89bbb8a16
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2646F6CCDA8C884115378993D5CD0@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBJtDGRXnE48TQ+lYDwE0NuGJQo/rCiIu5AYZC6syp94/ykZwzgYWobt77uRvEmFfQP89OCFYszRDdVMusmlUgGJFXorW0NJ52cLc1oq56skC4bIpTnBazN/zSt3y/ceWW3L3VjhE9oKPkCIi1Y54x4LBkN/RQBHh2FYoBWEapoEYUOuMaFv67PIdjY47RnXKaPMNhLHS4WHC2+GqTymWnZY+c/4EnCIpsuYfGg9EUrdnKaynIK/fg+HubvQ8uVuP4JmU0vFNprRdnDycqW2OUAZ9mrw84gaAfXj6hLgCJFYDdOFvAMGO6ZzWtsAky1WIxPaIC/DFhepXHtSoq2d2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(52116002)(6506007)(1076003)(186003)(5660300002)(2906002)(508600001)(66476007)(66946007)(4744005)(8936002)(8676002)(16526019)(4326008)(7416002)(55016002)(6916009)(7696005)(6666004)(9686003)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LV81a+YnElR1MMLAP89aXvny6e/XVWSIlUfan08yjJSojWoywL6JAlBmKVW2?=
 =?us-ascii?Q?NyHtKKb0fGDYK+sSKT+y5b0ogjx6/3q/CjtCJVtxyHWI5iM050txygZgU0yp?=
 =?us-ascii?Q?I4CKYfwQkm5GGBTHvIflskC9kTGfdcS9kyqevLbk73CiPOzCtUucX36Hr0H/?=
 =?us-ascii?Q?xwYTQRVdo/Yo1w7olL651+EU+PBwpUNQiiLUD5TiEDA7Ov+aymJ/X2+gabAb?=
 =?us-ascii?Q?Gt11/FlCOa3qvln+jFUjqWBLg326WQTZcN3clKZHHhWppKm74cxdtB8g1gBL?=
 =?us-ascii?Q?oktKCrW4CdjRXKrXqUKJof8vF9L9ZHZBrgjbk9BPzSgNt1SM5eGRM2Fxe1+0?=
 =?us-ascii?Q?Zo/em8hBqGH7z5XcncOxfHhsClcQe1cRinjBE6LC2/e5izP6tILVh7KyEwXm?=
 =?us-ascii?Q?BsA5Vqf7DcoFXwNtl3TNIcni/Vd6F29EB7ffkYp9nh6Dg+5XkL+Z+1RrgI3X?=
 =?us-ascii?Q?LB9eP8KqSrPFz9XajjaIXvmvX4ctQeX7pyGBCMUEAKn/lgTyqahU5O+E+rz4?=
 =?us-ascii?Q?gm6uLOsVwQycMm//Dgx4d5pWA6fJkod5xx9hwC09lzJzhNVDdED3DbNmusG7?=
 =?us-ascii?Q?KWvwgJAGgi0hWPL7ZR1UTry/watN+CgQwLiotl1UMOpvOpbbRg8H4DPcORgG?=
 =?us-ascii?Q?ED05CxJxpYr/Xr0N3pIEMx9gTcj6snmofgSFKXJQWohqY8gjFT9rblZ5Ay+z?=
 =?us-ascii?Q?U+ifYF3wOeqYptt/hJcT0T/+zrOIhdbz6jIB+GodnJI1/TaE5pxPIcIcX63x?=
 =?us-ascii?Q?V1bku9mwu0hsbyo7Gb4qM6GHmWbpVTcKaTvaYhEXEDAb49ihRsGPRJ6m69lg?=
 =?us-ascii?Q?5YRBcnvakNXFv2h1L385Z5ZUAeeXR8FrkW+p6Gz1Udt+KjFtr6U9vFBOHCM3?=
 =?us-ascii?Q?T7ncp5HdwznFcpwLfuZ2diu3e5i8iry16AyVOJjzJdt3OqN5pbTYOsWql8JM?=
 =?us-ascii?Q?aPaU2CcvcJG8crQ7GrKcr7QmMObI0lITtsvYYfjUnAyE/2FraFAsC3oZJTNX?=
 =?us-ascii?Q?ovhG7vefx4JrhpTKQOyEHYEpoA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 20:55:04.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 833a7350-2cfd-40a5-9852-08d89bbb8a16
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhdzFWnXzo/+710w5rpPtCXZrVXgr9kBuuNozrbBvGELKXmE8y6MFtBjpsEzlpUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_15:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 malwarescore=0 adultscore=0 mlxlogscore=893 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 08, 2020 at 06:36:23PM +0100, Florent Revest wrote:
> This moves the bpf_sock_from_file definition into net/core/filter.c
> which only gets compiled with CONFIG_NET and also moves the helper proto
> usage next to other tracing helpers that are conditional on CONFIG_NET.
> 
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
Acked-by: Martin KaFai Lau <kafai@fb.com>
