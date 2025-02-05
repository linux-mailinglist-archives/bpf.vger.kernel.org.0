Return-Path: <bpf+bounces-50464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7DA2802E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36643A617E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFC227B9D;
	Wed,  5 Feb 2025 00:35:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AC79F5;
	Wed,  5 Feb 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738715725; cv=none; b=cT4GQE7GRGFCBzd8ukmPCxJNgwf6fHQckFG3BVCWuw1+4TEzRX9l3U+71aw7DtYDsWyGwB7XnSN21NbuiLTJNIGRB1ZNVpUrUL2MZIApKqJbiUpP7ZN7isymLVdINL1z9+vaGeNmlJbj2ZkGdhbu61rAYOZEY9KFMc56UPLAI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738715725; c=relaxed/simple;
	bh=xWE0l1fyQZcerbALehy228Zxj2+0c+MEx/a4oL83YXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7HGv/6KaEgfQ+fV41X8tpo6hYAz6sfX0oHC79J0kJK3mYtkBK8/4PXQus/cLxkW3zZrkKa8EjGEzi1TdVw8lW5IF9opa6eDiCR/3mz6aQ4iTRcR8m+zcO48xkfRioPRTCM+rClyh/cesWyLQ82AVmmBA/TA+UtFGx8vJnF3PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE4C4CEDF;
	Wed,  5 Feb 2025 00:35:22 +0000 (UTC)
Date: Tue, 4 Feb 2025 19:35:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
 <linux-kbuild@vger.kernel.org>, "masahiroy@kernel.org"
 <masahiroy@kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "torvalds@linux-foundation.org"
 <torvalds@linux-foundation.org>, "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
 "nathan@kernel.org" <nathan@kernel.org>, "zhengyejian1@huawei.com"
 <zhengyejian1@huawei.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250204193559.1f87b4ea@gandalf.local.home>
In-Reply-To: <aba52935dc06a1fe69f05309f5d9828a297ad787.camel@crowdstrike.com>
References: <20250102232609.529842248@goodmis.org>
	<20250102232651.347490863@goodmis.org>
	<aba52935dc06a1fe69f05309f5d9828a297ad787.camel@crowdstrike.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 00:13:26 +0000
Martin Kelly <martin.kelly@crowdstrike.com> wrote:

> I'm not necessarily a qualified reviewer for this patch, but I'm very
> interested in seeing it or a similar solution get merged, as the impact
> when it hits is significant (silent failure) and not easy to detect or
> work around. Is there any obstacle left in getting this one merged
> other than further reviews?

A version of the patches 1-14 was merged this merge window, with some
tweaks. I plan on rebasing patches 15 and 16 on top of that and
resubmitting. I just have some other things I'm finishing up.

Thanks,

-- Steve

