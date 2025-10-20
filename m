Return-Path: <bpf+bounces-71370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E921BF00C7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E83A4B39
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190DE2EC0B9;
	Mon, 20 Oct 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AlB9iHNE"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4C1643B
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950539; cv=none; b=BjioT5450SQf9dxOsshr+W2QXih1yyeM8es7Xgle5sZHK6AVBRPd978bGIaRNXz8STtgeFXvs6lpNTKYFCYeda9oO6OvUBIFaBLW7PAfA5bFMxNo53dm20TXSyEKJQvZVbWNbbWKkmtNC1IT6ju6j5xL8oUljYPMGTc3CXjd9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950539; c=relaxed/simple;
	bh=DYoMtqXAd1bYjN9ifJuuyABxTo2xM9ZgqMGXjS6AdLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrQ/q/oj4kk63nG3vDVLWYKrw/x09oK26c8Bpk42dppJdRkg9SAHnJgmSE6ZlVH3KISN5/B5U0fu1OvmIkkAmtiEazZmOIPQmhjmvrejAZOZxzOz7gqO49GepQiQ8VIHN0WG0JdFkyVgMUojbsrsN3sM4CC0YheiICgHYXCZC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AlB9iHNE; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760950534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlNK4xzyZp6bH52zfvmLf5/eAknw81lWxyjNV/nWbvQ=;
	b=AlB9iHNEuWsJwo5qdj8hjVlzG2TtJrknazorNxtB3iL8DXqfvte/6Q9QxQE1QepvgU6gDe
	ER7ddtUdLldUBN/OicP/pAeLl4IXE9j7cZ16lZgSKlrtMAVgd9JXi//nqC8aCsIK4GuBNR
	z7mv8QWctiIfTRaODpd9nfvTVz2JssI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/5] bpf: tracing session supporting
Date: Mon, 20 Oct 2025 16:55:22 +0800
Message-ID: <3379104.aeNJFYEL58@7950hx>
In-Reply-To: <aPXwbQgGOqAQfxbq@krava>
References:
 <20251018142124.783206-1-dongml2@chinatelecom.cn> <aPXwbQgGOqAQfxbq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/20 16:18, Jiri Olsa wrote:
> On Sat, Oct 18, 2025 at 10:21:19PM +0800, Menglong Dong wrote:
> > Sometimes, we need to hook both the entry and exit of a function with
> > TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> > function, which is not convenient.
> > 
> > Therefore, we add a tracing session support for TRACING. Generally
> > speaking, it's similar to kprobe session, which can hook both the entry
> > and exit of a function with a single BPF program. Meanwhile, it can also
> > control the execution of the fexit with the return value of the fentry.
> > session cookie is not supported yet, and I'm not sure if it's necessary.
> 
> hi,
> I think it'd be useful to have support for cookie, people that use kprobe
> session because of multi attach, could easily migrate to trampolines once
> we have fast multi attach for trampolines

OK, I'll implement it in the next version.

> 
> jirka
> 
> 
> > 
> > For now, only x86_64 is supported. Other architectures will be supported
> > later.
> > 
> > Menglong Dong (5):
> >   bpf: add tracing session support
> >   bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
> >   bpf,x86: add tracing session supporting for x86_64
> >   libbpf: add support for tracing session
> >   selftests/bpf: add testcases for tracing session
> > 
> >  arch/arm64/net/bpf_jit_comp.c                 |   3 +
> >  arch/loongarch/net/bpf_jit.c                  |   3 +
> >  arch/powerpc/net/bpf_jit_comp.c               |   3 +
> >  arch/riscv/net/bpf_jit_comp64.c               |   3 +
> >  arch/s390/net/bpf_jit_comp.c                  |   3 +
> >  arch/x86/net/bpf_jit_comp.c                   | 115 ++++++++++-
> >  include/linux/bpf.h                           |   1 +
> >  include/uapi/linux/bpf.h                      |   1 +
> >  kernel/bpf/btf.c                              |   2 +
> >  kernel/bpf/syscall.c                          |   2 +
> >  kernel/bpf/trampoline.c                       |   5 +-
> >  kernel/bpf/verifier.c                         |  17 +-
> >  kernel/trace/bpf_trace.c                      |  43 ++++-
> >  net/bpf/test_run.c                            |   1 +
> >  net/core/bpf_sk_storage.c                     |   1 +
> >  tools/bpf/bpftool/common.c                    |   1 +
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  tools/lib/bpf/bpf.c                           |   2 +
> >  tools/lib/bpf/libbpf.c                        |   3 +
> >  .../selftests/bpf/prog_tests/fsession_test.c  | 132 +++++++++++++
> >  .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
> >  21 files changed, 511 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> > 
> 
> 





