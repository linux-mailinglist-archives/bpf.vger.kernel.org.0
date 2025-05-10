Return-Path: <bpf+bounces-57964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC5AB2079
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 02:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43096982840
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 00:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FF44C94;
	Sat, 10 May 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQDhA/nJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86201944F
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746836697; cv=none; b=nsEq7uZ9/myWzgNBqf/OTnHJWBl6mWmcmyiZZpkaJCghML5ppfExAuk0cqoye2hT5upC9t7JGYjyTkhdtZxUZI80yIh7esyRRSzN+zvwmRXMhVgXMk/C0MLFfVV3HfkLXX30eq4Ga+DikD+dFyv4f4h0jBCeVl7kL/3oCP5Gdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746836697; c=relaxed/simple;
	bh=/VsMM64Na1sw/g7S0NAdjQKW6L53wiR1kcmRZOdmD/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBbiaN3khssGUsHZoGPQkvziHbWT/oC45ohxntS/lhew2g3LLwL0/ORG4nB8FacHqYBuywTEvRutY8LQp41OEGvG/Y6xBjmae6+ILliGoM5n+E6pu2vyHU3shBB0bVi1SALDWeyP7VTsaqyIlXtEKbVMUpc1Bj9QD+evMat3vFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQDhA/nJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1b8e8b2b2so1177195f8f.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746836694; x=1747441494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ad58mGNCB9cNtZ1DXUTUG/VpnnqCkWI+ofAgq5MPQo=;
        b=RQDhA/nJC3S0vRNHo459iJuYEty/yTda2B+bngZCyvi4wJav7Zrh0zASQOOkmQm3XR
         VddpSaX5KQMZ6tuC0FkTSBRkbDn5FSR6+JwzFEpReiJTexqbKSYPvyCbFR0n0493clWb
         3JmKiCsg90gun+Irs2WPsoaep+zjY9kUgVdMGl2Une4REXHZEF8ME84GWvIYg4kgDYNz
         NwXw5ygqu+dYHfFZuoRp75XYoDIua4ma9ziSQXa/enzXO1LlNMP6oda51epVwqjYmRKV
         Av1H6vln1D5zpCgZy+Yind+oKR67YwcrjkwHHeZ5UrSJSMPG5Zwud51xEpxn0VKS2jPv
         yVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746836694; x=1747441494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ad58mGNCB9cNtZ1DXUTUG/VpnnqCkWI+ofAgq5MPQo=;
        b=kt41jhSrZ9eDbPTxaHLaga6pB9Xba5A38kS6+WB4Dx+UizBhgaOHOX3TX4sEhKLKq1
         ewjPZ3tyfowuA2CuxvjHkXb0FnsET8Yw0Nl2nYvAPt0yyRXuGjkjX98v7zD6ep4XQIP1
         Ypaekrmxy1atTf/75dtvozLglWTVyPbLGj5y2X7FEULCTnKNpnbteDu3DOdvnVGwmVVP
         TI/mNTU2nOnaed7ayDxuHIPGARJNtlh8FhT8SsZ8XBXhW46N7KI9buhlNxzBF3lGrUYC
         trtBXR2dZO1lBHw1XI74wwdHI9+XI7bIHSdazl7IRzMlCsRH1xes52Mb4FFbzL12LfqN
         zAsg==
X-Gm-Message-State: AOJu0YyjSs6TEsh4ixofXR/JnCNwATpj0EgTebHvqPsRBvOVB1YJGG0k
	wEj0iYXQ71GiZf9UA/QxmHOMHQUPAekRkVYrutAVlZvfJpV0Fd+l1zof+A==
X-Gm-Gg: ASbGncvw2zypBp6VSxPbzc7UYCNdpd7b8M87ORHoP0aZ4vqoY/yOa1oofRebMBEeFBa
	LwBgapJYRWXNKp36EM95xuI4AfW5TNtnxlCr4+/cFXrRA0kNj2YnZAxLw/bN9aZDwyxUzZpP9Gi
	Z+Kb5XpwteMiokmlwkTeT/PweahmNP9g7VoBMXeDnKYOCaV6YBh0gpThVq2mYFEFhkkF7KXRbIc
	lRWGS/PBKdPq4As4XHT95NmURjjGMaQjgHKgssb4oFC7HpWd9O15+DSmhIVAdV/k/cRNEziIx6j
	5O3klOGIH8B06ANkffp66And+I1EhZhRsmdlvRSgnMD14soFP7grbcfkTMJRfTNlABwqwg==
X-Google-Smtp-Source: AGHT+IGmsqOVV4ZhrKv0SGFanzP+yhCnhXnYPH31luOLqs0UJk414ejUBF/Wac5PzpFdOCf4yIkCFQ==
X-Received: by 2002:a05:6000:2207:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-3a1f6427683mr4604024f8f.7.1746836693429;
        Fri, 09 May 2025 17:24:53 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddde0sm4857878f8f.14.2025.05.09.17.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 17:24:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: allow skipping docs compilation
Date: Sat, 10 May 2025 01:24:50 +0100
Message-ID: <20250510002450.365613-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Currently rst2man is required to build bpf selftests, as the tool is
used by Makefile.docs. rst2man may be missing in some build
environments and is not essential for selftests. It makes sense to
allow user to skip building docs.

This patch adds SKIP_DOCS variable into bpf selftests Makefile that when
set to 1 allows skipping building docs, for example:
make -C tools/testing/selftests TARGETS=bpf SKIP_DOCS=1

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 03663222a0a5..0d04cf54068e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -358,7 +358,9 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    prefix= DESTDIR=$(SCRATCH_DIR)/ install-bin
 endif
 
+ifneq ($(SKIP_DOCS),1)
 all: docs
+endif
 
 docs:
 	$(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)	\
-- 
2.49.0


