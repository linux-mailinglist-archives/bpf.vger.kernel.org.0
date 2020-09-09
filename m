Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B0263874
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIIV2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 17:28:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIV2b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 17:28:31 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089LBt1p009065;
        Wed, 9 Sep 2020 14:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nnhSFEgm25H7kJUjJ3iDzsYcDtZp/kQTvTGg+jJwXzg=;
 b=aGqu0rjdoRSpdNaOVeXOTxsEAYY0prFuva0vjESvVVX+vt78eMbUXMMVK0WIaU4v5DC2
 0b1VhyniAGCv4hcbFCUCcw8sPh3+u2QY6F2vK/nTs26vMpuRaSwKRvxWITM51ZnXvTaF
 KFZiGmoiCxYLhmc/jFIwBdYMWFeUbE/yiYM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctr6hnun-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 14:28:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 14:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnjTC23hbgzTracriQVxXccL6io3t2sAsjBZhf1/djOr8C6i7pKeWH4GElcFPRkqkjEp6SSdQP3gqlFbPJi7XwluNiqLw6Yqh6iFM5KUZMhxyw231L6QvlyDW9dgqW4vZJn2mKWSIGBly7brFbAK8zMwmdRyFoi+3VraVRaVxO7Qgqeg1osYuGDaHd033UEfjr9z0ii4NgN0R/0ubrWH8mJUmsvAnxvkp7RpAzWm9GKqxnfV5bZNjtZzzNaxJb0Q0qAcb6WJLVFa+hMQuD6itnW9+MDg2jp3hyMrfPWRc/s6CCRbLDySEfYxBr9hSfKvdVmcAxAdks4TOVmhzJFBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnhSFEgm25H7kJUjJ3iDzsYcDtZp/kQTvTGg+jJwXzg=;
 b=D1BNfX18Y0yoYo5ZkPzNZfi+kHVJ26WkvHIRlJGVhfdxIs9TB4OatDi5sGlSpos7W5US1/6EgUhT/BpSsUxFYKuaR1qm42mrX3AYtAxzL86a6nbb7WnrbM5fNNDeSAx4uB7VqZhQwUD4idANk+5qRW4FtV2qV07Ev+Bn2YTNZ9HFoA9VOmyRfKlpVoP1i6IpSaAmCap2raWjH5ENeeL7t4tjivM0XU3qEiK4kW4L9OJYeJTiFw/PXEjnKHkjJRCs7MKl29xbQPfBc5hZwNsm3EZCE435ICmTKBtV7Mqs3MmRypL/zTsAmYAtS3JUba10bPVbe9yfAtTrFjAwituOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnhSFEgm25H7kJUjJ3iDzsYcDtZp/kQTvTGg+jJwXzg=;
 b=YDiCq+Ysdczp59GhkZ4X8H0W3fftxku3QjU8gEH99Bl6p92L5E89KLs747NvemJF6LAkCkIaygK2DOzb9ExZNzFBg050hZsz3NF0pMxHyEkRjGUE3WzMva4pLeGBDkogsoI4HYa3tuxlMJgopfuACu3MrXrETn3GN8JiU4FWEBI=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 21:28:08 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 21:28:08 +0000
Date:   Wed, 9 Sep 2020 14:28:01 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 10/11] bpf: hoist type checking for nullable
 arg types
Message-ID: <20200909212801.arrgiwzv4vfqwqzh@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-11-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-11-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR17CA0084.namprd17.prod.outlook.com
 (2603:10b6:300:c2::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR17CA0084.namprd17.prod.outlook.com (2603:10b6:300:c2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 21:28:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b197bdc-c434-44f9-3472-08d855073ebf
X-MS-TrafficTypeDiagnostic: BY5PR15MB3570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB357032648AF7D79D80F00625D5260@BY5PR15MB3570.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeGM3Gy4XZGmR/q2khjZz8fUow1miEU/mMq4Hy5Q9+RuNvjWmhOSvsiPEu/W3sboBZEpabqYsXYJf7jRUvPDuv0GIClLvaO3QnmwQsCqSsGoLSn5FQSlcueIXukdJ5deArqtTBYR+EpTioo376ZoW1nKkBb/AhGe723bIa2lR9Shxduzduv5zqzUy+OZ1f5jP/+zs8Fwm5vXsNkLkgMr5xY+tLwV3OP0b5pgf7wT4ZS6m3LfzJ2szrHz4b5OmQ0GoiZJPiFeI3vLzZdLYYOUAlpS2XCfyDjDDMNbwdEP9hkxp4hXbDX0kXQXoMADZfbch8WwyJ8zFvNgB67sVY1u2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(86362001)(316002)(52116002)(7696005)(16526019)(6916009)(66556008)(6666004)(6506007)(55016002)(9686003)(8936002)(478600001)(66476007)(8676002)(1076003)(186003)(66946007)(4744005)(4326008)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Jhn63ZKU7y2Zg7Vzg9nYqLeDUampIwe/INaezeB9j3Nw1g5ijWLt/GufdG8uWfqdeiFDVialUeDaDtTubs5OsPyzqXIzJ+J/ZrOQSLOR0SjcwutC/hHdKcISAUZ60htpITjTrnLJbOQQjdfpkoh8+8fl19HHWW9bEX9vcJlWWs/0Sprs5B9blnNJhkx5q9dpDIyV5UquK2Zn3/Jqxrxl3ZcXavzOuV8jPL/tOMCaAIBkiXOwPmQ9Wm8kOnA3AxmXsSHB+m0MTAuMXsH76YMWK7ejP6kBdxGnS+5UE5w0TxrkrSorBfXiD9Gwe2TxRv9CDt1UNlKNnk1gIJOid5UJUi9zGTXG8OMXQJoHlAPXbc9YRBSTOwmIUdTPMOWKfzQpOHEixxcSt33Cqq/Sns3OkfZBjrZttNjneaJJaLsbr801k/6BDzPY92HdyRALN6uAF8s2rd2boStMOvTn0JEv7xBmFABlHXAIiHKA6T8TrwJWw+e3nHB82MkAR7L9eQ3xg1+iEZBFjbOeLlLIbso/OTYC8BRrHNKpC72d68TtCnqI4BT35wYUrwf3jdQWbL2nQeBudMLISC1Cyid7Pwm3U+eW0P0aYuWWnvpoTdv+BAHd8rxt0Ba8cICS7q6gHrIx3GMe3T3+tjVoX4wYqs/wyHOwNlMPcYtqUD+Q55djBuI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b197bdc-c434-44f9-3472-08d855073ebf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 21:28:08.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38lepJx7IHVFSEQTlcA1KjXitnneRv4dVQwv+QZqaHdxQEnqI/a4VQQPMlzfX0Fl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090188
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:54PM +0100, Lorenz Bauer wrote:
> check_func_arg has a plethora of weird if statements with empty branches.
> They work around the fact that *_OR_NULL argument types should accept a
> SCALAR_VALUE register, as long as it's value is 0. These statements make
> it difficult to reason about the type checking logic.
> 
> Instead, skip more detailed type checking logic iff the register is 0,
> and the function expects a nullable type. This allows simplifying the type
> checking itself.
Acked-by: Martin KaFai Lau <kafai@fb.com>
