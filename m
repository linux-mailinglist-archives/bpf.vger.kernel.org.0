Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D351F258
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiEIBav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 21:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiEIBBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 21:01:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEFEBE09
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:57:16 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248MchPH023935;
        Sun, 8 May 2022 17:57:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=A4jyd7lXriECNwtJImDnkHixPAUXbR1NOJwh7bqrjaI=;
 b=NtaIrt/TDXaDPvCqoIPlR64yreWUsqA+lR0CglwYa4yj6TB7jMr/T/C0yduezXhOzpLS
 wBOuAsGrGVTDdCF4cZwi8uZDCxyyLnFXgVeQ96DnYTDa+d4dSwMu3119f0kUhSIlVZ/4
 IinmYA9QpGoIhPuXCl89EVxCM3YjpnjtA7k= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpfmntbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 17:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXMyAOMh/u5miik4nQGsjoGBQp1BUcAHhAJL+8uHnzrZjg0IK+/SNyafP98x1JppqYulBIu1i/5bJOVsqnXUv78Q83pa7KVRvMHidRrXmRMH4vQShQvMKkg2u9we8DzRcOK0qgR2GtYXZsudn1Gfee6Mb4gJ0aP2MV9g7353YAeN3YY32H2rWHIp7O79oo4Nmmo+2pcm3ZrMB2SQ6EVzB5lV9OzxUntSiuemoVNIiZnGnJtP3dfIjIa5WpWuuufJlwwDndZRaUc7Z/UN2ksKohYenjFIEn49h2F8klaFrweDUxg4uJ93ap5WxOSWsy5RdRPrSInqbAGvGZmMTuEMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4jyd7lXriECNwtJImDnkHixPAUXbR1NOJwh7bqrjaI=;
 b=LWz4pJH+OKP4cvg+rojUmzV2YPMs7RUsumKhp7rBmzXWkf4DGomHXhL48KTQylqZB9vZ3TCbkGhyHXjynR/W9xQqXPDp9AvEMF/sEny3TTWPuZo2sPdsDZUb+FMb5W4Kdi/Zhdi9dfsHY3KmCK3RL0K7N1zcq6F3g3sZ9Bh5GAiGZWsQdbW9Qo+dxJfnQKKvWur88NobYjZDjoNeltevRwx4tWwvypKGW/kV6WAqBbHJuEj0Pgd33BKFUa0xDtdNk0vuPh3HBDI1iCmbzH0Jp0WjEM7OJJNyKwaAA40Z8usNgdlQqRAo+FYr/6Lf8+P0S/CzlGHfqlEZpR6MZI1pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB2832.namprd15.prod.outlook.com (2603:10b6:208:125::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 00:57:01 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 00:57:01 +0000
Message-ID: <3eaeb884-1c67-6461-e610-1f6a26068730@fb.com>
Date:   Sun, 8 May 2022 20:56:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 03/12] libbpf: Fix an error in 64bit relocation
 value computation
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190017.2577688-1-yhs@fb.com>
 <8572184e-7ba7-d16e-8823-0fbc4abac627@fb.com>
In-Reply-To: <8572184e-7ba7-d16e-8823-0fbc4abac627@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::22) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82e3138-4a80-4e17-7112-08da3156d374
X-MS-TrafficTypeDiagnostic: MN2PR15MB2832:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2832BAF223790D91B122483AA0C69@MN2PR15MB2832.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/LLSut4yjHGFbJuUZ+liHn367NiWq82Eps5xWPfh9KrC+TVWwUgiBZjO03gnSFkQ/XLiJKPGmPd3rCM/AMmlYsoeNgllXNFGzKBpm2oSGqHj0mkmdkA3D8P49p8RNUS7cQMwLW6HZoCKQ81qcFXmXNAzAiq4qp9z2c67vbvI88wM8kobyf4vNRttfbQIcZijkas5lPRN8nM9H3jLYYgK+TxJwOBCK2FrF8G2OLil1F7QhX1GgYmnqVXxQmA6g5dKQgn8Dnvyr2aBAfGvoJUApqwXZvSoFcW1L1krhkV0oJWcngzxywX4SKIql5p9LPIa/uT7c2OYmhQ0lX6qehSFgJ8Fy4QBGRk8egEAxTXf4izV3R6RH7qjBsJBn5inX0dgzKPN6NliomFrSKfPiINaYphMng3CNuh1llkNcAXng8vZQTNvzmtW2sjgFqbenpDcbZJJEiyUpv9l1ZaGZh0b+Dd/RmqFq/JF7M2wiMUYrXg9CDK/QjuMEK4cZc4thI+CU4x5mjYZ/lqljjgv2UkY96iFEVjCfo1b1FhuLn+npdB1Jtq5cKgVi2xpw3F+S4+v7UEGK/hwJZqpuzo+vLr1QZ7dlcmqTYvNq8jRg4uRNse39PEFLedsqIxOJ1Px6QgjGq4CqQ/yHeaVCCgDNXy7dDLwIDGs7pt7zkCgT5UlkjjRIEm6XZ1bLtb/24EKPbEhM0B7sIqDuvq425PfKiwirV42ttRpgwdX6ZhMEKDnYsEAH8+/9w1eiCTyQGMRLM/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4744005)(36756003)(31696002)(8936002)(31686004)(38100700002)(5660300002)(83380400001)(508600001)(186003)(4326008)(66556008)(66476007)(2616005)(8676002)(66946007)(54906003)(316002)(53546011)(6506007)(86362001)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRFWkNKdnVKTkovaWFVcXBjYUhnRSt6RFE3SVpOeURoV1p6Rk13Ym8rYUdu?=
 =?utf-8?B?Tm1seTFzTlNHR1J4K1dZNlF6OG1qeXpVNzY5RE00NVVIVDdmM2VRbXBFQmQ1?=
 =?utf-8?B?TTg3aVR0K2twVEFyaXZYLzBsK3c1bVU3Q1pjL3BDYjd6ZjZ3U3pkTmpKZ1BT?=
 =?utf-8?B?U3VHOU9BbmhqakpvVlRGRDY1OENtaUpibk5FbHVFQmZpRS9wL2VlL1BuUlNy?=
 =?utf-8?B?WSt2YWE1Y2svZmp2UVlVQk84OWdoV3FCWi9xUGJyRWkybjJkTTJqZGgyRXdG?=
 =?utf-8?B?MTMyRWNVWkkvM1BobmdtQTBzVmM3SWNhN3BrYXlQNWJmSTJMdnp5Q3NOeFNC?=
 =?utf-8?B?NkZvOWxBUEhTUklHT2pod3VVenp2ek5MZmkyUExmMjdLdEhTNXNmMWxUbERX?=
 =?utf-8?B?NUZwbW1yTXd5eEErS25hUmNKaVY1SzE5R0RSbm5QSWhIS2E1cXhtd2FNUjdJ?=
 =?utf-8?B?a0JZeFBURkpKYmFWcWtNTjJZb1c3cVEyN2prRVBhOVZRYjRtcGhRNGxPbW5H?=
 =?utf-8?B?QlUweVVnUFdPTWdWUlVJQzBtZ09MVUc3VHZBcjZaL3ZuSHUrdjV3b0tOV1RB?=
 =?utf-8?B?NzVva1BScDdvZ0tQQi9DUzduT3V0V28rcmZOZXhBUlIzem03dGowYWY1MXZo?=
 =?utf-8?B?cEJzQUQrUFF2U0tXRkcwdzlMN1lkVVlVb3loTy9URzNVbVVwUlZnK01US2xh?=
 =?utf-8?B?cU1nNmhkWmJQL1V5NWxIMmhqczBsVzdoeTA1MjIrQ3lYNzRFSEcwRVpLbVpR?=
 =?utf-8?B?MmE0NEJLZGQ1a2VvcnFDOHdrcXFzKzF4T1Rzb3Rsd2xHT3FuOHZGeWlDdkFE?=
 =?utf-8?B?L2I3ek5CQTc2NjBpd3lvdEphaFAzd1ViOWdINFh5cXZRL1FBcmtCNndUWlBn?=
 =?utf-8?B?b25vUXYzQVhCbUNqMjM0eW9NeUcvV0oyZVp1VGNiZXdMNlNoeVBqQXRhNUhJ?=
 =?utf-8?B?dmxqVGpldXkzLzc1cEJqc3NLclhRTkdZVWY1aEFzbmozbEVuRTNZUGdlQXp3?=
 =?utf-8?B?elZTa2ZIb1AyUWpXNmtqQ1lOeHhPOHJqekhHdStFR1ZtZlhPV0ZOa0dhOXg0?=
 =?utf-8?B?a0wxcElnS2JJU2R2a0ExdE9KQ3dFYllPMy9kRGd6blF3VGdrdjRYQXk2cTJw?=
 =?utf-8?B?QzNzSzRBb252YzhOb2FwTENBaCt0M3dYTW1TbkRaaWpjMS91WnRxNFk5Q1RT?=
 =?utf-8?B?eWRvZ0cvZWhiRnFFK1drWTRQS2NHZDZBRCtpa0lrWm1QY3diOUkyVmc3bytw?=
 =?utf-8?B?alUyVFV6NnJ2ZDlrL0l0YmFFYjlsVk9QRklJMVVkZHhmWXR5QVR0ZUhoa1dN?=
 =?utf-8?B?MzJrZWU4bGdDeGE1UnF4NFNUSjRkTFlpKzVoMU1aY1FhQ2ZHVlk5RUhsY1M4?=
 =?utf-8?B?QVQ4UWZrV2lWK05lSW94dXFqSmV6S0dLMU1TdEFIK0ptU2ZsdCtOV3FhdWdy?=
 =?utf-8?B?OHVFOWxoZklUeC8zMVVCTDB1clVIVEJWSjVhZGF6eW1mWmxYOVBUMXVIMldY?=
 =?utf-8?B?V2NYSFJOaFlIcXVJNkFEUkJkVU9weitoSm1idk1wUWtkUHp4ZnlIaExKQi85?=
 =?utf-8?B?WE5VcXE3RHhYeG8vR1Y0ZDhwUWQvdmRWMTE4dGtEeTd6aVZ1RGpxbHpyaG1i?=
 =?utf-8?B?bU0rWGFVR3hib3ZzeTVtaE9NckQ5LzFaWUU0ZCt6cmJ4UGVNcVRNbHFFQ1Va?=
 =?utf-8?B?UXpjcCtPbGlJZzRZajR2MHpFRDR6VTJqUXdvaVF0YWRJUkU1ek9aNkFJZ0VG?=
 =?utf-8?B?U3VlR3lXMnJwbVhQS1N5cFRteDlKRnN1bTBEYjBBOGMzYTQ4ejEwM2lFemZm?=
 =?utf-8?B?eHYxSjUva1p2aUQvQkJrei8rVzBXbFdNT3V1MlVyYWlWcGlQb09jWTVEQmFS?=
 =?utf-8?B?Yi80VFFwNS9ZZUcwdEFhZWxOajlrVEpwZTBMd0xiVzlhQ2dYRjZ0YzVJd1Vm?=
 =?utf-8?B?N2Y4aW55SjVYMEtvU3Z2OXRORC9mZlBzOVZzZ1BVQmJUbFNzM3doSnRmTHNR?=
 =?utf-8?B?QnJOUElDcjIycWNSUGZqQVJqRFQ5enFqeStDellCaWxjQXdQejVBZVFiemE2?=
 =?utf-8?B?TldZNVIrNGdlTmU2ZmFpcnhaSTZwcGkwWjlSd1hpUEwyRE9qdUxuUzdxU29Y?=
 =?utf-8?B?dUFNL3lyckg1enhnMFhDNUJEclRQRGhxclhkRzdlNTJKaWQ3cCtaSzcxRWRo?=
 =?utf-8?B?M1JEMS9saHdvMkY1d3M0R24rZlVVbERnRUNadUpRVUZ2TFlTa28zenlLQUFq?=
 =?utf-8?B?OWJHSDh3NllTeVpXTW5oR2FHWFJSY1B3N0tRTWpIcVZSZG5ZTUIxaXlhNWVD?=
 =?utf-8?B?cDJzSDFZTlpjWkcvTXJVTlA2U1NuNVhJVVBRYmt2VW01OEE4a3FvRmVnMFg3?=
 =?utf-8?Q?QotTNRCa9bg8zxyEO0Z9P92WuO2eTwRxf4rPn?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82e3138-4a80-4e17-7112-08da3156d374
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 00:57:01.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKIiNpBJv6wjDs7T9MGmdjxpyFsVulDs2c4PeWZQD0SVuSXnzHuc8VS1gX7PU5bgqQTS4Y7GaFV+Jf9+GnEsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2832
X-Proofpoint-ORIG-GUID: 9Wi86_8wy5EJ5mAx56yi4MmjA2Ni0r1I
X-Proofpoint-GUID: 9Wi86_8wy5EJ5mAx56yi4MmjA2Ni0r1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/8/22 8:55 PM, Dave Marchevsky wrote:   
> On 5/1/22 3:00 PM, Yonghong Song wrote:   
>> Currently, the 64bit relocation value in the instruction
>> is computed as follows:
>>   __u64 imm = insn[0].imm + ((__u64)insn[1].imm << 32)
>>
>> Suppose insn[0].imm = -1 (0xffffffff) and insn[1].imm = 1.
>> With the above computation, insn[0].imm will first sign-extend
>> to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
>> producing incorrect value 0xFFFFFFFF. The correct value
>> should be 0x1FFFFFFFF.
>>
>> Changing insn[0].imm to __u32 first will prevent 64bit sign
>> extension and fix the issue.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>  tools/lib/bpf/relo_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> 

Whoops, meant:

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
