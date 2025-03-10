Return-Path: <bpf+bounces-53727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38191A596AC
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD793A587B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CDA22AE59;
	Mon, 10 Mar 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYrNxzPa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0622ACF1;
	Mon, 10 Mar 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614566; cv=none; b=nHsH60r7pFCWxXoU0Q8F/a4bYJL8YPk/XptdpHOZ/M28x/ASRhF1yamphPzinHkZOf7nDEnmVH9klIUxhpqYmRO2GKznzo6DM6SEO+qJ/gYwuj5Qer5pgEPnGW4B3mNM0peo5z2fBmV/tZB19B5uulBsK4T1dk4KKsczR0JVOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614566; c=relaxed/simple;
	bh=ukr+QU9GwJs4cVQN7oYi2ig6HaWNiXtRqpX8b+1yVQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iB0mzCDQPVpQFw/OnnoiEJ5daOlspI5MbcW//A8ecVzLljRil86PEtQcRPCLThxh6YpA32xUq8v9rvV2Vd77V33HZjarWPhER+egJlI99IkCf/e1zNLuHkVQGBAiY3xfeGg0RSFPvS5kpx17b2O59bXMoOLFh+6lv/uoKxbojMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYrNxzPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39D1C4CEE5;
	Mon, 10 Mar 2025 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741614565;
	bh=ukr+QU9GwJs4cVQN7oYi2ig6HaWNiXtRqpX8b+1yVQU=;
	h=From:To:Cc:Subject:Date:From;
	b=HYrNxzPawBSFCUeo978nHVd3Hzk0sAkHQBVKuwdFcA6qFd1OGGE/VZBkIDauqdj/f
	 RjRQu61uUU1EJFrmij4wWGeKGq3ZJr4s7OW02BZiymZMtPzigOMeEvfv5+Nd6zjTI3
	 mqWu/Qux7qC05uQ0/TOHTS/JzF5OrS0dP/kyMpbGL7WBQh9RBcQ6AAUxYk3gu8MyG4
	 6FC+Kss0AOMDkhFKq7f/SL7zbLk8XigxVQmCYjMLM6Yn6L3HFnoPVCSrP8dT2VgNq0
	 rFFUICL96KiTOVOwMDPMvNsfk3a91GEbch1/kV/xW/QjhRF2KFD97rFpbfllrrMLIO
	 C8Qljls6jzRVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: preload: add MODULE_DESCRIPTION
Date: Mon, 10 Mar 2025 14:49:16 +0100
Message-Id: <20250310134920.4123633-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Modpost complains when extra warnings are enabled:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/bpf/preload/bpf_preload.o

Add a description from the Kconfig help text.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
Not sure if that description actually fits what the module does. If not,
please add a different description instead.
---
 kernel/bpf/preload/bpf_preload_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 0c63bc2cd895..2fdf3c978db1 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -90,3 +90,4 @@ static void __exit fini(void)
 late_initcall(load);
 module_exit(fini);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Embedded BPF programs for introspection in bpffs");
-- 
2.39.5


