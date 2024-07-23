Return-Path: <bpf+bounces-35430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9B93A869
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB531C2283C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86444143C52;
	Tue, 23 Jul 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Us+kZ2xS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F013D898
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768270; cv=none; b=PM3aAyHZ8S6YHriyAfq3GJ8yyrkaQADY8HB1HkICTuMHWiAQhfTEZddZsKUttjXrzD5KkW7MHNeaZfzhsFmiLyyOW+l6Ss5fLIkXTPmtE1LtorcRtUI7LT6rLkRulO0/ivO+bidrr58kjtDHs3v+Gb+b00iNqAzP1WNmAqNr3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768270; c=relaxed/simple;
	bh=qJF9t3LM2XZNIN2N3llnIBuEj+N30FLc4tG274MyvAs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YkBqu53qxvpRhq1ol+SwFdToEXkAo07X92j1hG13Rl8bJTG/nWHbZU2qPqS9oxGHPf3YpTXZJdg6uGvwfv//mxERVSNbUJQMC+eZTxV15IP8Kc2CEcCxuFTFPpbkDB3QjzeFV2MffzENV+q1ejHsL1165ZcHTsPhlVA13X8L6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Us+kZ2xS; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721768266; x=1722027466;
	bh=F6mFX5rcgQkfE22vPi1fwvy8qn71uyYUKftItrf2q6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Us+kZ2xScOy8+76kswf3Ebva7OEHuIk6NSSFyiDy+p3RCXeCYhQPFxtC+hbLUVqy3
	 uuyk5vqBrlt5azf8konwgmllr7gYEyWnoBbk2nYFa0bpNhDDNJ1RgLfVYJqjDoqMNi
	 OagQXsPWGG/vnb/l2KSGdG2Jg8RF2nH4YLos6Dz1+eP8tCkNQ48rAO43mp3+4h6JFm
	 DnO0+EphF+JVNeZzeqrFby0NBGwxs4+JVbEIxVnHqYHGWPcSnc81Y7f8z2yq/DdUe5
	 j64UgT+gBof+twu6oMfFiHyh0LGfUxOfAbV0WWZkTp7OMkUP/TVm6+fmDDBnhXXv/5
	 s2CSCEUUR7SvA==
Date: Tue, 23 Jul 2024 20:57:43 +0000
To: bpf <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: make %.test.d prerequisite order only
Message-ID: <yyjJRl5LODbI4-FseU0wIP5e4ik0zAy7Sy-5eGwrzG_UanI8rwWlQPfXAFnn_27hoZFogoUHRSWxFsLk7hPr0b6P5TZ3cRrM30_ggnu555M=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: fc2f97e2c96d7c644e3a5f70cc3a1f17c910b249
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

%.test.o should depend on %.test.d order-only to avoid unnecessary
recompilations due to compiler dumping .d and .o files in random
order.

Link: https://lore.kernel.org/all/gSoCpn9qV5K0hRvrvYlrw2StRntsvZcrUuDfkZUh1=
Ang9E6yZ9XJGYDuIP9iCuM2YTVhSEzEXCteQ94_0uIUjx_mXwupFJt64NJaiMr99a0=3D@pm.me
Link: https://lore.kernel.org/all/FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnm=
T2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=3D@pm.me
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 74f829952..4bcb1d1ce 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -596,7 +596,7 @@ endif
 # Note: we cd into output directory to ensure embedded BPF object is found
 $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:=09=09=09\
 =09=09      $(TRUNNER_TESTS_DIR)/%.c=09=09=09=09\
-=09=09      $(TRUNNER_OUTPUT)/%.test.d
+=09=09      | $(TRUNNER_OUTPUT)/%.test.d
 =09$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
 =09$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
=20
--=20
2.34.1


