Return-Path: <bpf+bounces-18053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20F815454
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96051C24725
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D218EC3;
	Fri, 15 Dec 2023 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0VKAr8p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8318EB8
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE4FC433C8;
	Fri, 15 Dec 2023 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702681508;
	bh=hveThWDdbyJf7djHgcj5zXJYyZ2QtXKRcgsgWbSpxqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n0VKAr8ps7iFtRct0mWP4W91F4uLD1atUa/OGs78Otf7txvYj5nDNwYpl+Yz5x1ny
	 acjX2Cop7zzT47mLkNujdVD/VoIpWCSBnnb4cB0J92TbPA909BF/5ASOzqLZyFXNy3
	 REe05Hc4nsrqbgjHfdxAwWgvkQqa3rVmQpcUc76eZ7MiaCTZTky1npomNcrBsLwvHi
	 zAzV6tWLeVenI8RFCvQuJ431kGxCmhIMVDarEbPsZQdAkx//xoZBhGs/iTWFR3M0dL
	 fK5zHJ2pD4Ym8sPRz7LCmBG+WN4T4r65ca9ADl8OoedDqs8hoOBanKMyn2pHPM/tdu
	 CQafF5j05qNnQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>,
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao@huaweicloud.com>
Subject: [PATCHv2 bpf] bpf: Add missing BPF_LINK_TYPE invocations
Date: Sat, 16 Dec 2023 00:05:02 +0100
Message-ID: <20231215230502.2769743-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.

The reason is missing BPF_LINK_TYPE invocation for uprobe multi
link and for several other links, adding that.

[1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 v2 changes:
 - move NETFILTER/TCX/NETKIT under CONFIG_NET
 - added tags

 include/linux/bpf_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..94baced5a1ad 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -142,9 +142,13 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
 #ifdef CONFIG_NET
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
 #endif
 #ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
+BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
-- 
2.43.0


