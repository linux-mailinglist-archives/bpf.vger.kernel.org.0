Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C73953D5
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhEaCEd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 May 2021 22:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEaCEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 May 2021 22:04:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FFC06174A
        for <bpf@vger.kernel.org>; Sun, 30 May 2021 19:02:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h20so9935899qko.11
        for <bpf@vger.kernel.org>; Sun, 30 May 2021 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcO+zll+a9QMDo+Zj5bTXrtZevlh7VblZTN8enNoy7k=;
        b=QF+S3Svbs6TGFV4mDphU8aRoaLsBGDO6i9orle1SRClQ97aaqR/XblJ+RtMsi2Qzpu
         hnEDR+Llw+rBozFMeqWJ4kOcFstlnx29o1y3sL5lzKkox1Xmm9P3zPCf4g/GU8WdqDu9
         eD1CYUedeFJKGbCbpU6b41z+KpfxIzgdOlxTZvsh01RxmUoW6XIIC2py1HxvAeLWX7JE
         nLXnnrsGHfp1NVV+O8fOE6GQ0wxZsaROX7gV+w/W69Ye8xGQUvENgB9bXO2+hOEMrskQ
         fqgvA8+u/uitc9hbNDnovOXpCmflncawbgeZMd3Xjjw1zkQPgAWZdEDDmv7W+DW1hTOX
         Fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcO+zll+a9QMDo+Zj5bTXrtZevlh7VblZTN8enNoy7k=;
        b=GsnC7nIlMgV5SNNRAd64R8CnhLqgm7xRl0GnTuYfjr8VGtH8lMut8PpQLjATgW6veo
         j5T7s+F+3xjPnqqjecFaKs+Sw6B0rv3KTxoHs0E+mDm2U+qYR3SKRYOBUHSdYVSgmPOK
         rdJS9dFkO0wvgTnrrWFFOo48ndD5u8G2jkC2PyTyDWq3WSOWO2WOUiM2GsYLJKT5carg
         tWJqiAqz3B1KfeRZ3CxUzB5GcdfedIKxuxtenPMCLtLljBssqyMPOdOiaYcM8Z6Dk2aB
         OtwnpXeXIY96kRCYqURF+T2QZ0boJv6KItYsPtlXHnwk4xXgAEIMryGOgO+H5Q43/aOL
         TzNw==
X-Gm-Message-State: AOAM532s6R/u9WGHR2RH6zS2pgdvr4rfcdQb5qD0PtNYXxAgLMVrQzh4
        AhG/F77k2GfGywQ0oD9MPU5akQ==
X-Google-Smtp-Source: ABdhPJwfqLRA4Dj9UbcT5Jyux343K1g8OtUoWQ9ZIVBfiL4ZaJlvjH1uEYqgEuxovFXM98qduIES2g==
X-Received: by 2002:ae9:c30f:: with SMTP id n15mr4283130qkg.71.1622426571513;
        Sun, 30 May 2021 19:02:51 -0700 (PDT)
Received: from ubuntu-vbox.myfiosgateway.com (pool-108-50-174-202.nwrknj.fios.verizon.net. [108.50.174.202])
        by smtp.gmail.com with ESMTPSA id a22sm51079qka.0.2021.05.30.19.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 19:02:51 -0700 (PDT)
From:   hv90@scarletmail.rutgers.edu
X-Google-Original-From: harishankar.vishwanathan@rutgers.edu
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, ecree@solarflare.com,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next] bpf: tnums: Provably sound, faster, and more precise algorithm for tnum_mul
Date:   Sun, 30 May 2021 22:01:57 -0400
Message-Id: <20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu>
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
 kernel/bpf/tnum.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ceac5281bd31..3d7127f439a1 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -111,28 +111,31 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
-/* half-multiply add: acc += (unknown * mask * value).
- * An intermediate step in the multiply algorithm.
+/* Generate partial products by multiplying each bit in the multiplier (tnum a)
+ * with the multiplicand (tnum b), and add the partial products after
+ * appropriately bit-shifting them. Instead of directly performing tnum addition
+ * on the generated partial products, equivalenty, decompose each partial
+ * product into two tnums, consisting of the value-sum (acc_v) and the
+ * mask-sum (acc_m) and then perform tnum addition on them. The following paper
+ * explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
  */
-static struct tnum hma(struct tnum acc, u64 value, u64 mask)
-{
-	while (mask) {
-		if (mask & 1)
-			acc = tnum_add(acc, TNUM(0, value));
-		mask >>= 1;
-		value <<= 1;
-	}
-	return acc;
-}
-
 struct tnum tnum_mul(struct tnum a, struct tnum b)
 {
-	struct tnum acc;
-	u64 pi;
-
-	pi = a.value * b.value;
-	acc = hma(TNUM(pi, 0), a.mask, b.mask | b.value);
-	return hma(acc, b.mask, a.value);
+	u64 acc_v = a.value * b.value;
+	struct tnum acc_m = TNUM(0, 0);
+
+	while (a.value || a.mask) {
+		/* LSB of tnum a is a certain 1 */
+		if (a.value & 1)
+			acc_m = tnum_add(acc_m, TNUM(0, b.mask));
+		/* LSB of tnum a is uncertain */
+		else if (a.mask & 1)
+			acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
+		/* Note: no case for LSB is certain 0 */
+		a = tnum_rshift(a, 1);
+		b = tnum_lshift(b, 1);
+	}
+	return tnum_add(TNUM(acc_v, 0), acc_m);
 }
 
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
-- 
2.25.1

