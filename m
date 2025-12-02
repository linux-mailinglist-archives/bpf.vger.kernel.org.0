Return-Path: <bpf+bounces-75867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E7C9AC46
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAB4E155A
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97C307ADE;
	Tue,  2 Dec 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IU4vYZqC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEE280327
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665989; cv=none; b=uWBa9d2STJD2+Q1JzdnXCeZxoq3l00M17JT7mEuMdFhPslKpOuYGKbr7QycfrMxGHDNJzkyiMKTyoOHLT/FwsY106Q/LTyLQZAi4A5lNCVzTVp5VuK6qRvAME+LZowjhgJO1mUcHHFKY5vJ1W1eHqOe4Lyyuc2RVWpKG2v2IB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665989; c=relaxed/simple;
	bh=Z7r6OzoH7omO/51pifJA6c+WWkYEvn8kuP2pMjeab24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3nVaS7YxWSLtVK9Jz4PXHCMnC2YFT4+0jiTszfSl8MVndOfgrsFFlyJ8e9YOQ3Rueu1ssDP38GKfUyUu+xhSnCwacZ5K0CSTRAISHEA8Q3ZtBZxjSNDW9sjFRJ/V8egQiAS8+p+aclgjH23VY4RbplFcBCwhYxpD2oc3Ln3VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IU4vYZqC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73875aa527so821219266b.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764665985; x=1765270785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ThzGarJezG2ZHy2Bqj3o69sOGnDn4SAuoVez0Iottc=;
        b=IU4vYZqC4samWZ6Jsbvz/9VhI2uweLqrsXJG5bOB2AQ/MgmFuf7DHya1ZmGP7q3peW
         tpsLBbpPtPpCigF41gTpmqFuuS1OeLXl4Cy9bvnDqzZawr27afXrFQXQ/BkdQFgZJkrt
         lez3MshCAvpAVGSqdI14dKfQcnQYOV4wCiImneUA+RQCevzzOBYSYRhH/4uDUvyAcWtw
         15TDC3zvNvMYe1BZkpZaEbsu6H4Fa8DiD999DZkyKhsazi4Zo8SeQKS2RE70X/UyRWJt
         qmtafI6HYQGh89UUp8THDCLUMCBvsgC5HQTQ7Qwkzo56zAmx8mFioKJk8OdJLq+Jb2Vw
         u2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665985; x=1765270785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ThzGarJezG2ZHy2Bqj3o69sOGnDn4SAuoVez0Iottc=;
        b=LKvUQBkBo4NrmdE938OxVJEZS3sC+Wd8Gs/j1qmX+02UIe/2HE7kYhiWeU3KSNBmgT
         rEg9t09dlhm6pJSe4AE07pDTrsryMmTk0XVApBBvm7BQD52FXEKZg4x1H+lnHM3JeynY
         TO0UbSaM9Y8Sjf1o+Ew3Lo+RHmtiho+R5WcC4QtvE6XpTRKLzSZg2qW39wO2daLvIM48
         4lcohJuIqKcpL729N65y0Pl+vwNx0gOt6LMHTSiP9Wv/41ZhXCm/MhQbR2WGP4TPxl+Y
         aAPsSs1BFmVisKxS64EDP4FwM2dAu8TD2hU2oertIE0Oh1NOTz8TldiEBpm082XMN+Mt
         Yp0g==
X-Forwarded-Encrypted: i=1; AJvYcCXN9AP09PiLqNJWH7ttLONjERYTDz6wNcSriLbCh4IllJvRlx6FlQr8Trj23b5LFAbzZts=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWuzp/MwNPYIXTrLsiPQr+ZV71k/Y6yk7dJeu6SU9cQsVUMAN
	er8VD7f/dh422FZmlWLmBBlYvk579Sx/CtuVJ75mB1AjCfwDk/nGuWa8FlE917IOvg==
X-Gm-Gg: ASbGnctcsyLp3BSfWrpV896ncdHZvSiywSuLav2QDNYPtv8hCV4v90dGG9E1dlQPiVr
	2VmvhPURvceiIisgrNv/h7R371VyAsWK2eYCOZC/hxR9nvTKrYTqqwX1Eqwgm1jS1o5Ft2Ywxnu
	R52/qv87/5npArUGmkPe4dcERvWgSQ+ZkoLavz45kJwnIBbpHips8PV7/4GflgMyMFhMx4oi0ZQ
	CWU/SoEPjCppZ/Ua1FD3hn7xY+CtkaQyT8izngAFfl94kN4QTgXSE7nPygiZCI/GtJBvDWwsCW0
	nDO2433jETKkxKp+BWKx5ID6YSLqLuA5UX+98QB031aGLSCTL0tU3X/r9H/H3abmAKQquuzAJmZ
	SGByNSNa87UVgQW6LvD7zVTzIrr2Hz5bPtma73XN8B8Wl5qbD7OQlKxlBwDr8y7P4JUjZo5CnOI
	bQfrR8efhF7NSG2aNCgZn5NH+w7JIypgEpVFRUYqjPamYC0wVFdR3B1Jtksb98/J0Nyen3ew==
X-Google-Smtp-Source: AGHT+IEd13Gfa95fFiAB+HhgH8HllVe7yQTF/83ZcxpIt+j1YIh7ZhERRPExwQScgq2v+RZ3H+DtXA==
X-Received: by 2002:a17:907:9484:b0:b72:3765:eda9 with SMTP id a640c23a62f3a-b76719ec8f8mr4125012666b.60.1764665984325;
        Tue, 02 Dec 2025 00:59:44 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aecd4sm1489172766b.44.2025.12.02.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:59:43 -0800 (PST)
Date: Tue, 2 Dec 2025 08:59:40 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
Message-ID: <aS6qfN4cXoEO82bE@google.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
 <20251202075441.1409-3-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075441.1409-3-electronlsr@gmail.com>

On Tue, Dec 02, 2025 at 03:54:41PM +0800, Shuran Liu wrote:
> Add a regression test for bpf_d_path() when invoked from an LSM program.
> The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> the binary being executed, and verifies that a simple prefix comparison on
> the returned pathname behaves correctly after the fix in patch 1.
> 
> To avoid nondeterminism, the LSM program now filters based on the
> expected PID, which is populated from userspace before the test binary is
> executed. This prevents unrelated processes that also trigger the
> bprm_check_security LSM hook from overwriting test results. Parent and
> child processes are synchronized through a pipe to ensure the PID is set
> before the child execs the test binary.
> 
> Per review feedback, the new test is merged into the existing d_path
> selftest rather than adding new prog_tests/ or progs/ files.
> 
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>

Feel free to add:

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  .../testing/selftests/bpf/prog_tests/d_path.c | 64 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index ccc768592e66..2909ca3bae0f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -195,6 +195,67 @@ static void test_d_path_check_types(void)
>  	test_d_path_check_types__destroy(skel);
>  }
>  
> +static void test_d_path_lsm(void)
> +{
> +	struct test_d_path *skel;
> +	int err;
> +	int pipefd[2];
> +	pid_t pid;
> +
> +	skel = test_d_path__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> +		return;
> +
> +	err = test_d_path__attach(skel);
> +	if (!ASSERT_OK(err, "attach failed"))
> +		goto cleanup;
> +
> +	/* Prepare the test binary */
> +	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");

I'd much prefer if we also cleaned up after ourselves, but it's not
that much of an issue I guess.

> +	if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> +		goto cleanup;
> +
> +	pid = fork();
> +	if (!ASSERT_GE(pid, 0, "fork failed")) {
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		goto cleanup;
> +	}
> +
> +	if (pid == 0) {
> +		/* Child */
> +		char buf;
> +
> +		close(pipefd[1]);
> +		/* Wait for parent to set PID in BPF map */
> +		if (read(pipefd[0], &buf, 1) != 1)
> +			exit(1);
> +		close(pipefd[0]);
> +		execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
> +		exit(1);
> +	}
> +
> +	/* Parent */
> +	close(pipefd[0]);
> +
> +	/* Update BPF map with child PID */
> +	skel->bss->my_pid = pid;
> +
> +	/* Signal child to proceed */
> +	write(pipefd[1], "G", 1);
> +	close(pipefd[1]);
> +
> +	/* Wait for child */
> +	waitpid(pid, NULL, 0);
> +
> +	ASSERT_EQ(skel->bss->called_lsm, 1, "lsm hook called");
> +	ASSERT_EQ(skel->bss->lsm_match, 1, "lsm match");
> +
> +cleanup:
> +	test_d_path__destroy(skel);
> +}
> +
>  void test_d_path(void)
>  {
>  	if (test__start_subtest("basic"))
> @@ -205,4 +266,7 @@ void test_d_path(void)
>  
>  	if (test__start_subtest("check_alloc_mem"))
>  		test_d_path_check_types();
> +
> +	if (test__start_subtest("lsm"))
> +		test_d_path_lsm();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..7f65c282069a 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -17,6 +17,8 @@ int rets_close[MAX_FILES] = {};
>  
>  int called_stat = 0;
>  int called_close = 0;
> +int called_lsm = 0;
> +int lsm_match = 0;
>  
>  SEC("fentry/security_inode_getattr")
>  int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> @@ -62,4 +64,35 @@ int BPF_PROG(prog_close, struct file *file, void *id)
>  	return 0;
>  }
>  
> +SEC("lsm/bprm_check_security")
> +int BPF_PROG(prog_lsm, struct linux_binprm *bprm)
> +{
> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +	char path[MAX_PATH_LEN] = {};
> +	int ret;
> +
> +	if (pid != my_pid)
> +		return 0;
> +
> +	called_lsm = 1;
> +	ret = bpf_d_path(&bprm->file->f_path, path, MAX_PATH_LEN);
> +	if (ret < 0)
> +		return 0;
> +
> +	{
> +		static const char target_dir[] = "/tmp/";
> +
> +#pragma unroll
> +		for (int i = 0; i < sizeof(target_dir) - 1; i++) {
> +			if (path[i] != target_dir[i]) {
> +				lsm_match = -1; /* mismatch */
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	lsm_match = 1; /* prefix match */
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.52.0
> 

