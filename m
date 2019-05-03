Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2412BB2
	for <lists+bpf@lfdr.de>; Fri,  3 May 2019 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfECKn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 May 2019 06:43:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39272 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfECKn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 May 2019 06:43:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so7255335wrp.6
        for <bpf@vger.kernel.org>; Fri, 03 May 2019 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HU+XJURX+8gtKclVt6Ec6skvPc1Pkhc0cIYSbM/6vbA=;
        b=fRdx0czfVcJxvB2gIvOCStJVxS67PoTg91xuQlYyBckvBX18vpyGBwBZ3Q2Actzft9
         ChopHPQyueqV/t4hNsQk/6+rRHngHXxTl5xTxj8LvXAJx2fWZHy4+lOLIRFWNKdoVuE+
         +2TfnRK+TBJFU38KEsHsBVdbNWQBAko3MAHyvtHXNxqoqOMxyiYw6vuCIcetSQFsmR+b
         bP9sJ64UbNcLjsqcsvGo4DjLQuze6X29kVFs36eEl3TlDWN8QSbOmwuCIUt/FDrD9hVV
         7hTC7ndWNvtticzqMgJYRb/HGA7glFeLtrHD6wBaKO+0IMUoHxrmdR53k/HN0YCximWm
         176A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HU+XJURX+8gtKclVt6Ec6skvPc1Pkhc0cIYSbM/6vbA=;
        b=t/OE8sYlyNqCa8AJvhBsAuRJz7omQ0rxGfQ9sT0FXMIKHGiPEoREpelieMs2EZFzYD
         Kx5ENSyi1RjsYXn7QSuSOHrlO4+aNFLLnmiZTvjUTmAEZwHr0WXIa2xmSQvOEHbq9c6s
         vYTOpqKaUyW0WP25N6WdVbv2aUx6jdvk1Zj8neLbXFGroVqbL402sEZUGTsUSAq5r3kZ
         6J3C2K183GzNr9u9RrcE86/wWjdPZcpBgxuMJnyfzF803woBzhEEtmK3YnrIC2EBVEGB
         Vitlp0wRw1jb3lWKlaSWTl9VwFxtERnQBDayRRqC7gRo7n7ZZ0UIX+IULWE0a7jMmSKp
         nozg==
X-Gm-Message-State: APjAAAUBoIGKAEpjuPJRuXROXvosdB7LoXlgZe9aFlyS1u72z+RU8mHu
        FIeiqCcKdYzG5DJ/ecg6/WnsRA==
X-Google-Smtp-Source: APXvYqwBxZloFdoUpSfEvnOWBCiaBQk2oLSm0bHBCEIEU9v7oS+ou3mgMDolY+DiyFQwhEJ0QnWiuQ==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr6704471wrv.218.1556880236018;
        Fri, 03 May 2019 03:43:56 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id r29sm1716999wra.56.2019.05.03.03.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 03:43:55 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v6 bpf-next 12/17] powerpc: bpf: eliminate zero extension code-gen
Date:   Fri,  3 May 2019 11:42:39 +0100
Message-Id: <1556880164-10689-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
References: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
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
index 21a1dcd..9fef73dc 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -557,9 +557,15 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				goto bpf_alu32_trunc;
 			break;
 
+		/*
+		 * ZEXT
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

