Return-Path: <bpf+bounces-42469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73BD9A484A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A901C20D61
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C7207A3B;
	Fri, 18 Oct 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRL7Xu+/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9918C35F;
	Fri, 18 Oct 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284090; cv=none; b=lXBwC6TuOP1YPVATooj0zdeXTOp6xBdUlAkzTWuFd0OOKJ3ijyZ6gZUce/JNXfUBJTRd1Ux4xcOr6dHLd4tD3gm24InGeGwgtHbcL5VTIhYMfKdnFncl1W+3uxt7yxwF9vUoRNxSpQwp3TX0S9cK6ZOFXrJ2Ni73UOUr/RUOM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284090; c=relaxed/simple;
	bh=duof+l519DJRmJt0vEL9iIZDscSPcBGOX2moFFwv8XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8zx/Q/7mwy0PzD1acafxlDyuzbxfhHbUl+saWSRdBVg6vItdn1mM3SR28diFPi4UOpN6pofKq2vQVA3KMm/FUCBE7W1iaFhSTyzNmClHdhyiWHZ9nwKIjp/dL/+/EljFT1VlDwKaULn0ZIrvdGQiyqpbloa1bAzmyg7+l3eRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRL7Xu+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3D4C4CEC3;
	Fri, 18 Oct 2024 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284089;
	bh=duof+l519DJRmJt0vEL9iIZDscSPcBGOX2moFFwv8XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRL7Xu+//QSDd0Lq7RLnZ6Zue0p/vtdWjX/UShbVCT9ZUNOqD1+D77CMlmEkDat9x
	 PSeaJ5r1ZL1cOHq/whz0yIRFEeJzuwIB36/vpGzTEEQW4W96NR0x8bdyihEVdfg4Ul
	 ik7JYOYQAJNCvYawPL/i11zP9bsjZUoS7Q6PjVPTO93fW3/uizyP2NNG3DY1R7i7PD
	 wg2diRlmwFJHj/1R9w1asikKvNWfx2kyqU+dnFDql8oO5e6ppevRLt/foThCNNGkeY
	 i2IsIufMIKeBttD24F3WC1bybt2O1cMjnuKwdgR/O5a2NzkrS8mAFVXT3K74iWBCIq
	 5AGkzpd/Q3rdw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv8 bpf-next 01/13] bpf: Allow return values 0 and 1 for kprobe session
Date: Fri, 18 Oct 2024 22:40:57 +0200
Message-ID: <20241018204109.713820-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018204109.713820-1-jolsa@kernel.org>
References: <20241018204109.713820-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kprobe session program can return only 0 or 1,
instruct verifier to check for that.

Fixes: 535a3692ba72 ("bpf: Add support for kprobe session attach")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba..5c941fd1b141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15915,6 +15915,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			return -ENOTSUPP;
 		}
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+			range = retval_range(0, 1);
+			break;
+		default:
+			return 0;
+		}
+		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		range = retval_range(SK_DROP, SK_PASS);
 		break;
-- 
2.46.2


