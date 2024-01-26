Return-Path: <bpf+bounces-20369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1A83D2EE
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 04:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3911F248E8
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5970A94F;
	Fri, 26 Jan 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUlv393L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD18A944
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706239575; cv=none; b=gya+/ZxtMCkUnDFryYNZ0Y7uApwPXp/3XF26C/sbK3RLeM8oy0zJ2aAQlshSq9d84L/ApWb4bIN5GRMCZ3+ezDczElr7IIA3PEsCos+Gqa31MyE8A7M/MBfiFfeUJvvw3IW3m+G+7WxCY/s6HbGuVhA11KlsBQ8ATnSrVCB+hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706239575; c=relaxed/simple;
	bh=K/5IKUJwNENhC36vnIdxJ13MbiHWkQO+1Nf5Ecz7Vgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJVd/mOa6BgbdBGWvSSppbMYqSe1Y3jO0PBtqDg3cEI5xkTVuKbd8TtCB32eVzI01nUmopTlnu0dI7SItq4iYSZ+dO+AbafaL9XhC2YPJfLaLwufo2Nh++7Dk+n1giIUUN9k9KodRPwdFHzlr0AiXfB1puUamB2eNuUb23L14Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUlv393L; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf3ea86423so12170491fa.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 19:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706239571; x=1706844371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqF2tHMly/pY01Q5kWiQakhWjb5ZSNXelLXiXMWZK5Y=;
        b=DUlv393LVrbu+E5yhc2gBfsQm2AHanaNq4QiVGXbtWzsdklvDgM6Kk5BvuNiv/wMPE
         wuGHvxGW2ctnFKY59y6PIEmydpxfHu3LIMhWyc7at8noRvN4O7oyhNNcHCqX1WQ8wGHX
         aJpWpG/lOMI70wq2OHU3zPxM1yICSf6qb9MmMzdmAVfyNLDTztIFXFxi+8p9uAvRoVQ0
         WdZ4amzfg6ZyTCMXC69QbaZKihaUvOTElAdTX0XukJcY/T4EdtGUHz8IWxRZqYCy/4M4
         sRByFMLen0PJ8TgH07Qutu0P4kdohs0DvFj7sP2jD/SQfmYHm5LbAUb3gtwqtDPN+1C8
         WgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706239571; x=1706844371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqF2tHMly/pY01Q5kWiQakhWjb5ZSNXelLXiXMWZK5Y=;
        b=tzBGuo1TKHTvCfcEyytHcNyisHKmpO8ZGrmEUmIsdcRqdNzo1oftpFxSPbJ89cC+nh
         /4qVX/dUHjiw+fUizecnwWUXDFcofjJq9SBlEUCsW2PnFmae9/saRCu/LfXvNSCWKQl+
         3tDNP//esAAbqq7x9spqFpTdlWqbHAHSpzZRFIKs1JhmS2eRd2rWyvRt4e4jX/DmtmaV
         RoAzM6+WCknfKjxcmyeWlWWqO/eQizNv0HQ3YdnN2kHIGXt4Gin8vq1KBgXgcuSptskN
         iF19cVIEum3oietbP4XLZKV+mP65XhnOmQDRgHaJwTVfx5Al/qpgCsWCoEZBfuZEsXDl
         3Bag==
X-Gm-Message-State: AOJu0Yzm8xnncakiA2tv87OSffGVvX0qnSTsfjTYHU+QxjY4Tou/Xdeg
	1EJW1/BWdlzq7LV7deKBaj1uNPV3sUZIU0vydYM2blitbXSg0SwyI5pD2jX9
X-Google-Smtp-Source: AGHT+IGGxJN6rY8nyKHR45A3oddpBx+wLAv51Dh8AHYfM6czNGJEIq2R+U522XA6VKCDxPOnOPR8/A==
X-Received: by 2002:a05:651c:140f:b0:2cd:df43:9544 with SMTP id u15-20020a05651c140f00b002cddf439544mr265179lje.97.1706239570835;
        Thu, 25 Jan 2024 19:26:10 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b005593c83bdafsm145816eds.45.2024.01.25.19.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:26:10 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: One more maintainer for libbpf and BPF selftests
Date: Fri, 26 Jan 2024 05:25:54 +0200
Message-ID: <20240126032554.9697-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been working on BPF verifier, BPF selftests and, to some extent,
libbpf, for some time. As suggested by Andrii and Alexei,
I humbly ask to add me to maintainers list:
- As reviewer   for BPF [GENERAL]
- As maintainer for BPF [LIBRARY]
- As maintainer for BPF [SELFTESTS]

This patch adds dedicated entries to MAINTAINERS.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8709c7cd3656..0707eeea689a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3792,6 +3792,7 @@ M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
 R:	Martin KaFai Lau <martin.lau@linux.dev>
+R:	Eduard Zingerman <eddyz87@gmail.com>
 R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
@@ -3852,6 +3853,7 @@ F:	net/unix/unix_bpf.c
 
 BPF [LIBRARY] (libbpf)
 M:	Andrii Nakryiko <andrii@kernel.org>
+M:	Eduard Zingerman <eddyz87@gmail.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/lib/bpf/
@@ -3909,6 +3911,7 @@ F:	security/bpf/
 
 BPF [SELFTESTS] (Test Runners & Infrastructure)
 M:	Andrii Nakryiko <andrii@kernel.org>
+M:	Eduard Zingerman <eddyz87@gmail.com>
 R:	Mykola Lysenko <mykolal@fb.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.43.0


