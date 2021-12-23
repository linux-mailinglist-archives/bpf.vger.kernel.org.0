Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD98D47DBFF
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 01:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhLWA1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 19:27:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10956 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230412AbhLWA1X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 19:27:23 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHx0c2010806;
        Wed, 22 Dec 2021 16:27:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wBndrxte696U3bh1+uJ3lB90bHeyOJYD8RhjQkKO7Xw=;
 b=p2RhsvrHVe2TB8zBRqpec0zLYP/M9xx5zgtspS/B8rd7CJTEdvYAPtrqLZfAhP9aN88Z
 xzt5rfauI1wsABNZnoQpoNe3BOW38emclNUo/fofUcsbcMSQMhz2R+v+CmgzQB/U/rdE
 Ps23y7GPFfX3vLQIV0bB+GE+lvJVc+EQfv0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d40wrng02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Dec 2021 16:27:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 16:26:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2w89CxpOzjgiWt3M6sJASmv4O8yxlOw+YBJ5SCBdHF7FWzV3kAnsDOTv9Tu8kXd/rlHBND0dzP07r/e/5+VBroqbwLMYiMm8wU2kruVtx4KqxXrBcEjoFWALYJKVTc0qxEyiKTm5n7O8ici487Xldq1N5/LWTdzYzCB0F0lMgguVd+TxgJXQgpdFShQRcOW+qw/U2auxV/v30DBIobeFLrBH6lYe3iBpcpQu7YO5j5NAxjbu6Nx87WTKcQhMAgOHpqtYC0J83QcmrSzdE/7HUjPm1yKrvCkQEQYwHUTpdaD9rMiS7I89TdaqgvR67TkBEPgu/oc7MfD0jFaIOOPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBndrxte696U3bh1+uJ3lB90bHeyOJYD8RhjQkKO7Xw=;
 b=S7yiR+tDRprFgWD6L/Mw1EV+51V2oRh38UI+UhgdN8fNzwH/kZ7B5gMtczRszHr21rrWEr66OafV9FfMV6qwGCG52P+Q8IMEIIH4zTmNUuUcimBlrofP+yEAUdg9k/iJq0DxoFkzPVaqEzGtiOA0pnCuCTIajmrQrWUnTJEuHjvW57PHq9H3lCUazuRhKjf+Wispx+Gp5ECKp4ZEaqgDIoumn2QFWm/OIsQZ1nI6ZeNH4yq+BiZ/L3PJUF2TOWIOjepU63R9ZW3aG9EPeo/E15qN3tStXvqvinMhcEFS4MMj23kMG2rw3VFHilh/czqF9CHB7bKoIh8vvNkMsxKFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4903.namprd15.prod.outlook.com (2603:10b6:806:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 00:26:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 00:26:57 +0000
Message-ID: <7527e408-80da-9e6f-46bf-931efc0582e2@fb.com>
Date:   Wed, 22 Dec 2021 16:26:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next 1/2] libbpf: normalize PT_REGS_xxx() macro
 definitions
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20211222213924.1869758-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211222213924.1869758-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 239949cb-a9bc-4f6f-c94c-08d9c5aaed16
X-MS-TrafficTypeDiagnostic: SA1PR15MB4903:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB490351B1F1336630709EB598D37E9@SA1PR15MB4903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFJFd6m+ft5VyGygA3f7ZeME4ZvtwRVhjORoZKVqs0n7OVSoB/nhlIoziR+Eck2ztBXsVDtWreLSoJDQ42mJHAQE2jfO+5pgJ3lf2yTrHp/CBK042ifQbla8eup1wD9ZnD5zf398BdaQwMGRdpJCZ09cXwy69gmP4PbvncGXJYZEoiYQwICJDc9rD6n4/KlH8omq8NCHkhRBs/0tgBTzS5/E9yHr+yq78xZayx+KfFumArarksh5vZjUM7qyU8G3cCQ7yhMxFRlAmtZpBQ6J/SQFmENxstF2vC+gTikKj8rsMk0bSJOLVrDZlES6hoIPJM56gvWxgmP9YmrLvruEnOnJmpsPqgmn4u7zNH2zabaDHx2/G1SRaeaLAaNv8H3gkyBFp7DYPkyj6eM0CG6Fo1ZMueAW3ZkmA6yzTtsVwZaSJfTnFScV94UjQY2Z5aH0tNPkGlAVe8ElrzzJDQuc3DnjZ0HBcdkDO6G1t2Lx1vObTOacuq91jDAjtmVBVTPO7hbW8N58O8wKFbhnX2bFKQnFU+98BGruIFb6ZErW2+VecKS+kFH/FwCL8cD6Z2V8qlu2iKc/hUwOBIygCncPhWvJmNDexnJvzZyUIcTQ2jLKNAb/eeUyJHSLaJ8O1uGeDKz+WfoCgJ2BlGrV0EWF/gVxLS+IMhWak2eP+bH+a3j1wpYgt36NeqynoMXai8zEhcGB9qLTzcab34etZNArbqN65j7T6r2rvjUx0Gr7jSFwd03M+bGuMTajrdAvFksS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(53546011)(316002)(52116002)(66476007)(6486002)(54906003)(38100700002)(86362001)(6666004)(186003)(2906002)(31696002)(66946007)(4326008)(66556008)(2616005)(36756003)(8676002)(8936002)(5660300002)(31686004)(6512007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRsQk5FSksyZnZEN0s5L2gwV0VCMGRzVHJYSjZGWnBSVGVnVVRjYllJNS9O?=
 =?utf-8?B?R09QZDVGVVQxeDJ1WUwzZG1INTNZRjRRSy9YaVNTSXo5c0YrR3dabXR4ajZL?=
 =?utf-8?B?SitCeVdVK2JnZjYwNUp3azJzUGdkdGoxZGZXOFM3SDZSVTZNUDM3RmJKbzdo?=
 =?utf-8?B?QzVVUFJLa3g3ejNtaE5DZk9OVHNHSWd3d053WVcrL1NkZVRQeGdFcXlPOTRv?=
 =?utf-8?B?aUd5K1Z0WkNWbm5TK3FKcFFEUFdLblAvUVRjckt4NU02VW9KYWdJaklSUHFz?=
 =?utf-8?B?Y0hDdG9tVndBVXVra1hxREg1SE9KUFhzTkg4TnkybG0rS0Y2bjNWTVhYSzls?=
 =?utf-8?B?NE53OHdBWEJET3B3S3h6TFVrY2pMSkdwckZkWUIwTTVBY05SVHF6WTljL1BK?=
 =?utf-8?B?UmJzanNDeDE4R215MmFQS3VMNG5yT0tOREExY2Fua1pBUHhzVHNTWWppVmlU?=
 =?utf-8?B?S0phQWZNeW0yc0FxeVd1czUzZVJGakQ0Ym5NVnZPNGNkaUx5R09wVXJnVkE4?=
 =?utf-8?B?N1o1OHhlVUp2VFQ3cmxMMEFyTW9jelZPRSt6Z3B0czd1NGdyVmZiNElKSGpr?=
 =?utf-8?B?dyszTTFOQ0pTUGYrTEpCbDcrY3d6RnBHR2JJVlBEa2RVcld3NG4zclBsdW43?=
 =?utf-8?B?RC9nb2pMOWdHWXRiUXIyRXNoeVlLb3podStQOWZmQ1BvOEoxRmpmRjZzaTFS?=
 =?utf-8?B?NVN3d3JNZXVNOC92enZIOFFGR1hIZ09tKzF3MXk2ajF3NEpvOTJFeHk2UTRP?=
 =?utf-8?B?b0pMc0p2V0F5ZVI5Vmcwa2lzOXlKdnVoTk9hUDdqekRjdW0xdEVxeXl2cUlT?=
 =?utf-8?B?NC9GZTRGZlNlM3lnUUJyTWVoWVdwamVsVmpJRm1pcGdLcWhFL2FUaXVwQ3dB?=
 =?utf-8?B?KzE0aFJZQU5oMkhXcFdUdGR1b01QS3h2aVNuVDl5L0ZYY0RxOXRQSTc1aDYy?=
 =?utf-8?B?eEdCS3FmcDZoWlV2VzJ5MXZxQ2hOL3QyYk83SDQ2Tzc5Nm8yR0ZwMTZTV25z?=
 =?utf-8?B?VERuR280T2hab3d2Rnp3K3Z0OUNCUks3a2lodHBWR1Y4M3lFRm9oZllmYk1X?=
 =?utf-8?B?YWhHQ05yZzRDdFRxQnlLaDhBNFloa0ZET3lJRmVac015Y3lkRE5CdTNZVEtO?=
 =?utf-8?B?YzB1VEpFZU1XV290NHJEdG1iaTFVVkhVbXBQQ2lDWEluVG9IN0VkUGhZODRH?=
 =?utf-8?B?ald3YU5FYzRYYXRDUmxsMmR2WXIydnhRdXJUUmdJMmtuWVVBdFZpeHV0QU13?=
 =?utf-8?B?RnRxdHF4cE1BNHExOXBQTG5QWmhLTE5sS2lmam1IQzZQNmdvTzBXTjRHdzc5?=
 =?utf-8?B?aEtFNmxucDBLV3VZT3ZuRzdWS1pUclAwZ1NoU0Y4dGZLdW1qSXlCNGFiMVJS?=
 =?utf-8?B?SnF4QUV6SHRjK1JXNERDQ0pZYVlVRXZKbVgvRjAxU0ZxTFBhM1FjNHJaY0xT?=
 =?utf-8?B?dk0wdUtRSFlXZ3I4UXNlMUNzQXpGRUZoamw4enZMR3o1TUpkWXlzNDM4VFQw?=
 =?utf-8?B?bVkvS1VFRGJoWFdCZ2h5Sk9TUFRFYk8yS1JDOUh6RFBCbHFnSXlZNWp2cUZq?=
 =?utf-8?B?eE5MZWNhZnIwckdIMjJoN1NTRjRhb09ITHU1QTlGdmg3V2Q3NVhCMWJZTUZP?=
 =?utf-8?B?THkzazhRZE03VStUR0o4YmlKZDhHS2wxZTlJWTlOc2hYMlFlUlJ2SDRFbzJh?=
 =?utf-8?B?bmZnTXlidUdLaHUzdm9FNGdCd05LS0IzeDdmOEFtcUpmb1J0cUU0UFp5MHhI?=
 =?utf-8?B?WDNpSmNDR2FxdEpDN3E2cXhieDdEZXdRTmdvWk5XK3g2STV0dUs5ektnbmJi?=
 =?utf-8?B?TnR6YWRCNWFKT1dHMUxZMnEzZDJzNTl2NityVDV4YjhYcmd0bFBxZkxQUmZP?=
 =?utf-8?B?aTNxeXJmSmR3eXN0N2xZSWdkSlJSdHlDK1B1YVpWVlkzdnFtZ2o3Z2FxNVhN?=
 =?utf-8?B?QzJ6SUt0dVdYR1hlaDJnWXMzWlNpellTWUlSK1U4bUtMaVJjWU8vRDlJM2Uv?=
 =?utf-8?B?MjRHTUpYSXlEeGZQQXlWcUM2VDdIZlplSUtSUkdaTnNTQ0E1QlZBNnZqNUN3?=
 =?utf-8?B?OWJkZFdRemFjU0twWWZtOGlFYmNjb3VYZmh1cTUyZ3FJNkVFTjY2MEhDYUpm?=
 =?utf-8?Q?/+9p7rkggZGr1dNkwndB01qP9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 239949cb-a9bc-4f6f-c94c-08d9c5aaed16
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 00:26:56.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+m9JhZqPmhwHto+jZQeMnEWchLhkvoxVt9dxkGBJbv4I5fMcHYr13DpKBFeKD+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4903
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JIfc45ctYLcztUfNLt6HTzqSh-lYS2tR
X-Proofpoint-ORIG-GUID: JIfc45ctYLcztUfNLt6HTzqSh-lYS2tR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112220125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/22/21 1:39 PM, Andrii Nakryiko wrote:
> Refactor PT_REGS macros definitions in  bpf_tracing.h to avoid excessive
> duplication. We currently have classic PT_REGS_xxx() and CO-RE-enabled
> PT_REGS_xxx_CORE(). We are about to add also _SYSCALL variants, which
> would require excessive copying of all the per-architecture definitions.
> 
> Instead, separate architecture-specific field/register names from the
> final macro that utilize them. That way for upcoming _SYSCALL variants
> we'll be able to just define x86_64 exception and otherwise have one
> common set of _SYSCALL macro definitions common for all architectures.
> 
> Cc: Kenta Tada <Kenta.Tada@sony.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I tried my best to compare old and new sources. Except "const volatile 
struct user_pt_regs *" becomes "const struct user_pt_regs *", I didn't
spot any other semantic differences. Agree that "volatile" is not really
needed here. So

Acked-by: Yonghong Song <yhs@fb.com>
