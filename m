Return-Path: <bpf+bounces-59699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B95ACEB38
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48465189B783
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8FD1FECB4;
	Thu,  5 Jun 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="AYd+VJE5"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC821F4176;
	Thu,  5 Jun 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109903; cv=none; b=HrvOzbPDqa+ScxXB4hi7ZvbVW/ENU0UiLU52ScFwUbEZWi/Y+KM+M7K+ykl14PBEgQiuM6jd7Mc6BdYod4xD9XE3HHgHRyLA+A01V6SfWtsQ49QWnp0Ho6mXxevmudnu+OpIs/nNbeOLjA2FtDMrfzl3Q0vtHJ5wIuy0RuB0zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109903; c=relaxed/simple;
	bh=ADAo4tuAn9RJse2Dsl/pLYasjN1HWf+dOgXZED+HZ0c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R5eSTmWsraynviKI4JR79fj6KAKZOUC5md8sAumYSJzI2IKUZ1PuIH8ygaPeaaaRA0GYAr1Y1LHMC9x8O84G4TsVLKgRTpX7LwPpIhkQXvbJkn/pto6Aom1UVICG/LtSLyT2dMra+AMNCEAUY8FErhmtjfK/gqlDebGPvuQcr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=AYd+VJE5; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749109883;
	bh=riOYvbqngrrZtJixWRHCaMdJe6DT8P5TkGFvEYl78Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYd+VJE5lKlEjhHf5oHs05oZUpDJ2BsMS3x+/D01ci4p5dtZTDLw/RtuQCezvK4H4
	 9JOfr/k+yyHOMjRFZ+a+HK+2J9PF9ugugnt+8r4dMoSJQj3zvINBu7MroedVSc0Bky
	 Ts0VX32LXNwaiOpUJPsFN8Sog3eTxdg6IHqu+MuA=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id CD1A1A28; Thu, 05 Jun 2025 15:51:17 +0800
X-QQ-mid: xmsmtpt1749109877th51j190x
Message-ID: <tencent_F85EF146D110170D48845EB3F02ED5549409@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XKLqM7JeVPGU0RrgQGAi/gOOybpETim/eOO5nyhGqNka7shneg+
	 EufHpPXJz532I2fJbZBPyyrG3nQTLAkguSn7BQRmDhkzAWl4orFo2S8X4OFdhxguZdsUGxFa9Mpo
	 qHPVqqQ0mrHBhc7D1Q8wSg5YZkRCmYPtwpavBWcH18V9vABB8UGGspg4hfTxmR3qmO3u6+Ktjq3l
	 vSoZbLqoXUFQYpoZc1j8UPk5Pucde7gn5Qqv3XoNlOZxzCzKmXwhxoloFjKx984LuvDP58qvzmrV
	 mBpBBU38mmOuvsEgc9PIcUszCcbjXYPjMNSHGarFQ6Ziu2GG+nkRm0z2rJk1PPRWI75iMnAqOLZW
	 wLUfRSTdc+7lTQzflFTgQC+qGbQwW+yS1Gxe3II6ct8IoL1K/TBbAVYeTydoWxc2CJP/Kbw+YPtt
	 clrenvo9DNdjIDhr4qsbkIA2ZK0by+x5oYRX9CwdPEZa5jt8vBDQSoEFveJhTXhQw98xFdoDMpRb
	 86nIuZfXCUsnJAazvQZu5OUmn5qVY70GFgY3duM3sAnyNJZhnJINFI9GcR2GDqYXmMB/g7wHcBjf
	 pCuCYUITgbELJKl7b4Ib9pNISvM1/Afst8/uMe9vF5utiVAHpYQAZsiH/gu3xF6Yq6EyRlIk1pxn
	 0XfryPS4YcCy8Op+GlanCOTtnMR+EHoJM/Nyj3sazXKTu2giouYGJsL5Fr0uaiTnze4uTe62qDtR
	 N7lC+jSMoE6cqWm8TmhyHebAEt8C4SGbOWs4bok2Gwv1fWCyBvMKMy7zbAHb45a/u22oVs/WNY6q
	 KdII5KSnQ6U4Xfkz3WLdYJH6qo+OdbkbtWi4IiOZfD5N71mg6yfCGkqHQ/h1jHRrRWv3VHrDXF1h
	 cJr+2ZRobCb7qhbKiY5AwJjE1P8PFEY3PrAbWhmpIhkytZvI7wipn/g08cQpNg0/P6fcoY4dmVo4
	 EwdfnowzxsSO0h1wfBAol3gVIBd1wjrL0d7KATx1GZv8t8k7SzViUFb0XAVT/tYe7OQmvCrP8mW9
	 NdohZDZPVkg1QnDtxcZAM+hicZx+I=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Kreimer <algonell@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	Lin Yikai <yikai.lin@vivo.com>,
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Cc: rtoax@foxmail.com
Subject: [PATCH bpf-next 2/2] bpftool: skel: Introduce NAME__open_and_load_opts()
Date: Thu,  5 Jun 2025 15:51:13 +0800
X-OQ-MSGID: <8c0f486b44591013c4fe538fb5edb908992978b8.1749109589.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749109589.git.rongtao@cestc.cn>
References: <cover.1749109589.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Update Documentation for skel NAME__open_and_load_opts()

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index ca860fd97d8d..4dc2a624090e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -107,8 +107,10 @@ bpftool gen skeleton *FILE*
       global data maps. It corresponds to libbpf's **bpf_object__load**\ ()
       API.
 
-    - **example__open_and_load** combines **example__open** and
-      **example__load** invocations in one commonly used operation.
+    - **example__open_and_load** and **example__open_and_load_opts**.
+      Combines **example__open** and **example__load** invocations in one
+      commonly used operation. **_opts** variants accepts extra
+      **bpf_object_open_opts** options.
 
     - **example__attach** and **example__detach**.
       This pair of functions allow to attach and detach, correspondingly,
@@ -336,6 +338,9 @@ files into the final BPF ELF object file *example.bpf.o*.
                 const struct bpf_object_open_opts *opts);
   static inline struct example *example__open();
   static inline int example__load(struct example *obj);
+  static inline struct example *example__open();
+  static inline struct example *example__open_and_load_opts(
+                const struct bpf_object_open_opts *opts);
   static inline struct example *example__open_and_load();
   static inline int example__attach(struct example *obj);
   static inline void example__detach(struct example *obj);
-- 
2.49.0


