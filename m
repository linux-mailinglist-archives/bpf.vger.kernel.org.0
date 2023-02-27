Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3E6A4FA3
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjB0XZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjB0XZ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:25:28 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372C25E22
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:25:24 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RLAIL3017385;
        Mon, 27 Feb 2023 15:25:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=QRdIrYnp0sn77VWNUICklJF0BpTMCL7/XKdZ0V1HAs8=;
 b=EbKVvTv4H3bGac/u4ocJkCKiV1gVrul/HG+ph6m9PZF5Jbu10vc1TURPL1nKE7kiFccR
 5xPZpO7lcaWjcsV6qKy+dKVg6ksAvhIqclrcVVTdcDfsWkkE4jiyjSZB14O28641Wyhy
 uXx10olMV6NivhYqXGfq2UpETuDhVpFdkINmmc8FCiNLPfGtOUMiY8snGPviRJKMNYg2
 Sv/bGgP+XKeXEiOXR2lmJkf8Gc7+RzLATE3JJCRHsQhXWm9SjIXvhGt6ZfVw2/Q5eNQS
 f/eoicJLXGpj91Sz2jMjrvKxVJpuy0Yly8ki42Z85fgiY9L4PnfB5axwVSmWy3407tFY 2g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nygwt4nth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 15:25:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeXb59pRjg7ixBciFWbth9zPvGu8FOLkti7ughnAL8jXOuTcYTQf94mu7IBvAQwfmriNx+JUG79YmVhqYrz/e9Fld011wXUQPM4Ta6DY1JzNs6Big14A5w2UEmuCjxZ7WuqU5mWMTKNDSLNbkuVBPEIfIo4PyeAVhxoKFf9J/h4eZ1bbuVGK5xY/B+z7f7/oDMXk5E4VTqTTjwOIv08qv7giAfMsdgttwJU0+HdHu82oE1bRC6qNiuaHdjP0QFepnd4atL/ZxT9+freHQ112ktXbiJkKMVfK42oQynGxD4lK/v2DgKFFglYXeRxitOXvMZJkrffc5udwKdY0hAY50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPmq6geEa1bGLTUVOQL4zxIMggq1NciBl5wB+FgdM5I=;
 b=QGhGPDUad2HKL5CJyQTfnQ/udlWyKRnS5RiGtELBWqZqP6qRUUToY3SqY5k3w+X9LBc4erlYfiqqZDAra0V9kX5J2zpnZW3jMwJV84jZwu3DYqtFnlN7FVkUXogo9joBTZRoy+KchXtGpOY8/0qzi0jCD0WL3Ciwl7HFjKcAfQx3cm8O/lz4VNnrQK7Kw1iwldwNuLMcfIQUykBIDy8Dybtq6R8dKcdETrqnIev3nqWL/G4b6OOT0zLLhv5HpQ2bkAhYGDnQ/N3CQXZSIUTO7ltPuktOFfRmzABuwNktRpMdNrwJA7yALtgHxuM6U+94csG9Zo+wKq9a3MgVINfHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5692.namprd15.prod.outlook.com (2603:10b6:a03:4cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 23:25:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 23:25:06 +0000
Message-ID: <9627c69b-c174-e228-c38f-39598dfbd4cd@meta.com>
Date:   Mon, 27 Feb 2023 15:25:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [v2] bpf: Propose some new instructions for -mcpu=v4
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com>
 <CAEf4BzZ+pA4QQGbiS=_-gzGwCOpvGdzkQr1c17j8uGVREykzNQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzZ+pA4QQGbiS=_-gzGwCOpvGdzkQr1c17j8uGVREykzNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b88f23c-5adf-49dd-7cc1-08db1919dbf5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGPdSY5QmEyWqSef6PrrhlyUtDKrGmedMXYrNNPhfUxIM0FApnaPVBCh6nDMhD5tAYJwh3nzl3Qvxs9FcqC+RcH8Ao5glpdTTMVnVvHELpG/HqWk1ZcGJHNokv+Tr7J61BO/L737Cd1rnnoVPtCwO3byyS8rrBCo9NUfrymmXpTzBL+/oMVMcJKBPRzfxcYN3uG05cz2GSgtArvnIZ9C1sitSJAwY2v7V+EJ5p3a3VsiyLzmZxe0sLURh01wPlLI4Exti2GnR1ZdhcjpgFxm5zLdYUl9HCC0RHIkN+gfmso7q2cbwMbnpLhjc8i/1udnsMAPQRZGaDtiaH9B28A9RVFWK8UvrmEQpv7q1GlzexjAOxJbusSchCjgOSVUxLTbn9qJAFu5ng9ZRH4sBkvOZtSL6Y0LmRaGRkgZtd8Ci+ibtvcJGKejFqT7+VIJ6PepW75eWcAQKU98f2oaOdSu8mC2wWCexK4YkXs+W9VUXJnRAwO71DV/lOjFN+iYqjSBHu25u5v2SivyE8XUlneaRlD5WSbSahUUH17BSFgFHjIQ64Xfi6/xZhB2n7YPVECVcV+YUWrsKHZHilhlyxDM2H0h1DG06BwDGSCkrqCcptN05h99FfH3GXi2uhPU/4jkpnILTNmcz1/5wbfFg0m538VUWGiSHL7QpAtN054dM72LC52+fVuWk4rJtupG/ePjSG+lGIglAxwvkR0b9bAiyqM3i10B79TEZsow/YbJ/Oub7Fz+qb+YLdlqa3YMvySr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(2906002)(31686004)(5660300002)(8936002)(36756003)(41300700001)(54906003)(66476007)(66946007)(31696002)(86362001)(6916009)(316002)(8676002)(6486002)(966005)(4326008)(66556008)(478600001)(38100700002)(6512007)(53546011)(6506007)(186003)(2616005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BqOXdqNzdPSUFaOEFyL3FHWEcxWmZsUjdjeDRYbW42bW40NjhjTHFQcGZh?=
 =?utf-8?B?dzZkRjVkSm9USDBDY0pVaU9ManNhWTdxZjArWERaYy9MYW0za1I3aUt6T283?=
 =?utf-8?B?Q3ViVmt6TmhvTmpkWmE1TjJFbmYvejdZQmFKL09td0tGZ1Y0RDlGYVh2bDZP?=
 =?utf-8?B?cWRWMDNtZ1NtMEVUTm42dnA2dXNOWnd4ZzA4R3RkR041TXY3eEpwaks3c1VC?=
 =?utf-8?B?WFIwdTNUTjlCMDBnTk5qeTE4Vnc1UTFBVitTelo1Tkx3ck0ydFo3TFBKZFpH?=
 =?utf-8?B?SVhnSjRYZnhGaVhoc2Y4YmdFVDRBSVROQzRDTXV0Yzc0V3g5SHozOXlmNmpt?=
 =?utf-8?B?VlZVcVczTHJyVXZGckx0cDFLT0k1VlVHdnZJdEpkYk9vSVpha3AvdkU5UDQ4?=
 =?utf-8?B?U2tERnNyK2dSbnVCSzhWVER2dXFveVF1RGM4VWRsbVNaYmlvaDZkeGRLdk9q?=
 =?utf-8?B?cG81aEpVek0ycFR0d2Q1eXExaldBODVuWE9Ic2ovbm85QUVPNi9nQjNibGZH?=
 =?utf-8?B?S2pUNnlPcHBON2I2N0R5eTlHMkpMejQ5QU5KTlVqRDRMejFZVTdYS2Nra044?=
 =?utf-8?B?Zy9mSUFxWVBJZGhLRk5SaVJxNFRnQS80Nzh2dnY5MzZ1N0tUVlpyUzVXYmoy?=
 =?utf-8?B?V1kydERmTUg5UlpCOTNPeS85UlpaQnRTZjczVzdVbXFQVFVzcU14QXFJZmls?=
 =?utf-8?B?dmRNOUxqemUwa0U3WWwxOHdINlA5QnNuNzBEQjE0NUEwZzFkTnFWeS9vODNt?=
 =?utf-8?B?cXZLMXdNSmk0Z0xZSGpjYVJtZXdlQ3MyY1E4T05IYVdoODFoWXduRDI3WmVS?=
 =?utf-8?B?aWdSUzFVaVpyNGNzQnpWOVAzY0JCSWZRSXBWRzN4OGIvV1dkNVpJNHdnSFVP?=
 =?utf-8?B?Y2UwRHNUbE4xaU81bW0vTm00UzluNk1zcDVXaUxvUS9rYXhQNk5wakxsVWgz?=
 =?utf-8?B?ck1JL0ZGQVczVkg3VktlRTdyWWthbXowV01XRlUreU5QTGRDLzBHY21leTFF?=
 =?utf-8?B?UURtcmRqNElDNzhKclhtNlZMTmdGcU4xTkNKZmNlWGlqZk1URHA4NkVHQmdH?=
 =?utf-8?B?NUY1RUdxMTcwVzc4TEQ0VGFELzh6K2lSSGNjOTU3SndZRkpHNnY4aHNCSnRR?=
 =?utf-8?B?MHc3cmY3bjVwaEpocVpsVTZZQk44TWx1UW43dU5seTR0aDdRa2kwYXBkQ0E5?=
 =?utf-8?B?MlE3TlRYeEFlTTdmaXVPWEcwODN2Q2dkbjhKNHl0bUUyRXl1SEw0c0hBUjY4?=
 =?utf-8?B?endOQ2x6NWJEVkhTV2FCMDBKczFUZFlIcDRrMzI5V1FOMDV0V01qYmJmQ2Ra?=
 =?utf-8?B?b1hiNGdWY003LzhtKzR3eWU0c2pXKzBIMWVYSEtlcnNmamJaTlZCd2xxenY1?=
 =?utf-8?B?U212U25Ud1c5cng2UXNmRm44WkQ5a0RFaFc1SVUxU3FXeDFXcitzKzVCNEJv?=
 =?utf-8?B?SFhIeEJBTjVuaDQxemdiQnJUOVhoSnM5TFlIVVFyaTdta1J5enViQUdrRHhK?=
 =?utf-8?B?cEdHQy9EMTJsOEZEZ1RiL1kzRnNUYTVVUnBkdXpjOWRqOUVobjI3RWV1Nlpq?=
 =?utf-8?B?UjZWbllqeWFWYUFxM2JuNkZqMVFIenEwclZKV1RlWlpZd05DMnZWanZTRXdr?=
 =?utf-8?B?amVTZ3BPWXBzT3pmazNsSmNVZ0lBekg1RENsUWl6NE9tdlBLRGM3UHRLaExT?=
 =?utf-8?B?UW1DK3NWTVJ5M0kzWTRma0gvdTdiYkpIMlpqTWJTMWtHV0M3VWtBUllrc2x2?=
 =?utf-8?B?TnMwNG0yT2w1SWlJamUxT09PU3B2c2N1YmpkSXd0bmUySzNETUtTWGtXM3RI?=
 =?utf-8?B?OW80VkZPOExQenVSTnhVSUtUSE5UMXdNTlJjckZDdFRBd1o0azR3RWVUWXhP?=
 =?utf-8?B?THU5ZmhWVVY1R09KYXlqZlBLc1dvSFNHeCtCcHB3ZHVDc2RReVAxckVQbHJU?=
 =?utf-8?B?QjFFZGxRWlRENytER3Q3Z2xrbHBLeEMvZUhJVk1VaFhmb1FldklyWTY3RHBs?=
 =?utf-8?B?R1g5c3EvRlFFc1hreEhJY1l1bDk1a0E0c0xmWnVhNCtrUkJxbFNZUFQ0S255?=
 =?utf-8?B?RXNyajRQQk5CV3N4YS9XL0NycGVob0hrMjJGVHZZYnZXcVVPTlBSZnRGUUhv?=
 =?utf-8?B?cjVGN01iMktXVFdRc1FEaTJWVU1rNExGUlpCOEZMYmdjL0Vja2UzYlQwdmxn?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b88f23c-5adf-49dd-7cc1-08db1919dbf5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:25:05.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVQyPg3/7Zc3wK40fp+36/ouImrUQG+S4KLtUd4XZAx+9/6UJiX/flrxoNVNx6G6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5692
X-Proofpoint-ORIG-GUID: kA5b9wn93MBAoTcXvS6F1ctIsLib4Xm8
X-Proofpoint-GUID: kA5b9wn93MBAoTcXvS6F1ctIsLib4Xm8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/27/23 2:24 PM, Andrii Nakryiko wrote:
> On Sun, Feb 26, 2023 at 10:31 AM Yonghong Song <yhs@meta.com> wrote:
>>
>> Over the past, there are some discussions to extend bpf
>> instruction ISA to accommodate some new use cases or
>> fix some potential issues. These new instructions will
>> be included in new cpu flavor -mcpu=v4.
>>
>> The following are the proposal to add new instructions in 6
>> different categories. The proposal is a little bit rough.
>> You can find bpf insn background information in
>> Documentation/bpf/instruction-set.rst. Compared to previous
>> proposal (v1) in
>>
>> https://lore.kernel.org/bpf/01515302-c37d-2ee5-c950-2f556a4caad0@meta.com/
>> there are two changes:
>>     . for sign extend load, removing alu32_mode differentiator
>>       since alu32_mode is only a compiler asm syntax mechanism in
>>       this case, and not involved in insn encoding.
>>     . for sign extend mov, there is no support for sign extend
>>       moving an imm to a register.
>>
>> The corresponding llvm implementation is at
>>       https://reviews.llvm.org/D144829
>>
>> The following is the proposal details.
>>
>> SDIV/SMOD (signed div and mod)
>> ==============================
>>
>> bpf already has unsigned DIV and MOD. They are encoded as
>>
>>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>>      DIV  0x3          0/1           BPF_ALU/BPF_ALU64        0
>>      MOD  0x9          0/1           BPF_ALU/BPF_ALU64        0
>>
>> The current 'code' field only has two value left, 0xe and 0xf.
>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
>> But using these two values takes up all 'code' space and makes
>> future extension hard.
>>
>> Here, I propose to encode SDIV/SMOD like below:
>>
>>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>>      DIV  0x3          0/1           BPF_ALU/BPF_ALU64        1
>>      MOD  0x9          0/1           BPF_ALU/BPF_ALU64        1
>>
>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
>> to indicate signed div/mod.
>>
>> Sign extend load
>> ================
>>
>> Currently llvm generated normal load instructions are encoded like below.
>>
>>      mode(3 bits)      size(2 bits)    instruction class(3 bits)
>>      BPF_MEM (0x3)     8/16/32/64      BPF_LDX
>>
>> For mode, existing used values are 0x0, 0x1, 0x2, 0x3, 0x6.
>> The proposal is to use mod value 0x4 to encode sign extend loads.
>>
>>      mode(3 bits)      size(2 bits)    instruction class(3 bits)
>>      BPF_SMEM (0x4)    8/16/32         BPF_LDX
> 
> can we define BPF_SMEM for 64-bit for completeness here? I can see
> some situations where, for example, libbpf needs to switch between
> BPF_MEM/BPF_SMEM based on CO-RE relocation and target type, and not
> having to special-case 64-bit case would be nice.
> 
> It's minor, but so seems to be to support sign-extended 64-bit load
> (which would be equivalent to non-sign-extended, of course).

We can support sign-extended 64-bit load. But compiler won't be
able to generate this insn since 64-bit load will be generated
with existing non-sign-extended load.

If this can make libbpf life easier, yes, we can do it.

> 
>>
>> Sign extend register mov
>> ========================
>>
>> Current BPF_MOV insn is encoded as
>>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>>      MOV  0xb          0/1           BPF_ALU/BPF_ALU64        0
>>
>> Let us support sign extended move insn as defined below:
>>
>>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>>      MOVS 0xb          1             BPF_ALU                  8/16
>>      MOVS 0xb          1             BPF_ALU64                8/16/32
> 
> will this be literal 8, 16, 32 decimal values or similarly to
> BPF_{B,H,W,DW} we'll just have values 0, 1, 2, 3 to represent 8, 16,
> 32, 64?

Yes, 8/16/32 are decimal values similar to existing encoding of
be/le instruction.

> 
> Also, a similar question about uniformly supporting 32 for BPF_ALU and
> 64 for BPF_ALU64?

Similar to above 64bit SMEM, we could support 32bit sign extend for 
BPF_ALU and 64bit sign extend for BPF_ALU64. Compiler won't pick
these insns during code generation, but libbpf and inline asm should
be free to use them.

> 
> 
>>
>> In the above sign extended mov instruction, 'off' represents the 'size'.
>> For example, if BPF_ALU class, and 'off' is 8, which means sign
>> extend a 8-bit value (in register) to a 32-bit value. If BPF_ALU64 class,
>> the same 8-bit value will sign extend to a 64-bit value.
>>
> 
> [...]
