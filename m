Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E413422BAB7
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGXAAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 20:00:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgGXAAE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 20:00:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NNxeAJ018851;
        Thu, 23 Jul 2020 16:59:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/y+0Tk+WQEM4gCaR5i/72aCVoPV+ea3KgyvHzKWmDvQ=;
 b=ICOt6entC+LjzIhfcn32ZNbBF1vwGgGJlOleooQ5JVepW8tFDCLm7epGSbokJS4DJpFU
 D7hhTM5R4t5s4jwk688cp6s0KvooT0gtknsU9boWpdK55bxbvlNNDOtLFSbVscgIjhSJ
 Wa4D1QXE2ZY1qyr0dvN+bcqyogMy/a5BpsE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32esyuy3t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 16:59:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 16:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7qBIJDe28wHOCDmn1CrpKg/oQaS67geQU7rjtCGAVr/bkJ3puv2L8fbdiyHeGMsfKxbfqdaotOekqx0RdobX3uEGNnxhojDw+LJRB4+yQAfFkoyAb/ovUty/OyiRxx4QuLJvxLwxV48Gu7a7c4wY5dKQmDSJknrmjfj+ymCbI+Ld8FwL9Q1mFIKaEk+95BuhGqET3m1Rdm8s52p7iEuxm9nX3mdF4tUHxHkXyWxoDPUMr3ar5y/PM749Wzbu7CTyJRvKJu87CGoeWWda0srG7NzwfP1ygOlL8lS/9GbObwaWEM0FANzxH/ucW/TVOGF9hQT07cgREh8U13vCOW3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y+0Tk+WQEM4gCaR5i/72aCVoPV+ea3KgyvHzKWmDvQ=;
 b=DpKcI/ni9Ro1SO5j05xfEMiEqYqw12t8HpzCRSUep5zHwHm8fn+YjotQ3qfTSiKFm3k3Lyor48XV+bM4ye/A+wjYtqS1vdL6DVPaYb4bSnk8bHItqtr0m5Hf56TJigoojzeu9QU+N713ddq6e06QJIHs8YTP+r8LYRBg9RbVejsxdim2BrOz0qZbJg07s5ZsUWfX6Ma8rAQfpCsf+AMLPsptnSQWC0Buv7/5hOYjb9P62UoZR1e2o8gWNy6Jx57SCZPUp5ao8F4aPR1GGTAaLEm3G3qIpZMphzfhCsZsBsQF/z2dBBqiOYilujvKsyp64dBD6YOmCBmLs/TPEMI+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y+0Tk+WQEM4gCaR5i/72aCVoPV+ea3KgyvHzKWmDvQ=;
 b=MawsYnly5ZN5vlhgi5CmBf4ffY1bwMSeOV2UzKoetlR8NfYv+OfkqipJNTC8x3gT2zqMneAOfvYadcNMzQ2YoK4NMVw5JikgOMXeXejVnyHzaK15FGlUi3wNEOhjEwFh9E9a/6iEuIAhhbTx9Q0+5Gldokgw966lAU5/Wf3HtR4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Thu, 23 Jul
 2020 23:59:43 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 23:59:43 +0000
Date:   Thu, 23 Jul 2020 16:59:41 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] selftests/bpf: Test CGROUP_STORAGE map
 can't be used by multiple progs
Message-ID: <20200723235941.jrxo3az7hpg6tts2@kafai-mbp>
References: <cover.1595489786.git.zhuyifei@google.com>
 <16989c2daceb609f6538f132987a66a84aa2032a.1595489786.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16989c2daceb609f6538f132987a66a84aa2032a.1595489786.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:ea06) by BYAPR06CA0008.namprd06.prod.outlook.com (2603:10b6:a03:d4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Thu, 23 Jul 2020 23:59:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:ea06]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcb498a-d5c1-405f-7ef0-08d82f647803
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB282207EEB7556E2CD72AAAFBD5760@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Yd6Aj4uQgTFGRed/nzC94K8Kt0DRn4ch75VpVlXkFX1wQ+W54fhvRAnei8iVT2jzvi3wf2Ai27G2vs37OTVrrqAAhhxBs4QPc8kBIz2ufrU2USm0y1o5H2dPiD/gZ2uR67B1bx82Qv8OiHFmsKbmb4a7Hb5JBHUAEmaDWY6WFUd+rn0ggiVyHZ0ukgLKcLI+iW09512qf4QFGlcYdxYi09gn+OMu2zm+KOCFrXF1ErLkVYYm6OHpzRbASWwjiK6Ql1MrhsrixQDkXKws4IR3P2B8Mauj0KX2Ts4QeIaE1PxEY1ZIO+nMcQdWqiST6ErSI6B1W+g3NPi8EhSt3TDZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(478600001)(4326008)(8676002)(33716001)(316002)(5660300002)(9686003)(86362001)(66556008)(66476007)(66946007)(8936002)(2906002)(54906003)(55016002)(186003)(1076003)(16526019)(6496006)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vhNO10Xn/boB0MjNW9IJLsu7AzZ7q0yiRIXr8DLNcIsgLAMjXdIbjGJLDOkAi3mLAMif/wAydLwox3Evvt3IYBzse5V+UjC/WKdepk7iWbARNt6n7tDgxhIZlyOtkEIcwJmze9Cz3KJmfZ7mfZV1NsrNj8STnCtuChr/MroAg1O+AC3rbL+udxlwopekrNDM1tuKlHdfQYo4k2cOC+aEEFkh6QStJ+B9/IR4c8qAE1UYKSRsfb72h8yVmbok4VOXP2QZXEeXZy+Eo09JStBBciEO7ltS+hUEC1Xxf5Vbc/7j+fJtGXNLkYKN6f4M2YHWITv2kWObsPhRj9rXlmyVyoXBEo8dR5y3fWZhYRG/xh4VfX2RtONfH/2BOPGmmhluLv1FA1cbtnLRvxsLsY2l09IF1lFsAp+Dd1Bxe7pCO5p2AxmD+YUJ4b/MXkMvhrX2Jc6zII83twJzPeWJfbMT9Dp9L5Q8uf4QgSoeR42WHFM4SvAaleLyAHynythfrjslaQvEbU5/PjZsCOUX4Jnp3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcb498a-d5c1-405f-7ef0-08d82f647803
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 23:59:43.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZXwyyktCe5NVUNAukXildUMAeuco/pJ1VvrAnTBtNYyv1AFuCexhNuPYdgNmHLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 02:40:55AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The current assumption is that the lifetime of a cgroup storage
> is tied to the program's attachment. The storage is created in
> cgroup_bpf_attach, and released upon cgroup_bpf_detach and
> cgroup_bpf_release.
> 
> Because the current semantics is that each attachment gets a
> completely independent cgroup storage, and you can have multiple
> programs attached to the same (cgroup, attach type) pair, the key
> of the CGROUP_STORAGE map, looking up the map with this pair could
> yield multiple storages, and that is not permitted. Therefore,
> the kernel verifier checks that two programs cannot share the same
> CGROUP_STORAGE map, even if they have different expected attach
> types, considering that the actual attach type does not always
> have to be equal to the expected attach type.
> 
> The test creates a CGROUP_STORAGE map and make it shared across
> two different programs, one cgroup_skb/egress and one /ingress.
> It asserts that the two programs cannot be both loaded, due to
> verifier failure from the above reason.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  .../bpf/prog_tests/cg_storage_multi.c         | 42 +++++++++++++----
>  .../selftests/bpf/progs/cg_storage_multi.h    | 13 ++++++
>  .../progs/cg_storage_multi_egress_ingress.c   | 45 +++++++++++++++++++
>  .../bpf/progs/cg_storage_multi_egress_only.c  |  9 ++--
>  4 files changed, 98 insertions(+), 11 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi.h
>  create mode 100644 tools/testing/selftests/bpf/progs/cg_storage_multi_egress_ingress.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> index 6d5a2194e036..1f4ab437ddb9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> @@ -8,7 +8,10 @@
>  #include <cgroup_helpers.h>
>  #include <network_helpers.h>
>  
> +#include "progs/cg_storage_multi.h"
> +
>  #include "cg_storage_multi_egress_only.skel.h"
> +#include "cg_storage_multi_egress_ingress.skel.h"
>  
>  #define PARENT_CGROUP "/cgroup_storage"
>  #define CHILD_CGROUP "/cgroup_storage/child"
> @@ -16,10 +19,10 @@
>  static int duration;
>  
>  static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
> -			   __u32 expected)
> +			   struct cgroup_value *expected)
>  {
>  	struct bpf_cgroup_storage_key key = {0};
> -	__u32 value;
> +	struct cgroup_value value;
>  	int map_fd;
>  
>  	map_fd = bpf_map__fd(map);
> @@ -29,8 +32,8 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
>  	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
>  		  "map-lookup", "errno %d", errno))
>  		return true;
> -	if (CHECK(value != expected,
> -		  "assert-storage", "got %u expected %u", value, expected))
> +	if (CHECK(memcmp(&value, expected, sizeof(struct cgroup_value)),
> +		  "assert-storage", "storages differ"))
>  		return true;
>  
>  	return false;
> @@ -39,7 +42,7 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
>  static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
>  {
>  	struct bpf_cgroup_storage_key key = {0};
> -	__u32 value;
> +	struct cgroup_value value;
>  	int map_fd;
>  
>  	map_fd = bpf_map__fd(map);
> @@ -86,6 +89,7 @@ static bool connect_send(const char *cgroup_path)
>  static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
>  {
>  	struct cg_storage_multi_egress_only *obj;
> +	struct cgroup_value expected_cgroup_value;
>  	struct bpf_link *parent_link = NULL, *child_link = NULL;
>  	bool err;
>  
> @@ -109,7 +113,9 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
>  	if (CHECK(obj->bss->invocations != 1,
>  		  "first-invoke", "invocations=%d", obj->bss->invocations))
>  		goto close_bpf_object;
> -	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 1))
> +	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
> +	if (assert_storage(obj->maps.cgroup_storage,
> +			   PARENT_CGROUP, &expected_cgroup_value))
>  		goto close_bpf_object;
>  	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
>  		goto close_bpf_object;
> @@ -129,9 +135,13 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
>  	if (CHECK(obj->bss->invocations != 3,
>  		  "second-invoke", "invocations=%d", obj->bss->invocations))
>  		goto close_bpf_object;
> -	if (assert_storage(obj->maps.cgroup_storage, PARENT_CGROUP, 2))
> +	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 2 };
> +	if (assert_storage(obj->maps.cgroup_storage,
> +			   PARENT_CGROUP, &expected_cgroup_value))
>  		goto close_bpf_object;
> -	if (assert_storage(obj->maps.cgroup_storage, CHILD_CGROUP, 1))
> +	expected_cgroup_value = (struct cgroup_value) { .egress_pkts = 1 };
> +	if (assert_storage(obj->maps.cgroup_storage,
> +			   CHILD_CGROUP, &expected_cgroup_value))
>  		goto close_bpf_object;
>  
>  close_bpf_object:
> @@ -143,6 +153,19 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
>  	cg_storage_multi_egress_only__destroy(obj);
>  }
>  
> +static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
> +{
> +	struct cg_storage_multi_egress_ingress *obj;
> +
> +	/* Cannot load both programs due to verifier failure:
> +	 * "only one cgroup storage of each type is allowed"
> +	 */
> +	obj = cg_storage_multi_egress_ingress__open_and_load();
> +	if (CHECK(obj || errno != EBUSY,
> +		  "skel-load", "errno %d, expected EBUSY", errno))
obj may theoretically need to be freed.
Probably not big deal since this case will be gone in
the latter test.

> +		return;
> +}
> +
