Return-Path: <bpf+bounces-27256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265A8AB60A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7D11F22DE8
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E511C94;
	Fri, 19 Apr 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HkV4YuY3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFE64F
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558987; cv=none; b=MiJYyJlKzsSjA+k4tm6MLj5DDDMs24GvHdjFPLbjIWGP6cZSXGcfZgif8jeVGg4X67UmbBWpOea3p+jJHihi2gblwPZOnyCUxLGLo6T0oBmh9c4ryvSsLqH+pyPsXq5N4yQxAft6sXssLyRqog90J+/QUo2QDJM/wqmRDO2vM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558987; c=relaxed/simple;
	bh=uvqyMm6RdPhca3S0S494KFQ/7x+fa3280uaxDVX2YVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cNROfY63R63xCsC8g/xLKR21a8YSnWHWUDsGytGNmfn4FDWuyEvpot9/X886iqJuGs9uQjJbxKnkpV0WIA2Qw3gMTVdpDh322Kyk1YM/5cg3wPctWvA2Uum+hfu3wLGO7C19TMOkDzhFFeXO7DBg7ukdd+gas4cmvcAM3bQvA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HkV4YuY3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1913993a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713558985; x=1714163785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yPkCzEFvsubtbQIxpQ070dEUu4CVmNqo0J7yCYv3yk=;
        b=HkV4YuY3gjGZwrapHNX+KI/Jn7ILyA/hY436cTQ61JZiC4Eo+Y8FA/xVV+OcXTfnGa
         e2YXBTfKViy0J1Q/mvywBbCbwxWyuaN8VgJqHw0JMD7zJhSeHKtwxvAg43MphXTMnBSg
         cziNLsOakPtQf0L7B9tpuk8LJwTBHjer1tsUDIgPAIAUEgRLYv6jBeAlww4GN51Z0p+x
         LL62wvMp6vy1LlgH/gOiG20BoelMjk4KImtwMncTBgNCVEVWQFE5f37SnLA950LmNciy
         Wua/OlmaYzrSP6OreWJIIj3aHcjfCnz04o98VvkcTeM0PE+Aihlz3Ti68DxJKr5Ys/K6
         b54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713558985; x=1714163785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yPkCzEFvsubtbQIxpQ070dEUu4CVmNqo0J7yCYv3yk=;
        b=vBjzsr9AU6dV7Cu2GviX4ktoNXSQMzGOWV5WDIXvxiDnPOQ/MHXj26ZCh+NMahJV4l
         FYiEU6nKi516ngr36iSXUF0Hpj/RRkFrf0tF9NLPWTI/oENCPR+NukFXoHj29djJVgH2
         ylUno5PUM3j9iUEzLYEGEEj28xqnwPXeEF4tb7Izt2kbSHovY0tl3gMr96hwqaOcFevQ
         38Chu0ysfsaPMYSTC5D9n572RqSxB+TLaGnnjEFIdDHRHQz/JAYNNd3b6QghgPYZygaM
         wk9A6252mtT1klQl7PjeRdhUg0HAxy2mbwk3h6ddPoFW4dG9qopmCNt1nNBCa8ir/aZr
         AErA==
X-Gm-Message-State: AOJu0YxkuLz2VDprWG6nRaIFyRrUYdaVJs0g+0FoRHogFG42lqNWBuVG
	XvorQ6U/3UcpsY1RcrzH2gPgN6aXPcK+XMq+ZTD5KvdGpGhMVjv5Y+NDC4Jo
X-Google-Smtp-Source: AGHT+IEgoQqLs3BC17SPALRXVm1MedeHs/L/CqlMAVOdnZyQsvll+/pRB3a1+ta2TAshp9DnHVgOCw==
X-Received: by 2002:a17:902:cf0b:b0:1e7:b682:ec95 with SMTP id i11-20020a170902cf0b00b001e7b682ec95mr3637255plg.3.1713558985358;
        Fri, 19 Apr 2024 13:36:25 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm3779357plk.240.2024.04.19.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 13:36:25 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify helper ID and pointer terms in instruction-set.rst
Date: Fri, 19 Apr 2024 13:36:17 -0700
Message-Id: <20240419203617.6850-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per IETF 119 meeting discussion and mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/2JwWQwFdOeMGv0VTbD0CKWwAOEA/
the following changes are made.

First, say call by "static ID" rather than call by "address"

Second, change "pointer" to "address"

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 8d0781f0b..1f92551a3 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -443,27 +443,27 @@ otherwise identical operations, and indicates the base64 conformance
 group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
-========  =====  =======  ===============================  ===================================================
-code      value  src_reg  description                      notes
-========  =====  =======  ===============================  ===================================================
-JA        0x0    0x0      PC += offset                     {JA, K, JMP} only
-JA        0x0    0x0      PC += imm                        {JA, K, JMP32} only
+========  =====  =======  =================================  ===================================================
+code      value  src_reg  description                        notes
+========  =====  =======  =================================  ===================================================
+JA        0x0    0x0      PC += offset                       {JA, K, JMP} only
+JA        0x0    0x0      PC += imm                          {JA, K, JMP32} only
 JEQ       0x1    any      PC += offset if dst == src
-JGT       0x2    any      PC += offset if dst > src        unsigned
-JGE       0x3    any      PC += offset if dst >= src       unsigned
+JGT       0x2    any      PC += offset if dst > src          unsigned
+JGE       0x3    any      PC += offset if dst >= src         unsigned
 JSET      0x4    any      PC += offset if dst & src
 JNE       0x5    any      PC += offset if dst != src
-JSGT      0x6    any      PC += offset if dst > src        signed
-JSGE      0x7    any      PC += offset if dst >= src       signed
-CALL      0x8    0x0      call helper function by address  {CALL, K, JMP} only, see `Helper functions`_
-CALL      0x8    0x1      call PC += imm                   {CALL, K, JMP} only, see `Program-local functions`_
-CALL      0x8    0x2      call helper function by BTF ID   {CALL, K, JMP} only, see `Helper functions`_
-EXIT      0x9    0x0      return                           {CALL, K, JMP} only
-JLT       0xa    any      PC += offset if dst < src        unsigned
-JLE       0xb    any      PC += offset if dst <= src       unsigned
-JSLT      0xc    any      PC += offset if dst < src        signed
-JSLE      0xd    any      PC += offset if dst <= src       signed
-========  =====  =======  ===============================  ===================================================
+JSGT      0x6    any      PC += offset if dst > src          signed
+JSGE      0x7    any      PC += offset if dst >= src         signed
+CALL      0x8    0x0      call helper function by static ID  {CALL, K, JMP} only, see `Helper functions`_
+CALL      0x8    0x1      call PC += imm                     {CALL, K, JMP} only, see `Program-local functions`_
+CALL      0x8    0x2      call helper function by BTF ID     {CALL, K, JMP} only, see `Helper functions`_
+EXIT      0x9    0x0      return                             {CALL, K, JMP} only
+JLT       0xa    any      PC += offset if dst < src          unsigned
+JLE       0xb    any      PC += offset if dst <= src         unsigned
+JSLT      0xc    any      PC += offset if dst < src          signed
+JSLE      0xd    any      PC += offset if dst <= src         signed
+========  =====  =======  =================================  ===================================================
 
 The BPF program needs to store the return value into register R0 before doing an
 ``EXIT``.
@@ -498,9 +498,9 @@ Helper functions
 Helper functions are a concept whereby BPF programs can call into a
 set of function calls exposed by the underlying platform.
 
-Historically, each helper function was identified by an address
+Historically, each helper function was identified by a static ID
 encoded in the 'imm' field.  The available helper functions may differ
-for each program type, but address values are unique across all program types.
+for each program type, but static IDs are unique across all program types.
 
 Platforms that support the BPF Type Format (BTF) support identifying
 a helper function by a BTF ID encoded in the 'imm' field, where the BTF ID
@@ -667,11 +667,11 @@ src_reg  pseudocode                                 imm type     dst type
 =======  =========================================  ===========  ==============
 0x0      dst = (next_imm << 32) | imm               integer      integer
 0x1      dst = map_by_fd(imm)                       map fd       map
-0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
-0x3      dst = var_addr(imm)                        variable id  data pointer
-0x4      dst = code_addr(imm)                       integer      code pointer
+0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data address
+0x3      dst = var_addr(imm)                        variable id  data address
+0x4      dst = code_addr(imm)                       integer      code address
 0x5      dst = map_by_idx(imm)                      map index    map
-0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
+0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data address
 =======  =========================================  ===========  ==============
 
 where
-- 
2.40.1


