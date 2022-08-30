Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2EA5A721E
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiH3X6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiH3X6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:58:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AEA50C1
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:57:22 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjHrK003588;
        Tue, 30 Aug 2022 16:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VS8jeWgmTLsZbFYQwZP60RSHuIppWcpBZUjkuI0Puu4=;
 b=mEuqoM55zwczrlsn80mwQkZs/Pj9V9Hx05EIHNoUJVVFKHQg9IaBjyh4xmECYO634ZlF
 1pbKWMyJRA62/11K95j0cLzlL+9UVtJIUfoNg3tK7I/sZru2nM2LnjbZm7iLlqwHCsO8
 Fj8r5Rvy6ee3Uqnf86hkxt52a+YRbf26K5c= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5dn0jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5GNtcRw6/wHsnHROqq7dpGDnUAn+cLFUeoN62PcRwICAtE0WOIKEL24Uv9700tUwVOMf0Nl1tss3MbkZtJmGFiRoJ9yHJEGpXvAZv5GkpbZdOeYcTmGGbf6DQGCQbLBSVlTyYHyOj9uP6EUNeuDcolQsZzNw3jnsGABlEMt691qXShXDYJhWkfYhfLS27rjbrjIn2X0lnvk1+PoisYmn0sYLPsMk3ZTHFLiyGulm4e0iGGiFJfUNQQRdbsYOS7CDk9aw+ZjjkX1L4tJ1g8aYwW9bd/m46AW6Wvd9/VQRAhKsxBU3fV6veHgZFg448uY5yTlvXZR5SuMS+PHI4rqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS8jeWgmTLsZbFYQwZP60RSHuIppWcpBZUjkuI0Puu4=;
 b=A/qq56nK5yroj1Nnrczl6xfZAI3VDkBJ6rl3E6+53Z8nnO8pGrzzeKnJB0Od3kb5j4ZSjHJGKDnubO1ec9EX27MIboytFtc30nDkFNq/YGHC+Cug0H751+y2TC3B8hhLM9BdRPlCqGg7YP3X+Q60i+Qs/pdGG66pY791I2Vza7RtsdObodWT4GSmoVsCTXEqRxL/z3yppa0YhUeZVD2xT6NC8cGs05fNl3SCdhTU4k5VCiH0iWsdGWgpZT0bbEt60j33XsH7EkioID9uJorHYvkUeTWSM32qVAIiJeKD6bhKURQ5Sqf+enpZLcauarvqAg0QO5xws+zvqZKeKa33+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3642.namprd15.prod.outlook.com (2603:10b6:5:1fa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 23:56:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 23:56:35 +0000
Message-ID: <56e56327-cfed-3e78-84ca-db45ac5662c9@fb.com>
Date:   Tue, 30 Aug 2022 16:56:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-6-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220829192317.486946-6-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9587495b-1232-4623-ea52-08da8ae34565
X-MS-TrafficTypeDiagnostic: DM6PR15MB3642:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbmVe5fVKKtdVUYS3NJg/KyAeZo2gTliY+kqzF8R6MkrSFvifNe+/s+dV0O5SyHR76umTaQube1gwS8ixFUlEJygPeUml6kV67RVxZAooOkNQfOpyeWdJUGRMragUrKIOo7BQ+8GYssJr/vpYPsWqDggzfGvCkf6Sy2YLHgwfD22GTEq+aY1BJZ7uVpN4gZtr9CA6IY3dXufSw4TTo0XlVJYF4PJSbLrHcaFcW2+DVIQY1gXYMddkAslwnljyxiZfEcYXncXYNLUloLyMXONi3bDc8ju1BvMbwBG9TSUUHcW91ashHSmfHT/f9oJtHcsvP0+jK2Zwssg3spXjVUV3pPoRO7EGPWWRYEAISjc8ZPTmWSniDdOHbdSmhFF463/VZTMz12FEIc+CNYxzA0YkYhGn/xkZK/KjLzHFeQdv5d/jXaN64M4D5yqKjSNBijd01uINOUEt2WoBHfwV+k3DIS5ovOvuSQsJTdrKMdAd82dXXzrQmWA6S/1TPbWRS8/QV3VXyO3JAgbdaf7gFvISwmEkjh8S2sq3fIfp08bca33eR+4M31uYsXH5ZEA75CIxIfuE4fGi3c/8QTdtnxoRyTwTpwN7jEguKSWxkhQOQbq+OpPC9PMvX9GYEQiXv/PtA8gYpmkLmEd5Q7PF1saPOaBUQk1mXr1mRHn2wftlr30HcblL8Lr9X6H1oowe4UJbm3ACmzriNTbREQsYzWhHQo/u17/pQVTUppNXVY2Gd4ZVUxiSYf938d4inmN3xS/6HQ//zV3QOHSSrCN8zirfDW3VaMeqJgSl+Vujz8qPUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6512007)(186003)(53546011)(4744005)(8936002)(6506007)(5660300002)(36756003)(31686004)(41300700001)(86362001)(478600001)(6486002)(31696002)(316002)(6636002)(2906002)(2616005)(38100700002)(8676002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlyM0JTTWg3SWVPNWZWZmw5MTZHLzJPdkd1VjhyQklwamg4anhpT2RZdWUw?=
 =?utf-8?B?SEx6TWd6dyt1QVBmbjkwNlBublJLRy9QOVNGc2J3NWpXczliKzJnTk1nVkUy?=
 =?utf-8?B?Z0lTQUxJa2lBY0cxanVRWkxLV1RxZnRMWjNhMDA5Z0loYXJNMEZoMHFkUEJk?=
 =?utf-8?B?Q1FrWTk2YlFOaExNbEJ6U01jNjJudTdNdmk2UFpGeTNUSnJzbW4xYUdhL0VS?=
 =?utf-8?B?RCtUbFJac1ZCczFOOEhPL1RaUFdzY2s1SFBVY1Z0dDlMVStidk45UnhXTjF5?=
 =?utf-8?B?emRwb1lwQ3pTaTZvczJuam1jaS9zdE5Ja0FZbWlkS1loMmVES2IrM2sxWHlo?=
 =?utf-8?B?bWtXaktQbks0MFBadWVQS1kvUkY5enFpcFFNdVZrVVpocGdyZUI4c1duZThz?=
 =?utf-8?B?NjhoNkNleEYxQklNd3lyRlkwS1JadjdKeEl0eXNhL1hvc0dTQkNhR01WZlln?=
 =?utf-8?B?cDdVN0tYNlVVWURUamtld0syZzBDVHlnUFFxbVpMdXJpVWV2dm1hWEkwN2pG?=
 =?utf-8?B?RkpRdzZkZWxMcU80OUs1OEtCajgrQno0UDY3c0VYSzNYREQvYk1aNVVxQTA3?=
 =?utf-8?B?OUpLc3NqOGh1dFhKbDMyYnlXTExBak1MNDM3RDE3MVdTUVhaQ3NhVktyS2J2?=
 =?utf-8?B?NDlvL3BzYklaWVczQjhoQmNibFIxRStPSDRQZ3lhUWF1MTExaStBNDdFQWFS?=
 =?utf-8?B?ZStRRkh6U1ZlZldKbGlvNWZ4WUVSaDNwQ3RLOW1kSWl4VkdWYXN3OXZZSkNU?=
 =?utf-8?B?SkdTNGVKTDE3NUZ6V0c5VzZ3cGZJdG5kb0xvMTNEQnhSVEZBeTI0OWdxSXFa?=
 =?utf-8?B?NTVyQnd6dUxGOWpYTFRISzA4U3dDV2J1UTV0KzdRK0xnak5SSGhOb0t4WG1M?=
 =?utf-8?B?Tmt5Nko4T1p6SHNGTWFHOHNnM1Y2RFIyRVZ5ek9lekhidWYyUElFb0dSSGNt?=
 =?utf-8?B?b2l1VTB4RElqZWZabENaZ1haYnlCaE5tRXRaVS9pajZCVXNOSjNBdmMzTndi?=
 =?utf-8?B?VkZJVGVOc2lObkltNjFFTmdwZDJaak93am5rNnFqV2JlZXErN1hIVU1vdnBT?=
 =?utf-8?B?MDNqTWZCZVVSZHJaQzM0aHBtM2tsYkFhVHdTNmpoRkU2enlzNzVub21BRXNJ?=
 =?utf-8?B?SWZxMEZFYi9jY2E4eHlIRUxidHlaa0FjbGpSUFp4N3VVaVNxQnI1NUtaZVVm?=
 =?utf-8?B?TVdvWWVtTFVRZjMrSzNwVW5jbzhWN3lZcGM1MVhXZmNQeXhVRXRYOEVtV1ho?=
 =?utf-8?B?VmZ0Y0NqQjJRSUFWMlhYU3NiQThzdzJLM3A0OVh3OXlxMW1heUVQQ0U3c0Jq?=
 =?utf-8?B?LzBzZEZ6U0FGNTBhSXBBWEx1WERmdk8va2YrNG9QTlJSZHUveG11QnoyWE1N?=
 =?utf-8?B?Z2hkMEJxRmQ1aGtacndHcDJZWlNqL01xYU9LZFBpR1BsdTR6dHoxckowOWpq?=
 =?utf-8?B?RnF6STVXL2swQ0NGMERydlU1bmhzTlVCMzdRaXZmNjd0WEh4NFdUdVVNMzlw?=
 =?utf-8?B?RW1ablZDU0xTYUVQK0lhN3lYWTJhaDhzUjNzeGI4eDdnd2RNUzRMdUc2dlhw?=
 =?utf-8?B?YW9KV2Z0SW5icWtDamRjVXNiOTZzMjI5L2FTVTU1V1pKckpLQWhja2J3UjRw?=
 =?utf-8?B?UWRuUVBmSURuK0hIWk1kMUlLN2VaWGEzZmsvbU1ocURWSnduL3VRcjFOTitJ?=
 =?utf-8?B?N05NQlhaNVliemZSY0JPeG9GQ21CdTBVSExBbkg1N3diZU5QSFU2N1BDYml2?=
 =?utf-8?B?a0tyMDFDUkZMYkJ5Mk4vYlhvWmpQbEtvRGl6QkFuTUJnaEQ2V1h4K0ptUWR5?=
 =?utf-8?B?bTZtUGIwUGZXRjQwTjZhb3RrMXV3V2Iyd05yV3phU1pGemJzV0JoSG9LdUxk?=
 =?utf-8?B?V1pWOWpsY2hmREFnUzdxYVlPUDlnUE1VYk5Bcld4cEpSSDJuR2FMa0NXMi9x?=
 =?utf-8?B?VXNhT3JhNCsyRjV0WWdyeVV6bWZodEdndERDUFpnMjRQb0hZREdVSEJXVWFJ?=
 =?utf-8?B?ZndpRiswcmh6WEdLY3BIRzZxYURuNngrL1lJNTkyMSt5bnhKSi92YXNDMitn?=
 =?utf-8?B?RlhONDljeVZxTHBFSlZ1dWJYUjZjVzdNb3hRNkFSakhaUU0zNFYyQkVNcFg1?=
 =?utf-8?B?Zk1hWWpubC9UQWR4Z3JNU0NLdEpZNmZpRTIwMGM3VllaK1BFV3FqTGhFTFMy?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9587495b-1232-4623-ea52-08da8ae34565
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 23:56:35.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljQPvrhBxSSbtlLZmtSLIPbB/jUKIZnEJDEEimNTiTKwB/wWb2RnoiDq586txFLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3642
X-Proofpoint-GUID: zL_rBCrM4gFnEs9mftqu-CAx4EfOC2B8
X-Proofpoint-ORIG-GUID: zL_rBCrM4gFnEs9mftqu-CAx4EfOC2B8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
> Show tid or pid of iterators if giving an argument of tid or pid
> 
> For example, the command `bpftool link list` may list following
> lines.
> 
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 33: iter  prog 225  target_name task_file  tid 1644
>          pids test_progs(1644)
> 
> Link 33 is a task_file iterator with tid 1644.  For now, only targets
> of task, task_file and task_vma may be with tid or pid to filter out
> tasks other than those belonging to a process (pid) or a thread (tid).
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Please rebase on top of bpf-next as the bpf_iter cgroup support
is just merged which will cause a conflict with this patch.

Acked-by: Yonghong Song <yhs@fb.com>
