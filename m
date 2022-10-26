Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5B60E0AB
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiJZMbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiJZMb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 08:31:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F517AB15
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 05:31:25 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666787484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HOwmFeqA0a/oNdvdHF9irYL7W2HF2WYB7JZql6T3ucA=;
        b=aaVLo0USjYTlD9swI6s8ELrsWMeBQipEk4D/t0X9ezbpfWLPY9HnpH8UGSXtg3RvIguLcH
        xQelqyF15XdTNahKCrsX8ZOfbGXTJs9YmIq4KtLsGiItoaRQ6TKaQzSaEc5qC8yGdJVnEy
        33NYa6agzI0kxxJFAG45QJP3E0QhaWoBQBfFTME15FbwuceSgvOmhh3v30XjBKGEhA/+Q+
        8VsiSlk4lnxBVfegJ0Pv3vq5gOIWFbIq/5O8LhcKJ+luOef0a0xeGAwqQEawq0S+hCRqpu
        q6xGe5eDnZDC7pB3qxjshq3MzVvkx9H4RjUeGiJik20ybIvjZhilYdvKDgqveQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666787484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HOwmFeqA0a/oNdvdHF9irYL7W2HF2WYB7JZql6T3ucA=;
        b=Yn5fLdc71EuiSs1XGvTxFfxM9UE3IOOx0mYZbcKQ0JXSre6wGER29kE8JO2GzPf9wKl+2+
        f6gdhbTW/VX+NaAA==
To:     bpf@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] bpf: Remove the obsolte u64_stats_fetch_*_irq() users.
Date:   Wed, 26 Oct 2022 14:31:10 +0200
Message-Id: <20221026123110.331690-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Now that the 32bit UP oddity is gone and 32bit uses always a sequence
count, there is no need for the fetch_irq() variants anymore.

Convert to the regular interface.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f4..71d8eb131928d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2117,11 +2117,11 @@ static void bpf_prog_get_stats(const struct bpf_pro=
g *prog,
=20
 		st =3D per_cpu_ptr(prog->stats, cpu);
 		do {
-			start =3D u64_stats_fetch_begin_irq(&st->syncp);
+			start =3D u64_stats_fetch_begin(&st->syncp);
 			tnsecs =3D u64_stats_read(&st->nsecs);
 			tcnt =3D u64_stats_read(&st->cnt);
 			tmisses =3D u64_stats_read(&st->misses);
-		} while (u64_stats_fetch_retry_irq(&st->syncp, start));
+		} while (u64_stats_fetch_retry(&st->syncp, start));
 		nsecs +=3D tnsecs;
 		cnt +=3D tcnt;
 		misses +=3D tmisses;
--=20
2.37.2

