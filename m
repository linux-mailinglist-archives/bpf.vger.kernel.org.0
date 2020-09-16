Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0280F26C8EA
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgIPRuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:50:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbgIPRtF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Sep 2020 13:49:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GH0q8o020512;
        Wed, 16 Sep 2020 10:01:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UUwy3YnOc4gLnCr7fvml2E0yREEpuznMqmgGpq2K1ws=;
 b=T4OsTgtK/2sq99KI1uu5ogXu5R6wUiRib6IF2WhMMgi1xT4jJrunmh6GuHDSbmBVgTH0
 PRO+NFR/ey8SziR8aASyMjWl2a4jinNOyYy9cKqaHsz5zH4Tdt4IGjMohaHzHtoNY03y
 DhPCVcOpyePPhq/EO1GxgBpMlWncUwJcPPI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5pkvqgb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 10:01:09 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 10:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGzZ5V21rFdSYJAB4uqFUGz/tZRttKd2iI8Gw2XTBnMs0aTrYQ1pTHVedchpY5FD60+jnvGFXwUYcNYarPPrKQF5wRlxn1Kk87wRUDYFmCmtEWXCVu5HveAj4kqabgCN48x/Ctua7CWPnCOPxQewX0XeUonBYQsA1rqMCvykIT1uah1uQVWbLhI+3PS/GuYRKE0qkyT7rg17w7wILwPXXr/nmzMq6fIoJor3V+kwKoNj8aBqvPyADapNL+qTay76NJJ/ASppXG1M6wMnawjubBkUZY7S566vUMW4/FLobAWzONLTmVctDC7v+iYmsUnacQg5Y5i/nRKQpWcRndJxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUwy3YnOc4gLnCr7fvml2E0yREEpuznMqmgGpq2K1ws=;
 b=U9gJ6lJdDrgFJeNG/91QGAvONKoXuijk1iJg+wF3B9k1l8GermbNWPKnXZIKLb5UWnBfKikRrL6HvbVdDCQN9hJnDS8KMsgRXXSAlHnKK5ajWYhWn5uklBB9P+/73PBr/Eg4qkVOkCh2EnBr1tWcqd+I3OmG60TZohiiF+TI99tp+YEsaAT+1cVxdYQRo7XCMGw98vTEkET1eRVVUm8vGIzC5e+OjyXI1DZ/7la74rgDGlzMV3z/zFkmDRXTB9Q7wwRvt39pCYUkWqlAWK5sFRVbyaGg0heNcjl7RHoe9H8hcFtgN2qxE6/b1O+bfHUb+YXGoRvAVTdHlKCYR0Cwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUwy3YnOc4gLnCr7fvml2E0yREEpuznMqmgGpq2K1ws=;
 b=br2m1Bt8gIRjpgrtZwqKHTtg7II7rA6TLkTmM76/E1O1tg2NafJDwUasSLLd+1wr2pHXSHoY6kWHZmfFQS0aCmfUaNHtczGCJrZn1GN4lRzbf2PJP8O0pGg9FQ+KJ7+KhLLXteIEiZW7F8z8Yu9I3cRzIOvhvkRSGEzvT1Z+z/s=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3511.namprd15.prod.outlook.com (2603:10b6:a03:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 17:00:59 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 17:00:59 +0000
Date:   Wed, 16 Sep 2020 10:00:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 00/11] Make check_func_arg type checks table
 driven
Message-ID: <20200916170052.6gw5md6hwxd6rsce@kafai-mbp>
References: <20200910125631.225188-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR17CA0080.namprd17.prod.outlook.com
 (2603:10b6:300:c2::18) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:2074) by MWHPR17CA0080.namprd17.prod.outlook.com (2603:10b6:300:c2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 17:00:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:2074]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b3f1aa-d594-4b69-0d69-08d85a6215df
X-MS-TrafficTypeDiagnostic: BYAPR15MB3511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB35116F0F00F8296C133F5E16D5210@BYAPR15MB3511.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XYxasZCGKKuZRpQkUo2IMG+wGWvCsdMkt+85LUtYgWyroFocglbIixeUtMKDUBzqXiMRSkwOFvwI+HwXrJSm4kSbnokFh8fYFfOxgatuFOQ8xXrjKkdiFoEzngp+THcVc5UIe2P8cJ3uR5X1B97W9mgOUdqE66QQI21KhPpNlHbg1RC+p9NbQ+6FK7t6CtxOEuKcznXG1sjUA6OyTBR9Q/gvqJHzHDAqE1t8DDid4F+D6xPXpuRgJmq/3dqODtYXWMD06v+ahelgX6QRa7idt6wRKXYXe9q4JeG5W/VaLOtvm6AjSKg8HV5JmhH9Y1G4h9hdaGBKv54QoVomYBGsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(136003)(376002)(396003)(2906002)(66476007)(66946007)(186003)(16526019)(66556008)(1076003)(478600001)(6666004)(316002)(6496006)(52116002)(5660300002)(33716001)(83380400001)(8936002)(86362001)(6916009)(55016002)(8676002)(4326008)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: esGcUpkVEdDkDkBoO+ZH5cfLYOMMCJdOLzL+WhUvf/lkUs4aIDpYI1JEmj+2pNYaLQQOPo8NqcTF3VDeJy3a+dYOlYZG5j4BtsxTLUDQqdOlpje+musQ6QZvuO02Gb0Jea2nOibu+A1mq1wHYuNzx2u13Xf5cmJGix7dLlFmgh7OhXKJy88Gaps8CE/U/Qiqg7ypvK6+mNXzyGBP66KYMmDWj8IPnhqMvMbG24MtdMpHE2Tgz4V6ijcAsy5Wg6amv8nBQ2gTCHCEhQKbUzmGNFhMHDU3Fm7tflauTomv+sOWnjYWMul0cOjBv4+8r865VrL7GcOXVYpcvTQme+OucjLr/bH8hS3pLX5uZDd8Rfc4tKyHdjGKPDs4Vuk66Z8ui9sX0eN5QgNKj/Yt+u96deBZJNI80jhoTmeUOKVICTwnOiJB1dP0b72A7855s1lQ8sepbbe7ppI6N8papl2uUr9CRlv4tP6kWgs+OSN49rCtC1hQyzG+kTDlVB2Xi1aBmeoDIbQHQeNLSZaP55ZZgNgt8YlVyrKI9+D0Y7pEvfQN+SAua/9hJ1jRehP1TNK47a1VAHww06KM/ZGj7qzJfK2bVDKLC3A1rg+xrvazG+ejqdHq9zSQJlqXv7mJIbeV1NcTNPTzPz9dXVv8x0feSlyIhKZKVFqWZJH4dlGQ1V0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b3f1aa-d594-4b69-0d69-08d85a6215df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:00:59.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSi1fyGEql6zkXvIOvVZUF4W9w1A6Bz7H93lqnsq3CyuD+dBemfGwenlDsTCi9ev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=969 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160120
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 01:56:20PM +0100, Lorenz Bauer wrote:
> Another round of review from Martin, thanks!
> 
> Changes in v3:
> - Fix BTF_ID_LIST_SINGLE if BTF is disabled (Martin)
> - Drop incorrect arg_btf_id in bpf_sk_storage.c (Martin)
> - Check for arg_btf_id in check_func_proto (Martin)
> - Drop incorrect PTR_TO_BTF_ID from fullsock_types (Martin)
> - Introduce btf_seq_file_ids in bpf_trace.c to reduce duplication
> 
> Changes in v2:
> - Make the series stand alone (Martin)
> - Drop incorrect BTF_SET_START fix (Andrii)
> - Only support a single BTF ID per argument (Martin)
> - Introduce BTF_ID_LIST_SINGLE macro (Andrii)
> - Skip check_ctx_reg iff register is NULL
> - Change output of check_reg_type slightly, to avoid touching tests
> 
> Original cover letter:
> 
> Currently, check_func_arg has this pretty gnarly if statement that
> compares the valid arg_type with the actualy reg_type. Sprinkled
> in-between are checks for register_is_null, to short circuit these
> tests if we're dealing with a nullable arg_type. There is also some
> code for later bounds / access checking hidden away in there.
> 
> This series of patches refactors the function into something like this:
> 
>    if (reg_is_null && arg_type_is_nullable)
>      skip type checking
> 
>    do type checking, including BTF validation
> 
>    do bounds / access checking
> 
> The type checking is now table driven, which makes it easy to extend
> the acceptable types. Maybe more importantly, using a table makes it
> easy to provide more helpful verifier output (see the last patch).
This set is currently marked as "Changes Requested".  Since there is
no other comment since then, can you respin v4?
