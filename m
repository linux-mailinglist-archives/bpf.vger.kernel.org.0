Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E326B39CD7B
	for <lists+bpf@lfdr.de>; Sun,  6 Jun 2021 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhFFFip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Jun 2021 01:38:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFFip (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 6 Jun 2021 01:38:45 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1565aDgN020083;
        Sat, 5 Jun 2021 22:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/zeVCKNCAsdlZ2vCJKkEvflLGAWAIFZ6hsfTx3e8khU=;
 b=RAabQAUHzgBCV/F+5Mw4MvNQoAxG2RDcy9z6Ym3QGobznsNVzzF5Qy3sKrXF/C/9kiY1
 lgA+sGuU7+/rA/B5yZy1gF6HhA4HT2PH78OeO4LvSWUDbmVUTVpaBXY5tTKad3ErIzkE
 /IHL32qIo4tAw4ksDhGosARUCtvkX5iuMAM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3905anuk9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 05 Jun 2021 22:36:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 22:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/lO97yDez282hamn0Kt/yuGwiNC9Q0lvnTuKtfZkbF63sb9oeBqqQ838h4B2TU5S3BCclSvA4OyK5GpN1WOTaoxkJdew6GW2Ta38KG52HnQ1YpNBOAOQsnir471KI4258i3X3HN39qICqSA5TET//GLXTi13aIMWw7sWkh74atMqrhwm2tWT4KASEFiafA1sYdEULz51MfsJh2AxpE6rE7Cc7P6KZ8piZD2YwlKZzH3oiugg1YIJ7slXcetgo37no0XRRAc2ymgO37S0tqZmSPM+eb7MVCm7WUj4BdvcMDpRiBCLDD4uQn8EZdCZdjxcR21RxJ+l8wb5Shhu0nXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zeVCKNCAsdlZ2vCJKkEvflLGAWAIFZ6hsfTx3e8khU=;
 b=kdl2Pu55PNBUMggk7xDq9k6NmOtX3yTFaz38YF5DoVWR75DHAh6zKxcTeUYCuFWs+TK8vsZ5auyrd2xT4/N8zVA0q0dUrJF0f4R7aMo20Odf3tTvzFNIqdoHb/0HkaE9m4zuzzOEbL/nkEzjyHJj4DXLODA1n+vgVIEGUACfWwVYaJqm7IiLyLC9xJLwgYoctngMNSe0zqKkzV34GMwc2HQzt0ibqo8+iTSZ57/M7Uc7J8nRLGlfbeDOO1+ahIonEV4TDkGUNInm7BWwoGTDdiFDpSYVBRTTIleNdB1SnHJB3Zm6MMrT+TlYhaLeAmoCIE8Xq4R/QXdXdhA1Tu32Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Sun, 6 Jun
 2021 05:36:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.026; Sun, 6 Jun 2021
 05:36:37 +0000
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
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
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-4-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f9de1ad9-979e-ed36-fa64-d3c2c0ea9987@fb.com>
Date:   Sat, 5 Jun 2021 22:36:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210604220235.6758-4-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f46]
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a79] (2620:10d:c090:400::5:f46) by SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Sun, 6 Jun 2021 05:36:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d88346-d986-40d5-1cc5-08d928ad0de3
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB203123DAAEA6B1B153D5CE39D3399@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yc4h5JxQ6Za8Nq2N08Oy9/kgmzxji2XxFEFzdtywxEM7GkgS1TfaQXZgGjIZue0yxh1KXlcDQSn1Bijsq7jHYYlg08+GJWHgS+1o129WhCM6Fa2O+ltEg9ApArzE6CNiQGyIi8Jz0QUSqwm3e5zzZ4dpcNGqbpo59kTEqv+FHtM8PrYaxYLpkO41BJZ3+y8Qj1I7eQRZvOrm4Ty/Pe2xMNOFi78KmDtUUQW5oJrRgSaTKbL2L8UJpp8l+Y6qTXYSlrnh8IRVDIyZaY1xCQSOz0M9y2/VCfSlXhJXI0kAcDlEobG1j1k7xrzIAlrTY7RsV5fiM1YkmYWQmFyEr1urfwGfXypP6hdJGMbOnZilKeq/ZC/9UOJHsoLFOE8GYj6lEW2GgOlvlfMDLD2WXR4qqecjbE55wD9agSZpAcWK9TV6Q2HHWHI+BkXC4jo5ixjUn41P0pVV/0rLjHJ2V+dTMU5StMvSU8JXnEJUGus0eRo2fMeL0CE9jrVQqZzoz6ySdWbY9wwIdefWzmy182LrEHM+krG9bC5Zv2yXeVyPT36o83wh3VBlAF4HP5hN6rSxhDu+LsObvKQWIrco7Fz1ANMcTk00UxnEYKOE6mxQam/ifUW6kU68XTAbKv2/yuq9Q3LioulRq/MyLbfnDcpblSBKEBtlCqAmlOe1yWyM1i21XYuwS4wZboJh2a/wvDO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(36756003)(5660300002)(86362001)(6666004)(31696002)(66946007)(8676002)(66556008)(38100700002)(2616005)(66476007)(8936002)(54906003)(4326008)(7416002)(316002)(83380400001)(2906002)(53546011)(186003)(16526019)(31686004)(478600001)(52116002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cm5DWnlPNHpBdzEwbGg4ZkN2VFQyY3FzN0Exa2E2N082S1d3UE1CVW00R3NS?=
 =?utf-8?B?MloxZU9hWDFNVWppaU9aMGxpN1hocWxKcXBESnFhZFVZSm9WTTRFT2RCYXpz?=
 =?utf-8?B?WTE2U1ZmMDdGNHJsMFYvVnBsR3JVQTM3SEU1cjhHVlZHRmordEZvSGRiK1Ax?=
 =?utf-8?B?Zm1pVVQ0SUIzUjZjMm1xRFpRbERNbWRqS0xGeVNaSFJUeEdqL1k1ck1RSCtX?=
 =?utf-8?B?aHlIc2FQcWsyM1d1anVEOWY0a0pYc0g0STVMZHRnc2l5VUpraEIxNm1sNmtE?=
 =?utf-8?B?c29hK0gwM0RPSExTODRQelFmZ1BNYlRYTE4xTDNudW1xc3ZIdno3Qjk1ZTVU?=
 =?utf-8?B?Z2FKd1lHU3dMMTd3b254K01BZ2daYnNxbjgrcEVYOWhZdVlVNFFyQ2NHbVFh?=
 =?utf-8?B?M05Od2RLMzZGZlZSSU5jQnhVM21DU2tEaUhiWFlhRlh4WUdVNW1CVlJzcExs?=
 =?utf-8?B?dUh5ME9hQVFhU2JyWTErdEUrQnRsdmJkaVRBdXgxV1dRaDZYVjl5ajhhVnJJ?=
 =?utf-8?B?K3F6YUVsV29WaS9sT085U0lTeDU1MzJNSlZqcUhnek5zM2RuZ0t2cVYreXkw?=
 =?utf-8?B?YzU2Wnk4ZG54L1h0WlkzTkxjRjRjUnpMOERTTzZraG8yVFBRMnA5N1VyZlha?=
 =?utf-8?B?T1dhN2RBTVQ4K2tOTkMveTNLa1k3dnhpN3k0bUp1YUJxQVUwRzA0bkp1dlY1?=
 =?utf-8?B?YWZET0xHM1ZTTEdydzBscHRQK2JKM3pFeXlUcysvUVVSLzdnS1pKSFlLTWgx?=
 =?utf-8?B?T2R3UDEyc3lubUlwSC9jKzNoZGE2UkZhTExibUdOcXRLTWN4S2llbVhqZ0p6?=
 =?utf-8?B?emJNbWpNT2UvWDJHeU9zOFBRMk1aeGxTOGNuMGNIeWhQM284STUzVDV0U0tv?=
 =?utf-8?B?bnZ5S0xjcUM5cDlSeTA1aFJrOVYwYitNWVkwR2JCdTYvS2RVOVdzRHMrcnZp?=
 =?utf-8?B?UjJGMzVvdHg2Z2NWRG5XcEV3bHc0YXYrYS9MeGlGWWRuNVZmLy9rbUJZMk9O?=
 =?utf-8?B?d09oTmI3MmRPT1ZmTk1xL2s2WmEwWm5sRmQ4REZLejBIdU12em5IVXR5b0xK?=
 =?utf-8?B?bUg1OG5IRzRKZGZMdXZTTCtScHRSUVlxQjJBbEZWMXZjYW1mcG5KM1NUazRT?=
 =?utf-8?B?ZGx4aGJHZ2NJUVcwNVVJdU9ZSDBGRnluZm90bWN5VEQ5NnRUUnUvTHdWenVC?=
 =?utf-8?B?Q2FBeGE4d2xLaHBEVTMwVUdlWWxENHNRQ1RZZWJ0SmEyaXJnQXlLZlJUZmc0?=
 =?utf-8?B?RzIwZFZ4MTBYR1liMDdsWGJiMWgxOEpNQ0JqVDd1RWJHdFBmTUNUWEc5ejdH?=
 =?utf-8?B?WktnTStzb2IrdmNSdlJxd1Z5bHE1TTFVZmxhMnNFK09FVmJsVW42dzVhOEJn?=
 =?utf-8?B?bnByM01UWFJrMmY3Z01UZFhYRjFvakJGOUxPSmFHOWxMV1BGd0FEQzlnSFFJ?=
 =?utf-8?B?eXhaUVk0T3NMdUJPTExqZ2VPaldKZjZpdE9nKzYzdmE4ZUtwVXk3NWs1R3F6?=
 =?utf-8?B?aVY2SE9jVHVCVklQZXZJcXVKeW9ZYUlUSm5OcVp4Vjk5UGVuQVhrR0FFYU1j?=
 =?utf-8?B?WnlERG5VQVo2U0t6b0xPRDhzVkFtM0JwSDBkaUF0VnRUSWwxaXZwWWpZZm95?=
 =?utf-8?B?Z2hxdms3Zlc0OXpKeXlGcjJKbjZ4RjhId1pPajBYQmlpbSt5M1Q2RTRIRVJr?=
 =?utf-8?B?RTZ1bHRLR0hhU0JwVU1pWVRlamJnZ2xDWGluZm4xc1A2OHcyTDdpbTl1b2cr?=
 =?utf-8?B?SHBHc3FLV2hNckhwYWRSaCtoVjRZUHYxMkZCNVZyWWpjU1F1OG1uY3dlakhG?=
 =?utf-8?B?a3JOR1hwd1FwaVlrZkdsUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d88346-d986-40d5-1cc5-08d928ad0de3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:36:37.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLcfNhbm+KYLXPmtmj9LQIQv0JXhjwiV0/IbTpcT1JS0oaG1G7TdlaxkObyPblQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: A-A2n8TfvVWv16tYujmemC1TgS0jSwzZ
X-Proofpoint-ORIG-GUID: A-A2n8TfvVWv16tYujmemC1TgS0jSwzZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_03:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106060046
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/4/21 3:02 PM, Zvi Effron wrote:
> Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
> programs.
> 
> The test uses a BPF program that takes in a return value from XDP
> metadata, then reduces the size of the XDP metadata by 4 bytes.
> 
> Test cases validate the possible failure cases for passing in invalid
> xdp_md contexts, that the return value is successfully passed
> in, and that the adjusted metadata is successfully copied out.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   .../bpf/prog_tests/xdp_context_test_run.c     | 114 ++++++++++++++++++
>   .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
>   2 files changed, 134 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> new file mode 100644
> index 000000000000..0dbdebbc66ce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "test_xdp_context_test_run.skel.h"
> +
> +void test_xdp_context_test_run(void)
> +{
> +	struct test_xdp_context_test_run *skel = NULL;
> +	char data[sizeof(pkt_v4) + sizeof(__u32)];
> +	char buf[128];
> +	char bad_ctx[sizeof(struct xdp_md)];
> +	struct xdp_md ctx_in, ctx_out;
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .data_in = &data,
> +			    .data_out = buf,
> +				.data_size_in = sizeof(data),
> +			    .data_size_out = sizeof(buf),
> +			    .ctx_out = &ctx_out,
> +			    .ctx_size_out = sizeof(ctx_out),
> +			    .repeat = 1,
> +		);
> +	int err, prog_fd;
> +
> +	skel = test_xdp_context_test_run__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel"))
> +		return;
> +	prog_fd = bpf_program__fd(skel->progs._xdp_context);
> +
> +	*(__u32 *)data = XDP_PASS;
> +	*(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
> +
> +	memset(&ctx_in, 0, sizeof(ctx_in));
> +	opts.ctx_in = &ctx_in;
> +	opts.ctx_size_in = sizeof(ctx_in);
> +
> +	opts.ctx_in = &ctx_in;
> +	opts.ctx_size_in = sizeof(ctx_in);
> +	ctx_in.data_meta = 0;
> +	ctx_in.data = sizeof(__u32);
> +	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_OK(err, "bpf_prog_test_run(test1)");
> +	ASSERT_EQ(opts.retval, XDP_PASS, "test1-retval");
> +	ASSERT_EQ(opts.data_size_out, sizeof(pkt_v4), "test1-datasize");
> +	ASSERT_EQ(opts.ctx_size_out, opts.ctx_size_in, "test1-ctxsize");
> +	ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
> +	ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
> +	ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
> +
> +	/* Data past the end of the kernel's struct xdp_md must be 0 */
> +	bad_ctx[sizeof(bad_ctx) - 1] = 1;
> +	opts.ctx_in = bad_ctx;
> +	opts.ctx_size_in = sizeof(bad_ctx);
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test2-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test2)");
> +
> +	/* The egress cannot be specified */
> +	ctx_in.egress_ifindex = 1;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test3-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test3)");
> +
> +	/* data_meta must reference the start of data */
> +	ctx_in.data_meta = sizeof(__u32);
> +	ctx_in.data = ctx_in.data_meta;
> +	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> +	ctx_in.egress_ifindex = 0;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test4-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test4)");
> +
> +	/* Metadata must be 32 bytes or smaller */
> +	ctx_in.data_meta = 0;
> +	ctx_in.data = sizeof(__u32)*9;
> +	ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test5-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test5)");
> +
> +	/* Metadata's size must be a multiple of 4 */
> +	ctx_in.data = 3;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test6-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test6)");
> +
> +	/* Total size of data must match data_end - data_meta */
> +	ctx_in.data = 0;
> +	ctx_in.data_end = sizeof(pkt_v4) - 4;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test7-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test7)");
> +
> +	ctx_in.data_end = sizeof(pkt_v4) + 4;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test8-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test8)");
> +
> +	/* RX queue cannot be specified without specifying an ingress */
> +	ctx_in.data_end = sizeof(pkt_v4);
> +	ctx_in.ingress_ifindex = 0;
> +	ctx_in.rx_queue_index = 1;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test9-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test9)");

Also, these failure tests are very similar. I suggest to have
a static function to do the common work. This should
simplify the code and also it will be clear for each
test what are ctx_in parameters. In current form,
one may have to search previous test to get some
parameter value. For example, for the above, one has
to search previous tests to find ctx_in.data = 0 and
ctx_in.data_meta = 0.

> +
> +	ctx_in.ingress_ifindex = 1;
> +	ctx_in.rx_queue_index = 1;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test10-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test10)");
> +
> +	test_xdp_context_test_run__destroy(skel);
> +}
[...]
