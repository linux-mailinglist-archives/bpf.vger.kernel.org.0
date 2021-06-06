Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23C339CCBC
	for <lists+bpf@lfdr.de>; Sun,  6 Jun 2021 06:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhFFEVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Jun 2021 00:21:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15496 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhFFEVC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 6 Jun 2021 00:21:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1564Is7A006040;
        Sat, 5 Jun 2021 21:18:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=n5kK6XUf2XrTDEDUIVM3H6vPH5o+5eUQ3DEiQCbulgY=;
 b=eH/Swo04m16eVntYKS0Vv2oReIr4j5Ac2BqeC+3XfNOJRyNnO4JGF8l2x1y7BUh50x/c
 4xONhOvIAsETEFp7EpluknLD4uqvbu8BM6BXjdML2SSvvcjzOG8A81I2wSMI88Gz62Sb
 bH0Z0mUXrIUH9VHNOAFFly4rqA6DuzbMbYI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3907132x2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 05 Jun 2021 21:18:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 21:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InDwzG3O7lE4e485OE3ABAX+Xwafh37r3Y8w5/KcdCWoA+O51Fcm9/vHIzjti4kRRABVTvaZZLVUeQo6g0frL3aAKdvM7l+jET09Atvs458BgrdYRT+kZgj7vytCdrs58s6m0TKNTYx6bYttAGSAr7YHdnxutLHDfYn1T5vf2hjZTo7hJteiW47tfxmGOL4sjvv6JLDaem18X+h2aQLLotr1DtaeI0XDVzwhgSJ8g1jEw8bCMz5voKB+4TQYd8RjNfofwZll5jeAlAEyuPUeGR1z7UfYNNodtunPW0b/Rwd/BSw5JqDJkxhuw89kFVPlYkY2sXbsukygZnTT5dCz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5kK6XUf2XrTDEDUIVM3H6vPH5o+5eUQ3DEiQCbulgY=;
 b=CzdAZyje373SFJnRr0/YVfvf/UJ/ziyq7MO2hnCQfXW7g1kbArsAK0A9yiwFc1Wt0Vv9mj6oPesv7hdfojbWYpMlGpr4EMZwg3KZIQMbhBBbR1KkbepInT/hvpYV5DUYz7mMjQk4MAHLFLG0aaccql1jJFBrDCz37ffRQyNGJdU9xVJsVVOJjLeChdeukyFVeCYy4h4bOax7Wu2cKO1cCBQyG46LwOybuTYugyMSBdbFCp8Z/1jvRXyvhwZD6jCpaAr8g3eVT5K0QH8u3OjtNdPC+nMkdepJd4lH+BD7uQSSnm9GefaiFgPXkBQw66NY2qNI23OcnyhpCxgzbFvQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2480.namprd15.prod.outlook.com (2603:10b6:805:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 04:18:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.026; Sun, 6 Jun 2021
 04:18:51 +0000
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
Message-ID: <960ba904-9e5a-9345-4ff3-73c3eb8a82bd@fb.com>
Date:   Sat, 5 Jun 2021 21:18:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210604220235.6758-4-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f8c6]
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a79] (2620:10d:c090:400::5:f8c6) by BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 04:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 201f12b5-378d-4661-8da7-08d928a230be
X-MS-TrafficTypeDiagnostic: SN6PR15MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB24806D3EE6BF9495B908E839D3399@SN6PR15MB2480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SChKBLKeK8E8gpavl6m1Y/MNNzENtVz4vZ6rGQzxDeCwUjKjh9A4QxO6hYGT9w8yHEQLekmLODGChll/jZwbUNy4Ig8dMg+sVpLxuWCSo6503gj3bIoFLLYKqMOVhFPGP533adW/2CXPEG4r9IZIQzJHFhfAcWuPuJzIlO0DioCe9ohXcuNyHvg8wXJ+hrWaY8cldmXRqmRDHmDpN+tl1bZDsXmhSbCyBq8bzHE/ZeN2X7i6f7bBqjL6bsWsyLpI2M7lE9sWTxa2Q3k1kJZgRpPHlzJeLs2R2OaVCdCOunDBLSMlXQ4rjY8BcpAFRo+/Y01Gt5MvQtplqywtRcyeMzv0IkO8rr/+6wSHqiIOsDSlpsSkXSLEq5uCCW3yXAnloSukYBabMwDkRKGNrGxpvptiGbOO2A941AH6BLW+Taz4cr7FAJ/aaYZDuTOwbuu2KLxgOK39lvqxZQ4//h7GQkRIoY/bUmzdMpKwb6KgqfTTEdFXP0+HQ7PW1jBkVNoiTbwbUpNXYgn7/M5GnKZLIOY9vnDYhWU+7T9xsNW/ef8Br/hmS6Bts5d0SNEsxS48ugG/sQTfp0Ab3fZEcWxZGyWG8JXWQNJT32DRurFZ7NCH5Sd7mvoPeBlGYhcKG02FMSViVJabPGpuZ4nBd6ZpwU2jUCEBxua4DA2zxs9+Zl4Qa62k7bw84dIT3u5oTTWY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(8676002)(36756003)(186003)(86362001)(16526019)(53546011)(478600001)(2616005)(66946007)(8936002)(38100700002)(66556008)(66476007)(6486002)(54906003)(316002)(5660300002)(52116002)(4326008)(83380400001)(7416002)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bVFpVWY4SFZia0VKYlZYV0lNVCtGVWxNTzNvMlRsUi91dXRYbmU4TFJwTXkw?=
 =?utf-8?B?V3J4YTVxaE00RGJPU0duQ29KM2g0NWtsYmVlVG9na21SOWhrQzgxK0tRNEx6?=
 =?utf-8?B?bjVmMnEySFBBTG50a1JqdU5zRWkzZ1NiQ1NGeGxhOGF0akk4UklCUDg1OUJZ?=
 =?utf-8?B?aDQvTG1MQVpVc2VPOUJXZldiaVZUODFIT3o3dllpbXlaZERGYVQ4K0lFMlFF?=
 =?utf-8?B?QTd6UXBxSFQ4clZOeDZpMlBmZHIvbUJ5RXppK0d1OXZ4WVNSeVFnU1Y2Yk9n?=
 =?utf-8?B?MWxQdGQ1M1ZUSXZiUEFDRXJVeWlCRGpFSTZ0Qm9zalNPNnVUNHdnbkVxR0VS?=
 =?utf-8?B?SkY3UUg1cHVmRzlBYXR0enRsWTUrazIyY205dTF1TGFLaUZYMWVZUm1mbmVI?=
 =?utf-8?B?YlJ5OVd6elMrcTNKSkJjT245T21LK2grbDJzSFNuQ0F4MnVML25UUWFJaXJo?=
 =?utf-8?B?ZFI3T1c4dG40a3IxUE1EbllZenc0RXovRHFUZ0U2eXJ5U2hzTEtCR3BMWFVL?=
 =?utf-8?B?MlZhdWszNnhpOFZqTnJkU0Irc0drUTBrOUtKVXVicENnYkN6K1dLNjdMWGNK?=
 =?utf-8?B?Rlk0OS9CYm9zOStFRW9hRDQ2WTZvUjlkQmNWaE1WcWZuV0dIUGdJNWRzbjEy?=
 =?utf-8?B?ZmlNbi9yTlhOWGNuM0t3aHdja0MzbThLWGJySlU4dEZQeTR4UXZqQUVnbFR5?=
 =?utf-8?B?MFQ1TFVMbklpOTFaVERNTkxCNHBUamhxZGlNYUF4VVNFQ2xPbHlwODM0UDds?=
 =?utf-8?B?UmthUTVLR3l5Q0Y1L1N4L1QwbTR3TGg1L0x2eUlPbTFzRlNmTlNYMXRleGZC?=
 =?utf-8?B?Nk0rWEQzRXMxdDdwUDdFbTg2S1lreUFWemcrb2I2QldiWUQ5aWt3aFNnM2dB?=
 =?utf-8?B?SWtzUWNQN2UrTGZYNGI0RG43ZFF5dEZUc2VjSkJzWWFOWGk1c0Y4NGQ1dXE2?=
 =?utf-8?B?ZFRjeHVUSVE1L2ZFa0RRZlNmdWFQRDEvS3c4U3BOOVZFaUxibEpwbWxjcWg1?=
 =?utf-8?B?bk9oRXo1V3Q0MkZ0OVppTEdhcThIZ0ZZM1A3RzZXdTNwSHZNa3VFVHY0bHN3?=
 =?utf-8?B?aVhib1BVcGE1cE42SWFXWFlhQmdEQjhyVXlNdGZzeGtDSlU4RzFSdHBiTTNa?=
 =?utf-8?B?UjFyTU96S3BHU1hpSGV0bExmYy9SMGdLbUlQZDcwcTJlTjJ1SkdUckplRVUr?=
 =?utf-8?B?cjdvdjdlL1RSSmZMRGYydEh0bUZxK2VZemp6anJEbmxLTVVjYXhucm9UMlZY?=
 =?utf-8?B?YWw5ZTVBNWd3SXpvTWU2dExFVjJTTzBYd0hBL0lTNURxWUl0aGY2aUlkSkRV?=
 =?utf-8?B?RDUrOG41bXVMQ3h6a3lnRW9PY3Jnc0xJWVpBM1Q0dTdybi9NNlVRM3pFMW5p?=
 =?utf-8?B?MmhUZk9rNXRNU0V3ME0vQWlKWk9IeUJFbkJBUFpZRVkweitOSkgzRWhFUGtS?=
 =?utf-8?B?eGlpVTBlWkwwM0tVcnZuSDV1TklhdHh6VmZOd0h1dEk0UFIybCtSTEZUTHBi?=
 =?utf-8?B?cFBmZ1EwTmM2dUw2Rk1FT09xMUlRQmlHdUhFZ1VhcUhtenVnUHBBd0FnSlNB?=
 =?utf-8?B?Zk0vUTdpSDFmcjRpL3IwVTd1Ky9YSTVwZmlHY2toSUFnL1I3UVJvRm1vN054?=
 =?utf-8?B?SVpuNHdpMC9hTlNlYUk2QWY2MkFRYWNyVFhCTFR0bml4YnhwbDVvWENHSFMr?=
 =?utf-8?B?SzBqdVVuOEwyQjBqL2JDeHVuVzNMVUc4bHA5dS9VUS9pR2JwQytta3NrZHFT?=
 =?utf-8?B?WnhwVEZVdnJVZXhEMGtxQ0d2R2x2TVZGSS9yYzRRdmpneUhsWm5ZcHFVb09I?=
 =?utf-8?Q?Nvu0giv7+InCpgwsikxXhWTVS5xQe5EacXs/g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f12b5-378d-4661-8da7-08d928a230be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 04:18:51.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FZ7xCaG29vMj4YikPky6DivxYEyDtLx3qr1ASr5AXZmwIQbUO0KG7Ln1HQ4eB8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2480
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: gMH3DwUPwYT23bBCg0l-Iy72MS5LWcHV
X-Proofpoint-GUID: gMH3DwUPwYT23bBCg0l-Iy72MS5LWcHV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_01:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106060034
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

The above two assignments are redundant.

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

I suggest just to test ctx_out.data == 0. It just happens
the input data - meta = 4 and bpf program adjuested by 4.
If they are not the same, the result won't be equal to data_meta.

> +	ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
> +
> +	/* Data past the end of the kernel's struct xdp_md must be 0 */
> +	bad_ctx[sizeof(bad_ctx) - 1] = 1;
> +	opts.ctx_in = bad_ctx;
> +	opts.ctx_size_in = sizeof(bad_ctx);
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test2-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test2)");

I suggest to drop this test. Basically you did here
is to have non-zero egress_ifindex which is not allowed.
You have a test below.

> +
> +	/* The egress cannot be specified */
> +	ctx_in.egress_ifindex = 1;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test3-errno");

Use EINVAL explicitly? The same for below a few other cases.

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

This test is not necessary if ctx size should be
<= sizeof(struct xdp_md). So far, I think we can
require it must be sizeof(struct xdp_md). If
in the future, kernel struct xdp_md is extended,
it may be changed to accept both old and new
xdp_md's similar to other uapi data strcture
like struct bpf_prog_info if there is a desire.
In my opinion, the kernel should just stick
to sizeof(struct xdp_md) size since the functionality
is implemented as a *testing* mechanism.

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
> +
> +	ctx_in.ingress_ifindex = 1;
> +	ctx_in.rx_queue_index = 1;
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_EQ(errno, 22, "test10-errno");
> +	ASSERT_ERR(err, "bpf_prog_test_run(test10)");

Why this failure? I guess it is due to device search failure, right?
So this test MAY succeed if the underlying host happens with
a proper configuration with ingress_ifindex = 1 and rx_queue_index = 1,
right?

> +
> +	test_xdp_context_test_run__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> new file mode 100644
> index 000000000000..56fd0995b67c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("xdp")
> +int _xdp_context(struct xdp_md *xdp)

Maybe drop prefix "_" from the function name?

> +{
> +	void *data = (void *)(unsigned long)xdp->data;
> +	__u32 *metadata = (void *)(unsigned long)xdp->data_meta;

The above code is okay as verifier will rewrite correctly with actual 
address. But I still suggest to use "long" instead of "unsigned long"
to be consistent with other bpf programs.

> +	__u32 ret;
> +
> +	if (metadata + 1 > data)
> +		return XDP_ABORTED;
> +	ret = *metadata;
> +	if (bpf_xdp_adjust_meta(xdp, 4))
> +		return XDP_ABORTED;
> +	return ret;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> 
