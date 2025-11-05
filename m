Return-Path: <bpf+bounces-73656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A19C36380
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 303E14F7F1F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522F32E152;
	Wed,  5 Nov 2025 15:04:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C52C21DE;
	Wed,  5 Nov 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355045; cv=none; b=ZD7bLs8snEK1SXECjlsy27ig3Bhy59KxfpXk2e5k5Yhlm+L/29Reg5j3AwUXFsYR53agniJ89ucw1/wILABz8cL1cOOdWSd1O5n58/1jhVwTT2iuwJcoqNkr1PGQgtKH7OiAPzXAStmujV5lzYMm0KUJVlqmJRiLQ9Z9FhHQMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355045; c=relaxed/simple;
	bh=7nRtJDI+lKfoUQzV5K0HGMxyYiioXf+2xuEzOcU8H1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGERHFTqKT3ahBmpulY8sOSb/+2bliAKPZ4jtd/KdSPeB3AW7mEQ1aKWjfOrbZKDwjqclYCXzsPMNVe3Zc+SHSDAQoVZzGUm+vik0Q3RMqBHCrkr1dB0vBo0Ry46qgLXMwrPF+XPIGqEB3fpc/MxAYDiCXf8dmMAydABALIl5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 850B9B90E7;
	Wed,  5 Nov 2025 15:03:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 04C4F20038;
	Wed,  5 Nov 2025 15:03:51 +0000 (UTC)
Date: Wed, 5 Nov 2025 10:03:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Yonghong
 Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return
 probe
Message-ID: <20251105100359.2e6eeae5@gandalf.local.home>
In-Reply-To: <CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
References: <20251104215405.168643-1-jolsa@kernel.org>
	<CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: faimxb7r1prhubhdn7yebgf5kzgcbf3i
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 04C4F20038
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19oICpbajdNSFsER0ElgnZk3x8uXBBdGko=
X-HE-Tag: 1762355031-356352
X-HE-Meta: U2FsdGVkX182fn0J2UslbYkznHRMSErGJ3A/8IoWardkfjvbQHaIz+u0ZUICYBydfGjrErq+xiA2IckyziDpSQOTj35xgoPq9ZY3buH7UHYb41ZS7TdypRtcQew65S8JK7ojXgHm6d6VbK92XTT7Lxmxe12dInoy0pxKsxMs3Yy+GrA/BrRIQ7ggEEEzBg+u1qxtjmKByTJUi6oXyg2U1RVocy9SwK9oNuQuWdeXCQTV/jJFUxYZ/ORaWWfow2NKrXqi0cEOjmHtBX9TEPQvCCzl7N3s4++eyl82mzhN8EX/4pIbZH7YnQleKzVlGXuZp9zYF4p9baXYq6VaueidsgcLZvWaHNC0

On Tue, 4 Nov 2025 18:20:41 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Steven, Peter,
> 
> How should we route this?
> 
> If you take it into your tree, please send it to Linus right away,
> so we can pull it into bpf/bpf-next trees.
> The conflicts in selftests/bpf in the last merge window
> were annoying. I don't want to see a repeat.

Let me run this through my tests and then I'll give you an Acked-by and you
can take it through your tree.

-- Steve

