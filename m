Return-Path: <bpf+bounces-78130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198DCFEFAD
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9A8338342C
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E33939DF;
	Wed,  7 Jan 2026 16:31:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5638759C;
	Wed,  7 Jan 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803487; cv=none; b=ASC188XvrlANXWltxRi9pagtPu+e6ahfCrJJdNceTLToK4HTNMRsG94SYo4TzTuPBsRirZ+2lz+jaa5AZsFyLaWkQfcf4AWEjPjQQXHIM07d/C/aX/f4Scoi2pV+VnekAxqwCNe5+VOmZMoVvYKAKBXLLIMd77M2qKp4JLnVdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803487; c=relaxed/simple;
	bh=J3LAhts01TSTvdTr+QbNJ9nDbiWBGUbfy51kI6fgFl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1godeSV1Wg3FEcPiaEIDGThQiFNkTQ6ajfPPk5oTVrjqSaKwhShMfbLE0KoZXDG2+zQdLNmS7wy9JqskewUNBr2KMrNAMsDMyHMovuK4aHzyiWqOCR/i8rFvxZU7KohlTFoj+NOP3b+rjRqZToWZn0Azknc8PgS01z4Z1gQdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4319F140446;
	Wed,  7 Jan 2026 16:31:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E149B6000C;
	Wed,  7 Jan 2026 16:31:05 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:31:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin
 <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "open list:Real-time Linux Analysis (RTLA) tools"
 <linux-trace-kernel@vger.kernel.org>, "open list:Real-time Linux Analysis
 (RTLA) tools" <linux-kernel@vger.kernel.org>, "open list:BPF
 [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
Message-ID: <20260107113132.7c05cd53@gandalf.local.home>
In-Reply-To: <CAAq0SUmW7mUP0iiHMJevR+T6BKHJiFoU4M8sCVjJSRMFnT2J_w@mail.gmail.com>
References: <20260106133655.249887-1-wander@redhat.com>
	<20260106133655.249887-16-wander@redhat.com>
	<20260106110519.40c97efe@gandalf.local.home>
	<CAAq0SUmW7mUP0iiHMJevR+T6BKHJiFoU4M8sCVjJSRMFnT2J_w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: aozjwsgeo4ybe7wxrcmexaez1doo1gue
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E149B6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+pjuSXFsl32O24eq1V52N+QslxA4cC3uA=
X-HE-Tag: 1767803465-756638
X-HE-Meta: U2FsdGVkX1/BVuZ/pAowZ4akA6E+ncWgKMBm/Se/QyTdD3qBOaBELwKgJ8nOcMyYaU3/goDz9VshtumzbkoHQB72liVFsp+1lnIsgeNzsfj7pgE6wdK+Ndt/biRty6b/xwxtc3yYyzJWusW+UlFL0Q8azM2dX9u7R7vGHpw0ZRMu+qW8EC2L63KJ48k5iKzHBw3XJLq45anhXvutNVCGDdo9F0O5EVFUwEq5M9AO3zMwvcRDGewCqisCDJSsvW7qGX+OwLyEx7cg0DbR/Q9Iv9eKpbm8Z5V0WGtKIBtoDDuMTax/0x3+sr6NR5oyn3JgXvpje+vD3x1VzckdKYfQQuMpwFixltmeAOBC2Z+NyEFCpWKzw7+Rvw==

On Wed, 7 Jan 2026 10:24:43 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> > In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
> > should implement that too.
> >  
> 
> I considered that, but, in this use case, I saw no point because it
> didn't bring any advantage and volatile was simpler.
> Furthermore, as Crystal pointed out, using volatile for variables
> shared with signals is a pretty standard practice.

OK, I've just been broken in by Linus yelling at anyone defining any
variable as volatile ;-)  I now avoid it at all costs, and only have the
locations that need to be volatile defined that way.

-- Steve

