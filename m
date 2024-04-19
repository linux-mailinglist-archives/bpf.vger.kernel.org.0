Return-Path: <bpf+bounces-27257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E418AB60B
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE228452B
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271A11CB4;
	Fri, 19 Apr 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="taEVn25M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="f43kbksQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c4z2VA2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48441119F
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558999; cv=none; b=PcoqDODXCUeZ5tz/kZf1Rwhnv26OiEq6d147YKocx5ZEqV+4jStM4KKmkj7iGOqlH6HgO0P2aIbcqMM7b1PXdA6QVwiJfjt3cwHsQ8snjBwvPqOtKe4zxSbFO7uyj0Fpgbucp9YrylimlkIinT2bI9nysTzzpukIsJshsby+/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558999; c=relaxed/simple;
	bh=MZ+FLL9T7COvUIxjckaYOOrPJ7WB0tzQYrmYyak+vtc=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=uLr+U4RTi4HchufUojDBqF71osy9yzsinNc5m2u/Ev9gXO5mygAkzybjuTqHXTQ+dE0L1tWO390HdWMEr//fYSL0OAybm4lCmTUC8Jv4dDl/a6ICSPlxnXN3kQxWNN+QAwRYEuCuLfq7NdJvQpUCrbajLDndAnPeCn3f0MOBMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=taEVn25M; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=f43kbksQ reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=c4z2VA2F reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EBCCCC15107E
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713558990; bh=MZ+FLL9T7COvUIxjckaYOOrPJ7WB0tzQYrmYyak+vtc=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=taEVn25Me4DOooYUoC3Bau29fqBQiKAez4vKRJRHu9slHqPTnbgKOfp8ZYPqec2+l
	 iKywnefm3aZepH7fHdrC/MvQvMgWts+pf2NnsWIovNlybA4Nw5DlgsAfC1K5NdGVkg
	 s2zcxrTgF/+3KJ4Znf8DPku5GSeqfrmiaqBF9mR8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BDDF4C14F6F1;
 Fri, 19 Apr 2024 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713558990; bh=MZ+FLL9T7COvUIxjckaYOOrPJ7WB0tzQYrmYyak+vtc=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=f43kbksQ+M/n7Y8vE5ACcIsoXMFgNld2ozY4sWJsVrc1XCYUK0yFfBVUq9MKo7ZoS
 a1GCBMs8F+aE2kSsy8zOtAEkOfC/5uYpOYKYKoqJSTzoxDp232v8j+ezZ8UFZKMrNL
 woqrZMLUQzcwtkp/tbzL8j3m8nupx5258xTg8/pI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 052A6C14F6F1
 for <bpf@ietfa.amsl.com>; Fri, 19 Apr 2024 13:36:30 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJKK5ZRJENWY for <bpf@ietfa.amsl.com>;
 Fri, 19 Apr 2024 13:36:26 -0700 (PDT)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 653CAC14F6E4
 for <bpf@ietf.org>; Fri, 19 Apr 2024 13:36:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e50a04c317so15024195ad.1
 for <bpf@ietf.org>; Fri, 19 Apr 2024 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713558985; x=1714163785; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4yPkCzEFvsubtbQIxpQ070dEUu4CVmNqo0J7yCYv3yk=;
 b=c4z2VA2FG7WB0hbrbBhWlobqljb1FOIxJzcQXjOUjvWtP+iUZVBxbdppjY8MIMmzjy
 X5a7z4N5siWnxCLycSMv6CP50FzorWbiEzuFZev0ac9L6DTEWQWrmzCgw+uvqIHnM2af
 VPmsgVP+lLWY4Hixh07BuFfTe4OGUTaRJ89tBbdZzvGwXF3+bwF/0hJjB/HvcFxoTTYr
 gqrPO45gIDzRguBqqeajz6PMyW5ad+E5zGu+LL76oL1Gh7O0luUtRU+TQHxf2XVBQRB+
 QPtF35gq8FxHAYAjiOByn2u1HUEvSue/8MPO3Q6BMS4Zqf0Wo9koYuqZWrSTQ046Jehg
 H/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713558985; x=1714163785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yPkCzEFvsubtbQIxpQ070dEUu4CVmNqo0J7yCYv3yk=;
 b=to6vq40eKoBr/swl1mOe0+SrCb7fVDIPlJMHGshwyo+hUc58DLVxqY83NT2QoQ+6C2
 3xqaonWDFZQI30BCYTD5CNCp+LcubVibJ38Q5O1S9JaKg/0hYboeXI72kPtfSwL6pr+L
 3rcr/9B9xvVVBJmZKZVmm9up/nPOj2zS2/J0uJtCF4W0nDs/F6pXDTTGnmFReN+jz5h2
 0ROOxMBtwdLIh/BTXWBVmEpox8FFVzat0qFLyZ9rLeI+NGqB6oQyPLL2n8OBBZ30TTdr
 1BxUpQCWQ7XXnbtzTzIL77JlCbHDFyEb1J7Q4KcJbz8Jqc85zAGBuowbBmKXv0LbiJIo
 TpgA==
X-Gm-Message-State: AOJu0Yw2Hx04D47nQ+jOdqEZIV25xR7QWM4qi1YFfuR51CEpWYRx4RC3
 btldma8pshaTSXL67iBc5i5jlNmTuGqnb43gM8s7//GxO9aL55OCDv3EvYdH
X-Google-Smtp-Source: AGHT+IEgoQqLs3BC17SPALRXVm1MedeHs/L/CqlMAVOdnZyQsvll+/pRB3a1+ta2TAshp9DnHVgOCw==
X-Received: by 2002:a17:902:cf0b:b0:1e7:b682:ec95 with SMTP id
 i11-20020a170902cf0b00b001e7b682ec95mr3637255plg.3.1713558985358; 
 Fri, 19 Apr 2024 13:36:25 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 q4-20020a170902edc400b001e29c4b7bd2sm3779357plk.240.2024.04.19.13.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 13:36:25 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Fri, 19 Apr 2024 13:36:17 -0700
Message-Id: <20240419203617.6850-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/f3Hyx3QnAlgTMaIhr9SRMTL83zA>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify helper ID and pointer terms in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

