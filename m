Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A343DC0D5
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhG3WN2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 18:13:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhG3WNZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 18:13:25 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UM9Sv6001058;
        Fri, 30 Jul 2021 15:13:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d42rCPAZ8U6PNlE07hKRLwBfUx6U/Klu3z3wPk0rK/w=;
 b=Dadp6/lF1UpvBHWn55NK4FCadoQQuwYxmUtAttKLQEt4GQxF5mg23hszKHZ7PMTFNhVk
 /VRYM3lWJprRtLOs29WufztGkERMRWft9qFN1NmZKOqD81mBvs5sCaTleAoQT86U+atR
 eSL73NW/4VLQNqxdk5twdwDTwHseFF87McU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a4bp05cmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 15:13:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXFBibmFKFQQRlX2Pwc0YtzPevR5ULekjdtgy3dkaelGReant59fhKSrHOFHvCsINXdpWNXpiMYDH0Vob4ToFUwQ3wogrLztgUli8/GSgDfvOf7p0lhITqLKAbQR0/TQGnYomWdVJMxD8NXt78zXPcYqIjCZgI9vg3QeOeimlgoxB40Z5Wlyv1t+hvLGXytp5NiAmwz4SQlZqpVgim2axhhUc102hW1e3X79OG7ELYDF/FZ82ExxyQkkWV917v7gH8aWjiaq45G2Ic7IRtt29isVTmjWvDkLdujy6WczX6pGkpWvFRyXlnh5Me7D3AJ3Icpdv1DdzQIY5Ab7l0vk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d42rCPAZ8U6PNlE07hKRLwBfUx6U/Klu3z3wPk0rK/w=;
 b=nI8a5+yP4c0zU3cw0UQcIRgCBu1uFri5hSWCRk/uZjLeuNCE7MlUTn4tblzRwK+obY6DL86uO6Xjcda6JomKleOYkePHfzWTRMzu6aPZnsDVn/R5CTY//YS8TILf42lrhLewO4bbrV4GVmfGrQGBviVNCzpQ0Gb1dFrWMJozqMMsF9/uIc0gPiuy5mPhYs5Yr+GkCnFvxq8MQ+jitzcjrp5SnzG+pBOIIAxpQalQ57c9fxqNfXM5nIeB8LAIjJTjaXTQbhcgFHhwuEAQN6GcEnUjqCObhzMxnnhwtCGA1Mc064wLy8K6juYZ/yCcdRHAt65uOScS2Ag+oLYhQTPwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 22:13:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 22:13:04 +0000
Subject: Re: [PATCH v3 bpf-next 06/14] bpf: add bpf_get_attach_cookie() BPF
 helper to access bpf_cookie value
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-7-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2287af66-daeb-4017-276b-41a819f647a5@fb.com>
Date:   Fri, 30 Jul 2021 15:13:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210730053413.1090371-7-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:890f) by SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 22:13:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebdef56f-e143-4d99-f571-08d953a7337f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB43393AA9CDDCC235B5B521A3D3EC9@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /E0nJuwBKxHi0SB4S425NMXITZ3kXwqbblWDZ7LiAun1j87tjRqeeY+etipwOXMW7ZpsnhWrs1ZjCKI0OHSKphHx5lJnxkJiZYXW2huLF5ucwqHXdl3L0ZIl/hzLZK193FAcSbfAjEySLe5xAAu2Ys2VnB9ewlSemS7LwhJjnVdMaIuJI+Dd0D0YsAV2648um/CmKcBRwr1wflToaGofx2dlhNSDy5O0a/5u+QsOji+TR9fNEAoDroCpekfk3e43FOH1m+A3okP8dQtiUFpFOVfJMDt7+8FGqot2yBevVuhGUnYuYPIQ8fyvLkfrIwOvYI0IpkNFbvEMrfjzZMwYQ74r1uSdaFmIqjD/R4Wpz+JK6u7tnUVSb0oPaW9KYugpmFsr92GIQ5inhzpP6h74l7GL4yqY1bgjl46PCxfGT+BmXO4Sx5Nfa5leM8F/ATOJZ0AGk1nltRDvp8zxawMJ3g1d4oxmfxboQ5lVW1xDJ0UuSIo+cOySkmMttTZnThElSNfOlfcRYnMZRrZ7swkYSLMXFCh4CK2znoeNqLaQ4cjkJmyCAJwfno+oVmXIyo/pubFANQ1Tg4uFZIU1k1+UURRzbiOEznzZDXmzTP8XLfORjhZtCofUzrnowM7E6y55ZYqfyDCq029kOsNY6H3vViGAvNJC2/dXdnnS5OFjpgchBd0DcxInqFWbSp+DdOLzSZafqHnwxGz6m0RTOUearePu6HNiQuu2iN2XoNKFzck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(5660300002)(38100700002)(86362001)(31696002)(478600001)(2616005)(8936002)(316002)(52116002)(83380400001)(2906002)(31686004)(186003)(4326008)(53546011)(6486002)(66946007)(36756003)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhlVGsyaFZjeHhKbUxOM1YzK1hxN0hiZ2cyYzVHYWcwYXp0THZnZmd4bFlw?=
 =?utf-8?B?enZ5ZHM1RjkwSHRWWFQwdUtEOHJsUC9JVDlNNEdxTXp4MzZTeU0zbUhnT1dV?=
 =?utf-8?B?U2JNOXQrUy9LeFREYVZwbmN3cGpldXhGd1dsS2FpRG9pNWpRUiswd2xDVzhw?=
 =?utf-8?B?c3E3ZWh4TlZDcEtqOWxUM0lXcHNmaWFjTktuS2FOcmJ5dkVFaWhreGJpblF6?=
 =?utf-8?B?b0hGeWZhdHlXUCswNFFnN0wrcVFaR2NzeUk2YnNsVjVoVkJ5QTMxM2Y5cU4r?=
 =?utf-8?B?Ry9hWmJlVTRyaTFsbHlGTW1VTUlya3JyelJrNDFza09wd21BNDNNb2hsNjhZ?=
 =?utf-8?B?NXVFU1JncnA3dXc0NWdyY0t2eTFqMEh5dS8rSWtmdVZDMHBLUnZnWUNFNHlh?=
 =?utf-8?B?MXdzbEYzVndyMDBYVHR2djRVNHdBT2NtdVhzTGxMaU5hQmJFWGY5dzd6MzBM?=
 =?utf-8?B?ODhTNmZqUnVZM2dRdWxvdzRYWEhkdzU0TkxseVkreUlEV2hxS0N5Qkhrd2hO?=
 =?utf-8?B?V0dFWkhpZjV0b095NHMrbEFubk5xMGhGMmRBMmpyQmozMjQrcFRjUnF0a3Zm?=
 =?utf-8?B?VEIyZElmTUJsTXJBdW40cGNLbjlIWktYMlVWRzNydDJoWEdzSTRDdTJOM2oy?=
 =?utf-8?B?dTIxSmVmdXczVHpRVi92U0wzSHJZbnlqV0J3V3NQb1dMWi9FNlE4ZmRTSWxj?=
 =?utf-8?B?by9EL0FrVVU2dVFlWFhFenBNOXhRZDlPQ01mVm5Kak1sMW1zMWpUbDQ2NXE3?=
 =?utf-8?B?ZDl3T2NQcmNEV1FydUNIbjVrVGxsWmlqVVd3ZW1HUStsTTJGWksvdEEyaWpa?=
 =?utf-8?B?L3ZDMkN0bTJrd3luSHZ3UGg5eGl6bkxEaXdFTDB0TEtjWEF1bmhuVXY4Zkpu?=
 =?utf-8?B?elNtcTk1TDNabURFeTdXL3dTYUcwWi9JU3oyb0tsY2x1aHdnL3lyMWt1SHF3?=
 =?utf-8?B?T1orYU5uNkQxcTM3VjZ0cEZBWnRmemMwaFpjVjhXbXIwNHlHWnZQeFJRWWNr?=
 =?utf-8?B?RzdSektmeWxHKy80NHVNakxtYUh3dU1jdktkTEo5WEVVRm01VG0xMUErWjlv?=
 =?utf-8?B?Y2xvc2tBK1lMU29Td2VnaE9yOGtsS0V4UFVtTDlFWmVrS0hYWjhQY1RBN3Nz?=
 =?utf-8?B?aGpZWDR2MzJWYWJlZFNIaVV2bnZKeEYxbW9GQSt1Yk55MmI2Q3drZTJGNmdH?=
 =?utf-8?B?QmZrbGovRWUrV05uY3JQNFpkRkl5dm5HckYwY1JrR0N0L3JEcGYvZ3NsUCt0?=
 =?utf-8?B?S2piK0hwMjVhRE1RMDFXdW5wWlhYd0hFaUU0Vld0RzVlcmJ3dmkzS29SU3dJ?=
 =?utf-8?B?bGEzR2d2M0hCMDE2VnlGYkZadEJsV3l2ZE1wSWRsOFZvZzFuMmlGL1lkSHBv?=
 =?utf-8?B?S1NUY1liSW8rdTY1cmUzSzR3QnR4VVAyeGZLbitqczVRenN6eThnUS80Ky85?=
 =?utf-8?B?MFE5SnJGMzBpcnh6L3FlOXV3R3hqS0VVcGRDdUJpNzlwbmtQcmJ0aE94Z2J3?=
 =?utf-8?B?MW1VWXU5MUxTcGY4b0J0WGZ5VHpJcTJkNlVIRjI2MTVnTk1VTHJjUEMvNDN0?=
 =?utf-8?B?ZzJJb3JuQUFQRVFXMTJvV2Z2QmRraW10cm15MFBGYUFIdllDcThkU1BIT01t?=
 =?utf-8?B?T004WElKYTc1UCtIVXpVZG5aTFRveUlCSmRxY1lIMFhEb2d1TzZtaklpSVh5?=
 =?utf-8?B?TGt6ZmFvMHR4QURXRDQwcEZqVU9SczZ5bWNGTyswUnlwYUQyQ1oyY2lmcXV5?=
 =?utf-8?B?MnJWYm5qeS9xb3RwVW9qenJjR3RYcVkvSUo5OVFvMVVaV3pEa0l0RlFOTU5h?=
 =?utf-8?Q?4vEDb2DYRknzSx74R6lUHjUrtdW4lNnAosmn4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdef56f-e143-4d99-f571-08d953a7337f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 22:13:03.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si5EQhVyH4n/NfDkw8I1pMnxtRUXLxJ6DdVEEIie47zhr4pepLy0EvEZoLNgItmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: E3BbTd2WsgD6YEgpoSGL-5TXBDa3-vXO
X-Proofpoint-ORIG-GUID: E3BbTd2WsgD6YEgpoSGL-5TXBDa3-vXO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 10:34 PM, Andrii Nakryiko wrote:
> Add new BPF helper, bpf_get_attach_cookie(), which can be used by BPF programs
> to get access to a user-provided bpf_cookie value, specified during BPF
> program attachment (BPF link creation) time.
> 
> Naming is hard, though. With the concept being named "BPF cookie", I've
> considered calling the helper:
>    - bpf_get_cookie() -- seems too unspecific and easily mistaken with socket
>      cookie;
>    - bpf_get_bpf_cookie() -- too much tautology;
>    - bpf_get_link_cookie() -- would be ok, but while we create a BPF link to
>      attach BPF program to BPF hook, it's still an "attachment" and the
>      bpf_cookie is associated with BPF program attachment to a hook, not a BPF
>      link itself. Technically, we could support bpf_cookie with old-style
>      cgroup programs.So I ultimately rejected it in favor of
>      bpf_get_attach_cookie().
> 
> Currently all perf_event-backed BPF program types support
> bpf_get_attach_cookie() helper. Follow-up patches will add support for
> fentry/fexit programs as well.
> 
> While at it, mark bpf_tracing_func_proto() as static to make it obvious that
> it's only used from within the kernel/trace/bpf_trace.c.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
