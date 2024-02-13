Return-Path: <bpf+bounces-21853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4C8534C4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AABB21330
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBC5EE7A;
	Tue, 13 Feb 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrOE0IC5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AE5EE6E
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838552; cv=none; b=b+M2HSGwv8tIspZtlgd/eDdHRqw1oM6clC1rJnR4WOQSYClL8PRBozeRZ8I3GBmcn0n5vx/Ifra1lD5ChW7elLUu8Er5YRnOTRc3EoXGeK4nXqA9e09GF7Ih4r5FQFk+jjRU6Wim3a5BLM3zCF8FCvwVlu9sF98Mk09k6TMzgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838552; c=relaxed/simple;
	bh=zlAKTo9n4Pph0lCrcJvnKOkq7P9FnL2tuOXkWsWS6DY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CNCi7a4eUoRRV4faEfTpK32eIJ17zCPM+MCm25r6XxeTjZ4ZUHU8u1fYh1v6Rxy69nqTwlTM0eEp14UQskStKHYuJIopLyf26r0QupFWHqH7Mpy+HSvqjTMOLevSaod3FGkZLe2AtgJUXWtF7VAPWshIPPoCKlFrFCvwhezfNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrOE0IC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B8DC433F1;
	Tue, 13 Feb 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838552;
	bh=zlAKTo9n4Pph0lCrcJvnKOkq7P9FnL2tuOXkWsWS6DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrOE0IC5p0ORhszpxs973K3YY3Qz5gj5EkVcutCOAoNYQH2MIUfMfTU89CAsrRJ9S
	 AL+jks8Cv++4YCTEQDtd+VAlxbHE+VZmYOGCumB2LLSPKJ4YrpmWkwQRGQlDJzqXbm
	 AIa5ZZd3Rt74zjTLwzFE3TIhgwCrwgKCCpI2LSxuK1oA+QrIg0aD4TVnda9fMvlAck
	 aqcUEV/2GndMY2z7boE+VJ48VzYoN9gwPhM/lyFBddp86a5D1Cw46KbAeWTfzMz9VA
	 kvC61yGlFi9V+Q+6KwUu++YpShMt/iXM3ySR2T90cNTWrhsmLwl1PvLQdDYFsvnCCy
	 zGPmFLP/ZibEw==
Date: Wed, 14 Feb 2024 00:35:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik
 <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 1/4] fprobe: Add entry/exit callbacks types
Message-Id: <20240214003546.75688cf56b548a86eb090068@kernel.org>
In-Reply-To: <20240207153550.856536-2-jolsa@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
	<20240207153550.856536-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed,  7 Feb 2024 16:35:47 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> We are going to store callbacks in following change,
> so this will ease up the code.
> 

Yeah, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Hmm, can I pick this in my for-next tree?

Thank you,

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/fprobe.h | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 3e03758151f4..f39869588117 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -7,6 +7,16 @@
>  #include <linux/ftrace.h>
>  #include <linux/rethook.h>
>  
> +struct fprobe;
> +
> +typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
> +			       unsigned long ret_ip, struct pt_regs *regs,
> +			       void *entry_data);
> +
> +typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
> +			       unsigned long ret_ip, struct pt_regs *regs,
> +			       void *entry_data);
> +
>  /**
>   * struct fprobe - ftrace based probe.
>   * @ops: The ftrace_ops.
> @@ -34,12 +44,8 @@ struct fprobe {
>  	size_t			entry_data_size;
>  	int			nr_maxactive;
>  
> -	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
> -			     unsigned long ret_ip, struct pt_regs *regs,
> -			     void *entry_data);
> -	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
> -			     unsigned long ret_ip, struct pt_regs *regs,
> -			     void *entry_data);
> +	fprobe_entry_cb entry_handler;
> +	fprobe_exit_cb  exit_handler;
>  };
>  
>  /* This fprobe is soft-disabled. */
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

