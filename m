Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49046147494
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgAWXVO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:21:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729277AbgAWXVN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 18:21:13 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NNJKt9023824;
        Thu, 23 Jan 2020 15:20:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1jEKBxgyF6Dzewd+xjmWtfaKPgkRiussRG+Hs89Udx0=;
 b=g67+3Fd5ScZrvlT73xDKgyK3ofFgGb+rWxVFZyOu5kiiqQ3maHw1shkTKjQ05OPeHwGC
 cChtPov/GZW1U1c2GCSIq7+5tVIBfQjbXT4aQJODfcZebd7J36mHaUGHUxOx32nVJ+8u
 VZ8kQHR5ifPabcnIqHN1wb+F3TjsWSYvHto= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xpu216uhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 15:20:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 15:20:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLM9HtGSELNH+f6MwS0V/bxhva27wUew+JwDu7waeqofFBebkMVtJ6IXJLLYaKIJ78L0+bmqH0qzI0kwFCOd/K98cl9SU7fryyKZtH0QIMacrCTaR0U1c2bsNVczAmPgW/XSnYL8J00kjhnGCDjAm+KHXwfTOjVK1HZCBtd8N1gnePSnt2m2wKcVUFm+aSUD4Ve3FW29ntinEZW672QxammZZgCOtgTv7fJ98NcMjb2s6d3AUy9d1wuYOVT+RQZeHWwTeNjNFpS8NbY49moJOUNKW+mLdEV8ng8PzfPwLOlhjP5ZG7gS0LlW6y5RAhAwcoxDg4cxkJuf6qjQNNg1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jEKBxgyF6Dzewd+xjmWtfaKPgkRiussRG+Hs89Udx0=;
 b=QO6YStZgnHsUVIykm9RDPgDCckhfu0tRoM/R2icKeL8FHeQl8a9lMqosKLHGP7qFl3xNqVfTd6SD9cygA6VIbdgVeTDG5cOVwo5l4wb3+0VZvs33zPl4di6UwS2WrI2swiI1i6y23UgVe9w+0yMSEIVINjmrxiW+BOkot70PR8M0pBsp+NafBIV0uS+Y075k8KjEPjD13osRHRpQHMbRVPrCg9/p68xQGuB4O9OQFFx+u0HbzeQWH4Wm/znt06YcKYh2AUiGkKL3I351Zp+XZU0f+qoQ/2UdmejY7q/zVefUnK2JG8LbI7idHmaUBSF4/jvv5wyltINmvcU/20UnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jEKBxgyF6Dzewd+xjmWtfaKPgkRiussRG+Hs89Udx0=;
 b=O3qtM000w1pWnVbT9G+3WAqN2pS6vI2S/me92mkywQAYtW2fURNIYReM/kaBbIiMCdDAuCRKPUdpUkMn0TUVlb58X/x6nE0lKV+nz8C66xZxmDjEohz96o/Lcmhq1LUBxIH/Pr4EsEiu/BBTLgBSw/5uVPBU4cgP3cQM+wFE1ig=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB2989.namprd15.prod.outlook.com (20.178.251.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 23:20:44 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 23:20:44 +0000
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:200::2:d66d) by CO1PR15CA0046.namprd15.prod.outlook.com (2603:10b6:101:1f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 23:20:42 +0000
From:   Martin Lau <kafai@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add
 bpf_perf_prog_read_branches() selftest
Thread-Topic: [PATCH v3 bpf-next 3/3] selftests/bpf: add
 bpf_perf_prog_read_branches() selftest
Thread-Index: AQHV0jNm0a9RiyoxwUS3VlcHP8aotqf44wwA
Date:   Thu, 23 Jan 2020 23:20:44 +0000
Message-ID: <20200123232040.dqsswmoltc3rlqhm@kafai-mbp.dhcp.thefacebook.com>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
 <20200123212312.3963-4-dxu@dxuuu.xyz>
In-Reply-To: <20200123212312.3963-4-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:101:1f::14) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d66d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03aea31c-1a0e-4844-4d54-08d7a05adeaa
x-ms-traffictypediagnostic: MN2PR15MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB2989E6A7731B0B425D2EF892D50F0@MN2PR15MB2989.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(7696005)(52116002)(81166006)(316002)(71200400001)(81156014)(186003)(6916009)(2906002)(55016002)(9686003)(54906003)(86362001)(4326008)(6506007)(8936002)(5660300002)(1076003)(16526019)(8676002)(66556008)(478600001)(66946007)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB2989;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uVeiFzc74WCzs9nAnu973yT5bbK53dRp/0ByJTLPBPE0cZUQH/sSs4c5t0dTpEoUG4PkQlzrBlZmC+Jicb9bE/3AibWJmuseR3023Od7wCf2hZtgpS9QOGHiLg/+cZcCQkvg9YzBgM0iRqF/pXz7Gybaz8oXNVO8GjltFrH7qF6yTDj1Aurk1SSl5OUntf6AqFAqkNn+JRKppamkLhTCRS5EyqPQw8dC/dzrr+w9gceZ0eIfASg5eZmqDKeDJ3Fsr/rxuQoB96yFZJ+bBeHyN3zXeJ3JaHDjnfjhesCDZHf1xRtQ2XG5iPz7hhqk8kUspH6eTTFQVPy+gXySj6E1ZLfnmykTqQxovy+p1NQjeZ5lQ5dLkE+llkM7SNSyhBP/fEZbtyWxnfZjqbD4ybJG3bHMGvtjQYt+ohfVaYhLIy8hN19vtpqySvqDi19CBu1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB65E96AF005944286A502C47588A92A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aea31c-1a0e-4844-4d54-08d7a05adeaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 23:20:44.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZAkmHzv+51geLFCRaZiTMM95wpcWdkO28MKIwjso2NsCDxLwKvzu6F99aehbDYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2989
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_13:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 01:23:12PM -0800, Daniel Xu wrote:
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Please put some details to avoid empty commit message.
Same for patch 2.

> ---
>  .../selftests/bpf/prog_tests/perf_branches.c  | 106 ++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_branches.c  |  39 +++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.=
c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
> new file mode 100644
> index 000000000000..f8d7356a6507
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <sys/socket.h>
> +#include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
> +
> +static void on_sample(void *ctx, int cpu, void *data, __u32 size)
> +{
> +	int pbe_size =3D sizeof(struct perf_branch_entry);
> +	int ret =3D *(int *)data, duration =3D 0;
> +
> +	// It's hard to validate the contents of the branch entries b/c it
> +	// would require some kind of disassembler and also encoding the
> +	// valid jump instructions for supported architectures. So just check
> +	// the easy stuff for now.
/* ... */ comment style

> +	CHECK(ret < 0, "read_branches", "err %d\n", ret);
> +	CHECK(ret % pbe_size !=3D 0, "read_branches",
> +	      "bytes written=3D%d not multiple of struct size=3D%d\n",
> +	      ret, pbe_size);
> +
> +	*(int *)ctx =3D 1;
> +}
> +
> +void test_perf_branches(void)
> +{
> +	int err, prog_fd, i, pfd =3D -1, duration =3D 0, ok =3D 0;
> +	const char *file =3D "./test_perf_branches.o";
> +	const char *prog_name =3D "perf_event";
> +	struct perf_buffer_opts pb_opts =3D {};
> +	struct perf_event_attr attr =3D {};
> +	struct bpf_map *perf_buf_map;
> +	struct bpf_program *prog;
> +	struct bpf_object *obj;
> +	struct perf_buffer *pb;
> +	struct bpf_link *link;
> +	volatile int j =3D 0;
> +	cpu_set_t cpu_set;
> +
> +	/* load program */
> +	err =3D bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
> +	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno)) {
> +		obj =3D NULL;
> +		goto out_close;
> +	}
> +
> +	prog =3D bpf_object__find_program_by_title(obj, prog_name);
> +	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", prog_name))
> +		goto out_close;
> +
> +	/* load map */
> +	perf_buf_map =3D bpf_object__find_map_by_name(obj, "perf_buf_map");
> +	if (CHECK(!perf_buf_map, "find_perf_buf_map", "not found\n"))
> +		goto out_close;
Using skel may be able to cut some lines.

> +
> +	/* create perf event */
> +	attr.size =3D sizeof(attr);
> +	attr.type =3D PERF_TYPE_HARDWARE;
> +	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> +	attr.freq =3D 1;
> +	attr.sample_freq =3D 4000;
> +	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> +	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANC=
H_ANY;
> +	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
> +	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
> +		goto out_close;
> +
> +	/* attach perf_event */
> +	link =3D bpf_program__attach_perf_event(prog, pfd);
> +	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(link)=
))
> +		goto out_close_perf;
> +
> +	/* set up perf buffer */
> +	pb_opts.sample_cb =3D on_sample;
> +	pb_opts.ctx =3D &ok;
> +	pb =3D perf_buffer__new(bpf_map__fd(perf_buf_map), 1, &pb_opts);
> +	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
> +		goto out_detach;
> +
> +	/* generate some branches on cpu 0 */
> +	CPU_ZERO(&cpu_set);
> +	CPU_SET(0, &cpu_set);
> +	err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_se=
t);
> +	if (err && CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
'err &&' seems unnecessary.

> +		goto out_free_pb;
> +	for (i =3D 0; i < 1000000; ++i)
May be some comments on 1000000?

> +		++j;
> +
> +	/* read perf buffer */
> +	err =3D perf_buffer__poll(pb, 500);
> +	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
> +		goto out_free_pb;
> +
> +	if (CHECK(!ok, "ok", "not ok\n"))
> +		goto out_free_pb;
> +
> +out_free_pb:
> +	perf_buffer__free(pb);
> +out_detach:
> +	bpf_link__destroy(link);
> +out_close_perf:
> +	close(pfd);
> +out_close:
> +	bpf_object__close(obj);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/too=
ls/testing/selftests/bpf/progs/test_perf_branches.c
> new file mode 100644
> index 000000000000..d818079c7778
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook
> +
> +#include <linux/ptrace.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_trace_helpers.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(int));
> +	__uint(value_size, sizeof(int));
> +} perf_buf_map SEC(".maps");
> +
> +struct fake_perf_branch_entry {
> +	__u64 _a;
> +	__u64 _b;
> +	__u64 _c;
> +};
> +
> +SEC("perf_event")
> +int perf_branches(void *ctx)
> +{
> +	int ret;
> +	struct fake_perf_branch_entry entries[4];
Try to keep the reverse xmas tree.

> +
> +	ret =3D bpf_perf_prog_read_branches(ctx,
> +					  entries,
> +					  sizeof(entries));
> +	/* ignore spurious events */
> +	if (!ret)
Check for -ve also?

> +		return 1;
> +
> +	bpf_perf_event_output(ctx, &perf_buf_map, BPF_F_CURRENT_CPU,
> +			      &ret, sizeof(ret));
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --=20
> 2.21.1
>=20
