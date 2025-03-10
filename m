Return-Path: <bpf+bounces-53733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DFA5980B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A29C16757F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB11AB52D;
	Mon, 10 Mar 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="idzPK3ts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AB199239
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618035; cv=none; b=ll0PD2SZBv4d4hTv/WONmKu+P4LE5mmNY9RRbPIi4azoK58D5aUr93LIvRMn2tOEOuhJ/SyLOYPcELp2ILHh2vk+3u4aynU6SyLD26Qxn/dM9l/BmcB0AqN3IR7I9cG8k3jnbnu2g9ihJ9BA2+DDCTxMWBEOJqSUONr+/Y6Rrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618035; c=relaxed/simple;
	bh=SB/+iG0weGCOLzaqKc9uSk7WYKna1frSYOJuNDj+n+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7Zxjpc4/d39sOYMrwCBZ5O3xo5la+j6aRpbD8YqhGDAZb4BSi13nMlRAhP/828Q0Gr7btWTpS0SIMOFaZpeZhEnWNsmICCUY3cVERjvtpozbO/2hBL2e/8kZW/uC1WI5W9q72/CoS8phT+AsWy8IbEAZnyp6LlOM1kZkRdOIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=idzPK3ts; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso10358445e9.3
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1741618032; x=1742222832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRdLlqQu7W7PLePcyJaXA4f8x3IBBJVcU95cq3MPXak=;
        b=idzPK3tsIlcJU4cIgyvA6eGCMwHuDefX9pFeLYoLqlJcbwHcD28rd6vY+x9ejhs2IX
         FY4l0swmMD4+GcuGpY82dlYCSsXbTrQ3yOKm65nwRejSMd0NJ/H2MwJh4oW8Ie9nOEt5
         Jq0PWzWF/JbbOIAXAEWyB0k5NF5W46G0JN7wN/ErhI76luyDJwedhqzSYpx+8N9OgkAq
         UnpkkHeghMHpg85+N4WTnLMY12w88U+yMGNduIpIze4neclkCeU5/rRQyhrnACzm7JW+
         V7vpZZkD/TyZenH/b/6ufp0OkajBGiWmHab5rtCqCPx8K58gtBJjUxoR8nbexIm5rvKC
         F4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618032; x=1742222832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRdLlqQu7W7PLePcyJaXA4f8x3IBBJVcU95cq3MPXak=;
        b=ntLzYPt+ncnb6924MyzQkVNayJogVPjjCowxj989BNEkzJ03N6I01bq3SMOgkwp1bL
         tN8pm42t3D/+PwjX4bm64Dksxx9Od0lKCEvE1+nYgUjmZdNr65cvOiqaSu57Wn5ULnuQ
         AjqVGyXTPqBwelqi2yPlvVqrBXot6JLzJtG/+uJ3BbDP/IiI4y65pdvSI1qBUp+djhTw
         85bkTqM28OWpf3I1cvZhqqKRzCG2iJm3s2pUi09J+TZg0i1loIdLJXEUWb3GNzfOqIuY
         2X6APUA6b3Q6Q134ipmh24D/ya0VdpWRkzsse0tKTn1l4lmwa0D1WvbOm5EIKwwJG7+/
         mvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWm8CVoTh9IvxNPFMTb3S88CjrwUr6JvYj/bux2d7bIyIMZNt0zL47ZVsB/t28gI3jQ3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3Jj9WClXdHou8h5c/SvJ3Arz0F9p3KEblQb2I3jTE/j2YGRS
	EXrYXtWRdVs1ZZ5ws+ddv0tqJ7jHaPx9TeoyfjOq2AKaWsZdZHjvxXlXCsTHK4Y=
X-Gm-Gg: ASbGncsjto3liHDTvDd8AJKoEo6/Hp7we7lUjs3D2CRlRPVyuooYFKsL7M90UrVMPz8
	QWgggSmt4aOIa3SgAQgJI0ZyZ+xBokw9HqfOA2GgX0CuaagBQ64BAKYNU2K5h8kDfSpt1hR7mlX
	onOqwSU5RCiDELhh9dEUIXvUUzEOj+FicR04xTfVnzoWRXWwG4aE6mO3+ClZDr4Ct1dFf5IaQgU
	XN3ndzX+rBMYFDTB7DtDZbpERdNMzPVfgQNH1AebrovMtxDU01/4RDd52akwqiwzmVog+Y1kZkl
	0dQwsDShuHZvnas0cz6M+eKTPnKFurjdr82RPVj+CyjejOYYDxV2WHdheA==
X-Google-Smtp-Source: AGHT+IGKo9sqAowokE6AGwo26RrrhWSwn0OXMAABmokcBBx3STpBddM0dK8/sj/YhIepSU9lwrv0nA==
X-Received: by 2002:a05:600c:4f41:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43cec28d3c2mr36806185e9.26.1741618031460;
        Mon, 10 Mar 2025 07:47:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da097sm150852295e9.17.2025.03.10.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:47:10 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next] selftests/bpf: fix selection of static vs.  dynamic LLVM
Date: Mon, 10 Mar 2025 14:51:12 +0000
Message-Id: <20250310145112.1261241-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile uses the exit code of the `llvm-config --link-static --libs`
command to choose between statically-linked and dynamically-linked LLVMs.
The stdout and stderr of that command are redirected to /dev/null.
To redirect the output the "&>" construction is used, which might not be
supported by /bin/sh, which is executed by make for $(shell ...) commands.
On such systems the test will fail even if static LLVM is actually
supported. Replace "&>" by ">/dev/null 2>&1" to fix this.

Fixes: 2a9d30fac818 ("selftests/bpf: Support dynamically linking LLVM if static is not available")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 739305064839..ca41d47d4ba6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -180,7 +180,7 @@ ifeq ($(feature-llvm),1)
   # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
   LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
   # Prefer linking statically if it's available, otherwise fallback to shared
-  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
+  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && echo static),static)
     LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LLVM_LDLIBS  += -lstdc++
-- 
2.34.1


