Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EAA264C62
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIJSMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 14:12:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46223 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbgIJSLq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 14:11:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AIBR1C002438;
        Thu, 10 Sep 2020 11:11:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xCQGRNHI/zik77Z+3tYvBD7AvykyZduz9rF9J/12q0g=;
 b=cEMuXsWIRvtJnWcPmnpj6sC9O3jrsKaSY4l0UVms5NEbZa1SNQQUgcRsLLXRQX9hUQje
 yDlLsS9bSzHRgsBtZevpbanx0ybRC/as37Z6/aRCUm859riS2Xo7DMJ/09lTRd6Zy3GM
 k2OjQXekYV5uDYhGRBDgEfUE01RhWXHTyww= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33fjtd2578-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 11:11:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 11:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc4VhtDdshaAGuimuinFsLePwdQy4yTstHimc+0kAlqrndHJqNi4aDnxXMVahr4pQGIsGM6U5ZP33C+x2ihnD1+Mos0pOyj/Rld3FFbXYSlk8qFVwf82cOSHZ5MOeN7HmGW/sYYGircXVGTSk7CBNTKzOCs7IST2ehbNM0QVj/4fkixT2lSvyfMBhi/q+ShKzkE1Hgf6zrxJUMU84jK9/vpIU9RRJ6/QJZsgEpEBxZ/M33AfhhGE7475nedo7Zs1VKe5+NqQ9iLeHexpSkzYImxK8Pw9tVonWgr5rf21u1LJthKfXNBfD/g1arBJv/7KyjqGnNnx/UGgsYqJhHRNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCQGRNHI/zik77Z+3tYvBD7AvykyZduz9rF9J/12q0g=;
 b=hkvneODI+cR0kzhYwb5RsXsAV43jO1tQ28Hs0wM3htbhWq2dqHn5nJnd6C0+hEQEQI9lzIJtTDE7ncHrUhHqThci29+4Vhpy+0QbOt9xln8Qcqgnn92krpjDb4XJ4KYFuqEDYS6y1Abc8l2FzR1Ugs4AMOVhFvHNUFpBcUWif1/znRuuYTSN0TTmLxHql3z1vv6jHMFuJAG6JhJ80J30/MBMj2oqWRh1K2m5qZqv4UFA93vTc7oZsZbTJz5mjo+mUAk0ehwG3mOFSwLbolxBDBzljSqtCsDO9+tWgDR5cs7AnfnrEa/6zaRYjLEn09/vjS51maLBjp8rXOFhFXhZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCQGRNHI/zik77Z+3tYvBD7AvykyZduz9rF9J/12q0g=;
 b=IJYnxxg7ikbHtosLS3ww/mtrbX9H6beC9eZbd+ONU8JhWn/Ys2ygPB+MExjJjZoo6c2qunPoeVkc6Qw6NHzHBR+arQYRzVc9Z8unT6fCziRFRSA3JQuS/AKM72nCYxnCl1aLxp/nvg7QrOZDouVD7cruUczxNfJVpvlsJ6QXibw=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 18:11:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 18:11:20 +0000
Subject: Re: [PATCH bpf-next v5 3/3] selftests: bpf: Test iterating a sockmap
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>, <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200909162712.221874-1-lmb@cloudflare.com>
 <20200909162712.221874-4-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <45e403c2-223d-3f29-e6ec-7ad71f5893d8@fb.com>
Date:   Thu, 10 Sep 2020 11:11:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200909162712.221874-4-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:300:ae::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11ea] (2620:10d:c090:400::5:271c) by MWHPR14CA0023.namprd14.prod.outlook.com (2603:10b6:300:ae::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:11:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:271c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ce9ee52-a30b-4ff1-8c05-08d855b4eb8a
X-MS-TrafficTypeDiagnostic: BYAPR15MB4119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB4119FC95B4DCECD3DED28974D3270@BYAPR15MB4119.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTcpo4CRIBE7EC4hd7u1JwBNLbjElbKNIOFjYQ1YUNDfNeeIYV3pwQ9ctkJP0X+4/xRSBGf14S0Ua9Ua4vEpKresN6Xbsq3KJLUF+cRDxE75pvSrHJvXhNmNRe5zasboxL1NgyMlL3HQrtK3fgYToRZFJyTbGM0fkAPJDrHXjlQ0E0HjFZ+HsiD/wzSt17bonB3TTbrb2Vq3jWWW0vWqtTf1sV9xXUZ3c2hXnuRPQhjs/Rndcp2WbTMtUoht0m5NOmmqt2zuffQ1gHH+0JSlJZz6iIaRn/FjKwfpnIYGsunK90WTqGVFySJI9M/NvxGw3s1v84WmfO0yh2QgW3hv+3tWLu5ZctUlcriD5cDmoclcJHpGqSWwiCfqDxcuu9Df
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(186003)(6486002)(316002)(4326008)(83380400001)(66946007)(5660300002)(2906002)(8936002)(36756003)(6666004)(478600001)(31696002)(53546011)(86362001)(31686004)(16526019)(52116002)(2616005)(66476007)(66556008)(6636002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OA3sH1SjmBMfJsYDLR6ufI5Fpsq4POn8hX3kbytBk5gaS8kgFDsAIptfZCnIEAxNxpV/oSJyx3h4jgzj5eXopJyV9pwLmqrbaCldPK5LWV/lHM5el7JcHCV8IF/m++CavjnxBQ7LFFfRTQcpTGohw5ZLzgZ+qdDbihwR706FmspYCtcpbV3k20VAlG7tuhiiaZEcvuYumVr8LY30uzTf7UiU+v5p+B+9V17Rs4kHX6krnPCiVwlrRXz5BM1ld8VWbVd0C3w8POVYCZJDDgKAfFyoryYJ1mJtsSswuk4/YpqfSUnqfGKYvAKJnzk1Mk5//yDjaid1m6YA8nmlU3MI9VkeilSwlPSsO08IGYcTr05QSTPmdLzNVfDimLaB3Ra7lCOww3+Ts0U9l9Mte8BbNAjpqZzJ5wJ+AYdHD0aXui7sfvx0iaWxfPyN8p7aWMvgf82F9aHPF7qCBNfCeeI9KcRlxZeKaYg/g0Lge4XcvCNBOqCAyk1ccDudEwhRiMNUmWfuJ+MHIrZNK0E15LdSjv4D4m7HD57/duBmQrKB9T6lpmfZXUJ7rJnR/2QYnNY1bXAEhDpMkHh2KxNHiJJYDrVxtgBD061YSeLjRCdBvPnnOq7oxNpwruMvzKf7scq/N4/OfdMEHiMiEgW1izSseDBdTnfilLkKL/obcWSAUzkI7mkDCaBcE251BgpF+klc
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce9ee52-a30b-4ff1-8c05-08d855b4eb8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:11:20.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrJV86WprxhIkFF8wkb9zx+KaMFlG8scIG9E4r172jaKtGuxTbNisJZbLCLKsgf6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_08:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100168
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/20 9:27 AM, Lorenz Bauer wrote:
> Add a test that exercises a basic sockmap / sockhash iteration. For
> now we simply count the number of elements seen. Once sockmap update
> from iterators works we can extend this to perform a full copy.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 89 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
>   .../selftests/bpf/progs/bpf_iter_sockmap.c    | 43 +++++++++
>   .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
>   4 files changed, 144 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 0b79d78b98db..3215f4d22720 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -6,6 +6,9 @@
>   #include "test_skmsg_load_helpers.skel.h"
>   #include "test_sockmap_update.skel.h"
>   #include "test_sockmap_invalid_update.skel.h"
> +#include "bpf_iter_sockmap.skel.h"
> +
> +#include "progs/bpf_iter_sockmap.h"
>   
>   #define TCP_REPAIR		19	/* TCP sock is under repair right now */
>   
> @@ -171,6 +174,88 @@ static void test_sockmap_invalid_update(void)
>   		test_sockmap_invalid_update__destroy(skel);
>   }
>   
> +static void test_sockmap_iter(enum bpf_map_type map_type)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	int err, len, src_fd, iter_fd, duration;
> +	union bpf_iter_link_info linfo = {0};
> +	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
> +	__u32 i, num_sockets, max_elems;
> +	struct bpf_iter_sockmap *skel;
> +	struct bpf_link *link;
> +	struct bpf_map *src;
> +	char buf[64];
> +
> +	skel = bpf_iter_sockmap__open_and_load();
> +	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
> +		sock_fd[i] = -1;
> +
> +	/* Make sure we have at least one "empty" entry to test iteration of
> +	 * an empty slot.
> +	 */
> +	num_sockets = ARRAY_SIZE(sock_fd) - 1;
> +
> +	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
> +		src = skel->maps.sockmap;
> +		max_elems = bpf_map__max_entries(src);
> +	} else {
> +		src = skel->maps.sockhash;
> +		max_elems = num_sockets;
> +	}

I know you include the shared header progs/bpf_iter_sockmap.h to
supply SOCKMAP_MAX_ENTRIES in order to define sock_fd array.

I think it is easier to understand if just using bpf_map__max_entries() 
for both sockmap and sockhash to get max_elems and do dynamic allocation 
for sock_fd. WDYT?

> +
> +	src_fd = bpf_map__fd(src);
> +
> +	for (i = 0; i < num_sockets; i++) {
> +		sock_fd[i] = connected_socket_v4();
> +		if (CHECK(sock_fd[i] == -1, "connected_socket_v4", "cannot connect\n"))
> +			goto out;
> +
> +		err = bpf_map_update_elem(src_fd, &i, &sock_fd[i], BPF_NOEXIST);
> +		if (CHECK(err, "map_update", "failed: %s\n", strerror(errno)))
> +			goto out;
> +	}
> +
[...]
