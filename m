Return-Path: <bpf+bounces-47855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E8A0108E
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 00:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D02C7A1B7C
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DA1C3BEF;
	Fri,  3 Jan 2025 23:01:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085671B4233;
	Fri,  3 Jan 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945288; cv=none; b=rMEAbNE4YPp9r7y2/HHhzZZ6yO4Gy+q7W+CXn8zIKF2dvdSK1uRl7q1OYsTSiktfNEMoBUSb78Ly3LRZnA8BXOozpChy7YkJqNi6g3P6W1drZMwZ06dzOOKqPoczVWBEu/Ae0AMJKRsxE0t1Kp1WiynXU5VuWwUG0kalzr6f5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945288; c=relaxed/simple;
	bh=ygKZEWWLkAua1jdISLtrBfJeTUhY4u4X3AGmkp9dDto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTMTy2+Yk8N6usYqV3+19p9zajlUBvb534TaMVBEAVclUq4R2hO1od2gLzraJV+TH6o51E2jwts3Yq0Nj194M8M1wSfb686pUWheOZMz3uaMyag4f7NonU7eTfwXbtF640CCR7FEQalFH0xe6nIrmDAn48HrFcyDXQzTQrS8vTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A609FC4CEDF;
	Fri,  3 Jan 2025 23:01:24 +0000 (UTC)
Date: Fri, 3 Jan 2025 18:02:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 13/16] scripts/sorttable: Move code from sorttable.h
 into sorttable.c
Message-ID: <20250103180243.53cc9e98@gandalf.local.home>
In-Reply-To: <20250102232650.834242633@goodmis.org>
References: <20250102232609.529842248@goodmis.org>
	<20250102232650.834242633@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jan 2025 18:26:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 20615de18276..da9e1a82e886 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -327,10 +327,420 @@ static inline void *get_index(void *start, int entsize, int index)
>  	return start + (entsize * index);
>  }
>  
> -/* 32 bit and 64 bit are very similar */
> -#include "sorttable.h"
> -#define SORTTABLE_64
> -#include "sorttable.h"
> +

[..]

> +
> +#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)

My tests started to fail after this patch. It was the stack tracing tests
on x86_64. This patch removed the define of SORTTABLE_64, which stopped the
orc unwinder section from being sorted. :-p

Oops! When I post the stand-a-lone patches, this will be fixed.

-- Steve


> +/* ORC unwinder only support X86_64 */
> +#include <asm/orc_types.h>
> +
> +#define ERRSTR_MAXSZ	256
> +

