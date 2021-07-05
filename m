Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1353BC301
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGETLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 15:11:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57607 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhGETLS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Jul 2021 15:11:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D2F75C00EC;
        Mon,  5 Jul 2021 15:08:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Jul 2021 15:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9LDu2Brw0wu3AF4dA
        keGraGN+kmrsu6inkhg82EUdYU=; b=XCAlgY1LA6693XCNH1o0uY1c+FtbtV4Bv
        jebGXlN6uHVuSykLz1vNdVm6EfowvDnJmeOwpaUNIXbxWz73b9LjxBqw47yJuNew
        GxA11CAJtnWi6/Iyxsr5tDb9RpuVeE2fNHkhb+d4V4pgPOWyORrOCPIBotippTvb
        ELyOKJplkxXYhQ0vErcEF0RcwQNIU6XEVHNZQwIKx5Yk5u3OJlyxgROaBckjxrtS
        KWYNtXocPzPQeuHGEVAUL3tJanPR9S7LDB+LwkB/OfcR6W6qcA9095lCLKv9o+PK
        U+vMM/S7zjBxwTU1uQR4fmsIKHUWrRZXlAhAa9yJU8Nkx9Pc7crtw==
X-ME-Sender: <xms:tljjYC4QQKirggRa_HSg3RqTWhee85chUOdjq6ct-dTWxDmF2A8WBg>
    <xme:tljjYL5TLkhhucJ04GmFFo2fhK8cPxngvdK7wPMjX8IBhSM_3F78YHF39bNgbeaKW
    q1bpX5XL5xv-zxNhyg>
X-ME-Received: <xmr:tljjYBe0fkl4TXP8XDPjqGVqE17xVbC46UJKk1rcdwErcoGei8beCA-UwwsVTqbeh9ojIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejgedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgs
    uggrrdhltheqnecuggftrfgrthhtvghrnhepuefhfedvheelieduhedvveeiffdtleehie
    duueehjeejtdekuddvtdffheeuleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:tljjYPLD1lx8KxItHufsCh6Fd7WRW-wbOEgxci0Dv8jOTYG8LEq65g>
    <xmx:tljjYGKe2DZ6QKlvqP6nmvvx6fCntII_ZWvBKBqT0DXMZlVobpNR9w>
    <xmx:tljjYAwYxncxj6EOPK0cDKp3AjNxYvPmiNDbLmlNdxMOHOSqBx2hnw>
    <xmx:uFjjYC3z3EyiXDkA6Ge8CWDDNWVrLyqHT_NwxkrzymJMjwIzO9JZ4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jul 2021 15:08:37 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf] libbpf: fix race when pinning maps in parallel
Date:   Mon,  5 Jul 2021 21:09:26 +0200
Message-Id: <20210705190926.222119-1-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When loading in parallel multiple programs which use the same to-be
pinned map, it is possible that two instances of the loader will call
bpf_object__create_maps() at the same time. If the map doesn't exist
when both instances call bpf_object__reuse_map(), then one of the
instances will fail with EEXIST when calling bpf_map__pin().

Fix the race by retrying creating a map if bpf_map__pin() returns
EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
Fix race condition with map pinning").

Cc: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..7a31c7c3cd21 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4616,10 +4616,12 @@ bpf_object__create_maps(struct bpf_object *obj)
 	char *cp, errmsg[STRERR_BUFSIZE];
 	unsigned int i, j;
 	int err;
+	bool retried = false;
 
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
+retry:
 		if (map->pin_path) {
 			err = bpf_object__reuse_map(map);
 			if (err) {
@@ -4660,9 +4662,13 @@ bpf_object__create_maps(struct bpf_object *obj)
 		if (map->pin_path && !map->pinned) {
 			err = bpf_map__pin(map, NULL);
 			if (err) {
+				zclose(map->fd);
+				if (!retried && err == EEXIST) {
+					retried = true;
+					goto retry;
+				}
 				pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
 					map->name, map->pin_path, err);
-				zclose(map->fd);
 				goto err_out;
 			}
 		}
-- 
2.32.0

