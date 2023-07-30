Return-Path: <bpf+bounces-6340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D976839A
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 05:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E091C20A65
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1244659;
	Sun, 30 Jul 2023 03:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE28375
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 03:52:13 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818D1BC9
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d3583d0efso23714336d6.1
        for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690689127; x=1691293927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS0QrEAfMrnmUr8EFr5pq11r0uil3VUG1QUtldLkrFg=;
        b=lZa0TlNoaXOPEq/WCVCbhwA9jZz3K1KoJ2pL22ZgEbcmC4i1s4bZ8fx4DbmxNbtnwP
         qnv+9oHDWvQ/QoazOOW08gGIkNdCoTHl+oVowqI9wH3XvAdl6ZmS/FKmEAgawzBug47a
         cdUobfcGlGBAAWL5GZVKZKvN13/Cp/PVL55H5EN5LIW7VhVlswfT46Ril4P6n8T6TPjQ
         rs0QEbKL1YDc9mibho5quexdD+mnf8j7E/elpARNAJ5+hrIZjIxfFi8QY3GM2am4ksUr
         7BJhkd0BmqmC6P+CUGYIrX328VcneLSQzMok2n5aSL8nCR4Kqmkp0RqFAgV29cIP8fef
         XmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690689127; x=1691293927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS0QrEAfMrnmUr8EFr5pq11r0uil3VUG1QUtldLkrFg=;
        b=cnxsLRaoqod5UPUYI5mzO0jd2HRzWXQDcdJLGz0KciIMXFt1dPCwMxo/VtCcfF6aVM
         ePcqMoZ7vlEOVErMv+vSxvBOuWE0C/iGmkLHjeQ9nRQVv+ls/mutL8DLrk9rxnIVj2zp
         cKtoZG5AkZUvw4aTlAFh5wzKrZ29OaoMrBnGEleAk9sfxeoa/YgyR/8rZG/XsMxtQc0g
         7xrJnTcAtD1wYQYHzR58QNFFGVvgS97OfzUjmgpR9156liBikFdKH1iHO1vjPjV1zk+s
         UV6WnFpg42xVGLTrXPOYiCoXLxXbddTgohYlzsgUxpdMH4SCMsl+MACFQ2kT9jWF9fgK
         6aXA==
X-Gm-Message-State: ABy/qLYmfibW/eYxmM0JGOLmFH+nYsteYsqohPZOpP4Szyeq0zrD/23w
	rGA1Etb+gTykaNNKOrE/GfyBCKtDG9/fngBPyQ4=
X-Google-Smtp-Source: APBJJlEpOO0nPtxzSQBzLUrFBiHirSX6APD1rFeDY/AgeSlTcpEcHRslbWKuGu7XaEMfEd42Ha3SbA==
X-Received: by 2002:a0c:e290:0:b0:636:1722:8300 with SMTP id r16-20020a0ce290000000b0063617228300mr7379735qvl.1.1690689127735;
        Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b0063cf9478fddsm2583073qvm.128.2023.07.29.20.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] bpf, docs: Formalize type notation and function semantics in ISA standard
Date: Sat, 29 Jul 2023 23:51:56 -0400
Message-Id: <20230730035156.2728106-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230730035156.2728106-1-hawkinsw@obs.cr>
References: <20230730035156.2728106-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Give a single place where the shorthand for types are defined and the
semantics of helper functions are described.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 65 ++++++++++++++++++-
 Documentation/sphinx/requirements.txt         |  2 +-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fb8154cedd84..97378388e20b 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -10,9 +10,68 @@ This document specifies version 1.0 of the eBPF instruction set.
 Documentation conventions
 =========================
 
-For brevity, this document uses the type notion "u64", "u32", etc.
-to mean an unsigned integer whose width is the specified number of bits,
-and "s32", etc. to mean a signed integer of the specified number of bits.
+For brevity and consistency, this document refers to families
+of types using a shorthand syntax and refers to several helper
+functions when explaining the semantics of opcodes. The range
+of valid values for those types and the semantics of those functions
+are defined in the following subsections.
+
+Types
+-----
+This document refers to integer types with a notation of the form `SX`
+that succinctly defines whether their values are signed or unsigned
+numbers and the bit widths:
+
+=== =======
+`S` Meaning
+=== =======
+`u` unsigned
+`s` signed
+=== =======
+
+===== =========
+`X`   Bit width
+===== =========
+`8`   8 bits
+`16`  16 bits
+`32`  32 bits
+`64`  64 bits
+`128` 128 bits
+===== =========
+
+For example, `u32` is a type whose valid values are all the 32-bit unsigned
+numbers and `s16` is a types whose valid values are all the 16-bit signed
+numbers.
+
+Functions
+---------
+* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
+  returns the equivalent number as an unsigned 16-bit number in big-endian
+  format.
+* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
+  returns the equivalent number as an unsigned 32-bit number in big-endian
+  format.
+* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
+  returns the equivalent number as an unsigned 64-bit number in big-endian
+  format.
+* `htole16`: Takes an unsigned 16-bit number in host-endian format and
+  returns the equivalent number as an unsigned 16-bit number in little-endian
+  format.
+* `htole32`: Takes an unsigned 32-bit number in host-endian format and
+  returns the equivalent number as an unsigned 32-bit number in little-endian
+  format.
+* `htole64`: Takes an unsigned 64-bit number in host-endian format and
+  returns the equivalent number as an unsigned 64-bit number in little-endian
+  format.
+* `bswap16`: Takes an unsigned 16-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
+* `bswap32`: Takes an unsigned 32-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
+* `bswap64`: Takes an unsigned 64-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
 
 Registers and calling convention
 ================================
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..9479c5c2e338 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
-Sphinx==2.4.4
+Sphinx==7.1.1
-- 
2.40.1


