Return-Path: <bpf+bounces-30445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56C18CDD26
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FF01C209D5
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD012839F;
	Thu, 23 May 2024 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isbFv/k0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D94128391
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505746; cv=none; b=RcBxMPAZx6E7h1A0lbnMjJ1awEwpEeRTpOVHvZurR6DS+clSoozNAdOXXrxrhWAPfN66gmTvXBHFDG8kLW5R/B3yvsJLrj9j4hye+Gy5lJCF/1tGvyQ7y/gaheRp5CMKkjiJkK46K9TsCbXjefiPBeIF/yvr0cOQ7WrDONE+7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505746; c=relaxed/simple;
	bh=6Uk82ulfevuYTENW/+p1W3vTdPq0G9p6yNL8nLgaigQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkqlYpXAg40EX4pR6xrzMASOI8CKF0VP+28cjrTrv3U9fHOEzUXSl8je5ggXR2NtUL64T5UnF0tbdnaCqG3IZZrVH54LD/7Y59IEeWiPNJjrzlPM3uCbJ7GPt+vrrDCtznke0yVIChLxwk2Nv2OrjHpQkLGCFSOVvB8NJpc6PM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isbFv/k0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a0849f5a8so3077277b3.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505744; x=1717110544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4Wjbt7VL9c7feTccV4TocTwFgkAq7HdSZByqZVtp64=;
        b=isbFv/k0BOoOXxB3mxpCsZFOJJkhh9vPUxGbUP24z2IB/pjgWuDNLrkpgdBSGK1SWw
         8ZTsNGxhIMG3qgP3uQ0Wrfg+hB465KAMmTZoHWFPwbWxYcwUL5yiCV9cG1zS+FQL8QTN
         Bl053NqTJfWZiBH1+SyQx+5TTCc2YthSwQGhOJ8EywqEEvtHCfyEvgFSK4dnx5+MenyW
         PjeQ6yo6j6LCKcjUSq8rxrP6k14yrvb9zCmMqjVknIzYlgA0ytReIlavV4yHky1JmM7f
         C4P+gm4uMiChKZy39ZpVwmMrGmzojzzbm963Izy4ekx2BKXMHESHgMJXvIrhfA9bNJal
         l7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505744; x=1717110544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4Wjbt7VL9c7feTccV4TocTwFgkAq7HdSZByqZVtp64=;
        b=bquPkndIsmDf9ZjTB/vWRUn0lRQ+wSenbOG53Mhqa5hUbSCN4mcBErui0yhtvG+ZaP
         uoI07w3/y30iM4HbTjfjG4482kJiwiJK7/MdkUlzd1x87d8CZ/FL4NN/yOl57cu/vtQS
         Lg1VWDprscgo1QT0sn1ZanwvxtJQ4STKgQ4vKXGgtXo22byVRHn/dNPK1Tf9Uoc+9qtM
         841ysCwov03mSozbT05wm1DqMfU4w5lfhhs2ZoWf3wcJTLKg7jPs3BqTeJ2qV3lD1+AT
         yELn++AK/TIQivjZruaQ+JfsmKgPeKSbTgnqftMdLKLsjD1ZNdHcVm/Bu2H1zh+DDPk9
         ZEBA==
X-Gm-Message-State: AOJu0YwZnajZQlbX+z+q3w9bQSAaYHRfHFlgZ+4Nhy38UobQRfOinxUA
	9awlODEmJRnwR+qlV0fekza944XGnqk2IxcP/Ylty2Wn6UTaQmOVUGnx+g==
X-Google-Smtp-Source: AGHT+IERPdVR8wx15wmYB/Cxf0uj/BsizV2QjnibSn/9f10axwLGqULbSQ3BVsFbQhpbkS5GzfDEQQ==
X-Received: by 2002:a81:ae57:0:b0:61b:14f8:b628 with SMTP id 00721157ae682-62a08da8c5dmr5951197b3.23.1716505743883;
        Thu, 23 May 2024 16:09:03 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:09:03 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v5 8/8] bpftool: Fix pid_iter.bpf.c to comply with the change of bpf_link_fops.
Date: Thu, 23 May 2024 16:08:48 -0700
Message-Id: <20240523230848.2022072-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support epoll, a new instance of file_operations, bpf_link_fops_poll,
has been added for links that support epoll. The pid_iter.bpf.c checks
f_ops for links and other BPF objects. The check should fail for struct_ops
links without this patch.

Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 7bdbcac3cf62..948dde25034e 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -29,6 +29,7 @@ enum bpf_link_type___local {
 };
 
 extern const void bpf_link_fops __ksym;
+extern const void bpf_link_fops_poll __ksym __weak;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
 extern const void btf_fops __ksym;
@@ -84,7 +85,11 @@ int iter(struct bpf_iter__task_file *ctx)
 		fops = &btf_fops;
 		break;
 	case BPF_OBJ_LINK:
-		fops = &bpf_link_fops;
+		if (&bpf_link_fops_poll &&
+		    file->f_op == &bpf_link_fops_poll)
+			fops = &bpf_link_fops_poll;
+		else
+			fops = &bpf_link_fops;
 		break;
 	default:
 		return 0;
-- 
2.34.1


