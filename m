Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88481586FB7
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHARqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHARqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:46:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2AA2A435
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:46:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271GAxmd021682;
        Mon, 1 Aug 2022 10:45:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=S3vPeOgJ/YilB0h1oHI65ZLa6jWErOKCLX/hmYWannI=;
 b=Yjpt/8fBWSnKfeTF9VsBi+LHZ6YxaryAOzvyE1oMl2+LmjoR3Z/ewFavO4bkNsEaoqdu
 W9dSVmLuHpl8GqwdLR/fguugd2SDkTzQm6dOPaZqsfsNwoviHC8Rot50Ia5isLyY4dAq
 Fq54GE6DJ17yXxgnMCMeCWz4ctGegWaYZwY= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3crm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 10:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of5sgiPC+4UAdS16i/wc6EHK0G1+LHkuQi+L7fVL01WMlQIv3vQ8+9f6/Z36DdzDVKbodJceZXroSrayZqvjboSs/zX1vgDTYskMBUp1LIfpkE/k1hLiiDyBWaZ2AeQEAlrmWjS7Qj2QAOxHZoiig5ba4vR798S+WQtC2IE6W9fFo/NQQjNYX5y7Ewn/MoyizokVRKHM6vwxR3oN4Hyqbjz/C4hAJf7zzCze3UqB2aeLAfMWG6i0vHsmn0Slrffj17J568dJDATR3Dq5iWTFHbpWp5h7Ux3QT2TqpyPjcqRj7D3aHHQJttNWTJcDeh1w2fsOf1rYFy3PnS1JFS2Mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3vPeOgJ/YilB0h1oHI65ZLa6jWErOKCLX/hmYWannI=;
 b=kLR3h8uFwSAaSsUoFk6KqivzwRkbcSprJl0MjgHfH8hULoVReMcTviMVk7FlPKjE2Oq6x/DkPh+/dsZ+jfoufH+rlcKhXA5OQnWaQVwIAZs7d8DC5aI1yQsuqFTdJLCr+V1+ZJgP8Tix1XugXUy2M6mCS2KEs7WnLFQnncfEjAFD7yyF41zTWdkdGbFLo+O65nxgsOd8J52SIGA6OYTHsxaVTVQ0GLaPH9mYAZ7w0a4q/CeWG8nc9SyZV9+9DBqGUox7Oe3Ny1hfA8JyHn5SievAuuD61H7rpqZJm8HYcn1NNIW+1LiCK/R8+GCxX3hFDCaF9NR1j1fCFxYFwqm0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB3435.namprd15.prod.outlook.com (2603:10b6:5:16e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 17:45:32 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 17:45:32 +0000
Date:   Mon, 1 Aug 2022 10:45:30 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
Message-ID: <20220801174530.lcxhrvm6xtfjpxa7@kafai-mbp.dhcp.thefacebook.com>
References: <20220730000809.312891-1-sdf@google.com>
 <20220730000809.312891-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730000809.312891-2-sdf@google.com>
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a56251-0f70-4c00-3359-08da73e5a1a6
X-MS-TrafficTypeDiagnostic: DM6PR15MB3435:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aGvV53ZN87xFqGKAf4vkzq9SLcGAH4GJDm7gFhJL22xh7XaLpeHS5L7bafiTKefkJy9QJGnYYYz0qCUr8suQk1MMiwzv37tL80z1t528JjeDDGgGcFkDXqWikBJDjOrgvss8q8QMMusOwNlV41LD6z9VzZ4xkm8oNTYtTmH+MUldKt9vAIVL0ROsWPkhsv62uHATkfEoIIziDKkB20TlKpTfVLkk87YwqPTGO67AhpJHh7B2t7D5NBHzo0for+rpDMkgPB2Xk2o3YewgPIlWroMdhDBZRT0eu9FHEKCumESM4liSHng2YwMNM5Shp9zmV17of4dGBZUALXcS1o7p5BoSW30tTwxan0jsZlmIakF6+0ToNu/mj6zehoIxRkTCe3E5vRSb8mlSYPGVe/SUOrV88I9AqKSChoGUv72om+GkXFuppNE3xMPFSm7iqG0KZN98N++Oqu3i5qlwdYr9SYPFY+KdHG9cnSA6YEISpCnhGkpbSRz40wGLE55p99fSx7ucKmvdnfhd5byXK3jdJ5y5/RDlyPYedjC4TrndFD7BsCeSOPO2uFmCojfglD2Z87bZqtFVxKt5mIkZxOjq2e25hinGizERIpF7/SOKWQkrVcaMVoBp5NboJduP7UTzt1UU+cRC6cl84Z84EH40Agsx5oAnwc7oFP7uJ1/ZG6XhcHXc6Vf/exQXrPIZ6KB2rJQazT4vPgHsj4arLjQVGIqB+aRXzT6+eiKmUb7xgh1pgdPiDKhZ1+wcUelnweo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(8676002)(4326008)(66946007)(8936002)(5660300002)(66556008)(6486002)(66476007)(478600001)(7416002)(86362001)(83380400001)(1076003)(186003)(6512007)(41300700001)(52116002)(9686003)(2906002)(38100700002)(6506007)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0kSq+XsJrREFEk/vUmS/HCrA5fR6HxbOV247t7DHT32R86hZv5AjE2VwlSC?=
 =?us-ascii?Q?uXu3urtuBuqViqbvYlXdtvt10AILM0FTxIMxFHfQPcbOHEmV5PnAxpI0YcKE?=
 =?us-ascii?Q?XC6hwJpBkc9lOk007+qzBfhYJNldB6t87W4mtSqEiTedPG+tx+zl3YWkUm1i?=
 =?us-ascii?Q?jo+NEiuTYddoNaYpp6nQuZTfPaSD1hB4gVYYolYzopvG2/MiVQtaaHSwEmHN?=
 =?us-ascii?Q?bfmID1a82UkZNAWInBmjaSrTw7BLssH1EmRphL9e9ZMJ7IY5fJYCRNGnGIf6?=
 =?us-ascii?Q?k2L0lhGA9zSRenQ6AfaGFqYlGrsSYE+ilV+tO+YfkuwU+OejIaZJUFTGnkwO?=
 =?us-ascii?Q?MYycYiv4XW8EbhgxAnwjnVZsQiHmJy6RpSjjCJT/UD1A3FLEMvsW2Pb8jvem?=
 =?us-ascii?Q?8Lf6TRNEuCTagi8kxDHr0ovq+zaCl4OUHsm0n1sAoC+VWmFGmtPnp16WqWia?=
 =?us-ascii?Q?/drFQx64uEQ+zf1lrQ6iF8HGZB3YwIZcFoD7W/5mIcB2pH4N2DL/r+VMSy1W?=
 =?us-ascii?Q?0bwUlR4rIP2Wk8iy9scsTa6j9ZI+w60COe/OH6zMmludVWdrrnP/Xkg4JZCq?=
 =?us-ascii?Q?zFQIbEvKgBff8rxjEDoCZ9djuGczO3zwaOlofTsxZX+IGU4j9X2CNdlHGEgO?=
 =?us-ascii?Q?RVohilXzdsB+c3nSlQ6jcNidJvPhrG9r6ru1YjQyBhuVZ6MnXIwa3hqhShVT?=
 =?us-ascii?Q?o5fd+ek14cdIwIAKdvpOrfVb5i/mF3U/gusoXGJVvOnWEfY15mcLkhrBymf4?=
 =?us-ascii?Q?dT/NH0ygudxKnd8X4OSCkGLUhfIyj2G3CQTJrdIeeajbnQP5x0KE+33feVwe?=
 =?us-ascii?Q?IYc+JIVAp82GEQMd6RtEdy36w+e1oBv0UpbJ6xGYji72lVf4ldNmyvP+LOjj?=
 =?us-ascii?Q?vEJFXpOod7WSWUXsdFUH5+ysRQKM9TOxC576/nF5wo4R3CTuaBkV4/gKw4tp?=
 =?us-ascii?Q?h+Szt8nOjfCItUW7TDnVMUGJhDfdZwHku/lnUrLtwHuVbOCBoObGjFuWOHB3?=
 =?us-ascii?Q?5I+1s50bb5lJIefnl50a//933D8721MJdNFvQ8H2MJ3D8/AWaptI9Dv8FOEQ?=
 =?us-ascii?Q?WUUFe4zZeXE0KiJvJTSsKIvQBvQesbdQJIr+6r1nLavj6pKMT44cL6fYewX6?=
 =?us-ascii?Q?iCSSr0zptAOmWKGPTbDbgfjUwYagxxErznvIaNTMt+wB+JT5lJkNYv8xezOQ?=
 =?us-ascii?Q?pOTxGJT6Frqa0lZsd4AarKqZbmt4irYAQdKKhzWa3kNoyUhoKz9Vs/nKSmyC?=
 =?us-ascii?Q?ZrdyH1JXqPy8fAswapGvKPeuFBCm0f5X4ROCMIovhhIRuc1ye7HQ5/E3RWyd?=
 =?us-ascii?Q?H0PuByGdgNsfTIPuoacHlAdnrS17KZ3jw4yS7nrElCwTyaBpI4QFVMzypX2b?=
 =?us-ascii?Q?DYdlLl4WMT+U47ocmIuOYEtAl9vaeFnzarLG4W8vb/HiYJmN7GXAZ4J42EBF?=
 =?us-ascii?Q?A96nl6lms6L6X9+ZkqgrTM2PKZ2I+Vvrs5gNcgZV69DBOUuZDoJytLe+pqYJ?=
 =?us-ascii?Q?Wn7q+YI4l3ihFfv+U8iEWqmRyIt4xqQNC7KYRlXwkis6mOF/xWOo6qO9EYW/?=
 =?us-ascii?Q?bwokGLf1MD0RWkmZ6iowmAqC/rfxssEiRZzV++kL+X5tch+/9ijc9dUw6nMF?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a56251-0f70-4c00-3359-08da73e5a1a6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 17:45:32.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDjuWJpHB+qMOXYUv0ugAELukVvtydWNXejiAVn/DKG0hDsX/8zjnkmSTpTXWHae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3435
X-Proofpoint-ORIG-GUID: -umqHNuTYEcBSAT62l_kE2j1a-lMVuSU
X-Proofpoint-GUID: -umqHNuTYEcBSAT62l_kE2j1a-lMVuSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 05:08:09PM -0700, Stanislav Fomichev wrote:
> Apparently, no existing selftest covers it. Add a new one where
> we load cgroup/bind4 program and attach fentry to it.
> Calling bpf_obj_get_info_by_fd on the fentry program
> should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 109 ++++++++++++++++++
>  .../selftests/bpf/progs/attach_to_bpf.c       |  12 ++
>  2 files changed, 121 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> new file mode 100644
> index 000000000000..fcf726c5ff0f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "attach_to_bpf.skel.h"
> +
> +char bpf_log_buf[BPF_LOG_BUF_SIZE];
static

> +
> +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> +{
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	struct btf *btf;
> +	int err;
> +
> +	err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> +	if (err)
> +		return err;
> +
> +	if (!info.btf_id)
> +		return -EINVAL;
> +
> +	btf = btf__load_from_kernel_by_id(info.btf_id);
> +	err = libbpf_get_error(btf);
> +	if (err)
> +		return err;
> +
> +	err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> +	btf__free(btf);
> +	if (err <= 0)
> +		return err;
> +
> +	return err;
> +}
> +
> +int load_fentry(int attach_prog_fd, int attach_btf_id)
static

> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		    .expected_attach_type = BPF_TRACE_FENTRY,
> +		    .attach_prog_fd = attach_prog_fd,
> +		    .attach_btf_id = attach_btf_id,
> +		    .log_buf = bpf_log_buf,
> +		    .log_size = sizeof(bpf_log_buf),
> +	);
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int ret;
> +
> +	ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
> +			    "bind4_fentry",
> +			    "GPL",
> +			    insns,
> +			    ARRAY_SIZE(insns),
> +			    &opts);
> +	if (ret)
> +		printf("verifier log: %s\n", bpf_log_buf);
If this fentry prog is in the attach_to_bpf.c and load by skel, this printf
and the bpf_log_buf can go away.  I wonder if it can use the '?' like
SEC("?cgroup/bind4") and SEC("?fentry").  Then opens attach_to_bpf.skel.h
twice and use bpf_program__set_autoload() to load individual program.

Another option could be to reuse the progs/bind4_prog.c and directly
put the fentry program in the attach_to_bpf.c.

btw, this test feels like something that could be a few line
addition to the test_fexit_bpf2bpf_common() in fexit_bpf2bpf.c.
Adding one to test fentry into a cgroup bpf prog is also good.
No strong opinion here also.

> +	return ret;
> +}
> +
> +void test_attach_to_bpf(void)
> +{
> +	struct attach_to_bpf *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	int cgroup_fd = -1;
> +	int fentry_fd = -1;
> +	int btf_id;
> +
> +	cgroup_fd = test__join_cgroup("/attach_to_bpf");
> +	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> +		return;
> +
> +	skel = attach_to_bpf__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel"))
> +		goto cleanup;
> +
> +	skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
> +		goto cleanup;
> +
> +	btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
> +	if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> +		goto cleanup;
> +
> +	fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
> +	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> +		goto cleanup;
> +
> +	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> +	 * to another BPF program.
> +	 */
> +
> +	if (!ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> +		       "bpf_obj_get_info_by_fd"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> +	ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> +	ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> +
> +cleanup:
> +	close(cgroup_fd);
> +	close(fentry_fd);
> +	attach_to_bpf__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> new file mode 100644
> index 000000000000..3f111fe96f8f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
nit. attach_to_bpf.c sounds too broad.
May be fentry_to_cgroup_bpf.c ?

> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("cgroup/bind4")
> +int bind4(struct bpf_sock_addr *ctx)
> +{
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
