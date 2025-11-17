Return-Path: <bpf+bounces-74767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC6C65978
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8D54382804
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FFA304975;
	Mon, 17 Nov 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wiujq+2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AA301015
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401048; cv=none; b=IdpKkgGAHjFlATljcu3fVWPHwRMqlKApUkma824RahgiTiPvoJZAO4QGc4PPs9bSKglAR52jKH6kKYiVTlaSqfb4cHqEfIhlgb4fBPl2rlgvq1FdTOt7/tYGAWXEcH1LB3a4KxBAzS/l2VEWdRJEhQ2mN+ScvjK3F4JYQSwTrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401048; c=relaxed/simple;
	bh=kX6AFpK3QDzxWzPC+ssWPX8efYd7FbJVJ4iNqenCLXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7wRNXtkCD/LNkjYJVawD86dIXr9E/ifAza+X8vCnWN3Q6zNGQxbMMfCvu7Wf396FJifeUIJPpCc+8w51aYHgeuIMOtROeGasxC/G+99FYBpB9wAwk684jdY5AojzQkeBRVCPW6JzoXrgz8FNtIDKE0Y4YeL+XJetT+RgLWWiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wiujq+2E; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso3869878b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763401046; x=1764005846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyEbzk8z7xPPT1DseOSZ+zp56B2pNRV2BlLEcd5Pr+c=;
        b=Wiujq+2E+iA/V+u2BjagP0wBJNyEY9uthyUCd/rZ5cp+xgjNRbAD+lSbSFX2/MNLiU
         5wZbL2Zg9rFS0WId3WbgeFsiBVlE7MJ8oA7bok47ad6JcvIaZPNwvHZBXA0W1WdzzTQi
         30qnwamLBDy87NG/d0PRn+uhiKT0YT6K4SMKMNQhBQTpW0TCPbFU9KonMZF1RzfCKmAo
         N80zVCLdy3Rn2Zw5OkNqGNnPZzCXgxIcntDWxTXrs9gEMUdeZCcun3y+IQ1rciWxQp0z
         43YoSYamEO34VAzqO0gBi+c1n58G7Gr5Zd2KhD15WBRzxear0B7rHtWRjIhkApnQNxVn
         +YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401046; x=1764005846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyEbzk8z7xPPT1DseOSZ+zp56B2pNRV2BlLEcd5Pr+c=;
        b=Fy/CwCABoKUQkabCiwq4yXuBYJlI7NCxT6FRMNUFNr1hiHZzDRT8Bpo2Q5q5913Gef
         yBzIPAs5nl2kXFDovOVbRuoYKrX2UGeDLafZ2xDwOjObtrAYpLy7xN4g9IQnaek5Y4Bh
         jjIpH+yI95RqMl7NwkYdWOGQhA/ynOiuFx1UeF441AGZlzzo/4V+Lih+L3ptirtxaaNC
         Mg0yxdzuDYDFWTKHGac8ESC+W5BfWrpSbm4J4dGeY1FuX4CIRy/V9TY0Kz42runS5doZ
         oK5dRdnksA79TbJL5oOmfA6JG8itaUQe4kSVxL9xmGlPeS9V83fkMfBTU2G4NY714tMS
         FejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKUrPONH5MXv3i9pWWXV7OkH9VL+h0A3fm7sH+cGvaQu9r6hurMN280RkVHlzNY4F+LBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mdv/R9W5pavIPcMc/YN4tH+uBfvvtKFxXznL05t6lxFQPOD9
	d0JloP5A6HtHZBxp7e1afSvw9CfWinEVh837KRaMbgk9nydvyIv27Ooo
X-Gm-Gg: ASbGncvTDxWXI2dglgpGMc5Ruqv8824QHYR+UI0Bx9oeRy1hgRKt9anpk2OPIcSg/QO
	pkxtieMjpOEkRhberJqFWTMrYqm0lW6gVfF0n9CuYDmQ7rE6h4NhNCfL10RPSwEutf6nRfckmvw
	qpXbDDEpGbg5ASrRP443jBSmLr9Es3W5n6wCcsRI8DLiIJwbzDcxBvvvgLUNeCuv4dhv7vSB5II
	qH50kfHuPMLRHlxzmKiF/xc3y046c1IvljZl5p7374ScyniVImqrSFZhWydveeHa96yap9IBhe8
	cRQg8kn7OhBd4hGrFJLsRSQYLdtAGuX625Ue2KvJHkjdL5fRt1Si5s1youz+QUgwI05y1L5PH5R
	8zvcHTJcOsk4zVUVTyrfMMxsza22yH/jBmf5NZ4A3zdvLIcVrw0wuLySpGn/pvzUukrgBFqM8EL
	Fn5uWbDVEGHPn23RdMPG8WjrCKeUlYRV7y7Czywdgj5PNbqcwBzxclng==
X-Google-Smtp-Source: AGHT+IEK7YB6b5g9vRjs3QtpYVtsaA3O545xEkLIAQdMhsZCYtHsCYLz+LjhYU2gXqOD/FI0rh8ZgQ==
X-Received: by 2002:a05:7022:689e:b0:119:e56b:98be with SMTP id a92af1059eb24-11b41505914mr5960143c88.37.1763401046212;
        Mon, 17 Nov 2025 09:37:26 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm17190077c88.3.2025.11.17.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:37:24 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Date: Mon, 17 Nov 2025 09:35:26 -0800
Message-ID: <20251117173530.43293-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should do a better job at enforcing gfp flags for vmalloc. Right now, we
have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
supported flags. If a caller were to pass in an unsupported flag, we may
BUG, silently clear it, or completely ignore it.

If we are more proactive about enforcing gfp flags, we can making sure
callers know when they may be asking for unsupported behavior.

This patchset lets vmalloc control the incoming gfp flags, and cleans up
some hard to read gfp code.

---
Linked rfc [1] and rfc v2[2] for convenience.

Patch v2 -> v3:
  Only changes the whitelist mask and comment in patch 1:
  - Replace __GFP_HARDWALL with GFP_USER
  - Add GFP_KERNEL_ACCOUNT[4]
  - Add GFP_NOFS and GFP_NOIO just so all supported flags are explicitly
    listed in the mask.

v2:
  - Add __GFP_HARDWALL[3] for bpf and drm users.
  - cc BPF mailing list

RFC -> PATCH:
  - Collected review tags (Patches 1 & 4)
  - Add unlikely keyword to help the compiler
  - Replace pr_warn() with WARN(1)

RFC v2:
  - Whitelist supported gfp flags instead of blacklisting the unsupported
  - Move the flags check up to the only exported functions that accept
    flags:
	__vmalloc_noprof() and vmalloc_huge_node_prof()

[1] https://lore.kernel.org/linux-mm/20251030164330.44995-1-vishal.moola@gmail.com/
[2] https://lore.kernel.org/linux-mm/20251103190429.104747-1-vishal.moola@gmail.com/
[3] https://lore.kernel.org/linux-mm/20251110160457.61791-1-vishal.moola@gmail.com/T/#me8b548520ce9c81a5099c00abe53dd248c16eae7
[4] https://lore.kernel.org/linux-mm/69158bb1.a70a0220.3124cb.001e.GAE@google.com/

Vishal Moola (Oracle) (4):
  mm/vmalloc: warn on invalid vmalloc gfp flags
  mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
  mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
  mm/vmalloc: cleanup gfp flag use in new_vmap_block()

 mm/vmalloc.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

-- 
2.51.1


