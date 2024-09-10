Return-Path: <bpf+bounces-39437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DB973813
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C4282FE7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF5191F82;
	Tue, 10 Sep 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsXXSLQc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A0191F61
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972821; cv=none; b=psQhWim0vkErUaXVhf+z/Vrwd677yUhe+jt+LnUPSjUf64up19Sy/TrHgyUBH3L6vbxb9SW/OZCJZfFjl2AjBqT1YSy6eTgEEcWlcfNEVkahzdgglOekfFjGEpQgO0d33vdRss8ofb/4OJvO7/Z3dIsl38N+58mCh7umIOaY9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972821; c=relaxed/simple;
	bh=aP7HI4ZkCKOJcy90hN2x03zN9DiOU+JYw0TZys3gpfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C202sZkcTT0HuEbl9vi9o37CfSV00B8iryUNmv78Sz5RMZrD+Ce1q7Fh1XMNtL9UAqb+bL2CZTLEQbOAyY3EDNeHAkjYC5ICZiRgP7fqB/TDRGgw7QZBfu0ErHxUKZxjUcUZqaGB/HehIXZc7vYIPGMHHg2Kt1g5z7QGNTc4zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsXXSLQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602DCC4CEC3;
	Tue, 10 Sep 2024 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972821;
	bh=aP7HI4ZkCKOJcy90hN2x03zN9DiOU+JYw0TZys3gpfo=;
	h=From:To:Cc:Subject:Date:From;
	b=rsXXSLQcJ7zK1gFCt6pm8W3N0rpkUPr9Uo+G03+u9BhUho/8F7wP98s0GcJX6qdFS
	 Asu9/a+9yx/NRas5TUE8k09vzqGlCSK34LFEw0KT3DDdkbnrFp915gikTDM5MVJbn9
	 r7TEHf/RUdVviCpkAOdkuh1I71H5MaTw6vq3xMlQu8WJRrmDJqVhFcm6CuZ4G8Ouq6
	 /xc0FOybTMhSPvDQTTjwtfy3X7VXHOicuO/pR87WHnST14tjWhKcGqsLE1zk3kljBg
	 BVbMUuZBLkFnoXfn8X3xU+DRa7KdQs+Mh9Y2KaOlCuIROUpPNNfOZkY8Nuu5j9cnmW
	 VOoAFXP14rF1w==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] libbpf: Fix uretprobe.multi.s programs auto attachment
Date: Tue, 10 Sep 2024 14:53:36 +0200
Message-ID: <20240910125336.3056271-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Andrii we don't currently recognize uretprobe.multi.s
programs as return probes due to using (wrong) strcmp function.

Using strncmp instead to match uretprobe.multi as prefix.

Tests are passing, because the return program was executed
as entry program and all counts were incremented properly.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Closes: https://lore.kernel.org/bpf/CAEf4BzYpH_2f0eHwQG205Q_4hewbtC9OrVSA-_jn6ysz53QbBg@mail.gmail.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4f29e06c2641..08e110392516 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11688,7 +11688,7 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 		ret = 0;
 		break;
 	case 3:
-		opts.retprobe = strcmp(probe_type, "uretprobe.multi") == 0;
+		opts.retprobe = strncmp(probe_type, "uretprobe.multi", sizeof("uretprobe.multi") - 1) == 0;
 		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
 		ret = libbpf_get_error(*link);
 		break;
-- 
2.46.0


