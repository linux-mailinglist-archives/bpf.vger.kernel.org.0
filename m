Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF112A8A9F
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKEXVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:21:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726801AbgKEXVu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 18:21:50 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A5NCXNE009718;
        Thu, 5 Nov 2020 15:21:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Vbnt7SnS7m7VuYo2BtskuTUlwRF8f90Pgoq3WT669YA=;
 b=pOb008k40+yV5yhArEaCRn7kX+MmjuLBHAk3floTh7BHT6K0hCvgQjDuFF/LgYUQSkZc
 RhmBZQNyI8K3ruu1xw85xKh07gxCs7jL2adag8R8LH7FcP/8Yg2FGoGO1yrOz2m3Ehly
 9p2siad2YhPKNuT4WcoZp6N1wLzuBC0yt4s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34mek34fsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 15:21:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 15:21:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8wtXltCcUceBEduKYH1yNHiawHYyOzYfVACyG5NbHxiYdRFx5nOYsTw46augqjGFkKKMngz4x5DkqAJCCv8GQqvlHzNTclN2j+zDUPhsoBS0uv7eQ3gKvzPM+sRqYY8b/gLZYsymzrEsmT5zhibDIUsdtWUT5a53aeyzQ8xC1KQaXuz7CSozIbc8nSe1ZWXKEuIwcvhTDjoLX7PcR4ujd+T5OR/bkpGo8EJFDELlnypkeY5QGvUQxUydquGyILF39HbRNTpRV+QciieUbpX7/jxXhMKWdSswqGEEnWvKQPj+t5MoPN9PpwML3pOSXd4ysPYVgnBWJhN5B10ITelaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbnt7SnS7m7VuYo2BtskuTUlwRF8f90Pgoq3WT669YA=;
 b=HyoeRgdoAFBT/FP8Flvw9vbgfRiyHmJLmJkvemVw8u5eLTxl2RVqgURwki3ps4Lp+tVPn2td14zy8kF+5Mqw2pdtBkG0F+L0Hr2x1iMjXu+5Ph/gyVA5R70Hr8xYWsgwQvBnC3QpMBQS2m9uJoAv3n1FzjVcVtXIiBUD9j6HxNYQFErvvXxmt11VQNBuSQp2BudmEnwYNhhEuv6IdMOj14TgULaM1iJynBXEyvzsn5MN93Vv8aK0eN/K0UXG9rfH6OngcK3YLkmo5kUGUwlY4lJrLBbvnJqIViDOS/GdAN5VE7UGU87pFWUwWTaCYz18Yt+o54GnRsE+UwIxeKxMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbnt7SnS7m7VuYo2BtskuTUlwRF8f90Pgoq3WT669YA=;
 b=PrdywoiKXL0U7Ip30c+xuyXB1qPtpnK2oxrHlIZqaDyTMmh2M87BkmWz41BTvr9k4Xe/Jz00zcz58gE3ccOYPG3NXYbFMOs+ZpPJJK5ALvqT6mN1bz9Jm8CcZvVdlV1n64EtPlHVkTUY4QpbqTwi4tNbGvsmip8mrDkuoaUE+zc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3665.namprd15.prod.outlook.com (2603:10b6:a03:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 23:21:26 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 23:21:25 +0000
Date:   Thu, 5 Nov 2020 15:21:17 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v5 8/9] bpf: Add tests for task_local_storage
Message-ID: <20201105232117.wxjt66r7okihgbcf@kafai-mbp.dhcp.thefacebook.com>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
 <20201105225827.2619773-9-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105225827.2619773-9-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 5 Nov 2020 23:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12bc0957-1a77-4926-2828-08d881e1840e
X-MS-TrafficTypeDiagnostic: BY5PR15MB3665:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB366553DAA82C649EE598A6E9D5EE0@BY5PR15MB3665.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBURs7GVt7o5dLNptyyjCc8XO3Znr5xrL2AZCMoXSRZfqarLCiZIb0JxSyTUJhH/0PfKfRWDunX2Sp7px3Wz1qe7ncf3UIKV54Xrp8PvkHRpwRgOKizG9dKepN0Twkd5l44Mid6dpbACX/tLdTPpHzwqJzaJhK+CNIetoPay1Hb9DKeWJhG4gAm8yBDCRJlohMP1hJvXOfbiTj4TSeYltBJo24EJOYAPX/E/zpmoXuLwI2Yhts6tThgWpw203snF4Em/Jj+itorbnStXX/HPYDpIsl/Qgj3HXwmSBljI0zqKdjnHrbfkVKH8/Bnm+1Eg9ObaSZkBkeT6C64loGyKwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(2906002)(83380400001)(4744005)(8936002)(66556008)(1076003)(8676002)(6666004)(316002)(4326008)(6916009)(5660300002)(66946007)(66476007)(55016002)(54906003)(9686003)(52116002)(7696005)(6506007)(16526019)(186003)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qe2Cwj4mg746Cuj2kgodnAHQEhG/XjapB3NmKe7tudh3m3GiTGjY6hNErSmrsjeaoRZM8QGLtAaMLPk6WsUYOgg4Al+DJk1Zw8HrFeNtZ7RDoQtXqbjFZQdmylieKANZDNRUxfFacmusSbVrSuchX1BN99DJmnveU6kG19HjR1omVuI+rZq0lKZuS/KYHw+zva+R3bZbKQC6JS+jbTBePdG0BZ8vHszxhyT6tnULnp+Bhiw9+YWJ+21sUI3pgU5UHBcxwdVAtciNUT37KVSqXYOgKe9dY0y8ecN2rVQB1Bp9/NrIRh43jCUSeelboG/T8P67tll8U1ggwVDotAwIMqt9VnItAQQ5r6jqDX5DGmIQiGeX6/mvFsunny4SkBV/qnlv3Wd/468fRvLty3ycrL5ahlu+qpCWspQ7xuPtzPddjBjXPYz6bRLCOOOqT1YEnPa/Mz4tiYt9/7Ztf25MYqporq8j/inMHe/XskvXnpO+sc9r2/gytBMf38W+DUtKE7+oPM5h3VlrB9zWyuTR9B86ZZe/KtDHT3eNbmn9jwsR4rZpmQ+v+JbRC3ZgPKaic1isqeUiJTmOJvQRy2SocgQPMu2MeEOW5kVRMrQfivl60h0IP0rBrs4oyLhxVrVElLYVmrcBfKg7Gle0qNYz4i4wGriUmt+Wg0+YLTsrwlw1qI7CKt0vmSd/khCtBVcq
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc0957-1a77-4926-2828-08d881e1840e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 23:21:25.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V47BgDrZ6pVNgHTWQQE4+/YACN91YRs3tPQg3IOtgI+57o8yHLhkplXpgm8z7M7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3665
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxlogscore=443
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 10:58:26PM +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test exercises the syscall based map operations by creating a pidfd
> for the current process.
> 
> For verifying kernel / LSM functionality, the test implements a simple
> MAC policy which denies an executable from unlinking itself. The LSM
> program bprm_committed_creds sets a task_local_storage with a pointer to
> the inode. This is then used to detect if the task is trying to unlink
> itself in the inode_unlink LSM hook.
> 
> The test copies /bin/rm to /tmp and executes it in a child thread with
> the intention of deleting itself. A successful test should prevent the
> the running executable from deleting itself.
> 
> The bpf programs are also updated to call bpf_spin_{lock, unlock} to
> trigger the verfier checks for spin locks.
> 
> The temporary file is cleaned up later in the test.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
