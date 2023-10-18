Return-Path: <bpf+bounces-12609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842D7CEB3F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984161C20C85
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E963CCE0;
	Wed, 18 Oct 2023 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKer3voR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFC3C08B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 22:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FFC433C7;
	Wed, 18 Oct 2023 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697668112;
	bh=kOr6kBKVTsDGo/Ewz8kI8OgtxzzOHafK+KurBxJCfV4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=hKer3voRhWWEcxhPtyOE+NLlGnF6jr3xISPAMNr4ybU/hA5S6CXivbUBZjcGHBxB6
	 wuYohN9nefPMJfk4aJhNP/cR4rzEzuztuez/hfZL0pqRkkvoh6fcNb1iF4iqJvTdJt
	 3+UjEiB3JaB1dpqP48RZrOT21dOxB1zJpi6sr5d/0sUKUGuNS4V0vh8vC8ouNFAaFN
	 /awoxU/kLjfhQeT9YUfQ7pL2luEG0xvBJWFQGoNzQVjX9VZqrfnINzPbXxomD/Cenz
	 Eh03ihOpiIAtcMo8YBvFv3yQVjW7F+zBXj3atJK8gHCmkpjxNv3DL+iezwHfjJ6B2D
	 FnBUUduSXSBQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F028CE0BB0; Wed, 18 Oct 2023 15:28:32 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:28:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: bpf@vger.kernel.org
Cc: David Vernet <void@manifault.com>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] Fold smp_mb__before_atomic() into atomic_set_release()
Message-ID: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

bpf: Fold smp_mb__before_atomic() into atomic_set_release()

The bpf_user_ringbuf_drain() BPF_CALL function uses an atomic_set()
immediately preceded by smp_mb__before_atomic() so as to order storing
of ring-buffer consumer and producer positions prior to the atomic_set()
call's clearing of the ->busy flag, as follows:

        smp_mb__before_atomic();
        atomic_set(&rb->busy, 0);

Although this works given current architectures and implementations, and
given that this only needs to order prior writes against a later write.
However, it does so by accident because the smp_mb__before_atomic()
is only guaranteed to work with read-modify-write atomic operations,
and not at all with things like atomic_set() and atomic_read().

Note especially that smp_mb__before_atomic() will not, repeat *not*,
order the prior write to "a" before the subsequent non-read-modify-write
atomic read from "b", even on strongly ordered systems such as x86:

        WRITE_ONCE(a, 1);
        smp_mb__before_atomic();
        r1 = atomic_read(&b);

Therefore, replace the smp_mb__before_atomic() and atomic_set() with
atomic_set_release() as follows:

        atomic_set_release(&rb->busy, 0);

This is no slower (and sometimes is faster) than the original, and also
provides a formal guarantee of ordering that the original lacks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: David Vernet <void@manifault.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index f045fde632e5..0ee653a936ea 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -770,8 +770,7 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 	/* Prevent the clearing of the busy-bit from being reordered before the
 	 * storing of any rb consumer or producer positions.
 	 */
-	smp_mb__before_atomic();
-	atomic_set(&rb->busy, 0);
+	atomic_set_release(&rb->busy, 0);
 
 	if (flags & BPF_RB_FORCE_WAKEUP)
 		irq_work_queue(&rb->work);

