Return-Path: <bpf+bounces-14325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB447E2DF9
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160701C20382
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E92E639;
	Mon,  6 Nov 2023 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeGYVPgS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5862E62B
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:22 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B119B3
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:18 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afa5dbc378so53028107b3.0
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301597; x=1699906397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEho8kVQI0UfjE7sQSIDOb7jKBVuqGHDr0h2vIQuWQQ=;
        b=BeGYVPgSlbvcZlYdxQECAf/01/quvfTgrxt7/aIsvh3iqWJttI3z/3F7itV1QdQs+5
         +1WQZHXTSoS5DHpacpjEcMk/bobUcGSrtHS1Y5J0+UhIXIhJY5IHaO4BiKGEuRxuYaMM
         dvG/qvhh6otc5MYnxQ3Z6H8/NTfsPhXnEwAvz9pfEeXr4+IFa/UOMfeAPP1INn+alI/o
         B8LmUZU1VSuwz8JhmkD2MOAF9ACYMgJaifVEX9q+mKxEknC4gJJfE9iQLEmhwbcO6bYO
         opmQjgDmLob6ZS8UZkSwYxXh0dADEDl827NCssfoaqGW/tisWzNxS2MC1HvNEzxYAz9G
         7kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301597; x=1699906397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEho8kVQI0UfjE7sQSIDOb7jKBVuqGHDr0h2vIQuWQQ=;
        b=Dh68x7wgJFXKEgGJWzt7LoUVoN/PYvSkYKI8pZ77IIi1cFPWdqInlnYPjBBuVknY4+
         ZZ1yuvrqVrelVbQF3wnTRA84/BLnEpDmom2+169Eza/XiZhOQIz5kO/Rt+Y0AS00LjP6
         ZLizUxtX8No7e8JC7M8iWKsHccefz7PgywWwuxFLMHBIOYNAbyI5xOjkdrzXNAuUQdtX
         CRncg+ncyWc0zKx4+cqQHRUJ2xzg5Fe5E+wDYm0KV17XHiD9in54FUdBHsIZNGFGCOxx
         4U9pOXYgWP30HZwCWK/ZumZKHgM7sOKUpZTJnRZWkm280Dwl/viKr5ZgA7zR03DRG9AK
         06rQ==
X-Gm-Message-State: AOJu0Yyk1wA9i8AG5M6BSejXDagiz0KPqVqdo/9y2R2xClojtUWwcEGB
	/WlLhdZlSLTlXRMBHR/m/T65A1E9kPA=
X-Google-Smtp-Source: AGHT+IEAdQ7hQEYY6UCumkfkc3HGTWZVI3+1IjwfgCr6w7N2kkAEJzbS/LI96PpfSsCP4WC+r6D5GA==
X-Received: by 2002:a81:980b:0:b0:57a:8ecb:11ad with SMTP id p11-20020a81980b000000b0057a8ecb11admr7756317ywg.43.1699301596647;
        Mon, 06 Nov 2023 12:13:16 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:16 -0800 (PST)
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
Subject: [PATCH bpf-next v11 12/13] bpf: export btf_ctx_access to modules.
Date: Mon,  6 Nov 2023 12:12:51 -0800
Message-Id: <20231106201252.1568931-13-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
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
index 7165a1beeed5..e0812b00a6b2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6146,6 +6146,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


