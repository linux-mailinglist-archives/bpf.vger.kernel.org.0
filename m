Return-Path: <bpf+bounces-12933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08BC7D2117
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A51C2091C
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD371396;
	Sun, 22 Oct 2023 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuhr220w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7C1C3B
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:03:59 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D35E9
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce2cc39d12so1580206a34.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951038; x=1698555838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huZWoRNkRcoXfybJufnOZLqFrDN4rS3rGJ7XaRNrCoA=;
        b=kuhr220wKIDWXpJGQ17AZ+fBoqWg5eEbpjZb//1ZCT0N/KB1zsPy+/nkVdiZ/HKfNF
         9BcDIUqJjNXYbUt3JyBKiSAK49d+uGHr7017KvvmgPRdu4Jo6eaJqB08Uz9sE3IKSqBT
         R2xJ3prVlDuWI2SYCUps4PVcm+Asg1PA2PCNkFsnlZzO6Azv4HeCPSPSG+Xj3+C/wDuh
         Omh8glqljpc3YRIdo8jmteNwjZp/XxN8+QBXaPoJYVMcVUB1WRF/ilUK81ohYy/1zKrb
         Fr3eY8P3vTPckFrWBu6mBD/TiMiGkJrCoXMloppHmLsoQ/2CseOz1CmZ12rcU28epVU3
         gD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951038; x=1698555838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huZWoRNkRcoXfybJufnOZLqFrDN4rS3rGJ7XaRNrCoA=;
        b=pOGaO8KZke8/txi9R0hck3FFvw9hpG5o3wpg/aQwNOxBKexPx6fZygWhWnelMXUihB
         QCmqtDzR6HKEAfaMuqAsU4TkHzAoTXYio/mtEML5PdlH845vE1Z8+psSXXDVeUPvnvKx
         QpgF/9kFySnrjMJB8O4AU/7abji5DAg0otMTXBardv04iynZIubkG/a/caQHFFNYr69W
         QlPF7wvpTdywGAO/bi2iUPTBFKqBAguhvxKVWILKU9oV/T5busaUiBgnYbwUtRi2SgQ/
         SNEmF8SkYLs3/7RMFKR3zqUgP7C7Kc8/YOS8k5FdmB9pHiudM1JgA+RizgYxsJGQZb+B
         nBVw==
X-Gm-Message-State: AOJu0YySDAInsojHYlg43BCuibQ+zgQGKkx6Zmx74RvWPCRcJTDj6F/Q
	+1ZxbiEtFj+ak0ojhVPuBas9v5Q4HEI=
X-Google-Smtp-Source: AGHT+IEtMpH4vM4jvoS4g1X0yJxQowZIaZnJZ7qf7ba9serFXjjWVqnWSU78+IwUCh3UL0voMe9Ygg==
X-Received: by 2002:a05:6870:5d8d:b0:1e9:fc32:9887 with SMTP id fu13-20020a0568705d8d00b001e9fc329887mr9038115oab.13.1697951037966;
        Sat, 21 Oct 2023 22:03:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 09/10] bpf: export btf_ctx_access to modules.
Date: Sat, 21 Oct 2023 22:03:34 -0700
Message-Id: <20231022050335.2579051-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022050335.2579051-1-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
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
index c53888e8dddb..3773f6b16784 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6139,6 +6139,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


