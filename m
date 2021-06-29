Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01683B7A9C
	for <lists+bpf@lfdr.de>; Wed, 30 Jun 2021 01:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhF2XL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 19:11:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45748 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233329AbhF2XL2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 19:11:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TMoqxJ009772;
        Tue, 29 Jun 2021 16:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dw/8nNHot742kS5mX3r3P/6ptFD9YBqQWbJXO7tYs7Q=;
 b=WipLF0W3o0cIt9LgUAfkyZxElnlPpt4DyOqxpiRlmUiHgQoKpxp7dP9By04hNIi9bItj
 zOF+/GdSWzfZ1llIs2w5eVU6Q0KxMjdNUNiiOOTabEJEWQ+UMuuQZeKsT2Dg1KMAD9vo
 8rZi+GUjvljzN1X7Yp/eGsjDUufCXvE0BM4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39fxpsdg4j-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Jun 2021 16:08:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 16:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGZBioqLMSeaWyXItxkVEacYO7/Qg0w1S3k5eYAFYU5kqoYQHrYHvRS78rRALJ/+0a/DuP6sl5ZLEAEM37hLEBv41Sfwo5KHiD9z5OL3tLn7q6TdW96xMH4qzNwCwjdoO99lLViJFxFm1fNI393t+Lw4+NM11lvE1VejtP3nYs6fGKFBZJb7Pu9jIR6ql6pRrSJsdKqtMPWyvp2URimaCAWT7Vf7apbiP8pZsay1UY0thE1hHCDRRT2lcGVFdh5LfoieDBdDHd2rD2Jbu065rH5tWGftu8cNYvb8SVgExbMcEZoeVNeISj/2INg08jBQCDhZXyg5Al/VriTjYaBUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw/8nNHot742kS5mX3r3P/6ptFD9YBqQWbJXO7tYs7Q=;
 b=HDOxzcv2//Uys7zPjNWNgGtraHNyPl7QzCieFTguHbPA1vcFa3kGkBrXe++uB3iYHRLQXcP9h4TLSiPqw7WIfOdROHWV56Hq6tleu0U1B309B1L8w7fM3vaznFy5RTCQgTxsXd7j2hcOvSLnjWKp09d6bepQmVZ1cuiSsSbW/GIUgqBo75G2B9JW/bag0Gfci4D01Sn5CZaqe2H70xq4ijzjby68FdZv00C1B/AuEdt3pvSW+xa0jrtHpnAEhqXrPhmlQEtPoDlptlY+petDSQXELyo9mA+WTt5Rj3UVTJUrJmn7mq8xirZU2UAbfwXeDIYbYmp0NXxCYYXNylDcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2256.namprd15.prod.outlook.com (2603:10b6:805:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 23:08:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 23:08:57 +0000
Subject: Re: [PATCH 3/3] selftests: Add selftests for fwmark support in
 bpf_fib_lookup
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
        <bpf@vger.kernel.org>
CC:     <dsahern@gmail.com>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
 <20210629185537.78008-4-rumen.telbizov@menlosecurity.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <19658dd5-d872-1c9e-475a-120d0674ad7a@fb.com>
Date:   Tue, 29 Jun 2021 16:08:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210629185537.78008-4-rumen.telbizov@menlosecurity.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:d69f]
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a57] (2620:10d:c090:400::5:d69f) by SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 23:08:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899a2d6f-3458-4b36-f3ec-08d93b52df69
X-MS-TrafficTypeDiagnostic: SN6PR15MB2256:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2256AE66DFBA0E326EBE8481D3029@SN6PR15MB2256.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfCdYnkHyenkaaUd8AEqBwkZ6dUpT7jBGzO+Ksy6fFn2UzHeQrU42mfbnf045N5t8NNDNOAu1+gzET7CRrauMLABdCNPZSKS5Ly1ipP6S4JpZE0i5sHdIzdkM4pr2HoK7I6gyZutMZHySZ0UhdoM2v3IwoaVlOKNYDigXqC5telQBfkg7Pivl2YH1X/ZA6ABvUHjyIFmi5njyogPVNReqNS/vTXdud6WlbsKWFjFaQ2Vprli3DJpOlB+MiwMcrehpVmuDPqlsD2XBn8LlM7e4HBDckMQxNSy1bmI2oivqL++UzWqkVBemlkG68Nmv73eU8sJs7CJyEYgzJzmxa6Do9lWr9iEONQjQpC+W/keHM4eT/FL67G+ycKi1YUzK7ouOG4t0ahbWIrzW8wamnQJgW4J8sFrT1OIMwBJ76JGs1iywpujBEa3G6S1vxXv01/H6hSEsfWlPDLqPX9LPphLEYAtoq5VpzzVhTv4T/bgmTzVtZ5yZXL3WvEm+WNCrY7ktkDRZ64FgZsZnqRpksCZBy1EbN4q1WIysVwc31NklsczvGcnxVVfxbSd5/IQ7hle49CSUxzdaiDwIELmA4UmvvSWqJZf9L/SFxkjXDcvq3rsT3uzN4T5TT80AqQ0VahI218njW+Y6QcuGwu9HbY9hJz0Pi7CkKkHDngJbCuIjuv5ZvOB1nBU7uS8eHpawwLFuOyeSXi4/1eF8PK51qa/952MbgRPbRo3pmYOTviGdlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(86362001)(31696002)(83380400001)(478600001)(16526019)(4326008)(2906002)(186003)(52116002)(38100700002)(36756003)(31686004)(6486002)(2616005)(316002)(66556008)(53546011)(66476007)(8936002)(66946007)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lyZlBLaVlyZWdoaktPd3ZRUlRLdTJuTmgwY3h1aUhoeVh1SHUxUU50VGVJ?=
 =?utf-8?B?WXpKaDZGeTAxVGl3eEpYUUl2Rk1mSTkrTEpqaStHZ0dkWXZ4M0VPQVRoaG14?=
 =?utf-8?B?cTdaaUNEK0NuVGREZXlXemc4VVVkVk9LdWorLzErWHhRenBKWTdLTWI2Tm5r?=
 =?utf-8?B?Vyt3MlhTVmV5QzhxL3ErOG5nR0daeTdpRFZXWGZrOE10ckZhVEtwVy80aC9F?=
 =?utf-8?B?a3lJdmwwUVRhc0x0WDdNVGhkeHdBdEdXT000ZS8yTHFIZDBrMEY5MzZJejVH?=
 =?utf-8?B?TldWSjBHMWFKQ2RrRldTU1Nka0tIWWp0WFFtRHdxZDhpTFdjYmdtajA1Ulov?=
 =?utf-8?B?VGVFR0pNY2hmTjl1ZU45WUtKWHd2SVNBM3BQbCt1SGYvTjFPVGYyMEFhOHlo?=
 =?utf-8?B?WndMVTFhR0ZIbEFCbVhUU0Z0RkZVZUlNMXp5cTRHL3JwY3lwSGVaM3MrTDVz?=
 =?utf-8?B?U0FTdm45N3hSUHNNN01aSlpIVzdQSE9PNGVPcDFPaks4cXNsR1c0bnBDNHhj?=
 =?utf-8?B?ZUVZRHpINHgyRm5JMS9JU01FSklIUTJZVURUMWlUd3V2dXpINDJBTFc4UGRC?=
 =?utf-8?B?dklMdGs5L0k1Y3pwQVMyWlR6VzBtd0dUS2t2VldheEdUS0M1OUl5RDRxUkh6?=
 =?utf-8?B?RWx6bFM3MjZpYk41L3RTOUl0V2ZpK0lPemdrQmNwRnhWbW5kcEpTWm1Wc0ZZ?=
 =?utf-8?B?UTRqMC9JaWkxcGFNQlpXa3BwS3NMYmNaYlM0UG52YktkdkdwQmd0SkhkbHM2?=
 =?utf-8?B?YlNFUnc2VWM3dEVTaDdtYVo5S0pPTDNha3h0S2RnVExrVGRBbWVRNDJhYWky?=
 =?utf-8?B?RWw5Y3JzSnRyS20zYTBXSFhzK2p0Mk5Lc3VhelUzcGJydTFxblZGbXQzTzdC?=
 =?utf-8?B?TXB3V3BzaE13elhwYVVlRkRXTUxiUkRvc2FIS0J3TUJ3L25CcTJxZHExeHk4?=
 =?utf-8?B?UG0vZi9LeVA0N3VDVmQwaUtqMjgrSDI5dmdrbHpDVWZWQzUvS2trTXZqeEJH?=
 =?utf-8?B?NzNMN2FidzZ0T2ZwVUhCV2k0a0M0SjZoOFYyZ08rMWI2WlBVODhuZnVNNlZp?=
 =?utf-8?B?aXlJbk5ydGJMcWVqdjU5cERnTEJPd1dqYlFGZC9RYTdoZ1dVdjAyQzFiTk9z?=
 =?utf-8?B?VmlkcUtyeUVZSmNjNC9xeVFGUzhOeldxaUhydWtMVElodEkrQzJZMjk1UmRn?=
 =?utf-8?B?RW9Td2l5ZURDR3FIenBCSzN3NFY4T0dVMXU3REtqQnFwWXNobk1MSXd2eXhO?=
 =?utf-8?B?VG9WZWd2cUxlc2xxQk9UTzh3bzFGZnorMHQ3ZFhVMHNpZWZuRm1LUHRLU044?=
 =?utf-8?B?cnFjdHFYYzh0WkxpL0dzNEx3ajZ3SUo4a2xJc0YyeVhOeXdVK2o3aWIrQktz?=
 =?utf-8?B?amVPVnZJSmlsVHRpQmUyK1BoY1ZoZG9oUEZFQjBTMDJQYnhwT0xTa2F5aU5z?=
 =?utf-8?B?ekZ0b3FwQzJ2Q29xd2U4ZTZ1b1pHQ1dhVHc1UGZnYWx0RVBNS3lScDVpOFpT?=
 =?utf-8?B?aU5LR29oVmJ2b1Iyb1ZxdDRVS0E0anFpekROZHpBbzhtY1FwcFRhY2x0cWpF?=
 =?utf-8?B?RTZPU1Njdzh1MWtaa004dGp4cks5TjZPUVVoNmJqSmliZWkxMFpyUXJ2bTBs?=
 =?utf-8?B?UU8vWlFpSmV0UEM1Z2NIdTJRN1NLOXdBTHpuOS9QaGdHZmFoU1RYOGlhWCtE?=
 =?utf-8?B?TVAvdnhWUjJoTmF3MEZHMUlRbXJ3b0NIMUY0MDlPdXFhS1djUzVPcXVpc29T?=
 =?utf-8?B?T2NIY1Q4NzgvRGJETHVsSzR4RzluUU1WRFVlalc1MS82MmM4YUJQTkFxTWtX?=
 =?utf-8?B?VGJKZk54T01EMDhaQzdYUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 899a2d6f-3458-4b36-f3ec-08d93b52df69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 23:08:57.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQiIUchuB18oF9k87lb0oM2c5BoB52n4BQUplMGuRYy4PE6eQb9gw36LVph6WFMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2256
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0nq2CkPIO6e2_NS2BGcdBITOJK4nMKDd
X-Proofpoint-ORIG-GUID: 0nq2CkPIO6e2_NS2BGcdBITOJK4nMKDd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/29/21 11:55 AM, Rumen Telbizov wrote:
> Add selftests for ensuring:
>       * IPv4 route match according to ip rule fwmark
>       * IPv6 route match according to ip rule fwmark
> 
> Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   1 +
>   .../selftests/bpf/progs/test_bpf_fib_lookup.c | 135 ++++++++++++++
>   .../selftests/bpf/test_bpf_fib_lookup.sh      | 166 ++++++++++++++++++
>   3 files changed, 302 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
>   create mode 100755 tools/testing/selftests/bpf/test_bpf_fib_lookup.sh

It will be great if you can incorperate the test into test_progs.
You can see selftests/bpf/prog_tests/sk_assign.c as an example.

> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 511259c2c6c5..afbac539e20d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -73,6 +73,7 @@ TEST_PROGS := test_kmod.sh \
>   	test_bpftool_build.sh \
>   	test_bpftool.sh \
>   	test_bpftool_metadata.sh \
> +	test_bpf_fib_lookup.sh \
>   	test_doc_build.sh \
>   	test_xsk.sh
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c b/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
> new file mode 100644
> index 000000000000..e4bbfb01ab86
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * @author:  Rumen Telbizov <telbizov@gmail.com> <rumen.telbizov@menlosecurity.com>
> + * @created: Wed Jun 23 17:33:19 UTC 2021
> + *
> + * @description:
> + * Perform tests against bpf_fib_lookup()
> + * Communicates the results back via the trace buffer for the calling script
> + * to parse - /sys/kernel/debug/tracing/trace
> + *
> + */
> +
> +#include <arpa/inet.h>
> +#include <linux/bpf.h>
> +#include <linux/pkt_cls.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/if_ether.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define BPF_TRACE(fmt, ...) \
> +({ \
> +	static const char ____fmt[] = fmt; \
> +	bpf_trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__); \
> +})
> +
> +SEC("test_egress_ipv4_fwmark")
> +int __test_egress_ipv4_fwmark(struct __sk_buff *skb)
> +{
> +	void *data      = (void *)(long)skb->data;
> +	void *data_end  = (void *)(long)skb->data_end;
> +	struct bpf_fib_lookup fib;
> +	struct ethhdr *eth = data;
> +	struct iphdr *ip = data + sizeof(*eth);
> +
> +	if (data + sizeof(*eth) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (eth->h_proto != htons(ETH_P_IP))
> +		return TC_ACT_OK;
> +
> +	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (ip->protocol != IPPROTO_ICMP)
> +		return TC_ACT_OK;
> +
> +	if (htonl(ip->daddr) != 0x01020304)
> +		return TC_ACT_OK;
> +
> +	__builtin_memset(&fib, 0x0, sizeof(fib));
> +
> +	fib.family      = AF_INET;
> +	fib.l4_protocol = ip->protocol;
> +	fib.tot_len     = htons(ip->tot_len);
> +	fib.ifindex     = skb->ifindex;
> +	fib.tos         = ip->tos;
> +	fib.ipv4_src    = ip->saddr;
> +	fib.ipv4_dst    = ip->daddr;
> +	fib.mark        = skb->mark;
> +
> +	if (bpf_fib_lookup(skb, &fib, sizeof(fib), 0) < 0)
> +		return TC_ACT_OK;
> +
> +	BPF_TRACE("<test_bpf_fib_lookup: test_egress_ipv4_fwmark> fib.ipv4_dst: <%x> mark: <%d>",
> +		  htonl(fib.ipv4_dst), skb->mark);

If you use test_progs framework, you don't need BPF_TRACE any more.
You can assign these values to global variables and compare them
in user space C program.

> +	return TC_ACT_OK;
> +}
> +
> +SEC("test_egress_ipv6_fwmark")
> +int __test_egress_ipv6_fwmark(struct __sk_buff *skb)
> +{
> +	void *data      = (void *)(long)skb->data;
> +	void *data_end  = (void *)(long)skb->data_end;
> +	struct in6_addr *src, *dst;
> +	struct bpf_fib_lookup fib;
> +	struct ethhdr *eth = data;
> +	struct ipv6hdr *ip = data + sizeof(*eth);
> +
> +	if (data + sizeof(*eth) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (eth->h_proto != htons(ETH_P_IPV6))
> +		return TC_ACT_OK;
> +
> +	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (ip->nexthdr != IPPROTO_ICMPV6)
> +		return TC_ACT_OK;
> +
> +	/* 2000::2000 */
> +	if (!(ntohs(ip->daddr.s6_addr16[0]) == 0x2000 &&
> +	      ntohs(ip->daddr.s6_addr16[1]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[2]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[3]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[4]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[5]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[6]) == 0x0000 &&
> +	      ntohs(ip->daddr.s6_addr16[7]) == 0x2000))
> +		return TC_ACT_OK;
> +
> +	__builtin_memset(&fib, 0x0, sizeof(fib));
> +
> +	fib.family      = AF_INET6;
> +	fib.flowinfo    = 0;
> +	fib.l4_protocol = ip->nexthdr;
> +	fib.tot_len     = ntohs(ip->payload_len);
> +	fib.ifindex     = skb->ifindex;
> +	fib.mark        = skb->mark;
> +
> +	src = (struct in6_addr *)fib.ipv6_src;
> +	dst = (struct in6_addr *)fib.ipv6_dst;
> +	*src = ip->saddr;
> +	*dst = ip->daddr;
> +
> +	if (bpf_fib_lookup(skb, &fib, sizeof(fib), 0) < 0)
> +		return TC_ACT_OK;
> +
> +	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<0-2>: <%04x:%04x:%04x>",
> +		  ntohs(dst->s6_addr16[0]), ntohs(dst->s6_addr16[1]),
> +		  ntohs(dst->s6_addr16[2])
> +	);
> +	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<3-5>: <%04x:%04x:%04x>",
> +		  ntohs(dst->s6_addr16[3]), ntohs(dst->s6_addr16[4]),
> +		  ntohs(dst->s6_addr16[5])
> +	);
> +	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<6-7>: <%04x:%04x> mark: <%d>",
> +		  ntohs(dst->s6_addr16[6]), ntohs(dst->s6_addr16[7]), skb->mark
> +	);
> +
> +	return TC_ACT_OK;
> +}
> +
> +char __license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh b/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh
> new file mode 100755
> index 000000000000..4b8cc984b486
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh
> @@ -0,0 +1,166 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# @author:  Rumen Telbizov <telbizov@gmail.com> <rumen.telbizov@menlosecurity.com>
> +# @created: Wed Jun 23 17:33:19 UTC 2021
> +# @description:
> +# Test coverage for bpf_fib_lookup():
> +#  * IPv4 route match according to ip rule fwmark
> +#  * IPv6 route match according to ip rule fwmark
> +#
> +
[...]
