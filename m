Return-Path: <bpf+bounces-50001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E463A21595
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0013A527E
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D710166F29;
	Wed, 29 Jan 2025 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOLNm13u"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78D15534D
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110337; cv=none; b=YqaGi34jC9519SaAM2oZ3L/HRU1hki0Udx09RNsnWlrEPKBOFqCDblyaJm9bJogt7UehAEyTcMeA8fkMnI5ncQmSvwSfBhYFo7fHDAtve9w4rYNiXIJYsQcKfah/aawxGe2cl6QkcWJjK3vlv+1P5fuISnNzQzwc+dvi/U1wQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110337; c=relaxed/simple;
	bh=2F/mqirbYF+fsE1NRh3Xsmdmr+sV4kXa+yk1EwVlPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe6ecM2DYZXBuiD0U93yDaPHtJYFxMH7/RzTYR246AcxpWyZrqTmq9YlC0MeTzCOG00CdGsuJQQjysxiKZlo0vK73jpXj/3z/HCcR5oANgzNODIy8qXWRyFq/EvXRs8WLo3PmIepf4EFcaqSji8y1xIJ6RmwznDTuPH0FVPBtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOLNm13u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 16:25:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738110319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT13IexUZhkAAXhwE/N0PrSufPCrXu/MeHtXnJGqnn8=;
	b=mOLNm13uTp1vCBsoCiMl443USr46+89cRqKasoOx3qvZ6rPiOKrAfMdyUmGK6Odgyd1abE
	lEB1SUSXM8Guk9nu61FSeDbyqg+xDwSH/5kq/N+3XJZmfSh2jB0esZ9W/y+xDxrbE6ubqu
	wBucS28Dl8oGS9oDRufiiSfn4F0AzPY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rppt@kernel.org, liam.howlett@oracle.com, surenb@google.com, 
	kees@kernel.org, jannh@google.com
Subject: Re: [PATCH v2] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <i4i6vowepjshonekrr4flw7u2p42kyhe32t4zkkucmlcg7sjk5@y6pobovsxtol>
References: <20250127222114.1132392-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127222114.1132392-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 27, 2025 at 02:21:14PM -0800, Andrii Nakryiko wrote:
> It's very common for various tracing and profiling toolis to need to
> access /proc/PID/maps contents for stack symbolization needs to learn
> which shared libraries are mapped in memory, at which file offset, etc.
> Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> are looking at data for our own process, which is a trivial case not too
> relevant for profilers use cases).
> 
> Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> discover memory layout of another process: it allows to fully control
> arbitrary other processes. This is problematic from security POV for
> applications that only need read-only /proc/PID/maps (and other similar
> read-only data) access, and in large production settings CAP_SYS_PTRACE
> is frowned upon even for the system-wide profilers.
> 
> On the other hand, it's already possible to access similar kind of
> information (and more) with just CAP_PERFMON capability. E.g., setting
> up PERF_RECORD_MMAP collection through perf_event_open() would give one
> similar information to what /proc/PID/maps provides.
> 
> CAP_PERFMON, together with CAP_BPF, is already a very common combination
> for system-wide profiling and observability application. As such, it's
> reasonable and convenient to be able to access /proc/PID/maps with
> CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> 
> For procfs, these permissions are checked through common mm_access()
> helper, and so we augment that with cap_perfmon() check *only* if
> requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> permitted by CAP_PERFMON. So /proc/PID/mem, which uses
> PTRACE_MODE_ATTACH, won't be permitted by CAP_PERFMON, but
> /proc/PID/maps, /proc/PID/environ, and a bunch of other read-only
> contents will be allowable under CAP_PERFMON.
> 
> Besides procfs itself, mm_access() is used by process_madvise() and
> process_vm_{readv,writev}() syscalls. The former one uses
> PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> seems like a meaningful allowable capability as well.
> 
> process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> but that's outside the scope of this change), and as such won't be
> affected by this patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

