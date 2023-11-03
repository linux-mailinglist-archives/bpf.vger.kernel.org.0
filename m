Return-Path: <bpf+bounces-14183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66817E0C2C
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B24B216EB
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303E266A0;
	Fri,  3 Nov 2023 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMZKUhPK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC952629F
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:33 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97890D62
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce2d4567caso1387386a34.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053751; x=1699658551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiYA+yAgHYeiJuYSIGM5fexGKe6UQxLhT2NHtWey64=;
        b=EMZKUhPKLwVhq5R4yNE85nOKuRk7VV0r0mKCtVOLDUInwyz9fgvohiq4a1O+oHohwo
         JBTWWtWhI3E1uDZDcPM3z07ZB5gUw1gTQ98d4HpOzzTLNSFmt8uMxv7q9HIcBT13o9vu
         imicmRCGJId6Ntu8GRc47zuq2ao49BIU0jicz9PGYtlP+9Isy112g7FU/XdUGX+AK4ha
         uS7QQYukOdOaiHAn7ClO9DjdxTxeK5lg3VDDO6YdaJ4PI4d+b1tLRfNJ9zTW5e8QTw0y
         L0TJdv2G4E7cRRyPbqbCPSi4YZaMwbwnClMQPRYyIvkeMnWrM0qfUnhmpgiC1gfvzK6U
         ibMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053751; x=1699658551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiYA+yAgHYeiJuYSIGM5fexGKe6UQxLhT2NHtWey64=;
        b=NgpVuHMctcZVatiSx23JpLy8B0LDZse/38i0QD6LSiXjJ0pQn7885Kd/TtgxmWvrBh
         ReQhcFcnNcvazvPa6jHJLdNwDJlgb3KaIw4wYoNg+fO3SyiuWLuIWcDdawaFOYoSuovz
         q/hdyRfbqyQXtqRMctd5zFlnmb9K9ihrea7EAGufQ9JwAFUs5w19EVd73xcgoky6JZzU
         NIooXgA1PuQ6kYQQ9+/riZAdOxm8cc7eFAZbLgmiXaVYt/JHdQcmQu01UzfjLfcYvbtl
         Al2wz0CcKS+r1Ua+Br4lRMdGUgnuhO61qU277EOxIgaCeh3P4gfQiECx31thCEn+fcDD
         VAfQ==
X-Gm-Message-State: AOJu0Yyelbt+JI1emwx0niQSOPq/chI6NYnrRDJnfOtARkJb9oEQ0qJ9
	Y5RkgcvzdZUgFYBo8LoKeg6MPQS1q2Q=
X-Google-Smtp-Source: AGHT+IFu05UWQLhwd4Zoy7RrfzoKSYtLj02CP/ROfIzL2MurSkrhTX49hLiI8397D/fZvB+E6p8DLg==
X-Received: by 2002:a9d:62c3:0:b0:6c4:cda6:ff3e with SMTP id z3-20020a9d62c3000000b006c4cda6ff3emr22921370otk.18.1699053751787;
        Fri, 03 Nov 2023 16:22:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 12/13] bpf: export btf_ctx_access to modules.
Date: Fri,  3 Nov 2023 16:22:01 -0700
Message-Id: <20231103232202.3664407-13-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
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
index 490b5595ed8b..0bbd212bad7d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6140,6 +6140,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


