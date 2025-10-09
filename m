Return-Path: <bpf+bounces-70682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A3BCA16D
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F452540D46
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C872FB98B;
	Thu,  9 Oct 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHaL1wtJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF91A267;
	Thu,  9 Oct 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025634; cv=none; b=mOyqzpPErSZCDtRyKeqzIxnZbwMyA94Tu8TrUQbFXTfyONKrNSHCml9710dEpsHbCJ5CINJCfqc9dsnPAMC9zUK+URiHh1PX1LsXOq77d1FYlUyJXfB2sstWw4qEOPcMxxLRI7mk06T18qctb5jnEVeO/ZSlAtyERvnqUbX95ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025634; c=relaxed/simple;
	bh=Fi7bHxwuG0E5jp8GLYg02fCOE2rLCCy8GclI9WMQB70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWDLpH/GHekRAmoIrhmcNLRnvlAqjShLQkHKrEOLwMWLVI3FV/DmLp9vjh6t4XjgOfrCXV47ZyOM2ksDLAYUbsjjvSlAKsLbXIas01+i0fneV+T1ocQtGN/pvZGOM+s+uE6nYwXdhIM16RM+KnvU5ICpXLTn/oYnnOVDtlqRvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHaL1wtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7473CC4CEE7;
	Thu,  9 Oct 2025 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025634;
	bh=Fi7bHxwuG0E5jp8GLYg02fCOE2rLCCy8GclI9WMQB70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHaL1wtJBwAyQmcOl6WAOz6FmLioyMfBR5vqH4zZr88PQuWFFIbunnP/tgsNhN181
	 zlKOhdr7VidEeBbYc39YZ9z4G0+1Jnfnwo1BTbXTDJHvqByWzGLLTaurziMYJTG0D7
	 Htr7ZhoAHgWCDgeEYyV/7w524BPJFtbog0+SjSROQT+qoeWA+4Wcx240o7RxLEg/Jp
	 NUsjFxEDtvlGI3wFShRqG2rRVHYIoidAULOPt4U1SdN4jam43RGSaEZzmmLnBKKUou
	 zOlEPz9zdcUhkaeTHBj886wNijdoGvixeAJLibOHzoUKB+CMRdkqb1CDHbZ0XYAhEI
	 5hpDN2glqe+Yw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	maciej.fijalkowski@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh
Date: Thu,  9 Oct 2025 11:55:53 -0400
Message-ID: <20251009155752.773732-87-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Ricardo B. Marlière <rbm@suse.com>

[ Upstream commit 2a912258c90e895363c0ffc0be8a47f112ab67b7 ]

Currently, even if some subtests fails, the end result will still yield
"ok 1 selftests: bpf: test_xsk.sh". Fix it by exiting with 1 if there are
any failures.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/bpf/20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis, here is my determination:

**Backport Status: YES**

## Analysis

### Code Change
The commit adds a simple 2-line fix to ensure the test script exits with
code 1 when failures occur:
```bash
+else
+       exit 1
```

### Rationale for Backporting

**1. Pattern of Similar Backports**
My research shows that similar test exit code fixes have been
consistently backported to stable kernels:
- `selftests/net: have gro.sh -t return a correct exit code` (commit
  784e6abd99f24) was backported by AUTOSEL
- `selftests: ksft: Fix finished() helper exit code on skipped tests`
  (commit 170c966cbe274) was backported by AUTOSEL
- `selftests: xsk: fix reporting of failed tests` (commit 895b62eed2ab4)
  was backported to stable 6.1 branches

**2. Critical for Testing Infrastructure**
This fix addresses a real bug in test reporting that affects:
- **CI/Automated Testing**: Systems running selftests on stable kernels
  rely on correct exit codes to detect regressions
- **False Positives**: The current behavior reports "ok" even when tests
  fail, masking real problems
- **Quality Assurance**: Proper exit codes are essential for stable
  kernel validation

**3. Meets Stable Kernel Rules**
According to Documentation/process/stable-kernel-rules.rst:
- ✅ **Obviously correct**: Trivial 2-line addition with clear intent
- ✅ **Small and contained**: Only 2 lines in a single shell script
- ✅ **Fixes a real bug**: Test infrastructure incorrectly reporting
  success on failures
- ✅ **Already in mainline**: Commit 2a912258c90e exists in upstream
- ✅ **Minimal risk**: Changes only test infrastructure, cannot affect
  kernel runtime
- ✅ **Benefits users**: Helps developers and organizations running tests
  on stable kernels

**4. Historical Evidence**
The commit 8f610b24a1a44 shows this has already been selected by AUTOSEL
for backporting, with the marker `[ Upstream commit
2a912258c90e895363c0ffc0be8a47f112ab67b7 ]` and signed by Sasha Levin.

### Conclusion
This is a clear candidate for stable backporting. It fixes test
infrastructure that provides critical validation for stable kernels,
follows established backporting patterns for similar fixes, and meets
all stable kernel rules criteria.

 tools/testing/selftests/bpf/test_xsk.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 65aafe0003db0..62db060298a4a 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -241,4 +241,6 @@ done
 
 if [ $failures -eq 0 ]; then
         echo "All tests successful!"
+else
+	exit 1
 fi
-- 
2.51.0


