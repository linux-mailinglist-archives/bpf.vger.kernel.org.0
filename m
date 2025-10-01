Return-Path: <bpf+bounces-70073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0EBAFF3D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 12:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7A41925C17
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5D29BDA5;
	Wed,  1 Oct 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="1j3KHYsF"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8A28C5BE;
	Wed,  1 Oct 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313123; cv=none; b=kcY57nmqDct4mmdWnve6hbaWSvfqsUbbpTg+/0lCF3DAggPJyNOiT80ZxUoYWF0vm39IuJ8EXVlD+0OgujsXi/cmXpFIPszwkUFH7AGh5jOLSfF44jDWOPs400XaSNsrDT7O1137iBYdZBWq+s18IO/l3O8nEJgJVcGA/JQiIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313123; c=relaxed/simple;
	bh=EeZ2kT9K03baj9mnb5Sp5ZkcLYfpDyoTRehkVuytbcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkIkdc/ir7saU6oEs/5ERxXzxi43m4JedrKpRNMTwJWEvHh4tNAxYG35Xgz1ZIQ1t5F2d6jLF3GgU6g+lt+9pnJBSTZMUJGm9nAdF5eO8aIYuOV+aPjfFRW2o/ssMRrNcpLL+FJFmgiAuAww+NGhWfDIM9Wji/tH7XBZYH7yacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=1j3KHYsF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cc9Lp2M5Dz9tJ0;
	Wed,  1 Oct 2025 11:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759312610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhsTKtjFJe1vkO0ON/iAHYtNsvnVj09dnXPTU8Nc+YE=;
	b=1j3KHYsFq7txLDUJt1odXBbaxnKrpMyXe1isTpP9QbQmyDnKQ7JdsaBuKRARJgQsZBXdnB
	RebTuzUactFB4ejQX1vXw7xzvsLFG4SQ/InHmo0KZOTt8pl/wjjx/f9Oukg6LBN59jd6BG
	kqzrI321xA0rPzwgDJ9DKeruXWHe2bXdd4+3C8/DeX4ajmJnGvjPX/aeuJ1wbKXoWVNL5T
	CjkbI7CV07eQh5Ep7lwl5HYgALUKjrSun3QCciqmKDvPVNJP2tsOGFz2WpyV8B6N1cZNZR
	tYzk83reniW9oIwbIJdcvzY+38Z8mLsiJnUeyGsmetk8d20SrI2KEk8XdckItw==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	kafai.wan@linux.dev
Subject: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
Date: Wed,  1 Oct 2025 15:26:12 +0530
Message-ID: <20251001095613.267475-2-listout@listout.xyz>
In-Reply-To: <20251001095613.267475-1-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20251001095613.267475-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In check_alu_op(), the verifier currently calls check_reg_arg() and
adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
However, if the destination register holds a pointer, these scalar
adjustments are unnecessary and potentially incorrect.

This patch adds a check to skip the adjustment logic when the destination
register contains a pointer.

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..4b0924c38657 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15645,7 +15645,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 		/* check dest operand */
-		if (opcode == BPF_NEG) {
+		if (opcode == BPF_NEG &&
+		    !__is_pointer_value(false, &regs[insn->dst_reg])) {
 			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 			err = err ?: adjust_scalar_min_max_vals(env, insn,
 							 &regs[insn->dst_reg],
-- 
2.51.0


