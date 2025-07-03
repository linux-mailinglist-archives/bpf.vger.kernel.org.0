Return-Path: <bpf+bounces-62345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBDEAF82B5
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F735871AC
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600A2BE7D1;
	Thu,  3 Jul 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkyAaIdd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076029A300
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578577; cv=none; b=WGgXiPec1Tj/Yd23BWac1n6f3ffhQIlPvE7RxE6Wv1em5f5qkxWBzygfvVxr++yrp6X/nZMIS/inZLOhDToplSzd5jCTdY4msEuOi3IH9GNYWtLt+47yiQjJijSHfvHt55JqBo4D1EeOJMhGVONb9pXu4llrY9Q9tTEhpSFqzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578577; c=relaxed/simple;
	bh=oKmXe5ZfCTPUv59m8Yb4yKSLjjvv23HhyWiYrbSezII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLAtNwyxWQV8fpL5npQiS5NQDTTDIoqquDuQuGMArubUzK8pj5V8XTfKGXwu8YswTvYAnU8iksdl46qEF8fPfR3hg3jF/FYggmspaxyl01OwGcyKyJPn2nfHGjeZYDt4Ylh+NpFigFWNXp0O53BnemH27DluwL7l5Cx5B5WcIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkyAaIdd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so244820f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751578574; x=1752183374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oq7RH7gb32fj6VzPZ1IvdqLRwgqwZJeXHrxWfJjd90s=;
        b=mkyAaIdd39ZCentRhAtHNq5zfo87oKU2zIkHIy9yHEVh5gRe37zUnEMYtgr/GbZ+1h
         Ofuvfoq435/H+8opi9g0EmZqxP8K95GpIpTJjSPwu8v0oT6WxFhkdq6O5viCjSHlUjSg
         w26q14mCGfr63kp9fctsnbNvOWyPZhOPuMqb2k1VmuLl+qm9aqnZyaKyCU+6MwOtFlm5
         YRddCsv1NeG9A3j+iL4Fx/SFBkmUdGQXzOyz3m+fEMXnD9seli/dRMLjyIANro/85lSd
         qEPe65RSUG++VoOdqUcnjN1b8pNPOzgyhCUan8VdmkGg0hUyVAu86elkLgT1iENFiZgZ
         pT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578574; x=1752183374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq7RH7gb32fj6VzPZ1IvdqLRwgqwZJeXHrxWfJjd90s=;
        b=YVsZKyJJE+oUIhQAw5TGv0eENr9kcSICNBwpyrddMghVUoJBhL9j7xKW6e32E31yMX
         n28NPtXYXv8ZwSpzXx5I1eyT9gThXNJu/4ilyAlqKhPwd6B+uPQ+Hxxijzz0Qhb0g1rj
         27mIMusIjFlu6JULiYv4JW25NctICOz2jLhSO0G/WPee+oULXS53xMYLyD4fXcWTC1O5
         J0zeiDhS/ytT4GQsz7k7iOZBud5HJfqS95dWdrQ5M/FFxQE2vY/qP7jBceP+afOECg6X
         Hv2rjnsRDtQbz0wpdfFMQMVnxcpFZH8jPBkCWqvnIFn8ZAMtaAjhxIrLyahISUpB10O6
         sJsA==
X-Gm-Message-State: AOJu0YziSCMgrjX12B9QIHQk7RpSgskxvm7OY3YMItAmhpRu5efWFlok
	kL3A7NVejNQZZSpSFgpUGly9S7t+bGCdp553Eh8v9xHi19MI+52m1JAzyta78uua
X-Gm-Gg: ASbGncuwCV7eeJHu53cf/ozSJFOIDRtEOL7y5E0gDesn/Ka9NaIzhZ7Gddosg81qzwj
	lD0SXPlifrzb94B2yRWTsk1z0MRZ/OgCzoiYDRtr7ZJsP5nz7/hxZOcCFWHrulOnUUzsVEZAycO
	yr0GMfqybjr2LZJbFP4+MygHlC2PTu18mnSOpmnXosumpMVp1AuSKriVafm36zyMar3MHUV3pQ3
	czbVHv+DHJQkViQt9oqeyLqWqOeXipUI4fMe40TRotvBpGlvPhoYBdcVl389iQmr6CUsON5N1wT
	jotTJ3ZR5Peq7kbfYMHHlSw/WBCzFJ8vvk2kxF+cB9eHMYp9B4TrQzVDbzNwrQLh56OvuDQXQSz
	2zurGWpeE3ksFINYJfJf5v1b6fB9OcnGb29PKICQYxVVuoY7F3R6O0tQsweTm
X-Google-Smtp-Source: AGHT+IGOrWbB3+wKocklmSA/D/sToYuFW99YIt8cFqlw2cnKpUxz0ZiPsjkwn54t77gTdWDFMUq3dg==
X-Received: by 2002:a5d:5f08:0:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3b495ccb8efmr310906f8f.27.1751578574050;
        Thu, 03 Jul 2025 14:36:14 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00023855d33d1cb3f03.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:2385:5d33:d1cb:3f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97698sm734768f8f.54.2025.07.03.14.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:36:13 -0700 (PDT)
Date: Thu, 3 Jul 2025 23:36:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Negative test case for tail call
 map
Message-ID: <7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com>
References: <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>

This patch adds a negative test case for the following verifier error.

    expected prog array map for tail call

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index f3492efc8834..d0771da83a2f 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2433,3 +2433,16 @@
 	.errstr = "more than one arg with ref_obj_id",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"calls: wrong map type for tail call",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_LD_MAP_FD(BPF_REG_2, 0),
+	BPF_EMIT_CALL(BPF_FUNC_tail_call),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = REJECT,
+	.errstr = "expected prog array map for tail call",
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
-- 
2.43.0


