Return-Path: <bpf+bounces-37838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9B95B0BD
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F381C225C0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753717C7C7;
	Thu, 22 Aug 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKdAaWLW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D0176FA4
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316095; cv=none; b=I2g6ZoRm/mAGCCcY+sdLWC42nu3htez+u9ae215/QLEukaHa0F5mGsCOHM1aFp4XXsp8gY+vEO8uH4pxXfuJTHRAm3ogG4sGCNdFv9hXoN2TZFXVDtPlD9gueFp7Ntwdtx50wyDJzDTASrDZBSqiJgqetwQyHhHnzGPNU4E3KfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316095; c=relaxed/simple;
	bh=TWaaiO9Y1pDoBk0qTAerg7n/u6L4FzNG2TuvIwwwBBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km1Adp+npZXUXtxZFMlReSBD06O8GMfkc15j5NIz+LJP3GdaLwCTGrRFbT2GP673I+5zSTzH9OV07IIFFF/W3Bh8IybHPffczQLiNnVyiDAV72MAn4d3uAR//ulkTvCusqO03EWCIThztUcffxsUedRu5ovZ/78fsnVmoqu9K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKdAaWLW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7142448aaf9so381900b3a.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316093; x=1724920893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4Q+yZxSLwa3eWpRVGP+bvgxAyKUo3mF9qAjV+QT0+I=;
        b=MKdAaWLWWscPukDB4iGAIpM3aXaNkQqPUWwESfNir2vQxhzCr/tHNgOtWHNV4+a3Wt
         gLNzQAwb4YhR52A+S3f2ngWz7SuUxiwBbLhDnViaUMUf2rHZzdUGz+M5qzcPlhdTDlJ3
         rXNudADQ0zAHDRX5UYJz+3y4yQk0tFkZKxZudXiTsSUhxcfC5a83Ty7ADpjPMeiqLKTH
         EMhPo7Wmh78g463wCqzQO7J5UBZy5Lv3u1Sbxfg8kEk+mhFjebtXNwHP84siyco8D3Bq
         yfDzDzfLh8zfmWA0kQD7R91BlLbXnKw81cSgOFf5OW16smKRt076MZePeExdOsZezIDr
         bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316093; x=1724920893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4Q+yZxSLwa3eWpRVGP+bvgxAyKUo3mF9qAjV+QT0+I=;
        b=ESOGUCDriBLuZ9W3oKA7zzNI6VaJ/NTtXbsR6xSV47pJeu0gNYv49rqgj97Y6YVUYv
         OkHZqbZLZ9C9js0cKSrFaj9ETPZ/JPMk6rOSsaoAgltSaQ4DA3/tdFLtRwctfCBEybzC
         uGlTfgzMGxXTbIQp5210fpOBMVR+UcyNLCbJTQylAwVZJGEOJkORJrf+c8U83AoIFNYq
         FaeUUX4RPwBSVpq6BYsgkHQX4l0t1JHRHJcF2zRie+6ojdURjkCts6drQGgxI19qlWRV
         LumaeQbtMsGlv1fHnMZIvcpnamuRAAU+tVtz7k7TUN7i0y3xJomOlQ3RLfwwI4OJEMXa
         smFw==
X-Gm-Message-State: AOJu0YwUwtcTYj2l8gjON5PDjmpTh518JVYYxohGLBnWQCLHJJ6GKJD7
	absfQNklTgA+6ghI86sOKW1m5oQXQWnlCibmQUYFxNKmpM8+/4E0RXYDIxHa
X-Google-Smtp-Source: AGHT+IHc9tULavXcyw7m3jaiiVWLUAt8aHbVutnZK8meBcEXAiGlmHqZJq1YmpzR+z+SAzq1DO0nOA==
X-Received: by 2002:aa7:8882:0:b0:704:151d:dcce with SMTP id d2e1a72fcca58-7143174cb47mr3885243b3a.5.1724316093022;
        Thu, 22 Aug 2024 01:41:33 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:32 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: by default use arch mask allowing all archs
Date: Thu, 22 Aug 2024 01:41:11 -0700
Message-ID: <20240822084112.3257995-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If test case does not specify architecture via __arch_* macro consider
that it should be run for all architectures.

Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index b229dd013355..2ca9b73e5a6b 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -543,7 +543,7 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 	}
 
-	spec->arch_mask = arch_mask;
+	spec->arch_mask = arch_mask ?: -1;
 
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
-- 
2.45.2


