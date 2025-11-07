Return-Path: <bpf+bounces-73982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD7C416E9
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 20:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B1A3B8817
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9270303CBB;
	Fri,  7 Nov 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIBwQuH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B430216C
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543469; cv=none; b=nHuHvOWCFOIs7fXlWSXZa/vW8NziBT+g7RYfzmNu821ZvLVU6VbFn44C/nEylrhxuRejQI3Qx5vS1hUwM7oODtvNNkQ6uIUWUj9Guiv8MBBIY9oJCyZLABL0mcZ95HzELr6ihAQEOB5mitjLZ9TUsttI1BRBvMU6YyK9Ym26K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543469; c=relaxed/simple;
	bh=LOvVjmAZ5MAhtj2ca9vDqUWl9AkVu+va9cbqFU44kKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAZjKsACRUPsd7mc8aSEZS+cSRhC28KujwopDodwdOmHqapfshaak6nOOFD0wp9lfWhNj9lIk3v8I/JOKiTFxVW9siu94w+5mLGfXtqEFA8Ge51D/g4uBsBX7XoE8WOsRB/IJw+rU25mvQNvbpAjE0D0+GeO/Dl4Uvq4ifMHAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIBwQuH0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e896e91368so11478571cf.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543466; x=1763148266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCmaBzQQvD41lWrYJXfLEm28kJch7AJUAU7ZyzHTsQA=;
        b=XIBwQuH0fCxiuSJGJ478qFxVbi6ZsTjsyuCYzLmFsT1+KNOJudXy5zKlpWMW3jK7LS
         /h5jDBx8Z50+Rn6WGAu+HM/CbTB4h2ykWmUoFoDX/Y3bZztj/Ey7O40Ic5iIjlmzfbDB
         O9ayHa6rmSTz+kAS+y3d2SKzsBVJ1j/HrU1GGYiAsL0NRau9CbGz7dTowORaXpvOqIKV
         E11hI9iPh9PCU4f9AxQKCI/zmokdmEDJM+tMXG8pMBZp7Ff4WTnvNDDj4Q3ulupgUM80
         ly/ZIZ/ieLFt5NuUz80WkQOIH9//3QY6hveanXtCDA52qiQNm/JKpY+HVuIY+vtg1jwE
         tZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543466; x=1763148266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TCmaBzQQvD41lWrYJXfLEm28kJch7AJUAU7ZyzHTsQA=;
        b=B3btrrD/U8jrBS4IeT75TvVolgd/TtkN1XY/bmIHJ1kYIKVbvPFfk9lHBnv9BaQRMX
         Fizb4XRU417+2oZ+iDeXwh9mZXae93mywcAwAst+9cx4Pt+aTevyVJmGWtcJCTg3ajvx
         N1v11B9UmpBp86/cIBQi/acMtzngi0LtEud/m+/WNnEhbdFml2632c/vZxnyUowzDhWD
         rt9Mle6E2RnjKXG7MQRYZbRizVHZyJauvmm4aeDI2bB696i/SdtuVik3EKc5lCnvHSPQ
         HZ99rYce2tYo6A3ySVIr9ws0klW6kVDqtBwl7bFu1FsFy3cN/4dKiGT4pp6K3/pS+dAR
         iAGw==
X-Forwarded-Encrypted: i=1; AJvYcCXuZiEeg7AFnJhS3cUF57qOoMOUhf5LG8jvjOl/2RkrMU7qarWDD5cfU/WP7vwPMJoFVOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnrSA1ry1AQJWIxn2kN3N8kf9nqOPbDjLW9t5450ftgWGsgtb
	TnwzUaLEE+mqctdD+oTfh1yyYeooLWjwqLnBkalbjt4PrV0/Yu4Zznxc
X-Gm-Gg: ASbGncvLp8sJQYNDPNNv/oJgAR/ZG7B8Ey92JQLcBc4bKjlJiT98EhxrAuFaW+CQPv2
	BKAUV8D1V1fxT/Rc7DXAyLdfbQ7alEXRtD8dc/+U66n7a4rC4Z/CKbKP3Oksq0buYPU4MgiI5Rh
	B4fasZoO7iUIcoJtE13DOcnOBioEJA6dLCZ1FcnLIsz7jAk9OW/uJEcWl3zoXs3Fo7A2zGycsEm
	5eO2x2aCc3lRuLXrSz5BUMi7qarDteJIbBLmIFvVcW5kSNG7IGUKcmC96eA0bmsMg2Sz2AYzir0
	C+GftuS0h1Q9QpVe8zLnnn1D6HrLxjczCg9eY2fqHh3RRnc5O/bJffi1hXs61qXXTPSRCoRr75a
	eEmNDc+8CyxTfYXZpdkdEnT8M7SMv8xvPM5LjyQ0hyx8BVmVpbqtK4MVYnaqj7QT+G7u5XvQ1uM
	GEALVNEMYyXcMx0tC8pkPsmKjoS3sfiECGc/pzesO9JV0NLsJi/M+lGXM8L5OzAHs0oaHCA7WOb
	m8dhjEY6WSgN6wdZHSRMg==
X-Google-Smtp-Source: AGHT+IHh2qNkWfpzW2xjBtAVFK0LT3qoN3gy8tKHHmONbXSDp33/WjnAgrDQMwxFnd+nkInodHp1VQ==
X-Received: by 2002:ac8:7f84:0:b0:4d3:1b4f:dda1 with SMTP id d75a77b69052e-4eda4ff2f1fmr2654781cf.61.1762543466488;
        Fri, 07 Nov 2025 11:24:26 -0800 (PST)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57bf2cdsm251561cf.31.2025.11.07.11.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:24:26 -0800 (PST)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	paul.chaignon@gmail.com,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] bpf, verifier: Introduce tnum_step to step through tnum's members
Date: Fri,  7 Nov 2025 14:23:28 -0500
Message-ID: <20251107192328.2190680-2-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>
References: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces tnum_step(), a function that, when given t, and a
number z returns the smallest member of t larger than z. The number z
must be greater or equal to the smallest member of t and less than the
largest member of t.

The first step is to compute j, a number that keeps all of t's known
bits, and matches all unknown bits to z's bits. Since j is a member of
the t, it is already a candidate for result. However, we want our result
to be (minimally) greater than z.

There are only two possible cases:

(1) Case j <= z. In this case, we want to increase the value of j and
make it > z.
(2) Case j > z. In this case, we want to decrease the value of j while
keeping it > z.

(Case 1) j <= z

t = xx11x0x0
z = 10111101 (189)
j = 10111000 (184)
         ^
         k

(Case 1.1) Let's first consider the case where j < z. We will address j
== z later.

Since z > j, there had to be a bit position that was 1 in z and a 0 in
j, beyond which all positions of higher significance are equal in j and
z. Further, this position could not have been unknown in a, because the
unknown positions of a match z. This position had to be a 1 in z and
known 0 in t.

Let k be position of the most significant 1-to-0 flip. In our example, k
= 3 (starting the count at 1 at the least significant bit).  Setting (to
1) the unknown bits of t in positions of significance smaller than
k will not produce a result > z. Hence, we must set/unset the unknown
bits at positions of significance higher than k. Specifically, we look
for the next larger combination of 1s and 0s to place in those
positions, relative to the combination that exists in z. We can achieve
this by concatenating bits at unknown positions of t into an integer,
adding 1, and writing the bits of that result back into the
corresponding bit positions previously extracted from z.

From our example, considering only positions of significance greater
than k:

t =  xx..x
z =  10..1
    +    1
     -----
     11..0

This is the exact combination 1s and 0s we need at the unknown bits of t
in positions of significance greater than k. Further, our result must
only increase the value minimally above z. Hence, unknown bits in
positions of significance smaller than k should remain 0. We finally
have,

result = 11110000 (240)

(Case 1.2) Now consider the case when j = z, for example

t = 1x1x0xxx
z = 10110100 (180)
j = 10110100 (180)

Matching the unknown bits of the t to the bits of z yielded exactly z.
To produce a number greater than z, we must set/unset the unknown bits
in t, and *all* the unknown bits of t candidates for being set/unset. We
can do this similar to Case 1.1, by adding 1 to the bits extracted from
the masked bit positions of z. Essentially, this case is equivalent to
Case 1.1, with k = 0.

t =  1x1x0xxx
z =  .0.1.100
    +       1
    ---------
     .0.1.101

This is the exact combination of bits needed in the unknown positions of
t. After recalling the known positions of t, we get

result = 10110101 (181)

(Case 2) j > z

t = x00010x1
z = 10000010 (130)
j = 10001011 (139)
	^
	k

Since j > z, there had to be a bit position which was 0 in z, and a 1 in
j, beyond which all positions of higher significance are equal in j and
z. This position had to be a 0 in z and known 1 in t. Let k be the
position of the most significant 0-to-1 flip. In our example, k = 4.

Because of the 0-to-1 flip at position k, a member of t can become
greater than z if the bits in positions greater than k are themselves >=
to z. To make that member *minimally* greater than z, the bits in
positions greater than k must be exactly = z. Hence, we simply match all
of t's unknown bits in positions more significant than k to z's bits. In
positions less significant than k, we set all t's unknonwn bits to 0
to retain minimality.

In our example, in positions of greater significance than k (=4),
t=x000. These positions are matched with z (1000) to produce 1000. In
positions of lower significance than k, t=10x1. All unknown bits are set
to 0 to produce 1001. The final result is:

result = 10001001 (137)

This concludes the computation for a result > z that is a member of t.

The procedure for tnum_step() in this commit implements the idea
described above. As a proof of correctness, we verified the algorithm
against a logical specification of tnum_step. The specification asserts
the following about the inputs t, z and output res that:

1. res is a member of t, and
2. res is strictly greater than z, and
3. there does not exist another value res2 such that
	3a. res2 is also a member of t, and
	3b. res2 is greater than z
	3c. res2 is smaller than res

We checked the implementation against this logical specification using
an SMT solver. The verification formula in SMTLIB format is available
at [1]. The verification returned an "unsat": indicating that no input
assignment exists for which the implementation and the specification
produce different outputs.

In addition, we also automatically generated the logical encoding of the
C implementation using Agni [2] and verified it against the same
specification. This verification also returned an "unsat", confirming
that the implementation is equivalent to the specification. The formula
for this check is also available at [3].

[1] https://pastebin.com/raw/2eRWbiit
[2] https://github.com/bpfverif/agni
[3] https://pastebin.com/raw/EztVbBJ2

Co-developed-by: Matan Shachnai <m.shachnai@gmail.com>
Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 include/linux/tnum.h |  3 ++-
 kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c52b862dad45..63987f442b4a 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -125,5 +125,6 @@ static inline bool tnum_subreg_is_const(struct tnum a)
 {
 	return !(tnum_subreg(a)).mask;
 }
-
+/* Returns the smallest member of t larger than z. */
+u64 tnum_step(struct tnum t, u64 z);
 #endif /* _LINUX_TNUM_H */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..5c12d7d9ba22 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -253,3 +253,55 @@ struct tnum tnum_const_subreg(struct tnum a, u32 value)
 {
 	return tnum_with_subreg(a, tnum_const(value));
 }
+
+/* Given tnum t, and a number z such that tmin <= z < tmax, where tmin
+ * is the smallest member of the t (= t.value) and tmax is the largest
+ * member of t (= t.value | t.mask) returns the smallest member of t
+ * larger than z.
+ *
+ * For example,
+ * t      = x11100x0
+ * z      = 11110001 (241)
+ * result = 11110010 (242)
+ *
+ * Note: if this function is called with z >= tmax, it just returns
+ * early with tmax; if this function is called with z < tmin, the
+ * algorithm already returns tmin.
+ */
+u64 tnum_step(struct tnum t, u64 z)
+{
+	u64 tmax, j, p, q, r, s, v, u, w, res;
+	u8 k;
+
+	tmax = t.value | t.mask;
+
+	/* if z >= largest member of t, return largest member of t */
+	if (z >= tmax)
+		return tmax;
+
+	/* keep t's known bits, and match all unknown bits to z */
+	j = t.value | z & t.mask;
+
+	if (j > z) {
+		p = ~z & t.value & ~t.mask;
+		k = fls64(p); /* k is the most-significant 0-to-1 flip */
+		q = U64_MAX << k;
+		r = q & z; /* positions > k matched to z */
+		s = ~q & t.value; /* positions <= k matched to t.value */
+		v = r | s;
+		res = v;
+	} else {
+		p = z & ~t.value & ~t.mask;
+		k = fls64(p); /* k is the most-significant 1-to-0 flip */
+		q = U64_MAX << k;
+		r = q & t.mask & z; /* unknown positions > k, matched to z */
+		s = q & ~t.mask; /* known positions > k, set to 1 */
+		v = r | s;
+		/* add 1 to unknown positions > k to make value greater than z */
+		u = v + (1ULL << k);
+		/* extract bits in unknown positions > k from u, rest from t.value */
+		w = u & t.mask | t.value;
+		res = w;
+	}
+	return res;
+}
-- 
2.45.2


