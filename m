Return-Path: <bpf+bounces-44155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1529BF7F7
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373C01C21805
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FB20C31C;
	Wed,  6 Nov 2024 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="Kwb0kt2I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524820C00B
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924753; cv=none; b=uGv607Fbzxeb/xhm4Ua2N46Pfv2Ph9HYT+IO9tF1KDa7IvDnWjt2mXhLKuiyKbLur/7q1eflzjp1zuY6Y7vwUHSxOOobrDy7h9c5IIfGh8MmNTg//v04HoTEg6qHUPflEypX6flWhvC1uWgj1EQ0xEIOF/CFbcXTK7xVCSDqDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924753; c=relaxed/simple;
	bh=imHsVOw/Uplezoi7aMEmPTsQQULa0xN8n/W8FqE9mJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox19cExDJLOLcy8Wl1AcEk/qsDhMm+itUGY/UuKRPNHL1D0jftmlFBE8u6pjTaoile6sm/YCX09iDJK8fjBmSQzr7BINpwZekIJW0Xd8DO1aYjy6cSs/3UyFlJA4Gp19WtI3/jpt5K62os5ucaqyqTv0EN9akYtifNDRIzVBI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=Kwb0kt2I; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1730924349;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=imHsVOw/Uplezoi7aMEmPTsQQULa0xN8n/W8FqE9mJI=;
      b=Kwb0kt2IjSjZ5U9MDdlG27sJdDT3nPkpfuK7xz9DdX8OTSTblCYSoA/oilAX5nmg5
        tJQRrpKbvwPyVlTOmRJ0u6usQOl8MVoP9uHeT5WmfAUK+QNE16o43vVDXGqaNsDvA
        51aTHfBsR/mDwFy0OwTEdE7tdAuhHzTqtfwAZ0CS0=
Received: (qmail 1869 invoked by uid 107); 6 Nov 2024 20:19:09 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 06 Nov 2024 21:19:09 +0100
X-EPFL-Auth: NqEj0pUNiiveI6TtxcFotUvmjkRxL3TKiKG0Sf8e9ayfkMuP/F8=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 21:19:07 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>, <memxor@gmail.com>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 1/2] bpf: Check if iter args are stack pointers
Date: Wed, 6 Nov 2024 21:18:48 +0100
Message-ID: <20241106201849.2269411-2-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106201849.2269411-1-tao.lyu@epfl.ch>
References: <20241106201849.2269411-1-tao.lyu@epfl.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa11.intranet.epfl.ch (128.178.224.186) To
 ewa07.intranet.epfl.ch (128.178.224.178)

The verifier misses the type checking on iter arguments,
so any pointer types (e.g., map value pointers) can be passed as iter arguments.

We fix this issue by adding a type check to ensure the passed
iter arguments are in the type of PTR_TO_STACK.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..98afdcecefbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12234,6 +12234,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
+			/* Ensure the iter arg is a stack pointer */
+			if (reg->type != PTR_TO_STACK) {
+				verbose(env, "arg#%d expected pointer to the iterator\n", i);
+				return -EINVAL;
+			}
 			ret = process_iter_arg(env, regno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
-- 
2.34.1


