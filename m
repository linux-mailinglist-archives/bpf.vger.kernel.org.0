Return-Path: <bpf+bounces-55285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C48A7B345
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28CB16EF61
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEAD1F236C;
	Fri,  4 Apr 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LawnCKzA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1B1B0439;
	Fri,  4 Apr 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725133; cv=none; b=YUkjdMzh3H8jD9WvIG9p31G69TWOGpKU3wTdEpZeOhAxzL/2+Te7m1GxTv+UTE2RTBE/60oli0A9FYEnWSBFqZHOXVFPgh1nfpeVzxofQ5Lmh1Lcg6C4v89tqQZnRI3Hh8Igum1hl3Up48C6tn4P4f/ZqENnZIq++xspI4HhsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725133; c=relaxed/simple;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A38meICNyPw3sRt1Dc2DjweBAhPnsmyKQQ+liTas2lWN8UotZrvMZ1MFhnbD6Vj1iEHx3bvCs0fo+O7DrY7pw8E+2y45K9EKwRhaCNzI1YVTuJacmARxPl4Ij/Ehl08S6QlECoelUd1juHc7U9yUpN47wZjOyEAm6D0MvJNJ/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LawnCKzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A568C4CEE5;
	Fri,  4 Apr 2025 00:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725132;
	bh=kF6r9LrmUEFqC2gd1f+MdmUkT/hnZ97RKaBzdAFREfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LawnCKzAOgRrxEzA9rJ0Kxw4CjsNaoX7z+x5dgZm+6SdbDQPS6f62r4rHaMfeXTFK
	 uVL+p9Q/z3+KoqNvw+t1JGF7pG2iAt2ms4dMRMq7cRIIhuk0kH02VPtAwPKwUWGG/1
	 z8ODpiw+2lUOpUWJD2X4H6U7Y5E9wxcF7PTaWR37DmUdnLYHyTmAvbDCCRC49vGmVH
	 ifnDubqCx0NBTNz6V2GjhO2WZCI17pXLVMzgtMVPM4L5Twm40Zj1QRCchtxBBk/+Ef
	 8lq+MixU19TkyKO9Xkb5YqyKz6DPt2EbPU/MteYaAdaj6LnwCfiWG7uXkGTRtaKB3M
	 Sg7P4d5O74WcQ==
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
Subject: [PATCH AUTOSEL 6.13 17/22] bpf: bpftool: Setting error code in do_loader()
Date: Thu,  3 Apr 2025 20:04:46 -0400
Message-Id: <20250404000453.2688371-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000453.2688371-1-sashal@kernel.org>
References: <20250404000453.2688371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


