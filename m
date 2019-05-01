Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D71095F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2019 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEAOom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 May 2019 10:44:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfEAOoX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 May 2019 10:44:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so24796354wrq.10
        for <bpf@vger.kernel.org>; Wed, 01 May 2019 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgTpFSyNNSuuA9gXSMlYavP/PQMNAfd6tBhbx53xg9k=;
        b=EiFqgfeT5acF+oM5XLjLRWFLHQH+MlX1bcXe1qtmoC1qIiRJCr36IfQiFGjBBX1NTJ
         4+5e2cGP0MM6tuED5Dl8alCSFm7Yq371KRV0XXw3vDrT9owlmtPjcpHx6aQUXIPko3aF
         ihNxrC3POV3/PdeCHxHlJ759+Gx4we3w+sJAHijth7qkw9qf6+PLIwH9h0Nj85GpYcaU
         +4jGg8grZWlG03s/twteKWNUWsexNqXry/xNykdRk/FkhUjcGAELpPJiZ6QC98/tETd3
         QZdYtsgbtEW5/ZInII1Vx1lJ0bifT1SdxuPE17E/4PuSXnSllj35wdxErVxdF/CHGIbA
         iARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgTpFSyNNSuuA9gXSMlYavP/PQMNAfd6tBhbx53xg9k=;
        b=kHm9UGeTP2t1Q+uloEO+gR0E9oLVgn5vpiTRZ2kEPZhswObxqZQW2IKQFB3ENd+iwq
         pHtqVyi2ELXKeUbbGndsbIo4o/xuhJZNDu84wTqpfm0bOhjRU87s28OmNmf0wS260uHq
         Zt1YCWjUZdGQaVQ+WpiI76Vc5IQ1Senl7ospJ2KodyQTv5Lq++9yNZdJxUVkCgLVJvm3
         0JzScheZkatoKxpGQNlaYl3TUYKMg5Fa1XSbUDME914y6P7Wv2Gd84vVG8MYow9tAKvt
         MaJJhX8t4BLQmEWj9JNG/UOwlmfx8aVhSQ9JV7+lrr11lqKDNrsNnPqYQcQYpIpfuJWp
         L8uw==
X-Gm-Message-State: APjAAAXOzJdqfFuZYrsWoqpJJbmBPvaWUl2T/eajodT/Fd7PDiHftF41
        Bz5lDFrnZOeZ9DT8HrbQ2jDN9A==
X-Google-Smtp-Source: APXvYqwJ7J7IoF/x7199HmYneckyAeBAGR9XAcn9+M1xW8u+Mr7HLh+/WNxoKmD0qSsJskUwcYAzGw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr1736639wrv.253.1556721862535;
        Wed, 01 May 2019 07:44:22 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g10sm36164976wrq.2.2019.05.01.07.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 07:44:21 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v5 bpf-next 12/17] powerpc: bpf: eliminate zero extension code-gen
Date:   Wed,  1 May 2019 15:43:57 +0100
Message-Id: <1556721842-29836-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
References: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 21a1dcd..2266c7c 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -557,9 +557,15 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				goto bpf_alu32_trunc;
 			break;
 
+		/*
+		 * ZEXT, does low 32-bit zero extension unconditionally
+		 */
+		case BPF_ALU | BPF_ZEXT:
+			PPC_RLWINM(dst_reg, dst_reg, 0, 0, 31);
+			break;
 bpf_alu32_trunc:
 		/* Truncate to 32-bits */
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext)
 			PPC_RLWINM(dst_reg, dst_reg, 0, 0, 31);
 		break;
 
@@ -1046,6 +1052,11 @@ struct powerpc64_jit_data {
 	struct codegen_context ctx;
 };
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 proglen;
-- 
2.7.4

