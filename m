Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6E263829
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIIVF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 17:05:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgIIVFZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 17:05:25 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089KujG3026092;
        Wed, 9 Sep 2020 14:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fJkSwKf6uVuCCCVTbWZjNZEIdjqvc7T0cGlNco1GkDM=;
 b=HEZI3PqhwYJWOgPU8tGeAKT3OHoAQnb+aZ//6gnUoo5YxOnkizfXZp3FMw0m/Y94deE4
 QKkgpBvOD+WLIISzJLuCFnWGZFfbNpoqZMkkHXz9A6OFoYigYmpZQloCnVZhj10vf2Oq
 H1P3qe8wjxvN5yzqHs+rAEPAIrvhsxXD8Ks= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ct5u1qfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 14:05:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 14:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBO3rXi68Jk7kbUN2Bfpgw8bRyvJAJxSY2n6T7/iFPDIGOg3X6Nqkwgeg0G1WcqLihhsaM+IvnVLFF0i7wodpA5tGyfPFxzPDadkyjg/ZieYna+3D09FozUZ2jAaIFbju75xnZJ+JnlX187FLGZWMuSt9fArMbocdfZ9gJ87A4AwdWziglnZEfeE3zAXf3ZtVqh91r3JHBXL7t02O0R8HroLQriO6N4C/BHYGXpKnV57L7LBm0Lww2GNd5Zyu2LmSJaoet3vkCY6bghJUM20GZh/SGEDjO6pAIkhMPZZb7ph5ozrW7p7iNWFMX0djmgkmzqZvCRh0y43hU1J1qUNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJkSwKf6uVuCCCVTbWZjNZEIdjqvc7T0cGlNco1GkDM=;
 b=OQA3Yls1UqXwNL74Ee1bK0Bt7/NDZWZ/gprL9Wz1pxNnLig5snKMKMglV7vGaAFfFslWW+QvqAZnUScGKt/DXW/YaqGSG2hcBVFv+Ct4zS6yQHc+XnGPPhvvDLOcBZKQeUgqeaAs2aJ42tQBxuqRr6hGfYsqRx0+h/CJPGHtOjtTc7zOa1hlcoIeWC4mo05mr6O0IH94ns+Z86A9pwzdjHdSBPtZ5mE4YpxKmST3rvUklyDA36hJirWKbiLhat3PSiga5kwSYuQJOSoK7xPHOUFLfogtpnNLf2/rnDUkGiaaQUovglkFbB7QkP5vF4qFIxHFiuwCM2pDAGMoYHdvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJkSwKf6uVuCCCVTbWZjNZEIdjqvc7T0cGlNco1GkDM=;
 b=jd7JF3sbZs+rrVVB+XKQARcv+wMV3LyqrrMy70RTVnp2LRu50+2wgpbtGiwx+zh2sEYtO9AhrXaq3uOoLxDVcRuJ60YCZpFcT2Xi+p6BeSUr+4m92SpCdb32C9xJbYQfeKrS7aS752AFLPcYwqSZ8v3v40+QVdYPiRp7vSeIYrk=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2245.namprd15.prod.outlook.com (2603:10b6:a02:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 21:05:05 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 21:05:05 +0000
Date:   Wed, 9 Sep 2020 14:04:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 08/11] bpf: set meta->raw_mode for pointers
 close to use
Message-ID: <20200909210458.ve66mwijdzpm2cyv@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-9-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-9-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 21:05:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550434ac-a2f5-4b3e-4314-08d855040664
X-MS-TrafficTypeDiagnostic: BYAPR15MB2245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2245FCB86CBBEF14490D7506D5260@BYAPR15MB2245.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O51mLkGkUpEFuUAy0shWpJnrMO0Itc3JCUeL9VYgrO7jrBN020Ga37DGnM4FjoQ3nCfXV5wy6DhW/cN5rhTaTv1f6E9Sh1Poc6EXUoOyXi8PtTw4So6wEGVtehay0PFe8pkCwcGPjceYDhQ6APYOrRFiygGHiqqwiRV3hUhfBiAVGpRETNwCTe8i5FodpYWysy6aOI20gRD5XkF3r0qJ9skJUc0kwwBiTgO8boMsSeMPuefzGFL/2w5eg3HoPvKlgb/GjhtCwxi2eVkRpm+5glizaTzXhtCgDgmMtpzOv8ji8t66t5lsOsPnhBMjLO+QRgcBsgYO73vpZpXQeppAaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(136003)(376002)(8936002)(316002)(2906002)(66476007)(83380400001)(4326008)(66556008)(66946007)(8676002)(9686003)(55016002)(86362001)(6666004)(186003)(4744005)(6506007)(6916009)(478600001)(7696005)(52116002)(5660300002)(1076003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6sCBphFi/e7fuwCy7EnKl012QZz7Tn4DCZtKCYngWrPaHA5OxSePOOwqfT1rJh9OmgIobPZUj3HLGlmhftL1JBqH+hWtTR9GlJOQ8TUh73biLuUPtP4MfoNpEda4onUjU0Nm3/X+g7gpTTsOjOxoV8dS0+eBzWo8HCghUN7wA5RV0BEIx4raPiKV5dsuHQzIqHqmCf5TzXaS4ersEOsGX5SfgGX3KDpvboQX9GhDz+AT2+wJq0D70H51T8WXFMBYKMDv0vUPR48u66g74vcdmQQeSacx71gQUZyfS5ydPBKvK0kxfFkKnZEOhGrA/Nmg5dA7Ly2Skpt/Q98/+DKfZgHZUjtIrp4qCm7VtspQusJfj1kGJS6GtnEUWgjlC6zBxR8+ZZITbxrpsxdFUt0Quoi+VBOnFTYYJ+c71XZ+dQ73cFBYhY6Kj0916AvxcESVZVmXIRbJ5G98+aMbX1EPwJlKMfrLks6/mghGc/4uj2FO9juFFQf2qDtn8F+OwAhU6rrMkafArrEKoJZ6HS2uAbUXx3SHZvS1MnYQuO6XTMsRV1327QN2POPYeuqcXJaN9LV8cxUUd/nSnWwvTJNKzqH2pPLXRM9AWzZ9rZXiZsClLg5wQrD4IXqTzZR5qlqo6U67RsXoVqQzjF+1cNRTNidBs1uQqhnGx5HFBDsXA2U=
X-MS-Exchange-CrossTenant-Network-Message-Id: 550434ac-a2f5-4b3e-4314-08d855040664
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 21:05:05.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PinsQM89iyB+LJ3/lvlvxnrv1ekM8OgUgrFBlyzTBBO2BUkc8onc6CLyiplp/VN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 mlxlogscore=805 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090187
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:52PM +0100, Lorenz Bauer wrote:
> If we encounter a pointer to memory, we set meta->raw_mode depending
> on the type of memory we point at. What isn't obvious is that this
> information is only used when the next memory size argument is
> encountered.
> 
> Move the assignment closer to where it's used, and add a comment that
> explains what is going on.
Acked-by: Martin KaFai Lau <kafai@fb.com>
