Return-Path: <bpf+bounces-70136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2ABB1932
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DA819260F0
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7226F2BD;
	Wed,  1 Oct 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="w82lRbh5"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990B34BA4C;
	Wed,  1 Oct 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346292; cv=none; b=XZvbcLPd3+Umgv8NEvn/cv2otIIRemh/4yrLl7UG135+dLiDwbv3A9W54wV9/ynAXhT553F3sDxlmNqOMzMWWx/Q9Pk26tR1XyEwgkajari/fFfZmfvACSdxLppaSpnRxKe7C/4ih+4X3IeEoygB+8A5z/W1b2YvZHY8vSdHcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346292; c=relaxed/simple;
	bh=b+/c4W+RzknpNkDay02LrrvdC3AQVy2QaY78zoLH9j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l59Qe5+YqgxKiEQ86v+99vtgEw3T+ZevewcNvGUt/6jkeNnglWkgHCid1k9Y94rvkH7q83kpQGFmCnHbeTfVwrZL0Bu/nJyhTEMWJlE+wVBuri/t6QpRHeBxXPUQTKJsoNuNqH03OzvnBClPEijWMOkX9Kozg1xFkDaFbCqnEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=w82lRbh5; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ccPpQ1p1Nz9t4r;
	Wed,  1 Oct 2025 21:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAuF+EBwynVPrSFcy+C7ZyNzvXJyx6NhxkrvAlXADY=;
	b=w82lRbh5afDLQ+JNGE6UtKEHkuLIuz0yn7SYzpP3knfiH+cIMbejEkn7wTX3MbW/dFaJqX
	qw6TiNuJBbD6kIF/CJzp5RMpA44mvWSXLYSq2lDsESyh+B3Cl/3AdHQYUVOpbpYsT0P3kR
	SshXFK7FQkDGPGAboRpkVjpYiwa58v6oTqvOv6GGgxVYcGhBbgXzmD8YckgvE64ExBJ0Se
	n9zVNICgW7ZpctHGDYhCOqLqPGip8nKNnXJgUJdjfLb0PvqKIQkTJBo/lGXGEahT01+gcO
	pRrTJESH6HpWC5p43ZRllSbJx+A1rGUsIbFawBwjrKUdYPo+U0Z8abAQXXNFGQ==
From: Brahmajit Das <listout@listout.xyz>
To: listout@listout.xyz
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 0/2] bpf: Fix verifier crash on BPF_NEG with pointer register
Date: Thu,  2 Oct 2025 00:47:37 +0530
Message-ID: <20251001191739.2323644-1-listout@listout.xyz>
In-Reply-To: <20250923164144.1573636-1-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a crash in the BPF verifier triggered when the BPF_NEG
operation is applied to a pointer-typed register. The verifier now
checks that the destination register is not a pointer before performing
the operation.

Tested with syzkaller reproducer and new BPF sefltest.
Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58

Brahmajit Das (1):
  bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer

KaFai Wan (1):
  selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP

 kernel/bpf/verifier.c                          |  3 ++-
 .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.51.0


