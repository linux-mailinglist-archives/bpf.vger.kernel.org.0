Return-Path: <bpf+bounces-52898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68AA4A283
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807E189A656
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256301F8735;
	Fri, 28 Feb 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3/f4zux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10F1F8738
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769994; cv=none; b=fileNJmHCD/R2MG+WP4rIuA4+5RcTKt239HEoy9/aRM3Qt0flNOoTIx8+dprMdnsf3bfAXoYpMNFbu/nQzmfYGSfRDhPofr7j7E8mhglgFNQrwK9HFSJzjGvu77+iJn2mj16JEaN9A1nbC1qc3/8o3Am+tYRt6/g3Ke3vF9ZDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769994; c=relaxed/simple;
	bh=osCYEAlbfSRxqqNILnuDLFHNygE3ovjFH5MJtvBfvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmBnPrGHFlWBg8g/+rcF1zMUeHlA+sserMjWZ54I9L2Fz4iesHp49r/zwY8CCJ+9PHNdLn9RSevBi5oZx9I0S/wbrg8CX6WhIx6HtfG1ksR0k2nNgoBLco4iMiXI69fNmIJFim53XE2VdPMWPI9/ZJ0uNcqyVliIKc3jfy1594Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3/f4zux; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22359001f1aso53764025ad.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769992; x=1741374792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC0Ai0+M/0I/N4+fX5lpWGqrY3EYZEaa1GcWjqaM41E=;
        b=B3/f4zuxSVfUmd5UiD6NbQ9uIBV704g3BeNK0BPgD1FQsdoWGsah9l9UGDiwBvoNoz
         9BGiy29qsy24uii0Pou/c9ta767xQa5aD5s48nVlD/19BoLQwBMY2CuXCBHu4+yW6wgD
         Dl4knC3wEijnYeQJ2tdysVqzMFlQbxIVX3XHheB8YxhgxXbgdiYOVV/p01u+3gIW3cWQ
         Ze+4h+fhjJHiFOGEQD8H6dEP6WWkaV7f5kpaTDakVDUZXrR+8C/7ngcQpx1bUiaEy8XG
         PnTti82AzUIdHZUiBrfySz5SBteg3J+xYsRENyB8vpNKaTd5vG+h8PFoC/Pk7XmJ7HPX
         I/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769992; x=1741374792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC0Ai0+M/0I/N4+fX5lpWGqrY3EYZEaa1GcWjqaM41E=;
        b=nSmAkVcjyZq2qbcZ1CPsqZGEbLg9YhDMRdwJXXVwnMpPc1Frr8RJ1rJVFfd4j3963d
         9Xhnu+OcIhB9Fld206SoZkaMm4vfhqJua6u8W8NaRzKt6NsjdGVe1/8sM3HHwKEpq01D
         GRAkAfp8mBgyT8FzNK+rqCFqj+oHSnkowfyP9muVmINYtoqsb4ojsNmtuaCThi3H0RfI
         hgDjkmlOohWI9QH6HrcWaWlk5Xm2hyeQ+3DyXbe9yqkzaV7f5PUy1D9TYQDP8hhav17N
         4RGnF5qbXvvcKCxo/AHMnuWjDa6EKasQs3blW5tteZsFKOVFkWvii9bBv0MLPo+nU1VT
         xxKg==
X-Gm-Message-State: AOJu0Yzz+MCalYTAexFjrbie82TO6/XmdRZfL4qNUmNbQ0K/98ZvKbyn
	lpQx+DOx450fUc4CVg2TKJceDMTktQSU/gBbhVhjDyhbI7Oacrom6rcrDw==
X-Gm-Gg: ASbGncuzC9jAltRNpPXHL2m8uuUAdT2YTc7El9R446CIyk6xZrzdyiUmAzhcpkShpXP
	LM3q3LAJUFWoTYjedOWC9BkHWTvw7unTwHrqrQXdCS2B4GDuWknvM1dU04f6FmejhESeDeHYQDN
	iAjy/4cML9sxauGkzz98Ri4UI0Hw1MjbTE7M3wQf/q8hXqIeFT4+Lu4g0R82xHHKFsNGMmbPD1L
	yGazW567lS7qCgBUcx6ZHy0WMGDtJEBT1EUnQ0zzykeXOhhRsBlEvZOuPuZLxXOx/J5UKw3MXZ5
	tf+UVgdVJQauhbFEZbgFrw==
X-Google-Smtp-Source: AGHT+IFwONeJ5vKsBmKq1J/beotiKCscCBI4WVIy9Vq/n8f8nNQMut6ICfLdToRGbRaGAcho6rzW+w==
X-Received: by 2002:a05:6a00:2e11:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-734ac3d443emr8296033b3a.19.1740769992435;
        Fri, 28 Feb 2025 11:13:12 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm4228799b3a.50.2025.02.28.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:13:12 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 3/3] veristat: report program type guess results to sdterr
Date: Fri, 28 Feb 2025 11:12:20 -0800
Message-ID: <20250228191220.1488438-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228191220.1488438-1-eddyz87@gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order not to pollute CSV output, e.g.:

  $ ./veristat -o csv exceptions_ext.bpf.o > test.csv
  Using guessed program type 'sched_cls' for exceptions_ext.bpf.o/extension...
  Using guessed program type 'sched_cls' for exceptions_ext.bpf.o/throwing_extension...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 7d13b9234d2c..3a9cfc2bfae5 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1234,13 +1234,13 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 			bpf_program__set_expected_attach_type(prog, attach_type);
 
 			if (!env.quiet) {
-				printf("Using guessed program type '%s' for %s/%s...\n",
+				fprintf(stderr, "Using guessed program type '%s' for %s/%s...\n",
 					libbpf_bpf_prog_type_str(prog_type),
 					filename, prog_name);
 			}
 		} else {
 			if (!env.quiet) {
-				printf("Failed to guess program type for freplace program with context type name '%s' for %s/%s. Consider using canonical type names to help veristat...\n",
+				fprintf(stderr, "Failed to guess program type for freplace program with context type name '%s' for %s/%s. Consider using canonical type names to help veristat...\n",
 					ctx_name, filename, prog_name);
 			}
 		}
-- 
2.48.1


