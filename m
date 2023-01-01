Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE665AB06
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAASsx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 13:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAASsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 13:48:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6012199;
        Sun,  1 Jan 2023 10:48:49 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 301FNvnn018491;
        Sun, 1 Jan 2023 10:48:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=M8aC6ZjKwYt+CC6NNAlSmW8NtV0mgw+ajC8ob7laARo=;
 b=VgxELCJypVVHNohlQPTdqsgpK7VHpqCGSYXV0PBxEwH28yt//NBc9PF4m/KU6kisNW7s
 kvelNpKp42qfg57/RTyT/u3CyeIKOtxNiUtS/Yg5/QnZ36UaTKvAupHulDgiOt8sCciU
 o3HIyYcw9Wbsjlap+blByZawG2D5/phPZl8vIAqKPtRjGcIOUytnjrZ7FdBfGFvCEoFV
 Mh5ynTWGziIX+tD2uhy4gVBg+d1fy2n/ZByiqUwKwkdT2PNtqpSlkF1oBOaq/S9pSeiz
 WhIOK46Djbb92XgtQ8dI/q5/HRZSenhTYnhKKF2gFfhrVrfjsFbqVQaWkJZfk3kMHeID QA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtk34w55s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Jan 2023 10:48:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrCBZMzuVpxHBhoggyTzltfZYWSUhsBH7dVl49sBEyPCgpjJwxMvUeuMzXUNk5YkAVDDzDzctqeLA2Jd8MUQnw54+54gBbHg1LJAZz7I+HjsUH/r5fNtr1nuZ7i146XaWTtBJfXlfuC83fP1wukPw0E0O2A5wASA2z/+PPNcMN5/+n1NR4mF4+34h05U6Yv4tviPUr4AMiG+y090GcivYP7qtbyJVphD6O8vo/ASqH2dqL49n2prJ9x+ea8CXHVDVlDphgHNbGc2By5B+QPmaStaBoObKlEH+39TrMS9PycBStGkOn2l1wY0VdjKtpjJKdlOmMPJX0zoqPgriOhGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8aC6ZjKwYt+CC6NNAlSmW8NtV0mgw+ajC8ob7laARo=;
 b=dcRun/qPUN4sLN2nX6KgRDKkkgrcKan82L1L+F2Jgi+fIJZJh0y8CMdOagblco1o+55eU6NExVe3/ItUVShKfn0tppJh4JOB61WQdo7syo4YgaLP+fQWUMu/hUj/Zhb9HiigS8hSJV6sY5bYmy+EAeMLC6y6orvjYWAqnCgbP6dJt24IVqfXcwYT0OMxwS7cgSv/c11ZiPryULDXGLCYbJ+JgQLJqvAa5n/keQvu5Ixw/49gXFJ01BysJp5WHhC5lUd1kj9+m//Qcb/LQT3fV5j+4djySA8Kfp4U21+U69BXFXcrixVdL+nh0TQhRsNHzQUP0Pm64eP+0fVbOS/OPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5767.namprd15.prod.outlook.com (2603:10b6:510:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sun, 1 Jan
 2023 18:48:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.018; Sun, 1 Jan 2023
 18:48:06 +0000
Message-ID: <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
Date:   Sun, 1 Jan 2023 10:48:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6dde90-8690-4ea8-0f6b-08daec28b834
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+uRNwLfGeA/KVkvOYVgj76ZTpICWudhpnx+Ce5R2BxyQRfvj+nCcGnup07AP9tL8kOzLlVuwIhXEc8SPCfV/81smhD1v9pEKNfXrAzFoEktCP7cFsDzuWezRn4AcKEbhsasvXY47xu4GFd4Ae8YW6bKitoQs1MgaQzQswzvcTS1oQUbdPOy8qUOGbzGC0Xqy+gR7OxpWsiXFS++udAyoC2AoTrIUkrjsZpckbNA//u2DfAzSB+CzVivG9R7g+6p0DrI5YltugXRKeH0huiqWUwAi94g4jkug/wHqo1gHqzbIMrdCyVcoLSF4RBUUqwqFkBP4W/l3pxwBpoFVFbY9zUtLv4blWt5Ix0hFx0R0PfpPy2DlFjhADdr/4E4uBdrFBs4ROWndPZd19OrUeZ30PbgzcPdah7CBiqLHoCbwwdnQ/5YD1GFbNLGprVe8Hlfx7evRmY02I2brfmL5QvefP78XS7TtqW2hAzB+XG5i5cPb2a0IRnuk2UzVhiMJmoutqfWrb0HA/+UslEDNdb8Bna7NmPrSlGRbmdl5AFPrZNTcaNJQ4/b7vEhAz7eF9fBGGgzgwCDb+Xc7oToRFnq2myy55JeNVxtXuyhcqFVppkMCojS8tugx0fNpWtHtKGP0nISUoxCQ75WCGLbf316JSlJw3q87GT/pn//yByQ6le+rAcuMCUfdGvwNKHOWnUyyRsA74bFFrKEJdYU01vHWU47CEj0EgZxIv4w/SPfMFn3+UfvgvAaKsVXtNCb2Pbpqska+4IghLhIjrYnGlx41Yqhhw/d/6Gek6w/dC/jzVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(36756003)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(7416002)(31696002)(86362001)(83380400001)(6486002)(966005)(66946007)(66556008)(110136005)(54906003)(31686004)(6506007)(6666004)(478600001)(6512007)(4326008)(8676002)(66476007)(316002)(53546011)(186003)(2616005)(22166003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ako1UnNGd0p3RkxHT1NtcUpDcEtZRlFNRFF3VDF6Z3BuUXJIbzFJMHBKcWRU?=
 =?utf-8?B?akNycEVrblBoamdBSzVJT0VrSjIzSUJzQWU2aFNmaytRcDhPWE1aR1ZWWnRv?=
 =?utf-8?B?Y0pJdEgvT2ZSVWFSNlR1SGNkaDBUeG8yRS9keUJIMy9xUk04WUZ3SCtTcmNt?=
 =?utf-8?B?bFR3WFlVUnJrYlJKZ1h4ZmRLZkpHb1R6TElReUxmOEZXWDBIeVUzSHA5MVhq?=
 =?utf-8?B?Njk5U3gxYWpvRU94YTgvVms3R2ptdVpHdllYU2FBa0ZwRGs5VU9ieG1SMFVx?=
 =?utf-8?B?V1B3SnJNbERlK0hZKzlMeXhzK3VuTVIxWXJnQkVjRGhPR20vU0ZON25hd0Nx?=
 =?utf-8?B?TjI4alFNRTArVFdSdVl5dzBlSWpPaEFYWnl4U29mWlhNRk53WXNBMUpWT1Bw?=
 =?utf-8?B?OWFtbDhVWW1rcHpyU1Bpai9ZRXBDdUo3c29FMGFCQWV5eEppdUc2bkNUY2dX?=
 =?utf-8?B?c1N5U1B1MFZlOG5mZXNleXplTzJ5U1lmYjZNMVdzTys2V3RkT0UwM002ZW1j?=
 =?utf-8?B?V1Z1ZnRnWTY2akoramN3WXROb29SWU1CUldIUE5kUWEyZHR6YVNOVXp6aE1p?=
 =?utf-8?B?UnAwelpHSjBxWVZsbGlFWjAvM3RuaFAwYWwxb0g5K25meUU0WHFCWnJLazhG?=
 =?utf-8?B?VEpJNVY3blpFNFJwWXV5eGpZRGl2SlZGbkVxWFRUcmUzVFpaaUhKZDlxM2Q0?=
 =?utf-8?B?ekxhOGp5VWdOaC9DZ3cxblRDdko3cU1oYzhOLzRlRHl6a2FXSjVlajdWcWlm?=
 =?utf-8?B?UzVsNEdrQXhmbWtsNlRhd2QwbWY2bUxYRGJJWlh4eTR3aHE3WitSSEE1ZWJr?=
 =?utf-8?B?bnNVUERJOFY4b2ZzOGdMZ1cyRWc5c2ZoMW56WUpmL2w3Z0s5K09PcUFCcXJk?=
 =?utf-8?B?MVp0dUdTR2ZvUDc2WTVEYnVPN3hWdXZKQ2swOXRtTHowTW9tSjk1eldnMEJo?=
 =?utf-8?B?VG90YVJjTlhIWm44SjZVWm5VV1d4Y05KVkJIbHB2YVR5dDlhYzRzYXNpVXZ0?=
 =?utf-8?B?Sy9KOXRHL25lL1BHOHdjQ0dMQWU1ZUw4N2dDT29WMzd6RW9ZYWo2aWp2QXlv?=
 =?utf-8?B?OUZDeDRDY0FvMmE5QzhXd1hRL0N0UG9VNEt1Y1NWZUZPZVkrWStHbWNiS3cv?=
 =?utf-8?B?SDdLeU90dklPUXdna3NRajdVb0FmNGZwTmFESWdVOEhsSFdXYVJJeVRQNWxa?=
 =?utf-8?B?Y0JzQWpZQ2t1SFYzcFZzQ0hTOFZ3clA5YnNtRlpLTEoxV0tLNStkTTA5Rjl6?=
 =?utf-8?B?VldiTUY3SW5YT3M2T3N1Z0llVS9HaXBSMmJ0Nmwwb2FMeTg2N09UU0pFSk1s?=
 =?utf-8?B?WGNLaVFtRWVRZXJMaG9HbWx0dktSRi9IbHA4L0ZXRU5HT0ZLL3R1NjQyeENK?=
 =?utf-8?B?M3FyeFp5QXRkREdIbWNuNDd4WGR6UkhWcDJDR2xQNzZQM0lOVldWYUdKMkRV?=
 =?utf-8?B?OTRMT1lHOFYzYVIva1hIc29remZaTURwcm1GdHNWUTZ2QStRVXg5cm9mS2RN?=
 =?utf-8?B?NHpMS1krQ1ZZeGJFank0dkEzeWVEdktOSWFiWm0xMmg0eldBWjEydFJDZWtO?=
 =?utf-8?B?N2lTT3F0bDZiSWt5c29IZDI3M09CblFUeE4wc0hzbEJ5K28va0lWMlQxZWgr?=
 =?utf-8?B?OUNwbXRNTm1RcUNGb0lnWkJqWm52NHExazZRK29iQXI5YjFkbnNWQmNLWHFy?=
 =?utf-8?B?Yy9ZK3ZwZXVrd2xQTTZCOG8zWkltMDh4MXBoUzNXbEF3WkczbzYyZ2hXOTFG?=
 =?utf-8?B?b2E4ZGQ3bklUK2hHdmsxVnBVcXdWdU5mT1lOMGJRUFc0bW5Od1lGUE01YUk1?=
 =?utf-8?B?dlNqcVYxeDNaY3JGNExqekU1M2pEUjFqQmV1Z3ZDSmgxaWxqYXI5cVJKQ2NX?=
 =?utf-8?B?UnRpRzdQWXJvaS9Zd1NwNGhNRGV3bjd1a3hmUWNUVlVKeXVBT2lHMy93UkhN?=
 =?utf-8?B?R3dPTnoyemF0aTJ5RUd3cEdLNThDZCtwMmw0UkxIeWlDaFJsTlVROGV2bmNq?=
 =?utf-8?B?dzRZRDdCdVV0NmhWdjA5c2VQcXBSMDJHaFZReWxPTisvSitMRFFUa1FZU01t?=
 =?utf-8?B?aDk4a21lRDNuUjE2VklIMlZqS0pseUkrUUM2NHhRdmhFL1M1K2NJNWpLdkNJ?=
 =?utf-8?B?VEpRemM4TGpLamRiY1pIWGhZWXhRRlRhckhvSkc5YjRXM1ZsSDg5TTZ6VkhE?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6dde90-8690-4ea8-0f6b-08daec28b834
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2023 18:48:06.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTeGDqJK+qqfVs3Fh5TbNLMuyXdE9vF9qnrnrGSuviIw240EGE8sVMu7FwsTl33I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5767
X-Proofpoint-ORIG-GUID: QzYkfjzdpvdetHZOZdxTxDar2Ou-skU1
X-Proofpoint-GUID: QzYkfjzdpvdetHZOZdxTxDar2Ou-skU1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-01_09,2022-12-30_01,2022-06-22_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patchset tries to fix the problems found when checking how htab map
>> handles element reuse in bpf memory allocator. The immediate reuse of
>> freed elements may lead to two problems in htab map:
>>
>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>      htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>      flag which acquires bpf-spin-lock during value copying. The
>>      corruption of bpf-spin-lock may result in hard lock-up.
>> (2) lookup procedure may get incorrect map value if the found element is
>>      freed and then reused.
>>
>> Because the type of htab map elements are the same, so problem #1 can be
>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>> these special fields in map element only when the map element is newly
>> allocated. If it is just a reused element, there will be no
>> reinitialization.
> 
> Instead of adding the overhead of ctor callback let's just
> add __GFP_ZERO to flags in __alloc().
> That will address the issue 1 and will make bpf_mem_alloc behave just
> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> will behave the same way.

Patch 
https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/ 
tried to address a similar issue for lru hash table.
Maybe we need to do similar things after bpf_mem_cache_alloc() for
hash table?


> 
>> Problem #2 exists for both non-preallocated and preallocated htab map.
>> By adding seq in htab element, doing reuse check and retrying the
>> lookup procedure may be a feasible solution, but it will make the
>> lookup API being hard to use, because the user needs to check whether
>> the found element is reused or not and repeat the lookup procedure if it
>> is reused. A simpler solution would be just disabling freed elements
>> reuse and freeing these elements after lookup procedure ends.
> 
> You've proposed this 'solution' twice already in qptrie thread and both
> times the answer was 'no, we cannot do this' with reasons explained.
> The 3rd time the answer is still the same.
> This 'issue 2' existed in hashmap since very beginning for many years.
> It's a known quirk. There is nothing to fix really.
> 
> The graph apis (aka new gen data structs) with link list and rbtree are
> in active development. Soon bpf progs will be able to implement their own
> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
> be making the trade off between performance and lookup/delete race.
> So please respin with just __GFP_ZERO and update the patch 6
> to check for lockup only.
