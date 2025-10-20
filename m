Return-Path: <bpf+bounces-71396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2DBF1A7A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7B4F7871
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A83319879;
	Mon, 20 Oct 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO7HZOvZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17041302141
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968017; cv=none; b=tGkSS4+n04qVg4Y8WTsvX3+lP9BE1Uq77XzSkX+Gs2MItV1+wBzL65dHoTa85WFPf9X4QTKlptMRgWdTjDpLondb3Z0DTCstS4/Wa3K4IgbBxVAAsGcQN4nqnV57lWV4I8cynmXcovVM1kZCvhx1/TVlulZ2GLQImEEE445OC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968017; c=relaxed/simple;
	bh=Sq5libX+JM3WPG7zqMDxrV8+aH4+q3XRl1ghvIEgb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl0fqTI5kugqDAs00o7nKao7C1YZp9MGt0mEzR8HQJaZYCh53DbrC63PG/WJkfw77qV/GhqtzaQWry9oHNAZfB/tfX9UD6nl9F0pr7KXlYIHluuApkvcmnfzwkbEc+Pco1xdgZIbw4c9j6YvAABONDGs1DYygSxADxuDYum34p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO7HZOvZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeJ1Du+aCXhUYBm58dq+DSQq/mNgrM7c9de43cjduZY=;
	b=KO7HZOvZx6ZbzlImAObHrrVqZ/keP0b9xbaDqPBK4uoIJVf4US43ECqv6hak/ovp9BiCuf
	CH5+J4DwWWcOnilPZ51sPH6BsVWoLqOvHHQHfVgyPFCEgE7rwDi74lHk4BxnM4pblJI2Nt
	DAswDk8nGK14bezu/zhUlp+26scdqgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ZXCW7zI8O22tIUTB-cdcIQ-1; Mon, 20 Oct 2025 09:46:53 -0400
X-MC-Unique: ZXCW7zI8O22tIUTB-cdcIQ-1
X-Mimecast-MFC-AGG-ID: ZXCW7zI8O22tIUTB-cdcIQ_1760968013
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so5415964f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968012; x=1761572812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeJ1Du+aCXhUYBm58dq+DSQq/mNgrM7c9de43cjduZY=;
        b=AhBK84AXTPaSOl/uC1840bK3hU0JszH/XtY0NNJScWqAoSoA33b6x5MqZ7U//1iLjb
         XU6oTrQXK8IpfhLttzRBseb5iuc4qGutxnu1o3phwAThtzVRJrSxDB3w0tus59qZr6Z+
         reMeFOxYuF6L7s7TMkR3gOlsQ8ub0Ap3Oe6dwHDL1x2Z+x4s/eynt9XJ7OBNik6USeo/
         5IkwyLZqPVd01IkjzQmljhkNvb5FlRJ4R/XBeOfb/S2/BnIOaIYb6/sR2nux3HDjj6e/
         sEmiBN45swgSucz7tF0ByAzbulaI1S3YzP+Tm1K4nZGe6slYLHKp/tYZVexXwmnT0MfC
         yG2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbOUsB115BJEuy84hI2WVtZcGY05LiqkP/xPNaIjK7OgJePUJPOkIJMsgTaMGKKG+PjDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvuBRuiPF0juV11Vh48pYTSy2XVTSkagw3askX/BRImLjpMrM
	6XmQdNuFulCG5jz7w6tNoa7FnaiIWVjl6sAaLzDIJTHyprZ3lLzC3y2vBky/fISPfl1HwQo+6Rt
	NDMNTvz6v2kM2AiL+1o+JU0OYQ0iAIOgSiDYorutCZ3OGJA9RrHe4vxxBiqmfpg==
X-Gm-Gg: ASbGncvugaapWvGH4Bsdg3qEm7F2mDbUGuctNi5oQX1md7aZiw1vM/miSUUMY8UIvLP
	bYehrs2rKbMBhK71zYQvg15plM6BOK1kxLRYlMsLPOTNWRNX4AMTpjygfaSC3lGU9UWySGgc30c
	XTj15ILTCol7Ds7ztLgMCRT8w2wdvnB0HRB4MC6mi5YNC/xDE+HjNbN2y6j9xPYemQl7FZIQl/g
	w+tfOVdVV95WEhfSD/XneWrdLLcPQI7QhwNt3vUrCH5wI27Dl294AdKk3c6eNbGGhZb95NvW3tq
	JmwCnj9y4xXErjVmIKeYWE1/Ds73/HMVqpMFNsYKS59zr80n6IvNPre7fAqTbih5IMp9uyruR+e
	Jf8lzl0dSZpVIKwPDqHhtK9myCWB6dQ==
X-Received: by 2002:a05:6000:4285:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-42704d6c57amr8277572f8f.19.1760968012133;
        Mon, 20 Oct 2025 06:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYsUAywsoBSSavZPjR8dWhxCz2PQ6rM3m8YxB0dm+4iLqXx6iaMKdrToBp9kl1vWXEwcQwuA==
X-Received: by 2002:a05:6000:4285:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-42704d6c57amr8277550f8f.19.1760968011693;
        Mon, 20 Oct 2025 06:46:51 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm146424245e9.11.2025.10.20.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:46:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:46:49 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] sched/deadline: Add support to remove DL server's
 bandwidth contribution
Message-ID: <aPY9STUzTnNwKZ9V@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-9-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> During switching from sched_ext to FAIR tasks and vice-versa, we need
> support for removing the bandwidth contribution of either DL server. Add
> support for the same.
> 
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/sched.h    |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3c1fd2190949e..d585be4014427 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1684,6 +1684,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  		dl_rq_change_utilization(rq, dl_se, new_bw);
>  	}
>  
> +	/* Clear these so that the dl_server is reinitialized */
> +	if (new_bw == 0) {
> +		dl_se->dl_defer = 0;
> +		dl_se->dl_server = 0;
> +	}
> +
>  	dl_se->dl_runtime = runtime;
>  	dl_se->dl_deadline = period;
>  	dl_se->dl_period = period;
> @@ -1697,6 +1703,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	return retval;
>  }
>  
> +/**
> + * dl_server_remove_params - Remove bandwidth reservation for a DL server
> + * @dl_se: The DL server entity to remove bandwidth for
> + *
> + * This function removes the bandwidth reservation for a DL server entity,
> + * cleaning up all bandwidth accounting and server state.
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int dl_server_remove_params(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_se->dl_server)
> +		return 0; /* Already disabled */
> +
> +	/*
> +	 * First dequeue if still queued. It should not be queued since
> +	 * we call this only after the last dl_server_stop().
> +	 */
> +	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
> +		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
> +
> +	/* Remove bandwidth reservation */
> +	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
> +}

I am not sure this is correct wrt inactive_task_timer and
task_non_contending. I fear that removing bw immediately might break
other deadline entities guarantees (especially if one then maliciously
add/removes dl-servers quickly). I kind of think (but again not sure,
please Peter and other keep me honest :) we should be waiting for
inactive_task_timer to fire (if stopping before 0-lag) and let it clean
things up at that point (like we do for simple tasks).

You seem to have additional fixes later on in the series that might be
caused by what I describe above.

Thinking more about this I actually wonder if we need this (well it's
coming up with later patches) mechanism for automatically removing
servers based on fair vs. scx state (full/partial). If we are going to
manage dl-servers bw explicitly and separately [1], maybe we can just
leave the burden to the user (or middleware) of doing that via the
configuration interface?

Thanks,
Juri

1 - https://lore.kernel.org/lkml/aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb/ 


