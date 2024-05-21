Return-Path: <bpf+bounces-30095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7B8CAB6F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441A71F21907
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB86A8AD;
	Tue, 21 May 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqIL/9E3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56F56475
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285882; cv=none; b=Tt9lK/JLgg5fjUjslNIsV4JWCu6kdJ2fUuT9/LKRGvLirwXWtd1fmh9tJIrPhPsqnJJjZ3TyXmQ5Ev76r16+PMu16h+Nyg1t+jQ+SSp4NeaoNhrHAF7ETcZvEDqyk2WAI5eALiVeah3BXqbo+TiXUlX+PwUFbPDoBr1mXtXqd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285882; c=relaxed/simple;
	bh=mvdhMLjxwVm2Lw8vONSzdqyo0QAyub9hYVppd0JPOdA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkcMSS7mm0GKBP3HxH5e4ZMIGBdwhSRXPrU7HLWBRW4aFoNUI7AVlQal6RQMAI0Cp1hrbYiYUBy5n8BWHf9yNxV4M8hNe9yDRnE4ok4sVqU/2Z6u9vj4IwijkeOkhM2p0AKOFH6C6kk8FuFXmtpd1RIbRqWRGIziLKmqMy8xDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqIL/9E3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59e4136010so874107766b.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716285879; x=1716890679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eU3/SsODIXhLY+ShpzvtQ03ydaX3LndQs6DacnjRhfY=;
        b=eqIL/9E3yisD0A8yDZKs3m+UM5PxF5/Vdo0WLXwfjipjFv23SCC1KWdp1phpsenOBq
         88+qsElYT0yUJ2W37u5/aGZhbTOu1YvU/6f6NXJf//2wnlShT8CGo0czP4a3EXwAfQ+N
         x5OdQBbA8gV+DZsUiuiofhz8HJ/xXLI2gyVmEwlkaqV3/rQJegL0w0JcSD83XhPEYi6/
         7+k+UMKnEuJUgTF8Y9RCLToTjevcVS1OLfATeLT7+o6nDSGCe03asFAsf+2bBvOxDABA
         4tKk7OxnGKWkWsvZGTvwTs16bPcTo8kSkmdrqvVkCA1JrhYKa31axCDB4lzayp9qoy/J
         iqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285879; x=1716890679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU3/SsODIXhLY+ShpzvtQ03ydaX3LndQs6DacnjRhfY=;
        b=vZFeV1jdNgzqP21edqRcu8KZgUy/Wh4wxAoSpyLU1NoAlZHTCo3rVJOk7ROjo8NKnG
         rf/wk9N0HGV+NKtLEpDWefhh7JBf0cUY7CJL4Cq0MZNUvT/WCVM7xxzICngrpQqzfYUv
         ZZDggj1l/RcDi5L/rt1QxkaxUHFhN6YmbXgxzRvw7Yh9+0L0EhgFWxDQrWoxduQICrX5
         M9g8CcYcyeeXjw0Xl69PCgQBPD6/2eIIAlgL7fJqQRUZwctuNyLHUbdZfb/sR3Qg/I7j
         lATmK5uqKdRNDfhwtV/fTzhqNMs5iVKtqWVW/7ALNEUtB8ZKn/UPDi+BNM7ER4GQEtmb
         Ux/A==
X-Gm-Message-State: AOJu0Yz8Bqv/LAmu0NruacWp0S+97KY6hnweI9FnMMgRfW7b+ZB3qQkI
	52aGdFxsXBjWSVnZC1W5R3Vq9VpBRF4Lm+AeGQa2EtJ1gXJyGEtf
X-Google-Smtp-Source: AGHT+IHAu8LautGZMxHhWsYf9SEcp5RSmDRkPv45q5VfeVRyhrMKvNm3/4T9iOdPO2MgnUiyuGYpdA==
X-Received: by 2002:a17:906:2298:b0:a5a:3579:b908 with SMTP id a640c23a62f3a-a5a3579bb63mr1883935166b.38.1716285877810;
        Tue, 21 May 2024 03:04:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c70asm1585584966b.56.2024.05.21.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:04:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 12:04:35 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf 3/5] libbpf: detect broken PID filtering logic for
 multi-uprobe
Message-ID: <Zkxxsx6WQ4H-r6Lt@krava>
References: <20240520234720.1748918-1-andrii@kernel.org>
 <20240520234720.1748918-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520234720.1748918-4-andrii@kernel.org>

On Mon, May 20, 2024 at 04:47:18PM -0700, Andrii Nakryiko wrote:
> Libbpf is automatically (and transparently to user) detecting
> multi-uprobe support in the kernel, and, if supported, uses
> multi-uprobes to improve USDT attachment speed.
> 
> USDTs can be attached system-wide or for the specific process by PID. In
> the latter case, we rely on correct kernel logic of not triggering USDT
> for unrelated processes.
> 
> As such, on older kernels that do support multi-uprobes, but still have
> broken PID filtering logic, we need to fall back to singular uprobes.
> 
> Unfortunately, whether user is using PID filtering or not is known at
> the attachment time, which happens after relevant BPF programs were
> loaded into the kernel. Also unfortunately, we need to make a call
> whether to use multi-uprobes or singular uprobe for SEC("usdt") programs
> during BPF object load time, at which point we have no information about
> possible PID filtering.
> 
> The distinction between single and multi-uprobes is small, but important
> for the kernel. Multi-uprobes get BPF_TRACE_UPROBE_MULTI attach type,
> and kernel internally substitiute different implementation of some of
> BPF helpers (e.g., bpf_get_attach_cookie()) depending on whether uprobe
> is multi or singular. So, multi-uprobes and singular uprobes cannot be
> intermixed.
> 
> All the above implies that we have to make an early and conservative
> call about the use of multi-uprobes. And so this patch modifies libbpf's
> existing feature detector for multi-uprobe support to also check correct
> PID filtering. If PID filtering is not yet fixed, we fall back to
> singular uprobes for USDTs.
> 
> This extension to feature detection is simple thanks to kernel's -EINVAL
> addition for pid < 0.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/features.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index a336786a22a3..cff8640ca66f 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -392,11 +392,40 @@ static int probe_uprobe_multi_link(int token_fd)
>  	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
>  	err = -errno; /* close() can clobber errno */
>  
> +	if (link_fd >= 0 || err != -EBADF) {
> +		close(link_fd);
> +		close(prog_fd);
> +		return 0;
> +	}
> +
> +	/* Initial multi-uprobe support in kernel didn't handle PID filtering
> +	 * correctly (it was doing thread filtering, not process filtering).
> +	 * So now we'll detect if PID filtering logic was fixed, and, if not,
> +	 * we'll pretend multi-uprobes are not supported, if not.
> +	 * Multi-uprobes are used in USDT attachment logic, and we need to be
> +	 * conservative here, because multi-uprobe selection happens early at
> +	 * load time, while the use of PID filtering is known late at
> +	 * attachment time, at which point it's too late to undo multi-uprobe
> +	 * selection.
> +	 *
> +	 * Creating uprobe with pid == -1 for (invalid) '/' binary will fail
> +	 * early with -EINVAL on kernels with fixed PID filtering logic;
> +	 * otherwise -ESRCH would be returned if passed correct binary path
> +	 * (but we'll just get -BADF, of course).
> +	 */
> +	link_opts.uprobe_multi.pid = -1, /* invalid PID */

                                       ^ s/,/;/

so this affects just USDT load/attach, you right?

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> +	link_opts.uprobe_multi.path = "/"; /* invalid path */
> +	link_opts.uprobe_multi.offsets = &offset;
> +	link_opts.uprobe_multi.cnt = 1;
> +
> +	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
> +	err = -errno; /* close() can clobber errno */
> +
>  	if (link_fd >= 0)
>  		close(link_fd);
>  	close(prog_fd);
>  
> -	return link_fd < 0 && err == -EBADF;
> +	return link_fd < 0 && err == -EINVAL;
>  }
>  
>  static int probe_kern_bpf_cookie(int token_fd)
> -- 
> 2.43.0
> 
> 

