Return-Path: <bpf+bounces-55295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0117A7B3CA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3B17C3A6
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C06204583;
	Fri,  4 Apr 2025 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSv/B5b0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84C20409A;
	Fri,  4 Apr 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725211; cv=none; b=s9TfHCutY0UxdInRQVXlpcp+MNfrNvRmKy7Em09ZrtrvcGGd0QHxBaYdpBpJapKMpCXKvv9Ke7cm+QvpBki3GIvd2QzcHuNrel6Zg6tAX5NZC+zLmSy+6cEZFwiqiInDrlFt7Wjbwb3AQrBBVxhSRIZcNwwY9ehOlmPbLlF2iCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725211; c=relaxed/simple;
	bh=QwLzINMbv2zgSv1/FxCNaD/DrH9nc42/Y9VEWhmUXI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgaOHHNzCavFeUShbdGVBVPdfwi89oW8QvAoAvYRfcbiaEJYZWWGuALZEQHqCr0gXhmvuEbRH5drFUuACuclPeLx09XANva2WYLzH8j8Wnlx8JrB+0OcqNvVHBmbQoHFJxB3UQKF/OL6v95ioHpdLkoEnGq4GsdZqw42Hv9Z1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSv/B5b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE45C4CEE5;
	Fri,  4 Apr 2025 00:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725211;
	bh=QwLzINMbv2zgSv1/FxCNaD/DrH9nc42/Y9VEWhmUXI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSv/B5b0S73amyJG3CJSN7io1PpwaP5xucL5Q3DMznxcI6vLBHsWlPDGoh5CMTc98
	 MKJZmAiK0vHZ4QqTeusS2vhG/+A7d2EZHlpdImSgm7tGMl9LZa1bWHMcz/qJm6pLYW
	 NrtZtg2Tbyctnmrw/7c3QNMFT0RRDTdZHS4t6IlbYaitOdr5V2vRKr/s4J/vHmuwMw
	 lzfmWemCwmu8gYOphBdTdoLJ9bRugpl3B/7wgIxaUf97v3+ZFKGzbo1LhbSGtVvokT
	 mJfhBOPF2+cOQU+t5lPURg5W7CjKuJ1D4frCUvLN7UJsf4xRvHzqG+pI4dI+G5CUwJ
	 OH1XUOqbM/F1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sewon Nam <swnam0729@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/16] bpf: bpftool: Setting error code in do_loader()
Date: Thu,  3 Apr 2025 20:06:19 -0400
Message-Id: <20250404000624.2688940-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Sewon Nam <swnam0729@gmail.com>

[ Upstream commit 02a4694107b4c830d4bd6d194e98b3ac0bc86f29 ]

We are missing setting error code in do_loader() when
bpf_object__open_file() fails. This means the command's exit status code
will be successful, even though the operation failed. So make sure to
return the correct error code. To maintain consistency with other
locations where bpf_object__open_file() is called, return -1.

  [0] Closes: https://github.com/libbpf/bpftool/issues/156

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sewon Nam <swnam0729@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u
Link: https://lore.kernel.org/bpf/20250311031238.14865-1-swnam0729@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 90ae2ea61324c..174e076e56af2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1924,6 +1924,7 @@ static int do_loader(int argc, char **argv)
 
 	obj = bpf_object__open_file(file, &open_opts);
 	if (!obj) {
+		err = -1;
 		p_err("failed to open object file");
 		goto err_close_obj;
 	}
-- 
2.39.5


