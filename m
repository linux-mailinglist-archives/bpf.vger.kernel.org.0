Return-Path: <bpf+bounces-41622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97B999369
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DEE1F22EDC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49331DFD93;
	Thu, 10 Oct 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4puKX0A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440921CF5C3;
	Thu, 10 Oct 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591042; cv=none; b=ngYGTY4IWHTRS5iy5PNJHddN/TFyKA/AWvRezjNwFERab4TLi+nPtF93fAsSfCn/Q4zLuUbDhjRY74MkSImbHBymkZf7Z6e1spEIOSarCwvnED62UE+DTV6yJBFfzZSl9SQqpQX7sPkJR7uZrd/CT3qXIg0i2iXXMJW1Ix7joyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591042; c=relaxed/simple;
	bh=IpnexFqrLOrJyRd8LUIKHYxqoB4ni1PE1azc1ziZwCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm55sT5BDQUCujVbcqWkcUnxSAIOTQMfbs1UfHxs1L1b3B8JF/5nuqDr1XmoRH5s/iTbxwZOGVU1nyLIlw33Cabdr4tJYzeiOttVGzhkuzjTG5PuAG+mH7xH5SzC3OqmgoESLpTRI/GPOVqhbgc/v13uaIJM9PDw2DtBFCdvkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4puKX0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A13AC4CEC5;
	Thu, 10 Oct 2024 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591042;
	bh=IpnexFqrLOrJyRd8LUIKHYxqoB4ni1PE1azc1ziZwCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4puKX0AuQrDAhsKkXwg3pFC7KccmN3IewO1Sq2xPUILWWbdmo9NCMnjSOB1Qdiv5
	 6H/csdFr93PqqRa3HbpWZRVNOvqtRFfvKW3vgSZarXxYaFtn24jeC/h/4nJbOvhwND
	 YlQT3MTXASjgemUiSgY6zNB0zyZ67RaUzXrtdQpWAE+FUKLEN0FwSRq43gSWTmYGSb
	 u0tgipWmPs4DaGA3+m4bPvFqzTZGf+Qh4TjbO1eDmey2F+Wnd3cg/5Z1IRb7R1+Q6d
	 ty8ehpCu1DS8/9yWWT127nEhtP7FaXfY1BBOz66NDDgYMQlx81CyJHkBP4bvf+lgNt
	 LXFIaSASO7ymw==
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
Subject: [PATCHv6 bpf-next 03/16] bpf: Allow return values 0 and 1 for kprobe session
Date: Thu, 10 Oct 2024 22:09:44 +0200
Message-ID: <20241010200957.2750179-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..787008872a14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15910,6 +15910,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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


