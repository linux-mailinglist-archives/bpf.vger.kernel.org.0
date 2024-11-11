Return-Path: <bpf+bounces-44542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E69C48BF
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 23:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D186B2DE56
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAD1B4F07;
	Mon, 11 Nov 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Doa2I3io"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996D19CD1B
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360571; cv=none; b=gtRJxhEuri7BYA/USekShxcLLJAkOCJFhltkOyNdmTqqASZ9kku6cil2+GAcKmd3gF4FkIe7kihGFBlssZ5hsqefmga3ejuti6XPSVomCL/4mmv0i+k+Y82ho5bWqu37Ms1DUp+OE6SelZ5I/srRNFX+hiXMx/09+C9Q3qxBEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360571; c=relaxed/simple;
	bh=dwOJJM/S6xsgWRwUFpiAC+HzTJBbmLexM6keJAtd9kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8OqyPxgRjE/E8FxXWs5ZgVkau8oCwKB1+dQ8Ahslbk0pEyzXU++zmncUxqjuJuqVlxkmQEun2js5l3ZLAd9dqn/TE/yGzeDU6cvWA7WEsD/MbAHBc3eAxtq0c9x5Q6UBNJqpLaL57JGd5C2QRcgWtwh5Un4IZGDPHwiDgUfKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Doa2I3io; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso723409366b.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360568; x=1731965368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nq3ntCwXUnJqOsNv7yAXD58cw8IZtRbR4hPM9Xoc64=;
        b=Doa2I3iotjvPGuzgfMXWV9JgOop88hScKACQW78GFWVnxwYaOsm0hucuNex0p2Igey
         LuZ72klIuzD73g8pDg0n7HJXyuAuLgdPZiSz2Pdc8EGmlTZxql4/b831RKMgbTNCiPdJ
         wNTADu3/fuensZ+bx7ebw+fbip7mBgLNUXEXfgV9Pjcmt/Y5C3ysjVbEE/Ts0PIfYS9W
         NV/DcIOtUEcLZO1uLo1Ls7SHa/zeZdKEN8LhGRgJafKaFrt+h/Hm48AnQbpeTx13eemp
         c7aQ7GkkhkcbG6blHxfIL4+jafcUXfFoNPt1Oirnk/lKJSC7Nltc4/smXgTIHm3bekgs
         oThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360568; x=1731965368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nq3ntCwXUnJqOsNv7yAXD58cw8IZtRbR4hPM9Xoc64=;
        b=WomTGcDTLSqHX4VsJ5+F5OHQLblljQQqZPuAcxWIQH0uVz4yNqML7e4V/yB7P/O8oC
         vlOiQFSUusqG80FeKTcl4q6HFN+PS242M29T/4ybQN393aIMErbTPNQuf4GUaeTJEtlb
         nJncCLT0UQZ/Jt5OlsuijakTqqJdB4McuoNvF0G6tAvP4v6zwwXsdzGrMiN06iIfFeKM
         CUbbXrpo/jisip4ee/cKErbAWzUdid+uODTDfaFjweqbuFLj7JgvWTO4sc/iZ2U+NCDm
         0xmjf4Zt748uq08thGtFAC8C7tIvQXK5JjsqzMUv+vEae+X2yStZOmIeG3a8Kn0fS6bO
         Q/CA==
X-Gm-Message-State: AOJu0Yx/uG87pkXe7frE/qMcEHkSxmB9wloUSyfMiox0bJhBdueTyUIb
	+EhhfP7wkErGSWbYigabYRmMjLsKBj9JF+dLaj3WxCw0LNxvuX1qRtLMPw==
X-Google-Smtp-Source: AGHT+IFVZrJbkv1oyvNIRuMCSNrQaPfa9uRmpmt2iL4JaPOmAxlJ4Jc0En0dB2Wp2Fpakdn2Roe9IQ==
X-Received: by 2002:a17:906:c112:b0:a99:6036:90a with SMTP id a640c23a62f3a-a9eeff0d262mr1384032266b.14.1731360567777;
        Mon, 11 Nov 2024 13:29:27 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3961])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm629570266b.166.2024.11.11.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:29:27 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/4] libbpf: stringify error codes in log messages
Date: Mon, 11 Nov 2024 21:29:15 +0000
Message-ID: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Libbpf may report error in 2 ways:
 1. Numeric errno
 2. Errno's text representation, returned by strerror
Both ways may be confusing for users: numeric code requires people to
know how to find its meaning and strerror may be too generic and
unclear.

These patches modify libbpf error reporting by swapping numeric codes
and strerror with the standard short error name, for example:
"failed to attach: -22" becomes "failed to attach: -EINVAL".

Mykyta Yatsenko (4):
  libbpf: introduce errstr() for stringifying errno
  libbpf: stringify errno in log messages in libbpf.c
  libbpf: stringify errno in log messages in btf*.c
  libbpf: stringify errno in log messages in the remaining code

 tools/lib/bpf/btf.c        |  26 +--
 tools/lib/bpf/btf_dump.c   |   3 +-
 tools/lib/bpf/elf.c        |   4 +-
 tools/lib/bpf/features.c   |  15 +-
 tools/lib/bpf/gen_loader.c |   3 +-
 tools/lib/bpf/libbpf.c     | 356 ++++++++++++++++---------------------
 tools/lib/bpf/linker.c     |  21 ++-
 tools/lib/bpf/ringbuf.c    |  34 ++--
 tools/lib/bpf/str_error.c  |  59 ++++++
 tools/lib/bpf/str_error.h  |   7 +
 tools/lib/bpf/usdt.c       |  32 ++--
 11 files changed, 294 insertions(+), 266 deletions(-)

-- 
2.47.0


