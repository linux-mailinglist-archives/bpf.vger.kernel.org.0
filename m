Return-Path: <bpf+bounces-44301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFA9C113E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FF1C239E7
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E82185B9;
	Thu,  7 Nov 2024 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="J73tzT+0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A92217F39
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016078; cv=none; b=QaC1fEOCl97yIDXSLzVF78Ygd8kgDKHM35aWTISYbrnOM5FdZUliWsIFHEwYAhg6JPNq9/uagsCVmr1MOhNan3e0Mo/to4yOAhXeNtTAmRZ0oqF3z2yHb52qzbRkmFrLCE5wYdNamMCZ1vpmDti/v2mrbjQVMk8H8QzT1xiM8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016078; c=relaxed/simple;
	bh=dBOK0au2ahL7KrIO6srWl8JJicbOk+XoKnm2Qxc5tZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpxnlDtRiQuwoimEw5sp2kCTn8gpsb+KSM9Qr1nDYFijMWEArpnhTLqO+zXJw9bp1IVhsMLxUrJBVejUGwqpnrWB+OlXC4Ht+LYFlXjdfv/5dn3TOXY67bRkjMBMJJsgPikVzjKZ95WSZsmfo1bE24iehkdoD0Cy+rshw7d41Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=J73tzT+0; arc=none smtp.client-ip=128.178.224.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1731016068;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=dBOK0au2ahL7KrIO6srWl8JJicbOk+XoKnm2Qxc5tZA=;
      b=J73tzT+0F7i1ey3q8b+zAGgHZeFuMdASRxGhfQLSwffV0wkBFXqabLnn9jSTnPTUh
        PL+bVQfPopDQTW9w5hkgoWYsOvHei/PtXjV8Q57eXh6w8rX/Zy/7gECIgG02624oR
        NRqmA21IuwqIYyZIcVvyevWDNawxR/FGFrP+tNDng=
Received: (qmail 50193 invoked by uid 107); 7 Nov 2024 21:47:48 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Thu, 07 Nov 2024 22:47:48 +0100
X-EPFL-Auth: ue7o8txDBC8xkYlDeTmiZ9/NIRUZDt3ToLYCp6wTK/8M5kmQeA8=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 22:47:47 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 0/2] Check the types of iter arguments
Date: Thu, 7 Nov 2024 22:47:34 +0100
Message-ID: <20241107214736.347630-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa04.intranet.epfl.ch (128.178.224.170) To
 ewa07.intranet.epfl.ch (128.178.224.178)

The verifier misses the type checking on iter arguments,
so any pointer types (e.g., map value pointers) can be
passed as iter arguments.

As the included selftest shows, when passing a ptr_to_map_value
with offset 0, process_iter_arg still regards it as a stack pointer
and uses offset 0 to check the stack slot types.

In this case, as long as the stack slot types at offset 0 are STACK_ITER,
verifier checks can be passed before the fix.

To fix this issue, we add a type check in process_iter_arg to ensure
the passed iter arguments are in the type of PTR_TO_STACK.

Tao Lyu (2):
  bpf: Check if iter args are stack pointers
  selftests/bpf: Add a test for the type checking of iter args

 kernel/bpf/verifier.c                     |  5 +++++
 tools/testing/selftests/bpf/progs/iters.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.34.1


