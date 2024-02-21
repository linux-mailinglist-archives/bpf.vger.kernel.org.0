Return-Path: <bpf+bounces-22395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C303F85D525
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48761C22DFD
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC13FE4B;
	Wed, 21 Feb 2024 10:03:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3A3D3A8;
	Wed, 21 Feb 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509836; cv=none; b=Uz18DreuoDB5hdQoUUvcqmHaeBTLzr/ty9KCbO8ZgQCXo0U5jst98N1BCHTMrv9XaTimeAWA1DQUeQbj/mrdvNJdulJ4ZciKzmEgGRoJwvX/bIlOeI6lrkSEdz9K7WmbYamQ2xFOqiduhV070ZC3u+T3IIdTBxAflJOf/14sdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509836; c=relaxed/simple;
	bh=JQ8v0pGbNDM4U4Piv1sJDC8mDRvG5VWDoUTZXvOtx1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXLuCwRn++IeOE/TGK4WkuE82NfpIHo/wvbJw+Vd1oHOiSM6eOTnpj3+NcxVioKnwvLBlPJ9GpUGDxuoocI0CKRgt15ZxXZiJDO2BOiS2oPbHiN4SATXo0kIAedR/EeQcoPJvotFsIlIGTUVfiQQ3Qwr3+HHMMMkqhPBCQP6xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 008C82F2026D; Wed, 21 Feb 2024 10:03:51 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 707DC2F2025F;
	Wed, 21 Feb 2024 10:03:31 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH] bpf: change WARN ro pr_warn in verifier in 5.10 kernels
Date: Wed, 21 Feb 2024 13:03:23 +0300
Message-ID: <20240221100323.861959-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change WARN to pr_warn in check_map_prog_compatibility,
because this functionality was added in kernels 6.1 and
because fuzzing kernels with syzkaller while
kernel was started with parameter panic_on_warn
produces false positive crashes.

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45c50ee9b0370..7a7a6e3087ba2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10478,7 +10478,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			verbose(env, "trace type programs can only use preallocated hash map\n");
 			return -EINVAL;
 		}
-		WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
+		pr_warn_once("trace type BPF program uses run-time allocation\n");
 		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
 	}
 
-- 
2.42.1


