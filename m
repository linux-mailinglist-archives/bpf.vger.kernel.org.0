Return-Path: <bpf+bounces-77218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F379CD266E
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7DDD301C96B
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 03:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B523D7FC;
	Sat, 20 Dec 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/5L02zY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179A347DD;
	Sat, 20 Dec 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766202503; cv=none; b=NVm3UoJkItQUtjwxFe1Ew5whntbIw7lAC+qd26S3eNckKgj4TXAanF4DdSBmuFkLlFvnt0s4H3hCXtycHC+T2BJAonj0AVg8mnw6Y82G6LF540nXOd/EBkQHwRw5mcWv6VjzP2bR/3mnW0XvJGZUwHW+9wQQipnZBgYpirm9edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766202503; c=relaxed/simple;
	bh=n0UjH6rxp4IB+pxWkaxiUb1+qekNAzowkS8FcdDjBcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ew1Pxov3mnQ4s6sqDK8XqTJh7Z73G4Yf7+RaTUNt7cPf0hcXnsQRAAzfiZoBVF6y3WIZoecGuRvRysHuB68LwD0nPfQE3AIRDtbrl36Bob4AQYbvyUgj2Bh2PIoE4CLEvoHqT75aAlWh+O+8EnWKJgIDCcr2wcYQ/Mk6LdN4F/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/5L02zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7620AC4CEF5;
	Sat, 20 Dec 2025 03:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766202502;
	bh=n0UjH6rxp4IB+pxWkaxiUb1+qekNAzowkS8FcdDjBcc=;
	h=From:Date:Subject:To:Cc:From;
	b=r/5L02zYRWhq/D/qH7z7fVzKyD0mIE1AMVEG9j83a2ituyweGtiKh4rDEwpClWmBX
	 fxF1sjTBGH2LwKbwdFsQT1+sQNb80GKOE4ddXODTaM9rVYaH7qgp0nhcAoc47Tra3f
	 9qMiClSWVV56YmxAV8gNVOCO/9Ve7AJfRjfeJjSA96GxZ4E6BTL7ivvhNh7ZSjQCwZ
	 SNOM423e4eH8Y1SfVYmizzgSMfKGqvpa4v4JZzcO8UU7IlhfjZFIsPrBdOkOmwjFTD
	 ZvU64cIhG1amdftbgy1yMxkkw/VONoZP2UADcDo3WTbRrv0u9IN6iYfcLsbFvaP1PE
	 zoypOG0xUh6VA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Sat, 20 Dec 2025 04:48:09 +0100
Subject: [PATCH] bpf: crypto: replace -EEXIST with -EBUSY
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com>
X-B4-Tracking: v=1; b=H4sIAHgcRmkC/x3M0QpAMBSA4VfRuXbKhhavIhdjB6cY7YyUvLvl8
 uuv/wGhwCTQZg8Eulh49wkqz2BcrJ8J2SWDLnSttGrQ0YXb7s41Fc8RiW6WKDgcEzqrrS1rY6r
 SQDocgSa+/3vXv+8HSGtNv20AAAA=
X-Change-ID: 20251219-dev-module-init-eexists-bpf-da2aa3577437
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Lucas De Marchi <demarchi@kernel.org>, 
 bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=4s4dcK1i6cCHvuwA2GQnp8g1ai+DeFSrtU/4w51RHIk=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBpRhyA9aBNfYYJVkENORThiOc50zRlcUVflTF4r
 2pfWfH2qeSJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaUYcgAAKCRBAnqPEHxlR
 +63BD/wIRh5TK+3OXjC5jdb+1rzikUD0jwdH68zqcdPL4S1NaSWobHWXdz5Pnj07JpCD5Z/fOe+
 yk4lExAH8bu33XowtZg6TMRGlgR0vQYWNP0vEWMg3Au7JzTJ+ylAkDQ3Vhwz1uxFL9LkyVkh0k2
 pxF9QlqA4aY8CnAzusRm2/FwS8Ytfnxi0HMnO2croFBfsdVx+XjR79J7JVxRoBHtwbl5QSUpS6Y
 1fCaVub8sPn1QZPBwVbwdIJFatGlj8mQNXkASyR2CQGv6acjpX5E5ylEXhYDae4CcNf379pLHYn
 m7fQIdObvmbjXfKiqOVprHFDNgj9iddsL+yIc/My+OOCe6s36dAcNkxcMUf+c/gKcb8teq+uiFu
 WYJ9WzSayNe6wqtZKhQrWbQyF6WoCtXtNoTUCN8TR5vwGlXNLoUyM8puiioQOL+7zWqivehHUoS
 Ca8lzp9aIqsUB1OiiOqyZOxQS2oFewKfikkCnrtpdzGBnLE7HHk2yaTJU57Lq78A25P7Y8Dc5nN
 xERE5nO+rkyKDCUU78lORno5lGobcoHiXCST2W3vZHDDrA+SUxchAoUkmAtC33TVUSUGTyd1vZL
 uTMy1mnUTWMcci6QF7W2cy2VFa0dnugaZSzEeoRa+V8DvhY1xtGEOEmvJVVbgGvHvc8AZBdMDq6
 23HMZWGcg7HllVg==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

The -EEXIST error code is reserved by the module loading infrastructure
to indicate that a module is already loaded. When a module's init
function returns -EEXIST, userspace tools like kmod interpret this as
"module already loaded" and treat the operation as successful, returning
0 to the user even though the module initialization actually failed.

This follows the precedent set by commit 54416fd76770 ("netfilter:
conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
issue in nf_conntrack_helper_register().

This affects bpf_crypto_skcipher module. While the configuration
required to build it as a module is unlikely in practice, it is
technically possible, so fix it for correctness.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
The error code -EEXIST is reserved by the kernel module loader to
indicate that a module with the same name is already loaded. When a
module's init function returns -EEXIST, kmod interprets this as "module
already loaded" and reports success instead of failure [1].

The kernel module loader will include a safety net that provides -EEXIST
to -EBUSY with a warning [2], and a documentation patch has been sent to
prevent future occurrences [3].

These affected code paths were identified using a static analysis tool
[4] that traces -EEXIST returns to module_init(). The tool was developed
with AI assistance and all findings were manually validated.

Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
Link: https://gitlab.com/-/snippets/4913469 [4]
---
 kernel/bpf/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 83c4d9943084..1ab79a6dec84 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -60,7 +60,7 @@ struct bpf_crypto_ctx {
 int bpf_crypto_register_type(const struct bpf_crypto_type *type)
 {
 	struct bpf_crypto_type_list *node;
-	int err = -EEXIST;
+	int err = -EBUSY;
 
 	down_write(&bpf_crypto_types_sem);
 	list_for_each_entry(node, &bpf_crypto_types, list) {

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251219-dev-module-init-eexists-bpf-da2aa3577437

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


