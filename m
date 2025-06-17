Return-Path: <bpf+bounces-60811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE079ADCAEC
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83043BE325
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FE293C65;
	Tue, 17 Jun 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCaGCurU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D9293474
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162547; cv=none; b=FgE/YtJmVEa1xGgRtF7oKPkuEz675DuwRxcVo+GAFQU3eSLNh+6lCinN/uCNPI1d8imalpXYhAIKZ4XXFu9ZYgKBImdrhi3hn5nCrhQ+4M7cHTixdzZIxivOQZz7aUB1nkMVVtWOPGgEOCuXnctZ8nRH+BfMJShid22a5oNqUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162547; c=relaxed/simple;
	bh=K2qe82e0v0HKpunelq7NAle7/CAnWrFRq46yo5HY6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ghfin5OS2pdHY1cZNNpTHIFs9cvjSj4jA7SMnaHKz00ZvIxyYCtd3OT2q0gBnREY5fzLgcohlKiBvm5F6ygkBtJMf2s3UW2fpzyND9fmUqUK7zGEWlPuapyD4fl0ec6/Z8sXEmJWtC4QWABSpZUa4YGtBNbJutwdWtyooWXIs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCaGCurU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so11818004a12.3
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162544; x=1750767344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4/9MZCPq5wEUcbtUtAhh+o6Teq/vnm15USwunDDLYI=;
        b=jCaGCurU3XJknwOc+aKtNferJ2QdZu0fyBUTdgXkcy7be8UxWBb9at3voM7LUtdvWz
         kolzw57/i2JNZsVRB6gjRG6aqSRdt93DvChjPvrxAmm2tRFvaj9Eu2vNU0kdSHfzOso/
         NjaTL1dS1XnQpSJ8l4kJvZOJbXNVezieW8/+dNpzjCmgiK3dC3R3Vbk6lBTgRfD/IPhp
         xmSj9G8KoSSDgPiNbHICSCCHKeerFK5BmlYz84/040zzWj/0U4EVjL3Ite7SAWqSq+/d
         tBONg8A8aseGVRKqEHv1d0RBxqHD+g9qw8i+p5NEWkC4xOP1m1PbNfxsw3KcjOa0bOr8
         2/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162544; x=1750767344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4/9MZCPq5wEUcbtUtAhh+o6Teq/vnm15USwunDDLYI=;
        b=EZQZqpXmAWcHDkIil2Ns8J9OY1NpBnf8mHD430slllB0uIvfDFm+uj8GyqOympeztm
         Q/f7qE/DqjbaizPvFL6oIqHF8aU1xdZnq5SGWIO4GO0K6re+mEIamQ4hfBBrg9HjIiHs
         GZystgPvVOhoPL801ab3MW1soC+vPUIDGhHdRYRtOKMI7futQaTvteqNr0/OCgkQ/RlB
         P1xZ930fl/63dc83ytwQRrvPitZaQxFXSFAjux5jZoIzThqY6Z0hi3PKp5wKaSBQllBM
         LxEdpXTbiVkkiHGn6qoqNBvAYI1rGTL3sXRhIPnR498BxkFRX3M7Be8SgfmlOcCuMPoC
         j5Dw==
X-Gm-Message-State: AOJu0Yy4T8tuoTqCTwKClpn/0mM70iAUItlAnf/ePvikWXx7D287TtqO
	JQf6wFkqObUaIq668Wb34IEVGidIVA7jAiEmUU7ETLLe539EVeykZg0kqudEt5yjsTs=
X-Gm-Gg: ASbGncszvFW4Rx0Lbh+UDBjuFS2JOsAL/AC1/5FxnqCMwhbBIl98XFt8oBiv1DWzof+
	lOZ3PmVbZ5k5cN1SVRpQOGk92roQ1fEzSkyJp05EA8j3yxN7FBVMDtb6yLAeQ9Oe8L4A7c3j13D
	FG7jn83C9jAfAyllfBIbBPFOLeAsN/uLCLljyUrn2l2jJgEEdwHHhYf/sgT52OREdmVeYVdniDS
	bu1yi+Wryh590zm9VrOTaL1qYgWoPw9u/vnV1nwD6FEoZ6BxBQt+TPacs/Pf+4wQ+cNhrXci2xR
	2Vy123EBhVASx3n+tUoxsuGYZJw0tkDCPvh0UAjXgZZ3fYWscZU=
X-Google-Smtp-Source: AGHT+IHlv8QMcS/Fbr6+ygndWjFeVWDPxgYMgHC7vzXHPyzrQ7WkbhSbW389tu/SprIhge6p/alkFg==
X-Received: by 2002:a17:906:6a1a:b0:add:f191:d851 with SMTP id a640c23a62f3a-adfad53b7camr1194344866b.32.1750162543740;
        Tue, 17 Jun 2025 05:15:43 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:38d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec89292d9sm855329166b.116.2025.06.17.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:15:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: fix unintentional switch case fall through
Date: Tue, 17 Jun 2025 13:15:36 +0100
Message-ID: <20250617121536.1320074-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Break from switch expression after parsing -n CLI argument in veristat,
instead of falling through and enabling comparison mode.
Fixes: a5c57f81eb2b ("veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 56771650ee8c..4da627ca5749 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -364,6 +364,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			fprintf(stderr, "invalid top N specifier: %s\n", arg);
 			argp_usage(state);
 		}
+		break;
 	case 'C':
 		env.comparison_mode = true;
 		break;
-- 
2.49.0


