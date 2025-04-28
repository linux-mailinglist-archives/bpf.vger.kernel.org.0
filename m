Return-Path: <bpf+bounces-56863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA1A9F8AA
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9331A819F0
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA4293476;
	Mon, 28 Apr 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBFt5NT+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB95288B1;
	Mon, 28 Apr 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865287; cv=none; b=LKY9nb9vAh+jn8+6A130d87qkAnX+7cv8Zncp6DVGZUSkPHPSRlKSXibWGfTMdvt5Hds0JZAOHtAKhw0jLfZv/le8xMfTQj0H4nyQfpCd9MogVSrRboNKjJEsQQP8fcJZMSKk+jxrUgIQU4dgJQ/9pFOcR72JVRxFs4UCgI/wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865287; c=relaxed/simple;
	bh=kdC5V1GJVf0AYNDVDpETfg7feyFeCkn1u5NP5gc8Adk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6MCnT1cpm1EgtwDh/xLy6sYlhhiOn+T3hkzM2i00ix40nkUNrjXXXv/whmaY1NghYzKdly5zyFW0LIbeKw8XzFSEt2M0aYX0ZxaxDcqeDQN0wxz9wxB5cU/gr4xbV16J9z0Rc+9e0NQb0ZY/YTQs7yCS2sSbSTGOUclKVOqU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBFt5NT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8AFC4CEE4;
	Mon, 28 Apr 2025 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865286;
	bh=kdC5V1GJVf0AYNDVDpETfg7feyFeCkn1u5NP5gc8Adk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBFt5NT+Xr6LNbnOLRU/DXvOKowZJdVbMDR8bHSIaucTRowUy9MOTiIKO/QkbLJcY
	 VzmRl72a4FnZWlxXbTIz3qaUPQC9vF++rfclh3CAyzJKG6f2q1s1fWyogug9fe/yaX
	 VPgd/aiyeCEDipyz0CJ40OA23IhEESoWXSuRfQ4OUrf/OIcMIqPV72KRPQg9na0uCW
	 XEp85y3vkTFjxWz9G0Jc2noseWWxcbwHVgQHBga4lYtn1t5DEWDmMIzg3EmHp33aqd
	 JHgNtHctCLC1XKRMlKtfg1PPNGsdgJbBdU9PHRz1s7aHVLRFCEV1nfLDvZjqAZn141
	 NyRm6WcVWLS+w==
Date: Mon, 28 Apr 2025 08:34:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [RFC][PATCH 2/2] treewide: Have the task->flags & PF_KTHREAD
 check use the helper functions
Message-ID: <aA_KRQQXt646y37K@slm.duckdns.org>
References: <20250425204120.639530125@goodmis.org>
 <20250425204313.784243618@goodmis.org>
 <202504251558.AA50716@keescook>
 <CAADnVQKdWSuDm52GmNor75rFZGNBLcoCto3oecA3D3QHD_MyCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKdWSuDm52GmNor75rFZGNBLcoCto3oecA3D3QHD_MyCQ@mail.gmail.com>

On Fri, Apr 25, 2025 at 08:22:59PM -0700, Alexei Starovoitov wrote:
> > >  tools/sched_ext/scx_central.bpf.c          |  2 +-
> > >  tools/sched_ext/scx_flatcg.bpf.c           |  2 +-
> > >  tools/sched_ext/scx_qmap.bpf.c             |  2 +-
> >
> > I think these are fine. The Makefile is pulling in standard kbuild
> > Makefiles, so I think the correct include directories (outside of
> > tools/) are being used.
> 
> I suspect they are not fine.
> I don't think they #include linux/sched.h
> I would drop them for now.

Oh, this won't work. Those get all the kernel defs from the BTF generated
vmlinux.h file which doesn't include any inline functions or macros, so
please don't include them in this conversion.

Thanks.

-- 
tejun

