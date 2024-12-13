Return-Path: <bpf+bounces-46877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475919F145C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C58D16A38F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D915188596;
	Fri, 13 Dec 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9ffftBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD04632
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112293; cv=none; b=IQIdbVuuFszHz2bn4rnP03MVn3HuyoFt9HBRChytOjTIew41oZ7JfrUKpldfOKqqu6xCTDQzIWOH4/qKgtPMT9BWxctzg1YM5R3XGksY38xy5GnwNK48zyxOiqGQizym8DRTIN8aS/Nw7j51HNv4ggqm9y25tX8i9ExgcsmUrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112293; c=relaxed/simple;
	bh=DDh5IiaWN8I0LNFA7a6VmKickRyA6IkLKQAh6fEXR0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWf0OfN/gALOviwGgUR3DvJFLfVdEuYEb4yi0i17Ju5dUy1Ekv6ceghoVYclLamw58UEYkZBXT+bw/gjoTk5qQ9vQGcOQ7Mlgokw74rzI9yDgIfILpwmYt9NHL7ynmRmd+LzY+cH+u1CDrnrE4c3tOBuhEEg3yqv27GzhFd4o68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9ffftBN; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso14919695e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734112289; x=1734717089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aux7E1Mb/41rrFzY6V39d6KO8c7r/UmSLQpkpLq5Xgw=;
        b=N9ffftBNMdEmvOfvjfeStwkE49cBFk7+N2v1Lsx4g8d6/4fkVOe5E9KGefNrINpqxp
         RB2k+ftu2BH8xwF2QQr0bbNI0aVJzfJEuFuzRXTDvaUHz1J4vdMm79F+61hhEzbW77KT
         fBl43FhflraixqYlCNnP1kXv8AaKaPs9nflQTpxxHoPgqRNK3yzi4AVLfKbnZ93j1Zf+
         n/yqj5xlrwBQgtKUXvznaI5/QhjHLo6Bxdr2bWdmUls0pBBBn06+fmbqI8CuoIBYD0Cx
         ex//SMv7zdDCnF9DD4s3Rm5lcx/W3cWwIGrRV6WDrWnGaFgqgIDgr6jfl/GXDuAM9Z74
         Gwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112289; x=1734717089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aux7E1Mb/41rrFzY6V39d6KO8c7r/UmSLQpkpLq5Xgw=;
        b=If8RA6qyye5QIcdpaYnE0OVHHKgtAvw1trM4SYtO+nuGdaiuNOBu+O4T/Ax7vkiYkv
         CcGq3g9OpkVgImY34bVp+W8RTsdt2xYwgJIsxQZAmEEyj/B3v/V/XIx/lz7D1By3rqu4
         sWCKbE7o+COXCbyhDKl82F5P5f4x5gNz+x6ITM2nheX3XgZtlOp0PX4hVoBeRKMJYEaS
         0BJCPZGLLgTfYetcvEG2TBaA/oQJA4SLxapFBhOGJlbIt+Ffz5IuW8PAaZoOEs0og/pH
         9M5nUyU9NXBbJ5C+Djo0tHLz7yKOA5MJ9EocyDWZERrkBCrXzFKNLx1lPtYMkrSxOM+n
         BsdA==
X-Gm-Message-State: AOJu0YzWYvp7cZPJ6E5ugZsD3gGFicbUdMjmP+i3J23ZtnGyfgGOnIJg
	reJJoV7MtOZycO4/gi0GG9wYal2CFAbgENBpHJLU6AddN+uGRirFgsvC7JXmzZocxw==
X-Gm-Gg: ASbGncsM26wUiyvel/p9WOz8zFBUg0CzXxT6wiQJLzL9B9qPlgGU6ajBsyDtnEykztq
	I9qX50oMIYYMdzXDkU0p3LtRdpCZ0+b/bQvvnPN6LT90uBL0sg4EvGSmyjpQEuYtbNq8UGQbXWa
	iaTg0p0J4kXH7mB90KJiOefK7TPF7uXz1p9YZ/2e5wbq8VPGr4zEmsYsiZz7xYQr39fnHMY43/n
	mFDYg7zw63rByqoFwEjRvn8vV4vr+yAYIWzPHqNztQJ7PQ9aLkRkKLlTa/1uT9Mid2TeSuMtvVD
	f9RSgFLw
X-Google-Smtp-Source: AGHT+IHl8UV/ssKf+iJddG0S9rusjgVyGWA7OPKgqPKKkkFreExBNHCTKFrDcFZSfkGKD1g4lor4wg==
X-Received: by 2002:a05:600c:4fc1:b0:435:194:3cdf with SMTP id 5b1f17b1804b1-4362aa51500mr29260955e9.19.1734112289013;
        Fri, 13 Dec 2024 09:51:29 -0800 (PST)
Received: from localhost (fwdproxy-cln-036.fbsv.net. [2a03:2880:31ff:24::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c54bsm55442095e9.13.2024.12.13.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:51:28 -0800 (PST)
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
Subject: [PATCH bpf v2 0/3] Explicit raw_tp NULL arguments
Date: Fri, 13 Dec 2024 09:51:24 -0800
Message-ID: <20241213175127.2084759-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2857; h=from:subject; bh=DDh5IiaWN8I0LNFA7a6VmKickRyA6IkLKQAh6fEXR0c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXHIpXfb3WNuGCrookUBu202KGVeD9iIoWkkOK2ne oaXyYKKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1xyKQAKCRBM4MiGSL8RynMQD/ 9TjmXKI5CmObtrBYUwJO8tnGJBwSp/kTwN+1k7wuOUhctw1ijh+BkybO+0aDlQbbg8ib9vJyq20t3g NVOqsKy1gQQQg2uvCw+jLYj2abjasV0Fhw7XVTnEEg+i4dz012wFZ04bO+5YE4Qgr2ZKPYe8SJ4n2Z kQkUeWlSCE93kSR0I8QO/gOO48jbOdGTtKti6CQiDbOkQPYJUK5XwBazVc5bIlxkQjJ9Wr5/uWUgM1 4NZokIaFDwNQUTIIU+y/Nh4o3pIRthzL0glyp0xZ5yJpBxU3BiRJ9Few2NvFs8gMgSYaJYHK8Uh1BL MhvqMQF0ZTWrVCLPIl9K35G73UqALljLFTJosS16oriMAlswZwF3FPQFZotT7Bk6yB+Oym3FmQekoz JZCbx143njZR4gw6HV4Yh5F/9IBPzG7lfaRltW/vQK6p3NGEdbgqoD0Dc/pem3rSEr8ig8eHbaYYtw WVwLqFORl3Pl0Jpd0OvwwfYg6D5JnIXqbb+i7/hKb0XAIflzULrk4P4QD28jA2Fz+6mPex9OJLXgHj C5FnXG1VM0aZGDXGYb7b7ahLsAtd9EpNeQJcOmlYwv9SgweHSPFwXKsP6nVNHe3sXq1NWanZFsyqid 7xHLb3ieoMd2/Gk6UWKN8+DKBx6xxD546bxGfDkcCfh67CFkLls8OCO5l8mg==
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
 kernel/bpf/btf.c                              | 141 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  79 +---------
 .../selftests/bpf/prog_tests/raw_tp_null.c    |   3 +
 .../testing/selftests/bpf/progs/raw_tp_null.c |  19 ++-
 .../selftests/bpf/progs/raw_tp_null_fail.c    |  24 +++
 .../bpf/progs/test_tp_btf_nullable.c          |   6 +-
 7 files changed, 181 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c


base-commit: e4c80f69758e5088e8aae48f3d6abb41c6da7812
-- 
2.43.5


