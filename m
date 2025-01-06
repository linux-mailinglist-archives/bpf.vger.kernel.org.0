Return-Path: <bpf+bounces-48028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F86A032D4
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53F4164884
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467A1E0DD8;
	Mon,  6 Jan 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZF4ELhh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45887524B0;
	Mon,  6 Jan 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736203332; cv=none; b=CObfgEmWVk2RTgJK0lbURYxxqWCCta/WmAQdFG8nsHGP1uaInYY5jGSI1HBQEcawYXj99RBTxa2dm4DleagNIc8l3ulXKy8+WwvQyXZI7l8pt5puWkMyO7zrLziYHfZOBndIb/eXTyusM28Tr5yxa9mW40WEUyFTSwc4fb9jLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736203332; c=relaxed/simple;
	bh=T58Y1wysAHdymYcFdZzV+21Kmdl0+ykGjRQW2kpOB80=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lksYQZyOmZ/kBo5nKf9TjshRFSkYRFPI6ROPVPCcQFjWOoCWWn04jThjwnE9HCXa7lKmf55lPVq3q1mTaK5Ke4D/00+VeEkq0PNR4WVHTpGLc2QUe0N5gONVAQMyntfk/2yVeMy3mkK5D+xGv60kZbQTpyhrUmH3bMyI5FmXcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZF4ELhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70533C4CEDD;
	Mon,  6 Jan 2025 22:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736203331;
	bh=T58Y1wysAHdymYcFdZzV+21Kmdl0+ykGjRQW2kpOB80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZF4ELhhJ3GiaeQgxVBOCi6nsGFivEBR4S6ATBK1hMnNb17EPgKLBz4grEv/xZn32
	 wuGgvrsEjOQrPYo9RzyfoGY69RSebs/gLMXSOOdx/5UBJOT6KPRzS5CgdQnkKevzqf
	 jLlfimDqOXzDb0EPitv/QCDPRCQd7XoPgp16CQve9G4vOXTkliSEYJ2R+Y2Bv3WOOF
	 SN+mSldEZ11zbSwz6TRWN+bQdLpHGHX5B//hS5ZmCyuZnAe3X1s9mD1cNPzB8U4PAg
	 LzHyctQZfmPOJjJpqYWNAHEgHGG9tHSm0q4A+ICPA74NktR6TCkEyz5WZIxY/765ge
	 6tZ0J+47+06Fg==
Date: Tue, 7 Jan 2025 07:42:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@chromium.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi
 bpf program execution
Message-Id: <20250107074205.cb65bd26e29343c4a2f5084e@kernel.org>
In-Reply-To: <20250106175048.1443905-1-jolsa@kernel.org>
References: <20250106175048.1443905-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 18:50:47 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> When kprobe multi bpf program can't be executed due to recursion check,
> we currently return 0 (success) to fprobe layer where it's ignored for
> standard kprobe multi probes.
> 
> For kprobe session the success return value will make fprobe layer to
> install return probe and try to execute it as well.
> 
> But the return session probe should not get executed, because the entry
> part did not run. FWIW the return probe bpf program most likely won't get
> executed, because its recursion check will likely fail as well, but we
> don't need to run it in the first place.. also we can make this clear
> and obvious.

Yeah, that's right.

> 
> It also affects missed counts for kprobe session program execution, which
> are now doubled (extra count for not executed return probe).
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 48db147c6c7d..1f3d4b72a3f2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2797,7 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
>  		bpf_prog_inc_misses_counter(link->link.prog);
> -		err = 0;
> +		err = 1;
>  		goto out;
>  	}
>  
> -- 
> 2.47.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

