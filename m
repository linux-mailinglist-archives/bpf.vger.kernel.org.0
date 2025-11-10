Return-Path: <bpf+bounces-74105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A54C4961E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D29C3A45F8
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8312FB624;
	Mon, 10 Nov 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Akeb/ucT"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADE2FB0AE;
	Mon, 10 Nov 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809425; cv=none; b=SqzW+J88Cf3AqeFkt9DeFgtijKU9KG1DUP+X7F3Xe9EIcS2dhFU9nZ0c6yWxkNMgpGAJRtA3WjG1btcdN/4UFzow50J8m0LsUrSScQ29+XWajZd3Ex+fpeL/PVbBo/qIXCHLb+M8tREP2W7WEN0zDUtlIJTz86WXNNMO7WhnqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809425; c=relaxed/simple;
	bh=j/GmLtZD81Iakg1ssg53qGb/gdl098Mso9zN3dxXF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCNIhcykPtNBjV5e5Dg0Qvli/rrzm6FwQiZ6ktLZeZxX/lO426BgDDez57TwDoJvUpO3aM3A2+OwbkPNy7m3Ppf0FMcZw1Y5LSF3+9xO42ZgHWMX2O1XCeHhJo1DW2eZBt061vJ/zBPBdWV30kZKPkAgMyPiXb2a7k454qJt14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Akeb/ucT; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d52Y70Q67z9tgM;
	Mon, 10 Nov 2025 22:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1762809419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVpqQbrl3dN+EaWCdEE3H3CfbfxcMD+thTTN9Y4oXtk=;
	b=Akeb/ucTn5gL0dBj/U3LkeUyBQVab++NskUlESsxW4DZf/QH1qzFbQehJjkkU+4oBrRSKh
	7/+eIuoYtCIend49R8rzyJB0rVtjUuhESLZX91oRrD/wASrWg5DdNq/hnYhfY5n/9MfTrd
	jxyVaD7OvGRte88EuDDGp8PieJkQZRoVNtE/vHJ8ghA5y5McSsNzEVUHj1bXz0lLRulsKP
	75R8p8lsJuQlDPiH8lJfRGBlHuJlhKdAyF5N8/8bK/jbb4pVio10B+29/rVg3SX3md/EuZ
	olYsyii1kGxUEFYLTpJBHuhUcRpbugJ+em9NOiFcv3MTKVtU4F5LmS0cewIZMw==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [RFC bpf-next PATCH] bpf: Clamp trace length in __bpf_get_stack to fix OOB write
Date: Tue, 11 Nov 2025 02:46:40 +0530
Message-ID: <20251110211640.963-1-listout@listout.xyz>
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
triggered via bpf_get_stack() when capturing a kernel stack trace.

After the recent refactor that introduced stack_map_calculate_max_depth(),
the code in stack_map_get_build_id_offset() (and related helpers) stopped
clamping the number of trace entries (`trace_nr`) to the number of elements
that fit into the stack map value (`num_elem`).

As a result, if the captured stack contained more frames than the map value
can hold, the subsequent memcpy() would write past the end of the buffer,
triggering a KASAN report like:

    BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
    Write of size N at addr ... by task syz-executor...

Restore the missing clamp by limiting `trace_nr` to `num_elem` before
computing the copy length. This mirrors the pre-refactor logic and ensures
we never copy more bytes than the destination buffer can hold.

No functional change intended beyond reintroducing the missing bound check.

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 kernel/bpf/stackmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81dd..885130e4ab0d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,6 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, size / elem_size);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.51.2


