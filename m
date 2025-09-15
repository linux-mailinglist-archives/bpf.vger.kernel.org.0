Return-Path: <bpf+bounces-68443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DDB5872E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1501739D6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4329E114;
	Mon, 15 Sep 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efW0/HYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EA36D
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974088; cv=none; b=ZZ2ytmT84wkm8towhtdSXXdDIcM4HEHUaI5LddugSiHT04Z5bL3zPwYaed1LkDe+wLQAOzH9CHpG+2vXnMa5w6hDzzhvLxAp7uPMvjqoiksUcUSBLn/Nw/9mKYJkUudY4UzAo53UaslBTpFD4lrAK66evT79Ubx7l2YFldd4kCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974088; c=relaxed/simple;
	bh=w6JeAypw3raE2m5cxv+zakNvxAEpxnVROsaPCbKwd3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1UUhtm4/UAVodN7uX7tyn1Bzqc/58M9ps/tHqnZC1+Ca6+v8Nfs/qbU4pc8DIATclEEXCwk84Iaiuo1GadhCHk00rgxefitwjH1SwB5oBetUMpWbiSsNaYBaqwTwd49VawftkqEZ2ZkVrISlZvA+zlwfJb5y9Gkq9HbUvwkYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efW0/HYg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77619f3f41aso2586581b3a.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974086; x=1758578886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ldvvXU+mvTjqdrozHnGxhGhhat8Yzx7FAdBgSgebLs=;
        b=efW0/HYga7v9gtfTzqOWICnYmlghmuD4JkSPJhrbIMf/7utYn4VPz//TizQK7sXbSE
         zwLYUC/O4/81caw1jPDuXH16RkFCV8EF63D94G/+Jtn9Y1nHbvmxqjrpgirnnsYB9adB
         BYN4hzGHiMnDcUmlR5YgncSJssBXV5aBnxUOzTWuZj+Pi+U1TfznMMBn9xcrplHvdoF6
         XzOqFABjnZALKLNG28HpRMm8+Aihe5m7gEC9n+xD0vqdpw4ImWcwtbLePQbSkFIrcHl/
         GDznxtb7YY/wL9Gn5p5V8805+hSBRFAKn52O+agxB0KBQ0isi2mn+TJA/UPT/gPFbd6i
         ucFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974086; x=1758578886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ldvvXU+mvTjqdrozHnGxhGhhat8Yzx7FAdBgSgebLs=;
        b=qk9/GHuW0XfW13oEBt8yb+u+XChCV0AfiYuHJHMPIU7uDPIvi+szNNd/dSvhx6Mt17
         HzicFb/ru0sgMe/7CIyqIIfpyUVCkcDtvlNM7eAx3bBn4uANIS5m9twkctOPe6D3K24e
         LKavKU/lth8bqwoY7SMl3FbIROs3EuV/pMLbPzmifG8NF+UdeL5yUDUHk5e3gjBVf1bH
         BJFxVzrVTiTHiM42fYdm2wnjVlxkpxdGLuh5Ak9yBxlub57Tnspy1BZW9rR86vBLrRq+
         8aTStMqGGrbuXJomfgk8AMMr3QiAFSsipoiPAb0RVEa2rgzLIcYKPI0D8BqtaQedd5bJ
         WbTA==
X-Forwarded-Encrypted: i=1; AJvYcCWk0/ncH92BPGQM831rJSrOH5LdY38aRd0vyk3Vx0n14Z1Rh/eOq7VZKrsvKEQj4svr774=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFF679jcXxORaLuraeQZ+CWI07AEzlDOafYaBqbitm1VrZCgo
	QNj67QlZ5kviNaqm0Q8VVCfLqEQzFy2fi+H9x//QWYFar0EpFMLRqtqH
X-Gm-Gg: ASbGncsz30KBiKKE1gPVe2Yk/6NWyZEKFH9J9ebqdZPY+s8eY46tbtBVGn8AwyK1QOA
	HXKWZHz4wTTyXFD+aC7f70h8VJL4Zn/ZPdxvgSv/G6OOCWPfp69fnFFggQv1Gm0AHHRsTY3NUCJ
	UIqgf3d0TOG/SBPAh1wn9ohuhP7Oug6r+zf3mupe2JgQoQIporTRFtbDPa7OTN1fzA4hFtN62c8
	dAiGI2R7JEN11Ag26HfZsLOpQROwDxO8vjoRldmc9HCrgDd2D+a5aKnq1zBOUZPgCDnJJxAA/Uf
	m8miS4fl/XoxdfntFqMnnYzeXdaWs+gTDNmNerhutNXy4ugeDjpqRd5LAYNoXq6weBxxSjBFXpF
	r4mrg7AhU+JSVpH1bWt92hFPOkDICfYh9ifyTADuaqo6zqW8W
X-Google-Smtp-Source: AGHT+IGAJ2dRBodhuw9SSSSW0/ULhFLVO2Fsl38gBw+QRiAnE6ysqPd17B7KpQBdSHYci5TvGNE2pA==
X-Received: by 2002:a05:6a00:139d:b0:772:63ba:13b with SMTP id d2e1a72fcca58-7761219c183mr14003938b3a.30.1757974086536;
        Mon, 15 Sep 2025 15:08:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18419sm14285875b3a.67.2025.09.15.15.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:08:06 -0700 (PDT)
Message-ID: <630c851aa1116660b20270dc7115c841d131a222.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: BPF task work scheduling
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 15 Sep 2025 15:08:04 -0700
In-Reply-To: <20250915201820.248977-9-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
	 <20250915201820.248977-9-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests that check BPF task work scheduling mechanism.
> Validate that verifier does not accepts incorrect calls to
> bpf_task_work_schedule kfunc.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Please don't drop acks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/task_work.c | 107 +++++++++++++
>  .../selftests/bpf/progs/task_work_fail.c      |  96 +++++++++++
>  3 files changed, 352 insertions(+)
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

[...]

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
> +	if (pid =3D=3D 0) {

Nit: still no check for negative return value.

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

Nit: still no need to set_type.

> +	skel->bss->user_ptr =3D (char *)user_string;
> +
> +	err =3D task_work__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	pe_fd =3D perf_event_open(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES,=
 pid);
> +	if (pe_fd =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP)=
) {
> +		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> +		test__skip();
> +		goto cleanup;
> +	}
> +	if (!ASSERT_NEQ(pe_fd, -1, "pe_fd")) {
> +		fprintf(stderr, "perf_event_open errno: %d, pid: %d\n", errno, pid);
> +		goto cleanup;
> +	}
> +
> +	link =3D bpf_program__attach_perf_event(prog, pe_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +		goto cleanup;
> +
> +	close(pipefd[0]);
> +	write(pipefd[1], user_string, 1);
> +	close(pipefd[1]);
> +	/* Wait to collect some samples */
> +	waitpid(pid, &status, 0);
> +	pid =3D 0;
> +	map =3D bpf_object__find_map_by_name(skel->obj, map_name);
> +	if (!ASSERT_OK_PTR(map, "find map_name"))
> +		goto cleanup;
> +	if (!ASSERT_OK(verify_map(map, user_string), "verify map"))
> +		goto cleanup;
> +cleanup:
> +	if (pe_fd >=3D 0)
> +		close(pe_fd);
> +	task_work__destroy(skel);
> +	if (pid) {
> +		close(pipefd[0]);
> +		write(pipefd[1], user_string, 1);
> +		close(pipefd[1]);
> +		waitpid(pid, &status, 0);
> +	}
> +}

[...]

