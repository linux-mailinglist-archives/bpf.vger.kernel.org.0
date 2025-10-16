Return-Path: <bpf+bounces-71071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE2BE14D2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 04:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E3E540FF4
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067FF215075;
	Thu, 16 Oct 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbHQB4xf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF5212B0A
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760582241; cv=none; b=DVFoUJLNjnDqmsHrUwRoPzen/OAOsBHsFC0lMd7aIpW442xvVGSnOdrsldmEVyinPnrAIFJb21HKHdzvnFzMxXJc0R9pykE8GzkFd3XN3PSyk89pVUGx/vhWn1iX33of2E+tlWzNtbAUBAjeo7zHqwvvl5NpfP8X5BUYH1Pl6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760582241; c=relaxed/simple;
	bh=LP1O6z1IQDBpbTbRpeF8L3pbsetSmzmu2sMTOE7s14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADBGL8uC3AnKZ6W7cqlskb6AEbEJBBfq1cRfxii0flXRlmSmuC8B3oTVP0iYXY0RpEvKKup981myrprZYfEk93TPCmVLWE/5PizDF6Ayh7kK/wH3u2pbMNpYFfGRDkhgLDz4ZRNoCwqhJFG9p/Uc98R+ahCFfe/oHmLQnP9cBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbHQB4xf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789fb76b466so224706b3a.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760582239; x=1761187039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=HbHQB4xfaL4lhaMeZksPft8LhPnvZEYO9dD0QKNCnNW2UWRM8o0+qmXvFJg2UOlNqi
         QPjW1GbMeV+3xo0eWTXwK1hGOSjA5cnP2zZ4kIWwqzPpI9oWMGJX+KrZphP4EBeC4UVT
         bs570qad8kyBp5/ZwkhBZPrZrhecPi8YUZUH4053WnJNr8du0iCPsmihdYOraZ72n8a0
         DtUCHrGixS8Pyaigq9/zWT832ORvX1zmaFmL2NNoMfN6hCGwZ09/xXSfy0cU6mo7+lvx
         rr7vb8606TqWfVKw16aq9oeZwEXnMSHvnXCsvhSZBW3khpSE0v7oOUofixrVHX7htksW
         3gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760582239; x=1761187039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=czbpebfHypjKfMnglIMzbBAzrP7rZEbGIy2uxxyqDrQKHD5qMQ2wptBi7Qy78FKbzT
         o76T/EGfMTliKioKg4m1ovXtI9bQxfA4kMcFimTskUP+xMHJPvX1y8bBakF+3RGKVkfl
         S5pqWcMYWER/U2GjtwF/N8/EfYCp10E5fpBiPclIz6/4Feq/HEi5BxX4bJnqU24BZ6v5
         Kh7i87adulT0ymTg8XpSDCNMJELE3O3tP1iOxiIpqC0IPdMRqZOiKQpDGi7jPbu+O5Z+
         LRL7gA+MG30ca4e5hptzbbNKzT0ai36ar8PMlnHspLEOJ0281RSSxqlHlclKQ8XWGyt7
         KN+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3L1nDcEHqTAObUDmSXOi75gI67OH30X+mw6NOMq4x5YDL+GbjFfSUDzNZ5ydfl2kjDxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvp1fzVkV3Zh2LaLvrC0g1KOflouPDTt+J/T5XG9Y/C/0gj0TY
	K5Ais7GHLnvBRWES6KyRJhsL2uTpffVsCvd92l9bQr7L7j/yqnEweQGb
X-Gm-Gg: ASbGncvQzrJN749MF1gTi9kVf/zapG0n7majxTlVtTdigLHFWTGU5TnOjMacmBtyCcd
	+VtVj6mNmiyU4XZHJ8v1jQHseN/nI88XflmsH1BqQ31h3ZBZlSoC3goTOBsPyyQS2XLaHi4Z7wn
	Z0kyGwNyoCSMqI8MRwDSplHKIe9UOtVrO2rEB3rI438sTVXzoM9bCQSt1p5cUDUXbdnuCiRqPNg
	QjRK3oMw07A6aGCVTLJSVF/nbFfcvr5nyAGMv7Y7dwGenMXpnU1/rRFAX7qnFwoom8OtrNPZnXN
	ES+CRARZKV36jIcpih3irqqJ7s6S4YvDlBNadOZ6U+YRqDDlt3P1JIv9WEdrBV8VPNgq0SYvYId
	OEYTlySIjJRcdRA1SqzWeP6YG/2+BQcwgGx+e/4gbajuKnBwWMc32UBNCao7BgnqJJ8O7pST5Dz
	Jg1/l7K2KIt0XaInL9r74cymWonAXUBi2Q0FYqkHs=
X-Google-Smtp-Source: AGHT+IHB9sg160F5k8dcHqIO0vcnHYw7I/jKUXvzXeKcOMzujX0FrGkAzwRwRRp7T5XkI8hrihXiVA==
X-Received: by 2002:a05:6300:40d:b0:32d:b925:74ea with SMTP id adf61e73a8af0-32db9258839mr25138406637.11.1760582239322;
        Wed, 15 Oct 2025 19:37:19 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm21751956a91.3.2025.10.15.19.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:37:18 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH bpf v4] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 10:37:13 +0800
Message-ID: <20251016023713.3153209-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index fbf0d9c2f58b..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-- 
2.51.0


