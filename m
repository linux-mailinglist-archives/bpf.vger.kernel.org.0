Return-Path: <bpf+bounces-58183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A7AB6A12
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD9B860DCC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609926FD9D;
	Wed, 14 May 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF8oXD5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E61C3039
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222347; cv=none; b=EfAGQbMYJo/0nTlFBE2/AjqbJcBy4P+Iu+p0JeXqFXGk9iQNgv6yQyWvLmY7td8okjwnaRVzocJ/AAfIL/1OdiwcJquXKRONCYxxyX7w9+Ep/3yTirasQPyBQaiptz6T6auTUcDotrCtdoIga/6bZWOidgZVOqoNUGrobwpfTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222347; c=relaxed/simple;
	bh=9u0Zrk78xtJRVRLoqtQVWVy/MqKJGwJdC1HR0QL2tU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHTxPd8javDVDQG+LyhJh12tLoWfbPN9XFdJIU3w4Zu9dVcgmZNcmZVbX0y8x61+dw05URNHTI96XLy5HUPJRgajwW5f/gJXymmIrMsf90zLIShkRseEoFQ71FJ2LaGp2/NzSIPRV6ieXXzV52mtVD7wZN7egFeoWPUYIywbbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF8oXD5C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so50235755e9.1
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747222344; x=1747827144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHin4y+EQSfaJNRtH10/xinA+K7es66RR+eudItexas=;
        b=TF8oXD5C83Cti12pxB6NP0zSN+ijmR7zB8+E8oNwQ4XNzyVZoyO+2rVpm4yKQR4QtY
         hJVqrvLPbFTvviOEZV4VuVR7J8VPfpuuD368bFg6bKBg7pVKueYg8r6G0nLX7PcGg8Ko
         m59uyRGh76yFEQRYqZkiM9Vveeg4bs5ypj4j7vsibeI72ntc64IuP6P+jBgq7G/Lfh+l
         G/b2HwcilfHIbkIIjphsbwXqLoi82LYxlUcwvj0oxPmnh9+8e7OmussG7/Dtkb2KY6/6
         N4g06beZRp5MaCMTeBB6X2U9uH0UmhgSoc7n4c3zop3bBskUiRntLb7IDrMe3JLQTIyN
         h5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747222344; x=1747827144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHin4y+EQSfaJNRtH10/xinA+K7es66RR+eudItexas=;
        b=E08nskcCFX64JzKmQwN0fDMK+ZdKVGoXrXsqpkpj0cqmsESE11jObvW5cL4rIdoZOx
         v5Ie2ucZljrLWMVICiErwkXkhuyWYZbDXVWGo4ptiajLKgOd8F0wILxwRLD2bFpDXdnc
         +IlHJSCUHMcQ3sB542EThzcvk2OvARy9y198BdKhaZQSMGvFKbRjCGQCS4pqqrORYYlk
         IeiTyjzwyiV13H9ok0GtPCSVCSg5RaQ+z4kC2424yXymd9yKi14PfW8fwvQsHMtvKPrF
         0IIrAZvZtfA+NW9O/cmU+UbQgr7SL0rSwm5jWWpjvBn3iM67oZ8mAmmriQ48B4U3XZ38
         LLeg==
X-Gm-Message-State: AOJu0YxFyT/nuIloP0NdXJ1Mfj/GOpRBwSixLDLxMULoI8G8nDKgYvhI
	AtFbdXUge/RZvUoSfZgzMJRBGG1kkISnhQ1NA3KiWKkzLsQ+PDAPHPaejw==
X-Gm-Gg: ASbGncvQnh+IMTA+CJ6Dvw1aFt0NJ+5m6ws1N/CRplBu+2zFYcTpWbUyUp1L3rknfqL
	UOOYB2WzST+gOnEEAc2D6bOVn4JLNOa6gubszCk5rUoTtQqQk0mJh7Go4XSGzBMFlKfjUW5PNdh
	vCJ4nhj1/isk37vzhL3ZrJxBYboefVClnmmXIr6EEcYGdlUv7hvAUqmSfcZehdAo3KyRhFy1VdS
	s9v5tnNJ7gthqVwfc2UHl15Pt3Hvai5fLs4N4zxTNBaK2tEf6TwDqCbBR6FIpQWw/GlmDyZHF+b
	ypA4nQJoTyPhmBetmcV+3g2tr9S2lBtTdvskFnGUgYuK3Xi1eWENBmviP3m5TE1Ig/GvUMKYJdI
	2kSXN
X-Google-Smtp-Source: AGHT+IEwyuHDq97AWvRYMC9zLIuWdKMo0TW5JBoFC0+q8/7vdk30nbIZC3slnH4EQODQpz1BjDZnMg==
X-Received: by 2002:a05:600c:a016:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-442f20bb627mr26817975e9.7.1747222343993;
        Wed, 14 May 2025 04:32:23 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ceccsm19642435f8f.64.2025.05.14.04.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:32:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: check bpf_map_skeleton link for NULL
Date: Wed, 14 May 2025 12:32:20 +0100
Message-ID: <20250514113220.219095-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Avoid dereferencing bpf_map_skeleton's link field if it's NULL.
If BPF map skeleton is created with the size, that indicates containing
link field, but the field was not actually initialized with valid
bpf_link pointer, libbpf crashes. This may happen when using libbpf-rs
skeleton.
Skeleton loading may still progress, but user needs to attach struct_ops
map separately.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 617cfb9a7ff5..e9c641a2fb20 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14102,6 +14102,12 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		}
 
 		link = map_skel->link;
+		if (!link) {
+			pr_warn("map '%s': BPF map skeleton link is uninitialized\n",
+				bpf_map__name(map));
+			continue;
+		}
+
 		if (*link)
 			continue;
 
-- 
2.49.0


