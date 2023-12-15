Return-Path: <bpf+bounces-17973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7E81445C
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F01D1F23441
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8517997;
	Fri, 15 Dec 2023 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA+TodGn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8A16429
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 09:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907B3C433C9;
	Fri, 15 Dec 2023 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702631911;
	bh=xcUFZdKtjC9dQYYUUr/PeNmppY7xeL7LfhhKWEtdqlU=;
	h=From:To:Cc:Subject:Date:From;
	b=BA+TodGnYNLPb2ThlPStjSLMmIQWf6buF7NW+UcPXzVp3ZFhL033HmGO3kCmcbh3u
	 P932Uc836kB6tcn5LFRtWBmwUeFOJHas34Ro2oMma3HGsFNHT7xonm+j3QEDGTCYJQ
	 iHhmIHwr0WYzuWxr/LoRtsl3ye8XXu9+xZFH0EWDNDy/jxev3Tlgfak18ew/L8G5Ug
	 dRWhVvMqosvFrIIKQgVGPS49WZbgUoKGUe9nE0zKpPtpcLisvsZhStrgRqUKS7Wb6R
	 XtND5cTJKgZ46SKweDAx9Gt6M8OX3h701JQEhtl9TMg/GOq49NlWNaiOyYVITwZ4nx
	 uNis31kujjUdg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH bpf] bpf: Add missing BPF_LINK_TYPE invocations
Date: Fri, 15 Dec 2023 10:18:26 +0100
Message-ID: <20231215091826.2467281-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..38cbdaec6bdf 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -148,3 +148,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
+BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
-- 
2.43.0


