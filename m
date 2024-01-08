Return-Path: <bpf+bounces-19186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C3C826FCB
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986221C216D1
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82444C7F;
	Mon,  8 Jan 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw+FdnZs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB94438E
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd33336b32so22536391fa.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720516; x=1705325316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svOhLEBQw6ySn+JyuvVFhHT4ff1lI5RHm+bZAAT+5+M=;
        b=Aw+FdnZsna9+eBjktc7BDolowIVVyVA6bjn7CC5x2GlTxq9ipQqeVbcp34+Fhxrd93
         WDiwpqe9BThQVdCqumnhAtAQzztNJhwdtPi3mSdHROmSwvhCB9lJiavGsjuArIXSUsWK
         ApGGemDtNRo7ZruUYFKgMYroxMoUBiFArdWjOCHHD+Rp+TG3x26OGQ3UsPrln6KFLh/k
         Nj52E1zDeuuzM1MbXeRtID//7zMHAckm0Qb9gCN95HLoyE0z5oOR1vOHq1XqZeZFHjNe
         R3MKvyohQRJ5mk3Ax/XTsnh0PbSj2qmXE9aYGBcmcgvjWvNys90MImLZh3uYVc4wt2Ms
         cwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720516; x=1705325316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svOhLEBQw6ySn+JyuvVFhHT4ff1lI5RHm+bZAAT+5+M=;
        b=J5yefNQo7FVCmAMOxpRjnT9JdpGjKbMy+kQhKre8clOuxjBn/GFJtcKVT2RTdy69u6
         mSjydmElmmKfqIXPhxssTAO2RuNWz8Nl3tRC6MfZwpzJN00M9gAaaDnB5krTZYT2l8yn
         qB4KLpOvNAifh1/f8HvsSGWPfW1L1T4Kb+++4ctm5NE36JUZK+9+aRLIsyqbvXRoUXsl
         pV+TGxOvFWymWGeKL0Oq5pgYpfPRuFJa9ugTGMYCFPriAQ3srHfSip6iHWIhTD3sLsKj
         /InWnl8i2rSVTTChKL0vlqxR5c78KeNrsKJl7S2Z4laG2LxKqVcYWJwFNt+AYObWGFag
         jB5A==
X-Gm-Message-State: AOJu0Yz4RgiKfKcDfiy9JwHoQ6U4oruZ323/AdCsI3EowcAOIXFicWa7
	cLmj7NKH/8oEFpqBca3xovdUDgTElzs=
X-Google-Smtp-Source: AGHT+IE7DvlBwND6leoOmmU9j678tYl60HqN6p5fd8a5bP92o8c95aMZbffUE4CtBcdxzF/mkhTpqA==
X-Received: by 2002:a2e:9e46:0:b0:2cd:304f:8959 with SMTP id g6-20020a2e9e46000000b002cd304f8959mr1474114ljk.29.1704720516067;
        Mon, 08 Jan 2024 05:28:36 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a2ebe03000000b002cd3e2fc054sm1171458ljq.57.2024.01.08.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:28:35 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zenczykowski@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!= pkt_end' comparisons
Date: Mon,  8 Jan 2024 15:28:01 +0200
Message-ID: <20240108132802.6103-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108132802.6103-1-eddyz87@gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend try_match_pkt_pointers() to handle == and != operations.
For instruction:

      .--------------- pointer to packet with some range R
      |     .--------- pointer to packet end
      v     v
  if rA == rB goto ...

It is valid to infer that R bytes are available in packet.
This change should allow verification of BPF generated for
C code like below:

  if (data + 42 != data_end) { ... }

Suggested-by: Maciej Żenczykowski <zenczykowski@gmail.com>
Link: https://lore.kernel.org/bpf/CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 918e6a7912e2..b229ba0ad114 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14677,6 +14677,7 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 				   struct bpf_verifier_state *this_branch,
 				   struct bpf_verifier_state *other_branch)
 {
+	struct bpf_verifier_state *eq_branch;
 	int opcode = BPF_OP(insn->code);
 	int dst_regno = insn->dst_reg;
 
@@ -14713,6 +14714,13 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 		find_good_pkt_pointers(other_branch, dst_reg, dst_reg->type, opcode == BPF_JLT);
 		mark_pkt_end(this_branch, dst_regno, opcode == BPF_JLE);
 		break;
+	case BPF_JEQ:
+	case BPF_JNE:
+		/* pkt_data ==/!= pkt_end, pkt_meta ==/!= pkt_data */
+		eq_branch = opcode == BPF_JEQ ? other_branch : this_branch;
+		find_good_pkt_pointers(eq_branch, dst_reg, dst_reg->type, true);
+		mark_pkt_end(eq_branch, dst_regno, false);
+		break;
 	default:
 		return false;
 	}
-- 
2.43.0


