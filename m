Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C863AACC6
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQG5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 02:57:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229515AbhFQG5U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 02:57:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15H6risM008495;
        Wed, 16 Jun 2021 23:54:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=r/GeExurHj91g6+QqSd5Q4wy1NhGPHHZGcnLx5azB5s=;
 b=riqQzJ+HJUSAnds2A2L4JWunT510sxxSA9F6jS3XQ3ZKM7VUL4PnVq8V8Cl+u+Bdvj9h
 xloXr4Uz8cP6W1sY8oaitUSa/NEbWCM/J6tA5DUM/Tudy1UqfGM+78gMBPKK+Qoa8jRx
 SGK26J8x8E17GxFSrBfu7haJJgEAjROEiZ0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 397tf69y7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 23:54:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 23:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC1z97aXQk4/VVRPpyFhIEjuKr2m5IWW7S2j3qQGYHwhFgOls/aJzcjAk2fuES0sfnu+LQu60+uhg+oG2eMAOONRs9gn1d5T2ylQ6Z2x6ngLJ4iMSHDXQ2BRHrUVmVU+5jyZYqdv1JCbJzRnShuGQw0BDOKcu4MeFNMbV0YlbYb4RmSHlYFPyqyjPeE3Z/25cWThlT1c013hkbqHi78W6vTi1U56/3rybyrGuG0bS7JBBhpmMXWzz/vpHIdPFC7uIRNJ3yb61TfUo9NNMUmRPy8XJ8XjErIBIrcNOLrLaZlgx6/pyWiinXU5tJqJ5YpomLoxMGASnjt1Zd61sJ6aRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/GeExurHj91g6+QqSd5Q4wy1NhGPHHZGcnLx5azB5s=;
 b=TgFJUdCsLKGT4Kef9cOLUxvOYvLxyHjypSHCu8gLxxWK65+Z/edO+GqK+DesWIg0GdE1OJ5LPJLXEy+Z+mAfIPEo2G9+7Y3Wh1RfDukeWXQf06Wc4JAbZvp+pAn84kaqbFj5oLj9yJZrcnYzHeHik8nHsBDDQYn4uNws6T9p0mQ1RwuZmFt+yb8NFnyVqd/VcbKoBf8trE382ewsNPrvbB84MaDbM2IQoNZjDTKJC618iyrwyRDKWVz/Zvgs36kdB6YYwnwmKs7Zc5Ak5Bz8Ep5exix9/+DLgojLGRP+8vghF27gPyxw8XOaN9/euH3d7e8hjlYsfjCoQFEe4MQCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Thu, 17 Jun
 2021 06:54:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 06:54:55 +0000
Subject: Re: [PATCH bpf-next v5 3/4] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
 <20210616224712.3243-4-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <039ecbf0-c08b-8c18-b030-e902a1ded9f0@fb.com>
Date:   Wed, 16 Jun 2021 23:54:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616224712.3243-4-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6d3c]
X-ClientProxiedBy: CO2PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:104:4::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:6d3c) by CO2PR04CA0159.namprd04.prod.outlook.com (2603:10b6:104:4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 17 Jun 2021 06:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d04f146-96b2-4ef5-e981-08d9315cd043
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2031A0D1C4F25C4D3215BAB0D30E9@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPMTpFfQr/cgMF2g94wnrMx9JzdNtkv4GymyINQihm2KYwYk1Lk9Wzr1jZURKGYNCy7pYhmGUxUq4Lf/y5xivzGscop84DmozWjXvazAJk8OV8xKm02IzjaJEp2C45tirtdfgHeaNqxOPJkQuCkRp8w/TweQu0+ljOSTTGtW7evc3Rj4gFBHuPK/P+dI156csY2gpjlEhPME0OP1MdYv3n/i9xd/8h+PuKHbFwsxGbCeOg/+nBcaH+wjT+RHV6LEAVdh08tJGJq8eUWcbsC6dCWgURa6981fnuNROpenF1M47Y4Q+hsLuMKEzgSjl7Bk1FNV1c9agIsdc2B6hdzgU30IuDMg8sZ1A5pJ1/jC4gJ0lZENr7Gn2/29rPCZrRgiCxtZT0FjY2h9iZ7Yz/7EQgWs8D+K5YuoMaWQEYUp8J2euylF9wXSGqh/p4i7hnBJk1gP6HzVE79YSgYIdj2yDaDqQo5q3GxRpBuBOoLC4lFAuTBKcVCs4exTDvwZHJfT2+UyUiaRfoDqnEXooLxboCFW43w4mh1x44mHCm9B/ycQ+MBlI4bfAC4yR0IOOcVtldINHAA7/eRjdR4dJS+R/jfGuyfDEFRMggN5TLTmkwnmlhzto/vIxhCdtZ00JVBMRSTYVt18MNTXIoIedAZyYxA5+yAzd9QJjYcieihyUdUqxe1Av+RLRRMDLp6jCAGi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(4326008)(8936002)(54906003)(66556008)(36756003)(66946007)(186003)(16526019)(7416002)(6486002)(2906002)(478600001)(66476007)(5660300002)(31696002)(2616005)(31686004)(8676002)(38100700002)(6666004)(53546011)(52116002)(316002)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUp0Y0N6UEd4a0ZCOXpRdGRSVk9sZWRma0FuZ0d5TUI3VFp2Y0hqbCtmdmFP?=
 =?utf-8?B?OGU2SEV0eVJWbkRwamhuYlNWWWN4Y2hsZlVWN2hoeWZhYjFmSTh6MzZYOHNa?=
 =?utf-8?B?OW1uWHRWdHB3eGNOZGdjVkhlOVhLNk8raDQzSkhDL09QY0l3MFRxeWhPN01x?=
 =?utf-8?B?VTl0ZmJqKzhuK3BBTlVxbjRKUVVodm1Rd2Y5U3QxWGZmTGRpSkJDbEt1WGZJ?=
 =?utf-8?B?djZ2a1h5aXlMVGVoWmEyT0QwSUdXMVA3Y0J4ejNFM0U1eG9mOG1sRmtxWUFn?=
 =?utf-8?B?YmgxemNFMTBPTGZ2WWIzdUJBQStNSm91d0NPWjlaWVo2d1J6MlJYNzgrZno2?=
 =?utf-8?B?d3ZzU2U2UzYzNDBNZXVPTXlUVy9oVnMzYk0wVllERERXQVI5WlZNS1RmaFUy?=
 =?utf-8?B?R25XMXFuUUtONmdkbXhDZVVxc1NlenVhT3pXSzZSazFnSmY4Q2M2VTVvNTFG?=
 =?utf-8?B?N0EwaUMwaVdtNU1OZS9yVFBmd3lFdkJ6cjZTWmNxNnFYRGVwamdTY3Y3U2lE?=
 =?utf-8?B?bThZd2Y0b0FEakpYS08ycEJweUdIMGFIS0hNR09CUnF4ZVJOUkpNaklySXhF?=
 =?utf-8?B?aTVjWXVIZVZENXhKSnQ4YUNyeFpkL2I3ZDNDU0pmYWtmdWtwSDA1VHgzeXNp?=
 =?utf-8?B?U243MkdESmlDT212azhUUmNKbUJPdVhzKzR4bXVFZmJBNTJ2SE9TaXU1NGI4?=
 =?utf-8?B?SVZDRTUzQ01OdmxOaFd5VVhicVhrRmZXQ2VySnpMWllNaS9CK2ozZWI2VVFH?=
 =?utf-8?B?VXVWY2F3TURzend4cWpIL1AzTUdNYUd4UU50dEhQWHBLSXdMZEtuREV5Mjh3?=
 =?utf-8?B?K25RSWg2QUtKSHl6d0RLTCtGazVuOUdTcU42NW5oWCtIMlR0MU55NWZkcDN2?=
 =?utf-8?B?N3Z0dU9NV3dnZEtDYkdiZlZwWHZJRndsRmhrSzFWQlFKV2QyazFrVE1hZG1T?=
 =?utf-8?B?YTAyVWdya084R2hRSjMvOGJvR3YvRXlFeG9DR3M1VGJOWWtxdUZLc0Mzc29C?=
 =?utf-8?B?TjFzRngvZ0c2bEVRZ29sS0FrTTRqNHhOTzdMQ25BQnZ0VDI5TWR1OHZBWkp1?=
 =?utf-8?B?S3BkTFI3NEdIdjNZQlRRcXFPWE5YVWsrY1lMNzJIaW05OW1SUkM5S2ZudEU1?=
 =?utf-8?B?Ylk0bTZta2pXcHB2ZWJ6d3NNeU5PSnlzc2JXcVhhUnZNWkZZNGFLSWJneVNr?=
 =?utf-8?B?SWR5Q2FQdmgrUUE1OXBBZ2xpeHhrQjdwRjhvazd3ZDByWFNFamRWcGxVSnQx?=
 =?utf-8?B?OS9rNzk2ZVFOKzVBcDNIcHdyYmxZQTVMdHpIaVVJQ3ljV2M2b0Z1d0w3dzNY?=
 =?utf-8?B?MkFWSWRXWmE2SGp2dzgvdkdqR1BYbTVUeTF3dGtWZFdRR0ZQMzc0OUR1SkNI?=
 =?utf-8?B?S0dmRkpwbmwwTXVCQ1N0bjVKM05PZDhNOTJHc05ZUUphMTNKbW1teDJ3OGtm?=
 =?utf-8?B?bHZCejlodHppWndDWVIvbTBzeERTNE1Ea29xVXNudFFyZjI5cExxaEFtekZO?=
 =?utf-8?B?c2kxZVpTMFdxeUFzUE9RaXc1NlBad0dMd0tjNmtSMGt6amVqSmtQdy85N0tK?=
 =?utf-8?B?UlZITWlUeHpzMnpFdTloZ3JiWFZZMTNtSGxBVERWT1U0WEdYc0NLU3BKci94?=
 =?utf-8?B?cWthMlBvZTRXZGx1MlVya0tFNG05cklmN3ZhdlNITE5CcFlsTCszYTVyYnQ5?=
 =?utf-8?B?ek9lME83Qm5sYUNrS2M0MENLVG9wQlBVNm8rby9JN2R6Tnp4S3BrWThMd3hv?=
 =?utf-8?B?akNiT2pWa3g5bW9ZOHpJTW1FMkZNSlltRWw2MGhpRllXRTZpamJCVlRYSTRZ?=
 =?utf-8?B?Tjdjb2xRa2JTTjF1MUJwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d04f146-96b2-4ef5-e981-08d9315cd043
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 06:54:55.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug454nMFpqWxdjETIfQ/z+3jO7DtDAxXCHyFZq+Gp2xpX5fONZoIMDooWUf8wmoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: fcRvVGdhEDq_7DNrPj_oJRbntdEK7kDI
X-Proofpoint-GUID: fcRvVGdhEDq_7DNrPj_oJRbntdEK7kDI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 3:47 PM, Zvi Effron wrote:
> Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> contexts for BPF_PROG_TEST_RUN.
> 
> The intended use case is to allow testing XDP programs that make decisions
> based on the ingress interface or RX queue.
> 
> If ingress_ifindex is specified, look up the device by the provided index
> in the current namespace and use its xdp_rxq for the xdp_buff. If the
> rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> 0, return EINVAL.

Let us match actual implementation.
    EINVAL => -EINVAL

> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   net/bpf/test_run.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f3054f25409c..0183fefd165c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -690,15 +690,36 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
>   {
> +	unsigned int ingress_ifindex;
> +	unsigned int rx_queue_index;

nit: the above two definitions have the same type, let us merge them 
into one line.

> +	struct netdev_rx_queue *rxqueue;
> +	struct net_device *device;
> +
>   	if (!xdp_md)
>   		return 0;
>   
>   	if (xdp_md->egress_ifindex != 0)
>   		return -EINVAL;
>   
> -	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +	ingress_ifindex = xdp_md->ingress_ifindex;
> +	rx_queue_index = xdp_md->rx_queue_index;
> +
> +	if (!ingress_ifindex && rx_queue_index)
>   		return -EINVAL;
>   
> +	if (ingress_ifindex) {
> +		device = dev_get_by_index(current->nsproxy->net_ns,
> +					  ingress_ifindex);
> +		if (!device)
> +			return -EINVAL;
> +
> +		if (rx_queue_index >= device->real_num_rx_queues)
> +			return -EINVAL;

Does rx_queue_index = 0 is valid? I don't know whether it is valid
or not, just asking.

> +
> +		rxqueue = __netif_get_rx_queue(device, rx_queue_index);
> +		xdp->rxq = &rxqueue->xdp_rxq;
> +	}
> +
>   	xdp->data = xdp->data_meta + xdp_md->data;
>   
>   	return 0;
> 
