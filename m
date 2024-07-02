Return-Path: <bpf+bounces-33572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2691EBAD
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9974283D1D
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E54817;
	Tue,  2 Jul 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUrkfwUl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886C36C;
	Tue,  2 Jul 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878528; cv=none; b=cwU/UEFtYSKtP+2MC5yMK7DM9CqnSwadrw3blvXu0KQ87QAM3KKP1tAEZpZeI0iJUB8hokmcCAzCyM2MlUsyriGy/ByhztHfxtb0tOScYy8msmYdej9qX66VCeugKVhOFHUYC37BbrTp0XHR09416fffwQ8tPTe2Xvsytz/nenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878528; c=relaxed/simple;
	bh=Midxuz2nY9NJvcn5v3bgVN2AzPPMKajP3rum1jiNEFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U6otFbMrp4aYjb9AFcS9cJNQlMs9ftjbiEO8uZ4YtAf+tNu22MkEKmKDIEKX0Y2O/mYedD/264yJPecIbPVzAnoKqqoCDzXTPhkMMwIjgLdmNE6KCyuz9n3Cv3YJzdqGo74B/QGaqJU7+1OwadCPe9Pn0/0W10TsXSJbFZtZ3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUrkfwUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1CFC116B1;
	Tue,  2 Jul 2024 00:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719878528;
	bh=Midxuz2nY9NJvcn5v3bgVN2AzPPMKajP3rum1jiNEFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uUrkfwUlRSgR+4TG2TqSfX8K/wl6BMNwYXIsILx9EdSjEyHqGZbferwZscXk3sQQC
	 OvgM9GopMas3t5xkXtSmNAHK2HESdk4zEzDS+csLTr+yDi/MiTtad+7d7zceY80kkv
	 5+TMUr6kQYQ8295x9iaDO7JpJqA00WIWj7U1LMkFzD1bDPYAS7YyJMZM8tWd7zrVdZ
	 dAL9Yu0zwEi1GnkboN6mVkepvTWurycB+EH1/tHGPVe2Zf3PaLjqsKCES4YtxO/3il
	 UsNOJlU03eqj8Q/CQYL3u3/DLeWNqcg5tUFNuOzp5grXfY4VStIcPemu9mSQMAcQW4
	 4sQf7VfVsIc7Q==
Date: Tue, 2 Jul 2024 09:02:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>, Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v5 6/8] tracing/bpf-trace: Add support for faultable
 tracepoints
Message-Id: <20240702090202.bc000b44890fe16d9b757b40@kernel.org>
In-Reply-To: <20240626185941.68420-7-mathieu.desnoyers@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
	<20240626185941.68420-7-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 14:59:39 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> @@ -2443,9 +2443,15 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
>  	if (prog->aux->max_tp_access > btp->writable_size)
>  		return -EINVAL;
>  
> -	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
> -						    prog, TRACEPOINT_DEFAULT_PRIO,
> -						    TRACEPOINT_MAY_EXIST);
> +	if (tp->flags & TRACEPOINT_MAY_FAULT) {
> +		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
> +							    prog, TRACEPOINT_DEFAULT_PRIO,
> +							    TRACEPOINT_MAY_EXIST | TRACEPOINT_MAY_FAULT);
> +	} else {
> +		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
> +							    prog, TRACEPOINT_DEFAULT_PRIO,
> +							    TRACEPOINT_MAY_EXIST);
> +	}

nit: you can also just pass the flag directly,

		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
							    prog, TRACEPOINT_DEFAULT_PRIO,
							    TRACEPOINT_MAY_EXIST | (tp->flags & TRACEPOINT_MAY_FAULT));

But others looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

