Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA36BC304
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 01:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCPA7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 20:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPA7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 20:59:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5F1F5C8
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:59:09 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMW3FL019664;
        Wed, 15 Mar 2023 17:58:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zBLqUB2cMWeCyy7SEw6it49ZAY6puQ7Ev8XMn99EPcg=;
 b=M1bW5zqVM3LxD3FOfQGbaEehn7x2lUlSexgIVtQTNa9pA4/Pq3ki5qMfg3BKWUOdSPtH
 0reMSHt/PJa2C2Qw7v46nbUaxWAPnVpkQbT6xF2IHaGEgsSDCjTdhut8ixNsVhNMt44u
 ws2dNHwQ1ytz4ko4iWe1CbqSR1Saq75CtS2yo2ERKUa7RQ/4kNSqesXd0WbsgLjnwZHg
 zGNfT4ve2brsabA+fkvSlmMRi01bbN1EwthQ2zqKmUMNvkEAktF+b/UiwwErID4/Lc6w
 6yf76bPQ3IWoFt7fBobw2XqtsOErOI7LkvfkDsnuPwsU+CuL8YN2EgFJO8jbUWS65+3Z NQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpw50p1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2t6C9tsPuDRaj3GOzKqyb2mkBjZaZ7/ZKvMIaEisY3IVnYJSyvfDs2BkslN2jqiwVcvGqGNtLBXMsPinQY3xvso8z4dpfy8UJVWViZbtICa/NWvVMHNrI80GOJJsN4p22wCoqicSMwlsspgER9bKNcN5fc4vrnoAxJUzFvHsuDxZWzdNfd/hdwxfJvNUkA7Frgxpskes/GnFmmlwWlQwpqlfqR5Pq7MlARu3/THVlNh3mEfvBYwZP9fJDLiO/7e4J7AzrmRoTyMH8aOv+Wkhuz0KTi3zBycHSfRT6qw3kkn8Jf2kG4rmtP2Mgos5uugv+voKKjSfkci8bDU4jHZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBLqUB2cMWeCyy7SEw6it49ZAY6puQ7Ev8XMn99EPcg=;
 b=PPDkaoqC2mSl+cBb5rojOQZGY3OiV4fH4hUJWQku3NcsT4646v9cI+nC8/fH6Ah3X50NtKyoqcJwA1G3rkzREYk2LT9oPfQh1LWXKn45Qnp7h9PqFjiCsPcexR3fUjngjLc/u4G0rbkLynU6ysCziTeD8Wu51GutnuiG4KM/zm8BlnHdUo3pKgpybGH3qve5bNrImGSen4uZdaUpwzcv7MRgjZLX6+9MoAz2AASGZrtsO1eBRLEv4ZotdAltzmBAl9iwhDSBKZIAZI7BiwqjN1Y/aVpqIF+HjBJSrD3aYUed9jPnXCzR8NtHT2cKzwqAJtHBTUYx29Ga5RQjgKDEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5122.namprd15.prod.outlook.com (2603:10b6:303:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 00:58:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9509:699e:24e0:339e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9509:699e:24e0:339e%7]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 00:58:43 +0000
Message-ID: <e755f802-be5f-073f-bdf2-28bbd93fd0ab@meta.com>
Date:   Wed, 15 Mar 2023 17:58:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix a fd leak in an error
 path in network_helpers.c
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230316000726.1016773-1-martin.lau@linux.dev>
 <20230316000726.1016773-2-martin.lau@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230316000726.1016773-2-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4da953-e3a9-45a5-bfa9-08db25b996c4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZfTMrZZx1D6rmUNOFo81L7elLVjzN+NRX8N5z17ohtSL9usn4n4vUF8F3yfciIGlAW1gN7U8zAtxTeC4hLzo0AdNqEuHxHAUWtsMzaJeFZiq9Uj2khyX/Mbha4dGS88LPHsPnHIca6Yxd2B9GMRdrV5McBlhWXTKyZSEnuzwk+y3K83IY+OYcIKkTnQHxaruLZtsHUKumBhmRkEERMtrvb0WvOpXrNU1uulCYJjw9UNjtN7rZ1UUX9aCtLBkKXsE23l4v1vZqj9tCCop95mpyUEUt22A7RoHYgDAKepGytGEOG44fF/rvQbFyJYRiJ7mV00xjX8ygnQumdKzn5YKqZZR3Fk/ipPTeV1cmmqAgrje2h4wHy/o+TqfR6/hS5S67QHCnU8aa4+Gl/TeXdk5dgXpf2KhH6tyuuIKDlkhZUy00KlUv4EihYSlXVer1HQVwSucAc05Plq//goHiV2GAskxsXunVD/FZvzGTiayqbfCLdZeKX2OuFbIe8EnD/0k3o8fugkx52sxm+YOtpmS1QZnrEf198gbokg1aplj5ecjyeNaO8Cxjp4g1Vi9TgmLHttzYtVWFFdmYPFmCawcZyFqgQq4y4TWYzEU5WdLukuHkLBZXOlmm4TFLDhZwJQHPEwLewvzNKZYVIdGtHog+ulRhjkm95VuwCVOh/xqyD6ESA126nfVVgtUbE3iE4Ds3Vzdbp61X6f1Dxq/xzARj6OSNE7kjt+ysOJ1GRG0TA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(36756003)(186003)(6486002)(2616005)(53546011)(107886003)(6512007)(6506007)(6666004)(41300700001)(8676002)(66476007)(66556008)(4326008)(8936002)(2906002)(66946007)(4744005)(5660300002)(316002)(38100700002)(86362001)(478600001)(31696002)(54906003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNlcWt3ZmJ0VU1uR3IyenpqV2dEbklwZFp0cm0xeHJWY09PemdrUjJ1Yk04?=
 =?utf-8?B?NElmRlZETURQa3NxWEh5U21kajVVSk1MMitUODVXaDdoSUZ5eEpoOGxXMG54?=
 =?utf-8?B?Z2J1alY2VDc3L25NNVU2R2ZjYTNTODU2d2k4WTVwa2Q3L1J3cHJVZHM3ZUNV?=
 =?utf-8?B?aVFDcW9GSzZ4S2UyNnNvVFhzbzhITU1xWE0zbmJUaldLSTd6ZTMyVnFGcWZo?=
 =?utf-8?B?RGozcGhEMktoNnI3VEFzWmRvampUbG5vQXpWcE5aMGFPT1pQT3Ezczk3YVlk?=
 =?utf-8?B?Vnd1cEg3WURDYWk3cGFDNG1mcWd2ZkJSc0htb3dUSU85UUJyZzlsR3dOcnZh?=
 =?utf-8?B?bWRxYUw1QkwrblNSeXlwb2M2QlozK1BJWUhTYXJJZm83NzREcFBsV0xUbUk5?=
 =?utf-8?B?Q1hpbjVKS29jRTR3ZU5uejI3ZWFJdEErMlp3ZUtFSWN4dnptdHRmWTQyOSs4?=
 =?utf-8?B?TlhqclpwSS9haEd4WDltSkZmQmtDWWVPVklubkdaRkh0cUE2RlIxN0NuTzdm?=
 =?utf-8?B?TkN3Vnl4MnBTekdKVFNyM3l0YlQ4VDBnb3RFeHk4VjRzVGo1ZWdqZEQxK1JB?=
 =?utf-8?B?RFFrOStGR1ZDelR1MFpVcWp6T0FwcEFDMlliSzZqbFFudFVqWHJRYXd0cDl0?=
 =?utf-8?B?VUdKTWx5NTh5ZU01N2lHWHpUT3hzcGFySU93RGl1cEhVUTliTVZxd21wbHJ6?=
 =?utf-8?B?YVdTZkQ5SVI5SWJJcFdyMnpzczA4b2lVTlBqelAvM2lEeTRwbEZadngzQ2lp?=
 =?utf-8?B?SFhWUGk5L212SHFKM0pocWNuWWNYd3diV2ZQR0d1Uk5GbjNyNVJnOFlqVFF4?=
 =?utf-8?B?RStXZkUxRkl5SkplWFFNMjdCY1NBNDBYUXR5a3Yza3dmMFd5RVQraDRQdDBn?=
 =?utf-8?B?UGZUQkl1WDhKWmk1ZXY0T2xpUGR1OStCcmkyUmJmSWpBeW1mRkRZYm1SL0RO?=
 =?utf-8?B?cGxUL0wxWEF2OTFFK2UxM25kTWxoVlk3UG5aaW1jMm9xSXRWczM1a1VXRFpO?=
 =?utf-8?B?aFFLVFZKT3FhOHNwNm1LTWhUeVZtSnd3U3NFYXhFWGtNYjV6TFQ3ZlR4ZTAx?=
 =?utf-8?B?ankrVjkvWFlvS05tL1BFYnJobGFVaGNMeWVha0haUnRWWlF3cU9mVHEyUXpj?=
 =?utf-8?B?ZnNLSnNNaHRERG5yQnIrNlNvMjJSTUNUcWtPU1BBazd4aG9ZTjc2QTdEZDcw?=
 =?utf-8?B?WFpNUnYrb3hTVVVHOFo0bmFPN2pBL0x1cys0VTlIS1FMNi9QbGZEV0NxSVVD?=
 =?utf-8?B?TzEwU0ZTN05TeDM5VVFpL2w4dklDejdoOWRQa1d4MmlBUTBqTU85Zmg1RVgr?=
 =?utf-8?B?Z1QvVHBOTWVtNzlRZ1JUV2c1dysrREw2RzA1RGgwUzhnVitBRy9LVzFPUS9q?=
 =?utf-8?B?bFlTL04wbG8ySVdBU2V4bnhlMVhIWnEydGNXcExscTlVZlQ1anVVZDJHemlh?=
 =?utf-8?B?bEhkWmhMdXMzQWFGZ25qZGg4YUROQURJWVQrbzlublRhdHJ5akU3NnNRaEg5?=
 =?utf-8?B?QUZWdzd4NmR5MHlYeTUzWkpvczhXWTV5cXBmVUxvNWpSYkxHd3M3YjF0OVRh?=
 =?utf-8?B?MlIydnUydFlzNk1hM05NaU52QjRHQzhxbzA0NlpEelFDeERZTFRLSG9MNUZj?=
 =?utf-8?B?RVlRYTZzZzd0dWZIaEdDV1ZvSW9UVU9rRXFnT1dtMXRnU2JQOCtUVCs3QnJt?=
 =?utf-8?B?Tk1BeHpHa3hnWnBkZko3ZkdqSTBKR1lHeld3cWZSOUVCVVdEZFloUHZ2YTlR?=
 =?utf-8?B?YU1rRU9lQUkrdlpOM1lLZFo5Ym1CcG44WnNVL1NGNlB4ZDBRTzZndHNDb0JZ?=
 =?utf-8?B?d2IzVDZkNVd3aEc0OEs3UWdmV3hVSzVZZ1pUWnBEM2VNSTNrcTJKQjFQUkJB?=
 =?utf-8?B?akxtL1BqMjVuZVRhaEN6U0U3YXdlTUpUdUxudG1DWFh5NHY5UnhYVFNEWWw3?=
 =?utf-8?B?ZmsxaTF6bGdhQXJSdlhPeHlBb28rSy9hUkx5RzdPQ0ZPb1hXbms5cnVOcVdE?=
 =?utf-8?B?eWhPQTVmV3BqTVZ6TjJ5bEFpN3ZpdmN4TDUraURsM2plV01GUnB0UE5CVDMz?=
 =?utf-8?B?YnZVUmcwb1YrVngydDg2aGlqbDk1VU9WZE12bWp3cC9qRGQzaWJQVVJBMmZk?=
 =?utf-8?B?VzZ5aC9FUHRzRWQ0NnpxSnN1TmprZkkrZkh0ZHZPNEZaZkZYWXpRS2JBRTha?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4da953-e3a9-45a5-bfa9-08db25b996c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:58:43.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30ssKKLPert7xE+IEN6njtyKQREj0IV5cvmKyeyniwQmAMaglrRmnl4fkj68mzjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5122
X-Proofpoint-ORIG-GUID: qvEd9mapHkU3PvGHQvnDyYch7qcvP4XL
X-Proofpoint-GUID: qvEd9mapHkU3PvGHQvnDyYch7qcvP4XL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/23 5:07 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In __start_server, it leaks a fd when setsockopt(SO_REUSEPORT) fails.
> This patch fixes it.
> 
> Fixes: eed92afdd14c ("bpf: selftest: Test batching and bpf_(get|set)sockopt in bpf tcp iter")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
