Return-Path: <bpf+bounces-34957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F19341A4
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BF01C21219
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79C18412B;
	Wed, 17 Jul 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8+99ssZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425C184F;
	Wed, 17 Jul 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238464; cv=none; b=prGebNdTVWZzAGJJapA+Vo9qga5+lyCrS4IM+qvDbWvSlPGUsNrYib7Cnrr9OP8h08G3r4xJX03qL3v5jzmsQ5J19pm2s7k4bEQ1z6be8/9Mqle6QgnjyLqVeodLKTQsjq2nA5Z3bFS9Ln5jI//afXxxkeEjjEJVJ093U4RU48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238464; c=relaxed/simple;
	bh=d3NJz4jUuX7oE3096k7n7iS0SLoh6rburN9DwWrzyO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s11d/NzdANz3m+xRz7CVP2qgxabZt3Wfp0qprHLpF7VXpll1Z8ozE6xEZ4tjBPGow2fkBQ5IFpuo9F3hTrMIEdaXIXLMkAF523PGE01Ogxm15TxyRebrGAOlSMlLflVnHDF14QnK9G93fWoObTtXKehU3LTVOz8A0+hTn0gL3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8+99ssZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af22a9c19so5235954b3a.2;
        Wed, 17 Jul 2024 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238462; x=1721843262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hk1vOhEtpNT8o6McHb9O6PZJBmCTMgCBX1nWzjTxVE=;
        b=P8+99ssZPr0lwoSKGltNyhqGE6BIEur33GPIRD0/Q58yQYqi2rVOZpgTtnIx26sLqv
         8hizPdecfrnMSMoW72FE3xLPfrcG5ySTnNCuhKZ7EENfSaLQLQuBbt0wvHCeUgQvax8a
         CbPvcT0PDA/G69oohapFOkZkqhe2zs6wo/c1TZoDu+6h1++ZJFNJJ0DbHYXrkf20DZRq
         l4qO0D9JluouJuudQH83HadTIepfdWfRIy+8rJVQI406p0uAjcy9R11KIfzGKAIhLzGQ
         x6uNSJaaAYJzt2x2mRaEFh8GVCVjFvx3iDkVo2QigO43+h7fkiOQeeyCH95qLgw/tQTi
         Ek6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238462; x=1721843262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Hk1vOhEtpNT8o6McHb9O6PZJBmCTMgCBX1nWzjTxVE=;
        b=YkmeyXjKB/8Ec34rZ5Kjufe32xIdyQf/rfsOhwfONfQbWNKBVPNUv268opkfJRJHPu
         sg795+hYef1xpT8H1Pkr8vGQCXFa3kCEJhZKRqPiKGovdRSa5nxbVGlIPL86C14DNsw2
         mqNG/m/EVjHXcwNooDTJJxy4MZCMJ34cAjNaWLxLO7HD3CakuM9z5PWRboMtr3xzTnsW
         QYcGLvSxhMxEkNcwMp++V0PIDNWPFmaqAFevrOJLbi6SEDcnz4v2NIDdL3txlRGgJ0gb
         LYt6/SXrOLo7/8YS9kWRUJBvhYyCS+jzcBoKStm1ssPCrGDRBb4EVn9jHQZuZ/d6GVBe
         914A==
X-Forwarded-Encrypted: i=1; AJvYcCUqacUj1iPd79RxUrM9Yw54PuBR6w/x+0rWU2JKz8TZ9XMUZyogMwo/LF8oJdVUiv4W39MOfYcQBHwXh0n4ILJPfyrq9ss96WSTW2eWCnL7gnW0xdcmvMTwatvRzTIHtMeD
X-Gm-Message-State: AOJu0YzYsi+ruZBffuvi8GVQ78X25Zc73xj397VBTOr9vinhCCwBF44i
	cInorQAQviyWVqpDxxjIbCHrh7IG1Bu75KXawA8mwf1epFhdrOdG
X-Google-Smtp-Source: AGHT+IG2v9n5WK0JXwdEu98eZ50zz69zNuje+Regv6AkbfgeTzXByBFuU/KN/LO9gbET4Y3CWmGEAg==
X-Received: by 2002:a05:6a21:6d94:b0:1c3:b239:83e2 with SMTP id adf61e73a8af0-1c3fdcbffa5mr3387724637.12.1721238462032;
        Wed, 17 Jul 2024 10:47:42 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e4bcsm8398596b3a.117.2024.07.17.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:47:41 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH bpf-next 1/4] bpftool: refactor xdp attach/detach type judgment
Date: Thu, 18 Jul 2024 01:47:36 +0800
Message-Id: <20240717174736.1511339-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit no logical changed, just increases code readability and
facilitates TCX prog expansion, which will be implemented in the next
patch.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/net.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..1b9f4225b394 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -684,10 +684,18 @@ static int do_attach(int argc, char **argv)
 		}
 	}
 
+	switch (attach_type) {
 	/* attach xdp prog */
-	if (is_prefix("xdp", attach_type_strings[attach_type]))
-		err = do_attach_detach_xdp(progfd, attach_type, ifindex,
-					   overwrite);
+	case NET_ATTACH_TYPE_XDP:
+	case NET_ATTACH_TYPE_XDP_GENERIC:
+	case NET_ATTACH_TYPE_XDP_DRIVER:
+	case NET_ATTACH_TYPE_XDP_OFFLOAD:
+		err = do_attach_detach_xdp(progfd, attach_type, ifindex, overwrite);
+		break;
+	default:
+		break;
+	}
+
 	if (err) {
 		p_err("interface %s attach failed: %s",
 		      attach_type_strings[attach_type], strerror(-err));
@@ -721,10 +729,18 @@ static int do_detach(int argc, char **argv)
 	if (ifindex < 1)
 		return -EINVAL;
 
+	switch (attach_type) {
 	/* detach xdp prog */
-	progfd = -1;
-	if (is_prefix("xdp", attach_type_strings[attach_type]))
+	case NET_ATTACH_TYPE_XDP:
+	case NET_ATTACH_TYPE_XDP_GENERIC:
+	case NET_ATTACH_TYPE_XDP_DRIVER:
+	case NET_ATTACH_TYPE_XDP_OFFLOAD:
+		progfd = -1;
 		err = do_attach_detach_xdp(progfd, attach_type, ifindex, NULL);
+		break;
+	default:
+		break;
+	}
 
 	if (err < 0) {
 		p_err("interface %s detach failed: %s",
-- 
2.34.1


