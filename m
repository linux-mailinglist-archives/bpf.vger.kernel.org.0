Return-Path: <bpf+bounces-37032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD61950682
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5F81C22870
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5819AD6E;
	Tue, 13 Aug 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNuTjkaQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323E3B192;
	Tue, 13 Aug 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555820; cv=none; b=Grd+fusnql972HozwtHHeKt1RYoBGe/LQrg95EclV2ilIxcPY5X64t9TuwsVBfJ+Ig6XqLdmPyq9xQnDp/bplZ6O5Odb+7pV2JLStwYhI1vhR9Ru+BT/nIZ6RQbEiKd1zAuQNXZLr/DxYsQ5JnHgutLIDLyw86sizYH5fTVHwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555820; c=relaxed/simple;
	bh=8t7jBeDi3PSD/om6S8np+TEcPRhPpfyzvK6hyTPLYpA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gcd1/qh7qYZ3/obS6l7GznSgFrpkDTkt/CaI1olbySx5/mqHizYLnow9MJmfYA5FV5v1M51U+t+jamve5IFgn39EctGxFXxJ0r2pWLVZ83yFGqih1PwENpW2NVCMKxVCWaCROmZnaJeRkra5hh999aReD5IDVNrI3WyNLQHsUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNuTjkaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892FC4AF09;
	Tue, 13 Aug 2024 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723555819;
	bh=8t7jBeDi3PSD/om6S8np+TEcPRhPpfyzvK6hyTPLYpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iNuTjkaQIMVewLQ82yG1dQL9M+ujzfTGlDkKup73sF5hPc18006h5+gGzpApjXuhn
	 cqQpeyg2g8EkQ6i8gpPxnw5uPe8RJmCGsKT2cI3ilDe+vRjJxzurVpSYT5BHEKnQP1
	 x80RNbOidUluUEbeRIEKBNWmxVSwj2+pWPYscL0zM0rYrS7RNDnxgD1WDMDGEoZ5/3
	 kIO1GSfEjukPUn6VK8fspSwTulSPFjEMIR+Q+xUQntLSeeORfRrlSL1aPcclTsAEVX
	 TW6d3BYMUexahNbB3hGEl9vp93+jQYOsxG2UADQfNi+q32LY3s3m+I8W2zbLX5vS0H
	 WwkJ7mWZeMazg==
Date: Tue, 13 Aug 2024 22:30:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 peterz@infradead.org, oleg@redhat.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU
 one
Message-Id: <20240813223014.1a5093ede1a5046aaedea34a@kernel.org>
In-Reply-To: <20240809192357.4061484-1-andrii@kernel.org>
References: <20240809192357.4061484-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 12:23:57 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> trace_uprobe->nhit counter is not incremented atomically, so its value
> is questionable in when uprobe is hit on multiple CPUs simultaneously.
> 
> Also, doing this shared counter increment across many CPUs causes heavy
> cache line bouncing, limiting uprobe/uretprobe performance scaling with
> number of CPUs.
> 
> Solve both problems by making this a per-CPU counter.
> 

This looks good to me. I would like to pick this to linux-trace/probes/for-next.

> @@ -62,7 +63,7 @@ struct trace_uprobe {
>  	struct uprobe			*uprobe;

BTW, what is this change? I couldn't cleanly apply this to the v6.11-rc3.
Which tree would you working on? (I missed something?)

Thanks,

>  	unsigned long			offset;
>  	unsigned long			ref_ctr_offset;
> -	unsigned long			nhit;
> +	unsigned long __percpu		*nhits;
>  	struct trace_probe		tp;
>  };
>  
> @@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	if (!tu)
>  		return ERR_PTR(-ENOMEM);
>  
> +	tu->nhits = alloc_percpu(unsigned long);
> +	if (!tu->nhits) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
>  	ret = trace_probe_init(&tu->tp, event, group, true, nargs);
>  	if (ret < 0)
>  		goto error;
> @@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	return tu;
>  
>  error:
> +	free_percpu(tu->nhits);
>  	kfree(tu);
>  
>  	return ERR_PTR(ret);
> @@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>  	path_put(&tu->path);
>  	trace_probe_cleanup(&tu->tp);
>  	kfree(tu->filename);
> +	free_percpu(tu->nhits);
>  	kfree(tu);
>  }
>  
> @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  {
>  	struct dyn_event *ev = v;
>  	struct trace_uprobe *tu;
> +	unsigned long nhits;
> +	int cpu;
>  
>  	if (!is_trace_uprobe(ev))
>  		return 0;
>  
>  	tu = to_trace_uprobe(ev);
> +
> +	nhits = 0;
> +	for_each_possible_cpu(cpu) {
> +		nhits += READ_ONCE(*per_cpu_ptr(tu->nhits, cpu));
> +	}
> +
>  	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> -			trace_probe_name(&tu->tp), tu->nhit);
> +		   trace_probe_name(&tu->tp), nhits);
>  	return 0;
>  }
>  
> @@ -1507,7 +1524,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
>  	int ret = 0;
>  
>  	tu = container_of(con, struct trace_uprobe, consumer);
> -	tu->nhit++;
> +
> +	this_cpu_inc(*tu->nhits);
>  
>  	udd.tu = tu;
>  	udd.bp_addr = instruction_pointer(regs);
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

