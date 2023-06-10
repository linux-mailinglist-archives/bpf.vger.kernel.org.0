Return-Path: <bpf+bounces-2304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0E72A8F0
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6B6281AC1
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9375398;
	Sat, 10 Jun 2023 03:52:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB191878
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:52:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C673AA8;
	Fri,  9 Jun 2023 20:52:42 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A3YZ9G009987;
	Fri, 9 Jun 2023 20:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=SlcdWGWRnqumDnLG+9jYjc8MfBK5+l3eZislf/A4+6E=;
 b=ARpBWA0H5rqEm/YUfNtm57Mo3uzWHbn9ys3iHTz3RJuldKOxY7dCuRPNrHl1ugRjqp0K
 uyCRnMUThRLUk82laWWdw3P2eiOYuhXp6smMSz8VFDe/7uaKKdHbraydDpfztzVyAV+j
 TsNwzXCm9azQ6sislr+w97rz/Sac3gBlX7q2lytbVh6F2ajb2AZW4+55HobKL3lw43+n
 W122tPr8VtBYJrnKegg36iN0xdARHtnyOOMZhfo/EGP2JWCT+U9eWHSyM7sv5I08Ex1S
 AqJIneWd/Byvt4X6dJVdR5LPr5Av+MrvJdp0t6rFmWdbm+1VoRASuW7HTqP754yE8l1W fg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r4b1uj9rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 20:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erBjf0rEwJhB3NbmsOF6iYMNKNG7MD5Ra/uwmBZmWluPbZGxI0+35o2Kgdc0K16cGSIFW9BD/9EV9+BRc8yCgMxNarnmnqfCCLn2IVSw3orwGGncUdpYwPhFL6Zn+AmBCceKnpjo96GXmwY1+UhT1HM4stPEsYmfZlc0Wgpl1rWv9pAIORkkdeI7mGnMVJVS+Y+YOVux8/+KFlTOHPuJe7O/Q3UbuZC1IQETlZxiDyFAMHrHTCFozpEna6PXA6IJtSU4PWklVhlniI+dRrKosQt9pSJHzJXMOrXXAjCR0pkdDIKfcfDTPh970jn57I8Nw09u9mFByQCLD6mvIrtjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlcdWGWRnqumDnLG+9jYjc8MfBK5+l3eZislf/A4+6E=;
 b=OBmf6uSX1vGazWUhCMVzWrUe3M5fp9Zc5RFPX4fgi1mNMk2hUMpjNFwPltjojEc/KjqbP+JXbBfGLKXBvhmNjR8rHBEHdxCwkXUyNU/dPQoH9DZh026DtW8at9MaHgBwsM4x45sNVZCnfUmR4oXAxfNNUNgLmKYpz1qRqkugLPo7AzWu3cE4H8+cBzYLHe/KQaIT7UDeCy2ZlhuUkFFHxLp0kLoqMVh238fkZRNMn7yIIYfNO+C/6f8iFyHFY01oFT77nPQjm3ujbtFQ0C08pizUEEfxTe8gy/Hffy+urqMCRV90i/73bIgZcWSIDSxffosNLLliTuFbmkeVe49CWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4527.namprd15.prod.outlook.com (2603:10b6:510:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 03:51:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:51:56 +0000
Message-ID: <68003017-5111-176a-de34-5d576b6e3488@meta.com>
Date: Fri, 9 Jun 2023 20:51:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v4 0/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: menglong8.dong@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230609095653.1406173-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: b0706b47-7142-4ff4-54f0-08db696608bf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ghqaz3b4eHTfkXJo9IINiV1n76OKrOZ5yMnwh45XFbeJyGxqBRWAnQCxj52PusL48y9AiBlAW08/6x1VQImiOCH0Jre67SKSqtqAZDJ+ZAZHWRBM4eBADad3xeYTvQ6C/KjEsQ6dhAzBV5QKqgV/C6B7bSwOS3ZQUae0ZoIo0hel0yoAWZryXbg7TfhpSUG+W5EPSkLtEPEKARj/PcOclw8ZquStqV2D0kwVZykP5cXn7/EkvCzKq8/uRyaqM1GCiAjlawUYd97ytu1WQpN0B7lA4fy/jJsLcBlxVCIItcPNWUzpX3U6a9vGN5lp6f8KCzGvZG1N5wiRdBI7rx0rx8jTnJ4eQf9FhfN8+xBM9uqchb25Fn662N43uAsoSfuFdv09zmuIRgJ6iSWXBI7CfyH96vxK9JjGhpiZsVVd+fs4XFAuL2LLCDLe8Ki5E1Q/jH4CE5K0934weiRqJhK+T6wZv+SDOGigA1MWv36OEK2rKs8wsGnQ2fcWqMFADhmQSU4vudUQD7nGRd/pE4a2uyTNjoSvNruWu3JRi+Or8sTLuEmU9ceua8pH9uRo3fqlaC3wGTA3/sGCQN1qXHv1Iv4JTV//gBuYg9j+1oSMdxuKRNWYEngmFhQKAU5wB77jFVvZ91cuL1SSDBu9znwUyw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(478600001)(8936002)(8676002)(41300700001)(36756003)(316002)(4326008)(38100700002)(66556008)(66946007)(66476007)(7416002)(6486002)(5660300002)(31696002)(86362001)(2616005)(6666004)(186003)(83380400001)(31686004)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vm1lZk9VclJZTitSSmF6U29GUEV0Ym5QOWZORjJkQ2RGbmEyM2tleUhkbktY?=
 =?utf-8?B?SjhPYkQwYTg0aWIyNmxMYmRrdkYzRVM1enBsakxXdzFKbHNuVFFHK1N4eEg4?=
 =?utf-8?B?QmNBeUNPaTNVanAzRDdkbkxhSUlmb2VzQ3crRWZQbHdQUGVrbUt1aG9iUTRR?=
 =?utf-8?B?Z0t0SUh5UUwwU3ZvRjArNUxRZlMwL21DbmFkMVJnN05pSFNMK3V1TDNrSEJn?=
 =?utf-8?B?cTEvc1lhNlBNUWhaWWZCRVpKRjJxRTFkdVpsY2hoN0hSaFV1cWVKUHRSNFpQ?=
 =?utf-8?B?dHRpWGVDMEl1S3hET0VvTFh1T2VBWTBuT2hZemRaR2xGTXQyTEVyV1dFZ1Ax?=
 =?utf-8?B?V2NEV3VuYXB4OWpnTzZPQ3JiV0cwMnB1K2R0REtzNDQ3ZExiRldQMDgvQ2VT?=
 =?utf-8?B?VlJoU2xrdjBpMlMwY2RlcUdtMEVjNEZ5L25yQmJUbythajl5SStSTnF6d0Iz?=
 =?utf-8?B?QllyVHNYUFRrekROS0tyeTNCZHllTEkrT0dqcnJtMzJvakMrN2VCMWY4SG9h?=
 =?utf-8?B?Y0R0NHBFL3g0OXFxZmpNSE1DeGtyVXFTckN4RUZVanBUKzV1OU1SVVE5Um9F?=
 =?utf-8?B?bitCa3praVdadjlXejROanFGT1crL3dvSmltMXR3aDFVYkNzRG83alBrdnRQ?=
 =?utf-8?B?NEkxUThDWWs2U1pReHpvamdRS1M3MEZLUDRSb01rZElDczVTVnhXMlZ1b24w?=
 =?utf-8?B?bS9LYStqK1R1S0dUd1dzUjNTYjVkaUdpQVlPTkRzMEM5Yk5Cc0xmUzMyK1o2?=
 =?utf-8?B?RjRDUkNsN3gvNTVzMXZwOWdVQW4wWENmV1NCYnhyNFBFSUJxU1NJV0hQM3V4?=
 =?utf-8?B?VG1jQkp3QVI3RjZtNFpWWEdBOFpjMUZaYkdSTG9VOXBlTXBzN0wyem1lcU5H?=
 =?utf-8?B?aWZVSHFvcHlpNGdsR3FidnYrQzBqZzF0Nmc4d1lpamE3dHUvNGk5SlpEbzN3?=
 =?utf-8?B?TnV2TEhwQ21FQ1ZCenBleDFHekxUaENsNlJBTmtTS3dtRHNaRUpVUnNMTjJ2?=
 =?utf-8?B?bnNrUjdpRGZUSmdnblo3ek9OQmVSc3p0MlJEZzJjemR5U0VwVzVnU2drUTI4?=
 =?utf-8?B?aXBiRzdRT3FmVktDWmhLUmF6Ny9jR3lFd1l1YzBsc2RlYjJDZUdOOCtHdFpE?=
 =?utf-8?B?bDZGblVvckZwODEyMnVoYitBeUhnaWY2WDI2bWErMHgwcWhuSEkxRXhEd1VD?=
 =?utf-8?B?STRWQzdFZ1VrVU40cmpkLzJBV1FhOGkxNG96bWlRSFl6QXV4N0dCcHgrRTl2?=
 =?utf-8?B?L1hvSWt1ZkszRitCaXo2RUZPRnFOd29iL3VuK0srMGFNdGdmZUdkS1pVdXRV?=
 =?utf-8?B?d21EQXdudFBQeHJ4YVpLUkpaWlVqaDJjOHBwTTdDVlNtMXZvSUtKZ052R0xw?=
 =?utf-8?B?WHVkeCtDZWVnZEhEVytkMFQ2V2dnMXVOTFZwaWVTTkh5Ri9aUSthaGNoMHla?=
 =?utf-8?B?c01wdDZvdmhNdVlMNk5GTXRLZFhOZlBMQUZ6NCtnZVJGblFJZ2NEQ08xalR2?=
 =?utf-8?B?TXJRaGo4Rm8wMlU2NDZZNzBJRW9pY3lKU0RoVXBVbnBqdG1pUFF6RW9uRlBO?=
 =?utf-8?B?Z3k3dWE4MzJ6V2dlVFdkcEZpNVdGczJzMzZwWk9EcTB5NUJkR1pzeUlGcHpj?=
 =?utf-8?B?UVZFV1h1cjYyRnRTNVNCNzljMlFEenFZcGhlKzJpNVF4QkF3SGFKNHV4Z2Vl?=
 =?utf-8?B?bWpKSXZGUmppK2VTeHNUOHJSMVZUWHBzNURYeHVubUo1L2RSU0Q5dWxaNXVx?=
 =?utf-8?B?VEQwdnMrWXFqNk1sT0x0RitiM240QzFvU3pUM0JBMHBJZDkvZVI4NnNxMUI4?=
 =?utf-8?B?N09FbldJcmpWUGFPVThiUnczczVHcVMxanNRNkFJNFRsN3l5UzhVQmM2WWNp?=
 =?utf-8?B?MXp5UmY0VnlOTWtROEpva3BIcjVvdEpucGw4TXkwcXZydGx1a0RLTlY1RjVy?=
 =?utf-8?B?K1ppYmw1Y1BDWUVlSy9CUHU1aUZubHBXTTRsRXI4VkFxbUJLY2dpeUI2Rk1I?=
 =?utf-8?B?cGo4alp0a1dXYXpSYVZLYXhLbHZLSmlHZlJZZWh0b2dtWEY0U1RFQUJ5NGZL?=
 =?utf-8?B?SVRxYXA0R2VPRjNqNFdsOEU4NWFwbVU4Si9LL1FsSktkUHdzdHQzNVAwdWRO?=
 =?utf-8?B?ZGxLdmRQNkxQUmhyY1ZTSjJwOFlvL2RDSGRzSTZtMHhzYTZzTVcvSFk0NmUr?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0706b47-7142-4ff4-54f0-08db696608bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:51:55.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMkNfNalimqcADHOTGXdYLlC3DutxDH6E5tM0Rl5q40GA+5kTuUMnEY8k7A2H7tU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4527
X-Proofpoint-ORIG-GUID: -aWrUyf0Y7sztTxzSh4KgacOCZe3eCLF
X-Proofpoint-GUID: -aWrUyf0Y7sztTxzSh4KgacOCZe3eCLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_01,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not
> friendly at all, as too many functions have arguments count more than 6.
> According to the current kernel version, below is a statistics of the
> function arguments count:
> 
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
> 
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> 
> In the 1st patch, we make arch_prepare_bpf_trampoline() support to copy
> function arguments in stack for x86 arch. Therefore, the maximum
> arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT.
> 
> In the 2nd patch, we clean garbage value in upper bytes of the trampoline
> when we store the arguments from regs or on-stack into stack.
> 
> And the 3rd patches are for the testcases of the 1st patch.
> 
> Changes since v3:
> - try make the stack pointer 16-byte aligned. Not sure if I'm right :)
> - introduce clean_garbage() to clean the grabage when argument count is 7
> - use different data type in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> 
> Changes since v2:
> - keep MAX_BPF_FUNC_ARGS still
> - clean garbage value in upper bytes in the 2nd patch
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>    bpf_testmod_fentry_test{7,12} meanwhile in the 3rd patch
> 
> Changes since v1:
> - change the maximun function arguments to 14 from 12
> - add testcases (Jiri Olsa)
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> 
> Menglong Dong (3):
>    bpf, x86: allow function arguments up to 12 for TRACING
>    bpf, x86: clean garbage value in the stack of trampoline
>    selftests/bpf: add testcase for FENTRY/FEXIT with 6+ arguments
> 
>   arch/x86/net/bpf_jit_comp.c                   | 145 ++++++++++++++++--
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 ++-
>   .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
>   .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
>   .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
>   .../testing/selftests/bpf/progs/fentry_test.c |  33 ++++
>   .../testing/selftests/bpf/progs/fexit_test.c  |  57 +++++++
>   7 files changed, 245 insertions(+), 17 deletions(-)

Also replace rebase on top of bpf-next. Patch 3 cannot be applied.

