Return-Path: <bpf+bounces-71069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63409BE1417
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4EF19C6D20
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F0227B8E;
	Thu, 16 Oct 2025 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysao4obe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D0218EA2
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581734; cv=none; b=ZGsz59vcl8MXvJ9XFvKyLZIkyXyo8XonFywa4JL6JcXW0ytVNCOT6Wz+lOEVHPb9EnXJT+L4XwXuuqOzNciWz11IKglu49YZTrQwViiJbSLkLlU/HG+1gimPH68Dh1zXsYyEcYQKvhl4mRqRXAX8UPUSQegP9Wo5niW9vpo+igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581734; c=relaxed/simple;
	bh=LP1O6z1IQDBpbTbRpeF8L3pbsetSmzmu2sMTOE7s14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb1cxlhDuzlFnd/Jbx3g7x4a1PdcVR2BltuQjPXpbp89m17brMCZcDJOzPZaG5qBFPGqlylPZ96qpkMtCTzIipYzRqaN3JUX4vAFUDPjhFzaTUOhco/YkmmdSXte08g7C1HK714GwcgdFYMKTQWOBSSB1mamf0h+2kLL04HqhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysao4obe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f5d497692so327469b3a.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760581732; x=1761186532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=Ysao4obettxCwIcFjV6atFhQkKQS9fiyjg2rhI2ioKadfW6K7ejqTveU3g5vqMDgvl
         u8F/ijT9QMt/LbPH7ZIE/97ZVGKQxn6MTqAfUKXK8+CegfEtMwkadEfv93/eyGgIYohq
         nWjiYwuv79IyVs1bt69JaoyhCK013/j0ZhWPNPgLaQwDkYxoz2K+3wpaVFKG47YEHpPo
         mwyot05TwLxOeacJcY2lsCLploQluvgqYKaAgp5HzmjDKHGsIZzaIdJfXvgxl7TTcT4H
         2GD3IsiO6ZW6DPFgpAvUqjVJJmv9LVzhUTg75zkb1XNcQDOb7eQ3YjGPc+e6h72KF9iR
         sWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760581732; x=1761186532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=PRpOVyh+J5fU3HzBoQYi7og15x/9VQ0sgTgN032/Xtjk81r0IcRJDbBErBPTiMcYqu
         a9T7LW5AcGes11HhP6Ry9IZje6kEgz7e6iLULPUD96/Xi0/WrZR9LycSNKz4fnJ/Ra8f
         RxhQgJgwH+FT+mQC3+5MN6OlzN7qIVFyWPKJVsziUYP3VKN9Y3O3d8k7A3ZmBs/2Q1B1
         CfQu7SiMxS7DnFmhcYyf9FYww63Yrwj9IuOy4olw6oZPBRSVlFCZtBsDF7HXiT7NTxdh
         0HhvMlawL9QI5bHnfFUTmUYXemVCPdtGgoeDUMDPtu+bI7jPXi2wdasGi2goqoH8FZVW
         B7nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+r0CzWGcYw/qCP/tdIW9YmGcrX/N+CRLSyRy2W2XfvTEAKY01yfwoC5tOuA+acNmULu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/T1bkOBcvElLbR1R2M32S6LuFBMQjoRtT9aN3yolykulRaq+
	IPWXILMxBuGfrN0RMso8/dtJCcrHqqruUBYFgantjcEEKojuM4QECilu
X-Gm-Gg: ASbGncvs2N04WirSMAeTSrxsfKZhlGUhqAL/rfnjq2WnXl2JiJtvdoRMaLIF5ZpAleh
	NuWb3xXIGdvMRh63KJ+1deaxCMUvfqY0B6yovW59vy1Fm+XrzbdXVnVwYh00dQIc718i1/fHmgs
	74mqh1xTyqsX01WZRhbC7L4vveFtNkpvNX6lX2xJu3US71m3Xj1r0MRTJe4DsjIyWUovzrPm0Iq
	TMztnaVaq1zt2WhPSji1FOdZ+CM/76qxGoC8izj0wLXULzDXF7o2YnMc4D7WWverDvfBdsqnYOl
	ZWysk91sFrTQVFM5C85Qq2OKGEvKQgJwGyjkJ/vq8UH7N2duKoNKBTQqJ5+t883hn7dbaljMi4L
	CofbyJu/p6KNSPNCj2v6ACM+fisuu/CZiVdWOuY8A5u6hZZC9x5y9p4UVj9M7oendm7Vzy8jCVW
	1i0IiGq9pF1sq9xUo0eltEInzbqTjjwR4XTiPLjU8=
X-Google-Smtp-Source: AGHT+IFuqPT0J0veFe0yzcdPJPOifMos7ZUqhF8H3BBTiuHa78iT/YFUtlOxJl8k19dv/ZPmbtm27w==
X-Received: by 2002:a05:6a00:22ca:b0:781:275a:29d0 with SMTP id d2e1a72fcca58-79387051fa6mr35422135b3a.16.1760581732526;
        Wed, 15 Oct 2025 19:28:52 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d2d2b29sm20319608b3a.55.2025.10.15.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:28:51 -0700 (PDT)
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
Subject: [PATCH v3] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 10:28:46 +0800
Message-ID: <20251016022846.3152565-1-higuoxing@gmail.com>
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


