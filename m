Return-Path: <bpf+bounces-64053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D3B0DEA6
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385C06C081A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503D2EA739;
	Tue, 22 Jul 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKAyy1dm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6752EA15D;
	Tue, 22 Jul 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194152; cv=none; b=ppVS2VxboS20ZVQ8RKVptBwL87SUPiS3uwpxiWRvF7KOTxiGUYoYYQaiRG6ZmuVTDBziwUdFa93DABSKfp3r4mKGu7wBftEEnOuPHgdFNbccGO/zne59eE7hyLw5m95/LnYUKjICcxtZoafLvLSxkBQn3WA5pcUgMnpq8mdlv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194152; c=relaxed/simple;
	bh=fVt/4gXhze1cHAkkB1Y25oVjwaaigI0eu3hXijY+Bac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kWfN8hixWvXPIT1j3tJmCU/J8VxzMjf8eOPmjdiLz+Qzc+rSr10nleJ9BI0qsv/RYEUQaQm26pKVlunCaYQd6fM70Y2ipIOPwZi7R9qYjYH2mea4GV8uig++/fz5/UdPNiRDFRhPUfxRRvSXJuR7EfVleEn9Yvi/Wj2rdzWI0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKAyy1dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29507C4CEEB;
	Tue, 22 Jul 2025 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753194150;
	bh=fVt/4gXhze1cHAkkB1Y25oVjwaaigI0eu3hXijY+Bac=;
	h=Date:From:To:Cc:Subject:From;
	b=jKAyy1dm3j2Zqi9HJn/O0fWR2N8vWD7BbwiBkiqSnTYonHtOCduhesZrbk4hKUhlG
	 +BlB38/8+UjZEbDz6B59uu6ciQJm6bGFbBBufbjrfU5U90f4Vq3ymuRgJYt14nVHop
	 k1tDQcQl6s873xOi3rvmeUT2eC8O9z58DD1pacGGMPeGI4ZGYwOqLrEv0f6dVFCo1N
	 WkwwyUlnqXFypoSlECxx3m0A/4tL3ylViFWWKIXdxEW2cY14kUdPbvv14G2aKuYYrn
	 awPYuN8bo61E0YJHngDWh171nXBAjH+nAWY+E8xWmQCrEwbcbVfVmkYwo1IJvOFdPu
	 6nhXz9p24mogw==
Date: Tue, 22 Jul 2025 11:22:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/1] pahole: Don't fail when encoding BTF on an object with
 no DWARF info
Message-ID: <aH-eo6xY98cxBT1-@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If pahole is asked to encode BTF for a file with no DWARF info, don't
fail, just skip it.

This is the case, for instance, in this file in a kernel build with
DWARF info generation enabled:

  $ pahole ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
  libbpf: failed to find '.BTF' ELF section in ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
  pahole: file '../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o' has no supported type information.
  $

Before it was failing when encoding BTF for it, now:

  $ pahole --btf_encode ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
  $ echo $?
  0
  $

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/pahole.c b/pahole.c
index 333e71ab65924d2c..a001ec86ef1b0908 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3659,6 +3659,13 @@ try_sole_arg_as_class_names:
 			remaining = argc;
 			goto try_sole_arg_as_class_names;
 		}
+
+		if (btf_encode || ctf_encode) {
+			// If encoding is asked for and there is no DEBUG info to encode from,
+			// there are no errors, continue...
+			goto out_ok;
+		}
+
 		if (argv[remaining] != NULL) {
 			cus__fprintf_load_files_err(cus, "pahole", argv + remaining, err, stderr);
 		} else {
-- 
2.49.0


