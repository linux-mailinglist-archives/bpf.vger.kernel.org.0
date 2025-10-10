Return-Path: <bpf+bounces-70715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B0BCB8FA
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 05:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9126A19E72FE
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1326FDA8;
	Fri, 10 Oct 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib2SFpet"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D13D76
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067537; cv=none; b=UO+5ZqmnqISYTyED27fqKP1A6imhJJbuCm2jtLVlDzlLp0rE29cMHbkqXoarDXm2xSKaLSoGQuRwiQB7VHiQJPAhDU8/EoOqYiXk503gCCGBC5hfYZhyY1xeflCck3Doo1PX73f1XJlKCZsc+dacnx4dKx/w1dd/GgjoSjGmy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067537; c=relaxed/simple;
	bh=5qqJUczig2l29D4JIBSIymNxAk9sEevSR5zoATmnADc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5GDtI1Nherc1WyUltbC1waYc3Oxvo089WLz3yK4vksiykozZHgohTpmkBwMXMCUn1UdITB0uqgcugwIJwHBSZ6maw16PTfNyUOtUk3u0mTjGJYbIbUJDU+bO9tkV0nHUJzV/n1S5+ec0kadJ/SIm97xWdwWTiiUl+EWmYfhLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib2SFpet; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1414643a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067536; x=1760672336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=Ib2SFpetce/YXj8vq5KGkxi7hC4F6vBHXNe78UdkjPBGMhvtM674Qo9s8r4OK8qD5s
         HkTvb5IVzIxgbYEbUKSZ0xS5YvyXvguWu9+OBDvtL2jDgggs9JoIsqyuA3r4xHWiPkpI
         cA+J8EHmBNVyENnkyovfw4HF52IWWb7EqZOIU2XR4QWS060k1hrGpHZllE3TbJe2WIvs
         Od/fvwNqtTOysH/soYwzNiaCySv1dgPK10TaCXpAc10t4vi4+ayMqRyDKJ/I8YH6jykt
         cOs/ZffUGQRMYXGdwHHSVHW6bjPhQqMKSIwcpfXUi+Ay/B9rXzItZWz7zeH3T7wkqSkO
         gptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067536; x=1760672336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=T9A2WvejdnGLKJ8dweGX4uLDDT7Xm4t00CEtqnuEIku1hE3sMUTLA7JyFL8b3Zre7d
         fgiQEXyb15lUuI+LdYkPChKSm1xxg2upybG3RUWAVqCBkK9V4joXnnsFHtoMbcBOIVDZ
         xXFNc8A986WPuRHlALUuxPzTLr3YU7lY5GF2ajFr9w1PIbw2OMXiFZzYbQR8FXanEkmx
         rbJxdBN31vN0qsi724Pcv7vCDvmUI0r3KMNxohlgn4K2lRqmiYrF3qnNeBhsTKhB/WJB
         cFtIzOHChs9+ZRqM+fIZZUSNwuL6M2Ve+C9O3N4LS4GLboeJ0e91Gj+LfCXNmJpcHlpW
         S/nw==
X-Forwarded-Encrypted: i=1; AJvYcCXv+2Yoghm8GOMb7bzhNsG3A9512JHPm3/4PbUvZxMA4w5CNeKa0IXiCa++RodbpF9ipBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRbbxbsNspp50O8ijTt7TDDuhCNKsLaS308r/LcNOOwEvekaD
	aX9WvquEahtBk3Ye7F5zP/tOMsxUg+TJgzUmQRffimHo9kiUtkvIH6qw
X-Gm-Gg: ASbGnctut/QG80FWS0Yw9v2l9CG1T4zMOsUBrGtSEK7SbRwM14FB4Gf7jSOkbYRrvXx
	voOYj/NNbtYvhlyvDvAofB9feudg27fWKMUohjRod1ZXsYO8lH205po1r5yiHRq9kSXTgsUpTri
	8m15iVJ5gvhbHZej9y+/Dvhp1s6fDq3hYwIADCG1+4T/2WIICjoI0n5fPZq3KQyAW3J09/ojPLE
	RPzpza3pqjlmKSg8QJDx2bHFCeflKtK9EWte0VC27c6K7IAOR1xSyC4/q+rWs5/963wm3dwguXT
	SXllviUlJz0pKoj2pjOv/lGaNJdnUAJAeP0rYrXw8d0jDvEWbbwvhLR5NvJfZ4ZT1bTfGjO/Dk1
	oCc5/OFzi8ZTq0uqF310SBowIb52X9ZjvyacjIar24lQ/MVci
X-Google-Smtp-Source: AGHT+IF24F2zhzRlHXkJG3vE8zteAajopgAiIJ6/HmBuwskVoW5wMnZM1SXUIGAoZsViQJiW5B9opw==
X-Received: by 2002:a05:6a21:329e:b0:262:5e70:3393 with SMTP id adf61e73a8af0-32da8138eb2mr13769287637.13.1760067535732;
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm1260148b3a.74.2025.10.09.20.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: fprobe: optimization for entry only case
Date: Fri, 10 Oct 2025 11:38:45 +0800
Message-ID: <20251010033847.31008-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 104 +++++++++++++++++++++++++++++++++++-----
 lib/tests/test_fprobe.c |  99 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 12 deletions(-)

-- 
2.51.0


