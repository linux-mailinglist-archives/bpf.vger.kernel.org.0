Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C263CC54
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiK3AMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiK3AMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 19:12:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA1F716D3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:12:08 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATKRApD010972;
        Tue, 29 Nov 2022 16:11:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YRSnUnNlHo75jF25W41PqnnA1Z3SgXjZDxdXVDWPch0=;
 b=CjDCnRRFp6pTmIBQ3/odvn7T6uqdU9lSDV04SqS5ZySCUBTYXUQ6LmlF7emFjoI1Hs0p
 aAYPvSsBL9qNdV7NcfNJ4cQYRVhNmFkcbvUE4XRCm2HCYgjbimxWAX6T24sN205+kpIe
 ECDSga7hSlzUZQdl58lv1jVg5+dxYha+S1lROIlLn0brhL3muZ7lbujJ2FXSy/e5EUf4
 ufCORhzTM/aoqinBFDMviOMl+8iSpWCznFZiVCEIX3Sg9TbpOFV2X94iZVSYBi8wdbSL
 5GcL2K9lcH93lCSQAzk0Xa8omJtM9svE3LwhnjitpUxkdpPueLN6px1lmnIFdOf1uePZ Sw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m5fjdfk4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:11:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BosJKjQZCcm4kup3kiwjrKo3vVSZHfIi2TEz4IW/pNAXCpyfZGBV/p1wXyq6lff7NYUKEFZJCLCfM5VOnYyv/kxJUqCv2O8KiuUgxc4Rs6fdeq3QKxRfzE6erbrB4PRYVlKY02Gncnhhs443aZQQ8T9MaLgwRc27YjtFPdCj9gtaedLoagb7e6eL5IiPukMfzQ6fG7+bGFdGNhTEqi0KeDY61LmCVb34TWv0jopzcSqPuQx0C1L2+slG7+vxwXz7NLnNaoGFyJqIjNnV6VzYRTwnfJJ9wlc74zrhoX+bpa4uKkppE4uEDSfl1x8EK+PC9j1LSaDIAC4odVNjJFNDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRSnUnNlHo75jF25W41PqnnA1Z3SgXjZDxdXVDWPch0=;
 b=TWCz3avDiWBCB02OnoVE+mk+Ao4t+VlhsmysvWFD4rCqkCrtWQUZ9o4ijh0V8nvhkoXLuR/4TxMOglx1xGczPZMKEPyByyO13Ha2Zs72Yg1MHAumgvI5cPYNh6oGxvXoBnL9tis/OJ4F9YgiAbCOQM7cZ5k2c3qAtia18D9TOoZKEL1KYs2SzBSV7wHpEgGTAoMh9fFfIN3N+u/LJeLMFU+9m4JCKiwJWuCrmaCNs9bBv4plIVex479mxib+6OR2fQKNsmVwqibL2+A0sb0qqc4hbCrMCh1Jw26qgtVLleuQ1B3q/+Ku8qHdmugBE3bs0bC6ER4Qc0CPrJ8EC8PkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1935.namprd15.prod.outlook.com (2603:10b6:301:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 30 Nov
 2022 00:11:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:11:50 +0000
Message-ID: <5947a586-0dd0-bdec-018b-fe6d7e281735@meta.com>
Date:   Tue, 29 Nov 2022 16:11:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221129023713.2216451-1-yhs@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221129023713.2216451-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MWHPR15MB1935:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c42f9-60f8-4d7a-ecf4-08dad2677a3d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRbvQjgdDRqb63fMegv67uqrJSCK/zK3kwyZKfDaTfn6OgQ76KCrOAXSaTUY1zY3iwbjTO67jgsnzs3kCI4WHfGJmzWQitxnppOjr5BnQ88oN1LBXKoWBBp8qQwmybpnVweqKBkWCLUh2okEBn+yNwBZJ0dky91UA5rPTItJd+vPQJvH7mmEBchJ5gpHP5Be+o0acJfhzp+wpPTEFKgjEglSWwvPUB/+Xo/q+RAFO2pZO9GRjjtb80QJiukkr2SbmG+KDdkq3kBNecSQLFNKgC18b8//6ZM9sOUR1Nar2iqj0odeKIItrrhOwfrhtNj0gjpR4GtQZnKEQhiBz4naO3jut5u/18keDyIPyAos7gpiomPzcnFAtmTyIHo9Sr4As7GJRxT4fCtc70A+Zk0eQNt4S/MxUS8rzvzLCsXzk33hjGS2JQQVK6QfSEGwHPuJhVvBdlONJ0r4+vGfaSgpv/yIppxlRUU/pj9AQyRPGlS4gwIlNHPz/25EAvRYkIvIVa0Ok9ejxsWcB6NAvUyErSMzeY4WcoVKAxgzHfgmNw+1RQnZAqdLn7CG1TSa07lX3h2EOD9WAeGwFCm9ORx2RKgMPSKfy8ivMuB663YGw16JoUFx0THlhfCEUc2L+a8jtyyzrSoIZDJwMR9gq/PzG4qNgAGDxOrqAdCXMvLLfU2E+OaWBgZeATbUAtcw/9KMYS0HNdsd4oNkm6IvmQ0cnhE58lZLe+/WxW2XYuypD/qzYCPG8+agBXWHZQLvcrbF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(36756003)(53546011)(66476007)(478600001)(38100700002)(6506007)(6666004)(86362001)(966005)(6512007)(8676002)(41300700001)(66556008)(66946007)(6486002)(31696002)(4326008)(316002)(54906003)(8936002)(5660300002)(186003)(31686004)(2616005)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1IbHhUcG1vUTMrQUdOZUpHZHFvMTYvWTh3ZytnUktXUEFOTDV4Z1RaNDJ4?=
 =?utf-8?B?dDY0aEFBQnlGOHVDRm1lRzVROC9Mb2JISkZJdHdPQ2tCanhSZ2cvOXMvZkRE?=
 =?utf-8?B?OUNDQVA2dlo4R2RDZURpOUpxTE8yTEIyWHFSQ041THcwZkZrN0pTTG84ODUw?=
 =?utf-8?B?andyd3FnN0FFNkoxbVAvaVpnM043SHVTNW1UbHlBYjVScjdiS1lUVm9uSXFI?=
 =?utf-8?B?Rm51ZUZKdzVFcTJzYm5GVWdKV2FUNjU2Zjk1cGVNeng4WmJLNU54WUxoTnJL?=
 =?utf-8?B?TXpGdm5JalVMSVJOcmZuL092MGlCR1ZZcGdoNHNKSFMzangwNFRZamtHSEwr?=
 =?utf-8?B?T2Vrd2Q3N09Zb1VVbWlJeVVqek5NRFpXbkJBcnZKSEtnY1BxRzVFeGNRRUNp?=
 =?utf-8?B?cGJsNXN3UHJRcUVvZUsxT3ZZejZoVEVlTmFBK3VQZnZTUFRua1M3NzhlaGlU?=
 =?utf-8?B?WlMzQVJLMHN3SENibEk1Z0U4dm1rMC9VZFd5cmN4blJVOGgyMnBHUm5kY2tq?=
 =?utf-8?B?WnM4eTRZc1BOUHBVKzNmOEUwZXRWZStwUitiaktYSGU0YWsyMm9nSHRNa0Zx?=
 =?utf-8?B?a0oybDREVjhzNW5JeVRpNE1WMS8rNG5QYnhkNjJ6ejNmMGlkdW9jQWRXZVRi?=
 =?utf-8?B?Vzd0TWU0eTRkOVR3cUlPTmhxWUFVQWM4elJtU0ZNS3VFRHNPcEJGL2RLM3Ur?=
 =?utf-8?B?SjZ1WW1meDA4d0huelloRWFOWWtadkFxWUJXYTVzL04rM2wwN3owa0NjUzlB?=
 =?utf-8?B?VWtEQi9RSU1TUHZYSHd4M0NhSks4L0duOEwvdjl3d210dGhoRU9mS2djZ0RG?=
 =?utf-8?B?TjRsMWlVOEpuVUNINEJVWHF1aUV4c0ZjWUxjWFd3YTBoUGxBd2FCL3NRUFdK?=
 =?utf-8?B?YjRtYUlwbGFxdXFLdEJha2pRdkx0N3I4eEZ2bnlEZUdBSUJoSGgxQXFhOFl6?=
 =?utf-8?B?eFlwa2FDQW1BV3JpelRXN1haQm9mczNBbS85ZkVJWUdtdlpkd1R3d3QwS3Y5?=
 =?utf-8?B?cncyeTdSSUIvK3dSSGRqRkZlTGxvaUt4azZNSmMrVzhLUnBPRnNsYWpVcUZ3?=
 =?utf-8?B?bGhLa0JZYkVHemh5dlJ4VCt0aUVEMFlsaFdDYktvanRPN3l1cTRCYWJMYVhE?=
 =?utf-8?B?cXYxYjFUMytYQ0tETUtmRVhPb05NQmJ4a3B0dTJPTGYyVTcvUGN5bUtOMk1y?=
 =?utf-8?B?T3BKTzRSQ0xEWkF3aHRIZVNtaC9uMnA0cFo0RnViK2NOdHBYaUZGUldLVnFx?=
 =?utf-8?B?WDZkVGRFWEFpTGtOWVQwVXJCUUlmYU1JbHVVSG83N05PWVF5eGE2ZXRRbE9Y?=
 =?utf-8?B?SUVLb3BROEZ2V2lsaVRjVEVYaUdlM2ZHZURvcndZQnY4VjdTK2RnSitmM0xr?=
 =?utf-8?B?OG5rWkkxUDU4S0tUZzFkVEp5VHMzOWwvYXZveDc4QVFDU2JSVUF5RjgzMmlB?=
 =?utf-8?B?Q1I1bldCQitybndkd1g3alFDdW9wTTdQQXlxeWhBcWhSZ0htUmh4SURBbWFy?=
 =?utf-8?B?ckg2MmpJYjI5OVJJdWRZVHhzN3dPQ3RmaHhiTHpRUXQwemtvbC9XVGpjZzM0?=
 =?utf-8?B?c3dMMGZxdXZPWkpwQ3BSdnovSzl5YXJhQytMa2pjNk9mdnlNbklvMmFVcTh6?=
 =?utf-8?B?QUZ2bndiWVVjVml6cTBzZEY2bk1EOGxobkJtUkxmem82NmVsQmI3SGFUVm9S?=
 =?utf-8?B?ZkZPTDFGc0wwNG9MM3FSYU9nN21SUkh3OGhiRGIzWnlJTmdzWCtKQWZldGFL?=
 =?utf-8?B?WTlNR3JDRDVLa09pcnp1RXlkeExrOE9iWXZwOVRPNjFId2hHaGVva3Y5UGIz?=
 =?utf-8?B?aWRzZXZSbkpERG5UYk0vbUxUMmt4dnhQd1VqdDNwK2ZZdWhiYlp2V2tZckdO?=
 =?utf-8?B?ZUZ1V0g2K1ZOVFFpWS83Ui94MVVSNUhQbHJ0aTk3ZndKUkd1UXZLVUNtcER6?=
 =?utf-8?B?cEdtTW5vU0tBcW1SZEVwczBjQVBOL3JUOWZHclNHNEgyU2dNZFJkeVh0VTh6?=
 =?utf-8?B?QlBvMS9WblNzOVlSYzA1emRhRmtuUjU4bkZSRllYN3BsSVUxKytOanp2RURX?=
 =?utf-8?B?eFUvYjZZK09qdWRqSGxIQzI1MWM5UUg0dk1OSU81SC9zQXFpaUV1SlpwWm1x?=
 =?utf-8?B?Q2NScjl3ZWJ2WjdyMHlNcFAyd1c5TDdtNlc3YlAwRkl4UzNLSG1mczlxRFVT?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c42f9-60f8-4d7a-ecf4-08dad2677a3d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:11:50.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdW1sb1Bb89acu7T4psSg02Sr7vjmsnalCUDWuW/o6IDeS3Un4XmnFmorxp52IeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1935
X-Proofpoint-GUID: _3b67gtzeiYx2oBlIPljBfh-1MmQxDwM
X-Proofpoint-ORIG-GUID: _3b67gtzeiYx2oBlIPljBfh-1MmQxDwM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/28/22 6:37 PM, Yonghong Song wrote:
> Commit 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
> introduced MEM_RCU and bpf_rcu_read_lock/unlock() support. In that
> commit, a rcu pointer is tagged with both MEM_RCU and PTR_TRUSTED
> so that it can be passed into kfuncs or helpers as an argument.
> 
> Martin raised a good question in [1] such that the rcu pointer,
> although being able to accessing the object, might have reference
> count of 0. This might cause a problem if the rcu pointer is passed
> to a kfunc which expects trusted arguments where ref count should
> be greater than 0.
> 
> So this patch tries to fix this problem by tagging rcu pointer with
> MEM_RCU only. Special acquire functions are needed to try to
> acquire a reference with the consideration that the original rcu
> pointer ref count could be 0. This special acquire function's
> argument needs to be KF_RCU, a new introduced kfunc flag. In
> verifier, KF_RCU will require the actual argument register type
> to be MEM_RCU.
> 
>   [1] https://lore.kernel.org/bpf/ac70f574-4023-664e-b711-e0d3b18117fd@linux.dev/
> 
> Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   include/linux/bpf_verifier.h                  |  2 +-
>   include/linux/btf.h                           |  1 +
>   kernel/bpf/helpers.c                          | 14 ++++++++
>   kernel/bpf/verifier.c                         | 36 +++++++++++++------
>   .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  4 +--
>   .../selftests/bpf/prog_tests/task_kfunc.c     |  4 +--
>   .../selftests/bpf/progs/rcu_read_lock.c       |  7 ++--
>   7 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c05aa6e1f6f5..6f192dd9025e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>   	}
>   }
>   
> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
>   
>   static inline bool bpf_type_has_unsafe_modifiers(u32 type)
>   {
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9ed00077db6e..cbd6e4096f8c 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -70,6 +70,7 @@
>   #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> +#define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
>   
>   /*
>    * Return the name of the passed struct, if exists, or halt the build if for
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a5a511430f2a..46fbe027f3b6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1837,6 +1837,19 @@ struct task_struct *bpf_task_acquire(struct task_struct *p)
>   	return p;
>   }
>   
> +/**
> + * bpf_task_acquire_rcu - Acquire a reference to a rcu task object. A task
> + * acquired by this kfunc which is not stored in a map as a kptr, must be
> + * released by calling bpf_task_release().
> + * @p: The task on which a reference is being acquired or NULL.

A typo. The argument @p cannot be NULL. Will wait for more feedbacks
before sending next version with the fix.

> + */
> +struct task_struct *bpf_task_acquire_rcu(struct task_struct *p)
> +{
> +	if (!refcount_inc_not_zero(&p->rcu_users))
> +		return NULL;
> +	return p;
> +}
> +
>   /**
[...]
