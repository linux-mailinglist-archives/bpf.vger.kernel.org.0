Return-Path: <bpf+bounces-59541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BC1ACCE82
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69BF1765A6
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784B223301;
	Tue,  3 Jun 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="xig0onIz"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BC2153EA;
	Tue,  3 Jun 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984035; cv=none; b=ELFy+YGdY5DLhbgylEzEMR1STELxv61DVjwdibOVkQv1fyNKNJxkVav6Yr9/y/+Ou1MzD+g62Cn+A3mPHlNx4HLijZng5WzK2e+gQ4c8W96VoY121eg+j/5t3cSTQofGA5isw4abhm9DcvXT9ou3pu52ZS9eqfSNCapWcPu/0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984035; c=relaxed/simple;
	bh=0BP/5dGCz0PCIngKdcnEAonCQdD6pNDUv6FrHnLlfWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikXte/1XXfEhmtO24ZYpcoHu8jQB7XFcPO/IaveQnZ76cg5X/CZqcxNcn/qutnvMySOZ3gcvJ0OvvmTVAwgmLCDqIeiTgfT06qCO50Bl5lGtRwBO2wbgNqSJPZge4RS35I6vMC/1Woz5Jp6SLyjhL0WcLgHPEa9y8trr1sKqPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=xig0onIz; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748983580; bh=7DaMB/8Bf1cVB5O1oatwGQNMO20xEogCqa42wONtoKI=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=xig0onIzdeIMdm9UlibZ5uNfmNCxzj8tUsn97tYmL+98HujpF/us/mKxckBX/7x9a
	 Q7I/cTXye7qPrHTRnqSUV9Fi64TesJKHGUANHo8J/wwjU6N30w38J8ob17Vwg48/dZ
	 798N9vgx6VBIJMO+XzkZHemqEWzS+5qs0pGXhBdbsL/wG7t1Wcd/pz16NMFOM6+O9w
	 iFUVgTCDAZvjBU4e7fPYO//yvseQfAGsvNZpSPqGr8caeSXiA7GPYelE7BtdUBo9iS
	 IJGc3m2aE3I76j67yaXs/Qrdrb577tn/a9Q7pzv+2qEWrHktk95loLIVjXQ/6G/Esa
	 yp9YFF+2ky/Ig==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBjRc2yJlz8slT;
	Tue,  3 Jun 2025 22:46:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/QoQQ0EeRSuWsH6+0EAiEPD2l8zEg0hjM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBjRY1kNcz8st8;
	Tue,  3 Jun 2025 22:46:17 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next] bpf: Clarify sanitize_check_bounds()
Date: Tue,  3 Jun 2025 22:45:57 +0200
Message-ID: <20250603204557.332447-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As is, it appears as if pointer arithmetic is allowed for everything
except PTR_TO_{STACK,MAP_VALUE} if one only looks at
sanitize_check_bounds(). However, this is misleading as the function
only works together with retrieve_ptr_limit() and the two must be kept
in sync. This patch documents the interdependency and adds a check to
ensure they stay in sync.

adjust_ptr_min_max_vals(): Because the preceding switch returns -EACCES
for every opcode except for ADD/SUB, the sanitize_needed() following the
sanitize_check_bounds() call is always true if reached. This means,
unless sanitize_check_bounds() detected that the pointer goes OOB
because of the ADD/SUB and returns -EACCES, sanitize_ptr_alu() always
executes after sanitize_check_bounds().

The following shows that this also implies that retrieve_ptr_limit()
runs in all relevant cases.

Note that there are two calls to sanitize_ptr_alu(), these are simply
needed to easily calculate the correct alu_limit as explained in
commit 7fedb63a8307 ("bpf: Tighten speculative pointer arithmetic
mask"). The truncation-simulation is already performed on the first
call.

In the second sanitize_ptr_alu(commit_window = true), we always run
retrieve_ptr_limit(), unless:

* can_skip_alu_sanititation() is true, notably `BPF_SRC(insn->code) ==
  BPF_K`. BPF_K is fine because it means that there is no scalar
  register (which could be subject to speculative scalar confusion due
  to Spectre v4) that goes into the ALU operation. The pointer register
  can not be subject to v4-based value confusion due to the nospec
  added. Thus, in this case it would have been fine to also skip
  sanitize_check_bounds().

* If we are on a speculative path (`vstate->speculative`) and in the
  second "commit" phase, sanitize_ptr_alu() always just returns 0. This
  makes sense because there are no ALU sanitization limits to be learned
  from speculative paths. Furthermore, because the sanitization will
  ensure that pointer arithmetic stays in (architectural) bounds, the
  sanitize_check_bounds() on the speculative path could also be skipped.

The second case needs more attention: Assume we have some ALU operation
that is used with scalars architecturally, but with a
non-PTR_TO_{STACK,MAP_VALUE} pointer (e.g., PTR_TO_PACKET)
speculatively. It might appear as if this would allow an unsanitized
pointer ALU operations, but this can not happen because one of the
following two always holds:

* The type mismatch stems from Spectre v4, then it is prevented by a
  nospec after the possibly-bypassed store involving the pointer. There
  is no speculative path simulated for this case thus it never happens.

* The type mismatch stems from a Spectre v1 gadget like the following:

    r1 = slow(0)
    r4 = fast(0)
    r3 = SCALAR // Spectre v4 scalar confusion
    if (r1) {
      r2 = PTR_TO_PACKET
    } else {
      r2 = 42
    }
    if (r4) {
      r2 += r3
      *r2
    }

  If `r2 = PTR_TO_PACKET` is indeed dead code, it will be sanitized to
  `goto -1` (as is the case for the r4-if block). If it is not (e.g., if
  `r1 = r4 = 1` is possible), it will also be explored on an
  architectural path and retrieve_ptr_limit() will reject it.

To summarize, the exception for `vstate->speculative` is safe.

Back to retrieve_ptr_limit(): It only allows the ALU operation if the
involved pointer register (can be either source or destination for ADD)
is PTR_TO_STACK or PTR_TO_MAP_VALUE. Otherwise, it returns -EOPNOTSUPP.

Therefore, sanitize_check_bounds() returning 0 for
non-PTR_TO_{STACK,MAP_VALUE} is fine because retrieve_ptr_limit() also
runs for all relevant cases and prevents unsafe operations.

To summarize, we allow unsanitized pointer arithmetic with 64-bit
ADD/SUB for the following instructions if the requirements from
retrieve_ptr_limit() AND sanitize_check_bounds() hold:

* ptr -=/+= imm32 (i.e. `BPF_SRC(insn->code) == BPF_K`)

* PTR_TO_{STACK,MAP_VALUE} -= scalar

* PTR_TO_{STACK,MAP_VALUE} += scalar

* scalar += PTR_TO_{STACK,MAP_VALUE}

To document the interdependency between sanitize_check_bounds() and
retrieve_ptr_limit(), add a verifier_bug_if() to make sure they stay in
sync.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/CAP01T76HZ+s5h+_REqRFkRjjoKwnZZn9YswpSVinGicah1pGJw@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAP01T75oU0zfZCiymEcH3r-GQ5A6GOc6GmYzJEnMa3=53XuUQQ@mail.gmail.com/
---
 kernel/bpf/verifier.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7d6e0c5928b..e31f6b0ccb30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14284,7 +14284,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 		}
 		break;
 	default:
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -14311,7 +14311,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
-	int ret;
+	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
 
@@ -14511,11 +14511,19 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	if (!check_reg_sane_offset(env, dst_reg, ptr_reg->type))
 		return -EINVAL;
 	reg_bounds_sync(dst_reg);
-	if (sanitize_check_bounds(env, insn, dst_reg) < 0)
-		return -EACCES;
+	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
+	if (bounds_ret == -EACCES)
+		return bounds_ret;
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
 				       &info, true);
+		if (verifier_bug_if(!can_skip_alu_sanitation(env, insn)
+				    && !env->cur_state->speculative
+				    && bounds_ret
+				    && !ret,
+				    env, "Pointer type unsupported by sanitize_check_bounds() not rejected by retrieve_ptr_limit() as required")) {
+			return -EFAULT;
+		}
 		if (ret < 0)
 			return sanitize_err(env, insn, ret, off_reg, dst_reg);
 	}

base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
-- 
2.49.0


