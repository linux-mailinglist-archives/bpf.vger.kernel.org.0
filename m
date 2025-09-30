Return-Path: <bpf+bounces-70007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176ABABA00
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA8C3A93D2
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B728643E;
	Tue, 30 Sep 2025 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKpLoJBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92F27FB0E
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212043; cv=none; b=jSY4ls7oCia7naqNC7ePELwEyJhYzGyO9jSBj1h6zm7Kz2FtPTRWT6fSJ9C5OlcqnZ4BADyWwTfV5l87SkGFI/uu5ZWHY2OZ7u7KDGmguuda6KnauDuSOhLuj24sZ4TyIwh4LqP79vxUn/d0wMxFmGQOyMsAfonDKl21eKP7bCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212043; c=relaxed/simple;
	bh=M3JDOPbFjkClAC4UX2vhrNDOfN9b6bNYa0hiNAn1emM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Olx23W3ztM8MmCkskJZ6xGkbIKfxd2YBh4lnE0o8ydTDg+wSyb54lmsEGK3Gr0LjI4DufiBGNbmqmBmws9nvYNwbbjcr0AItmoS4REJj5I/NE/bg/DcygljhvTXfvCw8YH+dUJJYQoxQTLy2udSmi358ENUw8061xgTexEfhEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKpLoJBt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so71987405ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212041; x=1759816841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=hKpLoJBtNDECiZjp0VakSp3fmaHyldgcYRJAURPLoZBP4KVhzaYtEzpRPn//5pH9kV
         fHJz7876ZaFaJB65R4/H/1S0qXqY8sxE5KmS+E46Z144B05+1atfc5ERHSbWp6CI2HHB
         QQ1sSt0DKpnu7G1TwweNu2GYKEujXltczKjxte5zVFgGkYVPTVMexXtkIlDIsv2A0FD0
         t86vwWfsgEDUO/6ZM/MXDkxH/rEEUU5JKMt0htG+IS8JwFhEA0j+h//km/whpyax3yY7
         LThza1Da89ochEpmaxbFXFdvttHvwt3DE29t8Bl2OqkbIQqzDxUEboM87T7TN6OKaXH8
         dzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212041; x=1759816841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=HjdY/WQwbv/+1ln8D3F1YH7Ekhh8s71U0B3vG8s9KA7EsO16iAnzAuL88cP7BXzFXk
         /ijWJB52Mg3GuBJHN2+MxA+lt9cJemIExcISZZID8Lp3W9ZOanCA1ZdToTLIFHm2jh06
         w1O5n7AvE0ebqfPDaZXpqRBbR9dsK70HpjHdXo4HA860LkxUTdHtC3TVN9LgfBgeve8U
         jxjRtmv1QUHvb5Xg0wl+U+wUm+iZxVGAt6D3z77R7rdwQhsPEfat4nOpwf67tg8Paxzj
         xr5OxQcWqKj+PrwbJv9L5LZ9hPKcZkELL6hGirPYxmoKxlPOv84L3VKhDbZ95K/wLyjI
         +n3g==
X-Gm-Message-State: AOJu0YzgTx6wVLKM7gUuyH0nxpGp07vNcLeWMmvyaOUrNv8Ne9CiPUP2
	Zq23c1fjL+g8/cgcdR7b7QXvL8V4yIyx1dC2AmBNHTQahCOR57j/0P2e
X-Gm-Gg: ASbGncvM4bapISFAQI5QrVqlVpOtf1E55b93O/9LsYFytoywXEHAXyoPG3hF479g0p3
	SfwnoCf8hjC5OQuKcTWxa/rVtHGjtWrOTr1WZRb5COYbos9bhdvJjXBp0Ek5+tcY+m65vAlXMXc
	VaPRphWddaBWvmpm7JbE5L8aPbDLbTdx9REGqCeO/HWf8GGNsL3B3L7gDCzrEBHBYUYlpS/V8HS
	jlOJa37Xvt4xtW3pdyjwoc9oXJQpc/TBXAqFbDuv8souWLGSxrgqu4tEGhb9OFmeXTPZtKbK7v5
	gfBS3UyiHQKzctOUBDWpWKpBdoJPpadob1STnVnwgEq/MZqdZiPvKxurd5OBXPd+2RxmZJLjGLL
	rPwzkImDFRjA3aWeo1QfSXgiSFYBZwahwJdJ80I5a02nolZaiaVpBmpG9Kp3QMGyD1FRrAv3HkY
	/W06hsWsq9R5ymEU+WkAFrEcFaLFUSIklF9sl+2w==
X-Google-Smtp-Source: AGHT+IESjK5uuXD6SNUTqXGKn8jpixgQvb75Jnts3CNC+W4F2sDEPtoAZ7lXfxrqlZpJ+kSZvlFegw==
X-Received: by 2002:a17:903:2407:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-27ed4a7448emr222073545ad.61.1759212040904;
        Mon, 29 Sep 2025 23:00:40 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.23.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:00:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 11/11] Documentation: add BPF-based THP policy management
Date: Tue, 30 Sep 2025 13:58:26 +0800
Message-Id: <20250930055826.9810-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..f6991c674329 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -738,3 +738,42 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF THP
+=======
+
+Overview
+--------
+
+When the system is configured with "always" or "madvise" THP mode, a BPF program
+can be used to adjust THP allocation policies dynamically. This enables
+fine-grained control over THP decisions based on various factors including
+workload identity, allocation context, and system memory pressure.
+
+Program Interface
+-----------------
+
+This feature implements a struct_ops BPF program with the following interface::
+
+  int thp_get_order(struct vm_area_struct *vma,
+                    enum tva_type type,
+                    unsigned long orders);
+
+Parameters::
+
+  @vma: vm_area_struct associated with the THP allocation
+  @type: TVA type for current @vma
+  @orders: Bitmask of available THP orders for this allocation
+
+Return value::
+
+  The suggested THP order for allocation from the BPF program. Must be
+  a valid, available order.
+
+Implementation Notes
+--------------------
+
+This is currently an experimental feature. CONFIG_BPF_THP (EXPERIMENTAL) must be
+enabled to use it. Only one BPF program can be attached at a time, but the
+program can be updated dynamically to adjust policies without requiring affected
+tasks to be restarted.
-- 
2.47.3


