Return-Path: <bpf+bounces-784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2285706B5E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5314D2812C2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3280533D5;
	Wed, 17 May 2023 14:39:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512E1C26
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63637C433EF;
	Wed, 17 May 2023 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684334356;
	bh=TMM7IlszKJflW8l5pRzVXZO3+eGyQe+4n2y8etas4qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPN+GQNzPcnK13UYVJxP3glr2YotECBDJK7/9w+YWgfKTUndUBjans5CVJ/9grMkL
	 Dpp48fKMI1MNE6Ce26TGf0fgeZnmV/z2wrBl+wevmOQsF/3TI+P/0bR1Jjtsv2a9Mr
	 plk6K4L7zouC5+9GkTuqmbHCCyUD+j8VJIweNYrWMnxm64+JUvF07wgK1tKy4dePk4
	 arzkXMTXeCHgRpWHamUrIkOd/m+xQdjEtWi6B/m1WtNDNKYuxM9tR773Cpq2RJbM1S
	 QoW7t5TJ79M1cRlE4sUL1wh8sUIuyCkUzrozHa0yNhKCF2VaDr/QmwYHf8lIVYejPy
	 UFIGYths2LhAw==
Date: Wed, 17 May 2023 23:39:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, Mark
 Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v11 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-Id: <20230517233912.29d69e26b9a20e9d11e1448e@kernel.org>
In-Reply-To: <ZGTRMsLQ3QqvCGew@debian.me>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
	<168432122914.1351929.944185321099763072.stgit@mhiramat.roam.corp.google.com>
	<ZGTRMsLQ3QqvCGew@debian.me>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 20:05:54 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Wed, May 17, 2023 at 08:00:29PM +0900, Masami Hiramatsu (Google) wrote:
> > +As same as other dynamic events, fprobe events and tracepoint probe
> > +events are defined via `dynamic_events` interface file on tracefs.
> 
> Backquotes are rendered as italics instead. If you mean keyword/identifier,
> inline it with double backquotes (like ``foo``). Or you can skip formatting
> it instead (to be consistent with other keywords).

Oops, thanks for pointing it out!
Let me fix that.

> 
> > +For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
> 
> Did you mean using :doc: directive instead?

Yes, I will fix that.

> 
> ---- >8 ----
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index eca64ad7216a1c..0cf8ed84bd6651 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -64,7 +64,7 @@ Synopsis of fprobe-events
>    (\*4) this is useful for fetching a field of data structures.
>    (\*5) "u" means user-space dereference.
>  
> -For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
> +For the details of TYPE, see :doc:`kprobetrace`.
>  
>  BTF arguments
>  -------------
> 
> On the other hand, you can also directly link to intended doc section:
> 
> ---- >8 ----
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index eca64ad7216a1c..83892c7512726c 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -64,7 +64,7 @@ Synopsis of fprobe-events
>    (\*4) this is useful for fetching a field of data structures.
>    (\*5) "u" means user-space dereference.
>  
> -For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
> +For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.

Good catch! Thanks!

>  
>  BTF arguments
>  -------------
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 651f9ab53f3ee9..8a2dfee3814544 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -66,6 +66,8 @@ Synopsis of kprobe_events
>    (\*3) this is useful for fetching a field of data structures.
>    (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
>  
> +.. _kprobetrace_types:
> +
>  Types
>  -----
>  Several types are supported for fetchargs. Kprobe tracer will access memory
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

