Return-Path: <bpf+bounces-62160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD0AF5F8B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEFA1C40F4B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2E301123;
	Wed,  2 Jul 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3stI/pz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F552FF47B;
	Wed,  2 Jul 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476229; cv=none; b=GgDBDEiTmpz7/yrkb69WCyizIBdZxGYtffHrZbVoMfDnVz47YbfNwHBgYAXs53NUHuPyFFgSbMXGOki3Ytqij2WiQDBnhaiN3SNocNMkeHH1QC6a/yTRgGOioerwubioMjwX83Xm5rZGg9XfFYOhsZil/2hTSyww969H08ZaP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476229; c=relaxed/simple;
	bh=+kwbqJ0NQ6+/Ia1UxvkxCi/+QKYvGzcps3yND1R8ih8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUmBpNiWoaSF5kOPoiV4kwr+3hBkwITZXHowX/Bbpf3AfQSI1j5X2h/XAdz7EnM04UlXyACXu7Gzkhfa0ViDKkfJCTR92xxnPuSrTEivpDzaXAbNgmrM80nTfnIOxUWxKEbYjYvwz/cUNJ87+imaP4WxM6VKvTmkpoPUCogGaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3stI/pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D0BC4CEE7;
	Wed,  2 Jul 2025 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751476229;
	bh=+kwbqJ0NQ6+/Ia1UxvkxCi/+QKYvGzcps3yND1R8ih8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3stI/pzfWwQFAil0f1V55CQJXgC8m7OG1upghb9IwksQeG0e4wu6KcPSgaF4L3JO
	 spXlloArOmnq7DM/UYhlGCKtwVqWTRAFygjbZwPt5iZVZMuVOgoBpSjiEdTZC0rfbe
	 1FIGyekhJgdNlhlN8JSm9Xk93hFPv7fJKZbaiei+tzSUibZ+IXgf5Q3gNfqJxyl5VN
	 HFAg8+xAinGTxbs6jRKnuJ+3fjRZaYXbJIbwUCYBBO8UflhhZIWxIK4h/dnS3SrtIp
	 meIsrxR3mT1IQ5zS+soZy/RHGuDoUztFRG2tFpC/jtNrwm2JFNGE2T0lycsnZJ+nbu
	 o3xP2WhNks51Q==
Date: Wed, 2 Jul 2025 10:10:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: fweimer@redhat.com, akpm@linux-foundation.org, andrii@kernel.org,
	axboe@kernel.dk, beaub@linux.microsoft.com, bpf@vger.kernel.org,
	indu.bhagat@oracle.com, jemarch@gnu.org, jolsa@kernel.org,
	jpoimboe@kernel.org, jremus@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <aGVoAT6asYLUx4He@google.com>
References: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
 <87wm8qlsuk.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm8qlsuk.fsf@gentoo.org>

Hello,

On Wed, Jul 02, 2025 at 12:44:51PM +0100, Sam James wrote:
> I started to play around with this properly last night and it was
> straightforward, fortunately.
> 
> Did initially attempt to backport to 6.15 but it was a victim of some
> mm refactoring and didn't seem worth to carry on w/ that route.
> 
> Started a rough page with notes for myself (but corrections & such
> welcome) at https://wiki.gentoo.org/wiki/Project:Toolchain/SFrame but
> honestly, it's immediately obvious (and beautiful) when it's working
> correctly. I've used Namhyung Kim's example from this thread but you can
> see it easily with `perf top -g` too.

I've looked at the page but it doesn't seem to work well unfortunately.
The working case has the symbols correct but the overheads are same.
It should have more 'Children' overhead than 'Self' like in the broken
case because 'children = self + callchain'.

Thanks,
Namhyung

> 
> In one of the commit messages in the perf series, Steven also gave `perf
> record -g -vv true` which was convenient for making sure it's correctly
> discovered deferred unwinding support.
> 
> I plan on doing measurements next and doing some more playing once I've
> built more userland with it.

