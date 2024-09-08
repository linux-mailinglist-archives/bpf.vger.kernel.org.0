Return-Path: <bpf+bounces-39202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D289707E9
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A682281D5E
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393B16FF41;
	Sun,  8 Sep 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFMq+FJo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2EA2D;
	Sun,  8 Sep 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804029; cv=none; b=VNFgxgolLn6tbaBScNqwlC0nboylYuLYKOOywM3rfUpJLDtrvNpeETLqWAWZTY+14ZuJycMVQ5o8+Pbeqd17qyEGeEzgFQZ/6QiE8ugn5G0KWN6Rs1TT+HVYPivScpIOlOLiAICqxZlcJtclKwx2cIceKBMEg8N9c5eX1dfwBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804029; c=relaxed/simple;
	bh=Y2NDtCjVER93A9w2ReGNK7/dzcf+hFjKCrvUyF4u80E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LO+dIGdVlAD4LilFD5/V09HQGylrrXskcYKji80Ml4uYyv37/RtnJuBt6zbhXTS6MguSUjZi3WfHumODlbKMHbtvsFA5iCENUTtJ/NFTwNCdYW6R+PjiQ7LPe3To8LVc8YQiUWbLTKHoYEUviDJ5ZzzLpOxumIPBvzaYiB/LFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFMq+FJo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2054feabfc3so30093325ad.1;
        Sun, 08 Sep 2024 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725804027; x=1726408827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pj0AerlWB+eF4qNe7zKXJKWx1M/nXwU17bMun+xn84=;
        b=dFMq+FJo275m23g/1KxemJXU8v6vG8cbNXebAJI+KZSkBz3KZ88Of5dxDm99lwKUUX
         IO4WMhp0rFq0YCHfIwszARGYNTtasOf5PEpU2h57Mx3ePEthJOocFA/8rEvLqh1uIT8o
         4h+YHwEkzh1iRSUWd4w2B9XSmf54Re6BzT7QzmsKfXh8TI3ytJxZcMITTncKK/r/adO9
         KxlNygdBj7myE5q3yDoMhBN17Uv8WetUDyN9A5YygSo0Jnhygt5jDOeUTLKGMNAZzZKy
         cetI52fgF9McpUEEQP/rI3KenyeSgRh5rJL2V1Joclm0Jzw9dOuwD1Z6cIR+Z2fAfcI5
         95uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725804027; x=1726408827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pj0AerlWB+eF4qNe7zKXJKWx1M/nXwU17bMun+xn84=;
        b=JxYm5xNxHYCValTGpcQ9y1ttzPJDCEwuqt86frADrHQtcPXDXhQR2zE1PHVcw7s/Pj
         y4PbAUC4ND6UNkA40AYmUMcnyuVLMBbXvpn2TBaf2KDp/guIQvCdoFgiE9VBwm1yEnCQ
         mURmwT9la0YIGMRHDwCnuVYYNkBPuGFJ2Qek64g+z8ekercR5QexCYDz+UJujBYDxMbx
         l8cVguMkc+soSOobfsiVIjQ9GcMulYbSn0exe9I5CF9Cw33leYJZkb8AcqcO8lrYqsYa
         FyoRYeb7iKh0S2nWv+4EC28hrrXn9Z3F+Y7IEdaJZRdjzDHgdDIg2V65PcEQzpW79Cke
         O/PA==
X-Forwarded-Encrypted: i=1; AJvYcCVQHRk2W23/1Qb7qIELzZyq1xZZr15KsyZOrzVNFl44+9QP7NwOBlblGtKmTqqUD+zFUfI=@vger.kernel.org, AJvYcCX9r45aLPpS1tl0WI1I0/GskJbzyjoNanzKH169kFir3u7xBPc/ycIhIIv9+TDNMueHG49uZaohxFTSuuLs@vger.kernel.org
X-Gm-Message-State: AOJu0YwqB9oHEZ8KnpskJj+kDBN//L/lLmmDdAd9ioSvHqiM+GMLEyg7
	AQiFUs43QA/VUsYu+b3NBpyDe/FawaIQUW8gX7O1+KNu96cn4kx/
X-Google-Smtp-Source: AGHT+IHbKGBuA+EAxRn/bKTjAwZ/cMAEbkBNM60vx74Q24qVyty3SApZob0+FbTm5Ul8OtxMM30rjg==
X-Received: by 2002:a17:903:23c9:b0:206:a913:9697 with SMTP id d9443c01a7336-206f0612ef6mr82267335ad.43.1725804026367;
        Sun, 08 Sep 2024 07:00:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm20379895ad.91.2024.09.08.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:00:24 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jserv@ccns.ncku.edu.tw,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] bpftool: Fix undefined behavior caused by shifting into the sign bit
Date: Sun,  8 Sep 2024 22:00:09 +0800
Message-Id: <20240908140009.3149781-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace shifts of '1' with '1U' in bitwise operations within
__show_dev_tc_bpf() to prevent undefined behavior caused by shifting
into the sign bit of a signed integer. By using '1U', the operations
are explicitly performed on unsigned integers, avoiding potential
integer overflow or sign-related issues.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/bpf/bpftool/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..ad2ea6cf2db1 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -482,9 +482,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 		if (prog_flags[i] || json_output) {
 			NET_START_ARRAY("prog_flags", "%s ");
 			for (j = 0; prog_flags[i] && j < 32; j++) {
-				if (!(prog_flags[i] & (1 << j)))
+				if (!(prog_flags[i] & (1U << j)))
 					continue;
-				NET_DUMP_UINT_ONLY(1 << j);
+				NET_DUMP_UINT_ONLY(1U << j);
 			}
 			NET_END_ARRAY("");
 		}
@@ -493,9 +493,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 			if (link_flags[i] || json_output) {
 				NET_START_ARRAY("link_flags", "%s ");
 				for (j = 0; link_flags[i] && j < 32; j++) {
-					if (!(link_flags[i] & (1 << j)))
+					if (!(link_flags[i] & (1U << j)))
 						continue;
-					NET_DUMP_UINT_ONLY(1 << j);
+					NET_DUMP_UINT_ONLY(1U << j);
 				}
 				NET_END_ARRAY("");
 			}
-- 
2.34.1


