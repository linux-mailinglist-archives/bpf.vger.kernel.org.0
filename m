Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7225C9F8
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgICUIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 16:08:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgICUIg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Sep 2020 16:08:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083K13W5015837;
        Thu, 3 Sep 2020 13:08:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nZdXOdEGW6qD8u3FFWK9zDtA9lB+PUOtD638RPFxEWk=;
 b=m+mvFAHms+fsa/YKeqDXaJajMTXGbam5VhEkkjQo7yiZEY9tn0ViYnwdKzWMak1UnXxR
 O2P1d59jVEb0CK62wEM1OfHb73qi1RcHEDPOTd5JewH0ipTyfvvEd6306PMvHodvX3MR
 2M86ex7mJa6wOKvzw8AnhIrK0WWOzxJ+JS4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33a4cnjpjg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Sep 2020 13:08:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 13:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lteDmRNax1Vp1yLR9KbAV/VQ5M01dLQqdFWfgycsLxYnBJ2YVzrJNu7Ojf6bmrp3iCOENbV5IM3j0BCzSeEWRL2GOJQSdMVj5HKWECcRxl7tJUfH5Io0XDsZ4LvSZgimW/Gys09U1j2qq+1fkcQSmHbKLtkdQRsL8HfIyPGLJFeEpYbIxiroxHIQ4URHyxCP7cqPby13nOXNMqN4f7EHFslajoc5a8OAy+MsPWEcu6MluTYzEJ+wGoGo64WzA7sTPCvlC3jYgOIU9ly4byFc5PdaeWtHVQwjRhAcxxez0Ms/DlDSsa7MscBEdYulu7AADG21pKVBfGi7m6vEDjw3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZdXOdEGW6qD8u3FFWK9zDtA9lB+PUOtD638RPFxEWk=;
 b=LOwdbHEUdwQk2m8YczG25p9ClKt4vld50D7ddvjwoIoMK23Fk+9R2VGQs+/2FtwE0hgcS36UdwgTl3/jJfmw4RuXrrZqs1xtCCMdiUryuFzLLId+Y2KLPzELs1qshkkpjP1Pju/6M468oJc4gZAGk5qBMHoEM3viV6gq0J/t0A3Fq5kunjqNybVy1rZbsaTJ1bPi44pBvRYIceVMIp2Twpazw09SYzp628VO+OELSAgiIqjm3HqnMzJRCxnfCgKrmsGZohXimbdDGdtmQlQiAcHUpBRLIvEbud2aSNy7ztlXZr0ctHRruBlImldfWeBd+0kpX2jsNBJMgACWdwnHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZdXOdEGW6qD8u3FFWK9zDtA9lB+PUOtD638RPFxEWk=;
 b=j4CtzqBF78mcTcaR6IE3WnFBj6R/VhFew+C3MrpKWO8ORd2sOsrsH9aakd2nxPVsKU9ULwVysdZdnRtdZ0VQB+k3OEv2wW0CY/Ij7LURbHiHcjzRAncZWKbgD47ex0M3SxZYhU8LyTkC3hiLiPOnq9KlE5Z/J4QAO39suGi3hQE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:08:16 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3326.024; Thu, 3 Sep 2020
 20:08:16 +0000
Date:   Thu, 3 Sep 2020 13:08:10 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 0/4] Sockmap iterator
Message-ID: <20200903200810.lyxorvv2ocg2ibr2@kafai-mbp>
References: <20200901103210.54607-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901103210.54607-1-lmb@cloudflare.com>
X-ClientProxiedBy: BYAPR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:40::17) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:40::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 20:08:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:3935]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791dba00-8e0b-4433-78ae-08d8504517e9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2407B4E80384BEBBC9BB1650D52C0@BYAPR15MB2407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODfhQm0UkQISPrmRpq3ygLssPitODdbzRwtD+IJjKm9gYP8UHm2f9X/ZxYeHiDFU+BeXMh6t5wDiUpz7HFy4/XK+4DNuFDOaILv9v+cb1ACsQWBcH2hSfx3fKL6bd5NMw3+jALepYZ12imWcdpqDxNcnUdoNsdX0RvOl7rldAz9BwW9YOHKjj4Mx+CfXythn+eocsjVXDsTerQ/dJXGzPVSuX9LCAGgq8xX2sqzNUXtTet6urxv7iHF6LdZNo3+sLW2qACUDTmLwmqHnZbpwDbAp+zxTLkBEgUA3+6kB1l7pTbc451aH+JA3PPw877RAhlnY3u1YkPAUxuLLaK8Y9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(86362001)(33716001)(186003)(316002)(6486002)(9686003)(8676002)(83380400001)(6916009)(16576012)(8936002)(66556008)(66476007)(52116002)(4744005)(66946007)(6666004)(5660300002)(478600001)(1076003)(956004)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2xlfrHudVabY2KK0H/ZN3e/XpDQve+2Lh9XsyaIeCtxOe6ajkxLgAWDo1l73anetqxJQsxOn3tVkb4BwswdVw99d+VlrHh0w2YyVaeN4WUjLdeCZ97pffEUFhoajKdISG+cDiWDhhQIpzZe0qBR/5OnKPauTvMnVCv+YhPw0K9lM8BW5DDd/uyKIThTainEYX9Jw7FvWL1MJAiiROo9mt5PPQXEmmbuv4hk72rFnF7ZUt6R5m8XtNrFrLTsS7ayimEN+pCGtKtH435aFe0x2UdqccRKf9zqjeU/LxrgXaD61M/qaDAQ/m+f6rxKb2/of+XvXQkQQxhJvBegQW81cpkCdvK3HpCpTBuy/rpC+P+Su/goq35IH4ghRN8jzbSr2VEdZC/oW/aLqdL2Hn7KuN3T1JtbswVsBWfBIAgHG/nsuOzvfPjRA/xO1WtIxDyyQ5FLFjqy+/Zl2e+Emc28AMinLY6pu6NJV3rax2PKM5H+JteC9wlAYbLZ1/LQwxyjkjTvNouvNrtqkG47vWZJoZurqAJuYoqBiHfQmx0/2CYm6jt/wFI/w9+w2rHHG90pcmIglsWlPFym6Ouoe55HFS1tToUwqYflX9zohgWszVFLMW/Gffu1NtLgj0wPHdloamf89isPQtnc3NlK2z3R0LTXw+IIZG+aJESTZ6msdBNA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 791dba00-8e0b-4433-78ae-08d8504517e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:08:16.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9axbYCaNlMKNNcjhpAAnOO+M1DM9GzqiDOxp9VNuvz6lPrK1KVBCvtkcKy+4f+li
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_13:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=558 adultscore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 01, 2020 at 11:32:06AM +0100, Lorenz Bauer wrote:
> * Can we teach the verifier that PTR_TO_BTF_ID can be the same as PTR_TO_SOCKET?
I am working on a patch to teach the verifier to allow PTR_TO_SOCK* being used
in the bpf_skc_to_*_sock() helper.

The use case is, for example, use bpf_skc_to_tcp_sock() to cast the
tc's __sk_buff->sk to a kernel "struct tcp_sock" (PTR_TO_BTF_ID) such
that the bpf prog won't be limited by the fields in "struct bpf_tcp_sock"
if the user has perfmon cap.   Thus, in general, should be doable.
Hopefully I have something sharable next week.

For the sockmap iter  (which is tracing), I think it is better
to begin with PTR_TO_BTF_ID_OR_NULL such that the bpf iter prog
can access the tcp_sock (or udp_sock) without another casting or
bpf_probe_read_kernel().
