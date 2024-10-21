Return-Path: <bpf+bounces-42707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D019A93F8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A60D1F22C75
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398021FF05E;
	Mon, 21 Oct 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GuqxPzZr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B131FF055
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552624; cv=none; b=auHbKtqqkOdnw/S6rtmsX/9exY6TX8+hw+byLNsoncRC7lscsF9zjeTBMRQnKdyPZj+lC+Hiwb69hAg6KPi2zZEoHsqU26BNrcLlX+2vywKbWwpRofcZ1Kz6dfjDGuDVbAv5PVtg1enDB/fDx8GAowISxBOrcogJwz7EEmglOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552624; c=relaxed/simple;
	bh=3YCoSDXnCZt16X9xdWeW/a+e27s7xG0fmqkr9ptV1c4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l6e2e+yl33peZiKTeRY56vv9aguvTl0HR8/QiN5o9e06gGtUmgdzEaX+hVHl1PG5w4F5YHxB/kP0Qw3NYMNjavUYeGAhHh7+9k32wRERWtiMTXei2NDeB5P6UqsqcHY44z76AbbFOsGWg1WeBmIpbKDnqYocHSZplzTCKzCwyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GuqxPzZr; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729552616; x=1729811816;
	bh=/WiN5iL5UMBiePcQ0NW/mqJFSHEbR+SOCOUOUW12EaE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GuqxPzZrCsucltUez5mufQ8ySZfA+1ABXCCgxDEHK8uZeoWS6BTmxe1iEWdRESb21
	 l4D7CWBneiR2BCmStDS8gA+sAKt8eLzYRx/10FH7LOXSzPx8/G2IhTcxsHS5HnyVVJ
	 hqELK9BDsbLPNPjCJyCPH4Ff1bs4MOr/8oAeOn6HL7JveJ7bNzRuC92tp9Q1I/aOkg
	 KhhJ4oPIeXRrIGzh4rzgY3BrTjzMx8Za8IE3qNx2fETF1zlpA6WY68kyp8HPBQNeB/
	 hmHDl0zGj+85AdXpJy88s5bRzmKGuy407rAXvk5RCTzc29uDOjlhvq7V8S1B7i0W24
	 Idhm6K0C1IZFw==
Date: Mon, 21 Oct 2024 23:16:52 +0000
To: tj@kernel.org, void@manifault.com
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com
Subject: [PATCH] selftests/sched_ext: add order-only dependency of runner.o on BPFOBJ
Message-ID: <20241021231648.921226-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c0dc43686d32b48b2efc10ec330f7455db15c59b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The runner.o may start building before libbpf headers are installed,
and as a result build fails. This happened a couple of times on
libbpf/ci test jobs:
  * https://github.com/libbpf/ci/actions/runs/11447667257/job/31849533100
  * https://github.com/theihor/libbpf-ci/actions/runs/11445162764/job/31841=
649552

Headers are installed in a recipe for $(BPFOBJ) target, and adding an
order-only dependency should ensure this doesn't happen.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/sched_ext/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/sel=
ftests/sched_ext/Makefile
index 0754a2c110a1..57739563d334 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,7 +185,7 @@ auto-test-targets :=3D=09=09=09\
=20
 testcase-targets :=3D $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-tes=
t-targets)))
=20
-$(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR)
+$(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR) $(BPFOBJ)
 =09$(CC) $(CFLAGS) -c $< -o $@
=20
 # Create all of the test targets object files, whose testcase objects will=
 be
--=20
2.43.0



