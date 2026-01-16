Return-Path: <bpf+bounces-79180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9BD2B2E4
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C623020347
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC19342C8F;
	Fri, 16 Jan 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0+4tvrV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD524322B67;
	Fri, 16 Jan 2026 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536544; cv=none; b=RysS/NcccUDqvMNMX8v//t2VQm0tOHtnvGujGx0R1c9fUJa+r6uhIFeKUTWnfC5+3q+UA4rii5/gmBXKTFRazA80wDCEBQZ+xuGVjCYh5spgzcnXrgWQ2RG1+7HDNHUJjsKihgovJIUXHMHvoqSkfeq0fqzemphM/b1qECW3azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536544; c=relaxed/simple;
	bh=hdg6G9+VrL081+UpxMLzF3yK8Gu6xQuXHy2KRKzzfQg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ftlhh0FuQ/eazXm0bxEvQGavv++isgODwUc4wYh3kQ70iYrAHqSQDoE8/+D5TKj6viQ6ebJW3MCfUiSCsFHWSN+LmWuspoViZyyJU2u/R8Wem+3yh5UmhFHsQ5Cu9g8404MF+PHhBWM2cXNC2R/p8GCAD/q3xASghREEn/I2vOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0+4tvrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA60C116C6;
	Fri, 16 Jan 2026 04:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536544;
	bh=hdg6G9+VrL081+UpxMLzF3yK8Gu6xQuXHy2KRKzzfQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G0+4tvrVssphgsDtszPHMEgvzirVin7CKknWaTpMoxThSDxAMUBQM9nnVJTKEIDb7
	 AbEQsbeZSpIUQtAZBg6xVM84i3GwqDmG/DhiAeHv2S6/uAdu1IvvqRYATqlAH+quL7
	 m7RKbvqappQfkpAZqwc9ST/uLhY4WndQHh3GBOsHa0O3BqdirfrZHH/rMPJV1iWx0f
	 BrxYI2ofPoPK7Ye4t0ZNBNOdp5LoJVxvg3BfZtBTDXznTGhYtCRFgTPcOCkUWUWoql
	 yY9z0VdBRe3z6qCqFfW2SE2ANWACQpyOJHiwuVGw+J7Z/EQPsQfPbWkv5jJNXjmy8t
	 RSRqm7lTilrLQ==
Content-Type: multipart/mixed; boundary="===============6839654066856506556=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <379dc407b6e024b766ad40bfb899f8f6ce92e869d23c748275d0c054d62a569a@mail.kernel.org>
In-Reply-To: <20260116035024.98214-3-dongml2@chinatelecom.cn>
References: <20260116035024.98214-3-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mattbobrowski@google.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 16 Jan 2026 04:09:04 +0000 (UTC)

--===============6839654066856506556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> index 64a9c95d4acf..848fab952719 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> @@ -33,6 +33,7 @@ void test_get_func_args_test(void)
>
>  	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
>  	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
> +	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
>
>  	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
>  	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
>  	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
>  	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");

The trigger_module_test_read() call fires the new tracepoints which run the
tp_test1 and tp_test2 BPF programs. These programs set test5_result and
test6_result respectively. However, there are no assertions here to verify
that test5_result and test6_result equal 1.

Should there be:

    ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
    ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");

Without these assertions, the test will pass even if the tp_btf
bpf_get_func_arg() functionality is broken.

> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c

[ ... ]

> +__u64 test5_result = 0;
> +SEC("tp_btf/bpf_testmod_fentry_test1_tp")
> +int BPF_PROG(tp_test1)
> +{

[ ... ]

> +__u64 test6_result = 0;
> +SEC("tp_btf/bpf_testmod_fentry_test2_tp")
> +int BPF_PROG(tp_test2)
> +{

These result variables are set by the BPF programs but never checked in the
test driver, as noted above.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21055137351

--===============6839654066856506556==--

