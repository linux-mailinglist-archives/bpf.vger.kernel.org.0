Return-Path: <bpf+bounces-18126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F8815E0F
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF451F225AB
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D03C23;
	Sun, 17 Dec 2023 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIaW7xdv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07403D8F
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbc666461daso1358554276.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800718; x=1703405518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rmpNnk8wEhlIUifPMEMGUACM3FwSpEH8646eB8Cqo8=;
        b=GIaW7xdvlcAOFnUIu8osxyWYxtdNRmAroLybmeFoUDY+toCfA1YA1eBBfn8XAerjkp
         0LlQq50y+FMvTaioEPei7YGRWmZAl7iLMOBuotV1gEKGAXg/DEhTQivcfWvyNaBzroCo
         +PqBUgjZlY4H0haJCWjB86YQdKOyZFljw6qH4Oaxg2SHW3N3MXP6H5B6ZeVxTt7To59g
         HDIYmrkhSU/RoQnC+sy0mga4LG+uS7fq0OSCnXMGIF160+zrwMJqIsB+F+/wO6cpT6cv
         GBxkVnalk0XUlNJYvdJA+q4aj/gQdyf3Sv+kfn9sTbB13LwK664ZbygpX7OUo/WSlEJH
         dqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800718; x=1703405518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rmpNnk8wEhlIUifPMEMGUACM3FwSpEH8646eB8Cqo8=;
        b=Q5UBgPlczOFHHWgcb6IK8FbriDoB/6Ku6z2czhm3jCN3YvAzTJxiHQhURmkdSV7w3d
         Z1fmCPCMXPUQpi5msfzlz1NYZZJf02jePIgvyzOP/5xS7+IA+5qXNnWDvXrEFWx20S5e
         M8sfkIWKeg2kHDepwi5vZhKVrxpTTthQMPtFwXL674l2klNGNjyXA4dVeU/ttvPD1kuj
         PrBnGDy+HyopX3gpbbLpu6zbO8ZECDjNo2l+Iz3Y1k7DtkYM2FiLIx1448P5N84wbfvI
         j8UQIeq5fngY3lHY4gNde1IEhOoSxR60Wug4McksGCzH07etTP9FltU5AsiuQ6qKdMkO
         Zogg==
X-Gm-Message-State: AOJu0YwTV0YspHx8l9VDzwLRVYtL/NfvHtTYi7M+00/3JzNSYhFxUS6O
	ZWBqs5wMIW4NvLHHoee5KdU9XaINuWI=
X-Google-Smtp-Source: AGHT+IGB2wMCgpN+g9Jw8IWoDso6qiKzwh8oSP1FKcc1MsWw8uF7jv7QsJ4NT+2qEPGIEvYXtk91zQ==
X-Received: by 2002:a81:8642:0:b0:5d7:1940:f3ea with SMTP id w63-20020a818642000000b005d71940f3eamr10752305ywf.82.1702800718347;
        Sun, 17 Dec 2023 00:11:58 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:57 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v14 13/14] bpf: export btf_ctx_access to modules.
Date: Sun, 17 Dec 2023 00:11:30 -0800
Message-Id: <20231217081132.1025020-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cd6b10ee9046..7ee92c055b41 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6142,6 +6142,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


