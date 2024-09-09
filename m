Return-Path: <bpf+bounces-39263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BEA970F60
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47F81F226E2
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704A1AF4D8;
	Mon,  9 Sep 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgE8pnH+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C761AED25;
	Mon,  9 Sep 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866067; cv=none; b=ChBH7HAe4qFSFojDjyA2C/hxdV5aBWv4eSW5LQ8zZT3CD7dZEq+XKv+2ZrRwTPrRA9USkuJKSASCdRH/VFRSRjw/rJu7EqgZPTlWuzykPL0Eznaq/stH36dXNgTph5OMx7JtCJND0hGwiFEtIxcoBuy4Fjla/btUQA7xCAUjVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866067; c=relaxed/simple;
	bh=uA6HsZP/i8UtmILmp565d0iqwTuGFJo/YlQsR8nNgkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g41xY6twXaMMocQSWeQHYDSHq14jXX3HCew/Oa9N8GLJTWiNypGyGJnJzPj7z9vr18BRiHZ2OsaAyoZxMz9BskXRfE/9Us+4CBEsu4kDrvcgCPYjh7H4qY8sgoUgsIkOKGZOQO5IyQjy/kOddqE5BhtSN6GCmr2s1wkHZySaoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgE8pnH+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so1411144a12.0;
        Mon, 09 Sep 2024 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866065; x=1726470865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgn+JQxnIdqI9RCqO1MoOoWKE5oepwpbv1VA1abxv/c=;
        b=RgE8pnH+TuVyLmfxuIxm4mvKN5f6vSKx31qheN426gS5UCYDYKCIHQjq2HFOanqscy
         YvyOI1I03GkIZea2gpK1biZBeXU1NVsVtE6G+x5fx8+Nj3M7tmVJ026IBcaPD3IiNksA
         /HZ6QmRtZcOjLR23fz/o9n7bPZOibouKSUp6U786zCcaj7RJH2WqMVhsOsAMrM+CkAJ8
         rdRD+40bOiJhXLHepzHYabtN1yuViS+tUWa1ME3+4W+09fM59zuX+TbMNEd3zSHWmasQ
         YbtbE6Ci3Yo1t+rTItFETQDo15bD5CnLJ6yLvb9ZNu1nivPhGSJaolNrgGlSd5Fs2ZS5
         M0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866065; x=1726470865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgn+JQxnIdqI9RCqO1MoOoWKE5oepwpbv1VA1abxv/c=;
        b=tT5xBKYDFjFZL+T/AUp68fqpqbQgk9HvXvB5BCYJ3jRFEmynBzgdTFk1HXDJ92gcZI
         Rl79UUaoCu6LpU/l9T7hCA1j1vb8CwtrBsuMoNY9681qjE+HCyjX2f3jZc0qcAsYj5xo
         pFW4Db/fEkUQmuoWDmH73KXLYprHTZfZkepznbkkXjoahjghwDiSs2JlyBWs0JkpwhKT
         893edK9+Y7CKJS75oHCCAT7IwHUtYxCxVgQfyhAOhAyewvjJOZcoY5szXi5agFsUyfND
         cLdQPY2yevzzaQT9f8pnbZ0fLeMCV0VZkT2Eu8k2saELlanCb9ZsmQkoxj6wilg1xuZo
         79pw==
X-Forwarded-Encrypted: i=1; AJvYcCXJzUdJGetLI0q3itI3bh/2nAs/WfqGKPld3I1XROFfiw1mhsQKhp+CKB1hkAAveMxf6Q62tuOiVSTXqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdjup/lrbrAoc6PtpKkWO3cqdipt1pMKzIrTBxpAUMbqHGW4O
	0E6V4v3SGpKu6zOEBJ73J5lSN85/Emljoo2ZfvH1uTgg4YKmKhuG
X-Google-Smtp-Source: AGHT+IG1HOLavIEKor96Se94Y9lBECxGBzj9ZToR2ekM7COf2mZZ4x0mjBM+ILCSX6ktgrC7xK6p9A==
X-Received: by 2002:a17:902:dac1:b0:202:4bd9:aea5 with SMTP id d9443c01a7336-206b833f304mr295354815ad.14.1725866065415;
        Mon, 09 Sep 2024 00:14:25 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e32775sm28402125ad.77.2024.09.09.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:14:25 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>,
	jinke han <jinkehan@didiglobal.com>
Subject: [v2 PATCH bpf-next 1/2] bpf: Check percpu map value size first
Date: Mon,  9 Sep 2024 15:13:45 +0800
Message-Id: <20240909071346.1300093-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909071346.1300093-1-chen.dylane@gmail.com>
References: <20240909071346.1300093-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu map is often used, but the map value size limit often ignored,
like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
like percpu map of local_storage. Maybe the error message seems clearer
compared with "cannot allocate memory".

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: jinke han <jinkehan@didiglobal.com>
---
 kernel/bpf/arraymap.c | 3 +++
 kernel/bpf/hashtab.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a43e62e2a8bb..79660e3fca4c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 	/* avoid overflow on round_up(map->value_size) */
 	if (attr->value_size > INT_MAX)
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 45c7195b65ba..b14b87463ee0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
-- 
2.25.1


