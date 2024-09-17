Return-Path: <bpf+bounces-40029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634397AD1C
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A811F24E96
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64615ADAB;
	Tue, 17 Sep 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC+8OGXx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB158875;
	Tue, 17 Sep 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563107; cv=none; b=WjBOswwZ4+6pxwcolVPTWuHFOkye8LdsGLehOsdSYMe3zamFMmOSDzfSjb8qPnTqfR2FNny+XiteVAR9N5tLPnSSnyajs9uBZlA5PJ+i5GQyBWnh+3PdkjxbXOQhxbLWx8SveADaOnqoyomJMbvU/kkxQnYU91L70m01shnlSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563107; c=relaxed/simple;
	bh=qzy+FMkoW/u33RpdnvGiDT4W8kM5LMJuThnvREeYUfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg8albLKYZbMLm86uaLXPglFw9MykEDl7liOCo/tMdXUEFilFDyhm5+tnzQgCkTeBqXkYZ67AZx6vI4qhcsDxQrGi6KwZV8rK2nHLK+gQTcQn77gYBcRfPmytqtqcMd2rZKj5QGV0oSnyIB5JxlY0hMTU3WQnwZdP5gKmjZotBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC+8OGXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709F0C4CEC5;
	Tue, 17 Sep 2024 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563107;
	bh=qzy+FMkoW/u33RpdnvGiDT4W8kM5LMJuThnvREeYUfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC+8OGXxxK1sD89z6KBWUx84gH20ODy20SLJUdrOPeYv7KKCQrFeq6UgvvvEDP/I9
	 u8Q1GWiGaiy/2ckhIVS5ChA3UGcXylJEa78u85RQZRBhaAEptMbBToBGQvFNNnxyBv
	 A/SrAaW22dEcjzw4eJ7CUGhOwCye0dBuNlie7/Hmlk9t3h+aoSuho7lK4Swj8dyDVq
	 QDfRYsDU62eBlaB4myP8CZIYJPP9tRbuKecgNGQ47Gp9QllSARJ8LDBdBvRlqpGr1k
	 9h0ncS6LoeSl49Qqd9/4bWZfZiSwJdzkqx6n1OM5TEEc5pXbuEl2bOue8jq7B6tbEk
	 w82yCQ/MimBsw==
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
Subject: [PATCHv4 06/14] libbpf: Fix uretprobe.multi.s programs auto attachment
Date: Tue, 17 Sep 2024 10:50:16 +0200
Message-ID: <20240917085024.765883-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Andrii we don't currently recognize uretprobe.multi.s
programs as return probes due to using (wrong) strcmp function.

Using str_has_pfx() instead to match uretprobe.multi prefix.

Tests are passing, because the return program was executed
as entry program and all counts were incremented properly.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240910125336.3056271-1-jolsa@kernel.org
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 274441674f92..6917d4a0bd4e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11684,7 +11684,7 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 		ret = 0;
 		break;
 	case 3:
-		opts.retprobe = strcmp(probe_type, "uretprobe.multi") == 0;
+		opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
 		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
 		ret = libbpf_get_error(*link);
 		break;
-- 
2.46.0


