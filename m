Return-Path: <bpf+bounces-77361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 952EACD8D21
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72011303C275
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385933067B;
	Tue, 23 Dec 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9FfmGBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8530BBBB
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485947; cv=none; b=ZA+AsCL7R92R6Mb3WjSD15GYpPwXpQeK69uz6Arif1unRGMPreVw9TkSZ3u4EJe09kFkaMcH2bmyfsv//eFBAuyNaaXVfl2OE9Ecp9oak3UyyDSlmQsjG93YWwd863mUcDb//uiu2Z2wshk0KdPhOLIEEWVlG3StP4mZNiW3iRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485947; c=relaxed/simple;
	bh=x8N+hE9sMfmTC412S5/LLX9XgmMWp85F/kJbUlBTUEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt62VCgv7UGDHt0Jd+kJhjebBkazKwQpMZh6XFQzjc6liykv9rxpdmELyXMGgxoRw82fgOaxF/xFrU8JcQfgG3CoyBsPdlVZwKpeVcXqTcKQ0Dzrtni5C1eilOnTBVQ2uCJPH6apL3Ansli6dUcTaN7ISmDfOgkqGMIdnK/Kk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9FfmGBI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09d981507so35052565ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766485945; x=1767090745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNJLuiaipjlLN16Jr2e3fkSF+XbRwZGABwRVEwucSNs=;
        b=H9FfmGBIDwx/co/a7e26UMKIgwcXT8OT2drMgwMsY/Ts+fe8IXuUM2+GDG6oRZ/cSS
         lnVoFqw65hDaYQ82KJOvvJtQYXknjm3g7jt5WUy7PdnNO9skJoCZEHiLzcBb/ySWZNP7
         D0saH2p+xXwwVTbCtU+fuJgXT/aRBXf600Wzc51skZYXDZGutG0Fg5fLazuTmhM3RQYp
         G7J2C272z7wuE4QT4INNt4auR8eYS/SvSeVnngCkwUc4y6kM4sTYeQd8LUMjqEY3jtXx
         iL9B/8R75rMmO6gW9Gbu/rppj1V7GMKE2RBS/j+2uPI0P9EeF/RYJgNmuRO7FLts7yHo
         xxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485945; x=1767090745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNJLuiaipjlLN16Jr2e3fkSF+XbRwZGABwRVEwucSNs=;
        b=s/wPNR00jXx9uWzI2ApXf23UXLHeEBq6JpjjseSa7n09G+4sB+GoAzcFS87+jn0zWK
         Jxg+kEwqP5aclzKyIpFhjstA788kGImqsXsX5RpXRHIAjfCH8V/9ucvcaHJB1b0RtcNK
         42v9WKHqLkuNiokhDkHJQwEwqmMn9Ju0/1jk7inK71EwJVWjHqxk/eOqLDjFkDiOPo0s
         E2kfipDoQIoxH3cawA3vcXeg1QbGOXsylJXY/xnGc30UnyhtjrZznsig5L4qNSlO1zp2
         YJCbkIY+bN25ypdiF2TkIr8tjXP4lzmaw4CLgC0qkMb28VVTD9iGUoovB4CxJxNQlkKY
         UNDw==
X-Forwarded-Encrypted: i=1; AJvYcCWmKnFa2nc11/wbFWJ5b0xb0ng7HSkSZtxyTjrvF25KTJub9xrl5dPDTKTxUQbTFvDBrRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7x3mYyghutFcaxYmyLumg+1Up04jY8LuU+cXAoICfAvVTXIk
	4UwF5WWJEikuVkzVIrDdOtunbrWkanN/m5MpMMWeJBa1ePQy+DnBsWmI
X-Gm-Gg: AY/fxX5+NO7o8OcpydE1UFh6qlH1Nd6jl3t94ha95cKzwA6n3C3QHYTdjEeFiKR9RPv
	zhHEWRiVi7oRKsl9jZKZl7cQKTa6u0ZFhRs9eWpY564bfKLCdqdaKOXRAxo1gUvFN1fRJV9v0k+
	JLXbXdffITrszw99TtJ82m1GbdOQY5kO5ltvRfxR4uBXXxCdd3vlOyu9TIf9hnsZ13ASEwq96tA
	Agxgjq2h7cl0mBpDVlrFvq2PfWfO1G718LLehGG/JRARi+/HU3M3iTVorau5/iQhIt1+xovRtR+
	KpUfl4z5m5jyqSNCC6GdZgBXdltDjtD3nQaVxQbaPUupPKgN88M1FF28CoR6gHatAP8Fn9PKex1
	dsqyGdTPQxs5k4TZpMN4tCmX1W1dXn3QIwboMjSX/w3ta731AFZuzT22NcT5QNE7FSlSpTkytdh
	qCAaw=
X-Google-Smtp-Source: AGHT+IFwl2Sq6w/F11gUh0mTAkcsqNVsmcb8L+llvOdKJrCAhJrnGCxSRxwRK/yOWDjP9bTC6SZsUw==
X-Received: by 2002:a17:903:41c7:b0:294:8c99:f318 with SMTP id d9443c01a7336-2a2f0caa8eemr166946385ad.3.1766485945235;
        Tue, 23 Dec 2025 02:32:25 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm122429495ad.25.2025.12.23.02.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:32:24 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
Subject: [PATCH] buildid: validate page-backed file before parsing build ID
Date: Tue, 23 Dec 2025 18:32:07 +0800
Message-ID: <20251223103214.2412446-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__build_id_parse() only works on page-backed storage.  Its helper paths
eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
that do not map a regular file or lack valid address_space operations.

Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 lib/buildid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index aaf61dfc0919..7131594cb071 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	int ret;
 
 	/* only works for page backed storage  */
-	if (!vma->vm_file)
+	if (!vma->vm_file ||
+	    !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
+	    !vma->vm_file->f_mapping->a_ops ||
+	    !vma->vm_file->f_mapping->a_ops->read_folio)
 		return -EINVAL;
 
 	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
-- 
2.43.0


