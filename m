Return-Path: <bpf+bounces-34180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973C92AD30
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF71F22210
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873193BBC9;
	Tue,  9 Jul 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWnhEdcV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B4381C6;
	Tue,  9 Jul 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485656; cv=none; b=m9nC/3Ywhom7G9o7O2iHfRpxKGnRGkWLrfv+RH6ua35PQ8a8KVPL6dT2XF6Hcd2QCky4ZgvnwkiFRplst3FCiyzTK2aV2JyQ7gn43U3mABu7kLPQL19HGMdb9xB3SIEXzEfNunp/PcveGevzkqZuV4dGJM0aId7FZQG36fpb8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485656; c=relaxed/simple;
	bh=En7eN29oUdhbnGCceIKQVnfVhGbygC/YZrCQo2Gmjqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glzEf/FIRuBzK0nQlR/uJmYviI5QSgKBiyveuBtMAEouovfpeGpnUYlaqRBJvI5vAT+6rva2LzLobnkbUYYkKovCkVG8mbZlC2JkNkPc2u8miIAIiM6l6FArpFdVAkRgqqYj080ub6qfL4sNmx57Hy0XvA8OjMqfcI2fHutsjg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWnhEdcV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75fe9e62048so2350414a12.0;
        Mon, 08 Jul 2024 17:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485654; x=1721090454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrJuM824h69mw3ewTiWt6gkGarmFpPJOs53JqSC/mxs=;
        b=PWnhEdcVJHFmKo30E2Glht7aKntQI4RTFxiIHmpPbjZBX2lOBNmH1ZDgrj5CqSXJF6
         R+3JXPYXX16Cn4spgrKVU+TaTid5ycNGJDuwVQbNfCsKvgPagr28SfWMjKQODUyi9yqw
         6G6HTGtZ8qn6yQA2eRMAGQgAu712gL8Spjy4u7uKlafYPH23w+ZFj7g07Njf0FvTuTRo
         ExRAniPPOyJUy08S3jdqNafv/uUsvg2POdEKnBnDWFENg9di3b4/vqiob5R7+IrzTvBH
         /fCra71a7hND5CYVcfAgdmwhZwysfd4KYmn4URXzxsNBQI1dk+GoFqtbT8hMRnbPlzFM
         uZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485654; x=1721090454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrJuM824h69mw3ewTiWt6gkGarmFpPJOs53JqSC/mxs=;
        b=A13rYgU+VLIuwfXs/brbvIlTXH0SIvZdPwyrVm0+XWlI3hJPYA7Jce8QGXMzC7KAnb
         zWFTWyZgKeSQsM14VDWVNll+0EgRewW/avssIdvVNOx8FE+lGelgbUUs5M555OQZyfGr
         omje5mofOg2+ifjJHCYwvQOFQQSVFJfnZrpYx0diqxh3Mu557hgl8f93R5N+6chnuebW
         A4fVWT7PIdVbeNzGsSz9tb57MPPm7COmmjPaJs7sxTw5xNmE2nTNwx/U6mP4b4hi/59D
         xfjPrkAkNajKbaaMYHN8CaPHVZ2a1r3Av2wDJ49Lhmv2O6B5RTJPGieE/z+bkyGBmx+r
         C7HA==
X-Forwarded-Encrypted: i=1; AJvYcCX4GPGa/5jUL7FVtLh22okLrQGgpyykvcyJM5GSers9UWlgiopmgxgOhqdDny06L0Z9xdVzAKtEpwXAjvNK8emAW24f
X-Gm-Message-State: AOJu0YxzI+lojk2VHq5JnB1GiRF51+68sDS5SdaKG0d7tPq9O6RON5IG
	Xl7WaR44ZK0EEt8eZqndeiuLxGnJNs1R5oaao7vrca2eIaSs/JtK2hvqhA==
X-Google-Smtp-Source: AGHT+IFdvhX3vMGfw1RIxXJDXKc/VcBSvZvqDDRFPuGBkvXLYDuI7nqljcc3g20hxAjInBvKQYR5FA==
X-Received: by 2002:a05:6a20:8422:b0:1c0:e99b:ca66 with SMTP id adf61e73a8af0-1c2984c8751mr1146656637.39.1720485653749;
        Mon, 08 Jul 2024 17:40:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75b3sm4447985ad.129.2024.07.08.17.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:40:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org,
	andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	void@manifault.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>
Subject: [PATCH 3/3] sched_ext/scx_qmap: Add an example usage of DSQ iterator
Date: Mon,  8 Jul 2024 14:40:24 -1000
Message-ID: <20240709004041.1111039-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709004041.1111039-1-tj@kernel.org>
References: <20240709004041.1111039-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement periodic dumping of the shared DSQ to demonstrate the use of the
newly added DSQ iterator.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
---
 tools/sched_ext/scx_qmap.bpf.c | 25 +++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index b1d0b09c966e..27e35066a602 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -36,6 +36,7 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
+const volatile bool print_shared_dsq;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -604,10 +605,34 @@ static void monitor_cpuperf(void)
 	scx_bpf_put_cpumask(online);
 }
 
+/*
+ * Dump the currently queued tasks in the shared DSQ to demonstrate the usage of
+ * scx_bpf_dsq_nr_queued() and DSQ iterator. Raise the dispatch batch count to
+ * see meaningful dumps in the trace pipe.
+ */
+static void dump_shared_dsq(void)
+{
+	struct task_struct *p;
+	s32 nr;
+
+	if (!(nr = scx_bpf_dsq_nr_queued(SHARED_DSQ)))
+		return;
+
+	bpf_printk("Dumping %d tasks in SHARED_DSQ in reverse order", nr);
+
+	bpf_rcu_read_lock();
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV)
+		bpf_printk("%s[%d]", p->comm, p->pid);
+	bpf_rcu_read_unlock();
+}
+
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	monitor_cpuperf();
 
+	if (print_shared_dsq)
+		dump_shared_dsq();
+
 	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 	return 0;
 }
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e4e3ecffc4cf..304f0488a386 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,6 +28,7 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:Pd:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -82,6 +83,9 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'P':
+			skel->rodata->print_shared_dsq = true;
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
-- 
2.45.2


