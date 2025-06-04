Return-Path: <bpf+bounces-59635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5578CACDBF0
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E8917724F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A828CF75;
	Wed,  4 Jun 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgEQxibD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4F225A20;
	Wed,  4 Jun 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032739; cv=none; b=CrDaWmnd7lul8Q/SqkoCnMrIKfd9mzzSYLlwbh+wac/a7iI6jSKNMHMfTJ92lhWgUQehXCtvLY+b8SgxIetJfv1uFbPRxin81FbIAEJmohYQ/vPWRD5Cu8CTddzaNk9Tqg5Y1C8lBKq+ar8ofMuICtPyXdh/OeccCflqtCpkU6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032739; c=relaxed/simple;
	bh=xL+N//WjnuF0hOc7kdx62x8VitK0nxlNLXcupQQspzk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq7VxX2PbNJzLSUV3w68iBA5N6H1DyTUQcnwqWqgfNG7Sxohq7eG5Wa5P9zpkQczLJRr7esFepLR0vZ30QwYAt/wcu4OwBPQsKN63/xMtRWK6k9v2KV6AOACJUM7Bhe5XJgIBlJklzm29PVTD4OX0rwJTD5jmGxeDou4Rx+0Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgEQxibD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450d37d4699so33335885e9.0;
        Wed, 04 Jun 2025 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749032736; x=1749637536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yyzqZAFPiecVZ8v3jVi3mxvHGnKj1UzTNsDM6WLqpOU=;
        b=UgEQxibDLapiBdm/1/HNLLsNesRLx6vy5kwALtzTbYFIHi2YnvD25d6wbzEephiEIo
         yC0e7EOzhEuFhyC8modzDTH4/G+of8Pxd99EPd4SA+BSbo/xtIYxzr5Lxi3sb8E0fOoJ
         lnl/WQ6QKhMuLtGPenczeQbk6BnQnnvb51kYuPQ+HWrpYmVBx4rfLlLMDfaZdcZ2qxwX
         ugQ3S0z6pUERMIAFk0nPNeQSRqqN0r3LHkmPybQ24kSRinneRvV/xktk8w1YPdCEzXM4
         t1L/V3V3qorK53JJ/b8yJDxZyWB73ZP57bLmuyC20ad9T8VOQ8z3zAIpxhgWwr7CTrPO
         sDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032736; x=1749637536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyzqZAFPiecVZ8v3jVi3mxvHGnKj1UzTNsDM6WLqpOU=;
        b=BDz3BmoLoK6xPvTry9AcFabRIItehJBHHLNN1qTA85D8/vegtrH6G8Ig26m5VpX/80
         MpniZfDkcj6/RxV4jOKD/YAvel+tIpYL2nD8gIYjZug6UyG9Oq1ZFRBSp/VxTIP2E2R/
         mL80NePLEEmWNffrpJIxwry0oKhnV625QxW6ZIS56mEU181GUJF8LQ5vDg05Q7P08vx1
         8byi5F6nq7VncbBD1/yZdEIvJhBrmCpepSqDDSs/On/L7GC9E17iU1vuJqakx+2gd9zh
         pqNISXp2pMCrrSM+PWQsKbBk/YXhQMMYPAcinHQfb0vUdsWwP8Pvuyw2t1YsDSE/FWmX
         k2gA==
X-Forwarded-Encrypted: i=1; AJvYcCVC7hgsDC4TneJnh79UYKWxjNy/yXQsH3rV6PMlXl8U3qbIK5MgskECycXEL4fDo2usFj0PVvVX+nxoKzXRdz9F2Q==@vger.kernel.org, AJvYcCX5vwG03Hds8c8LJQqC/IB7vh0PdyuXYyX1Qd7dgyC2wU2k+aHKvK2kukoh+lvPIZVCA74=@vger.kernel.org, AJvYcCXttMm+C8a45D5WjLm7yviM23/skBnIMnszms4ujXplbrB3j6/GULhALEX7x0tJv291G7iTMUjsSJpAWEYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RI0/lFSnc5OJECfDzWnDlDwsLfhDQXZsdEYOKT2glJlCWMLO
	1oC7Ebr7ZUJITsrRIQapYa2dAT1akOYstyPYptt+jNowhxKMNBpsOXgtoSZazOQyKzop7w==
X-Gm-Gg: ASbGncs4U5XXWjYJaIMZODpcZ13G9pL3c6jNWu7ruZh3xRVg7eUaBot9kMi8M6foEn3
	GOUjumnsnu1kg+BV4ZqS0v42c6h2WvxF/sx1qqmmUz8ARjcK7FfIsVQnh6cgLgT/fZ98Zzyx4Z2
	4hjUibA1arTXlXJBvBiNuaP/lrPeAV49y5b2yigUFqLA3Ohsm9Ys5BcoqYny+4aVeDGwEo56CTC
	CJkkijIqcBB7/356gKLxM92Kuo0NoCmtuuwN+l1FNsQbdCSjE8zFH8AQj/Pd0Q45OAGUVinyXFx
	yXAok9EBYIeJYJVR5YXEcRedyTVHCx1cppNDG4s=
X-Google-Smtp-Source: AGHT+IFymM6noBC/NQKxn6oL2pO5mt03fzXdx6wOmLhOIQ4wn2u93ARJ20EQbs1qQuX1oAkAWNMMWw==
X-Received: by 2002:a05:600c:609b:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-451f0f247b4mr19281225e9.8.1749032735577;
        Wed, 04 Jun 2025 03:25:35 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b849sm21424103f8f.14.2025.06.04.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:25:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Jun 2025 12:25:33 +0200
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
Message-ID: <aEAfHYLEyc7xGy7E@krava>
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com>
 <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602181743.1c3dabea@gandalf.local.home>

On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> On Fri, 30 May 2025 17:00:38 -0700
> Howard Chu <howardchu95@gmail.com> wrote:
> 
> > Hello Namhyung,
> > 
> > On Fri, May 30, 2025 at 4:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > (Adding tracing folks)  
> > 
> > (That's so convenient wow)
> 
> Shouldn't the BPF folks be more relevant. I don't see any of the tracing
> code involved here.
> 
> > 
> > >
> > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:  
> > > > perf trace utilizes the tracepoint utility, the only filter in perf
> > > > trace is a filter on syscall type. For example, if perf traces only
> > > > openat, then it filters all the other syscalls, such as readlinkat,
> > > > readv, etc.
> > > >
> > > > This filtering is flawed. Consider this case: two perf trace
> > > > instances are running at the same time, trace instance A tracing
> > > > readlinkat, trace instance B tracing openat. When an openat syscall
> > > > enters, it triggers both BPF programs (sys_enter) in both perf trace
> > > > instances, these kernel functions will be executed:
> > > >
> > > > perf_syscall_enter
> > > >   perf_call_bpf_enter
> > > >     trace_call_bpf
> 
> This is in bpf_trace.c (BPF related, not tracing related).
> 
> -- Steve
> 
> 
> > > >       bpf_prog_run_array
> > > >
> > > > In bpf_prog_run_array:
> > > > ~~~
> > > > while ((prog = READ_ONCE(item->prog))) {
> > > >       run_ctx.bpf_cookie = item->bpf_cookie;
> > > >       ret &= run_prog(prog, ctx);
> > > >       item++;
> > > > }
> > > > ~~~
> > > >
> > > > I'm not a BPF expert, but by tinkering I found that if one of the BPF
> > > > programs returns 0, there will be no tracepoint sample. That is,
> > > >
> > > > (Is there a sample?) = ProgRetA & ProgRetB & ProgRetC
> > > >
> > > > Where ProgRetA is the return value of one of the BPF programs in the BPF
> > > > program array.
> > > >
> > > > Go back to the case, when two perf trace instances are tracing two
> > > > different syscalls, again, A is tracing readlinkat, B is tracing openat,
> > > > when an openat syscall enters, it triggers the sys_enter program in
> > > > instance A, call it ProgA, and the sys_enter program in instance B,
> > > > ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
> > > > even though ProgB returns 1; (Is there a sample?) = ProgRetA (0) &
> > > > ProgRetB (1) = 0. So there won't be a tracepoint sample in B's output,
> > > > when there really should be one.  
> > >
> > > Sounds like a bug.  I think it should run bpf programs attached to the
> > > current perf_event only.  Isn't it the case for tracepoint + perf + bpf?  
> > 
> > I really can't answer that question.

bpf programs for tracepoint are executed before the perf event specific
check/trigger in perf_trace_run_bpf_submit

bpf programs array is part of struct trace_event_call so it's global per
tracepoint, not per perf event

IIRC perf trace needs the perf event sample and the bpf program is there
to do the filter and some other related stuff?

if that's the case I wonder we could switch bpf_prog_run_array logic
to be permissive like below, and perhaps make that as tracepoint specific
change, because bpf_prog_run_array is used in other place

or make it somehow configurable.. otherwise I fear that might break existing
use cases.. FWIW bpf ci tests [1] survived the change below

jirka


[1] https://github.com/kernel-patches/bpf/pull/9044

---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..4ca8afe0217c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2218,12 +2218,12 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	const struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
-	u32 ret = 1;
+	u32 ret = 0;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
 
 	if (unlikely(!array))
-		return ret;
+		return 1;
 
 	run_ctx.is_uprobe = false;
 
@@ -2232,7 +2232,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.bpf_cookie = item->bpf_cookie;
-		ret &= run_prog(prog, ctx);
+		ret |= run_prog(prog, ctx);
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);

