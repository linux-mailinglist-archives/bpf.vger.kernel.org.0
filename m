Return-Path: <bpf+bounces-74973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA1C69B8F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1404EF27D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01883559F8;
	Tue, 18 Nov 2025 13:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E93570A7;
	Tue, 18 Nov 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473900; cv=none; b=T4bhUAXLBtK8HxO90RZPVu1DinhzvoLSt2A1w+cVbgQ/sY33ANNTTpYpM/bb35q95pZIyNkfLgqwmoUbWF+TY4T6JIYC6xNX7cqaITil6k/Jc3Atlat7WTlP2nKVqFrZx+9wW+xEeDNoQnDk43gp2DuchDElEINWhrTyW+cIvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473900; c=relaxed/simple;
	bh=rGNa/pIfv8qROdNsKKm+I5WoENZH93stWE6TJNY0qHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnzZLK6fSJx20WcxUv8rfoY1d12oz9ycdfsxw9/uwBaRu35LItFJm1+G4uXlYuiBAcJXCB6gSsZfBxB09PzaKfx1nXzb0yl5D+SSGplP8o/zHYwAiZ0TCfP3bRHI64OxG2la5jq2svDJ8j6eB1/XXPO+h07r3ZB7HseU5Sy8wZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id F1B7514053C;
	Tue, 18 Nov 2025 13:51:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 0B3D720016;
	Tue, 18 Nov 2025 13:51:29 +0000 (UTC)
Date: Tue, 18 Nov 2025 08:51:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: bot+bpf-ci@kernel.org
Cc: menglong8.dong@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
Message-ID: <20251118085156.5a571add@gandalf.local.home>
In-Reply-To: <83e39931f7cb3894d6fd3537550448b89a5aa60fb2e3757b56d6e8db91496e3d@mail.kernel.org>
References: <20251118123639.688444-2-dongml2@chinatelecom.cn>
	<83e39931f7cb3894d6fd3537550448b89a5aa60fb2e3757b56d6e8db91496e3d@mail.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ep6oawa8szkw14899k4prd39i998i474
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0B3D720016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EOVwYfCYl+koTenwO+++nMwveKn3ACK8=
X-HE-Tag: 1763473889-837908
X-HE-Meta: U2FsdGVkX1+iydgnmD1eeaqN1xa4rq9fJM3KcSj7iR03m30041Pbi2Ao4ElW7CL3xEbd+3iP6phbbTrN9/2LRVts3fQg6aRQUZf9dZGDwOrK5Uy8VmvmW6PpL+fl9KZYHSHhfkkF34qmYep+KbXZrvNRyxKDW5z1LjfVJuyd9xN8CBLDlQL/aocfqjnVGKE6PifgsyrnBuMo6UqiIL1jQFX0ijoZOiEwChAXwdjBhPbh6S1wDr6DpOQgn7G+Sio9RVeGkaxHzz5r1KwpHt2NJszZb+QWCCUrqNJsCYaDx9pnYMDP2Tj8yjy7Kkc7g01N5ZWTjACoN49ZbVSDUp/wioBdZhIhequS

On Tue, 18 Nov 2025 13:25:04 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> The commit message says "we can tell if we should use 'jmp' for the
> callback in ftrace_call_replace()", but no architecture code is updated
> to check the LSB. Should ftrace_find_rec_direct() and call_direct_funcs()
> mask the JMP bit before returning addresses to architecture code?

I guess AI isn't smart enough to know about kernel config options yet.

> +config DYNAMIC_FTRACE_WITH_JMP
> +	def_bool y
> +	depends on DYNAMIC_FTRACE
> +	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	depends on HAVE_DYNAMIC_FTRACE_WITH_JMP

Where this code is only implemented when HAVE_DYNAMIC_FTRACE_WITH_JMP is
set.

-- Steve

