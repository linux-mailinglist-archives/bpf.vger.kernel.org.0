Return-Path: <bpf+bounces-29357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FED8C1A9D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36C01C22000
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652E83CB1;
	Fri, 10 May 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay3IRznw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C585F870
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299796; cv=none; b=BZZ2zoVfEuMQXtBDPOszyXePZc4j2yO8rHVpmsahwErtxSvVahn/sd4/K5MYG/IojX8KYWRel+FjZMUarG2cjkASyY0jj1N79mTT63l8Bew1BLBTTbNN4LZOEWgkEZemEDKu2d0+8oYcHOd3EZKuS5kY9RcgQhDjRUhsMiYXSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299796; c=relaxed/simple;
	bh=D55ymEmgXz4iQWm3Fzu/fcCDdwZBDQDEGkYQNfW5/Uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F50rd6+XuGvkwefyR8XKuoIHPRNhrJ/Gdsz9WTJpIVC1KMnX/S5aoLoqjPGzNgPKevpwtyKruvxsUbem4koNUSsiTP3iWu610FPM8dJJKgr5TG0ZHPqjX1RDz70iPwlJGefFvaoIbaf8tlh1dZbdjkfPSXMez3BmM/Sp/ZAmE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ay3IRznw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso2277399276.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299794; x=1715904594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Woyjqf1Jf+ZN0ROzD4LFadIcncJKJRyNekxOoKd72k4=;
        b=Ay3IRznwGFhgxtGCjnICCOsViXPNdWB++bN8DfrIE474kunmXPCLjx8FV26xlIB+gF
         ZHsY3hqN8UMW50wvnOn02NjHkYtYchsAZTs0awdlmckaHYmww49P9wDUkWe4sEMoEfv4
         Asia5amP/3zPhsG0cAsLPSAd7Tj0AsSBk447LymUZCsGctFWRSVa7h9esBLMIqqG8iqQ
         a1PwmpW1UtBeMA49KPXwd/ahbr8kMIwuRiTkWA4MEkt7/6g4Y9M3mExRChHPQrDfPBJ0
         w9Bl0J2YHx4c5G1eEhB0EYadiUsBcISzyqJQfCjyj7LSaWTooFkAqhep6dxmLsEwjjLP
         RMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299794; x=1715904594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Woyjqf1Jf+ZN0ROzD4LFadIcncJKJRyNekxOoKd72k4=;
        b=h/adwECgsWdLaei/fSFObqmoMtWXJdGJMqHdtcyQM65zK1RPwsifQfdgGiwzGtY1p4
         NH13Y4IJGIXD+ijHjLHH3HhIdEhnUMbdq+P1R7omDge4uSVbU0QnsorpVk12tFmb/bCB
         0E5PwtD0Vm0uD/rUydxU4BPohdOBBZCB4vPyI6D3fKoQJP3PmeyTxLKfAViMbtsGA+VE
         zZhuEiru+wDGUkJ1wCCffTCdOCwXqJSF4ufGYfDKr+XMnUv6wWXaVwnI7YJEP0gKyuRA
         tic368EALuNBEkaLmzvcIVUfTmnUr+hfcMSP5MJ/NCXM8AiZbTr28hinK6OypqQcZiPQ
         Gx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiMvGKeZhdQQCYd9VZPqfJ6Ve/gUgu5rcZQmZ3SJGMMib/mqY5oMj9SNH+F5jrGtgD491HhnHp6+b20qVrqGllH0o2
X-Gm-Message-State: AOJu0YzKqZWZstmJ3Rr3aBPwCPvEqIiNzcwGLH2fDWfCE76ymOh4RNis
	foffLnlv4T4aIIf289swVVyGfXGfLM97eTk3x05X/NEybBSHn+2F+CBgUZBVSJeJ5ALq7RSB4le
	8nw==
X-Google-Smtp-Source: AGHT+IFaj6bmAeTVTIliFBtquFibuZcld7R/X60oTVpmTPySBxzB4mvpPMdxa4luEXPujDJe9yOplutTGtY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1205:b0:deb:9c81:7a81 with SMTP id
 3f1490d57ef6-dee4f36f045mr285525276.10.1715299794053; Thu, 09 May 2024
 17:09:54 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:34 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-18-edliaw@google.com>
Subject: [PATCH v4 17/66] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


