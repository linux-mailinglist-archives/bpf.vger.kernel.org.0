Return-Path: <bpf+bounces-70879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C69BD815F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 10:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811BB1923A0F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074F155322;
	Tue, 14 Oct 2025 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8JihYcI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4930F538
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429012; cv=none; b=Qa0XXRXJunWdAXrQB1zzhYFbhws1dLD6PA+EAAkYkjbSYI4srrM+57dfaHQ0MNi6MyoAkEX5574epsL+Z+EjLXTGood19+q6vEfmaoDpqEm0fwzAAKyWMrq/9S6lc8GlHsN8D0Lz0gczkbz6tFGQCWMxLGf7H0xUT7wa+peXE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429012; c=relaxed/simple;
	bh=xcIHiyrY6zpd/QJ5ecaxifkvV6PL2HbfdLFpHH8rkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKdl7ZPzScyepha7lNUDmlUtrHEH0HjxI8AJSiM1FZyHKZfSrmFttwPrC0d6iVd98fbMPylueA70TA9ErNui+lU/IcNq7j9JuWbLfhgO3VWzbqDqq14CjtkfvfQPJlEbF5k0OP3dprnMNIM2MewL8kLf74qnbJ3RoWtr9VVB9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8JihYcI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d3540a43fso47809575ad.3
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429009; x=1761033809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ0YZ6ERdNgsUMAEbLjWSRV62CkKEzgpgQpU/84KBjs=;
        b=i8JihYcIqvmIZJhuIORaE7v2Y7pbqfEaZuru1fH3S8d1haJq9SDJX76PTLf84dFW8c
         AIQfYT6EJhaP6w2pQ6QOue6RVKtShff8SIZwVgkr42BVhNd1/xgoxiZ0xMI/+BZainj6
         NqaaOQUc9JfWBUeAZnlj9Si1FGqcqxosvvpFqWGIVa5LbITzCIJeyVYKqwKEx5+y7GtQ
         SeyPT9d4mBX+RMR88yCYwPkxccp0mbEDt7/iye3eulS5OK9/WGrgT0ZluJ7mM36NgLLh
         zireUlg2nFNYlEczF2HBs73npsPCUiPht7jvUFJEWiWOOFTg61jVMAQHKcfibkXH/dsR
         XT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429009; x=1761033809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZ0YZ6ERdNgsUMAEbLjWSRV62CkKEzgpgQpU/84KBjs=;
        b=rNQYHN4HpVLJg+dyK253CRtirxnnSdyBF5ESh7GUct2dstB3uMeCJP/6zDmWlJs7P2
         /eUKkxjf5GqXSm6TVQjpdCbMJ8v8pc4jDZ+gOLJLiYxjtkksTWyLNh8Nd2P9TUg3HJo1
         F/ckBgEFVeg3ylTifWQKKYWYqYK1b/T7Qieie+4NgJz9CQ7sdrWnC2PCMImXDMk4cfws
         RFyhcXWE+uX8+eVwZH/IDwQvBhwQd8ccKIE9r/BiX50l5dPNRSOd8r1nXv39+4leTqeX
         3CJxzgDq2/1PdY8b8sppFKpCuC4xMwq6MBSq2qZ7CzWidlVa5HwBhQp4An+EjiOqS9FW
         ZREQ==
X-Gm-Message-State: AOJu0Yx19SF0PRIDoNOKx+cCnukv0zNLdpDmjvnrsGLutVSNS4S9BOL4
	HpwR3F3Za16bINDvZ2R70tyYQyZwIshtjh/m5hEGH7tX4z4xjxYUPk8UiSgvGgHIO9VOzA==
X-Gm-Gg: ASbGncslHQFjEpLvUX0xGFRGWGmHjzeuQ6B+NbnK4g0OnKfaU7f6ti7thxpzzItO4PN
	GZRJKX9oBtEBx0XDbQVMiSPdlXmeWHLB6N11Viidq6o307Ed5fh2pEggFmw+K0Z2CqFxRL+Uc7Y
	C21Or7JwOHGRLoFfQTtqXyzlQM/wDR15TCw9GutXcKgS6uzsWroJeZ9NOQj1mtf7yDLyKhET4wO
	ODvZBcoZ0B53nEwi4ZptA3KtWv7XU+5dIVwffH2NG1oq/lR+XA00WYzVktUX0aa0/bHuFWQt+UL
	4mOPeR/QkpyS8EgNm3frQwRtN47wJQqbPGRwHvCGqa6NwFoKUsEPzCXCaUJDn+hQ8OOG/hO6BUQ
	oxJligV6nmj8KlyszElZwitHS50HNuQj7QaTirBf9rdc0RxqRqVMBcKY0WlxK
X-Google-Smtp-Source: AGHT+IFPgNTqNpjyUZ+iocqEkYenDoDPdOqlpKuMh6WhWwfOvgcL2peErJ3UypjvuONEB5mk54U2ZQ==
X-Received: by 2002:a17:902:f64a:b0:260:3c5d:9c2 with SMTP id d9443c01a7336-290272e46bfmr292801235ad.48.1760429009236;
        Tue, 14 Oct 2025 01:03:29 -0700 (PDT)
Received: from localhost ([192.19.38.250])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b626e8bf5sm14635088a91.23.2025.10.14.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:03:28 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	sveiss@meta.com,
	andrii@kernel.org,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Tue, 14 Oct 2025 16:03:23 +0800
Message-ID: <20251014080323.1660391-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I noticed a selftest failure in my local environment. The
test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.

Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..4f071943ffb0 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -140,6 +140,7 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
 	fflush(fp);
+	fsync(fd);
 
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
-- 
2.51.0


