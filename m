Return-Path: <bpf+bounces-74361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8AC56931
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D360E3B82BF
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75129E0E5;
	Thu, 13 Nov 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4zEreGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4611C6FEC
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025928; cv=none; b=t0giWCPZgUzQLj1OPyYIfyTMmNTomPgaqSP5iRkwF1rTpttK+lJRG+ctgAwWTgcNw9sV6AtmJtsQce6Nb76O9cz084Rdj4LxuID2r4KULOll8xs7b6lTNZ3rSWPjB8/42/oQ9ocyRSGEqHhQzfmwLIypUgIEHGZHli84eOE0e8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025928; c=relaxed/simple;
	bh=usK7YafZDyDYuvmToGzRtv6NjdNL5jQp4w1ZlhdJT3w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UcdJogS2JxniUDFXaW9DHfmvHgj2g5m6JYN+GOGnYv236wo0U/wuRWk7c4/zyLRSCO1+ZjjHbcVKaRYUcl2Xq9P6n28FiwpjbQ01vLRFfjh9pFiA8YdLkam4lX8OTyOKazmWzQdlCq0nQPIboOmU3yvmlNzj3n3L2Vy0OAFnZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4zEreGt; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6418122dd7bso1040948a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763025925; x=1763630725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wGxd2Nw7kIfF+X5sboMmEDrcOSvSTGzXLHUe8FP1kYA=;
        b=T4zEreGtSANnp1UFjCCqqkZ6U+kQKtCSGf1AKNXveYK1PbYJ9PnYyb4ZD3UNOZXBJu
         RX+N3jqzbktCKLPf9oXJ7eMKiEB0kHoa66lAvudL/QB9KF2GsSfBz2u9t2vngSvh0NBZ
         1lzp17LEo1REh6gt9KHYr/lZtzdJyv9YjxbIV3SbZ6FWFkVJhINySGTgsMrq6VcuCz/U
         pOuZ70NaVcr6dCrn22ObxuqhKxIzJobC44ihdFVCq32BCkSZsBGglrNeXJMsirbkt2vr
         IKWgJTeT31anKZBGPXWzPqF9vrzOy+9LbKy70+phLn3UMdWt8XOmNkhL/8PP+BOLb7iF
         mOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025925; x=1763630725;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGxd2Nw7kIfF+X5sboMmEDrcOSvSTGzXLHUe8FP1kYA=;
        b=JzwPFA/WJKYd6zLpaLme2SznxXIGHU24AHLD0+fSYCMDUME7Iej8ZSBX0lQy3MFtz7
         rLWTckLp/5Aa38teqTQ4ErkcdFLXBo1kKmuJgi75lkDVQ+o0NbTIEGFPOEjg/P410B3D
         0AGp9BgrFGVrBaeCsYrGFTPkZDhZN8SsoAYstgF9+jfPl9KVfPbmL7F0xmzpGgGAH7+2
         hI/H+OzzVvAeNhaWdT3ScmkD3oovg0YAgij9F2aQGMsw3jIN96V0mNhjKB35kLysOpJW
         aM4DsuhtdFUALfmvNTG6ebO3SM5bXY7LeROFfyO6vgNqMASoumMCGuPyD9reoWgX8aE1
         sEjg==
X-Gm-Message-State: AOJu0YzWS7LkuxIB+xDSM7FwPpWbMXB+fBWIfeB9oyI33A5MAkgVNswJ
	XNecCGAp/sWYD3FO3cFnBEnUxWWhL3EGbFtu7qIsAo57WHlFf+M/BluPmIG/Nv1uDXsR1OM5KZj
	KTSAZ0ALPqQEdR2xFT4rBiJOYMZzAKC1thbZja8H69CHdrbII+B4rLf29mwhuLrSYrDSoUVdY9o
	wVLqHSvwBwyjzGOHiceZAEnJep5RC1+DpZCMy0fQhe17qG3v1XAxOuIchg4+H6VyOMSkxKJA==
X-Google-Smtp-Source: AGHT+IFi5b3KlQVlouj2yD3BMhmIdzuP340OeI3rK0mLgUYGUSNyeOXyIFxG0P8t67OfTt6BTOMbEU30RVlo/m2WgoU7
X-Received: from edo23.prod.google.com ([2002:a05:6402:52d7:b0:641:daeb:121e])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518d:b0:641:72a8:c91b with SMTP id 4fb4d7f45d1cf-6431a5a7522mr5627125a12.34.1763025925483;
 Thu, 13 Nov 2025 01:25:25 -0800 (PST)
Date: Thu, 13 Nov 2025 09:25:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113092519.2632079-1-mattbobrowski@google.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: retry bpf_map_update_elem() when
 E2BIG is returned
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Executing the test_maps binary on platforms with extremely high core
counts may cause intermittent assertion failures in
test_update_delete() (called via test_map_parallel()). This can occur
because bpf_map_update_elem() under some circumstances (specifically
in this case while performing bpf_map_update_elem() with BPF_NOEXIST
on a BPF_MAP_TYPE_HASH with its map_flags set to BPF_F_NO_PREALLOC)
can return an E2BIG error code i.e.

error -7 7 tools/testing/selftests/bpf/test_maps.c:#: void
test_update_delete(unsigned int, void *): Assertion `err == 0' failed.
tools/testing/selftests/bpf/test_maps.c:#: void
__run_parallel(unsigned int, void (*)(unsigned int, void *), void *):
Assertion `status == 0' failed.

As it turns out, is_map_full() which is called from alloc_htab_elem()
can take on a conservative approach when htab->use_percpu_counter is
true (which is the case here because the percpu_counter is used when a
BPF_MAP_TYPE_HASH is created with its map_flags set to
BPF_F_NO_PREALLOC). This conservative approach prioritizes preventing
over-allocation and potential issues that could arise from possibly
exceeding htab->map.max_entries in highly concurrent environments,
even if it means slightly under-utilizing the htab map's capacity.

Given that bpf_map_update_elem() from test_update_delete() can return
E2BIG, update can_retry() such that it also accounts for the E2BIG
error code (specifically only when running with map_flags being set to
BPF_F_NO_PREALLOC). The retry loop will allow the global count
belonging to the percpu_counter to become synchronized and better
reflect the current htab map's capacity.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 3fae9ce46ca9..ccc5acd55ff9 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1399,7 +1399,8 @@ static void test_map_stress(void)
 static bool can_retry(int err)
 {
 	return (err == EAGAIN || err == EBUSY ||
-		(err == ENOMEM && map_opts.map_flags == BPF_F_NO_PREALLOC));
+		((err == ENOMEM || err == E2BIG) &&
+		 map_opts.map_flags == BPF_F_NO_PREALLOC));
 }
 
 int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
-- 
2.51.2.1041.gc1ab5b90ca-goog


