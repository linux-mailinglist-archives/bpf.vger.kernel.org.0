Return-Path: <bpf+bounces-49429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFBA18A23
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2077188C59A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1D1487F6;
	Wed, 22 Jan 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJ1lAQ52"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE21249F9
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513808; cv=none; b=Ofy/5oKc4fCchRlKPJjvNr6jZeSEwcJFsns9v2CosK/Woigq32CusML6IE5DPXnOAhr/6H/dV0nH3Sy2g1pq/S9FjrD0fXBHTStZSqM8WIFeBKa3qojGkWDtmW5Zgw/D2HeACBzyOd4muNJlz/Qz2Td1m3tX0ZJ+R0aM7no4mVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513808; c=relaxed/simple;
	bh=l4v/YhjpmMfpHhesuy6BUCaOhu1NAv4+8hskyYlz+DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUQOBBN52e46q13oO7VZAiPVyklrKLKLoLN+1Dw54SlTKgkwZF+TQTc5Ui14x41WZKzNGTFaJoT33Htae4TOI9HOvz9Tt1xFStZbfXeL7q+dnD5JCO+yhCp55flffOa9h1/uLvTO04wNU38We9XwCiFeYUIlBoq33p1X6fWSqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mJ1lAQ52; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f67c30e1-f9c7-4829-a71c-a7372758bd72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737513801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EQ4oHGtN5SPmqaqSWiOHGtT/Dq2Q1IzNdGplQT8NQw=;
	b=mJ1lAQ522+4BarUU0uYHF5v/Sbt1dBH9uSLkLH/nu9q3CabD+Pv65RObWQtG8q+zsXuuf/
	ZPSgoUXHETDK3KBXh3aj5PZ+yQVgEYYpdQYSFgANt+qkNU2C7e0mXfhqccrXci8UkH6/5+
	KkSI4dlNhGzTg4LG0xrhbse0Tp8BSo8=
Date: Wed, 22 Jan 2025 10:43:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix freplace_link segfault in
 tailcalls prog test
Content-Language: en-US
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
References: <20250122022838.1079157-1-wutengda@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20250122022838.1079157-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 22/1/25 10:28, Tengda Wu wrote:
> There are two bpf_link__destroy(freplace_link) calls in
> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
> is called, if the following bpf_map_{update,delete}_elem() throws an
> exception, it will jump to the "out" label and call bpf_link__destroy()
> again, causing double free and eventually leading to a segfault.
> 
> Fix it by directly resetting freplace_link to NULL after the first
> bpf_link__destroy() call.
> 
> Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 544144620ca6..a12fa0521ccc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>  	err = bpf_link__destroy(freplace_link);
>  	if (!ASSERT_OK(err, "destroy link"))
>  		goto out;
> +	freplace_link = NULL;
>  
>  	/* OK to update prog_array map then delete element from the map. */
>  

LGTM.

Reviewed-by: Leon Hwang <leon.hwang@linux.dev>



