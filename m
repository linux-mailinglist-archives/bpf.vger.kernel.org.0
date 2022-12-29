Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE466589B0
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 07:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiL2GaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 01:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiL2GaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 01:30:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0554BCBC
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 22:30:02 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BT64xIA024436;
        Wed, 28 Dec 2022 22:29:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1GE4c6akrTO2oTxRA8S36dHyT39y+dG5s45Lgi/8W3s=;
 b=k+b3PJHUdcWuoywdW5xe7Bi9dr+gXwMWRvgNHXy8cuu8hbvJzW8fbuCtHzrszJfjAgBK
 9+TtdWEV56VAREpOS5tGntxpSaZsGs6w3aE3t7r93yTZCkEx780ui4xUL7kshiWElhsu
 ai2KlMSDYn+a18Z7hUy0ZGMFx6LzbRn4tN+pLXOh/J5pjVC1Y2ff2SzhIS/FFZmlOMKo
 p4UohAdTAvtx0Q5V2FU+fv5b6okS7HITnxnZLdMlWKLhe8lJ6RsL+AJvN9wWUxpVaAx+
 BaTeZcrK3i0bxkLGY+vl+7a0jTZdJorbgudAbZJooGrX7z+su3wBfD+WmDqfGl1SolZB VQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mr097jnxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 22:29:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWAV94dJEyA6/1Dy6mw8bN65I4bocWYPbPZ4qzi7Mnpp/bHBGHCmxDzUbt3FOEoysDuaIMExU7IfFYfE3t4mPU/ZuWCjMKbcyicTOldYEUj1cFI/IvPUQgNEwEHltggeqfgp4Syqv95psGyfcfaztxlB6yFZBcZwhRmUYwCu7TXqbrNO/Ui+5rNCwUQAJXDl8Zn1jW0jCpUBx3fZovL1U24NciaURfE8JTFRtuDqjmjsBIRFbCL6JALCkrAPMAUfShooXySe0m+x6PVV8VKp8WAcu8hUNw9OBdSc4Xh1liXfej52ugguCJkUCNrdHTlFBgDj7JJddmrY9KnmCyPDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GE4c6akrTO2oTxRA8S36dHyT39y+dG5s45Lgi/8W3s=;
 b=aKGeYQ8sdxBvMO8kUX/aRRAZDGI2JbrewODNXFmni0JqdObaFSQiMy7hLaPwaBu+gzjC4Gq+xZVdmXh4qCbK9fsEG7FG3duduPgLJ5tMmnUNkcx+yn+sZIFV+HM9Xq9b/A0ONJll2Q1Mjp7AsC+kjtwP29LGrGQ94psjrtrrJ3FVfpiOqYdv/vXxDn3PlJwVb2l4826W+7FAmsMKSLnk+39pLy74WeMnwmqiQD+qqnunJBP3oZ9wQUoVo9rgd151tVMUh5dad6tex1xeiEz+tvpJaT6qn6FVDHnRdL/3giZiBK+nyITx/Gdso7mM4MUTSr6ZtZfE04JBCPqR3f9G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3942.namprd15.prod.outlook.com (2603:10b6:5:2b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 06:29:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 06:29:25 +0000
Message-ID: <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
Date:   Wed, 28 Dec 2022 22:29:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     xiangxia.m.yue@gmail.com, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
 <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a57e63c-b48c-488b-6077-08dae96607aa
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9nBjvmaEgTE0CrFuIrOXn023eeJ/i+Ptnj9Q5bP8MVl5Ty40bz4qFOFATZWEUs7Q4Ld1tP7L7h1pEz4Dtoq1u6pHqRuMhXM8Ts06R7HXRpByVYudvPIgDUUqIchl3PTtH5kwpDZYvnh724/1D4xqoi1x610Q8t8ZqPd8dwExZPFTLR74ha+6y9iGFkxWaiIo068ngzocX49IIjjwlvA1OmtjhFNQHUNerGpz/jBWqJxBbu6yCHb/Cpj2rz/oSaQkozY90XSrqOYECWtKFFezTyFvrLDhXGM6/EC2DzZ5BpIO0GSrEbwYmnb5t2XaIfmWtIZJdbWcX/FfinTyy1zAMTaWF2vTEOYiPfIkAeEpVrEsjE7M1UMs5xRU3h2QveFY1ByUurkZ9TQTaLjWMvIomeE1o33ly5pOCpACnRTu7ItS7oaLwneAtGj5PGbhizuXGpc9bqQTfbfTWJONu9Y7suOVGPXMKzePa8eCymYjTA95DpBOXFmJTcDi9eqUNlJNlDwZOaqtGClz7+54cKmFsSG4IKc4qARPWOOXUPSknKUeOHbO6vkFxZVNdOOhoZlspZOrFss2nd1ZRs/1SPAtXTv1CqDhCjfeCZwp0Vy+uIcU7VutxJqSKxtxKkoU3/SV2Uv2cXr9g3gaJiumCpnkxs5u/D3EsRc2C2SKAlCKmSQqH2g7QdBwB9wvVj37jrHeF7zaiwlvNjY97MPT9s0RPGYWWypr14z5NRfXcEwQEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(53546011)(6506007)(186003)(6512007)(478600001)(6486002)(316002)(86362001)(2906002)(31696002)(6666004)(6916009)(54906003)(36756003)(31686004)(2616005)(7416002)(41300700001)(38100700002)(5660300002)(66946007)(66556008)(4326008)(83380400001)(8676002)(66476007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRiWllrTHNGb1p3SDB1WmdiS3ZiYkN0djRrZ0V5Mk9uSHp3Ulo2NFFNWGUr?=
 =?utf-8?B?MXZCY2Z3TERORlk1a2xKOVNDb25nUWZwWHU1bUcrRm4vSWhKZW4xaWV2WjNv?=
 =?utf-8?B?VFNackFJVzFvOTgrMW1rczV3SGxnbE82TGRYdzNOVmZDSm5RU0JMZndyOUpr?=
 =?utf-8?B?VTFtaWxHbnVTLzgrVFY5bjlRUkdtVU9OZnpycVZkemNNbkY5MjYvWkp5RFV4?=
 =?utf-8?B?aTAzUjFYSE5wcTN0NHBaV3RyaVlXTVVGMGJqSWw4alpWY3JZQ3FydVB3QjRW?=
 =?utf-8?B?Z0djTFhZclRmaVhPbWxPcnlscmRYdCtpVWJDWEVwQURNTHZwZkhIbk1Lb25Q?=
 =?utf-8?B?dFRuSE1KOXRoQjZ1MkJlcU96NjFVOXNIcmhFMFRTYk5hUGc4QVRKMzlkazY5?=
 =?utf-8?B?bHlnWkc3dzlLRVFQNkRuVkxvRUV2NVQ3WU15RVpPaVEyZEZPRU4zQmNocVpX?=
 =?utf-8?B?dEdkblZUK1dBNEVEcVRUWS9aZU5YNXdTUHdwdVhSbFB3SnBJYk9ncTI1b3pl?=
 =?utf-8?B?Ym9pVGZVRnBEcXQ2OUYwNUZwT1VNMkdGL29mcVEyaTJ3d1NHa0Z2bG51eUJU?=
 =?utf-8?B?aGVzSGRZV1U2VnJ3Zmc4MWxqcGw4cTlzbmJaZHFmdFJoNGFrZXc1UkRSSFdz?=
 =?utf-8?B?d2tkYTBZbVZyMzZtK0c1WkZiKzdrZVRVSHFEb3o1RHVsZzU1OEYrRVM2MmE1?=
 =?utf-8?B?QnBzaVo3dUpRWmpDQkU4Y2I2NTkxVkcxRGxMVzFoZkk1VzJQTDlIYzJHc2Rn?=
 =?utf-8?B?V01ES09IbThmQzRaUDhnTW5tRFlvY3o2SG5hdGFUSWwyQ3FqU2ZxK1I0T215?=
 =?utf-8?B?Q0svVitxVlgxL3hiK2FhbVdwcU8rWGs5NUgwQ20zWFdGelE5RzJUN0t3TlpH?=
 =?utf-8?B?SkQvcmpvbXNIa1ljRnh4K3U1aXhyVHA2NVVCb1lDSWx5c2IxZ1hsTFJTOGRx?=
 =?utf-8?B?YnM5NndlNjF2dUlnb0o5RlkwS21iL1pNZGF0L0hyTWQ2TVVLcU9aQS9RdlRI?=
 =?utf-8?B?RDhBclBNQmN1SGtDQ0NDTVFWbUdSZkdVMDRVaTFhZFc5Z3EwV0ZNRU01QXBx?=
 =?utf-8?B?M2FaUElwRzZOZGI0OTdiZXdtbkN5WEFXQmpLQ1BSRE5BV0VKMlpCWjJuaTQ0?=
 =?utf-8?B?cEI5eWtLKzY5MmlEb2k0cWdoVy9pWXl1TVJlZmNQVTZXS1RUeFBsY3J4d0o5?=
 =?utf-8?B?MTNHaWlRV3hOUWxiTTBCYVhqVkwrcURtTHMzZGxCb3ZMNDBkN1hLQXhMU3ZJ?=
 =?utf-8?B?bW5uYVBXTHBNL0FZaEQvdDZ4ak1VbFRTdzkzVGFGVzViejJMWXc2UWh2M29Y?=
 =?utf-8?B?VUF1eTNmNWQwNENRRGEzS1Fia2pZNjdGNzVmbDQyalFDWUZqQ0N5SGFZeEMw?=
 =?utf-8?B?UU01cmFaeUVxUHV1TjByd0lyRGdtYUx5NXpGSmRTRXRJV0tvcGw5MU5NU2Jx?=
 =?utf-8?B?M0lwV2p5S2FCNG5sNGh3TkRET2xLNjhic3hDWUROV3BJbFpuSTlHVkF2N0RN?=
 =?utf-8?B?M3RwbG5NTCtueVgvanI4WENjMnpxWDBUa3QrSDg0WXZyTWRZRU9EZmEwSXJm?=
 =?utf-8?B?aFFkSW5CZnFGR0JZZkgwMWg5YXFRNzd4a1F5MmtGV3hTWTM4WTZUbU84ZWFX?=
 =?utf-8?B?TU4wWk1YYlExdUc1dUUySnE2Nm8xblFva2hrVE96UVo4eDhEb0Q0OTFiV2c4?=
 =?utf-8?B?VVdrNS9RMWNRYTR0c1Z1WG0wT1BzRlMyaXJvSlVueFBxd1l1azFxTzdaeXV5?=
 =?utf-8?B?VlhCMDdOYlFBUjIwNVBSUmZyN0gxd3pFaGFqdHZrVENyZ2p1R2J3amZPdzBN?=
 =?utf-8?B?N2pTSzhWSjFwOVk3U0wwWTEybjlmSStzT2hIRmRvWkt0aG1kZC9ZN0x1ZUpM?=
 =?utf-8?B?M3MzZCt1MGZmd1F0SzRKS3hEaC9uMHY3eU9zMjR2c0VIV2hmand6YXZ0SWFk?=
 =?utf-8?B?WkdkdzFSU2RtcjRpNjlmalFzU3lISTJjdTNJYXQrWGJRVHpFT0V3YUVkL0JZ?=
 =?utf-8?B?V1lKTUFUTDBYWkp5dzlKM1pqYWEvYmNTVVozcHlWdHVUN2pVKzBZRDcwWDlP?=
 =?utf-8?B?NXZWaW5ZMFJQelhyamREb2tYZ1BpZk1DNXlYUkg1a1pnbjA2UXFhUDBtc3FD?=
 =?utf-8?B?WkdkSmpDY25TcnhYM3lpSUJ2SUE4S0tSVk94a2wxaFFHTjA0V0h1ZDluQzRF?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a57e63c-b48c-488b-6077-08dae96607aa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 06:29:25.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuBschL90IcareqPyGSsPaf0zwhcFFCwzjuO9PgUI//TaVIL4fW97xxYN5YZWoTn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3942
X-Proofpoint-ORIG-GUID: cgeVR_ibvZO4bWHsyi6YPAGBd1RKW0HD
X-Proofpoint-GUID: cgeVR_ibvZO4bWHsyi6YPAGBd1RKW0HD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-29_03,2022-12-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>
>>> This testing show how to reproduce deadlock in special case.
>>> We update htab map in Task and NMI context. Task can be interrupted by
>>> NMI, if the same map bucket was locked, there will be a deadlock.
>>>
>>> * map max_entries is 2.
>>> * NMI using key 4 and Task context using key 20.
>>> * so same bucket index but map_locked index is different.
>>>
>>> The selftest use perf to produce the NMI and fentry nmi_handle.
>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
>>> map syscall increase this counter in bpf_disable_instrumentation.
>>> Then fentry nmi_handle and update hash map will reproduce the issue.
>>>
>>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Hou Tao <houtao1@huawei.com>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>    tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>>>    tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>>>    .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
>>>    .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
>>>    4 files changed, 109 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> index 99cc33c51eaa..87e8fc9c9df2 100644
>>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
>>>    get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
>>>    get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
>>>    htab_update/reenter_update
>>> +htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
>>>    kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
>>>    kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
>>>    kfunc_call/subprog_lskel                         # skel unexpected error: -2
>>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
>>> index 585fcf73c731..735239b31050 100644
>>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>>> @@ -26,6 +26,7 @@ get_func_args_test                   # trampoline
>>>    get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
>>>    get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
>>>    htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
>>> +htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
>>>    kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
>>>    kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
>>>    kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..137dce8f1346
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> @@ -0,0 +1,75 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#define _GNU_SOURCE
>>> +#include <pthread.h>
>>> +#include <sched.h>
>>> +#include <test_progs.h>
>>> +
>>> +#include "htab_deadlock.skel.h"
>>> +
>>> +static int perf_event_open(void)
>>> +{
>>> +     struct perf_event_attr attr = {0};
>>> +     int pfd;
>>> +
>>> +     /* create perf event on CPU 0 */
>>> +     attr.size = sizeof(attr);
>>> +     attr.type = PERF_TYPE_HARDWARE;
>>> +     attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>> +     attr.freq = 1;
>>> +     attr.sample_freq = 1000;
>>> +     pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> +
>>> +     return pfd >= 0 ? pfd : -errno;
>>> +}
>>> +
>>> +void test_htab_deadlock(void)
>>> +{
>>> +     unsigned int val = 0, key = 20;
>>> +     struct bpf_link *link = NULL;
>>> +     struct htab_deadlock *skel;
>>> +     int err, i, pfd;
>>> +     cpu_set_t cpus;
>>> +
>>> +     skel = htab_deadlock__open_and_load();
>>> +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>> +             return;
>>> +
>>> +     err = htab_deadlock__attach(skel);
>>> +     if (!ASSERT_OK(err, "skel_attach"))
>>> +             goto clean_skel;
>>> +
>>> +     /* NMI events. */
>>> +     pfd = perf_event_open();
>>> +     if (pfd < 0) {
>>> +             if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
>>> +                     printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>> +                     test__skip();
>>> +                     goto clean_skel;
>>> +             }
>>> +             if (!ASSERT_GE(pfd, 0, "perf_event_open"))
>>> +                     goto clean_skel;
>>> +     }
>>> +
>>> +     link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
>>> +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>> +             goto clean_pfd;
>>> +
>>> +     /* Pinned on CPU 0 */
>>> +     CPU_ZERO(&cpus);
>>> +     CPU_SET(0, &cpus);
>>> +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
>>> +
>>> +     /* update bpf map concurrently on CPU0 in NMI and Task context.
>>> +      * there should be no kernel deadlock.
>>> +      */
>>> +     for (i = 0; i < 100000; i++)
>>> +             bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
>>> +                                 &key, &val, BPF_ANY);
>>> +
>>> +     bpf_link__destroy(link);
>>> +clean_pfd:
>>> +     close(pfd);
>>> +clean_skel:
>>> +     htab_deadlock__destroy(skel);
>>> +}
>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..d394f95e97c3
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> @@ -0,0 +1,32 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>> +     __uint(max_entries, 2);
>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>> +     __type(key, unsigned int);
>>> +     __type(value, unsigned int);
>>> +} htab SEC(".maps");
>>> +
>>> +/* nmi_handle on x86 platform. If changing keyword
>>> + * "static" to "inline", this prog load failed. */
>>> +SEC("fentry/nmi_handle")
>>
>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
>> we have
>>     static int nmi_handle(unsigned int type, struct pt_regs *regs)
>>     {
>>          ...
>>     }
>>     ...
>>     static noinstr void default_do_nmi(struct pt_regs *regs)
>>     {
>>          ...
>>          handled = nmi_handle(NMI_LOCAL, regs);
>>          ...
>>     }
>>
>> Since nmi_handle is a static function, it is possible that
>> the function might be inlined in default_do_nmi by the
>> compiler. If this happens, fentry/nmi_handle will not
>> be triggered and the test will pass.
>>
>> So I suggest to change the comment to
>>     nmi_handle() is a static function and might be
>>     inlined into its caller. If this happens, the
>>     test can still pass without previous kernel fix.
> 
> It's worse than this.
> fentry is buggy.
> We shouldn't allow attaching fentry to:
> NOKPROBE_SYMBOL(nmi_handle);

Okay, I see. Looks we should prevent fentry from
attaching any NOKPROBE_SYMBOL functions.

BTW, I think fentry/nmi_handle can be replaced with
tracepoint nmi/nmi_handler. it is more reliable
and won't be impacted by potential NOKPROBE_SYMBOL
issues.
