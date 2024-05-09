Return-Path: <bpf+bounces-29266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428228C1695
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D38B24922
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D643C13D29D;
	Thu,  9 May 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0i0YWe8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C513D263
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284951; cv=none; b=ZIv/eJqhqLsgfVE+YzHL20np87hhvxsbWG9bCYPpi7T/klBdb8uervk14xQmWF1jVuavXLG98XbsKhr6bY05iA/clkmO84HqaAZENy8o2ohoUuz2AzFmq3u5ckYTDKRfR9DGGSHMTo5wEsjJDLrxcarAfu8/yPSDWdv+YnjI3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284951; c=relaxed/simple;
	bh=bxJLCfAhlTefmGTLWdKhHKRSmFtlMAwKw+2HpiuuKOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EI3yh6yjhR6TpSrWQvWgajlCCKrgbT/IEsBkVldiIdPTCyv2oK8jykHovu73N7Ri6VvKvTvBsPclQAHPxB6f58Gq0LQr4CxyCMKY7Ep2o3H6lFLilmt64xeRgOLt2LdoYEfR6yKXszrv+d3lmlHp4pnSGlf4O+rFsUBFuWsnJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0i0YWe8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f467b9e948so1253896b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284949; x=1715889749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4z9tRmkFYCcw5oob96Va/ErGYfm0S2CmMdMe4FBR7I=;
        b=D0i0YWe8ck8Fmpt+b2aMwVeBEfI756ZePQN9InAJ+AS88oc6rNr+0leQR6D6UiciOO
         TDfkhnwKStVYzMCdS15nlEpc2dlu9Ni5o/MvmXtME0WcneXXHKMHlcb+LsKs8DT3txyl
         WAf9dWrFfisgOiEYG2dE7S3p0mNpxEWTAKRogKpG+hnYxhX9fw+LhNVz3p6t8ajghuNC
         swRaW3bRhAF7jwXzhApmx7mLKyPUlZWCQwgeGCRSDb41PkOR0C/4pYUT93Q+8harwXJg
         5yVCAlrMY10P+mrBZQPGAi4VT9rE5io7NHaoiv4WRFMkLS1wnBf4CVTpih9OJNpVCgEO
         KhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284949; x=1715889749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4z9tRmkFYCcw5oob96Va/ErGYfm0S2CmMdMe4FBR7I=;
        b=IJNRZVbDbpxDzINjwIbKJrWeRwcT9FCYQSwJoL+UbwxFlFNOrz/Ez2IcSqrHdvTpep
         VHpVAwlggjmDgV9DHSlHpCoKJEMwSbUPLMivklVdJ4WVphM35EeIURd8KQV/ed9leaDy
         zV4OmGIrsMb9DvLRCek4ly7WYQagZyXgc8G7DCDRkRvj+u9Qscv5k6pTtmkUwkLG0swp
         YGeo5bCvtCMMsxXChwdf1g0e9EOF4o1fqaNeEA9LDPItF8BqNoumkIpSg7ZHZhhJiFeJ
         BpoL6w3Sb9YrNOF+V9Zf4Gu2UGVtCDch4TbYhZaMHZE7ch/OPZd39AGuPEOQHmuE6P/P
         Xy1A==
X-Forwarded-Encrypted: i=1; AJvYcCXbcqTMGRG/yqBprFG+/R0LvN4QvsFGM1sg+Oy2dEFQtMzYW5bboBDId+dwdqsbIEAynFpGb0qx4OTB8Xmu72NWn4bb
X-Gm-Message-State: AOJu0Yz33kQQsEet/3nDvZ8VHT3vnWg0pQ0T73ShaJiwFgNvAwV6jfwz
	Gi0LNW+tGG4DhWoE0IUDrZvYj8PAHErLRHbPlYFrUCVrrcQMdUAXmNZoax+PdizqlE24SGQxP+s
	8+Q==
X-Google-Smtp-Source: AGHT+IGF4qz3epyZCqVd8sIgyp87fgIn9moU6vLMHysn53aGUxAkCsTmzzKAv9A4azIh93bvW+KCzfUowb8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:178a:b0:6f4:9fc8:8cb0 with SMTP id
 d2e1a72fcca58-6f4e037e983mr23426b3a.5.1715284949238; Thu, 09 May 2024
 13:02:29 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:28 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-37-edliaw@google.com>
Subject: [PATCH v3 36/68] selftests/mqueue: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index fb898850867c..43630ee0b63d 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -20,7 +20,6 @@
  *   performance.
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


