Return-Path: <bpf+bounces-55292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC8A7B3A0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB97A8453
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE151FCCF7;
	Fri,  4 Apr 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdS42XnZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575401FC7D7;
	Fri,  4 Apr 2025 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725178; cv=none; b=Ion9taTANF0XQm6aZOa20XqWR2zdVBHmIt1qBHpQSpQwm1mq5yKLyavUEeJ1Hy3teNYXQzifPiTIvDpYLhAMiZ12/RlvTDe91sySoWTuQVXWotp8NrWXLHN8fgQyvq0s7X4FZ8g24QSi0daHeJjMMBODSpaGX61P8mNnBeGLJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725178; c=relaxed/simple;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9QauSZJHC9E6wFWgcpMDsKTssjcQpn/QN8H4/1xqakx+0b2yu+wTXku1hg0RDRWUXstQ8ks95kqaJYRjoWRmJJjEJr1jab6ZIJ22IAFYmQHfGGvvo8IJz2P4ELivtrmo7s5V1NI6OfYkPo/KZfq7y3fk2y0S65OnX+tRLhk7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdS42XnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD53AC4CEE3;
	Fri,  4 Apr 2025 00:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725175;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdS42XnZEq9uWPKRkP44SeYf14yWapbdZ91kb82BpG/AY4kyBlVx8qi8CPNsBsQu5
	 F7Rs7n0haXRvAoenE5UBi+9iNt6v/ru2cEn+NuEFKD0iQ24jGBL4/zFduY78gtpy7K
	 4OBgILZgwRaHmNmBY+jBHbkRgAG466Zvl/GJQxH1a8oe31/+6UnnrhJUE+E6yQ6uHp
	 UW2gI6mcIznTU4Lar8Hpzn9rOn7OhCK+g55/EkNbzJzIFl9/ldzLrQjd4D2UZ+slkI
	 ihelAgatEdH7XJ8GL16MpdmLQRCUPtg1DtuwbHjXojwjZNOt7DVDVpu6TrpSl8YliY
	 PZLQOYQ746Fig==
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
Subject: [PATCH AUTOSEL 6.12 15/20] bpf: bpftool: Setting error code in do_loader()
Date: Thu,  3 Apr 2025 20:05:35 -0400
Message-Id: <20250404000541.2688670-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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


