Return-Path: <bpf+bounces-44938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A158B9CDCAD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E50D1F23429
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513B18FDDB;
	Fri, 15 Nov 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="fEGi9A2t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445A18950A
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666883; cv=none; b=m7+/3gZRSnmJ+QQx70vpnjOqYEUtleTKz415Lyc4S20oW19OZ25KCeUC4i5XTGKWfhCSOpkarplY1M/iKNfpQjhKq3yN5KZM6RIC6/mrDrrWLj51FGRcz0z3jwUv+bAC6XEIbtqwNCrnbJCsyY9pG8oPBtqbu5lD2ZR8m9FuWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666883; c=relaxed/simple;
	bh=0k5j4H4ThGyosbeAZR4mh0eRqVc7n4UR16sQfdLyedA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd6f2Ih1p5tZlIVe4DIJokrY0lb8pONSnBJVUlMRywBHgyTKR4o0UHJ1BmPF8+K49QTEPsfsdfOCxSRp6RuYy/wZ5+AEgjX2mS/M3W9NZpYcuMSFPiqLO08LiqOs6VtALSjRUvqrbnOPnRCYXKZICIZH2D7BkG5c1TGH7mgU1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=fEGi9A2t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c77459558so14905615ad.0
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1731666881; x=1732271681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCgxJEtdxcQBWvgHN5JlceMQQr3Zip321u703iLLdL0=;
        b=fEGi9A2t3o455S77tsQS3cBkhSd9nJEm7y32uh5DFH1DBAdJpu1ZIl6A7dT4Dy1BS8
         F2/F6sOxp/LXFqb0mDzejZQAJ9xd7Y67qTUQULjvIKicz7I2lwBU4Yj2jrQxNfqaN773
         YAyklu8DAQfrNJ50ccYTCapqC/R+IL4q3nbtYGkQG6M5hDCvpG9K6QeEFRYkjZCHeVJr
         VjAxJJr9BmC3hLXH53aDVE4Nwpc7RP3O+3nezKujUf5IHkl3YIBC9OONX6yQaDOh75A/
         mznqq2epMZ8oIyf3AthAUPk0zAXsjiZYDnUR0w6i5k1TGiKdRTzzgGk37TcEj/7ZLq90
         MXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666881; x=1732271681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCgxJEtdxcQBWvgHN5JlceMQQr3Zip321u703iLLdL0=;
        b=g7p+ZIqgUT9wZJGbxKBxH0/Fqxcd24TKk9ttNVXvUTrqPCaiKqRRHcEjXlYVqEPh/u
         MDJkZ/UJSDq2oH72Y68BmXkU2ZKd0NLTf3ROlzSQ+jZ6DNCMPYwRXY5jKM1oC7gyjdGi
         CI2u32td+Mk8GtFrlJFy/1zV4+bmf0B3jdSST3b1wvKq8ew18AZuCkePd52nIJhwxAS9
         EqrMdcyRXnbKXME/NhY05PfC4EWLLG/BgaWTFD5hg0+GeytRWY9gRjMCWzS8e+fURiV2
         oznnXUT4kkzWgVnKi8gJmaNjejUKnxYgySE2mdZDRfk6eOmxqtoERFzx4r0RKvOKQekb
         uSzg==
X-Forwarded-Encrypted: i=1; AJvYcCXrihRz7xMjUBJrF49OWk9Y0lAxblQ+Dkfw3rpdy8XzQzNrpcCaIG6N5aY7XE2wIpdBGLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdka3jszv8AR4BEM6DUPr2/dVlEgSSQR/F22vPGPg5HthhLc0
	myqjcj3jMZPyLOE+jvC6Lsb3rOLTElyHl9HoKyVpn4A9hXVMAPBqLHG/q8bWJ2o=
X-Google-Smtp-Source: AGHT+IGdmb5QMtEi6lF6HVCbZpuUNSUsm3Dwd5WKiUob1G+Fjl1XkprbRQ1GycAsAJid0oXqoEgdtw==
X-Received: by 2002:a17:902:e885:b0:20f:aee9:d8d7 with SMTP id d9443c01a7336-211d0d81e71mr34790435ad.32.1731666881434;
        Fri, 15 Nov 2024 02:34:41 -0800 (PST)
Received: from localhost.localdomain ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f36dbasm9519345ad.156.2024.11.15.02.34.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Nov 2024 02:34:40 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH] libbpf: Change hash_combine parameters from long to __u32
Date: Fri, 15 Nov 2024 19:34:19 +0900
Message-ID: <20241115103422.55040-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hash_combine() could be trapped when compiled with sanitizer like "zig cc".
This patch changes parameters to __u32 to fix it.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8befb8103e32..11ccb5aa4958 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3548,7 +3548,7 @@ struct btf_dedup {
 	struct strset *strs_set;
 };
 
-static long hash_combine(long h, long value)
+static __u32 hash_combine(__u32 h, __u32 value)
 {
 	return h * 31 + value;
 }
-- 
2.42.0


