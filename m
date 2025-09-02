Return-Path: <bpf+bounces-67202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD3B40A74
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB81BA268F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CA311C24;
	Tue,  2 Sep 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PYSdiyWj"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C62BE048
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830157; cv=none; b=ElahwQpHH9AbJei1eLyuuNbYjIc76RU6mEJa7fUTlUqtZjVwBk/lB+lcgVUeGiREce0xrdWiXHBice637QfI5XANUWYGuvKf5B9dOJOR3ZZhkIpLfFtWlrsWvOlsITPYUzgMa9S1YOGTRLoHbK+W8dPrYvPbgRtgC0OrUiiwrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830157; c=relaxed/simple;
	bh=Ato1tVA1wUZsQFoG9RuBqtrKpeMqkWrmiSxe4wEuPEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kl96kE56NeeUggM2Xiuc56znr82q+TUH9GMN/jApsZUmqiTOgy02LD1RlLORC0lVeyQmHYmaLy7ZOHbWuTZcbuETO4gx/niPRq6opaKOmGd7Jxujb7jGv13uAMcz3OOGkhOZAL7m7rvPVWNhhkgyw9hhEb6Zc1wRRBVXMFo3eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PYSdiyWj; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edfbf4a2-392d-422e-aab3-288161a80dbd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756830151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEtUZqDjTtvLU9CHbnteENKo+orhvtc3iV5/b7Ki7Rs=;
	b=PYSdiyWjxuv4e4FhP4p/Z+mKJ4Ip8nl9huG6bueTS488FDMOAmOnIccHfmXSgsn40jzD7E
	x2N8fOehEwp9TaVm7llkCXyufmBjDPSTgiGIKPronNI6E10i3S3Ui+0MOKL3KS53aCOY81
	z/NG85vt0CyKr9JFPOUl2tFBFp2UJow=
Date: Tue, 2 Sep 2025 09:22:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add tests for arena fault
 reporting
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250901193730.43543-1-puranjay@kernel.org>
 <20250901193730.43543-5-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250901193730.43543-5-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/1/25 12:37 PM, Puranjay Mohan wrote:
> Add selftests for testing the reporting of arena page faults through BPF
> streams. Two new bpf programs are added that read and write to an
> unmapped arena address and the fault reporting is verified in the
> userspace through streams.
>
> The added bpf programs need to access the user_vm_start in struct
> bpf_arena, this is done by casting &arena to struct bpf_arena *, but
> barrier_var() is used on this ptr before accessing ptr->user_vm_start;
> to stop GCC from issuing an out-of-bound access due to the cast from
> smaller map struct to larger "struct bpf_arena"
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

LGTM with one nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../testing/selftests/bpf/prog_tests/stream.c | 34 ++++++++++-
>   tools/testing/selftests/bpf/progs/stream.c    | 61 +++++++++++++++++++
>   2 files changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> index 9d0e5d93edee7..b2a85364e3c4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -41,6 +41,22 @@ struct {
>   		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>   		"|[ \t]+[^\n]+\n)*",
>   	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_read_fault),
> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_write_fault),
> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},
>   };
>   
>   static int match_regex(const char *pattern, const char *string)
> @@ -63,6 +79,7 @@ void test_stream_errors(void)
>   	struct stream *skel;
>   	int ret, prog_fd;
>   	char buf[1024];
> +	char fault_addr[64] = {0};

Looks like the above '= {0}' is not necessary as the only usage
is below:

+			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
+			ret = match_regex(fault_addr, buf);

>   
>   	skel = stream__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> @@ -85,6 +102,14 @@ void test_stream_errors(void)
>   			continue;
>   		}
>   #endif
> +#if !defined(__x86_64__) && !defined(__aarch64__)
> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> +		if (i == 2 || i == 3) {
> +			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> +			ASSERT_EQ(ret, 0, "stream read");
> +			continue;
> +		}
> +#endif
>   
>   		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
>   		ASSERT_GT(ret, 0, "stream read");
> @@ -92,8 +117,15 @@ void test_stream_errors(void)
>   		buf[ret] = '\0';
>   
>   		ret = match_regex(stream_error_arr[i].errstr, buf);
> -		if (!ASSERT_TRUE(ret == 1, "regex match"))
> +		if (ret && (i == 2 || i == 3)) {
> +			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
> +			ret = match_regex(fault_addr, buf);
> +		}
> +		if (!ASSERT_TRUE(ret == 1, "regex match")) {
>   			fprintf(stderr, "Output from stream:\n%s\n", buf);
> +			if (i == 2 || i == 3)
> +				fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
> +		}
>   	}
>   
>   	stream__destroy(skel);
>
[...]


