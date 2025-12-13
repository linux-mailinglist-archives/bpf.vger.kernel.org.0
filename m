Return-Path: <bpf+bounces-76548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1BCBA2E8
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 03:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ECC93089E77
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 02:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60221C16A;
	Sat, 13 Dec 2025 02:18:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A91AA1D2;
	Sat, 13 Dec 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592337; cv=none; b=taiMYEElr55ib+eE2AwGt8V6ohf+KCfdrTdud5rlIgVVa0dx9lTtG6MGgZISJuyagBS1F3kw3QDj4XoAuAE4u642SuYiiwCHl6otjvXY6/uLtt95gNk/xO0uhkkQtFogoxT0fVhEn2VU5ke1zEqbjJ86aJ7C2qlTi2tp7bfwK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592337; c=relaxed/simple;
	bh=ZI9hCZEWuZ2ppIODd9Lq/QAxmjFUcxbkVL+U3B3tFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neXZBispVmR3hGYQe/Mcxu6PGN+Zess1oQFDAax5Y32LS+tJMmLhSQ77tgML2IZHpNq/DWX96udj4COWEAWdhzXce1iI7zxBwC+0mHhxDc8UuA13oEnQXDgLUJAd8HU2MB4PAHO8UXvI0zXBw3njIg12lJ9kpNfunFFJr3zby/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B87C958B0F;
	Sat, 13 Dec 2025 02:18:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 9B1DE20024;
	Sat, 13 Dec 2025 02:18:44 +0000 (UTC)
Date: Fri, 12 Dec 2025 21:18:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251212211839.6c3e2399@fedora>
In-Reply-To: <39252902-567b-4e74-b6c4-91eae1df7c0d@paulmck-laptop>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
	<B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
	<febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
	<bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
	<0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
	<C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
	<83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
	<7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>
	<d863f1ad-477d-4e3f-a0b5-fa9f282a164a@paulmck-laptop>
	<C9254103-18E1-480F-8009-003EB44F6F2F@nvidia.com>
	<39252902-567b-4e74-b6c4-91eae1df7c0d@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9B1DE20024
X-Stat-Signature: fed981ucywbbxmcmzr8e1gxm69hc4hq3
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zXEryEs/o0kL1/9E0kbzyT3o1Z7je3rw=
X-HE-Tag: 1765592324-161545
X-HE-Meta: U2FsdGVkX19AKiK36Zs0wqjoTvYDt1E6OkzwVY78+gdP+OgPdHUq9zbCZWSzHy/TEHRmgFTSJ7DWSjBUuNLGPmaT3CcRW80MHuNXeZfQqUJXZ4mXX7UHBoR7zNBdFuLSA3C+41ctO0Pk0Jlj3AbKUeXJ3uSMkjRWgZjMXb0Ptq5MsiGVg7FBRT3g0/aTEBzdxJPvsJeJzigN/QqdHQGwAjFEy2pK+RFb1HY1r8mCVeldsMwGV9tpVoAFwVDcNbou5cIV+VVFeP8YD4F8+FDvVZEMUBQvVcrY7vToklqTnJcHWoH7cL1UNvraURdmyaqIvLCGPOLK8WpdE2sxOUYt6dB2w66qTpgL

On Fri, 12 Dec 2025 16:06:09 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Now *that* I have no problem with, as long as the consideration and
> exploration is very public and includes the usual BPF/tracing suspects.

So we are all set then ;-)

As I talked with both of you, I'll just reinstate my thoughts on the
patch here and make it public.

I agree with Joel that it would be better to have consistency between
RT and non-RT.

I agree with Paul that I do not want to add possible regressions for
the sake of consistency.

Thus, I'm going to keep this a PREEMPT_RT only change. If someone can
come in and convince us that the PREEMPT_RT way is also beneficial for
the non-RT case then we can make it consistent again. Until then, this
change is focusing on fixing PREEMPT_RT, and that's what the patch is
going to be limited to.

Thanks for the discussion,

-- Steve

PS. I have a working patch, but since I've been busy running a
conference, I haven't had the time to vet it enough for public
consumption.

