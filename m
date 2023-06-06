Return-Path: <bpf+bounces-1957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D1724E80
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE251C20BE0
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B1294D7;
	Tue,  6 Jun 2023 21:08:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E727219
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 21:08:24 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748991725;
	Tue,  6 Jun 2023 14:08:21 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IelV5009995;
	Tue, 6 Jun 2023 14:08:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=X46uiavbAda5btK60va7cFzwAT49msZmrRoBZvDKnOY=;
 b=D2AUVyQCKCOvVuU2xgKj7jb9kFYIsxd+wbFRzH9kae/50OzJmt7VFFNev7v9kz+doJm8
 FIj+JqwaPZozLDVGui7Z+q3TUnkI6fArVAnlACvbRxw3u+FtjX12Xh5IxgRK+fTmO/O7
 TjZu+6hbuaEWuu2yjz9aKA01ZfRicWjJ+GYeL5rqF/6Pryzg3/BXP28fSbKRfqgRCvQ1
 qmoKY4r9NhbFipjMBesJQAyTkXLva3yVdMqYuBQXR5E/fAGSo4mcx3YojeRmT7ENiYYj
 oZjUF0FcQw+gsRC1PGMSvKj5iB1+3CW1KAmzuzTqzAT13TkwaL/GvWXXYrp28XfDgB6K Ng== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a89h4v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 14:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KStQnjGUJ9tQWm9uFmQ+h8mWKJ1hBfkbR8PPtxX3rHEQCefHA7IVleACgjaHnBwxpQ6+ToeAq4sGsfGjrAkHqYMQrx6F2ggmsmf0BnIJK0nKqMk+xqWsRfTyCMzPmxgKWiR7sDiVCeeBO9oJ0b6H2NQgjcj+jnA1949+IcxR04Uigdh5WkI0OEZku2pl1+VrE27E7i9I+nAF+lNyUd+DQfgvBykx/VmDi27/Iydd6LbadTJGkzNA2IWekxzMN/oMx6P5W55c40CaV5lOGD3Ux4NCUdWM0XmSYTXqo5llpVgMG349sJdr8Hp3nfh3bOQ6MSfJtfsJCrXTCIORLcP57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X46uiavbAda5btK60va7cFzwAT49msZmrRoBZvDKnOY=;
 b=Nkbi0I6BHopZwIDH3Iq4UeJwuzpdQujMvJ8wkdlSm5cBqTbH+zElkcjjJt5dzrGxj+4VgP7IdfdquaodQju1YWN2HeTeUqA9oCA4fZcve6gON+qaMmM05Gn+7M9uCN8K6uj4f3nADTY4q7jQDK2RN0C1x4nWxQedT1ir/Vs0UPs0KwES++y6CyV6DLtZujmUiar6mknugdmvF6qDqYHugSsTjmdJMVnUbr3TkKXUGaW6GgjPak8Ums/yhUtdzvbFeacMRLMk5Ot7mTOdQao2ms9AL8rqffQVXdaM0U8He/OUAOK+2B9VSgWRUCyHvXN9vxN6JqAeLEsxvJL/FAJ2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4566.namprd15.prod.outlook.com (2603:10b6:a03:377::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 21:08:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 21:08:00 +0000
Message-ID: <cfcb1518-f13f-98c0-d051-0e3f904295bc@meta.com>
Date: Tue, 6 Jun 2023 14:07:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCHv2 bpf] bpf: Add extra path pointer check to d_path helper
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
References: <20230606181714.532998-1-jolsa@kernel.org>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230606181714.532998-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: ed281b3d-47ce-4844-0f47-08db66d21c48
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ebRSBw9lsuQ5boiao7ylHxwIiF95oEp+SRtt7/iTGN6WiBcs7IfBRPsb2NGZ2S3AHAPvgBION6Y4gnHm1NOXvPzNYbMhdP/WFtWP5sKEQw8hHT30rNDv5v/MbMKJ8h9CLssB16KfHccF0uXMJGElIi+R0hrFhP5IlErnBkLoaI7taDY1W0uCAthQwRzUC80dnYNTF5VfQkn+OVeR6KtluVjLoqijOGGN7Lrp5I+mc2uNT22CdesLwcEd0VZtj88CxWzkxuvc2T3XclTdgtnvCZanPKUJ/FcOcsjcbsxByEMW5vF85ewS7l6JupfklC1uHeAtwo9nyXwx5fJ1lnAAUwQPmO14vsUJjVLYl4NNyeOKXiGIiUnR/6BK89Sl7FmddoUy7rlvwX+0WSP0w+di2XnYrsO7Lo07PWG+19fpMo7ZhUO9eU0hWrJoyavmiVu0ReOXkL/iS5XkTM44bPDJ9mJrtBz7IdUC67rghuq3vRePHADf0ahzYeIAsBvBBWhqX1J5Agf2vvzgzCj9wTL19mSBNeYMhwqkdVaMTk1ond9DeaBYWip39vCZMaCbuWRfwmbst19JpQr2upRgvzwo4xPJ8cDHVhe6aWA3fJBeH4ZBy2yE9ITBzaxITF09SHe668JYQoZ0yTdz/2f29Eg+wQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(7416002)(6506007)(6512007)(31686004)(53546011)(83380400001)(86362001)(36756003)(186003)(2906002)(5660300002)(2616005)(8676002)(8936002)(316002)(41300700001)(31696002)(66476007)(66946007)(38100700002)(66556008)(54906003)(4326008)(110136005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmcvZGVLNUpSUDQvanFYWmNlYUdUelY3Qkt6bVlza1Z6eTdMeGtPQU53eGk1?=
 =?utf-8?B?aWZvR1BmZGlpclNrWUMrOVFkTC93SmVCSXhSZU9wcXhTYlg0eDJCK2Jyc0tk?=
 =?utf-8?B?MkFzenJlbEd4NkdsRjY1VUFuL1U0ellYQnhqMmx2eGN2eTlwU2J1UG5jd0Jt?=
 =?utf-8?B?dVMzTmpMWTVOTXlsZnF6eHNVM0Qwc2VZRlF2Z0RpdmxCYWgwSEJxVHI4cFNJ?=
 =?utf-8?B?MEljODJneEhDbjRIZHN0eEIvZHZpbmR3TVhrTzFONFhxS1VENWt2UkI2aklB?=
 =?utf-8?B?UEk1d2hPNjhsYXYxNDlxSTRGMHJGYzNQQkJOZGlhN1ZWVmx2dmZKZDVSdGg5?=
 =?utf-8?B?c004NXk1ZGtUNDh0enh5VHZuRWNwdmFZZ09qZzZvTE5ocGFHeXZkWXhWMmhF?=
 =?utf-8?B?YUk5UTQwV1F4VEtUZHE3OXJtRHJSVmZNR05HRE8xaUczM1N4R01tVnNUV0w0?=
 =?utf-8?B?VVZjN3hPSDFSeEE1NjNsaXdpZlJWeGF3aGZidlE3bWJWMGdVSFNvTk1xMVdN?=
 =?utf-8?B?TUF0UVloLzREVzJoTFppd0FhMVNLQitEbTdIcXAyRkRoVEpXNlhnYnFuVm1B?=
 =?utf-8?B?WWpMWU1FMXRiMUp6akVOTnBhRDBuWG9ZRjMwYVFtZGZLcTJuZkJ4NXZYLzJi?=
 =?utf-8?B?Q05NRTZUcC9RZzhVeVdTcUF5UGNDYXF0bWZScnN5bFVEVnQ2V2hhRDRCMVJB?=
 =?utf-8?B?MCtUK3dJTTBQWURmSjkyM3JSY1dKZURZeHNTREFXNU5Gb0lBeGJVZksxeUZs?=
 =?utf-8?B?YVcrWkxGRmpuYnRIM0EwUkVZbCtqdk81bThvYlpqY1JYWGd4ZzZ4eXh5bzZw?=
 =?utf-8?B?THpvVG9sM1VobGRPdmZ1c1N5RlZYRE15b2NJandZb0FNUlVzNkgvOVZWOFBy?=
 =?utf-8?B?OUJUNDlmTkYvT3JlTnN3QTBJUDd5OFNaQ2xKZjh4MWVSd1BJc0dVME85QjA0?=
 =?utf-8?B?ZXpPeW9yTEhFNEdTZXcvZHJaTTRUUEluelM2YW9KcExETEtXMVJ3bGV6aU9o?=
 =?utf-8?B?ZDlVRTd4UUI1SUJTanJ0bVNEZ1FxVmloZ1FMT3pJekc0QXM4d3k0K2ZqSHp2?=
 =?utf-8?B?YWxMZjFIV0Z2Y1dBQmduY2J2d0lIZ3A2ZExsZG5kSERoYi9pQ1hpRmlHUHY3?=
 =?utf-8?B?dnRJeUJmNllOcFY2Qm1LUVgwQjRzMGZBVENkaE1mWnBIR05OR2ZTS3FIOFFD?=
 =?utf-8?B?QkVBN3ltQ2M4UUcxbDFEZmNMSCtPZDR5UVVWZkQwR3p2a0lENnNCeVY1TW15?=
 =?utf-8?B?bTlDbGlOTVNOa01vSDBBVTZySGttMVdCMGo1NHlpdnFWL3JZTDhxaGRWTE5C?=
 =?utf-8?B?Wmo0RUtOZStHbHRxemlpUTBpcWUxU0hxL0xmK3RmMVExalRScm9WcXEvU210?=
 =?utf-8?B?T3hUcnZDWEVLS2o5SDRhWGdQMTNYKzduZEQ5OHExNGVnUTRxOGVHRnNlU3pP?=
 =?utf-8?B?SmpQWTltV3FONEVLUXBaSjRpdXNaeUtuY1hHdlQ4b2dnWXVFa0NHZ3ZhY2U5?=
 =?utf-8?B?Q3lDak9mVHMvRW5zVEVDL3AxQnhnamdraitxZDMxbno3a1VIWGdRQUlVUnYw?=
 =?utf-8?B?ZWxRS05IczlDSVhKc3paM1VwZnhRVzFPNnpqdWtZc2tROE5tQXE3ZkNQcE80?=
 =?utf-8?B?UlBFMllEemgrME9FeFQycjNTQXlibXZEUG5iRVRLcW1xMGREaWhvNjkydGxH?=
 =?utf-8?B?M1AxZlVPUHdhYTZjeDhDNzFmMHlrMWJINS9XaHFWd1QwUkdLcWhtTHV6RFZ3?=
 =?utf-8?B?WUZYT016QXJ3VjU0dnY5NWVVcHJwM09NQnA1aEtCakRha0NnTmpUbFpNT3ls?=
 =?utf-8?B?NGozdk5lWGVTWmY4dE1tOXpvQWZDT3hNVXZrQlJRTk1takNVMTdiQW00bmZ0?=
 =?utf-8?B?Y0VlaHl5Q1NQVDU0WVBhYmpOKzBaZDRRZXl4Uys3MG5xUTJDbm5GczNabVNF?=
 =?utf-8?B?cWZaUFlFNHgwYkRjTEtveFBwWElOYnNBR3laVlZFVzZjSHQwaFZKVkVIUmhl?=
 =?utf-8?B?b2ZxYmUxRjdnQ253YWVZVFRVMWdSODF3cDRBaUQzNDVRMDVQeExQdEZrZnM3?=
 =?utf-8?B?TndYZ2dDUjVmMVNmM3EyRVk4TjVVR0tqQzlhWm9PZHlHZVRTbGxKZnZZMy8x?=
 =?utf-8?B?dnBJZTZTWmh3dCtNMit3dzMyS3M3b0h6OThUb0NjMWRmYmIrelY2cVVMelVM?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed281b3d-47ce-4844-0f47-08db66d21c48
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 21:08:00.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nvrbp3lscsX5S2UAUwmdo0mKybgAJ1LZPIeXG0GRCZ2Kv98GEg7Iz09e2hLiLsE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4566
X-Proofpoint-GUID: VwvehsUnEETI5rmQ9XklLMIdpBTCMUEm
X-Proofpoint-ORIG-GUID: VwvehsUnEETI5rmQ9XklLMIdpBTCMUEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/6/23 11:17 AM, Jiri Olsa wrote:
> Anastasios reported crash on stable 5.15 kernel with following
> bpf attached to lsm hook:
> 
>    SEC("lsm.s/bprm_creds_for_exec")
>    int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
>    {
>            struct path *path = &bprm->executable->f_path;
>            char p[128] = { 0 };
> 
>            bpf_d_path(path, p, 128);
>            return 0;
>    }
> 
> but bprm->executable can be NULL, so bpf_d_path call will crash:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000018
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
>    ...
>    RIP: 0010:d_path+0x22/0x280
>    ...
>    Call Trace:
>     <TASK>
>     bpf_d_path+0x21/0x60
>     bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
>     bpf_trampoline_6442506293_0+0x55/0x1000
>     bpf_lsm_bprm_creds_for_exec+0x5/0x10
>     security_bprm_creds_for_exec+0x29/0x40
>     bprm_execve+0x1c1/0x900
>     do_execveat_common.isra.0+0x1af/0x260
>     __x64_sys_execve+0x32/0x40
> 
> It's problem for all stable trees with bpf_d_path helper, which was
> added in 5.9.
> 
> This issue is fixed in current bpf code, where we identify and mark
> trusted pointers, so the above code would fail even to load.
> 
> For the sake of the stable trees and to workaround potentially broken
> verifier in the future, adding the code that reads the path object from
> the passed pointer and verifies it's valid in kernel space.
> 
> Cc: stable@vger.kernel.org # v5.9+
> Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

