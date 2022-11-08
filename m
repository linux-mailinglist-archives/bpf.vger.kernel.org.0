Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E077C6219E8
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiKHQ5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 11:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiKHQ5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 11:57:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3F59856
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:57:08 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8GtFeF022120;
        Tue, 8 Nov 2022 08:56:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9Pym7pwRtLOCSieYQa0KHwftvAfjtcImnhx5OYh6eBo=;
 b=M83WjBsD0/Aa4KLc9NWl8pIqSbL6prPGMJFukYzl6GuEnBDA1o6iYYvH4nbWIjyXTc4v
 ko3dKZg+Q2pHIyforrs7GXbLY/eYdPKD6lGdL1jFvXTWYg9i/7BZ5r2mE1JyWWDJ3xwJ
 fJe7nWjC3IThXg3mFuNphShaELKt+FyJ1oZThfb9Bkk8m4NrtqFe+UwaBaYLAoDaPEnc
 LtLDvCFyASCSFVNEof05s0ac8pw6Wqi04RqtDRXrsDZ/EMxGc9J3pr7t37w2y2bi266V
 9L6WAr+zkTsWAGYoaK1lzmR6JH/oe0Pg4hw72A95CPpb9wnc/AWEj8hLjDi5rTns2Epm Qg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqh9wccpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 08:56:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7/CunMBVeGph9XT/y5bEcj/Zzew+GSE5l5pl1+VX+Htj0H8QfmKp2qsz7zavB/TFb1GAY9DYJVJuPrPl204opi4ao50Ak1AADw7Yu775j/CjK+LlLw3Yi1+m6D/rJKpbm8n5hOiXdE9OuzOcOZ7ZyuqJ0gU6FX7wwjOnyIN/eUcGHnLhlZgOIulerqveb+nfJ3TyKYcTkWnUTiXbpZ6NkbGsMGTdpLBEV01afKOLX3rX6iFch/lx7p1gRtW8XFSI0ZZbNfUNyFAa8gSUhbv0o/9IR0ayrGXv0RXYnY5WBF5MncKdixJbj3c3kn+Xc/s280Y65wKfYQ02qACzf039g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pym7pwRtLOCSieYQa0KHwftvAfjtcImnhx5OYh6eBo=;
 b=Nude4OTmolreAM8sv6EQEKg4dykRkUmxoKJFKaD+lRGbzmNu4F4lG80bSjD2UWqkLgk3nmfAWz7FOkthTkdCNZ3oAkN8k013Jdv2FmejZEqZMSAOYv2j7ejKq7y6VmGYp9aEpBrZ70ruLI+zRXR7QkMbnyk9NvnWW73s86/OD1e8yZjHkMe/w3HRWujSCSyAt+xRa4vc7uWL4fOEmfflcccDD0+/ZVvXCsAGMcDtyLw7kJixI54aztPzzvLlvEyak6g/6BSQTwZskXUy9UQ0D+K+0itCaRVVHjCKTgIH0VpP8s2O8eMH8uP7O6usDakw2NE2nEsID7zQR2Et9YeLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BL3PR15MB5434.namprd15.prod.outlook.com (2603:10b6:208:3b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 16:56:51 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:56:51 +0000
Message-ID: <d5a886ba-4768-9c97-9b56-0e0d58020617@meta.com>
Date:   Tue, 8 Nov 2022 08:56:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074109.263773-1-yhs@fb.com>
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <20221108074109.263773-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:303:2a::16) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|BL3PR15MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 60367e0e-4f23-4db5-5a9e-08dac1aa3b81
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CNxC3/kp2u1snuTgiUdAvAtE64aMkR2s46yaH31Jz300Hgi62tp/+Qb/CZ4JTXYXSS8bero/q/3JJU+tTlU2U0aA5oDkHKfEWA3D28n2ZkK83qnlAU2HqE0n6nNzH0cVcwNHPhgiivuDFBPTMhjiW2iZeia+hu/ELeC+g8IqqWbm9FAwFWbgD4VdHM+CMvtwO+A0EJBdziIvk8bWJTQnlMGJ0/amY5w8EJsJgBXkhmngEE+ZeGswImXGEabty9TzNGyyjY1Umo5uCeQD1mzdyMMrNUWIdDdggdMxCZvdXWHQ8f437YA+WtScU1ey1BzRPzoRTYYXhhmlT/ShpUbDV8RJkXWdrA9Rbf5Bija0ZkDkpqootM3wFil0IuN6oB9Ta8Wex0zpGG0DAX1qqrwK+hX3L72rwqyqNYlqLQhyYWtLpl0z9hjKlmLUY2GmrAd7AOCKH9PUlgaTBCr6IM9IEM3YSmibF5Ctxf495c8GGZNituItBaHvGr3CPUvbEFUzEvDN1unkpc8uv0HHiyS6smfUPh/+zxgsbV+4SpBj5DvvJwYluyQjJIpQM1UW4zZQGRtbEKHBwibHxD/+NKibfT3hyWc8oq60JNzX8VuYV+AAiJFTXnKJVnbbRC2KbmqrkM0+/bOiTZklCeMatsaZugnivj5S0QJr14VVmRAvDXTEEdMdmHzz6FZ7CRbRc1ss93EgH91OyKfUs+buBzeQz4MtVXugLVpfd6Y7pnSfFa7oGohSgevN/NNXCYeADqQNkmqf0zplbcfCgXNZ/1m6FHBer+WU9KqOSzA9MM8RT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(66946007)(2906002)(2616005)(6666004)(5660300002)(8936002)(66476007)(36756003)(6512007)(26005)(4326008)(41300700001)(8676002)(316002)(54906003)(6506007)(38100700002)(31686004)(186003)(53546011)(55236004)(66899015)(66556008)(31696002)(478600001)(6486002)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXZvZWQrc0pzMmcwazUyQldQOVV3bDhZL2tDb2FKTkpLYmtGM2NqTmlhUUQw?=
 =?utf-8?B?VitCdW90cDFNN1hoZTd5ZWR4WXpqVmJVRjNDUTBhSUtjTys2ZmFGREZlc3VF?=
 =?utf-8?B?Vzd1RXlhajF1NkM0bjJkYWRtL1JvYy81VHVKUnY4UmdyK09DQWFVTzllbHVC?=
 =?utf-8?B?QnpabjJRQWFjY1A2dm9hMml2MDJDQWJwMnYxSlByOGpIcStpdU15VzdkU3Nr?=
 =?utf-8?B?SnJ0TmdiNzNWdGN3dTFHRllZTjhXN1R6em5Qc3piZCtXMzFic0tiUG13MGVU?=
 =?utf-8?B?K2RBeWw1WVcwMWNuZkkxY0sveHBGcU04MlRSd3NRRER0YTRLV0ZlbUJaeWRQ?=
 =?utf-8?B?Wm4yWE9LT2hLV2JDMkdSRXRWaWg3cEo5MGJlRFpMQXFFNVNDZzR5dlVuc3ZG?=
 =?utf-8?B?dVJ2Wk50RGFzV0VCZHFnaVZXc05HazJBUTVEQnNCUDcvdDB3cWNHMjhkV0Rv?=
 =?utf-8?B?MkZLOVIvTjRUc3BqMHRKUWJzenZYdERYY3pvbEFhUjB0VlNHVURrWkE0bWds?=
 =?utf-8?B?MjNpMnVqUC9tMzFyVnZ1Y0FNRFBpUFJKVm1pcVd4cnNXQkREZitJME54QWxN?=
 =?utf-8?B?R2p5a0s4QkVOTHRzbldZV1lGcE50Qkc4elN3a01RaWFIaGF6NlBYdkUreHNN?=
 =?utf-8?B?bUg4VjV4UDVyYUlvUEU4d0pDOG9KYTFlOHhXWVhJRU9OQUprbHRyWThnajQ1?=
 =?utf-8?B?d1k3Q3I1U1l6eFZGTmlyNEZxUm5pbFNlVWRDdlRXRXlMR29QR0kxMlpzbXk5?=
 =?utf-8?B?eFdCOWUrck5qY1BVcmFQMlArV0l6ZjVtRWh0djRTMTFHRHorR0FRdUVBU0pI?=
 =?utf-8?B?cUVxOFJmL0c0UHFRRytEL1pFam03YzlSeGp6ZEZUbE41WmJRZzMzZ2d5Vi9a?=
 =?utf-8?B?blJ6OVFHTWFaQnYyUVh6TjQzNGpvR0Myem1mNjRoNXh3MXZyVWtiU3hhYUpn?=
 =?utf-8?B?dXBSZVl5cGUrMGhBQS9uTUpvcTZIQWhUK1BWYlluT29MeEZybjdneTl0RWV0?=
 =?utf-8?B?RTNRY1RyZkhlSFg3RjdqZ25zUmhXTjNybDNTT3Ewa3dwdkhNRUxiNlBXaFZO?=
 =?utf-8?B?QzFvaW9BWlFNQk5EN2p6a3cvdE9VZ0Q2clpubUxRVTZ5MUlnVEZLdWw4V1M3?=
 =?utf-8?B?OWREUnNtU2pCTmE0QmZkMnR6REh3RWFxdUxtOFJZcVZSdnBkWlVwc0c5eGcy?=
 =?utf-8?B?WEg3VVhPZE5FUWVSWWVDb2k4WmxDTGhhRFlWekdwdFR0NUFYYUVwdjRndTFQ?=
 =?utf-8?B?NmFWekFFWG1nUHJweW4xaVZPU1cwUFdaV09hQ2kvUUlLQ01mb3ZCNVhhQVVY?=
 =?utf-8?B?UC9DMzdSaklOTHRUTkQ1dmZ2NGVpS3ZzY2VtWGdVenhMbTM5ZnJmQ2t0M2xr?=
 =?utf-8?B?dWtza0ZoZk5BZ1RqT3BKWnFWMHFmdWJMVlFENTl6bSs5eXErTlRnbklSYU5E?=
 =?utf-8?B?UW1UejQ1VWFRSjJGZ0VGamttelk5Y29mMlU3bE1TelNpNUNwRGsyanN4ZmN0?=
 =?utf-8?B?aVBuNlRlL3Qxeml1MWxxMnBpUy82NCtQZlllV0Z5Y1NPQ3MydDc3djJhNHVl?=
 =?utf-8?B?OERKVzNCNC83U2pIUVFsbWZQUk9hVGJ2UzcvbjlKS3RkZFYyanIySUZ6VVpw?=
 =?utf-8?B?UDBqVTNtK24yMEk3MUJ5VENGdzcwQzhsK1ZKdnFDbkthTDZzTGtqTCtuNitM?=
 =?utf-8?B?QmRTUmg0WGN6YUFxTlZtbXRseFhZVFl2dGJUZGFBUWVHQVg2eWFGTVlhMmxY?=
 =?utf-8?B?Zi95RnNUMjdMblJFckFHTVNuSUJwVlpUeXlTdFBFQ2ZKM0doZE1ORDU2dVpZ?=
 =?utf-8?B?YnhaVVQzbXJBRStId210V204dVdyenAxcjRlR3Jacm8xbjIydHVJSGdqSTY0?=
 =?utf-8?B?MFpWTUNUSTM4b2NnYWxpVG9ucGZZUXRNbHFyN2xVZjJYNWFKRkt6a2xaZ2ll?=
 =?utf-8?B?cXd4S24yd1FSZVYxSzg4bEVsR0Z2R1NFVGFjK3NhUStqVzZrQVM2ZGhMTFBK?=
 =?utf-8?B?UkVtRGhVTkhadlhZRFdNMGNDN0VhVzBYOVdZNU1tTHpTOU0yZW13citJbFdU?=
 =?utf-8?B?MUI5NllpamRZYjBLZmk4NUw4aXpXRFJlSERZRUlPd0RWRFEzNE9LQWUvbERD?=
 =?utf-8?Q?VxMk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60367e0e-4f23-4db5-5a9e-08dac1aa3b81
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:56:51.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihocWh/dkAnFY33hfqJRk6mPWl1o+ZrV5lSEQXUxFEMgdAp9e1w4MoF6F5UaNVRg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5434
X-Proofpoint-ORIG-GUID: uKFi7jT_yLKMVmEAN9W_uxEtu6x_cjWY
X-Proofpoint-GUID: uKFi7jT_yLKMVmEAN9W_uxEtu6x_cjWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/22 11:41 PM, Yonghong Song wrote:
> Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two kfunc's
> can be used for all program types. A new kfunc hook type BTF_KFUNC_HOOK_GENERIC
> is added which corresponds to prog type BPF_PROG_TYPE_UNSPEC, indicating the
> kfunc intends to be used for all prog types.
> 
> The kfunc bpf_rcu_read_lock() is tagged with new flag KF_RCU_LOCK and
> bpf_rcu_read_unlock() with new flag KF_RCU_UNLOCK. These two new flags
> are used by the verifier to identify these two helpers.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   include/linux/bpf.h  |  3 +++
>   include/linux/btf.h  |  2 ++
>   kernel/bpf/btf.c     |  8 ++++++++
>   kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
>   4 files changed, 37 insertions(+), 1 deletion(-)
> 
> For new kfuncs, I added KF_RCU_LOCK and KF_RCU_UNLOCK flags to
> indicate a helper could be bpf_rcu_read_lock/unlock(). This could
> be a waste for kfunc flag space as the flag is used to identify
> one helper. Alternatively, we might identify kfunc based on
> btf_id. Any suggestions are welcome.
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5011cb50abf1..b4bbcafd1c9b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2118,6 +2118,9 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>   const struct btf_func_model *
>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>   			 const struct bpf_insn *insn);
> +void bpf_rcu_read_lock(void);
> +void bpf_rcu_read_unlock(void);
> +
>   struct bpf_core_ctx {
>   	struct bpf_verifier_log *log;
>   	const struct btf *btf;
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index d80345fa566b..8783ca7e6079 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -51,6 +51,8 @@
>   #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> +#define KF_RCU_LOCK     (1 << 7) /* kfunc does rcu_read_lock() */
> +#define KF_RCU_UNLOCK   (1 << 8) /* kfunc does rcu_read_unlock() */

Please don't use KF flags for these. It's not going to scale.
Compare btf_id instead.

