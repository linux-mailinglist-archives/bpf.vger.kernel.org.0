Return-Path: <bpf+bounces-44616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05F9C57BE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1D5B31C02
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD602141A7;
	Tue, 12 Nov 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK9ZVnGO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E213EEE
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409771; cv=none; b=eI30K6vuazneUgsl+Rn+o5lp0vqb0qZ2ceeDei/2I6/vverG4TYlD1MHfDA3QVq3HvfOzXyKzTjuHVkg1rHir4tM7qA3+gUhPy2OtX+EnuQb3dCrIK9XEYVOpIEdlRlaS+7qq+T8RKpjbv8KG1V60ZiLIxBsIj4B917zWeBvhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409771; c=relaxed/simple;
	bh=m1iiAY5TdZ31BVQfwgfETCvVT0vzokJv88Br9nUkAOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akVuNESYPDjt+v7sCA2DbmIo+VZhfErIYMSkTVb3+DAWOwBW/AqIew1BkkV2WLIMmiR5rCECzizww+BUmiHUbWLw4s8U5gS8uS3KrpOyGHtvb5JBYo1BKT8rNU3MFOuzhko9OApvZOBzVU0fditEUnHpP90SKLP+EDMtq113qBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK9ZVnGO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdda5cfb6so54550485ad.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409769; x=1732014569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbh+Ilos50BuQt+XEpYGq60PcPdNUFcP1RucqNZOLIo=;
        b=WK9ZVnGOvuPoXBM2+Y4YdvtYNVBwsLHdK+LXfOIuSuq/gM03wW+6WcnFDJ239QKDvC
         i63uyazNtBXPVw03jQhLt3UqwJIdG0UqZLCIwhzV3OS9Zns3E16IKum3pST2ZQenKdQk
         Tjfx8XVvWJSZlfrRSjbx1IaPFgnIUyBw2LQMUyH6xNl5KHx/4LivqTYS8u0pEd+BKeE9
         KnmQawIEtZoCp4esnZDKZdpb5knLToEWEbsgI61E3ytLDUbj+4yinPW3D8ovbnmAAAK1
         3ptZ2ZvevDNkqyWnzsKLn6lSMFVVDipUpbpkxzYIcnDgvF0m2ur6Dni7A+HzbZrhX32b
         EC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409769; x=1732014569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbh+Ilos50BuQt+XEpYGq60PcPdNUFcP1RucqNZOLIo=;
        b=NZt7Ch1GGsOUcA1Kd+4PmvnKsa1DWt5pkF+sFG3XDuWnQjhXTETiktx2ORfjIbj5iY
         68g+s2jEGGiyY17soy8gu7xfTxmDihoNI+tgXBaztVbxXvMDk9PkmqJTbSLsFSc14qta
         Fg/wcyZTs8p1jtUKHnZ+UY75dubBX6D2FIyYEN7hDGkh2DDhBQ+puWYLF5iW0gAapiFj
         5TAI6GziMJVgtfEDQRN6PoAwssYkA484HTv/FlCkvUZZjWTeqMDM71qOmZrU9XZAEeKy
         Lq8ENXunsDoJasZ+gc87i6b4oXu+ky6AGOwv9FJEfyxqDB/Qjoba9kWscJN8ErN566l1
         wtlg==
X-Gm-Message-State: AOJu0YwrYp4wWd1Nv7TibE0clyFBe7LjflAsovJORlsrbfU4b6Jzrj+b
	xdIK9VISXEXZTe3elCfQdm0XYj3yuwVfRUrm40QbkFMptRaVqMwLa6VucQ==
X-Google-Smtp-Source: AGHT+IGOvnO0SpXcbXoWvMQhV33bX9mHFKrzZASzUuGa1v0OBhQeVIz/UNLYNLUWkgBtUb4Fhyfnyg==
X-Received: by 2002:a17:902:ce8b:b0:20c:dd71:c94f with SMTP id d9443c01a7336-2118359aea5mr187400235ad.41.1731409769498;
        Tue, 12 Nov 2024 03:09:29 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45eabsm91789135ad.114.2024.11.12.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:09:29 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next 4/4] selftests/bpf: update send_signal to lower perf evemts frequency
Date: Tue, 12 Nov 2024 03:09:06 -0800
Message-ID: <20241112110906.3045278-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112110906.3045278-1-eddyz87@gmail.com>
References: <20241112110906.3045278-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit [1] sample perf events less often in
test_send_signal_nmi(). This should reduce perf events throttling.

[1] 7015843afcaf ("selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 4e03d7a4c6f7..1702aa592c2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -229,7 +229,8 @@ static void test_send_signal_perf(bool signal_thread, bool remote)
 static void test_send_signal_nmi(bool signal_thread, bool remote)
 {
 	struct perf_event_attr attr = {
-		.sample_period = 1,
+		.freq = 1,
+		.sample_freq = 1000,
 		.type = PERF_TYPE_HARDWARE,
 		.config = PERF_COUNT_HW_CPU_CYCLES,
 	};
-- 
2.47.0


