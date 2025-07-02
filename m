Return-Path: <bpf+bounces-62106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0DAAF1454
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731364E76D5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE1025A2A2;
	Wed,  2 Jul 2025 11:45:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFC229B13;
	Wed,  2 Jul 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456700; cv=none; b=l2cMlviCfk4nZsjPX18J7B5x7UDh2jJt6VafYKwtvtyS/5tpuqAjMdW3Rvcxlu4WGKt/ZUbV25S/btC/Z3Odd41bbONoypPzK/xy1hOtRAJvCiewMG4cM2c43KEsXBtck7jOw0GG1BGK2f32aMCiiYQiJkg86u0q7fLCcpW3hRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456700; c=relaxed/simple;
	bh=8GKq3PK2RAXJflRfO6z7N1Qh8M5GuPT3A2ZYflG78hM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UQM3GkzthEoD8dzGapx9fLhIO2Tf3VYqr8TvQeyk9qt9Vs1RFUJ/XHcDF1cQ13qDCRMaff2wdr2tuRMuM6VfzrDIAm6DUhLclGR61GCxsXJVAcil61CXCtAUCTv5lR7UssPfcN6zUtSfLnMP6xY2B6itFg2brHziA82wzw/MbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 92323341ED4;
	Wed, 02 Jul 2025 11:44:54 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: fweimer@redhat.com
Cc: akpm@linux-foundation.org,andrii@kernel.org,axboe@kernel.dk,beaub@linux.microsoft.com,bpf@vger.kernel.org,indu.bhagat@oracle.com,jemarch@gnu.org,jolsa@kernel.org,jpoimboe@kernel.org,jremus@linux.ibm.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,mingo@kernel.org,namhyung@kernel.org,peterz@infradead.org,rostedt@goodmis.org,tglx@linutronix.de,torvalds@linux-foundation.org,x86@kernel.org
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
In-Reply-To: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
Organization: Gentoo
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Wed, 02 Jul 2025 12:44:51 +0100
Message-ID: <87wm8qlsuk.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I started to play around with this properly last night and it was
straightforward, fortunately.

Did initially attempt to backport to 6.15 but it was a victim of some
mm refactoring and didn't seem worth to carry on w/ that route.

Started a rough page with notes for myself (but corrections & such
welcome) at https://wiki.gentoo.org/wiki/Project:Toolchain/SFrame but
honestly, it's immediately obvious (and beautiful) when it's working
correctly. I've used Namhyung Kim's example from this thread but you can
see it easily with `perf top -g` too.

In one of the commit messages in the perf series, Steven also gave `perf
record -g -vv true` which was convenient for making sure it's correctly
discovered deferred unwinding support.

I plan on doing measurements next and doing some more playing once I've
built more userland with it.

