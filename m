Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8E29741
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfEXLfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 07:35:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391023AbfEXLfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 07:35:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so1293194wru.11
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=US70ctyVgh5ZhQm+sb5H0syPlHMSWIxsmSGMyVGS7A4=;
        b=DCMLT0OnZhC/2CUSus39g+KAPeTFz3iJrPAgE0ZEDBMoeUp1MHxaJMSVgc3YUvtSNZ
         jYwCbKnnEPUUw9c7vJktB5hIq3P+D/aBYoNiMqwclfSoiGuS4QXCkNR1tJgEbuTNdFc2
         eCLy+OLHs2kPQVJaq6FgpRLC5kZ8Dj2ql6SMZJIuqwRe2WVeYzIkI2SrtQVTAAGsFc4n
         Ww1kjU5oJqNx2FpDktajoICJ8dOZRguS8yF4ZUnXs5qApPj/CkRHfD2L2F8BBlO5lecj
         UBYxfs1Sl/mC5zRHOTGI5ai0eLuLe89+AbHRrWZPcPSHEWoCVQcZyODNuvsker/SdZgt
         TS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=US70ctyVgh5ZhQm+sb5H0syPlHMSWIxsmSGMyVGS7A4=;
        b=cgfXfyx6F+sqcHitPy3goacCmk7bZ3f+TtZgLGtSyZwCnfuMa0l/DqCTl1BX7Otk1p
         bpHvSPNAO9/RyPOM+mA/p119QsR6ejmXCP43bfivH84xyP/bbFSFZQGEEQsdmep39BBH
         qervKaInF82IhBBzKmUu81d5UuwzZw2sTiiKP2c6nHNg/PjFt9Ve2sf3P2CKB2455/z5
         xX0keRolzFCHGzjrHd/lMcmzOY08BRaTZQeWV+UW/12kOFXk3aSaX4Ow0DPwXBENpdae
         bFP+eYqfGiz02MLuHQ7PIrk76jEQjktpO+bs/u2rghWV9WhCzPS5sKnlBEISrfqpZbcx
         W/6A==
X-Gm-Message-State: APjAAAWYBIzHdM8NHUjDuOFLK31WZV/lJ8xm3iZDIlKeWqES7kj0OZfE
        3bJLBAWttOQw++zIncHS+RSgWA==
X-Google-Smtp-Source: APXvYqy+NWeBxetm6DfuBSCSjNK0bZu2zo/VzE1vHt6oqvOqm3TXtjDfpVUfS712R2WkNc0hyOG31Q==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr2147372wrq.115.1558697749586;
        Fri, 24 May 2019 04:35:49 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id x22sm2462902wmi.4.2019.05.24.04.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 04:35:48 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v8 bpf-next 03/16] bpf: introduce new mov32 variant for doing explicit zero extension
Date:   Fri, 24 May 2019 12:35:13 +0100
Message-Id: <1558697726-4058-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
References: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The encoding for this new variant is based on BPF_X format. "imm" field was
0 only, now it could be 1 which means doing zero extension unconditionally

  .code = BPF_ALU | BPF_MOV | BPF_X
  .dst_reg = DST
  .src_reg = SRC
  .imm  = 1

We use this new form for doing zero extension for which verifier will
guarantee SRC == DST.

Implications on JIT back-ends when doing code-gen for
BPF_ALU | BPF_MOV | BPF_X:
  1. No change if hardware already does zero extension unconditionally for
     sub-register write.
  2. Otherwise, when seeing imm == 1, just generate insns to clear high
     32-bit. No need to generate insns for the move because when imm == 1,
     dst_reg is the same as src_reg at the moment.

Interpreter doesn't need change as well. It is doing unconditionally zero
extension for mov32 already.

One helper macro BPF_ZEXT_REG is added to help creating zero extension
insn using this new mov32 variant.

One helper function insn_is_zext is added for checking one insn is an
zero extension on dst. This will be widely used by a few JIT back-ends in
later patches in this set.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/filter.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7148bab..bb10ffb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -160,6 +160,20 @@ struct ctl_table_header;
 		.off   = 0,					\
 		.imm   = IMM })
 
+/* Special form of mov32, used for doing explicit zero extension on dst. */
+#define BPF_ZEXT_REG(DST)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = DST,					\
+		.off   = 0,					\
+		.imm   = 1 })
+
+static inline bool insn_is_zext(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU | BPF_MOV | BPF_X) && insn->imm == 1;
+}
+
 /* BPF_LD_IMM64 macro encodes single 'load 64-bit immediate' insn */
 #define BPF_LD_IMM64(DST, IMM)					\
 	BPF_LD_IMM64_RAW(DST, 0, IMM)
-- 
2.7.4

