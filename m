Return-Path: <bpf+bounces-47988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC9A02F51
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90FE164032
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A711DE8B0;
	Mon,  6 Jan 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4cd8LWT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDD4A0C;
	Mon,  6 Jan 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185855; cv=none; b=rIb4+h67U3D/p9bXfS4yh2JZJ4IUG0dWzYMK6Tx7RGbuTFuRoi+v8KtqchOfe7el83rN0B9gSh2bvFNaU/pBjmZFSZKM9n2nBlEQNNc1cNLSsCxy6Yf+KSD4wZPIZgrkhQ0m+eVBTPvDZwsUJRD3+kbpd+8CVFZjgggYb/EoPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185855; c=relaxed/simple;
	bh=TRtW8/9BwFZwtdlWRGqcUKIsNHklKQHW+AZk0cQ0up4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D62R2U0eeHHNjwK4ouKXK9c3Fh11Hpw1Kw3z0WWfTWvftV+banxwkyw603RYX7FxpZnnCAZTMyuF9orIouRXnHDiO9/hUqw9qx2fENsNsFfdwaoDtaD3hA7Yk36vGyqSskDiJ6nhkzhgNd+whP2ZuTao/McFIILyfD9yGNXPRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4cd8LWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226B4C4CED2;
	Mon,  6 Jan 2025 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736185854;
	bh=TRtW8/9BwFZwtdlWRGqcUKIsNHklKQHW+AZk0cQ0up4=;
	h=From:To:Cc:Subject:Date:From;
	b=V4cd8LWTiSKmGe6np3Mjbef/eZ6S31mr3fOwTSabLHtzuYaEJdiAQFAB0YVSNPhcj
	 wYpVSe7dsJ1e6LzJ6+v53TWKJ/Ovd38GUfsHKE/WdhZK7Xf5apHpUu//Qy+/jfbFG3
	 LvMYWLSdyzLu6J4B1Y0dp8vojlPZGVhhEPRtBZJ5/pEtMXu8xIV2MYTY4dxRhKmv+/
	 r81OieoOYwHSQK81ByWG359MyGB5YNewtTHydEXPEWAvLUBCIcD8vCRG3nC0tOw8kW
	 htvX7LOZrGT1jGmRJM1oK6U2nuaX40i8NA9I1OZD42DFuCdH/VsEgTffubrWzu4CXr
	 momx+7ZMEDWNw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi bpf program execution
Date: Mon,  6 Jan 2025 18:50:47 +0100
Message-ID: <20250106175048.1443905-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kprobe multi bpf program can't be executed due to recursion check,
we currently return 0 (success) to fprobe layer where it's ignored for
standard kprobe multi probes.

For kprobe session the success return value will make fprobe layer to
install return probe and try to execute it as well.

But the return session probe should not get executed, because the entry
part did not run. FWIW the return probe bpf program most likely won't get
executed, because its recursion check will likely fail as well, but we
don't need to run it in the first place.. also we can make this clear
and obvious.

It also affects missed counts for kprobe session program execution, which
are now doubled (extra count for not executed return probe).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 48db147c6c7d..1f3d4b72a3f2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2797,7 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		bpf_prog_inc_misses_counter(link->link.prog);
-		err = 0;
+		err = 1;
 		goto out;
 	}
 
-- 
2.47.0


