Return-Path: <bpf+bounces-70197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F28BB4597
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A7319E3F0D
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887682264CF;
	Thu,  2 Oct 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYqJYnzZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777B1F19A;
	Thu,  2 Oct 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419056; cv=none; b=N3uhE5Ua9Ekk6vFmCS1ED5hgggzxo7UNKv9VUlw6/DKx1h593uTMOHanmzNybe8s7aIR3QWtIYu6la+rxzd71txiZKezILr0mKHbNythI9h+1MiKbdihfiWlyUKJsMOFgaKbpVC68N+46C7C3kOvu4M20a3zMU7ZwbOJtCml/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419056; c=relaxed/simple;
	bh=vh0VVOO9+/7GWA6NXZ2Gf0cH0YvjpZ87GMq2P86zrH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkH7Cr0gM9sDY9OcHTYALi/Sr0Lntjm5mPAb74gDOsUbIZ+/iKuan8/4yGzxlA3ZCFPUXZoGQtA0pJQwI9fKun//DamRmeiNUFnf1nVyJmh4qQWjJMlgoO7LgBqjp36NeWFLF3T2dAFv6t/mwNds7ohELM7NToxpvU9FjkgQC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYqJYnzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F305DC4CEFB;
	Thu,  2 Oct 2025 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419054;
	bh=vh0VVOO9+/7GWA6NXZ2Gf0cH0YvjpZ87GMq2P86zrH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYqJYnzZ1w8DBAyona7bNafm4BWc3nYied2BuWTMMSmdekcl6ywbls5N8SnKajB+z
	 B7qM+cJsPeewJOMXQV3x3od1Ll+5FO9juWsOIZLMKmVWJhETjDmgW2cVKJD7fSWhPH
	 WuuKKfu1WCuRdh6gUenRDsRo9uBVtBrp2Tn5XAfaKayuaN0pYqFFK9TJEhoyzDwc5z
	 maKfJnYayM8ekCD3G7zlaaY1rXQtp5604wiMpUlN9dIZ1vioQQizrp/a/HuCE5/ubF
	 FNmpsWVKPQkngoqmzlb9xDtmqPg14z5wDMx8CTBzmlY3+doZ1KhdwFFzOBskdQRrJp
	 rwX+QkfqUrzxQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	yamada.masahiro@socionext.com,
	michal.lkml@markovi.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kbuild@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] Unbreak 'make tools/*' for user-space targets
Date: Thu,  2 Oct 2025 11:30:08 -0400
Message-ID: <20251002153025.2209281-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002153025.2209281-1-sashal@kernel.org>
References: <20251002153025.2209281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit ee916dccd4df6e2fd19c3606c4735282b72f1473 ]

This pattern isn't very documented, and apparently not used much outside
of 'make tools/help', but it has existed for over a decade (since commit
ea01fa9f63ae: "tools: Connect to the kernel build system").

However, it doesn't work very well for most cases, particularly the
useful "tools/all" target, because it overrides the LDFLAGS value with
an empty one.

And once overridden, 'make' will then not honor the tooling makefiles
trying to change it - which then makes any LDFLAGS use in the tooling
directory break, typically causing odd link errors.

Remove that LDFLAGS override, since it seems to be entirely historical.
The core kernel makefiles no longer modify LDFLAGS as part of the build,
and use kernel-specific link flags instead (eg 'KBUILD_LDFLAGS' and
friends).

This allows more of the 'make tools/*' cases to work.  I say 'more',
because some of the tooling build rules make various other assumptions
or have other issues, so it's still a bit hit-or-miss.  But those issues
tend to show up with the 'make -C tools xyz' pattern too, so now it's no
longer an issue of this particular 'tools/*' build rule being special.

Acked-by: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit, here is my
determination:

## **Backport Status: YES**

### Detailed Analysis

#### Historical Context
The `LDFLAGS=` override was added in commit ea01fa9f63ae (2012) by
Borislav Petkov with the comment "Clear a bunch of variables before
executing the submake." This was done when the tools build system was
first connected to the kernel build system. However, this override is
now obsolete since modern kernel builds use `KBUILD_LDFLAGS` instead of
`LDFLAGS` (Makefile:1447-1448).

#### What the Commit Fixes

**Build Errors**: The commit fixes link errors when using `make
tools/all` or `make tools/<toolname>` from the top-level kernel
directory. By overriding `LDFLAGS=` (setting it to empty), the top-level
Makefile prevents tools' makefiles from setting their own linker flags,
causing link failures.

**Security Issue**: More critically, this prevents distribution-provided
security flags from being applied. As demonstrated by commit
0e0b27dbede5e ("tools/rv: Keep user LDFLAGS in build"), not honoring
`LDFLAGS` causes tools to be built without PIE (Position Independent
Executable), which prevents ASLR (Address Space Layout Randomization) -
a critical security mitigation against ROP attacks.

#### Evidence from Related Commits

Multiple tools have had to work around LDFLAGS issues:
- `d81bab116b485`: tools/bootconfig - explicitly specify LDFLAGS
- `0e0b27dbede5e`: tools/rv - Keep user LDFLAGS (security: PIE not
  enabled)
- `9adc4dc96722b`: tools/runqslower - Fix LDFLAGS usage (caused link
  failures)

#### Alignment with Stable Kernel Rules

From Documentation/process/stable-kernel-rules.rst:

✅ **Line 18-20**: "It fixes a problem like... **a build error** (but not
for things marked CONFIG_BROKEN)"

✅ **Line 18**: "a real **security issue**" - Tools not being built with
PIE/ASLR

✅ **Line 10**: "obviously correct and tested" - Simple 2-line change,
Acked-by Nathan Chancellor

✅ **Line 11**: "cannot be bigger than 100 lines" - Only 4 lines changed
total

#### Risk Assessment

**Risk: VERY LOW**
- Removes obsolete override (kernel hasn't used LDFLAGS since switching
  to KBUILD_LDFLAGS)
- Only affects `make tools/*` pattern from top-level Makefile
- Tools already work correctly with `make -C tools` pattern
- Change makes behavior consistent between both invocation methods

#### Code Analysis

The change at Makefile:1447-1448:
```diff
-$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C
$(srctree)/tools/
+$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
```

This allows tools makefiles like tools/perf/Makefile.perf:528 and
tools/bpf/bpftool/Makefile:186 to properly use `LDFLAGS` during linking,
including distribution-provided flags for hardening (PIE, RELRO, etc.).

### Conclusion

This commit **should be backported** because it:
1. Fixes documented build errors (meets stable rule line 19-20)
2. Addresses a security issue where tools aren't built with hardening
   flags (meets stable rule line 18)
3. Is minimal, safe, and obviously correct
4. Has been Acked by a kernel maintainer
5. Removes technical debt that has caused repeated issues across
   multiple tools

The commit already appears to have been selected for backport via
AUTOSEL (evidenced by `Signed-off-by: Sasha Levin`), which is
appropriate given it fixes both build failures and a security concern.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 82bb9cdf73a32..76dddefde0540 100644
--- a/Makefile
+++ b/Makefile
@@ -1444,11 +1444,11 @@ endif
 
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
-- 
2.51.0


