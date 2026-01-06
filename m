Return-Path: <bpf+bounces-78014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AEACFB3C8
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 23:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60496305E347
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1062E8E07;
	Tue,  6 Jan 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi+MZXd1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAB288C13;
	Tue,  6 Jan 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737453; cv=none; b=nNtj3PGbilqA4TRjJfkn7Mm49rafA9MQSgYtw9P0rCyN0fca4gmLJ42JY9j/R4+HN8XmGJfSx8vlz2o1gkOF179+D7ajYpXmNAa1494M3EAOy7nchw3Cqt6oBkqn9aLwOywLFFQ5hgYYd/5rReJogNJSxRX8y741qVV0UxnT3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737453; c=relaxed/simple;
	bh=3ItmZWXe7SLATqaA/No0vinjdYjMYE4Kv3BCtuInokY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JxBZZ9W1Et5lmEsn7y29taKQQowRX6cOZR7ZEsIaDT1TQQtTHg1wvzySeCiKHkzKJT4oNp55oKcva4LrDIM5WZ1YHD+/hu4p15dcqi8B4lfL6Q2mUWHcm4tF4yLWFMXh2kKjgWlaMUURI/N8Azx3tH6tYfFFZmilmbSdaWWpzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi+MZXd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5845FC19421;
	Tue,  6 Jan 2026 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737452;
	bh=3ItmZWXe7SLATqaA/No0vinjdYjMYE4Kv3BCtuInokY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qi+MZXd1/oLdWLcHvlwqpwcdkrYHzdtmHT3UgLO+nOBkwS3ltGhH3Hu6g3YkQJqM7
	 wJmRt1U0p7fUaarV6lfCX+laBGFcXHKL14KfF+GkMm4m9hwlCbOlAG5EDnYBTFQUBX
	 pyMbndCiICGcvQPXXiV8JBIqIYWg5eeZlRstgw5QXjHFHh40PVxhN9YzZSXLtYJ3zT
	 nrZWEI5ajr1HQ0lJLLeVY6gVq3KG1iLntKBXJCwKPUaUTaWp0SvKX84NcDLZYoyaQp
	 9JB/IuzyIr62iqM90v5gmVD8zx13GGdpWUG9Ao1jMffjSfyUMwmpovwmHz0+4IVHhG
	 R28nCoOf2KRjg==
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
Subject: Re: [PATCH 0/5] kbuild: uapi: improvements to header testing
Message-Id: <176773745004.1983625.3214132191933293574.b4-ty@kernel.org>
Date: Tue, 06 Jan 2026 15:10:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev

On Tue, 23 Dec 2025 08:04:07 +0100, Thomas Weißschuh wrote:
> Also validate that UAPI headers do not depend on libc and remove the
> dependency on CC_CAN_LINK.
> 
> 

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next-unstable

Thanks!

[1/5] kbuild: uapi: validate that headers do not use libc
      https://git.kernel.org/kbuild/c/6059b880a93c3
[2/5] hexagon: Drop invalid UAPI header asm/signal.h
      https://git.kernel.org/kbuild/c/cc45d2ea5cfb8
[3/5] kbuild: uapi: don't compile test bpf_perf_event.h on xtensa
      https://git.kernel.org/kbuild/c/e2772ba5f43df
[4/5] kbuild: uapi: split out command conditions into variables
      https://git.kernel.org/kbuild/c/4ac85d9bc73ed
[5/5] kbuild: uapi: drop dependency on CC_CAN_LINK
      https://git.kernel.org/kbuild/c/e3970d77ec504

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


