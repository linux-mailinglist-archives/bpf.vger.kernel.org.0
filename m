Return-Path: <bpf+bounces-36149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3F94316D
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A47281F70
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1A1B3746;
	Wed, 31 Jul 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rzMEHapO"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010010.outbound.protection.outlook.com [52.103.33.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129A1B3730;
	Wed, 31 Jul 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434059; cv=fail; b=gMa4/w1R+714xMGvtxcU6ykDfJ2hE7FJjQAsqbcyzBhJ29hORR6I6wHnVskWKxyPgJxJcWKkb/WP1v+NSc65rqTPQEtsoUSAeUPjkcqXFRgp8glWt0mFs2nqJGad4+yIThnfLXlRDnN9A2gLdLQTaLmi6VhOV5BZa/qHfpJwXuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434059; c=relaxed/simple;
	bh=IuWzZ/q8IF9CW7bJLrtEBIbOhBMXMTa6quvqyBmyOCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeQAw8pvL+zu6EOWOXpbze7cF+53SIdWHYoMEOtHsho6lE1SjZaDFOVsUGzrQZbKYGsAQ4WpvGbKrJWXzLIYvwYkQNR1hMkYFyAMcOmokqKXTW41oZ40M7XjEbll2JIWLussq1cbideYoVjucP9bGTiw0yq02qJT5QZZ8kLr+kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rzMEHapO; arc=fail smtp.client-ip=52.103.33.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoTZ93AFUl2Xqq6tkjy5XlPCwIwWI1SDrOzjzSY/6JicKXDxw5Rq3Cad4872ZssyNGtpgos5zK256B1ltNaSjmPJvcQnGm4ce8IB88xlu9RJlKMxO5cq4Pr68pfZXO+kjxUBHfrtW/JmDENpzICEoT8mU7EGsYLd2MPqEaCD5oW8uxj/Dl6xImelTCBcnC8cvMzObWbXv+mdByLshpr5kuUE0HQHfvnNUZDwQUHgGaw2gcQXYfr8EYuII3+KZq28JMQVLmGAAwb/2zEGi+pULf9kfBMgLse2MI2ASqlPW7yEyPWffUkLkLXXeyz+oLLiKHu8Dmrj7RwP+i9xZwIGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzUSsxjOqt8RRRa4M+ok76o0CdXyEGr+n3pWt5ni+Vg=;
 b=l5caORNUzttY5QQiFf55dgHym/2nxYFPnPWPCM6VI7SXqHxyKf2b98K4RlVkkMFE/2g6ODOyAtWpBKuP7xLAZ7EK24dN/p05lR1rAUcU5XNqS0H8R7KFCdI7QqWkMAHgG7P+XjkzGnmZ9QwEb6GcTbVYXjBLjP9J7KedsfLUOSsmgRFxRQIooFWLTNkGPhm+NGE89aV3tpX+gEnNDlUGr8ebpyiU9nio1tilrPkTg1qNL/0qNSWCBdVPliKvYIzs3TZr/HK25gmBKMTL8awcLq8UjnINjbtHyJeTJLPvQafeJkWe0nE2XM5FtdBRQGYyObhqtp1Vj2yMl0TAwDmydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzUSsxjOqt8RRRa4M+ok76o0CdXyEGr+n3pWt5ni+Vg=;
 b=rzMEHapOs5+gNBna76ULE8iuA3Bu2VFY4qjbHr67I0srfH2Jm58lc4eN0K4TXjXAjz9M+97LXYzofPzVnu9OKsLOcirvCgVWsYrmc3lWCr2xJEbk80qpJDbEo6CHam08oENj1+YebOJMrYpuXfA/uwi+D4VkbfbMK9sDqyh2X6SGbetVW6768jejHm51b+MHMTxuws6et38nGauUvbZykObxdBz+FfM679F5LPS70Yv2tk2BIh1xJIZGQq4Yqh+0NPdE3vtNz66Sz5N3+41GN0pwBEuCY0uF0cNU4Uq+g+mF6pzRhcH51Xx69SfUWd7sLYLdNOuJzyORVPwYj+eh5A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PR3PR03MB6394.eurprd03.prod.outlook.com (2603:10a6:102:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 13:54:14 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:54:14 +0000
Message-ID:
 <AM6PR03MB58482854EA66B98107FBEA2B99B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 31 Jul 2024 14:53:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF
 (CRIB)
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com,
 snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
 <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [82Mp57BNq496AYaaXWFsoFFJKQi6wtGl]
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <bd7b6093-4e65-40ba-9b0f-69b6c3f2f300@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PR3PR03MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f07b0ba-87d9-483e-d399-08dcb168435d
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBJhxXVKwyRJg7Ed6G3Q6hbxrJrcUx5k98k2p3EmHnz1xI7nIddlP3ZwRv9h8ttW3B5GGuhsid7UAB62hsjHwbNm0weOa72J8WMUPCZZs3qLSAJqyLyu4l/vFaa7Re06rINjFF51dj7oz8aXAUlmSUZr4tX7oIiyKIFN8ufKXEMd8SL8ttAtV99urdZBdc2Hi93gNalOMWKq3B5ZHFg/7FBnJdziUePG9YRdCrtMZt54IIY2uMSYqlXUqMH3t62KOpEHu1w0414ey2hbm6+ycuWjmQyS/B6i53mtpyWIwZosD8Mmii70gzJHTcmZC8G5gbthrCsEBLG9LNKbf7KPt/q7iEZykKryV+px8MqAWK26Y20z0l5nVoA3tn+X6cYKaYRMmWa4Hy3z3wmqgBr/fkevoHNjVB20D222rzMPzutnerrekUs8tqAYMNvftFr5p3lyiA69cL4b40TKPklQMNucWB33shhaTiBkmz20ymV2s1SfER2vSOVd2D918iZkcaJMCx7yPUpopjY1rObraQK0F3TQ3vjc3USu9vsM7x25lS5ixCaC4T8bb8o6qaK3L3iUWSY0v9OvhMecxEMlZA7cnjR+OViP7xwqQGSl6plkt5r3+DElMGSaQ+uUMYoKx2GwZhYdvTa1vCdPo2scaKxs484dAMX+TNOEmjeE/7shTS8au2Mupryu021NJCMciS/f7oQStoazKbB+Rs19RUV5t6OU8AR0TIKxdg8mN/cvtfZB+H6J5LSG4xMwa3M8BrumC5I/mz5ad4FJiEUNaXs64wnYqm3es6vA0YcEaMLPYhN5v8KOW/VFpm3F4QAm3xxs/0ykODl4oQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|461199028|1602099012|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	425LNk84799Iz0oPNOpmJtNYte6F/EIiUzzIJoR5ftRwN+l2DiqWg4FS/DLLGh4vXxhZ0VqXm60/nLgEcuMILtG/MzDIwidA+ZyrGLlAgK2/tw7jy4lNQUZaXGOvUUZrH70l0+MK8tO01juTdu8CiycGMOP3hCjJixzJHjGyWZHWiC5BAZwOcKNUoFnnG5hyowsbBEgVlqyMlsooONgUxmxf2aQNycioJyIwkEnnqvwBfX6JMYhGooyuKXb2Yh1CWjoaXCgSopivQ21tGlExR0ouYY6KkA7acJ7lY63pBznwh72W+6kFJ05rpRGNgMVeneUWNl9Z/lMD7aSuMLmNv4/T44r953EOlbwavtUB3qZf5nJEvZW8m2GqPCB8b23L0ysw+w/4P1VGddLf3cYr5DiE+A/pHWieP7FTrBqYGyl/EMFpoq0b6dcC2r1f7yzDtO0NuTHl7VfRZi9PwzITYlKKUVWXgg87P+6ekCyIJ97niay0ZgcSBm0pl1RBMu0v00UmD89yCPlCOB5mc0A3Q4odFTrTK+H763CdHBjf6Nb0J+nuO9jU0QN/iWtVgYyC35g9tmnLP3GdVnJFXrznKYT+DhjE8POf1icYbJqzRZY+wGbRa/okRKLTzFAotvc8N94Genj52Rz1Cuzu+IA7/4AhdWDKc9Ft0WG3dMUhgzdh4uWNE3p2hXOa9ygQ5BUzIzxKReWwyCflqIpXKJ9DzkHy9CCbpu94AqQ1zFqa304tTTOHrSZtDBA6y3G1hUwbUpiCCt+P6Ct8FLRNw+D5Ot1f2vCfpNsP2MVCnGPw4T4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlFS2hBTFFPUjJhcmRZcnBMOXpwc0o1MmZHcm1sK001ODJtcWtHT29aUUF2?=
 =?utf-8?B?R1lUTUd4S0NLQThteTJZUjRsQVVmZFdTVjZ1anE2RXVid2FST3o2SisxMk54?=
 =?utf-8?B?MER0VXYwTDBNWGsyZTl4NUFRZ0VTMTNBV2dWZTVFMTRxWFdsYjBuaEFFRDdM?=
 =?utf-8?B?NjhPU1ByVEYzRURvTjd0aDQ0Zk5EZVZJQmY1cFM2VnkwNkJKaEw4TThDQThK?=
 =?utf-8?B?aXBrUjNSVEdzdEl5S2d5QnBOTWYxdklEeUtVdjBlc1JMTWt1RnlMc2xBQ3Nt?=
 =?utf-8?B?MWppdVZKdVhRS3NCWW41Wnk0UXRwNDU0WU5mL2UxelNIb244SE5pa1VOQXgz?=
 =?utf-8?B?RmlHcW91UDlBQ3M4SlU3ek1zWUJMSlRLR1c5OE40R3pRQW50OUFxZTZGL2tX?=
 =?utf-8?B?czd6QkxqMUZ4Ty9NSCtJdGxaSS90QU1rdVhhSjB4VHRYRGZpcGsxK0p2U1BC?=
 =?utf-8?B?MzBwL250aWcrNmZVQTc4eDhXV2xYVmdwblJHK3dlWjk3L0s2SFJhSGY5RGND?=
 =?utf-8?B?NkQwRHNUMFVpTWV4dGZ6c1BLUXBmR3FnQTAwMzM5YzlDZjRyVy9aVXRyZ1FP?=
 =?utf-8?B?SW94blJvdWxhdzA4TlFuaXJJM3BEeDZOY0JvNU15QUwxYTBzUkhYbHBUSlRB?=
 =?utf-8?B?N2x6dnluRXRibzVmT1FaVmVSKzBKL3FzQTNITEZJUERQLzI2dVk3Y2tqemZa?=
 =?utf-8?B?UllBeDVKZzRjZlpNRTRvYnlOZWJINkUxMEw2WENuY1VhdWV2cElncDJqR1Nt?=
 =?utf-8?B?OENzRThFcUhOaTdSbEI4NjRGdmhiSE8wQnRzRUZSZU1KcFZCNGJqMVlBb0I4?=
 =?utf-8?B?WnVjV1BoMHRydXNpTFRDczhtMmRZOXE3R2RtRW0zNkowSFNibWJWbEs5YXV0?=
 =?utf-8?B?S2R6M0w4N3pRZURwSERtMGFURitnRlpNZVRiVjViWHJKQk5jd2cyeW1rc2k3?=
 =?utf-8?B?OFBEU3dZajMrZWFKaGNtbmxnUjFkWXFBeXZXc1JMYjFPTDhpeGdRclBnMUg1?=
 =?utf-8?B?cFlHQ0lBMG5MVkphTGdMRVFOS0hSVUd4QTJ6NmpPRzFVNG5Kb2pZeXJubUpU?=
 =?utf-8?B?KzEyRjdEazBydXlLMGRZN1paTHduUUk3RmlKSWgvNDBROEt3VVZwU3ZTYlNn?=
 =?utf-8?B?NGV0MmdKMDVXUE5ZaE1BRm9sUDVBMjZuQzFOY2gvYWlXbDlIVVBOWDFCcGUr?=
 =?utf-8?B?allocllQNXFvdGlKKzdxZ3B3dC84dTRWek0xTlNROElIZk8yaWIwdDhWMXBx?=
 =?utf-8?B?RVJucWs3NHBseDV2RUJoUllvMUhGT1FTRFR3T1NYOVRYVDRtdEZyeXRjU1Qy?=
 =?utf-8?B?QjlnODkzUlkyUXFwSHhZU0VQRE9GTUo2V0RzTEQ3V3FkWGt5a3lvclFkNGcz?=
 =?utf-8?B?UnpXUUtlanV3SStnTjh0MFJHaXZhcTc5UXJzWWd4Nk85SXZMcFBmQmljU3F0?=
 =?utf-8?B?Wk5haUFsSDRNcllEbEJIUTlHMVpJOUFOUmVnSytraWxNRTF3dktSYTllNlE1?=
 =?utf-8?B?S0txN3E0Si95SmlENWVDR1R2a0FLaWNZdnZpQnNEcCt3WWNuZ0lZMllNeUhk?=
 =?utf-8?B?ZHpMK1pGT0pzYjg0cDZlczZuS01KSHdvTk5OUG9ibStWamdQS295ZTI3bGRm?=
 =?utf-8?B?RTFjTGZMbUpGQmVMSU9nZ1ZBS0tTeWYrbks0M3NRUUhFZmJBSGY5d0tWRGdB?=
 =?utf-8?Q?vGTnrGoQ0+bF3YqUwuR3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f07b0ba-87d9-483e-d399-08dcb168435d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:54:14.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6394

On 7/23/24 01:49, Kumar Kartikeya Dwivedi wrote:
> On Tue, 23 Jul 2024 at 01:47, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Jul 11, 2024 at 12:10:17PM +0100, Juntong Deng wrote:
>>>
>>> In restore_udp_socket I had to add a struct bpf_crib_skb_info for
>>> restoring packets, this is because there is currently no BPF_CORE_WRITE.
>>>
>>> I am not sure what the current attitude of the kernel community
>>> towards BPF_CORE_WRITE is, personally I think it is well worth adding,
>>> as we need a portable way to change the value in the kernel.
>>>
>>> This not only allows more complexity in the CRIB restoring part to
>>> be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
>>> ebpf to unlock more possible application scenarios.
>>
>> There are lots of interesting ideas in this patch set, but it seems they are
>> doing the 'C-checkpoint' part of CRIx and something like BPF_CORE_WRITE
>> is necessary for 'R-restore'.
>> I'm afraid BPF_CORE_WRITE cannot be introduced without breaking all safety nets.
>> It will make bpf just as unsafe as any kernel module if bpf progs can start
>> writing into arbitrary kernel data structures. So it's a show stopper.
>> If you think there is a value in adding all these iterators for 'checkpoint'
>> part alone we can discuss and generalize individual patches.
> 
> I think it would be better to focus on the particular problem Juntong
> wants to solve, and go from there.
> That might help in cutting down the size of the patch set.
> It seems the main problem was restoring UDP sockets, but it got lost
> among all the other stuff.
> It's better to begin the discussion from there, which can still be
> rooted in what you believe CRIB in general is useful for.
> 
> Also, information is missing on what the previous attempts at solving
> this UDP problem were, and why they were insufficient such that BPF
> was necessary.
> What motivates the examples included as part of this set?
> I think this particular GSoC project is not new, so what were the
> limitations in previous attempts at restoring UDP sockets?

Yes, this idea originated from the GSoC task of dumping CORK-ed
UDP socket.

While I was solving this task I realized that ebpf has a much greater
potential to completely change the way we checkpoint/restore processes,
and can achieve better performance and more extensibility,
and that is CRIB.

For now, restoring CORK-ed UDP sockets is just one of the problems that
CRIB can solve, and it is not the main problem (that is, CRIB is not
designed around solving UDP problem).

(The difficulty with restoring CORK-ed UDP is that we do not have a
simple and elegant way to read back UDP packets in the write queue
before, but this is a simple task in CRIB.)

This is why I did not mention the GSoC task and the previous attempts
to solve the UDP problem in the patch set, because it is not the
same problem, and the previous solution to the UDP problem has nothing
to do with ebpf (CRIB).

But if adding this information would be useful, I can add it in the next
version of the patch set.

> Adding kfuncs makes it easier to checkpoint and restore state, but it
> also carries a maintenance cost.
> 
> Using BPF to speed up task state dump is going to be beneficial, but
> is an orthogonal problem (and doesn't have to be CRIU specific, the
> primitives that CRIU requires can be generic and used by others as
> well).
> 
> You're also skirting all kinds of compatibility concerns if you encode
> state to restore into structs, not getting into specifics, but if this
> pattern is followed, what happens on a kernel where say a particular
> field isn't available? It is a possibility that kfuncs may change
> their behavior due to kernel changes (not CRIB changes particularly),
> so how does user space respond to that? Sometimes, patches are
> backported, how does feature detection work?
> 
> What happens when the struct used to restore is grown to accomodate
> more state to restore? Kfuncs will have to detect the size of the
> structure and work with multiple versions (like what nf_conntrack_bpf
> kfuncs try to do with opts__sz).
> 

You are right, so CRIB needs BPF_CORE_READ and BPF_CORE_WRITE because we
need a portable way to read/write kernel structure values, and achieving
portability only through kfuncs would be a complex tough problem.

But since BPF_CORE_WRITE cannot be introduced, we put the restoration
part on hold and focus on dumping part first, which we can achieve
portability with BPF_CORE_READ.

> I tried to add io_uring and epoll iterators for capturing state
> (https://lore.kernel.org/bpf/20211201042333.2035153-1-memxor@gmail.com)
> a couple of years back, although I didn't have time to pursue it
> further after GSoC. But I tried to minimize the restoration interfaces
> exposed precisely because the above is hard to ensure. The more kfuncs
> you expose to restore state, the deeper the hole becomes, since it's
> meant to be a relatively user-friendly interface for CRIU to use, and
> work across different kernel versions.
> 

This was a great attempt!

I have always believed that checkpoint/restore via ebpf has great
potential (that is why I created CRIB).

If CRIB is successfully merged to the mainline, maybe we can retry
dumping io_uring and epoll via ebpf.

> Can the values passed through the struct to restore state be trusted?
> I'm not very well versed with the net/, but I think
> bpf_restore_skb_rcv_queue isn't doing much sanitization and taking in
> whatever was passed by the program. It would be helpful to explain why
> that is or is not ok.
> 

Of course it cannot be trusted, but since this is an RFC patch set,
I did not put too much effort into security checking (sanitization),
I mainly wanted to show the idea (proof of concept) and get feedback.

I will put more effort into security in subsequent versions of
the patch set.

> It's easier to review if we just focus on a particular problem. I
> think let's start with the UDP case, and then look at everything else
> later.
> 

Yes, it is always good to start with a particular problem.

I will focus next on solving the socket dump problem via CRIB and try to
integrate it into the CRIU project (in a personal branch).

If the above patch set is not too large, maybe I can also try to solve
one or two problems via CRIB that cannot be well dumped via procfs
in CRIU (poor performance or incomplete information).

Anyway, I will keep the next version of the patch set small and easy
to review.

>>
>> High level feedback:
>>
>> - no need for BPF_PROG_TYPE_CRIB program type. Existing syscall type should fit.
>>
> 
> +1
> 
>> - proposed file/socket iterators are somewhat unnecessary in this open coded form.
>>    there is already file/socket iterator. From the selftests it looks like it
>>    can be used to do 'checkpoint' part already.
> 
> +1
> 
>>
>> - KF_ITER_GETTER is a good addition, but we should be able to do it without these flags.
>>    kfunc-s should be able to accept iterator as an argument. Some __suffix annotation
>>    may be necessary to help verifier if BTF type alone of the argument won't be enough.
>>
>> - KF_OBTAIN looks like a broken hammer to bypass safety. Like:
>>
>>    > Currently we cannot pass the pointer returned by the iterator next
>>    > method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
>>    > returned by the iterator next method is not "valid".
> 
> I've replied to this particular patch to explain what exact unsafety
> it might introduce.
> I also think the 2nd use case might be fixed by a recent patch.
> 
> [...]


