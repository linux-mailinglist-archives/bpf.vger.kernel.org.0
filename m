Return-Path: <bpf+bounces-2499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55872E1B0
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD661C20C6F
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBB294EE;
	Tue, 13 Jun 2023 11:31:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484E29114
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 11:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C80C433EF;
	Tue, 13 Jun 2023 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686655885;
	bh=Tc9Rv1TKGjNY3wjuYqn/2AHERQ2vFNQgDjss39jIE50=;
	h=From:To:Cc:Subject:Date:From;
	b=URabcveS/jj/V7yTmOldibSZ0Pr0pVMrvttWQz1JB/ABSco8tAh+n5h1E5tdMl+5H
	 xl/uJm+ewi2GFQuvn6CUBCka5FcKYhO7p8Jz9Rd76E6d01lp/rOSPm6SoHcpK8/1Ik
	 063Z3bB4r7u0srZh2YyyxfICal0LlWiBAMLLdmdpPYQaAH9UsI84GXz9AF1k8wjdxp
	 Tg38MoOa9Lj49TCemtnD5S67K+bBksWU0bcn7hiQokVj4q2yELTM/owgQIfzZu9e2/
	 ttFuFOog/8bjH5HkLdm/vCX7EFKDNpy68A0HBpui5z93sYDEeWKhlBkchVJyyti8A5
	 dfvzaM9RR/z3g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Force kprobe multi expected_attach_type for kprobe_multi link
Date: Tue, 13 Jun 2023 13:31:19 +0200
Message-Id: <20230613113119.2348619-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently allow to create perf link for program with
expected_attach_type == BPF_TRACE_KPROBE_MULTI.

This will cause crash when we call helpers like get_attach_cookie or
get_func_ip in such program, because it will call the kprobe_multi's
version (current->bpf_ctx context setup) of those helpers while it
expects perf_link's current->bpf_ctx context setup.

Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
only for programs attaching through kprobe_multi link.

Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with kprobe multi link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0c21d0d8efe4..e8fe04a5db93 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4675,6 +4675,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_perf_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if (attr->link_create.attach_type == BPF_PERF_EVENT)
 			ret = bpf_perf_link_attach(attr, prog);
 		else
-- 
2.40.1


