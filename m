Return-Path: <bpf+bounces-35341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891793988B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 05:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E8A1F2262A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C113B79F;
	Tue, 23 Jul 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lVet5LpY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3713A86D
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704031; cv=none; b=NTlnUsgx+TZIqMjlne3Ty3fhOOFj3ByInREZ6DRflPUXOf07/lXKG/YWtOezoCOFJl5D1KILUpXE1sFbljuHnZfw3T8iYlLjH3JtgCCST2B0Yuci/dToaSg5f5cJgE/ImJBttaeGZkGzZLrskJmW4MiUjmtVHqlMQtehynuSIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704031; c=relaxed/simple;
	bh=q+HyuY/+CqqF3zyoDDDMjDJ46YSj3lP+Zy1BTU4CpvE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZABjes/O/YSA6ABM8DrA2O+OaGmCYz+0WrYh3hngIv3h9jnWIpN7z9+0YjRaZcOu6O92gagv8xZ4IJHonxOwTfeg0UsOfATeRPxWtqUbaR+gIr+ovqUYrwZyRr+KHWIcJZMrii5NH5UfhFDLy+aNXd64oX8SPw839FEkyLiamJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lVet5LpY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721704027; x=1721963227;
	bh=furQO7ae5cfHkUhDTfIDbxd1LUxnrc4sBS1bNKhCQBg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lVet5LpYC/G6LaLmVf7z2/sGruUZIWsFhQiRZyc/YYLjukIfCnsrC7DGnruuob1TE
	 +CIccn1sNrVgU5ggxdUEoDXuMCm+3EcFSPv3ZaKozGjP4F0taCVSoztQP2M1qiVlV9
	 j2QdSacQTxFuhRykJxjPe5l8DhnFcY/91VCW+hgmGcL+erCVMFuBKmD9LuvrBN0s0R
	 QnjeXTC4343elARKppL99jQkzJ5WW6863jfGJVz+6NljA87aNzvMe5HDt7gqCHX65q
	 WJt5cMnnuk6EcmLBhbdQUmCDzdhw28w4+TG4rkvGMJNrOWkKGLg8JT0zNoV4JjZnPU
	 MiPDie4SFlRuQ==
Date: Tue, 23 Jul 2024 03:07:00 +0000
To: bpf <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: don't include .d files on make clean
Message-ID: <K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9be0a444015311980f20456e841889651a23cb2e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ignore generated %.test.o dependencies when make goal is clean or
docs-clean.

Link: https://lore.kernel.org/all/oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQM=
p-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=3D@pm.me
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 05b234248..74f829952 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -608,7 +608,9 @@ $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.=
d:=09=09=09\
 =09=09=09    $(TRUNNER_BPF_SKELS_LINKED)=09=09=09\
 =09=09=09    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
=20
+ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
+endif
=20
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:=09=09=09=09\
 =09=09       %.c=09=09=09=09=09=09\
--=20
2.34.1


