Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC46EEB25
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjDYX4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 19:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjDYX4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:56:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29014453
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:56:22 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLERBa028347;
        Tue, 25 Apr 2023 16:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+/c9+3odcA4+wOfLWt9tX4oCnFEOEQol1pHw+hh+5TM=;
 b=O2Js7HbHU5SJTdItFGf2QjjrRPus1lA/1hNUJEPlSaaMa0Ha/T1j8C/t7Ywdpd8SBYLT
 ep918wBsnjtn5uPETTccvZ8zTWDD++kRaXr0nVS8cVEOXFmyXxfp5PE7nmrWDBE+Vkva
 EEhGoB3oylRCUnkvtA44muYWCaobIikEvIKyipZ+4z7YWudfkqdyMCwXwzGW4IOMz62V
 ItJLblyO9TGEFgbAIOathAmV3CFjUBda8pAiOD638U1NDrfkHHh8FtDuL0mFm/q3kQhS
 OMXEmcndrO8Kw1rViH4oVzYExrtEVezbSMYIm1cbPEgKN6XEwWizk7ahoZPer33dsp1g Zw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6ek7mrnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 16:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsOsrX0obcMS1QMi4dtdvU7sElvK9iJcxxcyZbZIhiyH7Ws07GArQJgscwpPd2ZW0hzAcL56Y/nZCh26twmDAUxyeHVxlHZT/MvUMbA5zg7RdPEoXL6aoDg7TDCsda9RN0RskJECDDFnGOiPRnU5irZHYIA/8QB5dz6xM21fC5ubqv6CW3KH+dAl0SNe8YesK7CrVJ+C4koD893ZcgSabGnWkWtDgNcRVdp20BzcL+jtRweN4Zoz3bdTtd003wsV1OEvgyzCoQxoMamr8/EhZsvVYfmln8YMc4phj5Aw0+o7vLdaiMuVs5XZNh5ULFqkn7kNdhgy2jsULVpqj0Yc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/c9+3odcA4+wOfLWt9tX4oCnFEOEQol1pHw+hh+5TM=;
 b=XMqFZmTah8y2hI5wXzSWMWcwcKtBK08YGKCoHFPRW+iYQv4fH726mi0MlfcmiEGXiZmPISOwDyUB+eAUQy0nLKv8P4oBbepnKxm8pgmZ4F1dAhmzGM54g6jt1YCHWu0f0Gzf0wvv8mHdX1irUuOAvkkyBu9t25Ix/sI9oV2pFymZRkpLfvJnIFhFd/WggoOuggJ+nMGSOsxB6c1xjhnhJztcVAniJGDwS4IUiIFa+hDuacxaYb0OKlJgrAEWLdixtKnmXbYXDf1veXwXeTvA4PUwR4lfTxcLIPMV6tZIpwxg9l/VrAoYPJOBhJ3/0RJIJ20pmfF02+8G78igUQ9/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4575.namprd15.prod.outlook.com (2603:10b6:510:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 23:56:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 23:56:04 +0000
Message-ID: <d7e22ae7-0080-1ad3-e05b-379890953f95@meta.com>
Date:   Tue, 25 Apr 2023 16:56:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230424160447.2005755-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: efa7e202-9bc1-4630-5c0b-08db45e8a12e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVUxNa+G9Xn9ic4emEPse1be9f/rksgf8oq7mA1IRx90fUQhMi4/kGN4GpBBslA4sz54bgAT8yPxl3f0bFloGX23S6LwpTj7Il0JVoEXK0Vj/Ep/1qnE2ZEH+Fu6E6+wXD1xv/jeLPCsZd7638lO3xhK3N9hlTBuGY/QbziNG++XSlKJRk0O+QpCCIMDzB67ilITjbpy2q3bQDBTDVwsV2qwLbGTzLuXA0a66o9Hjz++HTiq3+eNhPQ5QGGqw6f99S1UEGERdLOSAaDzf/DZ+IM1vKIiGJqx+BWY4gr7KANLF37HZrLP63EiX/i3YjQEDaENDuJNaVzv+tFxcTDcrwebXgfJFTT+GLeZnc/cmR/tAdhVlxNzqZQ/fdqAkslpXz/2Wrnn5jMRrC0AGrgPwWzwhIC+JXpjIyKQyr2mvwx67qs0UTcNfLnkQ/GK2JHJjwXxq2zbhRrrE1ECOGV1SCiRoEj/G9Ql8R2hXsUowvEpNImkrgknkFh34PK0LjYBB4iEwSoZOxRFglxG1zRzl6HfVvMSQvIchlVvNwtbG4oSRtYj+JxGomd3ny09eP3afmzN/3lzPqUf5N1Zet3mAWQdICFQMY7ewq/92K0b8QH7FVZbXbHUWjLAB+CcEqoL4+vdbPi4oV/3D6VvBAB94g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(186003)(38100700002)(6506007)(6512007)(53546011)(83380400001)(2616005)(2906002)(8676002)(8936002)(5660300002)(7416002)(36756003)(478600001)(41300700001)(54906003)(31696002)(86362001)(110136005)(4326008)(6486002)(316002)(6666004)(66556008)(66476007)(66946007)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE8yVlhlcjdTRzVDLzNJRE90ZXBtSzdVYXNTaVZpb0l4Mk9RRnZnNXJpN1Mz?=
 =?utf-8?B?SnJVVURqZ2I2ajV4OGxDclYrYTg3emYwMHdTZEJoc0h0endGS1NaV20xejlp?=
 =?utf-8?B?YWoyeGk5d3ZqcldMY0xuWXl1cXB0a0pCdWpRNXN1MnpZbWI3WjlDVkU5WnJa?=
 =?utf-8?B?ZDBRRjVUT0pHVGo3NktFZmpTN3phRi9lRmpZM0R5VTd3cWhPbjkrRWdrRnd1?=
 =?utf-8?B?a2kvVC9FMkk2YWMrVXFwSXBTaUJZcnJNMmg2c1RUeUhmcXJvTnVENE00K0k4?=
 =?utf-8?B?elBmRW9YZTVOcWV6eWFTcXJnTmdiOUJ3OHVLYldwcFVtWll0V0czcHBzNVYy?=
 =?utf-8?B?ZWJVNkl5L2psUklIQ0xvNjVKd0NMTk5JQ0VBMDB3amlwWkp4WnRaWUtGVDVN?=
 =?utf-8?B?K0l5R0c3UFRFV2lrWGttV3piVDhkaU9NUHVycXBxbFpmR1BkdHREMDN5clVp?=
 =?utf-8?B?bEptNWtoWHEyK3dVdC9PQSt4TkJWTklFOFpWd2UzVFgxU0RvMU4zUHBwV0NZ?=
 =?utf-8?B?bkhzS1ZPbEd2QVo2eVoraVVSR0VsV3J1bDJlZDFmZTJWTUVER1RkTS93T2FW?=
 =?utf-8?B?UXRJNk5UZWdjeDJZanp3eE1xN3pDMm5oUGdlMThVU1N4UEE0SmM2blFtMG13?=
 =?utf-8?B?WVI1anVka2JlYmFIMS9PTGFhTHBOeHM5SWQ4RE9mODkyd09vNkJZa2JVL1Bk?=
 =?utf-8?B?QUdYSXltVkdjMVVoM0Y5dUVpR2Jjdlk2aFlNM3l1MDlweEVCU2ZqZzJIK3VH?=
 =?utf-8?B?aitUNjZQSEVWZE5mZVV4c1RWais0OGJ1WGVJV3oza1ROMGt4OW1LY0J5bjFV?=
 =?utf-8?B?UWZoUHVreUYrOVVnbnhHVzhOdVlkR1JUKzJqbzRUVlVkdGQzMUxnQWV3azE2?=
 =?utf-8?B?N0tkY1dGaDh5U0FlZ0E0b3F0RmN1RzFaMHlINmNvNHE3TkFkRmhqcUdoR3Yr?=
 =?utf-8?B?bnEvVk5ySk13NDMxUFR4VklQUmN5YmhzcnBrWFlvK204b1VwSUkwM1BSLy9D?=
 =?utf-8?B?QmRLU0cyNFpPc3JJVWtKMFdqNHM1RSt2dC9YVEliUVFjTk1zZFU2ZlhpeDlW?=
 =?utf-8?B?RWJVS2hsUDA0RUhzR2R1ekFxUjZJd1lpUzlicGJ4NVRubTdvRFF5eVBRQVlB?=
 =?utf-8?B?Z0NhWFEzQmV4UTZNOEV2K21ldlRKcXFFV0pPaFd2TjlwVVE3WnZOdW1hQUFI?=
 =?utf-8?B?anhtUjAwd1Z3cmdRQzg5SDUwTGE1aXltMkNlK2NXMlpYdk5RejVPOW9uL0hF?=
 =?utf-8?B?M1k2VmE2YXBOMnJEUnIvLzJDRkZzM014UDQ1UEVqL1IydUxlVi8va29MbWoy?=
 =?utf-8?B?Z29sZFU4Ri82bHpQcjcxakdiMDJ1aCtzMDhxWVM4Ykk1blkyTkF1UkxpcGdN?=
 =?utf-8?B?RmN3bURscnU0N0FUUDNiQ0dWVHFJZVU1czBWaWwxSm83QnRQb0lzcHUySVk3?=
 =?utf-8?B?VjV4cE0yT0JpaXdJQjJqS1ZLRmlnMzV4dUdZcGlPSmhocW5CeTBsZm1wSEVS?=
 =?utf-8?B?czNPUkhOdnhTZzJMbCt3MXVrMWZsSW1sRnAxL0lnOHJicmR2NitOc21ka0I0?=
 =?utf-8?B?aDdJYkkzbFByOTJaQ2hycnFkMUNFVGsrbGhDYlQ2aFdWVzUwMmVWcWlYamFn?=
 =?utf-8?B?ckgwUG1kVzRaamZwR1JzaHpsM0RDczJ5ZDF3NS9yM1djWHlCZFVNOWlMMnNB?=
 =?utf-8?B?UzV1ZlJKRGo4SjZTMWo2SHRWSGFBTzFNZmJmWkRBVkpwT1VPNWxJd1BGbjR2?=
 =?utf-8?B?S2t6K2djZTdUV2JzQmRGZ1oyczVJSEZ0cUp1TWgwL3VVOVhpMHlGSTkyOHZ1?=
 =?utf-8?B?Q2tvSGtvTWdTQzJlSzJ4eGdTK3FqMUlLclJJcWdnVTYzSTd0WnJDbGlYU09n?=
 =?utf-8?B?bW1rSjZpTFEvcVkwK3lwTVFXNEEwWGgwNDdQM3B2WUR6SExCb0lyZ3BKNmdp?=
 =?utf-8?B?L2tVc1VRdTJTUHBKZjd6YndSaFZsY3ZvMHdDdVdjWnVDNkFLM1c3SzlwdVJv?=
 =?utf-8?B?NXV0bENhNklnV2p3cDJsY0ZsdkxTK3h6bkRLNGNVVjhWK0xaVE9nWm10YjNn?=
 =?utf-8?B?d3g2d0c3L0FsS2R5RGFXL1J1YzN4cDJPVEI5dXF6ZGJ3eWR4ZitBZ05Ud3RL?=
 =?utf-8?B?U1IyZlZqdnZ5d1NocUtjZUhrWllRbFgrT3lJK1ZUMEQvblArMTBXK21LZnNT?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa7e202-9bc1-4630-5c0b-08db45e8a12e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 23:56:04.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVurKwtocsQYA3MhR9nVVA1837sVSAi3L/esBoeODZPDJlOO9UfOTZ2MGXRKg6e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4575
X-Proofpoint-ORIG-GUID: Ubkb1IzNbY6NtPI7192ohWrFuRndtt9E
X-Proofpoint-GUID: Ubkb1IzNbY6NtPI7192ohWrFuRndtt9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 9:04 AM, Jiri Olsa wrote:
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
> 
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
> 
>    struct {
>            __u32           flags;
>            __u32           cnt;
>            __aligned_u64   paths;
>            __aligned_u64   offsets;
>            __aligned_u64   ref_ctr_offsets;
>    } uprobe_multi;
> 
> Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> the same 'cnt' length. Each uprobe is defined with a single index
> in all three arrays:
> 
>    paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]

paths[idx], offsets[idx] and optional ref_ctr_offsets[idx]?

> 
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/linux/trace_events.h |   6 +
>   include/uapi/linux/bpf.h     |  14 +++
>   kernel/bpf/syscall.c         |  16 ++-
>   kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
>   4 files changed, 265 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 0e373222a6df..b0db245fc0f5 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -749,6 +749,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>   			    u32 *fd_type, const char **buf,
>   			    u64 *probe_offset, u64 *probe_addr);
>   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>   #else
>   static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>   {
> @@ -795,6 +796,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int
> +bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   
>   enum {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1bb11a6ee667..debc041c6ca5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1035,6 +1035,7 @@ enum bpf_attach_type {
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
>   	BPF_STRUCT_OPS,
> +	BPF_TRACE_UPROBE_MULTI,
>   	__MAX_BPF_ATTACH_TYPE
>   };
>   
> @@ -1052,6 +1053,7 @@ enum bpf_link_type {
>   	BPF_LINK_TYPE_KPROBE_MULTI = 8,
>   	BPF_LINK_TYPE_STRUCT_OPS = 9,
>   	BPF_LINK_TYPE_NETFILTER = 10,
> +	BPF_LINK_TYPE_UPROBE_MULTI = 11,
>   
>   	MAX_BPF_LINK_TYPE,
>   };
> @@ -1169,6 +1171,11 @@ enum bpf_link_type {
>    */
>   #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
>   
> +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> + */
> +#define BPF_F_UPROBE_MULTI_RETURN	(1U << 0)
> +
>   /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
>    * the following extensions:
>    *
> @@ -1568,6 +1575,13 @@ union bpf_attr {
>   				__s32		priority;
>   				__u32		flags;
>   			} netfilter;
> +			struct {
> +				__u32		flags;
> +				__u32		cnt;
> +				__aligned_u64	paths;
> +				__aligned_u64	offsets;
> +				__aligned_u64	ref_ctr_offsets;
> +			} uprobe_multi;
>   		};
>   	} link_create;
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573e..0b789a33317b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4601,7 +4601,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   		break;
>   	case BPF_PROG_TYPE_KPROBE:
>   		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
> -		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
> +		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI &&
> +		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
>   			ret = -EINVAL;
>   			goto out;
>   		}
> @@ -4666,10 +4667,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   		ret = bpf_perf_link_attach(attr, prog);
>   		break;
>   	case BPF_PROG_TYPE_KPROBE:
> +		/* Ensure that program with eBPF_TRACE_UPROBE_MULTI attach type can
> +		 * attach only to uprobe_multi link. It has its own runtime context
> +		 * which is specific for get_func_ip/get_attach_cookie helpers.
> +		 */
> +		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
> +		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
> +			ret = -EINVAL;
> +			goto out;
> +		}

The above seems redundant since it is checked in 
bpf_uprobe_multi_link_attach().
That is why the BPF_TRACE_KPROBE_MULTI is not checked here since
bpf_kprobe_multi_link_attach() checks it.

>   		if (attr->link_create.attach_type == BPF_PERF_EVENT)
>   			ret = bpf_perf_link_attach(attr, prog);
> -		else
> +		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
>   			ret = bpf_kprobe_multi_link_attach(attr, prog);
> +		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
> +			ret = bpf_uprobe_multi_link_attach(attr, prog);
>   		break;
>   	default:
>   		ret = -EINVAL;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index bcf91bc7bf71..b84a7d01abf4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -23,6 +23,7 @@
>   #include <linux/sort.h>
>   #include <linux/key.h>
>   #include <linux/verification.h>
> +#include <linux/namei.h>
>   
>   #include <net/bpf_sk_storage.h>
>   
> @@ -2901,3 +2902,233 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
>   	return 0;
>   }
>   #endif
> +
> +#ifdef CONFIG_UPROBES
> +struct bpf_uprobe_multi_link;
> +
> +struct bpf_uprobe {
> +	struct bpf_uprobe_multi_link *link;
> +	struct inode *inode;
> +	loff_t offset;
> +	loff_t ref_ctr_offset;
> +	struct uprobe_consumer consumer;
> +};
> +
> +struct bpf_uprobe_multi_link {
> +	struct bpf_link link;
> +	u32 cnt;
> +	struct bpf_uprobe *uprobes;
> +};
> +
> +struct bpf_uprobe_multi_run_ctx {
> +	struct bpf_run_ctx run_ctx;
> +	unsigned long entry_ip;
> +};
> +
> +static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		uprobe_unregister(uprobes[i].inode, uprobes[i].offset,
> +				  &uprobes[i].consumer);
> +	}
> +}
> +
> +static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> +{
> +	struct bpf_uprobe_multi_link *umulti_link;
> +
> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> +	bpf_uprobe_unregister(umulti_link->uprobes, umulti_link->cnt);
> +}
> +
> +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_uprobe_multi_link *umulti_link;
> +
> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> +	kvfree(umulti_link->uprobes);
> +	kfree(umulti_link);
> +}
> +
> +static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
> +	.release = bpf_uprobe_multi_link_release,
> +	.dealloc = bpf_uprobe_multi_link_dealloc,
> +};
> +
> +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> +			   unsigned long entry_ip,
> +			   struct pt_regs *regs)
> +{
> +	struct bpf_uprobe_multi_link *link = uprobe->link;
> +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> +		.entry_ip = entry_ip,
> +	};
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err;
> +
> +	preempt_disable();

Alexei has pointed out here.
preempt_disable() is not favored.
We should use migrate_disable/enable().
For non sleepable program, the below rcu_read_lock() is okay.
For sleepable program, use rcu_read_lock_trace().
See __bpf_prog_enter_sleepable_recur() in trampoline.c as
an example.

> +
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	err = bpf_prog_run(link->link.prog, regs);
> +	bpf_reset_run_ctx(old_run_ctx);
> +	rcu_read_unlock();
> +
> + out:
> +	__this_cpu_dec(bpf_prog_active);
> +	preempt_enable();
> +	return err;
> +}
> +
[...]
