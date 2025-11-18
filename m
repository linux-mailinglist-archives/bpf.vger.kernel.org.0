Return-Path: <bpf+bounces-74963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D85C6981C
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92B6A381F32
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EF279794;
	Tue, 18 Nov 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IQRUfTKQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C62773E5
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470718; cv=none; b=mF8NYp+NJEJ+92Ar2WmElMhRSI4otXMw1G0zj8qO5XdvcVP+Mwre7eq2pzwEYfnMyRhj1nbLYViP1by/iozwJ04osjOGu4zhh00iWm3Q1He3RaGatOj/lJcS9nP+4g+jO8WsY/ExH4aCmq5tQ6lZ4EUTsTlfAcD5OetoDl3bcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470718; c=relaxed/simple;
	bh=1It17VyWxlZt4UP1TPW3kOAhm2nO9vcYweNBkfj4jkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQWRrsoZts9HL5WC/0NaoO7xcP6kJ526ngEnCOlU5LEsIZlaIhTcpjnQqv28erz5UEBmMTCscs0RfZpfR0HrmWadWpuekLEzr8xaODnZdxqqFtRwRkBPIIeNp+tuF3M4iT3kDY7utoPHhqSYFULG9B/sWnIxYDIISHihDWy6s/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IQRUfTKQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763470704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J0WyGvggr4Md2cOrTzy5GTDtDFxSripvoA8F1jrkQLc=;
	b=IQRUfTKQX049clQqn5N4KiP37s/o1KBwFMIDwoVQfcJa5qKzODBX1lL114EeV8X59EtnQN
	vD3Ls5bGqUjSBQzxXUFEHSDzDzS+gY00jhfRRqziqaloHwYML1h3SV2SBkqoMtG1xyKzZO
	rausHYu5KCeYe27rvL/JGkxxuthbbgQ=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_get_task_cmdline kfunc
Date: Tue, 18 Nov 2025 20:58:01 +0800
Message-ID: <20251118125802.385503-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the bpf_get_task_cmdline kfunc. One use case is as follows: In
production environments, there are often short-lived script tasks executed,
and sometimes these tasks may cause stability issues. It is desirable to
detect these script tasks via eBPF. The common approach is to check
the process name, but it can be difficult to distinguish specific
tasks in some cases. Take the shell as an example: some tasks are
started via bash xxx.sh – their process name is bash, but the script
name of the task can be obtained through the cmdline. Additionally,
myabe this is helpful for security auditing purposes.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 865b0dae38d..7cac17d58d5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2685,6 +2685,27 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+/*
+ * bpf_get_task_cmdline - Get the cmdline to a buffer
+ *
+ * @task: The task whose cmdline to get.
+ * @buffer: The buffer to save cmdline info.
+ * @len: The length of the buffer.
+ *
+ * Return: the size of the cmdline field copied. Note that the copy does
+ * not guarantee an ending NULL byte. A negative error code on failure.
+ */
+__bpf_kfunc int bpf_get_task_cmdline(struct task_struct *task, char *buffer, size_t len)
+{
+	int ret;
+
+	ret = get_cmdline(task, buffer, len);
+	if (ret < 0)
+		memset(buffer, 0, len);
+
+	return ret;
+}
+
 /**
  * bpf_task_from_vpid - Find a struct task_struct from its vpid by looking it up
  * in the pid namespace of the current task. If a task is returned, it must
@@ -4421,6 +4442,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_get_task_cmdline, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
 #endif
-- 
2.48.1


