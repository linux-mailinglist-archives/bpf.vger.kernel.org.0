Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAC4E7928
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355918AbiCYQqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbiCYQqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:46:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2C4A3F6
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 09:45:16 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P6du8b005570;
        Fri, 25 Mar 2022 09:45:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cpN5tM7q5zUPhafNm4x3sb1bs5MZ7U7Cav6K3t81X04=;
 b=FXjfamDNlDs98YBGBHHD9fKNHKjehYHJ3+PavgYLWSaj3tNuOe4VXB5K5WBhADc+iD3F
 mCa4Rltd0h1TKTszKxdJyQa11BZT4fncHGftyEEwa28PU1opuMTROaN2olSSmLAV3o5s
 wsaUB37be/A5kRHwrLbGs6iXgGlfMlbbZR4= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f0n6vw2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 09:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/dbkZaeAB2M30+tQUblplVFq00CZyNR54NO8FzIf8cT6ru+FSbDxNxtFm0h3DVpd9kA1ejSB8pAWpbB9dCe165XxdTTtnRKNdbV03OEL0sFf9H4zJJb085k4KI0BdIi1XaSHzd7SXQodTRZkodgP9f+0Kx8xnkl0yMTLGYAqRJ0lYa0l/IG3ajDtRKf7QK4TM8X075nvlX1iGWQ4f4PVVMBoys+mtavFYJCBt+riZJvIJcLpiT7W9aQ/rbLg7j+jukHLG0RSqKS8qKMwkPJuQRoHjhpYK7EBxvKJYBdfhdmtuGkdbUN583MN/+Y9wtGUnQ6L82UwW63JAqAwd9F+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpN5tM7q5zUPhafNm4x3sb1bs5MZ7U7Cav6K3t81X04=;
 b=cavlemSvxaR/d5JGFED+ruuGyGMEHPpskIilrTB6wXTDo0FOSNwXQ8sIAjiSD5GrjoQU1K66uGgUX4QQEWQ09T8vwg3E9Cjy4FK4bgzijO4sjATl8D6mJsopqjhPW6byhYnvrNv0Za3mcvIdZxKAsHjLhvUH8N8BHhDsBuGRedB0BVmOJZxlYZsGAGs6WwuvhfOpo7zPATZAUh7gVJGz1+/og0s/G6vYQYhgqv3mi2vMmBlUUOdN4XBqrNbA261PGOIrqJbXM03RvNyXE3vwA/UiEH7FWCX6YoKibVJ8BLe/EnIa1OxCnM2bnXj1035kSBYVcoUMXq3CSOrnWpbb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2332.namprd15.prod.outlook.com (2603:10b6:5:88::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:45:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 16:45:11 +0000
Message-ID: <d20c72e3-9fcc-9ee0-9775-ef8fd3281ae7@fb.com>
Date:   Fri, 25 Mar 2022 09:45:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
Content-Language: en-US
To:     fankaixi.li@bytedance.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220322154231.55044-4-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2b9b8f-3826-42ee-2d08-08da0e7ed402
X-MS-TrafficTypeDiagnostic: DM6PR15MB2332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB23329EDB9173664934AEE0FBD31A9@DM6PR15MB2332.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcEa5bxZ8ww/43+ptIuqrFZ1Cpo+2ojm/FkhMJxeuxQ0uQYukTXvGEs+O7mBVXy7jw04uk7hjNt8AHagK3qQOspB8OBWk1AepC/JbSYo4Abx2v7r/meSI+BYvnZRn0WXGpbIan0YkUso+kz+XSJnuSaFXNCRcl2YknDq7Sx8ZO/DzwFDMI02lvtpawNTMTnGes5kDpsALikvM4vnP7ZVhugoV/Bhylr0GcxJaQsLVK2HXu5+FV3nAXCplIgjA3N0YW2cYYh0GquPcrxjQOz2J4o4m9caW4WguiBJymoMvTQTBd5ABORBPmleBV8UGIgnfMfIUVYsCscD9s8NbRRLMm2lyPWiwOHR2TXfJVLJxXxzJFXlb9IphIFQ8FVPTKGlfQ/tR/ARwBA3xHMrNFlAcxOeVxb8m9IXskkrLMnCVVRVVR3UuJzVSAeuUbQvxNC3JuQ1mx4YyxZt+dIxS5rZnraJjeLeUd6hkmkKk9ff2irfDeQZj1CuJLttDfIKC9bcl0QbChF6DqdguYGV4Tq+WyCxPGDMOmicKWJ5pG3BFs0IjzFhBdP0UMdeFAIzIqjuGBUKXoAGQPi//7vCGX2maWcFQL3XH4+J2Ks3is8MZM+FJySnFNF2OWLM49JOZF7yFWl426rjWE2Ob88p6328Hil48rB9vgmbmLpMRFbae2j2HU9ZRHjTS9EOewsVCER4A3sHB04oBaxuxOy/zOGyGxUtwS/HzexcWjC86dGD8h/wskNQuSoUoPP5xNAuXt3C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66476007)(5660300002)(2616005)(66946007)(66556008)(6666004)(2906002)(31696002)(86362001)(38100700002)(316002)(8936002)(83380400001)(6506007)(52116002)(53546011)(186003)(6512007)(508600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1E5R1MxWHNQR0tCYUVVNmJQMW5KK2pWTDRQcXFjV0g3N2FYblNDTVZ1amd6?=
 =?utf-8?B?eXFNM3lzZDAxbUhzNjlxV3RYbGlGbFVlSWFuZVVuWXk4MUQrbU5DS0NMdEQ2?=
 =?utf-8?B?UVdPakNrSFRUeVp3TDRUazFjM1ZxQW5oUTVKMVhteGFzcVZTMXIrS0l3Z0sv?=
 =?utf-8?B?dUFIUys5cm1SQXFCT2ptNGgzWHpaMG5qQ05aUGxuSHVycnlSaGFlV1FocFpS?=
 =?utf-8?B?Y1oxa2orZXZLSzlQcS9Sdldlbk5jNlZxUmZaZXQwYXZtT1g0Q2NqNSs1RG80?=
 =?utf-8?B?dVhaKy8xR0FCeExlbjkzUE9BWTNLTVFPL3BYUDZvaEJ1Rjc0ZmNTU3Q4Q0Fa?=
 =?utf-8?B?V1BVaHRMS0toTUZCOFZPSFpNTzluQmc0S25nS1lrS1hlYnh2N1RXdGJpOVVY?=
 =?utf-8?B?Tk9jay9FMldwZ2RiUkp6MWJxazZBajdDa0NwOGpRNzRyNTUzRGgzSlY1cTlS?=
 =?utf-8?B?QStsUGFMekhCR1BLZkVpZ3NnS0pnSEhHa1RoQjM2WEJ3NzVMcHpCV3dKcVJu?=
 =?utf-8?B?WUhrbnN5NExLSFNyU29ROXh3WXlDUDFGS21mTzJ0SlR3Tno4ZU9wMVZYZC9j?=
 =?utf-8?B?OUxJb3FkTjNiekJMV2lLZVF5K0VOYldxUTRwcW9oM00vSEdTTzFkSzVrUlhE?=
 =?utf-8?B?Q3hmbUY2TzMyRUFvUUp5ekVMYXVBdEJSSDM5Mkg5U1JBbjFlZGg3YWpjcWtq?=
 =?utf-8?B?U1JiN1RUMkN3WUp4YTZiS1RTaDBNQXVORHdJQW8vNXJnaUg0aEVxZTlTUWxl?=
 =?utf-8?B?YW9idnZoTjlFL2FCMmNXN2lVVWtiK3lGRlBhQy9YblJ3U1RpampBSGY2RU5D?=
 =?utf-8?B?RDBneUZZdmRFbHBrand0OFQ5aXZKaDkrVXVKMEFqUGNRcElJMG5oaFJaTFNx?=
 =?utf-8?B?SmEyNDJyZ2RuNDdvK0h2STZ3WmRmQzFWalg1QlpwUE5uWlJhbTc4UllGL0NE?=
 =?utf-8?B?RWZwR0paK2l5QkU2SEdkNmYxdmJwc2RoYjMwM0U5a0NXb3BIOGFBMi9mQ3Ey?=
 =?utf-8?B?VVdmQ0wram5KR1NYYmJPdXRvZmhLN3Exb2NLUUpISmI5dlFnOEVrcXlkcW9a?=
 =?utf-8?B?QmJkN2tFdTVPM2xKY2ZmanNybUdPSlc1cUdoRFZ0cGxpSWZYcjA0SVJXTDNv?=
 =?utf-8?B?SEtPR3VwYXlhRnNGaTltUEtpRE52cStmRDA1WndlZFZVejBPTFpXcS9YMW5V?=
 =?utf-8?B?b0ExcTVTNG1XQVhscGlzRDg3bkJhYW8wYUlzVkRRWU82L1pkWXdZZHdUUVYv?=
 =?utf-8?B?djJhT2gyY0RsVzkxM25LMUZRT3dtRFpjWlJWVXJzK3RIQzFYUjJEa2FWd245?=
 =?utf-8?B?OGdFYVA0WFJpY2JYRU5GTGwzbGsrLzIzTnlBMkRBRG5LclcvTFU0c1BGYVFw?=
 =?utf-8?B?eVBydzNISFVLYkZzQkQ3UzNzTWt0UUs4d1A0YzFDNk1OMHZqYVRRdTRnSjNn?=
 =?utf-8?B?aXVzditReTdmZzlPNkttVDBWV2tJVEdzTk9qbUFFVWNQOUZ5a0NlZktqb3Uv?=
 =?utf-8?B?WHFiTWdLMkNkVmZrMnl4YkJyMW5haTBNbnh6ZnZvOXRzZmdXN0pxT1dmZnpC?=
 =?utf-8?B?Q0w3WU9ZVFVBemdyK3g5QVAyY0NZY1hqQ1RjTlhjMkh2YVhJaTJPc3ZheGs1?=
 =?utf-8?B?R0JzSUFRdjJ6alY5WkZkSzREV1p4cVNaM0RwenRjS1R0SDRlNEE4OEJyc1VV?=
 =?utf-8?B?elBRWGsrbTFGWHh4NjVHREVyZkNjOW9nRUgyWUhZU0c5SGtlRnRaOFltS0VN?=
 =?utf-8?B?K2x0cFduQjlocVdLaEg5NHdCSDVXbXVjZEZhVFczWldDeSsrQ0s5UjVxT0la?=
 =?utf-8?B?bkJrdlF1ckYwcVhneHIrQ0RXNzFEdnRDWGUxSlZMMy9RTUdHblhueGgyTVhR?=
 =?utf-8?B?VFdxOXhGTjR5Nk1BWnpLV09GYTVFVnpmUFJsY2ZNVGRJNVJqTkJyWjd6Zkkv?=
 =?utf-8?B?QTNTUlNvS2N0RGcydVlxbXgwZ0NXanRWWEpyMFArT3NaRXVHdm5ZKzVQclQy?=
 =?utf-8?B?dVJ4WkkzRmM1dkV0OWlLV2ZsQ3lZVHlWTTAzdlRpdmJiQlIwaGFSeTZrODZp?=
 =?utf-8?B?YWp1emNVYU5ickk2Tm5QeHFSRmJGenFyaU9wVVp2dkxwYnNHV0lqUEsvV0JB?=
 =?utf-8?B?N0QrNE5YNVY0N1JhWUV0VlFQNjQrUStTalNaZEl4aFFXcjI4NHhlOTZwazBQ?=
 =?utf-8?B?U3lCVi9FSG04K1BpaXBGKzRBY0V0aGJaSFZOcVI2V01nVklWdDZLSGZueVNt?=
 =?utf-8?B?aG9LcmFwQjk5OTZSTDVsdWZHRVBVa0ZKSlJUb2RKSm9Gc01TdE9UZURoS0F0?=
 =?utf-8?B?bGlYUkVIWm5JWUhLWXdYamQweEs1UTE5QkNVWEVkQjhCQWhmbWVMZlRnUmNo?=
 =?utf-8?Q?PWMR0JHYEp19HQRA=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2b9b8f-3826-42ee-2d08-08da0e7ed402
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:45:11.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77rUItYxb1IGTJbWSfEgoiethVfXf4r/Aq1ozVI4FOyJqHHIzkisZyXi0Ax6mXGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2332
X-Proofpoint-ORIG-GUID: Oe2h741k0xcoG8bIRF9-RC-6EwEizZCa
X-Proofpoint-GUID: Oe2h741k0xcoG8bIRF9-RC-6EwEizZCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Add two ipv6 address on underlay nic interface, and use bpf code to
> configure the secondary ipv6 address as the vxlan tunnel source ip.
> Then check ping6 result and log contains the correct tunnel source
> ip.
> 
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>

Similar here, proper name in Signed-off-by tag.

> ---
>   .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_tunnel.sh    | 43 ++++++++++++++--
>   2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index ab635c55ae9b..56e1aee0ba5a 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -740,4 +740,55 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
>   	return TC_ACT_OK;
>   }
>   
> +SEC("ip6vxlan_set_tunnel_src")
> +int _ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
> +{
> +	struct bpf_tunnel_key key;
> +	int ret;
> +
> +	__builtin_memset(&key, 0x0, sizeof(key));
> +	key.local_ipv6[3] = bpf_htonl(0xbb); /* ::bb */
> +	key.remote_ipv6[3] = bpf_htonl(0x11); /* ::11 */
> +	key.tunnel_id = 22;
> +	key.tunnel_tos = 0;
> +	key.tunnel_ttl = 64;
> +
> +	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_TUNINFO_IPV6);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
> +SEC("ip6vxlan_get_tunnel_src")
> +int _ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
> +{
> +	char fmt[] = "key %d remote ip6 ::%x source ip6 ::%x\n";
> +	char fmt2[] = "label %x\n";
> +	struct bpf_tunnel_key key;
> +	int ret;
> +
> +	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_TUNINFO_IPV6);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_trace_printk(fmt, sizeof(fmt),
> +			 key.tunnel_id, key.remote_ipv6[3], key.local_ipv6[3]);
> +	bpf_trace_printk(fmt2, sizeof(fmt2),
> +			 key.tunnel_label);

using bpf_printk().

> +
> +	if (bpf_ntohl(key.local_ipv6[3]) != 0xbb) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}

abstract 0xbb as a macro?

> +
> +	return TC_ACT_OK;
> +}
> +
[...]
