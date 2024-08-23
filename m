Return-Path: <bpf+bounces-37914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C103795C2F5
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 03:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116D6B21E3A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EE18026;
	Fri, 23 Aug 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eF7peOQn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D208171C2
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377612; cv=none; b=UKs+YgBvuWO4YF5vX4TYTpZX8KsP0+ueVElrvfZy84uFr/evESszFVvyKDKU4+8Il6jCoYYm4svnXR2qLLN/R3AV/gL3ZNRHTJ/LpEENAtPcslqCUCfOCgPRh3aLSc8LxKZDVV4RoLICKVbkXwqbOibKO1vXLTj8EwIIIb+j+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377612; c=relaxed/simple;
	bh=GE1g0r64qT92If7xW8WdHoAA4djZYeFOynlZtd+eUyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo9jmNN+oYQV0vRC/OVXL6O62ZtyR2i6f163K/Ow2Sfud7LOhqUKSDnauSrRg0XVpZ0z+5tkqO2SW1+YReWjP+xvSKIcaShsQP5EUB60FN5PRw1kvM1plHnkXHzOHIuzzJ2SGbVE5LIeiBQK67vYErrKD3qRsqKCH2zHtQX1Wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eF7peOQn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42808071810so11206425e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 18:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724377609; x=1724982409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYzWq5z7WQYhVMJfatGwNPUU4L/alJEM3TD5Z1W4W28=;
        b=eF7peOQnSdTJxle+KWzXrONmXd7HhuuCPTfV6mxbEDGWesKvQ9sG/Am86oU3u3Yofx
         ROPc2L0myk0fJ6Ku7bEJZVUWwWovIPlYxqmGmfHFPrh+x1+Xw76644XsYFG4599y7ZfW
         xzN0UpVeECqgv2i+FZGBBWr7TfwPbOZ++HXXq1SSjJ2RN2TMdQxTjOnJ6XcsruhLYO1C
         wvQPVenlIqHJntXZKNbvOebSJcguZPsVsY5h8fsNQOdcawoh+dM0PwMZXoJSplNrbfYS
         ZaxxzEX3KiigKDUCXe9M/7Mxk5z4uztnb/jjsVHqYR7qiXh5ADcwZf+iNW1sxYjY6tAR
         dIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724377609; x=1724982409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYzWq5z7WQYhVMJfatGwNPUU4L/alJEM3TD5Z1W4W28=;
        b=bv9BQrl2jmsUEswy6jyxSkiYm39WWi/bok5+2Xcr/brSUVcok7gW7a1PIbrKbf41mE
         bihrw/q0X82ekNfkOFhvCoZh7ayQTve7W/MslJpT+E8oU365WsLecNpLYg/UwoM4w8fI
         8ld3YnB+iQ5kWtDmDkJvNqfXIJ5hvXK9cQXT3Ok66byV9lj8eqG9z4NkzcmbaidHh+zj
         KHqTifmFNH8ix5wD7/yWWS80vy95/TQRpPNagCjbf4xsiWVCwr0/BtSwqVChINUoYdUP
         ffak6yRlfmaBn0KlCGsyU/42hPlQp9cnAGEbfxCIaMEa1P1g3ZGKCqhn5DMxR8bypj/H
         SqOw==
X-Gm-Message-State: AOJu0YzxbrTrqtcmAwEAyiuopOZqklS9GtiD9VWW5+oPdgds9VybTDuA
	jy0GsW2SNPeTT2sgitLu2Teql7CURLzZwUJ2pxpwBt1pWKvJWh4COR1SN5nxxaA=
X-Google-Smtp-Source: AGHT+IF8EM5OpS8vaaRheq/z7Al8vYW4FlT2Cp6tbBG+VyeOeI4ZZMj0Tcud+GD0ao4gE76dFf6/7Q==
X-Received: by 2002:a05:6000:1fa3:b0:368:504d:c3a4 with SMTP id ffacd0b85a97d-3731185c346mr377428f8f.17.1724377608804;
        Thu, 22 Aug 2024 18:46:48 -0700 (PDT)
Received: from localhost (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55a94sm2031326a12.57.2024.08.22.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:46:48 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.10 2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
Date: Fri, 23 Aug 2024 09:46:31 +0800
Message-ID: <20240823014631.114866-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823014631.114866-1-shung-hsi.yu@suse.com>
References: <20240823014631.114866-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 662c3e2db00f92e50c26e9dc4fe47c52223d9982 ]

A selftest is added such that without the previous patch,
a crash can happen. With the previous patch, the test can
run successfully. The new test is written in a way which
mimics original crash case:
  main_prog
    static_prog_1
      static_prog_2
where static_prog_1 has different paths to static_prog_2
and some path has stack allocated and some other path
does not. A stacksafe() checking in static_prog_2()
triggered the crash.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240812214852.214037-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index fe65e0952a1e..179bfe25dbc6 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1434,4 +1434,58 @@ int iter_arr_with_actual_elem_count(const void *ctx)
 	return sum;
 }
 
+__u32 upper, select_n, result;
+__u64 global;
+
+static __noinline bool nest_2(char *str)
+{
+	/* some insns (including branch insns) to ensure stacksafe() is triggered
+	 * in nest_2(). This way, stacksafe() can compare frame associated with nest_1().
+	 */
+	if (str[0] == 't')
+		return true;
+	if (str[1] == 'e')
+		return true;
+	if (str[2] == 's')
+		return true;
+	if (str[3] == 't')
+		return true;
+	return false;
+}
+
+static __noinline bool nest_1(int n)
+{
+	/* case 0: allocate stack, case 1: no allocate stack */
+	switch (n) {
+	case 0: {
+		char comm[16];
+
+		if (bpf_get_current_comm(comm, 16))
+			return false;
+		return nest_2(comm);
+	}
+	case 1:
+		return nest_2((char *)&global);
+	default:
+		return false;
+	}
+}
+
+SEC("raw_tp")
+__success
+int iter_subprog_check_stacksafe(const void *ctx)
+{
+	long i;
+
+	bpf_for(i, 0, upper) {
+		if (!nest_1(select_n)) {
+			result = 1;
+			return 0;
+		}
+	}
+
+	result = 2;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


