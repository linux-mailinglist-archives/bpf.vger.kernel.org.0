Return-Path: <bpf+bounces-39046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1054696E0EC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F205B23F8C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E121A0AE1;
	Thu,  5 Sep 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrjZF/G/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF41A254E;
	Thu,  5 Sep 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556455; cv=none; b=KH1IaEq3B9xe0KJ/93ChJxQ6PtSfRBCGp6x3gDZn2UdKGlDrvEWLg2+oCC0yzjbCm72GgFSlMR+vJD/K9wCJ01GtoG2MMY3iBO8hWcnUpPzh1mdQoOD/f+M/v+TpkvyGYfqaP85mJiXpFTB99bS3BBo2LB/nxDNQhdb1d1oE3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556455; c=relaxed/simple;
	bh=ACiEB5LXUh7OfpSRX4hgkRl9TgTVeMVuJ5u8n6h3v6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rN+W483BRXQ9l95V4RU45L18pgO5Ne9r0dt6GsnYel+AWIYbCydnMUOW37wT6ueIoEEzy2T4jmtshjhu03Hn71Xol4FtunF1gwUj3VIlKuuPHdRTfuBh2i/q1l7LJzVgtAdrgsO+2b3xS4WpJHCSiD7q/OPPP13ub8/cyzhzAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrjZF/G/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717594b4ce7so896435b3a.0;
        Thu, 05 Sep 2024 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725556453; x=1726161253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qzH2P6QT/VZDU01WTRilziL7RsN8P6XpRi7hhgH0MM=;
        b=nrjZF/G/I1KX+y2s0kso1I6zI//seQ5RcfWgX/YzSjfHS2wiAB5VVDPAgmeHpyplHg
         8DlWsB3h7leOv/GPlf1uXnlefTo+k7M0SOigU7sYvsnMhujvHoOrb8GxC+vImMDFgNpH
         HhqZflvoKdgU9zub9hUQw6bZWnciBC/VoZjNkNAfvQScMKP90/xx8+N46JltZAVQrjfe
         OFbkh8GI21i85xzrh0y9aPDrZQ/h9zxsqiMjJOudocCw1MnmwaK1gVzj+QpeNhoMk70y
         xcHmymUhgQrjc27IYmyokyN+RBo2KNQmXLJ1kyOmxx5AW/uAUYbC6iEwzHT2VyE6uxLt
         nSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725556453; x=1726161253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qzH2P6QT/VZDU01WTRilziL7RsN8P6XpRi7hhgH0MM=;
        b=JVpOnFa+Ux+xKq0pRhRA2Sfjnmp0wOt5XeY5ZdEu3iz5fW/QajZqxorpzktgWCuuEp
         BWrqkxbhHKZ+0NrZQHH5CPRAKSf0FNzRWaQgAby312ryRA48COBMOrK6/RwTyCiFIeTp
         scC6C7JOSKIRm+N/DyumO4Cfeo6CeVqHfw/qBpVnnqVbM57uVYY2zgmwsej9FmotUV6R
         itxTL2JECFS7N9jF/iN/b6x2YUq6hGKCRIilh4VKJYmT0wQEZ2MfeNKCNAy2ujRdHAox
         7ADRORkOmDNkA8SNQNCikOa3EsidWFlYwlsrD5WB9n5Hq5w/zQxD7eqgJx08UrPCoflV
         v/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWhiXPJ6Z6HDKvqdXEarxPPsuuOOZTbIMaWxllO7XMKPu3h2a3eWk6fyjbwxCwfWf9YcUULTbNkDYCMa74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAF1n0kvkeTCdoRYxIFpHoV2FOSfudV8YdN+H+HSbXSvbvWbB2
	56pcboJ6DLeDNQNO9pE75XhMWYSmEKY9lyLWcjk17w5ppFmmd6QG
X-Google-Smtp-Source: AGHT+IFNQ30Hl3bbgFIamcPL18mrmHP0yLBj3dz/0jzD0MnCq/pSxUooRWLpBz/POMEpqh31MC1ZtA==
X-Received: by 2002:a05:6a20:5530:b0:1cc:e17f:a3a2 with SMTP id adf61e73a8af0-1cce17fa3bfmr20162553637.0.1725556453229;
        Thu, 05 Sep 2024 10:14:13 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178e99c111sm1364522b3a.92.2024.09.05.10.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:14:12 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [RFC PATCH bpf-next] bpf: Check percpu map value size first
Date: Fri,  6 Sep 2024 01:14:06 +0800
Message-Id: <20240905171406.832962-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu map is often used, but the map value size limit often ignored,
like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
percpu map value size is bound by PCPU_MIN_UNIT_SZIE, so we
can check the value size whether it exceeds PCPU_MIN_UNIT_SZIE first,
like percpu map of local_storage. Maybe the error message seems clearer
compared with "cannot allocate memory".

the test case we create a percpu map with large value like:
struct test_t {
        int a[100000];
};
struct {
        __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
        __uint(max_entries, 1);
        __type(key, u32);
        __type(value, struct test_t);
} start SEC(".maps");

test on ubuntu24.04 vm:
libbpf: Error in bpf_create_map_xattr(start):Argument list too long(-7).
Retrying without BTF.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 kernel/bpf/arraymap.c | 3 +++
 kernel/bpf/hashtab.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a43e62e2a8bb..7c3c32f156ff 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 	/* avoid overflow on round_up(map->value_size) */
 	if (attr->value_size > INT_MAX)
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 45c7195b65ba..16d590fe1ffb 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
-- 
2.25.1


