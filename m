Return-Path: <bpf+bounces-6482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B576A37B
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B226D2816F4
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A91E530;
	Mon, 31 Jul 2023 21:55:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72F1DDF8;
	Mon, 31 Jul 2023 21:55:36 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FFD1FF0;
	Mon, 31 Jul 2023 14:55:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D9D515C019E;
	Mon, 31 Jul 2023 17:55:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 31 Jul 2023 17:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1690840525; x=1690926925; bh=r3NTgG4qLC
	9ZQhYXCs1UXPjCX4mwEQOdjG4bzdifxkI=; b=vZylnhrkSW7MBNL5YAgTv8djUG
	eySXV57dXy3KGxs0C8lSaKf0v5rs+upnskhR4UugPFDd/W+bbDyTeQShUAtOSHdE
	FljVCmrDRsw0+IOasPj44TCglOZ9puA8wEa7tTGeEhYnhuEZvhZhO7s5y3YNmbui
	f/4OcLGnD/7UX0+qb/RTsQR72lLyOhwcHRUfsHuUREu0Cl9u/xmxfSfVe7oTH0tV
	vfi4ZpIKRpLY8o/Oz4Bmuy761Haq+bE9/y1wXy/jJz6L1HrPnHDATfWUtY+HzKx4
	GrrKI7QlGp3Dv5YyKqO8C4Mv4o/FVsCAULc+OAuCvFgbI3wesULxHyBs/dpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690840525; x=1690926925; bh=r3NTgG4qLC9ZQ
	hYXCs1UXPjCX4mwEQOdjG4bzdifxkI=; b=dNQcqzLXz1LBlJZBUinplkmVHEYaC
	ssgVLtML0avz4wnTdONP2fhO/yK9kgveKbr4UW7zU9NVsFOjRGTWpj29lWMdgZpC
	2SSWPNoL3n44oIZG2duAeUpbRnDArEllrLsmZQXZ98AzaCv0hAOqeuAXL6GJsSZS
	MN3uubIVLporrz3mz4jIClUzXo/PSatE8OVgtxEYx38j0zCT7IRTzE+UeLyf/XJQ
	zLcWq6S8sVjQNxyfgVW/OWb4ubpKKCIZxYEKOS+4hjvb65SBxOvAPn2hc90n2xDC
	qvZABoJcR8vmyRhbs+ySwLx9pzxTtUKkD6EXBt6t6kVh2D2ZaKVZZv52w==
X-ME-Sender: <xms:zS3IZLWjb92NwR5GZ8puc815lBR224UFEow8unK-5X6X5EhqFdV9Vw>
    <xme:zS3IZDlub75xmfd-BONhJojF66BrHlPRXiZKAyNU7Ef7advln21kDEejf1Kx8b03X
    sO-7OyXtIG4ldByOQ>
X-ME-Received: <xmr:zS3IZHZ8ZTQdabAjdXdWHV6x7Z8zLiSwFezT1fkrDyu_-oL0zpOX5Yp5-FRHcZUdXdSxh6KIqTPZYba2Z30mHZ2j9dCKkrEBXqrdFxi59W4gGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetueektdeuhfefvefggfevge
    ffgfekfefhkeekteffheevtddvhedukeehffeltdenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:zS3IZGVus9IQwwMDzSpZik9RMZ5Cy8R-7SKBaFWNaXNj_zjlBjBpGA>
    <xmx:zS3IZFmD9IIr6YS-Otm5u3Is1JCUlsVYIBQgwr050KyB-lfPJ4CFCw>
    <xmx:zS3IZDd_EDViJFvd6Xp3HvLs0-ySSXL_5WwHBi_sWvPaoBcpWg0H1g>
    <xmx:zS3IZHlmPvQR-H5ide7b-Z0EHJ18dXzLCM5hvZQg12QUKeDBogIEwQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 17:55:24 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kadlec@netfilter.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ast@kernel.org,
	edumazet@google.com,
	pablo@netfilter.org,
	kuba@kernel.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] netfilter: bpf: Only define get_proto_defrag_hook() if necessary
Date: Mon, 31 Jul 2023 15:55:00 -0600
Message-ID: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before, we were getting this warning:

  net/netfilter/nf_bpf_link.c:32:1: warning: 'get_proto_defrag_hook' defined but not used [-Wunused-function]

Guard the definition with CONFIG_NF_DEFRAG_IPV[4|6].

Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307291213.fZ0zDmoG-lkp@intel.com/
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/netfilter/nf_bpf_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 8fe594bbc7e2..e502ec00b2fe 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -28,6 +28,7 @@ struct bpf_nf_link {
 	const struct nf_defrag_hook *defrag_hook;
 };
 
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 static const struct nf_defrag_hook *
 get_proto_defrag_hook(struct bpf_nf_link *link,
 		      const struct nf_defrag_hook __rcu *global_hook,
@@ -68,6 +69,7 @@ get_proto_defrag_hook(struct bpf_nf_link *link,
 
 	return hook;
 }
+#endif
 
 static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 {
-- 
2.41.0


