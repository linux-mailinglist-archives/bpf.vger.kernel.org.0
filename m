Return-Path: <bpf+bounces-912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4D708820
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A21C211BD
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D82F134AA;
	Thu, 18 May 2023 18:59:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06396FB8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 18:59:04 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F621729
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 11:58:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFs2w7014802;
	Thu, 18 May 2023 11:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5engHhErtisTGJL1K1QR4zdx58a6zfqwiInEauFSueg=;
 b=XDxObSw72gifR5W5J/x9mE44l56jSt4jZHmwmffmo28h5F1kAG6ugwn0UcwphjrNY8+A
 YXA/cQG0dk3YmushUdKsT/IEt8wI1hFNqrQtsBFrO8wTom8HjWLEWqYDOVjEmLfYr7sW
 sG7E2jBcUo2/m2z1PhaahKtLtUxlh7VHDRl4oR2HHnLs6jQTYImsqzajBBk3SCrHByG0
 gF0nVzzwuGwS0gQeg3VKOF68A2qbPDV005XxCLzhFzVb6aACkbtp2w8Op1qqmtywIVYM
 ZVwsLvg3iyPRJiKXZ4uG2V3mvcq+8yWIIV1YtMA+/x1PKlPEmFzhoUgGpBDSErcuOikr wg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qmufs21wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 11:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hieNDID+ww2rz2AaW0c9y9/CFB/jE03Us8lj5gwgM4SGPd1NzkVt3c9q/aT/En/W4g9PtuMijLZ9ELNm42DOg1bDEipOOazp03K5ccKOJSia8En+JiGBT+RVeltKlnMXDWWudAO9ziK7rtrXmAtS6Z7d5Q+BCxZCNkDczV9Qhr8iRmK34bT/ZlO4tVrQl2LYhiCzDws67USdJ1XHOJ8SvdaxQLVdLOkyu4jd2lcEFlZhWmfo0NAAS6hq3toU2ch1B9sMQrc88gfSmz0cGodglVCu5KJbmhKGORN5Ucj8uzLWKIF4r1sgnW0b84SIJKo/NJwGdlHjRpPUj0+vYJWyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5engHhErtisTGJL1K1QR4zdx58a6zfqwiInEauFSueg=;
 b=Dri/3n09ajN6/OMQ/9HkfCxfFw0gtIo5nCX6cMRoMa1B7q9jqhCcebdcWRb5hM7jBafd/dVfvdFxaWfgcPflgMr6hKRzMWNYmWCMDkISGJKpc/Y0GA2dBFXgEnxtTfx/TL/ZZtoSRH29hl2VY9K+1xcugwiuAbdSDcGKeymtMIb4yPpXvpL84TMLDxfYfPQd7rXLAUKotdNKsmTo/2rE5NFdvebNC/oAdE0xbC/lQmssAP91UqluDTICEa/BM6i04ezyhVgslTY0C0KNJRZPFZhmtTdbHrtNimkhAu0FaDbJEca4xeJULMzEjou4w8ww02s2f3PTmwPxM8WkqWRXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5686.namprd15.prod.outlook.com (2603:10b6:510:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 18:57:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 18:57:41 +0000
Message-ID: <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
Date: Thu, 18 May 2023 11:57:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v8 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock
 in iterator
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc: kafai@fb.com, sdf@google.com
References: <20230517175458.527970-1-aditi.ghag@isovalent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230517175458.527970-1-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: cb09e9ed-f5be-41d6-d57c-08db57d1c1ad
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GVXmiRlbkaLEEaH9UolQ2Rbej71KGiuctiA04eC4TJhhe5yeLLxfdr6ILa1bcfG97G/uugkbmk+dUq92KMUh8OAwHKsFFmPDgrJTFJJH0b89hfgVStD3zXKVqFtALuD61Hs27yCQtp8dKRVZEcyjkmScJH1i/2E4KXyZX/Qo+jeNC9gjJVN0W3/KjxMRzmmxaJkmIqQV2ZCSxW5YGRWIfJsPbWECIMtE3ni0YU3/Y7SEEvKBO22cuDoK2qH3IYYDpza2sN09NUgU//Gw4JEJtuGekmyN6fSpSxMypr1G7VmJzTd578LxKG29RQFfhekuR9Ontm+3RkZmrVAyGzCv6IA236eAkhoB197udYMnF0dxb9teVzmKOiIXSG2GJXrDp00K4inJivGbkS8Box5Qfz2pXD2eobEeeCH4/1zuRgxIg07lmPAB3hRiqSxK4ZOoX/SH4vh7sECoW9HKucExq1JC4dR2d6z9YMrOvlkpT00Ww+hTDRX/TjVv1CKSqvboTpkcwnrkTS99pbkTr2LtJNaW/31kNAVvmwJqzBFeNyAk2poNxftJrEcZcOtt5z2vWgrorKUoGOyZ0QX9WcqtN8BqT67avrkp9bS5PSToRjKvjwDWDS94jKvKvBZ2QvLJRXs8LwbzS5aewH2EkUKBPQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(83380400001)(186003)(2616005)(478600001)(6486002)(6512007)(6506007)(53546011)(8936002)(8676002)(5660300002)(36756003)(38100700002)(41300700001)(66556008)(66946007)(66476007)(2906002)(4326008)(316002)(31696002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2N3dDdKRHNEdGwwVnYrR2dZZ1hRTE9TNHlkZjByVlZzbXduVjRUUXF3U0tJ?=
 =?utf-8?B?ekIwTGUwUDRBbVF0VFdEdEtmNm85THJvVE1wRlQrZ2FhRVBMMGFXd3VnYWp1?=
 =?utf-8?B?MytYVHd4QkI0YUwwdnBObStIWGZCK2ViYUJDaHpoZnFFcjdhNWN1QlNHM2hF?=
 =?utf-8?B?dXFMbHQzMFU3cERVQkZ4R3IydWRKQWVwTzJKRVJ2S0VsTEZ1OVdyVUJUTFBT?=
 =?utf-8?B?Ny9OQjY1bDAxZXJZd1BJbytmZGpCUk1ZVWxNWmU4aWozaEdkWnhnRlJtOFpG?=
 =?utf-8?B?UlpQYWtWVnlZRlRBYjdOaEx6WVJ5d1dmOEJIVHh2MnpKYXM3cjBlZzEzN2tV?=
 =?utf-8?B?RFoxYkx1dUZwdzlMYW0xRE8rTU1QbUtMbE5Cd0g2ZkJ1UTlab0NTaWVLNU9u?=
 =?utf-8?B?eWZSNlZRQURkL2h3dmRKcU9lQ2h2anhVNVNZN1VmRGdTZ2N4aGZKa0Z0Z1VU?=
 =?utf-8?B?Y0xKZmVPeFdzTVVmR2p1dnh2R00xVW81dGNVVitJK0g2Mk15aU41SjRsZ1k5?=
 =?utf-8?B?bTNzRVk1ZmRZUnoyZ2JTZUcwNWZqSWExNDJtUVVDVzVyeW1uUElDUWQ3Qm1h?=
 =?utf-8?B?cFJpbWZlUE9YWVhqVGVCcFNzMitVZ1lsR3crbkxqbEhmWkw0V0N2UXhTdmxC?=
 =?utf-8?B?bXd6VU01d2x3ZmhYTWlXUy9IdEczbWZ5UXYwQ1FXYWErcElQNmtONnZoQjJv?=
 =?utf-8?B?V3lzT1JNdFJqOU0xOEozaVpHdUZhSmxlMC80NVZSMDV2Wi90RWdTSnp4U1Jy?=
 =?utf-8?B?MHBGQzFITFU1QmNyTFBhS05JakIxRHhKdmtRL3piR2lZTXNSMjN0ZFI1NXlL?=
 =?utf-8?B?OXNwbFZFWStzMUlkTE8vd3Z1VXNkYjFWUzVlK3NIeFcveFNQTjNXRG94cHZs?=
 =?utf-8?B?NTRFVFZGWTZWSjlKTXY4NlAvYlNIVS9nUU45eEFlaTBmbVRwai9JM25vS2ww?=
 =?utf-8?B?Y1hhSGZsVHYwcTVYSFYwblQ1ZWVFSEpBMUlqNmdJZm4xRzFHVDc5bnZkYUxk?=
 =?utf-8?B?ZmUrMW5jSU9KUTRCNnBiNVNJS2NEdWdRZzNva1pWOUJqVzF0d0p5SmxjOE9z?=
 =?utf-8?B?Sks5Z1lPYTJIMUV4b2pLMFRubit6VnpqdmtjUzQyK2YwT293TU9FNVlQNmVi?=
 =?utf-8?B?N0JmWG9YVzlEM1hVTlZydzZOR1dxNTc3UjhlT3JQVXlVckhaSzhiNkhObjJ5?=
 =?utf-8?B?LzVrWDdWMlFMVDF4MG5QRzFxTC9ZUWpFVWw1QUZTTVl6Y3plVmtMUEtUTElM?=
 =?utf-8?B?ZFk2c1V4WFpFZjFEeE1FMysrbm1tTWlraHB3Q1NtT05LY1FqUU5XeERvQTBt?=
 =?utf-8?B?TTJWN0lCamRqbWpIcDA1bzloOUsrWW1HYnZwa2dMYVlua3BDOXludlE2ally?=
 =?utf-8?B?aFBtOHpyaDBsTm1FNFNza1RKQlNsa0lISzdlR25lODlXRTNtemVqVjZqQTVU?=
 =?utf-8?B?Uk5VZ1ZkcU1rcWNDMVdwV2NCMzNnWlZhY2FRZ3ZEZmRuZlV6TjZScE80Sm8w?=
 =?utf-8?B?MDN0S3l4OHNXRHFScC90UlZvZ2d2MG1oQmNNMGxWMUZwRmVIZ3lKdHNnY3RS?=
 =?utf-8?B?eGQwU0ZCMHlhTU01ZCtCcnovQ1g0R1RDeGx5YU43Vk9HTGxxbVFYT1VDdmZa?=
 =?utf-8?B?RVBEcGd0WDJyNW5OTm81U29PUjNwSFdNY0dRalZ4UG80YThxcjJXb2YzS1Ew?=
 =?utf-8?B?Wm80TTc0N3FxWk1YdUZMTlQzMXY4QTJ6cTlHcmxSQjhCc1lvVXRkdUd2MWJj?=
 =?utf-8?B?ZjZ5RDdKM3Q5dWRXN0phNVlTN1RWamZ1eEthb1NSaTlOSzlvNC9yTjhZM2VR?=
 =?utf-8?B?ejNsTzA4VW5SSndILzFVOTEvRC9ZUmRJRXl6aUFvMHVVV3h2U3REZTJLdVFy?=
 =?utf-8?B?Y09kVFJveDdPRGFTZTBrMnA1MWxFVEtIYWREb0R2ck9wNVM1V0NvRW5vbzZ4?=
 =?utf-8?B?RmxZbW1ick5qU0xleHpTSHFyTUdpbWJaTzl6SnhPM1YreFVtcFJpR0xUOSty?=
 =?utf-8?B?QzF1S1VJZjBHbkNpZDhoZi9idnpJRTB3N29MbVBBVURJNit6bVpzejNPcEpK?=
 =?utf-8?B?eXRNczNSb2tDUldmcFo0a1JhN05OWE84WGkzM05BOXdrNk1XWnBYdDhmNHJB?=
 =?utf-8?B?c01FS01FVExHYzJKcVhmWmhlL1pwTHA2bjErY2xiRHk2WklPY2RSbGZTbmVL?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb09e9ed-f5be-41d6-d57c-08db57d1c1ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:57:41.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2dGo8jAImJFGrk8GjFsNT7X8k169zOdXkm3zXcW3ctK0o+P9riGfSJLjOylBu/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5686
X-Proofpoint-ORIG-GUID: mxhz6e1rLjgDWPF6QmtJiR0psLyrW-XT
X-Proofpoint-GUID: mxhz6e1rLjgDWPF6QmtJiR0psLyrW-XT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/17/23 10:54 AM, Aditi Ghag wrote:
> This is a preparatory commit to replace `lock_sock_fast` with
> `lock_sock`, and faciliate BPF programs executed from the iterator to be

facilitate

> able to destroy TCP listening sockets using the bpf_sock_destroy kfunc
> (implemened in follow-up commits).  Previously, BPF TCP iterator was

implemented

> acquiring the sock lock with BH disabled. This led to scenarios where
> the sockets hash table bucket lock can be acquired with BH enabled in
> some context versus disabled in other, and  caused a
> <softirq-safe> -> <softirq-unsafe> dependency with the sock lock.

For 'and caused a <softirq-safe> -> <softirq-unsafe> dependency with
the sock lock', maybe can be rephrased like below:

In such situation, kernel issued an warning since it thinks that
in the BH enabled path the same bucket lock *might* be acquired again
in the softirq context (BH disabled), which will lead to a potential
dead lock.

Note that in this particular triggering, the local_bh_disable()
happens in process context, so the warning is a false alarm.

> 
> Here is a snippet of annotated stack trace that motivated this change:
> 
> ```
> 
> Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&h->lhash2[i].lock);
>                                local_irq_disable();
>                                lock(slock-AF_INET6);
>                                lock(&h->lhash2[i].lock);

                                  local_bh_disable();
                                  lock(&h->lhash2[i].lock);

>   <Interrupt>
>     lock(slock-AF_INET6);
> *** DEADLOCK ***
Replace the above with below:

kernel imagined possible scenario:
     local_bh_disable();  /* Possible softirq */
     lock(&h->lhash2[i].lock);
*** Potential Deadlock ***

> 
> process context:
> 
> lock_acquire+0xcd/0x330
> _raw_spin_lock+0x33/0x40
> ------> Acquire (bucket) lhash2.lock with BH enabled
> __inet_hash+0x4b/0x210
> inet_csk_listen_start+0xe6/0x100
> inet_listen+0x95/0x1d0
> __sys_listen+0x69/0xb0
> __x64_sys_listen+0x14/0x20
> do_syscall_64+0x3c/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> 
> bpf_sock_destroy run from iterator in interrupt context:
> 
> lock_acquire+0xcd/0x330
> _raw_spin_lock+0x33/0x40
> ------> Acquire (bucket) lhash2.lock with BH disabled
> inet_unhash+0x9a/0x110
> tcp_set_state+0x6a/0x210
> tcp_abort+0x10d/0x200
> bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
> bpf_iter_run_prog+0x1ff/0x340
> ------> lock_sock_fast that acquires sock lock with BH disabled
> bpf_iter_tcp_seq_show+0xca/0x190
> bpf_seq_read+0x177/0x450
> 
> ```
> 
> Acked-by: Yonghong Song <yhs@meta.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/tcp_ipv4.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ea370afa70ed..f2d370a9450f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   	struct bpf_iter_meta meta;
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
> -	bool slow;
>   	uid_t uid;
>   	int ret;
>   
> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   		return 0;
>   
>   	if (sk_fullsock(sk))
> -		slow = lock_sock_fast(sk);
> +		lock_sock(sk);
>   
>   	if (unlikely(sk_unhashed(sk))) {
>   		ret = SEQ_SKIP;
> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>   
>   unlock:
>   	if (sk_fullsock(sk))
> -		unlock_sock_fast(sk, slow);
> +		release_sock(sk);
>   	return ret;
>   
>   }

