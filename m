Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55983DC0AD
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhG3WC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 18:02:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhG3WC6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 18:02:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UM0wEw004614;
        Fri, 30 Jul 2021 15:02:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SX5BO2rqAfpiVH/qJEDndcniXKB9K9fKt4Hs8QFpy/A=;
 b=WUS+GeN88suZKqy1hPeehRbtWUcaIefsVcnjorKmWTELAA9xCCn5/8SejgNdVjGIDKNr
 TqjNQ16Bd5sOtXjbs/+sywD2VlvosjV4T0g2FB6VGnwtDELcnpXZgijQGTf25jOd2c16
 Pa2igeAGh2nxBEFUvOdBKCI7uWVYmbrZbmo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a491ce5jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 15:02:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhxZ/E6aJv3/83/CwhUlmriecbQSQdbSLDw7IboGlYBPzw5clzBtxp4wGow3eNOtg5x6+4fGxzZmucG9NCIrPmoi5ArYFuH0aRKRLL+mBGXndpTsH9kapPNNMQBNmpM6g3ag9zkpk/Fd6+lMRFaNwuEZzbfnr/+1YcAcwbM4w8HoPGj0VDnPnRPBtQ7JFFVHI/0te0V5lQgp7NH+tuNhul9Ftf1WChz5B6OhTOnKV4yn3cUIoL/2uZ4g318DoQUHIbFMZ1Y4XceozVVWtl9yVAM1OPAbIPwJMdk7XL+VjBz7oym3sbUoVHyZCmxdzCTh6EEmOFLLbvpdEOEjXBurUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX5BO2rqAfpiVH/qJEDndcniXKB9K9fKt4Hs8QFpy/A=;
 b=U/kdo6d0+PCIi4stnxY7GvLxEg3Qwb7tJxQNLEaX2fgxH2dJonVT1LzMuz/yLoA1wY4enUk6W3djbTpCDYTwk02ioBAGcRDnc0hlZkQA2zyysYWfRCnhLn5Y23P57ARMWIpHpXCU+BRmJQV4St7pXTwrRw72WqOYRVbOLiISrqdFrRi/zPGmz4UgsJHLk9muRWHeeAPGcMul2Jyi0KKkZ8KbBONFEydsr0JhKX059V5l1e/2bi2GnaeP+P9YBctj5HLcJ6UPqi0XLSs/lOjsWl1lBqYZsSqe6V2MfjBeGuPYsNCl/d/jtS49cUQdLKmzPuj6cFlgAxplH1zc0284sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2127.namprd15.prod.outlook.com (2603:10b6:805:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 22:02:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 22:02:35 +0000
Subject: Re: [PATCH v3 bpf-next 05/14] bpf: allow to specify user-provided
 bpf_cookie for BPF perf links
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-6-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2cedfed1-2db8-31f5-b214-619701873dc0@fb.com>
Date:   Fri, 30 Jul 2021 15:02:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210730053413.1090371-6-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:890f) by SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 22:02:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f546ac75-3ac0-4834-4aa1-08d953a5bc8d
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21279347F07ABE390E5EFEF2D3EC9@SN6PR1501MB2127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJjOLk+3o3ZyiEMb74Ih+ETIrjGEeluxM6B8WGUncsncNQF8uTUlZtchZMsQtsVliMW3uKJ48U1I0+gQq8h6fWMRyJ8HQLbaP7V5m1OAayiIpN5ow74HPXDd02vYWLOZq9ZYgbN3eSfYvng8CymN0tFqh5WjfQQc/EyEkNurqjlFPWaxYvXldB+TsOU0tV6L1wms/eRc3Iq48oU8R4lQimEmrjqtvjZioSDFfRraOEMf56yY7bgFlVw9+f+s4H9to76jRDln6BxilP6iQS6tWKU+HbuECqSs4iOMxYyoghZ4YIBbuWIz6ANRiRtjmC8sLWLIJ8C413TvL/Lml7Z4c1p6okdQ6OVZCG8ggahB1egqPXZdQ2lVo2GSZSBUTOOwkLdd9xiF0QD0L8umGPn2p75uX48xceuJK97gUsao/l8lFy3BFexBepbt6Tfu+PexMgTW5gw3TeEWPLgONLgRYPq6tYgbOe/qmNJqNKUuscCYoL9AS9778aqPQdcV/J6LfgDb4sjLP9UmoGNVpNvjW0rabrjQcUAHXrvYVBkrZwAO7ZeuDjOOkmK9aR6AiP/BMXJJtaO2O4R2sf3Nu+dl9XwQWzSkKJACdjHDE91hSvF1c1SWzuWn1kuJfhSONKhmPyn4Zfs9ja6fhUVOU3HqDVxAI8BqYI4oAhlxkgnDhfDA77/tVc2uRBj9oQQOAMf8GqjGZjght+Q3+NFSGJnl5Y8sKQNXWpqER5B9Eotymp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(83380400001)(6486002)(86362001)(66556008)(53546011)(31696002)(52116002)(66946007)(478600001)(2906002)(5660300002)(8676002)(31686004)(36756003)(186003)(38100700002)(66476007)(316002)(8936002)(4326008)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pZWWlxRUM1OUFpajgzYXh3OFNxZWhxOVErdXdmeWl1eVk0dW1MelpNLzdo?=
 =?utf-8?B?T0MydXl2M3RLWXRYUHRFaWU2RFcrWWhCWmdJenVmR2RrWk0xb0VuU0pOci9O?=
 =?utf-8?B?MjVacVBVNGV1Y2VxUUtIVStNdFk1c0FIOVVydWxHeG95SWhObnFjbnhLVXhZ?=
 =?utf-8?B?Z3lSOEpESlpSd1QwL2xSeTNNcFNod3VjL0ZyY0hEMGVTcUVBN2kzNmdpMXpR?=
 =?utf-8?B?emxMc0ZMN0d0RXVsLzhzUUNuL0MzNkR6L1ZMaVAyY21mSHcrVDJzaU9CeFlP?=
 =?utf-8?B?M3YvL1VQZktoczB0a25XcDVyRVdyTVplSDhxZW92YmRkK04zQ24vM05VK3Vj?=
 =?utf-8?B?VUhucjVpbWc1elZ1UnVGdG1QOW1aanc5OFYrencyQzd1eWdIaCszbTR1RVFk?=
 =?utf-8?B?VmcrbGRReGZEeWlSL0ZDTVpxdWU5VU1SLzVZSHEzb2x4cEFUdmtpVHV2TzhP?=
 =?utf-8?B?akR0SzVIazBvZ0h2dU9tYnFTdkRXZGNERDZ1R2dpUlhFQ0lDNlI3MzZ4ckxI?=
 =?utf-8?B?T0QwRlBia09GMng4WEthRE85OHFMQ0tqTXpUVW1Ec3NNWFRVbDl5a0JmVTRZ?=
 =?utf-8?B?U1FYeU5PTTJlQy9pSmhaM05iejFUTVZudFBXRm1yWHdjZlZOUjFiZ1U3YXpz?=
 =?utf-8?B?NVQ2YkNic1c2aG9pUHlpMFlXREhHZGRrTHF6eFhaMVlFbWFsajJ1UUg0RmZp?=
 =?utf-8?B?ZzRvdGRuM1FmMmRFQXYwV0JGV0RVazBGNW04WGlRdHdFVlFUMTYzZjhrb2xi?=
 =?utf-8?B?OEkzTGVVdGczTldSWDlmRFAvUmQzQUZUV25NOHFtRFd2NHJvZEJUMkVWbnAr?=
 =?utf-8?B?Z3dFeHBxSUxOZ2xmNVNvam1FUk1RUzlTdWFtWVRITFA3akdqajJlOTZIbnRj?=
 =?utf-8?B?T1pXYlBqSFN2c2RsOVkrYkRDVmdiRmVsS2ZCeXFmaG1nMUtEVVFzNDNXN3Fw?=
 =?utf-8?B?ZE4zUTNrckVoWDYvTkpxVHBIZmFibEs5Rzh5QkprZzI3WFpGTktsTExhM2Vh?=
 =?utf-8?B?QlNWRWFkdk5KZHF0ZnJyS3lpOGQ4ZENDMGhoS0dTRmE5aGcydFNPRUhESGNE?=
 =?utf-8?B?YnVJdFJWa0JLeExZZkpHM3lEY0k5eXpCZGhGRWpZTlRoaGc4UFcxV0lidGxQ?=
 =?utf-8?B?VitRaGpucUdIcDdLSXpBRDlrL0Y3WThOYW1uZ1hBcWRaMTZLRGdDMDNZT0dV?=
 =?utf-8?B?OXlqQi9tQUtVbmpkclhNUHNiVnl3akhsS3hhWXFxeUlaeTY0UnhZeUpzeGsy?=
 =?utf-8?B?dysrQWFHZnd4WStLVmwrNmcrVGVTeFZoUnVQOG0zWGVJZzJtWldTOUo2QnFH?=
 =?utf-8?B?elJYcEl6Q05qR3hwUUR1cW9rbU1JaXNrUVdsb0JZNWdaMEN5UTVPcW5VNDJy?=
 =?utf-8?B?UmUvVmlEelFSU3lzWS9lL2RoSWVVVUF3RG1DS0c1UmxVcDVRN0FBUmdxcFVT?=
 =?utf-8?B?WCsvKytYT2pSYWdBcERXZVJyS0ZLRHhDTnpQZUNSMWlRZ3FzaUQ1QWttdXhF?=
 =?utf-8?B?MlpYUEM0cXNvQkVNRjlTaXg4MkEzZ1JHRDJlT3JneE5tODFyWW8wMDJZTmx5?=
 =?utf-8?B?eU9BbVBCdUFuclhwWEN0bmhCTkZldERxNEdqU2Rndmh3OVVMWVozZXM2NFhw?=
 =?utf-8?B?TU05dlcyeFl3cnVPUEhqWlN6ZXpjUm1XM3M2TW0zT0NXeW4xS0toUVlpZWhJ?=
 =?utf-8?B?ZE8xRXI3azVOUWROVWZ2MFZhVEVjYis1aDZNSTJxMlVWbXluaW5BUFZ0eHVj?=
 =?utf-8?B?K0FDdmtJLzhndnZmVlc2cUtCUFY2R2d6NmM1TithNXZ0dmZTa2p0RVkwVE8v?=
 =?utf-8?Q?pvzmBalE8vsrckfIu7ehWixMayZR/SfmYsvQg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f546ac75-3ac0-4834-4aa1-08d953a5bc8d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 22:02:34.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk7jESxA9CHmeEeoGrzNnBcFIgHeUr+0ebSfFGGAjMUGTWp1IZ6dWQdoGc5882p2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2127
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: PUaZd4Zb1BcwpekRH0Zd43DJZFqd9fbw
X-Proofpoint-GUID: PUaZd4Zb1BcwpekRH0Zd43DJZFqd9fbw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 10:34 PM, Andrii Nakryiko wrote:
> Add ability for users to specify custom u64 value (bpf_cookie) when creating
> BPF link for perf_event-backed BPF programs (kprobe/uprobe, perf_event,
> tracepoints).
> 
> This is useful for cases when the same BPF program is used for attaching and
> processing invocation of different tracepoints/kprobes/uprobes in a generic
> fashion, but such that each invocation is distinguished from each other (e.g.,
> BPF program can look up additional information associated with a specific
> kernel function without having to rely on function IP lookups). This enables
> new use cases to be implemented simply and efficiently that previously were
> possible only through code generation (and thus multiple instances of almost
> identical BPF program) or compilation at runtime (BCC-style) on target hosts
> (even more expensive resource-wise). For uprobes it is not even possible in
> some cases to know function IP before hand (e.g., when attaching to shared
> library without PID filtering, in which case base load address is not known
> for a library).
> 
> This is done by storing u64 bpf_cookie in struct bpf_prog_array_item,
> corresponding to each attached and run BPF program. Given cgroup BPF programs
> already use two 8-byte pointers for their needs and cgroup BPF programs don't
> have (yet?) support for bpf_cookie, reuse that space through union of
> cgroup_storage and new bpf_cookie field.
> 
> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> program execution code, which luckily is now also split from
> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> giving access to this user-provided cookie value from inside a BPF program.
> Generic perf_event BPF programs will access this value from perf_event itself
> through passed in BPF program context.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
