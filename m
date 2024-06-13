Return-Path: <bpf+bounces-32069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1C906D2E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9AAB26212
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA0146A9B;
	Thu, 13 Jun 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g7/atvju"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BB144D13
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279606; cv=none; b=ZCY+kuW+4YkoNp65ObAZx283l+g8CUtDlCJRqB1BZd+V12E5zHcy4hGE3W46/2TP0V7bGP/nqzP6DHiDWjdiuFupiBdkxJmzfE42+Mx8wITtwRJV6jHHdf/4dDmHDt/AFIAPUp0zRvm/LIo/kFlDJ5w9r+56F2phITk8gbw0d8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279606; c=relaxed/simple;
	bh=lsx4ZQR9c13NLDr5rFo5a4uYKtnINLXrbRGOVrupKes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEDqyHduPY9+mMbLPBUVHBP5TwWuJhP7MyNskAboKd6wKHBksUNagCgJHHdZ0jqUf+FX9CHD76k5Or13ICd1AiIe6EPmkQFi/lpHArfvZ/2uXxtaYAzsrlutmQjuB8uSo4FARwBmi9WB8dReQdegVbv+f4QhvuBjolm414mjVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g7/atvju; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s+RvXUzCEtpLNZclqRnGtbwf2eq7+spSVb/AWgrahz4=; b=g7/atvjuvvyUWz3fs56wgCXa8V
	hb8c9HUnfKoNCsgBbUpqnokaAIM6cFsX6xfdg4J/4AFb4h4NnenBZKLqymgVxaJVlvGSuXTdmdCQ5
	L6nxq9TLGHMpauo9NbxLYt1Z3dHNrWOUTQbKTatZ3jlKm49m1/EWMRydwr3FO/0tyyj5RU4pifaWW
	T6eOCT8BWFYyEtE/JQqx2qkMHs8ookBvJZ8gBMTtsp8j5pTbx0MY4a8Kl13Y0VgEKDyQQQsxGhqjd
	Kb+3H3IXNqvC6dVC9oTfWYLh7vPuBm8S4ioXxonQCWRnI9VN5iVcBYMTMovJO1VaNEcA/XxKW6zUp
	QCSHFiPw==;
Received: from 34.249.197.178.dynamic.cust.swisscom.net ([178.197.249.34] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHj17-000G9k-DH; Thu, 13 Jun 2024 13:53:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	jjlopezjaimez@google.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/3] bpf: Reduce stack consumption in check_stack_write_fixed_off
Date: Thu, 13 Jun 2024 13:53:09 +0200
Message-Id: <20240613115310.25383-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240613115310.25383-1-daniel@iogearbox.net>
References: <20240613115310.25383-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

The fake_reg moved into env->fake_reg given it consumes a lot of stack
space (120 bytes). Migrate the fake_reg in check_stack_write_fixed_off()
as well now that we have it.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f455548ba46c..e5a0ba3bc38d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4549,11 +4549,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
-		struct bpf_reg_state fake_reg = {};
+		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
 
-		__mark_reg_known(&fake_reg, insn->imm);
-		fake_reg.type = SCALAR_VALUE;
-		save_register_state(env, state, spi, &fake_reg, size);
+		memset(tmp_reg, 0, sizeof(*tmp_reg));
+		__mark_reg_known(tmp_reg, insn->imm);
+		tmp_reg->type = SCALAR_VALUE;
+		save_register_state(env, state, spi, tmp_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
-- 
2.43.0


