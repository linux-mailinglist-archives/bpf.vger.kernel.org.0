Return-Path: <bpf+bounces-33105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3C91725B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6651C22E61
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9D17D88E;
	Tue, 25 Jun 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8eWRLQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DA17D36A
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346598; cv=none; b=Kvu84uFco0GnX0QLIn0ONx5JmaEn/cTelIeU8CB7MXaiyWL1mgigQmcHGnqMS9WyqXbF7sL4QeLTCj91UmEWH3L5JAJOg3gTegIcQBKWJBhiqzbg9DNAhK32zRkN5G8L0A5/7hJFSLKCgGGLS94iIbimDPGpQMC2SXIYT8M4swY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346598; c=relaxed/simple;
	bh=Cn54epZbJlIdkBAEP0bQCfn9wQ5cD6vtUa9+7LXtTUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le5dqOukhzYfzbr9j1olD1u6cuqIqWBFf8wJ2l+NSozU5JHgvbrrAZqdNQtzZ4P0BPInuIWfyUKIuj7LwaTghNpbg9j5Wb6eq8yaA4GRsgUmSCVr+cFxeX/mHzI7d2ENCAc6v0t+LFnPMl3GVGc6sw9q2b/Yp7bO7ZRsiqfzFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8eWRLQr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9d9b57b90so40169675ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719346596; x=1719951396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6v+EQ83tVKtdmqeCNbPaOqAIYZtdL+e1dSkEgpgu3w=;
        b=W8eWRLQrcW8DKw11pZveba+JtQl8HbQTYqzA04tA9vuUKc1vkDRVo3sG3E+gfa/Bfy
         vm7TGWx6PVvpvrKivsuPPm1NEsytnetunVP9B+Mx5nGCRnGy+NRo+8rT/ktRiopLUUCp
         abUCiZ3QFp3BJVqyIlAehvFx7e4LaDJ1z2t6V7BRudoYRLQV4WUia3AJc5Jav2q4xyYf
         rlSm3SUiAnU0HvXC0QWOuUQ4XFQHelS7BCb4VIf+8RHwjTiW+MGSWSEf8TzuXhYh1uzz
         SwVIyGcSOM8wCUcAYbgzaqepZlCtZhx/61EzJ0kRNEEriCtQ49/qRrwDTs91ipaNTxV6
         cA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346596; x=1719951396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6v+EQ83tVKtdmqeCNbPaOqAIYZtdL+e1dSkEgpgu3w=;
        b=Il4EwFzUDcCdsgXalxzk3hho6dc5k3KU6mOCw7eFYIe0GZ/15h0ELwgCASpKEsyY+x
         wDGc1fgdNITlA/XTEeDOQr0drcDZcQlCsWsLWNJXbSoxs5fQ/4wMddIzJ5R+YY0l4OCK
         KgX51a5ex1x1nN/J97e19IUjJ7XV1zjXKNP5W9t2wO6tTiisOWmB1e4PkVaiwG+4hnUv
         v5ysd2yM1iir/goGAxv82EV/7/+bU0D76katXSLZHxUi3ntbv8QPuxAtsXrVIaDRfW4z
         HFZS7wj9QOzNZOCAaqvLnFjn0HpF/4+Gq8V0QC0qtgDwmTEiiN9WkEulWT1vw5yKOntC
         0MHQ==
X-Gm-Message-State: AOJu0Yz7uV7KN3MgEkma/1C/OXgCU17CGpW9iPWotCvJ/KkCE3m+NQb0
	ZiHae3Hl8VM+UUqxtf+U4YA5Xgo+GPXSZfUzgwg1+ioOuXLKk05esULHXQ==
X-Google-Smtp-Source: AGHT+IFSrTOC/eIY2i70Nevc1GaCFzmrx/kV1gNcwCDjjl9uuPNcls5onvDh2RHng2zrszXFeY+C8g==
X-Received: by 2002:a17:902:d4cc:b0:1f7:3332:65bf with SMTP id d9443c01a7336-1fa23ec2d20mr121285115ad.16.1719346595812;
        Tue, 25 Jun 2024 13:16:35 -0700 (PDT)
Received: from john.. ([98.97.39.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebabc13fsm85600725ad.250.2024.06.25.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 13:16:35 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	vincent.whitchurch@datadoghq.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com
Subject: [PATCH bpf 2/2] bpf: sockmap, add test for ingress through strparser
Date: Tue, 25 Jun 2024 13:16:32 -0700
Message-Id: <20240625201632.49024-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240625201632.49024-1-john.fastabend@gmail.com>
References: <20240625201632.49024-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an option to always return SK_PASS in the verdict callback
instead of redirecting the skb.  This allows testing cases
which are not covered by the test program as of now.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 9cba4ec844a5..cc3e4d96c8ac 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -78,6 +78,7 @@ int txmsg_end_push;
 int txmsg_start_pop;
 int txmsg_pop;
 int txmsg_ingress;
+int txmsg_pass_skb;
 int txmsg_redir_skb;
 int txmsg_ktls_skb;
 int txmsg_ktls_skb_drop;
@@ -108,6 +109,7 @@ static const struct option long_options[] = {
 	{"txmsg_start_pop",  required_argument,	NULL, 'w'},
 	{"txmsg_pop",	     required_argument,	NULL, 'x'},
 	{"txmsg_ingress", no_argument,		&txmsg_ingress, 1 },
+	{"txmsg_pass_skb", no_argument,		&txmsg_pass_skb, 1 },
 	{"txmsg_redir_skb", no_argument,	&txmsg_redir_skb, 1 },
 	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
@@ -177,6 +179,7 @@ static void test_reset(void)
 	txmsg_pass = txmsg_drop = txmsg_redir = 0;
 	txmsg_apply = txmsg_cork = 0;
 	txmsg_ingress = txmsg_redir_skb = 0;
+	txmsg_pass_skb = 0;
 	txmsg_ktls_skb = txmsg_ktls_skb_drop = txmsg_ktls_skb_redir = 0;
 	txmsg_omit_skb_parser = 0;
 	skb_use_parser = 0;
@@ -956,6 +959,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 {
 	int i, key, next_key, err, zero = 0;
 	struct bpf_program *tx_prog;
+	struct bpf_program *skb_verdict_prog;
 
 	/* If base test skip BPF setup */
 	if (test == BASE || test == BASE_SENDPAGE)
@@ -972,7 +976,12 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		}
 	}
 
-	links[1] = bpf_program__attach_sockmap(progs[1], map_fd[0]);
+	if (txmsg_pass_skb)
+		skb_verdict_prog = progs[2];
+	else
+		skb_verdict_prog = progs[1];
+
+	links[1] = bpf_program__attach_sockmap(skb_verdict_prog, map_fd[0]);
 	if (!links[1]) {
 		fprintf(stderr, "ERROR: bpf_program__attach_sockmap (sockmap): (%s)\n",
 			strerror(errno));
@@ -1361,6 +1370,8 @@ static void test_options(char *options)
 	}
 	if (txmsg_ingress)
 		append_str(options, "ingress,", OPTSTRING);
+	if (txmsg_pass_skb)
+		append_str(options, "pass_skb,", OPTSTRING);
 	if (txmsg_redir_skb)
 		append_str(options, "redir_skb,", OPTSTRING);
 	if (txmsg_ktls_skb)
-- 
2.33.0


