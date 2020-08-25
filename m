Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D1250DE8
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 02:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHYAy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 20:54:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40766 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbgHYAyz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 20:54:55 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P0oUqc011124;
        Mon, 24 Aug 2020 17:54:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6fqUrGM9oqv4+eRLMJc5JY9oBDw3jjneTWRvvcJcny4=;
 b=b+XyJG+rIEOoWgkL8n2UaDyueR7oDMH/xvuXeVg5g0zo11S8zyB4PqvCLrBg64t+mCMJ
 VZkEsTO9SKRmzY8U1cldugGwYTf4f7wdqOI1WC/ERW7VvvSg8P3RanrdTcRHrdi/AZ/0
 2Ou4I65b4Ac+RmstL+ZrlQ8wXR4FFVb9QGc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333juu03y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 17:54:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 17:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ7VWkNDIi4F3EjNvLCSqYgxgCY0+mU5kgIU/nGE0p7a7QwiKng9UPTnoXbH4r7XwjQPkXH6lrfHp8U7PzB8NBAdWVPKGjy5MQnMD+NanUuDUvHoH84euiOPdeYfYfYWuWMpmantsRqS3jHMq4FZCzUTArxG80oDA76fjTyWMzynqr08BZjlS9NKc6EM37QNx3rmSknkUR5MJXkctB3Ct3/2a22R/+AZIN+jkRPqqz1bgj3TG170HfamXKLWiVYcC8xwfYEx1h6DlB6nehxOrwQ8itC9ngLU71tOoWDl6+kXfQxvJPVEsjWXHfDKrWR8xvZ++QTlEbG2Bb07Ia0/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fqUrGM9oqv4+eRLMJc5JY9oBDw3jjneTWRvvcJcny4=;
 b=iPWoyFmYXH141Zx20l5IEKbd+REzVBmQK1QmFrQFTc3bUsDPF8REDyubXF/yX7oxrsdQt0IXjkPmI8H0HjSyGIHdk3pm/hZU2307wkNq9TbJBMzXYDiNGsd6E5CgP4ZxLPJnuaoRPRs6RV4SYdnrpv6P+jWtpuQxEEsemXrrmqpdJOvf7KOfmnAyEoapcEEfJiD5OEwFJjv7AFO+QwKVGqc1bKo4mu3gA03cgAzcaBX9uZd0LI67WdFbMLCmfHf4hgV2xyFaOoMwBDuI3I64HhKdPcmvw+hfdrTKWwBxifz3DhfUnMXjB2CZTrFn1QhXxrxf/2SvCDyS8/41VLVYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fqUrGM9oqv4+eRLMJc5JY9oBDw3jjneTWRvvcJcny4=;
 b=U/93fW8mRwvDk33BkNeu3JO87kkLFbGuiI2UfclHJ/YgcEJEx2bmUTImz2ufjoHN3pbIXWtAzJITDHYgYdMo8XHUb3FNQQRIb/2BJRCu4qixgyPMTshdmYdATHiueF0TBoMzzEB6p2eelf8I68rloXzeOEJMWRHyKWPVB3qVc6Y=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 00:54:37 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 00:54:37 +0000
Date:   Mon, 24 Aug 2020 17:54:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v9 4/7] bpf: Split bpf_local_storage to
 bpf_sk_storage
Message-ID: <20200825005432.5iknjupl3o2hhqw7@kafai-mbp.dhcp.thefacebook.com>
References: <20200823165612.404892-1-kpsingh@chromium.org>
 <20200823165612.404892-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823165612.404892-5-kpsingh@chromium.org>
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:a03:1b8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 00:54:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:87f3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b08f0fd9-e36b-4e70-c4bb-08d8489170d1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3207CF3699DA8EE8A69E0661D5570@BYAPR15MB3207.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+2KDaDA9h7cNKabeaIDo2trYWeJCVfeKVeC1KFV+fPg6vrFLWGXo3wTfiLJuxzctQO6UMHGllFWUTV5fth9xZmTEL5s9FN2yHOCBiCWuNYm0rzw0MurUY7nkkPvMngDDvWmSqRyiKtf8AePz4TyNIJrnRpkwYFOIG0exaKjmY5bDSh9Fir9oNA+un8wNNn90HDn1dC2q+Dmafuh3TRKWrG29NxFBzzzYZvYab+U6NBNVdu7TsHdS1xvQtRGSS5HfLlE/A2bLBF9w+2PVpHSNfShr2/NZ+EMGnPd+tomasn55POi6aJRUIngpmhrVlV7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(186003)(5660300002)(6916009)(52116002)(4744005)(956004)(86362001)(4326008)(66946007)(16576012)(66556008)(9686003)(6666004)(8676002)(316002)(8936002)(2906002)(66476007)(54906003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FipcjUWAQkIyAWuzmljhondlUpgMfqZokoj3WLNIH84WH+9CohlWivBaEg2xg8GL6PPqGnB6uS/ePKCeZ6t54VUmcpfNDQoqjitq5WM6+1wsG8/nOwYBBqK5CiAd1vmXFR6w5/7mfoPHTY9nrUksLSfnJs79jNnCY3a63GJT1kXCL/u3X0qzSlv1AjjWc0yX8M5IlTq3AWDd1jw/IpVrTh9tSJXoptnQo+SkAO1IeWx6kJ2faU4/BilFSXY/28ITqEsBjU3qkMF0vQfeRJ2u3GlMNKYT5mLbqhTDxCyoQAAXgXvMfllB2fXqEuVgWxMH7DHzAEE4xbGwc922agmFn4HXRHQPdLvVvbagC575McrngN9KpTZDvmo/J9/w2Idaj3SJCd23meOYpqcbevXI5UJ9jtkatnG17IvSyuNWKDyaiReXBEBhMkcsgL0TGnDuRcP4EkkU27zyBoAES3GKeHvM+MLcuey4pLS1ssriqoa6sRRBft01pi8y+sWk6OFSzwRe/VsgXWgb6EE1pyjCxIYM85QgyofbCm2gyHLkju/H4Z1gU/IT5d0hlCC/q4SvCd5Iv3m3/wrhBIw/MPCLZA4h4Kb7V2JXPJL0toPh6jZ/XlXzLqRCEBxfZvAwYzdhqkuJG5E5I60baOkQuf6FkNSDYZ6VJpfBnl7KF+QdPq0=
X-MS-Exchange-CrossTenant-Network-Message-Id: b08f0fd9-e36b-4e70-c4bb-08d8489170d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 00:54:37.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXaGLi290Jmyfw/ZPVHK4uO5GHUT92V3OyLzbBbfFKIgyy1Y/lcG6hebNsqIxWAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=707
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=1
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 23, 2020 at 06:56:09PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> A purely mechanical change:
> 
> 	bpf_sk_storage.c = bpf_sk_storage.c + bpf_local_storage.c
> 	bpf_sk_storage.h = bpf_sk_storage.h + bpf_local_storage.h
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
