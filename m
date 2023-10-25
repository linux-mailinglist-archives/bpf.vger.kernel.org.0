Return-Path: <bpf+bounces-13207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F087A7D60F8
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B18E281C81
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6A2568;
	Wed, 25 Oct 2023 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="apZU3Ukl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CC80F
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:56:42 +0000 (UTC)
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88C99
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:56:40 -0700 (PDT)
Message-ID: <e6c950d7-bb81-4265-bbbe-0201694280b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698209798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnJEc392XDya3Y1sRshgSDBgOSUIPccl2W4W3G0+rok=;
	b=apZU3Ukl3vWu/2XxPIc+ttsRD3jx+VtwnCcj6CdVMgM5yEDaL5QxlSjeoOOGT7fa6UwEhZ
	baF50EiOB6XV8dGk2hGvHBjaW+1UtMyShoOWsvBUSJFfVdSeoDO3amqdS7A256GwQYQrP1
	+pdHi7FrZs16n5AjBYe852KT/jl2XiI=
Date: Tue, 24 Oct 2023 21:56:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix selftests broken by
 mitigations=off
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, gerhorst@cs.fau.de, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 martin.lau@linux.dev, sdf@google.com, song@kernel.org
References: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
 <20231025031144.5508-1-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025031144.5508-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/24/23 8:11 PM, Yafang Shao wrote:
> When we configure the kernel command line with 'mitigations=off' and set
> the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
> bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
> causes issues in the execution of `test_progs -t verifier`. This is because
> 'mitigations=off' bypasses Spectre v1 and Spectre v4 protections.
>
> Currently, when a program requests to run in unprivileged mode
> (kernel.unprivileged_bpf_disabled = 0), the BPF verifier may prevent it
> from running due to the following conditions not being enabled:
>
>    - bypass_spec_v1
>    - bypass_spec_v4
>    - allow_ptr_leaks
>    - allow_uninit_stack
>
> While 'mitigations=off' enables the first two conditions, it does not
> enable the latter two. As a result, some test cases in
> 'test_progs -t verifier' that were expected to fail to run may run
> successfully, while others still fail but with different error messages.
> This makes it challenging to address them comprehensively.
>
> Moreover, in the future, we may introduce more fine-grained control over
> CPU mitigations, such as enabling only bypass_spec_v1 or bypass_spec_v4.
>
> Given the complexity of the situation, rather than fixing each broken test
> case individually, it's preferable to skip them when 'mitigations=off' is
> in effect and introduce specific test cases for the new 'mitigations=off'
> scenario. For instance, we can introduce new BTF declaration tags like
> '__failure__nospec', '__failure_nospecv1' and '__failure_nospecv4'.
>
> In this patch, the approach is to simply skip the broken test cases when
> 'mitigations=off' is enabled. The result of `test_progs -t verifier` as
> follows after this commit,
>
> Before this commit
> ==================
> - without 'mitigations=off'
>    - kernel.unprivileged_bpf_disabled = 2
>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>    - kernel.unprivileged_bpf_disabled = 0
>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED   <<<<
> - with 'mitigations=off'
>    - kernel.unprivileged_bpf_disabled = 2
>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>    - kernel.unprivileged_bpf_disabled = 0
>      Summary: 63/1276 PASSED, 0 SKIPPED, 11 FAILED   <<<< 11 FAILED
>
> After this commit
> =================
> - without 'mitigations=off'
>    - kernel.unprivileged_bpf_disabled = 2
>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>    - kernel.unprivileged_bpf_disabled = 0
>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED    <<<<
> - with this patch, with 'mitigations=off'
>    - kernel.unprivileged_bpf_disabled = 2
>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>    - kernel.unprivileged_bpf_disabled = 0
>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED   <<<< SKIPPED
>
> Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Ack with a nit below.
Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/unpriv_helpers.c | 35 +++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
> index 2a6efbd0401e..7101e72ef4a3 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -4,9 +4,42 @@
>   #include <stdlib.h>
>   #include <error.h>
>   #include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
>   
>   #include "unpriv_helpers.h"
>   
> [...]
>   bool get_unpriv_disabled(void)
>   {
>   	bool disabled;
> @@ -22,5 +55,5 @@ bool get_unpriv_disabled(void)
>   		disabled = true;
>   	}
>   
> -	return disabled;
> +	return disabled ? true : get_mitigations_off();

Above code is correct. But you could slightly simplify it with
	return disabled ? : get_mitigations_off();

I guess maintainer can decide whether simplification is needed
or not.

>   }

