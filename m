Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451723D10DA
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhGUN1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 09:27:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36947 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237966AbhGUN1W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Jul 2021 09:27:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A97A5C0180;
        Wed, 21 Jul 2021 10:07:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 21 Jul 2021 10:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X+kxKKorTwnhM1KRH
        4GRU37BfUAFlQFSCjr16g94J44=; b=O1lBi+xPGl2iLCK5TtLiNrm28pnkv6RUs
        aY6waW3V8P84uTBpVM03eR0qkZuPa83objJCS7th7PyS/2J6JZwQBc5yb/jyBcWF
        ctfO8XNUK5r8G0i00+R+8mFekPuLZG7UkMog6P2Foys+0JqZ7zwvzpmfJzIq43NM
        hk2ZZ1DvHbIm5NlYw/PnCJfZkz7WNZxirNBfeVlU7ksturNNZWHs5TXYJfpQTo+g
        FU/ZTiQfb19G+9mjkCi76eLeJMruYBHf8QHcm6Vvdq3vPyC0n7gI6d52qqVEnUSn
        Djutn+DJOQLBxPiC4/yAxD5q2bQAQapntAlS8Z7KOcl8kigbFjDMg==
X-ME-Sender: <xms:PSr4YHIFavijpwK0R8FT0-tav_jpF5CIwNEnCuDpeUztJRZl-JV0mg>
    <xme:PSr4YLLZFi_800Xxhbo8DtMZliKpvtCOZfLx6iK2kuDhgtlwzaQA75W1tMXM_tAo5
    h6JBiovdeyKePm6YKg>
X-ME-Received: <xmr:PSr4YPv0yJd1t5FkYoz39H8dpzYrWQmTV4P26rZZOhQ3nWzLBDLf2seN39BzEdWhqsUxSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggr
    rdhltheqnecuggftrfgrthhtvghrnhepuefhfedvheelieduhedvveeiffdtleehieduue
    ehjeejtdekuddvtdffheeuleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:PSr4YAY98fIZO6AfETAZLbNN1MHOMUquHpyHNTyjl570CyK9op_GoQ>
    <xmx:PSr4YOYjVt_7hDkav--XSVZjqRLWXOUpPNxWR_Lmx6e6TkZ1gVsS1Q>
    <xmx:PSr4YECJ3IgmYdVdymTWwOP3tzplvQOd3-9tnG_nN1ChTTX3xt_niA>
    <xmx:Pir4YNmHbxGZaeE1hYe-eOqciFbRpfzrxfDqizskj0vEmQO8TQ67Ow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:07:55 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf-next] selftests/bpf: Mute expected invalid map creation error msg
Date:   Wed, 21 Jul 2021 16:09:41 +0200
Message-Id: <20210721140941.563175-1-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, the newly introduced test case in test_map_in_map(), which
checks whether the inner map is destroyed after unsuccessful creation of
the outer map, logged the following harmless and expected error:

    libbpf: map 'mim': failed to create: Invalid argument(-22) libbpf:
    failed to load object './test_map_in_map_invalid.o'

To avoid any possible confusion, mute the logging during loading of the
prog.

Fixes: 08f71a1e39a1 ("selftests/bpf: Check inner map deletion")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/testing/selftests/bpf/test_maps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 5a8e069e64fa..14cea869235b 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1163,6 +1163,7 @@ static void test_map_in_map(void)
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
 	__u32 id = 0;
+	libbpf_print_fn_t old_print_fn;
 
 	obj = bpf_object__open(MAPINMAP_PROG);
 
@@ -1250,12 +1251,16 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
+	old_print_fn = libbpf_set_print(NULL);
+
 	err = bpf_object__load(obj);
 	if (!err) {
 		printf("Loading obj supposed to fail\n");
 		goto out_map_in_map;
 	}
 
+	libbpf_set_print(old_print_fn);
+
 	/* Iterate over all maps to check whether the internal map
 	 * ("mim.internal") has been destroyed.
 	 */
-- 
2.32.0

