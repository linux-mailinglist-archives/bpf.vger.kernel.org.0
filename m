Return-Path: <bpf+bounces-21599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFAF84EF93
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C971F28D9F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA55226;
	Fri,  9 Feb 2024 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE0RhHv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64C5221
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451638; cv=none; b=mKN8lMFg3PchFN30VSTHK8/W83G5t0SsOKNM+97qJkmxcg7Lo+KrElZXx2SWyB/WxqQX9TgNKHWS5SKQcIo/quwIkdLW7hFO3lo8gzyYYpcXPkGQnZlQ0ccEqRniC2GrHX3LXA46SC+KT5jMyynmGQGLoOM8hOL6Cyzq2q9HtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451638; c=relaxed/simple;
	bh=D/TrAhQWAcIDdh/oQnU+KCkH9OnP8LFJRj8yUjQYKhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvEeELxnuCXhnL/UNhwj5m4ArBx7z7gzmipurcICV1kPV2HHSnttQTWw4tisHhDHR5AQBR/pvyaj/+MMgSS5njcaXd1sfNTbzQOFprw89kBbi1xQDLBmr6zd1KeHPBJiTu0ZaQP5oG/c3dEjzglEXiEoLeFN6wTvnisIjPaY1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE0RhHv2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso437704a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451636; x=1708056436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCIDfn6Q/Sj02IoZMnsUeC+cwQq+R0K4Vy6avN3EcgA=;
        b=LE0RhHv2dns8ZgzUmerp0A8r/xNz02j/fdXW+6Awzqu4/+3D/2AkY+pYgvkBrq12al
         Pbjl/3vFIBG1n8zGAOgvoUx6fca0t2i6Wxlv+RcpI4kaiDZusMxlpHiiQt+e+HWSP1nU
         any7uvFtO4CMYbYrh8hF8F0vDZjPHqyXCoSTbgkz36zwZof7Be94XY/PwMHf7nO/sqCV
         t26MUkvMSd9ngVzAdhrcEYseN9h2NHJcoWfZzk86H/wWujW+/p5QNLJhJ6QOb2w2iVvK
         5ElYXgzzxiCT0yOdQFZ50iFZg6UTFn1W7rc3LWYxYXT7HN13yNDiJo6MKAdBLFdxqPQu
         UwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451636; x=1708056436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCIDfn6Q/Sj02IoZMnsUeC+cwQq+R0K4Vy6avN3EcgA=;
        b=lcQ7PKnvG/PXNfQZ9XoET63+4A/5eksPATfItjjFCq1QmiScg3Iilgkta2AOH0SmfZ
         QymIiDMQHMxXImT33YwDeti2p5V9h/jHiCwHLxC7np54EMlmpXcd+LTYpDdEF+dAc4e/
         1DgY5tPbQP0GmfYlf8FXBiT781VlRj2JbI1Ek8n3X/PpjHfgXnutR0zN+GL406e1u23i
         myWRke4t0m5R5qyjkKnl4ISo9QXms5kl6xV7w5NFP5kKA2I1ceCysWsDfoXs0xGj7Bf9
         gff2FQc24BdaA04+HmexOilNly3uZPpQbVRc3CwwWZ269KoclpvR6xx9HSDNf9AKgEPC
         Ijkw==
X-Gm-Message-State: AOJu0Yy9WtVYzFBbeSIXNvrL90OZST9/YPAm/OyjlCcZqXztkSvLH/1Z
	anJcZw/Ej0Gy9tynFBxcj5x65hwZEx94QnoF7+1qVUFTK5Su8Kbdc2ZQ07aE
X-Google-Smtp-Source: AGHT+IEi6h+ceTfRMJ5dI0p3X7XJYh4ZzKQVqNqt1uF5ux0MvuhWLqAFaBeMLSjm/CCs2wr1Y3GeYQ==
X-Received: by 2002:a05:6a21:6711:b0:19c:9c2e:7860 with SMTP id wh17-20020a056a21671100b0019c9c2e7860mr691997pzb.13.1707451635981;
        Thu, 08 Feb 2024 20:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXL44286flKbPuiC5jJpQL4r9tnFLyhpDpeoUK86uHyxm1KmiZjhC6iWst+l0Yj3ohxbkOTv9OMTtkRZouflvj/p0qsmCfCCNN+RU3re5UYu0eZbWx8Sm3Trzrg2OIR5wSWop8s/7FQFUH7FL46mVTYTOUwdUDu4w4XDY8IA5NbPjR3F59YeYpxDdlZ6qaYXgatcmUWxkbTYM+4Q6SW/7jYYzybmfjOPjllVmPAAYXvZ0YIqXV+dVZ+aEPOeAxlLZHGJST60otvvVynWglcMCjg34Qy05PuwmX05Am2ndC0Gyx9LCDF3GGY+BLLY5ra/6Typc56SRoEhQjNtaZfxlsYSSewLkgZjqAGJ0j4Ju5PQ7l/N2P/Sg==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001d9a40e204bsm551470plz.21.2024.02.08.20.07.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 15/20] bpf: Tell bpf programs kernel's PAGE_SIZE
Date: Thu,  8 Feb 2024 20:06:03 -0800
Message-Id: <20240209040608.98927-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmlinux BTF includes all kernel enums.
Add __PAGE_SIZE = PAGE_SIZE enum, so that bpf programs
that include vmlinux.h can easily access it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2829077f0461..3aa3f56a4310 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -88,13 +88,18 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	return NULL;
 }
 
+/* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
+enum page_size_enum {
+	__PAGE_SIZE = PAGE_SIZE
+};
+
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
 
-	size = round_up(size, PAGE_SIZE);
+	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
 	if (fp == NULL)
 		return NULL;
-- 
2.34.1


