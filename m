Return-Path: <bpf+bounces-37837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4395B0BC
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC41F22202
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F8170A37;
	Thu, 22 Aug 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGg4AdeS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90217C224
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316094; cv=none; b=CS8ggRZvnwtOmMmPzEhBiDHeZ9ixibUNwnjV+OuYK/ekJe1YMbtyBYuW0L7Iy+CpgzVDouyYqxkrziQofkY7vj8aZVf2GlBCXl/f5SVD0347L9l8LKqyNtmQtHsHxhvEFhaFtsQq7kWKJ0Oq1FOqUq22dHshS/ddS9LXEZEezHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316094; c=relaxed/simple;
	bh=h8BV47jBODJvK8yR8ErXbphdg6EPxoTY6p1WKqK5ISY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOYP+9JnlNsn9k6gdt23toatke3t/qOogAEu0MI4sBszE8W+l8cr03Rvd2K4uUz3t97m2J90gsR9Kv25HpXezjiNtZj/O5NXteY/WIqNTK36pfmahKQgz9V+ZH0ylN6IKdZKGWBeZh8ewfsrHERmGuktMDyKrLikROAH3l30WK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGg4AdeS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7142014d8dfso449868b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316092; x=1724920892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsa0n2Jb5f9A4YGXDvRlV32yLFSY00XhLTjGYihf/fo=;
        b=YGg4AdeSKtopAvlmaIPAhxDED301O1c+kYR9N/9JKSlKM2L7JGUCnZislepFjmrv0x
         fuQNNzH3WjhKt0XLYprrpNMy9+nkXUc/0baG9xiMttwS0xHpyRvnq6xGEKtro+JVIPt4
         z+z2U2PRtwsom7d18RQPog+V+mQUOtUSKjf+i5I55IOtMDMh5Yd1A4ogg5hWvrgR5fCo
         /WUyHmhf7h8JGp6uPCLy9sNRqQPphXtEoNvp8UMR7iNjYw3rYrjljM+wXJZYMKVyB6lz
         y9h5ZaZppra+QPEC/qM3GbSCeEZod65beN7QP8WES4YQza1TXUW8+Ujna8HB/wpszEqw
         MZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316092; x=1724920892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsa0n2Jb5f9A4YGXDvRlV32yLFSY00XhLTjGYihf/fo=;
        b=w6x6k3z9j6SXOZdaICP2tTbKEIdkfov7z/pQgDdxCtxYukSCX3jD0fvCYj6K8PIwpg
         U81CXSAyWs2ylzxZI/uhSkfR8h2f0HZzCcRVW8flXQL8ew3djFJ5Z1uhkCLtPeThRMO6
         AmZv5QJEGVs5mqOFL6iZSS6mOTnkxJGPxYzjt2ZyZDVrxAXUF5tXiqfhRHmbruthTMF8
         2AgOzVWkvVLECurZAjvWsb3G2DLUyYhELbPevwZTFXLVB8LaohdkSJ0qdmby6HslULEF
         0mDGEPpNBkOXbXpNYUntACLG1Tx+bun6UDTOD07mWyKYCYciJDfY+Lw6QbuZi4uyBRIk
         5ezw==
X-Gm-Message-State: AOJu0YysSxRgpwVWg3I/wkDWPXe3nwJqD8Mq7I1NhiB/0ay4XSj8G3jh
	WhPerfzHXqoGL3eBTJdsdqvBWM9f/gRUTds6cpaZIRQCSDuhROSBhAlBhd5p
X-Google-Smtp-Source: AGHT+IE2Q5SC65ih+C3L5Zo2d+f4KHbG8LBMtkJFNYwkfoGk4qv5hn+0c6wRwDpniDBw4a3tx3m2QA==
X-Received: by 2002:a05:6a20:d04f:b0:1be:c86e:7a4d with SMTP id adf61e73a8af0-1caeb34a613mr1204511637.53.1724316092021;
        Thu, 22 Aug 2024 01:41:32 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 4/6] bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
Date: Thu, 22 Aug 2024 01:41:10 -0700
Message-ID: <20240822084112.3257995-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
by a single instruction "r0 = r1". This follows bpf_fastcall contract.
This commit allows bpf_fastcall pattern rewrite for these two
functions in order to use them in bpf_fastcall selftests.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94308cc7c503..543b8c9edac7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16170,6 +16170,9 @@ static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 /* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
 static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
 {
+	if (meta->btf == btf_vmlinux)
+		return meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+		       meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast];
 	return false;
 }
 
-- 
2.45.2


