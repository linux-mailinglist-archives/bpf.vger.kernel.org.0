Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00A740D243
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 06:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhIPESm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 00:18:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229463AbhIPESl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 00:18:41 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18FM3pR9005895;
        Wed, 15 Sep 2021 21:17:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bcFQjxoEba6S829buLMHOArYiRebaPh2It468HxRgR0=;
 b=I6D1NctqBJwCclfAfZcPIiI9uZhr+08/kqXGjCwRXUgeP54RInlA9eRV4pHXCGdsbp98
 km/uZehkymMGqDLVUGISl0JqdQXbEcVWLwt+LBvcoCiaKki06MbTFVofq8yRLZg63vTA
 caJASXICMQOTkdzJxUwp18Ph4To7OSCdJuw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b36fg0kbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 21:17:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 21:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDElIZ8zqFtEdxRS2dmkkgZId9fw7KO0SOnyXIoasBkMRb+p7CzKYNMm6+Zx6Ais8Tj0wDPg2XTYuqB4GBCNE+ov3ncSEYiGmk2SiJU+1MoKKrgMtAa0wObMAsytXjYu9z+1KDpeQLW0i9pW5pjexLiMRhX9MK6Gi9NP5s4xzw5E+NHxNxGbnD41CkeJFsuPUaEXmWyItl2aFgtnxhzWt6/Jm3Pt1Kioaqu/Mk+lnBlSzOuiji7ppby7MVIZoRnCIwogFR872ckKB8ZXziBFrpOpvw7BJAx4ilJsxLAg4z8q8GbCx4qWX5v+zD4VkSy9SWGOEGmY7fBOT4ieJAHu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bcFQjxoEba6S829buLMHOArYiRebaPh2It468HxRgR0=;
 b=mely8/6i/HzFmn+pOTUIEezlVpMgYQc7+rbR3zdAThLJNFh3wiXTEGclQfrNP5IaTiehTNCchdD/+7b/A7HWZX4aRhg5icYkrch6xCXpWO9mJP6cnTB+IrFFRlhJhrk24hgEwNNPBhyJswyKYfa8dLDemIa4T61InNvyi2azJcWt/nW9kPKi+B9Q8ZH0BY86E7gc0mY9t08mXuxDTMadFdMm/hB+rIzn/uEoYVs4FofqbbQTLRS8iArNQ5WmuUksOBtyXx8RLqBHwMFHwrXAiL763iSUS4l9kTV2NQI8ppEZjy/Ja//9F+Y7iT/hjbE763gMtFufseKztOuz3wQNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1967.namprd15.prod.outlook.com (2603:10b6:805:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 04:17:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 04:17:06 +0000
Subject: Re: [PATCH bpf-next 4/7] libbpf: allow skipping attach_func_name in
 bpf_program__set_attach_target()
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-5-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1334565d-4810-1ded-504b-180a7b124473@fb.com>
Date:   Wed, 15 Sep 2021 21:17:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-5-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 04:17:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6756f3bd-04a7-448a-221d-08d978c8d833
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19676488E0B1FE0EEF0BB0A9D3DC9@SN6PR1501MB1967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxXJV2E4WfVQxUuN4lk2JvD4r3+wn2B3LtX6zn0i6n2e4jBHJ581DHeO7fImZesU9dYZrdQkrlt74/cuatOI9AqSEfZe3tU6CGFkI+lHDZ9SVSIBOAmsZWbLc6iSzybpXGUK3kAE+Ynl47oQVPtI4Iv0H6EqmrGj5M4xdG+/a4F2o12UxeSQ6zoZoa/Hszt7uBegipAuPJlOIgeawma0KU17I8bqnh0ElsIrDg528/PH/KKeF+/k+ZqYpTyMrd2sGmAM32qWBPbf+cPmSmP9fyDVPujzShnks/f1uWaLdhjur9Ozb3e4QU7BMJtK1gYad10dNraoUvF9nZ/dcDK7lPF0matRGWxFD5tOTa8WFeYVBX/RIQ3oOXGdk0iSmnGm+1cxmd0bE4zl+crdZd3BxIp84pK0WoVKaaQxZMdysOIS9k6CpvWItOFXHR8d0ppEeMkIKAbRWm8ToTRIT0vvIMs2UssuJoKv8QVrdnijf5WLe9IZIAj0SZVUGaSPLtnsx2iKoPFVos4cXH3VIDL3oU1BFZ0EVPEemgr4QE0nHLwG6qTt02yiy6NNh6Qiim1Imnud8LakT48/vRBw33b3wTv9rhJbX7hkp/dfb9diGvXHhYLnxnNigSteWA18r20snD142K+aRRtnoQNl/Xq54OHztJmFHKznnLmQM+lXNyFZXMfPwCTR8RT91APAdRMTvTr/6DwQfeOphnYt5W4Ad23Zh7VGf8cl1ewOnlUIBoFs7yxtAXUDlD3NDD2ZN8k+p4u5kvk/ItaSNl+m2tLC2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(478600001)(52116002)(6486002)(4326008)(31686004)(5660300002)(53546011)(2906002)(31696002)(66476007)(38100700002)(66556008)(66946007)(8936002)(86362001)(36756003)(2616005)(186003)(316002)(8676002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdPM2NSRDhYWEF6RHFhNEEyU1o5c24wOC8yM1BVRGJxbWthYzRqZFZGQ05H?=
 =?utf-8?B?SlJrR2VZTkVtNFpGdXJQZWt6S1I1UEVaZ2hOQklCelRTcEMvZjVCdEp3N3Bz?=
 =?utf-8?B?b1Z4NnlWbmtKVUFhWUhYZjI2ZnhxaWVabmRITEUvcU9WZzVhdWNQTlRGY2Js?=
 =?utf-8?B?dE9TbjVBTFFGc25QTVZOWHphdmdxUTErdUZpbWJuVUlYWHpmWVh1TnA1Y3I0?=
 =?utf-8?B?RVJzWUdCQ0tIdTVIOTVheDZMVFFGbE1yQXBmZWF6TENWSm1JYkw5NFg3NUMz?=
 =?utf-8?B?b09pc083U0VlQTVscTlibVI4WFRBWlhDQ3J6ZW9OQk9iQmlXWVF2cnZhdHVE?=
 =?utf-8?B?aUJ3Z1ozNE5hUXVvQmdxWHQ4bTRyZG53dHVxMklvektScjA3V3N1YnRVeFpa?=
 =?utf-8?B?cHZQVzNVelpJY3FMeWJnNnNyUHBXWHc2Sng1QW94dXhJcnI5TkZQM2t4V2o3?=
 =?utf-8?B?OUFVR1N0MEVMSlo3SlE0ZHVoSFVrVWh0NkZLdzVvdDhBdHNEdDJqQTVDbDdW?=
 =?utf-8?B?MEdqOXFiL0pTZU4zZFM1SGV1OHFHRXJHM1NZeGtkZGZObVRaeFcwNzVwR3d6?=
 =?utf-8?B?RkdmUFF5aVhINDdDRmxYc2taWGxTUmljOEE3Z3ZzWWFaWEprRnFzeVV2eWdk?=
 =?utf-8?B?WDlpUEFCWm54cSt3MHhvVjBHd3JOaVlvZ2gzZkIwdk44Y0VLMWRFdzBzTTdP?=
 =?utf-8?B?L1ZvenQ4d1NjVE9ud1hnRGVSOHBYTGdVd3cyRHpxWnJ0c3JMZW9mNlpBODFF?=
 =?utf-8?B?WGJIL1kwdjV3eklXSlRCcjVkMmZkeGZPa3pBNVU3KzM4NGNqTFlUQjdxZExV?=
 =?utf-8?B?UFhZNi9BcUllb3lFNjVUUDBpTkVHQW9ndFJNSURsUUpRck94a09nMlkvZXdV?=
 =?utf-8?B?cGZIS0ZBVnI5NHFnbGJFYlNBU3M2TXYrbHNhdTlQNWM2T0FFOS9RT2RydHI2?=
 =?utf-8?B?Rit6VjdzY2UxTVFCNjRrckQxdFNnZGFNNWhxc3lIRHo3L2JHem5Fd2dMWGt2?=
 =?utf-8?B?ZjA3ZVhmU0FXUzVWT2NMM1d0Vzh3Wm1aak0rN3BhM1FPTmRrV1pTU2J1Vk1G?=
 =?utf-8?B?Z3Vodk9OQ2VvU1N0WDBneUxaWE90bjVDY1dIbC91U2wwQ1hQWFY1Wmt6NnpN?=
 =?utf-8?B?UFJ2SGk3RUF0Y0l2K3JrbWIvQXpZMWczN2dmR3Ryb2JIK2Mveld5NDYxUGlN?=
 =?utf-8?B?RVZQYmpDbTB0QjVJS1p6WDVHd09lWGRPNHR6VGlCVm55ZS9HcEd6WXA2Mkd5?=
 =?utf-8?B?RGs5S1p1U1JKNzMrQkJRVXdDeWw3cWhDNEVDbVRCYjRZeUV3bWFGNnRTbEtW?=
 =?utf-8?B?Q0hnUUFqWmJOR3ZZTEcvWUJzbVpmK1lMeFp5WktOSXJ6aThpTVg4S0lxYlhW?=
 =?utf-8?B?UTY4ekU5Z0lJUnpFdTVRRUhMRTdmekMyQkYvK1NFKzZ1M1c3WWR5a01UZDN6?=
 =?utf-8?B?WVRwcFZMMFBaV01XY3NXTENpekpHcFBNRDdmZzdxSlA4VnZ4N2xodHBqaFd5?=
 =?utf-8?B?RHJ1ekZmZjYzWjF3eUFXVGlUbHd3M1hLWHhpZWhadXVSV1RaZjh6QVhndGw2?=
 =?utf-8?B?TU1ybEVVVldOUnFPVHp0eFBpOXMwYmhHNHVWSHRSTEExbWVJN0ZCZ2FtUkZU?=
 =?utf-8?B?TUozVitaaEVZMHRZWHpBNmg5SlpEd056RkFNNVJrdDFHUXB3WFJhMGlMd3Fr?=
 =?utf-8?B?RlZvMmc5Y2o2ODRIS0VpcU16eFdES2ltY3huL3drd01sd2xkb0RhYmpNS3dM?=
 =?utf-8?B?UXNQdWFmUGYxc1l2b3pOMDFSZzl5bVNENHNaOWVKK0Q1ekkrWmNseWZ0TlZT?=
 =?utf-8?B?bGg0czN0K2hJZDA0Mlo4dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756f3bd-04a7-448a-221d-08d978c8d833
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 04:17:06.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZgk/8r1mCrT0ZeTsZzbcrUaDnn5oDaVDaQU2Rl1fc9gsN2m/MQGkvKpZpRL/6ET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1967
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8y4efLPm_LrqGQrsvBLnyWwsMc9yURAw
X-Proofpoint-GUID: 8y4efLPm_LrqGQrsvBLnyWwsMc9yURAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=847
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109160026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> Allow to use bpf_program__set_attach_target to only set target attach
> program FD, while letting libbpf to use target attach function name from
> SEC() definition. This might be useful for some scenarios where
> bpf_object contains multiple related freplace BPF programs intended to
> replace different sub-programs in target BPF program. In such case all
> programs will have the same attach_prog_fd, but different
> attach_func_name. It's conveninent to specify such target function names

typo: conveninent => convenient

> declaratively in SEC() definitions, but attach_prog_fd is a dynamic
> runtime setting.
> 
> To simplify such scenario, allow bpf_program__set_attach_target() to
> delay BTF ID resolution till the BPF program load time by providing NULL
> attach_func_name. In that case the behavior will be similar to using
> bpf_object_open_opts.attach_prog_fd (which is marked deprecated since
> v0.7), but has the benefit of allowing more control by user in what is
> attached to what. Such setup allows having BPF programs attached to
> different target attach_prog_fd with target funtions still declaratively
> recorded in BPF source code in SEC() definitions.
> 
> Selftests changes in the next patch should make this more obvious.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
