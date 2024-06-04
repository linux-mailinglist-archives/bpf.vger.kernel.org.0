Return-Path: <bpf+bounces-31364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88958FBB13
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C3D1C2040B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFD14A09B;
	Tue,  4 Jun 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A53rhYnq"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE384A33
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523942; cv=none; b=H43mNpJoo9B+QXbnbNnoeKH+JdMvjG9m2+eISVRleOUCL7OayI7f2Ni7KXZ+ID9jV69vJRD9b/HC5OZFvpaz1waoydxooqw1yzXcgX0KLzbMSKmvwBAdvakessX1YWIfqeyZ5n6W4Jp+LKhsciDSiVSYx36/Q6fJJu0jqEynQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523942; c=relaxed/simple;
	bh=SAoLNdBkHxfRf0lcXIvBdfTZ86UKVZLCIkMHLMJ9Nh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sr5a0JXm5JItKcODdzchghf65OWslcZF0QmCP5vRSkX5h6t6PYUWeLnVTmMcw5a3fIjSxQwggFGo5z4WtlWRqEmNaLI2ZQM9QYmQFLhLFzqjnFPCKZJJERPh/sukvw3izkz9GiD4uH8vR3v0kXE4IPq2l13bvhRo2z+enDUi9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A53rhYnq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717523938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iysOHjwrMgTrLNtPUXknmmPipuNOcqqVRYskfOd5IBA=;
	b=A53rhYnqt+Qtf9+g8lytwtMX+rJuA3N50UJzAMRZtseDzvBxlo63c4d0tH0kD8eaFm4UUA
	J2t1P3JX33vPKD3agn38pmWnBvR8KfHWThHuqazOomM+e6F+ml3HuO3tMRyskiXG4vgK5J
	EdbCEZFJBA9Q0x2gtFqYr+QmznfD1M0=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <5cd1549d-1728-4ed4-a35a-3cc80a993c9c@linux.dev>
Date: Tue, 4 Jun 2024 10:58:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Ignore .llvm.<hash> suffix in
 kallsyms_find()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240604175546.1339303-1-yonghong.song@linux.dev>
Content-Language: en-GB
In-Reply-To: <20240604175546.1339303-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Sorry, messed up the git submit with two unrelated patches. Please ignore this.
Will submit the correct one soon.

On 6/4/24 10:55 AM, Yonghong Song wrote:
> I hit the following failure when running selftests with
> internal backported upstream kernel:
>    test_ksyms:PASS:kallsyms_fopen 0 nsec
>    test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>    #123     ksyms:FAIL
>
> In /proc/kallsyms, we have
>    $ cat /proc/kallsyms | grep bpf_link_fops
>    ffffffff829f0cb0 d bpf_link_fops.llvm.12608678492448798416
> The CONFIG_LTO_CLANG_THIN is enabled in the kernel which is responsible
> for bpf_link_fops.llvm.12608678492448798416 symbol name.
>
> In prog_tests/ksyms.c we have
>    kallsyms_find("bpf_link_fops", &link_fops_addr)
> and kallsyms_find() compares "bpf_link_fops" with symbols
> in /proc/kallsyms in order to find the entry. With
> bpf_link_fops.llvm.<hash> in /proc/kallsyms, the kallsyms_find()
> failed.
>
> To fix the issue, in kallsyms_find(), if a symbol has suffix
> .llvm.<hash>, that suffix will be ignored for comparison.
> This fixed the test failure.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/trace_helpers.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 70e29f316fe7..dc871e642ed5 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -221,6 +221,18 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
>   		return -EINVAL;
>   
>   	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name) > 0) {
> +		/* If CONFIG_LTO_CLANG_THIN is enabled, static variable/function
> +		 * symbols could be promoted to global due to cross-file inlining.
> +		 * For such cases, clang compiler will add .llvm.<hash> suffix
> +		 * to those symbols to avoid potential naming conflict.
> +		 * Let us ignore .llvm.<hash> suffix during symbol comparison.
> +		 */
> +		if (type == 'd') {
> +			char *res = strstr(name, ".llvm.");
> +
> +			if (res)
> +				*res = '\0';
> +		}
>   		if (strcmp(name, sym) == 0) {
>   			*addr = value;
>   			goto out;

