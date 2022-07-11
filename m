Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADE57077C
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGKPsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 11:48:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EC62A7D;
        Mon, 11 Jul 2022 08:48:23 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AIjADu012568;
        Mon, 11 Jul 2022 08:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CXaT/UZrhLe+ZSNadvk/XKZcZZDkYLbU+BdhY1Nj6/Y=;
 b=rBR43MuhxyF0i9dHg+BHmxIJyVzPe/6cX2pq8313soKDEOQiVYdX/OUECnY9TnbGG0jh
 E1bjnhFAkBqyzp9wT2qY5EqhihEPA7tyNFrpWwWvzThY1rvIZw36FKLM0+XiVuuQHs+N
 tqtegPj3NK+6gEUiFpMUzxpd/Z4Y+FuHPc0= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h79041fch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTmfuF4I0en7UFpN52xZECaKaepJZrh0IXsoX58oYCqbZ0Hucucl5zJC/FyPjdGPMlfVLoZF6rxXnmGSaSM49OM4NBRHBWrgizk3H9/J86JvHVGpXmAf0UWjR+Uw7BG/zLgMTgeDBs2+uVKLthmiwp7FEf/xUmbnBV3MOS6IeXJMgCyBZBH3wXEGwcHUFdwrsREGrY6E7v3CdjOL4BRWaE53HoYHSlQ/cKfcpKDL5nYu/x3pQ3hgtVxYTH7aBSM6lmAJrJHwadTC6Z8vY1rCoJQ0uxzY+TdzVjGX6+f/dYBmTXkZpUcadIyF8KgOJwhr1r5KtanmkWHNzxjNY1ByVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXaT/UZrhLe+ZSNadvk/XKZcZZDkYLbU+BdhY1Nj6/Y=;
 b=eHm2y4IDX4SJ5UW4HZGBSjESgwEyv+9/VtCjzHHHovkWklIkNErlJn9dqfxwIJKjZe+Sh0rBhTvXRLuYglKS2ifmy2eddj5KPRzYhY92RPKgM1hn+Xjk5bzS/whU3ga6MvjaTKnhDYyDEpYvpB35i7CsjYR/Cmsa7+o0UyEzRC+YNNscs9+CZNu229oZRklv15wojAEYnaj7dVr5nYfCco75qqCcErXOE60NO98RIJgGd4UWI/Vzo05BIxmDSJc4/NInAoEmfyQLHTCpqpw6a5P6IO+0APfFzGLGaMtFKH8A+U2PjKuzoPoqacgq78gwED3+rmRAStggtlsHDQngvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN0PR15MB5369.namprd15.prod.outlook.com (2603:10b6:208:374::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 15:47:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 15:47:53 +0000
Message-ID: <989e1d04-788d-57c9-9e72-7552e6adc815@fb.com>
Date:   Mon, 11 Jul 2022 08:47:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v2] bpf: Fix 'dubious one-bit signed bitfield'
 warnings
Content-Language: en-US
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b470932-a7f3-4363-b761-08da6354b786
X-MS-TrafficTypeDiagnostic: MN0PR15MB5369:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORBDSf4ZVAtuEGdangViu7v9QEVzdMtwNLI7An0OwcO7lJS9hfyL7nkGQASn6yjEKOB+BDyguQsEVvg35kamZPUf8AO+6kyaNr21IUnZXEwr9oeHV7W8pOXLfo91XK5ofGDG3xAen389a4EAweenhrOEeAIRVUh99FGQw+4pMYtNpsW4jULg/0XNF2+B0fQma4V7ygcNigDcTXl06cFjw5HPWtpgCfr7HJQquyXjORrKqq4sgXdAX5jkR1vTy2f3m7eR2EzLMv3nblqEEwowFbqP98czcHPgnM717N4UyrX6jNsqFO36BWWY1eLGTlDl9B0TFJTdFBZm7hMLvREci7mB9uRgoqqJQMKzgceqoM2RfOW+dAma7Z4qU8B9HxAGFodsbuVx7lNbPaDAsvvbXe0eq/IWjllWS/mSut03FjoRv0AZAj54wWX+Ygwkqdy9BG+Hzb+C7oRtfMizR0W+kGgX1ucGWbEJd0zy3Un4qbU++t+LIhfzSvvquwiFyGgwHnkFJ1MXxU2ZYqg2ofqhj1LUUfJe1+GI5PRvg1mqj4AWTqJ4jgYZN+XZh5q/NFC7mFuVkgk8M3rvU4EGxRA4pTfeJn0h8uqtaPhjkbJ0VjvRett3KhhTziSxN7ud4sFfafyXjAMGZFRDS+a4rDeBY6yBPySZokrajqhQbKvWpwPnz8KeBSKgkw+AuInkAnx/5CXwuBzxbCccG86jFVZFiaizHz88y/vcdHJmQDE4eJJIY9h45+ichw2L76VKQpsQjcS/HriTMWOzMPsBoB+na9TIZw2sB45jAOkFpBF+ex6+Q6JLpe6i563bEWJHYOZYEB/8cS1tG9saZbBwWBoHv+fNAJT9n1k3BvlfKBm5LkBc2UADiI9ZzKXoZruscorqghQqrZTmOYCWoblw+JKwHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(921005)(7416002)(6486002)(4744005)(966005)(38100700002)(110136005)(8936002)(83380400001)(316002)(5660300002)(478600001)(31686004)(6512007)(31696002)(4326008)(53546011)(2906002)(8676002)(41300700001)(36756003)(6506007)(86362001)(66476007)(66556008)(66946007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVwa3VkODRqNkFGb2ViUTZoRVM3Y2VRL2pTeWdHb3dzMHdEei91RzBHd1A0?=
 =?utf-8?B?Q09MSFFCKzM4UEl0RWhSYWNhRlBURXhxRUgrMWNzc0doYlpQejlQdFVTeDNy?=
 =?utf-8?B?YU5QZXRONSsyblVoVVE1QlFiYjFRRm5KZEx2ZXg5eXVsTGpVbDBzV3UreVB4?=
 =?utf-8?B?VkJkcGZudFJjVWY5V2tnZ0JJVkQxdGFGMTZRWlR5Q3NhOXhyM0wvTk05SEFK?=
 =?utf-8?B?ZnJkOTNXK0d2ZVNuWFV5UWF6Wm56TVpVTHhHSktmNjFXRnlFNjRISjJRSlVG?=
 =?utf-8?B?c2N6Tk9hei94UDBvdGhmdVVzWXgvWlNJRm00dTZlRjNXSGhNR1lCaitseFpI?=
 =?utf-8?B?bTVQN01zYmhweHB4NmxBZS9QMHRrdWRhMzIwVkpWcEdoUS9abzNXNkJ1azlQ?=
 =?utf-8?B?QlJBdlRLSmtBUUMycnFMYTZhNE1kU0p5aDVrNkJienAyYkw0VDRNOGZpUDJD?=
 =?utf-8?B?cGJJczV2WndsNmVGQzhYdXFYbU54c2xnS3YrdThaOTMvbWJTckFNN0VGTDJW?=
 =?utf-8?B?K0NpenZRWkJaTDlPVnM0eVNydTIzUzQ5UVI0Y3dUTHMzT29tZjhsdkFJcDd1?=
 =?utf-8?B?OUhTalJKVHVyMG9GQiszRjZYR2dRUjBhNzdDdng3cmpvVThQVEdnSk9wZ0hr?=
 =?utf-8?B?c3dpMEh2bnErVE10UWV2NXdpUUMrT2o1eUZCTC9vL3doVWpzb3RreW1ISzA5?=
 =?utf-8?B?Y05zYXlRR3F3ODJYNWVYVWpQU0hQZjZmeE0wcy91b25zRDVXS1N5ZmVpZGc1?=
 =?utf-8?B?NE5nNUNxOGw4MjlvTDdBTnI0NUZLT3JkT1NaNWtCbUNScXRLRlByMnl6bFdK?=
 =?utf-8?B?OFBSZkxJZFhrM1ExbmtheDB2WGZjSm1OUFJXZklUbnJGTk8zNlZRL1JXd0tO?=
 =?utf-8?B?YldDOUV3YkJMTG9rL1RJNlBNMldtbW5tYWFTOWVIaWFSNHJ4TXhjYlpBQmI5?=
 =?utf-8?B?YW9ZNHdHZlcrOUo4cnAvVkl2ZFJkK1RpRjQ2OGlyUytVTmZjY2xnY1Q0emRr?=
 =?utf-8?B?SDB3N2dkWFRqcjBJblhBc05CRVBPb2d4MHlZTWZmNmJpR0NVQXpFaG1XcE5x?=
 =?utf-8?B?SXFRZVpDZDkwZjhPMTArN09DdWZJeFJCRmJoZ2dLQVhpZndGTjlrS2x1cGdI?=
 =?utf-8?B?aExDR01lR2hRTmUxa3g3TnBpWDhOd2JQVElBZ3BFVUYzZVN5OU1jQitycGRP?=
 =?utf-8?B?U2Z3eWVLb21DVnR4aS83dXBmUEZkSnFKZkdQOHZSejFXcHhkaEtqV2wwMU5I?=
 =?utf-8?B?K256N0IzR2xPcDhrbDV6aTBPUzhQbDl5UnJnTEQyUnZOdXVEZ0tGSkhvUW1o?=
 =?utf-8?B?elVzR2NXclhsVU1wVDV3c3MxRzdCVXpDdkxkLzRBaWtYMjJJYVhoaXp5dlZr?=
 =?utf-8?B?Ylh6eWxKUmduTC9jdjd1dWxsRE15Q0lrSWFPSEUyR2ZZdkxGd2xOQjl4N3hK?=
 =?utf-8?B?c3g4M1A2SjE0UWFEOUFaRWZYODE1ejltOFNYcEttU2I5Rkp6OEdtUm44OU1r?=
 =?utf-8?B?MTNKbUM0ck10SXgya0Vwa3lMN2dLRUYvN1I1WXVXY2s2cFRlakE1cXdsUlVJ?=
 =?utf-8?B?bHZHbkl3QXdHL3hZTmJlL0pDRkVRY3BtaG4vYWtFdGNtaFBPVitQQ2lJREJ5?=
 =?utf-8?B?Qm8waDBTSGZJSDhlQ2lvMXgwSFEvUDQ1RDB1aS9uVTFuZEUzTnpMQnp3eTZp?=
 =?utf-8?B?VmlPTEQwNVc0WFpjVmkzbG0xOUl1bU5CZ01abkltUXlSMUtGVnRPM3BRTDZj?=
 =?utf-8?B?TTU2RDk3b3pBanFyc25pZ21TelY2ZlUrOWZGd0RVZlBhbUxJVzVOdWs3Z3pS?=
 =?utf-8?B?Z2x2akNYNkYzL0o3cm9JbW0zeHVRTmdqajExZWhubWRtYlhRUmpMelFIWnZx?=
 =?utf-8?B?OEQxL2N5dENVREtZcmV4TkVBY1J5dW51Zjh2R1VGdmxvczE4OWZ1SjZubEJj?=
 =?utf-8?B?Uk1GRndPcmI0RjhocWx2Mys3UXlMeFdwQ003ODFPS1lGeDJXOHE3dHJKWm1B?=
 =?utf-8?B?bGpjTlhkaVN4TGhpMVdabUpZcm5qWFZLSFdPR2R4QnBHQkdvMmRXRjV3M3hZ?=
 =?utf-8?B?dDZJUm9PazBlRVhZamZoajkrOXJ5OGJPNlN0VjltMlAxZS9WY1NZUDNSNzNF?=
 =?utf-8?Q?GZYW5I5cPKJMFp53j2x7+UxNN?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b470932-a7f3-4363-b761-08da6354b786
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:47:53.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS01wpREpRTPUm/h5AXUSFMTi82n9iUZk9PtR82ZrPxhDL3yKvTPH9VrAMvzMELF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5369
X-Proofpoint-ORIG-GUID: 1j2XeDSRXZLgJFYqpWfgeV5kZJgU8Dpn
X-Proofpoint-GUID: 1j2XeDSRXZLgJFYqpWfgeV5kZJgU8Dpn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_20,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/11/22 1:12 AM, Matthieu Baerts wrote:
> Our CI[1] reported these warnings when using Sparse:
> 
>    $ touch net/mptcp/bpf.c
>    $ make C=1 net/mptcp/bpf.o
>    net/mptcp/bpf.c: note: in included file:
>    include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
>    include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield
> 
> Set them as 'unsigned' to avoid warnings.
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487
> 
> Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Yonghong Song <yhs@fb.com>
