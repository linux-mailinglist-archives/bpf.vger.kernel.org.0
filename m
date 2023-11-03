Return-Path: <bpf+bounces-14144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAB7E0AF5
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B97281CD9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3F24211;
	Fri,  3 Nov 2023 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kl18rAdF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90024201
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:09:26 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B03CF
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:09:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507b9408c61so3216901e87.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699049363; x=1699654163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuN7gYl2f9j4m13qRB4taTG381QaiJck5wqiJSvm24=;
        b=Kl18rAdFdNLsVWkmO4CE+2DJxLKEZO3W9ip3AWB1iI/8o/S9zZetNzjLA8NQFzWeyI
         5u4MZob6E3jrCN06YvF4CcIX39eI+q/ztbs+goAjfn2SX8NdUc5w1wG5X0XrLqg7uocL
         TYkVknq3xFszyevjYiGL78ILbUkqxX7DdJdHq4Ki6jR9REa2GGNmUKhaHhcDRieNL2ft
         M81ytNCiLUKC+It/Rv+dQD8AoFbp4dawsFjgU0spB5qE91x7ajRHAcFR272zxGkoSOOt
         4TswZhJxyF92Qvso3gWOKwc4zrgWL3FCgtfab0z8azuLB104TYjg3cKjKbAkYNVBdROF
         7IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049363; x=1699654163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBuN7gYl2f9j4m13qRB4taTG381QaiJck5wqiJSvm24=;
        b=jwzHCfa49WF6YwU8EeTjpbxsu1eO7pn5wsfpa1cDX1Z7ba7k1EqTF7YQQPp8R27bxm
         BY2WhC24WFk3iJpbGbr9lq+6HZb9fkJrwkg/1qNRoiHaW3Ezaj9oxTJrXLiuideDoBkA
         z7szw/Juuyb/Eg6XC8nyvU7IghRRGnSAJHxErLLJFIdS7OPWDeW6MSi73YgUECAmQpP6
         uhEBg4n2gWZoEgVgILFw4HAtl1WeWSJimBUaYm56psn5Hr8Yllk0V6exVLSGGU+Uut+K
         xIJ2u6aZjVA2WOzS7tI/t4iZG6ls4Ie5TUXNCXUOdmSAQCTP+DJFR9YDXexLZyVinzEF
         JhEw==
X-Gm-Message-State: AOJu0YxJAO7Zu02ItDwWZoIFvvanQgRCLfjziU2L97n9WTpyJlE8gMMp
	Q4P8SY8KL9oXfbUBfDijY583pA==
X-Google-Smtp-Source: AGHT+IEr6GbDZ4s+E8RGXMnC70xlRgNiPkcHdcJp3VSEFy36sZoLWuW438sdEFKZIJ2wEB7kwesPVg==
X-Received: by 2002:ac2:5925:0:b0:507:9fc1:ca7a with SMTP id v5-20020ac25925000000b005079fc1ca7amr16708313lfi.9.1699049362665;
        Fri, 03 Nov 2023 15:09:22 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id m11-20020ac24acb000000b00507cf5fa20esm327760lfp.97.2023.11.03.15.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:09:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: config.aarch64: disable CONFIG_DEBUG_INFO_REDUCED
Date: Fri,  3 Nov 2023 23:09:12 +0100
Message-ID: <20231103220912.333930-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building an arm64 kernel and seftests/bpf with defconfig +
selftests/bpf/config and selftests/bpf/config.aarch64 the fragment
CONFIG_DEBUG_INFO_REDUCED is enabled in arm64's defconfig, it should be
disabled in file sefltests/bpf/config.aarch64 since if its not disabled
CONFIG_DEBUG_INFO_BTF wont be enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config.aarch64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 253821494884..7b6e1d48c309 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -37,6 +37,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_REDUCED=n
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_LOCKDEP=y
 CONFIG_DEBUG_NOTIFIERS=y
-- 
2.42.0


