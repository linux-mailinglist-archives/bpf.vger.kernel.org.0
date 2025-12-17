Return-Path: <bpf+bounces-76925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C676ECC9B64
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBEF3062E7A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A6311C38;
	Wed, 17 Dec 2025 22:29:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE33112C2;
	Wed, 17 Dec 2025 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010541; cv=none; b=ldcrs+Yrm3+UIhH6a2OMTja7b1bn7roTYp75SkN/zZMJdJ+daDQJJVNXBu+2HR0tkTwiMnSb2SXE0cXY5s+hJIDroiE567pkPZQXUE7NX6weMYZFMeatBPjmh2hgAPoVhm9+YHcSAe7fESiX2jdYZHuYwBaZJaqDOsM4VFxNpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010541; c=relaxed/simple;
	bh=2hawc1SSg+liNeexE2EYxW5UPDOa48r4bF69kCdcuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaRAQQkU56X/yV5Lnf+bzsVrohnKx7M3+l/OnPhbW0Os8TQ7Lil7VPAqsW/+zg4jtDOiBkR1L4phb8ZYbsa9dk8BQ0x8bw11qhhpba5uPvJ0IGv1OZtCUAx8oNp6d5hFXiPDhDtjFSEvzAwyogkwWwiyyWUQEzUu3iwqLfVvH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DB953160168;
	Wed, 17 Dec 2025 22:28:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id EF2C96000A;
	Wed, 17 Dec 2025 22:28:52 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:30:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 georges.aureau@hpe.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kallsyms: Always initialize modbuildid
Message-ID: <20251217173029.2d07012c@gandalf.local.home>
In-Reply-To: <20251210170347.28053-1-mhi@mailbox.org>
References: <20251210170347.28053-1-mhi@mailbox.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fanm57x3yjdxcqgoguhs9ebmsd1xpeu5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: EF2C96000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+AwUgPOkPQtD55AUh0sTWLJi3q30jqUWI=
X-HE-Tag: 1766010532-244636
X-HE-Meta: U2FsdGVkX1+ht2JxDWh2RXatxiYHvO7GQ9ze+R9EnAi1bsHURm4vgvzLYpsPZLltGGsz6LUmgNMTyQn0ehSNz74deEdj64Zh/OkfB/QkezVTozf795oIbEpSoSv/4UybWhrbyOvoaL0hEBmKnwuznOazKqhhYm86N/M171LNIGMlWfpb2cjOQkqzVK0jgfheQ6Ps7spSoqUzAUgsHQEkehtxbyADeRer20Xqc6nODxLUAxQ/OIWSa0nHTNZKtI2AybELXW6kjdsXMGPI78hvdrys9l5mm+nhLrgvoJ3LSndZUetR/MxlXkpy/Diiftoazj2MehEMEPxTTk3eLMHjqBU06Uyj0gt9FOqbJiKUkTusJJCvIWokAZuznU31XXnq

On Wed, 10 Dec 2025 18:03:45 +0100
Maurice Hieronymus <mhi@mailbox.org> wrote:

>  include/linux/filter.h | 6 ++++--
>  include/linux/ftrace.h | 4 ++--
>  kernel/kallsyms.c      | 4 ++--
>  kernel/trace/ftrace.c  | 8 +++++++-
>  4 files changed, 15 insertions(+), 7 deletions(-)

Also split this up into two patches. Then I can take the one for ftrace and
the networking folks can take the bpf update.

-- Steve

