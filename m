Return-Path: <bpf+bounces-62840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF2AFF4AE
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABB13B3B69
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84A2243954;
	Wed,  9 Jul 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIuo9yY3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41502192EE
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100047; cv=none; b=hLG+VST+7H1zqCwFwWLMjj5+75bWiDUIjvxrJmzoLXcOsH8QAzFhgTglx3PqkQNWEp4WSh90u0VIiR27BzPmVB0cD2HsKJqLZtlGk+A0GqJxY+k9EK7l+/M7Asbq8nVJY+s0uzXV0zZj4Bo4wbVrTl1OQJfmtQj0/xGGlnl8Sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100047; c=relaxed/simple;
	bh=bztqHnKzwxWldAgxfchev1H0ftv+W+htjlaWR8a6R9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoNMjmYt3ytsAgJFOe0ifvqNEEZa8+DLLudLJ7Xqrv4vWpeC4c0Tybkcb/Ap9gtjKdA72HIzLfiurL17z9QbdaL7PvukbDH9COrJ2Dg37W5q+SsflLEvNJUcOdowy070p/+nDmTXAMqtQ+q25wKpUZ51UR5iol1ObpjLyjw65Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIuo9yY3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so293198f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100044; x=1752704844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxWJZ65v0/e+PK0Cbc7GeVA8XdAlhQ/j+sMYGg/5pnA=;
        b=KIuo9yY3Ag68g2ITADEg2t7nocCuj5JAVj4kIp9x+46T2XCDKsUb6lYQ8WXZwPY1GH
         pXu2P3Tp4qVPEzP0WQdwOrnD1n5eHp+Nfznu9IxAG+/T/DxTLS0RjeeGdc+wPwGk21XY
         CYZepKN+IHdS8WcUoSrYeNT2B12fntXmIfuugha2k+qgPPxDi9W+9niDf1Ehdf9xwuBk
         QMu4rZjVA3LTu2VbaG+vm6azN2RFU/DMcLC5W6SQ9DxGlFxjUk0L2YZvzA/NXMiAwynH
         Af+LPChfaxBbLN+MQXUZhtgFOM/iuxxcWJEGC/nnQWLj8NGFIW16B98UBkSjscVxsLRY
         ehtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100044; x=1752704844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxWJZ65v0/e+PK0Cbc7GeVA8XdAlhQ/j+sMYGg/5pnA=;
        b=JXCHGcZkE0nvd8bEhguI4hiISQSrVo4kaRatMBJ9f1lP0LgMfYy178FNLccxL0cLea
         1SfyzP9iv+WrGkZGEWwDyTFClBhU/O8bIDEcnP7KAlf6oPl+IjACdWGKyRO3JX0CStvp
         IJ6zrafrOp20e3k/oty6dXP0UZU/h1uxzq23+VLwZVHZ2kCfcQuO9W5H/mtplz1hcp9+
         TGlFvC018gdubW4NyCgIxd394TB9m2EmTPJrwhzObyB4ES12a0XD7QWtw22bfcVDAt5U
         4R2pXuv1cmZPmohSjlb5k6731Aj0hCHQbd/nmjcBn68qfJFeR+ZYTKuu4Taq1+Ktydof
         SyLg==
X-Gm-Message-State: AOJu0Yw52QRSxcfU3UwV7bgJFw83N9xfWavRyTtKt8vVDHHJKpPtJHGs
	SQecnSJoEoBHjuTokV5k0hWuHvCBxcgW6bl4ub9w32IJCkj6r1JxyDFoJa4Hng==
X-Gm-Gg: ASbGncu2vt3aKb8mtUoPkr/rZYJnhelmc9QiTFBwhouDpzIz/DZY2Cx2B6zRo/9rPww
	nHQZCBgnBzBoWOCTETBwbyneGCwqivD4zrQFg1/SCAEl/V3uzfbUN2XH4orY5+hWtBazWfy9A0V
	/NWehGWVUoxAL/Hv25XYyvCJtZRWEjViUtYrdUWcGSnmlHnXzPLYNuK5Oy4P4d2/H8B/ZJvOjbl
	IiqmO16srgNKM+7/XiW4KHkcBy+1Yftqys/62jIQlsa6L5vD1C4TW4KXC0rYx6saFTNJ33nwUvb
	K+yN9MXSOPdJQA/gYed+gEQfkjr3ZwfZnNRYWcrDmuNb/oZmTv8fZFr8m4WyCoyKXrrucmkfYvZ
	o/eQ7IdGMPwwS28O3hor9kTslgqLI5BcSg9KMnmdhIqAtealag9Tk8Ft4RQU=
X-Google-Smtp-Source: AGHT+IEmCyF4cWOwDdYi2+Wai8mrJcFNDOLSePYI3c48ogP3YBLZEnnd13jgwd+zO6Wzp3oJXXJi4Q==
X-Received: by 2002:a5d:5f51:0:b0:3b5:e6bf:f86b with SMTP id ffacd0b85a97d-3b5e7f11908mr1047101f8f.11.1752100043831;
        Wed, 09 Jul 2025 15:27:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f9b02e2208aa1971.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f9b0:2e22:8aa:1971])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b5250sm1112215e9.18.2025.07.09.15.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:27:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 00:27:21 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Range analysis test case for JSET
Message-ID: <9e72d9b0e793c85362c86727911e36a087fe3044.1752099022.git.paul.chaignon@gmail.com>
References: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>

This patch adds coverage for the warning detected by syzkaller and fixed
in the previous patch. Without the previous patch, this test fails with:

  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds
  violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0]
  var_off=(0x0, 0x0)(1)

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 6f986ae5085e..2232bce1bdce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2,6 +2,7 @@
 /* Converted from tools/testing/selftests/bpf/verifier/bounds.c */
 
 #include <linux/bpf.h>
+#include <../../../include/linux/filter.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -1532,4 +1533,22 @@ __naked void sub32_partial_overflow(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead branch on jset, does not result in invariants violation error")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_range_analysis(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_netns_cookie];				\
+	if r0 == 0 goto l0_%=;					\
+	.8byte %[jset]; /* if r0 & 0xffffffff goto +0 */	\
+l0_%=:	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_netns_cookie),
+	  __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 0xffffffff, 0))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


