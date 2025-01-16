Return-Path: <bpf+bounces-49030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E1A132DA
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8CB1657C5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD718E34A;
	Thu, 16 Jan 2025 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boG4RiTV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAD18C332;
	Thu, 16 Jan 2025 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737007074; cv=none; b=oplXrIW4OVQasFRHIaUfLp0Qfdgt8/hBdpaaJfh3Gj6F34yJUvu7hpca3GqHeSfRWplqZBo/9Bb8FBi7iqB6HiQfqR6xbuUQFIaX+MYatJ9jZHFkYQ2z5jwPtehRBJ/5L8M5Yh4s5Lcd2mniJREENMIyr+9FJ6t4IhZu4MzVHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737007074; c=relaxed/simple;
	bh=UJdNxl5LcdPKG7+KGEqxW1rEpNBHUqDvsCXrJwlCX6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EKqLLmcN/uyOKzIOmhQ8Cnbc0L2taTwQ7tMr/dNh61GdUoSu0+UB0emfhi6KawbcxKDN5usWuOtkl8FO9boYmVc2llmZhGSjpxHVQck8vsUB0BoXboMK7dgmR69NdDSePZzP7xjaDP15JLoolcYocwyCbvb+0skg/18pyl+eCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boG4RiTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7E9C4CED6;
	Thu, 16 Jan 2025 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737007073;
	bh=UJdNxl5LcdPKG7+KGEqxW1rEpNBHUqDvsCXrJwlCX6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=boG4RiTVcmJ0/CWQdVTEuV4bS6VAK9Flc2WmHrJldr5RkYjwFoGBRPqnKKnOM9TXY
	 GugpH/QdKmp9ZO76ZFwW1tKpCUvQWXRAuoG9ywjefAJMx+m/q8pWvjQwhEdEnjIuHd
	 2vFRrmdf7T6pKieGZ2TooUSJZo1k7dwHML3p240brNSzOqA1ixPEcY705CTKLhqzW4
	 uUO3V38IsXmlt1J+pzMEjzxciYnmIXySyZGbymzWo0YNqNB/uxNgnZ6HoSyo2+XWq9
	 ToMpyMK9sqYsD+9V3c0z86nJU5bnXNmbOvefBwp/EAeZW/GYJuYrhTdHUPT0h+WQ2L
	 dmE9J9vSAJIGA==
Date: Thu, 16 Jan 2025 14:57:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Laight
 <David.Laight@ACULAB.COM>, Peter Zijlstra <peterz@infradead.org>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-Id: <20250116145751.717d370483a1764657dea8c9@kernel.org>
In-Reply-To: <20250114140237.3506624-1-jolsa@kernel.org>
References: <20250114140237.3506624-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 15:02:37 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> while checking on similar code for uprobes I was wondering if we
> can merge first 2 steps of instruction update in text_poke_bp_batch
> function.
> 
> Basically the first step now would be to write int3 byte together
> with the rest of the bytes of the new instruction instead of doing
> that separately. And the second step would be to overwrite int3
> byte with first byte of the new instruction.
> 
> Would that work or do I miss some x86 detail that could lead to crash?

I agree with Peterz and David. My original idea is that the putting
int3 is safe anyway because it is just 1 byte. Then we can update
following bytes (only after we ensure no one executing(e.g. interrupted)
that part). The another good point of int3 is that can avoid writing
over cache-line boundary because it is 1 byte.

Without this int3 detour, it is possible to see half-way updated
instruction from some other CPU cores :( 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

