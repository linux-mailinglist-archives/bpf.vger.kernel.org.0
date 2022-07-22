Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40257E973
	for <lists+bpf@lfdr.de>; Sat, 23 Jul 2022 00:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiGVWB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWB4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 18:01:56 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC5175B7
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 15:01:53 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 9720FF54D37B; Fri, 22 Jul 2022 15:01:40 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     lorenzo@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
Date:   Fri, 22 Jul 2022 15:01:05 -0700
Message-Id: <20220722220105.2065466-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For the case where offset + len =3D=3D size, bpf_xdp_pointer should retur=
n a
valid pointer to the addr because that access is permitted. We should
only return NULL in the case where offset + len exceeds size.

Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine=
")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 289614887ed5..4307a75eeb4c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3918,7 +3918,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, =
u32 offset, u32 len)
 		offset -=3D frag_size;
 	}
 out:
-	return offset + len < size ? addr + offset : NULL;
+	return offset + len <=3D size ? addr + offset : NULL;
 }
=20
 BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
--=20
2.30.2

