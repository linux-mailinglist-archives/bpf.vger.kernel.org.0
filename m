Return-Path: <bpf+bounces-70045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7EBAD80C
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F7616D8EC
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C030594A;
	Tue, 30 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BYQF3UX5"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4391F152D
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244695; cv=none; b=XnjM5qei6HXzbM92EeFNRfLMd/Th2bs7HgYo1d9WXmyEwUo5OJuUk91o4SZ1Pm70ac5FVKcwdI4POGNkjeSXBqGISoCIUunn/QgElASzi6wfhVetrPFw4TUc6+Uaq8eLNNPUB1ho4VCXq8VL9eGXlFImHMB9OyTYySGMHcY7Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244695; c=relaxed/simple;
	bh=2J+m+KUOe0/Qtk8XxGSTelGZQaGfyxhyyfOSdkx1+I8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eKOkXs/NxygVPx1nDN28pz3vZTovD8kdHRPAQuZNTzESK5VjercIoOWFp2BhViOARPapydp2VSK4L4YzSuSRcPDuwzenkkUbbF3SYdwNzbd+3w37aak3L552c9ofCNQsODh9iev0MQQJoHyGTLasqDr7NmTJC55joV6CucGI1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BYQF3UX5; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759244689;
	bh=ym6iNn1ua3asUIf21e7ENsD/BN82VmDIXPA/hK+Tj78=;
	h=From:To:Cc:Subject:Date;
	b=BYQF3UX5Lrx7yT+KK2haG7a5lmn+y6rlZdp6V1iKQy5mQb13HaRcXHA+ip17fW8zd
	 yY4lnYhUVxahLoO1Qad8trEBCKN5gh6+hWg6YDB/BbCBxu/AwQTJWElAJFr+YYn7JB
	 wGWSBgXcSvf9VOtAkxDPuWuhpqjRNYgLIUOmtEuU=
Received: from wolframium.tail477849.ts.net ([112.10.248.244])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 12E2F4DF; Tue, 30 Sep 2025 23:04:46 +0800
X-QQ-mid: xmsmtpt1759244686t0qfaej2j
Message-ID: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOgyFM6sPB0M50HmrLjpCL3OxeHnWLcKpZcf/LFe4AveIPYTMsiy
	 G21kbVyTK7nFpymsyHOdUo09ooqg2IDiUAIf1hXeiOvZLV+N80fm3/fuB2DoPlPpz/XDGl7RvAJH
	 6+WI3rkA3Sv9bgpUYuC0l9wdjAd2Z3OZMBQSo6qnc1OCxlaxU1lHxCc0hkBe9VMOp4RkrSbi8eOK
	 PZY2PCapI9pSij/kj5SXi/QgoYsJuNjCin8PuvNqkQe/mZH3Au8MTWo1UpQ6vHG2+gc9ooXlGgg7
	 tt7tUru3cQZaf9Do2bJTcbCglTtoM0MDNUOeBmjJsy/z/8RLSsd1BhyVNVDEJTF9yJU28dxui9hL
	 HxONWVDfUX2pDPNGpOS62e1GUDtIF2Lf9XS/hnl/9RC9Q7hr5EvZbvjZxUZFj+ljgMWMmU6nBnns
	 U3BZh1DO5z4PsQ+ndn1rerHYAuZcCJZhmW8fMxXltrvNv2uzhWPk8zGtLV3vfyY8cSDpMfXdOuWc
	 c5Mexu8oRPEM7gUxWacmWGadnt5K7q7ejlozUrN0nEWUXeKr8OvZmulO5vifhrAe/Hrww+3qfeo5
	 CY5i94NUxCBPmeMugQCeTCr2v76EHODLcQK9mFxAc0pNw8C2UX462RL4t5oqxju96Jrp1LtahKM3
	 PlzyZNY9fXFh8GVJz+U/WNbyV/8usp51o8/xzZR33BuCyYG5F5Jwh1HoDuLjnfIWPdqVnLwxXuLB
	 f1ug7i6hAb7vJp+3P0cCD08jxYY1ThVX2mRiXWN5lUdx6WKqZci7u4XQazRCf1++nb8iS5Kx1yPg
	 X3yg9LDIC2+UyB5KraU2L+uym+Ioa2hWhUcMwHderxCbsnBawlTp7q57ZxdBNQIUCFN8IZIr1kWL
	 qqi0+tCtE66BQW+++qCJs1Hlx2PYm47p4Jxho2wq8beiDk3oTsGky6kh1QLJfcx0eq7WlUguRNpV
	 FFIbzqYpyEe0IBM9utgVc2+ZmiDgsQfIer4e3ki16uEAz+DGe8+10qsTIflErwkfx0RiwvOQ/ufo
	 L28CjAj8KwjcWjdqI6+4W4NSaG4iQJ/16d6Aop8jTAHJ/lhxTXybuIj0YLVfU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: yazhoutang@foxmail.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Shenghao Yuan <shenghaoyuan0928@163.com>,
	Tianci Cao <ziye@zju.edu.cn>
Subject: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
Date: Tue, 30 Sep 2025 23:04:33 +0800
X-OQ-MSGID: <20250930150433.139672-1-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazhou Tang <tangyazhou518@outlook.com>

When verifying BPF programs, the check_alu_op() function validates
instructions with ALU operations. The 'offset' field in these
instructions is a signed 16-bit integer.

The existing check 'insn->off > 1' was intended to ensure the offset is
either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
signed, this check incorrectly accepts all negative values (e.g., -1).

This commit tightens the validation by changing the condition to
'(insn->off != 0 && insn->off != 1)'. This ensures that any value
other than the explicitly permitted 0 and 1 is rejected, hardening the
verifier against malformed BPF programs.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9fb1f957a093..8979a84f9253 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15739,7 +15739,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || insn->off > 1 ||
+			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
@@ -15749,7 +15749,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off > 1 ||
+			if (insn->src_reg != BPF_REG_0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
-- 
2.51.0


