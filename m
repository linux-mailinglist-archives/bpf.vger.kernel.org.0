Return-Path: <bpf+bounces-70676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35885BCA038
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0D4FF15B
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C52F291E;
	Thu,  9 Oct 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMn5za8D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC222688C;
	Thu,  9 Oct 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025563; cv=none; b=Wp8yc47teR/b4BEsQB03sNIwm0mlYmSIc4xZW0LoSL5epvH/TnFri1oscWsUiDGQ9nwY5bx6GDEtHtrkFfwJSn0KG0MzSBrTHpBGhsWODET/zzG09Kwz9tSDLcEIiaJMsxah1pmLcI6yEWVVdz7zCDIYBFslGaUHHAqPniGNnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025563; c=relaxed/simple;
	bh=TpkvX25yGwR/JxwIpFijDFZ154Awx6hGAs5N9knz/8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7W1Isux0VMWwgBE/2kx8Lyd/pTcWLWR69OsiT4p7ewXIB/Z+MgyxqX+UMq9aiECOsTi+4MwL2SHYAYOglW1yQI+/1KOAVlstsj/R+/HdBxZA/m7+utzxFcyFphOuSV3vB0lSZ2WCC7tAPrnt/XVWMcdQoCPjhOG7PLL3rZvl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMn5za8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50EC4CEE7;
	Thu,  9 Oct 2025 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025563;
	bh=TpkvX25yGwR/JxwIpFijDFZ154Awx6hGAs5N9knz/8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMn5za8Dlddpmd1vkzV989ByBIlp+C3WZEiyjPVkPPu9uncJn0lNSqhiQJQpA5ryw
	 Gv1OyD1Fp3yoJX67me5fm0v/Gh+ObB6bwd2rRFGmrjqpI2DMKEE+A6m3z0x7Lvl6pJ
	 1HabGBCj0gMDa9zmELPu2sP0JiJZVIwOiRNIVezcp4cZ/jkwf45qrewSvYVbUPDS27
	 kifhphZb7rwh4/OPHU6PLIpkHVVNoOc66yOgSN4y9/kUbzZ5WD7PhEiBSWwVIIccEv
	 AUJeVo+ljpp/CQIBzJ7gpQxT+WirJ0BjEOSaTd9PGILKuP11kBv9U3olmyhtJvyG/p
	 0crVWE0IKI81g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
Date: Thu,  9 Oct 2025 11:55:14 -0400
Message-ID: <20251009155752.773732-48-sashal@kernel.org>
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

[ Upstream commit 98857d111c53954aa038fcbc4cf48873e4240f7c ]

Commit e9fc3ce99b34 ("libbpf: Streamline error reporting for high-level
APIs") redefined the way that bpf_prog_detach2() returns. Therefore, adapt
the usage in test_lirc_mode2_user.c.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250828-selftests-bpf-v1-1-c7811cd8b98c@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis Complete

**Backport Status: YES**

### Extensive Technical Explanation

#### The Bug and Its Context

This commit fixes a **broken selftest** in `test_lirc_mode2_user.c` that
has been failing since Linux kernel v6.0 (June 2022) - a period of
approximately **3 years**.

#### Historical Timeline of the API Change

**Phase 1 - May 2021 (v5.14)**: Commit e9fc3ce99b34 ("libbpf: Streamline
error reporting for high-level APIs") introduced a new error handling
model for libbpf:

- **Legacy mode (default before v6.0)**: Integer-returning functions
  like `bpf_prog_detach2()` returned `-1` on error and set `errno`
- **Strict mode (LIBBPF_STRICT_DIRECT_ERRS)**: Functions return negative
  error codes directly (e.g., `-ENOENT` instead of `-1`)

The implementation in `libbpf_internal.h` showed:
```c
static inline int libbpf_err_errno(int ret)
{
    if (libbpf_mode & LIBBPF_STRICT_DIRECT_ERRS)
        return ret < 0 ? -errno : ret;  // New behavior
    return ret;  // Legacy: return -1
}
```

**Phase 2 - June 2022 (v6.0)**: Commit bd054102a8c7f ("libbpf: enforce
strict libbpf 1.0 behaviors") **made strict mode the mandatory default**
by removing the conditional logic:

```c
static inline int libbpf_err_errno(int ret)
{
    /* errno is already assumed to be set on error */
    return ret < 0 ? -errno : ret;  // Always strict mode now
}
```

This change is in all stable branches from **v6.0 onwards** (6.0.y,
6.1.y, 6.6.y, 6.12.y, 6.17.y, etc.).

#### The Actual Code Problem
(tools/testing/selftests/bpf/test_lirc_mode2_user.c:77)

**Before the fix** (broken since v6.0):
```c
ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
if (ret != -1 || errno != ENOENT) {  // WRONG: expects ret == -1
    printf("bpf_prog_detach2 not attached should fail: %m\n");
    return 1;
}
```

**After the fix**:
```c
ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
if (ret != -ENOENT) {  // CORRECT: expects ret == -ENOENT
    printf("bpf_prog_detach2 not attached should fail: %m\n");
    return 1;
}
```

#### Why The Test Was Broken

**Execution flow in v6.0+**:
1. `bpf_prog_detach2()` calls `sys_bpf(BPF_PROG_DETACH, ...)`
2. `sys_bpf()` → `syscall(__NR_bpf, ...)` returns `-1`, sets `errno =
   ENOENT`
3. `libbpf_err_errno(-1)` converts: `ret < 0 ? -errno : ret` → returns
   `-ENOENT` (value: -2)
4. Test checks `if (ret != -1 || errno != ENOENT)`:
   - `ret` is `-2` (not `-1`) ✗
   - Condition evaluates to `TRUE`
   - **Test incorrectly fails**

#### Why This Should Be Backported

1. **Fixes a Real Problem**: The test has been incorrectly failing for 3
   years on all v6.0+ kernels, potentially misleading developers who run
   BPF selftests

2. **Minimal Risk**: This is a **1-line change** in a selftest (not
   kernel code), changing only the expected return value check from `-1`
   to `-ENOENT`

3. **Meets Stable Criteria**:
   - ✅ Small (1 line changed)
   - ✅ Obviously correct (adapts test to match documented API behavior)
   - ✅ Fixes a genuine bug (broken test)
   - ✅ Already in mainline (v6.18)

4. **Selftest Policy**: My research shows selftests ARE regularly
   backported to stable kernels. Example commits in stable/linux-6.1.y:
   - `138749a8ff619 selftests/bpf: Fix a user_ringbuf failure with arm64
     64KB page size`
   - `5f3d693861c71 selftests/bpf: Mitigate sockmap_ktls
     disconnect_after_delete failure`

5. **Affects All Active Stable Branches**: Every stable kernel from v6.0
   onwards (including LTS 6.1, 6.6, and 6.12) has the broken test

#### Scope of Backport

This fix should be backported to **all stable kernels v6.0 and later**
that contain commit bd054102a8c7f (libbpf 1.0 enforcement). This
includes:
- linux-6.0.y
- linux-6.1.y (LTS)
- linux-6.6.y (LTS)
- linux-6.12.y (LTS)
- linux-6.13.y through linux-6.17.y

Kernels v5.19 and earlier do NOT need this fix because they still use
legacy mode where `bpf_prog_detach2()` returns `-1`.

 tools/testing/selftests/bpf/test_lirc_mode2_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
index 4694422aa76c3..88e4aeab21b7b 100644
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 
 	/* Let's try detach it before it was ever attached */
 	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
-	if (ret != -1 || errno != ENOENT) {
+	if (ret != -ENOENT) {
 		printf("bpf_prog_detach2 not attached should fail: %m\n");
 		return 1;
 	}
-- 
2.51.0


