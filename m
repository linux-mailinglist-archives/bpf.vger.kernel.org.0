Return-Path: <bpf+bounces-77024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374ACCCD29B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CAB0303BDCC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C230E0C5;
	Thu, 18 Dec 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmg5qzPW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FE2F5485
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080612; cv=none; b=utNrKIQlnVmTXKvztOXyJOulNEU1n4Q1C5Y9uyNrEagPOXHmZP8DnM/JPzm6+sA0shfTYTR6Q+eTIe3dSYeRArlIb9RBEg7HKiLjavQna3IaSEKGYVOMHRwIc4Gz6QqvhxmmcHYUeG3GdHqZxGpvh83Su38OMvf/Z7iYyOb7ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080612; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7bSx3Uw+MRSWHrRrs85OpUs4DJRk0sE5Lbl3naE8mkvwtLSgxqaN6GXvl+t9RSODR2351qncXDz6mEoBx8neVBLXK1b9M8A0YkZgIuTDeSdwSvpLr6QLan0llamh6xaiJAfA53OfsZzXkbsfqXu9/lHs+2Tvk8WUrO8V17OcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmg5qzPW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0834769f0so8611985ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080609; x=1766685409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=Lmg5qzPWNdy+3X74kgwy6dIAUNjod6ycKO7PHpu31yrEjhKLTy83jOyIWulobNfCc3
         vxIYU+SwoVtKIMmVDPt9t3DVceOYGOPpuuQ2JPCxr4TdLprbNBNFiiRZIcza+wLjlhN7
         RVYbAp5YwDxRXNQrgiBFiZQOLH35xvH5ElLw0wWs4W0oU3D6sgJIfLNgKLSctTHNQaNL
         iIdmfqVwcVUp6QKyXv0pHOBc/5t+bvCFr9HYscZfA+SmzObgzMIeQRKEz9wIm8ZZG4s2
         tgQHY7fgW5K5vwTzbwcs8CwXENCWeYZg624KobkZa8KWOh5Li7P/YE5rE8xeXorpOY3t
         esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080609; x=1766685409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=UvdthvFIOWDfuYE2zMgdYle9NNcQUVAclqX5ce9MYlSdYygo/h2zh9U6bsTP3ScWYV
         XUsSnhpFGaVH/TkYa/YwdMb9+u7a5L5zd3YB7whMNMwXX2H1zhGPKGp/WHs8BwC1Owzs
         kp4GxxLIwRFVgl/C5l2GhHie1NYq55nz0fKfoAKlUGFZOJNpXmMow/Hg4v6U4LZg3wcL
         soQ9CuCSs1rO/GQgKgrY2ejKtuma74VZPivv8g5ITs1iXZMZqnEQzxgmtHxZfPIPTyYe
         FZDuHjU63xBGNeSl5WeQUJBLUhJrxKqExqW4JPjs1UuqLZo8LXYxevoe+siG1L1pG3Hq
         mXJA==
X-Gm-Message-State: AOJu0YyD19UfLKVUL4LLkBXjBSVUyJXGAuGwkQCErMHi/+PFZxrSMetm
	aL4oZ/cbOaImKT6HwqWeJ0cJEYq6cedMF7Me482yJFTD5Y/DnsAg++oP9rf3EQ==
X-Gm-Gg: AY/fxX7yeW196F1RPZIRdUgY6a2Ivt88HY1nfUGa4MO22q5OINDhu4AhcLHxIF1eCvF
	eFNHut54c+xRwNKzLXvsUVoHAZZxg1tHIEBfUIyG/IX3ugceQhy37OVZUZH85+cuRW+CSjOwLbr
	Y2SxV/rlJ8Bp68wqhW6RzWBdGY32vhS5o+xP5oIF7ANTTCK7fGu0gvg1TuL6F6lxptcZxcaMC3j
	/lmpu9qe8oe+lkvqq8VpaVnF9hevgNV4GldS6l9KdORvuwohPFsSc6UXo9rY6nWXaNfS5+cpYgH
	1l/FIlOloi0CO8vvyw9KHfl76pfcZ7MftVhJ2MUlwfSUCHY6v+kFoExxoqAu4MxnSCQhdVEFH+z
	b1H999M4l8E43c5QzrTLFWNA/bTm8CgxfGAoQMGb2QDASoA+CMtimuP+FGj5w5Jp3SDcxTIBJHw
	a/Gb1kBqICPH6W
X-Google-Smtp-Source: AGHT+IEX5gBjqW6w28GPiBH/FtYGs7ySjffOR91L2p+J3IG4qzC5UlZVLnZrrs86GFuZNUn7N4v9Kg==
X-Received: by 2002:a17:903:320e:b0:2a1:360e:53a7 with SMTP id d9443c01a7336-2a2f22229f9mr1244225ad.13.1766080609299;
        Thu, 18 Dec 2025 09:56:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193ce63sm31901615ad.91.2025.12.18.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:48 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu, 18 Dec 2025 09:56:26 -0800
Message-ID: <20251218175628.1460321-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


