Return-Path: <bpf+bounces-43599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295409B6D5B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 21:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BC8B20D85
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D24B1D1727;
	Wed, 30 Oct 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oT+W/2vx"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AA1BD9D8;
	Wed, 30 Oct 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319170; cv=none; b=nyfHeeqPw/ItLQuE6xw6JOMQleC5cEhz+5QXkUF6VqMTCJKfkQOebqUBjyXwmJWngWCjlPvX4DKC76o1nZ5b28TI2cCd+vZcyXFvrrIcKm0fIXva7ey5FJ9TWNewNL2I0moyf6qNYZbrLpKp4/xoPnd11BGsx4TNYtOmqYW2FMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319170; c=relaxed/simple;
	bh=pKZHxYeG59gN4K6UnmwBK1qC2oVA4//QyJIDe+jYStk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD6arOiNBhJsJ9dWcE7+huOODZC8bWOTbBooZoDAwLE+b/+SiO3ir1xGzFIKwGjbbYJxpa9soTrsrHPNvUZSzbBhop5BrmgzVJ+uRQvuGLy7ZgtcUMKUpHMZXlsRkK6mbiixHrfsiRvJvih7YitD98GaJrNGES2w2LMj1/hJ/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oT+W/2vx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Clnn7Z7qrOy/l2sT7ztvxWd4HKhZh7MnGYAlRhtRBIc=; b=oT+W/2vxc8+SdLFcki0njSYPKh
	sYUSkwb8Pn/bLMbWKzIA9y2dcVPhZNVTi0/BUcEx0BkugaRGJBPZCu11vg56wFbX+dHOswxfRAA9X
	tIN3AN9Djg/ajJ+GTY7wHgU/MqV7FjYEYJH2Gyy2eCTMXYzMSLbueURGNjkOF7GXB4Kj3DgAtzhj8
	0aDN3mui/HyvaimoTdR4cGfqRZyfoaRE9w3mGgx17nrRsPLvGw+A8dlmW+srxMLn10+RD5xyE9uJx
	w9RSxZ+eswQ8x1le+/0G/ZpQue9VEE9m5/Qbpxp8mNY9YXLAIEO5vWAwJkrv6Q/AAMYDTi38uRTic
	BBrRjlcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6F3R-0000000AL3C-3X0i;
	Wed, 30 Oct 2024 20:12:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D36AF300ABE; Wed, 30 Oct 2024 21:12:32 +0100 (CET)
Date: Wed, 30 Oct 2024 21:12:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH perf/core] uprobes: fix WARN() inside hprobe_consume()
Message-ID: <20241030201232.GP14555@noisy.programming.kicks-ass.net>
References: <20241030160208.2115179-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030160208.2115179-1-andrii@kernel.org>

On Wed, Oct 30, 2024 at 09:02:08AM -0700, Andrii Nakryiko wrote:
> Use proper `*hstate` to print unexpected hprobe state. And drop unused
> local `state` variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410302020.1jHBLfss-lkp@intel.com/
> Fixes: 72a27524a493 ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Since I've not yet pushed it out to tip, I've folded it into the original patch.

