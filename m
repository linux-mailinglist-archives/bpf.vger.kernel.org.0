Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135A65B33CB
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIIJXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiIIJW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 05:22:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34029133A26;
        Fri,  9 Sep 2022 02:22:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CEB3E5C00B5;
        Fri,  9 Sep 2022 05:21:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Sep 2022 05:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1662715289; x=1662801689; bh=jlANohku92U8A5fXUAUP9klL/
        FT+qyLMucoExzq9De0=; b=GUh0Znt7Rknaii71ptm8Vb/kfeZHYTXOMU9AskwCK
        vXuyw+pxAG/NaglHzxqXUd6OiBHLPycqTFEF7Du11efgq+UwaV1ebFw2heR2bKrf
        9svY0DzfBc1jWT4MB1RzOKw1+tL6yHc4gy0yiym7ExbcKW8qiRXM0NIjMS5tcaMe
        fXgtrDzVgd9vL8c+R8mHCM6OVqMQnsFrs0n51Jk+IxPiHovJYWW+DdzMbFUQ7jRB
        U9SJm5dYcGfX4B2C4fhjuDnSqyHVZkV4ixDrR0vb3/sCy1I/WF06JUZt5wti5Rhu
        yVnge3E1kcIR3QDwakfuXeGAtItZ/Y1yM2wyk2qdvA6UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1662715289; x=1662801689; bh=jlANohku92U8A5fXUAUP9klL/FT+qyLMuco
        Exzq9De0=; b=Rp6jgHj8TIHXr7ZBB69+wH5e0+YfEd51ySRPELnkIp4oSylrvCM
        KteZtxVSI8RHTgE08QJ/1r9ivsUPrj5CFeX71ZCIx6jMwo6iIMmVMU2xyJHMuNSH
        swxSvORj9hy16kjQQFqGP3cVdubpa4OlWvH5c7LTy1+nKJjc4gmdjGguWt7usI07
        6I2dvjyhrJIzVRzoiAiPr+Jtqk0/20ngRQwmcLKu3yScjuuBxTXcnnOEx3w3mgu7
        6h+bYPYF7NE5e/Ym1Az0T4ASqc4wX3zCFCGrECy3+5u73tGL+cMWc42Ao12nJm62
        Mpoj+zeLrCXCw2YrZZUM8x9rCje3bmv5BVg==
X-ME-Sender: <xms:mAUbYw5rB1tMF3Ev_eiP6XbcyTrgAleHSXwQVd5D9PjPlwLaBrpqqQ>
    <xme:mAUbYx5FNYnPW3okXRkRgGoi-p1ivdA9FAAibOeN-Giz0RefA0vtgwUPDoTC30WJB
    UXYs11JKpRIdmxZmQ>
X-ME-Received: <xmr:mAUbY_e5z_qaz6i9dD4TdU1o0gRZ-Lwnm_mTaY8WIYwibDSpuEK8ehg6BfdCYQ3skG9XTUT7_aKeYDaApQ0Gl2uq6R9gdH3QO61u_PU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnfhorhgvnhii
    uceurghuvghruceoohhssheslhhmsgdrihhoqeenucggtffrrghtthgvrhhnpedugfeltd
    eiheejvdefhfeigffgteffgeelgeejleeuleehvefhgfdtheejudeftdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:mAUbY1KEHVJGPGn6XWkiDnmg3XTmEPla8nhAHL41F8mOkGRZMTwlRg>
    <xmx:mAUbY0LHTs9W8OSvP5V0e773qAeRQr7CcHMlo4ZGkvN4GUBrsImA9Q>
    <xmx:mAUbY2y_TnnGfgm_OR9IQ_VK53dhpGBtyRhIzIXPOtaP2xNIXhzrfw>
    <xmx:mQUbY2C_f-44XBSsaIq-eZV8K4J-pLZOxu1zvw5hkGnxJ6Zr3fcMLA>
Feedback-ID: icd3146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 05:21:27 -0400 (EDT)
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
Subject: [PATCH bpf] bpf: btf: fix truncated last_member_type_id in btf_struct_resolve
Date:   Fri,  9 Sep 2022 09:21:07 +0000
Message-Id: <20220909092107.3035-1-oss@lmb.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
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

