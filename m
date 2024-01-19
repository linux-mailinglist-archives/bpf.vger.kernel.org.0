Return-Path: <bpf+bounces-19933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA18330F9
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36359288537
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839585BAC6;
	Fri, 19 Jan 2024 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXwJ7Ewf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC15B5A8
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704646; cv=none; b=ibmRXCki01NcU2Dgr0DmaNbdnzz+up66bXnnY8gkRU0ySbDr66AyTNY3roNCWXsl/bpY7MyobwftFcPoi52v6IvF5ZjRmGzOXN85JGHg/TW2AbjZxGK0stPsr6D9PlsqEcJNCZVaspdj8PJRjspaIun8QgalMlnOevF3Ln4P2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704646; c=relaxed/simple;
	bh=oBXE3CnAP46kpgl0To4W0wqsrZpEKNQmFaHxyNWWtT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmLEHU3NWNFfzfOr5SAavvUsHu9aWETFHAO56AimUzE5TwWhMl3kLI9+n+8dj07rJ3qoNSV6BWnEenMyFTsV85xEnAccJMJ6dpk748m/wvWKux87CeWAHNWhOncqDWfynwbao6+k01S/oFaCTIa1ESGUXeuYAxwIJq+7ZXl2upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXwJ7Ewf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffae834c85so318967b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704643; x=1706309443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C31h5nrLPY/Ds6PEuYiSqNAz8UKDw1XfR+cUAYjO78c=;
        b=aXwJ7Ewfw+NA1Fn0mHwveeujB/944o12GfTFTXvsRgVROvM3v7YXaGWmf/B7ea4oWt
         SwrLkM53AA8NXDh5nnmaUDjSOzyvs6vEKTLvLKdjVXwYVMmuCEQYOYX8qtJ6ikhJI6Pt
         f7tOUEAk1+giJ7R91Qfp3o8/JGcgnkY+ZLU037raFp8Nl822YnrtiNoPSNTUJZPtuxgp
         jxjOfm5jIDPQe90Encv0NBcXlOFW3hBa26La0+1o54m1c+3F90eZeoJSG6uQAP6smA1q
         gDWhIVXYghRkbj//ZV3kS1fs3i2H06W4kczoLTTb1eK3X+h0zvyyGhAw9gpnX77KOSvM
         kkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704643; x=1706309443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C31h5nrLPY/Ds6PEuYiSqNAz8UKDw1XfR+cUAYjO78c=;
        b=MWRnoV6MEFl85G4bDM58k/AR6UweXRdVpZ8/yGA/jguCsnJG0RldGxcEgTeRXhIudz
         OcU9yjlN/uj15by2URBYA0q3J63xOjywYqw+yEwxTeoTRvZTizA4bym6He0E5pWieKoj
         GEmEZxvrAq5h4qUKJCaZWNjz7caeUmFBd/lObFxLwK3Xbvekj0HUdZLC/nFM93Hj2S/z
         a5Dki6hGp11iBXIMvwiW/ckhpN/7Dy5IxPLGregezGJOSbJfDS168oVgs6sxToW73TsW
         pi4psUs860pkZuI7+TiwsN97mwFIpAQJO7u/tmCo+Kz0TRsxdxM0mN0LZgm7AxfLloBM
         D43A==
X-Gm-Message-State: AOJu0YwGpjEfGNOcfWXsAfUKR9H5aT4i8XgnQkkAN6/PYy+PMTqA+a6O
	4YLpswIYbNpPcWv9UyzhDl4ujyZB5Bo7MTyC9Wwrs4tKlLgx1eqhiqBN/hRm
X-Google-Smtp-Source: AGHT+IHXSqiMCi7CyrzEFk5ZiFb3J3q8XFvDbX3g3D2bB7MygeLDaQD8ybfTO3InFM/b8I95v3AswA==
X-Received: by 2002:a0d:d842:0:b0:5ff:6c4d:fe34 with SMTP id a63-20020a0dd842000000b005ff6c4dfe34mr575162ywe.48.1705704643645;
        Fri, 19 Jan 2024 14:50:43 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:43 -0800 (PST)
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
Subject: [PATCH bpf-next v17 13/14] bpf: export btf_ctx_access to modules.
Date: Fri, 19 Jan 2024 14:50:04 -0800
Message-Id: <20240119225005.668602-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
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
index 78eacd4aa362..713ab3050091 100644
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


