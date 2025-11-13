Return-Path: <bpf+bounces-74353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CEC56116
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9723B42F3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EA325709;
	Thu, 13 Nov 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbp6OgO1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD7328B4D
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019075; cv=none; b=aFDnHxIJ6WWkGrwMK3l1lM+NvSBrWHyWDrNHqfTfzAmd4sOcquKfjchzehXyB3yU8krEKHZpiKWHGQx2+kLqR42o5iebj2g5HJvD6pmnTehgldPgFJg57IzFTChyZETHpX7MKtEQTVT4aCCZvZdreLlQm3WPIEptudYe9Usq3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019075; c=relaxed/simple;
	bh=ePPHRh37LkvGPOCOiIB+AdnoNXv42hyHC+Ui/ZOgDQs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k3No20SwoveCwHA/oK2NYyP+xoUCxRFU5F8dfvYkk6fdaVWqYRCwyOrb0Gt2kUrNqafhr8ol8iHELYjzYHGakD6tYBV0dJeseMvZc9S1HChCH63Asyk3mgOIoqd3UH+3QIaJHuHKgZ///mJwF5qdI8Qoz2NLmIOm6vk+9sI6uWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbp6OgO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEACC4CEFB;
	Thu, 13 Nov 2025 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763019074;
	bh=ePPHRh37LkvGPOCOiIB+AdnoNXv42hyHC+Ui/ZOgDQs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pbp6OgO18jGHmLA7HacSknIa19A2Ksk4CZvsQbCNXD6CLXUROQOGRhWy7pYQrrX36
	 WUmc1s9zKEVWHmBqCMC4ljON7rqKMcerPDqk4WdLURWPxhL9PY7iGYSCz3QWR9pPb+
	 n4NSaxcM32B0wIwQCB8vxxRVsxqXj504VmC5FPPeMXse7nPyVxO7DwcSRjBEReii5o
	 IR8g/rSuPi25NInwUv88e4ApTaAIeXTCkszZSmCj97paSAqFJBSyWF/nk23CYEZeUa
	 7/9sSLtgKEwSk+u9CqAvGJ2Mnt4Hm7aX5NsLtoiy4poR8wFHgFtH7eliYoveayYZ9R
	 GUhsaLrso3nrw==
Content-Type: multipart/mixed; boundary="===============5073049018771138881=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b6a18181c782b914ce9298d9e07d082c6a0240b49c01af16caeed5951f4ecdf@mail.kernel.org>
In-Reply-To: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
References: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal test
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Nov 2025 07:31:14 +0000 (UTC)

--===============5073049018771138881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 1702aa592..61521dc76 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -110,8 +110,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>  	close(pipe_p2c[0]); /* close read */
>
>  	skel = test_send_signal_kern__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
> +		kill(pid, SIGKILL);
>  		goto skel_open_load_failure;
> +	}

The fix addresses the skel_open_and_load failure path, but does this same
issue affect the other early failure paths in test_send_signal_common()?

Looking at the code after this hunk:

	if (!attr) {
		err = test_send_signal_kern__attach(skel);
		if (!ASSERT_OK(err, "skel_attach")) {
			err = -1;
			goto destroy_skel;
		}
	} else {
		[ ... ]
		if (!ASSERT_GE(pmu_fd, 0, "perf_event_open")) {
			err = -1;
			goto destroy_skel;
		}

		skel->links.send_signal_perf =
			bpf_program__attach_perf_event(skel->progs.send_signal_perf, pmu_fd);
		if (!ASSERT_OK_PTR(skel->links.send_signal_perf, "attach_perf_event"))
			goto disable_pmu;
	}

	/* wait until child signal handler installed */
	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");

All three failure paths (attach, perf_event_open, attach_perf_event) occur
before reading from the child at pipe_c2p[0]. They goto labels that
eventually reach skel_open_load_failure without killing the child first.
Won't these paths trigger the same infinite loop bug described in the
commit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19323536860

--===============5073049018771138881==--

