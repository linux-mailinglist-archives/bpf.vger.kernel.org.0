Return-Path: <bpf+bounces-42887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99489AC809
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB832817C9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0019F421;
	Wed, 23 Oct 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="pRYfAsuw"
X-Original-To: bpf@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81088143C7E;
	Wed, 23 Oct 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679572; cv=none; b=Ev6QK9Ewq6xZK4UdE8vkxL8FgZXKsTquVJEqqlWcXFCGJJq6EtzsnwV4fgP0A72Kw+CpkJNrHae+mXdVkBtZ8X+TfVG/M9dEpp/P3/So9sIIWjpAmfW9hzzRiwyHhp1cRpozp172BYOaEReW4I1IyY0whMiSgUsJjnO634y6Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679572; c=relaxed/simple;
	bh=2GIhElTgkbN2aYVYud17rFsikVxmWhWSFxq1yD8abmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mluKZx88BWaBWV7U3wz68tdgtGcAQ7VGEOn8FHu5qH7IqSsujDIZNex8GVLcpf8LJcWXmWHPchXwBNEX4aj/vseIYx6IM8c1M6Y1X3KXHDdBOon0UyJWRN/KI0DPPQKrEi2WoqCe4nvQjzXCb7D2w04BhvdmzcKpc+8txsTORS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pRYfAsuw; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1729679567; bh=2GIhElTgkbN2aYVYud17rFsikVxmWhWSFxq1yD8abmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRYfAsuwKdvsYJbrMe/NOuC01F2cnuyekTd/7NJku4YE4qLKYDOi/88q95vwI9E0L
	 +hQMn26GcBg04l2lxYXeL32QgsgBTGMGS6VZfQvHdOU7ifYm9hHIxti4sFd3xr+kN6
	 QimSlZsbYryvbmdwSzGs0cTyvFGEqGUnqxqyAJtW5PHtjYjf2ipsQkFA64rYtqqff3
	 8SHka+MheqbOrVQRyDxilSvztZQbSdOMWbeENtzN0VvhybIpNYgy2ssHMWiGEbmhJF
	 QKF7UCjeLRF6ogIuCkvA1j4GJDLoovzWWvRGJ/Wl2smc5ByvWXMJk46tY2pQVHIHBU
	 zeuJFJMRCSwfA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 3E66B1000E1; Wed, 23 Oct 2024 11:32:47 +0100 (BST)
Date: Wed, 23 Oct 2024 11:32:47 +0100
From: Sean Young <sean@mess.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error
 handling
Message-ID: <ZxjQz44-O5zyyJga@gofer.mess.org>
References: <20241023100131.3400274-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023100131.3400274-1-jolsa@kernel.org>

On Wed, Oct 23, 2024 at 12:01:31PM +0200, Jiri Olsa wrote:
> Peter reported that perf_event_detach_bpf_prog might skip to release
> the bpf program for -ENOENT error from bpf_prog_array_copy.
> 
> This can't happen because bpf program is stored in perf event and is
> detached and released only when perf event is freed.
> 
> Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> make sure the bpf program is released in any case.

Looks good. Should be unreachable anyway, so it doesn't matter. My
preference would be to just delete the lines, but no harm in belt and braces.

Acked-by: Sean Young <sean@mess.org>
> 
> Cc: Sean Young <sean@mess.org>
> Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
> Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 95b6b3b16bac..2c064ba7b0bd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  
>  	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
>  	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> -	if (ret == -ENOENT)
> -		goto unlock;
> +	if (WARN_ON_ONCE(ret == -ENOENT))
> +		goto put;
>  	if (ret < 0) {
>  		bpf_prog_array_delete_safe(old_array, event->prog);
>  	} else {
> @@ -2225,6 +2225,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  		bpf_prog_array_free_sleepable(old_array);
>  	}
>  
> +put:
>  	bpf_prog_put(event->prog);
>  	event->prog = NULL;
>  
> -- 
> 2.46.2

