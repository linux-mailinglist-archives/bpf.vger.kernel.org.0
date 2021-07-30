Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCB3DBDA5
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhG3RY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 13:24:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhG3RY3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 13:24:29 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UHLMr9032443;
        Fri, 30 Jul 2021 10:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YfVZERBDOX3Ln3DyACGxYl/JLNhBd4OrFUNXghgXJrg=;
 b=mh1unfK2MaBhaCMjbaEjVFSe0Bz3+gyer3WS6U06Z5OFuPZGD6PBu3R4PsUVf2/LAU4g
 upn5DrxZfg3NPQLqfROXpqnXt49ra8BJdWUP8FxkqR4SYwWWeSvho5MD48D729mDhbDg
 yKN2wP2YWKSjUPOXNltWMuBJVr4hPbYdXEU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3vrthute-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 10:24:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 10:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXFv5J705Gx5lu8mf3BzMZAbUubOyhsohWNk8jnKzcwrGLSdZLkDPx1xESwKJ85Kh+5kzmyE3MuB4XNQwxmdwXeZX6Xk3gC3UfZoFuESG4WICLhzyIV0nfQzchYLpYtgno50hgOo6vKj1CXGU4PJvSwmkvqNynb82x4dlz5GAknm8xTcXa0Mrm3FuPB+67hdTtsSJecC3yH2gcWbcfhPlTe0eXoS6X4XZCZN3SG4fUvewYSUFDTLAzCjYxGONeGFvVYNMiUOjQVZ0x91TeucnoD8flJfuZKpqqUNE/72MwK/gyKl/QkWHu6N9qmRwOqS4soFwEaT6Uh8+phu/TkH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfVZERBDOX3Ln3DyACGxYl/JLNhBd4OrFUNXghgXJrg=;
 b=dgYJ4S4mAicvUUxoM83ABCuofGIuX5jm+VO+Rm/M8H46Ht/U5WuRK1HMWef8nKcb0SCCIw17NMCAxsRrH2wRAfZGj5RSHwKVkr2er/veIptBAYzvuzjx7NrCTSgnIl8xohXCFqqYpeT9MvCqJTVS833dnLwjJSOTxrPOy1HQx0QH2xk9ZTx5mSxUIyoRO+61CyIwWgqwarBRC35R3HUfl5vtMovdfKWVucR6FOSusRQdx1QDUt/itP27pI0UnXyn9FPU+4PZ+46qq0FmKkyi5n3IndXKMh2XozkCnxMwtHLYGYj/rdDIR5XAyll2EuJIZ/wApar57CTHxBFPwWYJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4032.namprd15.prod.outlook.com (2603:10b6:806:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 17:24:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 17:24:05 +0000
Subject: Re: [PATCH v3 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-5-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b8a64a6f-0924-4367-c574-1c3302999f94@fb.com>
Date:   Fri, 30 Jul 2021 10:24:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210730053413.1090371-5-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:ca99) by SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Fri, 30 Jul 2021 17:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60bf1f61-8f30-499c-d795-08d9537ed4e2
X-MS-TrafficTypeDiagnostic: SA0PR15MB4032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB403256A5879AE126DD01F0B9D3EC9@SA0PR15MB4032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0lrI9B1BSwTtu7sBC0n8U0oxnEviTEa9IAM/1w0ORKccgrHyVMn/d0TuxjHwrG9gyQxu74pFvNy5brhiQg9tsyL2qKeTgthxvWh5wh5mSrewqodD5J6H4Lpl87TPD6l3iqeKOxHVt9uOekcAGZN1Sl9diHvklUrQDwjHI+LXOLuQkfNLKm0B1ZhV1MPepXoTDzg6nGOwucgceeKEVxp4Yq0SZioWjl7I2aTbOin58YkmgSQuq5Wz+zGI7mfMB/S0TT/BL/YCq+qHRqSo1pTIPeWKzZ5Uk0VB6pWhVJGwtZzwbuwPgEAg5Tvc272EBCSsjHVif5oU5l+oJU2fon0zXnV+8roiqacpR1SvTJf1YnJPyEHBOX8ds2mdGKv6p9KU06k66aixGj2pI0bUHXoCNjmgg+8aKks8ZWs1kuTxbTfH9IerNLfdQuudade+41/UhjYI5qBvKYV7/zzOvf85+f5S9/LQX/UWF1nH7f2bageXncsf7BrzweIBxOiccNSX8mXbzheQcKKQjDc+DskFpFXm8pgUuQCKr3lk853113ujCG175/GIl4Gxo2vmG1cjvEna2O5XF01wf3gB4b/QdKFfEp7YTvUI0ZuHhyDMflYU2d0cDnsaNBuqwusFuWslbvY667aKk91f2fVxeGMEjjiQPmUbURRxRZntq/DDOV3RJFMW+onRS3JwMlOM/6SyYoU7PFBlyNWIzZnsDpwXRNGJXfV/0a7kXuEclWN8y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(8676002)(2616005)(8936002)(478600001)(31696002)(66946007)(186003)(31686004)(2906002)(52116002)(66476007)(66556008)(38100700002)(83380400001)(36756003)(53546011)(6486002)(4326008)(5660300002)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJoS3BwcENhaStNZDZnRkRTWFRpTTNDcHM4RGtKcUJLdTkya21jc3hrL3F6?=
 =?utf-8?B?Y3VBL1JTcTZWR2xPSjFZdVVzemJnN3Bqc1RNa2NodnlrY2YrVzFONGhQUVgw?=
 =?utf-8?B?RWx3T2VyQXlPVHlyWGlvN0lxVC9XUUN4N0tTaHB1R2tIa2xiZ0YwYzhqcU0w?=
 =?utf-8?B?OGQrc0luaVZ2eFFVWTNkcnV0UVowa3Y5U2cyOGNXc01XRWwwV0VkS1pXVmIy?=
 =?utf-8?B?MkRhVzYzb1NMWE1zNnF6T1NVWnhVOEpDZmlPQisvZlc4bzV0NkQwS0ZnYnJS?=
 =?utf-8?B?SmtmdlN6elZiejcvNTZrVjVvMExxRUljNEdQazZIcXVvQ2J5Z1hGYlloYm1w?=
 =?utf-8?B?U1NmbXVJdWRDRVI2R0NzNG4vQkVsbFg0TnBZYkh3bm1TdlF3RWRLWTlQYTBR?=
 =?utf-8?B?RkJoSUxSREpOZFF4Qks5bGdUamRoSklLTGFHdHRQblBoZmxGTGxwTXVkM2p3?=
 =?utf-8?B?OTJWT3FSWlA2dDgzYU14STRiZzBEVkpQQm9LVHBGWXBpMEU4VGx2a3VkQ2VK?=
 =?utf-8?B?MS81QlVzVUNrdFNJVXdvK2w0bnlQcXl1T0ZZTU9KQVgrSWp1aFNKS3N4bXZq?=
 =?utf-8?B?RGZDVHczT1lLRkprNFNncUVKYlVLcHlQNm4raUIwMm1OK3h2U3JWdDhuQ1Qr?=
 =?utf-8?B?QU9ZVGZ4aE5ZcFFrMVVXVjZMUUxSaFp5OThsb2FzMFZZenZjOTZCamQzbERo?=
 =?utf-8?B?V2NwQy9mMmwwTTFEZTVjV2FKeWFXZHBma2FKZHY0ZW13L2tFcnk1UjhWYkVv?=
 =?utf-8?B?OWVSU1NwZysxT2VlUVlpQm9IbitIOVJFL1RjcjIreFRkdjdpczNJS01oQWxY?=
 =?utf-8?B?L0lUcFEvRG1NVmN5UG5vK0VLWGlON29iRzI2eUI3UGVtVGwyMDgrWnphRUZB?=
 =?utf-8?B?ODBzR3RTQ3E0enNYaUt3OFM5MWdNbDBPazhZVU5JWFB0R3dRa1dLVWo5VHpt?=
 =?utf-8?B?eTNaNytRUDV2d01HaFQzZW1US3dHRUprVk1rVFFpUTRweXhBMnJYNXNHb0g4?=
 =?utf-8?B?SjZGZ01taGFpRWpzYURtQzJiZEFSbnVMQjdyc1A3b0ovK1hCeGdWYmVrU2Z1?=
 =?utf-8?B?RDRHUG11ZzdaYnZGTnFsZ1NHQiswVXR6Q1VOcUo4OVFRYjVmbmdjMEY1NlFx?=
 =?utf-8?B?bSt6b2VRc1E0SWFrU01CMllkUEpjSUpGTmNLV1ZHdVdWd0tnWS9KY21RSngv?=
 =?utf-8?B?YWR4RjE4YUZvWGJQVXk3N1JxczhUTk14bGdjRk5LcjhEZVY4bWNDd28wN1Ny?=
 =?utf-8?B?d2xrNlordnV0M1BWaSs3VXNtM0p2QWtNd2U5QW9ZSjNIQm5JQW1UL3J2SEJx?=
 =?utf-8?B?LzlTZWo5NGM1aG56NVZWNS9CR1YzcHQ3NGJFNDNCMmpCdlQvV3RWd0thZVJu?=
 =?utf-8?B?YjNUMW9ETnB5U3Y0ZjZrNXBTcm50SDRWWVRNZWVFVitNS2tnYzNSQUVIc0Zx?=
 =?utf-8?B?cDhYaDJCQWR2Zm0rUWN6Uk93eVk5c1NYU25GblIyUDhlbkFLMEw4ODNmWElE?=
 =?utf-8?B?SmFUbzNreS9OK0xJVDQ0bEk0S1ZZcU1tRHJYN1RuOHB6VzgzQ1puVVpXQkhQ?=
 =?utf-8?B?ZUpXK0cyZVlaNHVXcWlyZ29jWG82d0RCZHA5c2xtK3pPdDZaZjZZSlZTeHU2?=
 =?utf-8?B?Y1BGMEFzSm9OVWFzVXBaMC93V2h5MVNZV1VramNUYWFXbXlxYk1SQ0tFaHR4?=
 =?utf-8?B?SmtKZDh6aDRHMFdhUU96K0xFczlTalNxaDZGL1VFLzM5eUdJTjQ3OFYxVER1?=
 =?utf-8?B?U1RhdWdGRm9QYlZoejRqYVNRQ0Q5QXRJOXV5V1A3dHJUYTcwSWRqK2R1dmNs?=
 =?utf-8?Q?nl7IGv3uqF6F4qynNjoalcFtkkklaDyzGHy+w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bf1f61-8f30-499c-d795-08d9537ed4e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 17:24:05.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK/ibvUMavw2tHvTYx1P2bWVE9FH5BQbkUNlw5rRM4RxQLfeMZyEUv0PdqHheYEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4032
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: dv8oC5ohYK4DKWaRmoGK9WzpgA3sNvM8
X-Proofpoint-GUID: dv8oC5ohYK4DKWaRmoGK9WzpgA3sNvM8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=905 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 10:34 PM, Andrii Nakryiko wrote:
> Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
> BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
> the common BPF link infrastructure, allowing to list all active perf_event
> based attachments, auto-detaching BPF program from perf_event when link's FD
> is closed, get generic BPF link fdinfo/get_info functionality.
> 
> BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
> are currently supported.
> 
> Force-detaching and atomic BPF program updates are not yet implemented, but
> with perf_event-based BPF links we now have common framework for this without
> the need to extend ioctl()-based perf_event interface.
> 
> One interesting consideration is a new value for bpf_attach_type, which
> BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
> bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
> bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
> BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
> program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
> mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
> define a single BPF_PERF_EVENT attach type for all of them and adjust
> link_create()'s logic for checking correspondence between attach type and
> program type.
> 
> The alternative would be to define three new attach types (e.g., BPF_KPROBE,
> BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
> and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
> libbpf. I chose to not do this to avoid unnecessary proliferation of
> bpf_attach_type enum values and not have to deal with naming conflicts.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
