Return-Path: <bpf+bounces-26343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F3F89E705
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C97BB21FAB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703017FD;
	Wed, 10 Apr 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwIuzb4T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15B10F1
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709724; cv=none; b=EkQ4ZQjSDR7Aex2ktv2tkO+8CyVnW4OG//6xXQaeIYhWa1xqpZ/ItwnEzVFQlPezSeJeY9WhOlzyL7wGOrMeZJo/fHBFvxHtWyTEk+jewtZycl7g+oNBTtHxREWuAcfnGW8AxbnBdqPdDPFswZNP5cpDPNwIXGTKk0p5nnINGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709724; c=relaxed/simple;
	bh=kYrFWFA7WneZwDQwTjX3ZgpxnvRnZ9c+6S58UYo6m/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNBYC71Yy4tFta+gW+ynvz3ayEbAqY33YQRpsp6LBmQkd2TAGJSx+lXkHhyWupbSMFCZOLcaKgxZUeVy8N3W/h5L+H6A04+K6aM8JCnoLGQEdCnCXB32qW17fONGCg+NZu4IBWhZHS4EHO2fd+uiuaqpvIFVL6dzs6048MsmYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwIuzb4T; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea0fd9ca89so1895605a34.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709721; x=1713314521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AqF5wMXF6A3WrrYWyUoEcyLqdmX7zmChx1pN+rJKiQ=;
        b=AwIuzb4TmPdv4Cp7wbMtPmF04MycQKCFYy9wOtrxBQEUrYaYdmzK2P5DGgvl28QIN9
         qr7PrjYeImIRRyie39uYvIL8Fv8btCpQIyiUqM5/OhR68Ueoq2og2fEsSPS6W/ETD0w7
         1ifIk4GBydAZesyia/YbppRT4eHV0591As6WPE17NQfpIdytmgIWWp9uHr9T/LJ2N6XV
         Zb+AEwhwXbr3lz3+TaHHqKG4c+1eDzz0O0pyhoqz1waGVk1wTXCzyerqKKhxWOwF0Ols
         eaip7qDsMANaQ+aZp/XbZguBEiqWxv45mmGY62fPOo1pOLRHTgTNMdVB2D+dMfjSMPu5
         uGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709721; x=1713314521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AqF5wMXF6A3WrrYWyUoEcyLqdmX7zmChx1pN+rJKiQ=;
        b=s+MmT6EJ/cioXlBeAgP0gyamSlATCc7yP07tR9ldghs5AtW+Wzwc2+san50c8InAVp
         Bnu4ec6Stmq8jRiqFz1I1WDyFrwD0mx8elM9VYzXoPLvg0vevhmRsvM3TjFbCdQUaUlq
         PplsEA5pQaUKAW/RbtVWFlZOmairqyNCmlWzCcYRySFxvEmBZaBxsDc0up5H6vEGlwnR
         A2nmzpRq2NepRJVzZRc14aSRNmoI1duLqJviRIclM7Ch2H4Gw4O3jRlIs7O1EJDjanX2
         FlC6ADdXDLs6OVPf4YN6+1vGAKmhdxFob49RSPzH+1hUEQAilUrUAKNXS/Q7HR5tRwFn
         P8NA==
X-Gm-Message-State: AOJu0YyfPgKsnSPUY8ln4iiTvmKxN+cyNbuzBapT6bk8wlMJdyl9LXd0
	6+p2aPX68LNd1DH/rr1i+AELM00Y799McDaPJaKgCxg5GMMKJN6Eqk+IYWVs
X-Google-Smtp-Source: AGHT+IE/AKpq5VO5YFQaddE5yZOpEH3kZrdSJEDele1gKiaZzBlvFVd/2H9Jp1x7b1CVEvtffKL/UQ==
X-Received: by 2002:a05:6808:9af:b0:3c5:f100:d559 with SMTP id e15-20020a05680809af00b003c5f100d559mr1178607oig.10.1712709721253;
        Tue, 09 Apr 2024 17:42:01 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:01 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 07/11] bpf: check_map_access() with the knowledge of arrays.
Date: Tue,  9 Apr 2024 17:41:46 -0700
Message-Id: <20240410004150.2917641-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that accessing a map aligns with an element if the corresponding
btf_field, if there is, represents an array.

It would be necessary for an access to be aligned with the beginning of an
array if we didn't make this change. Any access to elements other than the
first one would be rejected.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 34e43220c6f0..67b89d4ea1ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5428,7 +5428,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	rec = map->record;
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_field *field = &rec->fields[i];
-		u32 p = field->offset;
+		u32 p = field->offset, var_p, elem_size;
 
 		/* If any part of a field  can be touched by load/store, reject
 		 * this program. To check that [x1, x2) overlaps with [y1, y2),
@@ -5448,7 +5448,10 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 					verbose(env, "kptr access cannot have variable offset\n");
 					return -EACCES;
 				}
-				if (p != off + reg->var_off.value) {
+				var_p = off + reg->var_off.value;
+				elem_size = field->size / field->nelems;
+				if (var_p < p || var_p >= p + field->size ||
+				    (var_p - p) % elem_size) {
 					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
 						p, off + reg->var_off.value);
 					return -EACCES;
-- 
2.34.1


