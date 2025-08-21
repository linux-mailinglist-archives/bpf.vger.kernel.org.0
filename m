Return-Path: <bpf+bounces-66200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B156EB2F893
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8A1CE3017
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9B3218C1;
	Thu, 21 Aug 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwOoEsH8"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F3320CA1;
	Thu, 21 Aug 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780170; cv=none; b=s12CtjwHAzIFSgWnrf4U9Vm2w5aFZdqooRy4wGwn4aGXrO/X5aeOp0gXSvuXxHpkq24BqDQlrKnCnrSJxOTFisJGoakED6E9tsBkU3fh+xg3Hx05N9rS3lrGco8VCz2a+f2XN9u8BKnDqNg9QXRmnk/xuDqegx9XomBDmf2FyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780170; c=relaxed/simple;
	bh=LTXvhMrfCGOgbq5T8Pqy50MbvA6yjBjsqVMrWM2yCtk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OQ8QFVpzNAFg22OhOW42LJOgzGEy3L0Zl7gyWAn27rMFG2YUnFA3Vk8x2CJPPRN++UDzib5ER3kPPVWYu9VrSwZk+BnrKGcjRfnWhcoZEXY8zf3oRVNwNa7FiP63hPn4MAtgfb5h03j2kgzE0kHsiXufe9KcDAJdsa9qrOpJfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NwOoEsH8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZDd/E/eJc69eCEhmO/AHlbIPPmEIdZCQHwtjHHkjtw0=; b=NwOoEsH8paZXLhJUTOq02r6ayE
	2Qj8TxefHp2IMw9CwjwYeP6BREMPwmIUEqkfeCRtjRmbL5KP5W/VECgS/8cQRYhlVo077jcj9Q33b
	ZKLBDFWHZqfRGnqYPeQj2XsMX4ryD4irxJHDksUfnENdz93i99gxocTeHa5Ifj4Hpd1E87oTKiqVv
	tacZc79ZOqv8I/lB8H6nFHl1jUOc1IAsx9XOA3yv2pX3qDZK3vo/PuYXyCfYrLKuKGKHjcGJGnM/4
	u2cd8xDht9CzG/qsODn6GtfE/8Vr/qqjxcZS5mqepUJauaJg5NoGY5urv+VgLa5XJvr8fQ6Sk/Is6
	XFDBralA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4co-00000000Y9N-1fjm;
	Thu, 21 Aug 2025 12:42:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 842023002ED; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821122822.671515652@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jolsa@kernel.org,
 oleg@redhat.com,
 andrii@kernel.org,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alx@kernel.org,
 eyal.birger@gmail.com,
 kees@kernel.org,
 bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org,
 songliubraving@fb.com,
 yhs@fb.com,
 john.fastabend@gmail.com,
 haoluo@google.com,
 rostedt@goodmis.org,
 alan.maguire@oracle.com,
 David.Laight@ACULAB.COM,
 thomas@t-8ch.de,
 mingo@kernel.org,
 rick.p.edgecombe@intel.com
Subject: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi,

These are cleanups and fixes that I applied on top of Jiri's patches:

  https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org

The combined lot sits in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

Jiri was going to send me some selftest updates that might mean rebasing that
tree, but we'll see. If this all works we'll land it in -tip.


