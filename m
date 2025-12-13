Return-Path: <bpf+bounces-76555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CCDCBA61E
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 07:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADA23300214A
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE926A1B9;
	Sat, 13 Dec 2025 06:40:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BC228C9D;
	Sat, 13 Dec 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765608005; cv=none; b=duLBf7G9Iz63DPeYxNWQntNpLoh7kYlefGQqHMKqhluTi1BJiZg+pYiIfD/qQDzG481UYPnUAqsnEwJY42A7jZPiRK6MlvwzXJZ7f7FIY9+z93/Rn5ZcG/MJl+lNl5DYf/FJChLd9B/ugeiXHkmi6f4GpA6fcH8+PbbCVkjrG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765608005; c=relaxed/simple;
	bh=gb1M4S239Rk2pV8pAOHzG+Ffyav9kJa6yrKX+RMxYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAufdEq84VG7scEiwNL1EgUQ+yV75bdiWYyFWmyJZyM+bbXEGqF1zwB7dnBbOg593vsH59L7wu31IHl6MAPRIsKDQkwSjgaN1G28GuYXWq5oUw4G7bHfZVh1I+FOZzyX5TqG2q4Cxu1EuQfU1JuWs3WHlPbveuM8x1rEv8ghSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 961711404D6;
	Sat, 13 Dec 2025 06:20:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 39AA06000B;
	Sat, 13 Dec 2025 06:20:54 +0000 (UTC)
Date: Sat, 13 Dec 2025 01:20:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251213012050.576eead3@fedora>
In-Reply-To: <09c76498-6a0b-4880-8a86-2a295c47c703@efficios.com>
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
	<20251212211839.6c3e2399@fedora>
	<09c76498-6a0b-4880-8a86-2a295c47c703@efficios.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n7qz5qdzzmnhwwfc8ir9r88gcrdijmgo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 39AA06000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19V07REGIYtSgIpxWl75AGch8puwtuOgxE=
X-HE-Tag: 1765606854-447506
X-HE-Meta: U2FsdGVkX1+j32QEBIj90Zv4U/lD2XQyfLqcxFmK2ho22V44y2HEPw8I2nmkSve80cRQNfo/PWxisWwlQAd8WGpMylgYcLo1y8BmPDjbMDEr55WGX3Vik/3wq9uXjts4AtPZCrYLEzZaz8h2PAUE3HgMDDx86oVAAMbjWGjoYN3Bm3knIYXDj8xkT7/MRmNZRQl5puqqZjs+r8vXsGcNYBzoR8mfPpliFcVaSM2S/t43vA6btvQ03MY1S0MFwXfeJ38gnMdAxHvPcWNL70LgOb4u0lJHzJNl3bDuaVyzaKEi3p5i2ZOrRuMYBEbBOhQDcVgPz3WRjYk/5Hx/xtvzlqR9Yz74Wm2YhcrwcJBUk24pKpC6k58tDRjjVIv3iqSD

On Fri, 12 Dec 2025 23:19:41 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Here is one additional thing to keep in mind: although
> SRCU-fast is probably quite fast (as the name implies),
> last time I tried using migrate disable in a fast path
> I was surprised to see verbosity of the generated assembly,
> and how slow it was compared to preempt disable.
> 
> So before using migrate disable on a fast path, at least on
> non-preempt-RT configs, we should carefully consider the
> performance impact of migrate disable.

Right, which is another reason I'm keeping that part of the patch as-is.

-- Steve

