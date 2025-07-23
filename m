Return-Path: <bpf+bounces-64126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1270B0E772
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB81D1C20633
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B517B1C27;
	Wed, 23 Jul 2025 00:04:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DF184;
	Wed, 23 Jul 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229060; cv=none; b=l8TL3NSINgkdw1d6KwS9yAMO2KK2E/yyaCbWq4XZFMcppvWzvi2cW0ugG6YKR+YtXIRzKfUs/eUJgXqqaJaRiZxLjGxNQ63C0dXSbufSRPVtBs+3mqjsxuyKlH+jBAvj/b/N8jnV/Gn56LEu/N2UU1Rr3Onr2Ds+6BtFqk8Jp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229060; c=relaxed/simple;
	bh=zvxTzCeRO9oJWT1wPdAA781sDAx6+luKMQxGe/Qy99A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmS8nD5r/wN6fOMYOdcKSRS4K+N4//Tf/9fjPniZPvAh85UmRxCeif57/2SxPYZDobEUk+DhCTpoda/FWdNie77TcCL7qc8x/rwCxwIR2EQxwmbJ/M6HlvkjYnv7Gg7eNx9USBHRyX4H72aWj3RXUXHEFmVWCSXjHPe/cLhJr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4FC5F132BF7;
	Wed, 23 Jul 2025 00:04:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 0229B8000F;
	Wed, 23 Jul 2025 00:04:13 +0000 (UTC)
Date: Tue, 22 Jul 2025 20:04:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Eder
 Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v1] tools/rtla: Consolidate common parameters into
 shared structure
Message-ID: <20250722200413.4a3b3777@gandalf.local.home>
In-Reply-To: <20250701060337.648475-1-costa.shul@redhat.com>
References: <20250701060337.648475-1-costa.shul@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0229B8000F
X-Stat-Signature: r8oqwtdgrf5jjr1j8ijn7iukmsneamyg
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aoILLA/5Z71EuoA872FLboiUcOjUo/0U=
X-HE-Tag: 1753229053-332301
X-HE-Meta: U2FsdGVkX1+n95+cqcJqYJt+KVhQRkttmDltb3nGvZXVl2u6Zx/w8I99T0e+xccKmiMSyTWZMLDknjTjGLUBrW5l81JKKWMzA1LftUK3Cme7SjRDxSjWxx6CzGf8U/yDNj3y8enkY1042o+cDnqjaWxoeQ6EgcXvVtvw+GGIaw8ymS45SC+nS8tJmtLDWGFEb1fJeRXftv1gsnOLaMLXUm8PrTO0R3SkEKZUYcNVKbV2Se1shNFYMuv2VqXuyXnentOZOvmH9jWL6Zl/HtyJf3IVN0wqCXRhZyXMcA8acI8Ok4k9U54Qwm1P2S2vBpJ+Wcunif+Xpbz52j90m46KWinvJZKeZlkU

On Tue,  1 Jul 2025 09:03:14 +0300
Costa Shulyupin <costa.shul@redhat.com> wrote:

> timerlat_params and osnoise_params structures contain 17 identical
> fields.
> 
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.

I have no preference about this patch, but would like an acked-by or
reviewed-by from Tomas and/or Gabriele.

Thanks,

-- Steve


> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c       |  24 ++---
>  tools/tracing/rtla/src/osnoise.h       |  19 +---
>  tools/tracing/rtla/src/osnoise_hist.c  | 112 ++++++++++-----------
>  tools/tracing/rtla/src/osnoise_top.c   | 102 +++++++++----------
>  tools/tracing/rtla/src/timerlat.c      |  24 ++---
>  tools/tracing/rtla/src/timerlat.h      |  19 +---
>  tools/tracing/rtla/src/timerlat_bpf.c  |   4 +-
>  tools/tracing/rtla/src/timerlat_hist.c | 129 +++++++++++++------------
>  tools/tracing/rtla/src/timerlat_top.c  | 121 +++++++++++------------
>  tools/tracing/rtla/src/utils.h         |  31 ++++++
>  10 files changed, 292 insertions(+), 293 deletions(-)
> 

