Return-Path: <bpf+bounces-45318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42A9D4528
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A873282CCF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36D224FD;
	Thu, 21 Nov 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3DU4gvf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2DD53C
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150423; cv=none; b=gAD0RD5jDTMOWtCfml7iJhZHmKs+eMV6DdLgClqQZU1ctFYybur5KKessOY/9UoSpjnw3oNYfSKaW4ULrVnWOmZXvkC1LjjnTCDbqDMI/v2rfRbqUpdN4Bkp3Sx5K3NpCaYzneVZYsiNJ0vY9/j8whpLWutkA4VksqoFUvpOjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150423; c=relaxed/simple;
	bh=APxp5nrclt3Ucs6p75iSWXwBhkh6XUOWntnOvQrbTeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbCG7lELvONuhNizgCb4tTYjtM+IawsL+l+Vxw0Pe2u65SvwVfg9um3xEYOWp6UXE0tS0jGHpDwtbXojD4ZyUbiG0a/wbBDPXNmyklWi0zaV22QJUdvgAomeW17gg6ecbinuHouqacPERje4+4Onq8M8X3dNe/MlK2Z6M5RZ3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3DU4gvf; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-38230ed9baeso202432f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150419; x=1732755219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tej00vkmld4pYTCE/k3luj8HWyhQB200NxTUs+RzfYM=;
        b=B3DU4gvfwmsCjfT59UKtsIv6h8OAfpNeX/PSwIV2EEG3TEVN0ydUHolBTSqFvG0ltF
         PbriKbaPjBTTKtx5YPly5t1G+FIQ5AMXPpYweCjxJ4fxrSbsFE9zPJV6zunk1/7hCOw/
         eG7S7657BDs9E2KNSBzLTwZsTWY6jCPH3mmCbZ2Aq42LWeBGcQrjNhwK3/5xANnDl80d
         2wvZlw8EhW+pBxsc90yXLX0G/8G8r4XP4u2Ur2m2crULlA2apCywG/9Abb0Tdph4gv5z
         Sj6UbMkBU55c/kI86QKIAr7zAaxXkmbWYC6x25Z2pAZdNpi+402tySwJ3JHV5mMgc71c
         hbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150419; x=1732755219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tej00vkmld4pYTCE/k3luj8HWyhQB200NxTUs+RzfYM=;
        b=TFodX/q9/blfTDikkU1Lokl+vWMB0yaiGfmHlR+65amW9ADaDgh89uDlCUNegh9Rx/
         3rAyPkTNFHND9foQjlX9lgvGO2DLThGNvqTN2QcW35Xq4l9NRNYyMbGYp7iD2B4VJL3s
         OoSzojQx2xdl84GsgjQJNQqCmE40sCcVHE+a/GwnYcA64yGvsRt+1vL0McQ/sS9Ek9L2
         SvY6dvUpv1xkrcndG3fwFoV7qtPrRlQUjXh2U+d/fd2SXEYWvMM6ruIJpm5XeW76dfm7
         V+Zw0lsg5fiL26f5dv/VzNbccfa5oFtrtOsAMiwaKl1/dr80066lucpa3ZrqNXPNnwiL
         U/GQ==
X-Gm-Message-State: AOJu0YytmvluWP4Gj4gdh03lg8jwlK88Ycu2ERhTGwCwT6efFfsP+5JI
	dEafiPi+Vzcgtsu3YxnQaPt4joMN3jVYunht0E2sEUXNwC6TZnhr3H4qLJA/n0U=
X-Google-Smtp-Source: AGHT+IGkqkAmfuafvE+EFZ/aeMF+A+PHTPjsWS+FHLjtLRyx1FNcrxuEkQsz5FFfWMA7ZjAVrNJfwQ==
X-Received: by 2002:a5d:6c63:0:b0:382:49f9:74c0 with SMTP id ffacd0b85a97d-38254b15895mr4202779f8f.38.1732150419012;
        Wed, 20 Nov 2024 16:53:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825494b974sm3370005f8f.108.2024.11.20.16.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Wed, 20 Nov 2024 16:53:28 -0800
Message-ID: <20241121005329.408873-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; h=from:subject; bh=APxp5nrclt3Ucs6p75iSWXwBhkh6XUOWntnOvQrbTeo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ3E4VDCoHf4hgF2Cd//5saAt9hP0wTgJozIaZk xKl9jiKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENwAKCRBM4MiGSL8RyqIKEA CX4vlM/ZjaXdkrI+UPeyxitiL8luOGX/jXgomESpflHMSbmxkpqZrUk3Q8JoEMEzNxJLp5p26c0cL+ HkEm9d/6OcbBKewruiGYJPA+cmSZ55Mt1P1kyLlWNvo9H9g2ahCFOwZPQRzNOQuvn+V4EPXRiS7jvy pjtiJMiXFQ8vYW+p7Jq5vp1YfoxxinrsUTn5NpgBASQFqla/wEib3nXIt+QsvlrViRkJy80oQXL5VF sXE5Hf7kV6hubgi6zIWzV19wcq42K+GbvKkh1u4Efc2U7mZVhdOjpMPdaGVkAO5q/yPBkcg1uCsuRQ fy68oPiicOG68N8GAXnIEw9pQo46lEAra29SzsosPSrl6Jue4ewFRrttmoWAtMoozC3jCPQ5jYyqPn a8agyF/7jm92C709dnIzyz38yilwL17sV5CuuntWoSEXD5Vhj5V3Xl+dF6PgMyz2yrLZSGdRCfXkAz usSA4mAxzDq58GiH5N73fmijNsHIXh0UeiRIXLnuedcsGrtzg7FTIxR2iOQPLxjRauLxGAfoEytgFn 7F9NiVhGA/qoQM1lBM62JC2nSzrx66/rkS1zheF4wZKca7Y7xnl05aXDlyruJ0EPCyfADFbMuK1FD+ U0mdCM74E9lAoA+7KnQK8qMExRbFsuzAEMk8agKiaQ2oSGXyFPaTy1ixyG3Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

For preemption-related kfuncs, we don't test their interaction with
sleepable kfuncs (we do test helpers) even though the verifier has
code to protect against such a pattern. Expand coverage of the selftest
to include this case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/preempt_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 885377e83607..d24314c394c7 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -113,6 +113,18 @@ int preempt_sleepable_helper(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within non-preemptible region")
+int preempt_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_preempt_disable();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_preempt_enable();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.43.5


