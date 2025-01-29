Return-Path: <bpf+bounces-49998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B324CA21580
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2BB3A5303
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5070155316;
	Wed, 29 Jan 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYa59KTl"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF643166
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110114; cv=none; b=D3JpY8MnNSc9pgmWrm74LNebWYph8ReXoLv6SEm/VHHpbuzP6xrVZRlxbfbkutnURA9CkxXWsTuViyJp+9zgP3nNckCIs0A30yp5s75UtCB1TAKJeHNLckKwZYyJXcysSqLCo2jdsmCmGX9WTWsQ+jXtGgZQSpcdp8oSIlCivR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110114; c=relaxed/simple;
	bh=X/S05OkSZ33+fQ/7xP3Oh5JzmgDDcSvL7PrkokrwUkQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=jk79nd027kbZ0TQ1EX4+/kkIXFUIGYu0Lq3K2Uzw44fXdrSmiZlfdDaxwM71uMXX+2fiJJk/3z2TVOXvgtvDqTFYmQlK7av0JExveiOlr2WFMkWnR0gMJHSThlMWGH+Ure4XJuhn5TYDZblZ7NsBVpwGHJwnVWNYjr5y2vmGGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYa59KTl; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738110104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I46f/Rd0R5jaB8YDQCGB0uktDK3SIZJUjy8XsFnAFJ8=;
	b=lYa59KTlcMO4mtuXDJ5xTOtZTOYg2ZluR7nKVLAJvjb2End6Jer0Db0l0377Is4blcHqsS
	RL5eNQePUWhvaYN8GnvIYmhlBTPj/OQmit1NYmXejTGPOEs4Ue1Z5njKwwb+SSno7VlEzx
	MWuZfenTp/tuLeMFqdmypl3g1wUVjE4=
Date: Wed, 29 Jan 2025 00:21:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
TLS-Required: No
Subject: selftests/sched_ext: testing on BPF CI
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi Tejun, Andrea.

I tested a couple of variants of bpf-next + sched_ext source tree,
just sharing the results.

I found a working state: BPF CI pipeline ran successfully twice
(that's 8 build + run of selftests/sched_ext/runner in total).

Working state requires most patches between sched_ext/master and
sched_ext/for-6.14-fixes [1], and also the patch
  "tools/sched_ext: Receive updates from SCX repo" [2]

On plain bpf-next the dsp_local_on test fails [3].
Without the patch [2] there is a build error [4]: missing
SCX_ENUM_INIT definition.

We probably don't want to enable selftests/sched_ext on BPF CI with
that many "temporary" patches. I suggest to wait until all of this is
merged upstream.

You can check the full list of patches here:
https://github.com/kernel-patches/vmtest/pull/332/files

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/=
?h=3Dfor-6.14-fixes
[2] https://lore.kernel.org/all/Z1ucTqJP8IeIXZql@slm.duckdns.org/
[3] https://github.com/kernel-patches/vmtest/actions/runs/13019837022
[4] https://github.com/kernel-patches/vmtest/actions/runs/13020458479

