Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6D3D5CD7
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGZOir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 10:38:47 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36363 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234725AbhGZOig (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 10:38:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C493132005CA;
        Mon, 26 Jul 2021 11:18:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jul 2021 11:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ADxx3z4emZIDkOP7e
        x7VQNz3tFWmhUAeYpAGVdt8jtg=; b=tYxAheAtf6b3yG8/S5b4/TltHgBjR1kSi
        ustVWmdUNHW1UhM0T/gOJlqtgaZi8/mG7trQJEs322iSoiZYcyHBKuqnyrMq6Ru8
        lHCNedSQj8oykSWJs1ZUD4o/lAXtvVjXG4Q1VbfWfGtAoFUHTduDC2Ci+jrTCF80
        1irZU7g/e/3IQYaNSojqu8NJ+MvwLxdRTz0sHWStZ6eT+QSd2FiCvL7zt//8dC4p
        gbWwkb+sUJWcGfmY9hgkMN0Jq+EMT+LzunnUhCoh2/5aDsMhZn6gYblyCZ/GkKZV
        KH0MSBLDiioZin+pewbqL1MXBojJV3rRmlN6ApGCbJQzDiLMsDxtg==
X-ME-Sender: <xms:XtL-YKaZNlJWXzdvdJUGdMNBBQcSYfmC9krP8xGUcRgGYz6DMHVRJw>
    <xme:XtL-YNarSPCUN4V0vjzh-Bhw8I7xYjWC5_Z75knkXSoplvJj48hquA1-SVTjaNdOb
    FN_OUXhXFwWS8I3ZSQ>
X-ME-Received: <xmr:XtL-YE_G-43L-D9ursREI81x1yMMFpilNheHTWfm38ufD_uiODQuLCfN1KkERgrODg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggr
    rdhltheqnecuggftrfgrthhtvghrnhepuefhfedvheelieduhedvveeiffdtleehieduue
    ehjeejtdekuddvtdffheeuleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:XtL-YMrVFUBIKoqSYSIg8pgxqp4UJWRnczAbIBTWlD1njb8PIH7cwQ>
    <xmx:XtL-YFpH22VOaTMQocapT-oIGy7FRf54XRkPlmg3xdan4VE_SjSYRA>
    <xmx:XtL-YKTZVrSsCBFAaR9LqRZXU_ySs-IonLUSBYcX8pBDOh0VpTlGMg>
    <xmx:YNL-YMVPu2aerXJtNze5NLz93G5lD_BBf09amE9LKHAVMO2eEBYrWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 11:18:53 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH v2 bpf] libbpf: fix race when pinning maps in parallel
Date:   Mon, 26 Jul 2021 17:20:01 +0200
Message-Id: <20210726152001.34845-1-m@lambda.lt>
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

Fix the race by retrying reusing a map if bpf_map__pin() returns
EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
Fix race condition with map pinning").

Before retrying the pinning, we don't do any special cleaning of an
internal map state. The closer code inspection revealed that it's not
required:

    - bpf_object__create_map(): map->inner_map is destroyed after a
      successful call, map->fd is closed if pinning fails.
    - bpf_object__populate_internal_map(): created map elements is
      destroyed upon close(map->fd).
    - init_map_slots(): slots are freed after their initialization.

Cc: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..9a39453bb45b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4616,10 +4616,13 @@ bpf_object__create_maps(struct bpf_object *obj)
 	char *cp, errmsg[STRERR_BUFSIZE];
 	unsigned int i, j;
 	int err;
+	bool retried;
 
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
+		retried = false;
+retry:
 		if (map->pin_path) {
 			err = bpf_object__reuse_map(map);
 			if (err) {
@@ -4627,6 +4630,12 @@ bpf_object__create_maps(struct bpf_object *obj)
 					map->name);
 				goto err_out;
 			}
+			if (retried && map->fd < 0) {
+				pr_warn("map '%s': cannot find pinned map\n",
+					map->name);
+				err = -ENOENT;
+				goto err_out;
+			}
 		}
 
 		if (map->fd >= 0) {
@@ -4660,9 +4669,13 @@ bpf_object__create_maps(struct bpf_object *obj)
 		if (map->pin_path && !map->pinned) {
 			err = bpf_map__pin(map, NULL);
 			if (err) {
+				zclose(map->fd);
+				if (!retried && err == -EEXIST) {
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

