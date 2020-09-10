Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFC264BF9
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIJR4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:56:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726424AbgIJRyf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 13:54:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08AHrdZX015668;
        Thu, 10 Sep 2020 10:53:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Tq6Egt4EziPQh8FRHHLaMIApx5T/xaC9Wgodg4gok64=;
 b=EdHgeQhHdgB/GbJVv6Swd3T3AphfK5BgVKBn2VLYLY3apAwHSaTq1XML9hxM8h5xhn2H
 K/nR7zNkzj0yWclzVUAaE98r8CwKEd3qqmrJy/7RHelZLopd6UgAIUireix1bZwmgiVj
 ugDFQMxQeQMPyl5kax5v44Jh60tjnk/9zWs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 33exvhyqhc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 10:53:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 10:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THV56JkZIN/2/GLOCU8EgYTxXTnJitWF+yRtabWa7qukclQcIQUI4T5JYvKAITQK4WfsyFNvA4skLxLIF8cfQ6nDsjA82lTp8x7OZ7NvVOEd/4ZxX7sGqcPJjiS9Zq6WfwCPsMrTKi2WO1+obaqCRGmoXtax6eNFc9CPnaA96tQtU4wb1ispNiFFPuMFghkHD/wHpS2Rk6lo3tLmTZHZYqnHdXP8bR3BcpLtD8nKHmuAuqBjAGtTj/Afq55RpSdrf7bVH0psT+8//ggdrPTwip2Jrr1a43YRz8Pvx3kzNuaOQ4Bz5TIPe7Cf3PkYZgOSQcOwKIEdyUbbhuzsySO8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq6Egt4EziPQh8FRHHLaMIApx5T/xaC9Wgodg4gok64=;
 b=ZyvZU1gJlmJsPQS9GK+8DqnC3bNcQpZ2XUTYZzMJX+NaK7xNI2NOFgoH0vvHZShvYpp/whUwnztK+qnlIrjCQysOctLtneOZWF3FpTSSnjqHMTU00VLZS/nnHptV7xI5W1+2rPF4DBiaAeH6KAzTTiMgPLGtfm9LJgwwOGV3GllTCfZKcYfWyDEmItKc0yRloZoMxz//mn0BjexE9XYv0Hw4Rywzf+z93lwMFp06y3ZAaxxmv/vSsiLoPJdzlri5UVunziB0a7jKqXvSg0fPMnhIH7LQKa7MG+m648RHPrHv8S27JJ+TdDpEUYhY44TP0kExTj7Aj49qIAqXS+MdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq6Egt4EziPQh8FRHHLaMIApx5T/xaC9Wgodg4gok64=;
 b=H/Eh9yuP7pV0wwgjgze8RXLx8a7mOMwZl5AN0bxgr/w9PPHi6AHi8eWjCo6NkKpjdzvv6EcYymoCBboGCuIB+FP2eDqnKgUlJcStcJeTc9m/15vVOrQCUaGjQPyQHr3WJw1Xz18Jud54R4jnflfe4/wZQKKQav/twVi5yTi+IEg=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2997.namprd15.prod.outlook.com (2603:10b6:a03:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 17:53:27 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:53:27 +0000
Date:   Thu, 10 Sep 2020 10:53:19 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 11/11] bpf: use a table to drive helper arg
 type checks
Message-ID: <20200910175319.axax5tbm64wfkavu@kafai-mbp>
References: <20200910125631.225188-1-lmb@cloudflare.com>
 <20200910125631.225188-12-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910125631.225188-12-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR17CA0087.namprd17.prod.outlook.com
 (2603:10b6:300:c2::25) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:f5ef) by MWHPR17CA0087.namprd17.prod.outlook.com (2603:10b6:300:c2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 17:53:26 +0000
X-Originating-IP: [2620:10d:c090:400::5:f5ef]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96637510-430f-4398-14ff-08d855b26b74
X-MS-TrafficTypeDiagnostic: BYAPR15MB2997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB299790CB446F437FC9159B7CD5270@BYAPR15MB2997.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7+GwoUnc6Pz829WBM3WPcGOD6s2h0+41y6LSlQwtDy0DFtUHaQLUUNSbEthilltRqyeNPLy0s11S1eDPKGaVPfN7h1BHJnwhvgQm6yMPdM+wm0nUC9J942RpbqS6LBfOUNkY0BfronNi8q1rqu/1tJQnceM3vuFir5utAQZBmz1+gSA6VFkqbXDAJKhiCBdHDMwjgV/neG81csx99Hi/CP3TVnxBQYN+A8JZUSRGU4nl4EsJIqo6Dp6ooiKPUmaP5AnT4MI5M+XNw3rqBUP3jN6wnneIOmoUNWgRzJERuwlceCcmSg6YZeSAsDhR6feNJ+AjFh/xCYsoWrK7WtuUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(2906002)(186003)(52116002)(55016002)(33716001)(8676002)(66476007)(8936002)(9686003)(66556008)(6666004)(6496006)(66946007)(6916009)(316002)(16526019)(5660300002)(4326008)(86362001)(1076003)(4744005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TBl9mIiETC2ozqzjJQvfN9ud8D9kivf8L9I+Nm/Q8/8HHUuQNSjCEGVT9hkHMh0YZV+hvnPkdoJPBiiHAUDXCz2jnz1XLv2kmt+mda94cAsyHo3+l1w9FXFXap4NYMXXQPyqT7HI2evPUenpL//psR3jhJXS1T9kOZUHblEmcM02xpTy1qBGKmURM7zphtocBdof2BLzQKhs4fqQhdj/Q5GNtU7LW6HtEdJTLVwo4SpT1htksUSoqVVSS7mYz9mt9K4mLde7NEAhkeQMi1RJq0YVxG/Xtu4gHTVsscHn28vQHdLZy9pXbklI1UayMja//3TFn8xqx9Tw9caw4EpqgpdmQfeMuqI9mIEFAl6mmLanfr7sUBJyXT+Tr2VMD/ZZ2RVuOhB/4hurkn0xBNqsFnwfNVHaDewn5Cn3v4poQpgySqhdRpMagEtqHwF7dL2XdvdGRiGDP1TketwSr2smJ4oGUvsL2asW1ePbDsE4/YD44J6alMeBzRApZbkaFnuVgjA52SK95wtDJrSuGbhea4SUf5WGPLdNNwvJgMAZY4hljR8+mMLJGbn9FMuKPL5zlfyvqydN6nIIDtvh9Kg18ORNksUqqONKCh8iXkwGGN/d9MVhUq+XcgdDxuRRR+3eiupmURIkM1STnYNGdS03TDAEuULchvGSCdneSRyqZ+/vcJwJzvbJmd8HBHT1wJOb
X-MS-Exchange-CrossTenant-Network-Message-Id: 96637510-430f-4398-14ff-08d855b26b74
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 17:53:26.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3r+COgbMv+p/C+FjcvH7pLiQLYMaszLyyRstScCmdE9h0I6lezWXyyiezqHw8Zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2997
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=1 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=979 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 01:56:31PM +0100, Lorenz Bauer wrote:
> The mapping between bpf_arg_type and bpf_reg_type is encoded in a big
> hairy if statement that is hard to follow. The debug output also leaves
> to be desired: if a reg_type doesn't match we only print one of the
> options, instead printing all the valid ones.
> 
> Convert the if statement into a table which is then used to drive type
> checking. If none of the reg_types match we print all options, e.g.:
> 
>     R2 type=rdonly_buf expected=fp, pkt, pkt_meta, map_value
Acked-by: Martin KaFai Lau <kafai@fb.com>
