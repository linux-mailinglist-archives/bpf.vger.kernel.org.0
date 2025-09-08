Return-Path: <bpf+bounces-67697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1BDB485FE
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 09:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0153B2D34
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E52EA74C;
	Mon,  8 Sep 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FapjAo7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52D2E7F3A
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317394; cv=none; b=tp0EGrW73Bkqkwys4+k0MY7rxxOLeMjaNMPLsZ/MmMGoHqMB3wqBkGjDs5lSiOz1UligE1fwjUHdeSgTy3KBIGITrCyCRhb+EF8u4OayyKNDMcEBzibt0Tgu/bdQMfMmuBb5iCv1RpJpSKO5+7/O6dSehJmMVTdmMU0kYtWzyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317394; c=relaxed/simple;
	bh=YmRkE5Q/NBG1GbjO5fZbIc3YcFRjbgiD7rHBFpk0TnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/+zoKCjQr68E6oXCvJBHBODtKOHpH8c0+R79CZi8QRZ3Yzb9F1WDDNs6vfEO+ZvtkImUn9uWAXTXnSrCWKlPAWeCvtj7oYjfV5bi91p/I7zDvGvMMbiDst/mneOf1Pxnac0pVnWSb/co9+Hm0ylo6c21tY1TQr+ZnyHaNzS+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FapjAo7x; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3447762b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757317392; x=1757922192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vFORQsuBb9a0i8qix2/u4ryyjGrq0N7ZEvH3oL/s/Y4=;
        b=FapjAo7xi1Q2KoSj1947n5cATAGaxCH6pY2tA9D63YpXfUvdX5saVyphSDamvOdt2b
         cY5LYS8RKKCFrRpnNcWAp4au2pVwzF71ZbTODKXjbOCD/NE+mH6xGOSlJ+VXRvxVHQXG
         7TKbgkC7Dl+4STf2XKHqAw6syXIZEhuCTHqkbImPveqRUefyYWkEzsnxdyH610yNR6FS
         K2bX9H+nb7iQw8tsJ/ps3kMBQlD97UCIuyDzcp3hscAD+t3LYe0rsEx8o6j0HTg95eV/
         n1nKBFKV83YfM+XopeMeLTKzPYBJCO0drUxbmfMvHg4H0gG7nztuZAwAW2dITK/n2XZY
         xjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317392; x=1757922192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFORQsuBb9a0i8qix2/u4ryyjGrq0N7ZEvH3oL/s/Y4=;
        b=TDCYWHA2NEtf7AEM7y2zm4hSoDkDpbme51Wnu683XtZ0MbsxFz0RAlQ2vqPoNcw/OV
         hEptoEm5wpqfcfKzrfC7UQM1AnZMD8MkqhgERZrtzUPFFNTYTwTrBsPPQ/47+gqoAUWD
         zIyiq9On5KhP+Gjsdd3Q5L2sw8Xu3lSHooffepQLO5hGP7AXGh9fgtGoFN7T1/OQhi7O
         BFBTLRWuAcJm5uIDVkZ2Ctzr3bwCIe+Q3/NVT0C/3ZrcO9djOLP2eL6vMkczA5C8/yBj
         LbbxmRUPwRuWvC9lowFiUGjKNWDeoBKOdjGjFuEbn3H4HRMrKP6rddHbLO3eUk2PV3uH
         3knQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtV3cbUaSWRuBIeBnd7Il3aw1CLlVjdBDD680qzcHeAfJHFR0Wk3qiXe45A5u4TncvnG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNBSkANLIO2OMyqCfiVRaJN2Q+BGxXbT0gCzVt4ThTgk8tr7l
	nvJuscbaF2+vJc8dpi+AFuxigMYN8JyV24nyUpT2R+6VivpTEJQ9AHBs
X-Gm-Gg: ASbGnctzbr3zdMSiKBe7l7mCtKpDMRtdX7i+wJR6XCwtJ2Ow22TPjVtTm3AgZpDiyFw
	8ahtM3IsqXPi/maBIotShCu+2HFAWQGpa9DAKpjcYL4bjoSDTTLlGNJ1W32IUyDkHIhp9okyUtp
	4cONGgBKrlmrwi+/bPbw1gcaBsXnL/f7XzmoJGAavrKr6mjm/TCx9bAUNPVIJMw2ErWgBkRoJL8
	rSXS92LaMIJ+GEaHnKPZty4yvRR9MfEuXRbErV8UwGfXyUhJjZmFpDUim0bRyOpf3BG8wQUA1hX
	qIna/YlLuo7zbHODpz1IyREjQ//cp/+Cl03aum8WHxHYzfuQ54PQcNS24BdLZU7NgtrpwQE84a5
	opel6r4SqiwRmgNLPEfytDWVMiUgc
X-Google-Smtp-Source: AGHT+IFPQab+nlAJfa0UVp9Ngd+0kgD9Wh3+TnWn0OgREEtBqC9/JdlJExigkXR/CdjPq01rtXISbA==
X-Received: by 2002:aa7:8881:0:b0:772:5b42:63d1 with SMTP id d2e1a72fcca58-7742de633f5mr7330156b3a.20.1757317391672;
        Mon, 08 Sep 2025 00:43:11 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725e419913sm20968358b3a.55.2025.09.08.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:43:11 -0700 (PDT)
Message-ID: <6bc24eca4d2abdec108f2013c2e414e24d48642f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 00:43:07 -0700
In-Reply-To: <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests that check BPF task work scheduling mechanism.
> Validate that verifier does not accepts incorrect calls to
> bpf_task_work_schedule kfunc.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

The test cases in this patch check functional correctness, but there
is no attempt to do some stress testing of the state machine.
E.g. how hard/feasible would it be to construct a test that attempts
to exercise both branches of the (state =3D=3D BPF_TW_SCHEDULED) in the
bpf_task_work_cancel_and_free()?

>  .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/task_work.c | 108 +++++++++++++
>  .../selftests/bpf/progs/task_work_fail.c      |  98 ++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/to=
ols/testing/selftests/bpf/prog_tests/test_task_work.c
> new file mode 100644
> index 000000000000..9c3c7a46a827
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "task_work.skel.h"
> +#include "task_work_fail.skel.h"
> +#include <linux/bpf.h>
> +#include <linux/perf_event.h>
> +#include <sys/syscall.h>
> +#include <time.h>
> +
> +static int perf_event_open(__u32 type, __u64 config, int pid)
> +{
> +	struct perf_event_attr attr =3D {
> +		.type =3D type,
> +		.config =3D config,
> +		.size =3D sizeof(struct perf_event_attr),
> +		.sample_period =3D 100000,
> +	};
> +
> +	return syscall(__NR_perf_event_open, &attr, pid, -1, -1, 0);
> +}
> +
> +struct elem {
> +	char data[128];
> +	struct bpf_task_work tw;
> +};
> +
> +static int verify_map(struct bpf_map *map, const char *expected_data)
> +{
> +	int err;
> +	struct elem value;
> +	int processed_values =3D 0;
> +	int k, sz;
> +
> +	sz =3D bpf_map__max_entries(map);
> +	for (k =3D 0; k < sz; ++k) {
> +		err =3D bpf_map__lookup_elem(map, &k, sizeof(int), &value, sizeof(stru=
ct elem), 0);
> +		if (err)
> +			continue;
> +		if (!ASSERT_EQ(strcmp(expected_data, value.data), 0, "map data")) {
> +			fprintf(stderr, "expected '%s', found '%s' in %s map", expected_data,
> +				value.data, bpf_map__name(map));
> +			return 2;
> +		}
> +		processed_values++;
> +	}
> +
> +	return processed_values =3D=3D 0;

Nit: check for exact number of expected values here?

> +}
> +
> +static void task_work_run(const char *prog_name, const char *map_name)
> +{
> +	struct task_work *skel;
> +	struct bpf_program *prog;
> +	struct bpf_map *map;
> +	struct bpf_link *link;
> +	int err, pe_fd =3D 0, pid, status, pipefd[2];
> +	char user_string[] =3D "hello world";
> +
> +	if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
> +		return;
> +
> +	pid =3D fork();

Nit: check for negative return value?

> +	if (pid =3D=3D 0) {
> +		__u64 num =3D 1;
> +		int i;
> +		char buf;
> +
> +		close(pipefd[1]);
> +		read(pipefd[0], &buf, sizeof(buf));
> +		close(pipefd[0]);
> +
> +		for (i =3D 0; i < 10000; ++i)
> +			num *=3D time(0) % 7;
> +		(void)num;
> +		exit(0);
> +	}
> +	skel =3D task_work__open();
> +	if (!ASSERT_OK_PTR(skel, "task_work__open"))
> +		return;
> +
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		bpf_program__set_autoload(prog, false);
> +	}
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "prog_name"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +	bpf_program__set_type(prog, BPF_PROG_TYPE_PERF_EVENT);

Nit: this is not really necessary, the programs are already defined as
     SEC("perf_event").

> +	skel->bss->user_ptr =3D (char *)user_string;
> +
> +	err =3D task_work__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;

[...]

