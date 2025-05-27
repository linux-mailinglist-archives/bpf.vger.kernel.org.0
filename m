Return-Path: <bpf+bounces-58988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1BAC4C25
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 12:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131F07AD1DC
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF4254873;
	Tue, 27 May 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ9jLqsG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F5253F12
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341206; cv=none; b=oDbhUWc4Ns4LK9qeDktKQAhQ8Q332+nIP5et3jtft7Lkh8CiZBZXSc6fiGyU3citMNvJW1RS092u4mrU9BtdknFegn7HQJK0iOZc/ERphNSV6E95yk9o03wUAv/vxVGeXgXgQAaMCdS6E3+PBS9smgWS+ZUbHW2jKCSsBNDrLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341206; c=relaxed/simple;
	bh=dVmLXL7Dxq4oudQTYCKcyVzjG8XDcxvRold3ixPpHT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAr2gnToly8QsjO/1cDH4BWzjVvwZD9R72GUCM72diwpKwOGf0BfXRtY01IjZiWpIvg9xKL/IgezHO0egPagpYW21NnUzMjinB5mc1m2HZ14HI4MSxKaGabN/NkIP0O0Q1eN5Wvc3Xv2F0oQ9u77CpSrkIru5WGJhhcxmqzrqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ9jLqsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43A9C4CEE9;
	Tue, 27 May 2025 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748341206;
	bh=dVmLXL7Dxq4oudQTYCKcyVzjG8XDcxvRold3ixPpHT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HJ9jLqsGVrL97B7h88eBYlZB6+OojDc1tqqJ0h0eNE4u/hA3z/d370wYY2SQ97dRE
	 mnIak3lGYPySBGdM99eErDF61g4Wub55Yx2C0oCvblmq97MeDLG1ciVei9yK+V9jW1
	 LtcrxzZ/OHn1PqtKiw/lK/O7IFYM20Pd7G5SSn9RrdWVj4iZXxVo546hy+7S7ejJh2
	 ycIZ33ZI6p4LBOiRW5TvZZ6E1tzg62zL776nTOANRbrWCb3/BptVrETZ0bZr9KBLtH
	 Ty0qrpVGCyGwb7lXOYB25BK7KmvbJgNF9HQEfb90HlIsJGEy7KDVqkUXcZnRtWYRl0
	 GDH05NkgpDdPw==
Message-ID: <b8246692-6eb8-4079-9113-c1519221e55d@kernel.org>
Date: Tue, 27 May 2025 11:20:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/11] bpftool: Add support for dumping
 streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
References: <20250524011849.681425-1-memxor@gmail.com>
 <20250524011849.681425-11-memxor@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250524011849.681425-11-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-23 18:18 UTC-0700 ~ Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Add support for printing the BPF stream contents of a program in
> bpftool. The new bpftool prog tracelog command is extended to take
> stdout and stderr arguments, and then the prog specification.
> 
> The bpf_prog_stream_read() API added in previous patch is simply reused
> to grab data and then it is dumped to the respective file. The stdout
> data is sent to stdout, and stderr is printed to stderr.
> 
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-prog.rst    |  7 +++
>  tools/bpf/bpftool/bash-completion/bpftool     | 16 +++++-
>  tools/bpf/bpftool/prog.c                      | 50 ++++++++++++++++++-
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f010295350be..3f31fbb8a99c 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1113,6 +1113,53 @@ static int do_detach(int argc, char **argv)
>  	return 0;
>  }
>  
> +enum prog_tracelog_mode {
> +	TRACE_STDOUT,
> +	TRACE_STDERR,
> +};


You could have TRACE_STDOUT = 1 and TRACE_STDERR = 2 in this enum, and
later do "stream_id = mode". This would avoid passing "1" or "2" inside
of the prog_tracelog_stream() function. Although thinking again, it's
maybe confusing to use the same enum for the mode and the stream_id?
Your call.


> +
> +static int
> +prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
> +{
> +	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
> +	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
> +	static char buf[512];


Why static?


> +	int ret;
> +
> +	ret = 0;
> +	do {
> +		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf));
> +		if (ret > 0) {
> +			fwrite(buf, sizeof(buf[0]), ret, file);
> +		}


Nit: No brackets needed around fwrite()

Otherwise looks good, thanks!

Quentin

