Return-Path: <bpf+bounces-53656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3EA57F1A
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 22:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E684716B883
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73E1EB5DF;
	Sat,  8 Mar 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERV3JkaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BB839F4;
	Sat,  8 Mar 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471006; cv=none; b=ItRhkCm6TaB22nbkSsz/jCpLEc1dYQ5a8/A04GqFjGrh88i8qFQ3msCuvKLZYCc0cjaT4puY0xllk6amXXeTR3qIk4NIlwgZ3Cjifi4W8cye0h7eRhFlNsBcg9kyaIB1Qsf2IjHW5DpuwhBO+GPe19SXh6lFbmodUmCEtjoqPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471006; c=relaxed/simple;
	bh=8JVyvALdGhp+06JWv71Z3QRMqqCrXf5H4cRpW0QVk3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUjloK6TosiYICU9nko/w2UHcJPGakLq9Nq5lKmudiOkIn5Q1t2YKzM64xIqLTZbpbecJmna3CoXyruWjrJtWJnj+GOr6P2lxj0CETEueJDmoWHL04v7j0G4OG3sorw7QvYJnOIa2q6VGCCYhrSnTtrE1J6aQa6AjQJDnLZ9ZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERV3JkaF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbd96bef64so486412166b.3;
        Sat, 08 Mar 2025 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741471003; x=1742075803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy7bNbBQ5RijVVXZl92uPHvdE/fDQFAApRi8LCxQwm8=;
        b=ERV3JkaFTwyWnMFv5bkfPal3H4NEmqEFp0R+plcmv+gpoWIh4CYEUSLCH4F+GJgLr9
         tqXCJfqey9AzVCzvepFG90/oaSyuRmuCW857v+UqBYqf0zf4LH6BFyznHheQ3qM18qdi
         kVhLY4I83cil31kyuwpjQNvta3PcEIITTkm9YpmXi9IeCginSf3HiHrdCuqn+cn9rMk+
         I9Ti73kTnlYCtJBNi9aZAo2fr7vXXCLiHGwBAvFztFqdrTvpH5REovIrxWmenKTPrrgw
         WqdfST0xTQgznwDnws41bsJPZUd03D/6kDFqNahCE97Cogo2jkkxGxVPotQ9A0vqLq1Q
         BQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741471003; x=1742075803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy7bNbBQ5RijVVXZl92uPHvdE/fDQFAApRi8LCxQwm8=;
        b=AeRzS0RM54drxW8vyMVUd0d1SoZFf8zMdWKIRaoYvtVHnZ8PkwisSxYcR6vqZL5vZ5
         rJQOzXpiy/DmFSosoalZezo6u9G5h2Nnj8psbduCmY1iCkHYGQWErDwhx0nPau2pcWB2
         uXVnjec4m04KlhRGBJZExuXL+9xIdlLnggn1ECntyQCDo8ygMX8n0L/tn6bYqVYIXNMb
         oQOykzqSHU01sHFi0+NUQXaKtiCzimwsiTRR66wCqCpha4PuCqRgnNCggwCIcQW4c0n+
         v5q6F96lNPkhcqoGDvkiwTwuMqfe1HTpSaYoWqt4VtYNlPr9IBIFsW5JhVxfKyE27uve
         n7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUB4OdpZ5tggmmZuN9w18RnksK6/o2yX66Su7HmyvQsDbgqp94y4EPiX5+XzFild/2VtXInXMs7rsLRMB9q@vger.kernel.org, AJvYcCVwMvsrvqCOp7ie70LTUMABovwvNjKRszEqjHin8YoqVJQYc9HQz+U5OzCjCkG4QWyKROA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/elL+ou0Fx8TG6GYwUI5oreH3rUheEH0zisGv/dUI76MXUM1b
	z9Ru5r3POwWFAEgOXly2e3u0kQY91XJin2ARCCKid62oQ8vXpVl8
X-Gm-Gg: ASbGnctMDmAEL+bUu2xvO0mAi3BDR/USaY9XkyCBYvg4CmUJHNViT0L/vId3L7LQe5F
	9Z5OfdpiM5DTneRFy2KfY5+KRzseclWEJHME5IaylDxO5jPSf1aZFzsCKCXTR62UEDPRdVzm3O8
	qE3jb1YO8LMopTKCSTH0dg2egz1GoG8hAguKXKANt7+fDMJ2nMC3tO05Cg6lSuUR7nHj2uZsWxN
	2PmEDnvcxFzLEM7sTFT0mytSYJPKsD/Je+xZqECAItQusojI7jbR7bQlE8zz0Eu4zYWsMCXgkIL
	i/gTEZSVsBzCXaMv4/XpFNHGUzV6YFL12OYgQTkOX6SVapWnY39QxQwT
X-Google-Smtp-Source: AGHT+IHz4AuV2xnclSuleQgLco/at7uKIRgawb6iDA02l7khfRFvidmMxiaFO61FIlusyfpnPjEyQg==
X-Received: by 2002:a17:906:c505:b0:abf:19ac:771 with SMTP id a640c23a62f3a-ac2525ba73fmr762356466b.2.1741471002839;
        Sat, 08 Mar 2025 13:56:42 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:441e:3a26:bb73:78a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239737fc8sm499298366b.91.2025.03.08.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 13:56:41 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: add missing NULL check for __dev_get_by_index
Date: Sat,  8 Mar 2025 21:56:05 +0000
Message-Id: <20250308215605.4774-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __dev_get_by_index function can return NULL if it fails to 
find a device with the provided ifindex.

We should handle this case by adding a NULL check
and cleaning up if it does happened.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Fixes: a38845729ea3 ("bpf: offload: add map offload infrastructure")
---
 kernel/bpf/offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index a10153c3be2d..28a30fa4457a 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -530,6 +530,12 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	bpf_map_init_from_attr(&offmap->map, attr);
 	rtnl_lock();
 	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
+	if (!offmap->netdev) {
+		rtnl_unlock();
+		bpf_map_area_free(offmap);
+		return ERR_PTR(-ENODEV);
+	}	
+
 	netdev_lock_ops(offmap->netdev);
 	down_write(&bpf_devs_lock);
 	err = bpf_dev_offload_check(offmap->netdev);
-- 
2.39.5


