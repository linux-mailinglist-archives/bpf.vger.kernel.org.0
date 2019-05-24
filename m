Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6122984A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfEXMxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 08:53:34 -0400
Received: from foss.arm.com ([217.140.101.70]:42254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390781AbfEXMxe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 08:53:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4745DA78;
        Fri, 24 May 2019 05:53:33 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E34EA3F703;
        Fri, 24 May 2019 05:53:31 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com
Subject: [PATCH 1/2] arm64: insn: Fix ldadd instruction encoding
Date:   Fri, 24 May 2019 13:52:19 +0100
Message-Id: <20190524125220.25463-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC 8.1.0 reports that the ldadd instruction encoding, recently added to
insn.c, doesn't match the mask and couldn't possibly be identified:

 linux/arch/arm64/include/asm/insn.h: In function 'aarch64_insn_is_ldadd':
 linux/arch/arm64/include/asm/insn.h:280:257: warning: bitwise comparison always evaluates to false [-Wtautological-compare]

Bits [31:30] normally encode the size of the instruction (1 to 8 bytes)
and the current instruction value only encodes the 4- and 8-byte
variants. At the moment only the BPF JIT needs this instruction, and
doesn't require the 1- and 2-byte variants, but to be consistent with
our other ldr and str instruction encodings, clear the size field in the
insn value.

Fixes: 34b8ab091f9ef57a ("bpf, arm64: use more scalable stadd over ldxr / stxr loop in xadd")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
Strictly speaking, to be consistent with the ldr/str instructions we
would also check the Acquire/Release bit to filter out the acquire
release variants. I'm not sure if that matters, I think taking them in
is harmless.
---
 arch/arm64/include/asm/insn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index ec894de0ed4e..f71b84d9f294 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -277,7 +277,7 @@ __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
 __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
-__AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0xB8200000)
+__AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
-- 
2.21.0

