Return-Path: <bpf+bounces-38123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AF960050
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 06:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02A51F2268A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 04:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78E4C634;
	Tue, 27 Aug 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YSFGESaS"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127542556F;
	Tue, 27 Aug 2024 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733041; cv=none; b=cMqFT0S1QAreLZqVfDz6h9TQRRGYrVdsBPRzG1AszCXFIZAKGQhJ6uhEUtjYSxRG7L1N9jw2vmqhGKxOo5nifz0vWa1ozTc0cDIbh2vTVkdc9QzmB3G2/hicrow8PqA101Ejo5YoJayuwFcxdWM7yvT3EFxzdTwaAzEOgs8iBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733041; c=relaxed/simple;
	bh=fJlWSB8zEpvURa02sugoo7IDNT7J4LoH2lrYQThCUfo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KsE+6Jp5xq9mEeCUZnRUjnJIKZqmHbJnI7pMKDtxryvHxwYYmhMfASgza75ZBr92IFvHxX4jf7x5fJDujjxeCMjNycWWehw1R1VchTR3ZY5JnPZ6j5+EwsQRwhoyZiFc5HmrN44Np75tUaMD8Z68E4ZkMFMS9Eq5lKzkkEmmnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YSFGESaS; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724733036;
	bh=09iYwJ8SAKD94+ckhkuk//gibULwSwL3Fhx0GI/RLJc=;
	h=From:To:Cc:Subject:Date;
	b=YSFGESaS/2P6z1WQEi8RiAg7cZsPQXX0bh7rPu/Z7is6lqmm+uMFYXtLe0ksE7w1z
	 2/a8s4uGXePpXo4R0SNGsT0RyUO8htKEciP5souEOpYJ80o+MMWElOzRcTXl6oA7+v
	 GdX3Y4nHbsNkaMwX9TKjBF7+iRKPm8maSovTMYvQ=
Received: from RT-NUC.. ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 79FA3A9B; Tue, 27 Aug 2024 12:30:31 +0800
X-QQ-mid: xmsmtpt1724733031tyh1ijb7f
Message-ID: <tencent_34E5BCCAC5ABF3E81222AD81B1D05F16DE06@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeMtYPow0rvLqNZ5A0akD8uH7orL2G499xmgZSl2uRct0ysgOLSj
	 6y9lpxLOLNtOmJu8TplsdGSJJTHyek90E181vJSO3XKJIN6NylreJ5vp3tekCFYKn00ZB5QJr+qJ
	 mZV6D1zV7I3mjcYF/FCF70QmuCcd40eSBFjdrfYetAoixiEBQFIKL/sthJPT8LPhEUT4R+2IJzX6
	 4+cjsAtTm3COIys0iuk2JWVqHbhl1XE22PrPutrks/Lsiw7Z2vTbxGgfAFmF+XRgRutmlDBZsoVB
	 TJQUYvS+E76Y5GMXy4NQOhp5YG3XtKdlphsertrds1SC8u6+QoVjZs708Ha22Z+9yxKgMV0vMrnp
	 W6Gi+ggus/MgJphUYU0yd7uXFrUuLalUq8LywEseYBRQuJl3Eiv2BRv0ZAsIUH68DvLeb6sRARCA
	 qnZuQOpGkVc0x5Hyk7qPZCWFzuVdd5aEEwBpYLSs9dTnL8OC8yuslJBIXJNX7YSmMyt69bTUbjkn
	 9oZoUMhycoGywV480oQDdMKnAYUntQv4aunz7nPhfZ82rL2ZTZGC4WTn/3hVznH5MGM8inXbZEX5
	 q8GHuE4PJW0A1jA7jo9tJZjibPZ7Zk+nHy0tBIkgyis+XSm9AsAdbL8REXLZn67g/3JFDoBqQ6fI
	 T0kEFnAWnWrkMJ8ftfKIRa7w6+lh0Txreeiv9u4GdLYLK2M9M3l6525rxBJqAsdZ1nbckupzKpJP
	 fRitYH1DGpKbgWzS4bsoazz8rLvI4AGCGgHHQKYEGi2dAvykgAxS1G8iaIon/avlkAAHIRAJlNYO
	 G1yoIRPJb7ZGdwKiiA4GBAuyrFGdYpjlOT3fcGWdrcic9aGmOpwk5zSxshGB8V3mqd5zJgXusrDv
	 UKIWYTAO/zIn4VjT89bDvBdwvBR3txC+iJcPNZYy0zpQsa8mtjfgAJQt6h98r6SrEd+gyrgHtmle
	 JVwESmT3UaIzuHfWzxk8LQRrXL9EMKTORD5av/QaP3nIxdHqcNcIPxs3W/iqY7
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
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
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: tracex4: Fix failed to create kretprobe 'kmem_cache_alloc_node+0x0'
Date: Tue, 27 Aug 2024 12:30:30 +0800
X-OQ-MSGID: <20240827043030.175600-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

commit 7bd230a26648 ("mm/slab: enable slab allocation tagging for kmalloc
and friends") [1] swap kmem_cache_alloc_node() to
kmem_cache_alloc_node_noprof().

    linux/samples/bpf$ sudo ./tracex4
    libbpf: prog 'bpf_prog2': failed to create kretprobe
    'kmem_cache_alloc_node+0x0' perf event: No such file or directory
    ERROR: bpf_program__attach failed

Link: https://github.com/torvalds/linux/commit/7bd230a26648ac68ab3731ebbc449090f0ac6a37
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/tracex4.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/tracex4.bpf.c b/samples/bpf/tracex4.bpf.c
index ca826750901a..d786492fd926 100644
--- a/samples/bpf/tracex4.bpf.c
+++ b/samples/bpf/tracex4.bpf.c
@@ -33,13 +33,13 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kretprobe/kmem_cache_alloc_node")
+SEC("kretprobe/kmem_cache_alloc_node_noprof")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	long ptr = PT_REGS_RC(ctx);
 	long ip = 0;
 
-	/* get ip address of kmem_cache_alloc_node() caller */
+	/* get ip address of kmem_cache_alloc_node_noprof() caller */
 	BPF_KRETPROBE_READ_RET_IP(ip, ctx);
 
 	struct pair v = {
-- 
2.46.0


