Return-Path: <bpf+bounces-56057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E050BA90C32
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD4D3AC659
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B4224B1C;
	Wed, 16 Apr 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2xsbCnQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B32224220;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831267; cv=none; b=aK7y5i64tZIcAY/fESbOEqaCccBBtpct4n7QAjbEqTNr/H0ezNhMQFspzRzYuAPF96UlvnVFd6eTuwqEugAiHQQs8uvhYj3opixOhQHqXXib5cAAHop/tKiiJDjjmm/0j1xd8rDV7SchSpmK8aRE5yc1h5O2IAe3hzVtPb6KOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831267; c=relaxed/simple;
	bh=JdyDlfKzAPlsDcZj5fiWk0k/AOqsgufuJ/1KexX8/LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZimrgsab3ij6IVM9oVizR0L3mzrw4FXnLaZYlJcFeQ3/WE6oq8uD/ubNqVSqpbLC2rlfHg35lPfsROH9SlXYpbngR1lfhmivA5v8KOc7Kn9PNgbLwMhior3dpRtrWLH7HDeuRzAaCvvW/OejPlba5oB7yGg0vpGaolYIeW1yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2xsbCnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B6AC4CEE4;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831267;
	bh=JdyDlfKzAPlsDcZj5fiWk0k/AOqsgufuJ/1KexX8/LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R2xsbCnQp5oKl5os8qln0RvXnzCl8wUb48b2MKlGoOV3zVptGHpCkaeGZ6VIl+4dL
	 z2BSUJoJm/GS/YFvpxNBfyseCBjsCKXsaJXoM61Va1GB4MLa1EFZd+lFc78z3pbn9T
	 IwpPMk5QeGefKJOLAxthuCR1lC/yhR1Y6XWT/Krj1zNfo64tFp+mk/Z38Zog8f1c2g
	 KTP484vdEl5V/FDLtCc5Y40BJwknoVNh+8Tt7dhyvWGyNrRM56AHVY3gErxqnBqqb8
	 m+Y2F2qtFYpTpZ3vcXyqw50YpKgAohqycWCHLpno1dbrK2n9JrGMQ/iCXfV9JU1CD8
	 LwNTsjUBmx8UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDAC369C7;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
From: Thierry Treyer via B4 Relay <devnull+ttreyer.meta.com@kernel.org>
Date: Wed, 16 Apr 2025 19:20:36 +0000
Subject: [PATCH RFC 2/3] dwarf_loader: Add name to inline expansion
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-btf_inline-v1-2-e4bd2f8adae5@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: Thierry Treyer <ttreyer@meta.com>, acme@kernel.org, ast@kernel.org, 
 yhs@meta.com, andrii@kernel.org, ihor.solodrai@linux.dev, 
 songliubraving@meta.com, alan.maguire@oracle.com, mykolal@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744831265; l=1535;
 i=ttreyer@meta.com; s=20250416; h=from:subject:message-id;
 bh=GxSE1f8+lYV3zrhaWnIMYQRjICGOXJevdGgMRZAvrV4=;
 b=hFKyHffdY9Kr4yAK5v4Mo4gSpBq0a9f1W8sNS5wWj//EVX9husdcweWFfcGUHpYs/TXgpJ16d
 Bw9nKFhKN5LBueMspRyHu1ZwbRwtbiypjIQW2oIM6KdjNqdguG1bfXy
X-Developer-Key: i=ttreyer@meta.com; a=ed25519;
 pk=2NAyAkZ6zhou7+5zqr5ikv3g5BfFbkznGzvzfKv1nbU=
X-Endpoint-Received: by B4 Relay for ttreyer@meta.com/20250416 with
 auth_id=382
X-Original-From: Thierry Treyer <ttreyer@meta.com>
Reply-To: ttreyer@meta.com

From: Thierry Treyer <ttreyer@meta.com>

Add the name field to inline expansion. It contains the name of the
abstract origin. The name can be used to locate the origin function in
the BTF.

Surely there's a better way to find the btf_id of the original function?

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
---
 dwarf_loader.c | 9 +++++++++
 dwarves.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 24ac9afceb3793c165d3e92cfdfaf27ab67fd4d6..d7a130d138a65bad71a563cf3d629bdd7b9e6c6f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1376,6 +1376,15 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
+
+		Dwarf_Attribute attr_orig;
+		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
+			Dwarf_Die die_orig;
+			if (dwarf_formref_die(&attr_orig, &die_orig)) {
+				exp->name = attr_string(&die_orig, DW_AT_name, conf);
+			}
+		}
+
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 		exp->nr_parms = 0;
diff --git a/dwarves.h b/dwarves.h
index 38efd6a6e2b0b0e5a571a8d12bbec33502509d8b..13b19433fe4aa7cd54ec0160c7008a33cbc17e24 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -809,6 +809,7 @@ struct ip_tag {
 
 struct inline_expansion {
 	struct ip_tag	 ip;
+	const char *name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;

-- 
2.47.1



