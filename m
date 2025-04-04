Return-Path: <bpf+bounces-55314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993A1A7B8EF
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622AC17923A
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AC19995D;
	Fri,  4 Apr 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAMIhb2s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889B1C68F;
	Fri,  4 Apr 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755557; cv=none; b=kazphSJZ4j9Ea8/ouh8wT6Xhu9JPVVIM+1Tq8q+9dI7z9+BltOdzn4JS/qFtOsuHApWHQPgrA/++BqQgM2OGTX2H4Ht0KEBdGHbsOE2qGxuw0awpz8BrDzQLZgGvDsBWxDPoaDBCYN7JDcWbbD9c/P94qpdgJ9wqjs3BsDAPFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755557; c=relaxed/simple;
	bh=183ecq1ZaVgl6mrBx2K5c31q6mdBc7FpU9kg20N8aC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXEsliKaxQpR1eyO07NVnixS2xCN9gytDVhTnrfAOdpV6OpF+6TcA9IPV0si9DJpdesl8Mb3dCqknHkZ2BYoWKngExL8oNfV9+v42XVCSMNPQQTkzMy2FviLy7xAEGfJrp3WlGV0BXTuz4IT83TJpPYeeGwTciHeeYl+31ZGCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAMIhb2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01166C4CEDD;
	Fri,  4 Apr 2025 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743755556;
	bh=183ecq1ZaVgl6mrBx2K5c31q6mdBc7FpU9kg20N8aC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAMIhb2s7QuXVxGFvCg8rRUiwJsB1z84oQSX1JFTh9PN7+cmOVkHf9KAeG9FzE3tl
	 IJdn+MgYFIJXliAaIj1OMA4Kp3AK5A7PWjrZa5PDJEWu9fjhB2t5lDRv+YmpHSKjvt
	 nKYcivpKVveLk1P8wwsAk5xQxcF/OrBqMv8OOUuGVy+a1Sl6KG0AZFeEotflwgpag6
	 3c44OTzLgwefG3mXEJHAjgTIosc2+s/sh2D1qq2kqLMsuOt2xa4MGtbaP5TRTwhTyo
	 rEN5R6drs3hLoAs6PmfNGkn2PSoVTSXm3onQXDkvlBO3rkvyE7lax7ZAAVr+7uvyl9
	 IpBd9rXXBVksw==
Date: Fri, 4 Apr 2025 10:32:30 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mhocko@kernel.org, rostedt@goodmis.org,
	oleg@redhat.com, brauner@kernel.org, glider@google.com,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] exit: document sched_process_exit and
 sched_process_template relation
Message-ID: <Z--ZHo2iio71tCAO@gmail.com>
References: <20250403174120.4087794-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403174120.4087794-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> Add an explicit note pointing out that sched_process_exit tracepoint is,
> conceptually, related to sched_process_template and should be kept in
> sync (though, on the best effort basis).
> 
> This is a follow-up to [0], and can hopefully be just folded in when applying.
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20250402180925.90914-1-andrii@kernel.org/
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/trace/events/sched.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 05a14f2b35c3..3bec9fb73a36 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -326,7 +326,11 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
>  	     TP_ARGS(p));
>  
>  /*
> - * Tracepoint for a task exiting:
> + * Tracepoint for a task exiting.
> + * Note, it's a superset of sched_process_template and should be kept
> + * compatible as much as possible. sched_process_exits has an extra
> + * `group_dead` argument, so sched_process_template can't be used,
> + * unfortunately, just like sched_migrate_task above.

Thanks, I've folded this into the tracepoint patch, with this small edit:

 s/sched_process_exits
  /sched_process_exit

	Ingo

