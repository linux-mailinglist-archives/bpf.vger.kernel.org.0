Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90F83DEA
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHFXmK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 19:42:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39135 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfHFXmK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Aug 2019 19:42:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 21D11514;
        Tue,  6 Aug 2019 19:42:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 19:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=C4dn8c+a64obLuAbVd0IWLwMsl
        ReTaaLm+iLiH07rJ4=; b=TnY0qqHL14ZiJjDGId07CdkJLqHgm5xqjNIO8AwBJ/
        qtE1lIKqQcwjh3zn2bOuFYU1ywFFoTTffQ/XSCjwFF+6l3eCNJdL9SDsOywT15Eb
        JGI5ol6NtxKGXBJuFwZAkliUebdEgnYNIWyA0dEDachLXEPFZQZafCHLNCqpOnjz
        0t03OybEiwofNQ9tHj+YodqkrBoAii/nvnP1154FQeo0PE3iTb0Wio9Z3Om3+BxT
        qZ5BuhkBmMB2krQO3eH01W1KLuW4Ggyafa3Px2iYA3QzngJu2qTPe4yWVF3n0Zou
        agXXNpij87dEKwxyShOvqxAVvC2K5CCVtpZZeREmfKVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=C4dn8c+a64obLuAbV
        d0IWLwMslReTaaLm+iLiH07rJ4=; b=ralfnYgAvAVTn85E866YXZ+ZGqFabMSJq
        S/jF3xZ9L9J8iFWCldOShJsoo8U3WHhRR2KQFZBM8E88wmtzKf3MSUfakCl+FuNO
        UiUgnRqzhXS6JVC7YJuUoqXUE2h6W/7gywTHqRKu5kDEnsgwHJCSmB6LV8N8XIqQ
        sGJvLhDXlfYF4cOQYdrw8cynq8Bl3uweqOlyPcukG/soNCZmFqMhegRXCZn8+Sy5
        8VRadwYPe/SDn78i9eUUPD0GTVZTWsxgHe8lfhWUj9yYH33fgIobuSEy5sh38ZTl
        xQBgaSEvcMj8qTUvsjTlHOaRBtynPUQt+ssMuRpmK5VPTXiMlX1VA==
X-ME-Sender: <xms:UBBKXZBt4hS6jnFXc7UVKv1GviRndJF15pXV0cdZkj-G0b0kGf8Euw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgepud
X-ME-Proxy: <xmx:UBBKXQ882eC7JTB9Ajtt1KCa_vIhhkkFeH1FXxnNJN3M-dL75yh5gQ>
    <xmx:UBBKXUJa3pZDkxFDDB9fv9sZmXsM44ZfTvptODPvjObrNC64BhI-Ng>
    <xmx:UBBKXZjNhvo7XwywhsuoMaXsOw0GKjy0zvYbA_mXbqyz8OT93vDTIw>
    <xmx:UBBKXTV3EU9WsqMsXklckWLaGKkoozkIO7CN6uwNTMZ8p36eDlPO0A>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id C32BF8005A;
        Tue,  6 Aug 2019 19:42:07 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] libbpf: Add helper to extract perf fd from bpf_link
Date:   Tue,  6 Aug 2019 16:42:00 -0700
Message-Id: <20190806234201.6296-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is sometimes necessary to perform ioctl's on the underlying perf fd.
There is not currently a way to extract the fd given a bpf_link, so add a
helper for it.
---
 tools/lib/bpf/libbpf.c   | 13 +++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ead915aec349..8469d69448ae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4004,6 +4004,19 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
 	return err;
 }
 
+int bpf_link__get_perf_fd(struct bpf_link *link)
+{
+	struct bpf_link_fd *l = (void *)link;
+
+	if (!link)
+		return -1;
+
+	if (link->destroy != &bpf_link__destroy_perf_event)
+		return -1;
+
+	return l->fd;
+}
+
 struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 						int pfd)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8a9d462a6f6d..5391ac95e4fa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -168,6 +168,7 @@ LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 struct bpf_link;
 
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
+LIBBPF_API int bpf_link__get_perf_fd(struct bpf_link *link);
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..0f844ce29b04 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
 		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
+
+LIBBPF_0.0.5 {
+	global:
+		bpf_link__get_perf_fd;
+} LIBBPF_0.0.4;
-- 
2.20.1

