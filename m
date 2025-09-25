Return-Path: <bpf+bounces-69661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD82B9DD30
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084383A662E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAFC2E8E13;
	Thu, 25 Sep 2025 07:14:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C06219E8;
	Thu, 25 Sep 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784492; cv=none; b=hksJkdRNbl365kiYh9XsdhvVUmAInf9Ddq/lfE3T9gGqwta/mNFstyoFxFDO5qBR7XlGL++GH/x9X9UK2Z4Jp5Yhv4X2Q2qbSoYj72yih+FQb7UClKZhkfHplWN2RoOPl3NKlSwa79v2owFOXXGS85tmhyWJ0ytMPr2xJKDk+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784492; c=relaxed/simple;
	bh=7NcxTOwDekTgL2GhgwOZjxKvQwx1/iFkog9wKBVaUZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZUMyQ7TTBeUKyMJ6xjeFiak0pfOmAidchRl8YMWdtn6Mt8FMfaxE1JVrr2oXl/j9ClnflrrBL7x2ctXAN288CVzEED3rP9BU0pGWEsYO8koEomwvP+rxvwSI6jCwtn6RgFS5SmKHP2uGhIQcdZ5Z7ib0vZNjlncv4F5GkPzHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2633D160354;
	Thu, 25 Sep 2025 07:14:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7E35C20031;
	Thu, 25 Sep 2025 07:14:38 +0000 (UTC)
Date: Thu, 25 Sep 2025 03:14:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>, mark.rutland@arm.com,
 catalin.marinas@arm.com, will@kernel.org, revest@chromium.org,
 alexei.starovoitov@gmail.com, olsajiri@gmail.com, andrii@kernel.org,
 ast@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix the bug where bpf_get_stackid returns
 -EFAULT on the ARM64
Message-ID: <20250925031435.64f54ca0@batman.local.home>
In-Reply-To: <20250925123331.f4158581bd488ca0ba838d1c@kernel.org>
References: <20250925020822.119302-1-yangfeng59949@163.com>
	<20250925123331.f4158581bd488ca0ba838d1c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E35C20031
X-Stat-Signature: a4mr1i9f1s1f1ursbn1t6s3w14841sug
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19p+72UpTwl1SL3DLMeRJ+8sjZlK+VlD3g=
X-HE-Tag: 1758784478-716288
X-HE-Meta: U2FsdGVkX1/Og0jSkahwE0JXw3mOt8HgK/ymsHjHzYQJ+FMYHp8u7q/cbR+5f0WoD0ewLCaBEPf2Ohmx7olIKIvarMmzWShR4irKtrqG3vRQbkFmZNrBjJ3XQ0lv5tFcXv5jPeZm1f2HaPu5Hbtfn9+6N2ivgosLuA1+vBubCSZoGlfhovNzi9k4QlZB1tZqfXHSqwg8LwnwF3/uVB5uGb0359N3KP/9AIi3rXH3cq+sJfKdPYrV3B566i/o+35AMnIekigSk6Y8N0TYTGd0HmRU+mBZIZBzOybxCeEVGtXUBjLvIkZWwuTvZFuBui5sU97LahsRyiHK47ZfklEeC4pJOyfYad44Kr2lxeX6FYx3QJzvqoIbUQ==

On Thu, 25 Sep 2025 12:33:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This is actually a fix for arm64. So I think it will be
> merged via arm64 tree, right?

Correct.

-- Steve

