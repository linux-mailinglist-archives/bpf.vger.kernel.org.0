Return-Path: <bpf+bounces-42087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A099F5A9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7111F24863
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049A1F818C;
	Tue, 15 Oct 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="Q5V0zP/z"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A91F8186
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017183; cv=none; b=HpgMi/sFE3/L324Ym1pHynJ/HKRW+DuBcSbFTsNW51MkNGh+tGroFEFPo3GvbUiCgi0CgBFq1597f5M9BrQ4oHE99vKX0OngCz5tf1mMDHhKrLYtZHvcSmp7rNMTSd958kcflrz6EYkZS7uumxEZ0zQ3cjVG19GCCdeeZSGHSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017183; c=relaxed/simple;
	bh=J7VJOvb3+gWByufi8DxEEV+PP5uGJmU9rw04YU01O0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOrT4eFXjBW016qJyeEJM/ld78C+/TN2c0oATEvq1Ytb8J0ZfYQHIA6Z3aGkGM1OMq2US/1NwlO4fMNFpj6fZ5rsjpZJcCW8bgjjeFL6h9Op8dVtOZXwkMwiyR0WAL+OE861WqpoCO2blsj0lZLS1ZjrEPoNxhG3MaH1Kso9jG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=Q5V0zP/z; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729017176; x=1729621976; i=linux@jordanrome.com;
	bh=nPyyMqaCnki3SYCO0WYRERMoEpoqneiuZUKl3/N/e88=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q5V0zP/zTnUkIjsjnlzVHS7gYUnM6U0SKavIpJct+0RGfqQIzX4Bb9xaw6xsPmUM
	 tOut7Qcgj8k87Q+lLm4ffj8MZGyoRvD3OO1e/2gzTdI43AxGaRimJHpisK10Zo2R6
	 hMXa+oMKHlHtBDcKuwJeJlqrMKW3itMWwRcno6+ibo4LaybEhsUrqTzBnDKet28qG
	 1tDGZgSgkIkwSjdkX3eRCRYFVFpuf1Tq0aIz+tyEE+IlFOpGOQCoarorjyNhE2SQD
	 jrZPUeHHHb0reXIpxE6x8VnuUtHBwtECk5dWsfpF/ZeWO+Ss6QGiDKGZDgT+g049+
	 Whpame6m7YNRcZ435Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.1]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mds3H-1tJoBn3RfR-00SVL5; Tue, 15 Oct
 2024 20:27:18 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v1 1/2] bpf: Fix iter/task tid filtering
Date: Tue, 15 Oct 2024 11:27:06 -0700
Message-ID: <20241015182707.1746074-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ziyaXSrTTncumbr9/iR8ZhyQfMjMC6mgaLYDCx0+esR6PwWthf
 jQ+jZl8GQ5mo7PelLSOLVACj501b/6VOQgzWo7K9GC/Ua+8oAiyNL7eypEXd2YKS2a7kLjD
 uAvAk68884/HTxsisPYwQOcHzoiqj5Cz/zhY7QM8dS4Uqif2c1QGtXmBxqSMVuOETixJEF7
 9LKFTVAkn3tsXaQz+B2zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:US1S+TiHZec=;MEEhW3fMLFIP0cBYn4pFS4PbinS
 +ZaN0FyFpCMw/W9wdTXFHXxIgEurYDpkUkSLn5gKGUbgUpGASNZjeYqy+Gy8alBRC0fQyfln8
 BPiSYRVxNcDN3uI6s1AW6C2vUmKnCMn5IWUejQluNagT1S8DRZbZKVrBRQqRHvgtXLkGE3QZl
 M2GQfL7KqyZLljbvxzomSUal/NxoCsavMajBLlx8uW+jib/FZhKx1cC0BGOnyivLs4HwkPjig
 gCa6n6McRCWynT2bMLnDJElAYJhTRv+G37VbNJ9P0i7921/ciKeR4k+UImAi/BD4RnOEgtD6c
 2USG89D4b/Gsb1ZFEUrNrFIchhjwYbFXVwilk1KpaPl2wEiBzoysDVdWUvbw1t21XCPWRdxJn
 sh8f2I6DVS8OZX1tAYakZYVI3dqLjdyELXUVh27AMEOnDojQ0733Yz3o+RLQPFjDu4UEOZulf
 bh55j06F9GRGIIWfsMnPTVtwq5XqpgsG5aSdrgTyRshHCH+2f9lluRphzVYV9hMrBBG+euEGW
 0ugDPLfRlexPaUQdank3EXRmM6nKGQGs5EDKfuLZAo6lAH5u/o8xZUBDI5UZ9DPgvNFl7dulu
 0ByN4z2n9q3Tu2aSH/4Tl8+HiTc/BEAXOmXB2lmvEyyKWjuB4pPwDOpF9PGvpId53spBQQYwS
 yK9p5A8n4adUgMoFQrAeHithkgP+5vIORgZPh0m+luzE/fZDmamLy37CcivKekM+jLoIyVRud
 c3rRxHe2CKhaSxe1+IhLVjiZgOL1T0hng==

In userspace, you can add a tid filter by setting
the "task.tid" field for "bpf_iter_link_info".
However, `get_pid_task` when called for the
`BPF_TASK_ITER_TID` type should have been using
`PIDTYPE_PID` (tid) instead of `PIDTYPE_TGID` (pid).

Fixes: f0d74c4da1f0 ("bpf: Parameterize task iterators.")
Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/task_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 02aa9db8d796..5af9e130e500 100644
=2D-- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -99,7 +99,7 @@ static struct task_struct *task_seq_get_next(struct bpf_=
iter_seq_task_common *co
 		rcu_read_lock();
 		pid =3D find_pid_ns(common->pid, common->ns);
 		if (pid) {
-			task =3D get_pid_task(pid, PIDTYPE_TGID);
+			task =3D get_pid_task(pid, PIDTYPE_PID);
 			*tid =3D common->pid;
 		}
 		rcu_read_unlock();
=2D-
2.43.5


