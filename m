Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94F52CA1A
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 05:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiESDMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiESDLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 23:11:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E633E9D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 20:11:30 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J0MoiB016252;
        Wed, 18 May 2022 20:11:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zqRlJ7kiQcXTya8K+zD2kjaHv8HBZuK257ntRjGSNfc=;
 b=Q9Te4ZmJBHKO7rqM+VO5hVMDHztDtG/KP96GNKNBgOY6USCbnBwpBIS3PXSr25/9AMkN
 WU1aw9bB3FpN9WDYnv1OYTdBsiMh30olxNlboqQg86lynxrRTeJ4iJgZA2Pp2FwIP83x
 0wJadbFhx0rnaZR6vYeMBDqDNiRdKmMMoK4= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g5b9vgm5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 20:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcQ81wxxI8mSNbsROCzHS2+LLAiwsF89yKAow7TqgmKlD5PsMtKobxdIh6g3cgiOPFKgGBdvYex+7B1gHI5t8nr7h9UerXSaEw6PwpqLCLGbPHBzt4uT0VAkSmxYUrxF/DroHkO6GThPFcvg82haILqsUR8EkbuigCesKC9aDG5NXMiZyO7213V+tx2yy+pvFrosIKdlqjcQhXc0fySQxpjKHdnd7lk6qMKS9A0ec9O5gn5WTsclIQtfLif5MXsp5/uKcTdF7zBV6D51MddF6wtIj200/0RTBMsU/tSn2t+EH2AoOqVf43PnYhBkiY3BLK53jVw9s+iWE8Wsi8jjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqRlJ7kiQcXTya8K+zD2kjaHv8HBZuK257ntRjGSNfc=;
 b=HAFoToK2iv6H/GWDEd/dcGNARH/p1x+luQIK8QPW8SuxzSvICUOWB0cqPyNqmiWg4Fr2sBPs+gB69V7T5Ag9zl7bECr1u7JmsUe6L7eDp2fgveCu8yRD4anzjRLxU1/WyCZfJMyCSFrTf6XgMIc6H/zPk1aMKloF0rV4HwW//fthgWuKavSQqHrrUbq9u4xgwmqhLAobM+mxXg/n61djDoO5wBM9iaoRAihPFhXXcsBugpH7aDeQ+lm6c3EfF2jtIXM25tpFxjTZbEVMaghha4c7aXgTYbrFiGeRnxjABFkImG9TwtwaCeTkUqqom9MroU6B2azsbNnRPgyuYj2zOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2638.namprd15.prod.outlook.com (2603:10b6:208:127::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 03:11:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 03:11:14 +0000
Message-ID: <bd942573-b4a6-039b-12eb-3e997cc6150e@fb.com>
Date:   Wed, 18 May 2022 20:11:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 0/3] Start libbpf 1.0 dev cycle
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220518185915.3529475-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220518185915.3529475-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b484a984-f38c-4b1d-fe19-08da39453b9c
X-MS-TrafficTypeDiagnostic: MN2PR15MB2638:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2638B79FF50C95B31186ADF9D3D09@MN2PR15MB2638.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJVCYnQomT409kFrtFBjMkF1naQzCEZWtiRONGtypTw25qXy/4C40fquF7F1hGGWBsEQGQBchU0j01BKoIRftRytv5Blp0LlVuBXcj6UmoF90yXlv8IGLIqxS0XkX5IAE4KSWGmwt0Z+czs7AK/en4ZWFG1HodwAcKjK+zirXNoJujOKpqjmQFJU7OEjvQrSuuqvAi86MzxbFsZzYMwcOyrl21B+SBxdJl512IRmMcif+5LtVRWlwei+RyjXyAWXIr4yEFhrWN8qLLNXnWks++iSGvXyQJ7/R5rFvW1dVFkejNsMl/RVh51KUWlfmvD+g5k0tv3ijcIEpF5siSoGShGRcGYWyABhZQXy4jrEDtceGqJ+tC2YlyDUVQHy1MJMS63rsPIfJRhoViwlJht1PkdeRXi80uMgswEmDAmVoCG9WCumGt5NbU6jVB7Rx194vQBMLEVJ3LS/UIlvUvDysG+iLD6v7SL6fu7mKx5xbxefNLZlrjtEUbIAGaJmyvCJyIJYCT7+NmD2sI4/1Oos8Hp4ZvPwh8TpbrMBh6+cdnKiPeAmUllBMaQhJfkUOwXMgF/pKYnuvxu/0eCv6F3JsIjLv1OZJTTUhARMnZSjspKGzVndEjm2v5eSI/QWNy8VWJi3CYVpHMWNt9DFUlzTUYaR3lIWRj9uHiMch3IEiamHVWCndPP6wpnIv5lDo3gBfQ6dRCLQDLxPYJgpYZG70pY2a+Sp10u51jwCheA6Huk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(52116002)(53546011)(6512007)(6506007)(186003)(6666004)(83380400001)(5660300002)(4744005)(66476007)(31686004)(31696002)(316002)(66946007)(4326008)(36756003)(8676002)(66556008)(86362001)(38100700002)(508600001)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NONndTTlV6TmVUdXpobnQwVGlLdnBmWGdTR3c5YXpxNVJzTGlOVjJrdmY5?=
 =?utf-8?B?NlZzTlE4VExDSzN6aVJOMmxZSFpyUVNndllZMzMxSE1rZ2VJVUZVUWc3VXc0?=
 =?utf-8?B?MTAyd2JxN2txWE5DeEQrVEdOTWc5SVJHakF5U2JkNnhFR2REdGRyVXkrWlZV?=
 =?utf-8?B?ZXM0TDAwNk81VkpmMlJGbjZESEFOWGcxbXdJd0JLN1o3K2xseExMNGV3cTdT?=
 =?utf-8?B?OExmVDA2NjVTUEdXemRlaDQzZkNKRmtGVmNCVVdlUUVzOU01d2ZhSHFnMzRq?=
 =?utf-8?B?NVpXVlZwdU5uTFdPR1JObFZyUjVheTJUR0crVis1MGw3aHpFQzlsUXZnM3JP?=
 =?utf-8?B?ODNpTWpWNjRYYmtzdVMxSkdmTjdQRnQ0OEc4Z1FMMmVlSmxES0x2a0swU2hn?=
 =?utf-8?B?M3BkanhvaHNXR0hFODJFYWZMRzA0V0dDZ2ZOeitjRVM5M3JXVWREUEdweUF1?=
 =?utf-8?B?OVRCT3dJeFFwQ01UTzNpYjNpdkVCa0tGY0s5Qm9ObWUzSmQzZkp6OURESnZx?=
 =?utf-8?B?NDJPbXk1My9pRDFjSG1UQmtKMTc4Wkt1MkFZM041N0tPNk54SW05eHFLL3gz?=
 =?utf-8?B?bTZ5MzVBNW9OeTdrVWJFM2M1RjlCNWUwamlOL2NYNmkzYlBZRE5Xa2NYNW9F?=
 =?utf-8?B?WUhqMUNxV0syaHhNQThsa1lEeG8rWmpxWUsxS1RuVkFXelg0UnFEd3BuU3JQ?=
 =?utf-8?B?NGt3SGFhZEZ0cEk4bTZCNGU0WEd6YnZPYVJpSEd3SUM3dlRWaC85MFBKUGJx?=
 =?utf-8?B?MlBBMVhCYnE0L3ZDVEVJaXF2b0dqeU02Y0dzRWh0T2NoMnhhYkI5Y1JsV1lD?=
 =?utf-8?B?TXA1QjZ5K0VIdU96SXJOeXhxMkowQmt2UnJXN0Rmdjlrd2hvTVpOVmRKOFh4?=
 =?utf-8?B?NVBKZ2hlb0xFWWJ5NkdtVXlsTTN3ZnJJNk5adTg3YmF3Z2JyVW1rY2lqbEpI?=
 =?utf-8?B?czlSWS9wWXhPMWdxaXR5b2VuYTZlb1dyYlBWZFZjYVJiTzE2Si9aTFZ5QUZU?=
 =?utf-8?B?bVNXK0ViRStLOHdoeXhsT2cwbGVsbzIyTjdWZVlGc2l4VVZzRm91K2daeWNY?=
 =?utf-8?B?WTFEVlc1VEgxOXkwVDB5MCt6Y0d1eWZJcCs2NW9GME9aVkMydUx3NVhicUFX?=
 =?utf-8?B?aFdCVXRpdnJ1Q0FiSUpqSEZVMXJlSzRNU2I3K3NuK3RRQlZ5Z2krYXd5NzZs?=
 =?utf-8?B?OWlGUUcvNTZuNFlFajJTZlRacnB5UmMreGhwTjBHVnlMbENISi9uY1lZRS93?=
 =?utf-8?B?TFpGbUt0bzYraTFhZG1BQmdBL09SWm9iV01YSHRJM3hKSDNIV1NjR0duYW9D?=
 =?utf-8?B?eitXQTkrRXhPbFd4a0lEZ2k2RlZIRC83b1AySURXMUxnVFdxb1hqQ3dDbWdo?=
 =?utf-8?B?VUdDaXJ4RmdGeWxpNlFCNXVheCtudzZEbUhvekNUREw3cEZ0NHVDbnBMZU93?=
 =?utf-8?B?NGRCalNDODFnQ1p6MHNWMjNRWHlDWkJZNzYvNkpOY0x4NldyL1AzSjB3SUdC?=
 =?utf-8?B?dGpJd1RaMldTenFhQWsxTWFmWjQvVlNPZ1J1Ujh1UmQ4WkpLTExucEdYYXkz?=
 =?utf-8?B?bXFSeHVUZVFSSVJaa0ZVZjl0UFFmOTFFbVZ0RUllRnpSZ282dWtvQUNZTkNR?=
 =?utf-8?B?elF1LzUyWVJyMWw1bFhwb2hxU2J2Zi9YSW9Qc3VDUHFUMHdhcTJwNHNJSDBx?=
 =?utf-8?B?eWV1NkNxcHlOWGJnY2YzWDZQK0tzK3hNZHR5V1RXWi9jVTdXemVTWktBN0Zw?=
 =?utf-8?B?UFpnY2JydWV3NzRYRWdlMEM1dTVkUUk0bzdjZE9WbFZNUW8veHJESTBacjlJ?=
 =?utf-8?B?UTN5dDFXUUFPMFFIZ2hQaWxZeHB1Y1RyTmhPang0cENNeGQ4V3RwOHMvb3JO?=
 =?utf-8?B?RnpSTFN3aW4vYVNTYjlwRG9wSElaZkE1T2xkOENmZEZWaCtKZVBKOVBqdHRj?=
 =?utf-8?B?L2ZOMVROVEpGTGdGWkVJNmhMOXpXUUxST2UxMktLbGJhYlkyOEFReUFXaDQ1?=
 =?utf-8?B?VDFMc2g5Ry9LQUoyZHFIZVhVeE95N0hzQm5oSW8wM1IvSTVoR1ZyK2ZWV1pj?=
 =?utf-8?B?TzBKU05WODNocUJHOWlNVnVGR0lkcVZCVlJFQkxTQytmeG9IV1kva1F0K2Jo?=
 =?utf-8?B?SEc2V2hsdHU2V0pnVTZUWHIxUHJuUXVXdmJZOGVCVFYwc2lTL1B2T2FlVmZy?=
 =?utf-8?B?MVlTWTVtU1hGUWZoWlRLelJZeENqTGhUSlphVm9vZ0VJejdsRDl1Y2d3MjA0?=
 =?utf-8?B?T2hUZkRnSE96RnBrdnRQVjhXZHROZ0l3TzZ4cno5eUVzeWh1bjB1ZEExbXJI?=
 =?utf-8?B?ZnUveDdDUVl1NHhPUTVaVS9NZzBhQ0JrcVVFNkhkSjJ6K2diTGJWMDh4ODZv?=
 =?utf-8?Q?TDkzwX2oEIYoER5I=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b484a984-f38c-4b1d-fe19-08da39453b9c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 03:11:14.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my8isX0dipyh0WK6C8CXP2aMGIZ2SUszKTcCbI6JnHpg3Jc+TZpT90rf0vU1Vtht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2638
X-Proofpoint-GUID: PxP8tzZog4adKtGENMDMoKFdDDwYbCuU
X-Proofpoint-ORIG-GUID: PxP8tzZog4adKtGENMDMoKFdDDwYbCuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/18/22 11:59 AM, Andrii Nakryiko wrote:
> Start preparations for libbpf 1.0 release and as a first test remove
> bpf_create_map*() APIs.
> 
> Andrii Nakryiko (3):
>    libbpf: fix up global symbol counting logic
>    libbpf: start 1.0 development cycle
>    libbpf: remove bpf_create_map*() APIs
> 
>   tools/lib/bpf/Makefile         |  2 +-
>   tools/lib/bpf/bpf.c            | 80 ----------------------------------
>   tools/lib/bpf/bpf.h            | 42 ------------------
>   tools/lib/bpf/libbpf.map       |  4 ++
>   tools/lib/bpf/libbpf_version.h |  4 +-
>   5 files changed, 7 insertions(+), 125 deletions(-)
> 
Ack for the whole series.

Acked-by: Yonghong Song <yhs@fb.com>
