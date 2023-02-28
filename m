Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BBA6A5353
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1HAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 02:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1HAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 02:00:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB114C33
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 23:00:40 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S4ZiCk012494;
        Mon, 27 Feb 2023 23:00:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5Xg7TAoA5awOfezQWczJnfb5SE3EjNT05v2Hy3zUtBw=;
 b=Y22lh+i1Wz1Zh745Ggy7tbHaqYGlbYUlXAONcSrl/Q7GB6TjdYT7hMKPtw0Y8GYmw9iv
 Ra565x9dBKQdFXr8FRVAXRBP/SU6gm7fFVmgYVUWGXF4L5E9O9d0yMMPwn6OM5NSIUXi
 fdNyDpnTdOy2vFvVo/GYFf6o5D7ZtFWLxvZYKz5r6uJwOWF3Gb6DNXmM6J7q/wzngszZ
 1kz0b2zvA6BKMqRQQGFH7/9CP++xl5t6uDQpRmV3VKpDpgUBQVI2eFjFgwFqv5IbqeE1
 DWtnuaStDGWQxQeRdHK0Cw8XGoj+k+hK53EWT5pfv3Q35PEjxXZUdWZQrQ2YN2jFY/iM CA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p14eptvux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 23:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAXj6sHOemLHy/E171yh0caxbT1Isx9FQy5Xcoka/j/0QW0uCSAB0eeQqngILMGh2bCaVItAFbzJZiEnhEUzj+bj05Z3s/MMy4yCPTdpzAWyRtbwyth34RNztprZZGeMqmR9tfQWgb8+aLzKV+3dPc5Zc4B7Opnf9YPw6pirevCzPyMT9jnYfd2KaQwf3E+aCFvFj1P0mj5iqCtNNWFrzwV6hmUQjsRIzoGpaVgLLsRmpzu4ARh1/wtal9MiploDMbeU2zYAUKPaLExvlyhARh1LXS9+LtMbCQ3mLXIkkC87ibkjCmmcx+gBQBOaRLnZf1Lt/NBSMzq3VbpecOPKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xg7TAoA5awOfezQWczJnfb5SE3EjNT05v2Hy3zUtBw=;
 b=UGpv/+eExsKoxbKIi6731fIFPNW6/bUpiQI3M+4GBuPgfYYvxlvjMVlMJ7LDqmX8j3Z7MjRilIFrYU0UgyTVDMeyQ1W9/mqu+UpraAIQeQDhNAEhjHf+aR6DMIqLYB/67f7pnSc1KdpL6cvCW63AY8/ybujotCPY1Aun7Tt4rIz3M5CU7J0hg/TAbhpYPipgr6krbbKcolK0fRltAgxcfCq1N+O3IO4EeHy0WvAz/h7NLBOh3d04S0FjdpVqP8q0iX0mpT74sZwBBzpalqmUstglyXgnrMBCE1R1ZnaypMrWXnhzuNsFUgGKFoJpADWO+iuiWwSLJF2+wtcQI55IdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5418.namprd15.prod.outlook.com (2603:10b6:208:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Tue, 28 Feb
 2023 07:00:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 07:00:27 +0000
Message-ID: <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com>
Date:   Mon, 27 Feb 2023 23:00:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V4] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
References: <87r0ua7fu8.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87r0ua7fu8.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f251ebe-4751-49fc-ab29-08db195978d4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgcTpNdqp0hCL+ydcxyyk93JlJvvDBU3RR5Mh5CUGKrfzaqmri86cd40I3XmAPoI8rE+adFg0KjQtWC8YLFy6JRuxhBkS+XprvH2pAz6FbunuyN4HhqA0rlapZ46va9e20qFutcaP+kUdMTEDKEptQtlQi6PvaEGD3D/lX+ORj1GmBPYdxQUi3RmvCjZmPrDBx7spwyGdcm9mK3SRQYosjp4GxpwpIbHPUB/aupvJ5ecHeshRz8s/uDymmw4uCYGiv2/gFMnC5n+b8gOBTl2P4+LD1Yd3wdxNNapENfHmdTvqHJp6uBnr4SS68kn3Wc7W+7hS/6jwqyiS81GH7KBHb7JXsm9p465WWuGvM/guTM3luCVZFyq1ZZZoCnWOeaK3t764qMSJJ7Zw95i0K5oMkrQryiTaiiw0T71mM9uZ0b0tm0/KuASoTIPiwmSuCPnHb1Cle3RuHE8NG8t0qVCAndVnTM8pBwi1qgN1kbsoo8OI8GLp1kh2YZlj6mGDmoAdTfca3BmAU9awM05CGpmEZd4V/HBWF4gTKEWxUVkVCBACo4M9wAUuFA7sSJwhP69lwXYUMWhG6X8Lk3TZE89c6yq4zvtNNHiAQj+QD+U+O1SQvEKvX6Z0N2vT4xbLrqlpRAc5Qstfe9bsIRDUoWtZOQggNc7Iom1YsgRsnAk/nlfrkVP2rZoKI9aCA5h8h6oJhqVW40TyVrpETa07a3AnfU0HQFVOySuuBLKAObzOgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(6486002)(6666004)(2616005)(83380400001)(31696002)(38100700002)(86362001)(6512007)(53546011)(6506007)(186003)(5660300002)(54906003)(110136005)(478600001)(36756003)(8936002)(31686004)(316002)(66946007)(66476007)(8676002)(66556008)(2906002)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxCQmlpUU5ZbHFOV0phTXJIOHpKM2lNdnhsMFJXVGtkYWFaSTl6MVlWYmRM?=
 =?utf-8?B?NGUyalRpNUJBcHhKd3JmUjA4REdOd3VtNi8xdkZobnB4VzJnMzlYZ1VZYyt6?=
 =?utf-8?B?bXdZZGRtQVdFT0pFZU92YUMrN3Ribk83Nzd1SUo5SmJYT1pnTWdhMjk1ME0w?=
 =?utf-8?B?SGNsS0hHY2grSGp6SlhsbTVOYlVsOTNMNURpT0FCZ0ZJeVN1azFmM2U0dGRV?=
 =?utf-8?B?bjdvQVdiOVF0Mk15a3FMSkw5aXFQK0RMc0tIWUU0WWNYazBvQUJWdlpZa28y?=
 =?utf-8?B?dFVqdWcwMW0wNWpKbFVycldpWjVYcEdTL3VVY0I3K1luSzUxeit6S0dxS2Ir?=
 =?utf-8?B?cDlJL0ZuOGNmS1BlcTdxOFdqTkkrOEU1WDYyMjdxeWpzQmdidXNMVXNYc0E2?=
 =?utf-8?B?NlZRVm53bEVId3RUL0ZZb0UzRS9zR1RNQW9DR0poeFRidUxHZHFWY3NPWFNJ?=
 =?utf-8?B?eDhoTExPd0FwYnRJVjRDdHFuemZNQ1hrOUJZQ2JyTmk4c1VZakljblpJQTFU?=
 =?utf-8?B?YnhJZUJTdXd0Y3M2d3FPbFJZdU1aNmJoZ0VCL2UzQ3ppTlRaaGpTMjE3WWNQ?=
 =?utf-8?B?a0xZQTlianZhUWE4T2M2amcvdkRoS0VqUCtHbHp3dXA1d1BaaExVM1dkS0Rv?=
 =?utf-8?B?ZkNCNWwxTGtaRmJDdDFzQmZxenBtaUxiTTBwWUp6M1RBeWNBeWhBVXJpejNZ?=
 =?utf-8?B?Z2tUTDIrZWJESlNTOThWRkZTSU1tTnVadzd6NFE5blRic0NjRHRPaGlqM3Bv?=
 =?utf-8?B?aEpTL0hIRXNDaEtOWURrcDEwVWc2dFhzMGpyaE5CM01OdDBjOTRpQy9mMFBk?=
 =?utf-8?B?NXZpVTBjR01sRzlpT25Ib0RUdk16K3hWSGdlMDBmcEhrZ2dZK3dKM0NmWXdw?=
 =?utf-8?B?UVg0TzBXeHJmRDBGQ2huS3FtNVRoQ2N3djBVM0xCcFg1NmV6VC9QanBUVVdD?=
 =?utf-8?B?dlJURjhMcXpPK1RYNHRhcWVuMUdKV3I0aW04WW9naDlaY3ZENUQvb2lCZEJa?=
 =?utf-8?B?NjE2WXhWSnF0MGRaQVBXai9oMzhqQy9Lb0JVUVVNL1V1Y2I1Qm5ONFl4MDV1?=
 =?utf-8?B?aVJqTytSUUhJUlBwNEIwZXM4eGl4c2NIQXMva3puVmg4a2ZlQUN4bTd5UjQr?=
 =?utf-8?B?YmJMMDR0Sm1Ld3NrNGFwei81NjYzUzVMZGJVZ2VsU3ZoZ1VSQ0QzYm1DczlY?=
 =?utf-8?B?MTRuUWgydTVCMXZKdkQxNlNlekJ2OWw5bUF6UndOME5hVzRsbmcxdVhzVVow?=
 =?utf-8?B?bDg2dzFNNUVLNzZJWFVlYVhkTW8rSkR1YVhlbE9UbzVLTk9xU1Y3SG96UEQ1?=
 =?utf-8?B?RHJKSFM1cVdSUmk5Y0hOMUF4WnFUTEJGRTBCY0JhZ1ZjZzdEYm40cHYxelFl?=
 =?utf-8?B?R0NSMnFtYTRnVVJzTGJzVGR6V0hrRUxISmY5VW1FdFRTTnN3Q0g0VkNhK1ln?=
 =?utf-8?B?UTYybzRQS3JEYWUrT213N3JlWFY1Q1YwaWdEZHBIa1dHYlJ4WU1jSFFvYTZW?=
 =?utf-8?B?Zk90MlJvYUllSldhdmtWekZzaHVZTDZpK1NHem5NUHpsNk1nMzZSWHlWUHJu?=
 =?utf-8?B?aVRBN3NKZHowenFjc2Ftd2JTcDN3WWRhMGpjYXU1QmZYWTZaY0VuWmZGQ1Uw?=
 =?utf-8?B?VDM4TEUwMG5zaHpIMlJxbVRYWUEwNXRIVzZ4d0FCNkFTM0NkZTI2SU1YQUJP?=
 =?utf-8?B?YURtcThsbVZIUk1ERUR6emt3OXlia1dzYlZPWHlaaUZmNWQrRFhsU1ZyUWxU?=
 =?utf-8?B?SEE1TzNuOTJiTmZnVks1UDNuc1dNelRZRXJCa3B1UlBIR0FYdzBKanJDdjZl?=
 =?utf-8?B?SHhyOFQzL2Q3RlpKRG5UVzNING4zWjVlVHBrWXFGaW1zZ212N2RzUEViMThk?=
 =?utf-8?B?UUVrWVFFZVlZanZIZXExaUdRZWZ0bUl3REF4bnRqUEl2cnNwVm5CSFZqV2Ns?=
 =?utf-8?B?c013T3d0SVlnNDRDTXo3WmxBMzJ2cVVtUnRFSWtBVkJ2NzFTYmF5d1NVbnN2?=
 =?utf-8?B?bis1M093UjdwZEVPSUJ1ZDAycUwxc3RGOWltbWdFQkptS3ZuZUVTbjl4MGVp?=
 =?utf-8?B?QkJLWExoMzVtczhzcHBwaFFVRkZaQVVWUGlDMGR6Y09OMG5xemRwSUpLd1J2?=
 =?utf-8?B?anNpdkV5TlJ1bWIycHpFS2JBVVFaeWtxdTlHQTZqSENpMGlkU3ExeGs4VVI4?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f251ebe-4751-49fc-ab29-08db195978d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:00:27.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42ZRMv1P+aZXG8hq4PrNMHZdiSL1M8LxI85AWvSkajtAZhLNcA0cWI2DeyypgbuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5418
X-Proofpoint-ORIG-GUID: BZL0LFPKIzgEJbTEtgeP6PllUccBud6g
X-Proofpoint-GUID: BZL0LFPKIzgEJbTEtgeP6PllUccBud6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_04,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/27/23 5:12 PM, Jose E. Marchesi wrote:
> 
> [Changes from V3:
> - Back to src_reg and dst_reg, since they denote register numbers
>    as opposed to the values stored in these registers.]
> 
> [Changes from V2:
> - Use src and dst consistently in the document.
> - Use a more graphical depiction of the 128-bit instruction.
> - Remove `Where:' fragment.
> - Clarify that unused bits are reserved and shall be zeroed.]
> 
> [Changes from V1:
> - Use rst literal blocks for figures.
> - Avoid using | in the basic instruction/pseudo instruction figure.
> - Rebased to today's bpf-next master branch.]
> 
> This patch modifies instruction-set.rst so it documents the encoding
> of BPF instructions in terms of how the bytes are stored (be it in an
> ELF file or as bytes in a memory buffer to be loaded into the kernel
> or some other BPF consumer) as opposed to how the instruction looks
> like once loaded.
> 
> This is hopefully easier to understand by implementors looking to
> generate and/or consume bytes conforming BPF instructions.
> 
> The patch also clarifies that the unused bytes in a pseudo-instruction
> shall be cleared with zeros.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>   Documentation/bpf/instruction-set.rst | 46 ++++++++++++++-------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 01802ed9b29b..f67a6677ae09 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
>   * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>     constant) value after the basic instruction for a total of 128 bits.
>   
> -The basic instruction encoding looks as follows for a little-endian processor,
> -where MSB and LSB mean the most significant bits and least significant bits,
> -respectively:
> +The fields conforming an encoded basic instruction are stored in the
> +following order::
>   
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   src_reg  dst_reg  opcode
> -=============  =======  =======  =======  ============
> +  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
> +  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
>   
>   **imm**
>     signed integer immediate value
> @@ -64,16 +60,17 @@ imm            offset   src_reg  dst_reg  opcode
>   **opcode**
>     operation to perform
>   
> -and as follows for a big-endian processor:
> +Note that the contents of multi-byte fields ('imm' and 'offset') are
> +stored using big-endian byte ordering in big-endian BPF and
> +little-endian byte ordering in little-endian BPF.
>   
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   dst_reg  src_reg  opcode
> -=============  =======  =======  =======  ============
> +For example::
>   
> -Multi-byte fields ('imm' and 'offset') are similarly stored in
> -the byte order of the processor.
> +  opcode                  offset imm          assembly
> +         src_reg dst_reg
> +  07     0       1        00 00  44 33 22 11  r1 += 0x11223344 // little
> +         dst_reg src_reg
> +  07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
>   
>   Note that most instructions do not use all of the fields.
>   Unused fields shall be cleared to zero.
> @@ -84,18 +81,23 @@ The 64 bits following the basic instruction contain a pseudo instruction
>   using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>   and imm containing the high 32 bits of the immediate value.
>   
> -=================  ==================
> -64 bits (MSB)      64 bits (LSB)
> -=================  ==================
> -basic instruction  pseudo instruction
> -=================  ==================
> +This is depicted in the following figure::
> +
> +        basic_instruction
> +  .-----------------------------.
> +  |                             |
> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32

regs:16 -> regs:8

> +                                  |              |
> +                                  '--------------'
> +                                 pseudo instruction
>   
>   Thus the 64-bit immediate value is constructed as follows:
>   
>     imm64 = (next_imm << 32) | imm
>   
>   where 'next_imm' refers to the imm value of the pseudo instruction
> -following the basic instruction.
> +following the basic instruction.  The unused bytes in the pseudo
> +instruction are reserved and shall be cleared to zero.
>   
>   Instruction classes
>   -------------------
