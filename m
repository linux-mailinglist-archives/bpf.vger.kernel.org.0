Return-Path: <bpf+bounces-55666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02FBA84A98
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A3117E24B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB511DF73C;
	Thu, 10 Apr 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfFY7bWM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147E20ED
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304428; cv=none; b=YnhSyJ9nBTJZtWPWqR+nK/bMLHPOuGWcAdTJ8homUwWclW1dSgldfBbznK74nhih6Khse7Z9CzDRMUxqrn/YnnJkR2LTdONyH/gv9HdTAbVz9+hOREWqojiFpFmsTxrKeDeRTrcipJsd6HSm0PJ9TOthsiK3I4jcd+TAOqVn0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304428; c=relaxed/simple;
	bh=hlhXc3jpPXfrKskJI5rTOWHizAatSykMHdLV/l3qzQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXwEMqMAxv2e5gQZvusit6hxpSbu4s4NcXtX+8hQwgLx0018HkJZn1XlmWs/47Ls8u8dMDcqPEvezOO+mWnHb5m/BYtuOkQzr61VWcMn2tl0iai6H1OS4j0eQ7z6J/akoTY/mN7SA75C1mpM6QkASFoTQqHajLyoxxU5NLaKs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfFY7bWM; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c0dfba946so579676f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744304425; x=1744909225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrhCOfH8oYVp7+T2grMNCbZ666SCDxmsjP5Ly61cdr4=;
        b=BfFY7bWMqYWfG3VygWIfmw6UojW9v93oeCo/UxgAd37wEXcA67Iq5201P1Yp2YaNcd
         Ni8LoGWV107zj028irf5si1LBoqIGIahJk8WR/wAmeYaCswxFJZyhMquWtSW88I47MRm
         0wDA1xkenUMNMMQyqRxAdp3VlwzKfGfRKCjom2acYLBe4AO1nmrzxW0pnsphWUhGbVbj
         LzZgZFdQjQ+R7zF/Nnzxq1zy0QG5Wm9XhGp0AjIrRykvZ5chw4OOUwTwYqpqPhQqyIyl
         kdr3FFn9rIg3ibtQ6q5t6xdzvUoE8rfe5R3id2XoesoQwjC0gel+WascJrXkNqHMeYCo
         lUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304425; x=1744909225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrhCOfH8oYVp7+T2grMNCbZ666SCDxmsjP5Ly61cdr4=;
        b=j7Q+KiUj15q1G7j9yXVYDka2ru+FOBSyO1EXUfU73qUhNpmAGKi46L4b1ceUuHJLoe
         jvBz9Dj1zzwaK/74dcUVaELcR2P3n4wrFR7QZZfqOAuvuMhm7fmIpJdP/MMIud/xW3CN
         HwMXI5HP0hV21aOgM8Ob7fv27/pFj1862dXKss5IzGrhRQ1TArtwtnIBiLscMUAJWn61
         jbUMs7ayHs1sFqJnYqPGQCay8t5DmincUy5hKC+yWzY9g2UcHExzM/EKxh7Bpold/+26
         jZEViX+MF/8sSwVH34rDcwi88P0Slz3FE0aBuPL0FYl5SP0Pk4fAhJfHdnJR+lF0dw+C
         oSsw==
X-Gm-Message-State: AOJu0YzTEPzfFjQi49D3/AmSsUTepkheFvvIjgNbKwkdb+ki2vXdW3AE
	0N4rb2UD9dHEGUIbr0KNTqU2qUjO/wQSvm3JxXCrOvSK41tLePX2OA7ZOhkYobI=
X-Gm-Gg: ASbGncvJj0Zixlo2vBR8lDlVv206nSTRmTg6EZFMyLgIAcgsPO/x1WuWAyso1d6q+Rd
	CJfcMoMjJG4pAowqavsSNX7fIiE7IAyruNdYg6ulIh9YgCw8yRUWbU+OVpAinZ9wknHBz3FJ0Ms
	LHcyCVNZMm5lkCVdor1mWFCUdrm0P7+QalLe72ODGfbs22b47cV4tLPvKhsBD0hQ9VcoGopGP38
	t5HqHKTyMfoKCs40cm50u1FYofiD0eXxTg6NZILV+5VpIIZIU+XalJUAjACYrcyY4PZNvoLcjfC
	5vwTKyUGknxepO74DdB03P+shJ2XYNevNuZlqxy1zA==
X-Google-Smtp-Source: AGHT+IE4MlTrbK5hZw7jPKE8D3dg8HEaM3EBCZ6JSyPLaB8Na5+FJpfkeHR+j6ZOYHISQuDomS++rQ==
X-Received: by 2002:a5d:588b:0:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39d8f496e01mr3297848f8f.28.1744304424446;
        Thu, 10 Apr 2025 10:00:24 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fe28fsm5405076f8f.96.2025.04.10.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:00:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/1] selftests/bpf: Make res_spin_lock AA test condition stronger
Date: Thu, 10 Apr 2025 10:00:23 -0700
Message-ID: <20250410170023.2670683-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; h=from:subject; bh=LwS3v9IwoBVXchs8+NA9XvBRiow2JsY18IvoxSIWhyk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn9/gtFj7lB70ofV3IeZAe1NY5Bs07MkXjaLS7/dK4 1SMqO2yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/f4LQAKCRBM4MiGSL8Rym5jD/ wLDrm7c0LkGtKlXPCRowE47npgGiUr9UhLItSmgLJPbOqP8tq8O0ktgjoQzrhLYJFKKzqMwqFLOwX1 s6htDYJMnOhWpcps9l8xSezUpmhg3i+EjYQ9vYXAtrGuCDio//QfnoiDS++1GSnaqfQt/ZVUE397Tq 54K1DQvPV+tg12vbj6EibeHM1NMehASOK9NE5CEcBJ9Cgszu4Ls2meCKajxmpDjYylFIeMR3DEjT1y al4117BiOEzijU7EUbnTgP/XYQ92iJ6X+R9YQw73CSw3m5QmbDbTJtqcAp2ybp9vdxUyt8mD8j5lfc d6xW3rnDEex5VTmhi4UPb5PyZiv2m88oWqaggS7/oG+cMlUQzEmDwWQ4lEXwAa29HEtTELJc7lfmlP //COxq+Mu3r3++78dqx8Wt6Vv5+Gstv2muhL/QKF+iYEGqWGyFn+NLi9lQ5CIIH0WWw+HiEHHL3JdA dplXfJvjva+iJLDHTUybXljcf8vE3TlZo4xmtLB+g/QYKjRp+K6qkHEXuK1l0UFkTGyKYqJMIDYZmG ZQiUH2YU4mQXgw7aG9fs5q7+Wv7NiQNU0IX/lwNF9jdxijcWXmsQQuL/HGMAv8OhEZxtNzKR+iWCbu RBy8qB1+v+DCksSgCmuARENV7rmFZz7uRO1jeNfqQSY5oAY/WeWLpD8dSNNg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Let's make sure that we see a EDEADLK and ETIMEDOUT whenever checking
for the AA tests (in case of simple AA and AA after exhausting 31
entries).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20250410111637.467198-1-memxor@gmail.com

 * Separate variable assignment from condition test (Alexei)
---
 tools/testing/selftests/bpf/progs/res_spin_lock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock.c b/tools/testing/selftests/bpf/progs/res_spin_lock.c
index b33385dfbd35..22c4fb8b9266 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -38,13 +38,14 @@ int res_spin_lock_test(struct __sk_buff *ctx)
 	r = bpf_res_spin_lock(&elem1->lock);
 	if (r)
 		return r;
-	if (!bpf_res_spin_lock(&elem2->lock)) {
+	r = bpf_res_spin_lock(&elem2->lock);
+	if (!r) {
 		bpf_res_spin_unlock(&elem2->lock);
 		bpf_res_spin_unlock(&elem1->lock);
 		return -1;
 	}
 	bpf_res_spin_unlock(&elem1->lock);
-	return 0;
+	return r != -EDEADLK;
 }

 SEC("tc")
@@ -124,12 +125,15 @@ int res_spin_lock_test_held_lock_max(struct __sk_buff *ctx)
 	/* Trigger AA, after exhausting entries in the held lock table. This
 	 * time, only the timeout can save us, as AA detection won't succeed.
 	 */
-	if (!bpf_res_spin_lock(locks[34])) {
+	ret = bpf_res_spin_lock(locks[34]);
+	if (!ret) {
 		bpf_res_spin_unlock(locks[34]);
 		ret = 1;
 		goto end;
 	}

+	ret = ret != -ETIMEDOUT ? 2 : 0;
+
 end:
 	for (i = i - 1; i >= 0; i--)
 		bpf_res_spin_unlock(locks[i]);
--
2.47.1


