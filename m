Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF145B45FE
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIJLBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIJLBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 07:01:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0AA25296;
        Sat, 10 Sep 2022 04:01:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 212995C005B;
        Sat, 10 Sep 2022 07:01:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 10 Sep 2022 07:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1662807693; x=1662894093; bh=GGvzW4XEE8JXbLXeOzJ15+Q8I
        rPiWoJd4ry0fE29yYg=; b=jYvfnnIzQmJGhCigy86mDPQyoHqUr2xAjdVDxvJDn
        f0WxyLtD7Is/CPpqIRUVDYjaQMy23/6A7vPWeYoW37rbWq8DLfILuM7nqf7Wdw1o
        U2DfJgwCfkcVY9D4fSc1b27y92Ljd0VO6NKNJSw+5JhlBYgTw8+rP9GN9V1dHZkD
        0MVsEpOZ9mTv810isKexPCHbQqTXL9vojZCGA449oGamkqhWOkE/0QnCKRhgVJjv
        2CfuHifOE5RCVn9ZAEeUPBZpmQ4B5Jhwv2wufZG86gZSFCj3Cl442Jfdgi0ny8Wf
        Thx72MraCgt7YtCa18y6rV2WxQxfVmtG1LoGfWC81GiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1662807693; x=1662894093; bh=GGvzW4XEE8JXbLXeOzJ15+Q8IrPiWoJd4ry
        0fE29yYg=; b=S74dNaQunza+6NIFv4M4blEJWvvv1QCJjuAh+5jgs6V5CY46cGN
        kB3QgUUThQwS6CCBjDgzr12DtQ10DvRXTAs54biOXPbAyHZdkCHetU50hsf5NIIy
        ih5RpJkS7B/RGCJsE7YJXDte17WUFO1Y6FvcpoCZ3x21K2MxGCVEUw8plWxu3QWl
        L7EeSxXg/waC0D+NbrCu42qfJWOE6Zj8ek8qW3WqJnIS+VKwalSmz6lT0ysN3kOD
        KQ1bD+7sDBmSiZG4XSE5KLuU5jFXWu+efncy2foZLTmi5gby5RiNyw3RrCERpeOr
        g8bA9P2NJmsdKNe32kEiP1IqtZU1fNIDnsQ==
X-ME-Sender: <xms:jG4cY090U7Xy1qal6CX_h1HZLd8aBQfD3pfdE_WjizlC3Si6DiC0Jw>
    <xme:jG4cY8ub0TFB0c4pCBpJj7p49Xo0soE-wLQAmt82Huv7fJjmpgAo_MqYtoV3U_A6h
    V5AybbmUkf-S76rdg>
X-ME-Received: <xmr:jG4cY6APvCjr6K4KjL7TpVY4mexRNaFkwYe3xYApEHpOxwSjqyMphdg1A7IFd__8tzh-4Tps5f6pPI3CcdOSxkCvqndXhCaCYDr0RWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtjedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnfhorhgvnhii
    uceurghuvghruceoohhssheslhhmsgdrihhoqeenucggtffrrghtthgvrhhnpedugfeltd
    eiheejvdefhfeigffgteffgeelgeejleeuleehvefhgfdtheejudeftdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:jG4cY0fTf7oCEPU_aUq8PQAYiGSwxERMOWmcVVOcqDNVZTpXUFtcMA>
    <xmx:jG4cY5OD9tMqU8E_qHaSANddtMMBM7bqES4b_cW7Vogr3YMuju9qVA>
    <xmx:jG4cY-mzlgD-qlZ2K4RNA7CzsqNKc9gu8dqjTHafcVjPZBuvwQsFXQ>
    <xmx:jW4cY9lmg03Do_wIm9kr9V34Aa-b0VbcaoqZ0Om9m0f0fjHh9MXU4A>
Feedback-ID: icd3146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Sep 2022 07:01:30 -0400 (EDT)
From:   Lorenz Bauer <oss@lmb.io>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Lorenz Bauer <oss@lmb.io>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf: btf: fix truncated last_member_type_id in btf_struct_resolve
Date:   Sat, 10 Sep 2022 11:01:20 +0000
Message-Id: <20220910110120.339242-1-oss@lmb.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When trying to finish resolving a struct member, btf_struct_resolve
saves the member type id in a u16 temporary variable. This truncates
the 32 bit type id value if it exceeds UINT16_MAX.

As a result, structs that have members with type ids > UINT16_MAX and
which need resolution will fail with a message like this:

    [67414] STRUCT ff_device size=120 vlen=12
        effect_owners type_id=67434 bits_offset=960 Member exceeds struct_size

Fix this by changing the type of last_member_type_id to u32.

Fixes: a0791f0df7d2 ("bpf: fix BTF limits")
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Lorenz Bauer <oss@lmb.io>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e64447659f3..36fd4b509294 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3128,7 +3128,7 @@ static int btf_struct_resolve(struct btf_verifier_env *env,
 	if (v->next_member) {
 		const struct btf_type *last_member_type;
 		const struct btf_member *last_member;
-		u16 last_member_type_id;
+		u32 last_member_type_id;
 
 		last_member = btf_type_member(v->t) + v->next_member - 1;
 		last_member_type_id = last_member->type;
-- 
2.34.1

