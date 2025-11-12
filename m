Return-Path: <bpf+bounces-74273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A9C51173
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69A31894CE4
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BD2D9EC4;
	Wed, 12 Nov 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFI5caB4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkDUnUz7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89B2D5C7A
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935826; cv=none; b=KuhwPG0KiNZ8lAo872wAAgO+uWhfjMOpKcY70xTgW4OkBQTsNP9UXZuc0JDYwY4dWQaePNJItX9w1tDnDX1Z1GEH1sADJTuIQvV2Qij2jCXeYfcyXe3p+mFLr874zn6JxSrkjckngejNVXLIA9eVZqPbxgddLS9XGRh27ASVt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935826; c=relaxed/simple;
	bh=JTlKFAdSpSYtkGgowbMf87xomdCB6p1qfRhGFqHkUZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoljkLIbLLQeJkbg24sIuawU/MxrigF3n28ZoH1hVveSjXkiemvng/12me0Ja10lqIbpy+5eHrZv/M9lgWzqDerO36Ja3sDikJ2TMDvitVEJGk5gy6ME0YgXDijjXqC1lAgIMP9X73e5rWCEYc8N0MCYUvdDZ9BfgL+PTqHwtHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFI5caB4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkDUnUz7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 09:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762935817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6yTLXAujTwODMqnstReI7YpfOFnf85bRU19SPZ/3mY=;
	b=GFI5caB4fpYWU4iF2azJZ/l+cuocJcXSyspcVD5SOCR3wgo+9S2RxSEoc53E6+CgEI2XAB
	MXJeLFUxtXRr34PywoUaHfxW4TMBOilrKL+VCkSMfTx9Z++J35Js0ehOcyw+imQ3+SjeKe
	J6Cc7Q+0Ubz1dAV2c1NcxN8iI9U4eR0rxFfi8s+mSkVbuD5j81DcLrvsSpzWUgkUbLNiyn
	F+DQ4ce7OS28vCd/NJu92a+hBiZXcYBYjQOJehkH6Ikli6ldu22/ezEJx3QARKPaHWP2b4
	J/N0A3C88IJh3T/cEMZv74IGxtNKpfiBV/CkpsS4YmVY8RpGarj30Bol0dhOVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762935817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6yTLXAujTwODMqnstReI7YpfOFnf85bRU19SPZ/3mY=;
	b=AkDUnUz7zhCsPYLj1/7L+H3bsLB1R33nbLq176/VzwwY9cP2BF02yV480NGHMbt82ATnqP
	rfEgXUzG+X93W2DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Message-ID: <20251112082335.cCk-pD9W@linutronix.de>
References: <20251111170628.410641-1-chandna.sahil@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251111170628.410641-1-chandna.sahil@gmail.com>

On 2025-11-11 22:36:28 [+0530], Sahil Chandna wrote:
> The bpf_bprintf_prepare() and related helpers (bpf_try_get_buffers() /
> bpf_put_buffers()) rely on a per-CPU counter bpf_bprintf_nest_level to
> manage nested buffer usage. However, when invoked from different contexts
> (process, softirq, NMI), the nesting counter can become inconsistent if
> task  migration occurs between CPUs during these operations. This can
> result in warnings such as:

Not to be a nitpick but different contexts as describe above is fine. If
a preemptible task is preempted by softirq followed by NMI nothing bad
will happen, it will work as intended. That preempt_disable() has no
affect on not getting preempted by a softirq, hardirq or NMI.

The problem is that a task can be preempted by another task. The BPF
program is limited to a single CPU (so counter will always be
incremented on the same CPU) but you can still have multiple tasks
on the same CPU asking/ returning a buffer.
The first task is using slot 0, the second one slot 1. Still works (by
some definition of works since 1 can return the buffer before 2 does and
ask for a new one which will be slot 2 which is still in use).
However if you add two additional tasks to the mix then you will exceed
the available slots which leads to the warning below.

> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers=
 kernel/bpf/helpers.c:781 [inline]
> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare=
+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>=20
> Having only migrate_disable is insufficient here to prevent nesting,
> hence add preempt_disable()/enable() around buffer acquisition and releas=
e.

I prepared to following while adding the local locks which we agreed not
do:

    bpf_try_get_buffers() returns one of multiple per-CPU buffers. The
    "nesting" level is counted based on invocation to decide which buffer to
    return. This relies on disabled preemption in order to not get preempted
    while a buffer is returned and to have the buffers returned in the
    same order as they were requested. Without disabled preemption,
    multiple tasks can be preempted while a buffer is acquired,
    eventually exceeding the limit (MAX_BPRINTF_NEST_LEVEL) and
    triggering the warning.

    Multiple buffer can be acquired by the same context due users in
    different execution context (task and IRQ). It can also happen for a
    single context if after a buffer has been returned and another
    buffer needs to be returned due to an event (such as invoking
    spin_lock()).


you can take it or leave it. Here is a
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

since the change itself is okay and does not lead to any problems as far
as I am aware. I just think the description is not accurate and does not
describe the problem the syzkaller reproducer triggered. I leave to the
maintainer here=E2=80=A6

Sebastian

