Return-Path: <bpf+bounces-70670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA40BC9EAB
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2931353F84
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3892EB84A;
	Thu,  9 Oct 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhH1cdRD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65022579E;
	Thu,  9 Oct 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025479; cv=none; b=a3fgs1yymJ3RO1z282K1tFmSlvE15xO+BAJ+SaPvVoKBpybfss8OXFtv40M4uNUHk0MW3qqyyILAL2l3Q8+4Oj3JH/DZfAM0tTtYYEXgOaDP/fNJkttcx1Oi6o8iDlbHRQuqPXqxgDF8YYnob2vtPFndMPWgSRhU1/iPyjWPqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025479; c=relaxed/simple;
	bh=E4nJLrpDeGEx4Xp2TCSoSxry/oM15oaqTZBbcifIkas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhBXAR8N1WJdrYavoS6fiw/g6ZdA4/FO6fh1OnrK3wTT/7c3RF/g0Pd7Lsw26hSPx51NDj02t4edwVTOJ+KMLkWjBk79kFHarQNy3sWjt5O8u+gFLfFXx/dDK90lAXm6VheaTO2kybxWQsqeUC2H6l4QvuiM6acj2mH6NGqO7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhH1cdRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE187C4CEF8;
	Thu,  9 Oct 2025 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025478;
	bh=E4nJLrpDeGEx4Xp2TCSoSxry/oM15oaqTZBbcifIkas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhH1cdRDdgrqKMGm4QcKcxgT4nPWN1K/t32wEZ1cYsw7InhAzStyvi05YZakTj8/J
	 8V47LP84fjJ3wqWWJ5L39bmCA9Hl5UqEIMoJ+Y9uYBI+KwdnjXWurFeNu2o6gQ8TU8
	 qJ/is2SWW5rcuuTNF9WJDSMtR1kj53Th3MnjNtjXlD7RWVnDR1VZddBgi20rrDhSo/
	 Zpfi24O7OJ7YYqmaAGyvC3YfKli0E/piree+xL1N3smMb4jTfIsPnTJJPSODZ6AHJD
	 AYqd27xunWP0W1C0YxFFbjcIxUz7ePkWcNLpHrYGDdkTUZFBCRmKCS5hAk2VW1nq2M
	 2kpfRSsw0uqrg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] bpf: Don't use %pK through printk
Date: Thu,  9 Oct 2025 11:54:30 -0400
Message-ID: <20251009155752.773732-4-sashal@kernel.org>
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 2caa6b88e0ba0231fb4ff0ba8e73cedd5fb81fc8 ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT ANALYSIS

**Backport Status: YES**

### Rationale

This commit should be backported to stable kernel trees based on the
following comprehensive analysis:

### 1. **Part of Kernel-Wide Safety Cleanup**

This is one of 70+ commits in a tree-wide effort to remove incorrect %pK
usage through printk(). The commit addresses a real correctness issue
where %pK format specifier is being misused in a context where it was
never intended.

### 2. **Technical Issue Being Fixed**

The %pK format specifier has specific problems when used through
printk():

**From lib/vsprintf.c:870-878**, the restricted_pointer() function
shows:
```c
/*
 - kptr_restrict==1 cannot be used in IRQ context
 - because its test for CAP_SYSLOG would be meaningless.
 */
if (in_hardirq() || in_serving_softirq() || in_nmi()) {
    if (spec.field_width == -1)
        spec.field_width = 2 * sizeof(ptr);
    return error_string(buf, end, "pK-error", spec);
}
```

This means:
- If `bpf_jit_dump()` is called from interrupt context with
  `kptr_restrict=1`, it outputs "pK-error" instead of the pointer
- The CAP_SYSLOG check in %pK can potentially acquire sleeping locks in
  atomic contexts
- %pK was only designed for seq_file operations (procfs/sysfs), not for
  printk() as documented in Documentation/core-api/printk-formats.rst:94

### 3. **Strong Stable Backporting Precedent**

Similar commits from the same cleanup series have been explicitly
backported to stable:

- **timer_list commit** (a52067c24ccf): Backported to at least 5 stable
  trees (da36c3ad7c177, e563401934e41, 3695ade72a9bc, 41dd0c31ad4a2,
  3fb9ee05ec15f)
- **LoongArch commit** (2362e8124ed21): Tagged with `Cc:
  stable@vger.kernel.org` and backported (248449ba8977c)

Both commits have identical rationale and commit messages, indicating
this class of fix is considered appropriate for stable.

### 4. **Low Risk, High Safety**

The change is minimal and safe:
- **Single line change**: `%pK` → `%p` in include/linux/filter.h:1299
- **No functional logic changes**: Only affects debug output formatting
- **No API changes**: The bpf_jit_dump() function signature remains
  unchanged
- **Improves safety**: Prevents "pK-error" output and potential
  sleeping-in-atomic issues
- **Since 2017**: The %p formatter already hashes addresses (commit
  ad67b74d2469), so no new information leakage

### 5. **Affects Critical Subsystem**

The BPF JIT subsystem is critical for:
- Performance (eBPF program execution)
- Security (sandboxing, filtering)
- Debugging (when developers need JIT dumps)

Having correct debug output is important for troubleshooting BPF JIT
issues.

### 6. **Historical Context**

- **2015** (b13138ef72178a): %pK added to bpf_jit_dump when it was the
  recommended practice
- **2017** (ad67b74d2469): %p improved to hash addresses by default,
  making %pK obsolete for printk()
- **2025**: Tree-wide cleanup to remove obsolete %pK usage from printk()
  calls

### 7. **Matches Stable Kernel Criteria**

From stable kernel rules, this commit:
- ✅ Fixes incorrect API usage (misuse of %pK)
- ✅ Is obviously correct (single format specifier change)
- ✅ Has minimal risk of regression
- ✅ Doesn't introduce new features
- ✅ Part of a series with established backporting precedent

### Code Analysis

The changed code at include/linux/filter.h:1299:
```c
-pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
+pr_err("flen=%u proglen=%u pass=%u image=%p from=%s pid=%d\n", flen,
```

This function is called from arch-specific BPF JIT compilers during JIT
compilation, potentially in contexts where %pK would be problematic.

### Conclusion

This commit should be backported to stable trees because it:
1. Fixes incorrect use of a kernel API (%pK through printk)
2. Prevents potential "pK-error" output in debug messages
3. Aligns with kernel-wide cleanup effort that has stable backporting
   precedent
4. Carries minimal risk while improving code correctness
5. Follows the same pattern as other commits already accepted into
   stable

 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e0..52fecb7a1fe36 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1296,7 +1296,7 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
 				u32 pass, void *image)
 {
-	pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
+	pr_err("flen=%u proglen=%u pass=%u image=%p from=%s pid=%d\n", flen,
 	       proglen, pass, image, current->comm, task_pid_nr(current));
 
 	if (image)
-- 
2.51.0


