Return-Path: <bpf+bounces-35711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B093CEE1
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DF12828B9
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC3176248;
	Fri, 26 Jul 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Px2+qk8d"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488017556B
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979205; cv=none; b=LqXAmBa0goee8WKiG5fM9DjPxUZesY0sK1SvrDB8kodxruvC2M1+Gs5CmQcJ0Vrb4Drxv+B9nKsepuwz+pjPjBvMWohWl75CIW9/sCWSM2jG+NzZE67OO9Nqq+a4aOqn41rbVzy2oUxbaJx83THNmVBv2m8NS5i3tTp9nTKO5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979205; c=relaxed/simple;
	bh=tDp419MrvEibfZyX92J43y7HGiIKPTLE8swO7sfWdUU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SluN9wzbYVnrAf60dxhm0mPmzPLS17zsneEb8x9n9JNq3RxEMyjBE1YfnC80vxN3ADrPqL0lmHzGyZDkwhuaa6428oChpK++6ST7oR04CINUkknJQm92bNYv1o++d4DSbQsbMk5lEtDFeKJaGPJ06WhTRclWPtVO/FAzyhRU2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Px2+qk8d; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721979201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw71XfSyrGp+b4uwhn9pLFGlZte7sC+x3dvxGeoi+cU=;
	b=Px2+qk8dNO7+wuw+YA7kNqOCzFXmt6fM5UVaLaAbFv2YEgc6Y8SScjqQPNt6FBfbTHxntq
	6WuPQv6PhTe20sBdj77VvX2hoLbt5Vnzx94lcOImNdR64f+xAwX7SqPqvJ1RfSp7i0qOd5
	x3W6TD/Ud5jCqdvBlkB5bfC4Wo8ie4Q=
Date: Fri, 26 Jul 2024 07:33:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
Message-ID: <6805b881f70b84c0ceba3adbaab9d1affec41452@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcase for updating
 attached freplace prog to PROG_ARRAY map
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
In-Reply-To: <eb964de3-1a07-49a3-9d26-68777e1fc1cb@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-3-leon.hwang@linux.dev>
 <eb964de3-1a07-49a3-9d26-68777e1fc1cb@linux.dev>
X-Migadu-Flow: FLOW_OUT

26 July 2024 at 14:16, "Yonghong Song" <yonghong.song@linux.dev> wrote:

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
>=20
> [...]
>=20
>=20>=20
>=20> diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c =
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
>=20>  +
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
>=20>  +
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
>=20>  +char __license[] SEC("license") =3D "GPL";
> >=20
>=20>  +
> >=20
>=20
> extra line in the above.

Ack.

>=20
>=20>=20
>=20> diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools=
/testing/selftests/bpf/progs/tc_bpf2bpf.c
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
> >=20
>=20
> extra line in the above.
>

Ack.

Thanks,
Leon

