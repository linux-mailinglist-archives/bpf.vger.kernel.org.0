Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079945BDA85
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiITC6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiITC6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 22:58:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F2458510
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 19:58:42 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsi6p004484;
        Mon, 19 Sep 2022 19:58:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uQf/RAWdt1UgDuJ4KxT7xhDZlI2ngA2CPuAhdZc+xiw=;
 b=W/qapxSJ801nyKsO03rvwQn3t6I29UL2CeU994ELYI/EkUYLMIcnGH6nkiBmXbRvB2MC
 4Ts1ZcGE9D/qGr5v8rZBJI4T9ecuL1g91iJp1x4BkR/X2wotJQskPvB7VIOhLFnjBr0+
 evOHvKvb94rbdCwNhSNm3+b12k+/1fYyAvQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpyt7hwby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:58:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwV84EukuWwNzKYhuL0soAswQT6Ba8VDPkvTKzkOTBvzCXK+XUygswJIBOZ1TvxV4rGNZNwBfbpxo8ciTlEj8tmqLPqua0tNXKLG14RHhhUO+rFenAwYvUehxOJD2cE6Qo9hokye0wftk1nHgCQkcorMJmhuIV284ly3DejPv2jtBRQXkPIUL0iKSV5dYzMyRo5oplvxsmr4UamOHbMeeJJOHjPa+8jPR6iXIi6IkqJN4mRDru0zWNwIwJWw+vVcuyTH7Rl9dLqlImF1nQu0ijjmW7ov4vEHZvwH9vhHFYcrY8EBI5vC7GhV5ZrnAiJzjiI59UD+ycKADaHPCs6/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQf/RAWdt1UgDuJ4KxT7xhDZlI2ngA2CPuAhdZc+xiw=;
 b=jV6SbNQVCDaPuftgjtrr6bO7oM3oP9TAo5bWxTC4fUwdzggIuiDRM5XB3Fm7h+MzWSakZt/3iV8xBzGo1/Ci1Cc4x8Mxp6p63g3O5QI3lDIQ1wB7k3CsropBO+93dGlU5cR0kHWJ3r+jGXzNLacz6p8YeaaRnP10Ajd8jVwnOxDsbkTnr/3WAPbxyE5ly2CmTO5xrXT5MFMdQrEMXPPQuuYGatQ8v9/o2nxEF+Y/QqATMH9l+3zsd/vQ7HpsGFI1Dxma7e/6QFo/NKcgT2dp4GmpNuha4h3CNmWozngbAtaU/NH8vWGIr7fTKs16gYElQCPKuhXKDKijpZxv1mz4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 02:58:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 02:58:23 +0000
Message-ID: <65c2f50f-d7ad-a979-a7ea-2b79b4886d15@fb.com>
Date:   Mon, 19 Sep 2022 19:58:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v7 bpf-next 4/4] selftests/bpf: Add geneve with
 bpf_skb_set_tunnel_opt_dynptr test-case to test_progs
Content-Language: en-US
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
 <20220911122328.306188-5-shmulik.ladkani@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220911122328.306188-5-shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc86757-4207-4373-3c05-08da9ab3fb82
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn64POGZsXHU88TwzDayNHNe+2a54cKY2nNsZNdeZE1jMqqKXYft30b3m9ky0xRF95bz8R4kBLiu6EkPpkJwwSg4z0uj+HIP4YLpCYiKvViEnH3/3v66YQkAOElk/gGTVsVYSLIYO8ehm8A84GXAojains3zc2pJytm14yUO1lcU+oq/tqXjGfFRVwM6218d89zTVooKDvRkHoGD7wIVw0YsLPdr3GNH39El4LHP/5PvT/+RWLnvPXUbKmNgUWpmyKxz9sxusNBEr4MdOO8unI1pwXwTPvr9wlLb+tY9ut2nZ6iZrkcrGwV2W3JbMec55Oope5/JPXwDlEXwVn8hl2sO/K63JjJfmU/ULBsLu3c0YivdUuLoXiw2axxEkYkQl2QQylBY1QLCBRSzgM3/y4/RUhZgqioZrkPGnumM2frNnQ3D+U2okbpjJqhltiEfQwjVj31xkUBqww7a2QuMdiLZZYf7qOoMclR3gQO3tQ3LSrSNk+L9geDrjGcm6tMwXYtz1su5rqLhoaXdR3917UibJC7dI6FH585IM+OoluPYRkSFYfcP0dG8ReuOH05G8dij1gMuCcTiN1fv9HTwNTkJL79D+FMxUcxMLty1iJB+QhK2pkGmQpN7Ea29HWTWN0ktd1xaPI0YBMGQ374i1fr25DzsvqXZ7bxXOWHgrxPIXdQqhcQiHMaaRjFQtRh0RCKhuTsZ+XyFUBc0RE38kHi3QabtK85xOZ2aHfGMHIiwMe10WU7jD1mcXaiKqA3BNQw+607iKy7RYUj5tTI5wAK3ZjXeAnwcoa1tWZ3NCqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(2616005)(41300700001)(6512007)(5660300002)(2906002)(8676002)(186003)(6506007)(53546011)(316002)(66946007)(38100700002)(8936002)(66556008)(110136005)(54906003)(66476007)(4326008)(31696002)(36756003)(86362001)(478600001)(6486002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJKazhiRXJsVlZXb2x2Z1ZkRllhTnJpdEx0RUFaV3pOL2JNc21OanU1WFh5?=
 =?utf-8?B?WTQ3MXZSdWp6U2J6Q09IZlVvMGUvUnlkRWJPQTdsZUVIYnlOajF1bEZvNjdK?=
 =?utf-8?B?eUlPVUtML3l3RlJqalk3RUZ3OXI3NWNIeFVkT2lGbXpWUkVVRnJjdXZucnQv?=
 =?utf-8?B?NG9sSVBqbXZycm81OHVvM3JIU04xZmdtV29tZWltVzlmUjBueUphcUVxWWlj?=
 =?utf-8?B?ZFZjWlBsVklLYmhLVG5CYmZLT1B0eVJ1R2JMSzhFWEprZUVvcUdUWjdKV1BC?=
 =?utf-8?B?S2E4VERTMDlwRWZ4dE5MSnB2WFdsakxBYTZxM0RiYi9Ub0hyQUNwa1JIbDFE?=
 =?utf-8?B?Ym1mTElOa3JFUDJYTkpxL0d1cWVJZFZUcndrUmo0S0pyaGZOUXExNEpNRWdI?=
 =?utf-8?B?R0E5Y1RGLzRFVklJVmY2R3ZJdy9qL281eWsrTTJKS0pzRzV6dlArMU8zamdt?=
 =?utf-8?B?djVKL1BCVXE5UHZ2WW9pRzdJaHdrVXhEbktJOXE5Vkw2YTFSUVl6ODR3SUNX?=
 =?utf-8?B?NkJpcjV6UTFtYmRmOXVrdVlON0Yyck5oRHltT0xNTFAzSEQ3d2FrT0NWRWdC?=
 =?utf-8?B?cWJTaDVHYVhrVFpmTVlHZitiNGw4NDFrMzFqSGZIRjQwbURzemhWQmlDZ0hI?=
 =?utf-8?B?amVDTlVoUjBhcnp6Z3lwQmZUWklUWmpPSHd5WjZoYmtHSGUvN3VRVGhFSEQ0?=
 =?utf-8?B?UlUvOWd3TFdiYjdBL0hndVE1UVNiY3NHVlQwclZZbENOLytiYXJMZXJlTTNW?=
 =?utf-8?B?a3dNVUZNd0VLcjJnNzVBSWliWFdDMy8vdDBxM1pJL2tOV3FjeE13dVhtV3NS?=
 =?utf-8?B?YnZKY1JWUXRCUXFudUVBazRXUTJDSFEybUpEK3M1Y0ZWZXZMYlVld0RMUEJQ?=
 =?utf-8?B?MndOcWlYNG9uaGVwdHBVNW5acUpDaHo2YXJtUTZ2V0tCVVoyeFUvRzJFOVBV?=
 =?utf-8?B?TzNiTjYvTFdBbXErLzJhWkxhUWtpRWdYV3BDZEZGTVVRZUVGL3JQeXJDK0U2?=
 =?utf-8?B?Rk53SlYrQ1l4WDdPMFU2bmJ6eDZQbnBFY0NuTnJvcTE3MXIrYjZCV0VTbEQ2?=
 =?utf-8?B?SUtFdnVVaVhCemxTckRxbXhNWEtOREIyTE0wcjR1VDlWV1hKM0xocGNhOW9q?=
 =?utf-8?B?d0ppSFlUL3dhZGhpYmdlb0hlR2xOU3ZIQndVdXRINmYvNm1NaVpIYnBpdkxa?=
 =?utf-8?B?YmxVMUdEK2FyVnFlZ0FETllyRjBtUGs0cDc1MHRHWGFiOUtPaXlZTWFMZDU3?=
 =?utf-8?B?N0lMNG5xcG5Na0w4a0dDaDJqcWkvTVM3dWhJZlBBcW1Hcjl1K2FXTmVLUFcw?=
 =?utf-8?B?a3ZWR21YYVFkMk15WFptRmN4SWE1SW8zc3VCRXJBTk5ESkc0dzFLMEMvSzE2?=
 =?utf-8?B?U2tUamNoQjVRNzlGeklBZGpjaDZ1Wjh4V2s2bUJjYWZaa3J5d1VJK2hVa3lv?=
 =?utf-8?B?U1hnd214akhmMVBMTHQ2WGRnbG5MOFZlS1hsYXFMcW5sMGZOU0pPOGdNMHNN?=
 =?utf-8?B?MElRSmVpUTJmQktZNjI0SUxqeUI3ZkdteFdMQkt0RU90UTUvQjRMczlKTzRy?=
 =?utf-8?B?R245cUxOMHpueUZEVVpDQnRMN1hNb0lCZktna1FQdXNRVFptVWREZjl4aVFj?=
 =?utf-8?B?Q3BCQ29sUk5LV1dqcy9laTk0TC83M2xrRE9GbUEyMG1xb2FKc24vbUpTVkdZ?=
 =?utf-8?B?amdhQndRQ2ZzbldNUmp5YnRtNWh5Qy92dW5jc1k4Qi9PMVdZQjFncG9sV2dH?=
 =?utf-8?B?cUdkK1E0Z3lkK2FQN28xTG8rOXQzeTNweVR5cUE3WVVxbEFOWmNDUDl4ZmY0?=
 =?utf-8?B?a2Y0YlUwR2NGZkJ1N3A1dGQyVGpUOWh2bG9DZnVML2hFTEgrNmZVK2FDSVU4?=
 =?utf-8?B?Z3diNzc5cE9pUm40ejFSRXV3SDJlanZUUTNsbWxhQldTUzdIWnlad2FlZm1x?=
 =?utf-8?B?VVNoeTBrcThkd3FsRHEvQjhmQ2FmaHQxUXpwRFdrZElkRDNIS2pNSUJkOHZv?=
 =?utf-8?B?ZUo0eUQ0NEpxdjc0bWZTSHg1dEh3bnlKVlZtOWdHOXAzQW5rQ2dBTGQxVTR1?=
 =?utf-8?B?YjBHZ0t2SkY1NVhJK1M2NjdiKy9qZXJ2M09oS0Z3eDJCRGkwQ3NqK2NVMnVM?=
 =?utf-8?Q?KboWb9K551jVf6E0MViwzcIwe?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc86757-4207-4373-3c05-08da9ab3fb82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:58:23.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7azkiYslG4TkeI8ysgIyaie6J6vEGT1oDJkaUscX4fFtUxxvA1ishGs5aA6XZPOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4039
X-Proofpoint-ORIG-GUID: TOWeSfbjCv0MhmkJXKmSpsWXXta8dXfe
X-Proofpoint-GUID: TOWeSfbjCv0MhmkJXKmSpsWXXta8dXfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/22 5:23 AM, Shmulik Ladkani wrote:
> Add geneve test to test_tunnel. The test setup and scheme resembles the
> existing vxlan test.
> 
> The test also exercises tunnel option assignment using
> bpf_skb_set_tunnel_opt_dynptr.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> 
> ---
> v6:
> - Fix missing retcodes in progs/test_tunnel_kern.c
>    spotted by John Fastabend <john.fastabend@gmail.com>
> - Simplify bpf_skb_set_tunnel_opt_dynptr's interface, removing the
>    superfluous 'len' parameter
>    suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/test_tunnel.c    | 108 ++++++++++++++
>   .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++++++++++++
>   2 files changed, 246 insertions(+)
> 
[...]
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index b11f6952b0c8..cb901b76a547 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -24,6 +24,20 @@
>   
>   #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
>   
> +#define GENEVE_OPTS_LEN0 12
> +#define GENEVE_OPTS_LEN1 20
> +
> +struct tun_opts_raw {
> +	__u8 data[64];
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, struct tun_opts_raw);
> +} geneve_opts SEC(".maps");
> +
>   struct geneve_opt {
>   	__be16	opt_class;
>   	__u8	type;
> @@ -286,6 +300,130 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
>   	return TC_ACT_OK;
>   }
>   
> +SEC("tc")
> +int geneve_set_tunnel_dst(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key;
> +	struct tun_opts_raw *opts;
> +	struct bpf_dynptr dptr;
> +	__u32 index = 0;
> +	__u32 *local_ip = NULL;
> +
> +	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
> +	if (!local_ip) {
> +		log_err(-1);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	index = 0;
> +	opts = bpf_map_lookup_elem(&geneve_opts, &index);
> +	if (!opts) {
> +		log_err(-1);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	__builtin_memset(&key, 0x0, sizeof(key));
> +	key.local_ipv4 = 0xac100164; /* 172.16.1.100 */
> +	key.remote_ipv4 = *local_ip;
> +	key.tunnel_id = 2;
> +	key.tunnel_tos = 0;
> +	key.tunnel_ttl = 64;
> +
> +	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_ZERO_CSUM_TX);
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	/* set empty geneve options (of runtime length) using a dynptr */
> +	__builtin_memset(opts, 0x0, sizeof(*opts));
> +	if (*local_ip % 2)
> +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN1, 0, &dptr);
> +	else
> +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN0, 0, &dptr);
> +	ret = bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);

I think the above example is not good. since it can write as
	if (*local_ip % 2)
		ret = bpf_skb_set_tunnel_opt(skb, opts, GENEVE_OPTS_LEN1);
	else
		ret = bpf_skb_set_tunnel_opt(skb, opts,	GENEVE_OPTS_LEN0);

In the commit message of Patch 2, we have

===
For example, we have an ebpf program that gets geneve options on
incoming packets, stores them into a map (using a key representing
the incoming flow), and later needs to assign *same* options to
reply packets (belonging to same flow).
===

It would be great if you can create a test case for the above
use case.


> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
[...]
