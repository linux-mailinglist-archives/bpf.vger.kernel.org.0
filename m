Return-Path: <bpf+bounces-53863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07433A5D211
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B32117B5A6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27423264FA3;
	Tue, 11 Mar 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8vJZIUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C925EFBE
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730073; cv=none; b=JFfLFPdWSALz0t3ziRJgwNef22xqGrBrBTPPAK5HHXii7zR8Wfz9GQUdlRjxFyZo7Ro0/drQx/upYj352XFtLO8IGddU3yDrUqQoTLvSbF7Cbt0RYe6k8uaS+6lL77DWd78KxHOWWUeEPQRlyavnEHpShAN/ZXxfAxAqNl+KRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730073; c=relaxed/simple;
	bh=U2tE7nsz3ygx04ShiFjXSW+fKZLv6AGWVb+GS8JsRJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1SU28kv6eilpgbeQLfC1dUb+oyyrTB30sbRUPPJSJn3ZaXVk0lpOUM9XmKZNj60o24pQnXQJnxZND90VuvnIUJbqEv47SBwyueZIFfr+SxQj8CEg/SlUE3Sk9yH5On2ABGqF+PEWXZx7mBwtY4PDoz7hziV9GJZjOGr7X3YemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8vJZIUu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2975643f8f.2
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730070; x=1742334870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy/4a4SX7AKIv/nG/eNyzh6td6OCvpTawPsf3r/v7+o=;
        b=G8vJZIUuTy1CYG4TXS/NvZ0szFRwBQEtEZ6Nr9nTY0O2GbG+uK/N0MMi+XK0rwgYo4
         NVMmFVwfAP8O3Fu/+Hfv5PvdJbGri+dfboaXnVf9ofjB0z+PbTa4Mnzjm26NI3mW3n+i
         /mmFlZchBZ/acOoNnCzSakeL+2R3KpkAF6qdDtH1tS9QzBXQ+U2lulSXNQnlS4+K1Ag8
         BW80lxjTirS0AJ8N/lDUHapINZlqIjV0/AdoZkcDGUn6yX1fCiHzUqUiDC3Zq6ydXKRc
         Nx7HpVe7deEBSR3KNXReMP0m5+FYR6TL7ROlBLFk+QVvDkQIMJZXJLuo/UUKut0iKJX9
         LqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730070; x=1742334870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy/4a4SX7AKIv/nG/eNyzh6td6OCvpTawPsf3r/v7+o=;
        b=BmolXvrwLr3pz1zqcWrcWTm9zPn5W4eBiE5Bnr9KUJEdWUaxAz2sKPVJlNUl5u/tDs
         PqVlfOhxPhL48M8c3RZmuY0WZiRHvWqdlJfBhhxNsLxsljryJVIyKTGkyoiD/CsBVtXh
         yOKtt+2OT8nE/9jbvn1t+pf/kiE9tOldUQjuSNj6iSy0QbUAvhD3076n/6veA2MAFud3
         7n+JPVdaAr1Q3Jie/Y3fNo08vPLYCUPg1edNmgswEcM2soFffeQ+Lp+a1b4dUHYryPHL
         z7PqCXaMjOadAz5IktfjFUrWGVRxOPVW7aDJNyQP6zwRUWVXy+KmXtF+sr9+vntVVcrC
         Zdew==
X-Gm-Message-State: AOJu0YzSVhxR/7hWfK/+eQ7jSOtDtih6phBlfjxal1bkWMlVnc49EKRd
	vaSlfPA/ea8feEdtXLf44KwHS1xXdJ+nGnQRo2pRvzTTNFmnPfzFE5M5JA==
X-Gm-Gg: ASbGncvCpQIMZvAtWp9nasLvjrfHpMV1kXBUj92+nF/n9wEqDhyru6h0AvUhjwaNiAF
	GBqXQ8auHtla3uGPTD3s3fzDb2zmKLv4QR8o4U3X1rf5Nz8xgjZ7zPIMlI9IU7hrQLFMq4gCmhD
	cL2B0agEkhzYqwZVHQF/lYiPJ6MyMD3e3M4llD8qBOmtphmKAKRhtnA2xmWuMcV5+NpATR5mlZa
	wgIFYTzPxQ/iQasAPUbkWScYTcZDz5u6eY/DqHYaHgC9dqFas0v+i/iM70AZZYThOCE5uv8y0tY
	ieR48Nv8RMVvp+NDeUMv+60af/Q1lr4qK9L+IJSNZJefSC5adO4SgXElsO9gZEdUhC4lOPACpfp
	KwQOR/j1fFwEuaydEMg0+PjVKKjCnFa9Wfwq97FORxUOPpNv0nA==
X-Google-Smtp-Source: AGHT+IFVsv8hwpxgCW99TPTSRht9T7rtno84ewCAqj3j27YywSy4O71lQBb3QVdzt9HbYZAY6+bD7w==
X-Received: by 2002:a05:6000:156b:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-39132dc56f2mr17062941f8f.38.1741730070261;
        Tue, 11 Mar 2025 14:54:30 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm18815549f8f.46.2025.03.11.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:54:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 2/4] bpf: return prog btf_id without capable check
Date: Tue, 11 Mar 2025 21:54:18 +0000
Message-ID: <20250311215420.456512-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
check. This patch enables scenario, when freplace program, running
from user namespace, requires to query target prog's btf.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 188f7296cf9f..c51193ced383 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4749,6 +4749,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4895,8 +4897,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.48.1


