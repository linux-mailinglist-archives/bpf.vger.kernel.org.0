Return-Path: <bpf+bounces-71007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E2BDF035
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79D10354F47
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE526E717;
	Wed, 15 Oct 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/PmxhGW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5225E469
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537906; cv=none; b=uqWV8NvmbpKs/xTuArrJQ4Je6oXBZFe4oBst5FyqhM1JLEBpY9bOpFXOFn4NiwZffdNdMpwj9PLYOmjmDjb7M8z4FfrlpQk9XkEopDfbF5JEh4h9FQBgYSUtbC8yOSmT1myuohAj+OBg3IieSpivDApkkVxRvBr2Ln89OVbtnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537906; c=relaxed/simple;
	bh=CXI0qMvWqpeePDr4xBG9e2uqemr9IpjeVUqDleKN93I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYVFygSfjALK+Krb62rvkDzixeVBbri79dk16PLkTYaOHcWAxdGuCqV3exfC44RhXheStPIR/SXbUZFUY0+zGuaqwHwPhPJQ0KJ27INcNhgroAgaWUVlBSIiciR5+ZYohdeY98o3FUQoxpm6XWNfGYu/Bro9NvqbVJi1AAKT2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/PmxhGW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27ee41e0798so104121835ad.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537903; x=1761142703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=B/PmxhGW4USjX2YXd4ZukIPoqXuA90fULSmrq5rxT67yJShl4XIqibhEUVtGPwhFzO
         LN+xQ7/xaXSQZpakOu7fsyY2WVywH57LwnVqGH1l3Xg1AlYjmTI+hpO0xxxkEPSCS5dP
         hbiuSkNdc88c/KTt7abdO5MNcO/ahcESDoEOfRzkbRmGYXquGsyVVaVTVZaASZ+D8FTw
         qfwa0Z2+SoYpr6q8x0f3d+cVTS4q91SzPXC0I8tbIiSWiocp/laTNC7gUrW94UxwMqib
         /Uai3NzxDARFGDsp9J4CzvLvNP5De+rlVmeEfUWyuGtB98kdh2YF9PeL0QrJH3O/YLXm
         nQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537903; x=1761142703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=ign972gHTZnQZCrJwo+HSyVWBzixigfZU4kH6slT1i0sdfAlC0W39GKz+L+KGSydvl
         PIFdaxGpPJS2hvvrSWP2d35Bsz1gi+3B35X07YlWjsVvYHrLX8u6yNk7jr72h0qira1A
         ri3PeJOmH/MQWk+eBed0M7GWdRc6gOsO+GcHsNdOmeDpE8cEulXCPlWOF59g/MSQu6uJ
         em9ZBkDUVogC6O4tMj66s3TnyAcvu+/DgbquTF/arcDJnmYzv6s6T+J2Izvwqdv6O/++
         fvFNYul8xlGebAYZ/zis2EzPV64P+7DHMNKQq0cMGqOH/qN3EH9AH5X1M9z6zUtbPtYI
         8+7g==
X-Gm-Message-State: AOJu0Yx+zg1FA4L9iaC+PnAwmWAG3rBsKozW7O8ESlNvAnUUcnxp73TG
	POHH2ztjRwueI20Kw7m7gHsN30u7fH5f7lQ6gA2WeCBfiN/6u0V1xW00
X-Gm-Gg: ASbGncuEWHoJdgGUd+Frs5d4aA+7vVVaRL6pS6/kI2nbLqrOjX5fNwubwebwHJ0f4CJ
	oqqJdD2/sCLQA/Jjq3Oep6Osu9mE7yTRg2ahfZQN8LsTmBHtSHmJDb7zxO80p/x0j5gt7EpmuJV
	RgdXMa70G9KStai+T3WRklY2ci8aWCAwhmc+ckjRmiJNsj8imfdeZ3wgcdU83qVgiA14s+p6coz
	scEQS7QHX91eQ0YgCRN/Aq5oMmbWtH0u/SiisFndtfqbuYT4FJdvpXhnnybj6uyY//tR/kxs/Se
	NCOXvi4Bakxy+TItCrkbSzgxGNCnPU0OENT3EM8HEdyFZrvhJ+aXQP2HrSOxkOrPPsnGj8/i2ea
	deR93ARvNGd6uOpyvmqMhy2rRNyvSvgDI13EB/GMDhoaQuwtDgnAwUbH3d+wkd7LkFcoCvCC4He
	2HbKJAwfel4GvaO5kq
X-Google-Smtp-Source: AGHT+IFbpJ/lHtUZtOELQrDFo7AxEZqNrS9hHE1/EnXHjZzMn0AR8tXrPtdpNdO0986Yh1aFevTgmQ==
X-Received: by 2002:a17:902:e78f:b0:24b:182b:7144 with SMTP id d9443c01a7336-290273565bdmr371321185ad.7.1760537903035;
        Wed, 15 Oct 2025 07:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:21 -0700 (PDT)
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
Subject: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
Date: Wed, 15 Oct 2025 22:17:13 +0800
Message-Id: <20251015141716.887-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
owner can be NULL. With this change, BPF helpers can safely access
mm->owner to retrieve the associated task from the mm. We can then make
policy decision based on the task attribute.

The typical use case is as follows,

  bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
      goto out;

  /* Do something based on the task attribute */

out:
  bpf_rcu_read_unlock();

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..d400e18ee31e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
+#ifdef CONFIG_MEMCG
+	struct task_struct __rcu *owner;
+#endif
 };
 
 /* skb->sk, req->sk are not RCU protected, but we mark them as such
-- 
2.47.3


