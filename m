Return-Path: <bpf+bounces-37992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4495D932
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18841F2283F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D8D1C871C;
	Fri, 23 Aug 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WXFz247O"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A1192590
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451651; cv=none; b=k+DEygkbxxeX3n8+qRw2VbnIiqDzPFY1BBbC6/dXkimMpcInklA516xHAenacwAWQGRL/ZVsVbIOene0oSxUyEVjiSFJWda5sRM3JbAa9tVP/VChq8nFhDKuOHwzAk7l2YbEFGmyRDgEoMjhwHLuP99blQDuQmVkjDJmZb8O2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451651; c=relaxed/simple;
	bh=C7x3Qhn8K0myir3LhvG6UkAeYGwz4eBOQ00P3679p/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SinWJytyPbwo5b3XiXXds2c0JUooQSG7BF0lZu6Zvj2FDmBu8a78/Urg3aAs/gbd/GYXDrOWc9nc2yXZ6G7IotB7VnGsayOCVqe6qa+PbyQQfcoH4bwFc9CEK3YhVFqa+YXjqAdRk4/+f+HpyMoBipW+P1CNkp6htRD5hHg+ZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WXFz247O; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4t2IOyFua47v4U1VF+xfta9q145bR/4r5FS//oQXIak=; b=WXFz247Oi+AtpzBupziUCpFAck
	74ppR+z/HZRoGKtVoL5oJH3DbM7DPVaCYE1mM8Jb0AxzvTZhz+XWjvHp4fOYxDliuEvX/u9SK0zkY
	wHambqzy7yQfitP7cM8SYxsM7d7H/zjH3kOjx8vZgQLOV9ngQ1Ja9h892+BZQuLAAOUlMSvAr1Qry
	wu0KONX1llv3hsexGQdTgQccxdSkTw1U7XdgvttRnssljQbRNNNKawnfnnAYlPN9+6URMQUJKd/xt
	gGvqq6UKh0rNXs/ve+VcGoMO9Ju1zJelQ1TKotHT34jCRTYzf1aB9yJkbTBzYGD5oxKgzNvajkQpC
	m2ZOhDzg==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shceF-000Fr4-Ef; Sat, 24 Aug 2024 00:20:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 3/4] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Sat, 24 Aug 2024 00:20:32 +0200
Message-Id: <20240823222033.31006-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823222033.31006-1-daniel@iogearbox.net>
References: <20240823222033.31006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

The assumption of 'in privileged mode reads from uninitialized stack locations
are permitted' is not quite correct since the verifier was probing for read
access rather than write access. Both tests need to be annotated as __success
for privileged and unprivileged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_int_ptr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 9fc3fae5cd83..87206803c025 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -8,7 +8,6 @@
 SEC("socket")
 __description("ARG_PTR_TO_LONG uninitialized")
 __success
-__failure_unpriv __msg_unpriv("invalid indirect read from stack R4 off -16+0 size 8")
 __naked void arg_ptr_to_long_uninitialized(void)
 {
 	asm volatile ("					\
@@ -36,9 +35,7 @@ __naked void arg_ptr_to_long_uninitialized(void)
 
 SEC("socket")
 __description("ARG_PTR_TO_LONG half-uninitialized")
-/* in privileged mode reads from uninitialized stack locations are permitted */
-__success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R4 off -16+4 size 8")
+__success
 __retval(0)
 __naked void ptr_to_long_half_uninitialized(void)
 {
-- 
2.43.0


