Return-Path: <bpf+bounces-44139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB69BF68C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A56B22E59
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2F209F28;
	Wed,  6 Nov 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IueV2hAx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE6208204;
	Wed,  6 Nov 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921545; cv=none; b=i89O+ZddyivQqj54cld/guG/mbkpZv/Jh3biPa9yx+HdCrhBwJmEgwcQmN+lVAfwnPOAwTeISEBy5tUQQgWuIul+hLyg3cSzzfbHtxXjXWj1+w+pNKUTF7y0Pgb1luQ3gt5YlaVwBTUJne384hb69duC2jpkazJCXiED/Ich7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921545; c=relaxed/simple;
	bh=IRiCpI1LAj8gdXyqpxxNEdvHCy3pSba0EOUnJCNVx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcRRkdm6SbWzpCnDP7u07P1Ha0tCnghkbMh+mMFJ4nJT9ahQLwZexmGKluDO8Y6uOxJ3QP8o+UBqLCt+DrkrFlC1ntV8bfafJtNkBd+/E0jcGSVvOeXx8hFPWmcMWf+v+9uGtA/U5p2L8vn/zE0j0+wgDf1qz/vTUb+uXC+WlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IueV2hAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13FC4CEC6;
	Wed,  6 Nov 2024 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730921545;
	bh=IRiCpI1LAj8gdXyqpxxNEdvHCy3pSba0EOUnJCNVx8M=;
	h=From:To:Cc:Subject:Date:From;
	b=IueV2hAxOOeLGHIfDB/awnPMqygPKif/0VdbjeCVzO7UyD91GK/Yn+CWjK0Y9H2wH
	 w99i2ktG2SbfFIgILZiDp6McxmHIS4d0QJeV/zNfr+AGcJhAlrFdNYbvCh1URk23lf
	 nY9UCQcnpa0xVUK9HNxgl4/fOyu92L3m6cIsLf2DVVmt2bY/3yXMr7V7FELJqPP1ym
	 eEsmQUIQOQW4uuY1HBSieTnr64F3MAZIJ+/lGxdZdSnxoYXd6QGC9LnZuXDtmqEKJN
	 Tn7UR1D4Eg63nUO4MJqO1a4dIsmGP0CopeTL8WZ+qyb6MwE0j+Nhdtnu31C11oBRZO
	 BTxU3j+H3Ig+Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Quentin Monnet <qmo@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Abdurachmanov <davidlt@rivosinc.com>
Subject: [PATCH] tools: Override makefile ARCH variable if defined, but empty
Date: Wed,  6 Nov 2024 20:32:06 +0100
Message-ID: <20241106193208.290067-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

There are a number of tools (bpftool, selftests), that require a
"bootstrap" build. Here, a bootstrap build is a build host variant of
a target. E.g., assume that you're performing a bpftool cross-build on
x86 to riscv, a bootstrap build would then be an x86 variant of
bpftool. The typical way to perform the host build variant, is to pass
"ARCH=" in a sub-make. However, if a variable has been set with a
command argument, then ordinary assignments in the makefile are
ignored.

This side-effect results in that ARCH, and variables depending on ARCH
are not set.

Workaround by overriding ARCH to the host arch, if ARCH is empty.

Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/scripts/Makefile.arch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index f6a50f06dfc4..eabfe9f411d9 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -7,8 +7,8 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
                                   -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
 
-ifndef ARCH
-ARCH := $(HOSTARCH)
+ifeq ($(strip $(ARCH)),)
+override ARCH := $(HOSTARCH)
 endif
 
 SRCARCH := $(ARCH)

base-commit: 7758b206117dab9894f0bcb8333f8e4731c5065a
-- 
2.45.2


