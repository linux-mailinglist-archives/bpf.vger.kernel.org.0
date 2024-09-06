Return-Path: <bpf+bounces-39171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE296FD49
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA471C23CE1
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10D1591F1;
	Fri,  6 Sep 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfqitTXv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945513E03E;
	Fri,  6 Sep 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657920; cv=none; b=IhOEJM3E+63Sl84zdvAr4P4vZRJvgE2YnaXPaWE0t1NLVdcq71nS1Q2ycKDx43UtA5gDbA2ymIslyucCxjeWzqYQn8tOxv2Tjj1n0ShJjQZAg6oiNFuj4rKMEMJ3T/OCFCGzfzbOynaKWPo0F37jsI3ECTHcABfQvb26T8eQJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657920; c=relaxed/simple;
	bh=XrS12X3LVCHpuFplxbR859tEoneylDLhudm0aGAneS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIu03hx3zvvQnGu5E8ijSz8l74V2RzY5YOW1XwCBekanK0+/D9hnH0OlC7mw+OtjyaFaK80jyL7x2cnRAM6ER5wf3BUtZpSHwaNZ7XK4FUjkdjVh2OAA0kVfnzvWipzod2aauqi+smn+HNRJ8J3E1geO3NdYd7lW+BOEiq4GiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfqitTXv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so1844822a91.2;
        Fri, 06 Sep 2024 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725657918; x=1726262718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FDwaKnuEnniTcgz2ziX9XL1wJlzuKYqP1Mdi2IZZCw=;
        b=KfqitTXvvUz1azFgWIzkpjzR7hpFyD3tYRrAz50M6NaEIWegYNwaStAS7BPohnV7hJ
         SL44x5YcfpcARh01J8DOwKIlyFSZu1x9RpbQbhYDssbeQq1VlKQUB8DTC+gIlAWSFFGp
         +1OHuvUtttqBrM7jNHMrjSPidZyDuKqRocvKhMgOgkh5P2dn7/mLsd0hsgxCxeHUr3FD
         HzL2gX7HnryaWq5dt9qu8shb80Adi3tpM1hNo+T/tdPXKMUSs4TgvH3esVW5qXpYcM9G
         JTdadLrVVTCLKT5n7S3YzsxY7e+ae5y8OpBy8FTUdJIBqi7b25f/pWfbznzyLD5C2A58
         Gc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657918; x=1726262718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FDwaKnuEnniTcgz2ziX9XL1wJlzuKYqP1Mdi2IZZCw=;
        b=fDX/gqOkfTMmGFFh+LzlZwSssK0QRdypGmLI70JHugON2ufydp40AAQ2t/YgCcBXt/
         haUetWmgqUc4HSFFDJ7UuPrvn16b0o+c54+u8puKTZjoujQc+Xg5H5O7jc3rfyYaiLov
         ijIpPFtBY2q8ujAeqW77eoRIpcx63265g91CuDXQvXdKYIYdEoZIrcCW3m3XT2rbS756
         GNJ7ok2mNpa5FE1Vk1Yxv0KOCFSm+wZdz9iO1eLAoo7garkrjldccMkBwvqzvsPvjRK2
         xe2y+Y9+C5i0VTYMkVprslb3WMhTOeUU86ajsCkxovg5CE2Q83iUrocbYHtZ+vKL1uOH
         ziRA==
X-Forwarded-Encrypted: i=1; AJvYcCWhW8EMMzTEzyeHQM75vqrL16d6k3/VHZK9fArcg1D3QsodMfg341RtHZbp+oRvYWWpwJpYG8TsnVQARfJ4Hye0hLA=@vger.kernel.org, AJvYcCXwM9aTtkQ3nzJPOArvRwJDqkSdORiOn8Z1aPYIySS9/a/4nNmBkZScUHqol1q4rnOQkfsp6MRv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1W9XGRpsK1+AavN47c4wXFv9WNISRd2Gw72PEKWQlPGIs6ho5
	Dc+ZF5KrdH+gHAlOPtB83x1fb53Z4dhAkBu0XjsTuu+Fgm+dzssTfR0aOg1fnDhL+t8kDRaZBXZ
	nvVs96P7opFsAdXwjLmHs32DksD0=
X-Google-Smtp-Source: AGHT+IFC0kvWRUKeokRKj5NrR8AOqrEnCofMBiU9gIN0udm+rrhJRI9atoeeUtQCMD/fUNPy72zs/upQH/BxL7xhpKE=
X-Received: by 2002:a17:90a:8d18:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2dad50cb6f1mr4711337a91.26.1725657918482; Fri, 06 Sep 2024
 14:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com> <20240905075622.66819-3-lulie@linux.alibaba.com>
In-Reply-To: <20240905075622.66819-3-lulie@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:25:04 -0700
Message-ID: <CAEf4BzYOa7YDa215petHjuvKBOmuxXwTLwP+hET+7CE=DJG0JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Add test for __nullable
 suffix in tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, 
	shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com, 
	alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz, 
	vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:56=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Add a tracepoint with __nullable suffix in bpf_testmod, and add a
> failure load case:
>
> $./test_progs -t "module_attach"
>  #173/1   module_attach/handle_tp_btf_nullable_bare:OK
>  #173     module_attach:OK
>  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  .../bpf/bpf_testmod/bpf_testmod-events.h         |  6 ++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c      |  2 ++
>  .../selftests/bpf/prog_tests/module_attach.c     | 14 +++++++++++++-
>  .../bpf/progs/test_module_attach_fail.c          | 16 ++++++++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_module_attach_=
fail.c
>

[...]

> +
> +static void module_attach_fail(void)
> +{
> +       RUN_TESTS(test_module_attach_fail);
> +}
> +
> +void test_module_attach(void)
> +{
> +       module_attach_succ();
> +       module_attach_fail();
> +}

this is not a good idea to combine existing non-RUN_TESTS test with
RUN_TESTS. The latter is a subtest, while the former is a full test.
Keep them separate, just add a new file for
RUN_TESTS(test_module_attach_fail), or add them to existing
RUN_TESTS(), whatever makes most sense.

> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach_fail.c =
b/tools/testing/selftests/bpf/progs/test_module_attach_fail.c
> new file mode 100644
> index 0000000000000..0f848d8f2f5e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_module_attach_fail.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +#include "bpf_misc.h"
> +
> +SEC("tp_btf/bpf_testmod_test_nullable_bare")
> +__failure __msg("invalid mem access")

would be nice to confirm that register corresponding to nullable_ctx
actually has "_or_null" suffix


> +int BPF_PROG(handle_tp_btf_nullable_bare, struct bpf_testmod_test_read_c=
tx *nullable_ctx)
> +{
> +       return nullable_ctx->len;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.32.0.3.g01195cf9f
>
>

