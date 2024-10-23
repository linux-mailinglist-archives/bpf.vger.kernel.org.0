Return-Path: <bpf+bounces-42867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E949ABCF3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 06:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654D51F23484
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C0139CEF;
	Wed, 23 Oct 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVHn/X16"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B946136337
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658353; cv=none; b=J2vI3e6vk1iYgG6W5GzV0pTuu9eR7kQrxFMlmA3rp+tiDxhAIaa1/oschgzF4J54gQyyniNZlNgZhhMFx6fAU3z4gWHBIvVAjLLysxavCjiG//xNAaDbJKCdhefk234U8NX/tRgOhNMJ0GTNaMDj9V8lca26sN3pjk8eNb8az90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658353; c=relaxed/simple;
	bh=19W/WGcextcNMPD0JtnkpPdA0ejILwtafAZ79zI8QCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWV/FVi2Rl6er8vEaChphzZ9Jdi703qiYf6rCons1QZSTUAYiLNv9nDvsV5vhgWUEXyd6Ok7ST71DoQGvHfYCsixvvD+PyRqK9IfFyM1hjVSGuB9IlitWqrBIt5KzCmTk/x50fLD/69x0DFjCytSFT1rofd+W1bwojnlE52FI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVHn/X16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D04CC4CEC6;
	Wed, 23 Oct 2024 04:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729658353;
	bh=19W/WGcextcNMPD0JtnkpPdA0ejILwtafAZ79zI8QCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVHn/X16JuHyPmojkxEOQ1+d59dnUooGntN2/xglzadaSZ++QXBQvEay/MST0E07X
	 L0vKhnY5sIIHPcgxk1D5/LFgOX4Oc9bNeP+TPdpb9g5Y1km0AkOC7I67F88Yx1YJbB
	 qA6eBMaxFVS42ztIJsbG7zvrdr+8+NTZREu9VCiU26wNv+b7yk59rtotOzXyuibJEM
	 G8FhtrorDOcswwLkuq9kMoTtzoUM6c19fefqh2nWnm7Cd24PflYWJlGC9CakBsVneU
	 Ve0jcPKsdAeUi5nWAr2qrtmZVidPArtbAB+eyDmluF67xKSxpfkNFdLzvyKrkHkqrw
	 Vw2tJXRIimGuA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] selftests/bpf: fix test_spin_lock_fail.c's global vars usage
Date: Tue, 22 Oct 2024 21:39:06 -0700
Message-ID: <20241023043908.3834423-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023043908.3834423-1-andrii@kernel.org>
References: <20241023043908.3834423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables of special types (like `struct bpf_spin_lock`) make
underlying ARRAY maps non-mmapable. To make this work with libbpf's
mmaping logic, application is expected to declare such special variables
as static, so libbpf doesn't even attempt to mmap() such ARRAYs.

test_spin_lock_fail.c didn't follow this rule, but given it relied on
this test to trigger failures, this went unnoticed, as we never got to
the step of mmap()'ing these ARRAY maps.

It is fragile and relies on specific sequence of libbpf steps, which are
an internal implementation details.

Fix the test by marking lockA and lockB as static.

Fixes: c48748aea4f8 ("selftests/bpf: Add failure test cases for spin lock pairing")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index 43f40c4fe241..1c8b678e2e9a 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -28,8 +28,8 @@ struct {
 	},
 };
 
-SEC(".data.A") struct bpf_spin_lock lockA;
-SEC(".data.B") struct bpf_spin_lock lockB;
+static struct bpf_spin_lock lockA SEC(".data.A");
+static struct bpf_spin_lock lockB SEC(".data.B");
 
 SEC("?tc")
 int lock_id_kptr_preserve(void *ctx)
-- 
2.43.5


