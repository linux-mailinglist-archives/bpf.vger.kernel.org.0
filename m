Return-Path: <bpf+bounces-49485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698BA19220
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C787A21D6
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB322135A5;
	Wed, 22 Jan 2025 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ggnWUnmT"
X-Original-To: bpf@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F2212F87
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551524; cv=none; b=XhdX3wPlprs95fDfx/6Rw9hYNqpONnUsVJ6PKQi1Gol13EobYxz7g0fc5/sK9NP2ow86LA07e8bm4mnGvwL+A318Y9Kr6XINTnwBbqAxpxe9qE4L9i2zupVRHAPK4O5QL/1aEats1n8AY+4n/yG9CjtRTgdsghgztOZ5fvg0tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551524; c=relaxed/simple;
	bh=5959kPBereMjbacpyhvDGIY1REG5nPqghaV/Z9Pzhpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:
	 In-Reply-To:To:CC:References; b=VndF/MGbW1y35pjrW3vRQz7LX5lQjNvPK6zVhWPTckj9HgJpWWovdSbKHKTefNlnmR6yPuVUczDzVcuMwE6yQtATJxIKftR+GND2t9jrs/CQ4xzLg7uoY61vVo6QmUYY0ejojP3m7nGY/5UdxIlQKl7onsBJpM/4I+4mj8O6NKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ggnWUnmT; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250122131159euoutp01b80c41d4580c5e0df6952db24a6e076f~dBeassJKe0267002670euoutp01M
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:11:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250122131159euoutp01b80c41d4580c5e0df6952db24a6e076f~dBeassJKe0267002670euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737551519;
	bh=KAPuTK6ECY3IIUBY7nMPQTnFjU5YBP/3/lTZDmyrTQc=;
	h=From:Date:Subject:In-Reply-To:To:CC:References:From;
	b=ggnWUnmTcCmieOWZHgZBikUZNjTCc1Xv7N88IJse0sunC3YWBGJjAxGYPmhpkab77
	 21jprwzW48dey4gISMmvx/OaKIbBdo+6MmDM8YmSnC+IZeVA8nkWsjOC50iQJtQ5km
	 qKCQxDRBDX+xuFS6DzdtEC2hKiT4F8T3cJ7Gk4dM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250122131158eucas1p21c95e0e6c4195bb550028e862a2680f2~dBeaJ6BS52847028470eucas1p24;
	Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.01.20397.E9EE0976; Wed, 22
	Jan 2025 13:11:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250122131158eucas1p133e9989e5b972e0658b4ef7255901085~dBeZrHpZw2457724577eucas1p1C;
	Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250122131158eusmtrp2905fbad1053c6e9e921fa8446f7c229a~dBeZpfTLF0895608956eusmtrp2M;
	Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-34-6790ee9ea932
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.5D.19654.E9EE0976; Wed, 22
	Jan 2025 13:11:58 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250122131158eusmtip16da4697e3ba78e55fc060bc9a9c788c3~dBeZca9EJ1514915149eusmtip1k;
	Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id
	15.0.1497.48; Wed, 22 Jan 2025 13:11:57 +0000
From: Daniel Gomez <da.gomez@samsung.com>
Date: Wed, 22 Jan 2025 14:11:13 +0100
Subject: [PATCH 1/2] module: allow for module error injection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250122-modules-error-injection-v1-1-910590a04fd5@samsung.com>
In-Reply-To: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
	Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <llvm@lists.linux.dev>,
	<iovisor-dev@lists.iovisor.org>, <gost.dev@samsung.com>, Daniel Gomez
	<da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737551516; l=2479;
	i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
	bh=5959kPBereMjbacpyhvDGIY1REG5nPqghaV/Z9Pzhpw=;
	b=Qs3ZhYYvDw7GYoEVc3llZYUO8q4SaoeW+kRSaJvET8xE+y9+OysGIigOAgsnUYEJ4MMmnybpA
	Bm9VggPOhXNDfIM2ltVuK0+zipxQFNMAiWC1AKZnjpi4WjkfYHEczi6
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
	pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxbVRzNfff19dHZ5VEgXDenkblFyOyG0+Qibgxn4lvcjO4fDSFAlUch
	fIy01IpxiLgPh250DCqURkpnRzuKaAcdNBvYBloZmzMwsA42N1aUfZTMtQyR0Eo/pvvvnN85
	v3PvPbk0FH1GraGLyio4WZmkJIkSkFbn4uUXvplTSbfUmVPxwlILxP7FST72DboofLLtIcRu
	YxPEDtcAH/9tuAJwTa+RwIMNGojVHScp/Gf/UQKP2bQUrm5Z4GFPwwCFzUdMPOxWzQBsGfPx
	8GHTDIXvq4IENvjnIDYYvTw83mwjsKt9mcI3Oqy8HYh1918g2D7NNT6rsyjYWvcoZC2nj1Bs
	W3UjZIcO1ZDs7JlmwHZ1j5Osz/L024Iswav5XEnRh5xs8/Y8QaHVtrr8h7iP9L/+xq8Gw0wt
	iKER8xI672jm1QIBLWKMAGkvTZER4gdoaPTnKPEBdLBumXi04uvoIUNYxLQD1FP7yn8m7/Tt
	6EY3QH63CoRcFJOM+oct/BAmmQ1o8kIAhnAcsw31XFkOJwmZWDTc7FnBNA1X/F22zaExZJ5B
	Z71aGLHsRpc9jeHIGGYPUg/NhM+KZyZ46OxVe5hAZgKgo+MGKnLVBLR0whYWEDNAoPYDVjIi
	cMg4PQUj+FnUdNwUne9Hnc6L/MhCpwB16/0gIryORnTHo6lx6I6rmx/BT6FgX2u0mGJ0aeFc
	1F+BAvf/iYamo2Dnteg8E5mDGhh6JmJWI7c3VgU2ah4rQPN/AZrHCtABeBokcgp5qZSTby3j
	lGK5pFSuKJOKP9hXagErv3Qk4JrvBcY7f4kdgKCBAyAaJsULgx6VVCTMl1R+zMn25coUJZzc
	AdbSZFKiUD9wUCpipJIKrpjjyjnZI5WgY9ZUE8Wa4nlPcsaxPPXeu9r3C6vWEw/Pb/vqht0Z
	+OMdUnc9Q6GkU+O53E82TmpbRdd3fSlpVX0r7vMFBZBLcQ3dGsxJb/zctABOJaRnWeZuSVqe
	XPWe+l7VhjPv6tea2lpOpPTAJ/J+NBfUZr6Vlihc91xwp3jyRcPv6/MOs9bb+Zljp75w3lTO
	5o40pa3KyKp5sGlv9k05l313J50ROLTF2TXdp7vYv8lrTisoqJy4WqNcsh17Y8qc7XyQU2Xf
	veNrpjdRl5A1+/wvr1Xe+3RrvbVc6s8perk++RyQ1Ne5FjtNiLQvv7lfParriu01Ew16+/YD
	DSmNyu/mf9Lv+X4kbt1MIImUF0pSU6BMLvkXL7CycRQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsVy+t/xu7rz3k1INzi8U8ji++/ZzBZfft5m
	t/h85DibxeKF35gtbqyYwWxx6Ph+dosfS68wWjTtWMFkcWTKLGaLaasXs1k839fLZHF51xw2
	i4bZ31ktnkzZz2axpnMlq8WNCU8ZLTZd/sxq0b7yKZvFhwn/mSyWfnnHbLF0xVtWi6szdzFZ
	HF/+l83iweptrA4SHjf2nWLy2DnrLrvHgk2lHl03LjF7bFrVyeaxsGEqs8fRtiYWjxebZzJ6
	rN9ylcXj8ya5AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
	stQifbsEvYxtu/gKNgpXLLp+k72B8aRAFyMnh4SAicTn1VtZuhi5OIQEljJKTFv7kgUiISOx
	8ctVVghbWOLPtS42iKKPjBINM3dCOVsYJb5/e8oOUsUmoCmx7+QmMJtFQFXi9ql/zCC2sICt
	xNYrf8Gm8goISpyc+QTI5uBgBqpfv0sfJMwsIC+x/e0cZogSH4nzT6YygthCQPa3tcvBWjkF
	fCWmHX0KdqmIwDVWiSnzTjGCOMwC1xgleq8uZYM4VVTi9+RdYFUSAvuZJNa8Owr1Q6rE9itL
	oIoUJWZMXAn1Z63Eq/u7GScwis1CcuAshANnITlwASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k
	/NxNjMDEtO3Yzy07GFe++qh3iJGJg/EQowQHs5II7/8nE9KFeFMSK6tSi/Lji0pzUosPMZoC
	A2kis5Rocj4wNeaVxBuaGZgamphZGphamhkrifOyXTmfJiSQnliSmp2aWpBaBNPHxMEp1cCk
	tmmrgZn3ere3yoUGrsHV15QkddfrPrJf6/zgtLBkXrPnE43kqJ3fzhz/uC2+adrEV+4xVWt3
	Mc1INLp2yELd3rDwwZIvDPPnmP3LidNLam1VZN5+f4/iqshZpb6peV/0npu0ZdS3F7F/kbVK
	nJz6RUVG5WSbwKykPpalPru5nUQ8nzLLLZkg/aJ77eO8vD/frtv1H7evyS3L2Jyb9WiKnr7m
	p71MBh++rNhbkjnLbp7x4w+rbFYu39Qun1hnPrd7qu1C2z6umdI6W0+ev7pr/orz+/dMExPd
	3an9yiLEKpCHM4rtzZJ9akUMh1Qvfb6lWLPg5a1ay51aDPP3x2z0c3j4payvImh/4d5jKe+U
	WIozEg21mIuKEwFj9L7e1QMAAA==
X-CMS-MailID: 20250122131158eucas1p133e9989e5b972e0658b4ef7255901085
X-Msg-Generator: CA
X-RootMTR: 20250122131158eucas1p133e9989e5b972e0658b4ef7255901085
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250122131158eucas1p133e9989e5b972e0658b4ef7255901085
References: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
	<CGME20250122131158eucas1p133e9989e5b972e0658b4ef7255901085@eucas1p1.samsung.com>

Allow to test kernel module initialization with eBPF error injection
by forcing errors when any of the below annotated functions with
ALLOW_ERROR_INJECTION() return.

Allow to debug and test module load error behaviour when:

complete_formation(): when module initialization switches from
MODULE_STATE_UNFORMED to MODULE_STATE_COMING stage.

do_init_module(): when an error occurs during module initialization and
before we switch from MODULE_STATE_COMING to MODULE_STATE_LIVE stage.

module_enable_rodata_ro_after_init(): when an error occurs while
setting memory to RO after module initialization. This is when module
initialization reaches MODULE_STATE_LIVE stage.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c       | 3 +++
 kernel/module/strict_rwx.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f8f328fc37c6d93730882d0e6e613..54e6c4d0aab23ae5001a52c26417e7e7957ea3fd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -59,6 +59,7 @@
 #include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <linux/execmem.h>
+#include <linux/bpf.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
 
@@ -3089,6 +3090,7 @@ static noinline int do_init_module(struct module *mod)
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(do_init_module, ERRNO);
 
 static int may_init_module(void)
 {
@@ -3225,6 +3227,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	mutex_unlock(&module_mutex);
 	return err;
 }
+ALLOW_ERROR_INJECTION(complete_formation, ERRNO);
 
 static int prepare_coming_module(struct module *mod)
 {
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 74834ba15615fa02d1fa72b913feedd7400af779..21936f5cc1e679e4de90331ef4920597d9093f35 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/bpf.h>
 #include "internal.h"
 
 static int module_set_memory(const struct module *mod, enum mod_mem_type type,
@@ -71,6 +72,7 @@ int module_enable_rodata_ro_after_init(const struct module *mod)
 
 	return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
 }
+ALLOW_ERROR_INJECTION(module_enable_rodata_ro_after_init, ERRNO);
 
 int module_enable_data_nx(const struct module *mod)
 {

-- 
2.39.5


