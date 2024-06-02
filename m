Return-Path: <bpf+bounces-31172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FC8D7934
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5962281A00
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA31811F8;
	Sun,  2 Jun 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="svwa5Qta"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A78060D;
	Sun,  2 Jun 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371700; cv=none; b=JPXgObCUtOqBGd6dx8iaVdzzPTg9Y/dZdPmZ/253pjqiEnOZvpfZqr2nVGGzQXF2c363Aov6V9pjXIKd7xRPtvhg0fosyvreiTPv4d7+0CKxvfhgOlvmaNtyG1AwxpZdjMy7LUbUWnznh7QH4czBF0M2Mr5ZRqWZ3OrSVQacMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371700; c=relaxed/simple;
	bh=kQvJvtQkbytKL8eBkVTemEwkHweoymD3c2FocRBrZ9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBr1pbCQYMHXm0c6MXq4TN52rSxfSRdMLmmA02+wINEq4qK87tigEmLBOR2XNHoL42Z80rlv13FWASSuKq46F0bJoZUb6FIlOa/IEX+RjYyEQL4moVA/MyXPSV7yNVffDqjNAKatnVF2CsBtFJAYk9HfG3mjd0ZbNpab54hI0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=svwa5Qta; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zX3TyGNSYngLo35oMux7SV/aojpQ1E9+PViunZCVohw=; b=svwa5Qta00o2kyN4
	3uRn8Ly4fw+nptaTiWOox80ilOIj2cKnVu2AjfUwF0iBbseiH0pyWtsZqmT3/MS9U/lgDBJacrTgw
	de2+ig3M/uVRlroSQ57wFR7+3xOiX108CBtC24XUzLtR57XDVnuEaELEW1WXtZEg4/aDFrBV7a97f
	RJj9cBdoOOg3NzWKJujDxcsAaohD062lZE6RAjmkGaYQ74CF23r8mmtUwKYrE1Mv5AHGG1q5R1mXr
	wid2ZcXbpWO/XUxsd7b9ohu/OtKrMr6N3ZCKZ8sPUEMnXh6wjOqJVS0cldPVqYBtzMa8l8rLjDK0l
	wRutKtPhvzQ45rTtVA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDupS-003r31-1A;
	Sun, 02 Jun 2024 23:41:34 +0000
From: linux@treblig.org
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] selftests/bpf: remove unused 'key_t' structs
Date: Mon,  3 Jun 2024 00:41:11 +0100
Message-ID: <20240602234112.225107-3-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602234112.225107-1-linux@treblig.org>
References: <20240602234112.225107-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'key_t' is unused in a couple of files since the original
commit 60dd49ea6539 ("selftests/bpf: Add test for bpf array map
iterators").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c  | 6 ------
 .../selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c     | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
index c5969ca6f26b..564835ba7d51 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
@@ -6,12 +6,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-struct key_t {
-	int a;
-	int b;
-	int c;
-};
-
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__uint(max_entries, 3);
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
index 85fa710fad90..9f0e0705b2bf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
@@ -6,12 +6,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-struct key_t {
-	int a;
-	int b;
-	int c;
-};
-
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(max_entries, 3);
-- 
2.45.1


