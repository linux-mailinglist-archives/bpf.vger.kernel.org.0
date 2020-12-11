Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3172F2D6D86
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 02:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLKB1V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 20:27:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgLKB1J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 20:27:09 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB1OWmo027726;
        Thu, 10 Dec 2020 17:26:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Tz1P5J4dmHkWt72EGPHAvVibvexttbzj2htUvkyJGOg=;
 b=XFc+V1NM9YJZjzJAJ0O5a/VQtJHyq9s+6eo6Q7JoECHrtCWQerPO/ERELABMNHpn67A6
 OcmhhLIZAGwuJpZPXQ8XR767B1tCaOkHgrQO2lSeDdyuODHs56cj3lRIYf2VuyISsY/G
 wyAup28kDLBGRQC0wBspqPdrkHS6Pq13I/w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35aj8w0r1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Dec 2020 17:26:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 17:26:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx9sfBRBWkwpdBt0fB8cIVg8Pn9In0josKorX1mE0ap3xHndX10g2p1DvaH79q6C3Y6x4mzLIDzg2/0dnKfKGeT1HezQso5BTqJ/UuBSmRZ+CJJqQ5covnUBtirSl7lfk/NweGqcvhss33Ors8CWx4FWpM/wlVH31uj6IM1OHaJb+owV+aMR/bPyfR4Rk42RLslw152FcTXA59x+nTGHoigLGnweX+3o8BoCwSJ9DIalZaV55xkcgPzj1MBqtCCV7jgr9jZL1HWiv8sV4fdtBDE1QDXZmlAVYHT1qRZJblT4Bnd7O/7Y2tHMwFWJKI0tpIULnQn3Ed7cHJfKIwMr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz1P5J4dmHkWt72EGPHAvVibvexttbzj2htUvkyJGOg=;
 b=daywY10fmKYWGTY+HIn9n8TvHEoXo5MKwEP8lioZE+LlBUXZLA1xJTdof/Wo2Mh5mn5FHAIMuAxRkazqZoUWZ9FXqtnkp7BE7g126uFXumGcu8FP+Bp2CHPPnGY1yjK6UQCjkMskmh7x38ehsyGYpf2SnrbNKh8Gfl+RaoX65ueWon+lD6HMb5OGoS2XFb3RpC1Wi0GhP/V40dQnre0TmlBYcn7HSca62VtiBEwjl8x+t0e4k30hvgD/F8ZgfxO4kw3/KYxr/r2XrQ6oggyc73lkNB3OE+eznC8uHqeEktXNyopY4m7xacHlzZfx67zlqnJhpnGDomvmODeTPm2sLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz1P5J4dmHkWt72EGPHAvVibvexttbzj2htUvkyJGOg=;
 b=NmRVQPh2H6+mxQBmCpfmAMUxYmSqG9+iT+F7zoeJOyhmcpbCUmXfk3/cNB5luF8eE6wcEY8f0o0P4ain//rinLC3trvLEs3dssw+GmRDC3E1ymmPA9AZq+GDdrF8I68BZrxIllr2GUat6Dn/ab/ZaCV/gSWKDcxFEgqS48Oz/t8=
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 01:26:06 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.017; Fri, 11 Dec 2020
 01:26:06 +0000
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Drop the need for LLVM's llc
To:     Andrew Delgadillo <adelg@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, <daniel@iogearbox.net>
References: <6bdcc1e4-5ce2-7876-e48f-bce04f7298b6@fb.com>
 <20201211004344.3355074-1-adelg@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <de47d5cb-3fcb-9396-075b-07d8e4d7f9d5@fb.com>
Date:   Thu, 10 Dec 2020 17:26:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201211004344.3355074-1-adelg@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ca19]
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ca19) by BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.30 via Frontend Transport; Fri, 11 Dec 2020 01:26:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c7dfc1-021e-4480-3fe3-08d89d73bb83
X-MS-TrafficTypeDiagnostic: BYAPR15MB2648:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26489CF964853A3CB11D8105D3CA0@BYAPR15MB2648.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ct5SP+IngdzPXcRXS95Z1wIS6Nj+JiE+v0L4wnsPukljMI4GLMgknhndRHqI+FTMX6ME43/m5aYFtp7jpQnthFvynJK5Jfmy4gZ1gScw5msxR8bToQefgv+k/CXkwHyoVMf7sPYFt7imPWgXpm0j0eADI5BDQWYSKblJdQ6uQhvD0s4T6iSeoOlata0wV5hGeD7AWRunBL0I5CSZdwhWo85uri1c8t1gM7//OIVtdjmHWwR7eUMWj0LJs9GNQ2PlGrm+3yT6fZTm6L2OdOlqBC/541WZpVGiMFs4PinRYS+GptPwlYXkmmZCZvJyjeQp4Kjhou4x5Al00juGJ8DmUOoaqv2dV/2+UWZSAWjzdFPgsr7sEsoczQako6TKn+ngesiGxf1oCJOACB9tQzToRnzFmjY90RhlC7cJIhdDD10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(6486002)(66556008)(508600001)(66946007)(66476007)(186003)(31696002)(16526019)(2616005)(31686004)(4744005)(36756003)(2906002)(5660300002)(86362001)(53546011)(8936002)(52116002)(8676002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTFtQUtqckFTbWZtc1liS1pMbk1qUjBLQjJCSVhiNTNGQTNxQkRNUnlERDcw?=
 =?utf-8?B?U0k2WUNxTFJFL1NVd05DRzJZNkFvSVFCRmN6WUdvOGJkYjJDak9FeHBJUHNG?=
 =?utf-8?B?M3M3VjkrSEo5b3BIRmZ5TVVsYXRyaG0zRjQ2LytGWDBrdE1nQVJJZndXMW5G?=
 =?utf-8?B?dWFQS1FiM1ZvcVRXRExLbE1vaG41SFlnRElhK3lLRnZ0WlpJN2JTVlVJK0VP?=
 =?utf-8?B?dHZqaFZBclVNV09jaVdoeTduZjFML3NtVkl5VEd3VWh1ZStYN2pTa2xqVUMz?=
 =?utf-8?B?SytyamMxWnJsVmNUSGg2emtSQ3dFVm5BeVcrTFgvR1FTL2JkanRQN1I0Y2k3?=
 =?utf-8?B?bHhzazZNTFFrUStHVjBqK1hHZkJuWTZqeXMvTG5LQWJ6K1lRODh5MTVHL21l?=
 =?utf-8?B?MEhhbzhWRG0wbEw5bXgvWFR1U3Q2cDFUWUdvZUpESC92L2RuKy9JMlRyTlRF?=
 =?utf-8?B?aS9hamNpMlFyNWN5cWlNZit1MGVqU2FFZENpUUZuVDBXbzYrTFJncDlBZk9j?=
 =?utf-8?B?c0NKNXEwZ3NqSVNGakNURGp3N2MxdjlqVyswQVc2TDlCOXVTM2IyNmJRUGt6?=
 =?utf-8?B?NVBmNVR2OHJlQnJvZnVjNjZneWNYQ0YrL1hCUUplVjdlc0VmREZoYWNOaDNJ?=
 =?utf-8?B?U0Rjb1AvbWlEZ1p5RUN3ZXFrMzM1bDlzOWJ6M21vK3NZaFpnL1lVVExRK3kv?=
 =?utf-8?B?SFRsOFpNQlhJVFhqUlZBS0tlR2o3QnE1dVRZQmJKeUJYNXg2MEVWOWRubTdr?=
 =?utf-8?B?R05zV1VOS2lYMko1ODR0SWdtUXNFNExrYmRNUUxTN1ZzR25sSlBpTGRVMERi?=
 =?utf-8?B?WEFGNFkzelVveWFEbno2YW0zVnNieTBCcno2a1h5YUNMRU9iZUxKOFEyclhN?=
 =?utf-8?B?NWE2QUFQSHByR1B4ZjkxM3M5cmgyVVd3Ny95L1k4cURIS2IvZ0lUVXpLMUhS?=
 =?utf-8?B?a29aekFreEdpcDZ2czFLcUFzUVNNRWZrSERueHZaRXFTejNMSjZ3cVRJbk5s?=
 =?utf-8?B?UU9nQ2I1bGdTeHIyYlJQWHI0TkZBMWg2SXY4cERoNDhtdUd0QWlXaXRzQ3hI?=
 =?utf-8?B?d2FwQ0RtQ2w4SHFOcTFwdnZ2Z2RFbDFLY0lWZVlndUtiM2xJRFZaZjlQMnBT?=
 =?utf-8?B?NXFLY0U5L3YwMUJMd2FwTnd0cWhlOHJ5d2lFMVozb05jS2x4K1hGT0JTMGZk?=
 =?utf-8?B?eDYvM2tpZjMyeTh3S3B4am0rYWtFdURVc25lWkZOaG1Ud2J5VlVBekdEZUpW?=
 =?utf-8?B?OEZ0RkNncEhRUFFDNjQ3S2dGT0VpYUpjdi9JaE1KdkVQZGN2Slhya29iUldN?=
 =?utf-8?B?S0JDRmRNRVBmdEpKdVY0K2NXSHBjYit2T1VwRGM5d3RuZURZWlBFS25iQmJt?=
 =?utf-8?B?Q0Q3czdOR1RiWmc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 01:26:06.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c7dfc1-021e-4480-3fe3-08d89d73bb83
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4yH0XB+y3g9PZfy9iRUrxp5KCOVfkX7xxAz5jXW6OBfZhYZiNTGJ0LrcCsA8DEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_11:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/20 4:43 PM, Andrew Delgadillo wrote:
> LLC is meant for compiler development and debugging. Consequently, it
> exposes many low level options about its backend. To avoid future bugs
> introduced by using the raw LLC tool, use clang directly so that all
> appropriate options are passed to the back end.
> 
> Additionally, simplify the Makefile by removing the
> CLANG_NATIVE_BPF_BUILD_RULE as it is not being use, stop passing
> dwarfris attr since elfutils/libdw now supports the bpf backend (which
> should work with any recent pahole), and stop passing alu32 since
> -mcpu=v3 implies alu32.
> 
> Signed-off-by: Andrew Delgadillo <adelg@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
