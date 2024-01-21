Return-Path: <bpf+bounces-19972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C838354B0
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 07:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39102281FD1
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 06:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8A34545;
	Sun, 21 Jan 2024 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpN4IqvE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D6364A0
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705816919; cv=none; b=T3BA9KHHyYzgSdrUzTq4vWCuGMBxdpbkPTXEmL5GMjEwRv5tCoY/fgIT8bmIA8S0kVdQAILMcjw+SvbfET4E0bayFrLI5tGkQ5yOujipH99n1LPPlfaIyGPiQDBc10shQqAGbF+szHTvS7M+3UWU6mYSlQnFHwMm6Jzi/AUZ8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705816919; c=relaxed/simple;
	bh=JlokKU23y1V6jIEVJLb72d0tW/H38tq8w27Zl9E/a80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gisTiUl2B36941DaPykWkxVcUH0huNw1pruiHoZ7VSyKgjbj8ESIEcUs0Ov/uZW0Xx/hhZJZa/fS3RrVcAoB43solXwHtlWSYY0wWFT3TZJgvbrMyXSJXjDleXcmxdAkY3CEgpjD2yXlhx1Ff9gzkjfYqKCliGX95v9Ej5kt/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpN4IqvE; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-362772f69d4so1211295ab.0
        for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 22:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705816917; x=1706421717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrzbrfCZf6qRM5lNjXKYRMcOJiFiylEni+qNTULwU8M=;
        b=TpN4IqvErgMd11AissITyU3GWRyQdwuke/TTI0AlxrkiFoxf46BcG2VeddGmL7QJbp
         l/S0dqehiRgu4JnvMJjogHK5/3ByBhNmLc6VxUJEBZrhCmUSirfjSJBL1SNWHPL3F8p5
         mdzZUlSmwpJFuTDLaxjABP+RaLNILPMovdUHYWDyPKcYT85txhFOAAGV+TpBJntLA+5v
         U3DyUP5qgSy38ZTavA7DllxXoDK8Tzw17/y7SSGBiSLMwNLAEKEFvRI4YOBf9R5J6pdE
         fBBbtbrNbmxwCKxvUKXRjO4dsfnojD+PUtdlUVUiiVfrEyrIVzTEcRfCEnZTyHblOP7Q
         v8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705816917; x=1706421717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrzbrfCZf6qRM5lNjXKYRMcOJiFiylEni+qNTULwU8M=;
        b=HIwKJhOZ03FhLvuMNQVLvBhXYA7EvCRAVLieWPrjUKQfFYmtC6Wnk2oDtVxNOsjPLL
         noJ35+wy04Ydu4PkWHnd1hmSXupJ070mXaWyy6mUzWdfa0DX2NhO0CdRabb9DQPuhjP4
         1s131eoryWY7TH1l6zRJtFWkZerR1GNmpE4MUS5cTpkDdrySBf+95K0l7C54UUyandB0
         VJGtcoA7F7Qoqrk+af8dhK6T4qxDh4AWjCh3PuNg/5dFUAewVETQyPIrL6HXFI+xTCAg
         cEozY4Ls9s0oJ33P0+4fzw5MxYSbxs8/VtJI0tbtt11a6zimuu0mQvU5Ek8lIAFTlkrn
         i2dQ==
X-Gm-Message-State: AOJu0YziVCgPJH5ZEAuWu71R+BpWko7g1Qtje4FTAZiiqrcZYk243fDM
	N1lQBJLOGtVbyF6gDLubJNRkKL4TSpnbeaG60WNOXpOYbdPz3EwOGa2KjDcx
X-Google-Smtp-Source: AGHT+IEzdf+hhG82LvrbakggByc+x0ADkvJfoFmNwg5qxv+718E3cDXM0lpYhzhi1FUnmIPUWr8BNg==
X-Received: by 2002:a92:c7c1:0:b0:360:780c:d2ab with SMTP id g1-20020a92c7c1000000b00360780cd2abmr3144456ilk.5.1705816917620;
        Sat, 20 Jan 2024 22:01:57 -0800 (PST)
Received: from localhost.localdomain ([2400:2410:3f6b:3e00:bd41:4fb4:edd1:da0d])
        by smtp.gmail.com with ESMTPSA id mp8-20020a170902fd0800b001d5efc7b8eesm5341721plb.305.2024.01.20.22.01.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Jan 2024 22:01:57 -0800 (PST)
From: Dima Tisnek <dimaqq@gmail.com>
To: bpf@vger.kernel.org
Cc: Dima Tisnek <dimaqq@gmail.com>
Subject: [PATCH bpf-next] Correct bpf_core_read.h comment wrt bpf_core_relo struct
Date: Sun, 21 Jan 2024 15:01:26 +0900
Message-ID: <20240121060126.15650-1-dimaqq@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Past commits, like 28b93c64499ae09d9dc8c04123b15f8654a93c4c, have removed the last
vestiges of struct bpf_field_reloc, it's called struct bpf_core_relo now.

Signed-off-by: Dima Tisnek <dimaqq@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 7325a12692a3..5aec301e9585 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -268,7 +268,7 @@ enum bpf_enum_value_kind {
  * a relocation, which records BTF type ID describing root struct/union and an
  * accessor string which describes exact embedded field that was used to take
  * an address. See detailed description of this relocation format and
- * semantics in comments to struct bpf_field_reloc in libbpf_internal.h.
+ * semantics in comments to struct bpf_core_relo in include/uapi/linux/bpf.h.
  *
  * This relocation allows libbpf to adjust BPF instruction to use correct
  * actual field offset, based on target kernel BTF type that matches original
-- 
2.43.0


