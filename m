Return-Path: <bpf+bounces-33986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637892911C
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 07:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4738C1C2142C
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74E134A9;
	Sat,  6 Jul 2024 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SHVd2YsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B217753
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720242888; cv=none; b=uSX/4BDvkoWw1MaXODq0jPCh+iaCiUy50mt68XxCILDKx7HipsmlJ9csYLOzJvtRQhnLbw7DjFlYMDVMklLYlhcTyd0ub4+wvjbOtO2JZJkRBPS4wig5LHiQlnOMTMQEa8Eaov1vfDk8m2n/wDfsHyu19yCG73RjY1uresZ1R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720242888; c=relaxed/simple;
	bh=mgf18Fc9En0jFpIVsTgvmKPyThGPCz/ikS0vOiSXnio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lnw82m+3yY6ki/f63o55CrL1Bth4V6GJE2RUvrs/9jE0u+z5JIldYCfxB2eJVYmaZgGyRTc5gVXJCnZtM54cfEiG3j2NfgCso8vSXpav5BT/X+9jU2RTBwnZ8R1UGQ3oPsTjX6HSXgys6nAXavlFNOUb8CnYF91jFIMcXoWB3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SHVd2YsX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb1c918860so22492715ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 22:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720242887; x=1720847687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Giw87SQe8yuf6FkxysGSg/f7HoKphY0bMqQbHsvLA3c=;
        b=SHVd2YsXu29HYrL/WxV6hSu7V8Cpe4759sOtZOXD9ergNdhjtWxykVop8QGOY5Id50
         NDl034feKXh8we1mv5Cfka1WktjrJ+KqbqtBlOYlXxrxSwrunN2lUNc4Q2x14S3/028d
         ZzGhzm/jNlhOX4ZHodzODcE+256lAGPktuBe0RJvOfQ4fXSk0iECzH8LXtQXWuBAAiw4
         qWMraRENifRlWK50M9F8fAEZ2wT6lvJIfif2QIZoKZgkC44Fzm3cv38J9DnE1v0zNHYw
         RnelGw8A5yZBfRmBnUmEs8Ji6U2lvteKq5FDUncRxIp6opy5OA3hUKRtq+Z0VJdA8Jtt
         gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720242887; x=1720847687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Giw87SQe8yuf6FkxysGSg/f7HoKphY0bMqQbHsvLA3c=;
        b=Ua4izrl0VIlCRqe2smCIbC1BWhAybgpSY6rf41tnW8T+M9F6A6pZBaoQrmF2B5OY7a
         LEXmm0V5ZGub1QJF5JxervBj6/HEZ4GdV6HXsw+aTO2uXsvvO4v3CD8whzAZ2zqUe0s3
         Qval6NHdLdPb9Nc4AUS8wHyZ7Ko7tpZB4hfm64XitaY5Ey/rEDwi0UCZdBDFX6Pt2juS
         KmV9G6o+P8pXtynJOPHmGKbep1688vgVxl9itxgjfR9J+mSzakJAl20RRJps1NeV/Nnb
         HsAOizRFowoxGQpYSAxFALMVOXyjNCkmxcNWK5eLhnCf57LvWhp3IUASjSOHqERMDkjl
         AN3Q==
X-Gm-Message-State: AOJu0YzFGGVUeFrLV+kUsQGW5v7OSLLVM4SEXLE97IYSu7tgp1GIjRNl
	L7TQc4m2fxTAI5BJna/P69ZCalEbP8zD1iNj6TRTsmqFgZNddnHppAujoPbnhVA=
X-Google-Smtp-Source: AGHT+IFnQuT9OJyrEvKbkFbzI3EZR1voDmFuCU345bHL7OeAXzihbf1UNVrtwjUCvtnM/QKF/0czFw==
X-Received: by 2002:a17:902:d58a:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1fb37055ef2mr103534355ad.18.1720242886676;
        Fri, 05 Jul 2024 22:14:46 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3dbd7dcdsm34174015ad.157.2024.07.05.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:14:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH bpf-next] bpf: Use max() instead of max_t()
Date: Sat,  6 Jul 2024 07:12:46 +0200
Message-ID: <20240706051244.216737-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use max() instead of max_t(). The types are already compatible and don't
need to be cast to u32 using max_t().

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/bpf_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 976cb258a0ed..f0a4f5c06b10 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -779,7 +779,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	nbuckets = roundup_pow_of_two(num_possible_cpus());
 	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	nbuckets = max_t(u32, 2, nbuckets);
+	nbuckets = max(2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
 	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-- 
2.45.2


