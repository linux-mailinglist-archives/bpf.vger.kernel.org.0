Return-Path: <bpf+bounces-75828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4704C98C22
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 19:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A34224E1DF3
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7A226861;
	Mon,  1 Dec 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tryEfMX+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD17207DE2
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614920; cv=none; b=rc35Bf/cY49syDNlkJe7s7BHtG0AuYEysWJ7+3pvsEzVECoU1h4jCeK4BNqhAwM7lD3W+6fx5Q8yhJVepXcSmfcWcPLoXe0/MKQE0U/u5S/QV/Y9v9JQ1IrmoFoWiJ3plsFzsZ3CMEM9aOELoTD0hm1rTQvlpdEV2WFC2F/XyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614920; c=relaxed/simple;
	bh=CnfhMURLCP5gRu/Vrz9Z8ry7dgu8WYAjKRHKa+VVXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWI85qoR7Sgo0rtA0JE/stnei2P7no9mNGBSvkBi+WJ6UWVPDZ6329D95HWVtCOKU0SY9R4k7M9CBew25MFt+hsrKK7RTR1X0js81E4OQIVIh2lBQee0gGDTEY+Ijxgl+uFk//NKYWwA/JeErd+BuGj9faUUSEhkmo/7k8+yOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tryEfMX+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso8901076a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764614917; x=1765219717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpfWqQh/CZVZrTLcwqyUSpbKiv1XUQTOI1ALBgTqqvI=;
        b=tryEfMX+Yoa+T/PA9nCQBUwiA7iM1oRpuO/rDhTodFzigw+X4WkVmL8LyJ6yFyCdiu
         1PHjNQwiHibRv8bXHvoHOGN6CA2B2Rp1NbjgwV9lt8EwEcjjMUayF4nJSZG01aLtZjgg
         ZNu6q7GvLAta5ZCeXZfZUGc2T+TlmOCWjTWnRSiqf7AHwJ2JYJlai1srIk+1Hfb2ORd1
         KkrTxDBmPBiaNHvwJ9NYtHIbcYpCCoXJC8JPDJ9gvA10Dhb+I48D2Ey9F+qXq7IL3v3L
         QX8gLL8ZD37aSGMw4ZEK0AToadf5mMz/H6/6Guw4LWq7vFRyodqrTuuwZGy4wWFxqg3r
         oZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764614917; x=1765219717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpfWqQh/CZVZrTLcwqyUSpbKiv1XUQTOI1ALBgTqqvI=;
        b=jDq9H/sENigzvEIdE41+cy14GXOXp8aW8Ok8P5rezkuiYfTLykCbTpuUpgcf6J+qLh
         4hEgYhJkXWhk00ONIAhK0rYHC3ECZwe0HW7yAG+wmGbNGu0KuxJyFgauWCCvzOR2HCBJ
         h/K4yG8NXpb6wf2AKch3SubQAgyAgXVk2ffNhjRf8Kgzk0sS/ldk1sHi/De4cQGtp6h1
         BW5O4zGv9Ch6LI6tC7fIoENo9NIUXwI9zEmR1Z+ej1toRd2Kb1nLKMh2G2lkJ0kFM80V
         p0B3X+MwBezDhGd/kKZP4qLtQxYv/ZP/jgrEaY6WiEyw5edjCazGweV136FFiw0VSiD4
         deHg==
X-Forwarded-Encrypted: i=1; AJvYcCUqvN38eka88UkGWW3uLzbtv3WvAWsHUFNRMxKNfS4Q9TRB8eiAMHMGIV79IFgrmWOPwss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Uu35ZWytpPmO2QnN1JHHJXb4a9zymIl1aqHtixYzq1khy7CI
	tV6PvR2ZpK9kEWA8BDZDLX5Tcsx1X89iIPbFqh8gXA/y5HbRuQ0HjmBFQu2jZtbNBw==
X-Gm-Gg: ASbGncv8tvQ5yU50loKVO6RSkr16l/BCyQAQo1ZY6lIoda97HEQ17bJmrPVlKXs6b+0
	dkwMsxa+PcDNeXXyvcDSwrV2sQc9OrYX8gpScU6qUtZiifypK0SSIWvkVqZ/yWzOGMjI+Bhu0x7
	qdObPOGWtcL61NKFnGWOrYJ69k+koDV1NxMJuSHw9IqN3kp8o+yh27U/wDIywnMXwaIAL0/O6pr
	JyDNMK7CPQkFffatEDxG6ffG29jiu4doVj8wUxDGPRtAHPYtdeycpHYvBltW/migtsBGrnRg+jt
	LtT4cKsrYJHz5PVsIFiI75TBkuGj1dIuS1wXmgZOrQuvyiI6WNO0KuH7eZI/JeMqpDGfrDR55Jl
	poeu3AU59CWMHNdh3mQxuzrHnhBGxkg/ho/jE6q0LZ+ISrGnWMgy+e0VPqx8BoQo2HZ7UlsaltE
	uvhBOz+4mQVS/wLadywPcQAKxv3HgB8lOf6BVTVidBJuZY4iTcBrg7I1aEZis=
X-Google-Smtp-Source: AGHT+IGmXA2mP0MtVnshtm+vBcsRlVLPNa1rL0RYJJvD58tPEKTOZlQjPjIiAfAy0yNT5MrN/ysZGg==
X-Received: by 2002:a05:6402:3246:20b0:640:c640:98c5 with SMTP id 4fb4d7f45d1cf-6455469d112mr31462733a12.34.1764614917515;
        Mon, 01 Dec 2025 10:48:37 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035b75sm14363010a12.20.2025.12.01.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:48:37 -0800 (PST)
Date: Mon, 1 Dec 2025 18:48:33 +0000
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
Subject: Re: [PATCH bpf 1/2] bpf: mark bpf_d_path() buffer as writeable
Message-ID: <aS3jARS7a-gh9UCa@google.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
 <20251201143813.5212-2-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201143813.5212-2-electronlsr@gmail.com>

On Mon, Dec 01, 2025 at 10:38:12PM +0800, Shuran Liu wrote:
> Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking") started distinguishing read vs write accesses performed by
> helpers.
> 
> The second argument of bpf_d_path() is a pointer to a buffer that the
> helper fills with the resulting path. However, its prototype currently
> uses ARG_PTR_TO_MEM without MEM_WRITE.
> 
> Before 37cce22dbd51, helper accesses were conservatively treated as
> potential writes, so this mismatch did not cause issues. Since that
> commit, the verifier may incorrectly assume that the buffer contents
> are unchanged across the helper call and base its optimizations on this
> wrong assumption. This can lead to misbehaviour in BPF programs that
> read back the buffer, such as prefix comparisons on the returned path.
> 
> Fix this by marking the second argument of bpf_d_path() as
> ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
> write to the caller-provided buffer.
>
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..49e0bdaa7a1b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_BTF_ID,
>  	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
> -	.arg2_type	= ARG_PTR_TO_MEM,
> +	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
>  	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
>  	.allowed	= bpf_d_path_allowed,
>  };
> -- 
> 2.52.0
> 

