Return-Path: <bpf+bounces-66045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFADB2CEB5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A721C265E2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903912BE634;
	Tue, 19 Aug 2025 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWTLHEYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A37FBAC
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640287; cv=none; b=XK4grqFEVThuubf57mytAJ1oDjqWGasnVufCWsEX3GBRY/hSxB3+gG2GYtqLPiBf3ufKVhyLfjwfCYbJVxoVIkE9TRU1C++9+fBUCDgeN136VcWx2uByfzWGxbXWJtNeAg5kpiBCTo8bbsIPZav5HoAtChJHeF8px2XRBu09eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640287; c=relaxed/simple;
	bh=GVxI9+luJ3DExn1h9rvBRgP1AthzHOkxa2B6/NLHs/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUuGWlIS4PEHaYbBN6noQyheVdZq8Kchvlm05CIzhCMAoVNx5lXi1biChJfWq73Hq/stRxgdCtsN5aV4Qdmu6mVybAcpubZFtV0Mmq6lLIIbk6Z9R1QfJGzFdvlG+m36DiZ0/mle5BVfjfGZzUGt2y7KDPMmkNcWHFHgfTiYm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWTLHEYg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so35976195e9.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755640284; x=1756245084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHKM5+ozAkRPopxKG9hAAh5WpqV2sFtyfI75BRb+oes=;
        b=LWTLHEYgdxkJkN7R1NbgKpExK6dv1w+0vmkM0pvq2ZXOIvC/FQFNQ9KVLPxTHTOsl0
         2uQlr5jI6hVq2QvDvuqxHm7TMMY9KFaJ9ANHb8zr7y3YQhugdHSzXv3X8UGArewGJcNT
         EoMKbkN+bkzStw8cjNUrj5MAbP4FQoUd5A3L2UN27+Lj/EWFh/EkG76vA2M8agFj3/es
         5mDTgW+v1wdzxOojLLBu5liohgpzHjvBMc4AL8sQ6JdFgHamchzwQMOj5gUwe44o8tD+
         JAuiMR7Hn0jWS8lEl4/Eln6J5OMjLQebeoYGoIR14eW6TAjHJfUhHenCK+t5q1btLN2m
         Mn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640284; x=1756245084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHKM5+ozAkRPopxKG9hAAh5WpqV2sFtyfI75BRb+oes=;
        b=M7XmtTeZUGA+iOZGRciSPwoUotv6aRwEHrbDXih5YxY64Ity/tuaM+lYmnm1FcwAAS
         MuxE8rgNqTX8CbdPkrtBf3XCu4/pK1EOqbyNQkCnTmXbsiqsa7Kvd80cfo/GljZLKoHh
         KToyDxjO/H37zgGxJ6arbQ2Ko/4a+JVJ+qn8/pL/Q408YHlWFPiGtys2Rx9y3fsvHZjC
         vbIc7lyNQTb9DLwcp5q87MoYa6c01PdUqapZxGPz7bp1ilGa1XOiuR5v5sL7PssIBQEo
         0z8QGHXi7eUBYOEGO+kcAI6ACxqPHNQAc+t/hKw4knLHlWtetAfdRLT9IlQKKltvOPmP
         5HlA==
X-Gm-Message-State: AOJu0YydWHoLmx/kzkPc41EVFQQEaMTUjvkuMFeWFEo+yzew0ZmWR7P2
	4zsJxQFVwSZIAilSv171dseD4ARpW+6IVHev3R17ndIgcmw5Z1MB72P7e2cOeg==
X-Gm-Gg: ASbGnctdQtfSs5BrsLWqdb4HXnEANM2yB92VX21YB2T3daLN/utHCajfGWRrBnmwKvR
	TmSX6tc3iOWj23b9EGlL8udgpSMn64Aa64jwcWL4eZV27NFiJmzqeC7/f53pO+4hFrrDRB9D2NJ
	A8Xo/B/tYTLFlhOQF0JELj72s+PdXHeDG2yLhJsROCKimUFzUsxyIsBsJIbB6/mM43LBsQUFmAQ
	ZqVQJxfBsX2aOEytCBgEX1GkZkTv6WqJPzfC6WnBvmY+M7qcGG93/1n6n1OcemB5+ECIgDyZuTI
	Z/GvY9r8B4fe8dB5PbJN5/MWjOQVutgLF3jiIK6gDnpokEP5Ks4EM4x2o9OP8ujR/ZT9yWB21UV
	af4fEGywZkijpsefUEbgl
X-Google-Smtp-Source: AGHT+IEcYPTiZ2yN8xhdMlUPAqZ0oIER1bj/HMo4Ru9hCVDl6VPZc9YiE/3tVqbXJSj48uwN1E/oOQ==
X-Received: by 2002:a05:6000:24c1:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3c32c52bc28mr327114f8f.13.1755640283572;
        Tue, 19 Aug 2025 14:51:23 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43993sm5233702f8f.20.2025.08.19.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:51:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: export bpf_object__prepare symbol
Date: Tue, 19 Aug 2025 22:51:19 +0100
Message-ID: <20250819215119.37795-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add missing LIBBPF_API macro for bpf_object__prepare function to enable
its export.

Fixes: 1315c28ed809 ("libbpf: Split bpf object load into prepare/load")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 455a957cb702..2b86e21190d3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -252,7 +252,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
  * @return 0, on success; negative error code, otherwise, error code is
  * stored in errno
  */
-int bpf_object__prepare(struct bpf_object *obj);
+LIBBPF_API int bpf_object__prepare(struct bpf_object *obj);
 
 /**
  * @brief **bpf_object__load()** loads BPF object into kernel.
-- 
2.50.1


