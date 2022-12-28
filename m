Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C246572DC
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 05:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL1Eve (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 23:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiL1Euz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 23:50:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95530FAFE
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 20:43:26 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BS1x2WT027568;
        Tue, 27 Dec 2022 20:43:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=G8w4AkMDQfF31QNic6SKI0JLLnEoseBh4sglS+TLgIc=;
 b=XkMcodruEYbIhBJOZejRURUB/K3oXU1lbURNvI7cAO3bGShisgQ78ZaAZPCjkzz5KIRR
 M2+MVm4r4jODt79+OJDAgmQJOLuN6O2DGnMjryWSTEloVIOAyEm+5aPsKrtvZBEo3VPY
 k4raxjOihN20wFXBD9JLRdhEnFZIrhKDqGi4Q6Wz1jbV4HwbJw+igHaWi9tftneVetlK
 vhVUcjQ8MijlQ77jT5bDFfWItPEEUbBxib4bFV5LcUS0+quRB1K4jMh6fCySjgBlKXbu
 FJYLgqXFBCQrsPzciAvVcaCNE5y8gmKiKO4j6vxClib3EF8muScG4zoYwPDFpDvnkZz7 3Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mnx041gmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 20:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njs97przbg9utdboTBSCQdw8bimGQV5JL4T/YXEkS6eSRqEFcQmwnJuV93342m9L6ly6vnK7XciBoOd5GszFd80rIGhJujWku4qWOoI+JK3zRKdmOEoVAEaDR9t8YFDUUELv3+N+jUYJAIk20RpFjTIOE8LqWPlp8Cg0qGasLCtK3bo3p3xg//lasj+OM1T5hQjX+/9eDDmRzTgRbBl8UmsqRPeeS+TbKcN0Q/O45IKOxSJq2IkLFck8p2NN1qzPV+la2uPyYjln+ZLRS2tHlsc9DtMVeMIVI0EWt3x/tjsrjr3bRvHqCfPWFCjRRmnAb0ZB0ddxSB5/27qbL5rUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8w4AkMDQfF31QNic6SKI0JLLnEoseBh4sglS+TLgIc=;
 b=jIl1KnVJLaEMtg12dvNCK9b/rN0MRcYzfZes/8PJ1t4FXQRkEBes2aM1Zdtzc5MIB4yp2sX5iebxGSD34h3XFNyUkIUm7WwkpG54tml4GOkh3GhTkV6IJKRibUVyX7ey9VMv3hZQVecqH0XQh26pCAJYds8jPutzFmwxrXfRpzLSMlpiA6Rft+55pWVhk8BIAkuZxuuXpip/3r9yyuWLVZ6YZVaf4eKGve5Iw73IHT55UcYSQb5k5Ug1bylfS8Hamtw0ASmqihB3HN5fwpz81bz0/p2vciKHsousPn1f0sSBSY10P4/6a9U/LoLK3ve6L6xkTUIHMNLwk4S8VRVoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5129.namprd15.prod.outlook.com (2603:10b6:a03:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 28 Dec
 2022 04:42:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 04:42:58 +0000
Message-ID: <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
Date:   Tue, 27 Dec 2022 20:42:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     xiangxia.m.yue@gmail.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 827124e9-73a5-45c7-19e0-08dae88dfe62
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+ZfASflW+hcMRk3gdwrpUw9uVg7LNg4l2WPFPNj5lN815PQVwXKwfK6KlJfwQGvUqyqbpcZefU1Z0/0N/cQ5Eg8ceob1XUZeiO2F9ObeqsFoiRDL9FpikHyA2IAqRQ+5Dchjb30CEX4ksxWObiHQ2m8/omQE3pbM46U03cYsNxOztWTRkB4hr5ohYvZsSJ9cRix2roeUKDpXKDPVMpXr3A1lYZSh33zPV7de+ENtMZFxbACapa2m+i/hvoJb8onu9i2u2H5WfK/L8CjuO7I8YM+zG3c6KWrYdvUUzKsiT9RLrtmErauuR2BkGHjOZ40u13LIlBdYoB5lfCeLFbhTT5SLNCfHfhfcnb0EhCuoXbiFW2B/FGh13uDdcwxwrabUDuBONC2FC47ZRBSSUnPkmWU85pQg5OU009sSJGzaNNjnYllDPN5/hVDKCoRE8weQYZYJHd14kwVDWwAUPdTAUqo7sLzHzk7q4Pk4Wjl+tevHc4ihY3fW0DFWYRrrfqrI6YNX3KgKzmCragiQX0mULUdADcANOD+BfENlgFvtRnFxxFcE/EADyxqeNWeCSQONODPt2thg80cAlWpIlrFzjcv1wXqn+qq9G8moyYook7s1LGBg5kcNDWqL6V/MGcgurymlc2b4inQfvVl8eoAUSatoafI+RrpwTvpc8w8CqoCkQhPyN5pCC5eyj39DMUjy8hdxaqgDdT2hRzBMdRc/saFpW5neNgV7YyOGhSBbq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(31686004)(2616005)(5660300002)(6512007)(38100700002)(186003)(36756003)(66476007)(6506007)(53546011)(41300700001)(66946007)(66556008)(8936002)(478600001)(8676002)(6486002)(4326008)(316002)(6666004)(54906003)(2906002)(83380400001)(31696002)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZWOC9iZkkwbU1FWGs4K0xKRlJHT1dsdUEzaDUzaDdjaWo1WHBKeUxoK09Q?=
 =?utf-8?B?d0JOaHJmZEsrMGFBdVlZOS90akdoSGVlbU5STGJkbUl2WHZUMnlVVjVzMDJC?=
 =?utf-8?B?RzhCMkpCM21oeE9mMWJwbWxhRmFvdURqcnJGdmVsQ2tyUmhRUDcxeFZoY3la?=
 =?utf-8?B?a3gwOGgza0FEVVIwSTVyd3ZnUXJYeG10eWF1Z2Jyajl1cFFIUlBlTkREUGdt?=
 =?utf-8?B?OXhXSU50VzRFUlBTVnlvb21zWjNXd09uNXB1V0pIMjZlRFl0WkdJZ3dYdi9x?=
 =?utf-8?B?WWt1ZU9QY1RQNi9vb1k0aG0vZFBPT2ZrWFBTditIMGRqenFKQ0hmejhwSEVR?=
 =?utf-8?B?ZmhXYjJMZTVBNzhqcGYxWlhLalVaai9mSFNJZUNoWkRNbHBVbzVoWkNXbmdP?=
 =?utf-8?B?NE43NzdYVjMwSGQrMWpkaGJPdTdwM2owbkU0Ryt5amRrOW1iVlh3T25oeW01?=
 =?utf-8?B?dWhXQWNUUEVMTURqMEtuT2VKWk1CcHRDeko1dW8ySVdwTUNnNWRQVXNNQjEy?=
 =?utf-8?B?dWRxMy8zRmJuWnZ1R2t2KzVIbkNpbDVCUHZqdHBWWWVKa0lTUDNUVVU3REJV?=
 =?utf-8?B?YnF1c1BEdUNuc0kzdUlNWEhNSzZBNHJ2WXdPWTZaVXBuMkM2ZUJUSTU3WFpz?=
 =?utf-8?B?UkxtTnFpb3AwSmZ5T1ZWVVd5emR1aHBybGtKN2hMN0lLQ2x6aFhWNDJJZUhl?=
 =?utf-8?B?Z09HWnNoR0ZqazBrVVBSYzMyeHF1em9oV2Q0MDJtblFLaDNGYUwwNldjZDkv?=
 =?utf-8?B?TktwK3lmc2h1SDFvTWRtbDVyckJzWmlKZy9iWUJGbXNYTVhyU1hEdEZKNGYr?=
 =?utf-8?B?dWRWMUxwcnZJVitpZGZUTlZtc3JnbG1XWlVxMHV3eGpVZktWTldJN01xTkdY?=
 =?utf-8?B?eTNKYmxwNUJxeTJ4RHM5eGZNRXNFc3duYXJyTk11SFRmYzdwdjZ4MjIyd3ZV?=
 =?utf-8?B?dXYwc0RJdDVpeVh1aFZ4ZUt5Rk1HZzhEOEJFY0VvYllacmxGZUhaRG9rMDF6?=
 =?utf-8?B?S0F1azYrTFYrN1JvRDNzR29XSFVuVHF0YzF5cG96eHV0Z3VGWExHaEtRekNs?=
 =?utf-8?B?UDkzN3hXdHVPMWdYVjRabU9YZ3cyaTZ0MUpIQ1ZaOVMrUENHTEtoejc2OFV3?=
 =?utf-8?B?YUlUYTF6RnNHeVMrUXRBT2FwNXBNeHFUZnN1SXR5OXliSmVaWnZ3b1ZFMGtx?=
 =?utf-8?B?eDZ6MjhQRHl6K1F3UEt5dzJIRUlmam1JVmJJSzh2Q0tMT2NsNGJwdzREZER1?=
 =?utf-8?B?Q1VCZW12MkY1b0pQL0VjNWJ0SGVnRUFKRjRRQmZFZDRKLzd4b0E3NnFlT2Jx?=
 =?utf-8?B?TlBKM2JIRWpZSGhodXlySW9QVVc2YS9MY2hFYXlhNmFBd2JsaUZ0czloRFhi?=
 =?utf-8?B?djFTUDJ1Q3REaFhYdVpESkszNmpybWloQ2xZS1BodEhmNVg0NnNKckZpN0xt?=
 =?utf-8?B?Y2xMcXhZSW5sT2lNREp1YjhzUU1JU3ZlZVZuRnd6NHJ3Qm5XaUZGTGF1S2Zk?=
 =?utf-8?B?c3NTT1RyenZVZklpMTN5ellJNVNDKzdJTWEyYk9iZjFvVEdWcFl5dS83cE9o?=
 =?utf-8?B?YkZ2NjdDZTNTTzJlWG1jOVA1ZVZYU01ZR2pMeTd1eTZMV2w5MmltVTZHYzVN?=
 =?utf-8?B?Rk5Vc2ZXcjlZUE9ibklHMFNSalByRkNZaDN4RzZXZnV0bDRlZXFaK21iakxt?=
 =?utf-8?B?YWxKRXlNcEJPM0JLQjdSZGdkSktGdHl2ejA0SUVEczgrMFZydW54V1NETE1H?=
 =?utf-8?B?RmNUY2hyL2p4cDl2L3lEbi81K3BBYzYzdDN1TXI0RkpQeDRpRFVhMEViQklN?=
 =?utf-8?B?bXNsN0JiQk9KL1dQMm5oTkVGb0N4d1lKY2thbGxXWi94T2ZMdFVHdHl2Wk95?=
 =?utf-8?B?NDMxWnBLcGsvdDNPbnZ4ZTZPTmFLK3dUcFk3N3c1L3dKVk5XckRGejh6SkJz?=
 =?utf-8?B?SDBWMjZnT3RaTkIrZTRGang0QnRPVFAyZVc4OUtvZEVCTW13dlBCTGl4empE?=
 =?utf-8?B?cWp5YW01VHZmVUlmUCs2V0wwZzFBdEcxNDFreGZBQWdBanZOWXhQd01uVzVB?=
 =?utf-8?B?emJKRlNOTzZzV0s5M1lWKzVOQXhiZE5Ic0pxdzJZcDZWSFJJVVZka1l4OUZv?=
 =?utf-8?B?elRVeElrLytFZk83SmJqbHgrMk5LUU4rYU9vOEtLR216TThJQkRVRlJNZlpI?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827124e9-73a5-45c7-19e0-08dae88dfe62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 04:42:58.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbajRW3IUKeVOB5MJnECaVt6oXbifVe/ewDfZQNZYwWTaXKqCzRQsU9X/Hp7mh1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5129
X-Proofpoint-GUID: ojY6P1rIL33MZgoUeaEnqXPmBm_UwKyR
X-Proofpoint-ORIG-GUID: ojY6P1rIL33MZgoUeaEnqXPmBm_UwKyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_02,2022-12-27_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This testing show how to reproduce deadlock in special case.
> We update htab map in Task and NMI context. Task can be interrupted by
> NMI, if the same map bucket was locked, there will be a deadlock.
> 
> * map max_entries is 2.
> * NMI using key 4 and Task context using key 20.
> * so same bucket index but map_locked index is different.
> 
> The selftest use perf to produce the NMI and fentry nmi_handle.
> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> map syscall increase this counter in bpf_disable_instrumentation.
> Then fentry nmi_handle and update hash map will reproduce the issue.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>   .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
>   .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
>   4 files changed, 109 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 99cc33c51eaa..87e8fc9c9df2 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
>   get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
>   get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
>   htab_update/reenter_update
> +htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
>   kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
>   kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
>   kfunc_call/subprog_lskel                         # skel unexpected error: -2
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 585fcf73c731..735239b31050 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -26,6 +26,7 @@ get_func_args_test	                 # trampoline
>   get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
>   get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
>   htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> +htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
>   kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
>   kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
>   kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> new file mode 100644
> index 000000000000..137dce8f1346
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <test_progs.h>
> +
> +#include "htab_deadlock.skel.h"
> +
> +static int perf_event_open(void)
> +{
> +	struct perf_event_attr attr = {0};
> +	int pfd;
> +
> +	/* create perf event on CPU 0 */
> +	attr.size = sizeof(attr);
> +	attr.type = PERF_TYPE_HARDWARE;
> +	attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +	attr.freq = 1;
> +	attr.sample_freq = 1000;
> +	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> +
> +	return pfd >= 0 ? pfd : -errno;
> +}
> +
> +void test_htab_deadlock(void)
> +{
> +	unsigned int val = 0, key = 20;
> +	struct bpf_link *link = NULL;
> +	struct htab_deadlock *skel;
> +	int err, i, pfd;
> +	cpu_set_t cpus;
> +
> +	skel = htab_deadlock__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	err = htab_deadlock__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto clean_skel;
> +
> +	/* NMI events. */
> +	pfd = perf_event_open();
> +	if (pfd < 0) {
> +		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
> +			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> +			test__skip();
> +			goto clean_skel;
> +		}
> +		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
> +			goto clean_skel;
> +	}
> +
> +	link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
> +	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +		goto clean_pfd;
> +
> +	/* Pinned on CPU 0 */
> +	CPU_ZERO(&cpus);
> +	CPU_SET(0, &cpus);
> +	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> +
> +	/* update bpf map concurrently on CPU0 in NMI and Task context.
> +	 * there should be no kernel deadlock.
> +	 */
> +	for (i = 0; i < 100000; i++)
> +		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
> +				    &key, &val, BPF_ANY);
> +
> +	bpf_link__destroy(link);
> +clean_pfd:
> +	close(pfd);
> +clean_skel:
> +	htab_deadlock__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> new file mode 100644
> index 000000000000..d394f95e97c3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__uint(map_flags, BPF_F_ZERO_SEED);
> +	__type(key, unsigned int);
> +	__type(value, unsigned int);
> +} htab SEC(".maps");
> +
> +/* nmi_handle on x86 platform. If changing keyword
> + * "static" to "inline", this prog load failed. */
> +SEC("fentry/nmi_handle")

The above comment is not what I mean. In arch/x86/kernel/nmi.c,
we have
   static int nmi_handle(unsigned int type, struct pt_regs *regs)
   {
        ...
   }
   ...
   static noinstr void default_do_nmi(struct pt_regs *regs)
   {
        ...
        handled = nmi_handle(NMI_LOCAL, regs);
        ...
   }

Since nmi_handle is a static function, it is possible that
the function might be inlined in default_do_nmi by the
compiler. If this happens, fentry/nmi_handle will not
be triggered and the test will pass.

So I suggest to change the comment to
   nmi_handle() is a static function and might be
   inlined into its caller. If this happens, the
   test can still pass without previous kernel fix.

> +int bpf_nmi_handle(struct pt_regs *regs)
> +{
> +	unsigned int val = 0, key = 4;
> +
> +	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("perf_event")
> +int bpf_empty(struct pt_regs *regs)
> +{
> +	return 0;
> +}
