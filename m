Return-Path: <bpf+bounces-40736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9898CD1D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE11E1C21497
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAA12C473;
	Wed,  2 Oct 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEUqQRYh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACC33EC;
	Wed,  2 Oct 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850310; cv=none; b=WnjK7z82em4kY6I7RzzTToXVmFAPqwBshI5SnU62NDwDSSCB0GVO9qyTCpp2w0A20U5f8Dq6o6SQ0v0JX86nLMNYFN2ZsDw8swzZ8Nhnf1J2rzM3GGeuG1E3VZDmz7jVlQrRX+GaDdFKCosx7cGyBiz60pIAVy4VsVb7ovlTC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850310; c=relaxed/simple;
	bh=lfSqdrDVW8IPHNi3F/V0jAnpEIiI+8S0zzzKbOuVd+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=chRPNxU2L8aqaTkJO0amNT/LpD1yzcr/lOxAy/QX5HZQXm7qzZIKdAyqew6KYDUKWQXV1jiTdXI8/JEAHN+Kn2lzteT82ZHKmZ47oNafIeGghSZ7+40XvUcFtmXVk1JaY8llhMDRfh3zLoEdTjWSu8LCycY7lsuwC/xM44hdGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEUqQRYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D789FC4CEC5;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727850309;
	bh=lfSqdrDVW8IPHNi3F/V0jAnpEIiI+8S0zzzKbOuVd+Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JEUqQRYhtLhmG0kbyPgXn15a60MSqxYYqUxlr4s8IGrlFCzPsTDmdGES8F6YGLVBF
	 Gn4Y8H9vydLDhJdnlmKRFOCqwsoVzBiIDJ9HHh5M8auwFJMbDRxnj8g2M9z6UUVwg1
	 HzmnYprSFS9dGT6d4Dz/YKuSGf5SfOPPcMr1ZUU9aeByG+/nQ8uUehwfiji7v4Rv/d
	 ruDa+wGg912Qdl4c5bpaBkNtbt07peSG+/4f9rOALAKqbiKRZump03XxHSEbaWjj7G
	 mVtR58YpYk8nkp4k9NlFMG+s0E1CAn4Yx6tovE83WdmZw16ntEIKaZD6YxOSkkQsOq
	 3ReksYWAqOLRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C061ECF3198;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Subject: [PATCH bpf-next v4 0/2] BPF static linker: fix linking duplicate
 extern functions
Date: Wed, 02 Oct 2024 14:25:05 +0800
Message-Id: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHn/GYC/43NQQ7CIBAF0KsY1mJgoGJdeQ/josCMJSptQBuN6
 d3FLkyMMbr8+fPf3FnGFDCz9ezOEg4hhy6WoOcz5tom7pEHXzIDAVrUUPNjsLYn7i89x+sZU+R
 0iS7zlZGkbeNBArCy7hNSuE7ylj0XsZyzXWnakM9duk0vBzn1P/VBcsE9yYqsX1ZQ2U3buINKi
 1OHEzrAnxAUSDi3kh4VmZo+IPWCpBDyO6QKpIGMMRrJknqDxnF8ADW1V1RbAQAA
X-Change-ID: 20240929-libbpf-dup-extern-funcs-871f4bad2122
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=lfSqdrDVW8IPHNi3F/V0jAnpEIiI+8S0zzzKbOuVd+Y=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGl/nrsE2N553W9zIStZe/L8KbO1w2rOWy5sWbFw5pmX/
 EkGDk9OdJSyMIhxMciKKbJsOfxHLUG/e9MS7jnlMHNYmUCGMHBxCsBEpvgxMrx8v1Z6n10he+fc
 RRP+i7LIH/xxc9q3L3MiI0tYixrqud8zMvwTj/4tE/+w6lu99ffPGalHrl58c1jov4mUa7brN03
 Jdn4A
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

Currently, if `bpftool gen object` tries to link two objects that
contains the same extern function prototype, libbpf will try to get
their (non-existent) size by calling bpf__resolve_size like extern
variables and fail with:

	libbpf: global 'whatever': failed to resolve size of underlying type: -22

This should not be the case, and this series adds conditions to update
size only when the BTF kind is not function.

Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Eric Long <i@hack3r.moe>
---
Changes in v4:
- Remove redundant FUNC_PROTO check.
- Merge tests into linked_funcs.
- Link to v3: https://lore.kernel.org/r/20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe

Changes in v3:
- Simplifiy changes and shorten subjects, according to reviews.
- Remove unused includes in selftests.
- Link to v2: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe

Changes in v2:
- Fix compile errors. Oops!
- Link to v1: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe

---
Eric Long (2):
      libbpf: do not resolve size on duplicate FUNCs
      selftests/bpf: test linking with duplicate extern functions

 tools/lib/bpf/linker.c                            | 4 ++++
 tools/testing/selftests/bpf/progs/linked_funcs1.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/linked_funcs2.c | 8 ++++++++
 3 files changed, 20 insertions(+)
---
base-commit: 93eeaab4563cc7fc0309bc1c4d301139762bbd60
change-id: 20240929-libbpf-dup-extern-funcs-871f4bad2122

Best regards,
-- 
Eric Long <i@hack3r.moe>



