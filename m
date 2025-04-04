Return-Path: <bpf+bounces-55278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F968A7B304
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C9189B3FF
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0A19F438;
	Fri,  4 Apr 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9jvMJO8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA51799F;
	Fri,  4 Apr 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725084; cv=none; b=FFhVJTkkTcmB//bpxky1IO4XcjJW+DKrehvUAjoHfscudfa24Aj+aZgQ35QOuzL4l69KVO2wHzVv/1RCnM/+xmn8WZlNaghm6/KnpOvuy16RJ+21fY7iqK9nXqrUmsETEDSmJQeoXwvA3Xc+V02qPb1e+/hiqOtih7bNxO8zF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725084; c=relaxed/simple;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ka9ZgtYXoFBiTTe9vU8tG56haaKle7AS3lJY1jmO4BYoGujC0CEKdhwLYFSQSoW2fNcSytzgOvpqpCSIlEalOC6Xflrzkz/A0O6urmdHJptzgm9V7fPqj4YT6sM6iQdysagrHT9yvY4zJJpkLz3ssXBBz4GOJQah86iielNWsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9jvMJO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE6EC4CEE5;
	Fri,  4 Apr 2025 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725083;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9jvMJO83lSwoFgWSEynRorMiu623dUQC+c3bKhr+33rg/orfGGOuq0gDBuvRZkww
	 svTN64TCxTLw3WsYn+/RlWilkXgc7ziU741I+xKWI3OV5eIz03LEOgWbjlY3FSmlPa
	 S3AIY0J+7aIkLADXVu4yXohVuvwzFDf+fOgMmukTIby5Skzdf/N3B47oHzhZEar7XY
	 H2sL9euAUG9kykAEKfj9LU2WFUAGvi8bdJpMA2WDDXiD8Y0cGEuyfFZG25IffN3W+Z
	 aHjDYVcqjyjB4BKWNfzqRUUyemwBmcQ+42s2OQvtnCHgFwj/ZZk4IKj3gOO4HCEwVg
	 5r6FrzdkrXPhA==
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
Subject: [PATCH AUTOSEL 6.14 18/23] bpf: bpftool: Setting error code in do_loader()
Date: Thu,  3 Apr 2025 20:03:55 -0400
Message-Id: <20250404000402.2688049-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index e71be67f1d865..52ffb74ae4e89 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)
 
 	obj = bpf_object__open_file(file, &open_opts);
 	if (!obj) {
+		err = -1;
 		p_err("failed to open object file");
 		goto err_close_obj;
 	}
-- 
2.39.5


