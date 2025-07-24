Return-Path: <bpf+bounces-64306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02BEB11395
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D6A3A52A3
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9A22A808;
	Thu, 24 Jul 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FJUetJB8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB8237194
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395013; cv=none; b=eLyT6r9ELzYLFDHgijBEqEao1Itvys3GXd6/F4SjAobJS1xL1gUO8lEs4ChH9co8XXhMSTHAC0oOMfK8g+WNHULTNIvrB8MRpLr1UzEbmekC67EBBy5S4jDIimIoKd7QyYrabaC7WQ89BiapVQk0TuQ2NrvUrjfQo0MWiHTd7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395013; c=relaxed/simple;
	bh=UdytL1FJTf9FaEisCwAkzanpYRlTkzs24z/QVlmQXW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E+xiTnBS4uQVEcxyzW61ue0B59wjMCASBNUwEWuXzdTmLCU0qrxY2QGpoIwHarbxUE6FzuZo1cFPDB6R7S0Sz5wwM6cVbn4i8mAz0IrBRdITYwWgzg4R4NBJA+W6+PONAj0NBSf/badoj57bykIzckJMpblV4UN5PBU9MUb4wD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FJUetJB8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so839299f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753395010; x=1753999810; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQn8Lgb6ASas/h9P+50eo8xeiLL6WELb3IiOBUGM25U=;
        b=FJUetJB8N3mH8L0DQhLsutp1Gy+jPQ/lfcO5Eu7eSp/om6498DACfuAhx5zbZbNSGW
         JXMRR+Csllq9xeEyC8bQvxFH483jQ9tr9KTnyRjQEkTLYNtV2SsY8Y37aSYI3t8yW4jI
         Uu2Lgo3fRieOs46D7Q+Y/UwX8HqhpmLr+3x4KQ2Ee1eXUzXZMyNQdx7sM0sQwLuEkfwN
         S8DlNqDQKWZ/TPJDjDMxlz4XzZiO7XwfwH+oiv5T3Ce7Mrz/70Z/YQShibzcVOxTmM4h
         zbn6vpHBGz8YeaU+3MeUEQ9xg1MLJMU6GKboNQnpGpwcmJT0pBOddWe7JmT0tT1Vcngp
         j51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395010; x=1753999810;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQn8Lgb6ASas/h9P+50eo8xeiLL6WELb3IiOBUGM25U=;
        b=fh4MS/EAwIsMyeYhogDZ5nsXchfQSds6mbkFamJf7lI4RHyF5qOA0GMDnZaEAeTNNH
         E3j+AUB62mvt6sNnb+QhHCDFB8VHGKCxSBIohPC2FAGSKVgEXSBLk0w5B4+XyIm81+t9
         wFY07fpTsg03N+mqSr/ZrlRo8OjJiXkmOp939DaN6pFBk5kAlEoHirxaLaR0PC7Yji86
         Xy4l5Ql+NBDRzKg3DZNTifW6TASs7IRsogTkh5X1z7k73eylpwfEXVjwaE7kznaK+Xqh
         Cqar9bZuVVtioa0+kSb1E5pUBxerrhC2TV/nHktzgl408rhyrubaEDsm9stVLM1OZmo7
         fS6g==
X-Gm-Message-State: AOJu0YwumHQroTbQVyP1zPg2hUste7k0k1AbfzZje4hDV9P7xh0KrFSI
	9ThADPJI2M5apVnW78ACrgiyahiLH//+f5zjl6anYZNcLOGLxAcMIUbreoknrWlF5Jo=
X-Gm-Gg: ASbGncsmtr881vkehwzdntVW5pvHfSZJYz21zIbjv/zQGsONzei7oMRQ/Y+nYhwbp2R
	J5BaBVfhjn5nNC5lpN9QK6WhFvHazPrPoLbH+inkACNSHEjSIgrUpzST6kQVAFgBp6UCL+LI3Kh
	sWqG6Ad4s9ORvgj+asA3IB6edXyCw+mUte8xX728Vf+WI1gsd+4VoeHzA2VQwpdw9O0WoaxaY45
	Bur3aSA6W2QpD4jmc3htCkslJFCj6GYOwafbyo567VlXolGf3lT8G+MRyB9iIDVTYj9ROSl63sK
	XM/K1cSSfjQy7u2gMk1KEWlbf+7lbnBUQiSgXQ7c2rELn+tk+FOpBeGss7TO2zLHECjukcgYRlv
	kPpQFX9zqOQ==
X-Google-Smtp-Source: AGHT+IG4su4wyL8UbjfJS52FAtE34nXae6Z1/n7g4NnbDSzlRT3NDv3SYUXlGMG0qhso7NqgFWHkHg==
X-Received: by 2002:a5d:5f89:0:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3b768f1ab75mr7320147f8f.33.1753395010192;
        Thu, 24 Jul 2025 15:10:10 -0700 (PDT)
Received: from localhost ([177.45.162.214])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3f6c1177e9sm2012118a12.57.2025.07.24.15.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 15:10:09 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 24 Jul 2025 19:09:48 -0300
Subject: [PATCH] selftests/bpf: Install test modules into $INSTALL_PATH
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-bpf-next_for-next-v1-1-109f8d291080@suse.com>
X-B4-Tracking: v=1; b=H4sIACuvgmgC/zXMwQqDMBCE4VeRPbtUo8XSV5FSkjjRvUTZSBHEd
 28UvM1/mG+nBBUkehc7KX6SZI456rIgP9k4gmXITaYyz6ozLbslcMS2fsOs1+BQD2jQOnj/ovx
 bFEG2y+w/uZ1NYKc2+umUbuBxA3Qcf5CYGj6HAAAA
X-Change-ID: 20250724-bpf-next_for-next-f1de3e4becc8
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=rbm@suse.com;
 h=from:subject:message-id; bh=UdytL1FJTf9FaEisCwAkzanpYRlTkzs24z/QVlmQXW8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBogq8+XZdcMwhu+5M4LUywbP0HD/mlYec09Cjpr
 1977BFOpw+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaIKvPgAKCRDJC4p8Y4ZY
 pkGTD/4gZwZP0wf+mk7BXAxuzPyQna14XOcPfq+t82xaXJDRViY9f9Bow2n8yVv0m4KjSsEr4hm
 nVWc6BP+0c/+WU92QVeTLL54Gcvcoc5Lh4gB1lRS7RUYVhN/787J6pJt8ta5MgtKDIfiuyoU3sU
 PiEWdC8nEXft/Mcvw+ErgctUWdsqAOdf3gNBdDsv8TZUrYXvtaVtcHGa2uKz8HuU/7/H9FLxu1y
 D3NFXtvOPSaIbjV+H8VPxP+c8rrE7gu+R+Y8P+AeNjQsoHd8R6Su8FliYUKyCPryUVLu9qQ6ovk
 Ye0zTlWyFNKXncKzokiBjlISwe47ypCCYTqru2lyXg7nBpJhT7XKDLYNLTWEHFiXiTsGS4JSwJO
 Lgl1rm3U9QVeMxo6P6e4NGrdFfZV3HC5iSas9iPA8pAlAVX/fuJFDtEGixP+u5yJ0YwSXucjGI7
 tLV1cnH1Mw/uqd2bYrUgiCNmS6v0V5zaI/GmM9s7bQi+jQcvDHVuQ9/kGiBWjOpbtcSp2IMfyoE
 CzcSNdxkkCpjZoHKUzEbNjI5wChyt2GQ2Kz1hD37rtOCtcPXv8Ik8gsbpUYa+RfQPfWxlZMVPEe
 bTRr/r+kVrYc+NT4vZAnJv0lWQkMlim3pwscViYkz3EGNWCHBQD7S935J12/PgYtwFnd/bHNL72
 FxHyRKqOigFoOcQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

The tests expect the modules to be in the same working directory, but when
using a different $INSTALL_PATH they are not copied over.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 # cd tools/testing/selftests/kselftest_install && ./run_kselftest.sh -t bpf:test_verifier
TAP version 13
1..1
 # timeout set to 0
 # selftests: bpf: test_verifier
 # Can't find bpf_testmod.ko kernel module: -2
not ok 1 selftests: bpf: test_verifier # exit=1
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034dfbcd35f830432322f054d897bb406..56b0565af8a76a9e784836a836935dd22e814fc0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -877,5 +877,7 @@ override define INSTALL_RULE
 	@for DIR in $(TEST_INST_SUBDIRS); do		  \
 		mkdir -p $(INSTALL_PATH)/$$DIR;   \
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+		rsync -a $(OUTPUT)/$$DIR/*.ko $(INSTALL_PATH)/$$DIR;\
+		rsync -a $(OUTPUT)/*.ko $(INSTALL_PATH);\
 	done
 endef

---
base-commit: f227e9ed4fe4f2fed40e4725d6c10860d30c2ea2
change-id: 20250724-bpf-next_for-next-f1de3e4becc8

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


