Return-Path: <bpf+bounces-13505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA957DA245
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8606282617
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C433FE43;
	Fri, 27 Oct 2023 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDCkvxTR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E03FB1D
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:17:23 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997A1B4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a8628e54d4so23012107b3.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441441; x=1699046241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=WDCkvxTRFUnmZvqNqkqPLUeySvk/5zn72ewugI+KMlBCmak3Cpq+sMG037zyxt43nJ
         Wb16ON7ecv2W6K1/ZEO5+lsJFE4XaaXnm5ZH5m9D0B55JXOtr1ONoO5oeqRk5mJ9uu2U
         0XEAjv9k36Qd6B7Qin8V7zcTNVQTXzJWH6tCR37XOHSyEDJFBKPQG2iGzKIN5p5SA/Ah
         IcdY3GYQAz73zB4E4f0RZuTSdYzyGnUn4X1ORuAkRI4rmj7tLZKt9pL02kU1mX0peH9Y
         SKRmtvgYCly9a1KXYmE4Q90Ocxs2GKD/QuO2wQR7cpro47UDamBsWSTLRwwpgfW5v2pH
         PIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441441; x=1699046241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=vpmOvSuY02LZ67Q5oxuMTczJmXWlSftJqMyKLeFkBdBw6RuzrS8CKUGqQWngQaRpwO
         bY7Z/As9NHzEM1nzqGsg1JeQyBrvwzxlR8V/x19UjQRd3BkOFuaUjWido8R2Nme1umOk
         xMuZvoKTS3YXew18HBUi1Mx0gvebw3uGxPWsbflmuwkC6FMCK3Is5jWeekjGz52CjMCp
         XBULBw9o70q+7wYtaNOEATuobdg480AqXS4n3Ri2gGQZ/Ga2AYmhi19Byr8SIV/R6AG9
         KCYdK4FL3zk/o1kTBt1FJo9EkC1TXq7J+b9bxYo8+DzoTUh+w86kTgXcfiD9kjSuQIzt
         ecjQ==
X-Gm-Message-State: AOJu0YxXh422/O1nS62TTtTtc81+BJ1XIO6I//287+A0K7ldALGHimtb
	WzlrHRxcPSdU1L+KnlyX6jxPGNnLljg=
X-Google-Smtp-Source: AGHT+IHo/BoafNnt/NUerPaF9Xu5KB/GhR/7dxK/O0coqw8TyL1rJRTGyRAnema2C4OUxIEJTVnm7g==
X-Received: by 2002:a81:9b46:0:b0:5a7:c8c2:2947 with SMTP id s67-20020a819b46000000b005a7c8c22947mr7341612ywg.16.1698441440994;
        Fri, 27 Oct 2023 14:17:20 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b0059a34cfa2a5sm1080174ywc.67.2023.10.27.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:17:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 09/10] bpf: export btf_ctx_access to modules.
Date: Fri, 27 Oct 2023 14:17:01 -0700
Message-Id: <20231027211702.1374597-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027211702.1374597-1-thinker.li@gmail.com>
References: <20231027211702.1374597-1-thinker.li@gmail.com>
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
index 57d2114927e4..38f0611ee2f2 100644
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


