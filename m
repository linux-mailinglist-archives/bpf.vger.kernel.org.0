Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0F64AF94
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiLMGGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 01:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiLMGGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 01:06:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E617438
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 22:06:34 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD048Rj006823;
        Mon, 12 Dec 2022 22:06:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=r2yTIpVkXM6zEDqYJHTtrW9wKK0s7GhN6FzneRYKNJA=;
 b=B9u/Q1OU/smYfYuaKAneLbI0fP+xasntXMQsJHTHW9VzNWfUJfJHqbNz+Z7cVtgcNDWl
 NL3rig5ldVc5exK8qTXVWMkNKE7dqnw2hH2Bpb3PQT4oywr8SaAmukAIEHDVEZwF9ytw
 CWBHYTgIY8IlHTxmpZ0nZ12p1djzjmSwqYWbQQgtG8ESAxNJbwU8YvmfF+JIfZxNZS8D
 P2tJu/rC8jaLXEU3NStuacT8aIyWo9kBIFEGAc/1+nAUeYVL6gsSOVzSvLUgnfDdyMSJ
 9/otd+Z2IcvvdGejyVSwCf5G054RrtyL8Qta4hgBB9mlHryKh2Ve2QnlYJDpZgbdvIGI xQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4hwgac5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 22:06:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXuLVQRcVN2tVQvxCJijhW8ZjJNSUL/h4P21rhckCJTpWbeXdbvEgvSzVJNi10Kg5bcUB0FvUF8zqDU/yJZ80Xu2l3OjduD73qcCq6QZHNtfYaBMewtZ0finhT6hIZoxoTXq28H4ee+rVhkDhYiSUVuP312cyh12t3dGj9AQ+jwdXPOyZu0zLxFzACPphJoi8+jsxjw28JnS6VJf+6dD8Iu74C2tpzNRaBqyYlQ6VbfH85DZfWzcRs36orQvd+wDTy8uYcLNT9gzXb9wCUGMD8ZM4aswpxC6dU0WwUoqsEB2b72a+VEhKlJtD56Y1VinQ8UzVbrkljc19LOu9yvzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2yTIpVkXM6zEDqYJHTtrW9wKK0s7GhN6FzneRYKNJA=;
 b=UTBqpvtrxENwhNyC0rGuBYrP79S+r5U3x6o1IxETLSZxF4KgQ1u1Ge8QbLlw0OijBJMUjy24gavM9jQ/P5Nn42TdDuS0TKaWYKJAztwNYRDtL1do4DNFfy7jeWl2ANw08kw5OHKqtdOIbI+ak3CE0FXnuNat/qTdWfrz+u6LrYGbDYZkfQbhU602ToroRXhhvfdG5sq2N5wMfJ/7i287XKCVArGqKXVPZew9BORW9VLDWuygllK+ikzm2XhVLAq99bounGzbAfhExGEaZKr77NzshNw/FBLe8gbC4F0jHnqUDGCoUGyVvReAHr0wjDhU9Y4PJbmD783i5z9GFpkMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5037.namprd15.prod.outlook.com (2603:10b6:510:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 13 Dec
 2022 06:06:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 06:06:28 +0000
Message-ID: <79f96c95-2003-6af5-63a1-04052d3dc01b@meta.com>
Date:   Mon, 12 Dec 2022 22:06:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2 2/9] bpf: Allow read access to addr_len from
 cgroup sockaddr programs
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-3-daan.j.demeyer@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221210193559.371515-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: d829e1da-3184-40e8-a168-08dadcd02c47
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ah/hLfzKH10uXMn6Vhb0iSRTUuD1ryJswoYzTTH/pfNn3SD1dgKdakPLnl3nA15P6NBUn6cHdc54Mx7IoJEsK4eezJ590cbUUStZvy9Q8z+jHOvrxvtV7G8CWe1lokxI089024NFSoF6yb25Dy3EDtZXjUt7mBDfPtE2bqdoimaYSh+RTLf68wWKIqbrbUjqb8E8j1GjurTPAbXPzyESZJpZKIxk9JQg393stxCjrmnSTYLvK5PCCSCT4srjbMxdf86s81N3uuGROQBhMxd4mdZpHW5CbcRl8CjEMZErhYNPjHNzqCYJAI8z7iDoCRl+hmhEvgcjDqeNayujfwityYQLa44T32BBtwCcwatHB5NUWP1YQuUhCHTH9q7yB5Eb6l1b+LPjU3Sejych2E7rVYPmQDzQfq2EHS9tutNHRY26mXzglMcJebArWLAJPZkdS6kuYkt4GGaaca/OJ+YsH3i6EfEa9CtseEiQP7bWxOxmXvcfweesD461N/3vHCZ2yTxpJMBoDP1aWo/2gb9MyfOI7+njg8KncqT60u9G3qfIbTtGvW5IZtdqeenQExdFSceM1kbTdwHfkpqkQx2Lr+Xkz2jMsVXxSsUhKkuf+s0sp8x8AvSCDT13YQhNAolIdtV1qYB/OaHqS75JaiS0Qo5KarkqWLrwl+Y7s+fTLDSBIdGGSh9bRNMmb57rBoAC9TQRL2ZNPrTAGS/VLGcK5yEf8E9i1/Pgri+eFivRjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(31686004)(36756003)(478600001)(66946007)(66556008)(4326008)(8936002)(66476007)(8676002)(2906002)(5660300002)(38100700002)(31696002)(86362001)(83380400001)(6486002)(316002)(41300700001)(2616005)(6506007)(107886003)(6666004)(6512007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxuWTBWYUxCUnR4WUdvOHBGa0VCR3BJTldNb3VqMTFtNWNkN09FL2E5MTVM?=
 =?utf-8?B?SnVPS2FTSk5GTndSdFlvUFhOSWFJOUdvbHpoK0RRSXRVUTlkZXhlUFJCYWFG?=
 =?utf-8?B?WkhMU25kOU5uZFJ1bVBIM1hpUVFaNmJBQ2U1NVBKbFNVeFpOczhCNCs5L2NQ?=
 =?utf-8?B?RGFBRWhFMVN0cytmZWh0K1ZoZ1RwSk9lVlc0Z1BHM3JHYUh4bHVtMzh5T3FM?=
 =?utf-8?B?VXpPdWNxYlVPdnVKN2hSK0lqSmRHenJBWkZ6UUg1eis2OUdCQlJxWk1KWjc3?=
 =?utf-8?B?WWhJcUF5QldxNmJLc0EveWVDNjFudWVwZ24yQVBMQ3ZTYVR2d2FpajBmQVNp?=
 =?utf-8?B?UDlEWE9lRTJMOUl0SGJvaUUrWittbzJiSis4Y3hLem1YR3V1eXF4UWswc2Qy?=
 =?utf-8?B?ZzNVY29vandkWDdIc2FuUkw4NGIxdnpIVjhwanhaalA4MHVLMkdPRllkd0RK?=
 =?utf-8?B?alNVYnQ4TjdKZGtYTnpIdVZGeEMrUWRORC9rLzAzVk81aHZudWNxTWtuSUNa?=
 =?utf-8?B?Wm14UHdKQXJ4U1Brb0k1Q00xSXJWMm5QRHh0bnlXL1V4dFV1TWJ6V1RhSjI5?=
 =?utf-8?B?OGI5VXZ4a3JHWmJZeWRIZjRXb0V1ZEErekVyckpHcndGNnJsblFVTlZ6R1Yr?=
 =?utf-8?B?YVhBd3ZyVFJyOU5PZ3c0Zi9TRmI1M3N4Q3hsV1hqOGQxL2RHMHdwVEpYNjZY?=
 =?utf-8?B?MHQ5UnRXSkVjcXFHSmNENGFoZHZlSU5Vc2dqRGNhV2xGYmxrOElCVS9oV0l5?=
 =?utf-8?B?MndpMGxyOWVXT0drRUlVOFM2ZDBQc1NhUTdTcllPS1JYeVUxV1kycXFweDJl?=
 =?utf-8?B?Ui93R09TdC9UYWJXSjdTN1AyS1E5SUZGT0ZPTkVXOVlCaTYwWUt3TFZ1SHNr?=
 =?utf-8?B?bHJoY01weFZLWm5KV2hmSmRXWGM0RWxJTGFNbzBmVlN4S1Jabk1tWG9ZMnBI?=
 =?utf-8?B?ZUFPbE5meUJDVEJ6T294R3F6azU3NU5SQW5MUW04VFZPY1VRL3lvSkFoaGpz?=
 =?utf-8?B?S3c2YVdpWlBhZFpPeGJ5Ym9sVXFpcWI2RHB0LzNrYklyTDI0em1aR3ZzU3h5?=
 =?utf-8?B?RXpISlExRHZkOW40YkI1NHg5SUhaUklFVkJuWXBRVjhHVFQ5b2pKRWR1R0hv?=
 =?utf-8?B?U0RIM3NYN3FCY1c3enB3dE13MlRtRmtZclpVeFBOT3hNbjVWZXRPL2xRaVM5?=
 =?utf-8?B?Zk44VW82dE5KZ2FSSzZwd2J3d2dpWXZaVDhWWnNmZHRBVU10WVN0TWlYSjdy?=
 =?utf-8?B?ajBlODZOd1V3bmZzWGJPRmVrL01nWSszcS8wUDM0RHdQNDJNUUtQUUcxQ3hM?=
 =?utf-8?B?OWdYMVpITlREQ2hObHF1bUpEVVBlTGN5Zlc0RlVhamFJcnQ1dFV6bEVWVDZ1?=
 =?utf-8?B?bDVQS1cyUnVGMGNGVDdLVy9CSTNGUmxlMHNCU29OMDRUalJzZzFCQ1lCS0pH?=
 =?utf-8?B?SjM0Q3oxUkJNb1hnSGFKWlBkKzF3cENQaFBXMEdSWFlLMnNQajVaelFBOXR0?=
 =?utf-8?B?L1p5bGZaWDVFekRoVFVPcVY1ek1Lb2JtQnRvL2Q5NGJlVVFHNVZiTWZla2I4?=
 =?utf-8?B?Z01SUzlNUkk3UzhnTWhGenFrU3FjVm0vTkVBVEl1bTVJZ1E2aEtiSGMzcEhB?=
 =?utf-8?B?TUFOemFFK3JpZTJGLzZvbGlXeUdnMjNKcHlDc3hhZFRBR3VodXZrV1JJRXVj?=
 =?utf-8?B?V0pIZWsvM3BsZ0lKUHQzaDhKanBXS2IyWHZJTkttNUxtbDhuQkc5bVdoNlha?=
 =?utf-8?B?eVF3OHEwVlBSMHN2VHpIKzExMjBDR3hzNTkyKzNFdWp5TnZoZlE4eWMrR3JU?=
 =?utf-8?B?d3hRNGIveGE3Z1AwdC9iM0FFRmxLTng3eHkweExRdlNFY0k4elV0OFlYdTFC?=
 =?utf-8?B?N3pGMW05alg3bnFIZkhhQlZPbDlzQkdqUWRUNHFRd2pHSXNBdk1vOGVXTGlS?=
 =?utf-8?B?dXV0dE91VHFxelJYOHVNZVNwMW9PTVJIMkQxQ3RLcHdSZjhuM1lVOHRNNWFq?=
 =?utf-8?B?dmhuaTF4N0d1cE0zNFpMRnFiU21zTFA2Ry9iZEZkazM5L01wWHNEeDRkbDgz?=
 =?utf-8?B?RGJEajBCQjFlMVN3Wno1akV6WGlkcFRkdWV4WUZOc3UyU3FrM2hLTzFkaWJy?=
 =?utf-8?B?WlV4Wm8vUm0vZkRxMlFTZzgrUW5lUjZjblh0VDVVcitWWnhwbnU3OFlZNG5l?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d829e1da-3184-40e8-a168-08dadcd02c47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 06:06:28.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXF8XEFtJcD1y2C9PHGWu26QF4wb2VSh9OPekWTOrVUFCdgoIZokutpqjotxIFYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5037
X-Proofpoint-GUID: tMcACmH6QvZ5TZXX_FceBnLvI1AAvO9S
X-Proofpoint-ORIG-GUID: tMcACmH6QvZ5TZXX_FceBnLvI1AAvO9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/22 11:35 AM, Daan De Meyer wrote:
> ---
>   include/linux/bpf-cgroup.h     | 124 +++++++++++++++++----------------
>   include/linux/filter.h         |   1 +
>   include/uapi/linux/bpf.h       |   1 +
>   kernel/bpf/cgroup.c            |   3 +
>   net/core/filter.c              |  51 ++++++++++++++
>   net/ipv4/af_inet.c             |   9 +--
>   net/ipv4/ping.c                |   2 +-
>   net/ipv4/tcp_ipv4.c            |   2 +-
>   net/ipv4/udp.c                 |  11 +--
>   net/ipv6/af_inet6.c            |   9 +--
>   net/ipv6/ping.c                |   2 +-
>   net/ipv6/tcp_ipv6.c            |   2 +-
>   net/ipv6/udp.c                 |  12 ++--
>   tools/include/uapi/linux/bpf.h |   1 +
>   14 files changed, 146 insertions(+), 84 deletions(-)

Again, please add some commit message for this patch. The same for
a few other following patches.

> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..3ab2f06ddc8a 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
>   
>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>   				      enum cgroup_bpf_attach_type atype,
>   				      void *t_ctx,
>   				      u32 *flags);
> @@ -230,75 +231,76 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
>   	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
>   
> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
> -({									       \
> -	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(atype))					       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  NULL, NULL);	       \
> -	__ret;								       \
> -})
> -
> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
> -({									       \
> -	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(atype))	{				       \
> -		lock_sock(sk);						       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  t_ctx, NULL);	       \
> -		release_sock(sk);					       \
> -	}								       \
> -	__ret;								       \
> -})
> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)               \
> +	({                                                               \
> +		int __ret = 0;                                           \
> +		if (cgroup_bpf_enabled(atype))                           \
> +			__ret = __cgroup_bpf_run_filter_sock_addr(       \
> +				sk, uaddr, uaddrlen, atype, NULL, NULL); \
> +		__ret;                                                   \
> +	})
> +
> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)    \
> +	({                                                                \
> +		int __ret = 0;                                            \
> +		if (cgroup_bpf_enabled(atype)) {                          \
> +			lock_sock(sk);                                    \
> +			__ret = __cgroup_bpf_run_filter_sock_addr(        \
> +				sk, uaddr, uaddrlen, atype, t_ctx, NULL); \
> +			release_sock(sk);                                 \
> +		}                                                         \
> +		__ret;                                                    \
> +	})
>   
[...]
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8607136b6e2c..d0620927dbca 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8876,6 +8876,13 @@ static bool sock_addr_is_valid_access(int off, int size,
>   			return false;
>   		info->reg_type = PTR_TO_SOCKET;
>   		break;
> +	case bpf_ctx_range(struct bpf_sock_addr, user_addrlen):
> +		if (type != BPF_READ)
> +			return false;
> +
> +		if (size != sizeof(__u32))
> +			return false;
> +		break;
>   	default:
>   		if (type == BPF_READ) {
>   			if (size != size_default)
> @@ -9909,6 +9916,7 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
>   {
>   	int off, port_size = sizeof_field(struct sockaddr_in6, sin6_port);
>   	struct bpf_insn *insn = insn_buf;
> +	u32 read_size;
>   
>   	switch (si->off) {
>   	case offsetof(struct bpf_sock_addr, user_family):
> @@ -9986,6 +9994,49 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
>   				      si->dst_reg, si->src_reg,
>   				      offsetof(struct bpf_sock_addr_kern, sk));
>   		break;
> +
> +	case offsetof(struct bpf_sock_addr, user_addrlen):
> +		/* uaddrlen is a pointer so it should be accessed via indirect
> +		 * loads and stores. Also for stores additional temporary
> +		 * register is used since neither src_reg nor dst_reg can be
> +		 * overridden.
> +		 */
> +		if (type == BPF_WRITE) {

In the above, we have
 > +	case bpf_ctx_range(struct bpf_sock_addr, user_addrlen):
 > +		if (type != BPF_READ)
 > +			return false;
 > +
 > +		if (size != sizeof(__u32))
 > +			return false;
 > +		break;

So let us delay BPF_WRITE later once the write is enabled.


> +			int treg = BPF_REG_9;
> +
> +			if (si->src_reg == treg || si->dst_reg == treg)
> +				--treg;
> +			if (si->src_reg == treg || si->dst_reg == treg)
> +				--treg;
> +			*insn++ = BPF_STX_MEM(
> +				BPF_DW, si->dst_reg, treg,
> +				offsetof(struct bpf_sock_addr_kern, tmp_reg));
> +			*insn++ = BPF_LDX_MEM(
> +				BPF_FIELD_SIZEOF(struct bpf_sock_addr_kern,
> +						 uaddrlen),
> +				treg, si->dst_reg,
> +				offsetof(struct bpf_sock_addr_kern, uaddrlen));
> +			*insn++ = BPF_STX_MEM(
> +				BPF_SIZEOF(u32), treg, si->src_reg,
> +				bpf_ctx_narrow_access_offset(0, sizeof(u32),
> +							     sizeof(int)));
> +			*insn++ = BPF_LDX_MEM(
> +				BPF_DW, treg, si->dst_reg,
> +				offsetof(struct bpf_sock_addr_kern, tmp_reg));
> +		} else {
> +			*insn++ = BPF_LDX_MEM(
> +				BPF_FIELD_SIZEOF(struct bpf_sock_addr_kern,
> +						 uaddrlen),
> +				si->dst_reg, si->src_reg,
> +				offsetof(struct bpf_sock_addr_kern, uaddrlen));
> +			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
> +			*insn++ = BPF_LDX_MEM(
> +				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
> +				bpf_ctx_narrow_access_offset(0, read_size,
> +							     sizeof(int)));
> +		}
> +		*target_size = sizeof(u32);
> +		break;
>   	}
>   
>   	return insn - insn_buf;
[...]
