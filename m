Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3066E365
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjAQQWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjAQQWe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:22:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3903441B77;
        Tue, 17 Jan 2023 08:22:33 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30HG4Ebr020897;
        Tue, 17 Jan 2023 08:22:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1aIjLvkhEr9ZvjMB6hae7XlMNQADqTuW5rG6Xt2MrpE=;
 b=P/sAcZ3WFkkDjXQK2rIMeVKbL7b+Zs5OTXsciBNINI7+E6sXU1Xcy3m6HFIhFgV6IF79
 VfJS8Bt2COZou8jgcfjLFDRmBDvaPZm1TcTtIUBYPzFA4RBb1OiuvNWwVTPXIZKFt9SX
 YBgeN5Y46aabXQK+o5q38f2VZdPw76F4hjBF9rh1zlxzBjmq7cBYOHS5K3X+vHm79hlB
 5qWqgoFbzVp9FDkxa9InpCntTV5YQ3Wmur03UADnhKlg8FOyZoYPfSYNTex2EiBFIL/j
 QyRz0c+csapQEgw0s2bX1FYGA1vp5UftuOE11VXN/J2/myGuxslwLH8x7rSgReVG7kqB +w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by m0001303.ppops.net (PPS) with ESMTPS id 3n5w8ggq0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoDorVaJGd1R9tc0Wi5TKwLVgiaOSM3CXg70ePWLoRWt00mUNJz32SMvpRiuGUgjxweeOJp8iScl+Gt+ZQk1S3eZO7xFNnxTGLVDAlwHlxv+R/Ae5E8MOtlO52lzQ/tmz3dExVYsjoWXOm/iELo82ZOynDAWEyBg8Cof9/06RSLX1d99vyvMixx3Vg/w3/F5fTujXEPsxM9AnKT71pwRmWkFtbqVu+9eVSAbsUyDemnS0MoBIwqmW6n3ecWg+YFVV6SiR3wKkHqou20i0lE4+lzknuxjTmsHNAMRdMdoWsabNYuPyGObQXakxGGJTfyGOLCytuiLXj1rIlyMhdRwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aIjLvkhEr9ZvjMB6hae7XlMNQADqTuW5rG6Xt2MrpE=;
 b=QTUc1fzlAxNpTU/7fpxaaTYDgfEAeoGJGBGfrDmru85wuGzD+h3SFC+WNK1OUKz6HqM9JVmPQvIEqXA8VEuUJReRYauiEHlXqv1ODH5ZqS2sdpOuTXhv0C/Xu+kJEzJW4aLDUICgDJo3kQD6Kh4kMdykdI+4RNM3ZVk4qj4bdn4ewNhz0Xj8rT1HLy9iKLq+fjG3xZ9U60AursOVgrFKt23tymhQqwDqZlEOc58Y/q9WL/imlu9IXhw8S/nL/jm9qARGsuwZl5xarAYoOvnZCluXsdFAut6ZO3hgaQJdPuGe4dYLHMmXbR5ctSnRovtuv76X+8Eugcl4WP3R0wbQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4575.namprd15.prod.outlook.com (2603:10b6:510:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 16:22:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 16:22:04 +0000
Message-ID: <d685385a-2fb9-7106-c3cd-c36a98561f36@meta.com>
Date:   Tue, 17 Jan 2023 08:22:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
 <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
 <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
 <CAOFdcFPnHEc2qd-=C+hdK4nTjJfbHsf4r-G7pdJTRBAT6MuOzg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAOFdcFPnHEc2qd-=C+hdK4nTjJfbHsf4r-G7pdJTRBAT6MuOzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0150.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f585e5d-fccd-463f-b953-08daf8a6f86c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcCX5byZekPnagF0MNxH8q+pFn4cyUVi8vwbLu9kltekCfVsQ0l4KA10F+gYyMWvmy5BTr/EorA9Ls0TkiI2GhTnwdwYWPZXQysYi0vhjDBLdnXh3QwYnQ/FjZEPHlls79qW/xjHSlRG6pGdiwkWpJLSL1BXdsh8doVxbz4AMq/UHGrSs3uegDoyhT0ICa4EF5McmmzMsibanyeAi2MLJXkKgRkTqDtHAkqQnkTPnY0rJYYh4MavGbuvno6BDM5AI3vp8JpHb7mzMpGiQ5hkalg0vlQ3zWp8s/QxOmoOkp5mUuVMc/innMDMCjpVRrBlNeXCVLWfmIDplUKNYrp0ZCdpe6qh9/UjKmQjJ83pKSOTECVRuP11H0Y4gpXlFH1o7hnKY4dturwtIzceGvyx5g8eba6edlly22FSkpxHp6+HxH9gRsL5eyXpqOQbVVzTjgk1/gCGkkix3xGh1BecTZ1XUAGKK3X5EfqZWJpZHZRVzKmmfzHXLEfLTkuTX7kg3kASsg4v1ZD9awu8kq0Hs8tZ/m9v4qz1SaHMsDXsQf8o9P+o77qDU8FPQf+4KQ0OLlC3/gBo7K5OvUv59xAH4JO27tiCUXTyKqlbb8VKUi3S8YRh5jYl79nCXjTsyGCWd918H5ETk8nCkayfq3imS1dnp9hqyicoDHnC8gs5flKotfjxyB2FH/6dt/8DFpNmsYxa62LGaLF5RK58liljbDyjTcdIVbXMaHyfHPBElQHoKfQc1a1R8sSEy9tBugJO8bEOEm10G/BLJ3vB7SBSpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(31686004)(83380400001)(6512007)(53546011)(66556008)(66476007)(2616005)(186003)(6916009)(41300700001)(8676002)(4326008)(66946007)(36756003)(31696002)(86362001)(5660300002)(8936002)(6486002)(54906003)(2906002)(478600001)(316002)(6666004)(4744005)(7416002)(38100700002)(6506007)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVaMU1FZUxIY0doN0VVSUlwbEUvOFIwMHE3QmkyMmZjVlU3aXBsTGNTRkox?=
 =?utf-8?B?RVVJOE5CcFdsQjZkeGMxNFRSelI1cUhzRE5VZDJSYXovQ1lqOWV5bzVKak8r?=
 =?utf-8?B?dm5GM1ExOGJjcmlTNVB3U1VqSXdQc0Zyeml1UHRNa3psbXlCNE9Ma05qR1Nn?=
 =?utf-8?B?ZU4raVRJUlN5czFRMnh2OC9FNE1pTHhTcXVYMCtwbkFPYlRyZHg1NXNTalM1?=
 =?utf-8?B?ZW45eFBpaG5aZ0k1a01QUXhhNThOd3lBbkpId3NlbUU5WUNYMDhPVjJqWTRR?=
 =?utf-8?B?OVJwQldiME5LdlBOeVVvSWd6Q3JiWlBlYWQ0OVRrSGltdXpKak03QlFhVmQw?=
 =?utf-8?B?SFN1VEsycmJLYXpET0ptTkxJcjV4UGhNbzBscEpaeEpmZ2RaUk1zUXdJWFZP?=
 =?utf-8?B?ellMNFFJRG95SVVCQVhVQUI0aFQvNEVHM2ZoY0NuN3JzOU1FYlVHRWhYUlNy?=
 =?utf-8?B?S1M1OGhGVElEUGo5a2UxRkVpMlVMOCthRy95dXVFNXUzSHFyS2lHZ3pUaHh5?=
 =?utf-8?B?MkdqUzlrQmQxT01uZ1A4cTNoZ1dudzBFRmZYZGhGK0JwS1hCVlFRYTlLUGxJ?=
 =?utf-8?B?VXh4anpaZFN2U1c4SXpkL0lKQ3pOQzZQbURZTkJPSmhmSjA5LzVQeE0xUExU?=
 =?utf-8?B?dnFjay94dHpMWWpKcGswdSs1cGVBSHBERXBiZVRKWWtmZndVTmp3WlFtMHVK?=
 =?utf-8?B?WWExb0p4NGp2MUplNzZid1B5akJCMFJyaS9YdnN2RGVUYzlITHRvYy9Iak9a?=
 =?utf-8?B?eU9YRUc2V1FObGRZSFdCME9BMzBOV3VqRlg5QnBjQ0Y3V3BtOHJ6OXphWkxW?=
 =?utf-8?B?U2hnMkwyM3FnaGZrVThtYnkrVE1Cekw4TmJhcWxlOFBrRXJyWWRJQUdYUWo3?=
 =?utf-8?B?ZmlsczA3N1R3bDk0dTZtOTNHUTVKa3lsNi83dlVIR25MZmVhVnVOYUUzbjdk?=
 =?utf-8?B?ejBDeDhaTHoxaG1NWHpnL2pJRzNDSDVQNzRybkt5c3doVWlXRGpDeTlqb2pP?=
 =?utf-8?B?RXY1TUZuOTlpSWxnNFkvKzVlaHN4V3VWTHFrR0ZudUowcW5pN00vZiszRFYx?=
 =?utf-8?B?c2tpVlRzZi8zek9BNUtRN1RnTTA3bGtWdVg2RUJPV3c1Q2JNczl6cFkyamp5?=
 =?utf-8?B?cDZuMUcxN3EzQzJLalV6K2R6RFFCNVA2NEZBTVQ4NVRPYXBFS2t0Um4yMyt5?=
 =?utf-8?B?dGtwamFzR0dKQjFtd1U4NzlHNWtDRGRzcmgrQmpCZ05lYmtmS01MbCtyL3h2?=
 =?utf-8?B?Yll2bUJXMEdIWE5jNFcvRG12MW9OL1NVN05QT0ZyeG14ZHJ5RXUzeFV5TEpZ?=
 =?utf-8?B?enpvRHkvcnBuU1JiWjNyYmI3Q3VpMnFaVWNnNFJiYjl0TFdvUkttakpKV1g0?=
 =?utf-8?B?MVZRdm9uL0xDOEw4M25JdlNBa21xWmxjRlk4TTZFUnFwUWxpWVVaSVo2WENz?=
 =?utf-8?B?SDlyNFF3d1VBUURFMkFzSjhiK2cvUkluTS8vYzVIQllMUFFscUROVlBIYlEr?=
 =?utf-8?B?S1lsOHNiQ2Y2ZGhUcTJCYyt6dlRSc1Ntd1NKTzNIV0lkNTUxUVY0SjNpdDh1?=
 =?utf-8?B?QmJGZjJMSEhHR2NuTVBTVG01WjZYQ1p3MFordnFmRmc0bWl5MURFSC93MTF5?=
 =?utf-8?B?TnFSU1ZUN2VTNXF5WC9paTRXbWszVVRVYmtFTmN4QzQzVjNwK29iOTNVUzJT?=
 =?utf-8?B?dGZna0hjUXlBT3hLdzFic21VZEZNOEtwNHd3a1IrbU1yR21UVkFvdEdwdEdB?=
 =?utf-8?B?bzJkRXBURFo4RFRHL2tTN0hBQUQzMTlUZTFyb05UMVUzNktjTVpXeW5mRThi?=
 =?utf-8?B?V2lTUHRaVXkrZzB2WHNKSGprb1dET1h4dmdWNnFGeVQxQWl4TC9Oa3EwaU9L?=
 =?utf-8?B?Yk1jVGQ4MmlKWUNtTlp6REwvWDhLUk52YzU5QmFZZTRKeEFlSHNWMU5aNkR1?=
 =?utf-8?B?clVzQS9YT0xpMDBxbmxQN3dSQmhmL1dwRm1EZDN0dVo3K1BrNnA5aFdMU2xi?=
 =?utf-8?B?d1E1SmN3cFZRY2E2bTJnb1ZBRXRReUM0Zzh2RGJKMlVIQ05RUXVDZmplT3Jh?=
 =?utf-8?B?TWcrK3JhUWxYNU9KNVlKdkRUWjZpRXN5SWMvRHo2MzEzSklnS09aUWp2eDZu?=
 =?utf-8?B?UTN0OHVwcCtRc1VhU1hOdGNvMWJFZTU2ckdlbWY2eVpBMWNkZTM2ZkM3bWtD?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f585e5d-fccd-463f-b953-08daf8a6f86c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:22:04.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxZuCaShOIXU0EoiMxCRIKIcR5TB2m5kPY9fTzCzu6RqKD1t9eaYidVOJCeRVwo0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4575
X-Proofpoint-GUID: yUjqlxE4ZOvLIMoS4VhX3PLXMGJeN0Q_
X-Proofpoint-ORIG-GUID: yUjqlxE4ZOvLIMoS4VhX3PLXMGJeN0Q_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_07,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/16/23 11:09 PM, Peter Foley wrote:
> On Mon, Jan 16, 2023 at 11:05 PM Yonghong Song <yhs@meta.com> wrote:
>>
>> If I understand correctly (by inspecting clang code), the stack
>> protector is off by default. Do you have link to Gentoo build
>> page to show how they enable stack protector? cmake config or
>> a private patch?
>>
> The relevant override appears to be
> https://github.com/gentoo/gentoo/blob/c5247250e9d4a09e67a602965a5f72be3cebbf34/sys-devel/clang-common/clang-common-15.0.7.ebuild#L93

Thanks for the link. Looks like this is a security feature added by 
hardened_gentoo progject (https://wiki.gentoo.org/wiki/Hardened_Gentoo)
which unconditionally added -fstack-protector-strong to the clang
compilation flag.
