Return-Path: <bpf+bounces-58506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A4ABC8C3
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798B81B63A72
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61572219A7D;
	Mon, 19 May 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpT8/Vlb"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717F1A3142;
	Mon, 19 May 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688262; cv=none; b=BEhrzjXp6Pdhvz9w2kEmHQGvrH9HeTegyhUaLR8aO84D1hAxi2x/T3aD5pjHadERBSoHC8FmebN5sGqOPcCDqR8NRwVPVpclMLCY3udlsrI3TdcJ2LCtiCKkmKuRTBOVyCGzDyAJb/ofSjleCPNM+qd7dxQ2aGr1oPaVoRN5JNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688262; c=relaxed/simple;
	bh=ZGWrMzvU5zj2OJl0cQ+YUJDJ0rf2KWZdYa/+DN78Skg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaXzJQQV8qZ2sr4Q9gZ+1xsGbLWq1mPa1AL9ykXDsTe5PdG0q//y62ARDAnl0IFdp2fnWasbrBAl27nvYGyXRGVkn29wCbErNZy/lV9Vo9XhQ2ovh/+RWGF0at+eOKK9KFyzIJ/7S0rziOXN6lTInt/mI8ABYV9wajPPzrWIiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rpT8/Vlb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PsrBI3w2ZBwaYFa9maR6+A/7d1O7dN06m/BSAIgI5Yw=; b=rpT8/VlbLRN9BNi40bZL7bo19S
	/nO/O8uvq0XG30xsEeQaSWp1zWO1AIje12qrdvXba9qgyugANCh2Qq9S9ameLahr2ZR4sCVBhM7bR
	d+j6gZc3AxSPAA1KsElhEa4rRXcYLtz6eqew69OSwzvl6yAKgkTbWV0xg7AB9d8yrRVhO9xBrjvuT
	GbQklxZAiF8cAFgIFWLxUVgzfLKmBxkSyTSi09TwL+RTUpIKdKzB9woJYTZ9tkHg/ULfNM7BihqRU
	csvOJ6ZIaggM9VDwXC7fCuaHbXlunnL785MLRuXrnoz7h9xgqqJLpKytzvt1kZhS5ejOiGACjxafj
	COJaJXLg==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7YJ-0000000ASsi-3Pso;
	Mon, 19 May 2025 20:57:39 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org
Subject: [PATCH] bpf, docs: add indentation to make the bullet list work
Date: Mon, 19 May 2025 13:57:39 -0700
Message-ID: <20250519205739.180283-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a docs build warning and make the formatted output render
correctly as a list.

Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]

Fixes: 7220eabff8cb ("bpf, docs: document open-coded BPF iterators")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
---
 Documentation/bpf/bpf_iterators.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20250516.orig/Documentation/bpf/bpf_iterators.rst
+++ linux-next-20250516/Documentation/bpf/bpf_iterators.rst
@@ -52,14 +52,14 @@ a pointer to this `struct bpf_iter_<type
 
 Additionally:
   - Constructor, i.e., `bpf_iter_<type>_new()`, can have arbitrary extra
-  number of arguments. Return type is not enforced either.
+    number of arguments. Return type is not enforced either.
   - Next method, i.e., `bpf_iter_<type>_next()`, has to return a pointer
-  type and should have exactly one argument: `struct bpf_iter_<type> *`
-  (const/volatile/restrict and typedefs are ignored).
+    type and should have exactly one argument: `struct bpf_iter_<type> *`
+    (const/volatile/restrict and typedefs are ignored).
   - Destructor, i.e., `bpf_iter_<type>_destroy()`, should return void and
-  should have exactly one argument, similar to the next method.
+    should have exactly one argument, similar to the next method.
   - `struct bpf_iter_<type>` size is enforced to be positive and
-  a multiple of 8 bytes (to fit stack slots correctly).
+    a multiple of 8 bytes (to fit stack slots correctly).
 
 Such strictness and consistency allows to build generic helpers abstracting
 important, but boilerplate, details to be able to use open-coded iterators

