Return-Path: <bpf+bounces-29712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CF8C5B37
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CF9B228FC
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779D180A79;
	Tue, 14 May 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnsJnq1R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6F53E15
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712004; cv=none; b=izVUEpWOASEVSkcOXjVNYFwJKAGBf71wZJjMr50ImZ3+xStXSGWlkvENZyIpn0HXCcJivC9VLRk7USzqhUzl7mlGfTYtad43iT7TErmjAlx9+09QOEiojVW4iW4yjz0mp41mbaNmx4Sb7YkafS3J5bW2xRTCkbaGKXTVL7ksyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712004; c=relaxed/simple;
	bh=txzCHZoApIkJEuQWOfHuwwS8egDa47yTHCmqn1li7cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SO5kXx7j37nvlXNPRLuaDUbTSHhnFTfJL0bCTl/KyBqTnvrQC/ESnF/E2K+fYN8ILHTtroaCiWlae8skwno1qRPqM+sg6p/KrzDN7gr++hCO3/RrssWCghUsDlvIXENP1FHzLd3IKKwVblapM3DtDKPwsUOHOzPr+IvBJoYPSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnsJnq1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB15C2BD10;
	Tue, 14 May 2024 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712004;
	bh=txzCHZoApIkJEuQWOfHuwwS8egDa47yTHCmqn1li7cQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DnsJnq1Rb/Cgx/A//VH4MVTOO037n6PVFm1npIBX7w2eYV9ISp+JcV5Kh7GJaJsLf
	 qQD3y/t8w+uMI0iGXoOYZIxzNT3MlJu5Sv6q63jRmDpP1lVRb32XgzDyZs+atwvrjJ
	 I+tYTQAsSL9bgUEfckKjBF+aJtDYks/AIlJk/nTnlFS61DCCHj+ahrsQqpi/Hceewr
	 L6NpBH95QzHNA0YHgvdWbJODqYKsgtYm0VGyPQdeHuMDpED+uuN8xvI53Pi7vzuCk9
	 ckPsUZFyA6r3TbFvcN70ERGEtvXnGHq1f5sO8I3MTo4O5dYvPlJDp/ZPBc2/QeRnYy
	 rEQHw92C0uJmQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Zi Shen Lim <zlim.lnx@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] MAINTAINERS: Update ARM64 BPF JIT maintainer
Date: Tue, 14 May 2024 18:39:14 +0000
Message-Id: <20240514183914.27737-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zi Shen Lim is not actively doing kernel development and has decided to
tranfer the responsibility of maintaining the JIT to me.

Add myself as the maintainer for BPF JIT for ARM64 and remove Zi Shen
Lim.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05720fcc95cb..95beaf4dccf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3722,7 +3722,7 @@ F:	arch/arm/net/
 BPF JIT for ARM64
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Alexei Starovoitov <ast@kernel.org>
-M:	Zi Shen Lim <zlim.lnx@gmail.com>
+M:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/arm64/net/
-- 
2.40.1


