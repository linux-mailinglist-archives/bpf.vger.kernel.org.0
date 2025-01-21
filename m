Return-Path: <bpf+bounces-49390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F05A17FBC
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C8C18852B4
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471031F3D36;
	Tue, 21 Jan 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9kw3zJ4"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796071F03F5
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469641; cv=none; b=ramfIf0I89Uu4O12WYKMAws5Hw9I0Wv2TeSOrvfVHD2gleCQ+IRN9MsoGzPOFM3jhhiJNt1EHbafqFCmV6VH/2R/d6zOawv8B1AexgD2faoCg6EVzhAslPN2TVt4cwg5ZUr58bneQJCNfXgRNX4IDO58uVo9DN2UxDxcaCU4D5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469641; c=relaxed/simple;
	bh=dn3eKLROr3sckWluTIlgPfGxby0SuECURtx0BpBCQo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0iyXL6awSNaEII7eSdqQ34vX+Lniewp7V1rrPQAMyrQqmKKvjOgYZrcLwr0JUH8Ms6g+cbQujCEXiqbAFpcaU+I+ymIWEa7BLfJu1SofN9wIfnX51tMX/6z0tp9ckmRiFBkTB8PJGL2ySh6kwcKKOwI6Mej0+RprxwNYXz+uKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9kw3zJ4; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59696465-ee36-444f-9666-6d913d9d280b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737469635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRWG+RNLhMXwVuz9hmrmzLOm+Jnq0s8EeMmJVnJkMYI=;
	b=q9kw3zJ4H3bgsRLPplTYRIuNNdDiRB472ZIjliZpgIUtRCehJAPa793VP7n4+Bq3M0oQh1
	5QIZX0Mwobl9PvbkWF/hs/8Lcek4vn13sKRo6BPfpOhaVCI3Haq6gyH8F7kzEa5ffpRHd1
	QyymQfhbwZvJaXq/OqcN6nWhl/P0Zmo=
Date: Tue, 21 Jan 2025 22:27:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Fix freplace_link segfault in
 tailcalls prog test
To: Tengda Wu <wutengda@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 hffilwlqm@gmail.com
References: <20250121125602.683613-1-wutengda@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20250121125602.683613-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Tengda,

On 2025/1/21 20:56, Tengda Wu wrote:
> There are two bpf_link__destroy(freplace_link) calls in
> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
> is called, if the following bpf_map_{update,delete}_elem() throws an
> exception, it will jump to the "out" label and call bpf_link__destroy()
> again, causing double free and eventually leading to a segfault.
> 

Thank you for pointing this out.

> Fix this issue by moving bpf_link__destroy() out of the "out" label
> and only calling it when freplace_link exists and has not been freed.
> 

I think it would be better to reset freplace_link to NULL immediately
after the first bpf_link__destroy(freplace_link) call. This would help
avoid potential double-free scenarios.

I’ve tested the following diff, which implements this change:

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 544144620ca61..a12fa0521ccc0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
        err = bpf_link__destroy(freplace_link);
        if (!ASSERT_OK(err, "destroy link"))
                goto out;
+       freplace_link = NULL;

        /* OK to update prog_array map then delete element from the map. */

Thanks,
Leon

> Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 544144620ca6..028439dd2c5f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -1624,7 +1624,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>  	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
>  						     prog_fd, "subprog_tc");
>  	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
> -		goto out;
> +		goto out_free_link;
>  
>  	err = bpf_map_delete_elem(map_fd, &key);
>  	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
> @@ -1638,11 +1638,11 @@ static void test_tailcall_bpf2bpf_freplace(void)
>  		goto out;
>  
>  	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
> -	if (!ASSERT_ERR(err, "update jmp_table failure"))
> -		goto out;
> +	ASSERT_ERR(err, "update jmp_table failure");
>  
> -out:
> +out_free_link:
>  	bpf_link__destroy(freplace_link);
> +out:
>  	tailcall_freplace__destroy(freplace_skel);
>  	tc_bpf2bpf__destroy(tc_skel);
>  }


