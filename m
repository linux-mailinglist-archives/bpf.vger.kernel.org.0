Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7232053661D
	for <lists+bpf@lfdr.de>; Fri, 27 May 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbiE0QqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiE0QqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 12:46:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E89EAD1D
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 09:45:59 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RFAN6D012949;
        Fri, 27 May 2022 09:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+vvt5Wstke8eTrTCSowWzsMYUOtXpDOtT5f9iZQ12F4=;
 b=RTg0NKK1vFxjA9HY6hn+RM+KLCIF6NO9WrLi0giKkUEbOciwIB21AVu386AdzK2hlFHe
 Seq3aLsw8Pn7Ha+wCBkvLA/eHOe5zCiheVyF6VqXhsCqGIXWQop+izeBZFO5jgXSXJr0
 C2vrpAaYwzDAv/OWKorDZnZ0Yp9su51QKZk= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gaafu85c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 09:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7ZdVstVS9gUY99rjb3oUbgDrOxIKs22UmwfHTTrWEdCgv65aXPQPOq9tmgx4yc6dQW52s5vDS6qTlm7zV5RWhMHzVoOEpUhYpY6AI6km2NfZW9p0WwTjJ/5bZ7uHi8/mbs4f22Y+uofgUSSyHlUy2CnsRmho/dsPDJjfcKhkBmjwP3Q3bGSLfY6ZiJFRuIjWR5/BF8eF8Qgjnq2tJTBtNH4FA3AsPUtr3t7p4L4DJUJ/Up/uL5q4W/1TDUzp7zvugfnyHyJtnghryw8WZxdYXtWeuaiS+b3FuVawEECLcHiHAmPnjBxjBSMATfyhwjqFRWXXThMycuYf1Y2M1d++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vvt5Wstke8eTrTCSowWzsMYUOtXpDOtT5f9iZQ12F4=;
 b=H+uE1zVUdqtjZCeiplMtqpJd+NPnOFXg2kETNSIRlKc06TE40BsrQUTSfBYLfMlblt3KXM9xMw/HYKk1AZtJWjPS2pIZgrfurkLmmNcTuvpqoCHf9rXMTFDOrUqSPNj+efoKRzKrpzOJ098cE9hxIw2eJ97f6iMbhA/4tr3mGVQ3NYKgqFMg+MtroeCgBvcoVDoJBvB9laSSdPjuoFxbloZUALvm6VwPL2rN3Jr/2a3Xkk/D38hs2zGA4C9NOvabvoR795lKSueNGZvIMY1+q2aKn3RosncGuBdDCdCEtTNdCO3ZbxCsY9zGV0bsGetPt/ldbMUMGoNID9vPANm7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1356.namprd15.prod.outlook.com (2603:10b6:3:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 16:45:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 16:45:13 +0000
Message-ID: <73ec8d7e-07dc-fbc0-8a27-2a5b212b39d3@fb.com>
Date:   Fri, 27 May 2022 09:45:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: help to debug a kretprobe_dispatcher issue with 5.12
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
 <20220527210940.93c0ee60838ada827c177ada@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220527210940.93c0ee60838ada827c177ada@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21813124-4250-4a76-81cc-08da40004576
X-MS-TrafficTypeDiagnostic: DM5PR15MB1356:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB135625425E366076B4D3890CD3D89@DM5PR15MB1356.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtoCrBJdJX068bgmMxP5C/eo6H5fEKRZ3PNfhwjAZriUo+vKMI/RIqvvahdsyIK2bhFpA/y8huf1/Urdq3ONxbtueoSbu4ywCfpTdig0zXQactoSzkMGEX7QIhHPsm2hOSgNlDM0FaBD0R9WY/YiWGKj6271t196FNy7ssT/JSVS56a1J9H+etWrRPJJ2/GzuOL1xsxM8TyJ+esWtyjHfUwud23wrbBAninlU7VJIFb8HHzFOwAibgWP3EAVq9YmZyVOldYhx+iVNbtrmOh748XYDcG25HBK8B8GKNEzloYYhKrOMeTNrdYCwa7iE5riz3YmYAG0p/ROLMDVmaSubZbEK9c5dK9/ac8jTD1ETV0oXGeT8Jyv6N861feeBCTe6eR5pKA0FIRD6R6CepY3m/UFn6KtK1i0Bznz4JoL8BV1C350awhPmcSrkzQuDlPXKuAVnYmQW5GoTHRZ/mv/ZgDlmT0mRGBCitYvWawWBGg+6Jr5Mdwf4NFQYzEp+oHA0VDKBjardCpLu9d8anxrG3QNydGCBLU1iQ1p6b9TcP2112xGKXJosuw8E4ixTnkBqrlJWPkXtQxlUospRVqI/XlGMf/6q49+exjtyeZs6SIkH8rhnB7IlseC8ckQwwlFvbTMxHxbeIdfPHlzhsx4EjWq4qowTFVOpQbcImoRjWoY4co+Kd7haq3ncwT/pOEfPodPaPdk3sHFIzc6NLfk4JdeWozDAm9KEuvbfWjiMcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(4326008)(8676002)(86362001)(31696002)(186003)(316002)(6486002)(38100700002)(2906002)(508600001)(36756003)(2616005)(54906003)(8936002)(31686004)(6916009)(6512007)(5660300002)(66946007)(66476007)(66556008)(52116002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJGRXVDbkRTT1BGSG5jckN3bDBFaUp2N0E5eTVUbExaRlFRb1U5YmYybGls?=
 =?utf-8?B?Sy9qUkZ4ZkpROU9GRXpEeVQydlBVdWorWGVHNlNhZUZlc0xEdUF6WHEwUHhq?=
 =?utf-8?B?RkVNS3kvV1NDSDc0VzdsNk9TYUVWK1hlSllsWWpnZ2hvc2FHaXdseTF1N1Vv?=
 =?utf-8?B?eGRVQ1Jhem0yalVJcUVDOEZ2RXRTS3lRdjdwRlJSY3RzRTU5c0dDeFk1TUxm?=
 =?utf-8?B?QVVmUTlsbDV3RW16eTNvd0NpN2lhQ0w2SG5SSVpvVmZpcUFibThmUFJpcXF1?=
 =?utf-8?B?RmRTdkNNRDhYdk5reVBOdFNSay9QcmNJM013SG9RMU9vTUZaUld2N292bjVG?=
 =?utf-8?B?czdRUXZMa1JEeUVzVXFwNndLTk1yQ1F0UUNzZ2FTUlQ4ZGl0cFRIdXhzQUly?=
 =?utf-8?B?ajRNOXJwTU8yRlZMa0xNdTRIVk5ZQXZRd3pzQnByNlpmaVdUTXY3Y1lhK3lQ?=
 =?utf-8?B?QmJKeDhtY2R1M0J5RUpMbGVrNmZBaFFDOUplWnVMTFhmWUhxcXZVMTVuMHFP?=
 =?utf-8?B?MXpNbmJWZ0hMTTRlQjViQ0ZTM0QycjBKQ1R1K3dsU1k3cHdoOENYZDBUYytt?=
 =?utf-8?B?SldIYTExYnpuNUJxUDg4RFZnQzEzeStPcllpeE5zcmhLL001QXZIZ0FxMlBv?=
 =?utf-8?B?QTdERTNSUEVDOGZLcjd3b25YMjNTZlIwL3pteDEzbXRTdUN0SkJHeFJtcW0x?=
 =?utf-8?B?VVJWcTNoTkRSTVNkL2VmVGpRL2NIRGpueE9URk5ZQy9jWFdJeFBxYVd6aFB6?=
 =?utf-8?B?bC9KbkdyQkZKMkdBcDUvSnh4OUtJdTRjcnNjazdyRkhsY3BZckJoU2VhR1ZF?=
 =?utf-8?B?Rm95RFpoZjV4MnRMazllY1RZeUxyZWFKTUd4M1ZtSHRGRUJhTEwrbk5zWWFy?=
 =?utf-8?B?YTR2ZkJ4SnBjTDJiT1Nicm9XL1p1WUszejlGa0ROYU8xTUF6bEFqSDVnZ21a?=
 =?utf-8?B?WnJpY2xnSXNUWHFRRE5KMWhGSFFObnhNTmJuTGlrZmpVaWVGSUZYWEQ5Vlhy?=
 =?utf-8?B?czgxa1FhRy9YVisvak1UaE1odWJZazdUQmxuQTFPelJjMGdzb1JDeWRQekpH?=
 =?utf-8?B?ME41emU3SGxJMm1JRG9hRW9nRGV0c0E3Ujk1ekZHYUZMM1JvT3ZmNTRZcFRI?=
 =?utf-8?B?VnVtc3crdDFuMUNrOVVvQnJvbVVqV3JnaVNCVzdTTGdEalVqRlhTME96SXZn?=
 =?utf-8?B?TERTdGN1THJEeFpFbTNhenZkUEt1RmdJQlFkUGk5Y0FUM2hNdmV5L1AwOFVl?=
 =?utf-8?B?YzNXbGxCcm9sNFR2dUxyOXV0bTY4WVZPME5BdGFHa080dVlNb3B2ZFlPcTZD?=
 =?utf-8?B?MlBOYjZRZlI5enVhWTF0UTVTR0lqeG5vRk5adVkyeTRWR2JobVlZcG56WmNF?=
 =?utf-8?B?d2RPaGhaU2pPelFDY1o0WWE3YWFCQ054S1JDMnArQzdhY0VsdXhHT1R2ZW5K?=
 =?utf-8?B?aHUvQXg5d29uNDRmMndRM29ic3ZXOXNOMDlXYWdiT0Q3SUJBbUVYeG1iUVRv?=
 =?utf-8?B?djdxWE9kN2pCMTl6SmRyMnZXSFhYcUVEeEdsQ0hQM0ZVV2d4ODE0WWdpVEho?=
 =?utf-8?B?TUFyT24vS1ZTY3ZFQzcvL0lGYkIvWUYyVzBMK05CUjdxdW1SUWZVT2V6cmtI?=
 =?utf-8?B?Vm9HWHBaUjNwQ1dxYVo0T2dleWpMT281RU1OQXBSWUJ3WHBiSDdDam9GRFRM?=
 =?utf-8?B?U3dBOGQ5VnpJTzFWMDFHelFFU3dGZGJEdzg0amVMbTVhTHR0OXdMMHRGVS9C?=
 =?utf-8?B?SjJ6T3hTTXNPekkydnFlUGQxMkxvRzdpcm1IcVZYTi9waERIdno4NEF3cXpV?=
 =?utf-8?B?NXgxZnpDYThSRHN4MVNIbFdTNExxaUdySTgxUjR5Z2ljcytncGdFS1U1alVn?=
 =?utf-8?B?RUJrK0ZIaDB5MHNiMmpFMlF3SjdCbm1ad2U4SDRUZXd0NlF6VDNQY2p6Zy9D?=
 =?utf-8?B?L0ZPRUhpbE5vU29ZSFIyU0M4Nzlna1YycVUxWHhuSStuVUIzV3hOdGx1NzZz?=
 =?utf-8?B?VGE4Z3JXTXpnMDFIYWJmZG9Ma1lRV3VhSU1ZSGlvNmgxRHBXK0JIRFpVeTcv?=
 =?utf-8?B?OHI2NCtJMjNwQUpuK3hEbmJNK0pudXpiMHExSXFMd3l3RTU1ajBvVTlnanlU?=
 =?utf-8?B?RlJjMWlpRlNHMm42NzJ0ZzNWWm1UL3dNZWxSQUU1RElDR25JYXlzT3RTaTAw?=
 =?utf-8?B?VnlOWXRQOTNiZTJlU0JoNk11TGNqK0JPa1BmMTFkMm5KbFNBdEFEaHZrN2l4?=
 =?utf-8?B?ZE5DejhybHVuZjgzUW1mRlAzRzZoTXZXRXYwaHJUY1hVZzNJZHk5ZXg5QVdK?=
 =?utf-8?B?YXlkM0hCbDZnWWUrWER2UFdSaklneFVaTVh6c3lwTnRjaVpNSzhIVXBqWTc3?=
 =?utf-8?Q?WZcKc3kSZ8p8UlHU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21813124-4250-4a76-81cc-08da40004576
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 16:45:13.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFoKdtLEfNEmq/8hMIOLj+EHVomd7ecXVuYZCkDQcwt2LzLEeiG14DF4dpIL6jgh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1356
X-Proofpoint-GUID: -2DRJKvD3d9pXVkT47pEYSGmyPG1o4zQ
X-Proofpoint-ORIG-GUID: -2DRJKvD3d9pXVkT47pEYSGmyPG1o4zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_05,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/27/22 5:09 AM, Masami Hiramatsu (Google) wrote:
> On Thu, 26 May 2022 12:48:41 -0700
> Yonghong Song <yhs@fb.com> wrote:
> 
>> Hi, Masami,
>>
>> In our production servers, with 5.12, we hit an oops like below:
>>
>> Backtrace:
>> #0  kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1744:2)
>> #1  __kretprobe_trampoline_handler (kernel/kprobes.c:1960:4)
>> #2  kretprobe_trampoline_handler (include/linux/kprobes.h:219:8)
>> #3  trampoline_handler (arch/x86/kernel/kprobes/core.c:846:2)
>> #4  __kretprobe_trampoline+0x2a/0x4b
>> #5  0xffffffff810c91e0
>> Dmesg:
>> ...
>> [1435716.133501] BUG: kernel NULL pointer dereference, address:
>> 00000000000000a0
>> [1435716.147783] #PF: supervisor read access in kernel mode
>> [1435716.158411] #PF: error_code(0x0000) - not-present page
>> [1435716.169039] PGD 6df216067 P4D 6df216067 PUD 6aad80067 PMD 0
>> [1435716.180714] Oops: 0000 [#1] SMP
>> [1435716.187343] CPU: 19 PID: 3139400 Comm: tupperware-agen Kdump:
>> loaded Tainted: G S         O  K   5.12.0-0_fbk5_clang_4818_g9939bf8c1268 #1
>> [1435716.212570] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive
>> MP, BIOS YMM16 05/24/2021
>> [1435716.229803] RIP: 0010:kretprobe_dispatcher+0x16/0x70
>> [1435716.240089] Code: b5 3d 00 48 8b 83 d8 00 00 00 8b 00 eb d8 31 c0
>> 5b 41 5e c3 41 57 41 56 53 49 89 f6 48 89 fb 48 8b 47 18 48 8b 00 4c 8d
>> 78 e8 <48> 8b 88 a0 00 00 00 65 48 ff 01 48 8b 80 c0 00 00 00 8b 00 a8 01
>> [1435716.278001] RSP: 0018:ffffc90001d77db8 EFLAGS: 00010286
>> [1435716.288797] RAX: 0000000000000000 RBX: ffff8884b586fa00 RCX:
>> 0000000000000000
>> [1435716.303416] RDX: 0000000000000001 RSI: ffffc90001d77e30 RDI:
>> ffff8884b586fa00
>> [1435716.318037] RBP: ffff8884b586fa10 R08: 0000000000000078 R09:
>> ffff888450a944b0
>> [1435716.332659] R10: 0000000000000013 R11: ffffffff82c56d38 R12:
>> ffff888765e5ae00
>> [1435716.347278] R13: ffff8884b586fa10 R14: ffffc90001d77e30 R15:
>> ffffffffffffffe8
>> [1435716.361896] FS:  00007f3897afd700(0000) GS:ffff88885fcc0000(0000)
>> knlGS:0000000000000000
>> [1435716.378427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [1435716.390264] CR2: 00000000000000a0 CR3: 0000000674c5f003 CR4:
>> 00000000007706e0
>> [1435716.404882] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [1435716.419502] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [1435716.434121] PKRU: 55555554
>> [1435716.439876] Call Trace:
>>
>> Our 5.12 is not exactly the upstream stable 5.12, which contains some
>> additional backport. But I checked kernel/trace, kernel/events and
>> arch/x86 directory, we didn't add any major changes except some bpf
>> changes which I think should not trigger the above oops.
>>
>> Further code analysis (through checking asm codes) find the issue
>> is below:
>>
>> static nokprobe_inline struct kretprobe *get_kretprobe(struct
>> kretprobe_instance *ri)
>> {
>>           RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
>>                   "Kretprobe is accessed from instance under preemptive
>> context");
>>
>>           return READ_ONCE(ri->rph->rp);
>> }
>>
>> static int
>> kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
>> {
>>           struct kretprobe *rp = get_kretprobe(ri);
>>               <=== rp is a NULL pointer here
>>           struct trace_kprobe *tk = container_of(rp, struct trace_kprobe,
>> rp);
>>
>>           raw_cpu_inc(*tk->nhit);
>>           ...
>> }
>>
>> It looks like 'rp' is a NULL pointer at the time of failure. And the
>> only places I found 'rp' could be NULL is in unregister_kretprobes.
>>
>> void unregister_kretprobes(struct kretprobe **rps, int num)
>> {
>>           int i;
>>
>>           if (num <= 0)
>>                   return;
>>           mutex_lock(&kprobe_mutex);
>>           for (i = 0; i < num; i++) {
>>                   if (__unregister_kprobe_top(&rps[i]->kp) < 0)
>>                           rps[i]->kp.addr = NULL;
>>                   rps[i]->rph->rp = NULL;
>>           }
>>           mutex_unlock(&kprobe_mutex);
>>           ...
>> }
>>
>> So I suspect there is a race condition between kretprobe_dispatcher()
>> (or higher level kretprobe_trampoline_handler()) and
>> unregister_kretprobes(). I looked at kernel/trace code and had not
>> found an obvious race yet. I will continue to check.
>> But at the same time, I would like to seek some expert advice to see
>> whether you are aware of any potential issues in 5.12 or not and where
>> are possible places I should focus on to add debug codes for experiments.
> 
> Thanks for reporting! Yes, it could happen.
> 
> __kretprobe_trampoline_handler() checks that the get_kretprobe(ri) returns
> not NULL, but since that is not locked, it is possible to be NULL afterwards.
> I think this has been introduced when we make kretprobe lockless. I think
> this is not a bug but a specification change (all kretprobe handler must
> check the return value of get_kretprobe(ri) or get kretprobe from current
> kprobe.) Anyway, trace_kprobe.c should be updated to solve this issue.
> 
> 	CPU0					CPU1
> 
> __kretprobe_trampoline_handler()
> 	rp = get_kretprobe(ri);
> ...						unregister_kretprobe()
> 	rp->handler(ri, regs);		rps[i]->rph->rp = NULL;
> -> kretprobe_dispatcher()
> 	rp = get_kretprobe(ri)

In __kretprobe_trampoline_handler, I see:

                 rp = get_kretprobe(ri);
                 if (rp && rp->handler) {
                         struct kprobe *prev = kprobe_running();

                         __this_cpu_write(current_kprobe, &rp->kp);
                         ri->ret_addr = correct_ret_addr;
                         rp->handler(ri, regs);
                         __this_cpu_write(current_kprobe, prev);
                 }

So it is possible get_kretprobe(ri) could be NULL. But it may not
be NULL at that point, but may become NULL inside kretprobe_dispatcher() 
due to the above race.

Thanks for analysis. I am looking forward to the patch to solve
this problem.

> 
> 
> Thank you,
> 
> 
