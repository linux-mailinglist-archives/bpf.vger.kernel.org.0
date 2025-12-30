Return-Path: <bpf+bounces-77506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF426CE8DCE
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 08:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6CD730150FB
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5222F8BD0;
	Tue, 30 Dec 2025 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9RqCWbd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F72F90D8
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767078812; cv=none; b=Xi3jwEOWGvuO77+DdBXB9IRsaxhtx78V2smgZMPDzUJKzcIwcird0L4k5N4QDu78WcgcGHniTww0Uygj1UpfEcFMkUUyCdPB6xAMVDg3VgtKLs/8GwgXh3fH1YBRVuoz8FvY/DPDLqq8lVgrHjht1w0FiOBhSE4Ku7WLsyhChB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767078812; c=relaxed/simple;
	bh=XbJg3Omwe2NMszvaXw92dUbRW9jVJsTJnp2CjqNX47c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UH6WmnOusdepB1L5YJCcChifP21fVLZODyH5lEEOhBgacxuoI0fg8MG+mu6MCUSprnqUzxdpvWiPC8VxqhvhPAEFkD0M6k5CW9uM+yLOJXP25QD1wgVX9x5VWCkbfq8d4Z8wcTQZwB0z0KVy66H2n6DS6owyWolU3f8wQ6yJl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9RqCWbd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso8706500a91.1
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767078810; x=1767683610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0h57q58CX2yKohfDk/jbjGjossZDFzfn+uFAddQCU8=;
        b=T9RqCWbdWuIScgn5xnfpC0GJPXTzavk5DsryOvGXzxGJRwVZ9MOJluvj/BAtII0gYk
         k8IJECPnphjaLmxgVAcmnpTDGkcaeFo1530SqkBW+oJ7LyxwpAgB6MMvIunvow1IX6S2
         5EHg0ZHryTsUJkxOBGSdgdG6hFEuIBfhiltCOLtlRDB1cKmfDtXiHWM1V9GUlT+1wRoU
         hHshf9J5dTQ7x/y/hpK3F7Ux74ENgEw4OF2BQKxPv4efR2ukLfpgKbKIaERUzSstotkF
         T4Q1n9bfTUhXhy1Kov0E6QP9pXVRVeoLvr2NR7WLj5jt/64ABj789kTWPF+7TFtWUt0M
         B1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767078810; x=1767683610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0h57q58CX2yKohfDk/jbjGjossZDFzfn+uFAddQCU8=;
        b=dQy73xGXKPWPapzldCSTPoAOwCA7v4xSbJL95sdrIlzBzVvdrk+2rhAXa6OoWvHbga
         JkwwG7KLZHN1ZlEbESkQm8x85KUhqhh5zLqxv1ykWtrO/N6mBSwmSmBiWbvULNifD24W
         KVTZLVgID3CwI/ZQXd2qv7R9qXXudcoyDXw+/nAFAX4HjOu8yLDRgB9lCigE8veBzEXi
         8VxcHUHBwZ7HPyu+Dy0WpZuNCbUrwrUQ1HRbYU6BHXYIxgm+1N7VQR0c2hnvn0RKTvfv
         ty/wEn2gdJAj+WP8BFdy5+GoTZyZWFd4YwiYVxGZoLPxAvtXTR0ELqYpJBeBs0uN0JHd
         fw3w==
X-Gm-Message-State: AOJu0YxjlCuiKUKexqDnAUEfXPtWCenW5c7CPPsBLBJfqduM+04QMQ4j
	04ObXKa5+3Hhm0xdh/gVUmmc885mB+zFkgnXNA3CDDAwEJjmYPBqG6GwcoR6KbyJEl0=
X-Gm-Gg: AY/fxX5oLMz1sFNCWJ8Nnx+T+IDWfJgWtNw4pnmkM8VDk6niaJle49Dcz87RkGUWZu8
	/fCSdMBCxGG9SNvP7ss1/wMcafIbcb4ronzER1PNvxU484hIIaXWjvtqOyAK+zBu6FxLN0dozK/
	OkCEbn5oU6yTfpSl3us6PPijlgQ/FVCKhzG5/p67okmdgpHBEGewFCTaGQ0e62+jEyPlgGnCNaN
	5MchZB6eGdrwm0D5STTFQ+Lx1CBXr5Rw6wuH9jGPL6HVsVjgmJmZE+opJkEs+ybBb5nxrSnGBOC
	jvooyhLQmzAGV+NWwbVRKWS7TsnPm2OocJ5FAK5Tw8qvS5AYvYUka4QOr5WNBNHOcprE+ckraS2
	owF4kXJ9YRMdOqyowXhp4XQh2rk5Me9zLPkNJ7l/2TgzzA7OYP24rZZKvrqBF6PUjil16+ltgb+
	4pjMhdYF8RGgVNbsClqIkZzmI=
X-Google-Smtp-Source: AGHT+IFdIWZ7L2jS8RWH17dL6ONrvnKavPDOMAvIepZZKf5rHf60FLt232HObCO5p/kaXn7NFBUn5g==
X-Received: by 2002:a17:90a:d60c:b0:34c:4c6d:ad0f with SMTP id 98e67ed59e1d1-34e921f0e35mr26407209a91.37.1767078809613;
        Mon, 29 Dec 2025 23:13:29 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7723b3a8sm15578514a91.3.2025.12.29.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 23:13:29 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH 2/2] selftests/bpf: test cases for bpf_loop SCC and state graph backedges
Date: Mon, 29 Dec 2025 23:13:08 -0800
Message-ID: <20251229-scc-for-callbacks-v1-2-ceadfe679900@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Test for state graph backedges accumulation for SCCs formed by
bpf_loop(). Equivalent to the following C program:

  int main(void) {
    1: fp[-8] = bpf_get_prandom_u32();
    2: fp[-16] = -32;                       // used in a memory access below
    3: bpf_loop(7, loop_cb4, fp, 0);
    4: return 0;
  }

  int loop_cb4(int i, void *ctx) {
    5: if (unlikely(ctx[-8] > bpf_get_prandom_u32()))
    6:   *(u64 *)(fp + ctx[-16]) = 42;      // aligned access expected
    7: if (unlikely(fp[-8] > bpf_get_prandom_u32()))
    8:   ctx[-16] = -31;                    // makes said access unaligned
    9: return 0;
  }

If state graph backedges are not accumulated properly at the SCC
formed by loop_cb4() call from bpf_loop(), the state {ctx[-16]=-32}
injected at instruction 9 on verification path 1,2,3,5,7,9,4 would be
considered fully verified and would lack precision mark for ctx[-16].
This would lead to early pruning of verification path 1,2,3,5,7,8,9 in
state {ctx[-16]=-31}, which in turn leads to the incorrect assumption
that the above program is safe.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 7dd92a303bf6b3f0fc2962f6ce6cc453350561e3..69061f0309579eada74e5f2a68640470ff94a8b3 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1926,4 +1926,79 @@ static int loop1_wrapper(void)
 	);
 }
 
+/*
+ * This is similar to a test case absent_mark_in_the_middle_state(),
+ * but adapted for use with bpf_loop().
+ */
+SEC("raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+__naked void absent_mark_in_the_middle_state4(void)
+{
+	/*
+	 * Equivalent to a C program below:
+	 *
+	 * int main(void) {
+	 *   fp[-8] = bpf_get_prandom_u32();
+	 *   fp[-16] = -32;                    // used in a memory access below
+	 *   bpf_loop(7, loop_cb4, fp, 0);
+	 *   return 0;
+	 * }
+	 *
+	 * int loop_cb4(int i, void *ctx) {
+	 *   if (unlikely(ctx[-8] > bpf_get_prandom_u32()))
+	 *     *(u64 *)(fp + ctx[-16]) = 42;   // aligned access expected
+	 *   if (unlikely(fp[-8] > bpf_get_prandom_u32()))
+	 *     ctx[-16] = -31;                 // makes said access unaligned
+	 *   return 0;
+	 * }
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"*(u64 *)(r10 - 8) = r0;"
+		"*(u64 *)(r10 - 16) = -32;"
+		"r1 = 7;"
+		"r2 = loop_cb4 ll;"
+		"r3 = r10;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_loop),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+__used __naked
+static void loop_cb4(void)
+{
+	asm volatile (
+		"r9 = r2;"
+		"r8 = *(u64 *)(r9 - 8);"
+		"r6 = *(u64 *)(r9 - 16);"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 > r8 goto use_fp16_%=;"
+	"1:"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 > r8 goto update_fp16_%=;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+	"use_fp16_%=:"
+		"r1 = r10;"
+		"r1 += r6;"
+		"*(u64 *)(r1 + 0) = 42;"
+		"goto 1b;"
+	"update_fp16_%=:"
+		"*(u64 *)(r9 - 16) = -31;"
+		"goto 2b;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.52.0

