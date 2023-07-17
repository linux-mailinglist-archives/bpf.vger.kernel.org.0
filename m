Return-Path: <bpf+bounces-5142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC9756F26
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847AE281319
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87E1095F;
	Mon, 17 Jul 2023 21:52:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B0107B0
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 21:52:57 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74FE4C
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 14:52:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HGGUXb007515;
	Mon, 17 Jul 2023 14:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NrTu64j5mK7/wYvJtS9b/fxcKxgqSuoLAhKClaTSamk=;
 b=WI6HzZEQy1buWMUDDgmcGRpdK8a3phjdc8+/02YN9fKOsknXsbQhvJbWokF8fg5KkxDF
 eoybKNG6k4Soq7Q+hqyi22irAQIDot1uNPGIvxswu7QHpwi1PhIhanmG99Ow2M7sJnnx
 u+ayrCioru2XSrRRFA3lnj30JWYvFcnWRCZZeaI8r87nCDpY1gib5P+RFMZWedv8A4Fb
 pG5pPISDzTvWgwPOegfrz7pNG4PeZnP+MHCmvroQ14F9UxjQB00qml90DlsVIvjaVKZA
 sA8+Jjc1PqlaOEAaDjFQ3V9o3OsrFRibC3w8LwKAfFcjZpuBbcFdkgRBmnbZPET3Ju2k Eg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rus6y7hkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jul 2023 14:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpICgUYNYn/ux52Am3ZbkyIIqj+qf/tPV5oV7mU1SRJFoWLdq4ACL71LeHgM3kIztUfeIt+ewjziTKihEsWX20V9+yil6gzGVYdfH/eO9Wi21CatoKj0Sp+xqKszjwHtvaKAPu/oPnCAvriBOlXqZ/9h6VzLcJ1Z7yLwuOnyAvjoxWgoD3rloQM8DPFCE6Tx7c9STZl3qHiXUBgDp7CR6Zejfw/+017X5tvAG+HZ7DoNi/+APYQ0Fh3PpJLTh8hOJS04AU92ZrUEMC02JFf/RvRHiSlgq1Nb65HI+PsoOU/vUl8GhQBTywHJC9AmkEnYWr3RXV/Or7XiJi0In8nf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDQw6ycj3XxgPnA3CwiYzwzsUU6/hQUiS7/dX5q+IaQ=;
 b=gPPQfxYYTC4AznhQ2z5BSDeQRo9QGZ4/STc/NHrBOTy//lFZxC+9t7ZUotTjuTxY0ixwyr1lq66pk3c8jab4Zo/3dP3ovof6qPqkpIZ3oySbPX1V/q9cvUf01QstE7g/IccEqu3Id8CyJDp00BseqcGHUz46gP4+m0NlyrjFSlW3nXAYvqNgH+3LsMryaxdCWxVg3/OdeYwCnLzbm4++sNRHcTTe7X8iZnSmaP6rGelMj5E31YGZA+pYt6NSlvBk3hTKfuSCiXN+xSnW9c35RTMxc58VVVcOOj8HpDSB34Akc54NoWoj7z5/JPPpTcf9syt4JZubN8sD7zFpRDR48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6122.namprd15.prod.outlook.com (2603:10b6:208:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 21:52:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 21:52:35 +0000
Message-ID: <aa910249-cc7f-680f-144a-b6f6962b277d@meta.com>
Date: Mon, 17 Jul 2023 14:52:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 39793cf7-c0b2-4ba0-357c-08db871021a9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X3bM3FxN6jDR1OWc+A9xBrb6tjSwHbUueRg/wDekxbpmbnC0CPgZZQD/vsj12DHadeMaR3Hs5yP5qsLKIrNOnaoN6my56FV4yBIacLV7QRPWed1WgDVAIhVcON+IOaVcL5TrtKOlhGOO58tiNNIAMk9Wjmnu0pxmcaV3XGS7N+xB+FTFi+x4jcOiryK+qfcADtKDBPKvmQHnafmW/nuI8Bm19CJ1D681vO+LRZf13XYD0qtWf+Y8un+ofoJYa/N39zmJ2YLw9tbw03w1pvprOsI58fcxJnGlwrXxm7gXIK+Z+wWCK5HuDCW7wl0Ftz7jFrh9GA2F6wCQOzodZQxIaHjdWDWk7ahhaOHUA73YypRgrnnHHVX8vhbdJbvAVDUjMt/lj174hojQOxsc9Y6F9SiU8mWChdOhIA6S4HwoKsRXL1LqQjsQ9NXjNOc4xYMv//sq7WGyEoRM9jxDjBQjHmkq/Cb1Bva9eSe8QvhspUM4U/eox/Kq3FDZJ4+UhHOt6Fk2puw1JiJfXTfzLrMhNsk+wO06YA+euFGuld9kaLVU51hb8Nw18dTWdG0xCBx7ViNd6HkHwfYM4qkELbRqGlFLXSYhA5TKB+dWSeJDHrOQvfkO0sObjTHxKEw2yZNcc1iNAlW7ySHQs5sizLNkxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(66556008)(31686004)(316002)(4326008)(66476007)(41300700001)(66946007)(2906002)(54906003)(31696002)(110136005)(8676002)(86362001)(478600001)(8936002)(38100700002)(186003)(6506007)(53546011)(5660300002)(36756003)(6512007)(6666004)(966005)(6486002)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rm80VFhVSGNFRS9iZTJwMXdvT053UFJxQzhHbkdKSE5xUERFZkJwdkY4MDJY?=
 =?utf-8?B?akhQcWFlWDhxbzVRUWpmZFFxYWtpZU1WM3JQOWpsYk8xc1RUUVNYZ0dSWnFS?=
 =?utf-8?B?NDNCQ2lNV1R1eGRXVk5CVWI1L0UrT20wUDlLVktTY0RTMFFPZ0EyQTMrVGJa?=
 =?utf-8?B?YXJvRUVjMVhNTFNPTFBKbCtjOU9VaFlmOXR6Z3AyanN2eExxL3lkSFFYZTBy?=
 =?utf-8?B?bWREb3VmL1dkR1ozT1dqV1lOQkFiTDVSbXpmM2Vxa3pybFNqa1pvVzV3WFhp?=
 =?utf-8?B?MHpvckp0cVRRcWgxM2NkTGNJWDdTT3Z3dFRLZ0hxWDVVd3NoQTNpeDlXT3hL?=
 =?utf-8?B?L1NLWXZmQ1p1NHZ6TGZSbFd1V0JtTkFOQjl0QlBjT2lRanhScnBJcGhyTjdx?=
 =?utf-8?B?RnQwU3hhaEx0akMxTkhaQVRCQmoxcEFOVlZUZm5HR0E4V1Nzb2ZxVmhObTdJ?=
 =?utf-8?B?SmlZL0tYeTRFNkludlRVMDZvWlNDaHNMWS9rZnYyS0NJYWFIMnpCYjRDUG5Y?=
 =?utf-8?B?OWxzVWp4K0s3UkR5L21lSlRwbkZiTGI5NkZnYnpXc0hwSDNCTnN2OUdhTEln?=
 =?utf-8?B?YUZEOVFQNThwa1dMeGJnRUhHNTFnS1ZYYVArUzVkKzlKcnBueEx1V0tibEJO?=
 =?utf-8?B?VmdXSngrZE9JQis2M1FMUjMrMXJEWG9oZ25oZHlTMmNJMTlSTk1kWC9BcVNB?=
 =?utf-8?B?Y05Vb2haaGZUN1BCZk9sVHJLeHNHZUZkSWgya2pVZ24xK2w0QVRIeHVWYUV3?=
 =?utf-8?B?ajlJOUxXWGJrUk5kZUdRMjY2VFltQTl6cE1RRkszVkphUUxmblVaM0UvWmM3?=
 =?utf-8?B?VTFneWtvUHFrdmFzQWRlZzJZYitvTVpweUtkTHJOam8vZllycjYzM3VpZGhK?=
 =?utf-8?B?WldlVmV4LzZyTk8zZEo0RlhOZWNMeFp6ejBaa01WVlZwdW92WHFjWnl6R1Vp?=
 =?utf-8?B?bmV4TysxNkcwc0FMazZaYldzbHkzTjRhbE85RE9ZNFhHV1hXcHR4ZEs5YXg4?=
 =?utf-8?B?QXN0MGEvMjJJWVpiYVF0QTQrc25lTjdXVVQwdWNTUWRaRGt0cTBtSmVCankr?=
 =?utf-8?B?RTNtU0MwQTNnS3p2TVpKNXNGSTYrR2hzOW54K3ZCVkE3Nm5DZzJMczR3ZjQ4?=
 =?utf-8?B?Z2gwWWN2Uzh6Z2NKYVoyVWx2b0VMbDhKWXNMb0xTRitNdGNnVHhqY3dMdVRL?=
 =?utf-8?B?QnZEM1lrUkgvQUVRdVNRZ09qZldUaVlVUWVKTmo3aXRWcVQ2QWlma0VMRFpP?=
 =?utf-8?B?eG9YcmlpTUVXMGcyYUJWTUljTVNQWlNxTnhpWUVJNEg5SlhOUDU0QkRwT2py?=
 =?utf-8?B?blMzcWhkRGl5ZUtrVkRLMDZNMWhzYkMxRjBCRzJ2N1l0NXBaWDVlemovRzdx?=
 =?utf-8?B?N0MybHF0UFJtWC93UDdLVnhtdDM2ZjEzMy9GZ28xandNWi9UN2hNdWRGWWZk?=
 =?utf-8?B?R09UMGxyMEYvdGtQMm50S2JMQk56alVRdEoydjh6VWVVSkpMbFZGUzkrSmd0?=
 =?utf-8?B?bm9OQUFkcDZaL3dsUTlHejQ4RnVFelRSYmlha1RsdE1TN0tsNjhrenBlNFVq?=
 =?utf-8?B?VFdhODlXOWQ0VldGZzBuOWJ1eldZNzI4QzVPbnIyL1I2a2tMYXhLZ3lzR0Fj?=
 =?utf-8?B?THFKZHlMZnFyT09NdlFIdVlhMjBvaHFNczB4dmlieGR6N2VENXU3UHNDaUtE?=
 =?utf-8?B?L2J6UVpIRjh0M2xaQVZEOHNEREtWa09FRUpzNG5jeVRLT2IxSTdqd1dSdHJO?=
 =?utf-8?B?WEhGa0JRTC9vSU9HbEpiUFM3VWJtVHlKQnJGTjZzdXgwa0w0V3B1T1VxRGF5?=
 =?utf-8?B?VllLY2w5RHI2ZnZ4bXlyR1NUOFE3bFo4QmxqMUhHTEtNeHQwOXpkMjVXYTEy?=
 =?utf-8?B?VUE3UW1NZUlaOWViTVNKN0VpUmd1Q3l1UEFBd0dOOVNVR1RGdFJvdXl4Nm5Z?=
 =?utf-8?B?VGR5SnN0RCtDeDBDMHQ1U0lvbmpLYmJuSmZEV05YUW1oald6cmpPTGpqR1Nh?=
 =?utf-8?B?QTVHalJNdndrZUcvWjQ5aUtvZkZoYWJLdVAwdXNROS9MMlJFeDZqb0E4YTdX?=
 =?utf-8?B?cDJMS1EwaFo4Smw0YU9lMG5uMnhpTkpINVYxRFBlYnpvNzRqTDh4MktiNjVv?=
 =?utf-8?Q?81yeTl9DZ7oN64iYtMXJbbJFZ?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39793cf7-c0b2-4ba0-357c-08db871021a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 21:52:35.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94xZdXCetU/SfV1Px0hiBdmK/gqrteohzvB9HJWLp7Y9EikBXWb8oVOkzRNcy05v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6122
X-Proofpoint-GUID: g4ss2or7_8kptnpDERLlKzzAtzrwRR6j
X-Proofpoint-ORIG-GUID: g4ss2or7_8kptnpDERLlKzzAtzrwRR6j
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/16/23 6:39 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>>> In previous discussion ([1]), it is agreed that we should introduce
>>> cpu version 4 (llvm flag -mcpu=v4) which contains some instructions
>>> which can simplify code, make code easier to understand, fix the
>>> existing problem, or simply for feature completeness. More specifically,
>>> the following new insns are proposed:
>>>    . sign extended load
>>>    . sign extended mov
>>>    . bswap
>>>    . signed div/mod
>>>    . ja with 32-bit offset
>>>
>>> This patch set added kernel support for insns proposed in [1] except
>>> BPF_ST which already has full kernel support. Beside the above proposed
>>> insns, LLVM will generate BPF_ST insn as well under -mcpu=v4 ([2]).
>>>
>>> The patchset implements interpreter and jit support for these new
>>> insns as well as necessary verifier support.
> 
> Hi Yonghong,
> 
> Sorry for delayed response, I'm still in the middle of the series.
> I've tested this patch-set using updated LLVM version and have
> a few notes:
> - kernel/bpf/disasm.c needs an update to handle new instructions;

Thanks for pointing this out. My bad. I have disasm.c patch in
RFCv1, but somehow during cherry-pick process, I missed it in v2.
Will add it back to next revision.

> - test_verifier test 'invalid 64-bit BPF_END' from basic_instr.c
>   is failing because '.code = BPF_ALU64 | BPF_END | BPF_TO_LE'
>   is now valid;

I didn't run 'test_verifier'. Thanks for pointing it out.
Will run it and fix the problem in the next revision.

> - I've looked through the usage of BPF_LDX and found that there
>   is a function seccomp.c:seccomp_check_filter(), that directly
>   checks possible CLASS / CODE combinations. Should this function
>   be updated to handle new instructions?
> 
> Thanks,
> Eduard
> 
>>>
>>> To test this patch set, you need to have latest llvm from 'main' branch
>>> of llvm-project repo and apply [2] on top of it.
>>>
>>>    [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com/
>>>    [2] https://reviews.llvm.org/D144829
>>>
>>> Changelogs:
>>>    RFCv1 -> v2:
>>>     . add more verifier supports for signed extend load and mov insns.
>>>     . rename some insn names to be more consistent with intel practice.
>>>     . add cpuv4 test runner for test progs.
>>>     . add more unit and C tests.
>>>     . add documentation.
>>>
>>> Yonghong Song (15):
>>>    bpf: Support new sign-extension load insns
>>>    bpf: Fix sign-extension ctx member accesses
>>>    bpf: Support new sign-extension mov insns
>>>    bpf: Support new unconditional bswap instruction
>>>    bpf: Support new signed div/mod instructions.
>>>    bpf: Fix jit blinding with new sdiv/smov insns
>>>    bpf: Support new 32bit offset jmp instruction
>>>    selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing
>>>    selftests/bpf: Add unit tests for new sign-extension load insns
>>>    selftests/bpf: Add unit tests for new sign-extension mov insns
>>>    selftests/bpf: Add unit tests for new bswap insns
>>>    selftests/bpf: Add unit tests for new sdiv/smod insns
>>>    selftests/bpf: Add unit tests for new gotol insn
>>>    selftests/bpf: Test ldsx with more complex cases
>>>    docs/bpf: Add documentation for new instructions
>>>
>>>   Documentation/bpf/bpf_design_QA.rst           |   5 -
>>>   .../bpf/standardization/instruction-set.rst   | 100 ++-
>>>   arch/x86/net/bpf_jit_comp.c                   | 131 ++-
>>>   include/linux/filter.h                        |  14 +-
>>>   include/uapi/linux/bpf.h                      |   1 +
>>>   kernel/bpf/cgroup.c                           |  14 +-
>>>   kernel/bpf/core.c                             | 174 +++-
>>>   kernel/bpf/verifier.c                         | 315 ++++++--
>>>   tools/include/uapi/linux/bpf.h                |   1 +
>>>   tools/testing/selftests/bpf/.gitignore        |   2 +
>>>   tools/testing/selftests/bpf/Makefile          |  18 +-
>>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
>>>   .../selftests/bpf/prog_tests/test_ldsx_insn.c |  88 ++
>>>   .../selftests/bpf/prog_tests/verifier.c       |  10 +
>>>   .../selftests/bpf/progs/test_ldsx_insn.c      |  75 ++
>>>   .../selftests/bpf/progs/verifier_bswap.c      |  45 ++
>>>   .../selftests/bpf/progs/verifier_gotol.c      |  30 +
>>>   .../selftests/bpf/progs/verifier_ldsx.c       | 115 +++
>>>   .../selftests/bpf/progs/verifier_movsx.c      | 177 ++++
>>>   .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
>>>   20 files changed, 1929 insertions(+), 158 deletions(-)
>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c
>>>
> 

