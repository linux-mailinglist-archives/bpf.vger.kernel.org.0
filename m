Return-Path: <bpf+bounces-35701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93093CD04
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B45CB2148B
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA722F1E;
	Fri, 26 Jul 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qTzhsD8V"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5732032D
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964790; cv=none; b=BEitZlm7qJ6yb4uXpaEkHa+f2w0IRvnqenmqT/DesItPl0Htgac+68huhczQnpHLh2MT+fB7b7d6CN6+IBkEDlVuBiYCT4y7eClmXDT/S6UoaiIYj8jKQn7KPV2X0ywtzAi2KIsPouLJu7lGlCb5EUrt5kJzGDaK4Bfzur7va5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964790; c=relaxed/simple;
	bh=TxOdaf8QxyBhXk1yqy85ZrlahHfi6Xatdx9C/sj4TtE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PoXQy0MmunZ0sjfTuM99K+yi7W/8D3PIKS68o7gbL3KvxCsYiq1LmCfp+vf29Mwn+/ndi660wXmpnZ44xwSdP0n0mvOXq+60tUBrt40RPJXtUjokLrtJMS/I383s1n7u0VcgqSjcnbbUvB1q5fA746+7XYBR4Tf0axQqqUUOocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qTzhsD8V; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721964786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kyaWJrpohgGNlgTt2o3lAr8+b5kCUUo1mVdyeuICGI=;
	b=qTzhsD8VJYFfoCi6dXAosaTKOiiTSR7MR6KiHD1ptZ+tXG4FiKhF4vbOfwldQywzxS4a9i
	AfYnw4J+9g7T79jeYyEp4bxxPsuqxsd2ylpRnD4wPe9Cj2zOL+e95B0nRhXaajjwjtkF5V
	DDN299CD1FKLicAikrDwTVED8z9fB5M=
Date: Fri, 26 Jul 2024 03:33:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: leon.hwang@linux.dev
Message-ID: <44ac0e987d616239b07960619e8c684e6bbdc98f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcase for updating
 attached freplace prog to PROG_ARRAY map
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
In-Reply-To: <12d2779b-332f-4914-9f03-6eca5f73b81a@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-3-leon.hwang@linux.dev>
 <12d2779b-332f-4914-9f03-6eca5f73b81a@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Yonghong,

Thank you for your review.

26 July 2024 at 05:11, "Yonghong Song" <yonghong.song@linux.dev> wrote:



>=20
>=20On 7/24/24 5:32 PM, Leon Hwang wrote:
>=20
>=20>=20
>=20> Add a selftest to confirm the issue, which gets -EINVAL when update
> >=20
>=20>  attached freplace prog to PROG_ARRAY map, has been fixed.
> >=20
>=20>  cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> >=20
>=20>  327/25 tailcalls/tailcall_freplace:OK
> >=20
>=20>  327 tailcalls:OK
> >=20
>=20>  Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED
> >=20
>=20>  Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  .../selftests/bpf/prog_tests/tailcalls.c | 76 ++++++++++++++++++-
> >=20
>=20>  .../selftests/bpf/progs/tailcall_freplace.c | 33 ++++++++
> >=20
>=20>  .../testing/selftests/bpf/progs/tc_bpf2bpf.c | 23 ++++++
> >=20
>=20>  3 files changed, 131 insertions(+), 1 deletion(-)
> >=20
>=20>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_frep=
lace.c
> >=20
>=20>  create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> >=20
>=20>  diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/=
tools/testing/selftests/bpf/prog_tests/tailcalls.c
> >=20
>=20>  index e01fabb8cc415..f1145601c0005 100644
> >=20
>=20>  --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> >=20
>=20>  +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> >=20
>=20>  @@ -5,7 +5,8 @@
> >=20
>=20>  #include "tailcall_poke.skel.h"
> >=20
>=20>  #include "tailcall_bpf2bpf_hierarchy2.skel.h"
> >=20
>=20>  #include "tailcall_bpf2bpf_hierarchy3.skel.h"
> >=20
>=20>  -
> >=20
>=20>  +#include "tailcall_freplace.skel.h"
> >=20
>=20>  +#include "tc_bpf2bpf.skel.h"
> >=20
>=20>  > /* test_tailcall_1 checks basic functionality by patching multip=
le locations
> >=20
>=20>  * in a single program for a single tail call slot with nop->jmp, j=
mp->nop
> >=20
>=20>  @@ -1495,6 +1496,77 @@ static void test_tailcall_bpf2bpf_hierarchy=
_3(void)
> >=20
>=20>  RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
> >=20
>=20>  }
> >=20
>=20>  > +/* test_tailcall_freplace checks that the attached freplace pro=
g is OK to
> >=20
>=20>  + * update to PROG_ARRAY map.
> >=20
>=20
> update the prog_array map.

Ack.

>=20
>=20>=20
>=20> + */
> >=20
>=20>  +static void test_tailcall_freplace(void)
> >=20
>=20>  +{
> >=20
>=20>  + struct tailcall_freplace *fr_skel =3D NULL;
> >=20
>=20>  + struct tc_bpf2bpf *tc_skel =3D NULL;
> >=20
>=20>  + struct bpf_link *fr_link =3D NULL;
> >=20
>=20>  + int prog_fd, map_fd;
> >=20
>=20>  + char buff[128] =3D {};
> >=20
>=20>  + int err, key;
> >=20
>=20>  +
> >=20
>=20>  + LIBBPF_OPTS(bpf_test_run_opts, topts,
> >=20
>=20>  + .data_in =3D buff,
> >=20
>=20>  + .data_size_in =3D sizeof(buff),
> >=20
>=20>  + .repeat =3D 1,
> >=20
>=20>  + );
> >=20
>=20>  +
> >=20
>=20>  + fr_skel =3D tailcall_freplace__open();
> >=20
>=20>  + if (!ASSERT_OK_PTR(fr_skel, "open fr_skel"))
> >=20
>=20
> if (!ASSERT_OK_PTR(fr_skel, "open fr_skel"))
>=20
>=20=3D=3D>
>=20
>=20if (!ASSERT_OK_PTR(fr_skel, "tailcall_freplace__open"))
>=20
>=20Similar for below other ASSERT_* macros.

Ack.

>=20
>=20>=20
>=20> + goto out;
> >=20
>=20
> Let us just do 'return' here.

Ack.

>=20
>=20>=20
>=20> +
> >=20
>=20>  + tc_skel =3D tc_bpf2bpf__open_and_load();
> >=20
>=20>  + if (!ASSERT_OK_PTR(tc_skel, "open tc_skel"))
> >=20
>=20>  + goto out;
> >=20
>=20>  +
> >=20
>=20>  + prog_fd =3D bpf_program__fd(tc_skel->progs.entry);
> >=20
>=20>  + if (!ASSERT_GE(prog_fd, 0, "tc_skel entry prog_id"))
> >=20
>=20>  + goto out;
> >=20
>=20
> ASSERT_GE is not necessary, prog_fd should already be valid.

Ack.

I should read bpf_program__fd() source code before using it.

>=20
>=20>=20
>=20> +
> >=20
>=20>  + err =3D bpf_program__set_attach_target(fr_skel->progs.entry,
> >=20
>=20>  + prog_fd, "subprog");
> >=20
>=20>  + if (!ASSERT_OK(err, "set_attach_target"))
> >=20
>=20>  + goto out;
> >=20
>=20>  +
> >=20
>=20>  + err =3D tailcall_freplace__load(fr_skel);
> >=20
>=20>  + if (!ASSERT_OK(err, "load fr_skel"))
> >=20
>=20>  + goto out;
> >=20
>=20>  +
> >=20
>=20>  + fr_link =3D bpf_program__attach_freplace(fr_skel->progs.entry,
> >=20
>=20>  + prog_fd, "subprog");
> >=20
>=20>  + if (!ASSERT_OK_PTR(fr_link, "attach_freplace"))
> >=20
>=20>  + goto out;
> >=20
>=20>  +
> >=20
>=20>  + prog_fd =3D bpf_program__fd(fr_skel->progs.entry);
> >=20
>=20>  + if (!ASSERT_GE(prog_fd, 0, "fr_skel entry prog_fd"))
> >=20
>=20>  + goto out;
> >=20
>=20
> prog_fd is valid here. No need ASSERT_GE.

Ack.

>=20
>=20>=20
>=20> +
> >=20
>=20>  + map_fd =3D bpf_map__fd(fr_skel->maps.jmp_table);
> >=20
>=20>  + if (!ASSERT_GE(map_fd, 0, "fr_skel jmp_table map_fd"))
> >=20
>=20>  + goto out;
> >=20
>=20
> map_fd is valid. No need ASSERT_GE.

Ack.

>=20
>=20>=20
>=20> +
> >=20
>=20>  + key =3D 0;
> >=20
>=20>  + err =3D bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
> >=20
>=20>  + if (!ASSERT_OK(err, "update jmp_table"))
> >=20
>=20>  + goto out;
> >=20
>=20>  +
> >=20
>=20>  + prog_fd =3D bpf_program__fd(tc_skel->progs.entry);
> >=20
>=20>  + if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
> >=20
>=20>  + goto out;
> >=20
>=20
> prog_fd is valid here.

Ack.

>=20
>=20>=20
>=20> +
> >=20
>=20>  + err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> >=20
>=20>  + ASSERT_OK(err, "test_run");
> >=20
>=20>  + ASSERT_EQ(topts.retval, 34, "test_run retval");
> >=20
>=20>  +
> >=20
>=20>  +out:
> >=20
>=20>  + bpf_link__destroy(fr_link);
> >=20
>=20>  + tc_bpf2bpf__destroy(tc_skel);
> >=20
>=20>  + tailcall_freplace__destroy(fr_skel);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  void test_tailcalls(void)
> >=20
>=20>  {
> >=20
>=20>  if (test__start_subtest("tailcall_1"))
> >=20
>=20>  @@ -1543,4 +1615,6 @@ void test_tailcalls(void)
> >=20
>=20>  test_tailcall_bpf2bpf_hierarchy_fentry_entry();
> >=20
>=20>  test_tailcall_bpf2bpf_hierarchy_2();
> >=20
>=20>  test_tailcall_bpf2bpf_hierarchy_3();
> >=20
>=20>  + if (test__start_subtest("tailcall_freplace"))
> >=20
>=20>  + test_tailcall_freplace();
> >=20
>=20>  }
> >=20
>=20>  diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c=
 b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> >=20
>=20>  new file mode 100644
> >=20
>=20>  index 0000000000000..80b5fa386ed9c
> >=20
>=20>  --- /dev/null
> >=20
>=20>  +++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
> >=20
>=20>  @@ -0,0 +1,33 @@
> >=20
>=20>  +// SPDX-License-Identifier: GPL-2.0
> >=20
>=20>  +
> >=20
>=20>  +#include <linux/bpf.h>
> >=20
>=20>  +#include <bpf/bpf_helpers.h>
> >=20
>=20>  +#include "bpf_legacy.h"
> >=20
>=20
> bpf_legacy.h is not needed.

Ack.

>=20
>=20>=20
>=20> +
> >=20
>=20>  +struct {
> >=20
>=20>  + __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >=20
>=20>  + __uint(max_entries, 1);
> >=20
>=20>  + __uint(key_size, sizeof(__u32));
> >=20
>=20>  + __uint(value_size, sizeof(__u32));
> >=20
>=20>  +} jmp_table SEC(".maps");
> >=20
>=20>  +
> >=20
>=20>  +int count =3D 0;
> >=20
>=20>  +
> >=20
>=20>  +__noinline
> >=20
>=20>  +int subprog(struct __sk_buff *skb)
> >=20
>=20>  +{
> >=20
>=20>  + count++;
> >=20
>=20>  +
> >=20
>=20>  + bpf_tail_call_static(skb, &jmp_table, 0);
> >=20
>=20>  +
> >=20
>=20>  + return count;
> >=20
>=20>  +}
> >=20
>=20
> subprog() can be inlined into entry(). This
>=20
>=20can avoid confusing vs. tc_bpf2bpf.c.
>=20
>=20Better if you can differentiate two 'entry()' function
>=20
>=20names, e.g., entry_freplace(), entry_tc(), it can make
>=20
>=20it easy for people to understand your change in tailcalls.c.

Indeed. Thanks for your suggestion.

>=20
>=20>=20
>=20> +
> >=20
>=20>  +SEC("freplace")
> >=20
>=20>  +int entry(struct __sk_buff *skb)
> >=20
>=20>  +{
> >=20
>=20>  + return subprog(skb);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
> >  +char __license[] SEC("license") =3D "GPL";
> >=20
>=20>  +
> >=20
>=20>  diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tool=
s/testing/selftests/bpf/progs/tc_bpf2bpf.c
> >=20
>=20>  new file mode 100644
> >=20
>=20>  index 0000000000000..4810961554585
> >=20
>=20>  --- /dev/null
> >=20
>=20>  +++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> >=20
>=20>  @@ -0,0 +1,23 @@
> >=20
>=20>  +// SPDX-License-Identifier: GPL-2.0
> >=20
>=20>  +
> >=20
>=20>  +#include <linux/bpf.h>
> >=20
>=20>  +#include <bpf/bpf_helpers.h>
> >=20
>=20>  +#include "bpf_legacy.h"
> >=20
>=20>  +
> >=20
>=20>  +__noinline
> >=20
>=20>  +int subprog(struct __sk_buff *skb)
> >=20
>=20>  +{
> >=20
>=20>  + volatile int ret =3D 1;
> >=20
>=20>  +
> >=20
>=20>  + asm volatile (""::"r+"(ret));
> >=20
>=20>  + return ret;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +SEC("tc")
> >=20
>=20>  +int entry(struct __sk_buff *skb)
> >=20
>=20>  +{
> >=20
>=20>  + return subprog(skb);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +char __license[] SEC("license") =3D "GPL";
> >=20
>=20>  +
> >
>

