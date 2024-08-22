Return-Path: <bpf+bounces-37794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768D95A8AF
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB90FB2207B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC626AAD;
	Thu, 22 Aug 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEY9KqrB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F26320B
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285934; cv=none; b=KHVnns9notprkgxJq9YD8XoLIwQvpskMMyaiupsRDWUxNMTftd9ALrubzYjjfYP8klJ1IU8V/+1b9tY+LHtVqO1nfp00wEvH8A4LZ+j3hQZ8SNPW2dpUmqiii67wVGcyQHvmd1qmeNHZLP5b4/y0xdkJMg6cn90DDxTCDA8S5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285934; c=relaxed/simple;
	bh=kVyy1MZAN+0vRyfBg5fStS7s14Xtxk22NBHaV6WmBDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/R14s9CPq4q7DXuRjl7dHasbA11ZpWx0H0QE/yFv54LgShZo8ovfYEMShxL8eDyZIMJRcEUhYdaRu/K6Rl3faAi/HyV3im4bxDEopqJpj8vOgaJKVp0GSLJr7pbg7EyyqMs20/UQJS0GsU3QKlSFieOU/9WliW4GX2jwSj7niY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEY9KqrB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714262f1bb4so234162b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724285932; x=1724890732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcww5zT0v3DraoesAC8Z/sFkSYGmunnl86XXVsE3WNA=;
        b=XEY9KqrB9rN75Dd+QN1YAy0weJxhTAHCILpwq6KK4+580v6vbzmxasMKn3JhalOFYT
         UsBHFFcQuq9IdEP8PCswzqowxrpacxGzdIQNJBcYwcuJoz1qw3SoL9c7vu/3nzt/CkR6
         iQsdpwMsmq91xAk7geVqf/LJ47xuV0M2vJ2MCdomQCzmi/Y2Asp1Npt656wOjV8bonIl
         tY6bMIlFLtmTXdj+pF5srIpWk53BglnLVTOwixcnXJgyanS3KmF2Kg1YWCBwBB5gO+C4
         mnO7Cedf4T9/+lgw5D/A7gxyDsd5y0QAyorH+cFkTL89j6on0tmyCk0Hijetc/VkHWEJ
         6ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724285932; x=1724890732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcww5zT0v3DraoesAC8Z/sFkSYGmunnl86XXVsE3WNA=;
        b=SqdxjSbIiKTjD9ZPGOu9AFn02ZrHooSPDED1M+OdFJ3RLyIhsEhB21RCJp4WE9HcuW
         DfRTB/6eU43dPLAv5KKnxhdphu4WtJ8COE0m9kLfYFmWZdvHNW6lJpzwu/URGssLu87t
         fXlanijVHMo1CXNj50ufA/WDJViL+aEygpWQfEQi0//onGjdmhnonr3QPlDjwwgK+ybV
         ilb3BFEVBnBMiq5sWbid83kfIhOgosPWPekngtJvQlnColrNfBw6zZbQcgreeQu3n/cT
         6nHLbX2XTkTRkF5ZrTkFYo3jUr2SNzOHS44TgqMGyBUPn/n/9lYcmzdNHEIAtb8N7dOO
         9P0g==
X-Gm-Message-State: AOJu0YyGP+6ghvHm+ppr+VmA+bLY1qEA5ewJyvb98DW+d8UcdUao3v3L
	ZIgEcqVLKOAszTq197S5zN26bGwMghDp91q2xWDjSUcxjb9CiYzd9VHY7GvA
X-Google-Smtp-Source: AGHT+IE3mpFEXsBXGmW6F2638lPC4JH5424iICa6m43PIFEAEFSFWK0LfDgGEWNKnM9+qbR7rL/P4w==
X-Received: by 2002:a05:6a00:9443:b0:714:160e:8f5f with SMTP id d2e1a72fcca58-714364b88f4mr272325b3a.11.1724285931977;
        Wed, 21 Aug 2024 17:18:51 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424e145sm231448b3a.55.2024.08.21.17.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:18:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
Date: Wed, 21 Aug 2024 17:18:36 -0700
Message-ID: <20240822001837.2715909-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822001837.2715909-1-eddyz87@gmail.com>
References: <20240822001837.2715909-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
referencing a non-existing BTF type, function bpf_core_calc_relo_insn
would cause a null pointer deference.

Fix this by adding a proper check upper in call stack, as malformed
relocation records could be passed from user space.

Simplest reproducer is a program:

    r0 = 0
    exit

With a single relocation record:

    .insn_off = 0,          /* patch first instruction */
    .type_id = 100500,      /* this type id does not exist */
    .access_str_off = 6,    /* offset of string "0" */
    .kind = BPF_CORE_TYPE_ID_LOCAL,

See the link for original reproducer or next commit for a test case.

Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_id().")
Reported-by: Liu RuiTong <cnitlrt@gmail.com>
Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b12db397303e..e38e770a6945 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8888,6 +8888,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	struct bpf_core_cand_list cands = {};
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
+	const struct btf_type *type;
 	int err;
 
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
@@ -8897,6 +8898,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!specs)
 		return -ENOMEM;
 
+	type = btf_type_by_id(ctx->btf, relo->type_id);
+	if (!type) {
+		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
+			relo_idx, relo->type_id);
+		return -EINVAL;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
-- 
2.45.2


