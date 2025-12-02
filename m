Return-Path: <bpf+bounces-75871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA95C9B38C
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581F83A5F23
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224A30146B;
	Tue,  2 Dec 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6v+npYt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64727FD5A
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672688; cv=none; b=Tnq59z2d7WPefml29dkFDmpQ0I5aTl8NL88md6UW3Ch7L/KIy+xjc1J6HN6XLK3gmnjXplyf/p7wOsn+hGD7devZc9/lQVIIKMiQETcJjW6fZTRkfb039HilmoEbf+DF/+ORjF9ulVlTpyeNfD8YZgMttqTR679b2OL9uYRSI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672688; c=relaxed/simple;
	bh=N93bf/KZw0h+VJH4mzQ3LTBQpyL19LRzVwWCH9yZjAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhavSIdPjh0YH/43tpQtoe9ZJvBKqzgTxqcCQCEDPCktelakuQ+dz8cUBXDxoSKPrf/MvzxU3+xWpoQIDNLo+03laRrQ8OvWIQUHSe7ZK/7ladjEtL31g84jaYry1KulNQa1DOLekR6BPm7/635dHZFNkOT/D7pw+N/VmkosIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6v+npYt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso33985725e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 02:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764672684; x=1765277484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=on3Kan0NbvHupUMJLZOKeYAcH+YqhDINUzUWKZMJC6Y=;
        b=D6v+npYtu8tgUo8IF0GU/JqlN7N4i5DXXhmNZTzGAKsHSxzETIR3B30LMAfq3G1UXe
         kA4OmL0Kx7ueMjNBolGgpUn3yNgOFMnYN4vNERJ7uD1ecOHO288oL0neIFWFJI+Rut/d
         8qkDMHMx8pltxgl+L0kRvSqCQPMsfQGKcu7x+Gd6YXUvu6OeMlsd0HsfUwQZ4FvJDmbE
         oothnQEJ26tA0R4d6kxJmdCV6K+/gV1eRyDxSfcrNUSI2GSYnmTkHkhAUZ4GDSZuwwhm
         Pqul/opVAcNR2n9iPyLCB214zXy3Am34BgftrBuZWrSShCplOApn9iLOUKalXrcBDfZL
         b8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672684; x=1765277484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on3Kan0NbvHupUMJLZOKeYAcH+YqhDINUzUWKZMJC6Y=;
        b=ImdytnzF3/2loHRyTckQb95BzY/++dS9PziiO16Z0DfJ3K+3yl7ybPrsgwYaiP4frx
         ucyosyz2niAScbzKON+shpY8swGMUoaTyFr+Dzypg6rY3vR3NjmLnDjCy28wbdoiTESW
         4NTgvJl1NSBEFl2wfTT5dsY2aMcmv6rqsIOYGpUq6b86ltB/wpdy6/xx/nSevrIiYVIv
         yWxlXdlXmc7wq00TyA6GINHRyC/ZvCaNcOXtvjZd/qEfaW4cG+yS6pn4NErQysTV5Tp6
         LJymcvvHViknfanT8UVSvvlDQ1CcNKg0fqh06SHjQ6xz/X1OPsiRdBXJF7UYife5lca0
         2ung==
X-Forwarded-Encrypted: i=1; AJvYcCXmSSVUpsBZAPyMTXB1x5h0BDTy+ZFKcM0NtxlPdiCxsOnLhPUfS+d1KSEG4yrjwlFPZQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3sBpdYVQHuzE4runv/Y4cnZyah6VOxfnjbvVBVgwWbhr94tj
	Up4YyFNQ9Rl5X64zC523PtKhHbjbWkyPmsexKPdsYt6IISt7S7hJmywLUMq3gihhWg==
X-Gm-Gg: ASbGncscXsecIFKxWXKC5gI/8w4YUppzkAV/CW3Rq2XoKZzQnDiB42LSclD12agcpIt
	O3EyeMeMWwDwD7Ef/ciQuVnbzNXX8gL7M8CAkNEMq84/2KNHVb+FbzXQY2CHUbl7lfzEZJ4Yl5o
	CQ5xvYy0FkniDwb7/uxYkQI0vH4zhwW0rXwOHI4UE6gbuzskszHkq3Daf05Ru7l17/kZI8x2U5E
	y9wGIyDF6k/FdjsRHrH3IdCR3qRGAlHMpZ2xTRtkjoeTJ0DKWlNydOyFOWJbR7kcRT4Amhp1wml
	MHuGD+oI2InbEXRcB67ip0NHIhwx7xbDuh53sgFu0OFWnqMe4brEqjDhg0nGTv4YIteLuCKJmv2
	6z1pGsuvSKDOshphgHzxFJRaDsA6bcwK4PyQS6TMbbt6ZX22CLqOplRLfnmV1Zsn9CdRKBeOBNA
	MsvT03yvP7lucU2tgpIUzJ6T5YwsxkuMena0dFDPRSUOEQ/DvN8ZXbipvrBguWRr/AhXg=
X-Google-Smtp-Source: AGHT+IFfI32AxldlfwCLkGNskF/o6XCATWWX6oiTRLGmi8WmK+KLfPtB4E3WKWIeymgEdapC8W5o3Q==
X-Received: by 2002:a05:600c:1f8f:b0:477:a0dd:b2af with SMTP id 5b1f17b1804b1-477c01ea502mr377572095e9.33.1764672683650;
        Tue, 02 Dec 2025 02:51:23 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc6f7bsm375078255e9.2.2025.12.02.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 02:51:23 -0800 (PST)
Date: Tue, 2 Dec 2025 10:51:19 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>, g@google.com
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
Message-ID: <aS7Ep6980hOjICSF@google.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
 <20251202075441.1409-3-electronlsr@gmail.com>
 <aS6qfN4cXoEO82bE@google.com>
 <F1F96C9B-EAD1-4FD7-A053-EE072A5F4E53@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F1F96C9B-EAD1-4FD7-A053-EE072A5F4E53@gmail.com>

On Tue, Dec 02, 2025 at 05:30:15PM +0800, Shuran Liu wrote:
> Hi Matt,
> 
> Thanks a lot for the review and for re-sending your Reviewed-by tag.
> 
> In the next version of the series I’ll add your
> 
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> to the patch that introduces the new selftest, and I’ll also make sure to
> remove /tmp/bpf_d_path_test in the test cleanup path as you suggested.

SGTM.

> I also noticed that the CI is currently failing due to the `#pragma unroll`
> around the loop in prog_lsm(). Would you prefer that I simply drop the pragma
> in the next version, given that the loop bound is small and constant anyway,
> or is there a better way you’d recommend to handle this?

Yeah, I don't think the use of this directive is required here given
the iteration count is tiny. Alternatively, perhaps you could switch
over to using a more BPF verifier preferred alternative
(i.e. bpf_for() or better yet and simpler bpf_repeat())?

> > On Tue, Dec 02, 2025 at 00:59:45AM -0800, Matt Bobrowski wrote：
> > 
> > On Tue, Dec 02, 2025 at 03:54:41PM +0800, Shuran Liu wrote:
> >> Add a regression test for bpf_d_path() when invoked from an LSM program.
> >> The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> >> the binary being executed, and verifies that a simple prefix comparison on
> >> the returned pathname behaves correctly after the fix in patch 1.
> >> 
> >> To avoid nondeterminism, the LSM program now filters based on the
> >> expected PID, which is populated from userspace before the test binary is
> >> executed. This prevents unrelated processes that also trigger the
> >> bprm_check_security LSM hook from overwriting test results. Parent and
> >> child processes are synchronized through a pipe to ensure the PID is set
> >> before the child execs the test binary.
> >> 
> >> Per review feedback, the new test is merged into the existing d_path
> >> selftest rather than adding new prog_tests/ or progs/ files.
> >> 
> >> Co-developed-by: Zesen Liu <ftyg@live.com>
> >> Signed-off-by: Zesen Liu <ftyg@live.com>
> >> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> >> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> >> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> >> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> >> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> > 
> > Feel free to add:
> > 
> > Reviewed-by: Matt Bobrowski <mattbobrowski@google.com <mailto:mattbobrowski@google.com>>
> > 
> >> ---
> >> .../testing/selftests/bpf/prog_tests/d_path.c | 64 +++++++++++++++++++
> >> .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
> >> 2 files changed, 97 insertions(+)
> >> 
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> index ccc768592e66..2909ca3bae0f 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> @@ -195,6 +195,67 @@ static void test_d_path_check_types(void)
> >> 	test_d_path_check_types__destroy(skel);
> >> }
> >> 
> >> +static void test_d_path_lsm(void)
> >> +{
> >> +	struct test_d_path *skel;
> >> +	int err;
> >> +	int pipefd[2];
> >> +	pid_t pid;
> >> +
> >> +	skel = test_d_path__open_and_load();
> >> +	if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> >> +		return;
> >> +
> >> +	err = test_d_path__attach(skel);
> >> +	if (!ASSERT_OK(err, "attach failed"))
> >> +		goto cleanup;
> >> +
> >> +	/* Prepare the test binary */
> >> +	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> > 
> > I'd much prefer if we also cleaned up after ourselves, but it's not
> > that much of an issue I guess.
> > 
> >> +	if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> >> +		goto cleanup;
> >> +
> >> +	pid = fork();
> >> +	if (!ASSERT_GE(pid, 0, "fork failed")) {
> >> +		close(pipefd[0]);
> >> +		close(pipefd[1]);
> >> +		goto cleanup;
> >> +	}
> >> +
> >> +	if (pid == 0) {
> >> +		/* Child */
> >> +		char buf;
> >> +
> >> +		close(pipefd[1]);
> >> +		/* Wait for parent to set PID in BPF map */
> >> +		if (read(pipefd[0], &buf, 1) != 1)
> >> +			exit(1);
> >> +		close(pipefd[0]);
> >> +		execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
> >> +		exit(1);
> >> +	}
> >> +
> >> +	/* Parent */
> >> +	close(pipefd[0]);
> >> +
> >> +	/* Update BPF map with child PID */
> >> +	skel->bss->my_pid = pid;
> >> +
> >> +	/* Signal child to proceed */
> >> +	write(pipefd[1], "G", 1);
> >> +	close(pipefd[1]);
> >> +
> >> +	/* Wait for child */
> >> +	waitpid(pid, NULL, 0);
> >> +
> >> +	ASSERT_EQ(skel->bss->called_lsm, 1, "lsm hook called");
> >> +	ASSERT_EQ(skel->bss->lsm_match, 1, "lsm match");
> >> +
> >> +cleanup:
> >> +	test_d_path__destroy(skel);
> >> +}
> >> +
> >> void test_d_path(void)
> >> {
> >> 	if (test__start_subtest("basic"))
> >> @@ -205,4 +266,7 @@ void test_d_path(void)
> >> 
> >> 	if (test__start_subtest("check_alloc_mem"))
> >> 		test_d_path_check_types();
> >> +
> >> +	if (test__start_subtest("lsm"))
> >> +		test_d_path_lsm();
> >> }
> >> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> >> index 84e1f883f97b..7f65c282069a 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> >> @@ -17,6 +17,8 @@ int rets_close[MAX_FILES] = {};
> >> 
> >> int called_stat = 0;
> >> int called_close = 0;
> >> +int called_lsm = 0;
> >> +int lsm_match = 0;
> >> 
> >> SEC("fentry/security_inode_getattr")
> >> int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> >> @@ -62,4 +64,35 @@ int BPF_PROG(prog_close, struct file *file, void *id)
> >> 	return 0;
> >> }
> >> 
> >> +SEC("lsm/bprm_check_security")
> >> +int BPF_PROG(prog_lsm, struct linux_binprm *bprm)
> >> +{
> >> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> >> +	char path[MAX_PATH_LEN] = {};
> >> +	int ret;
> >> +
> >> +	if (pid != my_pid)
> >> +		return 0;
> >> +
> >> +	called_lsm = 1;
> >> +	ret = bpf_d_path(&bprm->file->f_path, path, MAX_PATH_LEN);
> >> +	if (ret < 0)
> >> +		return 0;
> >> +
> >> +	{
> >> +		static const char target_dir[] = "/tmp/";
> >> +
> >> +#pragma unroll
> >> +		for (int i = 0; i < sizeof(target_dir) - 1; i++) {
> >> +			if (path[i] != target_dir[i]) {
> >> +				lsm_match = -1; /* mismatch */
> >> +				return 0;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	lsm_match = 1; /* prefix match */
> >> +	return 0;
> >> +}
> >> +
> >> char _license[] SEC("license") = "GPL";
> >> -- 
> >> 2.52.0
> 

