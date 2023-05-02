Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0B6F4A3E
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEBTUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBTUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 15:20:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B1A1BD4
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 12:20:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 342FTlJK009353;
        Tue, 2 May 2023 12:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7lqLT22tGCoGznzzjbAL5KsGpr3bYWXm4QgLcwZo0UE=;
 b=da0KL4ONemq2Bl5jqto7AGrKX7+3Cvd3qFKtQDRBS8UsxNymOlqfLj2G8W9OdeVoxq4i
 yaOC84awBQCMy7s+6p3z5Z4RU0BHw17aGMZOsfzEslhJUffhJjDkK9Za209zXzi78BAY
 erNRUa7eqGavAP2PFcbmr3yDBHY0m2Fj86QtI8lPR4xN2ffq9NR+A+qi/OgVKyL3vblJ
 o+E0EdHrMBzdoox3L3i2romt6kkScQrcaRyuRz6Vx5gbOFWMmY5gUjhwMkJZ5jPg7SOP
 j52AFfZZzoCTWCO4DOk/yBHle29l9ThS9XOaWMf/1MBFg7y5ZcbC3/WeycKARDGT7F4d +g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3qas9bp3c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 12:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9zAVYXC5ypWUq7YXqEIZ09JnSekdSk8el10nWEqO4hVV4owhf2j1A9bxQrMiX5Ln7J0R+O9sJHnVVZUdzkJ+/Tgx/9ss/9uNyPkjz/wEeUCPOUOZhXrYkhPiBdOh3lYDGaY+kGFQI4IEj+aet3KexvZJcrYxsSEZqjjf98Yin50//v7Kh6n1wlyYmZhrqYDdn+DLqydpViEced21sSKdRNtGOUN3QCn48TZ3Tb6/NM4vEVybMGJSOZMw4G6CHECgJhHo5B9C8KPohqHKglGXaXSS08TR4D/G/M0Z52RTO3/Dht/uP0Uiw6N9KusrP62bu+Jf/cF5OY4wc6eSlFCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lqLT22tGCoGznzzjbAL5KsGpr3bYWXm4QgLcwZo0UE=;
 b=oGJtLQ0+XTScijVflJI5l+P11uHyiKVHz9vZkznT+LWbMdSB61fuWzStxJ/T6QRpBGRDA3szsXlD9EGotVWlUNzoglw9zgI5c2jAiOX1pvsC9UPCL/1+U6YKnL1JoubBrYkuQzLXkUVKgynEnNZq6C3J6xyDTUMkglaKLOPSizUK2DMg01JYVyGinRuuulUmsKEz3T6blnDdBMwrOxI7ota14m4yaw2hVzeCn7x3K7Hq10Tw8/lDNf6pb231pZsGW7O48sRZfhQFtHo76hIbPllFTh7qyYL05N8xuXK3X/8zBA2QvDVRqJ8thf/Yt2ZdOrKqtf8zK6YlHlRCCCm99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5720.namprd15.prod.outlook.com (2603:10b6:a03:4ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 2 May
 2023 19:20:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 19:20:03 +0000
Message-ID: <8b170d9b-f436-c8ae-ab10-751e253939ac@meta.com>
Date:   Tue, 2 May 2023 12:19:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Print a warning only if writing to
 unprivileged_bpf_disabled.
Content-Language: en-US
To:     Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230502181418.308479-1-kuifeng@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230502181418.308479-1-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f3a353-b9fc-47e4-9434-08db4b423aee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkhVY6NgXwv1PTDcc43iruudghYxD2jrzcpdc60ptUN6JB75Q0JZWo//JDr3JgLGBm4PuJs079uQHbqj7sDN09/1IrrFrgP7GTruUGpn181+RUAEz6plWQCbCxsWRnT0mKwT37XZ6+IIB6qFnNg7qrdZ0kNOQK+n5BRT15c/d3exaWf/A9LEFM0GksFtRbjO4fWFBdhliQAQw93DLbUXeMogI10qYeMABnWKN7i5lBPJgC0yB6hsW625W/a7TP4Gbk/sOFLalujW9yF6S/IfcsL8tidm0KTAjS791cEwN7GniiGWq1pMxVhnA482Oyyzr/Lj1EW2LYIJQN2IE0m6kXsNGnRihVqGVIFNttPSFtsNwml2dq8SzUBlz6ok0WZxVdy0eQNHmlIbqwxFDuTh1Nwd7KFLhN5dnTY/8oxS7Cxw/z4p4HZuZT9IeHjTaR/ogiOyMWlE4YRnoD94PtbVBXF6uCRggZoP+ljR9IL0CwrU+rvJtZ5FJLl729pbgR+McPjALCbvGSJd8Ib/x6pecuKqCnJUFGxggZNHATsVTUi5FwkH3wwTeApGpsSSVe+X6RN8dsg6hOMP+ly2rasRQQmSGyGjguK7x90S2dqa6jFG8KPSZV9rI1EmtWDaVqD1MVgkJOrvprgBPghXmFEmKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(4744005)(2906002)(38100700002)(5660300002)(36756003)(8676002)(8936002)(86362001)(31696002)(6486002)(6666004)(107886003)(6512007)(478600001)(6506007)(2616005)(83380400001)(31686004)(53546011)(186003)(316002)(66556008)(41300700001)(66476007)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hyRnRwQkhBZTE1YlluYm1rSmFQU2tHbUxxc3hjdmV0UWZhQkdqWngyKzZ6?=
 =?utf-8?B?dnVoVVFpcEdIVGQ3MHVCb0FpSjkvaWlITTVHVGVucXhjeFRQeDFWVDlSTjBh?=
 =?utf-8?B?cGhLSXcrSyt5Mll1YWxlS2UwaDhXNk5JWTBIVGN2KzF0VXJrc2lTVWZJNC9p?=
 =?utf-8?B?bHN1cXNKK2FzV3lUbEo2dDcxSk9uK1VZdVFmUHQyVUFuVUpURENqUExSakVF?=
 =?utf-8?B?aWtwSXkwYVJBbDVSN09KTXcvenNGdFI2YW4vUytDUWR6c2ErajlnMWZRQ0pZ?=
 =?utf-8?B?dmpJMGNNZXB3bzVtQ2JmdVBZeXM0TjM3ZWtoVjZnNWdWUUh2WVZmTUpqcmZV?=
 =?utf-8?B?cUhHd3RSWW1aM2hMYXRpRVdIY05pOHlVU0xjTGtINDVZVkhVOUNHdTB0TzJi?=
 =?utf-8?B?VDRvbHNacnpMZXRkWWlnUERxSTNnKzRDdGcwYURzTnF5ZVB5OXpWaENRNllN?=
 =?utf-8?B?UmIvT0N0d2NnQjhkRUxoN2xpam9ycEZBRXNtWEN6N2hZbi9ONmVRRnRVZE4w?=
 =?utf-8?B?eVBVb3F4d3ZhZkhyblhaeFp4WVVSNTJtd2dxYlVHeHhSL3psdXVwNkxId1Zs?=
 =?utf-8?B?VDBpU2haM1lrRHAyWHd2S3Y5WkJDMUZZaWc5bGMvUjJYVlRCeXc0aHQwZys4?=
 =?utf-8?B?ZEl4Y3ZxcVlzN0loSmc3VjA0d0wraFZ0cjRwSklmbEVVY2hzVUUxSXRjWlQ1?=
 =?utf-8?B?dzdYQnA3VGJ2YVpIbHpweXJkUDkxMG9KRzU4THUvais1MXdNamhHL0N6Qmx4?=
 =?utf-8?B?bnhhOUFOaWxnRGN0bUNaK09aYXFWNjJRNWxWWWd0dXpycHZPb2RHcW1rY1ZM?=
 =?utf-8?B?T1NTNUttMkZBanZiVzZCdTYrOE93djJucWpLTVJMU1dKd3owV09pQUUwY2wv?=
 =?utf-8?B?YXlickVaWkNNODF0QzhUWHFxdkI2M0V2bkpXeE5DQVpjUnFKOU1DYzBnTjN4?=
 =?utf-8?B?VFJxRmE1Qmd3OXgvTk5qZ0JuTXh3dGFhQkhTdTZUdHNEQkd0Nm4rb213SWxI?=
 =?utf-8?B?bkJyTkhvbXN3dlZNM2VhbjFnY1k4WGVjbkF6VVBDMks5MGs3L3pCem9hNzd6?=
 =?utf-8?B?YmNqODBoNzNQVGVKSHdvYXRuUG9KeXVyVGtxNTJLb0RQK3dPdStjRVEwenNo?=
 =?utf-8?B?ajM5N3hPaHVCOHpaYkxyWXBBZnVwUXVNYm5aYm1HVlNxNTZJVGsxay9MZ0pM?=
 =?utf-8?B?bHVzNHZnMGhnZUlMdVpGSTJ5N1c3TVA5Y0dHVHM0WFpXb2NDNGdvRDZ5WFdn?=
 =?utf-8?B?eVN1TU5va0d4YVMyUWZadTJTdXhUb3M5Z1IxSFV3cC95U3RSUlkzbkUwMXRF?=
 =?utf-8?B?V2VwUFgvaHlCWWFPMWNhMWgrNzNHWTNTUXdGVkFRWDVxRmkvMFgrRm92clVV?=
 =?utf-8?B?TGxyVUVqdEEzcDQ4QldBSGdkZjNuc1h3OC9XU211MVJDNHRJK0xSNmp3VUYy?=
 =?utf-8?B?Z2toRTBaSUpTRE9FeVcrb1Q2dTFiOGRHREVBRFpyajBBb2dJelE5VXljUEdT?=
 =?utf-8?B?MkFMMWRtbzhuZXAxMHN6NTlKNS9mUGs4VWFoY2hQMHIyZDQvT2diNFgvOVRP?=
 =?utf-8?B?bG42RXoyclVDekhUVmVLTGVyYlZIMFlsVy9ydFJlemVldUNUQ3hCNkE1V3dv?=
 =?utf-8?B?eVBudkZKb0RTblExcVZaejM0RzRFeTdGbmMvcC9GYVZSQWRPemVvU21QdzdP?=
 =?utf-8?B?M1dBTjUwVEEvQUQvdys3RFFud0VqdHVVS3R6RFg4bFo5ajNhMEJlU3RqZWVr?=
 =?utf-8?B?bmRIRFZ5TW5XZXF6WDFtR1lBSWcwY2dGbTRiZzFRN25rVG9xVHM0SXIyUG53?=
 =?utf-8?B?akIwc1pNYXJWU3hmRjUyajJIdkdoUGRtZ2YzUjE4RG4yY1B2b1NGT1dwRTZk?=
 =?utf-8?B?eFh6YTQwTlFZMDdIaDJhZ3dvNFdkSmpoMzZtZnlrUHhUaVhiYnp2TnBsSEV1?=
 =?utf-8?B?MVFqeWNRYmk2NUt6VE5zZU9WKysrY2U5WU9ZZVRPR2FqL2h6dzhlWFZDN080?=
 =?utf-8?B?R0NPOEZKTnIyanJuK1puWWVkNFRoNFVHbVRnTmEwbUhQdXpMcUhiUDY2U3Ri?=
 =?utf-8?B?bGg2SWx5NDM2QlpvN1J0ZGNUek5KMVRabzlwV05jRk0wSW02YmFVMWhZVWx2?=
 =?utf-8?B?aDFIWXJ5aEhIS0E2OU15WWhCMjEvcnZQUVlmSnF6RlByUURMTGx0L0xXbWFI?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f3a353-b9fc-47e4-9434-08db4b423aee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 19:20:03.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6X//VxlC47MzhXAg959zysqkbQWtZYdoTzP8+xwsb9DR3blq8cv9tFPWAr4TJCJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5720
X-Proofpoint-ORIG-GUID: 3e22SG1LgqQNORzfd3ggCrMbVQcRiMq5
X-Proofpoint-GUID: 3e22SG1LgqQNORzfd3ggCrMbVQcRiMq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_11,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/2/23 11:14 AM, Kui-Feng Lee wrote:
> Only print the warning message if you are writing to
> "/proc/sys/kernel/unprivileged_bpf_disabled".
> 
> The kernel may print an annoying warning when you read
> "/proc/sys/kernel/unprivileged_bpf_disabled" saying
> 
>    WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
>    via Spectre v2 BHB attacks!
> 
> However, this message is only meaningful when the feature is
> disabled or enabled.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Acked-by: Yonghong Song <yhs@fb.com>
