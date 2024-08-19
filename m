Return-Path: <bpf+bounces-37548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9395766F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 23:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A25B21629
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D11598F4;
	Mon, 19 Aug 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM8Q7zaA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8AEEA5
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102648; cv=none; b=SCH+wGINTVqia7V/vb6n9jZgDIKvnHbyp9F+7UCk8sSdIu56uN17qkda6ZAviRKfux1fBIBGiBfe/8IxfC4Vw5cMjqXlxH49uXPlItI32J71WQIa1mDidU/UDOPaXEHsS68sIcNb4lX34aKOTgCQFE2Qn5kk4xtq7Mt9tYt49qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102648; c=relaxed/simple;
	bh=qHi0XiYxbJTUx6fIjLhJUHL3TKkYnZzIcr3rYvpyOeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmoxn5OW2HF/OSH0PlZoD62/7bDApNhGW1QrG2czgGRqtZCxhmKW+NS9j47SFzv+PBAkexjv81MVeKAfAfCpN8nvlY944Okv6CVRBKcfY9aw9lNXpbF6DdW/feb+a6Hka8AlLZIlNo2pwUG8WIrMSO+tBFzb+d+MyhLUA+IIaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM8Q7zaA; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d3e93cceso554279585a.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724102646; x=1724707446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Maze1xTDoCQK8yWkME/BuJg0jJiIJuQldRvkiNTeuP4=;
        b=KM8Q7zaANpwKhJVHKWir2dG+xy2rXa9RtceNv4V5ZvnPUtX+W96iVzZOXyEClDLUwF
         xeV3MRBbq1eVfstamvLAZaMw4KzxTpNEk5EzH8D5KRjYXWxrA1JawJZToIJ9CMTBG14x
         7I6CDgBWg77ED4bD2mVKCAMpRxaSxk1RBpr+PRqES6T0pKEsuW3ycLevXLPUWUKhGE6a
         ugEsiMt5UwmeSAhHoV6/6nTTRW9SG00GEkc8x9+pFrYn5fq5GWZRf924UecGxzrbUwZ/
         oB8QEI5tG+8jO7hElUbiSBL7hivEBaZLvj9eMi+S7+11LFNVV82k+jLPR31KMDWryPO/
         mrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102646; x=1724707446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Maze1xTDoCQK8yWkME/BuJg0jJiIJuQldRvkiNTeuP4=;
        b=U7hk6GCyIF4LN+qowaQfDyHMvJRV9O1VNeJ5HPj+LN9jBTsRdB4GsUxdu8F/wbVsuB
         aYczJz5g8YBbKOZ4KZXQqO+t1GAs9jfeMRN7RiwiNNE07KTPp0jV2xI6SK+eoZa6sQBr
         vuafGwK1gPyHYbREo/rgPwojmaWDNSYbdx05xq/WG6Sso3sXynHUsTQOasVHZ3hlBNgB
         PU09eR71JFM66/K1VKZM3477Kk+7v/MCI/rov2YRJU/ZBWrdI2hnBAPG8wi3XwlmkgEf
         cz806qgdloisMUzM4IZPWlGLGwDmN3uvR+vHqRnu1qrZ2E30wiEvHRRLt1pEQrYEtk2S
         dd3g==
X-Gm-Message-State: AOJu0YxXfVBv0x3G4fjBFsE93NYyp8UEbpPkgNVj/d+YeQFoPpjAYFX+
	iiVqkH+bnZFGUqHcyMx38wvqRokMSfgdGzO7ys426N6NJ9Qt1ClYvHyoyg==
X-Google-Smtp-Source: AGHT+IGTlB2lLuML9VUVsiXh4cSOaLNHaV4ZLhNtx1lslmLkr83Y8aWWLaVe1Y6U5lFVNEqMyPCo0g==
X-Received: by 2002:a05:620a:248a:b0:79f:f6:1a78 with SMTP id af79cd13be357-7a667af313emr159387985a.15.1724102645667;
        Mon, 19 Aug 2024 14:24:05 -0700 (PDT)
Received: from linux.hsd1.mi.comcast.net ([2601:400:8180:3d70::4977])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e55a0sm467093885a.78.2024.08.19.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:24:05 -0700 (PDT)
From: linsyking <xiangyiming2002@gmail.com>
X-Google-Original-From: linsyking <kxiang@umich.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	linsyking <kxiang@umich.edu>
Subject: [PATCH] docs/bpf: Fix a typo in verifier.rst
Date: Mon, 19 Aug 2024 17:22:30 -0400
Message-ID: <20240819212230.50343-1-kxiang@umich.edu>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In verifier.rst, there is a typo in section 'Register parentage chains'.
Caller saved registers are r0-r5, callee saved registers are r6-r9.

Here by context it means callee saved registers rather than caller saved
registers. This may confuse users.

Signed-off-by: linsyking <kxiang@umich.edu>
---
 Documentation/bpf/verifier.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 356894399..d23761540 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -418,7 +418,7 @@ The rules for correspondence between registers / stack slots are as follows:
   linked to the registers and stack slots of the parent state with the same
   indices.
 
-* For the outer stack frames, only caller saved registers (r6-r9) and stack
+* For the outer stack frames, only callee saved registers (r6-r9) and stack
   slots are linked to the registers and stack slots of the parent state with the
   same indices.
 
-- 
2.46.0


