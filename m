Return-Path: <bpf+bounces-57530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38606AAC7F2
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A813BFE7C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF62820CF;
	Tue,  6 May 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxszpRYB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86128137F;
	Tue,  6 May 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541741; cv=none; b=ZyhDbUIZX5Uvh/tyNCvQfhSAtf7IIX+4LEF/vEosDYl/TKyo4G8PPhpxCoLyAyfnADhpimWL949eiPbveOQc32uA87yPbZ/Yh4dwoeQZ3dhhHnD7+carYCK7eA3e34CBavRCWiqjjJ936YcAw8+tqnSjssI2hn8LSdF1uJPvQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541741; c=relaxed/simple;
	bh=IJHHseOgHNs3AOiq3STstPXs9Ok8aHt5Zb+1wzbHFik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5scl4fxOjn6LlkZNXZOzvv1cqzmR8PVXe4kPxMZeNiaX+6ucfJA64/mSp66wkfSWdrosDQSyMnjl/ywRFmpNvqRld/McN6wUQzwdnGEMr4IlVpLYoXfjHsf8xjQA3SmVRMhlnJTkv82CNG6/ujg5HJQ6UbMaK3+CTKSJqRBkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxszpRYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A49C4CEF0;
	Tue,  6 May 2025 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746541740;
	bh=IJHHseOgHNs3AOiq3STstPXs9Ok8aHt5Zb+1wzbHFik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pxszpRYB3PG72pkjYudQA2/la5qxMmluzQi3WA5RGhkYheBR/q1im29V8XgiUsBH9
	 Q/G5Lfk8o5xAR6L58BYrTo/hTSe0PDNCVQxBHKqPUItziDzmFoxJKdmLihqT3vSceh
	 kYme+onDDk9GBFE4geDIweV0JGjilfsV5s6zfbuUqQS1YV7+oO+VxnejiMk9DikVxM
	 G1MFuI7Zpprk04wuq1B/riE+8xHL4KXaRwuod+3jXtzHhCX9qX21Fz6WWmsVmtL0sk
	 V6AJ8DqtisDAh87RjtZsKklcTjBmuxWuCixJLCpFLdEFhCr7gRMlcJEfnhtn0qMBQE
	 fKi9lYe+T/kiw==
Message-ID: <ee3f47dd-dd22-4947-afa5-a99a3de96710@kernel.org>
Date: Tue, 6 May 2025 15:28:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20250506135727.3977467-1-jolsa@kernel.org>
 <20250506135727.3977467-4-jolsa@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250506135727.3977467-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 14:57, Jiri Olsa wrote:
> Adding support to display ref_ctr_offset in link output, like:
> 
>   # bpftool link
>   ...
>   42: perf_event  prog 174
>           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
>           bpf_cookie 3735928559
>           pids test_progs(1820)
> 
>   # bpftool link -j | jq
>   [
>     ...
>     {
>       "id": 42,
>        ...
>       "ref_ctr_offset": 50500538,
>     }
>   ]
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks Jiri!

