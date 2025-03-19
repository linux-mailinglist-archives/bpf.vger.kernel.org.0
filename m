Return-Path: <bpf+bounces-54392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D5A69529
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24143B8E6C
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91A1E105E;
	Wed, 19 Mar 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DOSZ7MLb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A221DF987
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402286; cv=none; b=Yo9MjhLcHNg/7YSp16Vwopvy/8ZdyKUET0C/MkoJ/dO9P9retNXQxPjAqJM8mtYpth9hMD1cMehobcVK1oeWOA6le8h28/vSnvXyCi/SbPLYG4XPOX4FZALJw4iM3KmE5DjpKnoeT6STTtYpFo/fBwNngHZ4IujHSY4P7ubw3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402286; c=relaxed/simple;
	bh=uerTHu75CrYUa3ffYlB9U3gPlSyrz7/nEyaTjDB6yUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHnKiaz2zclDiR9zcPUGK/Wczt2dAPwe6Q3UBPwLxgc9SvctUvMuxjgK9d/T4DKXq3I6GTNAsALFAsOFlLxpRJYps+nmdDduDvwDP80NQtEMplmzS0wzNIiNNhOvBvDaIAW6cbt8BW/IoKH1sr3L+HFkf6Xp0BrZ7MUSDOHWT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DOSZ7MLb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52JGCVYt020382;
	Wed, 19 Mar 2025 09:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=zXGg4WeggFj0WdeURBWtWKb1JbwtTeK50Yyz1BgTvJ4=; b=DOSZ7MLbL1+V
	4BUaBGP2GvNd8Y8Sqx68NZpPVGWapie/iq9hJmDgNYnxQ5kYbtgqvx0inp3lptkL
	htU2mvFuZDwTxWySq519xwPW1xdwIwcm56wLZ5fGcCG4aLiPsfq/J1NnPg5saIYN
	S8DVUwZqZ09DZIRdRmC6Xv2WZG2xtNqFFta/uzXs6H6mtRFWnbVuaoWkm/Q2zexH
	vLAW8mvi1BQJUjIwuXpCMf1e1tof1Xq5jTvGgHkgo5sBbmQAahlL43pvN7Xw0XY5
	n8SgCC7Yqd0+a0+QkHcBiWd+GzjAOSEj8s/0eX+3SGX4YjcP5O19GQx0n/2LTLik
	m5ybdigizA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45fn4mmb9n-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Mar 2025 09:37:18 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.14; Wed, 19 Mar 2025 16:36:47 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yonghong.song@linux.dev>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v12 1/5] bpf: adjust BPF JIT dependency to BPF_SYSCALL
Date: Wed, 19 Mar 2025 09:36:34 -0700
Message-ID: <20250319163638.3607043-2-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319163638.3607043-1-vadfed@meta.com>
References: <20250319163638.3607043-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _YJ5qyg1bKDhjlYM3-OwGkGTK87vrDb0
X-Proofpoint-GUID: _YJ5qyg1bKDhjlYM3-OwGkGTK87vrDb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01

BPF JIT is moving towards optimizing kfuncs and it was long overdue to
switch the dependency. Let's do it now to simplify other patches in the
series.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 17067dcb4386..528d37819570 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -41,7 +41,7 @@ config BPF_SYSCALL
 
 config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
-	depends on BPF
+	depends on BPF_SYSCALL
 	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
 	select EXECMEM
 	help
-- 
2.47.1


