Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996852A883A
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEUki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 15:40:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30492 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEUki (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 15:40:38 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5Ke4ue008267;
        Thu, 5 Nov 2020 12:40:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ji1HVbPlnvXBOXBTxvNpXGxx1UYjuwFpxHL++xFHq88=;
 b=IQCHGx82uvVhfxgWLyPDlg0x444N5PTGGo/7zekrx/JwCACQHFTkzWOw80qUjAvz5Ml5
 hmRIPbrUtiMmNkIt5UCDoWwU0TtVH8eNrEo9BzlvUXAv961yI8HlNUVOrIWYLDxQl7y7
 85WR7JDM97YjvK+V4B/HrZKfrkuainbK0B8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kbn7nwq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 12:40:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 12:40:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdiEEqRiyDSJ5oT06UVqFyDYWyrft87Oiqo6re+bhFcN1+dPUWEHbaEDp4JooES+YzgSsPnE1aB3miYg17Qpo4FnGoVxL8RgPUtu7RQ0+rmkW8wXz37fHos1RiFxIEK3IKxEUdWL8A10FV/HIgKyMvuOCZPnMR5m5JAkFQELTqJmdd1CtFecI7RViuyEh2KV6f5/xyF2i0WgTK/4yNHaSeyWPgkmFe5WINagoAC4WI1xnFRBcnhbWosLfgy8sH5npeRI5FAlz4D62ul8fuqJicTcsM2Y0OgJMVWpcYyt280heBowqzxiBOTC5Z7hYgJ9rTqI1KKlFrmjZYUQdI8vHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji1HVbPlnvXBOXBTxvNpXGxx1UYjuwFpxHL++xFHq88=;
 b=gDJN8rd8vRvddEgC2zk100CJaCosyy0Zhtz7UtsMO1+gKinMDEG7hHa2Fkv/cKrFhZlI8MTfaFyfFMJl+Kh5Q/vr3+OFaNFH1MoxoccMtyhcKulLE0jOjC78uA2rTG0uvFbQI2Rsy9tJsjx59EdncZ0kH2a1HNH+CFxSI4LHprg76Do5BjIvbAAh2gZxIfLN1tq8WhfEJyLU4QnzTfXXDVRIEJ7DZL4jSqHUTXMQ8OPRWfSVQP/xQQJR/w7dIoDgWFX282bxR22bfilw+w7BV1idegXaHB3Rc4KTCQlwvtJ7HjJwbe0KR0Hz3bvQql0oCiVOkjXA7iZfW1qBiTSrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji1HVbPlnvXBOXBTxvNpXGxx1UYjuwFpxHL++xFHq88=;
 b=kCF3qOMoRJZrUQrsngzzG6n5aQ4rcBgzKc3FIJJNzM+0y60cqQtEbNHeiAXggdWl+Cj2cAzP2GJr8LktfYtEVYRQWuUENDWZlFkRABghWTI9sX63MzXU5Md4XBDzgdpKpLqMMxQfKzdyuml3+S3nRl+zciMyTxhpZ6US+PLdKlc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3206.namprd15.prod.outlook.com (2603:10b6:a03:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 20:40:02 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 20:40:02 +0000
Date:   Thu, 5 Nov 2020 12:39:55 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Allow LSM programs to use bpf spin
 locks
Message-ID: <20201105203955.ekugupmtjurtdi6h@kafai-mbp.dhcp.thefacebook.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR1601CA0006.namprd16.prod.outlook.com
 (2603:10b6:300:da::16) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR1601CA0006.namprd16.prod.outlook.com (2603:10b6:300:da::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Thu, 5 Nov 2020 20:40:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e52bfa4-3ee3-44e2-e454-08d881caf83d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32069F12CAB4C43F8BA76D90D5EE0@BYAPR15MB3206.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC9r07kRCu/D+2WmhXWnvQGMkpP9RGKfr8rxeD72R59apXrgb4lk0sAaFnEoGfvTBDoGApHqDVxCr5CF+l5+1fyjL3KeRdp5VZu5Z+DCWkvdfhaLmFtXCPNeHCqhksQmkkJLfYczlpZgWMdoBnjIMwTwR6PID9toBzglzRKQMq3fAmLJS2haoEmumsOm+0TE/3gPKzeyeCPsW1iEqvjvumHdKuCuL2nZSd7LHKfUXPJaGqj2wbhs+bW/JR4jySArNKxNqOZowSjJQqG+bzBvz3UrnnC/+6Aos/IshrgacaoN4jrC1n/eVfYQoRtqy3W0tpk5AiP5NKUtXiE2hK/cl/SXI/e+u62M+NYKhjG9U67A2VvW1L7ztiyC2dv2JuaYjVxC3fBbf+FIUNiPqL94pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(16526019)(8936002)(6916009)(4326008)(6666004)(8676002)(966005)(186003)(54906003)(1076003)(4744005)(55016002)(5660300002)(9686003)(86362001)(66556008)(6506007)(7696005)(66946007)(52116002)(83380400001)(316002)(478600001)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bZCGHqSX/sgbEqjgCktye8hs+uH4kRhDth+9jbpLJRIWmfQO9QsSSkxYY5SAp3z0r/BMrD7STRvb5oOFF+HwwxZL7pTxmPH1c4gpjFp5XwioOvbTA+JfMDr1gA0wWYPXOm6V+3gBBhsaBqIBzjF5gHHh0bBTklimHYrP+15pVtQOE1jTD+Slb0NbJO9W0/BqsHF3iH9t0hlvJDFxiHvn6IfMJiunij6xf54h01OHhWbCPIkh7pNT2zZRj1PJnyCOGzFPd6+JciLmRpruaFKGooi1LHqkFThZcccRUlIKgfdx6yaBfRbwf5hOPitZ6UH2p96nX+xiyTn/6IFP3EV9TjWmXdipnRWYsNDMT1MKWQC1m5t0Ky85n323PFgYJml2OJMMfv9htr2NT0NP+kO8HC6DCi/p2c5gCr9KwxttBCTIPAIN9UpnkMeYRNPwBniKrawuCOWQuOIv64HYnt9xpKfmDepntAx7iVBmDI5yGT2NK/t2VNYz7DTHvRXjd/o0F2bntooqynrjmOfMkc/td0DNQzGBn1QmnHdc7fU7ogebwcqQnpHHx23CAIj43cKpwvC6o30mQgrN/Rxu9NFP6El8wtq29/+iw6DIBeEyhE0F0w4dnnUm9SpFXWd8Fhd7NYdxm5TOt4ZzNuu5T3tlaeuDPXExziFzaxvbRHbjOJdhRr9N2rBOa2E/uMX85eWu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e52bfa4-3ee3-44e2-e454-08d881caf83d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 20:40:02.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lqOCTmPSk3Av8bIDBzlDGnalr6hjZYEpq0KM2yC/5AN2u6MYRl/EYaUK7b8q8eQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_14:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=781 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:47PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Usage of spin locks was not allowed for tracing programs due to
> insufficient preemption checks. The verifier does not currently prevent
> LSM programs from using spin locks, but the helpers are not exposed
> via bpf_lsm_func_proto.
> 
> Based on the discussion in [1], non-sleepable LSM programs should be
> able to use bpf_spin_{lock, unlock}.
> 
> Sleepable LSM programs can be preempted which means that allowng spin
> locks will need more work (disabling preemption and the verifier
> ensuring that no sleepable helpers are called when a spin lock is held).
> 
> [1]: https://lore.kernel.org/bpf/20201103153132.2717326-1-kpsingh@chromium.org/T/#md601a053229287659071600d3483523f752cd2fb
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
