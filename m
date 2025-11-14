Return-Path: <bpf+bounces-74517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56FC5D6A1
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C13035B091
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51184322A21;
	Fri, 14 Nov 2025 13:38:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF131D72B;
	Fri, 14 Nov 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127512; cv=none; b=KGsZGndWeSU+uPD8VjpB2y7dIOV9NwhD9+kxnHSNRNPQ5ReXKoQntznadWwPjLmBYaDPBO05DCB+U+DLrMR2x6Dtob9Di5DCExIK+Yqa+epxRh/8arA053xtv+yP4JoiYt6fNneJ1SB0/p5WTWc+e1mjXQ9BZl5PlJonSM2wNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127512; c=relaxed/simple;
	bh=QFnd//cjCQ1eQc/eM/mSwQm8h0omy+mDmf3VulKf0WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BL28CzsakPNVq3aY+QBGDdB2lwaXTOmo+Jw3TOH2LVuf44DXg+Qep1Uu+cEN65p0QQ8nHSYa5+A/aTYz8rz8cJhf/hfxV6dEzwDQlAeN4qt4oaCu6WdfxQ+ZEzBRQHn7UXMPp/JgLRumyO32Ki+xhv2UgFO/k15I2DUtwQy6ZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 97D72140265;
	Fri, 14 Nov 2025 13:38:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id B7AC36000C;
	Fri, 14 Nov 2025 13:38:17 +0000 (UTC)
Date: Fri, 14 Nov 2025 08:38:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/7] bpf trampoline support "jmp" mode
Message-ID: <20251114083835.553c9480@gandalf.local.home>
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B7AC36000C
X-Stat-Signature: exknoxa6d3js4eg6fxzqyjuowo1kkxwx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187DFxGB89fVblMi9mvtSqYPmT3B/L9Vsc=
X-HE-Tag: 1763127497-328659
X-HE-Meta: U2FsdGVkX195TzEFvABiSmdGU1vh8NogsxuqHPDZUjNDyqGeyYTSOKRJrXOHMCe0TcUz8Da3XlWw2+WTJJt6XAXWouPeA0BzRcHJ+5MtzrqX1HCiqt2mjn/uts+/B0aFEvKMSbaZF5CNKvepmDH2hy1VmmECX3W53A+6xdqc927xwO4zUCW2sVN16ttkrBZpitLDw3kNgp1Ss3iz9kaDueyta3xug1pU4QKsF1q8fs3ob+pJq2hqDcIxKM5d5Zes8CXo6+OjpcqStZ+hRzG5iXM+IbxI+9VpKMrgXmzjC0GkH4R/OSM9tS1Kde8qHM52AISNLX1uBTyBEVT4vCS7dQLCUufytef4

On Fri, 14 Nov 2025 17:24:43 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
> Alexei in [1]. And the logic will become this:
>   call foo -> jmp trampoline -> call foo-body ->
>   return foo-body -> return foo

This obviously only works when there's a single function used by that
trampoline. It also doesn't allow tracing of the return side (it's
basically just the function tracer for a single function).

Is there any mechanism to make sure that the trampoline being called is
only used by that one function? I haven't looked at the code yet, but
should there be a test that makes sure a trampoline isn't registered for
two or more different functions?

-- Steve

