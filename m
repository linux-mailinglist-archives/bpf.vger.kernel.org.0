Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDD65DAD7
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbjADQ6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbjADQ52 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 11:57:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA1382;
        Wed,  4 Jan 2023 08:55:48 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3048VEGr018438;
        Wed, 4 Jan 2023 08:55:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=DDfye6blP8p3dcYcURVWJyg/OgyZil/JnUS4GaBnYxs=;
 b=HTBjxuzICdqSPFP02AmfGq8cHTMWI1lM5YgKlUxjEFbAtLUgg4C2Ru3tXzRK/8ctCDbc
 XxUteDX8YTChbwjx8RoT7EM5DkKKfhjyGd10RUsTHtOOBuDAcH4MLzyi6jwiG+oxWbuW
 oSb7hbSxQGV96SYvRct16DZXQ16WVAeD6dEJKtbuAa/ag00jefQhwQYHtRaCMQ01RSPE
 UatpPv5JUZLVVrFFs/cgke3f4QC2n531P7Rm58r7bfLt83h/sxyi8s2c+n7pfWA0iKOM
 auLlWSfatjUS/wWM7WRJryqf1Ek/ljQgaq75y5Orj2n85OTeC9gnfBerDj7nYr77Uvx8 VQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvktxa7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 08:55:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS5yDvo+GWIks8hkRukIetHX+r1r+PJUOV3z4NwNYHhl5Z8zbwyPHX667k2fZCF4sqV5UzE5k1xvRbprMajKM2Ngbr501ebJkfdQv8eJOReKCVk4VhgDEdpUw/KEyvjgfqGECwYw76wIVDH7aMwQbt4G4sUdR/nAF8TvbwggI/XFQFbl3Y4enGXqGHtmiCdL5aDqoWdEhO/GNLlRICeEggItHsvS9jChKfcWgbpyLvKjtEiQkLENwGCe6BYunzNwd0srts9DMpngxcVQWNB5IRTJMTKxCQV9Qau+Ma+AH9ZWuInx1tkrTuz+SBjge0+6dufBjx4o23ob54CToTbRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDfye6blP8p3dcYcURVWJyg/OgyZil/JnUS4GaBnYxs=;
 b=LFP5GvukOxhnsbcXJ34+Kf5eR7GyYzpZf0u9vSgn0YwUVvG2Q+ih/HLuRA9qS6enLElxi3soDC82bBbE3BEv5QhQeYu/JSWj9uNqqvFAt43/NPro92H+uQgQzP3uEyOCEVXygWKJDbeHJiIJGu7vY+/yaTgbziXmvcigvnw3dEWXTwW+d0byNjCY7OTG9F4iTblRD4aiTz/n+UdEpNv24/NT1oVrxBd5bdEfpJBsepksB8VH3QJxu8n3XVEPwXtbyYT87yyfEvvAEfVLPdHFtYQKVOGbDWANV0T1/k5uNOoTatwsvtORx23q32YoFShiM2oSP9AGZgaSYJcBUWtB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5768.namprd15.prod.outlook.com (2603:10b6:510:274::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:55:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:55:29 +0000
Message-ID: <f04bfa9a-fce1-8e16-f7b7-56bcaecac6a9@meta.com>
Date:   Wed, 4 Jan 2023 08:55:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] bpf: skip invalid kfunc call in backtrack_insn
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20230104014709.9375-1-sunhao.th@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230104014709.9375-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 44915a48-72bc-4ba1-2ed2-08daee747c21
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iodyOfL4kBK+/uzaT3RzIE5bzu5th8D4or6ZDOIpUs+VnghF3Tu4wVCDbMk5uU0HbaNp5HaBO4PboLt+wzAVePRKnafEmCTc0odD2g/e8uiVssyHFWxKyZBf+CjDbLrRXJeZIlNxyJysCUEkSjoBZqtJBlRU3i+zC+MextdFACQYRQ2F3Rf4OPuldBCNdO5FBi86Gp9fcqmaL9ppLEN3NmfZOAFNirK0DHa2aZSyxm3zIvfLhvTtGqLDRGb+MSBU4IZrX87uvzqNPiivQ/YjurP7ecbp3VNrAKFh32tcoRzj6aeZc1I2KCjpRduPvYrleyt8s4dQKRoTje9HfvGV1G4dM24NSaUSHM1bDEDdO2eaxlQwtIkBkGD2m7OLcr3VvUhl8wM7Naz3sph/9YNWR34twuamI4XFUCpNCfJfQJY6QJeu+hdkfpe0hcIoJh9Eiw10wqX/SHKbYa1q1BSe2U0zPewvzi4GG8fJCkkg6sPi0gNy6bkkH8TgslwSeYnwVN7gw0EAeLTvltmdT5j/U3V+lQyrxVkcwkjnpVLcNsMlZn3NToxwrAwnB1H0s028EtUr2jB2+NkHTL02ZWI8Vc0SvBjddInJeVwsa662R0S6p+f9i0kaCAPEw+ywCyxF+Em61J7gIF+z7l6bVPbmFgDs/DXyCF3l4Xssa0R2vp5aRFJj14nBZNTpnz8bcbjWa6TYS0ikeklCDBHa7HAoidycA5IEbEZ7QpQWtgBkIxKRcs9ydFb5E5e6zOxPFCLcHlc0sBdwG+gvCRRkZC0oxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(36756003)(38100700002)(7416002)(8936002)(5660300002)(41300700001)(83380400001)(86362001)(31696002)(2906002)(66556008)(66946007)(966005)(6486002)(31686004)(6506007)(6666004)(66476007)(8676002)(4326008)(2616005)(6512007)(316002)(53546011)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVVMC9kUk8rd2N3alRPaWJTeFN3emp6NGs4Q29HUjB0UkxqZytEdHdRS1ps?=
 =?utf-8?B?czZsRit4bWpUUlRJdU9nUzdyVCt6NWx5TVlTQ21WYlpsdVlGVzEvVlhHcmxQ?=
 =?utf-8?B?OWZaRitNcDkwajQvWXdOelpnaXJxSU1ZdFZwQlRiWTBsU0xCMTZOd3k3QmIw?=
 =?utf-8?B?R2VpUDE0YUl1ZVVtN1ZaNTczTkE5SlpUTUdlalovSm1TYVoyMml5ZFkrbTJl?=
 =?utf-8?B?MFFJZ1p3Nzhsdkc4Um0rOGxvMWIrdjFSV1lZMTZpOHNxMlM3ekU5eTNPczRr?=
 =?utf-8?B?N2piVjU2Y2tQWm1uN21wRFRVZEVaK3FmcjA5dVZIWEsvOVpjVkplTXJUenYy?=
 =?utf-8?B?a3ErbVduZHpJdTYrSmNiNDFOYklqSUJrcjFvMlJGZUcyYVh4OWdlSWVESGxE?=
 =?utf-8?B?TWpPU2xTbUwvWmtoK014UERWMXFnbkViSjN6TGl3a243cEl0djIvYjNXWDVL?=
 =?utf-8?B?aExHdzYrMTI5MWY4UExrbXlUSnNPR2kwQitaU1JJWEY4SVJQY1RFNnpNRE1V?=
 =?utf-8?B?NHljOWVlckpFcHJJMEd1WFY5eTE0Mm56NVVvVk41L0EzZU9pTVNTemUzLytv?=
 =?utf-8?B?S2kwT0lXQjJKVENuRjZtUlVNWllSK2l0RjVkTndpMnJCUEJYeE91Qkw2N3BP?=
 =?utf-8?B?SFVzaTRYSXRza2xTWW4xVWxrR0RJOUtiRWFpRVBtVmlBSzQzRS9tdmNGWlp2?=
 =?utf-8?B?UWFBNE9qTW1DK1plN2ZLd0ZFVTdCeHVrOVdkY2NvalJsK0RWNFJhdHJWVEFL?=
 =?utf-8?B?Um9qaEtYU2s4UWNTNTVNeGlaS3FkaGprUmVpM3lIVkZja1lhQXdaMWl2ZmFv?=
 =?utf-8?B?L0JSZ0hzdlE5b0hiSXhUdVBvOHNRanRRV016NkpjcjhkYkZCc21tWnFja1Yw?=
 =?utf-8?B?b0xYWEplaitsZlZxZ0E1eHgxTFR5VDY3SVVVdy9EQ01FY0szZkZLOWg1aTdQ?=
 =?utf-8?B?QjhBem9VVXN6REsyeUM0dnc1OTVJakJ5RGRKZ1ByOU05Z2wrQUhNdC92ZFB5?=
 =?utf-8?B?dElHSWI5QWdZY3NVSnRnbm1pNUh2a0EyNy9NZHpTVjh6YTNpdGx5S2VaVW0w?=
 =?utf-8?B?VGtUSHFueGZnMFFkLzVTbHZUMmt2TnlVVDhTM0RsS0I1NzVtcGhIZFBFQy9P?=
 =?utf-8?B?NlpFUEdBWnlCZGJUYzZ5cU9kWnRHMFQ3RmRTTG42bFpnNEJITUJaY3NHckJK?=
 =?utf-8?B?SWdmcnlBaHQwS3diSDRJa2pPUGdqSmVSN2NBWUZEZEY2ZS9GQ20wQm5raGRU?=
 =?utf-8?B?VnZPSGpleHJDSjBoTXlWV1Mxcy9IVHZKa0o2ZlNxc2p1dkZkczRnck1aUi83?=
 =?utf-8?B?RnZzMGI4ZUZQRnJqY2RWTnlDVlhOMkJKNFhtVk1UaXZCMWdhM0lmRW5td3h3?=
 =?utf-8?B?dExTOVl2bC9oNzdZT2tQOFo5OU1TTjI4N0RxZXRTZ2t2YjhEdjQ2VlppOGVi?=
 =?utf-8?B?UUZ1SFNzTFgwYVdyT2F5OUJMTmtKVkdpd2t3QWZkRmxzOEFpZXVuUWFKOTBq?=
 =?utf-8?B?Qmk2NVlLbktmK0hiZ21xdlZmY0hzL3Q5YVgwaW5OM3hLYURkSEdkVmgzNVdL?=
 =?utf-8?B?bTdkV2xEdW5PYUJIY1lCQVBBd3FUTndjL1RYVnY2My93Q3kzMzBGaTFURDA0?=
 =?utf-8?B?QnRHeWVXOWQrSkNMU08ycTlVNzcvR0tjd25KYjRLWWQvUlVGc2JnNTlIVkg0?=
 =?utf-8?B?YzdWRTJZdU9kWGRNUkVrYWE3cGZBZUNvazQ2alpVR1d4SzZ2ZlBHaGxrZWhw?=
 =?utf-8?B?Wk1OaGx0SHNNUnF0MlFNT3FlYWQzV25JTWhONTRkRFo3TzlwSUdMTHdYajdj?=
 =?utf-8?B?eDhlaW5EUlU1amFUNjRoOWk3RWxNekZMVkNZdmtjL3NSUkRnVVRtcW8yandm?=
 =?utf-8?B?YzlLeS91WTNUdUR4UENRNFBwTlc2NmZ5bEYxUTBCSDBFQTB4T3N6VHg0QUVT?=
 =?utf-8?B?RmRVcUsrbE9HRHVMQXBNNng2MzFCSjJGMVEzazBsUk43N3ZadXd1TTNIT1RF?=
 =?utf-8?B?RUpYVzFIcm42QVFqelVBV3JYRkltYVJ3enU5a09TSHJZMWE5SDNjOXNBa3JV?=
 =?utf-8?B?VXpjS3RzREo4c1diMWxrMmc4WjBrZWVBeG9mQXQ4cnlVbHQrRmllMGl6bDZa?=
 =?utf-8?B?SjJJT1FwVXVZNnRubWZVZURYajFlWFAzaUZTNUxwK283RmlyTkZEcVlRcVFM?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44915a48-72bc-4ba1-2ed2-08daee747c21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:55:29.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBHC58pgTGulC8MWOVjOajwwGceSHoq7Ym4I9DFCHpDhehk5L9LpzYQuFzhdGnr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5768
X-Proofpoint-GUID: 2JWT_mogMRJU1ZdwvW_T1VPkoeD0nh2P
X-Proofpoint-ORIG-GUID: 2JWT_mogMRJU1ZdwvW_T1VPkoeD0nh2P
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/3/23 5:47 PM, Hao Sun wrote:
> The verifier skips invalid kfunc call in check_kfunc_call(), which
> would be captured in fixup_kfunc_call() if such insn is not
> eliminated by dead code elimination. However, this can lead to the
> following warning in backtrack_insn(), alse see [1]:
> 
> ------------[ cut here ]------------
> verifier backtracking bug
> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
> kernel/bpf/verifier.c:2756
> 	__mark_chain_precision kernel/bpf/verifier.c:3065
> 	mark_chain_precision kernel/bpf/verifier.c:3165
> 	adjust_reg_min_max_vals kernel/bpf/verifier.c:10715
> 	check_alu_op kernel/bpf/verifier.c:10928
> 	do_check kernel/bpf/verifier.c:13821 [inline]
> 	do_check_common kernel/bpf/verifier.c:16289
> ...
> 
> So make backtracking conservative with this by returning ENOTSUPP.
> 
> [1] https://lore.kernel.org/bpf/CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com/
> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
