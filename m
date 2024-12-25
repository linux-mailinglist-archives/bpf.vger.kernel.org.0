Return-Path: <bpf+bounces-47601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442CC9FC2E7
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 01:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A97A1981
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310520E6;
	Wed, 25 Dec 2024 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezCGfQiq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B838B;
	Wed, 25 Dec 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735085357; cv=none; b=tMTuvAMuxXz7dbN13A3BvPFscG3UWCiPzgwTR6DpBd4Ag1RTcai4e88yL88b8GmXOYNnaXcUcOWzTrx0Wx94YM/UFlUjQgOJauMUae6Rh5BWHfdXt22qJ0ZfnvdttMEFR5k/bwtBEj7PKlIk/dIvz6rDW2NIOo/ooz1m6+Uq4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735085357; c=relaxed/simple;
	bh=GK5VEoZ6iWvG1OSIhekXapEioZs+guohK0mpEjfLISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqJzzYVg6+yPtunrPgy9SCwTFMxBkGsJ0PcPrBIkVALHRprV5lB+aual5Uo+FfnHxc+pNAPZfIvzmZxyyhBHB4tvyW+2bNtSgZ2d3jP5/VvYCZz/OXn0mGHIg5awiYDaeaYxa0aEmofCv3FHduh/IRakoPmw43L5s4CP4y74560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezCGfQiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56827C4CED0;
	Wed, 25 Dec 2024 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735085356;
	bh=GK5VEoZ6iWvG1OSIhekXapEioZs+guohK0mpEjfLISA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezCGfQiqTE/en1RiCEc7R5OY+XjVsFllB9Bpi2xvVzDWueh6eQAIqo3iMbOe2/dN/
	 IAkvu0d7Uqwzlt3xEoXc2vXSfo7te/Fq7JgtwdO5iqYsJvkafsfQPWvrKLJQqW4X9B
	 I0fBBjJRHPcQY0JLe+4WAVbwNEL0lEAGIGAJXtegg4KQPhOWULLcnMmvXx/o1KPmiH
	 YvRr16RWvstYfnP8Lf+4eToa1y7NwP5XutQRUVqFQjltX0ib4vYU6Vda9CRduErJ2O
	 PdBbpSUUcOYwSY2zP792OyhPReNQoEzgmv3oXFR/DZhkKjRlRIMs9uln0AOTf/1AOd
	 DvDaPHpwFj0og==
Date: Tue, 24 Dec 2024 14:09:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on selftest
Message-ID: <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>

The dsp_local_on selftest expects the scheduler to fail by trying to
schedule an e.g. CPU-affine task to the wrong CPU. However, this isn't
guaranteed to happen in the 1 second window that the test is running.
Besides, it's odd to have this particular exception path tested when there
are no other tests that verify that the interface is working at all - e.g.
the test would pass if dsp_local_on interface is completely broken and fails
on any attempt.

Flip the test so that it verifies that the feature works. While at it, fix a
typo in the info message.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Link: http://lkml.kernel.org/r/Z1n9v7Z6iNJ-wKmq@slm.duckdns.org
---
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c |    5 ++++-
 tools/testing/selftests/sched_ext/dsp_local_on.c     |    5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index 6325bf76f47e..fbda6bf54671 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -43,7 +43,10 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	if (!p)
 		return;
 
-	target = bpf_get_prandom_u32() % nr_cpus;
+	if (p->nr_cpus_allowed == nr_cpus)
+		target = bpf_get_prandom_u32() % nr_cpus;
+	else
+		target = scx_bpf_task_cpu(p);
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 	bpf_task_release(p);
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.c b/tools/testing/selftests/sched_ext/dsp_local_on.c
index 472851b56854..0ff27e57fe43 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.c
@@ -34,9 +34,10 @@ static enum scx_test_status run(void *ctx)
 	/* Just sleeping is fine, plenty of scheduling events happening */
 	sleep(1);
 
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
 	bpf_link__destroy(link);
 
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
 	return SCX_TEST_PASS;
 }
 
@@ -50,7 +51,7 @@ static void cleanup(void *ctx)
 struct scx_test dsp_local_on = {
 	.name = "dsp_local_on",
 	.description = "Verify we can directly dispatch tasks to a local DSQs "
-		       "from osp.dispatch()",
+		       "from ops.dispatch()",
 	.setup = setup,
 	.run = run,
 	.cleanup = cleanup,

