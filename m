Return-Path: <bpf+bounces-27610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BA8AFDD5
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F80287AC2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FB79E4;
	Wed, 24 Apr 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch+3bABi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C06112
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922130; cv=none; b=FThUdUJwh/Bnm5tsCjzoUbzWMXa94t728LPHu+Qu0GWuAFlvUruKJYSUtM23UqXxjdIcT2DBJDOSysDDWabn1zDyotamzhIKLGGClRyoDcEXbZBS18YR5QYQbxfFeMtz1OnXCGR4m2KZaaQ7o+MTbsIzqjXEiJg880u9MpMtf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922130; c=relaxed/simple;
	bh=9J26TE/6MUBkHwCplZk2OjBOWWngkfcaPvczZgQTHDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B60wbaF4eREs+3aCzZkxwDuaH+81GDNNkv3q5HM52vvXEFnXB7kK1FB8QPHaVq3AC/fVKBHzwBcgIeLZ/N/fmir4Y3W9r+BHkVMw9I2F/LnSx/IJABv4uSC1C2IEPWEx4Vny6BCnbGUIFug3mpwKaXbI/hpvJ5u3TePLkECvnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch+3bABi; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so4097047b6e.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922128; x=1714526928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H94wLOmtbonKp8Hw+9xTGITfBs3ZyZURRtQOSpiQtA=;
        b=ch+3bABi5KJY7cWrKd1piLP2EOxAaYuxOTu45NOzAKqy6YLL6UIA3D6kOAUvRHAZdN
         B3VPENfjbEBZp9AqYGWYKFetuJk6Izma8kSFv/0hZ+jjeCp8bGF6QZZrktg66CAwFPoX
         lnNEJgWESYC3cVC7StvEL+phgIoM1QcJkGTe6p87Izb0zxRDp7W4FxhU+2OQ92SDVsoc
         eCbIpsLVsSaGaSGHKpDzmd034M9b71jfVMWZkT3rRExYn/DO9q4TwO/wfVIy62b+c4XK
         +DQCazSf0rpyBsIskal9PySKyfrg8r5zuGzvd/0Xo6C/fuKNeRJkhKSCDL52uI8/ksdl
         Prng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922128; x=1714526928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H94wLOmtbonKp8Hw+9xTGITfBs3ZyZURRtQOSpiQtA=;
        b=JNDe4j8g58BDe+q8jgr7tmkniiAcVWdNQO7zSBcBdiv9Nl0zLLzZIli9FU4DDzmaPO
         sgXb2qvOaJPZIK2AlM17CzpOHORJB9aYsL6gCUEXDt4CpmU9QN8ovzPkEWAmtT5gdxG8
         BBeolB7CrELhQoZWcscQToNcKEsKsNzNF3XobP3QyixQK+6ZHqgIanTjPokfBLER3OqD
         T4D4DIVmiGPurT4WhgkZSWzcscivam+Xl4/ASgTCJIvlW8RkhdLyLdLbCt+MgCm58hJD
         dnJpDd2xYqasxD/rFaB4yFmv7DU8piW+yAdIsizlUK3jfAqHHqUPaF2YPR5OyqIX6BSl
         Y2Kg==
X-Gm-Message-State: AOJu0YzH6q4b+h+W/P4R4QKNfJJdQI6n67XLv3KcSFGy/e6+cthGANYQ
	wFWiOzxM1sWUEDZXm1FCAeXlTlikfs0CxVBC7k+gQonaZZGVvvHru6PtkA==
X-Google-Smtp-Source: AGHT+IEfxtvSqEESc5wBQaw3eo7cTgtqqV1OwMjnGC5oCoTpPreQCGGgH5A2JBTrsrfY7Y66FljwLA==
X-Received: by 2002:a05:6870:348e:b0:232:f9e0:e4c7 with SMTP id n14-20020a056870348e00b00232f9e0e4c7mr1135256oah.48.1713922128260;
        Tue, 23 Apr 2024 18:28:48 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/5] bpf: mark bpf_dummy_struct_ops.test_1 parameter as nullable
Date: Tue, 23 Apr 2024 18:28:17 -0700
Message-Id: <20240424012821.595216-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012821.595216-1-eddyz87@gmail.com>
References: <20240424012821.595216-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test case dummy_st_ops/dummy_init_ret_value passes NULL as the first
parameter of the test_1() function. Mark this parameter as nullable to
make verifier aware of such possibility.
Otherwise, NULL check in the test_1() code:

      SEC("struct_ops/test_1")
      int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
      {
            if (!state)
                    return ...;

            ... access state ...
      }

Might be removed by verifier, thus triggering NULL pointer dereference
under certain conditions.

Reported-by: Jose E. Marchesi <jemarch@gnu.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 net/bpf/bpf_dummy_struct_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 25b75844891a..8f413cdfd91a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -232,7 +232,7 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
 
-static int bpf_dummy_test_1(struct bpf_dummy_ops_state *cb)
+static int bpf_dummy_ops__test_1(struct bpf_dummy_ops_state *cb__nullable)
 {
 	return 0;
 }
@@ -249,7 +249,7 @@ static int bpf_dummy_test_sleepable(struct bpf_dummy_ops_state *cb)
 }
 
 static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
-	.test_1 = bpf_dummy_test_1,
+	.test_1 = bpf_dummy_ops__test_1,
 	.test_2 = bpf_dummy_test_2,
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
-- 
2.34.1


