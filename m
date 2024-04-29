Return-Path: <bpf+bounces-28180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9428B64B2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04C01C2190A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12463184123;
	Mon, 29 Apr 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FooPZrTj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A6184106
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426579; cv=none; b=Sl0ka7YugMqIMnv7diREAgKh6ynRb7xpBxKOCYBFoBPIhDLZshopZ6dUra6w2LKM/7v3BfCQZhz/tRYeq8gHhHyaW0MJyNRPoRZTfTeNgvosVrbxW9j04LYaCVTNcHLKlXOZueseyhst0Gx3KE2Zv15QHwAvKQzGa0i0NgKlIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426579; c=relaxed/simple;
	bh=qPWMaoapf8etuzRHFlLLredcVqscaPwHU3Og4UJsWKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bG7UzZu8vlE5CCU7usHRK6az28Yam2yXCvAjevH2jd/pgwLKSRDIhOTHBcUszFDHkj/BsjYbXZLNjAtqnEgZPI2ismzeFcsIosPuZHyBdllOo0XaZ9jOZTYQCFCblywsdE0ZWdSjf5VTEnc0Fq+x8dYlGrgei1wJ8s6aOSwrgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FooPZrTj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb55942409so2418691a34.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426577; x=1715031377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SyQcBUr1RoB63injLEssF5Dc8uqHZAPs77gRcJceqo=;
        b=FooPZrTjp8yBL0Vt3njGul57z1Zvb33SZCcOHsw6Pp3M561KMZ8c3zBksMDs74iAKc
         R9nxH5Wr5ZIpN8uNJeeV60Qd+qAPaA5qleWlot8RiOrKzyoZQaPuk7Ci0hQAjd171qTt
         E/QcjECVn9FtHyZZe/HdBiX1IjE8H8WrKiG7lJliICigxiZPSM68j3kfIOgXUFy/+Pmf
         GGrGzrFAIUoSNFM4qu/hr4zfsIdOyYHyT4yiu0jcScREpKkrnCA/sbWEhcXeV2/4fobt
         HWBo0a7aPf8Pj1PQRde8JeB0pRDM4c1iTWilBpyKuzmKLKQP7IXTtpW2boSkjHQiYXov
         Of0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426577; x=1715031377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SyQcBUr1RoB63injLEssF5Dc8uqHZAPs77gRcJceqo=;
        b=Z5UR8fatT4+nowdbjY9CtDXtzCAwOsOlbBjM/27Orcx6RsGb1j7coLMC4qJf9dUWkW
         iK+2ecl8eZ59OSzfOUrT5+brLU9ksZFOWAGAsdyfZfYsRbrrEvPbz6H2WmcH86xQoJzf
         SwaZ7BtMvvRlNRmiSEYQdw6Ax1hEczWEj+9z0RWsJLwlqzcSEK1ZdwFEizBUxbyx4DFE
         bevmCYLYuCF3p3m/eA1spcZBYEhfx+Cmb9BtcetLHzzuesUr5RrtwUrKWgRA5bBQkpA9
         EBLujxV/D109fcyT7TVyaWGQn8et6ZP51GpFB/ZwSUczUi5tAKs9TBWDr9WduEWvd7tp
         dTTQ==
X-Gm-Message-State: AOJu0YxZ5CqCT0MLxadyZ+HmishxC+KqoC6MR6OlmIYoMLXIf+g1gav2
	I92q62TV+kdweBUeIx6iCJNzwcn5inFiS36hmJtDnNUBribrnBB6VkrHoA==
X-Google-Smtp-Source: AGHT+IGSvpRcOUmGZbBouxAesp79MVsHG1Co9AzGYKXloTIQLa46GaZ+9gk7EiEJwhexu4o2a06wjw==
X-Received: by 2002:a05:6808:608f:b0:3c7:2364:e506 with SMTP id de15-20020a056808608f00b003c72364e506mr1114811oib.29.1714426576882;
        Mon, 29 Apr 2024 14:36:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/6] bpf: detach a bpf_struct_ops_map from a link.
Date: Mon, 29 Apr 2024 14:36:07 -0700
Message-Id: <20240429213609.487820-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429213609.487820-1-thinker.li@gmail.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user space programs to detach a struct_ops map from the attached
link.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 8e79b02a1ccb..4a8a7e5ffc56 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1252,8 +1252,36 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	return err;
 }
 
+static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+
+	mutex_lock(&update_mutex);
+
+	st_link = container_of(link, struct bpf_struct_ops_link, link);
+	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	if (!map) {
+		mutex_unlock(&update_mutex);
+		return -ENOENT;
+	}
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+
+	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+
+	map_attached_null(st_map);
+	rcu_assign_pointer(st_link->map, NULL);
+	bpf_map_put(map);
+
+	mutex_unlock(&update_mutex);
+
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
 	.dealloc = bpf_struct_ops_map_link_dealloc,
+	.detach = bpf_struct_ops_map_link_detach,
 	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
 	.update_map = bpf_struct_ops_map_link_update,
-- 
2.34.1


