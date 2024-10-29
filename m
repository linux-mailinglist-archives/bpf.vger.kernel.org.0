Return-Path: <bpf+bounces-43404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E539B51FD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D18628550A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF82107;
	Tue, 29 Oct 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujH6iIGM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C4201021
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227251; cv=none; b=ChzGzhO+kWnvJed1JGVzLeOom8gC5ddump991Jx4CfV247CkeCzm0kyneyy25V3gUT6o5Rxd9KGV8QNOqbWb3/xu24cS1ZQkpUiwzCY5mHVfoxkC8StLoNGCbDgTV5PAs3FM/UOgXB+irUuxq6qp7rMBoBl6HAhD6vXJQF8gqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227251; c=relaxed/simple;
	bh=OprCP/Mtq7dPDByLdTHJ/UpDapEoEr7ui9de9UGNXjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QI6WKPgefhg3h+MJP8kBaJ2CicDQBFzE2dYyf4nJxnVVXHvEY3ydoHHrVYkzt8bFwsDgN4JcXc9OVPCGncrvmn9to4QRpzf3kY8NEFVZ9z48XvDbrOR8a4ST/tgc7rSRRZ1WIj8dQMRcvF9NhH+MjOJ3flwUyvWlqyc0ASw6nb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujH6iIGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B74C4CECD;
	Tue, 29 Oct 2024 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227251;
	bh=OprCP/Mtq7dPDByLdTHJ/UpDapEoEr7ui9de9UGNXjY=;
	h=From:To:Cc:Subject:Date:From;
	b=ujH6iIGMPDwegpjzSxH5hchiizZx/g2UKHnQgLrXAaIqE6vog+L8JQS8cDZyde/2a
	 alw1zXs5+6qwVvichsDN/LGLDJbya3y7apUFwC+gOsOY/vs6cYttHIup+wQkG2Gx6y
	 ZWU4PtA9aCO1cDIChOkh0Dd4rit/TOWvikMCefXcwGsiwN0/Je95upfIf0Z9j0g17z
	 QdZIwAkerRGfmk5BRZgDCWC0JkcOhIHcE1txxdxHMDTh11/eIqDFePrkxHWTT6MAj5
	 D0R0+7XtR7rQLO+nXX4PPSJLg30YYao4bCzDTmEEai57fF4/wcRLfcAadB1QKOZRx/
	 rkLsqR3Jkd8pw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: start v1.6 development cycle
Date: Tue, 29 Oct 2024 11:40:45 -0700
Message-ID: <20241029184045.581537-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With libbpf v1.5.0 release out, start v1.6 dev cycle.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f40ccc2946e7..54b6f312cfa8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -430,3 +430,6 @@ LIBBPF_1.5.0 {
 		ring__consume_n;
 		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
+
+LIBBPF_1.6.0 {
+} LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index d6e5eff967cb..28c58fb17250 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 5
+#define LIBBPF_MINOR_VERSION 6
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.43.5


