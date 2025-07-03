Return-Path: <bpf+bounces-62312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB812AF7E06
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E34584B3B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BF257436;
	Thu,  3 Jul 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/3xGlcf"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3877226D02
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560713; cv=none; b=REB1K5gGD2ydOsAMN7dqgFbvVoVOEk6HfbWbMwu6E05kcsvDPDZkEeber1Ccd94rnpDDjfSWHS3L+FxQrG62QcuWc5xb7Rjf65/LbjIe0VTZMk7yYb8srlhTVLUCnTyuW78QHondG8G5pB/lBaxRADUEgKFhK1y10cJH2cM9gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560713; c=relaxed/simple;
	bh=tMw2h77EUdUJwSIctCdwYMpVl+/MG/Hi5H+pZeMOfOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQEvz32/IJ9hsiGlqrKS5Kq8EqKWygA+kVETRQVtG8jHqjkRIVQflh90ntRFzKorLT+Q0H2UerCAWwMBjZ0tLOnOig1uh6nvIzVe9yWzjCESi/u6RxYacqhIzljlQc06kVwmW4bBOCqUM1I80QxTIvbVjDwGYGgKGS9ZNObzO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/3xGlcf; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751560700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lATfwAAqsGvlKdPeL43bykiRSCI9nUnpe0EI/piiyfw=;
	b=k/3xGlcfdUx1S1RdNT/zUK2XrQAqNy76uL61+jctA6W99xIl0hHimYJc/FaBgtkUEnGjHj
	KcQVPVU5zwRtThQ/bmf6HAFcdvuJaRSNka3OTCni0a0Glcm15jvwAZ/+BZZrU4DMxDIHXM
	kqGlonSUfdMtrYoWbObCdGpP+6RT9Mo=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2] bpf: Clean code with bpf_copy_to_user
Date: Fri,  4 Jul 2025 00:37:00 +0800
Message-ID: <20250703163700.677628-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No logic change, just use bpf_copy_to_user to clean code.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

Change list:
  v1 -> v2:
    - do not directly return when handle err ENOSPC.(Yonghong)
  v1:
    https://lore.kernel.org/bpf/20250703124336.672416-1-chen.dylane@linux.dev

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e6eea594f1c..6ea3a8e3f7e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 
 			if (put_user(zero, ubuf))
 				return -EFAULT;
-		} else if (input_len >= len + 1) {
-			/* ubuf can hold the string with NULL terminator */
-			if (copy_to_user(ubuf, buf, len + 1))
-				return -EFAULT;
 		} else {
-			/* ubuf cannot hold the string with NULL terminator,
-			 * do a partial copy with NULL terminator.
-			 */
-			char zero = '\0';
-
-			err = -ENOSPC;
-			if (copy_to_user(ubuf, buf, input_len - 1))
-				return -EFAULT;
-			if (put_user(zero, ubuf + input_len - 1))
-				return -EFAULT;
+			err = bpf_copy_to_user(ubuf, buf, input_len, len);
+			if (err == -EFAULT)
+				return err;
 		}
 	}
 
-- 
2.48.1


