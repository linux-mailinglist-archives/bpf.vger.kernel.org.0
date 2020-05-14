Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D331D35FD
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENQHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 12:07:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgENQHp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 12:07:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EG5jE1001860;
        Thu, 14 May 2020 09:07:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kV1hUDYZd6mPTDOnyag/Y4SpQBIZ9UWeeFNqKpnpi1w=;
 b=OVEzIVNXg6ofs1djbkWE020twIqft+MmUg5xoCXowbkfSV2J4BatDpwSkOejXvnGdmil
 63fDBQ01nZofWJ/iLhcF3zRE+qlcz6wVWe6/JbM0RSQjMYqQS0QjXoXpWogr/9PSRYgN
 kojR30GreC1jQ8oCjuArkV2yy53t4kNfQL0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbc5h7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 09:07:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 09:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eed03RmNwNz+UwfeOJ4SdJI/BwA4J+JYn/o1R22WEDCOIBYHcYUYYVdYAzS8kbYy615F20kUXw8NzUeKDeU9n4SRLbmG3R5lml6HGpGQZmtpvHH3lQh3/NSZ3pkgO3hNcJy6q6xl+TPcLUb1XR5/PMVKvjKyMcx8O8cjikbKBvpDtOVAdI5MsyEBuMp/uSWueTEQIezIjBBKLAcUYlzusFaJBfiIi+ZF8/pQzfM7OYsa8UNGELfjPl6e9CRVCdLpyp1dzfmVQTepP8ZCfFstgPO5LuMFue7r4NXiJanPKj4a/WQaR0weBspZq3x+cfXza1KLmNXi0E173VJSDCUstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV1hUDYZd6mPTDOnyag/Y4SpQBIZ9UWeeFNqKpnpi1w=;
 b=Kqsp6mTtLOhnkiRdm0MvYDpTrVOgan20ZxDI/E+ZsbokIeA0+dv7Gt8pgn82EPJVuNW7r+owWswwbM0ZLNkVHYY+eu2DzPa5f9GCi/Cyoqe/+PGY76kPAmdRo1YCw8xM6pKfl4ec20QS/0LJKri4uTUS/ExP7L+o0nrVNXW2ZO022mjMyUQQnun+n9k90sY4r/NKD5hyGi8yfgzyK+0/EE8xQJ1uLplbIFBwrgCblTxeDO+T3704ZUvFUEKWmOowDqIHXonbDTcPaiYepqSoVqDryjiP98p2KOAGvL+CF7Vi/ci5T2Yf6cwXrrc3aXsPXtnH1jl03XAiJa3N21zbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV1hUDYZd6mPTDOnyag/Y4SpQBIZ9UWeeFNqKpnpi1w=;
 b=AgBbYgaKw/snDuumZKJp/ytFgS5xxm/2jFkGVnApS9PJslPVZVVk+rAriE8xgEF0z0BrMFdz/uu8nijfPCaP3fdeJWWJgI8aNDGwUM6gGZ4ajSQwMOGrqvwHizvf/B3uKOZ7406lpR10qUkp1zRTADPov2tI5UGz7po+5j7nWLE=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2454.namprd15.prod.outlook.com (2603:10b6:a02:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 16:07:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 16:07:12 +0000
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Test for sk helpers in
 cgroup skb
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <646dff71848bd93780581cf4e0f5a70f7f386966.1589405669.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a1360303-220c-5bde-5657-b8f5497190ad@fb.com>
Date:   Thu, 14 May 2020 09:07:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <646dff71848bd93780581cf4e0f5a70f7f386966.1589405669.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 16:07:11 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957f7e02-4feb-4b74-f81c-08d7f820dc92
X-MS-TrafficTypeDiagnostic: BYAPR15MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24548D784B45B9E9A9CC5529D3BC0@BYAPR15MB2454.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPmYoo49SidC3HVY9gWS0buSSDE85d5NbXCns4QSzt4qNSCKcBY48JWMvSrjVe7rxASoyDqqTnoBbxXvOcYND3H0QgP/WSArCxM3k6foRBAGRq32dvCQpXMcCBlFTq7gYPCMDZdAAWkHYDeUPxGn++P++WJTmZ7O4hEINrnOZXrI37O9vYLqCq3WSrYtECeFByCh+UEQrUTDm7PSinbaThr0yhP5d+ZvwJwo/5/iemyVAPgz73iHkfUMBTBQZKm9S7maaLUDLhEoda64uBGK50bAKThPQ72bHRES28zfAHaRRv3vOFuf7GotcfFIn1oi7pzg5ylfOfFbQeiD5Ja8b1h5kaIwrL3lFuUhB63vaQKWYzrEd3o+yjnAPSpRhykUm3tYb8l81lwV/ejhmiFALXqYbJclnH23vVbiyUMPe8s5w/ausoJqIhB3V5LCSzTT4a66/lwDWn/WpBJe75HY/8yxdEKsfobR2ydwSJIuZW3hDmAqcgxmOo8ef1UMSy8O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(86362001)(316002)(2906002)(8936002)(66556008)(186003)(4326008)(66476007)(52116002)(66946007)(16526019)(8676002)(36756003)(6512007)(6506007)(6486002)(2616005)(53546011)(31696002)(5660300002)(478600001)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MknN9H3z2jFtK2vw9WjQz5XCuwH+5jtBiZZ6Zy68Km9dZFkniiqKGAFTpVknWqJtR5VejjexBu6ZDQgU8cALGJ1+yBcQOXRzH3/g1x6QS+oBay5WFgjypP/uRqAhqt8+m15+H8CyP2mGfaKFw98Xbgxq2I/HfkKlC1mWVPwFoeXh/fiRCygiKeXSP0gixtiRFv5qpKWgO7i+o9p9xDoH4IZw/qwp5kuZEmocR1BRah6wFrf7WDYErh6RqkgPScA12H1SZQWI7lH2ftd7pzDenkj3MpmB+Bv/XTZIzjt6M+z9Z49pkM3BIqs9EZ767y93Xo4SYA3/Oa1YnwF2YhEimdYtnP7VEfR9JWFxs+AmjxapbP7PuP4ewckXHVtIpl8gJNaBOaPIS+j+MOUs//ya1xcWAa9tycIC6Ha8CbQ4L+SXOszOIg6yDbbXNwG8y5tDZZkIexjDJvT2Jkr1kF1upQdKgaiZqXvUZFdOBo5u3Wfk0f5UIxA0UiFsHtYL+Cib60iurIFCVr4kbhkJRgHOxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 957f7e02-4feb-4b74-f81c-08d7f820dc92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:07:12.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkAbIgEhngqS7Izc8xC3d1pyoSfFNCYtu2q1/AvHtaTfPqXwP7oKg7pmpAe/GuK1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> Test bpf_sk_lookup_tcp, bpf_sk_release, bpf_sk_cgroup_id and
> bpf_sk_ancestor_cgroup_id helpers from cgroup skb program.
> 
> The test creates a testing cgroup, starts a TCPv6 server inside the
> cgroup and creates two client sockets: one inside testing cgroup and one
> outside.
> 
> Then it attaches cgroup skb program to the cgroup that checks all TCP
> segments coming to the server and allows only those coming from the
> cgroup of the server. If a segment comes from a peer outside of the
> cgroup, it'll be dropped.
> 
> Finally the test checks that client from inside testing cgroup can
> successfully connect to the server, but client outside the cgroup fails
> to connect by timeout.
> 
> The main goal of the test is to check newly introduced
> bpf_sk_{,ancestor_}cgroup_id helpers.
> 
> It also checks a couple of socket lookup helpers (tcp & release), but
> lookup helpers were introduced much earlier and covered by other tests.
> Here it's mostly checked that they can be called from cgroup skb.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>   .../bpf/prog_tests/cgroup_skb_sk_lookup.c     |  99 +++++++++++++++++
>   .../bpf/progs/cgroup_skb_sk_lookup_kern.c     | 105 ++++++++++++++++++
>   2 files changed, 204 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
>   create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
> new file mode 100644
> index 000000000000..7ae0f49a2118
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 Facebook
> +
> +#include <test_progs.h>
> +
> +#include "network_helpers.h"
> +#include "cgroup_skb_sk_lookup_kern.skel.h"
> +
> +static void run_lookup_test(int map_fd, int out_sk)
> +{
> +	int serv_sk = -1, in_sk = -1, serv_in_sk = -1, err;
> +	__u32 serv_port_key = 0, duration = 0;
> +	struct sockaddr_in6 addr = {};
> +	socklen_t addr_len = sizeof(addr);
> +
> +	serv_sk = start_server(AF_INET6, SOCK_STREAM);
> +	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
> +		return;
> +
> +	err = getsockname(serv_sk, (struct sockaddr *)&addr, &addr_len);
> +	if (CHECK(err, "getsockname", "errno %d\n", errno))
> +		goto cleanup;
> +
> +	err = bpf_map_update_elem(map_fd, &serv_port_key, &addr.sin6_port, 0);
> +	if (CHECK(err < 0, "map_update", "errno %d", errno))
> +		goto cleanup;
> +
> +	/* Client outside of test cgroup should fail to connect by timeout. */
> +	err = connect_fd_to_fd(out_sk, serv_sk);
> +	if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd",
> +		  "unexpected result err %d errno %d\n", err, errno))
> +		goto cleanup;
> +
> +	err = connect_wait(out_sk);
> +	if (CHECK(err, "connect_wait", "unexpected result %d\n", err))
> +		goto cleanup;
> +
> +	/* Client inside test cgroup should connect just fine. */
> +	in_sk = connect_to_fd(AF_INET6, SOCK_STREAM, serv_sk);
> +	if (CHECK(in_sk < 0, "connect_to_fd", "errno %d\n", errno))
> +		goto cleanup;
> +
> +	serv_in_sk = accept(serv_sk, NULL, NULL);
> +	if (CHECK(serv_in_sk < 0, "accept", "errno %d\n", errno))
> +		goto cleanup;
> +
> +cleanup:
> +	close(serv_in_sk);
> +	close(in_sk);
> +	close(serv_sk);
> +}
> +
> +static void run_cgroup_bpf_test(const char *cg_path, const char *bpf_file,

You are using skeleton, bpf_file parameter is not needed any more.

> +				int out_sk)
> +{
> +	struct cgroup_skb_sk_lookup_kern *skel;
> +	struct bpf_link *link;
> +	__u32 duration = 0;
> +	int cgfd = -1;
> +
> +	skel = cgroup_skb_sk_lookup_kern__open_and_load();
> +	if (CHECK(!skel, "skel_open_load", "open_load failed\n"))
> +		return;
> +
> +	cgfd = test__join_cgroup(cg_path);
> +	if (CHECK(cgfd < 0, "cgroup_join", "cgroup setup failed\n"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach_cgroup(skel->progs.ingress_lookup, cgfd);
> +	if (CHECK(IS_ERR(link), "cgroup_attach", "err: %ld\n", PTR_ERR(link)))
> +		goto cleanup;
> +
> +	run_lookup_test(bpf_map__fd(skel->maps.serv_port), out_sk);
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	close(cgfd);
> +	cgroup_skb_sk_lookup_kern__destroy(skel);
> +}
> +
[...]
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u16);
> +} serv_port SEC(".maps");

This can be simplified as a global variable, e.g.,

__u16 serv_port = 0;

and use skeleton to access this variable in user space
and in kernel you can directly use this variable.

> +
> +
> +static inline void set_ip(__u32 *dst, const struct in6_addr *src)
> +{
> +	dst[0] = src->in6_u.u6_addr32[0];
> +	dst[1] = src->in6_u.u6_addr32[1];
> +	dst[2] = src->in6_u.u6_addr32[2];
> +	dst[3] = src->in6_u.u6_addr32[3];
> +}
[...]
