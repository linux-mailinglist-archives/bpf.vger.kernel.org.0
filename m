Return-Path: <bpf+bounces-76062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDFCA46F3
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8A623007A0D
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B71345CC9;
	Thu,  4 Dec 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOlq2iP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0D3431F8
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865069; cv=none; b=YvXbH15XLnXNNvM0ijzvZZ3e6i0XlFCD6MLWY1N1DHXKmoZLeH+SZufqbz1jfOQk3/lYD3Nek5OHDC257051eaHi+1cyXFs/1LjjqMKTVthnTY3VXVEbWlP84TfmI7xBz4PLJIOnhLUdHpte0VmjgPO4TVEBCLKJm2yXn8rzNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865069; c=relaxed/simple;
	bh=n+63PlaZKOtY3JC7oD0NHAoiyAMuX1R4DVqHT3OXT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2GDuifK1W0ANzqif814mgZe00s/twA2Wj9EEomDsINZ5Nh9tqwRa+XeapvSPeLog5x56tKYMtgdJ+FhWSJJdfuy0BmiblMVpesyVrw0dHbBHvKQ4EmfD6ve2Ag/z/mE2yGqUZ2WfusdTleOfITvfkaCI50B8WM6I/qNTE1SkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOlq2iP5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2956d816c10so14008775ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865067; x=1765469867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCCLpF4Ehq3zOwzYA8afoq69odsanopMUq/fUvlXjFQ=;
        b=JOlq2iP51J7G3YXdkCYgXKa6DEwLRAqdXBk7GTE+ekyqGBf5p2DqIaAz4kE63DZN4P
         jJBHrOVyKZ2lpP1NmPTgSVwpyj+v2Rpes31ye0UIcjQXXrpK8w3ry+aNdQMPN2VbQI5z
         L5S7OLUH++YM1Ypv5Gjj2ElPF+fSpt7/W+p6OyByTuI8bh6/5DKVY0BFN8YgEKIpkYmZ
         ZaMm3pfQWxHJk874mk1iWjctUw+sKF/+LVRPEFJ3jWBzFRXB0WJ7twBOhSmUF+TNTBFJ
         WyF98J/khfEOnh8ReBqBgfRqTv09PXtfGz7lP+93STATQDxQWzbenlao/l9RQWWbWsBI
         a2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865067; x=1765469867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCCLpF4Ehq3zOwzYA8afoq69odsanopMUq/fUvlXjFQ=;
        b=X/56AX5eJcqomp4cvecjkHq1rmoYw3I8FxmrRAat003SJO5hpRd40C3BfgEriS58nU
         foc1LhN9EbvfDlJnU5rJfjM37tYu51UMdx4+oUiR2U0v+9JvABX+j42s0gfZo7aQL9tS
         Blmcelv8MWWq2zj5rKbNjRmklTkr4Ra188VGidzFSbe3XoaHXnqy898J4MDt6eYbswpx
         EMbi/wvtatQbFvi+tSxt1jjCfxMVB4ZHG+Koup/TPwed/xYGWjyGVSPBLWyie8KOcOjo
         C23YdVbY6zCLJN2w3D6b5a1NKhfZ+AflaKdFx9ZFqArH6UuvoOOySSXGKUtb6OQadNjc
         foeA==
X-Forwarded-Encrypted: i=1; AJvYcCX18WzMRl4ViXB4rQzTma5CcpJBGjO1kKmYO73AftgKJpUvltOrDXkBv6VqrbP//H5p5qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvDzJDEYgZ41b2dAsrBnoGsAV5d1fbwf+0/Zx83MefMIOu+SW
	CN+2Evo8Ot8qVciNk+G5J/swIqjo77kDQqo1eOfVyl6tjklr7V8jCUVi
X-Gm-Gg: ASbGnctPDFmR0kRgOgmesHmCNl6AcUchmaQaH3MCeBd3Isj8BeNUp8W35WQn8bKqwv7
	RMYnVZv5TFvnIHlmw+xx/Qe/rrnJxoUIiZQPJCBiG6ygWGKVE6P8Tcgp8yisWX18r81oDfLSN+q
	fwXn1Fs3dtxnNJrVcbcvrZkMjofk5YrahpWeUnqWIKiO2kX3u5w9naCzu/LKXxVWIDNIKCR8fr8
	ElCw1Am2M+Y4WNCC4Ht1BcHDPK+6KfOja7CVZ0dnaAs838nU+jyRoYfefoemsNpXDCdl0zxQeSp
	tgYdAi9IKJdhCjeziesdT1Dq0apwlbNSjtXNQ88+b7mpHqOfFsjptDqFx2wjE3zBGS60b8wWgJk
	eTtdRpXDspgb+68iAFVRr/kJZ+9013s0NItnwzOJWa/0YbKa4ceH54hR2l6R/DC1c3Sp9+zA6a5
	aN7RxQG023TKoxRxfg2+k9yRY=
X-Google-Smtp-Source: AGHT+IGwXZtkCtpHlnxx5n5SCCk5+vCVmV28uuWId4Yw4ZJRYdebw+DO5VRN6jCZbGc+ZKgDSsauCg==
X-Received: by 2002:a17:903:11c7:b0:298:603b:dc46 with SMTP id d9443c01a7336-29d6841440dmr81074015ad.39.1764865067038;
        Thu, 04 Dec 2025 08:17:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49c8a0sm23922255ad.3.2025.12.04.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH 10/13] selftests: net: Work around build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:24 -0800
Message-ID: <20251204161729.2448052-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

ksft.h: In function ‘ksft_ready’:
ksft.h:27:9: error: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: error: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of the affected functions.

Fixes: 2b6d490b82668 ("selftests: drv-net: Factor out ksft C helpers")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/lib/ksft.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c6..b3d3f7e28e98 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -24,7 +24,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	if (write(fd, msg, sizeof(msg)))
+		;
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -48,7 +49,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	if (read(fd, &byte, sizeof(byte)))
+		;
 	if (fd != STDIN_FILENO)
 		close(fd);
 }
-- 
2.43.0


