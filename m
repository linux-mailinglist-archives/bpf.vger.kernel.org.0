Return-Path: <bpf+bounces-77032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C58CCD6AA
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48B09301692B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D693164BE;
	Thu, 18 Dec 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XKUGxuBM"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4099279DC2
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086726; cv=none; b=Z5ITlPd2Oavt6Nc9TmXfeJjbvLypaomfUtZw8o3weTE0d+YhkhF/jK6LeJ/X3dLw3Kvc407WObURHragYGfLbzAXJjKfJBUhfZmbmu0m4YX6Waq5fKHX1Wo0P/q0tq6EW0Ub+zOCwilDSDGprnpml+BQpS8HMzbMKa9/BptKsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086726; c=relaxed/simple;
	bh=zs9G8vLaSvvjBw072WIivgDUrx5yTUjoojq3hD6AQ9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ul7H+9qcC9uNb7L9niUUPzuHJ7EzkQgzLBYX6+duEOvmFYlJazA1YCdcywAoSwnBXzqjHRIoLrBiIx6pj4swGFpmLNWUxlbjQ+DfdDEErxTaJOiV+igsEV5nqiSJHOmhOL88y77sByu88b9G9Rrsvqz4Ct5CxhuviYh722AjVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XKUGxuBM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7efe93b8-84bf-42b0-b7e1-88a34c6149a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766086717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+aZ66SXcpy+HFDJDeEqsD8XFf6KCe/mjq5DW7G+LyU=;
	b=XKUGxuBM8qtoz7sVNvbfD54l7of5t3cFHZJmAEo++olS+CF8EDqU7nPAqwkKMhejTnoM81
	4KADT5RYhK8ZrrteBR9yGvWw4d7uxifBW4VzOrCde4uTbuxq0wJrMGDZJHWIzbW+fp0V6p
	SvC5yK8HFTmT2dmTiGMgAFgK++WuMKs=
Date: Thu, 18 Dec 2025 11:38:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: allow calling kfuncs from raw_tp programs
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20251218145514.339819-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251218145514.339819-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 6:55 AM, Puranjay Mohan wrote:
> Associate raw tracepoint program type with the kfunc tracing hook. This
> allows calling kfuncs from raw_tp programs.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   kernel/bpf/btf.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..539c9fdea41d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8681,6 +8681,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>   		return BTF_KFUNC_HOOK_STRUCT_OPS;
>   	case BPF_PROG_TYPE_TRACING:
>   	case BPF_PROG_TYPE_TRACEPOINT:
> +	case BPF_PROG_TYPE_RAW_TRACEPOINT:

You need to fix the selftest progs/verifier_kfunc_prog_types.c like below:

diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
index a509cad97e69..1fce7a7e8d03 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -32,7 +32,7 @@ static void task_kfunc_load_test(void)
  }
  
  SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
  int BPF_PROG(task_kfunc_raw_tp)
  {
         task_kfunc_load_test();
@@ -86,7 +86,7 @@ static void cgrp_kfunc_load_test(void)
  }
  
  SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
  int BPF_PROG(cgrp_kfunc_raw_tp)
  {
         cgrp_kfunc_load_test();
@@ -138,7 +138,7 @@ static void cpumask_kfunc_load_test(void)
  }
  
  SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
  int BPF_PROG(cpumask_kfunc_raw_tp)
  {
         cpumask_kfunc_load_test();

>   	case BPF_PROG_TYPE_PERF_EVENT:
>   	case BPF_PROG_TYPE_LSM:
>   		return BTF_KFUNC_HOOK_TRACING;
>
> base-commit: ec439c38013550420aecc15988ae6acb670838c1


