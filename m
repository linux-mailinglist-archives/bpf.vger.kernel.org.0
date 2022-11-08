Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C66209D8
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKHHEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHHEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:04:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECB8DFEF
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:04:21 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85q2Yi017254;
        Mon, 7 Nov 2022 23:03:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0tX9KceRYhFKRhdZ6424utH4mqqZfJDmKD4/e73AK3M=;
 b=Y+G6PikpTemHaOUQRiidozc4X9SzWDjBQF/XVCqGaa+miQOcD51bG+yOGeRXMtiRwUrY
 uo/JLfACn5X5LliC6EfjEWfzIzFptrmhXLUs0uexIu3Xt0sGkQBeeYQ0UhraLHxcBI2m
 5YlR9mGjRWFwwJ0eWk+0eu7OL8S53chf0JwalgrdRqHoE6ovVVyYBcsYOK2RSciBsNos
 Fz7+kxkIQL4N6Ppr+vtlsIlU8qpOeUvUN8zWWhSVtPSLG52dfTy/CdJYfycDNmgkaVEd
 MmgVYl3nlBkO2Dx7h5WDhtsh2ffsbcGLMNlrFJhH9bOEWqFPDZBcdKrq7pJnycpxgaIN 6w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqhba0bem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:03:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj4L26TmcTh1NaUCssZ2anlie7/sxNeqCZgwGKdjzgPh4u6BXZ2JepP6h8H3lfaqNa/rjWfJUFeZX440hyNT1meWhFjTIhv1AAwMaaAdSvrVNWOFW/EbiG/3WEWlXMumvvZKW6DrpMun309fBKgoHQHFfLepHcMxQHx9y1oZX6us1hSi/um6CU1WLDDZYwqTy3b6o0ig89vw41nAc680Iqdz9C46TgfU3MqcgdsZSbekIq4RAKANA2ajdc33A4aY8Dx/Vbhn6vy060DVBHwEhJX2G8kLHTNTg3MMbaHMUvGG5DyBy9jnwrFubBdVH03Mxbtxhjrk/F/9mAhuYd920Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tX9KceRYhFKRhdZ6424utH4mqqZfJDmKD4/e73AK3M=;
 b=ZF+XkFasYEnKAoLbxPFqWpp9Ww0rw7Q1vBRJvpNTPX/XCXocwvIEaIF6dZQ98VVnlJZR77WvylhZGgag8Kx/q25Ed8pBAsakgGlTQjV6/zsPYWPV4EhA9Eu1xLKnKc7PQYRvrGYaW0oXf4KgzKM2+oHEnCwn4r1SndOxQEoFAMH6ztVannRnDFp4pxChXrNeUJEnU78CZoI7a8DBqgk14g9/o/lXDdXS3KZ+JAPEOwnKkPva5qXv20RK4SMOuY7SI3+6JioUoki/i0ZTrBe3pQzOFUoowMajFYmxHHeKGPfngPelUUeAV2YZ+dChOuOTXVXbd2VPibmFZjsz77nZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1385.namprd15.prod.outlook.com (2603:10b6:3:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 07:03:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:03:37 +0000
Message-ID: <a85181da-99dc-d3a3-53c7-96584dbad8bf@meta.com>
Date:   Mon, 7 Nov 2022 23:03:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com>
 <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
 <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
 <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1385:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa6b0ee-2a32-4e7f-a543-08dac1575c16
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpBPjdWgsDdPp3DznLKoXp4fLPMMVrThJ56LRWdUQFYmhVi7oVmkKPQNeiURkbG7FQu0Aed76Sq8tQxlXtv04Jg7qEmx9HUCqPBAXL9JPt32GDwzq3HAK8ZGnbC0fwUnzLFahQUQc/DVw7Sc9cvFtP0h5oVzglSPTpK2xKx9Tgd78aBJ0tnjjgonYdmo1z1rSk8x81kX/YEecI6QIcoNqDwFLWd1TW2+ecGfEpkGDa0ubgh8tG5fA30NMH8Y8jG7gNqbfJcrYdb0X8Y7fFAbIQoHBymyRGDjVL9tGm/6zaN39w74nzeTfURfn6y0/Vx6laOUKuStExBnlqxjn+X2o64ZJgYZ0LfbeJ0hgJEDLwtRQ79WuzjqW+dGvdk5KHlA7iDhjsOyXNtLYW2QhWC8l5bDVQ8RXQFzPy3/wK8syRTxrbwApsI1M8roqDTmLaopJ1YOuoDQzzXeu9SLm+KyaYwZ9VxnGQHOLoXpm8ecDhdOaHg4WLld6bquksjtaO8MdzIOslV2StsPfmc0tWn5g7df8egIkzSzrIiRNCHgCWc945u+XtBpg5Yu00UZ2Cx99hu8GmjQ8F6j/0FqeKSvZKcrE9cXawCbqMn3Q1qMuwTeBDGhGsEvTofw9dElWyEDYOonf3N68oxx/sx015P4zssb/v7BMY/fjq5aykdiizIdxlhP/uIZsDjPlAqQ9eTRJr6I5SVr2lIKiDDL1WKe7Ai3ewM6H1B2j/Gqsdwv5e00ji1wnMbAsRzR9j60GlQHDjKEnrjOEWZDVYQoy8LhO4OSQvMOdWpjMAEhgLd29GvULu5U3CTAVdg79Po5yKtQ7I4UinmOMLDViGa1qp1CwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(31686004)(83380400001)(36756003)(6506007)(38100700002)(4326008)(86362001)(2906002)(5660300002)(7416002)(8676002)(8936002)(53546011)(31696002)(41300700001)(316002)(110136005)(2616005)(54906003)(966005)(186003)(6512007)(66946007)(66556008)(66476007)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUEwMHBwM29kNUJYMnRZQVk2VitNN1U5bFkyODlHQWl4NVp1Q0lIdDVENEd4?=
 =?utf-8?B?OUtRNEFhYjVNOVlaY0h3SCtveHk5eTdLdFBpWEhFeThVc1NZdHB5UDFiU3p1?=
 =?utf-8?B?NnNmZnZPWVR0Ym1jSlU4TFkrM0NqTWp1NCtLS0hFcGFURWs5YUVZYjRPZEdO?=
 =?utf-8?B?clg3bkp1cWpZQzk2Y0JjZCsyV01QV1NzeXJYYklLNEJPbnVZTG1RbGdzTkRZ?=
 =?utf-8?B?VGdQZTRQV005bEUycklqVHd6TDJ2NFMwTi9oWmd4UWhXWVhsRVBjdmsvdktt?=
 =?utf-8?B?Zk5rbHBWdXVYTG80NUpYcjhFeEJ0Rnh2WGxzZ3ovbzZTMndMVyt2Q01hNUhl?=
 =?utf-8?B?UnhUa0NxYkM5TklHNE93dUJwQmxmZ1k0WXFIVE9lRmJqa3F0enhwanRyWlFC?=
 =?utf-8?B?SzB6SlJ4SDYreEZMRnNnRmtBMUtaZDkwRHZMMXh3YVJ2cFhIWFVMU2l4MW5H?=
 =?utf-8?B?QmEvRGd2SVBySCtvSW1NbmFjUm1JcmJBVEtqVnFVZzg1WjlEdTZXZ0VWWDFL?=
 =?utf-8?B?cWluSUF1RHVSQXByMHllU1Rkc0xIWFNLUW9wYWFWSThWRmlvZmVmL2FHM1gx?=
 =?utf-8?B?K0JuUTMyVkhQSUFNU2hsaDRRSUZRZWs4M3lIeFNCRUZZSjRZRTl1S0NSeGl3?=
 =?utf-8?B?bXh1anBaRit4SXEvMkdPZGhoL1pjMDJTTml3RG9icFpVS05RN3grak83Nk14?=
 =?utf-8?B?S0hWbU5VV3VsMGlmcFpQcmJleUo1ZEIrcEJTajlPcThzeHFPc2tUdE9JUjd1?=
 =?utf-8?B?U1lyRXY3RHRNS2N4WXlJVjM4WTVDM3BzaGtYWHdaQWZvdy8vYWVWQWpPdlJJ?=
 =?utf-8?B?U2V1UDZMWGtIMlB6N0FHWWwxc0x4TzVDZHYrSUorNy8rT21rUzhYUzQzZVRT?=
 =?utf-8?B?eXhBb3VBdDcrcTNTeGFpUkI1NStGcUNlbjdXeGdCaDdUazMzWktpRGNGUktH?=
 =?utf-8?B?ZER2dERXWnFzN2ZGNXpvNHNDTStEZUp4aHpEQ1R3OEdGZnU1OUFCaG5DRTE1?=
 =?utf-8?B?cEJMWmVqTkR0QnA4empiRHV5ZVlpUFk0UHNlU05iQjE5SjdVUmhBN2QzMUo4?=
 =?utf-8?B?ZDJaTUtoWS8wRjdqbm4rREI5NGdnUjBpNmIycnZPU21vYis5d2kwSEVrM1pD?=
 =?utf-8?B?amMzSGloVEFjRFVleHdGNnZlQUR4UURwUmN2cDloK0VBU3Y5T005YUxkOTBT?=
 =?utf-8?B?V0NwMGlPRmpnWlpLNEVCMU1pSXVwRkhzeWowbVRWN2h1OVJsTmZzQ2dPTWp0?=
 =?utf-8?B?WlNod21EY0d0bGU5UnprM3ZHeXh4ZjhjbitjMFdKdzBYVHFhQ1VrV05MU1Mz?=
 =?utf-8?B?Z2VwNWw0OC9JczRaZDcwNnBpZy9ZbVZTYmd5VFJ6YU1FSm5TcFhnOEhDMWY1?=
 =?utf-8?B?ZnNLMjRFWXpLZDl4Q3IzdWRENE1iMHhkd1dKWXJMaFdpaTM4SlhKd2tYSldD?=
 =?utf-8?B?WTluSzNEVVlxSjlaZXFWcTdKakdrMlE1OFhySk9xZFFtd3FIRHFFRC9ucUI5?=
 =?utf-8?B?YUJCcXdKUVdIdmdhQmRwY3ZkTlZMU3YvS2poY1ZGaTYxeERtQmZhbFNLZ1Rx?=
 =?utf-8?B?S1BqMElhWGh4SmpzTE5QUlkxVjl4WGdDMm9ER0FzQVlacmZ1cnBIR3FlK1Y2?=
 =?utf-8?B?cDdLUXluSnBsdnRTT09zQzdSeDRaNlA1Z1h3Z0w0NzlZS0x0UGpJZDd5TlIr?=
 =?utf-8?B?aVpEQTRNTksxSUxJUHd3Uk1YaytZWmxSU1MrL3UvOHBBSEVUdnlZaUxPdllo?=
 =?utf-8?B?TE1BdmszZnBUdGUxbkhQU3d5bTdXcEJqZWZQcTRKR0NOUmRidjZkMGw4K1BC?=
 =?utf-8?B?bXkzTUhjTlJkcXpsMTZteXBmUmUxWjFqTldxU1NOZ1poekd5QW9nL3ZFdUxv?=
 =?utf-8?B?blUxUUNRTzYxcFRwckJtQ21nRjQ1cXRDd3ZuVVBQSDlTVUVrakpPNnZ4N0FV?=
 =?utf-8?B?WDQrOTROelZ0cjBsTloxM2dnM1hGZ3djNVVaaTVtYWt1THB4dGpLdkc2b1Bo?=
 =?utf-8?B?Z1M0QXFnOVkyYmI3eXJzK3owRXBYZHkyRkpwcVhHNTdha1ZYb0xrOWRnZEpw?=
 =?utf-8?B?SGlUU01QNUNOVDNzQVBuaDFqcjZuWlVuaVNkaFpBdnZCMitub0EwR05wRExR?=
 =?utf-8?B?UzlNb0hxRTVqS0MvSE1DK1lBVlFoRGVwaGxJaEwvN2pzTzA3N29Fb2k1RHU5?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6b0ee-2a32-4e7f-a543-08dac1575c16
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 07:03:37.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R97rqnx/iNls9yaWW9nXqojLtb4XTBMubeHl34/8NRsfd968xjssED//9sV8+m2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1385
X-Proofpoint-ORIG-GUID: cwCPf16cfnjHSwI_plEkYls-7j5u3cI7
X-Proofpoint-GUID: cwCPf16cfnjHSwI_plEkYls-7j5u3cI7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 8:08 PM, Hou Tao wrote:
> Hi,
> 
> On 11/8/2022 10:11 AM, Hao Luo wrote:
>> On Mon, Nov 7, 2022 at 1:59 PM Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>> On 11/6/22 11:42 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> bpf_iter_attach_cgroup() has already acquired an extra reference for the
>>>> start cgroup, but the reference will be released if the iterator link fd
>>>> is closed after the creation of iterator fd, and it may lead to
>>>> User-After-Free when reading the iterator fd.
>>>>
>>>> So fixing it by acquiring another reference for the start cgroup.
>>>>
>>>> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>> There is an alternative: does it make sense to have the iterator hold
>> a ref of the link? When the link is closed, my assumption is that the
>> program is already detached from the cgroup. After that, it makes no
>> sense to still allow iterating the cgroup. IIUC, holding a ref to the
>> link in the iterator also fixes for other types of objects.
> Also considered the alternative solution when fixing the similar problem in bpf
> map element iterator [0]. The problem is not all of bpf iterators need the
> pinning (e.g., bpf map iterator). Because bpf prog is also pinned by iterator fd
> in iter_open(), so closing the fd of iterator link doesn't release the bpf program.
> 
> [0]: https://lore.kernel.org/bpf/20220810080538.1845898-2-houtao@huaweicloud.com/

Okay, let us do the solution to hold a reference to the link for the 
iterator. For cgroup_iter, that means, both prog and cgroup will be 
present so we should be okay then.

>>
>> Hao
> 
