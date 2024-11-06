Return-Path: <bpf+bounces-44154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A09BF7F6
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0261F1F22B6A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B120C307;
	Wed,  6 Nov 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="ZJva2h0U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FB20C03A
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924753; cv=none; b=nxL8D7K9qfjeA0QXzeFg571GntwM+oIPxCm1idav9SDcVNrr2C4Lvgkw8GyDYSsETZ8bcSVm8UEZcCKbEz3Mvgv3Q2mMy92giKCynJ8vyd73xVFh2V3AeVYavgoZZDwtSHTB/UmLWqx2f+MtAO7Lpgs3rnfCZw3b/PcuGa5J+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924753; c=relaxed/simple;
	bh=vkRnxw5VtBVsfwFTwkTaQVwON2Ex0gYg7Yhdw2UrfRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvdwDFCEg6RmiIHzcN6nKjiC0g5Rrq0tOGnqYcCxci1ct63sUGDhw3Q0FAMJSJkaEeyoE9axCqOOA94UjKbgHK4LaWibdfWN7zYxK4ut1jEKbKmBKcXGMuWL28ajO0ZrqnKnLqhpiHsyGl4bSnLLEqgauiZ9TWUQoZ/2zP50igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=ZJva2h0U; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1730924349;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=vkRnxw5VtBVsfwFTwkTaQVwON2Ex0gYg7Yhdw2UrfRw=;
      b=ZJva2h0UNuuweedebsFXHvBvpgnwIIuh++BELjVUlXGK4oLvlXJqd+8rEiCcNvaFv
        Zt/D5RI36/p8IiC+iqgZuP/WDOXXKf+lrKHVf5NJ1sHU2AzghQSOpjANJ/Hoy7gxY
        +7HGS8o0IRZnxAf7+9Nze6o50ozY6fNU/jK4/mB3k=
Received: (qmail 1863 invoked by uid 107); 6 Nov 2024 20:19:09 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 06 Nov 2024 21:19:09 +0100
X-EPFL-Auth: jjmMVUN+tC4yziWPwhoEPDAOvTuxrHmdHU7Tf7nPRO2beoP0diw=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 21:19:06 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>, <memxor@gmail.com>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 0/2] Check the types of iter arguments
Date: Wed, 6 Nov 2024 21:18:47 +0100
Message-ID: <20241106201849.2269411-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
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

As the included selftest shows, when passing a ptr_to_map_value with offset 0,
process_iter_arg still regards it as a stack pointer and uses offset 0 to check
the stack slot types.

In this case, as long as the stack slot types at offset 0 are STACK_ITER,
verifier checks can be passed before the fix.

To fix this issue, we add a type check in process_iter_arg to ensure the passed
iter arguments are in the type of PTR_TO_STACK.

Tao Lyu (2):
  bpf: Check if iter args are stack pointers
  selftests/bpf: Add a test for the type checking of iter args

 kernel/bpf/verifier.c                     |  5 +++++
 tools/testing/selftests/bpf/progs/iters.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.34.1


