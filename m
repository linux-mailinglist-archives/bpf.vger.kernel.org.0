Return-Path: <bpf+bounces-48467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB90A08265
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336DE1888EE0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FF203717;
	Thu,  9 Jan 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eSRkB7TZ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263A23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459260; cv=none; b=n5V/RAISDe8ruCeKR/leE/w/evCBT6zktyYT9Ue/+r+oDKBNpGwyJ1wrDGVomv2pObkOu8ZXK/HD1PIVGyAU6h3Z0A4p+klynQFs6gWc04Qn4TuOz8I1RNnhiN8Dk9gG6N1eewADD3rEPkz0JqYgyq//nkH0Hq9Hsb8MXzyOMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459260; c=relaxed/simple;
	bh=hVLuKMW5/cC+1++g8R8SVflPh0W7BsBtyDruf+bF94Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsAGB8bOoC/dFkRAkLHhO5aMUei7zJEXmaKFn1cC06QZ7fjrcRfjyfy7BMAYXKtz5PGFdwcaRF2UHewWIvyX6hW3qaNkxJG9eLjODheaMiOCqkwK2434EazEMVbSMaxShNz+MKYIevRXuOBaLv4jzY4QHE/U568INBQTajNY4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eSRkB7TZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEDAC203E39C;
	Thu,  9 Jan 2025 13:47:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEDAC203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459259;
	bh=jakyclLbn9LTqyxZcj0KLg40zxL9680J4soMA1tDKuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSRkB7TZFse/s23CQZGoSc9iGyrpdFj9CCvaHWrWjKBagolDy7gKNTm1d1KiQNlkl
	 VKJlE/JLtmB/ZX2pAaGabYLOJdbCtem/LD3uftUxMjqoyeLddBdtjH8HyamDCI2Mfj
	 cFheD7hxI33uuOKi+sfN16yzvQVPmzVu5K+E0LW8=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 05/14] fs/kernel_read_file: Add an eBPF specifier to kernel_read_file
Date: Thu,  9 Jan 2025 13:43:47 -0800
Message-ID: <20250109214617.485144-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows for BPF_LOAD_FD to integrate with the existing LSM
infrastructure to make policy decisions about loading eBPF objects.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/kernel_read_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd1..39f9ed584df5a 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(EBPF, ebf-object)                    \
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
-- 
2.47.1


