Return-Path: <bpf+bounces-3768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B3743749
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AE01C20B87
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867EA957;
	Fri, 30 Jun 2023 08:34:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3853A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C19C433C0;
	Fri, 30 Jun 2023 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114042;
	bh=uDN6AaA9M+nq9NqvKkWvbz3C59dBzJ3U6YaBwDwtGaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn6bBhxeS7fk4Xj5242liE+3J23vIzlDr9YHaBy4APsqa56nhPaSDlt2f8X/1KYQB
	 YYbbgQAIZh5WnVyORkE1+2rNsiumm00SvfjFXa83cJPbJ2f+WrmFD3k9Ri7QaECMs0
	 ANSKSQ2dygHBKJ37uic7LAaUBx2/5P/BaFEKMMbGf1/68TgVRVv64DGo12s0dmPRiW
	 LLwGBlAY4tzzgZlBBlHhhukpcPQmL0dghTPTUJXkjOV0LOYmbhx84h3cA3gnQ1ENm4
	 BeEwW8MOCKq9wR+eSgHJ+mpMNlbKXihNKCYKnQOwos3dFVyp+EaDzjG45Hk80YqDXY
	 zTsPfUK1V2sgw==
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
Subject: [PATCHv3 bpf-next 01/26] bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
Date: Fri, 30 Jun 2023 10:33:19 +0200
Message-ID: <20230630083344.984305-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra attach_type checks from link_create under
bpf_prog_attach_check_attach_type.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c | 108 +++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 61 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..9046ad0f9b4e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3502,34 +3502,6 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	return fd;
 }
 
-static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
-					     enum bpf_attach_type attach_type)
-{
-	switch (prog->type) {
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-	case BPF_PROG_TYPE_SK_LOOKUP:
-		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
-	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
-			/* cg-skb progs can be loaded by unpriv user.
-			 * check permissions at attach time.
-			 */
-			return -EPERM;
-		return prog->enforce_expected_attach_type &&
-			prog->expected_attach_type != attach_type ?
-			-EINVAL : 0;
-	case BPF_PROG_TYPE_KPROBE:
-		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
-		    attach_type != BPF_TRACE_KPROBE_MULTI)
-			return -EINVAL;
-		return 0;
-	default:
-		return 0;
-	}
-}
-
 static enum bpf_prog_type
 attach_type_to_prog_type(enum bpf_attach_type attach_type)
 {
@@ -3593,6 +3565,53 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	}
 }
 
+static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
+					     enum bpf_attach_type attach_type)
+{
+	enum bpf_prog_type ptype;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		if (!capable(CAP_NET_ADMIN))
+			/* cg-skb progs can be loaded by unpriv user.
+			 * check permissions at attach time.
+			 */
+			return -EPERM;
+		return prog->enforce_expected_attach_type &&
+			prog->expected_attach_type != attach_type ?
+			-EINVAL : 0;
+	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		if (attach_type != BPF_PERF_EVENT &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		return 0;
+	case BPF_PROG_TYPE_EXT:
+		return 0;
+	case BPF_PROG_TYPE_NETFILTER:
+		if (attach_type != BPF_NETFILTER)
+			return -EINVAL;
+		return 0;
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_TRACEPOINT:
+		if (attach_type != BPF_PERF_EVENT)
+			return -EINVAL;
+		return 0;
+	default:
+		ptype = attach_type_to_prog_type(attach_type);
+		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type)
+			return -EINVAL;
+		return 0;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
 
 #define BPF_F_ATTACH_MASK \
@@ -4658,7 +4677,6 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
-	enum bpf_prog_type ptype;
 	struct bpf_prog *prog;
 	int ret;
 
@@ -4677,38 +4695,6 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (ret)
 		goto out;
 
-	switch (prog->type) {
-	case BPF_PROG_TYPE_EXT:
-		break;
-	case BPF_PROG_TYPE_NETFILTER:
-		if (attr->link_create.attach_type != BPF_NETFILTER) {
-			ret = -EINVAL;
-			goto out;
-		}
-		break;
-	case BPF_PROG_TYPE_PERF_EVENT:
-	case BPF_PROG_TYPE_TRACEPOINT:
-		if (attr->link_create.attach_type != BPF_PERF_EVENT) {
-			ret = -EINVAL;
-			goto out;
-		}
-		break;
-	case BPF_PROG_TYPE_KPROBE:
-		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
-		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
-			ret = -EINVAL;
-			goto out;
-		}
-		break;
-	default:
-		ptype = attach_type_to_prog_type(attr->link_create.attach_type);
-		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
-			ret = -EINVAL;
-			goto out;
-		}
-		break;
-	}
-
 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
-- 
2.41.0


