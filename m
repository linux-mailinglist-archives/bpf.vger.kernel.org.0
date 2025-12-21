Return-Path: <bpf+bounces-77264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE7CD3C5A
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 08:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC90F300986A
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D9233D85;
	Sun, 21 Dec 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id6jsMCQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92020C00C
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766300453; cv=none; b=OFoivHGKMG1Bsq9aiVaosbCgcgJ1r7+AAvUkj8K/DRF4JXOw4dEmtcMIrMMyzk+EByeRJs4D+OThXohTAKQAusIro91RQVZradlh4swhLly78X34m+oDaCD9qFVWmaN57FkUsnyCLt++JfsrIk4T5qvAZgn2jGIzv4Qj9edCo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766300453; c=relaxed/simple;
	bh=yGU327kh4Bf6zZy2Yagp8yzrreRNuA+F+B6N0rpT9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEUwlycLQdRL829Z4jMhW5NEsSnytk+UMFHeEC0s9+DsxZldsPxfY+7yYWeSKdPo81KxXQrizp7gJ+JiGpW39LDzrVDJIN6bKda7WEiEl11/IA/ldpArWoRGHCzyev+DSwsFwfYXhAabnnAg5ltDmVUWAtadeFv+DBBwMmqLamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id6jsMCQ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso1688857a91.0
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 23:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766300451; x=1766905251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm4lYrd1UEAfe1OMJYAL+6fR/c/Hp392vfi3YhuFblk=;
        b=Id6jsMCQCHx2Et3K0SiD6f92fLTrqr1aePvpJy/Z3hIVDdvfc7nmDjg7tJhSRbLgy9
         fWSqTfPsQWvRd4jyaHGlrwFTRDKg6uFXwhuAteyiqTWKjlTiN4WMcBSVAzXSpbVnzSoC
         FJQeAzldJKr8hoAA5sYn4uqUU771ISD39mpcbBLiLguVrkVaANEdV+M5PePfSsCQpWg4
         vvLafpGoy5fUavjr7QVv/ofX4yfMiMwgPZmdhazvIo8Oo4NBOqrY2KxsddlReEWZJ9Mg
         7eFZ8l515ooTfOV+MplZnWmjqp8JYR+uyl2eT6SrY0NZzhzsPf+9D/VtDJkr5bcmHy8T
         JHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766300451; x=1766905251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm4lYrd1UEAfe1OMJYAL+6fR/c/Hp392vfi3YhuFblk=;
        b=VC7jLbRYkXxGEaHh1hYL+vGJ8sdVWnfCvTwiogtQ8WesxHsa6BgCn8VfBsLO3+Y8tu
         +ClON6JyTXW8R0WT5pvoGR1qD/KFrKirxvcN3+PLUfwLBU8DSC4ROUv83prgsz28FGp+
         6FzXuA0+FRw0/Ow5O6rUEgQ7mk6b41FMzsWnTqlT0NWwMm8GINXaUP3WvGmpAeqZuXX8
         BfdlO5g2Qb6d+9qrU4dXn0iItUUCcymREYlSAvhKNeARv+dmnjUvtFdxMs2dC49btIKb
         puy2BmyRtDrZpCN/cBGiZxunhh9/Ua341AGLtF4n6x0Q5Da96VG1r73pGfu7VmEE15y1
         XCXw==
X-Gm-Message-State: AOJu0YymrgBTf0wh6FlAV/qSpWq5Km+0bPiwULX7meEiGsRooe7rhjkv
	RN4LO98DgztVHkYHIEeDfbKlEJk+2deA/bog9byHyIFbo0jEbi+kNZi7
X-Gm-Gg: AY/fxX4U9MCGZ1fNZwL2OumfDByRtiQD2uQ3AMoJUJOrUUFWeJsHojWP2T9SYgyarJG
	2r1L4/LtLMZPTNhKo4bnRXWhPdFAFlYVWPbpPiAKMGmVAXShdUxXSCRd2ldOptnDqBVoJnTFaBF
	fwlxsF0wYY2eiKQRGQ9dQ3dZxPb/TORMIky6UI2P00ZEHW7F3M9Dz0VYdUxtRjr4dylElBAoN6g
	cbfy5WHV3//ppfyoROt1vlrWjQ7Q24BcdFD4WjdpOq3eU/jJTvAMfgiRyf79U7ak4WQxvn9L09G
	iz4zYnqqvEeZ+z5fl7FRBROmxcSc16ICMhbsnpa2KRUURI6ogMFL5P7SlUe2zTeOtSFLrVscyJw
	lvL8NeUkdgp0/FC9sgL18Ztn3w4WFHCYVo7AUQG79c5glIApB68tr/LdtuWIHZGjiWDk6WPPsyd
	IHHhkCEHo32/r3s8xaDKFHAJzcoMFZXSHG77Mag5pYjQj/4PDjv9kXSUPiQ6e6LijGDQ==
X-Google-Smtp-Source: AGHT+IEVTyoizp72hHa2oRLjdKpOv2xTmjBKmKZHtuDvcFdYNCRlNJ1HgycXM39JHS+fOnG6zZbWAg==
X-Received: by 2002:a17:90b:4b0b:b0:340:c094:fbff with SMTP id 98e67ed59e1d1-34e71e09fecmr9309489a91.10.1766300450888;
        Sat, 20 Dec 2025 23:00:50 -0800 (PST)
Received: from cncf-development.local (90.106.216.35.bc.googleusercontent.com. [35.216.106.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34ebeac8623sm652843a91.1.2025.12.20.23.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 23:00:49 -0800 (PST)
From: SungRock Jung <tjdfkr2421@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SungRock Jung <tjdfkr2421@gmail.com>
Subject: [PATCH] Documentation/bpf: Update PROG_TYPE for BPF_PROG_RUN
Date: Sun, 21 Dec 2025 07:00:41 +0000
Message-ID: <20251221070041.26592-1-tjdfkr2421@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LWT_SEG6LOCAL no longer supports test_run starting from v6.11
so remove it from the list of program types supported by BPF_PROG_RUN.

Add TRACING and NETFILTER to reflect the
current set of program types that implement test_run support.

Signed-off-by: SungRock Jung <tjdfkr2421@gmail.com>
---
 Documentation/bpf/bpf_prog_run.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_prog_run.rst b/Documentation/bpf/bpf_prog_run.rst
index 4868c909d..81ef768c7 100644
--- a/Documentation/bpf/bpf_prog_run.rst
+++ b/Documentation/bpf/bpf_prog_run.rst
@@ -34,11 +34,12 @@ following types:
 - ``BPF_PROG_TYPE_LWT_IN``
 - ``BPF_PROG_TYPE_LWT_OUT``
 - ``BPF_PROG_TYPE_LWT_XMIT``
-- ``BPF_PROG_TYPE_LWT_SEG6LOCAL``
 - ``BPF_PROG_TYPE_FLOW_DISSECTOR``
 - ``BPF_PROG_TYPE_STRUCT_OPS``
 - ``BPF_PROG_TYPE_RAW_TRACEPOINT``
 - ``BPF_PROG_TYPE_SYSCALL``
+- ``BPF_PROG_TYPE_TRACING``
+- ``BPF_PROG_TYPE_NETFILTER``
 
 When using the ``BPF_PROG_RUN`` command, userspace supplies an input context
 object and (for program types operating on network packets) a buffer containing
-- 
2.48.1


