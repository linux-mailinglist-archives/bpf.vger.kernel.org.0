Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A022BABE
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXAEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 20:04:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgGXAEq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 20:04:46 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O04ULH003805;
        Thu, 23 Jul 2020 17:04:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=npjo1JXe5mcDxp5KRE5XYwALyEiEaGqpV2YdN8cXhoQ=;
 b=USfW87hVX6RdVpMvDS+dp/PWaOMH1z/iWFYEqgwX4ln3tcI1eGMnozgaUJmMNXc8S1Wg
 aEI47+RE+6XVOPN8uVt7/1AWHZhbmkHS3D+7I4Rzjz2yxnlznqleXdHJ5pEEmbseahdj
 hUkkA9PGt2L42gU1gT1PwbIy8GgTTxKRMUc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32embc919r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 17:04:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 17:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUDy1G4AbW5Gqi3egV+xpRxqoUFniv02ftHKnqpVLuzdsgPP3rqQeybA2ln7jiiTLY8f++QryWVXinqBBgiwWEUhYJqWenQ0IgA4da1aGuj3kn0HYaW8b15CZ/auVyre5ccMYI3J4XYQ29vL285rXIuNM3XSmPEecf7+/G/lh6AUNhgWngRzsCHIGiAQ/aOM+s4wwiL/pWxN82XgkHFQs0+NwBErWznRd0NutXI0exttTTtsoTqOTFHg+K+Z2At+4FOK2tvJdVFxJp4bz97c9fL6EbXEpBRhuVz16XSJf8oTPqsebu6cib0/TwSNHc3q90IgPX6WrIXz5gp4m9vl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjo1JXe5mcDxp5KRE5XYwALyEiEaGqpV2YdN8cXhoQ=;
 b=nFu96LytFJE/cHcjVkaoLMf1upk6LSITEfgobYLO79jeW5QvNxj/b4QKN4sI6jqzSQayrJ5RWWRgqt9rM70MKTdoqymRIkv1RrVeJmoqdVUi9pwhebV3CtnjKYoOyVo2b1nR67orIRftn3zwJZO23TN8Ru96ErBFk+nUvIu6pOVpH90YN/zPjpEBD7Mb/W6LRUA+lxRQqkYtxv9yyMsOMByi8fVJ5fXtTz8Uj4WMRpzfxJnP/Um4T/E7ppL0n22oth8P9q6o0RWW5jqTq226r/yDBS4iWvnCNB1WkEW1haD26ufthZWHz79dIMvdn5ZzBlzQU8CSYwyGd4+/THi0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjo1JXe5mcDxp5KRE5XYwALyEiEaGqpV2YdN8cXhoQ=;
 b=N4NonOsOUCpF9zDqXchWorlbavMHVaKbZYkhLx4WMQzUPDaEWrRZDbEwMAheQmlkIS6X8YAM4EJXaYHJz0jrBbVXevI7+aKyPJdt+Qy3UPbO7XLm16EFIZJgC5mMayseROJFkgnHHkSVZPju+2NUwtI6fZcAenQNGZCRncP8+6M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 00:03:52 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 00:03:52 +0000
Date:   Thu, 23 Jul 2020 17:03:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v5 bpf-next 1/5] selftests/bpf: Add test for
 CGROUP_STORAGE map on multiple attaches
Message-ID: <20200724000350.rs46ybnkqcgxuog7@kafai-mbp>
References: <cover.1595489786.git.zhuyifei@google.com>
 <46200200d3a12dac05a4f8b8cefebebce06bd6db.1595489786.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46200200d3a12dac05a4f8b8cefebebce06bd6db.1595489786.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:a03:117::23) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:ea06) by BYAPR08CA0046.namprd08.prod.outlook.com (2603:10b6:a03:117::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 00:03:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:ea06]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca76af6-7524-472e-6879-08d82f650c62
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28223A5F9D08231F06C304D3D5770@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NydTbRfiioJnljv1CLJ2hksjhzt6Fv4Y/2wP++xZGQs4HcGC8ngDs/FwzuTTMJPccX56JZSHvEwnLkbqqoWsYZI95d1HnbOS7w9bsLff5UM24p4X4rLc9RWEf9nFkpEol8m5tbtm8EKz3Gz33DVtuMmffiVzuIV5uteF9dJLoI+KLXM0gsHzOdHNM904SLk6mu+hIXWabM4xmPccwMSm8A85CSdxkgVkWStMkypXSVjCshsMfgUYxHXVw8jp0msdrkj82t1WkajIFnqH+I7u4mo8QCLMbaqkhiweLyPREU8V+sMLepzNm+yY2DilesaI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(478600001)(4326008)(8676002)(33716001)(316002)(5660300002)(9686003)(86362001)(66556008)(66476007)(66946007)(8936002)(2906002)(54906003)(55016002)(186003)(1076003)(16526019)(6496006)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YSA3wLB697Q+KGI1Kfh0wW6d6szDnRTOJI3Lc7iLs1R80NFlunpIrSYMqUCdmqQG5Hx9bpdqdUt2kGYhkUy0qr/oGBqJ536FWNRFvx0eq5bVnR4XIbc3YQaw59nTzirTMbB9am3zTqD50fxnfbSIEsQxBAVoA+guL6OymSLXt+DnlpkImb3jAym+qkb0JEx+46vsKX2YJbc3KU3ek4d6OB/s3Q2TyimkhePjtXE96+jZv6FIlHtTfD+0BXm2uBW3wXlxKRcoJn4tyUq9S6+FJKc8pJn01v2rZAgFGR3mXkgZSqf9Y9J/zJWEVb2QFc5MyQ7SuwH7Iw02PU9p4akfu1c893gFrcBYA9/HqC1VwuH+lAYZtzgIp2J8cPqUS8kZyw+el6H8ALJ2YENJZlwaGesd8gN8/vao+w0sxMF2vTB+qegclUSFMADy9N4ycDP0a924/xaenDizuhs0yLme1pwqdJ+6ZqgO7vjWahqB/zOqPh9aWp82FukrFISVP6wCKK7ylis6hf6pHOKjh3Eztg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eca76af6-7524-472e-6879-08d82f650c62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 00:03:52.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oQY7c6VN73B3FlGWnFPdKlEJB83sze40IfKSWNbH2MrDuOOgQdF8UBzEmQ88PEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 02:40:54AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This test creates a parent cgroup, and a child of that cgroup.
> It attaches a cgroup_skb/egress program that simply counts packets,
> to a global variable (ARRAY map), and to a CGROUP_STORAGE map.
> The program is first attached to the parent cgroup only, then to
> parent and child.
> 
> The test cases sends a message within the child cgroup, and because
> the program is inherited across parent / child cgroups, it will
> trigger the egress program for both the parent and child, if they
> exist. The program, when looking up a CGROUP_STORAGE map, uses the
> cgroup and attach type of the attachment parameters; therefore,
> both attaches uses different cgroup storages.
> 
> We assert that all packet counts returns what we expects.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  .../bpf/prog_tests/cg_storage_multi.c         | 163 ++++++++++++++++++
>  .../bpf/progs/cg_storage_multi_egress_only.c  |  30 ++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> new file mode 100644
> index 000000000000..6d5a2194e036
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include <cgroup_helpers.h>
> +#include <network_helpers.h>
> +
> +#include "cg_storage_multi_egress_only.skel.h"
> +
> +#define PARENT_CGROUP "/cgroup_storage"
> +#define CHILD_CGROUP "/cgroup_storage/child"
> +
> +static int duration;
> +
> +static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
> +			   __u32 expected)
> +{
> +	struct bpf_cgroup_storage_key key = {0};
> +	__u32 value;
> +	int map_fd;
> +
> +	map_fd = bpf_map__fd(map);
> +
> +	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
> +	key.attach_type = BPF_CGROUP_INET_EGRESS;
> +	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
> +		  "map-lookup", "errno %d", errno))
> +		return true;
> +	if (CHECK(value != expected,
> +		  "assert-storage", "got %u expected %u", value, expected))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
> +{
> +	struct bpf_cgroup_storage_key key = {0};
> +	__u32 value;
> +	int map_fd;
> +
> +	map_fd = bpf_map__fd(map);
> +
> +	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
> +	key.attach_type = BPF_CGROUP_INET_EGRESS;
> +	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) == 0,
> +		  "map-lookup", "succeeded, expected ENOENT"))
> +		return true;
> +	if (CHECK(errno != ENOENT,
> +		  "map-lookup", "errno %d, expected ENOENT", errno))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool connect_send(const char *cgroup_path)
> +{
> +	bool res = true;
> +	int server_fd = -1, client_fd = -1;
> +
> +	if (join_cgroup(cgroup_path))
> +		goto out_clean;
> +
> +	server_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
> +	if (server_fd < 0)
> +		goto out_clean;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (client_fd < 0)
> +		goto out_clean;
> +
> +	if (send(client_fd, "message", strlen("message"), 0) < 0)
> +		goto out_clean;
> +
> +	res = false;
> +
> +out_clean:
> +	close(client_fd);
> +	close(server_fd);
> +	return res;
> +}
> +
> +static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
> +{
> +	struct cg_storage_multi_egress_only *obj;
> +	struct bpf_link *parent_link = NULL, *child_link = NULL;
> +	bool err;
> +
> +	obj = cg_storage_multi_egress_only__open_and_load();
> +	if (CHECK(!obj, "skel-load", "errno %d", errno))
> +		return;
> +
> +	/* Attach to parent cgroup, trigger packet from child.
> +	 * Assert that there is only one run and in that run the storage is
> +	 * parent cgroup's storage.
> +	 * Also assert that child cgroup's storage does not exist
> +	 */
> +	parent_link = bpf_program__attach_cgroup(obj->progs.egress,
> +						 parent_cgroup_fd);
> +	if (CHECK(IS_ERR(parent_link), "parent-cg-attach",
> +		  "err %ld", PTR_ERR(parent_link)))
> +		goto close_bpf_object;
> +	err = connect_send(CHILD_CGROUP);
> +	if (CHECK(err, "first-connect-send", "errno %d", errno))
> +		goto close_bpf_object;
> +	if (CHECK(obj->bss->invocations != 1,
> +		  "first-invoke", "invocations=%d", obj->bss->invocations))
> +		goto close_bpf_object;
> +	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 1))
> +		goto close_bpf_object;
> +	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
> +		goto close_bpf_object;
> +
> +	/* Attach to parent and child cgroup, trigger packet from child.
> +	 * Assert that there are two additional runs, one that run with parent
> +	 * cgroup's storage and one with child cgroup's storage.
> +	 */
> +	child_link = bpf_program__attach_cgroup(obj->progs.egress,
> +						child_cgroup_fd);
> +	if (CHECK(IS_ERR(child_link), "child-cg-attach",
> +		  "err %ld", PTR_ERR(child_link)))
> +		goto close_bpf_object;
> +	err = connect_send(CHILD_CGROUP);
> +	if (CHECK(err, "second-connect-send", "errno %d", errno))
> +		goto close_bpf_object;
> +	if (CHECK(obj->bss->invocations != 3,
> +		  "second-invoke", "invocations=%d", obj->bss->invocations))
> +		goto close_bpf_object;
> +	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 2))
> +		goto close_bpf_object;
> +	if (assert_storage(obj->maps.cgroup_storage, CHILD_CGROUP, 1))
> +		goto close_bpf_object;
> +
> +close_bpf_object:
> +	if (parent_link)
Nit. I think bpf_link__destroy() is already NULL safe.

> +		bpf_link__destroy(parent_link);
> +	if (child_link)
> +		bpf_link__destroy(child_link);
> +
> +	cg_storage_multi_egress_only__destroy(obj);
> +}
> +
