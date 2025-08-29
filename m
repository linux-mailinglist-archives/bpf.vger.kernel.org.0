Return-Path: <bpf+bounces-66944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCEB3B498
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DC998162F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B255284893;
	Fri, 29 Aug 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O2BUEYze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507225BF1B
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453552; cv=none; b=OSiEh5lSoqTGp2l/7Oc3b0h2+lneS9cf42N4RVcebraQEebFNY27KDZb66/tBRPXoX7b4AZ9bjDU7b1L6okkY1VSAg99eu2z5RoQmmuAOS/dSnQEWvhbZc/8AMTAC/SYUGyws49BYSNSGJ4X9S+LuhOfDDPTT1RD+p7WOCc/c+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453552; c=relaxed/simple;
	bh=pPBaTowWqQ3L/K3Cg1MRjZfX8mRvRriYH/1VXvF3KzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNJJh51gG2hs1g1MgYpHwL3WKJ18sw2hc0QFXt6Iq1hljy8Hqencdndu/xEngD1PXBzXiVDzVOOrJvwHJ/z1SJq1tx9m2UNsPwqntIFh3RVRO0gYsaJIpYk2i7gOJiCntMMHp0j52rq1837eXAecRZfqipjjz8iz/+r/96Mjh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O2BUEYze; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso9914655e9.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756453549; x=1757058349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PC2yba/xmgksV6zG6n4nvj8k/R2J8J0LxU6Dw/Iapik=;
        b=O2BUEYzejz7h3OlrPHcbc8W25ncqVHVq8mNOroJzNwRWdLfTXQJB8iPpCaQxKCYVOZ
         Hhrs+kqU7suBiec848JXsd25frkw5PhitNT39Ls1Tochwy7EsD46p4ZfcsA+dcX2rJ+k
         yYgOnNVfwJEIfxSE80aRiTAM0RxelTAUvhOfqDm16xexWQ1CB2khenkwQjJqBTXl34hH
         gCkTxFYQr6EAgAFzI6RequMYytEk8358S6A09hYjhebOKx6nMQSwiT/gUMCAxeFZzbRf
         Xi539jILfmKaR0B7H4DCoctgaNEWkY4mULYGPcp0cnsUlUD8ba2U+aZA+0tqcnnCzirF
         8mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756453549; x=1757058349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PC2yba/xmgksV6zG6n4nvj8k/R2J8J0LxU6Dw/Iapik=;
        b=gPhTbDScMEY76DMD2KCIiDA6IsXK+bgXTNJ0nkSULCsrpMSl4FA1El14W8j7ZChMR5
         YeBc9HCYhF8NI9h/wKhmBgLNVuPQ4LQVqtBPIiVDEY8llSeeXdzyTd7Dx8/Jo8NSlixO
         v3hxRdpmXJOhC5hXG41zkCqfAwVCsFX7vxDl9FLxdRwsZIVtcVu8DjylKwaHgD4p9ID6
         jkCv/s4q8JEcsnbg/oi6jlT7rZFDfftWewhMI57tiZOG65GJUbSoYUPBPDN3czHNh7SC
         nm2jL7C6n6SZdnLKxqFpfVP+IXnpWtoKmNkhz2le/BEUUdUNqPpWzT9PtW8C78doKhiC
         sS3A==
X-Gm-Message-State: AOJu0YxGTwBRKPZyUSW0sNJPbhizNp79+UdHT6Fm60GpMoWBn8DRICbr
	WBMnu9iXLexMu4Cp8gGFrVTngWjvA1etCWHAKCG04lVzLj3ElXpdiL36ioTh54nDBPzPS8nyx2m
	y/iyzo7hSaQ==
X-Gm-Gg: ASbGncuazg2nRS7EXyjZb+UMyS52xlBHHmwDzhfElSjjy0h3Oy7vYhePMVWc8lixZ8H
	BazM1z7SDZQNsHYrEsGMMwHRzOYjGVB5iaqFuMCcOsjBraMWJxiLUsk5vgsy0xDJgU15oWY0SBk
	IVrPXBlGFaqkXgx2BQaale9Fj42iVRjwCqNQ+/Ighgn3qgkIzlh2VPjdsUrQ9k1pkO7xQ2SXjV/
	pqBpKBjCQ1/rd/sq2EwZ+eeVjLVTPzTtKhWjtaHWh6cVLQwWvUPYjuGPk7NGh6cve2KHmNZuilI
	l869dSJrkTdZsJLqigGHhEaWhHe0BfFX1OhjndCUgeqQFhTpzjwAv/9zTqqDbOyWUmqVOoWEX7N
	jJ1kZsZGnSiQpmJMR1/LjyjQKtJgb39JrbTSFI+ERatzRrp9ywyeWrvKIyn7AHtaFqtx3DpBN7B
	uMrlEdwkAGBldNgUsfytmYVZxSrjp7H4B2uA==
X-Google-Smtp-Source: AGHT+IFH8yOM/vYpy74eQPJaoNjfSKn3Su6Zc7hNUfD395Aep6BzyHYkd5dVdUVZWM9G4a+YXGRcaA==
X-Received: by 2002:a05:6000:178d:b0:3a3:7593:818b with SMTP id ffacd0b85a97d-3c5daefcb76mr19525435f8f.21.1756453548916;
        Fri, 29 Aug 2025 00:45:48 -0700 (PDT)
Received: from localhost (2001-b011-fa04-fd77-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:fd77:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065a3b67sm16406695ad.120.2025.08.29.00.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:45:48 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf] MAINTAINERS: add Shung-Hsi as reviewer for BPF CORE
Date: Fri, 29 Aug 2025 15:45:42 +0800
Message-ID: <20250829074544.104182-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a reviewer for BPF CORE, focusing mainly on verifier and
tnum.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Hope getting myself involved in mail loop would be the nudge I need that
gets me to do reviews more consistently.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..49364d6d4132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4525,6 +4525,7 @@ BPF [CORE]
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	John Fastabend <john.fastabend@gmail.com>
+R:	Shung-Hsi Yu <shung-hsi.yu@suse.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	include/linux/bpf*
-- 
2.51.0


