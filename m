Return-Path: <bpf+bounces-40252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE098442C
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F81F2379F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888BF1A4F29;
	Tue, 24 Sep 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIXNM2k3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110071F5FF
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176059; cv=none; b=eVKG5/nC17kRXAUo6um/xjqxNqY9DNczBb72zkianTgqvx4oashMOGK5n4BJYGTm4AdCK23IWPdOnBnOCRumnH9jz7+peT8P7J4qb/9Hxrw/VFuskj71lD/xNPAFrDdBkAyqxskv0JsD9SxDNkQpo/ujQrDHmakgXwPW12q1otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176059; c=relaxed/simple;
	bh=9X7JIYFJyll421XZX259Qd6ks2dRNi4SBc6zWIWW5Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmrhBzuzlB33x5av5BMXIXvSrfnCwK0IqiLaoStt4SXhRmtQxMM/4QcIKB6g3jrRpiBxdOSRcNihLy/dExCcii28vv83nNHnrbAaurdbENl0ts566PYZ76Xs+el9jNukovaDRbMSZtx82zmW4inViFVwRxqbLSUFUNS3ColxCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIXNM2k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57943C4CEC5;
	Tue, 24 Sep 2024 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727176058;
	bh=9X7JIYFJyll421XZX259Qd6ks2dRNi4SBc6zWIWW5Xs=;
	h=From:To:Cc:Subject:Date:From;
	b=PIXNM2k3eINB1XomYJ2y3gSbnK+EtNZDp4pk+0hAtk8m+MEORbOZH+Og6X6LBoabI
	 y2OtNqQPFJiOMvI7mb+ATOsuZrFGzyChgDdsYeAfCO/xUOlpvIKHb3BONGgCMPpmIj
	 4hBKPb/WAAnQERW0vhwpviJRzyORyabWx/hQ/lv+KfMSoou4iZuabNqe/e+6VOZIG8
	 mhgldCf0vmVjxUqVUQh7DGKsf+IhKjErnXCK6K3DsDtHiUQDJfoQ0QAKej8KcPvSZD
	 jxfd/1vd6V0MAqQl600WnBD8o/fp0RyfW0633HmykgwNOwxfXgsGyc9iX1pDwYwMHD
	 Iyyk9Ef7WfB4g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Fix uprobe consumer test
Date: Tue, 24 Sep 2024 13:07:30 +0200
Message-ID: <20240924110731.2644249-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With newly merged code the uprobe behaviour is slightly different
and affects uprobe consumer test.

We no longer need to check if the uprobe object is still preserved
after removing last uretprobe, because it stays as long as there's
pending/installed uretprobe instance.

This allows to run uretprobe consumers registered 'after' uprobe was
hit even if previous uretprobe got unregistered before being hit.

The uprobe object will be now removed after the last uprobe ref is
released and in such case it's held by ri->uprobe (return instance)
which is released after the uretprobe is hit.

Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Closes: https://lore.kernel.org/bpf/w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyGDkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=@pm.me/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 844f6fc8487b..c1ac813ff9ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -869,21 +869,14 @@ static void consumer_test(struct uprobe_multi_consumers *skel,
 			fmt = "prog 0/1: uprobe";
 		} else {
 			/*
-			 * uprobe return is tricky ;-)
-			 *
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
 			 *   idxs: 2/3 uprobe return in 'installed' mask
-			 *
-			 * in addition if 'after' state removes everything that was installed in
-			 * 'before' state, then uprobe kernel object goes away and return uprobe
-			 * is not installed and we won't hit it even if it's in 'after' state.
 			 */
 			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
-			unsigned long probe_preserved = before & after;  /* did uprobe go away */
 
-			if (had_uretprobes && probe_preserved && test_bit(idx, after))
+			if (had_uretprobes && test_bit(idx, after))
 				val++;
 			fmt = "idx 2/3: uretprobe";
 		}
-- 
2.46.0


