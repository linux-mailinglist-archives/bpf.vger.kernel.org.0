Return-Path: <bpf+bounces-46917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AB9F18F8
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755987A03E0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320A1A8F75;
	Fri, 13 Dec 2024 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIoYbe+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A971A8F60
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128378; cv=none; b=HpzkU9K11HuVdf6zSiLZvzOK4tSVfR3hwzxvDai5ik216aHZqVroPNqI6lsHLZe5rqRjjkSX9lpEa/IuNqvVDFOUtcAjh3wUisArjfKKYMbYQrTBL4naHdXap23gtecSxc5O7NIqeGgMwYjZ0mCZsLHXWpdCuh2bMsHL3L661VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128378; c=relaxed/simple;
	bh=hxNZfzyTuZtn18IqnuLTd61utg5J2kGkVlEyphgATVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpB2f+6UeRpJaVQS72/bGbI/clW1zcjSDh/qn6OE6nE4+RgNgoQ69OCHfx/Vx2nn/cpGqB7ozIJwD1/uvO9KlLsjXxP7Luu15lrMM/0iDfx2xSuJ/lWAGAOciDyvEwIm+7ac0A96q+z7dn4BeSMF19ybx7d+3+A3fswVqV88HEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIoYbe+i; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3863c36a731so1494939f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128374; x=1734733174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtF5/8xwgWar8Zr4sHJ9YDuK1oFjBfUWdOonsc0b5tI=;
        b=PIoYbe+iDInbjmxUSKs1ry1Rl9C7t1NlejI6DZGz9diofXKiWdSR6+dYYaeSSSxWN9
         NORWls3RZKwWTSOxfGz0NwPZh18cMstuS9yircfMW457+OAOzjV9ADGfpN3+65rVp0bT
         BqKyEFywDuvKAxAHFfVsJgHPNiGimOTpXriwhCnDSVNGm8GHzV0894PPW7gR+c0wJc4N
         0V0891r481FBPBJvcdIppD0i/Qo6pXH0qi56P8Rrs9CFsQ8GmqKSiTgxB8di3lK51nvh
         koRp09m7atHdwHi3K3E6UIG87WxT83i8lW5LMYVmUOZ+68Oc+11GM6oWeE7Yw2sT+pfp
         IjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128374; x=1734733174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtF5/8xwgWar8Zr4sHJ9YDuK1oFjBfUWdOonsc0b5tI=;
        b=uqJarsFFpV6v6bQ3r0n3+sY6AsS8GrDhz+acMwPK3bzI+BMcKxrX4+mtUYCr7RNq+D
         1DDxnmw9+pLv0FX6AwOtkOt+6Kj65+tnavfURhJJYaL8z32aADm5oc6JDDQfw4X4hV5f
         z2xsUORHTa8d6xRa3DEAb+LxvgKOfhPvr5XMdhM4oysYMcNvFvfgqKWzErEflMrQeCoQ
         cgfo65K5b6ouDyfKacBhei2AYNQWqQx3oE5JHPNXlmx3sGh6vTLvLkIUaYOuU9VthtYl
         pjXuMiAEfCcK7BfZ9fJEK4SzwjO+EhvVYf5IM8fRHxu9cQJh1sDFp+RhdFeKc6RbX4ze
         9eBQ==
X-Gm-Message-State: AOJu0YyzLqfHO7x9Myoh73cKovsD54+VMNmurG97hnN3IAtghJc5b6ym
	oEz+SYz06bmfneEVkhKPcDyVHRSiuJdXnUjk5phSlagYArDuANIITTiPeLiQFTuFCQ==
X-Gm-Gg: ASbGncsoPwaeFPdZrwqo0WqkbxQfPxfxJ5L9gCwtPR7Ta9R+/SM5EW3p5J0k3lHl6XV
	mfHxy9JjLLh2aNMkA2gVKRP4H6bB+PUWGo/szaMvWMmcdX57ayWw4lVhwh5Q0cIwi3Hwu4DpYfb
	4FzsQonQAqpbFxMF6N2U3vYgCWilE0NdcroRE4E5y8Yd9xfvpbZDMQTv+XBncAaZy3CMIs86toQ
	UyEmMzWNet3k5tM9J4wWAjKk9DcVu/bCARJplb6DJVf6tNDOmqtygPWKpWJ5HExDc8VkU3Ujert
	nrCD+t9N
X-Google-Smtp-Source: AGHT+IEaCIemLlME4jWFg5Gv5KqDWDClLZfNWzFd+Y/3PPTFlb0+jecr7KhCyC2A8cSRxhedFHIR1Q==
X-Received: by 2002:a05:6000:2a8:b0:386:3262:28c6 with SMTP id ffacd0b85a97d-38880ac2d54mr3326358f8f.5.1734128374215;
        Fri, 13 Dec 2024 14:19:34 -0800 (PST)
Received: from localhost (fwdproxy-cln-032.fbsv.net. [2a03:2880:31ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801612esm699987f8f.40.2024.12.13.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:19:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v3 0/3] Explicit raw_tp NULL arguments
Date: Fri, 13 Dec 2024 14:19:26 -0800
Message-ID: <20241213221929.3495062-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990; h=from:subject; bh=hxNZfzyTuZtn18IqnuLTd61utg5J2kGkVlEyphgATVk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXK5kzO7m3vauo/Fr3az7uTo35mwuJXOQBDnMh7Kq ReAPec2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1yuZAAKCRBM4MiGSL8RyribEA C8eiMCf+qxGGQT4k/dPSOKk0xzwGilAdhIwrKidMS2EqZ28EEUm+LEchX7xM/ffz6Z8XlYmv8CxEx0 WihYtbiivjYY9RKsPKkFDKOUUg37As5RDNyx8Rdg0f9yPaBRndxrVh42scsVz0Wz8+KBD/XU+hjXZn ktQXxqSnLoT4lXyaqJxTCwpNZqF04wI1yhlMrmJ2DYjCmKSBnqjhsxRFmepOmCGxd/P1Blp8X58vWX GdKQGV9fUbgjZ/bBgyKhCKHDLKw403v0RUVvvhKcywDncH5ogdyUfNI0k872wOTwtPJV669Q/k+Bxu HJlvkL7KpRUSnLkqWz+zkgv6StIePTmpEQbzy4G1NK8SoOA8KM1rZ/JhPxuLP2mSr6d2D1uphcFb5O J+OpUC+f1l5FsyZqHAZIxcl3Furz5vQkdUC12r9GH2A8TfR/Xr7R8zVFACChkMYBvxFbeY1zNpS3VH BlUtWm2CvphDSEAFPzUOKyIi1dKheEYEcA3qTdg4cxssIsuHhH01pZb6poqR0mkr6IiFAw1qvvW4sQ iBUggSPp/r5qiEPtkSa/nxJI4zpz7020KlXoIlNBZ9ilRYUk8pausoihZpvcinxbBKA3u7BytJ96w6 D5XxYySpYaTyu9XTHqNeH/qG/3Q3OcWHSaDynFyf7BjyglKBZ0ksCNP0suNg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set reverts the raw_tp masking changes introduced in commit
cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL") and
replaces it wwith an explicit list of tracepoints and their arguments
which need to be annotated as PTR_MAYBE_NULL. More context on the
fallout caused by the masking fix and subsequent discussions can be
found in [0].

To remedy this, we implement a solution of explicitly defined tracepoint
and define which args need to be marked NULL or scalar (for IS_ERR
case). The commit logs describes the details of this approach in detail.

We will follow up this solution an approach Eduard is working on to
perform automated analysis of NULL-ness of tracepoint arguments. The
current PoC is available here:

- LLVM branch with the analysis:
  https://github.com/eddyz87/llvm-project/tree/nullness-for-tracepoint-params
- Python script for merging of analysis results:
  https://gist.github.com/eddyz87/e47c164466a60e8d49e6911cff146f47

The idea is to infer a tri-state verdict for each tracepoint parameter:
definitely not null, can be null, unknown (in which case no assumptions
should be made).

Using this information, the verifier in most cases will be able to
precisely determine the state of the tracepoint parameter without any
human effort. At that point, the table maintained manually in this set
can be dropped and replace with this automated analysis tool's result.
This will be kept up to date with each kernel release.

  [0]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com

Changelog:
----------
v2 -> v3:
v2: https://lore.kernel.org/bpf/20241213175127.2084759-1-memxor@gmail.com

 * Address Eduard's nits, add Reviewed-by

v1 -> v2:
v1: https://lore.kernel.org/bpf/20241211020156.18966-1-memxor@gmail.com

 * Address comments from Jiri
   * Mark module tracepoints args NULL by default
   * Add more sunrpc tracepoints
   * Unify scalar or null handling
 * Address comments from Alexei
   * Use bitmask approach suggested in review
   * Unify scalar or null handling
   * Drop most tests that rely on CONFIG options
   * Drop scripts to generate tests

Kumar Kartikeya Dwivedi (3):
  bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
  bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
  selftests/bpf: Add tests for raw_tp NULL args

 include/linux/bpf.h                           |   6 -
 kernel/bpf/btf.c                              | 143 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  79 +---------
 .../selftests/bpf/prog_tests/raw_tp_null.c    |   3 +
 .../testing/selftests/bpf/progs/raw_tp_null.c |  19 ++-
 .../selftests/bpf/progs/raw_tp_null_fail.c    |  24 +++
 .../bpf/progs/test_tp_btf_nullable.c          |   6 +-
 7 files changed, 183 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c


base-commit: e4c80f69758e5088e8aae48f3d6abb41c6da7812
-- 
2.43.5


