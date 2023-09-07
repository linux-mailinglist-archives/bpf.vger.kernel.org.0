Return-Path: <bpf+bounces-9395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF479706F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C061C20AAD
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906291107;
	Thu,  7 Sep 2023 07:13:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D61102
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF1CC43395;
	Thu,  7 Sep 2023 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070807;
	bh=9dN9APma3dB+fLHgFrg04fPMfjuQaT5/i2MlAL7nUQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsXACZf7QYONRfnnQsaVbkRLgm5ogxGDyBmeidwseECCG6ATqhwmuwYtdYC19/wjD
	 +c8lpqF+sG30ZXkqnujNz1wtr8wWnIyvmVesofBMb1R571fHK9ry4XBfr32XvdrLdZ
	 9W5zJ5vZIoxzuEN1XNdAP3aKS92UyuXxYPFwsE8GWYUY2Y0ZYAfhkhily482g2anLE
	 bCBmCqukoPuRkQHoDvEUfiPgKi0OIqNTXuDQagEec66hDdMHND9AM+dVM/RkLL8WVV
	 grlX/cqPl8A8znI7P9f3+Kk1H12iRVjWOGHeBIbTrr2vGS9almF4eAlcGgcbdoO+Df
	 fANkMeYliYuyA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 1/9] bpf: Count stats for kprobe_multi programs
Date: Thu,  7 Sep 2023 09:13:03 +0200
Message-ID: <20230907071311.254313-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907071311.254313-1-jolsa@kernel.org>
References: <20230907071311.254313-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to gather missed stats for kprobe_multi
programs due to bpf_prog_active protection.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..279a3d370812 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2710,6 +2710,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
+		bpf_prog_inc_misses_counter(link->link.prog);
 		err = 0;
 		goto out;
 	}
-- 
2.41.0


