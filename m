Return-Path: <bpf+bounces-69131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2705B8DBC1
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA95C17EF8C
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384562D8762;
	Sun, 21 Sep 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eat5uUdP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B522D7D35
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461120; cv=none; b=ZHsv55gv1TLMtvvm9HdwXyGHSTWftsHcXqHcOupeDEwlXLR3npKyYcWBq6gT0IDoQKQEmrUhHno3Dl+l6u/G4GpTUhNn5sV6DZyCqRAasOtRO5WSlRmR6SFqYaEyB6qWW/LqWKEyffSCH9yvnt5S828ugKZmpjwZrhe15fWRBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461120; c=relaxed/simple;
	bh=GaeqG1aQ2hIPk42ZQ8nGrX2MqhtMYPgLblNvLX99w2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWeeJDMga/PDL1rcgSwasbJQU1cXExhnDtTB2tltbZHVyMkSeBLi+7IDPD4FEDb1RLHC/f7k5I5XK8mfnefCQ44jiJ8bH+trFhQoKR/PYfv5sh6wHp1/iYCCisvCFZIsW7bMI64JtpPBkt14P0jtHl9IBaphqZFbSR8W1BYv7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eat5uUdP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso7672375e9.3
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461116; x=1759065916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmK9vUQQJFeAfvCWCHwHTiLX7/2nAM7DIu9RJAL41Pc=;
        b=eat5uUdPx6E5qWKPywJoUtOjAMIsBNmKRVmzH461GlRrgx9bQWeGe+jh+iY2sKR0db
         XDoRWA9Y8/8rNWTBx5sfZMWdTlH1AHEBlReSnqA2YNx7MmHvwWhBOehrNvmglYwooqV6
         Eh0ixlxHHlX4GGdAMBWtcHQtaWLS1TYQjZxcUrrjjW8bdV45wFPFYH9T5iVZyrIrsN3R
         tF0daERh1Cij8VoT/5RqRic1Lpw94wf5p0csJFkZw0n7I+fzICK0NHt63jwDp9YSvFv1
         /YNFZFOrX7s9ag9TLiQICb6bMWu/tcgsFTLZBM2BiA3Rhys2OpnvIUuqql465qqG7fXK
         XNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461116; x=1759065916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmK9vUQQJFeAfvCWCHwHTiLX7/2nAM7DIu9RJAL41Pc=;
        b=HB8GlC38vJ+gN+L4vh6JkyC2ZLd4kG0F7mYLS+WyGTpdq7Tzhui8IYA+dIpeQm5Afk
         cWvACotBqv1dXtVWn+xib86PHE4Pug+Co2MVPC5SH3wPLRDZhrA5/FiZVyMitS2ZHzq3
         mOvtYUtW7JJS2HTQW4/yn/ZcVvBUz5/QMlVn8Hjfan2/w3hJ+kt7deVt8qqMIL0WqM/B
         qezkMjnDA8gRshJhjX3LeCTMrF5uVXiRMO0nL1y33+LpxhJ1/sVlFACyX4vcrXW8dqk1
         nFMMYLTHjZX8K/8Z1jpcP6enbNMrBatE6gAcxozMC/HTFCz7zt5J1H1leiDMKBl+IqUa
         3ZsA==
X-Gm-Message-State: AOJu0YwmjLw/hAWPnoNqmGyY1mHWVD7jMeWYR9MxH7TW7lHUlfAuV0yt
	2btfbFkRSrAu/iI0/3I+HYF8a08B+ELuQRd0MUQfySmEHhVP9t426CyPe3kw2LvIJus=
X-Gm-Gg: ASbGncvJWCR1lDMM7dQqIlJdvMsJCa6Rx0cMnWucQ9YQ8Vxuw1ljO+WYYZdevQmyHsh
	cSIuu3FHONgEMrx1hIueF0RHlSbWNRZf2lKwF553/G6FW93sWTA+D4am1/tF1expKOhZF+0f0BE
	JeGrEK+E9ujFLwU61A/4VEjmDuDsm4xjft884TQ/w42eCFK63Kud4YtoG2diRLRBw/a8D0OBchA
	IaAPZoOkzOEfLJwCFN6HcSJs3aeXBEPWISN14WLULHK6ZLjP4Pow64xHKBRbMBaNF7lcgmeUJ4A
	QGUH+Ui2p0IX/mYmDOwTEEq+IrJMUpTdDFQ3vQQOIopKbbGI57V9hM+zVCXoWHgjup1ixSGAoFn
	5ZNTEOoHz+UUjCylzNGX1Y2tShGE3wFRk15amJTlV0A==
X-Google-Smtp-Source: AGHT+IFYp360M8JY8eoKfOksuh+r/KgJMYj1oKhZJpwza2OlmHAWsV4RYEwv9lZp/dG0P6eHrOj6vw==
X-Received: by 2002:a05:600c:1d02:b0:468:9798:1b4c with SMTP id 5b1f17b1804b1-46c61cfddb1mr21581865e9.25.1758461116034;
        Sun, 21 Sep 2025 06:25:16 -0700 (PDT)
Received: from localhost.localdomain ([209.38.224.166])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46d1f3e1b03sm5898375e9.23.2025.09.21.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:25:15 -0700 (PDT)
From: Nick Zavaritsky <mejedi@gmail.com>
To: bpf@vger.kernel.org
Cc: Nick Zavaritsky <mejedi@gmail.com>
Subject: [PATCH 0/1] bpftool: Formatting defined by user:fmt: decl tag
Date: Sun, 21 Sep 2025 13:24:49 +0000
Message-ID: <20250921132503.9384-1-mejedi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool map dump command is handy when developing and troubleshooting
ebpf programs. It is nice to get data formatted in the most useful way,
eliminating the need to postprocess bpftool output. There were multiple
contributions in this vein over the years, e.g.:

  30255d317579 bpftool: Print as a string for char array

Sometimes the type alone doesn't carry enough semantic information, such
as __be32 storing an IPv4 address or __be16 encoding a port.

I propose using BTF decl tags to influence bpftool formatting.
Specifically, if the type itself or any type in the typedef chain has
"user:fmt:*" tag attached: 

  * "user:fmt:be" format the value as big-endian value (supports
    2, 4, or 8 byte integers);

  * "user:fmt:ip" format the value as IPv4 ot IPv6 address.

The typedef approach requires switching to a custom type (e.g.
bpf_inaddr) in map keys, values, and types that are embedded in a key
or value type.

The code remains nice and clean since the typedef and the underlying
type are compatible; e.g. we can key.addr = iphdr->daddr;

Nick Zavaritsky (1):
  bpftool: Formatting defined by user:fmt: decl tag

 tools/bpf/bpftool/btf_dumper.c | 119 +++++++++++++++++++++++++++++----
 tools/bpf/bpftool/main.h       |  12 ++++
 tools/bpf/bpftool/map.c        |   7 +-
 3 files changed, 124 insertions(+), 14 deletions(-)

-- 
2.43.0


