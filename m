Return-Path: <bpf+bounces-6336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD47682F0
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 02:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF23C281518
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9B382;
	Sun, 30 Jul 2023 00:43:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E24376
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 00:43:13 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F3E5F
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 17:43:12 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3D450C151084
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690677792; bh=I2CPm6HR9kb3b6b/24FDwdjzLCrBGZ1QJx0riBbFiRw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=O5JeVRn4ARoy09JmrTqw66ZDHwnQBLCm1xk5PTzJDsqm4jW3dPg4J1MG5rn1I7wWA
	 21bLDPKYqZ5mL+zqrBg8++J2X88wcpCbRw6iK3n5noVo5rdJRCESp0h3Fp77DdsNDU
	 c0wCjVXqzbrHm5VC3gpSx0rAeHsnT36XYDqn3sQY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Jul 29 17:43:12 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1DB2CC14CE51;
	Sat, 29 Jul 2023 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690677792; bh=I2CPm6HR9kb3b6b/24FDwdjzLCrBGZ1QJx0riBbFiRw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=O5JeVRn4ARoy09JmrTqw66ZDHwnQBLCm1xk5PTzJDsqm4jW3dPg4J1MG5rn1I7wWA
	 21bLDPKYqZ5mL+zqrBg8++J2X88wcpCbRw6iK3n5noVo5rdJRCESp0h3Fp77DdsNDU
	 c0wCjVXqzbrHm5VC3gpSx0rAeHsnT36XYDqn3sQY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3D06CC14CE51
 for <bpf@ietfa.amsl.com>; Sat, 29 Jul 2023 17:43:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -5.261
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMphNNo_ck1s for <bpf@ietfa.amsl.com>;
 Sat, 29 Jul 2023 17:43:06 -0700 (PDT)
Received: from 69-171-232-180.mail-mxout.facebook.com
 (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8DE4DC14CEFF
 for <bpf@ietf.org>; Sat, 29 Jul 2023 17:43:05 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
 id 53DF923E3D5EE; Sat, 29 Jul 2023 17:42:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@ietf.org,
 kernel test robot <lkp@intel.com>
Date: Sat, 29 Jul 2023 17:42:51 -0700
Message-Id: <20230730004251.381307-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/PprfBbbGh7pdq9jgLZhFlInNOlQ>
Subject: [Bpf] [PATCH bpf-next] docs/bpf: Fix malformed documentation
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Two issues are fixed:
  1. Malformed table due to newly-introduced BPF_MOVSX
  2. Missing reference link for ``Sign-extension load operations``

Fixes: 245d4c40c09b ("docs/bpf: Add documentation for new instructions")
Cc: bpf@ietf.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307291840.Cqhj7uox-lkp@intel.com/
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/standardization/instruction-set.rst   | 45 ++++++++++---------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fb8154cedd84..655494ac7af6 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -154,27 +154,27 @@ otherwise identical operations.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
 
-========  =====  =======  ==========================================================
-code      value  offset   description
-========  =====  =======  ==========================================================
-BPF_ADD   0x00   0        dst += src
-BPF_SUB   0x10   0        dst -= src
-BPF_MUL   0x20   0        dst \*= src
-BPF_DIV   0x30   0        dst = (src != 0) ? (dst / src) : 0
-BPF_SDIV  0x30   1        dst = (src != 0) ? (dst s/ src) : 0
-BPF_OR    0x40   0        dst \|= src
-BPF_AND   0x50   0        dst &= src
-BPF_LSH   0x60   0        dst <<= (src & mask)
-BPF_RSH   0x70   0        dst >>= (src & mask)
-BPF_NEG   0x80   0        dst = -dst
-BPF_MOD   0x90   0        dst = (src != 0) ? (dst % src) : dst
-BPF_SMOD  0x90   1        dst = (src != 0) ? (dst s% src) : dst
-BPF_XOR   0xa0   0        dst ^= src
-BPF_MOV   0xb0   0        dst = src
-BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
-BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
-BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
-========  =====  =======  ==========================================================
+=========  =====  =======  ==========================================================
+code       value  offset   description
+=========  =====  =======  ==========================================================
+BPF_ADD    0x00   0        dst += src
+BPF_SUB    0x10   0        dst -= src
+BPF_MUL    0x20   0        dst \*= src
+BPF_DIV    0x30   0        dst = (src != 0) ? (dst / src) : 0
+BPF_SDIV   0x30   1        dst = (src != 0) ? (dst s/ src) : 0
+BPF_OR     0x40   0        dst \|= src
+BPF_AND    0x50   0        dst &= src
+BPF_LSH    0x60   0        dst <<= (src & mask)
+BPF_RSH    0x70   0        dst >>= (src & mask)
+BPF_NEG    0x80   0        dst = -dst
+BPF_MOD    0x90   0        dst = (src != 0) ? (dst % src) : dst
+BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
+BPF_XOR    0xa0   0        dst ^= src
+BPF_MOV    0xb0   0        dst = src
+BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
+BPF_ARSH   0xc0   0        sign extending dst >>= (src & mask)
+BPF_END    0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
+=========  =====  =======  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -397,6 +397,9 @@ instructions that transfer data between a register and memory.
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
 'unsigned size' is one of u8, u16, u32 or u64.
 
+Sign-extension load operations
+------------------------------
+
 The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
 instructions that transfer data between a register and memory.
 
-- 
2.34.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

