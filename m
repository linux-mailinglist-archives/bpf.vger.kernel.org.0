Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACC393C21
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 05:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhE1D5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhE1D5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 23:57:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E89C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 20:55:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w9so1251186qvi.13
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MZayqZcRmqn7l8l4/HGbO4myT4vpr7hBR41Uph4kyE=;
        b=C1Ut5hW2XKt1gQpgRMJKKwcf6TDdOi1YgAYcw9AATI7wNbe7vTrhh1SmZ/qiqDWeqD
         z8PhUQExceevITIrulJGqecDVeHpGQgtxY2RRzPGyJumwnkCXhqLKASZjp4zSpMhdUeW
         66YCsUA6EmwpT2kxLOXPafFjQBeED6NSxnjQ/YWLN2fT5udH45UoJBO16CzhO6WKO4zy
         3BeVyuPmTH0kLavyryQOh6RoTge2YfRrmSI59Iu6gzSCnpv2WYV7YMraEB5bncrJiEZT
         RgabGJ1Wwpll3KUzamu8wt+Rvq5sx0R3QN7t9GWDwuylCpAlbJiB6gRl8AfPjSpTDpFJ
         o5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MZayqZcRmqn7l8l4/HGbO4myT4vpr7hBR41Uph4kyE=;
        b=F1UPfAisM6X16x1KwNk4ku4Sp0hOOYNilDwzvJK1vd+POk/z+BiQKSZXiS8eRHi3cp
         QqmWOBxDo7MwKrIny6e+t00q80w6ASnU+OGAcHJCp9y44XKrTtsVa0ky4GWtSGcsw6c3
         bhFk05YO3Cgcn5fYAqr1JMPUbxtNNJ2D8gzSeYSv2F8riJ3g3iPxhpJeTCh7XTxihnuP
         OlsDPbq3sfXc4qB/PJomPXhrXiH/DolhUgHxoJj6wzQsJzxbluP5nuH0dJwUCJMNzUs9
         oe7X9bhm4nur3beogr3DuN4phHo1/ruwkIH0spPqNx208UdQCPNa0Uc9FNcyPKrt9mfe
         eA/w==
X-Gm-Message-State: AOAM5331iXZo3ZRPZsHp6gphdAASbwGvEI5yRYv31b+MxpeSMLH1u73t
        IdFUG0Hmb8zGbXiNU5pKWhbsTg==
X-Google-Smtp-Source: ABdhPJydgUyMyQm0WVEz2TUdi83NKCLMePoJ8ev3GSqQotQcsVWRSDdfUYl90aYhdiNDQrjP/bf0uw==
X-Received: by 2002:a0c:8e4c:: with SMTP id w12mr1944962qvb.3.1622174146112;
        Thu, 27 May 2021 20:55:46 -0700 (PDT)
Received: from ubuntu-vbox.myfiosgateway.com (pool-108-50-174-202.nwrknj.fios.verizon.net. [108.50.174.202])
        by smtp.gmail.com with ESMTPSA id d16sm2560566qtw.23.2021.05.27.20.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 20:55:45 -0700 (PDT)
From:   hv90@scarletmail.rutgers.edu
X-Google-Original-From: harishankar.vishwanathan@rutgers.edu
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next] bpf: tnums: Provably sound, faster, and more precise algorithm for tnum_mul
Date:   Thu, 27 May 2021 23:55:20 -0400
Message-Id: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>

This patch introduces a new algorithm for multiplication of tristate
numbers (tnums) that is provably sound. It is faster and more precise when
compared to the existing method.

Like the existing method, this new algorithm follows the long
multiplication algorithm. The idea is to generate partial products by
multiplying each bit in the multiplier (tnum a) with the multiplicand
(tnum b), and adding the partial products after appropriately bit-shifting
them. The new algorithm, however, uses just a single loop over the bits of
the multiplier (tnum a) and accumulates only the uncertain components of
the multiplicand (tnum b) into a mask-only tnum. The following paper
explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.

A natural way to construct the tnum product is by performing a tnum
addition on all the partial products. This algorithm presents another
method of doing this: decompose each partial product into two tnums,
consisting of the values and the masks separately. The mask-sum is
accumulated within the loop in acc_m. The value-sum tnum is generated
using a.value * b.value. The tnum constructed by tnum addition of the
value-sum and the mask-sum contains all possible summations of concrete
values drawn from the partial product tnums pairwise. We prove this result
in the paper.

Our evaluations show that the new algorithm is overall more precise
(producing tnums with less uncertain components) than the existing method.
As an illustrative example, consider the input tnums A and B. The numbers
in the paranthesis correspond to (value;mask).

A                = 000000x1 (1;2)
B                = 0010011x (38;1)
A * B (existing) = xxxxxxxx (0;255)
A * B (new)      = 0x1xxxxx (32;95)

Importantly, we present a proof of soundness of the new algorithm in the
aforementioned paper. Additionally, we show that this new algorithm is
empirically faster than the existing method.

Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
---
 kernel/bpf/tnum.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ceac5281bd31..bb1fa1cc181d 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -111,30 +111,30 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
-/* half-multiply add: acc += (unknown * mask * value).
- * An intermediate step in the multiply algorithm.
- */
-static struct tnum hma(struct tnum acc, u64 value, u64 mask)
+struct tnum tnum_mul(struct tnum a, struct tnum b) 
 {
-	while (mask) {
-		if (mask & 1)
-			acc = tnum_add(acc, TNUM(0, value));
-		mask >>= 1;
-		value <<= 1;
-	}
-	return acc;
-}
+	u64 acc_v = a.value * b.value;
+	struct tnum acc_m = TNUM(0, 0);
 
-struct tnum tnum_mul(struct tnum a, struct tnum b)
-{
-	struct tnum acc;
-	u64 pi;
+	while (a.value > 0 || a.mask > 0) {
+
+		// LSB of tnum a is a certain 1
+		if (((a.value & 1) == 1) && ((a.mask & 1) == 0))
+			acc_m = tnum_add(acc_m, TNUM(0, b.mask));
 
-	pi = a.value * b.value;
-	acc = hma(TNUM(pi, 0), a.mask, b.mask | b.value);
-	return hma(acc, b.mask, a.value);
+		// LSB of tnum a is uncertain
+		else if ((a.mask & 1) == 1)
+			acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
+
+		// Note: no case for LSB is certain 0
+		a = tnum_rshift(a, 1);
+		b = tnum_lshift(b, 1);
+	}
+
+	return tnum_add(TNUM(acc_v, 0), acc_m);
 }
 
+
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
  * a 'known 0' - this will return a 'known 1' for that bit.
  */
-- 
2.25.1

