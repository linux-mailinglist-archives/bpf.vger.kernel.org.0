Return-Path: <bpf+bounces-62962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED3B00B3F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E093AFB8E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A32F2C5D;
	Thu, 10 Jul 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZLyrUMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EF27FD5A
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171707; cv=none; b=pnZlivTOqz/XH2DsPRxfEj7nT300NsVb1omo2k9rvP5a8yMO9jLcE98voaXlGtshwxlMFIkieqrmsFKZTm0twh2lEfbMq/rDhVfpwSeR+EppgMSR8kX5Vv8w5ykC0Nwv5Sotw0VZhjGTXd6Z+/Urx2nAiHYkQsFRsjJgFg2DQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171707; c=relaxed/simple;
	bh=uPn6C9iP9/iMGxGQqIzJ50CMvX+RJ65DDMsC5Q9UMyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9ysxB8I6Sz90p0SyWuqPe9NsoXz4PXwAepX1uagVEjzVj+HlIEo09oJh9J0lVMLPW/4DKz3a2h7ImCJsxw1Ru2V0C3W0QEVBAhmlXj7Tsq0HeFWBEA0fN9kLUUpf+phrmzeRMN2W71TsyHR/6JS5cVmXLhLd61kzVN1lb5BvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZLyrUMH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4537deebb01so7535345e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752171703; x=1752776503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/APXZEiRO03TIUpvgjHLQGDTt3mFWBbE6JnPXIv6NoI=;
        b=HZLyrUMHaqhwXA56DrmcOOIY+A1XroiWOKNoZsfmEk3h1GDVm2iS9Fjdosrr9pOO9W
         tVy5IHGawn8RpikJhe/UEcL3m4dPmbKSJqu/LCHe6u0bmJieVdlz3IgKhgBt2n79MmAn
         7cabpV/seQBHt3nHwJds/rVP0s05Sb3CXxyiOmM4XmPE5WRLSJxgvJgerA9vJvHyCj+c
         ERQxVUlcKm2kyoja6mpoSOZxqeTcLmyo3BpzzS8SMD5ok+Ihl4hCS1vcazFoEKqxAeDh
         PVtOMLWTywVyol4oatWIKR2BeAAoyn9IZJKUkX6qfZBSNUXHrDMv52RPSUTKRNjYXtMN
         ccxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171703; x=1752776503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/APXZEiRO03TIUpvgjHLQGDTt3mFWBbE6JnPXIv6NoI=;
        b=quFFkwhCtLBFolH5ZSRIDsQ/NneZbdCqRLESEhyGpN850nucCnf/GJ8EC5VWkmiRIY
         CaMCJwKCIgumTT9+klM67xcVRnHirHcIiiQKjvwF55DmODKYkpJO17Gpw/r9pTDkMfPq
         wJSwSmta9nv0+Vcb83wCaO8A2mrp5h8iEVsGhYeAdyKGw223pLPpm7vYmaffikd3uqxz
         bWZwERugKV/80T3YR15QsVTK1jT0F+iMxBDJLOm+4ypDitmFFQCqNKIH0ya5iir8WgKO
         ev0022CMETpMIbDU+ZfkfU9JXRYwMSEYmoLcCR0rWyfARlDJMzkmQbtC4WMsEmgPFJBN
         gocw==
X-Gm-Message-State: AOJu0YxUuScGbqaP8D5XvQs1iHC5VQWrnlazwfevzyaJ/+shMCVOMxio
	Kt1NmFJ/OVY+HpySNhHUAE2Fv2t7LNtCBD/R/P+JyiEa9Xobn4rIQtJ9djUbmpgu
X-Gm-Gg: ASbGncvl1nClQKbLk15zOXxQc0KCXiEhfsIaVSvlYhRCiIMceo+F1VThzRZ8NZEExrp
	yvrlTCmO1WpvflBn8oM7IikaCV6aWBn68G5csylz06QzrazYsWGeNqprrW1yW3qOq8cJMVcQK4W
	WEVuV5AvwS8xCDdYytDpS/vqeNsGkmwdynpMzZ6PSUze0zGV/0k8zHu+hWwV7DaJfc5B67xwqEg
	JJJ0U9/6MTzH0h8dCx3OelFZ1aW5u/e+qdmH5CL5H4wZ9oxwh1UmWyH9WgJMPfH4B6puujq6epm
	YCfu+w/o2gZmu026PEowy/qR5CxpAsnSohPHX4LUIT+SyyyHQYLupJJVdfkAp+qKRDt16e1K5+f
	FYbTcNBIx6IAr7glw8D7xjUMh1cF5XAjS96vdaqYEJmsZh+ZUqNWDEzHhhfAe2g==
X-Google-Smtp-Source: AGHT+IFA8NYjrRInaAifM+/1A6Bo1ZeHlJh2Pvf543HVg3bj0Uo5HAij10YSpRVTVLhzq+hh2Nja9g==
X-Received: by 2002:a05:600c:4689:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-454dd1c85c4mr45972625e9.4.1752171702947;
        Thu, 10 Jul 2025 11:21:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00939f1ea551223a20.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:939f:1ea5:5122:3a20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b5250sm26190435e9.18.2025.07.10.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:21:42 -0700 (PDT)
Date: Thu, 10 Jul 2025 20:21:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Range analysis test case for
 JSET
Message-ID: <c7893be1170fdbcf64e0200c110cdbd360ce7086.1752171365.git.paul.chaignon@gmail.com>
References: <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>

This patch adds coverage for the warning detected by syzkaller and fixed
in the previous patch. Without the previous patch, this test fails with:

  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds
  violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0]
  var_off=(0x0, 0x0)(1)

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - As suggested by Yonghong, revert use of __imm_insn for the jset
    insn since newer LLVM versions support it.

 .../selftests/bpf/progs/verifier_bounds.c      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 6f986ae5085e..63b533ca4933 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2,6 +2,7 @@
 /* Converted from tools/testing/selftests/bpf/verifier/bounds.c */
 
 #include <linux/bpf.h>
+#include <../../../include/linux/filter.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -1532,4 +1533,21 @@ __naked void sub32_partial_overflow(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead branch on jset, does not result in invariants violation error")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_range_analysis(void)
+{
+	asm volatile ("			\
+	call %[bpf_get_netns_cookie];	\
+	if r0 == 0 goto l0_%=;		\
+	if r0 & 0xffffffff goto +0; 	\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


