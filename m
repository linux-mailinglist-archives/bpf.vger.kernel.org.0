Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8E446A30
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhKEU6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 16:58:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhKEU6w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 16:58:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5G5KIj028815;
        Fri, 5 Nov 2021 13:55:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zUvqz64r7pJLkuUKiHe3aumrTPzEirwhR6LrZVmmYAc=;
 b=lw/KRyg7EFx/Poay818W6goVMvnASt+Cjfp1EIB48Yl7WXoH9yRJBvgwsXMDOcT44Xr0
 Gdj2nabs8LUB9abUTW4Ag1YHlnH/YObbJb2RmsllRiIyKgOYZZDESGGHNj33rDHTeypG
 Q8E4p7BhNxpVV84ugZRjKaxKEWghHMBpwG8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t3286xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Nov 2021 13:55:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 13:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQoZI5mPaKcapbMDlE5UT6DDOIp+Y3ZY/mKhrIGdUVtuYZlI9n5ou0Z51fO6MfDm2P4RrQhNkpCMGId9O3/CZElagb+8+ihhZTyh50yuPl+Z7Hr6Ml+Zs6kkED/cHJxS30PXoTlISVC8PyZdvcgzJ2b7MF17131fqC5DosBW21E/HSAnfS6XS96YR9W64Sf9r+cUIl4f85uGhsTPh+lJwBObY2y2GcdHPsfEjx30zuEAZPD6me0g5HVUuDId/H/91LE1q0LsHq9dkP5XTm8ki6OwMIZ+ISF3rL0ClGPlpYORmks1OAUCBIXVzNkSH097YmRG6YC/NVPjfmF3RCvAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUvqz64r7pJLkuUKiHe3aumrTPzEirwhR6LrZVmmYAc=;
 b=h5fJrwvFZZKvnelOa7SrAsCWlfbcwiuhEgOrfDa/j5GLP/JqjsgjAZh4iIYdg+FPXqpaFGqhfaFy2k8dwdNXDfw66rEgAji5RfyjZWNpetKlMFy39yQjgyoplxuMjXSP5eb6qRZqTy5PyywjzkEQ3reUJZFCXEnN+p8MSWPUDaclCYtm+zD6862Qq3F1O2SKGcDYf5QomJyYA3tkno+iwFIWuQTrgBSrCGacUIrLpVvytPOKJ9to948yaT5nJgg5Ahh/qi28J/vRiuvVjghYyd9OggQHKoCidsYVZfWdd8LgoX2MuFLn/wjMOOj7SFDrytTNFsxHjhIWtaBXdouLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3816.namprd15.prod.outlook.com (2603:10b6:5:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 20:55:56 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 20:55:56 +0000
Message-ID: <ade36e92-a304-b3b8-338f-60714dd7baf8@fb.com>
Date:   Fri, 5 Nov 2021 16:55:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 11/12] selftests/bpf: use explicit
 bpf_prog_test_load() calls everywhere
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-12-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-12-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::22) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:1723) by BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 20:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f57d90-c221-43e0-fdf1-08d9a09ea98b
X-MS-TrafficTypeDiagnostic: DM6PR15MB3816:
X-Microsoft-Antispam-PRVS: <DM6PR15MB381678BE238080854EA03E81A08E9@DM6PR15MB3816.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIFigAYsew2iLAqRnInqUY7kveAiVziNa1N/3ZwrmS5y5dfTSgOW6cM8uSwDG3M+24VkN68L5PlaL7I4XZyqFZOkDpJGkzGCiRA/VPu9qKoFMlN1BwZ9tAvTBUZYuluR0MRswXQaeyUil77heByYFCKE0NlBxHzQKsnd2463jcBWOYcYC4HEbdmgJGI6jsmhYX9lsallWf5R0X7mUPBSvvD4jHTHsBn2XZFm2U9hIFw6Kzj4dEreKEkCJRVX9JM6XNrsixdRm7d1spaFxZKp7fudWeE7kkke2eiLWQ2biEf2AVdFWz+lU2izg5V1tU3BP0i41tL42gKS12Qu30UoyACRMl2ttna7S6gxfaQ+7mkih2eL7ydiL3ltREDwFSq2KykhBuNnbpi4k+lug0GjZAhA7TTQS0EltfbQcMR48BsFvSkTy2o+DPU5UvmRzbhyckBA+JUMAySf0Vtl8p85c3Kxk2J1s6geUUBukOYe80ZDre6UIGyvfMVvfp1pRRObumfADCVgHVU7tzc2UxzmqMztssQE32/ZLNszP+WuMKzqAL761SPwi5Q1sl221++S+Uw6lOGXxCDRopr6p9AK/KcQ+Gzgu6q/nExcFmDmK/+sB97twEtbjGYXCG49NZFxRqTJwPOFflbUOVLiv+LFMEbPbu1obVwkzeyqc1MnOTBdKJFmbnSt9BTub4IJ5d1xVhdvhXT4Ugq//Qk/k70Lt2MFErdPcDwc641KnIHl9bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(5660300002)(508600001)(36756003)(53546011)(66556008)(2906002)(66476007)(8936002)(66946007)(316002)(38100700002)(8676002)(31696002)(83380400001)(31686004)(4326008)(2616005)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9JMEw3cmRPMEszaHdTclA2YVlxTFpYdVJjeWJPRmhwME50akMzZGZybzV5?=
 =?utf-8?B?V0E4dFJHMjlYaTZiemhidE1FU2lUdEFXUTN5aTJoR1ZTS295Qk5DMlVGeWVM?=
 =?utf-8?B?ZzJLM3U0NVlWSE8xY2NlNmdNOS9NM0UvYkNZM3FBZTA4cnB0bGk4YTJFQ0FN?=
 =?utf-8?B?Q0N1L3lXYjRSWW1Vc1ZUNDNjbVp1SXUvazVjZDV5T0tpeDBKRm9TdU4zTW9m?=
 =?utf-8?B?RjRlQUsvMzFPbi9GSHRKMlZjTFJ0eGlYMC9CWDBYNFpPTnVZOVp2UWZYajRO?=
 =?utf-8?B?eENRTVQ2djZDNEcwTWhkU0Q1dGRlcjl5Q2pmUzhtRHBsdmhaUjlJUVM2NVZZ?=
 =?utf-8?B?OGRnbG4yNGFOdUJXVXhwK3Vxb0Y2cS9VZm1US0FoeTNCY0hoSTZqVzVMM2hi?=
 =?utf-8?B?cnlSV1h3Z01nOWtWY2J6SDQzcUMvSnUwdWFSbDJUOXUwaUpYNzRqdWpQYWUx?=
 =?utf-8?B?QUNIQm5JWDI4THl2ejNWK25TZWJYNzlsMXN6THNrNjlsd202cW5mdXVYZzU5?=
 =?utf-8?B?TWcwWlZ3L1pRa0MrNDVSeit2L1BFTXN5VzVFOG5aUlk3NkVWWmpkcTZHR3A4?=
 =?utf-8?B?dzFNb01RRUxnV3E1ejBLbTlTRmtoK1VycW5rWURaRUFOdVJhS2duSmd6NEM5?=
 =?utf-8?B?M01oRmRmNVZjT00xSElUOWVrSGpQWXVyZkE1TlpSRkxpR0hadVZMREhmN2RF?=
 =?utf-8?B?OU41SmVHRHlrQy96L29GaG1lWjlURDAzVElqd0RJcEdyRFJoejZjNEI5dEJM?=
 =?utf-8?B?a3RwVXlKMGxmbGhhbXFwY3EzbXV6Skx6UEJEVE5RMkFNajNGa3ZVUTgxL2Yy?=
 =?utf-8?B?bGlrSEpQWXFUUXRpVkpISGszKzVLMU1VcG1UU0dJQUxzME9QVE9jVjVuQlkw?=
 =?utf-8?B?TlRhT0pmK3VXOE5sY2FaSkdNb1VzTGJudDh0UDJ1MEd4RVRYUEpMeXF3bDRo?=
 =?utf-8?B?NEJsTXpDYWduelJCaWRmWTA5MDZTcHczdG9LS3FiZ0l3UHNrc244OGxudytr?=
 =?utf-8?B?VnpIZkNCTXpya1QzMDNlcTRCY2U3WXhuQWMvQ1RiU09wb0hKQzdOZWhjTkhw?=
 =?utf-8?B?b21qVW5WZFpwam1EVk1hd2sycjR6a2RQUFd1WWRkQTNzNXY3TDVZdy9yaE5v?=
 =?utf-8?B?c05tVXdtTnNPNkFuZWcwZXZ0NUlIMGN5bTQxSGVBeThKaElMRFBtRmtpTzBE?=
 =?utf-8?B?ekZCc0VaWURaQjd6c2NXazVLYjZQY2Z4SEtaOXRSVkhLVFAwU3pQRHdhTzlT?=
 =?utf-8?B?OGJmK2dCdzJnQmxzc2xqcEFjcGlucGVJZ3lJZXBIWmxjUTJRMSt4WGZMY05R?=
 =?utf-8?B?V0lmV28xU3MwdG1mZEttM1Y1SkxhNUJEcGoyMWhHamxSQlJKeHo5bzVISGFE?=
 =?utf-8?B?eTRKWEExam9KNWQva2h3Z0taZkZvQnh3ZURWT3gyeHkwVkVsRUFNdU5GN2Uz?=
 =?utf-8?B?Y3YyN3VqVDc1M25ZMUJ6WFZPTnhMMGJIVC9NTGNMNjYvZjU4K3dFd04weFEr?=
 =?utf-8?B?OUswbFlLRjRUczE3Wm4yMFBvUWM2WmNCSVZCcjAwQ0FEbGd3VkpXZVJvWEgx?=
 =?utf-8?B?VXdwS25UVWVXbXYrQ21ZZmdnK0ZWaDROV09KQ0R1aldac3VNWlZFRERjcGJD?=
 =?utf-8?B?ekZyUC9zbVBJUUxUWE0razNMRVYwQ2krSXV2b3RRZmpiakJMZWlvQVZVbUJV?=
 =?utf-8?B?dTZYTzd1ZXhVRXhSMXlSSVhQVEJoWm1KQUFrbXpOMzMxZURBYlRHbStFUVkr?=
 =?utf-8?B?SWhocktBVWNYcXZ3L3ZXaUxBMEtXUnkwR25Bc2VKWU1ZbUdMUkFIcGVvYVBG?=
 =?utf-8?B?TmU4UXgvMHJnUC9LSDZsamNTaEl6TzBxUFpzQ1FRdjFjeTFOY3lwQ08rMWsx?=
 =?utf-8?B?amxDSHFhQmFiNzMwL0hmQUlGdjI5UlhHNGRlVzZJVTExMW4reFBPRU1PV1NB?=
 =?utf-8?B?a1JINkJPZ2V0Z3dnQmtCSkQ4R2JYRzVSdm5mMW4zUDNrSE94Z0g2MnY0R2xx?=
 =?utf-8?B?WG9YZVgzM3ZJUG9IdkVXMkF4azZKN2hUcXA3VTNBZ3BZZHpoNWJlUHhpRWhG?=
 =?utf-8?B?NHJVcDFUYXdsZVllcWdIUEExUUtISHBLU01XY0ZHUDJ2dmZPVUJHcmJTWTV0?=
 =?utf-8?B?OVBzSzdjVW9EL3ZwazRqNnBMTUNJd2hBdzFKdHFUOXFPdUJablExOFBPQXN1?=
 =?utf-8?Q?jEVDTViMD6/KK/oFTlqJeLNo3yTLC5n1vKImF91urCUp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f57d90-c221-43e0-fdf1-08d9a09ea98b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 20:55:56.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fmvj36FORXjY5HMF2DRsKUJcyyANED7JqIYLZWBlwyiv4iD1SxGh/anVME8BiHRRxymx1v+habaWQhwrsCr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3816
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -SeaZrvcY8Rf9mQctAFkfTs-Dpt_u-nF
X-Proofpoint-GUID: -SeaZrvcY8Rf9mQctAFkfTs-Dpt_u-nF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> -Dbpf_prog_load_deprecated=bpf_prog_test_load trick is both ugly and
> breaks when deprecation goes into effect due to macro magic. Convert all
> the uses to explicit bpf_prog_test_load() calls which avoid deprecation
> errors and makes everything less magical.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/testing/selftests/bpf/Makefile           |  2 +-
>  .../selftests/bpf/flow_dissector_load.h        |  3 ++-
>  .../testing/selftests/bpf/get_cgroup_id_user.c |  5 +++--
>  .../selftests/bpf/prog_tests/bpf_obj_id.c      |  2 +-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c   |  8 ++++----
>  .../bpf/prog_tests/get_stack_raw_tp.c          |  4 ++--
>  .../selftests/bpf/prog_tests/global_data.c     |  2 +-
>  .../bpf/prog_tests/global_func_args.c          |  2 +-
>  .../selftests/bpf/prog_tests/kfree_skb.c       |  2 +-
>  .../selftests/bpf/prog_tests/l4lb_all.c        |  2 +-
>  .../bpf/prog_tests/load_bytes_relative.c       |  2 +-
>  .../selftests/bpf/prog_tests/map_lock.c        |  4 ++--
>  .../selftests/bpf/prog_tests/pkt_access.c      |  2 +-
>  .../selftests/bpf/prog_tests/pkt_md_access.c   |  2 +-
>  .../selftests/bpf/prog_tests/queue_stack_map.c |  2 +-
>  .../testing/selftests/bpf/prog_tests/skb_ctx.c |  2 +-
>  .../selftests/bpf/prog_tests/skb_helpers.c     |  2 +-
>  .../selftests/bpf/prog_tests/spinlock.c        |  4 ++--
>  .../selftests/bpf/prog_tests/stacktrace_map.c  |  2 +-
>  .../bpf/prog_tests/stacktrace_map_raw_tp.c     |  2 +-
>  .../selftests/bpf/prog_tests/tailcalls.c       | 18 +++++++++---------
>  .../bpf/prog_tests/task_fd_query_rawtp.c       |  2 +-
>  .../bpf/prog_tests/task_fd_query_tp.c          |  4 ++--
>  .../selftests/bpf/prog_tests/tcp_estats.c      |  2 +-
>  .../selftests/bpf/prog_tests/tp_attach_query.c |  2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp.c   |  2 +-
>  .../selftests/bpf/prog_tests/xdp_adjust_tail.c |  6 +++---
>  .../selftests/bpf/prog_tests/xdp_attach.c      |  6 +++---
>  .../selftests/bpf/prog_tests/xdp_info.c        |  2 +-
>  .../selftests/bpf/prog_tests/xdp_perf.c        |  2 +-
>  .../selftests/bpf/progs/fexit_bpf2bpf.c        |  2 +-
>  tools/testing/selftests/bpf/test_dev_cgroup.c  |  3 ++-
>  .../selftests/bpf/test_lirc_mode2_user.c       |  6 ++++--
>  tools/testing/selftests/bpf/test_maps.c        |  7 ++++---
>  tools/testing/selftests/bpf/test_sysctl.c      |  1 +
>  .../selftests/bpf/test_tcpnotify_user.c        |  3 ++-
>  tools/testing/selftests/bpf/xdping.c           |  3 ++-
>  37 files changed, 68 insertions(+), 59 deletions(-)

[...]
