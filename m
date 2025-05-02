Return-Path: <bpf+bounces-57270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE6AA7A03
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94DB3B3922
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D781EF388;
	Fri,  2 May 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYfbyf66"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233A2AE7F
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212787; cv=none; b=cu5vUAsHs/F+an4jC8OhBLl+3BiraROhmaxPJf+PBRP57R9an8IVU7B/o/z2Et9MPXUAr8pOEXpV+1/arjP0A+FGI7IPXBvjzZAJhyZj0lu0ZUEqJpUC2fuNb12bMSs/WU01uVQEKWi5qxRgwfxkwFqeU06b3/EirtNfvD4gVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212787; c=relaxed/simple;
	bh=Tzrs5yE8xgNltNIMZercDTNuOxZVd8MaAQyrEmHEs24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InfwG48gRojTxOsdtIFvz6m62Le4OgAZUizoknWY72oJzo0cQ0EvTFYA4wrLlI2T8jD8UAYihaYYPGPmoaOWCc7OSxWoqS7tqRmwgaCVC0EcumZ0XWaRjXVPh7W6IMupY6/GlVIrftUxyRGhodMwmBzxEBlJqktn1bJSSDfYxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYfbyf66; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso40634735ad.2
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746212785; x=1746817585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv0iaTi00kSphVx8Glo+W/kVn32sEiaFZidUcg2VByc=;
        b=fYfbyf66BbOs07JRggB/QEagt2BD60uU983bnpGeAgk82qrefRfmZd/ZLgFwAIStya
         1nZ9FHnf9ufeMWf6K8FFl4LqHdKkEn9umjiJvyiXkYT4X/RKZOIwPiUSteFpQY4FbDWI
         mZ/NuEa8tBzXJtBprkmEpbjIWc0TF7zoIAx4lNp0wdtA4hyBmsHfiuvxdV0Z1gmzP7J3
         j/uqAhRmhbUweKHHreppqusWmkK6XDb/34oF8hecYEX9MLP0HF0A8nYYuMADibu7N9DA
         8Zi78SRFCU2YUu+EOKlzY2vDAI6ak23+Ch3APTEHyIrLn2Qn1VeF3PyQ5s3Mszqus+3Q
         0wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746212785; x=1746817585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv0iaTi00kSphVx8Glo+W/kVn32sEiaFZidUcg2VByc=;
        b=wUDDCy+sCTqTG0/dBWhAyy7zTazIeYQsODwNHtbB+YK3fyVTxN6aYUzwaSGIlRUX/X
         CCwKoq28kjlJTT4Imv3ZKWWYCb2c+5JdwcZKB+ljuUQnKJP5OqzPyx+xsbd/gvdTWuN9
         P+BQhCnbjmFJSZSqjem8uQVKo1Wj0WkbQymReCji91B/4bKdoQhpqwgm93BBmoFBnfKt
         lUozRgM4OGyliAkkAGN9T3+gvDsezRICFxabIO5MwE/Oe+LK4TUxJ+/hz/jrIpB7edZ7
         RnnYxYS15sBPM2/LynpphaDfmPMv9j5N5qplMz/wJ6rpxTO81V3i0H13INqxNfDCJVrG
         magw==
X-Gm-Message-State: AOJu0YyUC2ABuJ/U51MOysoypisSOR4GY/VEs8A6O2SscRLNW6UBjQsz
	lfxQRw9POm8l0AypCQ7q3nZVwsKtgGJjvs/xUDE8Jj/8u7pW9UH1jphb2Q==
X-Gm-Gg: ASbGncuSsaHDUcNRkQ66IHV55lXFFaUVOJT2vXF1gIpYwS6a+K1LUg43DjfDLXp3iR1
	l0qzidGm9dpNYqxjEKn+DpBideJbGQqnmwgRVk8+AbP5zstJLzpZ+jasR6e5pIJA3Fp1kNSVhnN
	My5GbSZgBy7ujCX1mbINz8pcsOKl+8t1Od7riwgMdDCUENyflIg8Khfb/UZ/fddBNeiANaDL+HL
	poC10YH/8WkXSfFJabPMDz8oWxKsdH4aALMa1C6mWK7UBKxtu2etUGOno52cYG9FP3BWFwRwLct
	+UwjyBbWmXBD0h++HhOJrepUskCo2M/o7z1NIH5A+n2mTxLcvTx7aNA=
X-Google-Smtp-Source: AGHT+IE8Ja6Q/eOJW73gO3+UBkKsfpN/onENQRL685YDAmWfepHYaq+ni1Fe2+9bsKbAEkxDOV8McA==
X-Received: by 2002:a17:903:2444:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22e102c6b64mr65964535ad.14.1746212784658;
        Fri, 02 May 2025 12:06:24 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c090:500::6:9b40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150ebfb1sm11426265ad.11.2025.05.02.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:06:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/3] Introduce kfuncs for memory reads into dynptrs
Date: Fri,  2 May 2025 20:06:18 +0100
Message-ID: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

Mykyta Yatsenko (3):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs

 include/linux/bpf.h                           |   7 +
 kernel/bpf/helpers.c                          |  14 +-
 kernel/trace/bpf_trace.c                      | 199 +++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
 6 files changed, 432 insertions(+), 3 deletions(-)

-- 
2.49.0


