Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF975299A9
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiEQGmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGmn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 02:42:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC662CC8A
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 23:42:39 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GIXMAa022291;
        Mon, 16 May 2022 23:42:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4nnLDdFHWnMdLxC9pJUR87f0RA4ysE317NjGm8/vgk8=;
 b=fuaFsCRMrzQkdRiH/d4mLjzJn60Fyzwd2jbvykCPg1QQNhKCU+7jP3w0NY4KwXWEEd58
 lNg1x7GxDnRdfQhUPTF0sqbUEZObbm468YpHBFyiz4kHgErfx+lN82r1p5C1iBg7hZjf
 lDP8c/a04I7+Aym6uP6rIWZ6/HJWLKn/nD0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g2a8u728b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 23:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2FyrJA0btsqmTN5L0k/xW256Cr4oNqTp95k4MDQjRVtlMnPmOblUCyHQp8WI20HW9G+5HoO/sA6G9GrfuF4oZpgw83rYp3qeUnzyKzfxr4SOlriZfW3HHQY6cf/kfyJhCujyopb/cVAnQQ7rnaPRzRglCxGTeLhK00hNudr5TTFAcB/FnfwvVV+0C+cEK0In4MurYxWHx3EfdYkouRERe0htp2z4QadRSXemJ7jYMKoTKD5CwvhjjF+a1IJ7KzeuasQT8KNFuCdKZfFbRU/gHrLLa3dP/cqP4gt/Hu9kBnO+Vg7/Zh15FOS33dXCWhMB1pmumLdt8qKEeWOzgScoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nnLDdFHWnMdLxC9pJUR87f0RA4ysE317NjGm8/vgk8=;
 b=mD1HK6WoZnFzLNhI1o9JcrFGkmOrnUYYFAXBhwJhwFCuPaATYrmJ0d81ABiLkTr8+b6e8LLvKw6P4g/LdCEmqe13+V7Qgq2WjmeTg4i8KSK22A1beMECj3VM6Z/aEI6o/lxPOWpIxZJ7+Jw/EOdUgzNQEkspzHfeMFFZw4ga3Gm4TARedzcjPbvRXaifVY9ntK+eRdQclABAAJz0j75qPg+XHwHz+U5m6cGlHVZ2/huHj4J6S2Xt5e58WHeKFQaKSYc5RJSNCcE+gkXHwJ70R6i8ftaeiqyCkyoj/PeEekE2YW4IZ+CKyIy+B6FjWk8LotHyldEtiM2xtFbbgiQtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2272.namprd15.prod.outlook.com (2603:10b6:805:26::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 06:42:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 06:42:18 +0000
Message-ID: <78dbf509-7fd4-b5f4-6ac5-c972d2685af4@fb.com>
Date:   Mon, 16 May 2022 23:42:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 00/12] libbpf: Textual representation of enums
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
References: <20220516173540.3520665-1-deso@posteo.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220516173540.3520665-1-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e9bc54-435a-4df6-0128-08da37d062e3
X-MS-TrafficTypeDiagnostic: SN6PR15MB2272:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB22729CB923DEB57E09A26AECD3CE9@SN6PR15MB2272.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mXrIAENUkvAd6FKGr9A+YFm3Kel4x6EsbXpS22kOc9ymDfnBWwgPEdlHj6bghRJLR7BLj7fhTDdx2rDH5ZrC8AnlaVKLBVb/Wdv9EoOywezmSdVxQxphGed15/b7ncbtgP3DigE1e9Irr7bTclVvtM0kMwMk7LJFqjeCUZbLUXx6SC7RXp1jkiy0A3fP4DJ4FlkPsEY9BPm48DHvSmt5tSzCtzUR1fr6j+AUuC7VvI0zTPELHGywtA3s5oK9BAPJDqANubDttOycw3hJb6ux/A2qTrIsoRxLXAV9cIGYDFcvl8c6MwqePIJ6xlRGt7gdVq5LEZACQGfEdfNqRj763G84wQ5tvtO3jYij6GfvEc6UcCAv+ePLHFwOL8QAcihpC2936x3KePPD/OzNa9ehAaU6kt9wN91GZqRJPWuqG0geC8rlqef1aZS+iHo5ak40Vb0w4NP5S5tBYaDOUsTlUGv+IaCYjLDcU4pdZgSg+kBhm4Imh+C9w9e6CdnZfhOwHhOE2VHNEFOp8AvzA8gx36MqRARshWzoEf/o5kUNMnawSk4WTLxbnN/jGts3fklTzjA+fmM+82gnI09TPfC9GrZrCRZZ0rY0l5xBsQddLkYAm3ntkXK9Tq0QpF+o63qyGlRktM09/Lm6hLTLjMYCwZtb6rTkwhFFFIl9yRMZmRTNhc8uUdeY/yBxlfqGX1avPbWHlpXFd09+7iAjy9LIfWdBCD3fhsMO8/inatjEeLOt/KUL6KNXM4acfbZefaz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(2616005)(31696002)(83380400001)(31686004)(86362001)(36756003)(66556008)(6506007)(53546011)(38100700002)(5660300002)(2906002)(6512007)(52116002)(186003)(6666004)(8936002)(508600001)(66476007)(316002)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJUK0NNUmVVNjZsRTVqbnVaNHNaRUNTUnRNaTdVbjRIK2U5OUQ0Ym1lSFFP?=
 =?utf-8?B?Wm5XWEVBcDNQMys3U2M0WXVsRlhZb1Y4REhDa3VaekRyUWVjZzdxOHltc1Ev?=
 =?utf-8?B?b21yY0hZdjZ6NDhTRm5mSy85amlwUlFiQWtMRWQzKzlmQUdPaWNJNTkvMmpC?=
 =?utf-8?B?cEMvS2REVTdDRk1CTkhNUGR0L3V4aHBHNzgwOVhHU1g4VDhzM1NySUtJRWlu?=
 =?utf-8?B?NDZpRUFuQVZlR1ZXMFFyakkwOEJxK1JOZmkxVWp4ZEMwS2s1d0tidEtORXNS?=
 =?utf-8?B?dStsK244WVMza2FIYVJTQXY1WjFYdjZ6MWUyelRYbFRNcUxYazRVS2NieTMv?=
 =?utf-8?B?RzlSNHpSaTZlY3ZOWWt6U1NPU2xJUytTVEpQaEJJNlU1ZlkrcU5ldGNXZ2sx?=
 =?utf-8?B?TnZjeFkyRk1YM2xOOHhqMHJpUXZtKy9XR3k2Z1o0RVJBVnl2QmJjOGdHNmVt?=
 =?utf-8?B?RG9JTE12cS9EOG0ra3BPcEhJU3YwNW9ETDNubXAvN1JRb1k4MVFZT0YwL1px?=
 =?utf-8?B?U1V0Y01KS09Tcm8yZ0NFK3BMUGN4L1hKQ3dETUZJSjlGazVaVGNxS0tXckJF?=
 =?utf-8?B?TmZlK0JHa1N2THFuVVJLeGpVYmN3b1M1c2NsdW9EYVkvZkNpb094ZGtoK05N?=
 =?utf-8?B?S0VOby9sVUVlbFY5T0U5eS9YcndpT085VE1TaERGNEtVSWtXOFlHaSt0OHBL?=
 =?utf-8?B?VVhEOWwxczM0SDJGWFNHZUVQWDhSVTdsMkh0eHdTc04yUmx3YUNIdWFvSHBa?=
 =?utf-8?B?SjNyYy8xQ3VPVUloeTNrWGppRUI5LzgwejhtNlpVMHNJSFh3Y1I3ZXB3OGw1?=
 =?utf-8?B?Z1I4cnZzaXY0WmwvZW04aGVFSDV3TXd5aGJGRFQxdGZpSEkvR2JiL215dDBi?=
 =?utf-8?B?Q28wMFptQ01kVCs3RG0vSFBZWFlUWUVFeXJHMVNwWFV5VC80ZVV3SGpsaUxF?=
 =?utf-8?B?Q2pTVlBqY0cxYm1VMityVDI5UHJxeEg3eEVhcnVMa1Q4ejErWnpwOEFUZ01w?=
 =?utf-8?B?Z3psRk9BN3VwUnlWcjVneXBBSTFSVGlYQVprUStIWldPVzBkSWJFbmJTb3Z6?=
 =?utf-8?B?ZEZRTnFNNG52RUZQZzJoOTNwTzBRSTFyVVhrZjZLOEFtRTY0d1R1MmxBWGNa?=
 =?utf-8?B?d3E4RE5rWEtBZTFueEdsSEJmWHlLVW5Yb2J4TGx6b094UU5ZY0dxc01LN2o3?=
 =?utf-8?B?aS90cVZRZGxtcXVjU1lrODFYWjZYMVYyUml6cXBhOUR2TWNUbEMrdzdvYkhK?=
 =?utf-8?B?TmtnUUFSbWdXSmJ2NXRJZ0piZEdscUk0T2lRS0NGaXJXWWk4VjBqMTFaZFdU?=
 =?utf-8?B?ZE43UnJtNkVkNlBIdFJjMS8rWFJQbFdiQnlXa2lHVzRpdDdoUUpJb2JQQk9i?=
 =?utf-8?B?TWNTVjJ5K0hTWGo1TFNoL21pVXZqZ2d2MzVHcWtIbTBWU25SbGR2WWJFTVY5?=
 =?utf-8?B?RTRwbkNtNWR4OHhHbzFkS3FOUnp6L08zQm84TjJDdTdvLzRGQTZ1dFRFbjBn?=
 =?utf-8?B?Q1pHOU1aaERBdk0xUzJ1eWlLTnp0bTRRY2gvdWp0eEVZTFhBODNuN0JPa2l3?=
 =?utf-8?B?MTZMcTk0RnBJMUFrcS9wQkMrMldpeXZtUzRWcGNrSG5PV1lGUzVzUWZBcWlp?=
 =?utf-8?B?czUrQ0pTZm5VZG10b05lOGo1TUQyQU5IaytNY1Z2UUdhRTFsa25LL1FIaUx5?=
 =?utf-8?B?OGVQS1FpWlpzUW9KaXhQc3dmRUdVLzVRbGJmbFhONnYvUmE1aEFGQWEzSFBk?=
 =?utf-8?B?KzBhRnBoNFlTRTA2UDBSZGpGQmRqd0E2RjZCVjJ4WmJ0OTNsOHd1Z1EvOEQy?=
 =?utf-8?B?K2xjUVdXMEU2WEEwQlJJYjZMRGk2Z0lKUHpZODd6aXZjY0hKUE5qTXRHL2Ey?=
 =?utf-8?B?enVINEFDR2ZBTHVLMjVWb09WNjlQeWthMHliaTAzU2lmZWY0NGRadG5Wcysr?=
 =?utf-8?B?TDg2K1VEdmpkeC9YTVYyM3JCSFRrZ0MzZnAwWmhGM1YrTGFlZzRCbUk2Yysv?=
 =?utf-8?B?NzZMMUF5TXh0dnlCRnNzWmp1Q2MyUDJ6U3VwekxGRmU1dHNCczBtTHowb2lM?=
 =?utf-8?B?bWs5aW9CWGxIQXo2dXdBWDhRR0dsZmRwTGllaGxzaVhxK2VWYmxwUUhNVzkw?=
 =?utf-8?B?QzlZUnZoK1RYdVIwaXczSmdDUUFZcjBLVU5wWkxOTituUDE2UHRRZ05PaUo2?=
 =?utf-8?B?NmJsbncwTUZvV3c0RFAzaTBsWlBRV0dwZnlPUlRSbEdxdXdiWkxYdmVCTmVR?=
 =?utf-8?B?YWhVVEJ1ZVRHaWNoNWl4bXJsQnV5VjhGV29YTlN0a2pPNVB1czNTWFM0aHZT?=
 =?utf-8?B?MXczRXR6UlRFZFI4Q2sxT2MzdldMN1BPZGhERk0zalVlc0dDdjVUelFhcldE?=
 =?utf-8?Q?0JabWLCpAy3+oaRg=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e9bc54-435a-4df6-0128-08da37d062e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:42:18.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn7sP+dgtDgWCWhiPNmAhl50H6AAUHZicD5BXo0T5CKxWPYA0w24aD1oLnGJsLv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2272
X-Proofpoint-ORIG-GUID: LPU9_NvTmGwRscr9YpDbLUGAe0du5ib8
X-Proofpoint-GUID: LPU9_NvTmGwRscr9YpDbLUGAe0du5ib8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-16_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/16/22 10:35 AM, Daniel Müller wrote:
> This patch set introduces the means for querying a textual representation of
> the following BPF related enum types:
> - enum bpf_map_type
> - enum bpf_prog_type
> - enum bpf_attach_type
> - enum bpf_link_type
> 
> To make that possible, we introduce a new public function for each of the types:
> libbpf_bpf_<type>_type_str.
> 
> Having a way to query a textual representation has been asked for in the past
> (by systemd, among others). Such representations can generally be useful in
> tracing and logging contexts, among others. At this point, at least one client,
> bpftool, maintains such a mapping manually, which is prone to get out of date as
> new enum variants are introduced. libbpf is arguably best situated to keep this
> list complete and up-to-date. This patch series adds BTF based tests to ensure
> that exhaustiveness is upheld moving forward.
> 
> The libbpf provided textual representation can be inferred from the
> corresponding enum variant name by removing the prefix and lowercasing the
> remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
> bpftool does not use such a programmatic approach for some of the
> bpf_attach_type variants. We propose a work around keeping the existing behavior
> for the time being in the patch titled "bpftool: Use
> libbpf_bpf_attach_type_str".
> 
> The patch series is structured as follows:
> - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
>    bpf_link_type}:
>    - we first introduce the corresponding public libbpf API function
>    - we then add BTF based self-tests
>    - we lastly adjust bpftool to use the libbpf provided functionality
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> Daniel Müller (12):
>    libbpf: Introduce libbpf_bpf_prog_type_str
>    selftests/bpf: Add test for libbpf_bpf_prog_type_str
>    bpftool: Use libbpf_bpf_prog_type_str
>    libbpf: Introduce libbpf_bpf_map_type_str
>    selftests/bpf: Add test for libbpf_bpf_map_type_str
>    bpftool: Use libbpf_bpf_map_type_str
>    libbpf: Introduce libbpf_bpf_attach_type_str
>    selftests/bpf: Add test for libbpf_bpf_attach_type_str
>    bpftool: Use libbpf_bpf_attach_type_str
>    libbpf: Introduce libbpf_bpf_link_type_str
>    selftests/bpf: Add test for libbpf_bpf_link_type_str
>    bpftool: Use libbpf_bpf_link_type_str
> 
>   tools/bpf/bpftool/cgroup.c                    |  20 +-
>   tools/bpf/bpftool/common.c                    |  46 ----
>   tools/bpf/bpftool/feature.c                   |  87 +++++---
>   tools/bpf/bpftool/link.c                      |  61 +++---
>   tools/bpf/bpftool/main.h                      |   6 -
>   tools/bpf/bpftool/map.c                       |  82 +++----
>   tools/bpf/bpftool/prog.c                      |  51 +----
>   tools/lib/bpf/libbpf.c                        | 160 ++++++++++++++
>   tools/lib/bpf/libbpf.h                        |  36 ++++
>   tools/lib/bpf/libbpf.map                      |   4 +
>   .../selftests/bpf/prog_tests/libbpf_str.c     | 201 ++++++++++++++++++
>   11 files changed, 539 insertions(+), 215 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c

LGTM. Ack for the whole series.
Acked-by: Yonghong Song <yhs@fb.com>
