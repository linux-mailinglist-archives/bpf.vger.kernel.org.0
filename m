Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F45A749C
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 05:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiHaDtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHaDt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:49:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B2B2775
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 20:49:27 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27V0pqB7022719;
        Tue, 30 Aug 2022 20:49:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JNpO/tygkMWrUWcfuzjFFVYfrjYZFcohrmiNkT5wlzg=;
 b=Zvc0WGASFKYZtbzDSRFurG3c8hJUEnsjGGBOIADbCpFhGpvEs3/mhgY3e1aRUhR0pgyb
 erMyiOJfBj5wQEnVxUfrTU9287hXMQZNiK7wD7N4m/sHI30qXZhQE/XoZBpZU8HZBzGe
 RbgptcVTKtyuL0JJ2n0UW6oLGW4Kaa+2GnQ= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j9nkrv0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 20:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl3k9UZOxh323PW634KBLUAc3UeZDzj9lNlq6kyZ60whulxIpQLBar5lyrz3Vx1tgehPbs3GO27Ga3sg7VMZSXzQ0R2iYdQ5V8+6/uVxuAcYtxZrnlKf0wjFb3+idzE4bKwlQizENimlVekNkyELkyewFCCwyI6lT0ngBL5B8gcaN1NOqprFdEKqxJkrM0jyEPPKF1NFi7vv0EkX3wd1lQUd/jD414RH4IJqiEGw6KdHcs8+WO+H5JjMIaBGgYHxttqvn85UaApvxyJS2osSszSWQDRZFAJ71lsR8613BTz4CFTVC2zLpG22KiMkXHUClx9SEpF4kD0rf4IB0fxaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNpO/tygkMWrUWcfuzjFFVYfrjYZFcohrmiNkT5wlzg=;
 b=C4U9KKTJXliZXb2dXLYhiS275GnezlCLAP/X4/IzJrDyP6F4RePkH1XzzFjFwJV5GfTdByh1z58cy7wtlECO9Gc1EwoowWZPblyMsbXSnmkkmcSg1aHf6hbqrpYrrenvlKsbd76VpAHbve0+VeDTQ+yNkacbqHzch4hj9R9Oa1ZHXDyUpE7h6WxsnT4K7ch3IrT0EyU5ah+ekDcZkCWrfKSFelkydPOkWumtyoDvZ++7RGhHxD60JH0rKa7c840yHdMGRTqSHyHSshnkgGUM2J3lnQxODOnRAVACTMs1uliDfH3DDKYzBzgbQEOMuqpSNuQDGXYGP9we5v/Mh2l5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2815.namprd15.prod.outlook.com (2603:10b6:208:12d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 03:49:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 03:49:11 +0000
Message-ID: <e2ff05e7-231e-c384-3322-68610fc03102@fb.com>
Date:   Tue, 30 Aug 2022 20:49:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v9 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220831023744.1790468-1-kuifeng@fb.com>
 <20220831023744.1790468-5-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220831023744.1790468-5-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d46d6e-797b-4e2d-df17-08da8b03c3a3
X-MS-TrafficTypeDiagnostic: MN2PR15MB2815:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ProPtyCUfJGeGpz4wOH9D3LcVngjyiULfoDw1fTYI9PLAEGiiOZbgwo7HgT1sph+TFTNlAadX5RTXPJEDny5itincc2uvQddnkZ2gOw1+aaqSv5ynZDsbP9nQ97jHjDqnDLV/VfWLs7Q3MO/Ux0qQHbRZhgXuIw2LBL8Zk07B20lHi8/51fW44l9mhSMhUofWo+vQdR0BG4BOmlgC7poxltm8ENxAM0Ta3618AXytlF2LaI2GxW+aMf/zC+XAzRJvJ/niRGGT1uqIVFR2mHOV24sR8CWWJ+d1wOdAo32ti+I8jeu4xTjz9ND8ypc9Tol+GmK2bV1bNFiHT2qO5CpW8NcK/Yue22dqmIgX+H6y9/YnAbnl7lKcMd/MWRT0cZz0VTnAFuiYRLdzC1W40l3fzRhixTzAc4+290JgT7YVwS8bJ0zt38Rg1yBHL5WeZVd2KoB0yK5IAss9DRajNZrg86vek77tGnyUByVw9lqPvKNZULb2EAqKGzDnqKurX8ff+RAKmsv4T7OrKoWcPfIvWZC2w8Wr3kDFWy0UoBoGvTPrgVFpevDOhouEUTIlARPZpz9TzSjbnjKUc1/E4K0aNQIKGKqhHiuCWhvK3vpZmGJdEWZB5HILF+mQeeQWaSvQA/UOX03INSHTtT0HG+JCW+3r32yLq9DU/0C+j0s/FoxMZw4CzpNvXjU+EjQHTQM/2wlM7+n2AcHWjqeZjDq3/HvhpbLFWOGvmzfAlpnbkcl6PnTxe/cmVogPytjc+58UKDeduD4sJFWcTt8KTmtLjsPea22JML8QLfF3XoQkB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(2906002)(6506007)(38100700002)(6666004)(2616005)(6512007)(53546011)(558084003)(6636002)(86362001)(8676002)(66946007)(31686004)(31696002)(6486002)(66476007)(66556008)(186003)(316002)(41300700001)(8936002)(478600001)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhZeXordTlPVVFSc0hKRnNtektTdVZPK2ZhNzBEUll1WmdaL3c4clhXaGE2?=
 =?utf-8?B?Wmxqc1pQS3NMM01zVXRiUUtYSWJ1Q1F4YVY3ODdNWW5pRU9Tbi9wZ2dYNDZp?=
 =?utf-8?B?c3BkL2I2aXlqL2loT090WjJIVit1am9RaE5NcSszaWc3L1FJNnlnbVJXdFFP?=
 =?utf-8?B?by8zZjZzR2lZQWJqdHBaZUxXK2lpRGhhMDBaSlh2TnV1NVNBbGFjZi94UUZS?=
 =?utf-8?B?OHA3NmRnaytYVWFBdmhnc0VJUDVQaU9TcUFZMXJDOUVvNkxYeHBrUFQ3R2xJ?=
 =?utf-8?B?aUgyTFRlRnBJV0NaR3pTaFpkTWtFeXZ3VVBtaVptNHprY3dEOEhodWtNK1VD?=
 =?utf-8?B?cGE1NU5tNVpQZXNKQU9uUHRwL1YwNnNyVmRxSyszaDN5QmJ6Z3pOR25Ld1RC?=
 =?utf-8?B?TWdtUDIvdDluKytZN0MzT0VPUldwWW83THNLQkh4OEJBdlRiNlpzbUlQbjJY?=
 =?utf-8?B?ejFyYmUxVFd1NnRiTWZYVStXSmxSdDVqVFk3enAyT0RlbUJ5SVE4NytFUk43?=
 =?utf-8?B?YnhyM2tLcTllOXZoVjF6V2cvVHZUZ3ROWlZ6OFZ3cVE0dzdGaU1hWStXNTY0?=
 =?utf-8?B?T0lQSTVuK2dBY3ZodGpFM3paOHV6OWdzVGhhVngzcURYN1dBV3h6cGxsc2g5?=
 =?utf-8?B?UUtTNjJNNmlEYzZkUlRiNjRnKzBwVVh5UkpMMHppUW1yVWJRWTM2LzVUbVdS?=
 =?utf-8?B?eGlZS2xPYkJqSHpPVUFMZDl5VWhrZ0lvZE0wSE9YaTR4dit5di9CZVg1RmUv?=
 =?utf-8?B?OUI0WXhiMUJxakRoQXJVZDFMM1IrdXlGR0pCTkVzZHhUTWVaOWxZZWhOZCt0?=
 =?utf-8?B?alBhaS84aDJpb0VjOVNudkt3TC83QXBtcGRVSVZsQ0drR1Ara3VVMVhGcXh6?=
 =?utf-8?B?dkFrUEdETzdaRGNKcE1NSEtzM3BRbkx2ckdsVlp3aEViT09ER0l1ZTd4ZlJE?=
 =?utf-8?B?UHliZnFxUllPNHZqOVV0Z1dtdlpSSHZLMjY3VTBmMVhSUDlKTkVIVUZndTZ4?=
 =?utf-8?B?c2hNZmgwcjUzamZVVDdZZWM1QmFTODI2K2dZQWtHbS9ZTkVwVTJHVkFlS1pN?=
 =?utf-8?B?UHJmcHUvUklLQXZrbWFFN2E2dEZ1TmorSXovNnFlUlQvaUs3YkxhYzJGTDho?=
 =?utf-8?B?a1ViZkFLOW05ajVYZ2hJRVN2Q3hFNXZlVkJrL2ROd0t0QytGR056NU5EZjVN?=
 =?utf-8?B?dy8reG9zU0dWQTU1VEpjN290OG1RZVpjV1llNFFGK3RhTHlKRVJlZEpKb2lP?=
 =?utf-8?B?Zmw4djkrTzhHeGhZQ0Z0UmFMMTNuUmlNWWRnYXN6UUt1bStvWlZkQTB0Q0FY?=
 =?utf-8?B?YzF1QjdUZlp1K0owaHY2dndlSXRGWVdnWFE4M1JrOVdrSjk5VDZiamJQMjNw?=
 =?utf-8?B?UWplZXFoWU9IRWVTTzFPUS9iRlROQWc0aWtDVnEvNW9LYkZLYUpkVUFXRUJm?=
 =?utf-8?B?OVdkTlBwUENmWEkxc2Y4TVM2VnpabGlmT21SYjF4Y3JDc0tLSFU3eXB1QUJo?=
 =?utf-8?B?VGNyNWdhZDR3aTJJbm1EeU04R2NnODlWWkhOYnVoZmpaMWxCUEtLNmNwSUha?=
 =?utf-8?B?S2tQV3R6ZDdyVVZxUVZSbVlPQzlPYVFzdmNwa3NPS2c3dnYycTNEeVNiNTZM?=
 =?utf-8?B?VEE2VzZ4SGxhUU1DbDM3K0NzOERMYVJ1K3A0Q3lxV0NNZ1ljWUpWeTFUZkJ0?=
 =?utf-8?B?UXcrY0xVdEg2L08yNkp4Vk1ndWdZZkxOM2poWjN1YTREeGF1ME1aQlk3dTlZ?=
 =?utf-8?B?SEYwMGpiQzJxa011RkVhNTRhRituN3ZqV25GUUZYY2ROYWg5MjZkcWhnaG4r?=
 =?utf-8?B?VTIxQTJlbWRtUnk3UlpVNmdlMFcrTVc0R3V0RjFHQ0xKcGJnRCswUmk2dXZv?=
 =?utf-8?B?emp6dVZKM2RSSjBrQXgrMHppVWRFaHdkbWU0TjJEeVJWVytIZ0ZZb081bUVa?=
 =?utf-8?B?VXJFZWNibnYzOEU2RXVnTEtBZlpmbGJ1MWRPd3ZkaVJMTlRkaE5XQlV1MkFh?=
 =?utf-8?B?VldML1dtQVVNRmRReVBPNzRlUWREVE0veU5KT2hQTWs0ZEFpZlMvdmFUV2F5?=
 =?utf-8?B?ZEtZL1FoMFZGZXNTV2JIRkN5TGM0NU5IWVBuVHlHNjlNMkE0QnVHWjJ3SEhm?=
 =?utf-8?B?RVUyVkVBS2ZPaGxWakY2MGFrVi9UeGhXQnFPMnhGZHhWVC9LVEdMelBPZjFm?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d46d6e-797b-4e2d-df17-08da8b03c3a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:49:11.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFcsdRAHaCFtrXylahIjh1M9nseHS6TFOQ1jDytVNlXW1NUmmz6ndIjNUBBDLHiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2815
X-Proofpoint-GUID: E_j9sQ9UuxUGZqT864Nn7DXzxqutJeJh
X-Proofpoint-ORIG-GUID: E_j9sQ9UuxUGZqT864Nn7DXzxqutJeJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/30/22 7:37 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files and tasks.
> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
