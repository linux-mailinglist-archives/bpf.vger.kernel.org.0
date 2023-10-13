Return-Path: <bpf+bounces-12204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F77C9068
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F774B20D74
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467972C86F;
	Fri, 13 Oct 2023 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfo42Nqq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9B2C84B
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:20 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20641B7
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a82f176860so10060027b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236998; x=1697841798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erUOV4dNptkdGGqSELDU+CDiUZ9qDYiO5ZXsDCge60c=;
        b=Kfo42NqqGhrjRH9N0cZwJrUctzOPgDoPTBpyNGk3LvFqftF9MdYKiCJ54uoYVT5Xvv
         m5q1xdd3PL6tjIz3lYZjtlT8JlgBpE047FN5NOz8dqzfzOJ2TS7euo9xs9tvi6W0FUCc
         uucy3eBEftSU65JKxtfllEGL3XqCE/CRlT7YwSW4UvqYVwdPvSHNlzPMwBwgZljfk68T
         67g1Wgx2C66Ia3CBhdA2YVL7HkYvAiPxjojBQ1gdb6ZyH5FzfuQRWQs1ntgwv8SmXOEY
         mHDL4bA9Wiu8BBzuHlVI6akQv2cOqJSBdFxHdmzvzeY+DKUFdQZQXTTZBmxxx4cbkIlM
         YsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236998; x=1697841798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erUOV4dNptkdGGqSELDU+CDiUZ9qDYiO5ZXsDCge60c=;
        b=JBY1xjQQNZiyVI84/9pJ83tZli7ytvLAt5OSKzQv9fSd2IrECrEHDsO8/SZZeg4JUf
         G/EiD3N1JlOn2X0sp3JlMeY3n+HJP/eFqvxw+KYCRvPkjnXc4VnmbDkrgs9wyDZQxI5G
         LHGnChCh3Z1MIR9zusRuMdoh1P62gv9BFh9pSag2ZlYGXvNL5Odnkvyo8gIz4mKHjrGn
         PJEPT9zsNt0p1AG25OFWXJfhYMqFrv1bpvXMEl8cls5kn3aaXSBj92iBXepkSOXGscHZ
         fGMGYQjQKat2eWrll9hxJYCUUnXHOMG1pzXccIAentUPPEhNSS0BHO/Dn3Krt+/PwPRO
         yYVA==
X-Gm-Message-State: AOJu0YwYgDzFGQ1dy3WyeAjhB85MvlW0dXnr/AhOBa5NOhn6TWxkG6Iz
	A50sF1LZsbG4yAmpJPQ+cFkfAiMGb3k=
X-Google-Smtp-Source: AGHT+IH0uamf8tItSPELZfNGi1v6HvlWO3AQ/TAgvXrL3wk0AO9VW+/po9oqR5AWeQ5e/GsQLHQKGw==
X-Received: by 2002:a81:b620:0:b0:5a7:ba09:e58b with SMTP id u32-20020a81b620000000b005a7ba09e58bmr14025999ywh.14.1697236998080;
        Fri, 13 Oct 2023 15:43:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/9] bpf: export btf_ctx_access to modules.
Date: Fri, 13 Oct 2023 15:43:03 -0700
Message-Id: <20231013224304.187218-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
References: <20231013224304.187218-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 990973d6057d..dc6d8fe9b63d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6141,6 +6141,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


