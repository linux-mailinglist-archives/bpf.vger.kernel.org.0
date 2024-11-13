Return-Path: <bpf+bounces-44751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129269C7450
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2311F222A4
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB691FF035;
	Wed, 13 Nov 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PwwG8BwX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560031DF73C
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508078; cv=none; b=LlS//sELLz1d2c0aTHuzbMuvrg+z4m3JWFJLBE3/joZqgZsxvJX0v6qhWdSwXDe4aCSztScqd6YKwIsOrRQWWH5+KRNlwoXIkTybZAP8rEqQgGLUx4bMFoxnQvX9df1hbjXEezYgB8xYid12uoiTU/6AuhJkz/zfNbBPEizsBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508078; c=relaxed/simple;
	bh=Y+2H4LdN8mN6PJGaLKpXtkX3V6r/tQyzwkTwSod6FNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVO2WhwyZGqwThu70ugXbVEc4uWgBhpGvfnZgi/SLXHfGlU2qFA5A7UTddtFktOQ18STP7wcsfRQwGASjtPGvL8CLveWbdLxWGiWccHvnUQ8dstGay2TkkFTcgkqkc23HxlUVA2PeB63PKLMQDEfgAXDp9mpnvoOT8Zq/IhzAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PwwG8BwX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d36f7cf765so54428916d6.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731508076; x=1732112876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=PwwG8BwX48E7l1wlbo6E2QcTFnMrvTuVrxgp4XINPytAvgCn40NKTTgmeR0fGLvfi4
         LT/gJEXucqr4713/yh+NQbRYIL5SLuRTgc2z3ylGC3+CIawGFUgViVNwl+rH1imXU2i2
         GIee5wJT/p1vPKOZVcQuTEsT0mTXMENe4xZpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508076; x=1732112876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvYXEOtoobfsjK9RlNl1WSgITYS4vYodr4T5ypoCMpg=;
        b=bqqqZH+wcigMVT70TEC5FrVO/GR+y1QtL4SRCUR+FB5zgxyS3wTAFjn/fabK0vGyqd
         slscbwocjqDc1epzG0VD9sZ7BlTzeqMQKl40bSB+L/F2yLBblMeGvYUg6gYnFPOjbnlk
         e2oS1B27h56v52WCp90P6uVv/SkY0LcV34fjf4RixO9zk4VGKK02L21lPKUUZSlj00i5
         NaC/l9c4zQYO9M+5d4Zroc03qLTCxrVFVFqsLILmvWKT2EhXqCdjiqR81zWeqkP8roZC
         YNyLDpMdV9u0cxr1p9zxzMSadABeC1ha8z4l+2dSSxGaPzGCUyjQYJNvWQzNL2Mvjx4H
         98wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa+JjtyfaAlap2Gb1K/2Wdm+DWheWM2YYYdzSvaimE0TuFiQOAvA2hg42ZlLV3gnAPMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EB7xtIKpSKrsna+Bq/5+2BgLB1vaLZjGhz+j143+DXBLGRMZ
	rEV62CJsE21nrBVGI8xE177s7HjbBhzq7kcxxm8AzRBstAVRYGTcr7MV3M43VA==
X-Google-Smtp-Source: AGHT+IHNU4BkuDoySGHigGN9ulN/IS07Uo7ecwBFdjEIsUxAiHxHdOdLhRm/oLLAi1XFBjrIj/1mmg==
X-Received: by 2002:a0c:f64c:0:b0:6d3:e7f8:e486 with SMTP id 6a1803df08f44-6d3e7f8e4ddmr746996d6.15.1731508076325;
        Wed, 13 Nov 2024 06:27:56 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defe5sm85134976d6.10.2024.11.13.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:27:55 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mqaio@linux.alibaba.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	andrii@kernel.org,
	jolsa@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 0/2] uprobe: avoid out-of-bounds memory access of fetching args
Date: Wed, 13 Nov 2024 14:27:32 +0000
Message-Id: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include additional patch (Andrii Nakryiko) since its a dependency

Andrii Nakryiko (1):
  uprobes: encapsulate preparation of uprobe args buffer

Qiao Ma (1):
  uprobe: avoid out-of-bounds memory access of fetching args

 kernel/trace/trace_uprobe.c | 86 ++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.39.4


