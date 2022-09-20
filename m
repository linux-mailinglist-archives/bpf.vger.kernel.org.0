Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A75BDC32
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 07:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiITFTc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 01:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITFTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 01:19:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A0B26;
        Mon, 19 Sep 2022 22:19:29 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsqw9007713;
        Mon, 19 Sep 2022 22:19:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uta79EeuqSVSIK2k7tRMnn1enJbetque7htxhnYDcZE=;
 b=rAXT3s2GlXhPUIDYjhWshMBCyXQZ7wmo3vRl5/gyiI0GR+/YADwf4466Fr3qObEuq7C1
 An4npUq6zlSpCF1Vikzmnmv2K8lInfmpGJ1/j6oNoqLx9oTdBqA/0qqbAVmdoh+SvMoX
 y6UuLKvWAsQlhGhXpPnMIrgbJI7Iy8j1FC0= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpmfxr2ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 22:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nchxlasKrgJwgc969pWRwzGQTdfMuo5Un1+qLCNVVkmZ/E+0JBvf/ApvVWwjx4BKrGlRQTEeuLlFQrieAeJZbdNd69QU5ypXPXVsssRaGkEKcO2WpM07knGi/bhuBMXilcMA+yMnmbF/0r1LCzkLRBZFtZBVTt9sFXYK5kdCvg+GKXTmGLNFFLolA8pOFHubx47KzCQNp40rY3qn2V4aiXvqLT0rqsyXPLW6adQ7p9r+RpWP4iCzAQUNx7PFNSp7WoPO0pQqpZBJPdfkK8EugNr60Ek5OsxvTdsEQGjqfgsw19f3sY9CSk2Mm2WDW0XihOpaaaEEOFtYrD3vhZjiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uta79EeuqSVSIK2k7tRMnn1enJbetque7htxhnYDcZE=;
 b=jRgykjc2Ow0QyDFnMzB900KZWRooY8YBVlrZ89dJUET0AOKPdkKeTN7iykpYw16KNGRogCJRLESatyzU2wuNejzeZXz3D8YKSmt5HQGdUHUcjdLl6+/2+0vBhmAPoOVFSLpn5fLSbLc4ArKZquuHF6vSGN3kYYOUDDJwIVPdztgDBWDJrS2ZSuSOhPpoZgAP+yspCN70CA8o1IKtRzWPcpiL617LmGw8t69Sn/MfBUNE+7vLq9lkeQeCrD9QiB6puWRK1xn9+fzTh09wfJiqVJqBdomLH+DQ5xIP+JWiEEHuZ2R2Z1yLQbD+ezUx1bvG6SkR5NtMilv/sxZyVvqY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4611.namprd15.prod.outlook.com (2603:10b6:806:19e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:19:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:19:02 +0000
Message-ID: <be8c0b20-722c-879e-15ca-649b559a7396@fb.com>
Date:   Mon, 19 Sep 2022 22:18:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH -next] bpf: simplify code in btf_parse_hdr
Content-Language: en-US
To:     williamsukatube@163.com, martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20220917084248.3649-1-williamsukatube@163.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220917084248.3649-1-williamsukatube@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e299d1-8058-4251-e8c1-08da9ac7a14a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWgctpeaka782wCXrvPZwdRt3/qbOfRpHCPRA4LpJCnY4IrqCJ+Tjpgjd+lgpXYcGuXuu3/DHvxhvaEjxkqW2KrvkB0DLhj9y1pFJFGNPUToMJUAGP0cWiyK5r5bEj/wiIkvOEuKGv7YLLgWS3wbsrXQUsnDy68FqaDpAOfdYQi2giYRnDwob9OQdwvVPrahmIQdsio+xlLJypDpO11QdYjpcMzdM5r7R83x0LUDFsLhT3gueuN0ayEokF8EMMfWpmnh+JdaCFzumh/RdgvEr64F6aauP66W1OTNrsqY5POiv5qjfR4D6GUTOW192M6q2oc4kgStf4asLtG5vnIoPDiosiMj//0FVkXSFFi02g9m2D91tQT4sH/PQ5XxRINJ4TV6CzPrYIsk9cFjNRHKb9HsvgafMFNB2mqGnqHyuNkn6v14Vs525nNXupxiLqfr7TU7AXTg9kKfEC4R0HEF5MZmhAqRDTYSYjGRdeMJUHq0PjLWgEVckFQlQ4FX1kdYr0ksmIMo3JYHhUGNPip5O1JOIOFiHKqeZouZ2ijNvngubFX3J/WEcA8NhPg9DSKGGn1mPk8BmVojxrXr7gQSoBW+JzaZifFE433xA8UM9EDo5RlA2YiZJPYqAj+4RHu6rjKc/MI6JW+YbZqkN5WSzoUtlXgM75yd1rZZoo0xpEShLTdhbFGOWVzy+uqj2aqy01f8LoFqfwQUl7mEO1VhY1LlsFRJtDhM7spJZrZsMSdxqoDxMjenDrENM/XJ46rd+FMQ8bfzptuuS4Wmq0z97YrVQWzU91Pv04db31u/vto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(5660300002)(2616005)(6512007)(558084003)(86362001)(31696002)(53546011)(2906002)(186003)(316002)(7416002)(8936002)(8676002)(66946007)(66476007)(66556008)(38100700002)(4326008)(41300700001)(31686004)(36756003)(6666004)(6486002)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdJSFRpQndaQkFGNEg2OFdtZ3FmNlppeDRGZ2ZVd0hVbS9wSG5Ud21GcDJo?=
 =?utf-8?B?bm5aREJKczE1OWZVM2R4eWdFUzZiTTdXNkhlTUppKyt6ZC80TDBlQnJ0S3RU?=
 =?utf-8?B?MitrTDd3SVVjY2xNRWEvRTZZaFhKNmNwN1lScldCUlVMNmkwZmYvODRoa0tp?=
 =?utf-8?B?T243RXI0Z28wSTdCNU1pY1RlZ0t2QW5Nc3B5Q0MyeHlYeGFnM0JvUXoxOUNn?=
 =?utf-8?B?WG1jSDZRZy92dlBtN2Z1UkNJREJwZ1J3TEM0RHUraENPSUZFZEZYSnNjUzll?=
 =?utf-8?B?dElYNUdxYkxBU0xESVd3THpZd1hxeHJwcUFXcGZ5L1VjQlVIb2FZbHg5UkFw?=
 =?utf-8?B?aDVpUTNvN2M3NDhhRC9OY21tdUljUk8wMTRla1g5R1NvOUx3TUNwT1JCMXVN?=
 =?utf-8?B?SzB1dzJmN2t2V3ZTMTF6TG5Dem81djN2VklpY3BoNzhhblZ4K29pemIvdWJ1?=
 =?utf-8?B?SDIveVFlcktoa2FRZFFMWmpJYm85Tkd0elF2bTJOdzkra1RPMGprZXBXaUVi?=
 =?utf-8?B?SldubG9oU3VDcGhBOGxDeTY0a29xcDNnL0pOb2lhbE1YSmNNL3IxWUlZajR6?=
 =?utf-8?B?VFhsa3JHRzVlUVJReHhPYnNhRDl2dWQ4QXdCWnM4WG1zRnFOYytrbmhsS1Rk?=
 =?utf-8?B?WSt1ZTg5a0dGMFFjS21zMlprTkM2cXA1WlZTRC9KWDNmU09FYzFRdU5scGFG?=
 =?utf-8?B?RXRlcTNpNGNvQzNRdWhPeW96SHRwaWZPSTFRRE9iRU9UaXl0KzJmc3Z0OHFI?=
 =?utf-8?B?QTc5Y3FRMHdCOHgwaHIxYnZoVlhvOVNFK0lBUnZHb1ByM1JPV1hQUFZ1VWNZ?=
 =?utf-8?B?WE85QXh3Y2REOVQ0cGVxVHVvcUIyWmUwcDlscEUycytQWVFBQUxLd2xxZWdX?=
 =?utf-8?B?M2RYQ0VhNkkrSTdnZ3pOdDUwUU5GVmVnM1E2YlZ6aU5zOWhWeHlHc2hESjlh?=
 =?utf-8?B?eFpIajVHSFN3NzBlSVhUZmdCQk53azBXa0ZmcjdBWlRGZ1ZSWkQ1N3paWnpn?=
 =?utf-8?B?QVkxK1Q4bGdNUFAvVkdUTmxZeDdCRHZhSWM1TWRObXB1YkxOczlMYU5QSDhh?=
 =?utf-8?B?Z2pVQTVCWkpFZUJpV2F1UU15WDBlMlJhWitiR0k4SFllM0ZkVEdOVU1OMXZO?=
 =?utf-8?B?VWJlNWQ5Uk5BZFBrZXBTMkc5T1o3MHRtN3hXcG81em9SbmRaV0RqQkFkK1Ew?=
 =?utf-8?B?ODdueEtTUXg4Rnk0OTdQb0ZWZStEYjFmOHZ4VHQ4eGJYY0ZHa2RDOWk1dWp2?=
 =?utf-8?B?ZjdOa2ZUL0VVTVA5UXMwQnBkMitnanpXS1dkanlyeDRHUDZvbEhSVmZZU3Ns?=
 =?utf-8?B?Yk9vRU1penZCemdiaWdKQm4wRktGMFBRdG5iNTYvdlB1dlBiUUR1cHJyN0tF?=
 =?utf-8?B?NWxRRUU4U3M5a0w1VGxhMnZKYkpzcktBMmxvNkpCY1ptdjRZQ0JVaWY2WmRo?=
 =?utf-8?B?V0hDL3pSd2RQbFRTZFFRM3k3NkF3MnhLZ2NWaThGOVY2WmhOSi9CR1lDaU03?=
 =?utf-8?B?VVVYR0VRa1VJOXh4MHh4UHYvQ0RpeU16MGs5UnAzcmV2aUdrY3prOU02aUh2?=
 =?utf-8?B?T3RXZi9LY05yejh1OTdnUnJVZGlvNTBQQ2dPNDFocXAwaFpMaWpxYmlRRFFn?=
 =?utf-8?B?am5kRVhLY2Fld0M1ZXBUaWdFWW16U25HZEFRVzdqdWRJNnpFdGpnSTFIZGcw?=
 =?utf-8?B?ak1jb0pmelNBUHRwVTJkdDh6L1ppVVFGZ09seE1JSXVoeGVJS2toNU5kWHk2?=
 =?utf-8?B?T3VRS0FyVEE1WFJYRHpkSVN3SnVQTGROc1MyVDh2dXpubjNCZXhIUk5ySVJ4?=
 =?utf-8?B?VFkyZGEyK3Y1Z3NGL1hsVUNWMDRvcDIxNHFiSExWY0Z1TVNmYWxyNVoxR3F6?=
 =?utf-8?B?MUhuZDhuaWxYbXhaSElUd1IzRXJsTkFHODE4cmttUms2d0FTaXkrVjlJMGNp?=
 =?utf-8?B?WXNTUm12b3lHa1RHekZEWC9kMERRVkZaOEdPaWZXcjB3dXpDcnBYc1h2RXQ1?=
 =?utf-8?B?OGRxdVB3dzgwMFErbi9UVnNYUmZEYUhMbmtuQ1ZNSUxjY0dBOURKREZJd1Vt?=
 =?utf-8?B?Z3lkQVhiL2JaT0dCRXRFL3piQVJWa1lWUnJvOS90cWxmWGYwb2pCQ0dXTjNo?=
 =?utf-8?B?djBCQm5FLzlxVVozZUVhNjNKdHU2MmZ0RlBnbmVkcVFIME56bG5Va1hZcUlN?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e299d1-8058-4251-e8c1-08da9ac7a14a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:19:02.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0OG4RMr7GwbPpCQc5mLTmRUBy42skSy+WqHhoOVb7j1v/JcWE9Ce5zzfS806+we
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4611
X-Proofpoint-GUID: REs4zWxQaVAcmyg9mcqxwb7Bgk29tsS3
X-Proofpoint-ORIG-GUID: REs4zWxQaVAcmyg9mcqxwb7Bgk29tsS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_01,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/17/22 1:42 AM, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@163.com>
> 
> It could directly return 'btf_check_sec_info' to simplify code.
> 
> Signed-off-by: William Dean <williamsukatube@163.com>

Acked-by: Yonghong Song <yhs@fb.com>
